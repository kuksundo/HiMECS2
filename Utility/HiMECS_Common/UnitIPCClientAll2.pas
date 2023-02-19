unit UnitIPCClientAll2;
{
  ParameterSource 추가 시 수정해야 하는 내용>--
    procedure CreateECSComAPIPCClient(ASharedName: string = ''); 함수 추가
    FIPCClient_ECS_ComAP2: TIPCClient<TEventData_Modbus_Standard>; 변수 추가
    procedure PulseEventData_ECS_ComAP2(AData: TEventData_Modbus_Standard); 함수 추가
    procedure PulseEventData(AData: TEventData_Modbus_Standard); 에서 내용 수정
   --<
이 유닛은 FEngineParameter의 value만 저장함.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IPC_LBX_Const, IPC_WT1600_Const, IPC_ECS_kumo_Const, IPC_MEXA7000_Const,
  IPC_MT210_Const, IPC_DYNAMO_Const, IPC_ECS_AVAT_Const, IPC_GasCalc_Const,
  IPC_Kral_Const, IPC_ECS_Woodward_Const, IPC_PLC_S7_Const, IPC_FlowMeter_Const,
  IPC_EngineParam_Const, IPC_HIC_Const, IPC_Modbus_Standard_Const, IPC_PMS_Const,
  HiMECSConst, UnitEngineParameterClass2, IPCThrdClient_Generic, IPC_FGSS_KM_Const,
  GpSharedMemory, GpSharedEvents
;

type
  TIPCClientAll = class(TObject)
  private
    procedure AddIPCClientList(ASharedName: string; AParamSource:TParameterSource);

    procedure CreateECSkumoIPCClient(ASharedName: string = '');
    procedure CreateECSkumo2IPCClient(ASharedName: string = '');
    procedure CreateECSAVATIPCClient(ASharedName: string = '');
    procedure CreateWoodwardIPCClient(ASharedName: string = '');
    procedure CreateWT1600IPCClient(ASharedName: string = '');
    procedure CreateMT210IPCClient(ASharedName: string = '');
    procedure CreateMEXA7000IPCClient(ASharedName: string = '');
    procedure CreateLBXIPCClient(ASharedName: string = '');
    procedure CreateFlowMeterIPCClient(ASharedName: string = '');
    procedure CreateDynamoIPCClient(ASharedName: string = '');
    procedure CreateGasCalcIPCClient(ASharedName: string = '');
    procedure CreateKRALIPCClient(ASharedName: string = '');
    procedure CreatePLCS7IPCClient(ASharedName: string = '');
    procedure CreateEngineParamIPCClient(ASharedName: string = '');
    procedure CreateHICIPCClient(ASharedName: string = '');
    procedure CreateUnKnownIPCClient(ASharedName: string = '');
    procedure CreatePLCModbusIPCClient(ASharedName: string = '');
    procedure CreatePMSOPCIPCClient(ASharedName: string = '');
    procedure CreateECSComAPIPCClient(ASharedName: string = '');
    procedure CreateECSComAPIPCClient2(ASharedName: string = '');
    procedure CreateFGSSKMIPCClient(ASharedName: string = '');
    procedure CreateECSAVAT2IPCClient(ASharedName: string = '');
    procedure CreateSCRBACHMANNIPCClient(ASharedName: string = '');
    procedure CreateEGCSSCHNEIDERIPCClient(ASharedName: string = '');
    procedure CreateECSWago8212IPCClient(ASharedName: string = '');
  protected
    FEventName: string;
  public
    FIPCClientList: TStringList;
    FEngineParameter: TEngineParameter;
    FEngineParameterItemRecord: TEngineParameterItemRecord; //Save폼에 값 전달시 사용
    FProjNo, FEngNo: string;

    {FECSData_kumo: TEventData_ECS_kumo;
    FECSData_AVAT: TEventData_ECS_AVAT;
    FECSData_Woodward: TEventData_ECS_Woodward;
    FMEXA7000Data: TEventData_MEXA7000_2;
    FLBXData: TEventData_LBX;
    FWT1600Data: TEventData_WT1600;
    FMT210Data: TEventData_MT210;
    FDYNAMODat2a: TEventData_DYNAMO;
    FFlowMeterData: TEventData_FlowMeter;
    FGasCalcData: TEventData_GasCalc;
    FKRALData: TEventData_KRAL;
    FPLCData_S7: TEventData_PLC_S7;
    FEngineParamData: TEventData_EngineParam;
    }
    FIPCClient_WT1600: TIPCClient<TEventData_WT1600>;//WT1600
    FIPCClient_MEXA7000: TIPCClient<TEventData_MEXA7000_2>;//MEXA7000
    FIPCClient_MT210: TIPCClient<TEventData_MT210>;//MT210
    FIPCClient_ECS_kumo: TIPCClient<TEventData_ECS_kumo>;//kumo ECS
    FIPCClient_ECS_AVAT: TIPCClient<TEventData_ECS_AVAT>;//AVAT ECS
    FIPCClient_ECS_Woodward: TIPCClient<TEventData_ECS_Woodward>;//Woodward(AtlasII) ECS
    FIPCClient_LBX: TIPCClient<TEventData_LBX>;//LBX
    FIPCClient_FlowMeter: TIPCClient<TEventData_FlowMeter>;//FlowMeter
    FIPCClient_Dynamo: TIPCClient<TEventData_DYNAMO>;//DynamoMeter
    FIPCClient_GasCalc: TIPCClient<TEventData_GasCalc>;//Gas Total
    FIPCClient_KRAL: TIPCClient<TEventData_Modbus_Standard>;//FlowMeter(KRAL)
    FIPCClient_PLC_S7: TIPCClient<TEventData_PLC_S7>;//Siemens PLC S7-300
    FIPCClient_EngineParam: TIPCClient<TEventData_EngineParam>;//Engine Parameter file
    FIPCClient_HIC: TIPCClient<TEventData_HIC>;//Hybrid Injector Controller
    FIPCClient_UnKnown: TIPCClient<TEventData_Modbus_Standard>;//UnKnown Source
    FIPCClient_PLC_Modbus: TIPCClient<TEventData_Modbus_Standard>;//PLC Modbus
    FIPCClient_PMSOPC: TIPCClient<TEventData_PMS>;//PMS OPC
    FIPCClient_ECS_ComAP: TIPCClient<TEventData_Modbus_Standard>;//ComAP ECS
    FIPCClient_ECS_ComAP2: TIPCClient<TEventData_Modbus_Standard>;//ComAP ECS
    FIPCClient_FGSS_KM: TIPCClient<TEventData_FGSS_KM>;//FGSS-KM Simulator
    FIPCClient_ECS_AVAT2: TIPCClient<TEventData_Modbus_Standard>;//AVAT ECS2
    FIPCClient_SCR_Bachmann: TIPCClient<TEventData_Modbus_Standard>;//SCR
    FIPCClient_EGCS_Schneider: TIPCClient<TEventData_Modbus_Standard>;//EGCS
    FIPCClient_ECS_Wago8212: TIPCClient<TEventData_Modbus_Standard>;//EGCS

    FgpSharedMM: TGpSharedMemory;
    FGpSharedEventProducer: TGpSharedEventProducer;
//    FGpSharedEventListener: TGpSharedEventListener;

    constructor Create;
    destructor Destroy;
    procedure InitVar;
    procedure ClearIPCClientAll;
    procedure ReadAddressFromParamFile(AFileName: string;
      AEncrypt: Bool = False; AFileFormat: integer = 1);
    function GetEventName: string;
    function GetEngineName: string;

    procedure CreateIPCClient(APS: TParameterSource; ASharedName: string = '');
    procedure DestroyIPCClient(AIPCClient: TParameterSource);
    procedure CreateIPCClientFromParam;
    procedure CreateIPCClientAll;

    procedure PulseEventDataFromInt(AEventSource: integer);
    procedure PulseEventData<T>(AData: T);
    procedure PulseEventData_ECS_kumo<T>(AData: T);
    procedure PulseEventData_ECS_AVAT<T>(AData: T);
    procedure PulseEventData_ECS_Woodward<T>(AData: T);
    procedure PulseEventData_WT1600<T>(AData: T);
    procedure PulseEventData_MEXA7000<T>(AData: T);
    procedure PulseEventData_MT210<T>(AData: T);
    procedure PulseEventData_LBX<T>(AData: T);
    procedure PulseEventData_FlowMeter<T>(AData: T);
    procedure PulseEventData_Dynamo<T>(AData: T);
    procedure PulseEventData_GasCalc<T>(AData: T);
    procedure PulseEventData_KRAL<T>(AData: T);
    procedure PulseEventData_PLC_S7<T>(AData: T);
    procedure PulseEventData_EngineParam<T>(AData: T);
    procedure PulseEventData_HIC<T>(AData: T);
    procedure PulseEventData_UnKnown<T>(AData: T);
    procedure PulseEventData_PLC_Modbus<T>(AData: T);
    procedure PulseEventData_PMSOPC<T>(AData: T);
    procedure PulseEventData_ECS_ComAP<T>(AData: T);
    procedure PulseEventData_ECS_ComAP2<T>(AData: T);
    procedure PulseEventData_FGSS_KM<T>(AData: T);
    procedure PulseEventData_ECS_AVAT2<T>(AData: T);
    procedure PulseEventData_SCR_Bachmann<T>(AData: T);
    procedure PulseEventData_EGCS_Schneider<T>(AData: T);
    procedure PulseEventData_ECS_Wago8212<T>(AData: T);

    procedure MakeEventData;
    procedure MakeEngParamDataFromCSV(var AEventData: TEventData_EngineParam; ACsv: string);
    procedure MakeModbusStandardFromCSV(var AEventData: TEventData_Modbus_Standard; ACsv: string);
    procedure Make_PulseEventData_PLC_Modbus;

    procedure InitgpSharedMemory4Producer(const ASMName, ANameSpace, AEventName: string);
    procedure AddEventName2gpSMProducer(const AEventName: string);
    procedure FinalgpSharedMemory4Producer;
    procedure SendData2gpSM(const AEventName, AData: string);
  end;

implementation

uses UnitStringUtil, UnitSimulateCommonData, UnitSimulateParamCommandLineOption2;

procedure TIPCClientAll.AddEventName2gpSMProducer(const AEventName: string);
begin
  if Assigned(FGpSharedEventProducer) then
    if AEventName <> '' then
      FGpSharedEventProducer.PublishedEvents.Add(AEventName);
end;

procedure TIPCClientAll.AddIPCClientList(ASharedName: string;
  AParamSource:TParameterSource);
begin
  if FIPCClientList.IndexOf(ASharedName) = -1 then
  begin
    FIPCClientList.AddObject(ASharedName, TObject(AParamSource));
  end;
end;

procedure TIPCClientAll.ClearIPCClientAll;
var
  i: integer;
  LParamSource: TParameterSource;
begin
  for i := 0 to FIPCClientList.Count - 1 do
  begin
    LParamSource := TParameterSource(FIPCClientList.Objects[i]);

    case TParameterSource(LParamSource) of
      psECS_kumo: if Assigned(FIPCClient_ECS_kumo) then FreeAndNil(FIPCClient_ECS_kumo);
      psECS_AVAT: if Assigned(FIPCClient_ECS_AVAT) then FreeAndNil(FIPCClient_ECS_AVAT);
      psMT210: if Assigned(FIPCClient_MT210) then FreeAndNil(FIPCClient_MT210);
      psMEXA7000: if Assigned(FIPCClient_MEXA7000) then FreeAndNil(FIPCClient_MEXA7000);
      psLBX: if Assigned(FIPCClient_LBX) then FreeAndNil(FIPCClient_LBX);
      psFlowMeter: if Assigned(FIPCClient_FlowMeter) then FreeAndNil(FIPCClient_FlowMeter);
      psWT1600: if Assigned(FIPCClient_WT1600) then FreeAndNil(FIPCClient_WT1600);
      //psGasCalculated: if Assigned() then FreeAndNil(FIPCClient_ECS_kumo);
      psECS_Woodward: if Assigned(FIPCClient_ECS_Woodward) then FreeAndNil(FIPCClient_ECS_Woodward);
      //psFlowMeterKral: if Assigned() then FreeAndNil(FIPCClient_ECS_kumo);
      psDynamo: if Assigned(FIPCClient_Dynamo) then FreeAndNil(FIPCClient_Dynamo);
      psPLC_S7: if Assigned(FIPCClient_PLC_S7) then FreeAndNil(FIPCClient_PLC_S7);
      psHIC: if Assigned(FIPCClient_HIC) then FreeAndNil(FIPCClient_HIC);
      psUnKnown: if Assigned(FIPCClient_UnKnown) then FreeAndNil(FIPCClient_UnKnown);
      psEngineParam: if Assigned(FIPCClient_EngineParam) then FreeAndNil(FIPCClient_EngineParam);
      psPLC_Modbus: if Assigned(FIPCClient_PLC_Modbus) then FreeAndNil(FIPCClient_PLC_Modbus);
      psPMSOPC: if Assigned(FIPCClient_PMSOPC) then FreeAndNil(FIPCClient_PMSOPC);
      psECS_ComAP: if Assigned(FIPCClient_ECS_ComAP) then FreeAndNil(FIPCClient_ECS_ComAP);
      psECS_ComAP2: if Assigned(FIPCClient_ECS_ComAP2) then FreeAndNil(FIPCClient_ECS_ComAP2);
      psFGSS_KM: if Assigned(FIPCClient_FGSS_KM) then FreeAndNil(FIPCClient_FGSS_KM);
      psECS_AVAT2: if Assigned(FIPCClient_ECS_AVAT2) then FreeAndNil(FIPCClient_ECS_AVAT2);
      psSCR_BachMann: if Assigned(FIPCClient_SCR_Bachmann) then FreeAndNil(FIPCClient_SCR_Bachmann);
      psScrubber_Schneider: if Assigned(FIPCClient_EGCS_Schneider) then FreeAndNil(FIPCClient_EGCS_Schneider);
      psECS_Wago8212: if Assigned(FIPCClient_ECS_Wago8212) then FreeAndNil(FIPCClient_ECS_Wago8212);
    end;
  end;

  FIPCClientList.Clear;
end;

constructor TIPCClientAll.Create;
begin
  InitVar;
end;

procedure TIPCClientAll.CreateDynamoIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_Dynamo) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psDynamo)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psDynamo);
  FIPCClient_Dynamo := TIPCClient<TEventData_DYNAMO>.Create(LSM, LSM2, True);//DYNAMO_EVENT_NAME
  AddIPCClientList(LSM, psDynamo);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateECSAVAT2IPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_ECS_AVAT2) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psECS_AVAT2)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psECS_AVAT2);
  FIPCClient_ECS_AVAT2 := TIPCClient<TEventData_Modbus_Standard>.Create(LSM, LSM2, True);
  AddIPCClientList(LSM, psECS_AVAT2);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateECSAVATIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_ECS_AVAT) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psECS_AVAT)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psECS_AVAT);
  FIPCClient_ECS_AVAT := TIPCClient<TEventData_ECS_AVAT>.Create(LSM, LSM2, True); //ECS_AVAT_EVENT_NAME
  AddIPCClientList(LSM, psECS_AVAT);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateECSComAPIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_ECS_ComAP) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psECS_ComAP)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psECS_ComAP);
  FIPCClient_ECS_ComAP := TIPCClient<TEventData_Modbus_Standard>.Create(LSM, LSM2, True);//PLCMODBUS_EVENT_NAME
  AddIPCClientList(LSM, psECS_ComAP);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateECSComAPIPCClient2(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_ECS_ComAP2) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psECS_ComAP2)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psECS_ComAP2);
  FIPCClient_ECS_ComAP2 := TIPCClient<TEventData_Modbus_Standard>.Create(LSM, LSM2, True);//PLCMODBUS_EVENT_NAME
  AddIPCClientList(LSM, psECS_ComAP2);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateECSkumo2IPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_ECS_kumo) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psECS_kumo2)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psECS_kumo2);

  FIPCClient_ECS_kumo := TIPCClient<TEventData_ECS_kumo>.Create(LSM, LSM2, True); //ECS_KUMO_EVENT_NAME
  AddIPCClientList(LSM, psECS_kumo2);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateECSkumoIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_ECS_kumo) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psECS_kumo)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psECS_kumo);

  FIPCClient_ECS_kumo := TIPCClient<TEventData_ECS_kumo>.Create(LSM, LSM2, True); //ECS_KUMO_EVENT_NAME
  AddIPCClientList(LSM, psECS_kumo);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateECSWago8212IPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_ECS_Wago8212) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psECS_Wago8212)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psECS_Wago8212);
  FIPCClient_ECS_Wago8212 := TIPCClient<TEventData_Modbus_Standard>.Create(LSM, LSM2, True);
  AddIPCClientList(LSM, psECS_Wago8212);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateEGCSSCHNEIDERIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_EGCS_Schneider) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psScrubber_Schneider)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psScrubber_Schneider);
  FIPCClient_EGCS_Schneider := TIPCClient<TEventData_Modbus_Standard>.Create(LSM, LSM2, True);
  AddIPCClientList(LSM, psScrubber_Schneider);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateEngineParamIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_EngineParam) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psEngineParam)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psEngineParam);

  FIPCClient_EngineParam := TIPCClient<TEventData_EngineParam>.Create(LSM, LSM2, True);//ENGINEPARAM_EVENT_NAME
  AddIPCClientList(LSM, psEngineParam);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateFGSSKMIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_FGSS_KM) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psFGSS_KM)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psFGSS_KM);
  FIPCClient_FGSS_KM := TIPCClient<TEventData_FGSS_KM>.Create(LSM, LSM2, True);
  AddIPCClientList(LSM, psFGSS_KM);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateFlowMeterIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_FlowMeter) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psFlowMeter)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psFlowMeter);
  FIPCClient_FlowMeter := TIPCClient<TEventData_FlowMeter>.Create(LSM, LSM2, True);//FLOWMETER_EVENT_NAME
  AddIPCClientList(LSM, psFlowMeter);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateGasCalcIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_GasCalc) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psGasCalculated)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psGasCalculated);
  FIPCClient_GasCalc := TIPCClient<TEventData_GasCalc>.Create(LSM, LSM2, True);//GASCALC_EVENT_NAME
  AddIPCClientList(LSM, psGasCalculated);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateHICIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_HIC) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psHIC)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psHIC);
  FIPCClient_HIC := TIPCClient<TEventData_HIC>.Create(LSM, LSM2, True);//HIC_EVENT_NAME
  AddIPCClientList(LSM, psHIC);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateIPCClient(APS: TParameterSource; ASharedName: string);
