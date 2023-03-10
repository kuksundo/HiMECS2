unit UnitMultiStateRecord2;

interface

uses Classes, System.SysUtils, Vcl.Dialogs,
  mormot.orm.core, mormot.rest.client, mormot.core.base, mormot.core.data,
  mormot.orm.base, mormot.rest.sqlite3;

type
  TEngineMultiStateRecord = class(TSQLRecord)
  private
    FTagName,
    FAddress,
    FStateDesc: string;
    FStateValue: integer;
    FStateMeaning: string;
  public
    FIsUpdate: Boolean;
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property TagName: string read FTagName write FTagName;
    property Address: string read FAddress write FAddress;
    property StateDesc: string read FStateDesc write FStateDesc;
    property StateValue: integer read FStateValue write FStateValue;
    property StateMeaning: string read FStateMeaning write FStateMeaning;
  end;

//For TEngineMultiStateRecord
function GetEngineMultiStateList2JSONArrayFromSqlite(AEngineParamDB: TRestClientDB = nil): RawUTF8;
function GetEngineMultiStateList2JSONArrayFromTagName(ATagName: string; AEngineParamDB: TRestClientDB = nil): RawUTF8;
function GetEngineMultiStateRecFromSqlite(AEngineParamDB: TRestClientDB = nil): TEngineMultiStateRecord;
function GetEngineMultiStateRecFromTagName(ATagName: string; AEngineParamDB: TRestClientDB = nil): TEngineMultiStateRecord;
procedure AddOrUpdatedEngineMultiStateRec(ARecord: TEngineMultiStateRecord; AEngineParamDB: TRestClientDB = nil);

implementation

uses UnitEngineParamRecord2;

function GetEngineMultiStateList2JSONArrayFromSqlite(AEngineParamDB: TRestClientDB): RawUTF8;
var
  LEngineMultiStateRecord:TEngineMultiStateRecord;
  LUtf8: RawUTF8;
  LDynUtf8: TRawUTF8DynArray;
  LDynArr: TDynArray;
begin
  LDynArr.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8);
  LEngineMultiStateRecord := GetEngineMultiStateRecFromSqlite(AEngineParamDB);

  try
    LEngineMultiStateRecord.FillRewind;

    while LEngineMultiStateRecord.FillOne do
    begin
      LUtf8 := LEngineMultiStateRecord.GetJSONValues(true, true, soSelect);
      LDynArr.Add(LUtf8);
    end;

    LUtf8 := LDynArr.SaveToJSON;
    Result := LUtf8;
  finally
    FreeAndNil(LEngineMultiStateRecord);
  end;
end;

function GetEngineMultiStateList2JSONArrayFromTagName(ATagName: string; AEngineParamDB: TRestClientDB): RawUTF8;
var
  LEngineMultiStateRecord:TEngineMultiStateRecord;
  LUtf8: RawUTF8;
  LDynUtf8: TRawUTF8DynArray;
  LDynArr: TDynArray;
begin
  LDynArr.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8);
  LEngineMultiStateRecord := GetEngineMultiStateRecFromTagName(ATagName, AEngineParamDB);

  if not Assigned(LEngineMultiStateRecord) then
  begin
    Showmessage('g_EngineParamDB is nill');
    Result := '';
    exit;
  end;

  try
    LEngineMultiStateRecord.FillRewind;

    while LEngineMultiStateRecord.FillOne do
    begin
      LUtf8 := LEngineMultiStateRecord.GetJSONValues(true, true, soSelect);
      LDynArr.Add(LUtf8);
    end;

    LUtf8 := LDynArr.SaveToJSON;
    Result := LUtf8;
  finally
    FreeAndNil(LEngineMultiStateRecord);
  end;
end;

function GetEngineMultiStateRecFromSqlite(AEngineParamDB: TRestClientDB): TEngineMultiStateRecord;
begin
  if not Assigned(AEngineParamDB) then
    AEngineParamDB := g_EngineParamDB;

  Result := TEngineMultiStateRecord.CreateAndFillPrepare(AEngineParamDB.orm,
      'ID <> ?', [-1]); //ORDER BY TagName, StateValue

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

function GetEngineMultiStateRecFromTagName(ATagName: string; AEngineParamDB: TRestClientDB): TEngineMultiStateRecord;
begin
  if not Assigned(AEngineParamDB) then
    if Assigned(g_EngineParamDB) then
      AEngineParamDB := g_EngineParamDB
    else
    begin
      Result := nil;
      exit;
    end;

  Result := TEngineMultiStateRecord.CreateAndFillPrepare(AEngineParamDB.orm,
      'TagName = ? ORDER BY StateValue', [ATagName]);

  if Result.FillOne then
    Result.IsUpdate := True
  else
    Result.IsUpdate := False;
end;

procedure AddOrUpdatedEngineMultiStateRec(ARecord: TEngineMultiStateRecord; AEngineParamDB: TRestClientDB);
begin
  if not Assigned(AEngineParamDB) then
    AEngineParamDB := g_EngineParamDB;

  if ARecord.IsUpdate then
  begin
    AEngineParamDB.Update(ARecord);
  end
  else
  begin
    AEngineParamDB.Add(ARecord, true);
  end;
end;

end.
