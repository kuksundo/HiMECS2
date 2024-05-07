unit UProxyClass;

interface

uses System.Classes,
  IdMappedPortTCP, IdSSLOpenSSL, IdServerInterceptLogFile;

type
  TFowardingClass = class
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
    procedure Connect;
    procedure DisConnect;
  public
    constructor Create(const ABindIP, ABindPort, AMappedIP, AMappedPort: string; AAllowOPList: TStringList);
    destructor Destroy();
  end;

implementation

end.
