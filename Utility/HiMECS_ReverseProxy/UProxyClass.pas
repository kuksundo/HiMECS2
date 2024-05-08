unit UProxyClass;

interface

uses System.Classes, System.SysUtils,
  IdMappedPortTCP, IdSSLOpenSSL, IdServerInterceptLogFile, IdContext;

type
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
    FAllowIPList = TStringList; //허용 IP List

    function IsAllowIp(const AIp: string): Boolean;//허용된 IP 리스트에 있는지 확인
  protected
    procedure ProxyConnect(AContext: TIdContext);
    procedure ProxyDisConnect(AContext: TIdContext);
    procedure ProxyExecute(AContext: TIdContext);
    procedure ProxyOutboundData(AContext: TIdContext);
  public
    constructor Create(const ABindIP, ABindPort, AMappedIP, AMappedPort: string;
      AAllowOPList: TStringList=nil);
    destructor Destroy(); override;

    procedure InitVar();
    procedure DestroyVar();

    procedure Connect;
    procedure DisConnect;

    procedure Log(const AMsg: string);
  end;

implementation

{ TReverseProxy }

procedure TReverseProxy.Connect;
begin

end;

constructor TReverseProxy.Create(const ABindIP, ABindPort, AMappedIP,
  AMappedPort: string; AAllowOPList: TStringList);
begin
  FBindIP := ABindIP;
  FBindPort := ABindPort;
  FMappedIP := AMappedIP;
  FMappedPort := AMappedPort;

  if Assigned(AAllowOPList) then
    FAllowIPList.Assign(AAllowOPList);

  InitVar();
end;

destructor TReverseProxy.Destroy;
begin
  DestroyVar();
end;

procedure TReverseProxy.DestroyVar;
begin
  FIdMappedPortTCP.Free;
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

procedure TReverseProxy.Log(const AMsg: string);
begin

end;

procedure TReverseProxy.ProxyConnect(AContext: TIdContext);
begin

end;

procedure TReverseProxy.ProxyDisConnect(AContext: TIdContext);
begin

end;

procedure TReverseProxy.ProxyExecute(AContext: TIdContext);
begin

end;

procedure TReverseProxy.ProxyOutboundData(AContext: TIdContext);
begin

end;

end.
