unit UnitModBusTCPWagoThread2;

interface

uses Windows, sysutils, classes, Forms, CPort, UnitModbusComConst, MyKernelObject,
  CopyData, MBT2;

Type
  TModBusTCPWagoThread = class(TThread)
    FOwner: TForm;
    FSocket: LongInt;     //TCP ��Ʈ
    FStoreType: TStoreType; //������(ini or registry)
    FModBusMode: TModBusMode;//ASCII, RTU mode, TCP_WAGO_MODE
    FQueryInterval: integer;//ModBus Query ����(mSec)
    FStopComm: Boolean;//��� �Ͻ� ���� = True
    FTimeOut: integer;//��� Send�� ���� Send���� ����ϴ� �ð�(mSec) - INFINITE
    FRequestTimeOut: integer;//Connect �� ���� ��� �ð�
    FSendBuf: array[0..255] of byte;//RTU Mode���� ����ϴ� �۽� ����
    FBufStr: String;//ASCII Mode���� ���Ǵ� ���Ź���
    FReqByteCount: integer;//RTU Mode�϶� Send�ÿ� �䱸 ����Ʈ ���� �˾ƾ� üũ����
    FConnected: Boolean;//TCP ����Ǹ� True
    procedure SetStopComm(Value: Boolean);
    procedure SetTimeOut(Value: integer);
    procedure SetQueryInterval(Value: integer);

  protected
    procedure Execute; override;

  public
    FIP: string;
    FPort: integer;

    FEventHandle: TEvent;//Send�� �� Receive�Ҷ����� Wait�ϴ� Event
    FSendCommandList: TStringList;//Modbus ��� ��� ����Ʈ

    constructor Create(AOwner: TForm; AIP: string; APort, AQueryInterval: integer);
    destructor Destroy; override;
    procedure InitComPort(AIP: string; APort: integer; AModBusMode: TModBusMode; AQueryInterval: integer);
    procedure SendQuery;
    procedure SendBufClear;

    procedure DisconnectTCP;
  published
    property StopComm: Boolean read FStopComm write SetStopComm;
    property TimeOut: integer read FTimeOut write SetTimeOut;
    property QueryInterval: integer read FQueryInterval write SetQueryInterval;
  end;

implementation

uses FrmModbusCom_main2, CommonUtil;

var g_Socket: LongInt;

{ TModBusComThread }

constructor TModBusTCPWagoThread.Create(AOwner: TForm; AIP: string; APort, AQueryInterval: integer);
begin
  inherited Create(True);

  FOwner := AOwner;
  FStopComm := False;
  FEventHandle := TEvent.Create('',False);
  FSendCommandList := TStringList.Create;
  FTimeOut := 3000; //3�� ��ٸ� �Ŀ� ��� ����� ������(Default = INFINITE)
  FBufStr := '';
  QueryInterval := AQueryInterval;
  FModBusMode := TCP_WAGO_MODE;
  InitComPort(AIP, APort, FModBusMode, 1000);
  Resume;
end;

destructor TModBusTCPWagoThread.Destroy;
begin
  DisconnectTCP;
  FEventHandle.Free;
  FSendCommandList.Free;

  inherited;
end;

procedure TModBusTCPWagoThread.DisconnectTCP;
begin
  if FConnected then
  begin
    MBTDisconnect(FSocket);
    MBTExit;
    FConnected := False;
  end;
end;

procedure TModBusTCPWagoThread.Execute;
begin
  while not terminated do
  begin
    if FStopComm then
      Suspend;

    Sleep(FQueryInterval);
    SendQuery;
 end;//while
end;

//�����Ʈ �ʱ�ȭ
//ModBusMode = TCP_WAGO_MODE
procedure TModBusTCPWagoThread.InitComPort(AIP: string; APort: integer; AModBusMode: TModBusMode; AQueryInterval: integer);
var ret: LongInt;
begin
  Suspend;

  FIP :=AIP;
  FModBusMode := AModBusMode;
  FPort:= APort;
  
  FStoreType := stIniFile;
  FQueryInterval := AQueryInterval;

  if FConnected then
    DisconnectTCP;

  //��� ����
  if AIP = '' then
  begin
    SendCopyData2(FOwner.Handle, 'IP �ּҰ� ����!', 1);
    exit;
  end;

  MBTInit;
  SendCopyData2(FOwner.Handle, 'MBTInit', 1);

  ret := MBTConnect(AIP, APort, True, 1000, @g_Socket);
  if ret <> 0 then
  begin
    SendCopyData2(FOwner.Handle, 'MBTConnect Fail!', 1);
    SendCopyData2(FOwner.Handle, 'Couldn''t connect to MB Device: 0x'+IntToHex(Trunc(ret),0), 1);
    MBTExit;
    SendCopyData2(FOwner.Handle, 'MBTExit!', 1);
    FConnected := False;
    Exit;
  end
  else
  begin
    FConnected := True;
    FSocket := g_Socket;
    SendCopyData2(FOwner.Handle, 'MBTConnect Success!', 1);
  end;
  
  resume;
