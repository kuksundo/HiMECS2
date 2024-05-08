unit UProyConfig;

interface

uses IniPersist, UnitConfigIniClass2;

type
  TReverseProxyConfig = class (TINIConfigBase)
    FBindIP,
    FBindPort,
    FMappedIP,
    FMappedPort,
    FPath
    : string;

  public
    [IniValue('TCP','FBindIP','',10)]
    property BindIP : string read FBindIP write FBindIP;
    [IniValue('TCP','FBindPort','',11)]
    property BindPort : string read FBindPort write FBindPort;
    [IniValue('TCP','FMappedIP','',12)]
    property MappedIP : string read FMappedIP write FMappedIP;
    [IniValue('TCP','FMappedPort','',13)]
    property MappedPort : string read FMappedPort write FMappedPort;
    [IniValue('TCP','FPath','',14)]
    property Path : string read FPath write FPath;

  end;

implementation

end.
