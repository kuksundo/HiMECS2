program StatusDisplay2;

uses
  Vcl.Forms,
  FrmStatusDisplay2 in 'FrmStatusDisplay2.pas' {StatusDisplayF},
  DosingUnitReady_Entry_Condition in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\HotImgForm\SCR\DosingUnitReady_Entry_Condition.pas',
  DosingUnitStart_Entry_Condition in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\HotImgForm\SCR\DosingUnitStart_Entry_Condition.pas' {DosingUnitStartEntryCondF},
  Heating_Entry_Condition in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\HotImgForm\SCR\Heating_Entry_Condition.pas',
  Regeneration_Entry_Condition in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\HotImgForm\SCR\Regeneration_Entry_Condition.pas',
  Sealing_Entry_Condition in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\HotImgForm\SCR\Sealing_Entry_Condition.pas',
  StandbyHeating_Entry_Condition in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\HotImgForm\SCR\StandbyHeating_Entry_Condition.pas',
  Venting_Entry_Condition in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\HotImgForm\SCR\Venting_Entry_Condition.pas' {VentingEntryCondF},
  DosingUnitInjection_Entry_Condition in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\HotImgForm\SCR\DosingUnitInjection_Entry_Condition.pas' {DosingUnitInjectionEntryCondF},
  UnitProcessUtil in '..\..\..\..\..\..\..\project\common\UnitProcessUtil.pas',
  UnitCommandLineUtil in '..\..\..\..\..\..\..\project\common\UnitCommandLineUtil.pas',
  FrmInputEdit in '..\..\..\..\..\..\..\project\common\Forms\FrmInputEdit.pas',
  UnitSimulateCommonData in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SimulateParamServer\UnitSimulateCommonData.pas',
  UnitStatusDisplayCommandLineOption2 in 'UnitStatusDisplayCommandLineOption2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TStatusDisplayF, StatusDisplayF);
  Application.Run;
end.
