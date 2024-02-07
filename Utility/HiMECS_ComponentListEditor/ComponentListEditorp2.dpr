program ComponentListEditorp2;

uses
  Forms,
  FrmComponentListEditor in 'FrmComponentListEditor.pas' {frmBPLListeditor};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBPLListeditor, frmBPLListeditor);
  Application.Run;
end.
