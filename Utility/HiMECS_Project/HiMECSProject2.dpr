program HiMECSProject2;

uses
  Vcl.Forms,
  FrmSelectProject2 in '..\..\Form\FrmSelectProject2.pas' {SelectProjectForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSelectProjectForm, SelectProjectForm);
  Application.Run;
end.
