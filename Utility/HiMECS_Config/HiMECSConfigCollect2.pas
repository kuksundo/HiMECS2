unit HiMECSConfigCollect2;
{
2011.3.7
- HiMECS Options Data
}

interface

uses classes, SysUtils, BaseConfigCollect, EngineParameterClass, mORMot, SynCommons,
  ProjectBaseClass, EngineBaseClass, HiMECSManualClass, UnitRttiUtil;

type
  THiMECSConfig2Collect = class;
  THiMECSConfig2Item = class;

  THiMECSConfig2 = class(TpjhBase)
  private
    FHiMECSConfig2Collect: THiMECSConfig2Collect;
    FProjectItemName: string;
    FMenuFileName,
    FEngineInfoFileName,
    FParamFileName,
    FModbusListFileName,
    FSensorRouteFileName,//���� '' �̸� DomSensorTypes2.DefaultSensorRouteDBFileName�� ����
    FProjectInfoFileName,
    FUserFileName,
    FManualInfoFileName
    : string;
    FHiMECSFormPath, //Form ���� bpl�� ����� ���
    FConfigPath,     //Config ���� file(.option,menu,form)�� ����� ���
    FDocPath,        //Document ���� file�� ����� ���
    FExesPath,       //�ܺ� ����ȭ���� ����� ���
    FBplsPath,       //Bpl ȭ���� ����� ���
    FLogPath         //Log File ���� ���
    : string;
    FExtAppInMDI : Boolean;
    FUseMonLauncher: Boolean; //true = HiMECS_MON_LAUNCHER.exe�� �̿��Ͽ� Montor list �ε���
    FUseCommLauncher: Boolean; //true = HiMECS_COMM_LAUNCHER.exe�� �̿��Ͽ� AutoRun list �ε���
    FEngParamEncrypt: Boolean;//Engine Parameter file Encryption
    FEngParamFileFormat: integer; //0: XML, 1: JSON , 2: Sqlite

    //for Update config
    FUpdateProtocol: integer;//0=HTTP. 1=HTTPS, 2=FTP, 3=Network File
    FFTPHost: string;
    FFTPPort: integer;
    FFTPUserID,
    FFTPPasswd,
    FFTPDirectory, //update�� file�� ��ġ�� ����
    FServerURL: string;
    FUpdateWhenStart: Boolean;
    FKillProcListFileName: string;

    FEngineParameter: TEngineParameter;
    FProjectInfo: TVesselInfo;
    FEngineInfo: TICEngine;
    FManualInfo: THiMECSManualInfo;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure Clear;

    property EngineParameter: TEngineParameter read FEngineParameter write FEngineParameter;
    property ProjectInfo: TVesselInfo read FProjectInfo write FProjectInfo;
    property EngineInfo: TICEngine read FEngineInfo write FEngineInfo;
    property ManualInfo: THiMECSManualInfo read FManualInfo write FManualInfo;
//    property HiMECSConfig2Collect: THiMECSConfig2Collect read FHiMECSConfig2Collect write FHiMECSConfig2Collect;
  published
    property ProjectItemName: string read FProjectItemName write FProjectItemName;
    property MenuFileName: string read FMenuFileName write FMenuFileName;
    property EngineInfoFileName: string read FEngineInfoFileName write FEngineInfoFileName;
    property ParamFileName: string read FParamFileName write FParamFileName;
    property ModbusListFileName: string read FModbusListFileName write FModbusListFileName;
    property SensorRouteFileName: string read FSensorRouteFileName write FSensorRouteFileName;
    property ProjectInfoFileName: string read FProjectInfoFileName write FProjectInfoFileName;
    property UserFileName: string read FUserFileName write FUserFileName;
    property ManualInfoFileName: string read FManualInfoFileName write FManualInfoFileName;

    property HiMECSFormPath: string read FHiMECSFormPath write FHiMECSFormPath;
    property ConfigPath: string read FConfigPath write FConfigPath;
    property DocPath: string read FDocPath write FDocPath;
    property ExesPath: string read FExesPath write FExesPath;
    property BplsPath: string read FBplsPath write FBplsPath;
    property LogPath: string read FLogPath write FLogPath;

    property ExtAppInMDI: Boolean read FExtAppInMDI write FExtAppInMDI;
    property UseMonLauncher: Boolean read FUseMonLauncher write FUseMonLauncher;
    property UseCommLauncher: Boolean read FUseCommLauncher write FUseCommLauncher;
    property EngParamEncrypt: Boolean read FEngParamEncrypt write FEngParamEncrypt;
    property EngParamFileFormat: Integer read FEngParamFileFormat write FEngParamFileFormat;

    property FTPHost: string read FFTPHost write FFTPHost;
    property FTPPort: integer read FFTPPort write FFTPPort;
    property FTPUserID: string read FFTPUserID write FFTPUserID;
    property FTPPasswd: string read FFTPPasswd write FFTPPasswd;
    property FTPDirectory: string read FFTPDirectory write FFTPDirectory;
    property ServerURL: string read FServerURL write FServerURL;
    property UpdateProtocol: integer read FUpdateProtocol write FUpdateProtocol;
    property UpdateWhenStart: Boolean read FUpdateWhenStart write FUpdateWhenStart;
    property KillProcListFileName: string read FKillProcListFileName write FKillProcListFileName;
  end;

  THiMECSConfig2Item = class(TCollectionItem)
  private
  published
  end;

  THiMECSConfig2Collect = class(TCollection)
  private
    function GetItem(Index: Integer): THiMECSConfig2Item;
    procedure SetItem(Index: Integer; const Value: THiMECSConfig2Item);
  public
    function  Add: THiMECSConfig2Item;
    function Insert(Index: Integer): THiMECSConfig2Item;
    property Items[Index: Integer]: THiMECSConfig2Item read GetItem  write SetItem; default;
  end;

implementation

function THiMECSConfig2Collect.Add: THiMECSConfig2Item;
begin
  Result := THiMECSConfig2Item(inherited Add);
end;

function THiMECSConfig2Collect.GetItem(Index: Integer): THiMECSConfig2Item;
begin
  Result := THiMECSConfig2Item(inherited Items[Index]);
end;

function THiMECSConfig2Collect.Insert(Index: Integer): THiMECSConfig2Item;
begin
  Result := THiMECSConfig2Item(inherited Insert(Index));
end;

procedure THiMECSConfig2Collect.SetItem(Index: Integer; const Value: THiMECSConfig2Item);
begin
  Items[Index].Assign(Value);
end;

{ THiMECSConfig2 }

procedure THiMECSConfig2.Clear;
begin
//  HiMECSConfig2Collect.Clear;
{  MenuFileName := '';
  HiMECSFormPath := '';
  ConfigPath := '';
  DocPath := '';
  ExesPath := ''; }
end;

constructor THiMECSConfig2.Create(AOwner: TComponent);
begin
  FHiMECSConfig2Collect := THiMECSConfig2Collect.Create(THiMECSConfig2Item);
end;

destructor THiMECSConfig2.Destroy;
var
  i: integer;
begin
  FHiMECSConfig2Collect.Free;
  inherited Destroy;
end;

end.
