unit FrmParamManage2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, System.SyncObjs, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvBaseDlg, JvSelectDirectory,
  Vcl.ExtCtrls, AdvSmoothSplashScreen, Vcl.Menus, Vcl.ImgList, NxColumnClasses,
  NxColumns, NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, SBPro,
  AdvOfficeTabSet, Vcl.StdCtrls, AeroButtons, JvExControls, JvLabel,
  CurvyControls, AdvOfficePager, Vcl.ComCtrls, IniFiles,
  UnitSTOMPClass, UnitWorker4OmniMsgQ,
  mormot.core.variants, mormot.core.base, mormot.core.data, mormot.core.text,
  mormot.core.datetime, mormot.core.unicode,
  FrmParamConfig2, UnitSimulateParamRecord2, UnitIPCClientAll2, HiMECSConst,
  UnitCommandLineUtil, GpCommandLineParser,
  UnitSimulateParamCommandLineOption2, Vcl.Mask, JvExMask, JvToolEdit,
  MyKernelObject4GpSharedMem, IPC.Events, IPC.SharedMem, GpSharedMemory,
  UnitSimulateCommonData, JvExComCtrls, JvStatusBar, UnitNextGridFrame,
  UnitEngineParameterClass2, UnitEngineParamRecord2,
  JvDialogs, UnitHookConst, UnitMultiStateRecord2, UnitFrameIPCMonitorAll2,
  UnitFrameWatchGrid2;

const
  MQ_TOPIC_STOMP = '/topic/#/';
  MEMO_MAX_LINES = 100;
  MSG_UPDATESTATUS = WM_USER + 1001;
  MSG_KEY_UP = WM_USER + 1002;
  MSG_KEY_DOWN = WM_USER + 1003;
  MSG_KEY_SHIFT = WM_USER + 1004;
  MSG_SYSTEM_MODE = WM_USER + 1005;
  MSG_COMMAND = WM_USER + 1006;
  MSG_COMMAND_JSON = WM_USER + 1007;

type
  TThreadSimulateEvent = class(TThread)
  private
    FParamSrcList: TStringList;
    FParamListJson: string;
  protected
    procedure Execute; override;
    procedure PulseParamListFromJson;
    procedure CreateIPCClients;

    //MainForm의 FParamListJson value가 변경되면(검색 조건을 변경하여 다시 조회하는 경우) FDocData도 함께 Update 되어야 함
    procedure SetParamListJson(AJson: string);
  public
    FIPCClientAll: TIPCClientAll;
//    FPauseEvent : MyKernelObject4GpSharedMem.TEvent;
    FPauseEvent: Event;
    FStop, FPause: Boolean;
    FCurrentIndex,
    FNextIndex,
    FGotoIndex: integer;
    FEventDataType: integer;
    FDocData: TDocVariantData;
    FInterval4PulseData: integer;

    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure ReStart;
    procedure SendData2gpSM(AData: string);
    procedure InitCurrentIndex;

    property ParamListJson: string read FParamListJson write SetParamListJson;
  end;

  TParamManageF = class(TForm)
    PageControl1: TAdvOfficePager;
    ParamListPage: TAdvOfficePage;
    STOMPPage: TAdvOfficePage;
    Splitter1: TSplitter;
    CurvyPanel1: TCurvyPanel;
    JvLabel6: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    Panel1: TPanel;
    btn_Search: TAeroButton;
    btn_Close: TAeroButton;
    ProdTypeCB: TComboBox;
    ModelNameCB: TComboBox;
    TaskTab: TAdvOfficeTabSet;
    StatusBarPro1: TStatusBarPro;
    ParamListGrid: TNextGrid;
    NxIncrementColumn1: TNxIncrementColumn;
    ProductType: TNxTextColumn;
    SystemName: TNxTextColumn;
    SubSystemName: TNxTextColumn;
    Subject: TNxTextColumn;
    JsonParamCollect: TNxButtonColumn;
    UpdateDate: TNxTextColumn;
    imagelist24x24: TImageList;
    ImageList16x16: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    ImportGeneratorMasterFromXlsFile1: TMenuItem;
    N2: TMenuItem;
    Close1: TMenuItem;
    View1: TMenuItem;
    DataBase1: TMenuItem;
    ools1: TMenuItem;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Add1: TMenuItem;
    N1: TMenuItem;
    DeleteSelectedCert1: TMenuItem;
    ImageList32x32: TImageList;
    SplashScreen1: TAdvSmoothSplashScreen;
    Timer1: TTimer;
    JvSelectDirectory1: TJvSelectDirectory;
    Memo1: TMemo;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MQServerIPEdit: TEdit;
    MQServerPortEdit: TEdit;
    TopicEdit: TEdit;
    StatusBar1: TStatusBar;
    SeqNo: TNxNumberColumn;
    ModelName: TNxTextColumn;
    JvLabel4: TJvLabel;
    CSVValues: TNxButtonColumn;
    ProjectName: TNxTextColumn;
    JvLabel5: TJvLabel;
    ProjectNameCB: TComboBox;
    Config1: TMenuItem;
    Enable: TNxCheckBoxColumn;
    TransferStepCheck: TCheckBox;
    SystemNameCB: TComboBox;
    SubSystemNameCB: TComboBox;
    ParamSourceList: TNxTextColumn;
    ParamDBEdit: TJvFilenameEdit;
    JvLabel7: TJvLabel;
    Desc: TNxTextColumn;
    ShowStatusDisplay1: TMenuItem;
    ShowSCROperationSimulate1: TMenuItem;
    est1: TMenuItem;
    estgpSharedMemory1: TMenuItem;
    AdvOfficePage1: TAdvOfficePage;
    SubjectEdit: TEdit;
    JvStatusBar1: TJvStatusBar;
    PopupMenu2: TPopupMenu;
    SendMultiStateToSM1: TMenuItem;
    JvSaveDialog1: TJvSaveDialog;
    N3: TMenuItem;
    SaveItemstoNewName1: TMenuItem;
    LoadWatchListFromFile1: TMenuItem;
    SendStateListToSMCreateDisplay1: TMenuItem;
    ShowEGCSOperationSimulate1: TMenuItem;
    N4: TMenuItem;
    ransferselectedstep1: TMenuItem;
    UseBalloon: TNxCheckBoxColumn;
    CommandJson: TNxTextColumn;
    FWG: TFrameWatchGrid2;
    IPCMonitorAll1: TFrameIPCMonitor2;
    CreateSimulateDB1: TMenuItem;
    Savecurrentsetting1: TMenuItem;
    N5: TMenuItem;
    Panel3: TPanel;
    AeroButton1: TAeroButton;
    AeroButton2: TAeroButton;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure ParamListGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure AeroButton1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Config1Click(Sender: TObject);
    procedure DeleteSelectedCert1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure ImportGeneratorMasterFromXlsFile1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SystemNameCBSelect(Sender: TObject);
    procedure ParamDBEditChange(Sender: TObject);
    procedure ParamListGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ShowStatusDisplay1Click(Sender: TObject);
    procedure ProdTypeCBChange(Sender: TObject);
    procedure ShowSCROperationSimulate1Click(Sender: TObject);
    procedure estgpSharedMemory1Click(Sender: TObject);
    procedure SendMultiStateToSM1Click(Sender: TObject);
    procedure SaveItemstoNewName1Click(Sender: TObject);
    procedure LoadWatchListFromFile1Click(Sender: TObject);
    procedure SendStateListToSMCreateDisplay1Click(Sender: TObject);
    procedure ShowEGCSOperationSimulate1Click(Sender: TObject);
    procedure ModelNameCBChange(Sender: TObject);
    procedure ransferselectedstep1Click(Sender: TObject);
    procedure CreateSimulateDB1Click(Sender: TObject);
    procedure ParamDBEditButtonClick(Sender: TObject);
    procedure Savecurrentsetting1Click(Sender: TObject);
    procedure AeroButton2Click(Sender: TObject);
  private
    FCommandLine: TSimulateParamCLO2;
    FpjhSTOMPClass: TpjhSTOMPClass;
    FThreadSimulateEvent: TThreadSimulateEvent;
    FThreadAssigned: Boolean;
    FExeFilePath: string;
    FIsDestroying: Boolean;
    FStepIndex: integer;
    FParamDBName,
    FParamSourceList,
    FJsonParamCollect,
    FCSVValues,
    FSimulateCompValuesJson: string;
    FAdditionalData: string;
