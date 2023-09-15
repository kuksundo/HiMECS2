unit FrmModbusCom_main2;
{1. DSiGetProcessWindow�Լ��� �̿��Ͽ� Window Handle�� �����ö� Main Form Handle�� �ƴ� ���� �߻�:
    (WM_CLOSE �޼����� ������ ���� ����)
   �ذ�: Project Source��
        Application.MainFormOnTaskbar := True;
        �߰��Ͽ� �ذ� ��.                     : 2015.2.28
 2. TrayIcon�� �߰��� �� Visible := True�� �Ǹ� �� ������ ����ȭ �ǳ� ���� �����
    TrayIcon�� Visible := False�� �θ� Main Form Handle�� ������ �� �����Ƿ� ���� ����
 3. FCode 04�� 125�� ���� ����, FCode 02�� 1000�� ���� ����
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, SyncObjs,
  Dialogs, CPort,
  StdCtrls, ComCtrls, ExtCtrls, DB, DBTables, Grids, DBGrids, iniFiles, ModbusComStruct,
  MyKernelObject, UnitModBusComThread2, FrmModbusConfig2, Menus, ByteArray,
  CopyData, UnitModBusTCPWagoThread2, MBT2, JvExComCtrls,
  JvProgressBar, JvExControls, JvLED, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdModBusClient, UnitModBusTCPThread2,
  DeCAL, IPCThreadEvent, UnitModbusComConst, CommonUtil, HiMECSConst2,
  IPCThrdClient_Generic,
  IPCThrdMonitor_Generic, IPC_ModbusComm_Const, JclDebug, FrmModbusCom_Recv,
  UnitNetworkAdaptor, USock, Vcl.ImgList, Vcl.AppEvnts, TimerPool,
  mormot.core.base, mormot.core.json, mormot.core.log,
  //STOMP units
  UnitSTOMPClass, UnitMQData,
  UnitEngineParamRecord2, FrmDisplaySingleValue,
  UnitSynLog2, UnitEngineParameterClass2, UnitIPCClientAll2;

type
  TModbusComF = class(TForm)
    Panel1: TPanel;
    ModBusSendComMemo: TMemo;
    Timer1: TTimer;
    Splitter1: TSplitter;
    ModBusRecvComMemo: TMemo;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    About1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    StatusBar1: TStatusBar;
    Button2: TButton;
    DisplayRecv1: TMenuItem;
    PopupMenu1: TPopupMenu;
    ImageList1: TImageList;
    ShowMainForm1: TMenuItem;
    Close1: TMenuItem;
    N5: TMenuItem;
    About2: TMenuItem;
    Button3: TButton;
    ShowHandle1: TMenuItem;
    ShowProcessID1: TMenuItem;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    ShowEngineName1: TMenuItem;
    N6: TMenuItem;
    ShowEventName1: TMenuItem;
    DisplaySIngleValue1: TMenuItem;
    N7: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WMReceiveString( var Message: TMessage ); message WM_RECEIVESTRING;
    procedure WMReceiveByte( var Message: TMessage ); message WM_RECEIVEBYTE;
    procedure WMReceiveByte4Write( var Message: TMessage ); message WM_RECEIVEBYTE_WRITE;
    procedure WMReceiveByteConfigData( var Message: TMessage ); message WM_RECEIVEBYTE_CONFIGDATA;
    procedure WMReceiveWordTCPWago( var Message: TMessage ); message WM_RECEIVEWORD_TCPWAGO;
    procedure WMReceiveWordTCP( var Message: TMessage ); message WM_RECEIVEWORD_TCP;
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;
    procedure Timer1Timer(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure Switch1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DisplayRecv1Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure ShowMainForm1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ShowHandle1Click(Sender: TObject);
    procedure ShowProcessID1Click(Sender: TObject);
    procedure ShowEngineName1Click(Sender: TObject);
    procedure ShowEventName1Click(Sender: TObject);
    procedure DisplaySIngleValue1Click(Sender: TObject);
  private
    FFirst: Boolean;//��ó���� ����ɶ� True �� �������ʹ� False
    FFilePath: string;      //������ ������ ���
    FStoreType: TStoreType; //������(ini or registry)
    FRecvStrBuf: String;        //��Ʈ���� ������ ���Ű��� �����
    FSharedMemName: string; //IPCClient Shared Memory Name
    FMapFileName: string;//Modbus map file name
    FMapFileName2: string;//Modbus map file name
    FIniFileName: string;//exe name + .ini
    FSaveFileName: string;//exe name + _save.ini
    FComPort: TComPort;     //��� ��Ʈ
    FModBusBlockList: DList;//Modbus Block ��ſ� Address ���� ����ü
    //FIPCClient: TIPCClient<TEventDataRecord>;//���� �޸� �� �̺�Ʈ ��ü
    FIPCClientAll: TIPCClientAll;
    FModBusBlock: TModbusBlock;//sendquery�� �ּҰ� ��(cnt����)
    FParamSource: TParameterSource;

    FModBusMode: TModBusMode;//ASCII, RTU , TCPWago Mode, simulate mode
    FMBTDLLHandle: THandle; //MBT.DLL file handle
    FIPAddress: string;
    FPortNum: integer;
    FBindIPAddress: string;

    FQueryInterval: integer;
    FTimeOut: integer;
    FLauncherHandle: integer; //�ڵ� ���� ��Ű�� ���α׷� window handle

    //FEventHandle: TEvent;//Send�� �� Receive�Ҷ����� Wait�ϴ� Event

    FModBusComThread: TModBusComThread; //Thread ��� ��ü
    FModBusTCPWagoThread: TModBusTCPWagoThread; //Thread ��� ��ü
    FModBusTCPThread: TModBusTCPThread; //Thread ��� ��ü

    FNetworkAdapterList: TNetworkAdapterCollect; //Local IP Address List
    FPJHTimerPool: TPJHTimerPool;
    FEngineName: string;  //Unique Engine Name

    FpjhSTOMPClass: TpjhSTOMPClass;
    FMQInfoRec: TMQInfoRec;

    FIsSimulate: Boolean;

    procedure OnAppMinimize(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnMakeData4Simulate(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);

    procedure SetCurrentCommandIndex(aIndex: integer);
    procedure SetModBusMode(aMode:TModBusMode);

    procedure SerialCommStart;
    procedure DisplayIPCClientList;
    procedure ShowMainForm;
  protected
    FIPCMonitor: TIPCMonitor<TConfigData_ModbusComm>;
    FWriteCommData: TConfigData_ModbusComm;

    procedure UpdateTrace_WriteComm(var Msg: TConfigData_ModbusComm); message WM_EVENT_WRITECOMM;
    procedure WriteComm_OnSignal(Data: TConfigData_ModbusComm); virtual;

    procedure MakeCommand4Write1(var AValue: string);
    procedure MakeCommand4Write2(var AValue: string);
    procedure MakeCommand4Write3(var AValue: string);
    procedure MakeCommand4Write4(var AValue: string);
    procedure MakeCommand4Write5(var AValue: string);
    procedure MakeCommand4Write6(var AValue: string);
    procedure MakeCommand4ScalarValue(var AValue: string);
  public
    FRecvByteBuf: TByteArray2;//��������� ������ ���Ű��� �����
    FRecvWordBuf: array[0..255] of word;//TCP Wago ���� ������ ���Ű� �����
    FRecvBoolBuf: array[0..MAX_DIGITAL_DATA] of Bool;//TCP ���� Digital ������ ���Ű� �����
    FSendCommandList: TStringList;//Modbus ��� ��� ����Ʈ
    //FWriteCommandList: TStringList;//Write ��� ��� ����Ʈ
    //���� Comport�� Write�� FSendCommandList�� Index(0���� ������)
    FCurrentCommandIndex: integer;
    //�����ð� �̻� ��ſ� ���� ������ ������ ����� �ٿ����� ����(Wait �ð� ����)
    FCommFail: Boolean;
    FCommFailCount: integer; //��� ������ ���� FQueryInterval�� ����� Ƚ��
    //Base Address, Slave number�� Function Code(ȯ�漳������ ����)
    FBaseAddress, FSlaveNo, FFunctionCode: integer;
    FCriticalSection: TCriticalSection;
    FErrCnt: integer; //LRC Error Log
    FEngineParameter: TEngineParameter;
    FEngParamEncrypt: Boolean;
    //0: XML, 1: JSON, 2: Sqlite
    FEngParamFileFormat: integer;
    FParamFileName: string;
    FConfigModified: Boolean;
    FToggleBackground: Boolean;
    FDisplayRecvF: TDisplayRecvF;

    procedure InitVar;
    function InitComport: Boolean;
    procedure SetDefaultComport;
    //�����ݷ�(;)���� �и��� �ؽ�Ʈ ȭ���� ODBC�� ��ġ�� �ʰ� ���� ������
    procedure ReadMapAddressFromParamFile(AFilename: string; AModBusBlockList:DList);
    procedure ReadMapAddressFromParamFileUsingTStrings(AFilename: string; AModBusBlockList:DList);
    procedure ReadMapFile;
    procedure AddCommand2List(StartAddr: string; cnt, fcode: integer);
    procedure AddCommand2List_WriteRegs;
    procedure MakeCommand;

    procedure MakeDataASCII(RecvData: string);
    procedure MakeDataASCIIWago(RecvData: string);
    procedure MakeDataRTU(ASlaveNo, ADataMode: integer);
    procedure MakeDataRTU4WriteFunc(ASlaveNo, ADataMode, AFuncNo, AByteCount: integer);
    procedure MakeDataTCPWago;
    procedure MakeDataTCP(AEngName: string);

    //Simulate Function
    procedure MakeDataRTU4Simulate;
    procedure MakeDataTCP4Simulate;

    procedure DisplayMessage(msg: string; IsSend: Boolean);
    function GetModBusBlock(aIndex: integer): TModBusBlock;

    procedure LoadConfigDataini2Form(ConfigForm:TModbusConfigF);
    procedure LoadConfigDataini2Var;
    procedure SaveConfigDataForm2ini(ConfigForm:TModbusConfigF);
    procedure SetConfigData;
    procedure SetConfigComm;
    function LoadDLL4TCPWago: Boolean; //MBT.dll file load check = load OK: true
    function MakeModbusTCPWago:Boolean;
    function MakeModbusTCP:Boolean;

    procedure TruncByte(AIndex: integer);
    procedure DisplayRecvForm;
    procedure DisplaySingleValue;
    procedure SendData2MQ(AMsg: string);
    //FSendCommandList�� ���� BlockNo�� ���۵Ǵ� Param Item Index�� ��ȯ��
    function GetStartItemIndexFromBlockNo(ABlockNo: integer): integer;
    function GetValueFromAddress(var ADesc: string; AFCode, AAddress: string; ABlockNo: integer=-1): string;
  published
    property FilePath: string read FFilePath;
    property StrBuf: string read FRecvStrBuf write FRecvStrBuf;
    property CurrentCommandIndex: integer read FCurrentCommandIndex write SetCurrentCommandIndex;
    property ModBusMode: TModBusMode read FModBusMode write SetModBusMode;
  end;

var
  ModbusComF: TModbusComF;

implementation

uses ModbusConsts, IPC_LBX_Const, IPC_WT1600_Const, IPC_ECS_kumo_Const, IPC_MEXA7000_Const,
  IPC_MT210_Const, IPC_DYNAMO_Const, IPC_ECS_AVAT_Const, IPC_GasCalc_Const,
  IPC_Kral_Const, IPC_ECS_Woodward_Const, IPC_PLC_S7_Const, IPC_FlowMeter_Const,
  IPC_EngineParam_Const, IPC_HIC_Const, IPC_Modbus_Standard_Const;

{$R *.dfm}

procedure TModbusComF.FormCreate(Sender: TObject);
begin
  InitVar;
end;

procedure TModbusComF.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  if Assigned(FPJHTimerPool) then
  begin
    FPJHTimerPool.RemoveAll;
    FreeAndNil(FPJHTimerPool);
  end;

  if Assigned(FpjhSTOMPClass) then
    FpjhSTOMPClass.Free;

  TrayIcon1.Visible := False;
  SendMessage(FLauncherHandle, WM_COPYDATA, WParam_FORMCLOSE, 0);

  ObjFree(FModBusBlockList);
  FModBusBlockList.free;

  //FIPCClient.Free;
  FIPCClientAll.Free;
  //FWriteCommandList.Free;

  if (FModBusMode = MODBUSTCP_MODE) then
  begin
    for i := 0 to FSendCommandList.Count - 1 do
      TModbusTCP_Command(FSendCommandList.Objects[i]).Free;
  end
  else
    FSendCommandList.Free;

  FRecvByteBuf.Free;
  FCriticalSection.Free;
  //FEventHandle.Free;
  FModBusComThread.CommPort := nil;
  FComport.Free;
  if FModBusComThread.Suspended then
    FModBusComThread.Resume;

  FModBusComThread.FEventHandle.Signal;
  FModBusComThread.Terminate;

  //FModBusComThread.Free;

  if Assigned(FModBusTCPWagoThread) then
  begin
    if FModBusTCPWagoThread.Suspended then
      FModBusTCPWagoThread.Resume;

    FModBusTCPWagoThread.Terminate;
    FModBusTCPWagoThread.FEventHandle.Signal;

    FModBusTCPWagoThread.Free;

    if FMBTDLLHandle <> 0 then begin
      FreeLibrary(FMBTDLLHandle);
      FMBTDLLHandle := 0;
    end;
  end;

  if Assigned(FModBusTCPThread) then
  begin
    if FModBusTCPThread.Suspended then
      FModBusTCPThread.Resume;

    FModBusTCPThread.Terminate;
    FModBusTCPThread.FEventHandle.Signal;

    FModBusTCPThread.Free;
  end;

  FreeAndNil(FEngineParameter);
  FNetworkAdapterList.Free;
end;

function TModbusComF.InitComport: Boolean;
begin
  Result := False;
  SetCurrentDir(FilePath);

  FModBusComThread.SetModbusMode(ModBusMode);
  FModBusComThread.StopComm := not FModBusComThread.StopComm;

  with FComport do
  begin
    if Connected then
    begin
      Close;
      exit;
    end;

    FlowControl.ControlDTR := dtrEnable;
    OnRxChar := FModBusComThread.OnReceiveChar;
    FModBusComThread.FQueryInterval := FQueryInterval;
    LoadSettings(FStoreType, FilePath+FIniFileName);
    StatusBar1.Panels[0].Text := Port;
    StatusBar1.Panels[2].Text := BaudRateToStr(BaudRate)+','+
        DataBitsToStr(DataBits)+','+StopBitsToStr(StopBits)+','+ParityToStr(Parity.Bits);
    StatusBar1.Panels[1].Text := FSharedMemName;
    Result := True;
  end;//with
end;

procedure TModbusComF.InitVar;
begin
  FFirst := True;
  FIsSimulate := False;
  FErrCnt := 0;
  FStoreType := stIniFile;
  FFilePath := ExtractFilePath(Application.ExeName); //�ǳ��� '\' ���Ե�
  FMBTDLLHandle := 0;
  FIniFileName := ChangeFileExt(ExtractFileName(Application.ExeName), '.ini');
  FSaveFileName := ChangeFileExt(ExtractFileName(Application.ExeName), '_save.ini');

  FPJHTimerPool := TPJHTimerPool.Create(nil);

  //LoadConfigDataini2Var�Լ� ���� ���� ���� �Ǿ�� ��.
  FNetworkAdapterList := TNetworkAdapterCollect.Create(TNetworkAdapterItem);
  GetWin32_NetworkAdapterConfigurationInfo(FNetworkAdapterList);

  LoadConfigDataini2Var;

  FModBusBlockList := DList.Create;
  //FIPCClient := TIPCClient<TEventDataRecord>.Create(FSharedMemName, HIC_EVENT_NAME, True);
  FIPCClientAll := TIPCClientAll.Create;

  FIPCMonitor := TIPCMonitor<TConfigData_ModbusComm>.Create(FSharedMemName, MODBUSCOMM_EVENT_NAME, True);
  FIPCMonitor.FIPCObject.OnSignal := WriteComm_OnSignal;
  FIPCMonitor.FreeOnTerminate := True;
  FIPCMonitor.Resume;

  //ShowMessage(IntToStr(FIPCClient.SharedMemSize));
  FSendCommandList := TStringList.Create;
  //FWriteCommandList := TStringList.Create;
  FRecvByteBuf := TByteArray2.Create(0);
  //FEventHandle := TEvent.Create('',False);
  //FModBusMode := ASCII_MODE;
  FCriticalSection := TCriticalSection.Create;
  FComport := TComport.Create(nil);
//  SetDefaultComport;
  FComport.Name := '';
  FComport.SyncMethod := smWindowSync;

  FModBusComThread := TModBusComThread.Create(Self,1000);
  FModBusComThread.FreeOnTerminate := True;
  FModBusComThread.CommPort := FComport;
  FModBusComThread.StopComm := True;

  FEngineParameter := TEngineParameter.Create(Self);

  ReadMapFile;

  if ModbusMode = TCP_WAGO_MODE then
  begin
    FModBusTCPWagoThread := nil;
    MakeModbusTCPWago;
  end
  else
  if (ModbusMode = MODBUSTCP_MODE) or (ModbusMode = MODBUSSERIAL_TCP_MODE) then
  begin
    MakeModbusTCP;
  end;
end;

procedure TModbusComF.MakeCommand;
var pModbusBlock: TModbusBlock;
    it: DIterator;
    tmpstr: string;
begin
  if (FModBusMode = ASCII_MODE) or (FModBusMode = RTU_MODE) then
    FModBusComThread.FSendCommandList.Clear
  else if (FModBusMode = MODBUSTCP_MODE) or (FModBusMode = MODBUSSERIAL_TCP_MODE) then
    FModBusTCPThread.FSendCommandList.Clear
  else if FModBusMode = TCP_WAGO_MODE then
    FModBusTCPWagoThread.FSendCommandList.Clear;

  FSendCommandList.Clear;

  case FModBusMode of
    ASCII_MODE:
      tmpstr := '(ASCII Mode)';
    RTU_MODE:
      tmpstr := '(RTU Mode)';
    TCP_WAGO_MODE:
      tmpstr := '(TCP-Wago Mode)';
    MODBUSTCP_MODE:
      tmpstr := '(ModbusTCP Mode)';
    MODBUSSERIAL_TCP_MODE:
      tmpstr := '(ModbusSerial->TCP Mode)';
  end;//case

  DisplayMessage('===================================', True);
  DisplayMessage('            COMMAND LIST' + tmpstr, True);
  DisplayMessage('===================================', True);

  it := FModBusBlockList.start;

  while not atEnd(it) do
  begin
    pModbusBlock := GetObject(it) as TModbusBlock;

    AddCommand2List(pModbusBlock.FStartAddr, pModbusBlock.FCount, pModbusBlock.FFunctionCode);
    Advance(it);
  end;//while

  DisplayMessage('===================================', True);

  if (FModBusMode = ASCII_MODE) or (FModBusMode = RTU_MODE) then
  begin
    FModBusComThread.FSendCommandList.Assign(FSendCommandList);
    //FModBusComThread.FWriteCommandList.Assign(FWriteCommandList);
  end
  else if (FModBusMode = MODBUSTCP_MODE) or (FModBusMode = MODBUSSERIAL_TCP_MODE) then
    FModBusTCPThread.FSendCommandList.Assign(FSendCommandList)
  else if FModBusMode = TCP_WAGO_MODE then
    FModBusTCPWagoThread.FSendCommandList.Assign(FSendCommandList);
end;

//(XAxis Data, Value Data) ������ �����
procedure TModbusComF.MakeCommand4ScalarValue(var AValue: string);
var
  i: integer;
  LNumOfData: integer;
begin
  with FWriteCommData do
  begin
    if ModBusFunctionCode = mbfWriteRegs then //WriteRegisters(16 = $10)
    begin
      LNumOfData := 1;
      AValue := AValue + Format('%.2x%.2x', [hi(LNumOfData), lo(LNumOfData)]);
      LNumOfData := LNumOfData * 2;
      AValue := AValue + Format('%.2x', [LNumOfData]);
      AValue := AValue + Format('%.2x%.2x', [hi(DataBuf[0]), lo(DataBuf[0])]);
    end;
  end;//with
end;

procedure TModbusComF.MakeCommand4Write1(var AValue: string);
var
  i: integer;
  LNumOfData: integer;
begin
  with FWriteCommData do
  begin
    if ModBusFunctionCode = mbfWriteRegs then //WriteRegisters(16 = $10)
    begin
      LNumOfData := NumOfData * 2;
      AValue := AValue + Format('%.2x%.2x', [hi(LNumOfData), lo(LNumOfData)]);
      LNumOfData := LNumOfData * 2;
      AValue := AValue + Format('%.2x', [LNumOfData]);

      for i := 0 to NumOfData_X - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(XAxisData[i]), lo(XAxisData[i])]);

      for i := 0 to NumOfData - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(DataBuf[i]), lo(DataBuf[i])]);
    end;
  end;//with