begin
  case TParameterSource(APS) of
    psECS_kumo: CreateECSkumoIPCClient(ASharedName);
    psECS_kumo2: CreateECSkumo2IPCClient(ASharedName);
    psECS_AVAT: CreateECSAVATIPCClient(ASharedName);
    psMT210: CreateMT210IPCClient(ASharedName);
    psMEXA7000: CreateMEXA7000IPCClient(ASharedName);
    psLBX: CreateLBXIPCClient(ASharedName);
    psFlowMeter: CreateFlowMeterIPCClient(ASharedName);
    psWT1600: CreateWT1600IPCClient(ASharedName);
    psGasCalculated: CreateGasCalcIPCClient(ASharedName);
    psECS_Woodward: CreateWoodwardIPCClient(ASharedName);
    psDynamo: CreateDynamoIPCClient(ASharedName);
    psFlowMeterKral: CreateKRALIPCClient(ASharedName);
    psPLC_S7: CreatePLCS7IPCClient(ASharedName);
    psEngineParam: CreateEngineParamIPCClient(ASharedName);
    psHIC: CreateHICIPCClient(ASharedName);
    psUnKnown: CreateUnKnownIPCClient(ASharedName);
    psPLC_Modbus: CreatePLCModbusIPCClient(ASharedName);
    psPMSOPC: CreatePMSOPCIPCClient(ASharedName);
    psECS_ComAP: CreateECSComAPIPCClient(ASharedName);
    psECS_ComAP2: CreateECSComAPIPCClient2(ASharedName);
    psFGSS_KM: CreateFGSSKMIPCClient(ASharedName);
    psECS_AVAT2: CreateECSAVAT2IPCClient(ASharedName);
    psSCR_BachMann: CreateSCRBACHMANNIPCClient(ASharedName);
    psScrubber_Schneider: CreateEGCSSCHNEIDERIPCClient(ASharedName);
    psECS_Wago8212: CreateECSWago8212IPCClient(ASharedName);
  else
    AddIPCClientList('UnKnown Parameter Source.', psUnKnown);
  end;