//    FgpSharedMM: TGpSharedMemory;
    FNotifySharedMMEvent,
    FNotifyNextStepEvent: Event;
    FNextStepSM: SharedMemory<TSimCommonData>;
    FIPCMonitorMode: Boolean; //True = IPC Monitor 값을 SM에 전달함
                              //Grid Row No
    FItemData_Dic : TDictionary<integer, TParamItemClass>;

    procedure InitVar;
    procedure FinalizeVar;
    procedure InitSTOMP(AUserId, APasswd, AServerIP, APort, ATopic: string);
    procedure DestroySTOMP;
    procedure InitIPCMonitor;
    procedure DestroyIPCMonitor;

    procedure WorkerResult(var msg: TMessage); message MSG_RESULT;
    procedure UpdateStatusBar(var Msg: TMessage); message MSG_UPDATESTATUS;
    procedure WM_KeyUp(var Msg: TMessage); message MSG_KEY_UP;
    procedure WM_KeyDown(var Msg: TMessage); message MSG_KEY_DOWN;
    procedure WM_KeyShift(var Msg: TMessage); message MSG_KEY_SHIFT;
    procedure WM_SystemMode(var Msg: TMessage); message MSG_SYSTEM_MODE;
    procedure WM_Command(var Msg: TMessage); message MSG_COMMAND;
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;
    procedure WM_CommandJson(var Msg: TMessage); message MSG_COMMAND_JSON;

    procedure ProcessSubscribeMsg;
    procedure SendData2MQ(AMsg: string; ATopic: string = '');
    procedure TransferSimData(AGotoIndex: integer=-1; AToPrev: Boolean=false);
    procedure CreateSimulateThread;
    procedure InitializeSimulateThread;
    procedure InitializeSimulateIndex;
    procedure InitParamDB(ADBName: string; ACreateIfNotExist: Boolean = True);

    procedure TransferMultiStateData(AValue: integer);
    procedure WatchValue2Screen_Analog(Name: string; AValue: string;
                                AEPIndex: integer);
    procedure WatchValue2Screen_Digital(Name: string; AValue: string;
                                AEPIndex: integer);
    procedure WatchValue2Screen_2;
    procedure DeleteEngineParamterFromGrid(AIndex: integer);
    procedure DisplayMessage(Msg: string; AIsSaveLog: Boolean = False; AMsgLevel: TSynLogInfo = sllInfo);
    procedure CreateIPCMonitor(AEP_DragDrop: TEngineParameterItemRecord; ADragCopyMode: TParamDragCopyMode = dcmCopyOnlyNonExist);

    function CommandLineParse(var AErrMsg: string): boolean;
    procedure LoadConfigFromFile(AFileName: string = '');
    procedure LoadConfig2Form(AForm: TConfigF);
    procedure LoadConfigForm2Object(AForm: TConfigF);
    procedure SetConfig;
    procedure ApplyUI;
    procedure DispConfigData;
    procedure DisplaySTOMPMessage2Memo(msg: string; ADest: integer);
    procedure SendParam2gpSharedMM;
//    procedure RecvParamFromSharedMM;
    procedure SendParam2CommandLineWithCreate;
    procedure SentParam2STOMP;
//    procedure SharedMMTest;
    procedure SendSystemMode2SharedMM(AIsSystemMode: Boolean);
    procedure SendCommand2SharedMM(ACommand: integer);

    procedure GetParamList2Grid(AIsFromRemote: Boolean = False);
    procedure GetSimParamSearchParam2Rec(var ASimParamSearchRec: TSimParamSearchRec);
    procedure GetSimParamSearchFromGrid2Rec(var ASimParamSearchRec: TSimParamSearchRec);
    procedure GetParamListFromLocal(ASimParamSearchRec: TSimParamSearchRec);
    procedure GetParamListFromVariant2Grid(ADoc: Variant);
    procedure GetStateListFromLocal(AGridIdx: integer; AIsCreateDisplay: Boolean);
    procedure ConvertMultiStat2ParamList(ADoc: string; AItemID, AProductKind: integer);

    procedure ShowParamEditFormFromGrid(ARow: integer);
    procedure ProcessSimulateOneStep;

    procedure SaveCondition2IniFile;
    procedure LoadCondition2Form;
  public
    FIPCClientAll : TIPCClientAll;
    FSettings : TConfigSettings;
    FParamListJson,
    FCommandJson: string;
    FCurrentIndex: integer;

    procedure SetSimData(APType, ASystemKind, ASubSystem: integer);
    procedure SetSimData4SCR(ASystemKind: integer);
    procedure SetSimData4EGCS(ASystemKind: integer);
  end;

const
  HookDll = '..\Dlls\' + HookKeyBdDLL_Name;

function StartHook(sender : HWND; MsgId_K: WORD) : BOOL; stdcall; external HookDll;
function StopHook: BOOL;stdcall; external HookDll;

procedure CreateParamManageR(ACLO: TpjhCommandLine<TSimulateParamCLO2>);//AJsonParamCollect, ACSVValues, AParamSrcList, AParamDB, AAdditionalData: string);

var
  ParamManageF: TParamManageF;

implementation

uses otlcomm, StompTypes, UnitSTOMPMsg.EventThreads, UnitVesselData2, UnitFGSSData,
  UnitHGSCurriculumData, FrmSimulateParamEdit2, IPC_Modbus_Standard_Const,
  UnitBase64Util2, UnitStringUtil, UnitFolderUtil2,// FrmStatusDisplay,
  FrmSCRSimulate2, UnitSCRData, UnitProcessUtil, UnitEGCSData, FrmEGCSSimulate2;

{$R *.dfm}

//Design Form의 SaveSimulateValue2DB()에서 AAdditionalData를 전달함
procedure CreateParamManageR(ACLO: TpjhCommandLine<TSimulateParamCLO2>);//AJsonParamCollect, ACSVValues, AParamSrcList, AParamDB, AAdditionalData: string);
var
  LParamManageF: TParamManageF;
//  LDoc: variant;
begin
  LParamManageF := TParamManageF.Create(nil);
  try
//    AJsonParamCollect := MakeBase64ToString(AJsonParamCollect);
//    ACSVValues := MakeBase64ToString(ACSVValues);
//    AParamSrcList := MakeBase64ToString(AParamSrcList);
//    AAdditionalData := MakeBase64ToString(AAdditionalData);

//    LParamManageF.FParamSourceList := AParamSrcList; //ECS By AVAT2,SCR By BachMann 형식으로 저장 됨
//    LParamManageF.FJsonParamCollect := AJsonParamCollect;
//    LParamManageF.FCSVValues := ACSVValues;
//    LParamManageF.FAdditionalData := AAdditionalData;
//    LParamManageF.STOMPPage.Visible := False;
//    LParamManageF.AeroButton1.Visible := False;

//    if AParamDB = '' then
//      AParamDB :=  HGS_SIMULATE_PARAM_DB_NAME;
    ACLO.FCommandLine.FJsonParamCollect := MakeBase64ToString(ACLO.FCommandLine.FJsonParamCollect);
    ACLO.FCommandLine.FCSVValues := MakeBase64ToString(ACLO.FCommandLine.FCSVValues);
    ACLO.FCommandLine.fParamSourceList := MakeBase64ToString(ACLO.FCommandLine.fParamSourceList);
    ACLO.FCommandLine.FAdditionalData := MakeBase64ToString(ACLO.FCommandLine.FAdditionalData);
    ACLO.FCommandLine.FSimulateCompValuesJson := MakeBase64ToString(ACLO.FCommandLine.FSimulateCompValuesJson);
    ACLO.FCommandLine.FSkipMsg := 'True';

    LParamManageF.FCommandLine := ACLO.FCommandLine;
//    LParamManageF.FParamSourceList := ACLO.FCommandLine.fParamSourceList; //ECS By AVAT2,SCR By BachMann 형식으로 저장 됨
//    LParamManageF.FJsonParamCollect := ACLO.FCommandLine.FJsonParamCollect;
//    LParamManageF.FCSVValues := ACLO.FCommandLine.FCSVValues;
//    LParamManageF.FAdditionalData := ACLO.FCommandLine.FAdditionalData;
//    LParamManageF.FSimulateCompValuesJson := ACLO.FCommandLine.FSimulateCompValuesJson;
    LParamManageF.STOMPPage.Visible := False;
    LParamManageF.AeroButton1.Visible := False;

    if ACLO.FCommandLine.FParamFileName = '' then
      ACLO.FCommandLine.FParamFileName :=  HGS_SIMULATE_PARAM_DB_NAME;

    LParamManageF.FParamDBName := ACLO.FCommandLine.FParamFileName;
    LParamManageF.Timer1.Enabled := True;

    LParamManageF.ShowModal;
  finally
    LParamManageF.Free;
  end;
end;

procedure TParamManageF.Add1Click(Sender: TObject);
begin
  ShowParamEditFormFromGrid(-1);
end;

procedure TParamManageF.AeroButton1Click(Sender: TObject);
begin
  TransferSimData;
end;

procedure TParamManageF.AeroButton2Click(Sender: TObject);
begin
  TransferSimData(-1,True);
end;

procedure TParamManageF.ApplyUI;
begin
  DispConfigData;
end;

procedure TParamManageF.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TParamManageF.btn_SearchClick(Sender: TObject);
begin
  GetParamList2Grid;
end;

procedure TParamManageF.Close1Click(Sender: TObject);
begin
  Close;
end;

function TParamManageF.CommandLineParse(var AErrMsg: string): boolean;
var
  LStr: string;
