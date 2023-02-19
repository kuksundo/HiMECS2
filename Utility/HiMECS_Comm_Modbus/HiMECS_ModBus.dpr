program HiMECS_ModBus;

uses
  RunOne,
  mormot.db.raw.sqlite3.static,
  Forms,
  FrmModbusCom_main in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\FrmModbusCom_main.pas' {ModbusComF},
  UnitModBusTCPWagoThread in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\UnitModBusTCPWagoThread.pas',
  UnitModBusComThread in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\UnitModBusComThread.pas',
  UnitModBusTCPThread in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\UnitModBusTCPThread.pas',
  FrmModbusConfig in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\FrmModbusConfig.pas' {ModbusConfigF},
  HiMECSConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\HiMECSConst.pas',
  IPCThreadEvent in '..\..\..\..\..\..\..\project\common\IPCThreadEvent.pas',
  IPCThrdClient_Generic in '..\..\..\..\..\..\..\project\common\IPCThrdClient_Generic.pas',
  UnitIPCClientAll2 in '..\HiMECS_Common\UnitIPCClientAll2.pas',
  IPC_ModbusComm_Const in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusComm_내구시험장\common\IPC_ModbusComm_Const.pas',
  IPCThrdMonitor_Generic in '..\..\..\..\..\..\..\project\common\IPCThrdMonitor_Generic.pas',
  IPC_Modbus_Standard_Const in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\common\IPC_Modbus_Standard_Const.pas',
  IdModBusSerialClient in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusComm_내구시험장\common\IdModBusSerialClient.pas',
  ModBusSerialTypes in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusComm_내구시험장\common\ModBusSerialTypes.pas',
  FrmModbusCom_Recv in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\FrmModbusCom_Recv.pas' {DisplayRecvF},
  UnitSTOMPClass in '..\..\..\..\..\..\..\project\common\UnitSTOMPClass.pas',
  UnitWorker4OmniMsgQ in '..\..\..\..\..\..\..\project\common\UnitWorker4OmniMsgQ.pas',
  UnitModbusComConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\UnitModbusComConst.pas',
  EngineConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\EngineConst.pas',
  VarRecUtils in '..\..\..\..\..\..\..\project\common\openarr\source\VarRecUtils.pas',
  IPC_ECS_AVAT2_Const in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\common\IPC_ECS_AVAT2_Const.pas',
  FrmDisplaySingleValue in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\FrmDisplaySingleValue.pas' {DispSingleValueF},
  SCrypt in '..\..\..\..\..\..\..\project\OpenSrc\lib\scrypt-for-delphi-master\SCrypt.pas',
  UnitEncrypt2 in '..\..\..\..\NoGitHub\Util\UnitEncrypt2.pas',
  MBT2 in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\MBT2.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TModbusComF, ModbusComF);
  Application.Run;
end.
