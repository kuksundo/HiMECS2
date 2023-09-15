unit UnitModBusTCPThread2;

interface

uses Windows, sysutils, classes, Forms, CPort, UnitModbusComConst, MyKernelObject,
  CopyData, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdModBusClient, IdModBusSerialClient;

Type
  TModBusTCPThread = class(TThread)
    FOwner: TForm;
    FStoreType: TStoreType; //������(ini or registry)
    FModBusMode: TModBusMode;//ASCII, RTU mode, TCP_WAGO_MODE
    FQueryInterval: integer;//ModBus Query ����(mSec)
    FStopComm: Boolean;//��� �Ͻ� ���� = True
    FTimeOut: integer;//��� Send�� ���� Send���� ����ϴ� �ð�(mSec) - INFINITE
    FRequestTimeOut: integer;//Connect �� ���� ��� �ð�
    FBufStr: String;//ASCII Mode���� ���Ǵ� ���Ź���
    FReqByteCount: integer;//RTU Mode�϶� Send�ÿ� �䱸 ����Ʈ ���� �˾ƾ� üũ����
    FConnected: Boolean;//TCP ����Ǹ� True
    procedure SetStopComm(Value: Boolean);
    procedure SetTimeOut(Value: integer);
    procedure SetQueryInterval(Value: integer);

  protected
    FIdModBusClient: TIdModBusClient;
    FIdModBusClientSerial: TIdModBusSerialClient;

    procedure Execute; override;

  public
    FIP: string;
    FBindIP: string;
    FPort: integer;

    FEventHandle: TEvent;//Send�� �� Receive�Ҷ����� Wait�ϴ� Event
    FSendCommandList: TStringList;//Modbus ��� ��� ����Ʈ

    constructor Create(AOwner: TForm; AIP: string; APort, AQueryInterval: integer; AModbusMode: integer = -1; ABindIP: string = '');
    destructor Destroy; override;
    procedure InitComPort(AIP: string; APort: integer; AModBusMode: TModBusMode; AQueryInterval: integer; ASlaveNo: integer = 0; ABindIP: string = '');
    procedure SendQuery;

    procedure DisconnectTCP;
  published
    property StopComm: Boolean read FStopComm write SetStopComm;
    property TimeOut: integer read FTimeOut write SetTimeOut;
    property QueryInterval: integer read FQueryInterval write SetQueryInterval;
  end;

implementation

uses FrmModbusCom_main2, CommonUtil;

{ TModBusComThread }

constructor TModBusTCPThread.Create(AOwner: TForm; AIP: string; APort, AQueryInterval: integer; AModbusMode: integer; ABindIP: string);
begin
  inherited Create(True);

  FOwner := AOwner;
  FStopComm := False;
  FEventHandle := TEvent.Create('',False);
  FSendCommandList := TStringList.Create;
  FTimeOut := 3000; //3�� ��ٸ� �Ŀ� ��� ����� ������(Default = INFINITE)
  FBufStr := '';
  QueryInterval := AQueryInterval;

  if TModBusMode(AModbusMode) = MODBUSSERIAL_TCP_MODE then
  begin
    FModBusMode := TModbusMode(AModbusMode);
    FIdModBusClientSerial := TIdModBusSerialClient.Create(AOwner);
  end
  else
  begin
    FModBusMode := MODBUSTCP_MODE;
    FIdModBusClient := TIdModBusClient.Create(AOwner);
  end;
  //InitComPort(AIP, APort, FModBusMode, 1000);
  //Resume;
end;

destructor TModBusTCPThread.Destroy;
begin
  DisconnectTCP;

  if Assigned(FIdModBusClient) then
    FreeAndNil(FIdModBusClient);

  if Assigned(FIdModBusClientSerial) then
    FreeAndNil(FIdModBusClientSerial);

  FEventHandle.Free;
  FSendCommandList.Free;

  inherited;
end;

procedure TModBusTCPThread.DisconnectTCP;
begin
  if FConnected then
  begin
    if FModbusMode = MODBUSTCP_MODE then
      FIdModBusClient.Disconnect
    else
    if FModbusMode = MODBUSSERIAL_TCP_MODE then
      FIdModBusClientSerial.Disconnect;

    FConnected := False;
  end;