begin
  AErrMsg := '';

  if not Assigned(FCommandLine) then
    FCommandLine := TSimulateParamCLO2.Create;

  try
    Result := CommandLineParser.Parse(FCommandLine);
  except
    on E: ECLPConfigurationError do begin
      AErrMsg := '*** Configuration error ***' + #13#10 +
        Format('%s, position = %d, name = %s',
          [E.ErrorInfo.Text, E.ErrorInfo.Position, E.ErrorInfo.SwitchName]);
      Exit;
    end;
  end;

  if not Result then
  begin
    AErrMsg := Format('%s, position = %d, name = %s',
      [CommandLineParser.ErrorInfo.Text, CommandLineParser.ErrorInfo.Position,
       CommandLineParser.ErrorInfo.SwitchName]) + #13#10;
    for LStr in CommandLineParser.Usage do
      AErrMsg := AErrMSg + LStr + #13#10;
  end
  else
  begin
  end;
end;

procedure TParamManageF.Config1Click(Sender: TObject);
begin
  SetConfig;
end;

procedure TParamManageF.ConvertMultiStat2ParamList(ADoc: string;
  AItemID, AProductKind: integer);
var
  LDocData: TDocVariantData;
  LResultDoc: Variant;
  i: integer;
  LDoc: Variant;
  LUtf8: RawUTF8;
  LDynUtf8File: TRawUTF8DynArray;
  LDynArrFile: TDynArray;
begin
  LDocData.InitJSON(ADoc);
  TDocVariant.New(LResultDoc);
  LDynArrFile.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8File);

  for i := 0 to LDocData.Count - 1 do
  begin
    LDoc := _JSON(LDocData.Value[i]);
    LResultDoc.Subject := LDoc.StateDesc + ' (' + IntToStr(LDoc.StateValue) + ')';
    LResultDoc.Desc := LDoc.StateMeaning;
    LResultDoc.SystemName := LDoc.TagName;
    LResultDoc.SubSystemName := LDoc.StateValue;
    LResultDoc.ItemID := AItemID;
    LResultDoc.ProductType := AProductKind;
    LUtf8 := VariantSaveJson(LResultDoc);
    LDynArrFile.Add(LUtf8);
  end;

  LDoc := _JSON(LDynArrFile.SaveToJSON);
  FParamListJson := LDoc;
end;

procedure TParamManageF.CreateIPCMonitor(
  AEP_DragDrop: TEngineParameterItemRecord; ADragCopyMode: TParamDragCopyMode);
var
  i, j, LResult: integer;
begin
  LResult := FWG.CreateIPCMonitor(AEP_DragDrop, ADragCopyMode);
end;

procedure TParamManageF.CreateSimulateDB1Click(Sender: TObject);
begin
  OpenDialog1.Filter := '';

  if OpenDialog1.Execute then
  begin
    if OpenDialog1.FileName <> '' then
    begin
      InitParamDB(OpenDialog1.FileName, True);
    end;
  end;
end;

procedure TParamManageF.CreateSimulateThread;
begin
//  if FThreadAssigned and (FThreadSimulateEvent4.Terminated) then
//    FThreadSimulateEvent := nil;

  if not FThreadAssigned then
  begin
    FThreadSimulateEvent := TThreadSimulateEvent.Create(True);
    FThreadSimulateEvent.FreeOnTerminate := True;
    FThreadSimulateEvent.FIPCClientAll := Self.FIPCClientAll;
    FThreadSimulateEvent.ParamListJson := Self.FParamListJson;
    FThreadSimulateEvent.FPause := TransferStepCheck.Checked;
    FThreadSimulateEvent.FInterval4PulseData := StrToIntDef(FSettings.Interval4PulseData,0);
    FThreadAssigned := True;
  end;
end;

procedure TParamManageF.DeleteEngineParamterFromGrid(AIndex: integer);
begin
  FWG.FreeStrListFromGrid(AIndex);
  FWG.NextGrid1.DeleteRow(AIndex);
  IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Delete(AIndex);
end;

procedure TParamManageF.DeleteSelectedCert1Click(Sender: TObject);
var
  LSimParamSearchRec: TSimParamSearchRec;
  LCertNo: string;
begin
  if ParamListGrid.SelectedRow = -1 then
    exit;

  if MessageDlg('Selected Parameter will be deleted.' + #13#10 + 'Are you sure?',
    mtConfirmation, [mbYes, mbNo], 0)= mrNo then
    exit;

  GetSimParamSearchFromGrid2Rec(LSimParamSearchRec);
  DeleteSimulateParam(LSimParamSearchRec);
  GetParamList2Grid;
  ParamListGrid.ScrollToRow(ParamListGrid.SelectedRow);
end;

procedure TParamManageF.DestroyIPCMonitor;
begin

end;

procedure TParamManageF.DestroySTOMP;
begin
  if Assigned(FpjhSTOMPClass) then
    FpjhSTOMPClass.Free;
end;

procedure TParamManageF.DispConfigData;
begin
  MQServerIPEdit.Text := FSettings.STOMPServerIP;
  MQServerPortEdit.Text := FSettings.STOMPServerPort;
  TopicEdit.Text := FSettings.STOMPServerTopic;
end;

procedure TParamManageF.DisplayMessage(Msg: string; AIsSaveLog: Boolean;
  AMsgLevel: TSynLogInfo);
begin

end;

procedure TParamManageF.DisplaySTOMPMessage2Memo(msg: string; ADest: integer);
begin
  if FIsDestroying then
    exit;

  if msg = ' ' then
  begin
    exit;
  end;

  case ADest of
    0 : begin
      with Memo1 do
      begin
        if Lines.Count > MEMO_MAX_LINES then
          Clear;
        Lines.Add(DateTimeToStr(now) + ' :: ' + msg);
      end;//with
    end;//dtSystemLog
  end;//case
end;

procedure TParamManageF.estgpSharedMemory1Click(Sender: TObject);
begin
//  SharedMMTest;
end;

procedure TParamManageF.FinalizeVar;
var
  LParamItemClass: TParamItemClass;
begin
  FIPCClientAll.FinalgpSharedMemory4Producer;
  FreeAndNil(FIPCClientAll);

  if Assigned(SCROpSimF) then
    SCROpSimF.Free;

  if Assigned(EGCSOpSimF) then
    EGCSOpSimF.Free;

  for LParamItemClass in FItemData_Dic.Values do
    LParamItemClass.Free;

  FItemData_Dic.Free;
//  FreeAndNil(FgpSharedMM);

  if Assigned(FCommandLine) then
    FCommandLine.Free;

  FSettings.Free;
//  FreeAndNil(FPauseEvent);

  DestroySTOMP;
end;

procedure TParamManageF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FThreadSimulateEvent) then
  begin
    FThreadSimulateEvent.FStop := True;
//    FThreadSimulateEvent.ReStart;
//    FThreadSimulateEvent.FPauseEvent.Pulse;
  end;

  Sleep(100);
end;

procedure TParamManageF.FormCreate(Sender: TObject);
begin
  InitVar;
end;

procedure TParamManageF.FormDestroy(Sender: TObject);
begin
  FinalizeVar;
end;

procedure TParamManageF.GetParamList2Grid(AIsFromRemote: Boolean);
var
  LSQLSimulateParamRecord: TSQLSimulateParamRecord;
  LSimParamSearchRec: TSimParamSearchRec;
  LDoc: Variant;
begin
  ParamListGrid.BeginUpdate;
  try
    ParamListGrid.ClearRows;
    GetSimParamSearchParam2Rec(LSimParamSearchRec);

//    if AIsFromRemote then
//      GetVesselListFromRemote(LSimParamSearchRec)
//    else
      GetParamListFromLocal(LSimParamSearchRec);
  finally
    InitializeSimulateIndex;
    ParamListGrid.EndUpdate;
  end;
end;

procedure TParamManageF.GetParamListFromLocal(
  ASimParamSearchRec: TSimParamSearchRec);
var
  LSQLSimulateParamRecord: TSQLSimulateParamRecord;
  LDoc: Variant;
  LDynUtf8File: TRawUTF8DynArray;
  LDynArrFile: TDynArray;
  LUtf8: RawUTF8;
begin
  LSQLSimulateParamRecord := GetSimulateParamRecordFromSearchRec(ASimParamSearchRec);
  try
    if LSQLSimulateParamRecord.IsUpdate then
    begin
      LSQLSimulateParamRecord.FillRewind;
      LDynArrFile.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8File);
//      StatusDisplayF.StatusStepControl.BeginUpdate;
//      StatusDisplayF.StepControlClear;
      try
        while LSQLSimulateParamRecord.FillOne do
        begin
          LDoc := GetVariantFromSimulateParamRecord(LSQLSimulateParamRecord);
          GetParamListFromVariant2Grid(LDoc);
//          StatusDisplayF.GetParamListFromVariant2StatusDisplay(LDoc);
          LUtf8 := VariantSaveJson(LDoc);
          LDynArrFile.Add(LUtf8);
        end;//while
      finally
