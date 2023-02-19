program HiMECSProjInfo2;

uses
  Vcl.Forms,
  FrmHiMECSProjInfo in 'FrmHiMECSProjInfo.pas' {Form2},
  UnitProjDM in 'UnitProjDM.pas' {DM1: TDataModule},
  Bcrypt in '..\..\..\..\..\..\..\project\OpenSrc\lib\bcrypt-for-delphi-master\Bcrypt.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitFrameProjInfo in '..\HiMECS_Common\UnitFrameProjInfo.pas' {HiMECSProjInfoFrame: TFrame},
  UnitProjectBaseClass2 in '..\..\Source\Common\UnitProjectBaseClass2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDM1, DM1);
  Application.Run;
end.