end;

procedure TModBusTCPThread.Execute;
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
procedure TModBusTCPThread.InitComPort(AIP: string; APort: integer;
  AModBusMode: TModBusMode; AQueryInterval: integer; ASlaveNo: integer;
  ABindIP: string);
var ret: LongInt;
begin
  Suspend;

  FIP :=AIP;
  FBindIP := ABindIP;

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

  if FModbusMode = MODBUSTCP_MODE then
  begin
    FIdModBusClient.Host := FIP;
    //Modbustcp Default Port = 502
    if FPort <> 0 then
      FIdModBusClient.Port := FPort;

    if FBindIP <> '' then
      FIdModBusClient.BoundIP := FBindIP;

    SendCopyData2(FOwner.Handle, 'TCP Init...', 1);

    FIdModBusClient.Connect;
    FIdModBusClient.BaseRegister := 0;
  end
  else
  if FModbusMode = MODBUSSERIAL_TCP_MODE then
  begin
    FIdModBusClientSerial.Host := FIP;
    //ezTCP Converter Default Port = 521
    if FPort <> 0 then
      FIdModBusClientSerial.Port := FPort;

    SendCopyData2(FOwner.Handle, 'TCP Init...', 1);

    FIdModBusClientSerial.Connect;
    FIdModBusClientSerial.BaseRegister := 0;
    FIdModBusClientSerial.ReadTimeout := FTimeOut;
    FIdModBusClientSerial.FSlaveNumber := ASlaveNo;
  end;

  FConnected := True;
  SendCopyData2(FOwner.Handle, 'TCP Connect Success!', 1);

  resume;
end;

procedure TModBusTCPThread.SendQuery;
var
  BufWord: Array[0..255] of Word;
  BufBool: Array[0..MAX_DIGITAL_DATA] of Boolean;
  i,j, SendLength: integer;
  tmpStr: string;
  LFunctionCode,
  LAddress,
  LCount: integer;
  LBool: Boolean;
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

    //MODBUSTCP Mode�� ���
    if (FModBusMode = MODBUSTCP_MODE) or (FModBusMode = MODBUSSERIAL_TCP_MODE) then
    begin
      //tmpStr := FSendCommandList.Strings[i];
      //LFunctionCode := StrToInt(Copy(tmpStr, 4,2));
      //LAddress := HexToInt(Copy(tmpStr, 6,4));
      //LCount := HexToInt(Copy(tmpStr, 10,4));

      //���� �ʱ�ȭ
      FillChar(BufWord, SizeOf(BufWord),0);
      LFunctionCode := TModbusTCP_Command(FSendCommandList.Objects[i]).FFunctionCode;
      LAddress := TModbusTCP_Command(FSendCommandList.Objects[i]).FStartAddress;
      LCount := TModbusTCP_Command(FSendCommandList.Objects[i]).FDataCountWord;

      TModbusComF(FOwner).FRecvWordBuf[0] := LFunctionCode;//Function Code
      TModbusComF(FOwner).FRecvWordBuf[1] := LCount;//Data Count
