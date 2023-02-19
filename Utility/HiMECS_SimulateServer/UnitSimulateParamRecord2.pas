unit UnitSimulateParamRecord2;

interface

uses
  Classes,
{$IFDEF USE_DYNAMIC_SQLITE}
  SynSqlite3,
{$ENDIF}
  mormot.core.base, mormot.core.os, mormot.orm.core, mormot.rest.client,
  mormot.rest.sqlite3, mormot.core.variants,
  UnitVesselData2, UnitHGSCurriculumData, UnitMultiStateRecord2;

const
  HGS_SIMULATE_PARAM_DB_NAME = 'HGSSimulateParameter.sqlite';

type
  TSimParamSearchRec = record
    fModelName,
    fProjectName,
    fSystemName,
    fSubSystemName,
    fSubject,
    fDesc
    : RawUTF8;
    fProductType: TShipProductType;
    fCourseLevel: TAcademyCourseLevel;
    fActivityLevel: TAcademyActivityLevel;
    fSeqNo: integer;
    fEnable,
    fIsCreateNewRec: Boolean;
  end;

  TSQLSimulateParamRecord = class(TOrm)
  private
    fProductType: TShipProductType;
    fCourseLevel: TAcademyCourseLevel;
    fActivityLevel: TAcademyActivityLevel;
    fModelName,
    fProjectName,
    fSystemName,
    fSubSystemName,
    fSubject,
    fDesc,
    fParamSourceList,//Parameter Source가 String type으로 저장 됨("ECS By AVAT2,SCR By BachMann")
    fJsonParamCollect,
    fCSVValues,
    fDFMText,
    fFileDBPath,
    fFileDBName,
    fCommandJson,//Design Form의 특정 컴포넌트에 추가 명령을 전달함
    fDFPageCaption //Design Form Caption(Simulate Transfer시 화면 이동 가능함)
    : RawUTF8;

    fDisplaySeqNo,
    fSeqNo,
    fDelaySecs,
    fDFPageIndex: integer;//AdvPageIndex(Simulate Transfer시 화면 이동 가능함)
    fFileCount: integer;

    fEnable, fUseBalloon: Boolean;
    fUpdateDate: TTimeLog;
  public
    FIsUpdate: Boolean;
    property IsUpdate: Boolean read FIsUpdate write FIsUpdate;
  published
    property ProductType: TShipProductType read fProductType write fProductType;
    property CourseLevel: TAcademyCourseLevel read fCourseLevel write fCourseLevel;
    property ActivityLevel: TAcademyActivityLevel read fActivityLevel write fActivityLevel;
    property ModelName: RawUTF8 read fModelName write fModelName;
    property ProjectName: RawUTF8 read fProjectName write fProjectName;
    property DisplaySeqNo: integer read fSeqNo write fSeqNo;
    property SystemName: RawUTF8 read fSystemName write fSystemName;
    property SubSystemName: RawUTF8 read fSubSystemName write fSubSystemName;
    property Subject: RawUTF8 read fSubject write fSubject;
    property Desc: RawUTF8 read fDesc write fDesc;
    property CommandJson: RawUTF8 read fCommandJson write fCommandJson;
    property ParamSourceList: RawUTF8 read fParamSourceList write fParamSourceList;
    property JsonParamCollect: RawUTF8 read fJsonParamCollect write fJsonParamCollect;
    property CSVValues: RawUTF8 read fCSVValues write fCSVValues;
    property DFMText: RawUTF8 read fDFMText write fDFMText;
    property FileDBPath: RawUTF8 read fFileDBPath write fFileDBPath;
    property FileDBName: RawUTF8 read fFileDBName write fFileDBName;
    property SeqNo: integer read fSeqNo write fSeqNo;
    property DelaySecs: integer read fDelaySecs write fDelaySecs;
    property FileCount: integer read fFileCount write fFileCount;
    property DFPageCaption: RawUTF8 read fDFPageCaption write fDFPageCaption;
    property DFPageIndex: integer read fDFPageIndex write fDFPageIndex;
    property Enable: Boolean read fEnable write fEnable;
    //True : Description을 SharedMM을 통해 소비자에 전달함
    property UseBalloon: Boolean read fUseBalloon write fUseBalloon;
    property UpdateDate: TTimeLog read fUpdateDate write fUpdateDate;
  end;

function InitSimulateParamClient(ASimulateParamDBName: string;
  var ASimulateParamModel: TSQLModel):TRestClientDB;
function CreateSimulateParamModel: TSQLModel;
procedure DestroySimulateParam(ASimulateParamDB: TSQLRestClientURI=nil; ASimulateParamModel: TSQLModel=nil);