end;

procedure TIPCClientAll.CreateIPCClientAll;
var
  i: integer;
  LPS: TParameterSource;
  LSN: string;
begin
  for i := 0 to FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    LPS := FEngineParameter.EngineParameterCollect.Items[i].ParameterSource;

    if FEngineParameter.EngineParameterCollect.Items[i].SharedName = '' then
      LSN := ParameterSource2SharedMN(LPS)
    else
      LSN := FEngineParameter.EngineParameterCollect.Items[i].SharedName;

    //List에 없으면 생성
    if FIPCClientList.IndexOf(LSN) = -1 then
    begin
//      LSN := FEngineParameter.EngineParameterCollect.Items[i].SharedName;

//      if LSN = '' then
//        LSN := ParameterSource2SharedMN(LPS);

      CreateIPCClient(LPS, LSN);
    end;
  end;
end;

procedure TIPCClientAll.CreateIPCClientFromParam;
var
  i: integer;
begin
  //for i := 0 to FEngineParameter.EngineParameterCollect.Count - 1 do
  //begin
    //CreateIPCClient(FEngineParameter.EngineParameterCollect.Items[i].ParameterSource);
    CreateIPCClient(psEngineParam);
  //end; //for
end;

procedure TIPCClientAll.CreateKRALIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_KRAL) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psFlowMeterKral)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psFlowMeterKral);
  FIPCClient_KRAL := TIPCClient<TEventData_Modbus_Standard>.Create(LSM, LSM2, True);//KRAK_EVENT_NAME
  AddIPCClientList(LSM, psFlowMeterKral);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateLBXIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_LBX) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psLBX)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psLBX);
  FIPCClient_LBX := TIPCClient<TEventData_LBX>.Create(LSM, LSM2, True);//LBX_EVENT_NAME
  AddIPCClientList(LSM, psLBX);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateMEXA7000IPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_MEXA7000) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psMEXA7000)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psMEXA7000);
  FIPCClient_MEXA7000 := TIPCClient<TEventData_MEXA7000_2>.Create(LSM, LSM2, True);//MEXA7000_EVENT_NAME
  AddIPCClientList(LSM, psMEXA7000);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateMT210IPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_MT210) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psMT210)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psMT210);

  FIPCClient_MT210 := TIPCClient<TEventData_MT210>.Create(LSM, LSM2, True);//MT210_EVENT_NAME
  AddIPCClientList(LSM, psMT210);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreatePLCModbusIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_PLC_Modbus) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psPLC_Modbus)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psPLC_Modbus);
  FIPCClient_PLC_Modbus := TIPCClient<TEventData_Modbus_Standard>.Create(LSM, LSM2, True);//PLCMODBUS_EVENT_NAME
  AddIPCClientList(LSM, psPLC_Modbus);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreatePLCS7IPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_PLC_S7) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psPLC_S7)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psPLC_S7);

  FIPCClient_PLC_S7 := TIPCClient<TEventData_PLC_S7>.Create(LSM, LSM2, True);//PLC_S7_EVENT_NAME
  AddIPCClientList(LSM, psPLC_S7);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreatePMSOPCIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_PMSOPC) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psPMSOPC)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psPMSOPC);
  FIPCClient_PMSOPC := TIPCClient<TEventData_PMS>.Create(LSM, LSM2, True);//PMS_EVENT_NAME
  AddIPCClientList(LSM, psPMSOPC);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateSCRBACHMANNIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_SCR_Bachmann) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psSCR_BachMann)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psSCR_BachMann);
  FIPCClient_SCR_Bachmann := TIPCClient<TEventData_Modbus_Standard>.Create(LSM, LSM2, True);
  AddIPCClientList(LSM, psSCR_BachMann);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateUnKnownIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_UnKnown) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psUnKnown)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psUnKnown);
  FIPCClient_UnKnown := TIPCClient<TEventData_Modbus_Standard>.Create(LSM, LSM2, True);//PLCMODBUS_EVENT_NAME
  AddIPCClientList(LSM, psUnKnown);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateWoodwardIPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_ECS_Woodward) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psECS_Woodward)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psECS_Woodward);
  FIPCClient_ECS_Woodward := TIPCClient<TEventData_ECS_Woodward>.Create(LSM, LSM2, True);//ECS_WOODWARD_EVENT_NAME
  AddIPCClientList(LSM, psECS_Woodward);

  FEventName := LSM + '_' + LSM2;