//        StatusDisplayF.StatusStepControl.EndUpdate;
      end;

      LDoc := _JSON(LDynArrFile.SaveToJSON);
      FParamListJson := LDoc;

      if Assigned(FThreadSimulateEvent) then
        FThreadSimulateEvent.ParamListJson := Self.FParamListJson;

      if FSettings.UseSharedMM then
        SendParam2gpSharedMM; //StatusDisplay.exe에 Grid에 표시된 모든 ParamList를 전달함(Step Control에 데이터 초기화함)

      if FSettings.UseSTOMP then
        SendData2MQ(FParamListJson);

      StatusBarPro1.Panels[1].Text := IntToStr(ParamListGrid.RowCount);
    end;
  finally
    FIPCMonitorMode := False;
    LSQLSimulateParamRecord.Free;
  end;
end;

procedure TParamManageF.GetParamListFromVariant2Grid(ADoc: Variant);
var
  LRow: integer;
  LShipProductTypes: integer;//TShipProductTypes;
begin
  LRow := ParamListGrid.AddRow;

  LShipProductTypes := ADoc.ProductType;

  ParamListGrid.CellsByName['Enable', LRow] := ADoc.Enable;
  ParamListGrid.CellsByName['UseBalloon', LRow] := ADoc.UseBalloon;

  if LShipProductTypes > -1 then
    ParamListGrid.CellsByName['ProductType', LRow] := g_ShipProductType.ToString(LShipProductTypes);

  ParamListGrid.CellsByName['ModelName', LRow] := ADoc.ModelName;
  ParamListGrid.CellsByName['ProjectName', LRow] := ADoc.ProjectName;
  ParamListGrid.CellsByName['SystemName', LRow] := ADoc.SystemName;
  ParamListGrid.CellsByName['SubSystemName', LRow] := ADoc.SubSystemName;
  ParamListGrid.CellsByName['SeqNo', LRow] := ADoc.SeqNo;
  ParamListGrid.CellsByName['Subject', LRow] := ADoc.Subject;
  ParamListGrid.CellsByName['Desc', LRow] := ADoc.Desc;
  ParamListGrid.CellsByName['ParamSourceList', LRow] := ADoc.ParamSourceList;
  ParamListGrid.CellsByName['JsonParamCollect', LRow] := ADoc.JsonParamCollect;
  ParamListGrid.CellsByName['CSVValues', LRow] := ADoc.CSVValues;
  ParamListGrid.CellsByName['CommandJson', LRow] := ADoc.CommandJson;

  if ADoc.UpdateDate > 127489752310 then
    ParamListGrid.CellsByName['UpdateDate', LRow] := DateToStr(TimeLogToDateTime(ADoc.UpdateDate));
end;

procedure TParamManageF.GetSimParamSearchFromGrid2Rec(
  var ASimParamSearchRec: TSimParamSearchRec);
var
  LRow: integer;
begin
  if ParamListGrid.SelectedRow = -1 then
    Exit;

  LRow := ParamListGrid.SelectedRow;
  ASimParamSearchRec := Default(TSimParamSearchRec);
  ASimParamSearchRec.fSeqNo := -1;

  ASimParamSearchRec.fProductType := g_ShipProductType.ToType(ParamListGrid.CellsByName['ProductType', LRow]);
  ASimParamSearchRec.fModelName := ParamListGrid.CellsByName['ModelName', LRow];
  ASimParamSearchRec.fProjectName := ParamListGrid.CellsByName['ProjectName', LRow];
  ASimParamSearchRec.fSystemName := ParamListGrid.CellsByName['SystemName', LRow];
  ASimParamSearchRec.fSubSystemName := ParamListGrid.CellsByName['SubSystemName', LRow];
  ASimParamSearchRec.fSubject := ParamListGrid.CellsByName['Subject', LRow];
  ASimParamSearchRec.fSeqNo := ParamListGrid.CellByName['SeqNo', LRow].AsInteger;
end;

procedure TParamManageF.GetSimParamSearchParam2Rec(
  var ASimParamSearchRec: TSimParamSearchRec);
begin
  ASimParamSearchRec := Default(TSimParamSearchRec);
  ASimParamSearchRec.fSeqNo := -1;

  if ProdTypeCB.ItemIndex = -1 then
    ASimParamSearchRec.fProductType := g_ShipProductType.ToType(0)
  else
    ASimParamSearchRec.fProductType := g_ShipProductType.ToType(ProdTypeCB.ItemIndex);

  ASimParamSearchRec.fModelName := ModelNameCB.Text;
  ASimParamSearchRec.fProjectName := ProjectNameCB.Text;
  ASimParamSearchRec.fSystemName := SystemNameCB.Text;
  ASimParamSearchRec.fSubSystemName := SubSystemNameCB.Text;
  ASimParamSearchRec.fSubject := SubjectEdit.Text;
end;

procedure TParamManageF.GetStateListFromLocal(AGridIdx: integer;
  AIsCreateDisplay: Boolean);
var
  LUtf8: RawUTF8;
  LTagName: string;
begin
  if Assigned(FWG.NextGrid1.Row[AGridIdx].Data) then
     if TEngineParameterItem(FWG.NextGrid1.Row[AGridIdx].Data).MultiStateItemIndex = -1 then
        exit;

  if not Assigned(g_EngineParamDB) then
  begin
    if MessageDlg('Parameter DB is not assigned!' + #13#10 + 'Do you want to select the db?',
               mtConfirmation,
               [mbYes, mbNo], 0, mbYes) = mrNo then
      exit;

    OpenDialog1.Filter := '';

    if OpenDialog1.Execute then
      InitEngineParamClient(OpenDialog1.FileName);
  end;

  LTagName := FWG.GetTagNameFromGrid(AGridIdx);
  LUtf8 := GetEngineMultiStateList2JSONArrayFromTagName(LTagName);

  if LUtf8 <> '' then
  begin
    ConvertMultiStat2ParamList(LUtf8, AGridIdx, 2);

    if AIsCreateDisplay then
      SendParam2CommandLineWithCreate
    else
      SendParam2gpSharedMM;

    if not FItemData_Dic.ContainsKey(AGridIdx) then
      FItemData_Dic.Add(AGridIdx, TParamItemClass.Create);

    FIPCMonitorMode := True;
  end;
end;

procedure TParamManageF.ImportGeneratorMasterFromXlsFile1Click(Sender: TObject);
var
  LSimParamSearchRec: TSimParamSearchRec;
begin
  LSimParamSearchRec := Default(TSimParamSearchRec);
  LSimParamSearchRec.fSeqNo := -1;
  GetSimParamSearchParam2Rec(LSimParamSearchRec);
  LSimParamSearchRec.fIsCreateNewRec := True;

  if not Assigned(FCommandLine) then
    FCommandLine := TSimulateParamCLO2.Create;

  if CreateOrShowParamEditFormFromDB(LSimParamSearchRec, FCommandLine,FIPCClientAll) = mrOK then  //FJsonParamCollect, FCSVValues, FParamSourceList, FAdditionalData
  begin
    GetParamList2Grid;
  end;
//  CreateOrShowParamEditFormFromDB(LSimParamSearchRec, '', '', '');
end;

procedure TParamManageF.InitializeSimulateIndex;
begin
//  if FThreadAssigned then
//  begin
//    if not FThreadSimulateEvent.Terminated then
//    begin
//      FThreadSimulateEvent.FStop := True;
//      //FThreadSimulateEvent.FPauseEvent.Pulse 하면 안됨
////      FThreadSimulateEvent.FPauseEvent.Signal;
//      FThreadSimulateEvent.ReStart;
//      FThreadAssigned := False;
//    end;
//  end;

  if Assigned(FThreadSimulateEvent) then
    FThreadSimulateEvent.InitCurrentIndex;

  StatusBarPro1.Panels[3].Text := '';
end;

procedure TParamManageF.InitializeSimulateThread;
begin
  if FThreadAssigned then
  begin
    FThreadSimulateEvent.FStop := True;
    FThreadSimulateEvent.ReStart;
    FThreadAssigned := False;
  end;

  CreateSimulateThread;
end;

procedure TParamManageF.InitIPCMonitor;
begin
  FWG.FCalculatedItemTimerHandle := -1;
  FWG.SetIPCMonitorAll(IPCMonitorAll1);
  FWG.SetStatusBar(JvStatusBar1);
  FWG.SetMainFormHandle(Handle);
  FWG.SetDeleteEngineParamterFromGrid(DeleteEngineParamterFromGrid);
  FWG.SetWatchValue2Screen_Analog(WatchValue2Screen_Analog); //Calculated Items을 계산하여 EngineParameter에 저장함
  FWG.NextGrid1.DoubleBuffered := False;
  FWG.FDisplayMessage := DisplayMessage;

  IPCMonitorAll1.FNextGrid := FWG.NextGrid1;
  IPCMonitorAll1.FPageControl := PageControl1;
  IPCMonitorAll1.SetValue2ScreenEvent4OnceAfterIPCTrigger(WatchValue2Screen_2);
  IPCMonitorAll1.FWatchValue2Screen_AnalogEvent := WatchValue2Screen_Analog;
  IPCMonitorAll1.FWatchValue2Screen_DigitalEvent := WatchValue2Screen_Digital;
  IPCMonitorAll1.FStatusBar := JvStatusBar1;