function GetSimulateParamRecordFromSearchRec(ASimParamSearchRec: TSimParamSearchRec; ASimulateParamDB: TSQLRestClientURI = nil): TSQLSimulateParamRecord;
function GetVariantFromSimulateParamRecord(ASQLSimulateParamRecord:TSQLSimulateParamRecord): variant;
function GetSimulateParamFromSubject(const ASubject: string; ACourseName : string = '';
  ASimulateParamDB: TSQLRestClientURI = nil): TSQLSimulateParamRecord;
procedure LoadSimulateParamFromVariant(ASQLSimulateParamRecord: TSQLSimulateParamRecord; ADoc: variant);

procedure AddOrUpdateSimulateParam(ASQLSimulateParamRecord: TSQLSimulateParamRecord; ASimulateParamDB: TSQLRestClientURI = nil);
function AddOrUpdateSimulateParamFromVariant(ADoc: variant; AIsOnlyAdd: Boolean = False; ASimulateParamDB: TSQLRestClientURI = nil): integer;
procedure DeleteSimulateParam(const ASubject: string; ACourseName : string = ''; ASimulateParamDB: TSQLRestClientURI = nil); overload;
procedure DeleteSimulateParam(const ASimParamSearchRec: TSimParamSearchRec; ASimulateParamDB: TSQLRestClientURI = nil); overload;

var
  g_SimulateParamDB: TRestClientDB;
  SimulateParamModel: TSQLModel;

implementation

uses SysUtils, Forms, VarRecUtils, Vcl.Dialogs, UnitStringUtil,
  UnitFolderUtil2, UnitRttiUtil2;

function InitSimulateParamClient(ASimulateParamDBName: string;
  var ASimulateParamModel: TSQLModel):TRestClientDB;
var
  LStr: string;
begin
  if ASimulateParamDBName = '' then
  begin
    ASimulateParamDBName := ChangeFileExt(ExtractFilePath(Application.ExeName),'.sqlite');
    LStr := GetDefaultDBPath;
  end
  else
  begin
    LStr := ExtractFilePath(ASimulateParamDBName);
    ASimulateParamDBName := ExtractFileName(ASimulateParamDBName);

    if LStr = '' then
      LStr := GetDefaultDBPath;
  end;

  LStr := EnsureDirectoryExists(LStr);
  LStr := LStr + ASimulateParamDBName;
  ASimulateParamModel:= CreateSimulateParamModel;
  Result:= TRestClientDB.Create(ASimulateParamModel, CreateSimulateParamModel,
    LStr, TSQLRestServerDB);
  TSQLRestClientDB(Result).Server.CreateMissingTables;
end;

function CreateSimulateParamModel: TSQLModel;
begin
  result := TSQLModel.Create([TSQLSimulateParamRecord, TEngineMultiStateRecord]);
end;

procedure DestroySimulateParam(ASimulateParamDB: TSQLRestClientURI; ASimulateParamModel: TSQLModel);
begin
  if not Assigned(ASimulateParamDB) then
    ASimulateParamDB := g_SimulateParamDB;

  if not Assigned(ASimulateParamModel) then
    ASimulateParamModel := SimulateParamModel;

  if Assigned(ASimulateParamModel) then
    FreeAndNil(ASimulateParamModel);

  if Assigned(ASimulateParamDB) then
    FreeAndNil(ASimulateParamDB);
end;

function GetSimulateParamRecordFromSearchRec(ASimParamSearchRec: TSimParamSearchRec;
  ASimulateParamDB: TSQLRestClientURI): TSQLSimulateParamRecord;
var
  ConstArray: TConstArray;
  LWhere, LStr: string;
  LFrom, LTo: TTimeLog;