end;

procedure TIPCClientAll.CreateWT1600IPCClient(ASharedName: string);
var
  LSM, LSM2: string;
begin
  if Assigned(FIPCClient_WT1600) then
    exit;

  if ASharedName = '' then
    LSM := ParameterSource2SharedMN(psWT1600)
  else
    LSM := ASharedName;

  LSM2 := ParameterSource2SharedMN(psWT1600);
  FIPCClient_WT1600 := TIPCClient<TEventData_WT1600>.Create(LSM, LSM2, True);//WT1600_EVENT_NAME
  AddIPCClientList(LSM, psWT1600);

  FEventName := LSM + '_' + LSM2;
end;

destructor TIPCClientAll.Destroy;
begin
  ClearIPCClientAll;

  FIPCClientList.Free;
  FEngineParameter.EngineParameterCollect.Clear;
  FreeAndNil(FEngineParameter);
end;

procedure TIPCClientAll.DestroyIPCClient(AIPCClient: TParameterSource);
begin
  if Assigned(FIPCClient_WT1600) and (AIPCClient = psWT1600) then
  begin
    FIPCClient_WT1600.Free;
  end;

  if Assigned(FIPCClient_MEXA7000) and (AIPCClient = psMEXA7000)  then
  begin
    FIPCClient_MEXA7000.Free;
  end;

  if Assigned(FIPCClient_MT210) and (AIPCClient = psMT210)  then
  begin
    FIPCClient_MT210.Free;
  end;

  if Assigned(FIPCClient_ECS_kumo) and (AIPCClient = psECS_kumo)  then
  begin
    FIPCClient_ECS_kumo.Free;
  end;

  if Assigned(FIPCClient_ECS_AVAT) and (AIPCClient = psECS_AVAT)  then
  begin
    FIPCClient_ECS_AVAT.Free;
  end;

  if Assigned(FIPCClient_LBX) and (AIPCClient = psLBX)  then
  begin
    FIPCClient_LBX.Free;
  end;

  if Assigned(FIPCClient_Dynamo) and (AIPCClient = psDynamo)  then
  begin
    FIPCClient_Dynamo.Free;
  end;

  if Assigned(FIPCClient_GasCalc) and (AIPCClient = psGasCalculated)  then
  begin
    FIPCClient_GasCalc.Free;
  end;

  if Assigned(FIPCClient_KRAL) and (AIPCClient = psFlowMeterKral)  then
  begin
    FIPCClient_KRAL.Free;
  end;

  if Assigned(FIPCClient_ECS_Woodward) and (AIPCClient = psECS_Woodward)  then
  begin
    FIPCClient_ECS_Woodward.Free;
  end;

  if Assigned(FIPCClient_PLC_S7) and (AIPCClient = psPLC_S7)  then
  begin
    FIPCClient_PLC_S7.Free;
  end;

  if Assigned(FIPCClient_HIC) and (AIPCClient = psHIC)  then
  begin
    FIPCClient_HIC.Free;
  end;

  if Assigned(FIPCClient_EngineParam) and (AIPCClient = psEngineParam)  then
  begin
    FIPCClient_EngineParam.Free;
  end;

  if Assigned(FIPCClient_PLC_Modbus) and (AIPCClient = psPLC_Modbus)  then
  begin
    FIPCClient_PLC_Modbus.Free;
  end;

  if Assigned(FIPCClient_PMSOPC) and (AIPCClient = psPMSOPC)  then
  begin
    FIPCClient_PMSOPC.Free;
  end;

  if Assigned(FIPCClient_ECS_ComAP) and (AIPCClient = psECS_ComAP)  then
  begin
    FIPCClient_ECS_ComAP.Free;
  end;
