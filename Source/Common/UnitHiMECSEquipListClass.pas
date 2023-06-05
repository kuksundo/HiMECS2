unit UnitHiMECSEquipListClass;

interface

uses classes, SysUtils, ExtCtrls, Vcl.Graphics, UnitTileListBase;

type
  THiMECSEquipListCollect = class;
  THiMECSEquipListItem = class;

  THiMECSEquipList = class(THiMECSTileListBase)
  private
    FEquipListCollect: THiMECSEquipListCollect;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

  published
    property EquipListCollect: THiMECSEquipListCollect read FEquipListCollect write FEquipListCollect;
  end;

  PEquipListItem = ^THiMECSEquipListItem;
  THiMECSEquipListItem = class(TCollectionItem)
  private
    FEquipTitle,
    FEquipFileName,//watch file name
    FRunProgramName, //실행 프로그램 이름: HiMECS_Watch2.exe
    FRunParameter,
    FEquipDesc,
    FEquipImage: string;
    FTileIndex: integer;//TileList의 Index
    FIsRelativePath: Boolean;//True = AppPath가 상대 경로임(HiMECS Bin 기준)
    FIsProgRelativePath: Boolean;//True = AppPath가 상대 경로임(HiMECS Bin 기준)
    FIsAutoLoad: Boolean;//True = 자동 로드, False = 수동 로드
    FAppHandle: integer; //실행창 핸들(Sendmessage시에 사용됨)
    FAppProcessId: THandle;
  public
    procedure Assign(Source: TPersistent); override;
    property AppProcessId: THandle read FAppProcessId write FAppProcessId;
  published
    property EquipTitle: string read FEquipTitle write FEquipTitle;
    property EquipFileName: string read FEquipFileName write FEquipFileName;
    property RunParameter: string read FRunParameter write FRunParameter;
    property RunProgramName: string read FRunProgramName write FRunProgramName;
    property EquipDesc: string read FEquipDesc write FEquipDesc;
    property EquipImage: string read FEquipImage write FEquipImage;
    property IsRelativePath: Boolean read FIsRelativePath write FIsRelativePath;
    property IsProgRelativePath: Boolean read FIsProgRelativePath write FIsProgRelativePath;
    property TileIndex: integer read FTileIndex write FTileIndex;
    property IsAutoLoad: Boolean read FIsAutoLoad write FIsAutoLoad;
    property AppHandle: integer read FAppHandle write FAppHandle;
  end;

  THiMECSEquipListCollect = class(TCollection)
  private
    function GetItem(Index: Integer): THiMECSEquipListItem;
    procedure SetItem(Index: Integer; const Value: THiMECSEquipListItem);
  public
    function  Add: THiMECSEquipListItem;
    function Insert(Index: Integer): THiMECSEquipListItem;
    property Items[Index: Integer]: THiMECSEquipListItem read GetItem  write SetItem; default;
  end;

implementation

constructor THiMECSEquipList.Create(AOwner: TComponent);
begin
  FEquipListCollect := THiMECSEquipListCollect.Create(THiMECSEquipListItem);
end;

destructor THiMECSEquipList.Destroy;
var
  i: integer;
begin
  inherited Destroy;
  FEquipListCollect.Free;
end;

function THiMECSEquipListCollect.Add: THiMECSEquipListItem;
begin
  Result := THiMECSEquipListItem(inherited Add);
end;

function THiMECSEquipListCollect.GetItem(Index: Integer): THiMECSEquipListItem;
begin
  Result := THiMECSEquipListItem(inherited Items[Index]);
end;

function THiMECSEquipListCollect.Insert(Index: Integer): THiMECSEquipListItem;
begin
  Result := THiMECSEquipListItem(inherited Insert(Index));
end;

procedure THiMECSEquipListCollect.SetItem(Index: Integer; const Value: THiMECSEquipListItem);
begin
  Items[Index].Assign(Value);
end;

{ THiMECSEquipListItem }

procedure THiMECSEquipListItem.Assign(Source: TPersistent);
begin
  if Source is THiMECSEquipListItem then
  begin
    EquipTitle := THiMECSEquipListItem(Source).EquipTitle;
    EquipFileName := THiMECSEquipListItem(Source).EquipFileName;
    EquipDesc := THiMECSEquipListItem(Source).EquipDesc;
    EquipImage := THiMECSEquipListItem(Source).EquipImage;
    IsRelativePath := THiMECSEquipListItem(Source).IsRelativePath;
    TileIndex := THiMECSEquipListItem(Source).TileIndex;
    IsAutoLoad := THiMECSEquipListItem(Source).IsAutoLoad;
    AppHandle := THiMECSEquipListItem(Source).AppHandle;
  end
  else
    inherited;
end;

end.
