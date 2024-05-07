program ProxyServer;

uses
  Vcl.Forms,
  FrmProxyMain in 'FrmProxyMain.pas' {Form1},
  UnitIndyUtil in '..\..\..\..\Common\UnitIndyUtil.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
