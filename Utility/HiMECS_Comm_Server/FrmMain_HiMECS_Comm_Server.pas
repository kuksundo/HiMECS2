unit FrmMain_HiMECS_Comm_Server;

interface

{$I mormot.defines.inc}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFrameCommServer2, Vcl.StdCtrls,
  AdvOfficePager, TimerPool,
  OtlContainerObserver, OtlComm, JHP.Util.gpSharedMem, GpSharedEvents,
  VSoft.Awaitable,
  mormot.core.base,
  mormot.core.data,
  mormot.core.unicode,
  mormot.core.json,
  mormot.orm.core,
  mormot.orm.rest,
  mormot.rest.server,
  mormot.soa.core,
  mormot.soa.server,
  mormot.rest.sqlite3,
  mormot.db.raw.sqlite3.static,
  UnitWorker4OmniMsgQ,
  HiMECS_Comm_Intf,
  UnitCommServerConfig,
  HiMECSConst, Vcl.Menus, UnitFrameIPCMonitorAll2;

type
  THiMECS_Comm_Service = class(TInjectableObjectRest, IHiMECS_Comm_Service)
  public
    function ServerExecute(const Acommand: RawUTF8): RawUTF8;
    function GetManualContents(const AManualInfo: TManualInfo): RawUTF8;
  end;

  THiMECSCommServerF = class(TForm)
    AdvOfficePager1: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    Edit1: TEdit;
    AdvOfficePager12: TAdvOfficePage;
    Memo1: TMemo;
    FCS: TFrameCommServer2;
    Button1: TButton;
    TFrameIPCMonitor1: TFrameIPCMonitor2;
    procedure FCSServerStartBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FPJHTimerPool: TPJHTimerPool;
    FSettings : TConfigSettings;
    FCommandQueue    : TOmniMessageQueue;
    FResponseQueue   : TOmniMessageQueue;
    FSendMsgQueue    : TOmniMessageQueue;

    FWorker          : TThread;
    FJHP_gpShM       : TJHP_gpShM;
    FCancelToken,
    FFinishedToken : ICancellationTokenSource;
    FRespondResult: string;

    procedure InitVar;
    procedure DestroyVar;

    procedure StartServer;
    procedure StartWorker;
    procedure StopWorker;

    procedure LoadConfigFromFile(AFileName: string = '');
    procedure LoadConfig2Form(AForm: TConfigF);
    procedure LoadConfigForm2Object(AForm: TConfigF);
    procedure SetConfig;
    procedure ApplyUI;

    procedure OnFinishToken(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);

    procedure DisplayMessage2FCS(msg: string; ADest: integer);
    procedure GpSMEventReceivedNotify(Sender: TObject;
      producerHandle: TGpSEHandle; const producerName, eventName,
      eventData: string);
    procedure ProcessCmdFromHiMECS(const AJsonEventData: string);
    function AsyncProcessCmdFromHiMECS(const token : ICancellationToken; const AJsonEventData : string) : IAwaitable<string>;
  public
    function ServerExecuteFromMainForm(const ACommand: RawUTF8): RawUTF8;
    function GetManualContentsFromMainForm(const AManualInfo: TManualInfo): RawUTF8;
    function GetManualFileByFileNameFromMainForm(const AFileName: RawUTF8): RawUTF8;
  end;

var
  HiMECSCommServerF: THiMECSCommServerF;

implementation

uses UnitFileSearchUtil, UnitBase64Util2;

{$R *.dfm}

{ THiMECSCommServerF }

procedure THiMECSCommServerF.ApplyUI;
begin

end;

function THiMECSCommServerF.AsyncProcessCmdFromHiMECS(
  const token: ICancellationToken;
  const AJsonEventData: string): IAwaitable<string>;
//var
//  LRespondRec: TRespondRec;
//  LCommandRec: TCommandRec;
//  LJson: string;
begin
  Result := TAsync.Configure<string>(
    function(const cancelToken : ICancellationToken) : string
    var
      i: Integer;
    begin

      WaitForSingleObject(cancelToken.Handle, 30000);

      Result := FRespondResult;
    end, token);

//  RecordLoadJson(LRespondRec, AJsonEventData, TypeInfo(TRespondRec));
//
//  LJson := LRespondRec.Respond;
//
//  if LRespondRec.Cmd = HiMECS_Cmd_GetManList then
//  begin
//
//  end
//  else
//  if LRespondRec.Cmd = HiMECS_Cmd_GetSensorListWithFilter then
//  begin
//
//  end;
end;

