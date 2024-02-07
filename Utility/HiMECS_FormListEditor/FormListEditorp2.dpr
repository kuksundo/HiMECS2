program FormListEditorp2;

uses
  Forms,
  FrmFormListEditor in 'FrmFormListEditor.pas' {frmBPLListeditor};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBPLListeditor, frmBPLListeditor);
  Application.Run;
end.