end;

procedure TParamManageF.InitParamDB(ADBName: string; ACreateIfNotExist: Boolean);
var
  LStr: string;
begin
  LStr := ExtractFilePath(ADBName);

  if LStr = '' then
    LStr := GetDefaultDBPath;

  if ADBName = '' then
    ADBName := LStr + HGS_SIMULATE_PARAM_DB_NAME;

  if ACreateIfNotExist or FileExists(ADBName) then
  begin
    DestroySimulateParam;
    g_SimulateParamDB := InitSimulateParamClient(ADBName, SimulateParamModel);
  end
  else
    ShowMessage('DB file : ' + ADBName + ' not found!');
end;

procedure TParamManageF.InitSTOMP(AUserId, APasswd, AServerIP, APort, ATopic: string);
begin
  if not Assigned(FpjhSTOMPClass) then
  begin
    FpjhSTOMPClass := TpjhSTOMPClass.CreateWithStr(AUserId,
                                            APasswd,
                                            AServerIP,
                                            APort,
                                            ATopic,
                                            Self.Handle);
  end;
end;

procedure TParamManageF.InitVar;
var
  LStr: string;
begin
  FExeFilePath := ExtractFilePath(Application.ExeName);
  FThreadSimulateEvent := nil;
  EGCSOpSimF := nil;
  SCROpSimF := nil;

//  if FCommandLine.ConfigFileName <> '' then
//    LStr := FCommandLine.ConfigFileName;

  FSettings := TConfigSettings.Create('');

  if FSettings.IniFileName = '' then
    FSettings.IniFileName := ChangeFileExt(Application.ExeName, '.ini');

  LoadConfigFromFile(FSettings.IniFileName);

//  FgpSharedMM := TGpSharedMemory.Create(SHARED_DATA_NAME, 0, SHARED_MAX_SIZE);
  FIPCClientAll := TIPCClientAll.Create;
  FIPCClientAll.InitgpSharedMemory4Producer(SHARED_DATA_NAME, gp_EventNameSpace, gp_EventName4SimCommandJson);
  FIPCClientAll.AddEventName2gpSMProducer(gp_EventName4SimAutoFillInData);
  FNextStepSM := SharedMemory<TSimCommonData>.Create(NEXTSTEP_SHARED_DATA_NAME, SharedMemoryAccessReadWrite);;
  FNotifySharedMMEvent := Event.Create(NOTIFY_SHMM_EVENT_NAME);  //StatusDisplay에 Notify 하는 Event
  FNotifyNextStepEvent := Event.Create(NEXT_STEP_EVENT_NAME);
  FItemData_Dic := TDictionary<integer, TParamItemClass>.Create;

  InitIPCMonitor;

  if FSettings.UseSTOMP then
  begin
    InitSTOMP(FSettings.STOMPServerUserId,
      FSettings.STOMPServerPasswd,
      FSettings.STOMPServerIP,
      FSettings.STOMPServerPort,
      FSettings.STOMPServerTopic);
  end;
//  InitSimulateParamClient(HGS_SIMULATE_PARAM_DB_NAME);

  STOMPMsgEventThread.SetDisplayMsgProc(DisplaySTOMPMessage2Memo);
//  InitSTOMP(FSettings.STOMPServerUserId,FSettings.STOMPServerPasswd,FSettings.STOMPServerIP,FSettings.STOMPServerTopic);
//  FPauseEvent := MyKernelObject4GpSharedMem.TEvent.Create('SimulateEvent', False);
  g_ShipProductType.InitArrayRecord(R_ShipProductType);
  g_ShipProductType.SetType2List(ProdTypeCB.Items);
//  ProdTypeCB.ItemIndex := ord(shptSCR);

  if not (Assigned(FCommandLine) and (UpperCase(FCommandLine.FSkipMsg) = 'TRUE')) then
    ShowMessage('FCommandJson을Client에 전달하기 위해서는(gpShaeredMemory 사용)' + #13#10 +
      'ParamServer.exe 프로그램을Client 보다 먼저 실행해야 함!!!');

  if FSettings.LoadCondOnStart then
    LoadCondition2Form;

  ProdTypeCBChange(ProdTypeCB);
//  if (FCommandLine.JsonParamCollect <> '') and (FCommandLine.FCSVValues <> '') then
//  begin
////    FCommandLine.JsonParamCollect := MakeBase64ToString(FCommandLine.JsonParamCollect);
////    FCommandLine.FCSVValues := MakeBase64ToString(FCommandLine.FCSVValues);
//    CreateParamManageR(FCommandLine.JsonParamCollect, FCommandLine.FCSVValues);
//  end;

//  if FCommandLine.ParamFileName <> '' then
//  begin
//
//  end;
end;

procedure TParamManageF.LoadCondition2Form;
var
  ini: TIniFile;
  LStr: string;
begin
  ini := TIniFile.Create(FSettings.IniFileName);

  try
    LStr := ini.ReadString('Start Condition', 'Product Type', '');
    ProdTypeCB.ItemIndex := Ord(g_ShipProductType.ToOrdinal(LStr));
    ModelNameCB.Text := ini.ReadString('Start Condition', 'Model Name', '');
    ProjectNameCB.Text := ini.ReadString('Start Condition', 'Project Name', '');
    SystemNameCB.Text := ini.ReadString('Start Condition', 'System Name', '');
    SubSystemNameCB.Text := ini.ReadString('Start Condition', 'SubSystem', '');
    ParamDBEdit.Text := ini.ReadString('Start Condition', 'Param DB', '');
    SubjectEdit.Text := ini.ReadString('Start Condition', 'Subject', '');
  finally
    ini.Free;
  end;
end;

procedure TParamManageF.LoadConfig2Form(AForm: TConfigF);
begin
  FSettings.LoadConfig2Form(AForm, FSettings);
end;

procedure TParamManageF.LoadConfigForm2Object(AForm: TConfigF);
begin
  FSettings.LoadConfigForm2Object(AForm, FSettings);
end;

procedure TParamManageF.LoadConfigFromFile(AFileName: string);
begin
  FSettings.Load(AFileName);

  if FSettings.STOMPServerIP = '' then
    FSettings.STOMPServerIP := '127.0.0.1';

  if FSettings.STOMPServerTopic = '' then
    FSettings.STOMPServerTopic := MQ_TOPIC_STOMP;

  ApplyUI;
end;

procedure TParamManageF.LoadWatchListFromFile1Click(Sender: TObject);
var
  LFileName: string;
  i: integer;
begin
  OpenDialog1.Filter := '';

  if OpenDialog1.Execute then
  begin
    if OpenDialog1.FileName <> '' then
    begin
      LFileName := ExtractFileName(OpenDialog1.FileName);
      FWG.GetItemsFromParamFile2Collect(OpenDialog1.FileName, 1,//json format
                True, False);
      FWG.NextGrid1.ClearRows;

      for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
      begin
        //DisplayFormat 속성이 나중에 추가 되었기 때문에 적용 안된 WatchList파일의 경우 적용하기 위함
        if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].DisplayFormat = '' then
        begin
          IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].DisplayFormat :=
            GetDisplayFormat(IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].RadixPosition,
                            IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].DisplayThousandSeperator);
        end;

        FWG.AddEngineParameter2Grid(i);
      end; //for
    end;
  end;
end;

procedure TParamManageF.ModelNameCBChange(Sender: TObject);
begin
  FillInSystemKind(ProdTypeCB.ItemIndex, ModelNameCB.ItemIndex, TComboBox(SystemNameCB));
end;

procedure TParamManageF.ParamDBEditButtonClick(Sender: TObject);
begin
  if ParamDBEdit.Text = '' then
    ParamDBEdit.Dialog.InitialDir := FExeFilePath;
end;

procedure TParamManageF.ParamDBEditChange(Sender: TObject);
begin
  InitParamDB(ParamDBEdit.Text);

  if not (Assigned(FCommandLine) and (UpperCase(FCommandLine.FSkipMsg) = 'TRUE')) then
    ShowMessage('MultiState 문자열을 Watch2 화면에 적용하기 위해서는 Watch2 화면에서 "Load Multi-State from Simulate DB"메뉴를 수동으로 실행할 것!! ');
end;

procedure TParamManageF.ParamListGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  if ARow = -1 then
    Exit;

  ShowParamEditFormFromGrid(ARow);
end;

procedure TParamManageF.ParamListGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DOWN then
    TransferSimData
  else
  if Key = VK_UP then
    TransferSimData(-1, True)
  else
  if Key = VK_SHIFT then
    ;
end;

procedure TParamManageF.ProcessSimulateOneStep;
begin
  TransferSimData;
end;

procedure TParamManageF.ProcessSubscribeMsg;
var
  msg: TOmniMessage;
  FStompFrame: IStompFrame;