end;

//(XAxis Data, YAxis Data, Value Data) ������ �����
procedure TModbusComF.MakeCommand4Write2(var AValue: string);
var
  i,j,LNumOfData: integer;
begin
  with FWriteCommData do
  begin
    if ModBusFunctionCode = mbfWriteRegs then //WriteRegisters(16 = $10)
    begin
      LNumOfData := NumOfData_X + NumOfData_Y + NumOfData;
      AValue := AValue + Format('%.2x%.2x', [hi(LNumOfData), lo(LNumOfData)]);
      LNumOfData := LNumOfData * 2;
      AValue := AValue + Format('%.2x', [LNumOfData]);

      for i := 0 to NumOfData_X - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(XAxisData[i]), lo(XAxisData[i])]);

      for i := 0 to NumOfData_Y - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(YAxisData[i]), lo(YAxisData[i])]);

      for i := 0 to NumOfData - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(DataBuf[i]), lo(DataBuf[i])]);
    end;
  end;//with
end;

//(XAxis Data, YAxis Data, ZAxis Data, Value Data) ������ �����
procedure TModbusComF.MakeCommand4Write3(var AValue: string);
var
  i,j,k,LNumOfData: integer;
begin
  with FWriteCommData do
  begin
    if ModBusFunctionCode = mbfWriteRegs then //WriteRegisters(16 = $10)
    begin
      LNumOfData := NumOfData_X + NumOfData_Y + NumOfData_Z + NumOfData;
      AValue := AValue + Format('%.2x%.2x', [hi(LNumOfData), lo(LNumOfData)]);
      LNumOfData := LNumOfData * 2;
      AValue := AValue + Format('%.2x', [LNumOfData]);

      for i := 0 to NumOfData_X - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(XAxisData[i]), lo(XAxisData[i])]);

      for i := 0 to NumOfData_Y - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(YAxisData[i]), lo(YAxisData[i])]);

      for i := 0 to NumOfData_Z - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(ZAxisData[i]), lo(ZAxisData[i])]);

      for i := 0 to NumOfData - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(DataBuf[i]), lo(DataBuf[i])]);
    end;
  end;//with
end;

//array[0..255] of single
procedure TModbusComF.MakeCommand4Write4(var AValue: string);
var
  i,j,LNumOfData: integer;
  LSr: TSingleRec;
begin
  with FWriteCommData do
  begin
    if ModBusFunctionCode = mbfWriteRegs then //WriteRegisters(16 = $10)
    begin
      LNumOfData := NumOfData * 2;
      AValue := AValue + Format('%.2x%.2x', [hi(LNumOfData), lo(LNumOfData)]);
      LNumOfData := LNumOfData * 2;
      AValue := AValue + Format('%.2x', [LNumOfData]);

      for i := 0 to NumOfData_X - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(XAxisData[i]), lo(XAxisData[i])]);

      for i := 0 to NumOfData - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(DataBuf[i]), lo(DataBuf[i])]);
    end;
  end;//with
end;

//array[0..255] of array[0..255] of single
procedure TModbusComF.MakeCommand4Write5(var AValue: string);
var
  i,j,k,LNumOfData: integer;
  LSr: TSingleRec;
begin
  with FWriteCommData do
  begin
    if ModBusFunctionCode = mbfWriteRegs then //WriteRegisters(16 = $10)
    begin
      LNumOfData := NumOfData_X + NumOfData_Y + NumOfData;
      AValue := AValue + Format('%.2x%.2x', [hi(LNumOfData), lo(LNumOfData)]);
      LNumOfData := LNumOfData * 2;
      AValue := AValue + Format('%.2x', [LNumOfData]);

      for i := 0 to NumOfData_X - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(XAxisData[i]), lo(XAxisData[i])]);

      for i := 0 to NumOfData_Y - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(YAxisData[i]), lo(YAxisData[i])]);

      for i := 0 to NumOfData - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(DataBuf[i]), lo(DataBuf[i])]);
    end;
  end;//with
end;

//array[0..255] of array[0..255] of array[0..255] of single
procedure TModbusComF.MakeCommand4Write6(var AValue: string);
var
  i,j,k,n,LNumOfData: integer;
  LSr: TSingleRec;
begin
  with FWriteCommData do
  begin
    if ModBusFunctionCode = mbfWriteRegs then //WriteRegisters(16 = $10)
    begin
      LNumOfData := NumOfData_X + NumOfData_Y + NumOfData_Z + NumOfData;
      AValue := AValue + Format('%.2x%.2x', [hi(LNumOfData), lo(LNumOfData)]);
      LNumOfData := LNumOfData * 2;
      AValue := AValue + Format('%.2x', [LNumOfData]);

      for i := 0 to NumOfData_X - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(XAxisData[i]), lo(XAxisData[i])]);

      for i := 0 to NumOfData_Y - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(YAxisData[i]), lo(YAxisData[i])]);

      for i := 0 to NumOfData_Z - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(ZAxisData[i]), lo(ZAxisData[i])]);

      for i := 0 to NumOfData - 1 do
        AValue := AValue + Format('%.2x%.2x',
                          [hi(DataBuf[i]), lo(DataBuf[i])]);
    end;
  end;//with
end;

procedure TModbusComF.ReadMapAddressFromParamFile(AFilename: string;
  AModBusBlockList: DList);
var
  i, LPrevBlockNo, LCount: integer;
  LIndex: integer;
  LStartAddr, LPrevAddr:string;
  LBlockNo,
  LFuncCode,
  LParamType: integer;
  LAlarm: Boolean;
  LEngParamList: RawUtf8;
begin
  if not FileExists(AFilename) then
  begin
    ShowMessage(AFilename + ' file is not exist');
    exit;
  end;

  FEngineParameter.EngineParameterCollect.Clear;

  if FEngParamFileFormat = 1 then //JSON
    FEngineParameter.LoadFromJSONFile(AFilename,
                                    ExtractFileName(AFilename),
                                    FEngParamEncrypt)
  else
  if FEngParamFileFormat = 2 then //Sqlite
  begin
    InitEngineParamClient(AFilename);
    //ParamNo�� ���� ����Ÿ(Modbus Data)�� ������
    LEngParamList := GetEngParamList2JSONArrayFromAddress;
    FEngineParameter.LoadFromJSONArray(LEngParamList);
  end;

  AModBusBlockList.clear;

  LPrevBlockNo := -1;
  LCount := 0;
  LIndex := 0;//���� Offset index ����

  if FEngineParameter.EngineParameterCollect.count > 0 then
  begin
    FIPCClientAll.FProjNo := FEngineParameter.EngineParameterCollect.Items[0].ProjNo;
    FIPCClientAll.FEngNo := FEngineParameter.EngineParameterCollect.Items[0].EngNo;
  end;

  for i := 0 to FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    //stConfig�� �ǳ� ��
    if (FEngineParameter.EngineParameterCollect.Items[i].SensorType = stConfig) and
      (FEngineParameter.EngineParameterCollect.Items[i].IsMatrixData) then
      continue;

    if (FEngineParameter.EngineParameterCollect.Items[i].SensorType = stCalculated) and
      (FEngineParameter.EngineParameterCollect.Items[i].ParameterSource = psManualInput) then
      continue;

    if (FEngineParameter.EngineParameterCollect.Items[i].SensorType = stParam) then
      continue;
