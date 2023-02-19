program HiMECSConfig2;

uses
  Vcl.Forms,
  UnitConfig2 in 'UnitConfig2.pas' {ConfigF},
  FrmHiMECSConfig2 in 'FrmHiMECSConfig2.pas' {Form1},
  HiMECSConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\HiMECSConst.pas',
  CommonUtil in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusComm_kumo\common\CommonUtil.pas',
  IPC_MEXA7000_Const in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\common\IPC_MEXA7000_Const.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  VarRecUtils in '..\..\..\..\..\..\..\project\common\openarr\source\VarRecUtils.pas',
  UnitHiMECSConfigCollect2 in '..\HiMECS_Common\UnitHiMECSConfigCollect2.pas',
  JHP.BaseConfigCollect in '..\..\..\..\Common\JHP.BaseConfigCollect.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
