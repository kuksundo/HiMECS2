unit UnitHiMECSMonitorListClass2;

interface

uses classes, SysUtils, ExtCtrls, Vcl.Graphics, JHP.BaseConfigCollect;

type
  THiMECSMonitorListCollect = class;
  THiMECSMonitorListItem = class;

  THiMECSMonitorList = class(TpjhBase)
  private
    FMonListTitle,
    FMonListPath: string;
    FMonitorListCollect: THiMECSMonitorListCollect;
    //TAdvSmoothTileList(Monitoring List/Communication List) ������
    FTileRowNum,
    FTileColNum: integer;
    FLauncherHandle: THandle;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

  published
    property MonitorListCollect: THiMECSMonitorListCollect read FMonitorListCollect write FMonitorListCollect;
    property TileRowNum: integer read FTileRowNum write FTileRowNum;
    property TileColNum: integer read FTileColNum write FTileColNum;
    property LauncherHandle: THandle read FLauncherHandle write FLauncherHandle;
  end;

  PMonitorListItem = ^THiMECSMonitorListItem;
  THiMECSMonitorListItem = class(TCollectionItem)
  private
    FMonitorTitle,
    FMonitorFileName,//watch file name
    FRunProgramName, //���� ���α׷� �̸�: HiMECS_Watch2.exe
    FRunParameter,
    FMonitorDesc,
    FMonitorImage: string;
    FTileIndex: integer;//TileList�� Index
    FIsRelativePath: Boolean;//True = AppPath�� ��� �����(HiMECS Bin ����)
    FIsProgRelativePath: Boolean;//True = AppPath�� ��� �����(HiMECS Bin ����)
    FIsAutoLoad: Boolean;//True = �ڵ� �ε�, False = ���� �ε�
    FAppHandle: integer; //����â �ڵ�(Sendmessage�ÿ� ����)
    FAppProcessId: THandle;
  public
    procedure Assign(Source: TPersistent); override;
    property AppProcessId: THandle read FAppProcessId write FAppProcessId;
  published
    property MonitorTitle: string read FMonitorTitle write FMonitorTitle;
    property MonitorFileName: string read FMonitorFileName write FMonitorFileName;
    property RunParameter: string read FRunParameter write FRunParameter;
    property RunProgramName: string read FRunProgramName write FRunProgramName;
    property MonitorDesc: string read FMonitorDesc write FMonitorDesc;
    property MonitorImage: string read FMonitorImage write FMonitorImage;
    property IsRelativePath: Boolean read FIsRelativePath write FIsRelativePath;
    property IsProgRelativePath: Boolean read FIsProgRelativePath write FIsProgRelativePath;
    property TileIndex: integer read FTileIndex write FTileIndex;
    property IsAutoLoad: Boolean read FIsAutoLoad write FIsAutoLoad;
    property AppHandle: integer read FAppHandle write FAppHandle;
  end;

  THiMECSMonitorListCollect = class(TCollection)
  private
    function GetItem(Index: Integer): THiMECSMonitorListItem;
    procedure SetItem(Index: Integer; const Value: THiMECSMonitorListItem);
  public
    function  Add: THiMECSMonitorListItem;
    function Insert(Index: Integer): THiMECSMonitorListItem;
    property Items[Index: Integer]: THiMECSMonitorListItem read GetItem  write SetItem; default;
  end;

implementation

constructor THiMECSMonitorList.Create(AOwner: TComponent);
begin
  FMonitorListCollect := THiMECSMonitorListCollect.Create(THiMECSMonitorListItem);
end;

destructor THiMECSMonitorList.Destroy;
var
  i: integer;
begin
  inherited Destroy;
  FMonitorListCollect.Free;
end;

function THiMECSMonitorListCollect.Add: THiMECSMonitorListItem;
begin
  Result := THiMECSMonitorListItem(inherited Add);
end;

function THiMECSMonitorListCollect.GetItem(Index: Integer): THiMECSMonitorListItem;
begin
  Result := THiMECSMonitorListItem(inherited Items[Index]);
end;

function THiMECSMonitorListCollect.Insert(Index: Integer): THiMECSMonitorListItem;
begin
  Result := THiMECSMonitorListItem(inherited Insert(Index));
end;

procedure THiMECSMonitorListCollect.SetItem(Index: Integer; const Value: THiMECSMonitorListItem);
begin
  Items[Index].Assign(Value);
end;

{ THiMECSMonitorListItem }

procedure THiMECSMonitorListItem.Assign(Source: TPersistent);
begin
  if Source is THiMECSMonitorListItem then
  begin
    MonitorTitle := THiMECSMonitorListItem(Source).MonitorTitle;
    MonitorFileName := THiMECSMonitorListItem(Source).MonitorFileName;
    MonitorDesc := THiMECSMonitorListItem(Source).MonitorDesc;
    MonitorImage := THiMECSMonitorListItem(Source).MonitorImage;
    IsRelativePath := THiMECSMonitorListItem(Source).IsRelativePath;
    TileIndex := THiMECSMonitorListItem(Source).TileIndex;
    IsAutoLoad := THiMECSMonitorListItem(Source).IsAutoLoad;
    AppHandle := THiMECSMonitorListItem(Source).AppHandle;
  end
  else
    inherited;
end;

end.