procedure THiMECSCommServerF.Button1Click(Sender: TObject);
var
  LCommand: RawUTF8;
  LCommandRec: TCommandRec;
begin
  LCommandRec.Cmd := HiMECS_Cmd_GetManList;
  LCommandRec.ParamStr := '';
  LCommandRec.ParamInt := 0;//TManualSortMethod(msmMSNo)
  LCommandRec.ParamInt2 := 0;//TManualSortMethod(mssSystem)
  LCommand := RecordSaveJson(LCommandRec, TypeInfo(TCommandRec));

  LCommand := ServerExecuteFromMainForm(LCommand);

//  ShowMessage(LCommand);
end;

procedure THiMECSCommServerF.DestroyVar;
begin
  FPJHTimerPool.RemoveAll;
  FreeAndNil(FPJHTimerPool);
  FJHP_gpShM.Free;
  FSettings.Free;
  FCS.DestroyHttpServer;
end;

procedure THiMECSCommServerF.DisplayMessage2FCS(msg: string; ADest: integer);
begin
  FCS.DisplayMessageUsingMsgQueue(Msg, TDisplayTarget(ADest));
end;

procedure THiMECSCommServerF.FCSServerStartBtnClick(Sender: TObject);
begin
  StartServer;
end;

procedure THiMECSCommServerF.FormCreate(Sender: TObject);
begin
  InitVar;
end;

procedure THiMECSCommServerF.FormDestroy(Sender: TObject);
begin
  DestroyVar;
end;

function THiMECSCommServerF.GetManualContentsFromMainForm(
  const AManualInfo: TManualInfo): RawUTF8;
var
  LStrList: TStringList;
  i: integer;
begin
  Result := '';
  SetCurrentDir(ExtractFilePath(Application.ExeName));

  LStrList := FindAllFiles('..\Doc\Manual\H35DF Control System');

  for i := 0 to LStrList.Count - 1 do
  begin
    Result := Result + LStrList.Names[i] + ',';
  end;
end;

function THiMECSCommServerF.GetManualFileByFileNameFromMainForm(
  const AFileName: RawUTF8): RawUTF8;
var
  LFullFileName: string;
begin
  Result := '';
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  LFullFileName := '..\Doc\Manual\H35DF Control System' + AFileName;

  if FileExists(LFullFileName) then
  begin
    Result := GetBase64ByFileName(LFullFileName);
  end
  else
    Result := HiMECS_RESULT_NO_DATA;
end;

procedure THiMECSCommServerF.GpSMEventReceivedNotify(Sender: TObject;
  producerHandle: TGpSEHandle; const producerName, eventName,
  eventData: string);
begin
  if producerHandle <> FJHP_gpShM.FgpEP.ProducerHandle then
  begin
    if (eventName = HiMECS_gpEventName4HiMECS) then
      ProcessCmdFromHiMECS(eventData);
  end;
end;

procedure THiMECSCommServerF.InitVar;
begin
  FPJHTimerPool := TPJHTimerPool.Create(nil);
  FSettings := TConfigSettings.create(ChangeFileExt(Application.ExeName, '.ini'));
  LoadConfigFromFile;

  FCS.FStartServerProc := StartServer;
  FCS.FAutoStartInterval := 10000; //10초

  FJHP_gpShM := TJHP_gpShM.Create(HiMECS_gpSMName4CommServer);
  //SharedMemory를 공유할 Producer와 Listener의 EventName은 동일해야 함
  FJHP_gpShM.InitgpSMEvent(HiMECS_gpNameSpace4CommServer,
    HiMECS_gpEventName4HiMECSCommServer,[gkProducer]);
  FJHP_gpShM.InitgpSMEvent(HiMECS_gpNameSpace4CommServer,
    HiMECS_gpEventName4HiMECS,[gpListener], GpSMEventReceivedNotify);     //HiMECS_gpListenerEventName4CommServer
  FCancelToken := TCancellationTokenSourceFactory.Create;
  FFinishedToken := TCancellationTokenSourceFactory.Create;
end;

procedure THiMECSCommServerF.LoadConfig2Form(AForm: TConfigF);
begin
  FSettings.LoadConfig2Form(AForm, FSettings);
end;

