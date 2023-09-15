unit UnitModBusComThread2;

interface

uses Windows, classes, Forms, CPort, UnitModbusComConst, MyKernelObject, CopyData;

Type
  TModBusComThread = class(TThread)
    FOwner: TForm;
    FComPort: TComPort;     //��� ��Ʈ
    FStoreType: TStoreType; //������(ini or registry)
    FModBusMode: TModBusMode;//ASCII, RTU mode
    FQueryInterval: integer;//ModBus Query ����(mSec)
    FStopComm: Boolean;//��� �Ͻ� ���� = True
    FTimeOut: integer;//��� Send�� ���� Send���� ����ϴ� �ð�(mSec) - INFINITE
    FSendBuf: array[0..255] of byte;//RTU Mode���� ����ϴ� �۽� ����
    FBufStr: String;//ASCII Mode���� ���Ǵ� ���Ź���
    FReqByteCount: integer;//RTU Mode�϶� Send�ÿ� �䱸 ����Ʈ ���� �˾ƾ� üũ����

    procedure OnReceiveChar(Sender: TObject; Count: Integer);
    procedure SetStopComm(Value: Boolean);
    procedure SetTimeOut(Value: integer);
    procedure SetQueryInterval(Value: integer);

  protected
    procedure Execute; override;

  public
    FEventHandle: TEvent;//Send�� �� Receive�Ҷ����� Wait�ϴ� Event
    FSendCommandList: TStringList;//Modbus ��� ��� ����Ʈ
    FWriteCommandList: TStringList;//Write ��� ��� ����Ʈ
    FSendCommandOnce: string;//�ѹ��� Read ���
    FCommMode: TCommMode;
    FIsConfirmMode: Boolean;//write function ���� �� return�� Ȯ���� ���  true

    constructor Create(AOwner: TForm; QueryInterval: integer);
    destructor Destroy; override;
    procedure InitComPort(AIniFile, PortName: string;
              ModBusMode: TModBusMode; QueryInterval: integer);
    procedure SendQuery;
    procedure SendBufClear;
    procedure SetModbusMode(AModbusMode: TModbusMode);
  published
    property CommPort: TComPort read FComPort write FComPort;
    property StopComm: Boolean read FStopComm write SetStopComm;
    property TimeOut: integer read FTimeOut write SetTimeOut;
    property QueryInterval: integer read FQueryInterval write SetQueryInterval;
  end;

implementation

uses FrmModbusCom_main2, CommonUtil;

{ TModBusComThread }

constructor TModBusComThread.Create(AOwner: TForm; QueryInterval: integer);
begin
  inherited Create(True);

  FOwner := AOwner;
  FStopComm := False;
  //FComport := TComport.Create(nil);
  FEventHandle := TEvent.Create('',False);
  FSendCommandList := TStringList.Create;
  FWriteCommandList := TStringList.Create;
  FTimeOut := 3000; //3�� ��ٸ� �Ŀ� ��� ����� ������(Default = INFINITE)
  FBufStr := '';
{  try
    InitComPort('Com1', ASCII_MODE, QueryInterval);
  except
    SendCopyData2(FOwner.Handle, 'Comm port open fail!', 1);
  end;
}
  Resume;
end;

destructor TModBusComThread.Destroy;
begin
  FComport.Free;
  FEventHandle.Free;
  FWriteCommandList.Free;
  FSendCommandList.Free;

  inherited;
end;

procedure TModBusComThread.Execute;
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
//PortName = 'Com1'
//ModBusMode = ASCII_MODE
procedure TModBusComThread.InitComPort(AIniFile, PortName: string;
  ModBusMode: TModBusMode; QueryInterval: integer);
begin
  FStoreType := stIniFile;
  FModBusMode := ModBusMode;
  FQueryInterval := QueryInterval;

  with FComport do
  begin
    FlowControl.ControlDTR := dtrEnable;
    OnRxChar := OnReceiveChar;
    Port := PortName;
    name := Port;
    LoadSettings(FStoreType,TModbusComF(FOwner).FilePath + AIniFile);
    //ShowSetupDialog;
    //StoreSettings(FStoreType,TModbusComF(FOwner).FilePath + INIFILENAME);

    if Connected then
      Close;

    //�����Ʈ�� �����Ѵ�
    Open;
    Sleep(100);
    ClearBuffer(True,True);
  end;//with

end;

procedure TModBusComThread.OnReceiveChar(Sender: TObject; Count: Integer);
var
  TmpBufStr: String;
  BufByte: Array[0..255] of Byte;
