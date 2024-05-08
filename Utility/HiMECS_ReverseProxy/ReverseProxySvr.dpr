program ReverseProxySvr;

uses
  Vcl.Forms,
  FrmReverseProxySvr in 'FrmReverseProxySvr.pas' {ReverseProxyF},
  FrmPortForward in 'FrmPortForward.pas' {Form1},
  UProxyType in 'UProxyType.pas',
  UProxyClass in 'UProxyClass.pas',
  UProxyWorkerThrd in 'UProxyWorkerThrd.pas',
  UProyConfig in 'UProyConfig.pas',
  FrmProxyConfig in 'FrmProxyConfig.pas' {TraderConfigF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TReverseProxyF, ReverseProxyF);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TTraderConfigF, TraderConfigF);
  Application.Run;
end.