end;

procedure TIPCClientAll.FinalgpSharedMemory4Producer;
begin
  FreeAndNil(FgpSharedMM);
end;

function TIPCClientAll.GetEngineName: string;
begin
  Result := '';

  if FEngineParameter.EngineParameterCollect.Count > 0 then
  begin
    Result := FEngineParameter.EngineParameterCollect.Items[0].ProjNo + '_' +
      FEngineParameter.EngineParameterCollect.Items[0].EngNo;
  end;
end;

function TIPCClientAll.GetEventName: string;
begin
  Result := FEventName;
end;

procedure TIPCClientAll.InitgpSharedMemory4Producer(const ASMName, ANameSpace, AEventName: string);
begin
  if Assigned(FgpSharedMM) then
    FgpSharedMM.Free;

  FgpSharedMM := TGpSharedMemory.Create(ASMName, 0, gp_SimParam_SHARED_MAX_SIZE); // gp_SimParam_SHARED_DATA_NAME

  if AEventName <> '' then
  begin
    FGpSharedEventProducer := TGpSharedEventProducer.Create(nil);
    FGpSharedEventProducer.Namespace := ANameSpace;//gp_EventNameSpace;
    FGpSharedEventProducer.PublishedEvents.Add(AEventName);
    FGpSharedEventProducer.Active := True;
  end;
