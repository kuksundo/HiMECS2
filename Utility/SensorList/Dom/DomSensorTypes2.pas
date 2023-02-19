unit DomSensorTypes2;

interface

uses
  System.Classes,
  mormot.core.base, mormot.core.json, mormot.core.data, mormot.orm.base,
  IniPersist, UnitConfigIniClass2, UnitSortInterfacedCollection2,
  UnitEngineElecPartClass2;

const
  DefaultSensorRouteDBFileName = 'SensorRoute.sqlite';

type
  TNotes = type RawUTF8;
  TProjectNo = type RawUTF8;
  TEngineNo = type RawUTF8;
  TTagName = type RawUTF8;
  TDueDate = type TDateTime;

  TSearchRec4Sensor = record
    FIsNewAdd: Boolean;
    FSubject: string;
    FProjectNo: TProjectNo;
    FProjectName: string;
    FCompletionDate: TDateTime;

  end;

//  TEngElecPartItem = class(TCollectionItemAutoCreateFields)
  TEngElecPartItem = class(TSynAutoCreateFields)//TSynPersistent
  private
    FParentNodeAbsIndex: integer;
    FParentNodeLevel: integer;

//    FLock: IAutoLocker;
    FLevelIndex,
    FNodeIndex,
    FAbsoluteIndex: integer;

    FProjectNo: TProjectNo;
    FProjectName: string;
    FEngineNo: TEngineNo;

    FEngSensor: TEngElecPartBase;
    FCreateTime,
    FModifiedTime: TTimeLog;
  protected
  public
    procedure AssignTo(Dest: TPersistent);
  published
    //Section Name, Key Name, Default Key Value, TagNo
    [IniValue('ProjectNo','ProjectNo','',200)]
    property ProjectNo: TProjectNo read FProjectNo write FProjectNo;
    [IniValue('ProjectName','ProjectName','',201)]
    property ProjectName: string read FProjectName write FProjectName;
    [IniValue('TEngineNo','TEngineNo','',202)]
    property EngineNo: TEngineNo read FEngineNo write FEngineNo;

    [IniValue('LevelIndex','LevelIndex','',203)]
    property LevelIndex: integer read FLevelIndex write FLevelIndex;
    [IniValue('NodeIndex','NodeIndex','',204)]
    property NodeIndex: integer read FNodeIndex write FNodeIndex;
    [IniValue('AbsoluteIndex','AbsoluteIndex','',205)]
    property AbsoluteIndex: integer read FAbsoluteIndex write FAbsoluteIndex;
    [IniValue('ParentNodeAbsIndex','ParentNodeAbsIndex','',206)]
    property ParentNodeAbsIndex: integer read FParentNodeAbsIndex write FParentNodeAbsIndex;
    [IniValue('ParentNodeLevel','ParentNodeLevel','',207)]
    property ParentNodeLevel: integer read FParentNodeLevel write FParentNodeLevel;
    //Key Value가 '->' 이면 Key Name을 이용해 SubClass에 접근함
    [IniValue('EngSensor','TEngSensor','->',208)]
    property EngSensor: TEngElecPartBase read FEngSensor;
    [IniValue('CreateTime','TTimeLog','',209)]
    property CreateTime: TTimeLog read FCreateTime write FCreateTime;
    [IniValue('ModifiedTime','TTimeLog','',210)]
    property ModifiedTime: TTimeLog read FModifiedTime write FModifiedTime;
  end;

  TEngElecPartItemObjArray = array of TEngElecPartItem;

  function GetItemByLevelNAbsIndex(ADynArray: TDynArray; ALevel, AAbsIndex: integer): TEngElecPartItem;
  function GetItemByLevelNAbsIndex2(ADynArray: TEngElecPartItemObjArray; ALevel, AAbsIndex: integer): TEngElecPartItem;
  function EngElecPartItemAbsoluteIndexCompare(const item1, item2): integer;
  function GetElecPartDisplayName(AEngElecPartItem: TEngElecPartItem): string;

//  TEngElecPartCollect = class(TSortableInterfacedCollection)
//  private
//    function GetCollItem(AIndex: integer): TEngElecPartItem;
//    function Compare(Item1, Item2 : TCollectionItem) : integer; override;
//  protected
//    class function GetClass: TCollectionItemClass; override;
//  public
////    procedure DeleteItemWithChildren(AEngElecPartItem: TEngElecPartItem);
//    function GetItemByLevelNAbsIndex(ALevel, AAbsIndex: integer): TEngElecPartItem;
//    function Add: TEngElecPartItem;
//    property Item[AIndex: integer]: TEngElecPartItem read GetCollItem; default;
//  end;