begin
  while FpjhSTOMPClass.GetResponseQMsg(msg) do
  begin
    FStompFrame := msg.MsgData.AsInterface as IStompFrame;
//    Memo1.Lines.Add(FStompFrame.GetBody);
  end;
end;

procedure TParamManageF.ProdTypeCBChange(Sender: TObject);
begin
  FillInModelKind(ProdTypeCB.ItemIndex, ModelNameCB);
  FillInSystemKind(ProdTypeCB.ItemIndex, ModelNameCB.ItemIndex, TComboBox(SystemNameCB));
end;

procedure TParamManageF.ransferselectedstep1Click(Sender: TObject);
begin
  TransferSimData(ParamListGrid.SelectedRow,True);
end;

//procedure TParamManageF.RecvParamFromSharedMM;
//var
//  LStrList: TStringList;
//begin
//  LStrList := TStringList.Create;
//  try
//    if FgpSharedMM.AcquireMemory(False, INFINITE) <> nil then
//    begin
////      if not FgpSharedMM.Modified then
//        LStrList.LoadFromStream(FgpSharedMM.AsStream);
//        ShowMessage(LStrList.text);
//    end;
//
//    if FgpSharedMM.Acquired then
//      FgpSharedMM.ReleaseMemory;
//  finally
//    LStrList.Free;
//  end;
//end;

procedure TParamManageF.SaveCondition2IniFile;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(FSettings.IniFileName);

  try
    ini.WriteString('Start Condition', 'Product Type', ProdTypeCB.Text);
    ini.WriteString('Start Condition', 'Model Name', ModelNameCB.Text);
    ini.WriteString('Start Condition', 'Project Name', ProjectNameCB.Text);
    ini.WriteString('Start Condition', 'System Name', SystemNameCB.Text);
    ini.WriteString('Start Condition', 'SubSystem', SubSystemNameCB.Text);
    ini.WriteString('Start Condition', 'Param DB', ParamDBEdit.Text);
    ini.WriteString('Start Condition', 'Subject', SubjectEdit.Text);

  finally
    ini.Free;
  end;
end;

procedure TParamManageF.Savecurrentsetting1Click(Sender: TObject);
begin
  SaveCondition2IniFile;
end;

procedure TParamManageF.SaveItemstoNewName1Click(Sender: TObject);
var
  LFileName: string;
begin
  if JvSaveDialog1.Execute then
  begin
    LFileName := JvSaveDialog1.FileName;

    if FileExists(LFileName) then
    begin
      if MessageDlg('File is already existed. Are you overwrite? if No press, then the data is not saved!.',
      mtConfirmation, [mbYes, mbNo], 0)= mrNo then
        exit;
    end;
  end;

  IPCMonitorAll1.FEngineParameter.SaveToJSONFile(LFileName,
              ExtractFileName(LFileName),True);
end;

procedure TParamManageF.SendCommand2SharedMM(ACommand: integer);
var
  data: SharedMemory<TSimCommonData>.Ptr;
begin
  StatusBarPro1.Panels[4].Text := IntToStr(ACommand);

  try
    data := FNextStepSM.BeginAccess;

    if (FNextStepSM.Abandoned) then
      exit;

    data^.Value := -1;
    data^.Command := ACommand;
    FNotifyNextStepEvent.Signal;
  finally
    FNextStepSM.EndAccess;
  end;
end;

procedure TParamManageF.SendData2MQ(AMsg, ATopic: string);
begin
  FpjhSTOMPClass.StompSendMsg(AMsg, ATopic);
end;

procedure TParamManageF.SendMultiStateToSM1Click(Sender: TObject);
begin
  if FWG.NextGrid1.SelectedRow <> -1 then
  begin
    GetStateListFromLocal(FWG.NextGrid1.SelectedRow, False);
  end;
end;

procedure TParamManageF.SendParam2gpSharedMM;
begin
//  if not FThreadAssigned then
//    CreateSimulateThread;

//  FThreadSimulateEvent.SendData2gpSM(FParamListJson);
  FIPCClientAll.SendData2gpSM(gp_EventName4StatusDisplay,FParamListJson);
  FNotifySharedMMEvent.Signal;
//    StatusBarPro1.Panels[4].Text := IntToStr(Random(100));
end;