//�ӽ� ��ƾ
//    if (FEngineParameter.EngineParameterCollect.Items[i].BlockNo <> 10) then
//      continue;

    if LPrevBlockNo = FEngineParameter.EngineParameterCollect.Items[i].BlockNo then
    begin
      if (LPrevBlockNo <> -1) then
        if (LPrevAddr <> FEngineParameter.EngineParameterCollect.Items[i].Address) then
        begin
          inc(LCount);
          LPrevAddr := FEngineParameter.EngineParameterCollect.Items[i].Address;
        end;
    end
    else
    begin
      if( LCount > 0) and
        (FEngineParameter.EngineParameterCollect.Items[i-1].BlockNo > 0) then
      begin
        FModBusBlock := TModbusBlock.Create;

        With FModBusBlock do
        begin
          //BlockNo�� ���ϴ� ������ �˻� �� ���ϴ°� ���� ������ ����(i-1)
          FStartAddr := LStartAddr;
          FCount := LCount;
          FBlockNo := LBlockNo;
          FFunctionCode := LFuncCode;
          FParamType := LParamType;
          FAlarm := LAlarm;
        end;

        AModBusBlockList.Add([FModBusBlock]);

        LCount := 1;
      end
      else
        inc(LCount);

      if LCount = 1 then
      begin
        FParamSource := FEngineParameter.EngineParameterCollect.Items[i].ParameterSource; //SharedName2ParameterSource(FEngineParameter.EngineParameterCollect.Items[i-1].SharedName);
        LStartAddr := FEngineParameter.EngineParameterCollect.Items[i].Address;
        LBlockNo := FEngineParameter.EngineParameterCollect.Items[i].BlockNo;
        LFuncCode := StrToIntDef(FEngineParameter.EngineParameterCollect.Items[i].FCode,0);
        LParamType := Ord(FEngineParameter.EngineParameterCollect.Items[i].ParameterType);
        LAlarm := FEngineParameter.EngineParameterCollect.Items[i].Alarm;
      end;

      LPrevBlockNo := FEngineParameter.EngineParameterCollect.Items[i].BlockNo;
      LPrevAddr := FEngineParameter.EngineParameterCollect.Items[i].Address;
    end;

  end;//for

  if( LCount > 0) and
    (FEngineParameter.EngineParameterCollect.Items[i-1].BlockNo > 0) then
  begin
    FModBusBlock := TModbusBlock.Create;

    With FModBusBlock do
    begin
      FCount := LCount;
      if LCount = 1 then
      begin
        FStartAddr := FEngineParameter.EngineParameterCollect.Items[i-1].Address;
        FBlockNo := FEngineParameter.EngineParameterCollect.Items[i-1].BlockNo;
        FFunctionCode := StrToIntDef(FEngineParameter.EngineParameterCollect.Items[i-1].FCode,0);
        FParamType := Ord(FEngineParameter.EngineParameterCollect.Items[i-1].ParameterType);
        FAlarm := FEngineParameter.EngineParameterCollect.Items[i-1].Alarm;
      end
      else
      begin
        FStartAddr := LStartAddr;
        FBlockNo := LBlockNo;
        FFunctionCode := LFuncCode;
        FParamType := LParamType;
        FAlarm := LAlarm;
      end;
    end;//with

    AModBusBlockList.Add([FModBusBlock]);
  end;
end;

procedure TModbusComF.ReadMapAddressFromParamFileUsingTStrings(
  AFilename: string; AModBusBlockList: DList);
var
  i, LIdx: integer;
  LBlockNo:string;
  LEngParamList: RawUtf8;
  LStrList: TStringList;
  LModBusBlock : TModbusBlock;
begin
  if not FileExists(AFilename) then
  begin
    ShowMessage(AFilename + ' file is not exist');
    exit;
  end;

  LStrList := TStringList.Create;

  try
    FEngineParameter.EngineParameterCollect.Clear;

    if FEngParamFileFormat = 1 then //JSON
      FEngineParameter.LoadFromJSONFile(AFilename,
                                      ExtractFileName(AFilename),
                                      FEngParamEncrypt)
    else
    if FEngParamFileFormat = 2 then //Sqlite
    begin
      InitEngineParamClient(AFilename);
      //ParamNo�� ���� ����Ÿ(Modbus Data)�� ������
      LEngParamList := GetEngParamList2JSONArrayFromAddress;
      FEngineParameter.LoadFromJSONArray(LEngParamList);
    end;

    AModBusBlockList.clear;

    if FEngineParameter.EngineParameterCollect.count > 0 then
    begin
      FIPCClientAll.FProjNo := FEngineParameter.EngineParameterCollect.Items[0].ProjNo;
      FIPCClientAll.FEngNo := FEngineParameter.EngineParameterCollect.Items[0].EngNo;
    end;

    for i := 0 to FEngineParameter.EngineParameterCollect.Count - 1 do
    begin
      //stConfig�� �ǳ� ��
//      if (FEngineParameter.EngineParameterCollect.Items[i].SensorType = stConfig) and
//        (FEngineParameter.EngineParameterCollect.Items[i].IsMatrixData) then
//        continue;
//
//      if (FEngineParameter.EngineParameterCollect.Items[i].SensorType = stCalculated) and
//        (FEngineParameter.EngineParameterCollect.Items[i].ParameterSource = psManualInput) then
//        continue;
//
//      if (FEngineParameter.EngineParameterCollect.Items[i].SensorType = stParam) then
//        continue;

      if (FEngineParameter.EngineParameterCollect.Items[i].Address = '') then
        continue;

      LBlockNo := IntToStr(FEngineParameter.EngineParameterCollect.Items[i].BlockNo);
      LIdx := LStrList.IndexOf(LBlockNo);

      if LIdx < 0 then
      begin
        LModBusBlock := TModbusBlock.Create;

        With LModBusBlock do
        begin
          //BlockNo�� ���ϴ� ������ �˻� �� ���ϴ°� ���� ������ ����(i-1)
          FStartAddr := FEngineParameter.EngineParameterCollect.Items[i].Address;
          FCount := 1;
          FBlockNo := FEngineParameter.EngineParameterCollect.Items[i].BlockNo;
          FFunctionCode := StrToIntDef(FEngineParameter.EngineParameterCollect.Items[i].FCode,0);
          FParamType := Ord(FEngineParameter.EngineParameterCollect.Items[i].ParameterType);
          FAlarm := FEngineParameter.EngineParameterCollect.Items[i].Alarm;
        end;

        LStrList.AddObject(LBlockNo, LModBusBlock);
      end
      else
      begin
        LModBusBlock := LStrList.Objects[LIdx] as TModbusBlock;
        LModBusBlock.FCount := LModBusBlock.FCount + 1;
      end;
    end;//for

    for i := 0 to LStrList.Count - 1 do
    begin
      LModBusBlock := LStrList.Objects[i] as TModbusBlock;
      AModBusBlockList.Add([LModBusBlock]);
    end;
  finally
    LStrList.Free;
  end;
end;

procedure TModbusComF.ReadMapFile;
begin
  FModBusComThread.TimeOut := FTimeOut;

  if not FFirst then
  begin
//    ReadMapAddress(FMapFileName,FModBusBlockList);
    MakeCommand;
  end;

  if (ModbusMode = ASCII_MODE) or (ModbusMode = RTU_MODE) then
    if FileExists(FilePath+FIniFileName) then
      FComport.LoadSettings(FStoreType, FilePath + FIniFileName);
end;

procedure TModbusComF.AddCommand2List(StartAddr: string; cnt, fcode: integer);
var
  SendBuff: string;
  tmpStr: string;
  iAddr: integer;
  lrc: Byte;
  crc16: word;
  SendLength: integer;
  ModbusTCP_Command: TModbusTCP_Command;
  i, itemp: integer;
begin
  if (FIPCClientAll.FEngineParameter.EngineParameterCollect.Items[0].ParameterSource = psECS_kumo) or
    (FIPCClientAll.FEngineParameter.EngineParameterCollect.Items[0].ParameterSource = psFlowMeterKral) then
    i := 0
  else
    i := -1;

  itemp := Str2Hex_Int(StartAddr);

  if itemp = -1 then
  begin
    ShowMessage('Start Address is null!');
    exit;
  end;

  iAddr := iTemp - FBaseAddress;// + i;

  SendBuff := Format('%.2x%.2x%.2x%.2x%.2x%.2x',
                    [FSlaveNo,FCode,(iAddr shr 8) and $FF,iAddr and $FF,
                        (cnt shr 8) and $FF,cnt and $FF]);

  if (ModbusMode = ASCII_MODE) or (ModbusMode = TCP_WAGO_MODE) then
  begin
    SendBuff := ':' + SendBuff;
    tmpStr := Copy(SendBuff,2,12);
    lrc := Update_LRC(tmpStr, Length(tmpStr));
    SendBuff := SendBuff + Format('%.2x',[lrc]) + #13#10;
  end
  else
  if ModbusMode = RTU_MODE then
  begin
    tmpStr := SendBuff;
    crc16 := CalcCRC16_2(tmpStr);
    SendBuff := SendBuff + Format('%.4x', [crc16]);
  end;

  if (FModBusMode = MODBUSTCP_MODE) or (FModBusMode = MODBUSSERIAL_TCP_MODE) then
  begin
    ModbusTCP_Command := TModbusTCP_Command.Create;
    ModbusTCP_Command.FSlaveAddress := FSlaveNo;
    ModbusTCP_Command.FFunctionCode := FCode;
    ModbusTCP_Command.FStartAddress := iAddr;
    ModbusTCP_Command.FParamIndex := FEngineParameter.EngineParameterCollect.GetItemIndexFromAddress(IntToStr(FCode), StartAddr);
    ModbusTCP_Command.FBlockNo := FEngineParameter.EngineParameterCollect.Items[ModbusTCP_Command.FParamIndex].BlockNo;
    ModbusTCP_Command.FDataCountWord := cnt;

    if FModBusMode = MODBUSSERIAL_TCP_MODE then
    begin
      tmpStr := SendBuff;
      crc16 := CalcCRC16_2(tmpStr);
      SendBuff := SendBuff + Format('%.4x', [crc16]);
    end;

    FSendCommandList.AddObject(SendBuff, ModbusTCP_Command);
  end
  else
    FSendCommandList.Add(SendBuff);

  DisplayMessage('(' + IntToStr(FSendCommandList.Count) + ') ' + SendBuff, True);
end;

procedure TModbusComF.AddCommand2List_WriteRegs;
var
  ModbusTCP_Command: TModbusTCP_Command;
  i: integer;
  iAddr: integer;
  SendBuff: string;
begin
  iAddr := Str2Hex_Int(FWriteCommData.ModBusAddress) - FBaseAddress;//$5000;
  SendBuff := Format('%.2x%.2x%.2x%.2x%.2x%.2x',
                    [FWriteCommData.SlaveNo, FWriteCommData.ModBusFunctionCode,
                      (iAddr shr 8) and $FF,iAddr and $FF,
                        (FWriteCommData.NumOfData shr 8) and $FF,
                        FWriteCommData.NumOfData and $FF]);

  if FWriteCommData.ModbusMode = Ord(MODBUSTCP_MODE) then
  begin
    ModbusTCP_Command := TModbusTCP_Command.Create;
    ModbusTCP_Command.FFunctionCode := FWriteCommData.ModBusFunctionCode;
    ModbusTCP_Command.FStartAddress := iAddr;
    ModbusTCP_Command.FDataCountWord := FWriteCommData.NumOfData;

    if FWriteCommData.ModBusFunctionCode = mbfWriteRegs then //WriteRegisters(16 = $10)
    begin
      ModbusTCP_Command.FRepeatCount := 1;
      SetLength(ModbusTCP_Command.FBufferWord, Length(FWriteCommData.DataBuf));
      for i := Low(FWriteCommData.DataBuf) to High(FWriteCommData.DataBuf) do
        ModbusTCP_Command.FBufferWord[i] := FWriteCommData.DataBuf[i];
    end;

    FSendCommandList.AddObject(SendBuff, ModbusTCP_Command);
  end
end;

procedure TModbusComF.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;

//  { Show the animated tray icon and also a hint balloon. }
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

procedure TModbusComF.WMReceiveString(var Message: TMessage);
var
  TmpStr, TmpRecvStr: string;
  i, j, LengthStr: integer;
begin  //CRLF�� ������ �����忡�� �� �Լ��� �Ѿ���� ����
  FCriticalSection.Enter;
  try

  LengthStr := Length(FRecvStrBuf);
  if LengthStr > 7 then //�⺻ packet�� byte count �̻� �������� Ȯ��
  begin
    if FRecvStrBuf[1] <> ':' then //ù���ڰ� ':'�� �ƴϸ� Invalid format
    begin
      DisplayMessage(FRecvStrBuf+' ==> ù���ڰ� ":"�� �ƴ�', False);
      FRecvStrBuf := '';
      exit;
    end;

    TmpStr := FRecvStrBuf[6] + FRecvStrBuf[7]; //Data�κ� Byte Size
    if TmpStr = '' then //Byte Count Field�� ������ Dead Packet
    begin
      DisplayMessage(FRecvStrBuf+' ==> Byte Count Field�� ����(6,7��°)', False);
      FRecvStrBuf := '';
      exit;
    end;

    i := HexToInt(TmpStr) * 2; //ASCII Mode������ ����Ÿ 1���� 2Byte�� �Ҵ��(?)
    if LengthStr >= i + 9 then //header(7)+lrc(2byte)����,  crlf(2byte)�� Length�� ��ȯ������ ���ܵ�
    begin
      tmpStr := '';
      j := 0;
      //�ΰ� �̻��� Response�� �Ѳ�����  ���ŵ� ��� ������ ':'�� �����Ͽ� ��� ó����
      j := NextPos2(':', FRecvStrBuf, 2);
      if j > 0 then
      begin
        tmpStr := Copy(FRecvStrBuf, j - 1, Length(FRecvStrBuf) - j);
        FRecvStrBuf := Copy(FRecvStrBuf, 1, j - 2) + #13#10;
      end;

      TmpRecvStr := FRecvStrBuf;
      FRecvStrBuf := tmpStr;              //Buffer �ʱ�ȭ


      DisplayMessage(TmpRecvStr, False);
      MakeDataASCII(TmpRecvStr);
    end;
  end
  else
    ;//FStrBuf := '';

  //FEventHandle.Signal;
  finally
    FCriticalSection.Leave;
  end;//try
end;

procedure TModbusComF.WMReceiveByte(var Message: TMessage);
var
  i, SN, FC, LByteCount: integer;
  TempByteBuf: TByteArray2;