procedure THiMECSCommServerF.LoadConfigForm2Object(AForm: TConfigF);
begin
  FSettings.LoadConfigForm2Object(AForm, FSettings);
end;

procedure THiMECSCommServerF.LoadConfigFromFile(AFileName: string);
begin
  FSettings.Load(AFileName);
end;

procedure THiMECSCommServerF.OnFinishToken(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  FFinishedToken.Cancel;
end;

procedure THiMECSCommServerF.ProcessCmdFromHiMECS(const AJsonEventData: string);
var
  LRespondRec: TRespondRec;
  LJson: string;
begin
  LJson := FJHP_gpShM.RecvDataFromgpSM;
  RecordLoadJson(LRespondRec, LJson, TypeInfo(TRespondRec));

  FRespondResult := LRespondRec.Respond;
  FCancelToken.Cancel;

//  if LRespondRec.Cmd = HiMECS_Cmd_GetManList then
//  begin
//
//  end
//  else
//  if LRespondRec.Cmd = HiMECS_Cmd_GetSensorListWithFilter then
//  begin
//
//  end;
end;

function THiMECSCommServerF.ServerExecuteFromMainForm(const ACommand: RawUTF8): RawUTF8;
var
  LResult: string;
begin
  FCancelToken.Reset;
  FFinishedToken.Reset;

  //30초동안 HiMECS로부터 반응이 없으면 쓰레드 종료
  FPJHTimerPool.Add(OnFinishToken, 30000);
  //HiMECS에 데이터 요청, GpSMEventReceivedNotify() 함수에서 데이터 수신함
  FJHP_gpShM.SendData2gpSM(HiMECS_gpEventName4HiMECSCommServer, ACommand);

  AsyncProcessCmdFromHiMECS(FCancelToken.Token, ACommand)
      .OnException(
        procedure(const e : Exception)
        begin
//          Result := e.Message;
        end)
      .OnCancellation(
        procedure
        begin
          LResult := FRespondResult;
          FFinishedToken.Cancel;
//          Result := 'Cancelled';
        end)
      .Await(
        procedure(const value : string)
        begin
          LResult := value;
        end);

  while True do
  begin
    Application.ProcessMessages;

    if FFinishedToken.Token.IsCancelled then
      Break;
  end;

  Result := LResult;
  FRespondResult := '';
//  ShowMessage(Result);
end;

procedure THiMECSCommServerF.SetConfig;
var
  LConfigF: TConfigF;
begin
  LConfigF := TConfigF.Create(Self);

  try
    LoadConfig2Form(LConfigF);

    if LConfigF.ShowModal = mrOK then
    begin
      LoadConfigForm2Object(LConfigF);
      FSettings.Save();
      ApplyUI;
    end;
  finally
    LConfigF.Free;
  end;
end;

procedure THiMECSCommServerF.StartServer;
begin
  FCS.CreateHttpServer(HiMECS_COMM_ROOT_NAME, 'HiMECS_Comm_Server.json', HiMECS_COMM_PORT, THiMECS_Comm_Service,
    [TypeInfo(IHiMECS_Comm_Service)], sicClientDriven, True);
  FCS.ServerStartBtnClick(nil);
end;

procedure THiMECSCommServerF.StartWorker;
begin
  FCommandQueue := TOmniMessageQueue.Create(1000);
  FResponseQueue := TOmniMessageQueue.Create(1000, false);
  FSendMsgQueue := TOmniMessageQueue.Create(1000, false);

  FWorker := TWorker.Create(FCommandQueue, FResponseQueue, FSendMsgQueue);
end;

procedure THiMECSCommServerF.StopWorker;
begin
  if assigned(FWorker) then
  begin
    TWorker(FWorker).Stop;
    FWorker.WaitFor;
    FreeAndNil(FWorker);
  end;

  if assigned(FResponseQueue) then
  begin
    FreeAndNil(FResponseQueue);
  end;

  FreeAndNil(FCommandQueue);
end;

{ THiMECS_Comm_Service }

function THiMECS_Comm_Service.GetManualContents(
  const AManualInfo: TManualInfo): RawUTF8;
begin
  Result := HiMECSCommServerF.GetManualContentsFromMainForm(AManualInfo);
end;

function THiMECS_Comm_Service.ServerExecute(const Acommand: RawUTF8): RawUTF8;
begin
  Result := HiMECSCommServerF.ServerExecuteFromMainForm(ACommand);
end;

end.