procedure TParamManageF.SendParam2CommandLineWithCreate;
var
  LRawUTF8: RawUTF8;
  LParam: string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  LRawUTF8 := StringToUtf8(FParamListJson);
  LRawUTF8 := MakeRawUTF8ToBin64(LRawUTF8);
  LParam := Utf8ToString(LRawUTF8);
  ExecNewProcess2('.\' + STATUS_DISPLAY_EXE_NSME, '/j'+LParam);
end;

procedure TParamManageF.SendStateListToSMCreateDisplay1Click(Sender: TObject);
begin
  if FWG.NextGrid1.SelectedRow <> -1 then
  begin
    GetStateListFromLocal(FWG.NextGrid1.SelectedRow, True);
  end;
end;

procedure TParamManageF.SendSystemMode2SharedMM(AIsSystemMode: Boolean);
var
  data: SharedMemory<TSimCommonData>.Ptr;
begin
  StatusBarPro1.Panels[4].Text := BoolToStr(AIsSystemMode);

  try
    data := FNextStepSM.BeginAccess;

    if (FNextStepSM.Abandoned) then
      exit;

    data^.Value := -1;
    data^.Command := -1;
    data^.IsSystemMode := AIsSystemMode;
    FNotifyNextStepEvent.Signal;
  finally
    FNextStepSM.EndAccess;
  end;
end;

procedure TParamManageF.SentParam2STOMP;
begin
  SendData2MQ(FParamListJson);
end;

procedure TParamManageF.SetConfig;
var
  LConfigF: TConfigF;
  LParamFileName: string;
begin
  LConfigF := TConfigF.Create(Self);

  try
    LParamFileName := FSettings.ParamFileName;
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

procedure TParamManageF.SetSimData(APType, ASystemKind, ASubSystem: integer);
begin
  ProdTypeCB.ItemIndex := APType;
  ProdTypeCB.OnChange(Self);
  SystemNameCB.ItemIndex :=ASystemKind;
  SystemNameCB.OnSelect(Self);
  SubSystemNameCB.ItemIndex := ASubSystem;

  GetParamList2Grid;
end;

//procedure TParamManageF.SetSimData4DosingUnitInjection;
//begin
//  ProdTypeCB.ItemIndex := Ord(shptSCR);
//  ProdTypeCB.OnChange(Self);
//  SystemNameCB.ItemIndex := Ord(smkDosingUnit);
//  SystemNameCB.OnSelect(Self);
//  SubSystemNameCB.ItemIndex := Ord(sss2Injection);
//
//  GetParamList2Grid;
//end;
//
//procedure TParamManageF.SetSimData4DosingUnitReady;
//begin
//  ProdTypeCB.ItemIndex := Ord(shptSCR);
//  ProdTypeCB.OnChange(Self);
//  SystemNameCB.ItemIndex := Ord(smkDosingUnit);
//  SystemNameCB.OnSelect(Self);
//  SubSystemNameCB.ItemIndex := Ord(sss2Ready);
//
//  GetParamList2Grid;
//end;
//
//procedure TParamManageF.SetSimData4Heating;
//begin
//  ProdTypeCB.ItemIndex := Ord(shptSCR);
//  ProdTypeCB.OnChange(Self);
//  SystemNameCB.ItemIndex := Ord(smkHeating);
//  SystemNameCB.OnSelect(Self);
//  SubSystemNameCB.ItemIndex := Ord(sss1Start);
//
//  GetParamList2Grid;
//end;
//
//procedure TParamManageF.SetSimData4Regeneration;
//begin
//  ProdTypeCB.ItemIndex := Ord(shptSCR);
//  ProdTypeCB.OnChange(Self);
//  SystemNameCB.ItemIndex := Ord(smkRegeneration);
//  SystemNameCB.OnSelect(Self);
//  SubSystemNameCB.ItemIndex := Ord(sss1Start);
//
//  GetParamList2Grid;
//end;

procedure TParamManageF.SetSimData4EGCS(ASystemKind: integer);
begin
  case ASystemKind of
    1: SetSimData(Ord(shptEGCS), Ord(eskHybrid), Ord(ess2Prepare));
    2: SetSimData(Ord(shptEGCS), Ord(eskHybrid), Ord(ess2OpenStart));
    3: SetSimData(Ord(shptEGCS), Ord(eskHybrid), Ord(ess2Open2CloseChgOver));
    4: SetSimData(Ord(shptEGCS), Ord(eskHybrid), Ord(ess2Close2OpenChgOver));
    5: SetSimData(Ord(shptEGCS), Ord(eskHybrid), Ord(ess2OpenStop));
    6: SetSimData(Ord(shptEGCS), Ord(eskHybrid), Ord(ess2ClosedStart));
    7: SetSimData(Ord(shptEGCS), Ord(eskHybrid), Ord(ess2ClosedStop));
    8: SetSimData(Ord(shptEGCS), Ord(eskHybrid), Ord(ess2HoldingDischarge));
    9: SetSimData(Ord(shptEGCS), Ord(eskHybrid), Ord(ess2SpillOverDischarge));
  end;
end;

procedure TParamManageF.SetSimData4SCR(ASystemKind: integer);
begin
  case ASystemKind of
    1: SetSimData(Ord(shptSCR), Ord(sskVenting), Ord(sss1Start));
    2: SetSimData(Ord(shptSCR), Ord(smkSealing), Ord(sss1Start));
    3: SetSimData(Ord(shptSCR), Ord(smkHeating), Ord(sss1Start));
    4: SetSimData(Ord(shptSCR), Ord(smkStandbyHeating), Ord(sss1Start));
    5: SetSimData(Ord(shptSCR), Ord(smkRegeneration), Ord(sss1Start));
    6: SetSimData(Ord(shptSCR), Ord(smkDosingUnit), Ord(sss2Ready));
    7: SetSimData(Ord(shptSCR), Ord(smkDosingUnit), Ord(sss2Injection));
  end;

//    1: SetSimData4Venting;
//    2: SetSimData4Sealing;
//    3: SetSimData4Heating;
//    4: SetSimData4StandbyHeating;
//    5: SetSimData4Regeneration;
//    6: SetSimData4DosingUnitReady;
//    7: SetSimData4DosingUnitInjection;
end;

//procedure TParamManageF.SetSimData4Sealing;
//begin
//  SetSimData(Ord(shptSCR), Ord(smkSealing), Ord(sss1Start));
//  ProdTypeCB.ItemIndex := Ord(shptSCR);
//  ProdTypeCB.OnChange(Self);
//  SystemNameCB.ItemIndex := Ord(smkSealing);
//  SystemNameCB.OnSelect(Self);
//  SubSystemNameCB.ItemIndex := Ord(sss1Start);
//
//  GetParamList2Grid;
//end;

//procedure TParamManageF.SetSimData4StandbyHeating;
//begin
//  ProdTypeCB.ItemIndex := Ord(shptSCR);
//  ProdTypeCB.OnChange(Self);
//  SystemNameCB.ItemIndex := Ord(smkStandbyHeating);
//  SystemNameCB.OnSelect(Self);
//  SubSystemNameCB.ItemIndex := Ord(sss1Start);
//
//  GetParamList2Grid;
//end;

//procedure TParamManageF.SetSimData4Venting;
//begin
//  SetSimData(Ord(shptSCR), Ord(sskVenting), Ord(sss1Start));
//  ProdTypeCB.ItemIndex := Ord(shptSCR);
//  ProdTypeCB.OnChange(Self);
//  SystemNameCB.ItemIndex := Ord(sskVenting);
//  SystemNameCB.OnSelect(Self);
//  SubSystemNameCB.ItemIndex := Ord(sss1Start);
//
//  GetParamList2Grid;
//end;

//procedure TParamManageF.SharedMMTest;
//var
//  LStrList: TStringList;
//begin
//  LStrList := TStringList.Create;
//  try
//    LStrList.Text := FParamListJson;
//
//    if FgpSharedMM.AcquireMemory(True, INFINITE) <> nil then
//    begin
//      if FgpSharedMM.IsWriting then
//        LStrList.SaveToStream(FgpSharedMM.AsStream);
//
//      if FgpSharedMM.Acquired then
//        FgpSharedMM.ReleaseMemory;
//    end;
//
//    if FgpSharedMM.AcquireMemory(False, INFINITE) <> nil then
//    begin
//      LStrList.Text := '';
//      LStrList.LoadFromStream(FgpSharedMM.AsStream);
//    end;
//  finally
//    LStrList.Free;
//  end;
//end;

procedure TParamManageF.ShowEGCSOperationSimulate1Click(Sender: TObject);
begin
  if not Assigned(EGCSOpSimF) then
    EGCSOpSimF := TEGCSOpSimF.Create(nil);

  EGCSOpSimF.Show;
  EGCSOpSimF.Edit1.SetFocus;
end;

procedure TParamManageF.ShowParamEditFormFromGrid(ARow: integer);
var
  LSimParamSearchRec: TSimParamSearchRec;
begin
  if ARow <> -1 then
  begin
    GetSimParamSearchFromGrid2Rec(LSimParamSearchRec);
  end;

  if not Assigned(FCommandLine) then
    FCommandLine := TSimulateParamCLO2.Create;

  if CreateOrShowParamEditFormFromDB (LSimParamSearchRec, FCommandLine, FIPCClientAll) = mrOK then //FJsonParamCollect, FCSVValues, FParamSourceList, FAdditionalData
  begin
    GetParamList2Grid;
    ParamListGrid.ScrollToRow(ARow);
  end;
end;

procedure TParamManageF.ShowSCROperationSimulate1Click(Sender: TObject);
//var
//  LSCROpSimF: TSCROpSimF;
begin
//  LSCROpSimF := TSCROpSimF.Create(nil);
  try
    if not Assigned(SCROpSimF) then
      SCROpSimF := TSCROpSimF.Create(nil);

    SCROpSimF.Show;
    SCROpSimF.Edit1.SetFocus;
  finally

  end;
end;

procedure TParamManageF.ShowStatusDisplay1Click(Sender: TObject);
begin
//  StatusDisplayF.Show;
//  StatusDisplayF.Align := alTop;
end;

procedure TParamManageF.SystemNameCBSelect(Sender: TObject);
begin
  FillInSubSystemKind(ProdTypeCB.ItemIndex, SystemNameCB.ItemIndex, SubSystemNameCB);
end;

procedure TParamManageF.Timer1Timer(Sender: TObject);
var
  LSimParamSearchRec: TSimParamSearchRec;
begin
  Timer1.Enabled := False;

  InitParamDB(FParamDBName);
  ParamDBEdit.Text := FParamDBName;
  LSimParamSearchRec := Default(TSimParamSearchRec);
  LSimParamSearchRec.fSeqNo := -1;
  LSimParamSearchRec.fIsCreateNewRec := True;

  if not Assigned(FCommandLine) then
    FCommandLine := TSimulateParamCLO2.Create;

  if CreateOrShowParamEditFormFromDB(LSimParamSearchRec, FCommandLine, FIPCClientAll) = mrOK then //FJsonParamCollect, FCSVValues, FParamSourceList, FAdditionalData
  begin
//    GetParamList2Grid;
//    ParamListGrid.ScrollToRow(ARow);
  end;
end;

procedure TParamManageF.TransferMultiStateData(AValue: integer);
var
  data: SharedMemory<TSimCommonData>.Ptr;
begin
  try
    data := FNextStepSM.BeginAccess;

    if (FNextStepSM.Abandoned) then
      exit;

    data^.Value := AValue;
    data^.Command := -1;
    data^.IsSystemMode := False;
    FNotifyNextStepEvent.Signal;
  finally
    FNextStepSM.EndAccess;
  end;
end;

procedure TParamManageF.TransferSimData(AGotoIndex: integer; AToPrev: Boolean);
begin
  if FSettings.UseSharedMM then
  begin
    if FThreadAssigned then
    begin
      if FThreadSimulateEvent.Terminated then
      begin
        CreateSimulateThread;
      end
      else
      if not TransferStepCheck.Checked then
      begin
        FThreadSimulateEvent.FStop := True;
        FThreadSimulateEvent.ReStart;
      end;
    end
    else
      CreateSimulateThread;

    if FIPCMonitorMode then
    begin

    end
    else
    begin
      if AGotoIndex <> -1 then
        FThreadSimulateEvent.FGotoIndex := AGotoIndex
      else
      if TransferStepCheck.Checked then
      begin
        if AToPrev then
          FThreadSimulateEvent.FNextIndex := -1
        else
          FThreadSimulateEvent.FNextIndex := 1;
      end;

      if FThreadSimulateEvent.Suspended then
        FThreadSimulateEvent.Resume
      else
        FThreadSimulateEvent.ReStart;
    end;
  end
  else
    ShowMessage('Please set the "UseSharedMM" from Option->Config->File');

  if FSettings.UseSTOMP then
  begin
//    SendData2MQ();
  end;
end;

procedure TParamManageF.UpdateStatusBar(var Msg: TMessage);
var
  data: SharedMemory<TSimCommonData>.Ptr;
begin
  ParamListGrid.SelectedRow := FThreadSimulateEvent.FCurrentIndex;
  ParamListGrid.ScrollToRow(ParamListGrid.SelectedRow);
  StatusBarPro1.Panels[3].Text := ParamListGrid.CellsByName['SeqNo',ParamListGrid.SelectedRow];//  IntToStr(ParamListGrid.SelectedRow+1);

  try
    data := FNextStepSM.BeginAccess;

    if (FNextStepSM.Abandoned) then
      exit;

    data^.Value := FThreadSimulateEvent.FCurrentIndex;
    data^.Command := -1;
    data^.IsSystemMode := True;
    FNotifyNextStepEvent.Signal;
  finally
    FNextStepSM.EndAccess;
  end;
//  StatusDisplayF.MoveNextStep(FThreadSimulateEvent.FCurrentIndex);
end;

procedure TParamManageF.WatchValue2Screen_2;
begin

end;

procedure TParamManageF.WatchValue2Screen_Analog(Name, AValue: string;
  AEPIndex: integer);
var
  LValue: string;
  iValue,
  LCurrentState: integer;
begin
  LValue := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].Value;
  FWG.NextGrid1.CellsByName['Value', AEPIndex] := LValue;

  if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MultiStateItemIndex <> -1 then
  begin
    iValue := StrToIntDef(LValue,-2);

    LCurrentState :=  FItemData_Dic.Items[AEPIndex].CurrentState;

    if LCurrentState >= 0 then
    begin
      if (iValue - LCurrentState) > 1 then
        iValue := LCurrentState + 1;
    end;

    TransferMultiStateData(iValue);
    FItemData_Dic.Items[AEPIndex].CurrentState := iValue;
  end;