begin
  if TModbusComF(FOwner).FCommFail then
    TModbusComF(FOwner).FCommFail := not TModbusComF(FOwner).FCommFail;
  try
    //TModbusComF(FOwner).RxLed.Value := True;
    SendCopyData2(FOwner.Handle, 'RxTrue', 0);

    //ACSII Mode�� ���
    if FModBusMode = ASCII_MODE then
    begin
      //���� �ʱ�ȭ
      TmpBufStr := '';
      //���ۿ� ���ڿ��� ������
      FComPort.ReadStr(TmpBufStr, Count);

      FBufStr := FBufStr + TmpBufStr;

      //CRLF�� ������ ���� �ϼ����� ���� ��Ŷ��
      if System.Pos(#13#10, FBufStr) = 0 then
        exit;

      TModbusComF(FOwner).FCriticalSection.Enter;
      TModbusComF(FOwner).StrBuf := FBufStr;
      FBufStr := '';
      SendMessage(TModbusComF(FOwner).Handle,WM_RECEIVESTRING, 0, 0);
      //FEventHandle.Signal;
      TModbusComF(FOwner).FCriticalSection.Leave;
    end
    else// RTU Mode�� ���
    begin
      //���� �ʱ�ȭ
      FillChar(BufByte, SizeOf(BufByte),0);
      //���ۿ� ��簪�� ������
      FComPort.Read(BufByte, Count);

      TModbusComF(FOwner).FRecvByteBuf.AppendByteArray(BufByte, Count);

      if (FCommMode = CM_DATA_READ) or (FCommMode = CM_CONFIG_READ) then
      begin
        //��û�� ������ŭ ���ۿ� ���� Main ���� �޼��� ����
        //(FReqByteCount*2) ���� 2013.2.20 for HIC
        if TModbusComF(FOwner).FRecvByteBuf.Size >= (FReqByteCount*2) + 5 then
        begin
          if FCommMode = CM_CONFIG_READ then //Read Matrix Data(�ڷᱸ���� CM_DATA_READ�� �ٸ�)
            SendMessage(TModbusComF(FOwner).Handle,WM_RECEIVEBYTE_CONFIGDATA, 0, 0)
          else
            SendMessage(TModbusComF(FOwner).Handle,WM_RECEIVEBYTE, 0, 0);
          //FEventHandle.Signal;
        end;
      end
      else
      if (FCommMode = CM_CONFIG_WRITE) or (FCommMode = CM_CONFIG_WRITE_CONFIRM) then
      begin
        //��û�� ������ŭ ���ۿ� ���� Main ���� �޼��� ����
        if TModbusComF(FOwner).FRecvByteBuf.Size >= 5 then
        begin
          case FCommMode of
            CM_CONFIG_WRITE: SendMessage(TModbusComF(FOwner).Handle,WM_RECEIVEBYTE_WRITE, 3, 0);
            CM_CONFIG_WRITE_CONFIRM: SendMessage(TModbusComF(FOwner).Handle,WM_RECEIVEBYTE_WRITE, 4, 0);
          end;
          //FEventHandle.Signal;
        end;
      end;
    end;
  finally
    //TModbusComF(FOwner).RxLed.Value := False;
    SendCopyData2(FOwner.Handle, 'RxFalse', 0);
  end;
end;

procedure TModBusComThread.SendBufClear;
begin
  FillChar(FSendBuf, Length(FSendBuf), #0);
end;

procedure TModBusComThread.SendQuery;
var
  i, SendLength, j: integer;
  tmpStr: string;

  procedure SendInternalQuery(ACommand: string; Aindex: integer);
  var
    i: integer;
  begin
    if StopComm then
      exit;

    SendCopyData2(FOwner.Handle, ' ', 1);
    //SystemBase���� �����Ϳ����� Send�ÿ� RTS�� High�� �ؾ���
    FComport.SetRTS(True);
    //ACSII Mode�� ���
    if FModBusMode = ASCII_MODE then
    begin
      FComPort.Writestr(ACommand);
      SendCopyData2(FOwner.Handle, ACommand, 1);
    end
    else if FModBusMode = RTU_MODE then// RTU Mode�� ���
    begin
      tmpStr := Copy(ACommand, 1, Length(ACommand));
      SendLength := String2HexByteAry(tmpStr, FSendBuf);
      FReqByteCount := FSendBuf[5];

      if Copy(ACommand, 3, 2) = '01' then
        FReqByteCount := (FReqByteCount div 8) + Ord(FReqByteCount mod 8 > 0);
      FComport.Write(FSendBuf[0], SendLength);
      SendBufClear();
      SendCopyData2(FOwner.Handle, tmpStr, 1);
    end;

    TModbusComF(FOwner).CurrentCommandIndex := Aindex;
    FComport.SetRTS(False);

    if FEventHandle.Wait(FTimeOut) then
    begin
      if terminated then
        exit;
    end;

    Sleep(FQueryInterval);
  end;
begin
  //Thread�� Suspend�Ǹ� ����ÿ� Resume�� �ѹ� �� �ֹǷ�
  //����ÿ� �� ��ƾ�� ������� �ʰ� �ϱ� ����
  if StopComm then
    exit;

  if FWriteCommandList.Count > 0 then
  begin
    if FIsConfirmMode then
    begin
      FCommMode := CM_CONFIG_WRITE_CONFIRM;
      FIsConfirmMode := False;
    end
    else
      FCommMode := CM_CONFIG_WRITE;

    try
      for i := FWriteCommandList.Count - 1 downto 0 do
      begin
        SendCopyData2(FOwner.Handle, '=== Write Command ===', 1);
        SendInternalQuery(FWriteCommandList.Strings[i],i);
        FWriteCommandList.Delete(i);
      end;
    finally
      //FWriteCommandList.Clear;
    end;
  end;

  if FSendCommandOnce <> '' then
  begin
    FCommMode := CM_CONFIG_READ;
    SendCopyData2(FOwner.Handle, '=== Once Read Command ===', 1);
    SendInternalQuery(FSendCommandOnce, -1);
    FSendCommandOnce := '';
  end;

  for i := 0 to FSendCommandList.Count - 1 do
  begin
    FCommMode := CM_DATA_READ;

    SendInternalQuery(FSendCommandList.Strings[i],i);
  end;//for
end;

procedure TModBusComThread.SetModbusMode(AModbusMode: TModbusMode);
begin
  FModBusMode := AModBusMode;
end;

procedure TModBusComThread.SetQueryInterval(Value: integer);
begin
  if FQueryInterval <> Value then
    FQueryInterval := Value;
end;

procedure TModBusComThread.SetStopComm(Value: Boolean);
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

procedure TModBusComThread.SetTimeOut(Value: integer);
begin
  if FTimeOut <> Value then
    FTimeOUt := Value;
end;

end.