//  TEngSensorCableRoute = class
//  private
//    FCableNo: string;
//    FEngElecParts: TEngElecPartCollect;
//  published
//    property CableNo: string read FCableNo write FCableNo;
//    property EngElecParts: TEngElecPartCollect read FEngElecParts write FEngElecParts;
//  end;

implementation

uses UnitRttiUtil2;

{ TEngElecPartCollection }

//function TEngElecPartCollect.Add: TEngElecPartItem;
//begin
//  Result := TEngElecPartItem(inherited Add);
//end;
//
//function TEngElecPartCollect.Compare(Item1, Item2: TCollectionItem): integer;
//begin
//  if TEngElecPartItem(item1).FAbsoluteIndex < TEngElecPartItem(item2).FAbsoluteIndex then
//    Result := -1
//  else if TEngElecPartItem(item1).FAbsoluteIndex > TEngElecPartItem(item2).FAbsoluteIndex then
//    Result := 1
//  else Result := 0;
//end;
//
//function TEngElecPartCollect.GetItemByLevelNAbsIndex(
//  ALevel, AAbsIndex: integer): TEngElecPartItem;
//var
//  i: integer;
//begin
//  Result := nil;
//
//  for i := 0 to Count - 1 do
//  begin
//    if (Item[i].LevelIndex = ALevel) and (Item[i].AbsoluteIndex = AAbsIndex) then
//    begin
//      Result := Item[i];
//      Break;
//    end;
//  end;
//end;
//
//class function TEngElecPartCollect.GetClass: TCollectionItemClass;
//begin
//  Result := TEngElecPartItem;
//end;
//
//function TEngElecPartCollect.GetCollItem(AIndex: integer): TEngElecPartItem;
//begin
//  Result := TEngElecPartItem(GetItem(AIndex));
//end;

{ TEngElecPartItem }

procedure TEngElecPartItem.AssignTo(Dest: TPersistent);
var
  LEngElecPartBase: TEngElecPartBase;
begin
  PersistentCopy(TPersistent(Self), Dest);

  LEngElecPartBase := TEngElecPartItem(Dest).EngSensor;
  PersistentCopy(TPersistent(Self.EngSensor),
    TPersistent(LEngElecPartBase));
end;

function GetItemByLevelNAbsIndex(ADynArray: TDynArray; ALevel, AAbsIndex: integer): TEngElecPartItem;
var
  i: integer;
begin
  Result := nil;

  for i := 0 to ADynArray.Count - 1 do
  begin
    if (TEngElecPartItem(ADynArray.ItemPtr(i)^).LevelIndex = ALevel) and
      (TEngElecPartItem(ADynArray.ItemPtr(i)^).AbsoluteIndex = AAbsIndex) then
    begin
      Result := TEngElecPartItem(ADynArray.ItemPtr(i)^);
      Break;
    end;
  end;
end;

function GetItemByLevelNAbsIndex2(ADynArray: TEngElecPartItemObjArray; ALevel, AAbsIndex: integer): TEngElecPartItem;
var
  i: integer;
begin
  Result := nil;

  for i := 0 to High(ADynArray) do
  begin
    if (TEngElecPartItem(ADynArray[i]).LevelIndex = ALevel) and
      (TEngElecPartItem(ADynArray[i]).AbsoluteIndex = AAbsIndex) then
    begin
      Result := TEngElecPartItem(ADynArray[i]);
      Break;
    end;
  end;
end;

function EngElecPartItemAbsoluteIndexCompare(const item1, item2): integer;
begin
  if TEngElecPartItem(item1).FAbsoluteIndex < TEngElecPartItem(item2).FAbsoluteIndex then
    Result := -1
  else if TEngElecPartItem(item1).FAbsoluteIndex > TEngElecPartItem(item2).FAbsoluteIndex then
    Result := 1
  else Result := 0;
end;

function GetElecPartDisplayName(
  AEngElecPartItem: TEngElecPartItem): string;
begin
  if AEngElecPartItem.EngSensor.ModuleName = '' then
    Result := AEngElecPartItem.EngSensor.PanelName + '/' +
      AEngElecPartItem.EngSensor.TerminalName + '/' +
      AEngElecPartItem.EngSensor.TerminalNo
  else
    Result := AEngElecPartItem.EngSensor.PanelName + '/' +
      AEngElecPartItem.EngSensor.ModuleName + '/' +
      AEngElecPartItem.EngSensor.ChannelNo
end;

initialization
  TJSONSerializer.RegisterObjArrayForJSON([
    TypeInfo(TEngElecPartItemObjArray), TEngElecPartItem
  ]);

end.