end;

procedure TIPCClientAll.InitVar;
begin
  FEngineParameter := TEngineParameter.Create(nil);
  FIPCClientList := TStringList.Create;
end;

procedure TIPCClientAll.MakeEngParamDataFromCSV(var AEventData: TEventData_EngineParam;
  ACsv: string);
var
  j: integer;
begin
  j := 0;

  while ACsv <> '' do
  begin
    AEventData.FData[j] := strToken(ACsv, ',');
    inc(j);
  end;

  AEventData.FDataCount := j;
end;

procedure TIPCClientAll.MakeEventData;
var
  i: integer;
  LParamSource:TParameterSource;
  LData: TEventData_Modbus_Standard;
begin
  for i := 0 to FIPCClientList.Count - 1 do
  begin
    LParamSource := TParameterSource(FIPCClientList.Objects[i]);

    case TParameterSource(LParamSource) of
//      psECS_kumo: PulseEventData_ECS_kumo<T>(AData);
//      psECS_AVAT: PulseEventData_ECS_AVAT<T>(AData);
//      psMT210: PulseEventData_MT210<T>(AData);
////      psMEXA7000: PulseEventData_MEXA7000<T>(AData); Mexa7000은 통신 프로그램에서 PulseMonitor 함수를 직접 호출 함
//      psLBX: PulseEventData_LBX<T>(AData);
//      psFlowMeter: PulseEventData_FlowMeter<T>(AData);
//      psWT1600: PulseEventData_WT1600<T>(AData);
//      psGasCalculated: PulseEventData_GasCalc<T>(AData);
//      psECS_Woodward: PulseEventData_ECS_Woodward<T>(AData);
//      psFlowMeterKral: PulseEventData_Kral<T>(AData);
//      psDynamo: PulseEventData_Dynamo<T>(AData);
//      psPLC_S7: PulseEventData_PLC_S7<T>(AData);
//      psHIC: PulseEventData_HIC<T>(AData);
////      psEngineParam: PulseEventData_EngineParam<T>(AData);
      psPLC_Modbus: Make_PulseEventData_PLC_Modbus;
////      psPMSOPC: PulseEventData_PMSOPC<T>(AData);
//      psECS_ComAP: PulseEventData_ECS_ComAP<T>(AData);
//      psECS_ComAP2: PulseEventData_ECS_ComAP2<T>(AData);
    else
      ;
    end;
  end;
end;

procedure TIPCClientAll.MakeModbusStandardFromCSV(
  var AEventData: TEventData_Modbus_Standard; ACsv: string);
var
  j: integer;
begin
  j := 0;

  while ACsv <> '' do
  begin
    AEventData.InpDataBuf[j] := StrToIntDef(Trim(strToken(ACsv, ',')),0);
    inc(j);
  end;

  AEventData.NumOfData := j;
  AEventData.ModBusFunctionCode := 3;
  AEventData.ModBusMode := 3; //Simulate Mode
end;

procedure TIPCClientAll.Make_PulseEventData_PLC_Modbus;
var
  LEventData: TEventData_Modbus_Standard;
  LCollect: TEngineParameterCollect;
  i, Lidx, LBlockNo: integer;
  LBlockChanged: Boolean;
begin
  LCollect := FEngineParameter.EngineParameterCollect;
  Lidx := 0;
  LBlockNo := -1;
  LBlockChanged := False;

  for i := 0 to LCollect.Count - 1 do
  begin
    if LBlockNo <> LCollect.Items[i].BlockNo then
    begin
      LBlockNo := LCollect.Items[i].BlockNo;
      LBlockChanged := True;
    end;

    if (LBlockNo <> -1) and LBlockChanged then
    begin
      FIPCClient_PLC_Modbus.PulseMonitor(LEventData);
      LBlockChanged := False;
      Lidx := 0;
    end;

    LEventData.InpDataBuf[Lidx] := StrToInt(LCollect.Items[i].Value);
  end;

