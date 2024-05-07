unit FrmProxyMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdContext, IdBaseComponent, IdComponent,
  Vcl.ExtCtrls, Vcl.StdCtrls,
  IdCustomTCPServer, IdTCPServer, IdTCPClient, IdMappedPortTCP
  ;

type
  TForm1 = class(TForm)
    IdTCPServer1: TIdTCPServer;
    Memo1: TMemo;
    Splitter1: TSplitter;
    IdMappedPortTCP1: TIdMappedPortTCP;
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure FormCreate(Sender: TObject);
  private
    procedure ProxyConnect(AContext: TIdContext);
    procedure Log(const AMsg: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses UnitIndyUtil;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 // Create and configure the proxy component
  IdMappedPortTCP1 := TIdMappedPortTCP.Create(Self);
  IdMappedPortTCP1.MappedHost := '192.168.1.2';
  IdMappedPortTCP1.MappedPort := 80;
  IdMappedPortTCP1.DefaultPort := 8080; // Set the proxy port
  IdMappedPortTCP1.OnConnect := ProxyConnect;
  // Other configuration settings as needed
end;

procedure TForm1.IdTCPServer1Execute(AContext: TIdContext);
var
  Server: TIdTCPClient;
  Host, Port: string;
begin
  if AContext.Data = nil then  // First connect
  begin
    Server := TIdTCPClient.Create;
    Host := AContext.Connection.IOHandler.ReadLn(':');
    Port := AContext.Connection.IOHandler.ReadLn(#13#10#13#10);
    Server.Host := Host;
    Server.Port := StrToIntDef(Port, 80);
    Memo1.Lines.Add(Server.Host + ':' + IntToStr(Server.Port));
    AContext.Data := Server;
    try
      Server.Connect;
    except
      on E: Exception do
      begin
        Log('Error while connecting: ' + E.ClassName + ' ' + E.Message);
        Server.Disconnect;
        Server.Free;
        AContext.Data := nil;
        AContext.Connection.Disconnect;
      end;
    end;
  end
  else
  begin
    Server := TIdTCPClient(AContext.Data);
    Server.IOHandler.CheckForDataOnSource(50);
    AContext.Connection.IOHandler.CheckForDataOnSource(50);
    if Server.Connected and AContext.Connection.Connected then
    begin
      if not AContext.Connection.IOHandler.InputBufferIsEmpty then
        CopyInputBuffer('CLIENT -> SERVER', AContext.Connection.IOHandler, Server.IOHandler);
      if not Server.IOHandler.InputBufferIsEmpty then
        CopyInputBuffer('SERVER -> CLIENT', Server.IOHandler, AContext.Connection.IOHandler);
    end
    else
    begin
      Log('Disconnected');
      Server.Disconnect;
      Server.Free;
      AContext.Data := nil;
      AContext.Connection.Disconnect;
    end;
  end;
end;

procedure TForm1.Log(const AMsg: string);
begin
  if Memo1.Lines.Count > 100 then
    Memo1.Lines.Clear;

  Memo1.Lines.Add(AMsg);
end;

procedure TForm1.ProxyConnect(AContext: TIdContext);
begin
  // Dynamically configure the target Host/Port based on client request
  // Example: Read host/port from the client connection and set MappedHost/MappedPort
  AContext.Connection.IOHandler.WriteLn('220 Welcome to My Proxy Server');
  // Other proxy logic...
end;

end.
