unit UnitProjectGroupClass;

interface

uses System.SysUtils, classes,
  Generics.Legacy, JHP.BaseConfigCollect, UnitProjectBaseClass2, UnitProjectFileClass2;

type
  TProjectGroupItemBase = class(TCollectionItem)
  private
    FProjectGroupNo, //Vessel 공사번호
    FProjectGroupName
    : string;
  published
    property ProjectGroupNo: string read FProjectGroupNo write FProjectGroupNo;
    property ProjectGroupName: string read FProjectGroupName write FProjectGroupName;
  end;

  TProjectGroupItem4Vessel = class(TProjectGroupItemBase)
  private
    FProjectFile: TProjectFile;
  public
    property ProjectFile: TProjectFile read FProjectFile write FProjectFile;
  end;

  TProjectGroupCollect<T: TProjectGroupItem4Vessel> = class(Generics.Legacy.TCollection<T>)
  private
  public
    destructor Destroy; override;
    function Add: TProjectGroupItem4Vessel;
  end;

  THiMECSProjectGroup = class(TpjhBase)
  private
    FProjectGroupCollect: TProjectGroupCollect<TProjectGroupItem4Vessel>;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Clear;

    property ProjectGroupCollect: TProjectGroupCollect<TProjectGroupItem4Vessel> read FProjectGroupCollect write FProjectGroupCollect;
  end;

implementation

{ THiMECSProjectGroup }

procedure THiMECSProjectGroup.Clear;
begin

end;

constructor THiMECSProjectGroup.Create(AOwner: TComponent);
begin
  FProjectGroupCollect := TProjectGroupCollect<TProjectGroupItem4Vessel>.Create;
end;

destructor THiMECSProjectGroup.Destroy;
begin
  FProjectGroupCollect.Free;

  inherited Destroy;
end;

{ TProjectGroupCollect<T> }

function TProjectGroupCollect<T>.Add: TProjectGroupItem4Vessel;
begin
  Result := TProjectGroupItem4Vessel(inherited Add);
  Result.FProjectFile := TProjectFile.Create(nil);
end;

destructor TProjectGroupCollect<T>.Destroy;
var
  i: integer;
  LItem4Vessel: TProjectGroupItem4Vessel;
begin
  for i := 0 to Count - 1 do
  begin
    LItem4Vessel := Items[i];
    LItem4Vessel.ProjectFile.Free;
  end;

  inherited;
end;

end.