begin
  if not Assigned(ASimulateParamDB) then
    ASimulateParamDB := g_SimulateParamDB;

  if not Assigned(ASimulateParamDB) then
  begin
    ShowMessage('Not assigned DB from GetSimulateParamRecordFromSearchRec');
    exit
  end;

  if ASimParamSearchRec.fIsCreateNewRec then
  begin
    Result := TSQLSimulateParamRecord.Create;
    exit;
  end;

  LWhere := '';
  ConstArray := CreateConstArray([]);
  try
    if ASimParamSearchRec.fProductType <> shptNull then
    begin
      AddConstArray(ConstArray, [Ord(ASimParamSearchRec.fProductType)]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ProductType = ? ';
    end;

    if ASimParamSearchRec.fEnable then
    begin
      AddConstArray(ConstArray, [ASimParamSearchRec.fEnable]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'Enable = ? ';
    end;

    if ASimParamSearchRec.fModelName <> '' then
    begin
      AddConstArray(ConstArray, [ASimParamSearchRec.fModelName]);//+'%'
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ModelName = ? ';
    end;

    if ASimParamSearchRec.fProjectName <> '' then
    begin
      AddConstArray(ConstArray, [ASimParamSearchRec.fProjectName]);//+'%'
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ProjectName = ? ';
    end;

    if ASimParamSearchRec.fSystemName <> '' then
    begin
      AddConstArray(ConstArray, [ASimParamSearchRec.fSystemName]);//+'%'
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'SystemName = ? ';
    end;

    if ASimParamSearchRec.fSubSystemName <> '' then
    begin
      AddConstArray(ConstArray, [ASimParamSearchRec.fSubSystemName]);//+'%'
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'SubSystemName = ? ';
    end;

    if ASimParamSearchRec.fSubject <> '' then
    begin
      AddConstArray(ConstArray, [ASimParamSearchRec.fSubject]);//+'%'
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'Subject = ? ';
    end;

    if ASimParamSearchRec.fDesc <> '' then
    begin
      AddConstArray(ConstArray, [ASimParamSearchRec.fDesc]);//+'%'
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'Desc = ? ';
    end;

    if ASimParamSearchRec.fSeqNo <> -1 then
    begin
      AddConstArray(ConstArray, [Ord(ASimParamSearchRec.fSeqNo)]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'SeqNo = ? ';
    end;

    if ASimParamSearchRec.fCourseLevel <> aclNull then
    begin
      AddConstArray(ConstArray, [Ord(ASimParamSearchRec.fCourseLevel)]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'CourseLevel = ? ';
    end;

    if ASimParamSearchRec.fActivityLevel <> aalNull then
    begin
      AddConstArray(ConstArray, [Ord(ASimParamSearchRec.fActivityLevel)]);
      if LWhere <> '' then
        LWhere := LWhere + ' and ';
      LWhere := LWhere + 'ActivityLevel = ? ';
    end;

    if LWhere = '' then
    begin
      AddConstArray(ConstArray, [-1]);
      LWhere := 'ID <> ? ';
    end;

    LWhere := LWhere + ' ORDER BY SystemName, SubSystemName, DisplaySeqNo, SeqNo ';
    Result := TSQLSimulateParamRecord.CreateAndFillPrepare(ASimulateParamDB.Orm, Lwhere, ConstArray);

    if Result.FillOne then
    begin
//      Result.FillRewind;
      Result.IsUpdate := True;
    end;
  finally
    FinalizeConstArray(ConstArray);
  end;
end;

function GetVariantFromSimulateParamRecord(ASQLSimulateParamRecord:TSQLSimulateParamRecord): variant;
begin
  TDocVariant.New(Result);
  LoadRecordPropertyToVariant(ASQLSimulateParamRecord, Result);
  //JsonParamCollect 내용 중 Json 배열을 AsVariant가 인식하기 못하기 때문에 추가 작업을 해줌
end;

function GetSimulateParamFromSubject(const ASubject: string; ACourseName : string = '';
  ASimulateParamDB: TSQLRestClientURI = nil): TSQLSimulateParamRecord;
var
  LCurriculumRec: TSimParamSearchRec;
begin
  if not Assigned(ASimulateParamDB) then
    ASimulateParamDB := g_SimulateParamDB;

  if not Assigned(ASimulateParamDB) then
  begin
    ShowMessage('Not assigned DB');
    exit
  end;

  LCurriculumRec := Default(TSimParamSearchRec);
  LCurriculumRec.fSeqNo := -1;
  LCurriculumRec.fSubject := ASubject;
//  LCurriculumRec.fCourseName := ACourseName;

  Result := GetSimulateParamRecordFromSearchRec(LCurriculumRec, ASimulateParamDB);
end;

procedure LoadSimulateParamFromVariant(ASQLSimulateParamRecord: TSQLSimulateParamRecord; ADoc: variant);
begin
  if ADoc = null then
    exit;

  LoadRecordPropertyFromVariant(ASQLSimulateParamRecord, ADoc);
end;

procedure AddOrUpdateSimulateParam(ASQLSimulateParamRecord: TSQLSimulateParamRecord;
  ASimulateParamDB: TSQLRestClientURI = nil);
begin
  if not Assigned(ASimulateParamDB) then
    ASimulateParamDB := g_SimulateParamDB;

  if not Assigned(ASimulateParamDB) then
  begin
    ShowMessage('Not assigned DB from AddOrUpdateSimulateParam');
    exit
  end;

  if ASQLSimulateParamRecord.IsUpdate then
  begin
    ASimulateParamDB.Update(ASQLSimulateParamRecord);
    ShowMessage('Data is Updated');
  end
  else
  begin
    ASimulateParamDB.Add(ASQLSimulateParamRecord, true);
    ShowMessage('Data is Added');
  end;
end;

function AddOrUpdateSimulateParamFromVariant(ADoc: variant; AIsOnlyAdd: Boolean;
  ASimulateParamDB: TSQLRestClientURI): integer;
var
  LSQLSimulateParamRecord: TSQLSimulateParamRecord;
  LIsUpdate: Boolean;
  LSimParamSearchRec: TSimParamSearchRec;
begin
  LSimParamSearchRec := Default(TSimParamSearchRec);
  LSimParamSearchRec.fSeqNo := -1;
  //Enumeration Type은 Type Name으로 저장됨
  LSimParamSearchRec.fProductType := g_ShipProductType.ToTypeFromEnumString(ADoc.ProductType);
  LSimParamSearchRec.fCourseLevel := g_AcademyCourseLevelDesc.ToTypeFromEnumString(ADoc.CourseLevel);
  LSimParamSearchRec.fActivityLevel := g_AcademyActivityLevelDesc.ToTypeFromEnumString(ADoc.ActivityLevel);
  LSimParamSearchRec.fModelName := ADoc.ModelName;
  LSimParamSearchRec.fProjectName := ADoc.ProjectName;
  LSimParamSearchRec.fSystemName := ADoc.SystemName;
  LSimParamSearchRec.fSubSystemName := ADoc.SubSystemName;
//  LSimParamSearchRec.fSubject := ADoc.Subject;
  LSimParamSearchRec.fSeqNo := ADoc.SeqNo;

  LSQLSimulateParamRecord := GetSimulateParamRecordFromSearchRec(LSimParamSearchRec, ASimulateParamDB);
  LIsUpdate := LSQLSimulateParamRecord.IsUpdate;
  try
    if AIsOnlyAdd then
    begin
      if not LSQLSimulateParamRecord.IsUpdate then
      begin
        LoadSimulateParamFromVariant(LSQLSimulateParamRecord, ADoc);
        LSQLSimulateParamRecord.IsUpdate := LIsUpdate;

        AddOrUpdateSimulateParam(LSQLSimulateParamRecord, ASimulateParamDB);
        Inc(Result);
      end;
    end
    else
    begin
      if LSQLSimulateParamRecord.IsUpdate then
        Inc(Result);

      LoadSimulateParamFromVariant(LSQLSimulateParamRecord, ADoc);
      LSQLSimulateParamRecord.IsUpdate := LIsUpdate;

      AddOrUpdateSimulateParam(LSQLSimulateParamRecord, ASimulateParamDB);
    end;
  finally
    FreeAndNil(LSQLSimulateParamRecord);
  end;
end;

procedure DeleteSimulateParam(const ASubject: string; ACourseName : string = '';
  ASimulateParamDB: TSQLRestClientURI = nil);overload;
var
  LSimulateParamRecord: TSQLSimulateParamRecord;
begin
  if not Assigned(ASimulateParamDB) then
    ASimulateParamDB := g_SimulateParamDB;

  if not Assigned(ASimulateParamDB) then
  begin
    ShowMessage('Not assigned DB');
    exit
  end;

  LSimulateParamRecord := GetSimulateParamFromSubject(ASubject, ACourseName);
  try
    if LSimulateParamRecord.IsUpdate then
      ASimulateParamDB.Delete(TSQLSimulateParamRecord, LSimulateParamRecord.ID);
  finally
    LSimulateParamRecord.Free;
  end;
end;

procedure DeleteSimulateParam(const ASimParamSearchRec: TSimParamSearchRec;
  ASimulateParamDB: TSQLRestClientURI = nil); overload;
var
  LSimulateParamRecord: TSQLSimulateParamRecord;
begin
  if not Assigned(ASimulateParamDB) then
    ASimulateParamDB := g_SimulateParamDB;

  if not Assigned(ASimulateParamDB) then
  begin
    ShowMessage('Not assigned DB');
    exit
  end;

  LSimulateParamRecord := GetSimulateParamRecordFromSearchRec(ASimParamSearchRec);
  try
    if LSimulateParamRecord.IsUpdate then
    begin
      LSimulateParamRecord.FillRewind;

      while LSimulateParamRecord.FillOne do
        ASimulateParamDB.Delete(TSQLSimulateParamRecord, LSimulateParamRecord.ID);
    end;
  finally
    LSimulateParamRecord.Free;
  end;
end;

initialization
{$IFDEF USE_DYNAMIC_SQLITE}
  FreeAndNil(sqlite3);
  sqlite3 := TSQLite3LibraryDynamic.Create();
{$ENDIF}

finalization
{$IFDEF USE_DYNAMIC_SQLITE}
  FreeAndNil(sqlite3);
{$ENDIF}
  DestroySimulateParam;

end.