end;

procedure TModBusTCPWagoThread.SendBufClear;
begin
  FillChar(FSendBuf, Length(FSendBuf), #0);
end;

procedure TModBusTCPWagoThread.SendQuery;
var
  BufWord: Array[0..255] of Word;
  i,j, SendLength: integer;
  tmpStr: string;
  LFunctionCode,
  LAddress,
  LCount: integer;
begin
  //Thread�� Suspend�Ǹ� ����ÿ� Resume�� �ѹ� �� �ֹǷ�
  //����ÿ� �� ��ƾ�� ������� �ʰ� �ϱ� ����
  if StopComm then
    exit;

  for i := 0 to FSendCommandList.Count - 1 do
  begin
    if StopComm then
      exit;

    SendCopyData2(FOwner.Handle, ' ', 1);

    //ACSII Mode�� ���
    if FModBusMode = TCP_WAGO_MODE then
    begin
      tmpStr := FSendCommandList.Strings[i];
      LFunctionCode := StrToInt(Copy(tmpStr, 4,2));
      LAddress := HexToInt(Copy(tmpStr, 6,4));
      LCount := HexToInt(Copy(tmpStr, 10,4));

      TModbusComF(FOwner).FRecvWordBuf[0] := LFunctionCode;//Function Code
      TModbusComF(FOwner).FRecvWordBuf[1] := LCount;//Data Count

      //���� �ʱ�ȭ
      FillChar(BufWord, SizeOf(BufWord),0);

      if (LFunctionCode = 1) or (LFunctionCode = 2) then
      begin
        MBTReadCoils(FSocket,
                      MODBUSTCP_TABLE_OUTPUT_COIL,
                      LAddress,
                      LCount,
                      @BufWord,
                      0,0);

        SendLength := LCount div 16;
        if (LCount mod 16) > 0 then
          inc(SendLength);

        for j := 2 to SendLength + 1 do
          TModbusComF(FOwner).FRecvWordBuf[j] := BufWord[j-2];
      end
      else
      if (LFunctionCode = 3) or (LFunctionCode = 4) then
      begin
        MBTReadRegisters(FSocket,
                          MODBUSTCP_TABLE_INPUT_REGISTER,
                          LAddress,
                          LCount,
                          @BufWord,
                          0,0);

        for j := 2 to LCount + 1 do
          TModbusComF(FOwner).FRecvWordBuf[j] := MBTSwapWord(BufWord[j-2]);
      end;

      TModbusComF(FOwner).CurrentCommandIndex := i;
      //��û�� ������ŭ ���ۿ� ���� Main ���� �޼��� ����
      SendMessage(TModbusComF(FOwner).Handle,WM_RECEIVEWORD_TCPWAGO, 0, 0);

      //SendCopyData2(FOwner.Handle, FSendCommandList.Strings[i], 1);
    end;

    if FEventHandle.Wait(FTimeOut) then
    begin
      if terminated then
       exit;
    end
    else
      Continue;

    //Sleep(FQueryInterval);
  end;//for

end;

procedure TModBusTCPWagoThread.SetQueryInterval(Value: integer);
begin
  if FQueryInterval <> Value then
    FQueryInterval := Value;
end;

procedure TModBusTCPWagoThread.SetStopComm(Value: Boolean);
begin
  if FStopComm <> Value then
  begin
    FStopComm := Value;

    if FStopComm then
      //Suspend
    else
      if Suspended then
        Resume;
  end;
end;

procedure TModBusTCPWagoThread.SetTimeOut(Value: integer);
begin
  if FTimeOut <> Value then
    FTimeOUt := Value;
end;

end.