end;

//procedure TIPCClientAll.PulseEventData(AData: TEventData_Modbus_Standard);
//var
//  i: integer;
//  LParamSource:TParameterSource;
//begin
//  for i := 0 to FIPCClientList.Count - 1 do
//  begin
//    LParamSource := TParameterSource(FIPCClientList.Objects[i]);
//
//    case TParameterSource(LParamSource) of
//      psECS_kumo: PulseEventData_ECS_kumo(AData);
//      psECS_AVAT: PulseEventData_ECS_AVAT(AData);
//      psMT210: PulseEventData_MT210(AData);
////      psMEXA7000: PulseEventData_MEXA7000(AData); Mexa7000은 통신 프로그램에서 PulseMonitor 함수를 직접 호출 함
//      psLBX: PulseEventData_LBX(AData);
//      psFlowMeter: PulseEventData_FlowMeter(AData);
//      psWT1600: PulseEventData_WT1600(AData);
//      psGasCalculated: PulseEventData_GasCalc(AData);
//      psECS_Woodward: PulseEventData_ECS_Woodward(AData);
//      psFlowMeterKral: PulseEventData_Kral(AData);
//      psDynamo: PulseEventData_Dynamo(AData);
//      psPLC_S7: PulseEventData_PLC_S7(AData);
//      psHIC: PulseEventData_HIC(AData);
////      psEngineParam: PulseEventData_EngineParam(AData);
//      psPLC_Modbus: PulseEventData_PLC_Modbus(AData);
////      psPMSOPC: PulseEventData_PMSOPC(AData);
//      psECS_ComAP: PulseEventData_ECS_ComAP(AData);
//      psECS_ComAP2: PulseEventData_ECS_ComAP2(AData);
//    else
//      ;
//    end;
//  end;
//
//end;

procedure TIPCClientAll.PulseEventData<T>(AData: T);
var
  i: integer;
  LParamSource:TParameterSource;
  LData: TEventData_Modbus_Standard;
begin
  for i := 0 to FIPCClientList.Count - 1 do
  begin
    LParamSource := TParameterSource(FIPCClientList.Objects[i]);

    case TParameterSource(LParamSource) of
      psECS_kumo: PulseEventData_ECS_kumo<T>(AData);
      psECS_AVAT: PulseEventData_ECS_AVAT<T>(AData);
      psMT210: PulseEventData_MT210<T>(AData);
//      psMEXA7000: PulseEventData_MEXA7000<T>(AData); Mexa7000은 통신 프로그램에서 PulseMonitor 함수를 직접 호출 함
      psLBX: PulseEventData_LBX<T>(AData);
      psFlowMeter: PulseEventData_FlowMeter<T>(AData);
      psWT1600: PulseEventData_WT1600<T>(AData);
      psGasCalculated: PulseEventData_GasCalc<T>(AData);
      psECS_Woodward: PulseEventData_ECS_Woodward<T>(AData);
      psFlowMeterKral: PulseEventData_Kral<T>(AData);
      psDynamo: PulseEventData_Dynamo<T>(AData);
      psPLC_S7: PulseEventData_PLC_S7<T>(AData);
      psHIC: PulseEventData_HIC<T>(AData);
      psUnKnown: PulseEventData_UnKnown<T>(AData);
      psEngineParam: PulseEventData_EngineParam<T>(AData);
      psPLC_Modbus: PulseEventData_PLC_Modbus<T>(AData);
//      psPMSOPC: PulseEventData_PMSOPC<T>(AData);
      psECS_ComAP: PulseEventData_ECS_ComAP<T>(AData);
      psECS_ComAP2: PulseEventData_ECS_ComAP2<T>(AData);
      psFGSS_KM: PulseEventData_FGSS_KM<T>(AData);
      psECS_AVAT2: PulseEventData_ECS_AVAT2<T>(AData);
      psSCR_BachMann: PulseEventData_SCR_Bachmann<T>(AData);
      psScrubber_Schneider: PulseEventData_EGCS_Schneider<T>(AData);
      psECS_Wago8212: PulseEventData_ECS_Wago8212<T>(AData);
    else
      ;
    end;
  end;
end;

procedure TIPCClientAll.PulseEventDataFromInt(AEventSource: integer);
begin

end;

//procedure TIPCClientAll.PulseEventData_Dynamo(
//  AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_DYNAMO;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_Dynamo.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_ECS_AVAT(
//  AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_ECS_AVAT;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_ECS_AVAT.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_ECS_ComAP(
//  AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_Modbus_Standard;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_ECS_ComAP.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_ECS_ComAP2(
//  AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_Modbus_Standard;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_ECS_ComAP2.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_ECS_kumo(
//  AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_ECS_kumo;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_ECS_kumo.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_ECS_Woodward(
//  AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_ECS_Woodward;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_ECS_Woodward.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_EngineParam(
//  AData: TEventData_EngineParam);
//var
//  LEventData: TEventData_EngineParam;
//begin
////  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_EngineParam.PulseMonitor(AData);
//end;
//
//procedure TIPCClientAll.PulseEventData_FlowMeter(
//  AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_FlowMeter;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_FlowMeter.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_GasCalc(
//  AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_GasCalc;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_GasCalc.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_HIC(AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_HIC;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_HIC.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_KRAL(AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_Modbus_Standard;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_KRAL.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_LBX(AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_LBX;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_LBX.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_MEXA7000(
//  AData: TEventData_MEXA7000_2);
//begin
//  FIPCClient_MEXA7000.PulseMonitor(AData);
//end;
//
//procedure TIPCClientAll.PulseEventData_MT210(AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_MT210;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_MT210.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_PLC_Modbus(
//  AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_Modbus_Standard;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_PLC_Modbus.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_PLC_S7(
//  AData: TEventData_Modbus_Standard);
//var
//  LEventData: TEventData_PLC_S7;
//begin
//  System.Move(AData, LEventData, Sizeof(LEventData));
//  FIPCClient_PLC_S7.PulseMonitor(LEventData);
//end;
//
//procedure TIPCClientAll.PulseEventData_PMSOPC(AData: TEventData_PMS);
//begin
//  FIPCClient_PMSOPC.PulseMonitor(AData);
//end;