begin
  while true do
  begin
    //RTU Mode������ CRLF�� ����
    if FRecvByteBuf.Size > 5 then //�⺻ packet�� byte count �̻� �������� Ȯ��
    begin
      //ù����Ÿ�� ��û�ߴ� Slave No�� �ƴϸ� Invalid format
      if (FRecvByteBuf.Items[0] <> FSlaveNo) then
      begin
        i := FRecvByteBuf.PosNext(FSlaveNo);
        if i > 0 then
        begin
          TruncByte(i);
          Continue;
        end;//if

        DisplayMessage(FRecvByteBuf.CopyToString(0,FRecvByteBuf.Size) + #13#10 +
                        ' ==> ù ����Ÿ�� ��ȿ�� Slave No�� �ƴ�('+
                        IntToStr(FSlaveNo)+')', False);
        FRecvByteBuf.Clear;
        exit;
      end;

      SN := FRecvByteBuf.Items[0];
      FC := FRecvByteBuf.Items[1];

      //if FC = 16 then
      //begin
      //  LByteCount := (FRecvByteBuf.Items[4] shl 8) and $FF00;
      //  LByteCount := LByteCount + FRecvByteBuf.Items[5];
      //end
      //else
        LByteCount := FRecvByteBuf.Items[2];

      if LByteCount <= 0 then //����Ÿ Count <= 0
      begin
        DisplayMessage(FRecvByteBuf.CopyToString(0,FRecvByteBuf.Size) + #13#10 +
                        ' ==> Byte Count Field �̻�(3��° Field)', False);
        FRecvByteBuf.Clear;
        exit;
      end;

      //Data Count + header(3byte)+crc(2byte)����,  RTU Mode������ CRLF�� ����
      if FRecvByteBuf.Size >= FRecvByteBuf.Items[2] + 5 then
      begin
        TempByteBuf := nil;

        //�ΰ� �̻��� Response�� �Ѳ�����  ���ŵ� ��� ������ SlaveNo,Function Code�� �����Ͽ� ��� ó����
        i := FRecvByteBuf.PosNext(SN,FRecvByteBuf.Items[2] + 5);
        if i > 0 then  //�Ǵٸ� FSlaveNo�� �����ϴ� ���
        begin
          if FRecvByteBuf.Items[i + 1] = FC then
          begin
            TempByteBuf := TByteArray2.Create(0);
            TempByteBuf.CopyByteArray(FRecvByteBuf, i, FRecvByteBuf.Size - i);
          end;
        end;

        DisplayMessage(FRecvByteBuf.CopyToString(0,FRecvByteBuf.Size), False);

        //if FC = 16 then
        //  MakeDataRTU4WriteFunc(SN, Message.WParam, FC, LByteCount)
        //else
          MakeDataRTU(SN, Message.WParam);
        //FRecvByteBuf.Clear;

        if Assigned(TempByteBuf) then
        begin
          FRecvByteBuf.CopyByteArray(TempByteBuf, 0, TempByteBuf.Size);
          TempByteBuf.Free;
          TempByteBuf := nil;
          continue;
        end
        else
          break;
      end
      else//���� �ϼ����� ���� ��Ŷ
        break;
    end
    else
      break;
  end;//while
end;

//Response = Function Code(1byte), Starting Address(2byte), Quantity of Registers(2byte)
//                (0x10                     0x0000                 0x0000)
procedure TModbusComF.WMReceiveByte4Write(var Message: TMessage);
var
  i, SN, FC, iAddr, iAddr2, Lcount: integer;
  LStr: string;
begin
  //FModBusComThread.FEventHandle.Signal;
  while true do
  begin
    if FRecvByteBuf.Size >= 8 then //�⺻ packet�� byte count �̻� �������� Ȯ��
    begin
      //ù����Ÿ�� ��û�ߴ� Slave No�� �ƴϸ� Invalid format
      if (FRecvByteBuf.Items[0] <> FSlaveNo) then
      begin
        i := FRecvByteBuf.PosNext(FSlaveNo);
        if i > 0 then
        begin
          TruncByte(i);
          Continue;
        end;//if

        DisplayMessage(FRecvByteBuf.CopyToString(0,FRecvByteBuf.Size) + #13#10 +
                        ' ==> ù ����Ÿ�� ��ȿ�� Slave No�� �ƴ�('+
                        IntToStr(FSlaveNo)+')', False);
        FRecvByteBuf.Clear;
        exit;
      end;

      SN := FRecvByteBuf.Items[0];
      FC := FRecvByteBuf.Items[1]; //0x10

      if FC = 16 then //0x10
      begin
        iAddr := Str2Hex_Int(FWriteCommData.ModBusAddress) - FBaseAddress - 1;//$5000;
        iAddr2 := (FRecvByteBuf.Items[2] shl 8) and $FF00; //Start Address Hi
        iAddr2 := iAddr2 + FRecvByteBuf.Items[3]; //Start Address Lo

        if iAddr = iAddr2 then
        begin
          Lcount := (FRecvByteBuf.Items[4] shl 8) and $FF00; //Quantity Hi
          Lcount := Lcount + FRecvByteBuf.Items[5]; //Quantity Lo

          if LCount = (FWriteCommData.NumOfData+FWriteCommData.NumOfData_X+FWriteCommData.NumOfData_Y+FWriteCommData.NumOfData_Z) then
          begin
            DisplayMessage(FRecvByteBuf.CopyToString(0,8), False);
            MakeDataRTU4WriteFunc(SN, Message.WParam, FC, Lcount);
          end
          else
          begin
            DisplayMessage(FRecvByteBuf.CopyToString(0,FRecvByteBuf.Size) + #13#10 +
                            ' ==> Byte Count Field �̻�(5��° Field)', False);
            FRecvByteBuf.Clear;
            exit;
          end;
        end;
      end;

{      if FRecvByteBuf.Items[2] <= 0 then //Start Address Hi
      begin
      end;
      if FRecvByteBuf.Items[3] <= 0 then //Start Address Lo
      begin
      end;
      if FRecvByteBuf.Items[4] <= 0 then //Quantity Hi
      begin
      end;
      if FRecvByteBuf.Items[5] <= 0 then //Quantity Lo
      begin
      end;
      if FRecvByteBuf.Items[6] <= 0 then //CRC Lo
      begin
      end;
      if FRecvByteBuf.Items[7] <= 0 then //CRC High
      begin
      end;
}
      break;
    end
    else
    if FRecvByteBuf.Size = 5 then //�⺻ packet�� byte count �̻� �������� Ȯ��
      break;
  end;//while
end;

//Matrix Data Read
procedure TModbusComF.WMReceiveByteConfigData(var Message: TMessage);
begin
  SendMessage(Handle,WM_RECEIVEBYTE, 1, 0);
end;

procedure TModbusComF.WMReceiveWordTCP(var Message: TMessage);
begin
  MakeDataTCP(FEngineName);
end;

procedure TModbusComF.WMReceiveWordTCPWago(var Message: TMessage);
begin
  MakeDataTCPWago;
end;

procedure TModbusComF.WriteComm_OnSignal(Data: TConfigData_ModbusComm);
begin
  //IPCClient�� Free �ɶ� pulsemonitor ����ǹǷ� �̸� ���ϱ� ����
  if Data.Termination then
  begin
    Data.Termination := False;
    exit;
  end;

  System.Move(Data, FWriteCommData, Sizeof(Data));
  SendMessage(Handle, WM_EVENT_WRITECOMM, 0,0);
end;

//������ ModBus Data���� LRC �� ����Ÿ �Ǽ��� �˻� �� �� ����Ÿ���� �����޸𸮿� ������
procedure TModbusComF.MakeDataASCII(RecvData: string);
var
  pModbusBlock: TModbusBlock;
  EventData: TEventData_Modbus_Standard;
  arydata: array[0..19] of char;
  pAryData: PChar;
  i, j, k, m, ByteCount: integer;
  lrc, tmpByte: Byte;
  tmpstr, tmpstr2, LStr: string;
begin
  tmpstr := '';
  tmpstr := RecvData[Length(RecvData) - 3] + RecvData[Length(RecvData) - 2];

  tmpstr2 := Copy(RecvData, 2, Length(RecvData) - 5);
  lrc := Update_LRC(tmpstr2, Length(tmpstr2));

  //LRC�� ��Ȯ���� Check
  if Str2Hex_Byte(tmpstr) = lrc then
  begin
    tmpstr := '';
    tmpstr := RecvData[6] + RecvData[7];//Byte Count ������
    ByteCount := Str2Hex_Byte(tmpstr);

    pModbusBlock := GetModBusBlock(FCurrentCommandIndex);
    if pModbusBlock <> nil then
    begin
      if (pModBusBlock.FFunctionCode = 1) or (pModBusBlock.FFunctionCode = 2) then
      begin
        j := (pModBusBlock.FCount div 8);
        if pModBusBlock.FCount mod 8 > 0 then
          Inc(j);
      end
      else
      begin
        //Byte Count�� Hi, Lo�� ���еǾ� ���� ������ ������ 2���� ���� ���� ����Ÿ ������
        ByteCount := ByteCount Div 2;
        j := pModBusBlock.FCount;
      end;

//      SetLength(EventData.InpDataBuf, 256);

      with EventData do
      begin
        ModBusFunctionCode := pModBusBlock.FFunctionCode;
        LStr := IntToStr(ModBusFunctionCode) + ',' + IntToStr(ByteCount);
        if (pModBusBlock.FFunctionCode = 1) or (pModBusBlock.FFunctionCode = 2) then
        begin
          //m := 0;
          for i := 0 to ByteCount - 1 do
          begin
            //�����޸𸮿� ���� ������
            tmpstr := RecvData[MODBUS_DATA_ASCII_START_HI_IDX + (i * 2)] +
                      RecvData[MODBUS_DATA_ASCII_START_HI_IDX + (i * 2) + 1];
            tmpByte := Str2Hex_Byte(tmpStr);

            if (i mod 2) = 0 then
              InpDataBuf[i div 2] := tmpByte shl 8
            else
              InpDataBuf[i div 2] := InpDataBuf[i div 2] + tmpByte;


(*            for k := 0 to 7 do
            begin
              if GetBitVal(tmpByte, k) = 0 then
                tmpstr := '0000'
              else
                tmpstr := 'FFFF';

              InpDataBuf[m] := Str2Hex_Int(tmpStr);
              inc(m);

              if m > pModBusBlock.FCount then
                break;
            end;//for
*)
            LStr := LStr + ',' + IntToStr(InpDataBuf[i]);
          end;//for
        end
        else
        begin
          for i := 0 to ByteCount - 1 do
          begin
            tmpstr := RecvData[MODBUS_DATA_ASCII_START_HI_IDX + (i * 4)] +
                      RecvData[MODBUS_DATA_ASCII_START_HI_IDX + (i * 4) + 1] +
                      RecvData[MODBUS_DATA_ASCII_START_LO_IDX + (i * 4)] +
                      RecvData[MODBUS_DATA_ASCII_START_LO_IDX + (i * 4) + 1];
            //�����޸𸮿� ���� ������
            InpDataBuf[i] := Str2Hex_Int(tmpStr);
            LStr := LStr + ',' + IntToStr(InpDataBuf[i]);
          end;//for
        end;

        NumOfData := ByteCount;
        ModBusMode := Ord(ASCII_MODE);

        //������ ����Ÿ���� �䱸�� ����Ÿ���� �ٸ��� exit
        if ByteCount <> j then//pModBusBlock.FCount
        begin
          DisplayMessage(RecvData +
                          ' ==> ������ ����Ÿ�� -> �䱸�� ����Ÿ���� �ٸ� (' +
                          IntToHex(ByteCount,2) +' -> '+ IntToHex(pModBusBlock.FCount,2)+ ')',
                                                      False);
          exit;
        end;//if

        ModBusAddress := pModBusBlock.FStartAddr;
        BlockNo := pModBusBlock.FBlockNo;
        EngineName := FEngineName;
      end;//with
    end//if
    else
    begin
      DisplayMessage('ModBusBlock�� ������ �� ����(' +
                        IntToStr(FCurrentCommandIndex) +')', False);
      exit;//startaddress�� �������� ���ϸ� exit
    end;

    if Assigned(FDisplayRecvF) then
      FDisplayRecvF.AddRowFromCSV(LStr);

    if FMQInfoRec.FIsEnableMQ then
    begin
      SendData2MQ(LStr);
      DisplayMessage('MQ Send: ' + FMQInfoRec.FIPAddr + ', Port: ' + FMQInfoRec.FPortNo + ', Topic: ' + FMQInfoRec.FTopic + ' >>> ' + LStr, False);
    end;

    FToggleBackground := not FToggleBackground;
    FIPCClientAll.PulseEventData<TEventData_Modbus_Standard>(EventData);
    FModBusComThread.FEventHandle.Signal;
    Lstr := '********'''+ FSharedMemName + '(' + CommMode2String(TCommMode(EventData.DataMode)) +')'', Send OK!'+#13#10;
    DisplayMessage(LStr, False);
  end
  else
  begin
    Inc(FErrCnt);
    Label4.Caption := IntToStr(FErrCnt);
    //DisplayMessage(RecvData ,False);//LRC Packet Error
    DisplayMessage(''' ==> LRC Error (' +tmpstr+' -> '+ IntToHex(lrc,2)+ ')''',
                                                      False);//LRC Packet Error
  end;
end;

//������ ����Ÿ��  �����޸𸮿� �����ϱ� ���� �ڵ�
//ADataMode: CM_DATA_READ, CM_CONFIG_READ, CM_DATA_WRITE, CM_CONFIG_WRITE
procedure TModbusComF.MakeDataRTU(ASlaveNo, ADataMode: integer);
var
  CRC16,RecvCRC: word;
  i, j, ByteCount: integer;
  pModbusBlock: TModbusBlock;
  EventData: TEventData_Modbus_Standard;
  arydata: array[0..19] of char;
  pAryData: PChar;
  tmpstr, LStr: string;
begin
  RecvCRC := (FRecvByteBuf.Items[FRecvByteBuf.Size - 2] shl 8) and $FF00;
  //tmpCRC := (tmpCRC shl 8) and $FF00;
  RecvCRC := RecvCRC + FRecvByteBuf.Items[FRecvByteBuf.Size - 1];
  tmpstr := FRecvByteBuf.CopyToString(0, FRecvByteBuf.Size-2);
  //CRC16 := UpdateCRC16(0, FRecvByteBuf.FBuffer, FRecvByteBuf.Size - 2);

  CRC16 := CalcCRC16_2(tmpstr);

  //CRC�� ��Ȯ���� Check
  if RecvCRC = CRC16 then
  begin
    ByteCount := FRecvByteBuf.Items[2];

