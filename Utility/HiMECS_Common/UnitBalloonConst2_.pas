unit UnitBalloonConst2;

interface

type
  TBalloonKind = (bkBalloonBasic, bkJvBallonHint);
  TBalloonRecord = record
    Command,
    CompName,//Balloon을 표시할 컴포넌트 이름
    Header,
    Text: string;
    IsShow,
    BalloonShowOnlyMine: Boolean;
    Kind: TBalloonKind;
    X,Y: integer;
  end;

function GetBalloonRecordFromJson(var ABalloonRecord: TBalloonRecord; const AJson: string): Boolean;
function GetBalloonRecordToJson(const ARecord: TBalloonRecord): string;

implementation

uses mormot.core.base, mormot.core.unicode, mormot.core.json;

function GetBalloonRecordFromJson(var ABalloonRecord: TBalloonRecord;
  const AJson: string): Boolean;
var
  LUtf8: RawUTF8;
begin
  LUtf8 := StringToUtf8(AJson);
  Result := RecordLoadJson(ABalloonRecord, LUtf8, TypeInfo(TBalloonRecord));
end;

function GetBalloonRecordToJson(
  const ARecord: TBalloonRecord): string;
begin
  Result := RecordSaveJson(ARecord, TypeInfo(TBalloonRecord));
end;



end.