procedure TIPCClientAll.PulseEventData_Dynamo<T>(AData: T);
var
  LEventData: TEventData_DYNAMO;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_Dynamo.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_ECS_AVAT2<T>(AData: T);
var
  LEventData: TEventData_Modbus_Standard;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_ECS_AVAT2.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_ECS_AVAT<T>(AData: T);
var
  LEventData: TEventData_ECS_AVAT;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_ECS_AVAT.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_ECS_ComAP2<T>(AData: T);
var
  LEventData: TEventData_Modbus_Standard;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_ECS_ComAP2.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_ECS_ComAP<T>(AData: T);
var
  LEventData: TEventData_Modbus_Standard;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_ECS_ComAP.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_ECS_kumo<T>(AData: T);
var
  LEventData: TEventData_ECS_kumo;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_ECS_kumo.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_ECS_Wago8212<T>(AData: T);
var
  LEventData: TEventData_Modbus_Standard;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_ECS_Wago8212.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_ECS_Woodward<T>(AData: T);
var
  LEventData: TEventData_ECS_Woodward;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_ECS_Woodward.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_EGCS_Schneider<T>(AData: T);
var
  LEventData: TEventData_Modbus_Standard;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_EGCS_Schneider.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_EngineParam<T>(AData: T);
var
  LEventData: TEventData_EngineParam;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_EngineParam.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_FGSS_KM<T>(AData: T);
var
  LEventData: TEventData_FGSS_KM;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_FGSS_KM.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_FlowMeter<T>(AData: T);
var
  LEventData: TEventData_FlowMeter;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_FlowMeter.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_GasCalc<T>(AData: T);
var
  LEventData: TEventData_GasCalc;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_GasCalc.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_HIC<T>(AData: T);
var
  LEventData: TEventData_HIC;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_HIC.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_KRAL<T>(AData: T);
var
  LEventData: TEventData_Modbus_Standard;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_KRAL.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_LBX<T>(AData: T);
var
  LEventData: TEventData_LBX;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_LBX.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_MEXA7000<T>(AData: T);
var
  LEventData: TEventData_MEXA7000_2;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_MEXA7000.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_MT210<T>(AData: T);
var
  LEventData: TEventData_MT210;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_MT210.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_PLC_Modbus<T>(AData: T);
var
  LEventData: TEventData_Modbus_Standard;
begin
//  SetLength(LEventData.InpDataBuf, 256);
//  SetLength(LEventData.InpDataBuf2, 256);
//  SetLength(LEventData.InpDataBuf_double, 1001);
//  SetLength(LEventData.ModBusMapFileName, 255);
//  SetLength(LEventData.IPAddress, 16);
//  SetLength(LEventData.EngineName, 20);
//  SetLength(LEventData.ModBusAddress, 5);
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_PLC_Modbus.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_PLC_S7<T>(AData: T);
var
  LEventData: TEventData_PLC_S7;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_PLC_S7.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_PMSOPC<T>(AData: T);
var
  LEventData: TEventData_PMS;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_PMSOPC.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_SCR_Bachmann<T>(AData: T);
var
  LEventData: TEventData_Modbus_Standard;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_SCR_Bachmann.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_UnKnown<T>(AData: T);
var
  LEventData: TEventData_Modbus_Standard;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_UnKnown.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.PulseEventData_WT1600<T>(AData: T);
var
  LEventData: TEventData_WT1600;
begin
  System.Move(AData, LEventData, Sizeof(LEventData));
  FIPCClient_WT1600.PulseMonitor(LEventData);
end;

procedure TIPCClientAll.ReadAddressFromParamFile(AFileName: string;
  AEncrypt: Bool; AFileFormat: integer);
begin
  if AFileFormat = 0 then
    FEngineParameter.LoadFromFile(AFilename,
                                      ExtractFileName(AFilename),
                                      AEncrypt)
  else if AFileFormat = 1 then
    FEngineParameter.LoadFromJSONFile(AFilename,
                                      ExtractFileName(AFilename),
                                      AEncrypt);

  if FEngineParameter.EngineParameterCollect.Count > 0 then
  begin
    FProjNo := FEngineParameter.EngineParameterCollect.Items[0].ProjNo;
    FEngNo := FEngineParameter.EngineParameterCollect.Items[0].EngNo;
  end;
end;

procedure TIPCClientAll.SendData2gpSM(const AEventName, AData: string);
var
  LStrList: TStringList;
begin
  LStrList := TStringList.Create;
  try
    LStrList.Add(IntToStr(GetCurrentProcessId));
    LStrList.Add(AData);

    if FgpSharedMM.AcquireMemory(True, INFINITE) <> nil then
    begin
      if FgpSharedMM.IsWriting then
        LStrList.SaveToStream(FgpSharedMM.AsStream);
    end;

    if FgpSharedMM.Acquired then
      FgpSharedMM.ReleaseMemory;

    FGpSharedEventProducer.BroadcastEvent(AEventName,
              FormatDateTime('hh:mm:ss.zzz', Now));
  finally
    LStrList.Free;
  end;
end;

end.