//    SetLength(EventData.InpDataBuf, 256);

    with EventData do
    begin
      LStr := IntToStr(FRecvByteBuf.Items[1]) + ',' + IntToStr(ByteCount);

      for i := 0 to ByteCount - 1 do
      begin
        //�����޸𸮿� ���� ������
        //����� Register�� 16bit�̰� ���ŵ� �����ʹ� 8bit�̹Ƿ� �ΰ��� ��ħ(2013.2.20)
        InpDataBuf[i] := (FRecvByteBuf.Items[MODBUS_DATA_RTU_START_HI_IDX + (i * 2)] shl 8) and $FF00;
        InpDataBuf[i] := InpDataBuf[i] + FRecvByteBuf.Items[MODBUS_DATA_RTU_START_HI_IDX + (i * 2)+1];
        LStr := LStr + ',' + IntToStr(InpDataBuf[i]);
      end;//for

      //Flag := cfModBusCom;
      NumOfData := ByteCount;
      ModBusMode := Ord(RTU_MODE);
      DataMode := ADataMode;

      //Read Once(CurrentCommandIndex = -1) �� ��쿡�� ModbusBlock�� ���� FWriteCommData�� ����
      if FCurrentCommandIndex = -1 then
      begin
        ModBusFunctionCode := FWriteCommData.ModBusFunctionCode;
        ModbusAddress := FWriteCommData.ModBusAddress;
        BlockNo := FWriteCommData.BlockNo;
        //NumOfBit := FWriteCommData.;
      end
      else
      begin
        if ASlaveNo = FSlaveNo then
          pModbusBlock := GetModBusBlock(FCurrentCommandIndex);

        ModBusFunctionCode := pModBusBlock.FFunctionCode;
        NumOfBit := pModBusBlock.FCount;

        if pModbusBlock <> nil then
        begin
          //������ ����Ÿ���� �䱸�� ����Ÿ���� �ٸ��� exit(�䱸�� ����Ÿ ���� �ι���0)
          if (pModBusBlock.FFunctionCode = 1) or (pModBusBlock.FFunctionCode = 2) then
          begin
            j := (pModBusBlock.FCount div 8);
            if pModBusBlock.FCount mod 8 > 0 then
              Inc(j);
          end
          else
            j := pModBusBlock.FCount * 2;

          if ByteCount <> j then
          begin
            DisplayMessage(FRecvByteBuf.CopyToString(0, FRecvByteBuf.Size) +
                            ' ==> ������ ����Ÿ�� -> �䱸�� ����Ÿ���� �ٸ� (' +
                            IntToHex(ByteCount,2) +' -> '+ IntToHex(pModBusBlock.FCount,2)+ ')',
                                                        False);
            exit;
          end;//if

          //pAryData := @aryData[0];
          //pAryData := StrPCopy(pAryData,pModBusBlock.FStartAddr);
          //StrCopy(@ModBusAddress[0], pAryData);//pModBusBlock.FStartAddr;
          ModbusAddress := pModBusBlock.FStartAddr;
          BlockNo := pModBusBlock.FBlockNo;
        end//if
        else
        begin
          DisplayMessage('ModBusBlock�� ������ �� ����(' +
                          IntToStr(FCurrentCommandIndex) +')', False);
          exit;//startaddress�� �������� ���ϸ� exit
        end;
      end;

      EngineName := FEngineName;
      LStr := IntToStr(BlockNo) + ',' +  LStr;
    end;//with

//    if FRecvByteBuf.Items[0] = FSlaveNo then
      FIPCClientAll.PulseEventData<TEventData_Modbus_Standard>(EventData);

    //Write Registers�� ��� �ð��� �ɸ��� ������ ���� Query�� Signal Timeout ���� ������Ŵ
    if EventData.ModBusFunctionCode <> 16 then
      FModBusComThread.FEventHandle.Signal;

    FRecvByteBuf.Clear;
    FToggleBackground := not FToggleBackground;

    if Assigned(FDisplayRecvF) then
      FDisplayRecvF.AddRowFromCSV(LStr);

    if FMQInfoRec.FIsEnableMQ then
    begin
      SendData2MQ(LStr);
      DisplayMessage('MQ Send: ' + FMQInfoRec.FIPAddr + ', Port: ' + FMQInfoRec.FPortNo + ', Topic: ' + FMQInfoRec.FTopic + ' >>> ' + LStr, False);
    end;

    Lstr := '********'''+ FSharedMemName + '(' + CommMode2String(TCommMode(EventData.DataMode)) +')'', Send OK!'+#13#10;
    DisplayMessage(LStr, False);
//    DisplayMessage('********* �����޸𸮿� ����Ÿ ������!!! **********'+#13#10, False);
  end
  else
  begin
    //CRC16 Packet Error
    DisplayMessage(''' ==> CRC Error (' + IntToHex(RecvCRC,2) +
                    ' -> '+ IntToHex(CRC16,2)+ ')''', False);
    FRecvByteBuf.Clear;
  end;

end;

procedure TModbusComF.MakeDataRTU4Simulate;
var
  i: integer;
  LStr: string;
  EventData: TEventData_Modbus_Standard_DynArr;
//  MQData: TEventData_Modbus_Standard_DynArr;
begin
  SetLength(EventData.InpDataBuf, 256);
//  SetLength(EventData.InpDataBuf2, 256);
//  SetLength(EventData.InpDataBuf_double, 1001);
//  SetLength(EventData.ModBusMapFileName, 255);
//  SetLength(EventData.IPAddress, 16);
//  SetLength(EventData.EngineName, 20);
//  SetLength(EventData.ModBusAddress, 5);

  with EventData do
  begin
    NumOfData := FIPCClientAll.FEngineParameter.EngineParameterCollect.Count;
    ModBusMode := Ord(RTU_MODE);
    DataMode := Ord(CM_DATA_READ);
    ModBusFunctionCode := StrToInt(FIPCClientAll.FEngineParameter.EngineParameterCollect.Items[0].FCode);
    ModbusAddress := FIPCClientAll.FEngineParameter.EngineParameterCollect.Items[0].Address;
    BlockNo := FIPCClientAll.FEngineParameter.EngineParameterCollect.Items[0].BlockNo;
    NumOfBit := FIPCClientAll.FEngineParameter.EngineParameterCollect.Count;
    EngineName := FEngineName;

    for i := 0 to NumOfData - 1 do
    begin
      //�����޸𸮿� ���� ������
      //����� Register�� 16bit�̰� ���ŵ� �����ʹ� 8bit�̹Ƿ� �ΰ��� ��ħ
      InpDataBuf[i] := Random(500);
//      LStr := LStr + ',' + IntToStr(InpDataBuf[i]);
    end;//for
  end;

//  SetLength(MQData.InpDataBuf, 256);
//  System.Move(EventData, MQData, SizeOf(EventData));

  if FMQInfoRec.FIsEnableMQ then
  begin
    LStr := UTF8ToString(RecordSaveJSON(EventData, TypeInfo(TEventData_Modbus_Standard_DynArr)));
    SendData2MQ(LStr);
    DisplayMessage('MQ Send: ' + FMQInfoRec.FIPAddr + ', Port: ' + FMQInfoRec.FPortNo + ', Topic: ' + FMQInfoRec.FTopic + ' >>> ' + LStr, False);
  end;

//  FIPCClientAll.PulseEventData<TEventData_Modbus_Standard>(EventData);
  Lstr := '********'''+ FSharedMemName + '(' + CommMode2String(TCommMode(EventData.DataMode)) +')'', Send OK!'+#13#10;
  DisplayMessage(LStr, False);
end;

procedure TModbusComF.MakeDataRTU4WriteFunc(ASlaveNo, ADataMode, AFuncNo,
  AByteCount: integer);
var
  CRC16,RecvCRC: word;
  i, j, ByteCount: integer;
  pModbusBlock: TModbusBlock;
  EventData: TEventData_Modbus_Standard;
  arydata: array[0..19] of char;
  pAryData: PChar;
  tmpstr, LStr: string;
begin
  if AFuncNo = 16 then
  begin
    RecvCRC := (FRecvByteBuf.Items[6] shl 8) and $FF00;
    RecvCRC := RecvCRC + FRecvByteBuf.Items[7];
    tmpstr := FRecvByteBuf.CopyToString(0, 6);
  end;

  CRC16 := CalcCRC16_2(tmpstr);

  //CRC�� ��Ȯ���� Check
  if RecvCRC = CRC16 then
  begin
    ByteCount := AByteCount;

//    SetLength(EventData.InpDataBuf, 256);

    with EventData do
    begin
      //for i := 0 to ByteCount - 1 do
      //begin
        //�����޸𸮿� ���� ������
        //����� Register�� 16bit�̰� ���ŵ� �����ʹ� 8bit�̹Ƿ� �ΰ��� ��ħ(2013.2.20)
        InpDataBuf[0] := (FRecvByteBuf.Items[4] shl 8) and $FF00;
        InpDataBuf[0] := InpDataBuf[i] + FRecvByteBuf.Items[5];
      //end;//for

      //Flag := cfModBusCom;
      NumOfData := ByteCount;
      ModBusMode := Ord(RTU_MODE);
      DataMode := ADataMode;

      //Read Once(CurrentCommandIndex = -1) �� ��쿡�� ModbusBlock�� ���� FWriteCommData�� ����
      if AFuncNo = 16 then
      begin
        ModBusFunctionCode := FWriteCommData.ModBusFunctionCode;
        ModbusAddress := FWriteCommData.ModBusAddress;
        BlockNo := FWriteCommData.BlockNo;
        ErrorCode := 9999;
      end;

    end;//with

    //FIPCClientAll.FIPCClient_HIC.PulseMonitor(EventData);
    FIPCClientAll.PulseEventData<TEventData_Modbus_Standard>(EventData);
    Lstr := '********'''+ FSharedMemName + '(' + CommMode2String(TCommMode(EventData.DataMode)) +')'', Send OK!'+#13#10;
    DisplayMessage(LStr, False);

    //Write Registers�� ��� �ð��� �ɸ��� ������ ���� Query�� Signal Timeout ���� ������Ŵ
    if EventData.ModBusFunctionCode <> 16 then
      FModBusComThread.FEventHandle.Signal
    else
    begin
      if FRecvByteBuf.Size > 8 then
        TruncByte(8)
      else
        FRecvByteBuf.Clear;
    end;
  end
  else
    //CRC16 Packet Error
    DisplayMessage(''' ==> CRC Error (' + IntToHex(RecvCRC,2) +
                    ' -> '+ IntToHex(CRC16,2)+ ')''', False);
end;

procedure TModbusComF.MakeDataTCP(AEngName: string);
var
  i, j, FC, LCount, Llength, Lloop, Idx, LParamIdx: integer;
  EventData: TEventData_Modbus_Standard_DynArr;
  LEventData2: TEventData_Modbus_Standard;
  Lstr, LStr2, LTemp, LFC: string;
  arydata: array[0..19] of char;
  pAryData: PChar;
  pModbusBlock: TModbusBlock;
  LAlarm, LBitMode: Boolean;
  ILog: ISynLog;
begin
  pModbusBlock := GetModBusBlock(FCurrentCommandIndex);

  if pModbusBlock <> nil then
  begin
    FC := FRecvWordBuf[0]; //Function Code
    LCount := FRecvWordBuf[1];//Data Count;

    LStr := IntToStr(FC) + ',' + IntToStr(LCount);

    SetLength(EventData.InpDataBuf, LCount);

    with EventData do
    begin
      LAlarm := pModBusBlock.FAlarm;
      BlockNo := pModBusBlock.FBlockNo;
      LParamIdx := GetStartItemIndexFromBlockNo(BlockNo);
      LBitMode := False;

      if LAlarm then //Analog
      begin
        Llength := LCount;
      end
      else
      begin //Digital
        Llength := LCount;

        if (FC = 3) or (FC = 4) then
        begin
          LBitMode := True; //Data�� Digital�ε� FC�� 3,4�� ��� �Ѱ��� Word �����͸� 16��� �ؾ� ��
          LCount := LCount * 16;
          SetLength(EventData.InpDataBuf, LCount);
//          Llength := LCount div 16;
//
//          if (LCount mod 16) > 0 then
//            inc(Llength);
        end
//        else
//          Llength := LCount;
      end;

