program ReverseProxySvr;

uses
  Vcl.Forms,
  FrmReverseProxySvr in 'FrmReverseProxySvr.pas' {ReverseProxyF},
  FrmPortForward in 'FrmPortForward.pas' {Form1},
  UProxyType in 'UProxyType.pas',
  UProxyClass in 'UProxyClass.pas',
  UProxyWorkerThrd in 'UProxyWorkerThrd.pas',
  UProyConfig in 'UProyConfig.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TReverseProxyF, ReverseProxyF);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
