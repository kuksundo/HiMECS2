program HiMECS_Comm_Server;

uses
  Vcl.Forms,
  UnitFrameCommServer2 in '..\..\..\..\Template\UnitFrameCommServer2.pas' {FrameCommServer: TFrame},
  UnitWorker4OmniMsgQ in '..\..\..\..\..\..\..\project\common\UnitWorker4OmniMsgQ.pas',
  UnitCommServerConfig in '..\..\..\..\Template\UnitCommServerConfig.pas',
  UnitFileSearchUtil in '..\..\..\..\..\..\..\project\common\UnitFileSearchUtil.pas',
  UnitCommUserBaseClass in '..\..\..\..\Template\UnitCommUserBaseClass.pas',
  JHP.BaseConfigCollect in '..\..\..\..\Common\JHP.BaseConfigCollect.pas',
  Bcrypt in '..\..\..\..\..\..\..\project\OpenSrc\lib\bcrypt-for-delphi-master\Bcrypt.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  VarRecUtils in '..\..\..\..\..\..\..\project\common\openarr\source\VarRecUtils.pas',
  uSMBIOS in '..\..\..\..\OpenSrc\lib\TSmBios\Common\uSMBIOS.pas',
  UnitBase64Util2 in '..\..\..\..\Common\UnitBase64Util2.pas',
  UnitModbusComConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\UnitModbusComConst.pas',
  MyKernelObject in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusComm_kumo\common\MyKernelObject.pas',
  UnitSimulateParamCommandLineOption in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SimulateParamServer\UnitSimulateParamCommandLineOption.pas',
  JHP.Util.Bit in '..\..\..\..\Common\JHP.Util.Bit.pas',
  JHP.Util.Common in '..\..\..\..\Common\JHP.Util.Common.pas',
  HiMECSConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\HiMECSConst.pas',
  OtlParallel in '..\..\..\..\OpenSrc\lib\OmniThreadLibrary\OtlParallel.pas',
  FrmMain_HiMECS_Comm_Server in 'FrmMain_HiMECS_Comm_Server.pas' {HiMECSCommServerF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THiMECSCommServerF, HiMECSCommServerF);
  Application.Run;
end.