//      SendCopyData2(FOwner.Handle, FSendCommandList.Strings[i] + IntToHex(Hi(FIdModBusClientSerial.FCRC),2), 1);

      if FModBusMode = MODBUSTCP_MODE then
      begin
        FIdModBusClient.UnitID := TModbusTCP_Command(FSendCommandList.Objects[i]).FSlaveAddress;

        case LFunctionCode of
          1 :FIdModBusClient.ReadCoils(LAddress, LCount, BufBool);
          2 :FIdModBusClient.ReadInputBits(LAddress, LCount, BufBool);
          3 :FIdModBusClient.ReadHoldingRegisters(LAddress, LCount, BufWord);
          4 :FIdModBusClient.ReadInputRegisters(LAddress, LCount, BufWord);
          16:begin
            if TModbusTCP_Command(FSendCommandList.Objects[i]).FRepeatCount = -1 then
              FIdModBusClient.WriteRegisters(LAddress, TModbusTCP_Command(FSendCommandList.Objects[i]).FBufferWord)
            else
            if TModbusTCP_Command(FSendCommandList.Objects[i]).FRepeatCount > 0 then
            begin
              FIdModBusClient.WriteRegisters(LAddress, TModbusTCP_Command(FSendCommandList.Objects[i]).FBufferWord);
              Dec(TModbusTCP_Command(FSendCommandList.Objects[i]).FRepeatCount);
            end
            else
            if TModbusTCP_Command(FSendCommandList.Objects[i]).FRepeatCount = 0 then
            begin
              TModbusTCP_Command(FSendCommandList.Objects[i]).Free;
              FSendCommandList.Delete(i);
            end;
          end;
        end;

        LFunctionCode := TModbusTCP_Command(FSendCommandList.Objects[i]).FFunctionCode;
        LCount := TModbusTCP_Command(FSendCommandList.Objects[i]).FDataCountWord;
      end
      else
      if FModBusMode = MODBUSSERIAL_TCP_MODE then
      begin
        case LFunctionCode of
          1 :FIdModBusClientSerial.ReadCoils_Serial(LAddress, LCount, BufBool);
          2 :FIdModBusClientSerial.ReadInputBits_Serial(LAddress, LCount, BufBool);
          3 :FIdModBusClientSerial.ReadHoldingRegisters_Serial(LAddress, LCount, BufWord);
          4 :FIdModBusClientSerial.ReadInputRegisters_Serial(LAddress, LCount, BufWord);
          16:begin
            if TModbusTCP_Command(FSendCommandList.Objects[i]).FRepeatCount = -1 then
              FIdModBusClientSerial.WriteRegisters_Serial(LAddress, TModbusTCP_Command(FSendCommandList.Objects[i]).FBufferWord)
            else
            if TModbusTCP_Command(FSendCommandList.Objects[i]).FRepeatCount > 0 then
            begin
              FIdModBusClientSerial.WriteRegisters_Serial(LAddress, TModbusTCP_Command(FSendCommandList.Objects[i]).FBufferWord);
              Dec(TModbusTCP_Command(FSendCommandList.Objects[i]).FRepeatCount);
            end
            else
            if TModbusTCP_Command(FSendCommandList.Objects[i]).FRepeatCount = 0 then
            begin
              TModbusTCP_Command(FSendCommandList.Objects[i]).Free;
              FSendCommandList.Delete(i);
            end;
          end;
        end;

        LFunctionCode := TModbusTCP_Command(FSendCommandList.Objects[i]).FFunctionCode;
        LCount := TModbusTCP_Command(FSendCommandList.Objects[i]).FDataCountWord;
      end;

      SendCopyData2(FOwner.Handle, '(' + IntToStr(i+1) + ') ' + FSendCommandList.Strings[i], 1);

      if (LFunctionCode = 1) or (LFunctionCode = 2) then
      begin
        SendLength := LCount div 16;
        if (LCount mod 16) > 0 then
          inc(SendLength);

        for j := 0 to LCount - 1 do
          TModbusComF(FOwner).FRecvBoolBuf[j] := BufBool[j];
      end
      else
      if (LFunctionCode = 3) or (LFunctionCode = 4) then
      begin
        for j := 2 to LCount + 1 do
          TModbusComF(FOwner).FRecvWordBuf[j] := BufWord[j-2];
      end;

      TModbusComF(FOwner).CurrentCommandIndex := i;
      //��û�� ������ŭ ���ۿ� ���� Main ���� �޼��� ����
      SendMessage(TModbusComF(FOwner).Handle,WM_RECEIVEWORD_TCP, 0, 0);
    end;

    if FEventHandle.Wait(FTimeOut) then
    begin
      if terminated then
       exit;
    end
    else
      Continue;

    Sleep(FQueryInterval);

  end;//for

end;

procedure TModBusTCPThread.SetQueryInterval(Value: integer);
begin
  if FQueryInterval <> Value then
    FQueryInterval := Value;
end;

procedure TModBusTCPThread.SetStopComm(Value: Boolean);
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

procedure TModBusTCPThread.SetTimeOut(Value: integer);
begin
  if FTimeOut <> Value then
    FTimeOUt := Value;
end;

end.
