unit UProxyClass;

interface

uses System.Classes, System.SysUtils,
  IdMappedPortTCP, IdSSLOpenSSL, IdServerInterceptLogFile, IdContext,
  IdCustomTCPServer, IdTCPServer, IdTCPClient,
  UnitIndyUtil, UProxyType
  ;

type
  TProcLog = procedure (const AMsg: string) of object;

  TReverseProxy = class
    FIdMappedPortTCP: TIdMappedPortTCP;
    FIdServerIOHandleOpenSSL: TIdServerIOHandlerSSLOpenSSL;
    FIdServerInterceptLogFile: TIdServerInterceptLogFile;

  private
    FBindIP: string;
    FBindPort: string;
    FMappedIP: string;
    FMappedPort: string;
    FPath: string;
    FAllowIPList: TStringList; //허용 IP List

    FProcLog: TProcLog;

    function IsAllowIp(const AIp: string): Boolean;//허용된 IP 리스트에 있는지 확인
  protected
    procedure ProxyConnect(AContext: TIdContext);
    procedure ProxyDisConnect(AContext: TIdContext);
    procedure ProxyExecute(AContext: TIdContext);
    procedure ProxyOutboundData(AContext: TIdContext);
  public
    constructor Create(const ARec: TProxyIPRec; AAllowOPList: TStringList=nil);
    destructor Destroy(); override;

    procedure InitVar();
    procedure DestroyVar();

    procedure Connect;
    procedure DisConnect;

    property LogProc: TProcLog read FProcLog write FProcLog;
  end;

implementation

{ TReverseProxy }

procedure TReverseProxy.Connect;
begin

end;

constructor TReverseProxy.Create(const ARec: TProxyIPRec;
  AAllowOPList: TStringList);
begin
  FBindIP := ARec.FSrcIP.FIp;
  FBindPort := ARec.FSrcIP.FPort;
  FMappedIP := ARec.FDestIP.FIp;
  FMappedPort := ARec.FDestIP.FPort;

  if Assigned(AAllowOPList) then
  begin
    FAllowIPList := TStringList.Create;
    FAllowIPList.Assign(AAllowOPList);
  end;

  InitVar();
end;

destructor TReverseProxy.Destroy;
begin
  DestroyVar();
end;

procedure TReverseProxy.DestroyVar;
begin
  FIdMappedPortTCP.Free;
  FAllowIPList.Free;
end;

procedure TReverseProxy.DisConnect;
begin

end;

procedure TReverseProxy.InitVar;
begin
  FIdMappedPortTCP := TIdMappedPortTCP.Create(nil);

  with FIdMappedPortTCP do
  begin
    MappedHost := FMappedIP;
    MappedPort := StrToIntDef(FMappedPort, 0);
    Bindings.Add.IP := FBindIP;
    Bindings.Add.Port := StrToIntDef(FBindPort, 0);

    OnConnect := ProxyConnect;
    OnDisConnect := ProxyDisConnect;
    OnExecute := ProxyExecute;
    OnOutboundData := ProxyOutboundData;
  end;
end;

function TReverseProxy.IsAllowIp(const AIp: string): Boolean;
begin

end;

procedure TReverseProxy.ProxyConnect(AContext: TIdContext);
begin
  // Dynamically configure the target Host/Port based on client request
  // Example: Read host/port from the client connection and set MappedHost/MappedPort
  AContext.Connection.IOHandler.WriteLn('220 Welcome to My Proxy Server');
  // Other proxy logic...
end;

procedure TReverseProxy.ProxyDisConnect(AContext: TIdContext);
begin

end;

procedure TReverseProxy.ProxyExecute(AContext: TIdContext);
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
    AContext.Data := Server;

    LogProc(Server.Host + ':' + IntToStr(Server.Port));

    try
      Server.Connect;
    except
      on E: Exception do
      begin
        Server.Disconnect;
        Server.Free;
        AContext.Data := nil;
        AContext.Connection.Disconnect;

        LogProc('Error while connecting: ' + E.ClassName + ' ' + E.Message);
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
      Server.Disconnect;
      Server.Free;
      AContext.Data := nil;
      AContext.Connection.Disconnect;

      LogProc('Disconnected');
    end;
  end;
end;

procedure TReverseProxy.ProxyOutboundData(AContext: TIdContext);
begin

end;

end.
