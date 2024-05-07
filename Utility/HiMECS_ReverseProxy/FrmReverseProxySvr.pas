unit FrmReverseProxySvr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  IdMappedPortTCP, IdContext, IdBaseComponent, IdComponent, IdCustomTCPServer,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TReverseProxyF = class(TForm)
    IdMappedPortTCP1: TIdMappedPortTCP;
    Memo1: TMemo;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Memo2: TMemo;
    procedure IdMappedPortTCP1Execute(AContext: TIdContext);
  private
  public
  end;

var
  ReverseProxyF: TReverseProxyF;

implementation

{$R *.dfm}

procedure TReverseProxyF.IdMappedPortTCP1Execute(AContext: TIdContext);
begin
;
end;

end.