end;

procedure TParamManageF.WatchValue2Screen_Digital(Name, AValue: string;
  AEPIndex: integer);
var
  LDouble: double;
  i: integer;
  LValue: string;
begin
  LValue := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].Value;

  if LValue = '' then
    exit;

  LDouble := StrToFloatDef(LValue, 0.0);

  if LValue = '0' then
    FWG.NextGrid1.CellsByName['Value', AEPIndex] := 'False'
  else
    FWG.NextGrid1.CellsByName['Value', AEPIndex] := 'True';

end;

procedure TParamManageF.WMCopyData(var Msg: TMessage);
var
  LDragCopyMode: TParamDragCopyMode;
begin
  case Msg.WParam of
    0: begin
      LDragCopyMode := PEngineParameterItemRecord(PCopyDataStruct(Msg.LParam)^.lpData)^.FParamDragCopyMode;
      if LDragCopyMode <> dcmCopyCancel then //HiMECS에서 모드가 전송 되어 오는 경우
        CreateIPCMonitor(PEngineParameterItemRecord(PCopyDataStruct(Msg.LParam)^.lpData)^, LDragCopyMode)
      else//마우스로 모드 선택하는 경우
        CreateIPCMonitor(PEngineParameterItemRecord(PCopyDataStruct(Msg.LParam)^.lpData)^, FWG.FDragCopyMode);
      //PageControl1.Pages[PageControl1.PageCount - 1].TabVisible := False;
    end;
  end;
end;

procedure TParamManageF.WM_Command(var Msg: TMessage);
begin
  SendCommand2SharedMM(Msg.WParam);
end;

procedure TParamManageF.WM_CommandJson(var Msg: TMessage);
begin
  FIPCClientAll.SendData2gpSM(gp_EventName4SimCommandJson, FCommandJson);

//  FIPCClientAll.FGpSharedEventProducer.BroadcastEvent(gp_EventName4SimCommandJson,
//              FormatDateTime('hh:mm:ss.zzz', Now));
end;

procedure TParamManageF.WM_KeyDown(var Msg: TMessage);
begin
  TransferSimData;
end;

procedure TParamManageF.WM_KeyShift(var Msg: TMessage);
var
  LShipProdType: TShipProductType;
begin
  LShipProdType := TShipProductType(Msg.LParam);

  case LShipProdType of
    shptSCR: SetSimData4SCR(Msg.WParam);
    shptEGCS: SetSimData4EGCS(Msg.WParam);
  end;
end;

procedure TParamManageF.WM_KeyUp(var Msg: TMessage);
begin
  TransferSimData(-1,True);
end;

procedure TParamManageF.WM_SystemMode(var Msg: TMessage);
begin
  SendSystemMode2SharedMM(Msg.WParam=1);
end;

procedure TParamManageF.WorkerResult(var msg: TMessage);
begin
  ProcessSubscribeMsg;
end;

{ TThreadSimulateEvent }


constructor TThreadSimulateEvent.Create(CreateSuspended: Boolean);
begin
//  FPauseEvent := APauseEvent;//TEvent.Create;
  FParamSrcList := TStringList.Create;
//  FPauseEvent := MyKernelObject4GpSharedMem.TEvent.Create('SimulateEvent', False);
  FPauseEvent := Event.Create(SIMULATE_EVENT_NAME);
//  FPauseEvent.Reset;
  FGotoIndex := -1;

  inherited Create(CreateSuspended);
end;

procedure TThreadSimulateEvent.CreateIPCClients;
var
  i: integer;
  LVar: Variant;
  LStr, LParamSrc: string;
begin
  FIPCClientAll.ClearIPCClientAll;
  FParamSrcList.Clear;
  FDocData.InitJSON(FParamListJson);

  for i := 0 to FDocData.Count - 1 do
  begin
    LVar := _JSON(FDocData.Value[i]);
    LStr := LVar.ParamSourceList;
    LParamSrc := strToken(LStr,',');

    if FParamSrcList.IndexOf(LParamSrc) < 0 then
    begin
      FIPCClientAll.CreateIPCClient(String2ParameterSource(LParamSrc));
      FParamSrcList.Add(LParamSrc);
    end;
  end;
end;

destructor TThreadSimulateEvent.Destroy;
begin
  FParamSrcList.Free;
//  FPauseEvent.Free;
end;

procedure TThreadSimulateEvent.Execute;
//var
//  LDynUtf8: TRawUTF8DynArray;
//  LDynArr: TDynArray;
begin
  //CreateIPCClients;
  PulseParamListFromJson;
end;

procedure TThreadSimulateEvent.InitCurrentIndex;
begin
  FCurrentIndex := -1;
end;

procedure TThreadSimulateEvent.PulseParamListFromJson;
var
  LUtf8: RawUTF8;
  LData: TEventData_Modbus_Standard;
  LParamSrc: TParameterSource;
  LVar: Variant;
  j, LDelaySecs: integer;
  LStr: string;
  LEnable: Boolean;
begin
  FCurrentIndex := 0;

  while not terminated do
  begin
//    for i := 0 to FDocData.Count - 1 do
//    begin
      LVar := _JSON(FDocData.Value[FCurrentIndex]); //TSQLSimulateParamRecord 1 Row를 가져옴
      LEnable := LVar.Enable;

      if LEnable then
      begin
//        FCurrentIndex := i;

        LUtf8 := LVar.CSVValues;
        LDelaySecs := LVar.DelaySecs;

        if LDelaySecs > 0 then
          Sleep(LDelaySecs);

        LStr := UTF8ToString(LUtf8);
        FIPCClientAll.MakeModbusStandardFromCSV(LData, LStr);

        LData.DFPageCaption := LVar.DFPageCaption;
        LData.DFPageIndex := LVar.DFPageIndex;
        LData.UseBalloon := LVar.UseBalloon;
//        LData.ModBusMapFileName := LVar.DFPageCaption;
//        LData.BlockNo := LVar.DFPageIndex;
//        LData.PowerOn := LVar.UseBalloon;

        if LData.UseBalloon then
        begin
          LData.IPAddress := LVar.Desc;
        end;

        if LVar.CommandJson <> '' then
        begin
          LData.UseCommandJson := True;
          SendData2gpSM(LVar.CommandJson);

          if FInterval4PulseData > 0 then
            Sleep(FInterval4PulseData);
        end;

        FIPCClientAll.PulseEventData<TEventData_Modbus_Standard>(LData); //TEventData_FGSS_KM

        if LData.UseCommandJson then
        begin
          LData.UseCommandJson := False;
        end;
      end;

      SendMessage(ParamManageF.Handle, MSG_UPDATESTATUS, 0, 0);

      if FPause then
      begin
//          FPauseEvent.Wait(INFINITE);
        FPauseEvent.WaitForSignal();
      end;

      if FStop then
        break;

      if FGotoIndex <> -1 then
      begin
        FCurrentIndex := FGotoIndex;
        FGotoIndex := -1;
      end
      else
        FCurrentIndex := FCurrentIndex + FNextIndex;

      if (FCurrentIndex < 0) then
        FCurrentIndex := FDocData.Count - 1;

      if (FCurrentIndex > FDocData.Count - 1) then
        FCurrentIndex := 0;

//    end;//for
  end;//while

  Terminate;
end;

procedure TThreadSimulateEvent.ReStart;
begin
    FPauseEvent.Signal;
//  FPauseEvent.Pulse;
end;

procedure TThreadSimulateEvent.SendData2gpSM(AData: string);
begin
  if AData = '{Components: []}' then
    exit;

  ParamManageF.FCommandJson := AData;
  SendMessage(ParamManageF.Handle, MSG_COMMAND_JSON, 0, 0);

//  FIPCClientAll.SendData2gpSM(AData);
//
//  FIPCClientAll.FGpSharedEventProducer.BroadcastEvent(gp_EventName4SimCommandJson,
//              FormatDateTime('hh:mm:ss.zzz', Now));
end;

procedure TThreadSimulateEvent.SetParamListJson(AJson: string);
begin
  FParamListJson := AJson;

  CreateIPCClients;
end;

end.