//      if LCount < 16 then
//        Lloop := LCount
//      else
        Lloop := 16;

      for i := 0 to Llength - 1 do
      begin
        LTemp := '';

        if LBitMode then
        begin
          for j := 0 to Lloop - 1 do
          begin
            Idx := i*16+j;
            //�����޸𸮿� ���� ������
            if IsbitSet(FRecvWordBuf[MODBUS_DATA_TCPWAGO_START_HI_IDX + i], j) then
            begin
              InpDataBuf[Idx] := $FFFF;
              LTemp := '65535';
            end
            else
            begin
              InpDataBuf[Idx] := $0000;
              LTemp := '0';
            end;

            if LParamIdx <> -1 then
              FEngineParameter.EngineParameterCollect.Items[LParamIdx+Idx].Value := LTemp;//IntToStr(InpDataBuf[i]);

            LStr := LStr + ',' + LTemp;
          end; //for j
        end
        else //not LBitMode
        begin
          if (FC = 3) or (FC = 4) then
          begin
            //�����޸𸮿� ���� ������
            InpDataBuf[i] := FRecvWordBuf[MODBUS_DATA_TCPWAGO_START_HI_IDX + i];
            LTemp := IntToStr(FRecvWordBuf[MODBUS_DATA_TCPWAGO_START_HI_IDX + i]);
            LStr := LStr + ',' + LTemp;
          end
          else
          begin
            if FRecvBoolBuf[i] then
            begin
              InpDataBuf[i] := $FFFF;
              LTemp := '65535';
            end
            else
            begin
              InpDataBuf[i] := $0000;
              LTemp := '0';
            end;

            LStr := LStr + ',' + LTemp;
          end;

          if LParamIdx <> -1 then
            FEngineParameter.EngineParameterCollect.Items[LParamIdx+i].Value := LTemp;//IntToStr(InpDataBuf[i]);
        end;
      end;//for

      //Flag := cfModBusCom;
      NumOfData := LCount;
      ModBusMode := Ord(FModBusMode);//MODBUSTCP_MODE);
      ModBusFunctionCode := FC;
      NumOfBit := LCount;
      ModBusAddress := pModBusBlock.FStartAddr;
      EngineName := AEngName;
      LStr := IntToStr(BlockNo) + ',' +  LStr;
    end;//with

    Copy_DynArrRec_2_EventData_Modbus_Standard(EventData, LEventData2);
    FIPCClientAll.PulseEventData<TEventData_Modbus_Standard>(LEventData2);
    FModBusTCPThread.FEventHandle.Signal;
    DisplayMessage(LStr, False);
    LStr2 := '********''' + FSharedMemName + ''', Send OK!(ModbusTCP : IP = ''' + FIPAddress;
    LStr2 := LStr2 + ''', Port = ' + IntToStr(FPortNum) + ', Engine: '+ LEventData2.EngineName +')***'+#13#10;
    DisplayMessage(LStr2, False);
    FRecvByteBuf.Clear;
    FToggleBackground := not FToggleBackground;

    if Assigned(FDisplayRecvF) then
      FDisplayRecvF.AddRowFromCSV(LStr);

    if Assigned(DispSingleValueF) then
    begin
      LStr2 := DispSingleValueF.GetAddressFromEdit(LFC);

      if LStr2 <> '' then
      begin
        if LFC = IntToStr(FC) then
        begin
          //Get Value and Description
          LTemp := GetValueFromAddress(LStr, LFC, LStr2, pModBusBlock.FBlockNo);
          if LTemp <> '' then
            DispSingleValueF.SetDataToForm(LStr, LTemp);
        end;
      end;
    end;

    if FMQInfoRec.FIsEnableMQ then
    begin
      LStr := UTF8ToString(RecordSaveJSON(EventData, TypeInfo(TEventData_Modbus_Standard_DynArr)));
      SendData2MQ(LStr);
      DisplayMessage('MQ Send: ' + FMQInfoRec.FIPAddr + ', Port: ' + FMQInfoRec.FPortNo + ', Topic: ' + FMQInfoRec.FTopic + ' >>> ' + LStr, False);
    end;

//    DisplayMessage(LStr +#13#10, False);          by pjh
  end//if
  else
  begin
    DisplayMessage('ModBusBlock�� ������ �� ����(' +
                      IntToStr(FCurrentCommandIndex) +')', False);
  end;
end;

procedure TModbusComF.MakeDataTCP4Simulate;
var
  i: integer;
  LStr: string;
  EventData: TEventData_Modbus_Standard_DynArr;
begin
  SetLength(EventData.InpDataBuf, 256);

  with EventData do
  begin
    NumOfData := FIPCClientAll.FEngineParameter.EngineParameterCollect.Count;
    ModBusMode := Ord(MODBUSTCP_MODE);
    DataMode := Ord(CM_DATA_READ);
    ModBusFunctionCode := StrToInt(FIPCClientAll.FEngineParameter.EngineParameterCollect.Items[0].FCode);
    ModbusAddress := FIPCClientAll.FEngineParameter.EngineParameterCollect.Items[0].Address;
    BlockNo := FIPCClientAll.FEngineParameter.EngineParameterCollect.Items[0].BlockNo;
    NumOfBit := FIPCClientAll.FEngineParameter.EngineParameterCollect.Count;
    EngineName := FEngineName;

    for i := 0 to NumOfData - 1 do
    begin
      InpDataBuf[i] := Random(500);
    end;//for
  end;

  if FMQInfoRec.FIsEnableMQ then
  begin
    LStr := UTF8ToString(RecordSaveJSON(EventData, TypeInfo(TEventData_Modbus_Standard_DynArr)));
    SendData2MQ(LStr);
    DisplayMessage('MQ Send: ' + FMQInfoRec.FIPAddr + ', Port: ' + FMQInfoRec.FPortNo + ', Topic: ' + FMQInfoRec.FTopic + ' >>> ' + LStr, False);
  end;

//  FIPCClientAll.PulseEventData<TEventData_Modbus_Standard>(EventData);
  Lstr := '********'''+ FSharedMemName + '(' + CommMode2String(TCommMode(EventData.DataMode)) +')'', Send OK!'+#13#10;
  DisplayMessage(LStr, False);
end;

procedure TModbusComF.MakeDataTCPWago;
var
  i, j, FC, LCount, Llength, Lloop: integer;
  EventData: TEventData_Modbus_Standard;//TEventData_HIC;
  Lstr: string;
  arydata: array[0..19] of char;
  pAryData: PChar;
  pModbusBlock: TModbusBlock;
begin
  pModbusBlock := GetModBusBlock(FCurrentCommandIndex);
  if pModbusBlock <> nil then
  begin

    FC := FRecvWordBuf[0]; //Function Code
    LCount := FRecvWordBuf[1];//Data Count;

    LStr := IntToStr(FC) + ',' + IntToStr(LCount);

//    SetLength(EventData.InpDataBuf, 256);
    with EventData do
    begin
      if (FC = 1) or (FC = 2) then
      begin
        Llength := LCount div 16;

        if (LCount mod 16) > 0 then
          inc(Llength);
      end
      else if (FC = 3) or (FC = 4) then
        Llength := LCount;

      for i := 0 to Llength - 1 do
      begin
        if (FC = 1) or (FC = 2) then
        begin
          if LCount < 16 then
            Lloop := LCount
          else
            Lloop := 15;

          for j := 0 to Lloop do
          begin
            //�����޸𸮿� ���� ������
            if IsBitSet(FRecvWordBuf[MODBUS_DATA_TCPWAGO_START_HI_IDX + i],j) then
              InpDataBuf[i*8+j] := $FFFF
            else
              InpDataBuf[i*8+j] := $0000;

            LStr := LStr + ',' + IntToStr(InpDataBuf[i*8+j]);
          end;
        end
        else if (FC = 3) or (FC = 4) then
        begin
          //�����޸𸮿� ���� ������
          InpDataBuf[i] := FRecvWordBuf[MODBUS_DATA_TCPWAGO_START_HI_IDX + i];
          LStr := LStr + ',' + IntToStr(FRecvWordBuf[MODBUS_DATA_TCPWAGO_START_HI_IDX + i]);
        end;
      end;//for

      //Flag := cfModBusCom;
      NumOfData := LCount;
      ModBusMode := Ord(TCP_WAGO_MODE);
      ModBusFunctionCode := FC;
      NumOfBit := LCount;
      pAryData := @aryData[0];
      pAryData := StrPCopy(pAryData,pModBusBlock.FStartAddr);
      StrCopy(@ModBusAddress[1], pAryData);//pModBusBlock.FStartAddr;
    end;//with

    //FIPCClientAll.FIPCClient_HIC.PulseMonitor(EventData);
    FIPCClientAll.PulseEventData<TEventData_Modbus_Standard>(EventData);
    FModBusTCPWagoThread.FEventHandle.Signal;
    FRecvByteBuf.Clear;
    DisplayMessage(LStr +#13#10, False);
    Lstr := '********'''+ FSharedMemName + ''', Send OK!(ModbusTCP : IP = ''' + FIPAddress;
    LStr := LStr + ''', Port = ' + IntToStr(FPortNum) + ')***'+#13#10;
    DisplayMessage(LStr, False);
  end//if
  else
  begin
    DisplayMessage('ModBusBlock�� ������ �� ����(' +
                      IntToStr(FCurrentCommandIndex) +')', False);
  end;
end;

function TModbusComF.MakeModbusTCP: Boolean;
begin
  Result := False;

  if (FModBusMode = MODBUSTCP_MODE) or (FModBusMode = MODBUSSERIAL_TCP_MODE) then
  begin
    if not Assigned(FModBusTCPThread) then
    begin
      FModBusTCPThread := TModBusTCPThread.Create(Self, FIPAddress, FPortNum, FQueryInterval, Ord(FModBusMode), FBindIPAddress);
      FModBusTCPThread.StopComm := True;
      StatusBar1.Panels[0].Width := 150;
      //JvLED1.Left := 103;
      StatusBar1.Panels[0].Text := FIPAddress+':'+IntToStr(FPortNum);
      StatusBar1.Panels[2].Width := 110;
      StatusBar1.Panels[2].Text := FSharedMemName;
      StatusBar1.Panels[3].Text := 'Bind: ' + FBindIPAddress;
    end
    else
    begin
      if FModBusMode = MODBUSSERIAL_TCP_MODE then
        FModBusTCPThread.InitComPort(FIPAddress, FPortNum, FModBusMode, FQueryInterval, FSlaveNo, FBindIPAddress)
      else
        FModBusTCPThread.InitComPort(FIPAddress, FPortNum, FModBusMode, FQueryInterval, FSlaveNo, FBindIPAddress);
    end;

    Result := True;
  end;
end;

function TModbusComF.MakeModbusTCPWago: Boolean;
begin
  Result := False;

  if FModBusMode = TCP_WAGO_MODE then
  begin
    if not LoadDLL4TCPWago then
    begin
      ShowMessage('MBT.dll file load fail!');
      Result := False;
    end
    else
      Result := True;

    //FPortNum := 502;
    if not Assigned(FModBusTCPWagoThread) then
    begin
      FModBusTCPWagoThread := TModBusTCPWagoThread.Create(Self, FIPAddress, FPortNum, FQueryInterval);
      FModBusTCPWagoThread.StopComm := True;
    end
    else
      FModBusTCPWagoThread.InitComPort(FIPAddress, FPortNum, FModBusMode, FQueryInterval);
  end;
end;

procedure TModbusComF.Timer1Timer(Sender: TObject);
var
  LStr: string;
begin
  with Timer1 do
  begin
    Enabled := False;
    try
      SetCurrentDir(FilePath);
      if FFirst then
      begin
//        FPJHTimerPool.AddOneShot(OnAppMinimize, 5000);
        //caption := IntToStr(Handle);
        FFirst := False;
//        Interval := 500;
        //ReadMapAddress(FMapFileName,FModBusBlockList);
//        ReadMapAddressFromParamFile(FParamFileName,FModBusBlockList);
        ReadMapAddressFromParamFileUsingTStrings(FParamFileName,FModBusBlockList);
        FIPCClientAll.FEngineParameter.Assign(FEngineParameter);
        FIPCClientAll.CreateIPCClientAll;
        FEngineName := FIPCClientAll.FProjNo + '_' + FIPCClientAll.FEngNo;
        Caption := Caption + '(' + FIPCClientAll.GetEventName + ')';

        if FIPCClientAll.FIPCClientList.Count > 0 then
        begin
          FSharedMemName := FIPCClientAll.FIPCClientList.Strings[0];
          StatusBar1.Panels[2].Text := FSharedMemName;
          StatusBar1.Panels[3].Text := FEngineName;

          if FMQInfoRec.FIsEnableMQ then
          begin
            if FMQInfoRec.FUserId = '' then
              FMQInfoRec.FUserId := 'pjh';
            if FMQInfoRec.FPasswd = '' then
              FMQInfoRec.FPasswd := 'pjh';
            if FMQInfoRec.FTopic = '' then
              FMQInfoRec.FTopic := '/topic/' + FEngineName;
            if FMQInfoRec.FIPAddr = '' then
              FMQInfoRec.FIPAddr := '10.14.21.117';

            if not Assigned(FpjhSTOMPClass) then
              FpjhSTOMPClass := TpjhSTOMPClass.CreateWithStr(FMQInfoRec.FUserId,FMQInfoRec.FPasswd,FMQInfoRec.FIPAddr,FMQInfoRec.FPortNo,FMQInfoRec.FTopic,Self.Handle,False,False);
          end;
        end;

        MakeCommand;

        if ParamCount > 0 then
        begin
          LStr := UpperCase(ParamStr(1));
          if LStr = '/A' then  //Automatic Communication Start
          begin
            if (FModBusMode = MODBUSTCP_MODE) or
                (FModBusMode = MODBUSSERIAL_TCP_MODE) or
                (FModBusMode = TCP_WAGO_MODE) then
              Button1Click(nil)
            else
              SerialCommStart;
          end
          else
          begin
            FIsSimulate := LStr = '/S';  //Simulate Mode

            if FIsSimulate then
            begin
              FPJHTimerPool.Add(OnMakeData4Simulate, 1000);
              DisplayMessage('*** Simulate Mode Start ***',True);
            end;
          end;
        end;
//        Application.Minimize;
      end//if
      else
      begin
        //SendQuery;
      end;
    finally
//      Enabled := True;
    end;//try
  end;//with
end;

procedure TModbusComF.DisplayIPCClientList;
var
  i: integer;
begin
  for i := 0 to FIPCClientAll.FIPCClientList.Count - 1 do
    DisplayMessage(FIPCClientAll.FIPCClientList.Strings[i] + ' Created.',True);
end;

procedure TModbusComF.DisplayMessage(msg: string; IsSend: Boolean);
begin
  if IsSend then
  begin
    if msg = ' ' then
    begin
      //TxLed.Value := True;
      exit;
    end
    else
      ;//TxLed.Value := False;

    with ModBusSendComMemo do
    begin
      if Lines.Count > 100 then
        Clear;

      Lines.Add(msg);
    end;//with
  end
  else
  begin
    if msg = 'RxTrue' then
    begin
      //RxLed.Value := True;
      exit;
    end
    else
    if msg = 'RxFalse' then
    begin
      //RxLed.Value := False;
      exit;
    end;

    with ModBusRecvComMemo do
    begin
      if Lines.Count > 100 then
        Clear;

      if FToggleBackground then
        Color := $00FFFF80
      else
        Color := clWhite;

      Lines.Add(msg);
    end;//with
  end;

end;

procedure TModbusComF.DisplayRecv1Click(Sender: TObject);
begin
  DisplayRecvForm;
end;

procedure TModbusComF.DisplayRecvForm;
var
  i: integer;
  LPrevBlockNo: integer;
  LStr, LDesc: string;
  LStrList: TStringList;
begin
  if Assigned(FDisplayRecvF) then
  begin
    FDisplayRecvF.Show;
    exit;
  end
  else
  begin
    LStrList := TStringList.Create;
    try
      LPrevBlockNo := -1;

      for i := 0 to FEngineParameter.EngineParameterCollect.Count - 1 do
      begin
        //stConfig�� �ǳ� ��
        if (FEngineParameter.EngineParameterCollect.Items[i].SensorType = stConfig) and
          (FEngineParameter.EngineParameterCollect.Items[i].IsMatrixData) then
          continue;

        if (FEngineParameter.EngineParameterCollect.Items[i].SensorType = stCalculated) and
          (FEngineParameter.EngineParameterCollect.Items[i].ParameterSource = psManualInput) then
          continue;

        if (FEngineParameter.EngineParameterCollect.Items[i].SensorType = stParam) then
          continue;

        with FEngineParameter.EngineParameterCollect.Items[i] do
        begin
          if LPrevBlockNo <> BlockNo then
          begin
            LPrevBlockNo := BlockNo;
            if LStr <> '' then
            begin
              LStrList.Add(LStr);
              LStr := '';
            end;
          end;

          //if UpperCase(Description) <> 'DUMMY' then
          //begin
            LDesc := replaceString(Description, ',', '', false);
            if LStr = '' then
              LStr := LDesc
            else
              LStr := LStr + ',' + LDesc;
          //end;
        end;//with

      end;//for

      if FEngineParameter.EngineParameterCollect.Count > 0 then
        if LStr <> '' then
          LStrList.Add(LStr);

      FDisplayRecvF := TDisplayRecvF.Create(Self);
      try
        with FDisplayRecvF do
        begin
          for i := 0 to LStrList.Count - 1 do
            AddColFromCSV(IntToStr(i+1) + ',' + LStrList.Strings[i]);
          Show;
        end;//with
      finally
        //FreeAndNil(LDisplayRecvF);
      end;//try
    finally
      FreeAndNil(LStrList);
    end;
  end;
end;

procedure TModbusComF.DisplaySingleValue;
var
  i: integer;
  LPrevBlockNo: integer;
  LStr, LDesc: string;
  LStrList: TStringList;
begin
  if Assigned(DispSingleValueF) then
  begin
    DispSingleValueF.Show;
    exit;
  end
  else
  begin
    LStrList := TStringList.Create;
    try
      DispSingleValueF := TDispSingleValueF.Create(Self);
      try
        with DispSingleValueF do
          Show;
//        begin
//          LStr := AddressEdit.Text;
//          if LStr <> '' then
//          begin
//
//            for i := 0 to FEngineParameter.EngineParameterCollect.Count - 1 do
//            begin
//              with FEngineParameter.EngineParameterCollect.Items[i] do
//              begin
//                //stConfig�� �ǳ� ��
//                if (SensorType = stConfig) and (IsMatrixData) then
//                  continue;
//
//                if (SensorType = stCalculated) and (ParameterSource = psManualInput) then
//                  continue;
//
//                if (SensorType = stParam) then
//                  continue;
//
//              if True then
//
//                LDesc := replaceString(Description, ',', '', false);
//              end;//with
//            end;//for
//          end;
//
//          Show;
//        end;//with
      finally
      end;//try
    finally
      FreeAndNil(LStrList);
    end;
  end;
end;

procedure TModbusComF.DisplaySIngleValue1Click(Sender: TObject);
begin
  DisplaySingleValue;
end;

//ModBusBlock�� aIndex��° �ڷḦ ��ȯ��
//aIndex�� FSendCommandList�� ���� Index�� ����Ŵ(0���� ������)
function TModbusComF.GetModBusBlock(aIndex: integer): TModBusBlock;
var it: DIterator;
    i: integer;
begin
  Result := nil;
  i := 0;
  it := FModBusBlockList.start;

  while not atEnd(it) do
  begin
    if i = aIndex then
    begin
      Result := GetObject(it) as TModbusBlock;
      exit;
    end;//if
    Advance(it);
    Inc(i);
  end;//while
end;

function TModbusComF.GetStartItemIndexFromBlockNo(ABlockNo: integer): integer;
var
  i: integer;
begin
  Result := -1;

  for i := 0 to FSendCommandList.Count - 1 do
  begin
    if TModbusTCP_Command(FSendCommandList.Objects[i]).FBlockNo = ABlockNo then
    begin
      Result := TModbusTCP_Command(FSendCommandList.Objects[i]).FParamIndex;
      Break;
    end;
  end;
end;

function TModbusComF.GetValueFromAddress(var ADesc: string; 
  AFCode, AAddress: string; ABlockNo: integer): string;
var
  i, LStartIdx, LBitPos: integer;
  LBitEnable: Boolean;
begin
  Result := '';
  
  if ABlockNo <> -1 then
    LStartIdx := GetStartItemIndexFromBlockNo(ABlockNo)
  else
    LStartIdx := 0;

  if LStartIdx = -1 then
    exit;

  LBitEnable := DispSingleValueF.BitEnableCheck.Checked;

  if LBitEnable then
    LBitPos := DispSingleValueF.BitGrp.ItemIndex;

  ADesc := '';

  for i := LStartIdx to FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    with FEngineParameter.EngineParameterCollect.Items[i] do
    begin
      if (BlockNo = ABlockNo) and (FCode = AFCode) and (Address = AAddress) then
      begin
        if LBitEnable then
//          if i <> LStartIdx + LBitPos then
          if LBitPos <> RadixPosition then
            continue;

        ADesc := Description;
        Result := Value;
        Break;      
      end;
    end;
  end;
end;

procedure TModbusComF.SetCurrentCommandIndex(aIndex: integer);
begin
  if FCurrentCommandIndex <> aIndex then
    FCurrentCommandIndex := aIndex;
end;

procedure TModbusComF.SetDefaultComport;
var
  LPortList: TStringList;
begin
  LPortList :=  TStringList.Create;
  try
    EnumComPorts(LPortList);

    if LPortList.Count > 0 then
      FComport.Port := LPortList[0];
  finally
    LPortList.Free;
  end;
end;

//IniFile -> Form
procedure TModbusComF.LoadConfigDataini2Form(ConfigForm:TModbusConfigF);
var
  iniFile: TIniFile;
begin
  SetCurrentDir(FilePath);
  iniFile := nil;
  iniFile := TInifile.create(FilePath+FIniFileName);
  try
    with iniFile, ConfigForm do
    begin
      ModbusModeRG.ItemIndex := ReadInteger(MODBUS_SECTION, 'Modbus Mode', 0);
      BaseAddrEdit.Text := ReadString(MODBUS_SECTION, 'Base Address','0000');
      SlaveNoEdit.Text := ReadString(MODBUS_SECTION, 'Slave No','1');
      QueryIntervalEdit.Text := ReadString(MODBUS_SECTION, 'Query Interval','0');
      ResponseWaitTimeOutEdit.Text := ReadString(MODBUS_SECTION, 'Response Wait Time Out','0');
      ParaFilenameEdit.FileName := ReadString(MODBUS_SECTION, 'Parameter File Name', '');
      EngParamEncryptCB.Checked := ReadBool(MODBUS_SECTION, 'Parameter Encrypt', False);
      ConfFileFormatRG.ItemIndex := ReadInteger(MODBUS_SECTION, 'Param File Format', 0);
      FilenameEdit.Filename := ReadString(MODBUS_SECTION, 'Modbus Map File Name', '.\ss197_Modbus_Map.txt');
      FilenameEdit2.Filename := ReadString(MODBUS_SECTION, 'Modbus Map File Name2', '.\GTI_Modbus_Map.txt');
      JvIPAddress1.Text := ReadString(MODBUS_SECTION, 'IP Address', '127.0.0.1');
      PortNumEdit.Text := ReadString(MODBUS_SECTION, 'Port Number', '502');
      SharedNameEdit.Text := ReadString(MODBUS_SECTION, 'Shared Name', ParameterSource2SharedMN(FParamSource));
      BindIPCB.Text := ReadString(MODBUS_SECTION, 'Bind IP Address', '');
      MQServerEnable.CheckBox.Checked := ReadBool(MODBUS_SECTION, 'MQ Server Enable', False);
      MQIPAddress.Text := ReadString(MODBUS_SECTION, 'MQ Server IP Address', '10.14.21.117');
      MQPortEdit.Text := ReadString(MODBUS_SECTION, 'MQ Server Port', '61613');
      MQBindComboBox.Text := ReadString(MODBUS_SECTION, 'MQ Server Bind IP Address', '');
      MQUserEdit.Text := ReadString(MODBUS_SECTION, 'MQ Server UserID', 'pjh');
      MQPasswdEdit.Text := ReadString(MODBUS_SECTION, 'MQ Server Passwd', 'pjh');
      MQTopicEdit.Text := ReadString(MODBUS_SECTION, 'MQ Server Topic', '');
    end;//with
  finally
    iniFile.Free;
    iniFile := nil;
  end;//try
end;

procedure TModbusComF.LoadConfigDataini2Var;
var
  iniFile: TIniFile;
  LStr: string;
begin
  SetCurrentDir(FilePath);
  iniFile := nil;
  iniFile := TInifile.create(FilePath+FIniFileName);
  try
    with iniFile do
    begin
      ModBusMode := TModBusMode(ReadInteger(MODBUS_SECTION, 'Modbus Mode', 0));
      FIsSimulate := ModbusMode = SIMULATE_MODE;
      FBaseAddress := Str2Hex_Int(ReadString(MODBUS_SECTION, 'Base Address','0000'));
      FSlaveNo := ReadInteger(MODBUS_SECTION, 'Slave No', 1);
      FQueryInterval := ReadInteger(MODBUS_SECTION, 'Query Interval',0);
      if (ModbusMode = ASCII_MODE) or (ModbusMode = RTU_MODE) then
      begin
        if Assigned(FModBusComThread) then
          FModBusComThread.QueryInterval := FQueryInterval;
      end
      else if (ModbusMode = MODBUSTCP_MODE) then
      begin
        if Assigned(FModBusTCPThread) then
          FModBusTCPThread.QueryInterval := FQueryInterval;
      end
      else if (ModbusMode = TCP_WAGO_MODE) then
      begin
        if Assigned(FModBusTCPWagoThread) then
          FModBusTCPWagoThread.QueryInterval := FQueryInterval;
      end;

      FTimeOut := ReadInteger(MODBUS_SECTION, 'Response Wait Time Out',0);

      LStr := ReadString(MODBUS_SECTION, 'Parameter File Name', '');
      FConfigModified := False;
      if FParamFileName <> LStr then
      begin
        FParamFileName := LStr;
        FConfigModified := True;
      end;

      FEngParamEncrypt := ReadBool(MODBUS_SECTION, 'Parameter Encrypt', false);
      FEngParamFileFormat := ReadInteger(MODBUS_SECTION, 'Param File Format', 0);

      FMapFileName := ReadString(MODBUS_SECTION, 'Modbus Map File Name', '.\ss197_Modbus_Map.txt');
      FMapFileName2 := ReadString(MODBUS_SECTION, 'Modbus Map File Name2', '.\GTI_Modbus_Map.txt');
      FIPAddress := ReadString(MODBUS_SECTION, 'IP Address', '127.0.0.1');
      FPortNum := ReadInteger(MODBUS_SECTION, 'Port Number', 502);
      FSharedMemName := ReadString(MODBUS_SECTION, 'Shared Name', ParameterSource2SharedMN(FParamSource));
      FBindIPAddress := ReadString(MODBUS_SECTION, 'Bind IP Address', '');

      if FBindIPAddress = '' then
        FBindIPAddress := FNetworkAdapterList.GetBindIP(FIPAddress);

      FMQInfoRec.FIsEnableMQ := ReadBool(MODBUS_SECTION, 'MQ Server Enable', False);
      FMQInfoRec.FIPAddr := ReadString(MODBUS_SECTION, 'MQ Server IP Address', '10.14.21.117');
      FMQInfoRec.FPortNo := ReadString(MODBUS_SECTION, 'MQ Server Port', '61613');
      FMQInfoRec.FBindIPAddress := ReadString(MODBUS_SECTION, 'MQ Server Bind IP Address', '');
      FMQInfoRec.FUserId := ReadString(MODBUS_SECTION, 'MQ Server UserID', 'pjh');
      FMQInfoRec.FPasswd := ReadString(MODBUS_SECTION, 'MQ Server Passwd', 'pjh');
      FMQInfoRec.FTopic := '/topic/' + ReadString(MODBUS_SECTION, 'MQ Server Topic', '');
    end;//with

    //FModBusComThread.FComport.LoadSettings(FStoreType,FilePath + INIFILENAME);
  finally
    iniFile.Free;
    iniFile := nil;
  end;//try

end;

procedure TModbusComF.SaveConfigDataForm2ini(ConfigForm:TModbusConfigF);
var
  iniFile: TIniFile;
begin
  SetCurrentDir(FilePath);
  iniFile := nil;
  iniFile := TInifile.create(FilePath+FIniFileName);
  try
    with iniFile, ConfigForm do
    begin
      WriteInteger(MODBUS_SECTION, 'Modbus Mode', ModbusModeRG.ItemIndex);
      WriteString(MODBUS_SECTION, 'Base Address', BaseAddrEdit.Text);
      WriteString(MODBUS_SECTION, 'Slave No', SlaveNoEdit.Text);
      WriteString(MODBUS_SECTION, 'Query Interval',QueryIntervalEdit.Text);
      WriteString(MODBUS_SECTION, 'Response Wait Time Out', ResponseWaitTimeOutEdit.Text);
      WriteString(MODBUS_SECTION, 'Parameter File Name', ParaFilenameEdit.FileName);
      WriteBool(MODBUS_SECTION, 'Parameter Encrypt', EngParamEncryptCB.Checked);
      WriteInteger(MODBUS_SECTION, 'Param File Format', ConfFileFormatRG.ItemIndex);
      WriteString(MODBUS_SECTION, 'Modbus Map File Name', FilenameEdit.Filename);
      WriteString(MODBUS_SECTION, 'Modbus Map File Name2', FilenameEdit2.Filename);
      WriteString(MODBUS_SECTION, 'IP Address', JvIPAddress1.Text);
      WriteString(MODBUS_SECTION, 'Port Number', PortNumEdit.Text);
      WriteString(MODBUS_SECTION, 'Shared Name', SharedNameEdit.Text);
      WriteString(MODBUS_SECTION, 'Bind IP Address', BindIPCB.Text);
      WriteBool(MODBUS_SECTION, 'MQ Server Enable', MQServerEnable.CheckBox.Checked);
      WriteString(MODBUS_SECTION, 'MQ Server IP Address', MQIPAddress.Text);
      WriteInteger(MODBUS_SECTION, 'MQ Server Port', StrToIntDef(MQPortEdit.Text, 0));
      WriteString(MODBUS_SECTION, 'MQ Server Bind IP Address', MQBindComboBox.Text);
      WriteString(MODBUS_SECTION, 'MQ Server IP Address', MQIPAddress.Text);
      WriteString(MODBUS_SECTION, 'MQ Server Port', MQPortEdit.Text);
      WriteString(MODBUS_SECTION, 'MQ Server Bind IP Address', MQBindComboBox.Text);
      WriteString(MODBUS_SECTION, 'MQ Server UserID', MQUserEdit.Text);
      WriteString(MODBUS_SECTION, 'MQ Server Passwd', MQPasswdEdit.Text);
      WriteString(MODBUS_SECTION, 'MQ Server Topic', MQTopicEdit.Text);
    end;//with
  finally
    iniFile.Free;
    iniFile := nil;
  end;//try
end;

procedure TModbusComF.SetConfigData;
var
  ConfigData: TModbusConfigF;
begin
  if Button1.Caption = 'Stop' then
    Button1Click(nil);

  ConfigData := nil;
  ConfigData := TModbusConfigF.Create(Self);
  try
    with ConfigData do
    begin
      SharedName2Combo(SharedNameEdit);
      LoadConfigDataini2Form(ConfigData);
      if ShowModal = mrOK then
      begin
        SaveConfigDataForm2ini(ConfigData);
        LoadConfigDataini2Var;
        ReadMapFile;

        if ModbusModeRG.ItemIndex = 2 then //TCP Wago Mode
        begin
          if not MakeModbusTCPWago then
            exit;
        end;

      end;
    end;//with
  finally
    ConfigData.Free;
    ConfigData := nil;
  end;//try
end;

function TModbusComF.LoadDLL4TCPWago: Boolean;
begin
  Result := False;

  if FMBTDLLHandle <> 0 then
  begin
    FreeLibrary(FMBTDLLHandle);
    FMBTDLLHandle := 0;
  end;

  FMBTDLLHandle := LoadLibrary('MBT.dll');

  if FMBTDLLHandle <> 0 then
  begin
    MBTInit := GetProcAddress(FMBTDLLHandle,'MBTInit');
    MBTExit := GetProcAddress(FMBTDLLHandle,'MBTExit');
    MBTConnect := GetProcAddress(FMBTDLLHandle,'MBTConnect');
    MBTDisconnect := GetProcAddress(FMBTDLLHandle,'MBTDisconnect');
    MBTReadRegisters := GetProcAddress(FMBTDLLHandle,'MBTReadRegisters');
    MBTReadCoils := GetProcAddress(FMBTDLLHandle,'MBTReadCoils');
    MBTReadExceptionStatus := GetProcAddress(FMBTDLLHandle,'MBTReadExceptionStatus');
    MBTWriteRegisters := GetProcAddress(FMBTDLLHandle,'MBTWriteRegisters');
    MBTWriteCoils := GetProcAddress(FMBTDLLHandle,'MBTWriteCoils');
    MBTSwapWord := GetProcAddress(FMBTDLLHandle,'MBTSwapWord');
    MBTSwapDWord := GetProcAddress(FMBTDLLHandle,'MBTSwapDWord');
    Result := True;
  end;
end;

procedure TModbusComF.N2Click(Sender: TObject);
begin
  SetConfigData;
end;

procedure TModbusComF.N4Click(Sender: TObject);
begin
  Close;
end;

procedure TModbusComF.OnAppMinimize(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  Application.Minimize;
end;

procedure TModbusComF.OnMakeData4Simulate(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  case FModbusMode of
    RTU_MODE: MakeDataRTU4Simulate;
    ASCII_MODE: ;
    MODBUSTCP_MODE: MakeDataTCP4Simulate;
  end;
end;

procedure TModbusComF.SendData2MQ(AMsg: string);
begin
  FpjhSTOMPClass.StompSendMsg(AMsg, FMQInfoRec.FTopic);
  FpjhSTOMPClass.DisConnectStomp;
end;

procedure TModbusComF.SerialCommStart;
begin
  if (FModBusMode = MODBUSTCP_MODE) or (FModBusMode = TCP_WAGO_MODE) then
  begin
    ShowMessage('Can only be Serial communication mode');
    exit;
  end;

  try
    InitComPort;
  except
    ShowMessage('Comm port Initialize fail!');
    exit;
  end;

//  FModBusComThread.StopComm := not FModBusComThread.StopComm;

  if FModBusComThread.StopComm then
  begin
//    if FComport.Connected then
//      FComport.Close;

    Button1.Caption := 'Start';
  end
  else
  begin
    //�����Ʈ�� �����Ѵ�
    FComport.Open;
    Sleep(100);
    FComport.ClearBuffer(True,True);

    FModBusComThread.Resume;
    Button1.Caption := 'Stop';
  end;

  //JvLED1.Status := FComport.Connected;
end;

procedure TModbusComF.SetConfigComm;
begin
{  FModBusComThread.FComPort.ShowSetupDialog;
  FModBusComThread.FComPort.StoreSettings(FStoreType,FilePath + INIFILENAME);
  FModBusComThread.InitComPort('',ModbusMode,1000);
}
  FComPort.ShowSetupDialog;
  FComPort.StoreSettings(FStoreType,FilePath + FIniFileName);
  InitComPort;
end;

procedure TModbusComF.Switch1Click(Sender: TObject);
begin
  FModBusComThread.StopComm := not FModBusComThread.StopComm;

  if FModBusComThread.StopComm then
    //Button2.Caption := '��Ž���'
  else
  begin
    FModBusComThread.Resume;
    ;//Button2.Caption := '�������';
  end;
end;

procedure TModbusComF.SetModBusMode(aMode: TModBusMode);
begin
  FModBusMode := aMode;

  if (FModBusMode = MODBUSTCP_MODE) or (FModBusMode = TCP_WAGO_MODE) then
  begin

  end
  else
  if (FModBusMode = ASCII_MODE) or (FModBusMode = RTU_MODE) then
  begin
    if FModBusMode <> aMode then
    begin
      FModBusComThread.FModBusMode := aMode;
    end;
  end;
end;

procedure TModbusComF.ShowEngineName1Click(Sender: TObject);
begin
//  ShowMessage(FIPCClientAll.FProjNo + '_' + FIPCClientAll.FEngNo);
  ShowMessage(FIPCClientAll.GetEngineName);
end;

procedure TModbusComF.ShowEventName1Click(Sender: TObject);
begin
  ShowMessage(FIPCClientAll.GetEventName);
end;

procedure TModbusComF.ShowHandle1Click(Sender: TObject);
var
  LHandle: HWND;
  LStr: string;
begin
  LHandle := DSiGetProcessWindow(GetCurrentProcessId);
  LStr := 'DSiGetProcessWindow:' + IntToStr(LHandle);
  LStr := LStr + #13#10 + 'Self.Handle: ' + IntToStr(Self.Handle);
  LStr := LStr + #13#10 + 'Application.Handle: ' + IntToStr(Application.Handle);
  LStr := LStr + #13#10 + 'Application.MainForm.Handle: ' + IntToStr(Application.MainForm.Handle);

  ShowMessage(LStr);
end;

procedure TModbusComF.ShowMainForm;
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TModbusComF.ShowMainForm1Click(Sender: TObject);
begin
  ShowMainForm;
end;

procedure TModbusComF.ShowProcessID1Click(Sender: TObject);
begin
  ShowMessage(IntToStr(GetCurrentProcessId));
end;

procedure TModbusComF.WMCopyData(var Msg: TMessage);
begin
  case Msg.WParam of //Echo
    WParam_SENDWINHANDLE: begin//Handle ���� OK
      if PCopyDataStruct(Msg.LParam)^.dwData = Handle then
      begin
        FLauncherHandle := PCopyDataStruct(Msg.LParam)^.cbData;
        SendHandleCopyData(FLauncherHandle, Handle, WParam_RECVHANDLEOK);
        //StatusBar1.SimplePanel := True;
        StatusBar1.SimpleText := FormatDateTime('hh:mi:ss: ', now) + 'WParam_SENDWINHANDLE Receive OK!';
      end;
    end;

    WParam_RECVHANDLEOK: begin
      ;
    end;

    WParam_DISPLAYMSG: begin
      DisplayMessage(PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^.StrMsg,
             Boolean(PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^.iHandle));
    end;
  end;
end;

procedure TModbusComF.TrayIcon1DblClick(Sender: TObject);
begin
  ShowMainForm;
end;

Procedure TModbusComF.TruncByte(AIndex: integer);
var
  TempByteBuf: TByteArray2;
begin
  TempByteBuf := TByteArray2.Create(0);
  try
    TempByteBuf.CopyByteArray(FRecvByteBuf, AIndex, FRecvByteBuf.Size - AIndex);
    FRecvByteBuf.Clear;
    FRecvByteBuf.CopyByteArray(TempByteBuf, 0, TempByteBuf.Size);
  finally
    TempByteBuf.Free;
    TempByteBuf := nil;
  end;//try
end;

procedure TModbusComF.UpdateTrace_WriteComm(var Msg: TConfigData_ModbusComm);
var
  iAddr, LNumOfData: integer;
  SendBuff, tmpstr: string;
  crc16: word;
  LSlaveNo: integer;
begin
  with FWriteCommData do
  begin
    if SlaveNo = 0 then
      LSlaveNo := FSlaveNo
    else
      LSlaveNo := SlaveNo;

    iAddr := Str2Hex_Int(ModBusAddress) - FBaseAddress - 1;//$5000;
    SendBuff := Format('%.2x%.2x%.2x%.2x',
                      [LSlaveNo, ModBusFunctionCode, hi(iAddr),lo(iAddr)]);
  end;//with

  //0: Repeat Read, 1: Only One read(config data), 2: Only One Write, 3: Only One Write for Confirm
  if (FWriteCommData.CommMode = 2) or (FWriteCommData.CommMode = 3) then
  begin
    case FWriteCommData.ParameterType of
      2: MakeCommand4ScalarValue(SendBuff);//ptAnalog
      4: MakeCommand4Write1(SendBuff);//ptMatrix1
      5: MakeCommand4Write2(SendBuff);//ptMatrix2
      6: MakeCommand4Write3(SendBuff);//ptMatrix3
      7: MakeCommand4Write4(SendBuff);//ptMatrix1f
      8: MakeCommand4Write5(SendBuff);//ptMatrix2f
      9: MakeCommand4Write6(SendBuff);//ptMatrix3f
    else
      ;
    end;
  end
  else
  begin
    LNumOfData := FWriteCommData.NumOfData;
    SendBuff := SendBuff + Format('%.2x%.2x', [hi(LNumOfData), lo(LNumOfData)]);
  end;

  if ModbusMode = RTU_MODE then
  begin
    tmpStr := SendBuff;
    crc16 := CalcCRC16_2(tmpStr);
    SendBuff := SendBuff + Format('%.4x', [crc16]);
  end;

  //FWriteCommData.CommMode = 0: Repeat Read, 1: Only One read, 2: Only One Write, 3: Only One Write for Confirm
  if FWriteCommData.CommMode = 1 then
  begin
    //FModBusComThread.FCommMode := CM_CONFIG_READ;
    FModBusComThread.FSendCommandOnce := SendBuff;
  end
  else
  begin
    //if (FWriteCommData.CommMode = 2) then
    //  FModBusComThread.FCommMode := CM_CONFIG_WRITE
    //else
    if (FWriteCommData.CommMode = 3) then
      FModBusComThread.FIsConfirmMode := True;
    //  FModBusComThread.FCommMode := CM_CONFIG_WRITE_CONFIRM;

    FModBusComThread.FWriteCommandList.Add(SendBuff);
  end;
end;

procedure TModbusComF.Button1Click(Sender: TObject);
begin
  if (FModBusMode = MODBUSTCP_MODE) or (FModBusMode = MODBUSSERIAL_TCP_MODE) then
  begin
    if not FModBusTCPThread.FConnected then
      if not MakeModbusTCP then
        exit;

    if not FModBusTCPThread.FConnected then
    begin
      ShowMessage('TCP ������ �ȵ�. ��Ż��� Ȯ�� �� �ٽ� �ѹ� �õ��Ͻÿ�!');
      exit;
    end;

    FModBusTCPThread.StopComm := not FModBusTCPThread.StopComm;

    if FModBusTCPThread.StopComm then
      Button1.Caption := 'Start'
    else
    begin
      FModBusTCPThread.Resume;
      Button1.Caption := 'Stop';
    end;
  end
  else
  if FModBusMode = TCP_WAGO_MODE then
  begin
    if not FModBusTCPWagoThread.FConnected then
      if not MakeModbusTCPWago then
        exit;

    if not FModBusTCPWagoThread.FConnected then
    begin
      ShowMessage('TCP ������ �ȵ�. ��Ż��� Ȯ�� �� �ٽ� �ѹ� �õ��Ͻþ�!');
      exit;
    end;

    FModBusTCPWagoThread.StopComm := not FModBusTCPWagoThread.StopComm;

    if FModBusTCPWagoThread.StopComm then
      Button1.Caption := 'Start'
    else
    begin
      FModBusTCPWagoThread.Resume;
      Button1.Caption := 'Stop';
    end;
  end
  else
  begin
    SerialCommStart;

    {FModBusComThread.StopComm := not FModBusComThread.StopComm;

    if FModBusComThread.StopComm then
      Button1.Caption := 'Start'
    else
    begin
      FModBusComThread.Resume;
      Button1.Caption := 'Stop';
    end;  }
  end;
end;

procedure TModbusComF.Button2Click(Sender: TObject);
begin
  if not FModBusTCPThread.StopComm then
    Button1Click(nil);

  if FModBusMode = MODBUSTCP_MODE then
  begin
    if Assigned(FModBusTCPThread) then
    begin
      FModBusTCPThread.DisconnectTCP;
      Button1Click(nil);
    end;
  end;
end;

procedure TModbusComF.Button3Click(Sender: TObject);
begin
  Pingit(FIPAddress,Handle);
end;

procedure TModbusComF.Close1Click(Sender: TObject);
begin
  Close;
end;

end.

