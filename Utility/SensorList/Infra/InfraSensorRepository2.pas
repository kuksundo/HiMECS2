unit InfraSensorRepository2;

interface

uses
  SysUtils,
  Sx.DDD.Core, mormot.orm.core, mormot.core.base, mormot.rest.core, mormot.core.search,
  UnitEngineElecPartClass2,
  UnitECUData2, HiMECSConst2,
  DomSensorCQRS2,
  DomSensorInterfaces2,
  DomSensorServices2,
  DomSensorTypes2,

  InfraSensorTypes2;

type
  /// ORM class corresponding to TEngElecPartBase DDD aggregate
  TSQLRecordEngElecPartItem = class(TOrm)
  protected
    fProjectNo: RawUTF8; // TProjectNo
    fProjectName: RawUTF8; // string
    fEngineNo: RawUTF8; // TEngineNo
    fLevelIndex: integer; // Integer
    fNodeIndex: integer; // Integer
    fAbsoluteIndex: integer; // Integer
    fParentNodeAbsIndex: integer; // Integer
    fParentNodeLevel: integer; // Integer
    fEngSensor_PartType: TEngElecPartType; // TEngElecPartType
    fEngSensor_InstrumentType: TEngInstrumentType; // TEngInstrumentType
    fEngSensor_TagName: RawUTF8; // string
    fEngSensor_TagDesc: RawUTF8; // string
    fEngSensor_TagDesc_Eng: RawUTF8; // string
    fEngSensor_TagDesc_Kor: RawUTF8; // string
    fEngSensor_SubTagName: RawUTF8; // TSignalType
    fEngSensor_PanelName: RawUTF8; // string
    fEngSensor_TerminalName: RawUTF8; // string
    fEngSensor_TerminalNo: RawUTF8; // string
    fEngSensor_ModuleName: RawUTF8; // string
    fEngSensor_ModuleNo: RawUTF8; // string
    fEngSensor_SlotNo: RawUTF8; // string
    fEngSensor_ChannelNo: RawUTF8; // string
    fEngSensor_CableNo: RawUTF8; // string
    fEngSensor_CableNote: RawUTF8; // string
    fEngSensor_SensorType: TSensorType; // TSensorType
    fEngSensor_SignalType: TSignalType; // TSignalType
    FCreateTime: TTimeLog; // Integer
    FModifiedTime: TTimeLog; // Integer
  published
    /// maps TEngElecPartItem.ProjectNo (TProjectNo)
    property ProjectNo: RawUTF8 read fProjectNo write fProjectNo;
    /// maps TEngElecPartItem.ProjectName (string)
    property ProjectName: RawUTF8 read fProjectName write fProjectName;
    /// maps TEngElecPartItem.EngineNo (TEngineNo)
    property EngineNo: RawUTF8 read fEngineNo write fEngineNo;
    /// maps TEngElecPartItem.LevelIndex
    property LevelIndex: integer read fLevelIndex write fLevelIndex;
    /// maps TEngElecPartItem.NodeIndex
    property NodeIndex: integer read fNodeIndex write fNodeIndex;
    /// maps TEngElecPartItem.AbsoluteIndex
    property AbsoluteIndex: integer read fAbsoluteIndex write fAbsoluteIndex;
    /// maps TEngElecPartItem.ParentNodeAbsIndex
    property ParentNodeAbsIndex: integer read fParentNodeAbsIndex write fParentNodeAbsIndex;
    /// maps TEngElecPartItem.ParentNodeLevel
    property ParentNodeLevel: integer read fParentNodeLevel write fParentNodeLevel;
    /// maps TEngElecPartItem.EngSensor.PartType
    property EngSensor_PartType: TEngElecPartType read fEngSensor_PartType write fEngSensor_PartType;
    /// maps TEngElecPartItem.EngSensor.InstrumentType
    property EngSensor_InstrumentType: TEngInstrumentType read fEngSensor_InstrumentType write fEngSensor_InstrumentType;
    /// maps TEngElecPartItem.EngSensor.TagName (string)
    property EngSensor_TagName: RawUTF8 read fEngSensor_TagName write fEngSensor_TagName;
    /// maps TEngElecPartItem.EngSensor.TagDesc (string)
    property EngSensor_TagDesc: RawUTF8 read fEngSensor_TagDesc write fEngSensor_TagDesc;
    /// maps TEngElecPartItem.EngSensor.TagDesc_Eng (string)
    property EngSensor_TagDesc_Eng: RawUTF8 read fEngSensor_TagDesc_Eng write fEngSensor_TagDesc_Eng;
    /// maps TEngElecPartItem.EngSensor.TagDesc_Kor (string)
    property EngSensor_TagDesc_Kor: RawUTF8 read fEngSensor_TagDesc_Kor write fEngSensor_TagDesc_Kor;
    /// maps TEngElecPartItem.EngSensor.EngSensor_SubTagName (string)
    property EngSensor_SubTagName: RawUTF8 read fEngSensor_SubTagName write fEngSensor_SubTagName;
    /// maps TEngElecPartItem.EngSensor.PanelName (string)
    property EngSensor_PanelName: RawUTF8 read fEngSensor_PanelName write fEngSensor_PanelName;
    /// maps TEngElecPartItem.EngSensor.TerminalName (string)
    property EngSensor_TerminalName: RawUTF8 read fEngSensor_TerminalName write fEngSensor_TerminalName;
    /// maps TEngElecPartItem.EngSensor.TerminalNo (string)
    property EngSensor_TerminalNo: RawUTF8 read fEngSensor_TerminalNo write fEngSensor_TerminalNo;
    /// maps TEngElecPartItem.EngSensor.ModuleName (string)
    property EngSensor_ModuleName: RawUTF8 read fEngSensor_ModuleName write fEngSensor_ModuleName;
    /// maps TEngElecPartItem.EngSensor.ModuleNo (string)
    property EngSensor_ModuleNo: RawUTF8 read fEngSensor_ModuleNo write fEngSensor_ModuleNo;
    /// maps TEngElecPartItem.EngSensor.SlotNo (string)
    property EngSensor_SlotNo: RawUTF8 read fEngSensor_SlotNo write fEngSensor_SlotNo;
    /// maps TEngElecPartItem.EngSensor.ChannelNo (string)
    property EngSensor_ChannelNo: RawUTF8 read fEngSensor_ChannelNo write fEngSensor_ChannelNo;
    /// maps TEngElecPartItem.EngSensor.ChannelNo (string)
    property EngSensor_CableNo: RawUTF8 read fEngSensor_CableNo write fEngSensor_CableNo;
    /// maps TEngElecPartItem.EngSensor.ChannelNo (string)
    property EngSensor_CableNote: RawUTF8 read fEngSensor_CableNote write fEngSensor_CableNote;
    /// maps TEngElecPartItem.EngSensor.SensorType
    property EngSensor_SensorType: TSensorType read fEngSensor_SensorType write fEngSensor_SensorType;
    /// maps TEngElecPartItem.EngSensor.SignalType
    property EngSensor_SignalType: TSignalType read fEngSensor_SignalType write fEngSensor_SignalType;
    /// maps TEngElecPartItem.CreateTime
    property CreateTime: TTimeLog read FCreateTime write FCreateTime;
    /// maps TEngElecPartItem.ModifiedTime
    property ModifiedTime: TTimeLog read FModifiedTime write FModifiedTime;
  end;

  TOrmEngSensorCableRoute = class(TSQLRecordEngElecPartItem)
  protected
    fCableNo: RawUTF8; // string
  published
    /// maps TEngSensorCableRoute.CableNo (string)
    property CableNo: RawUTF8 read fCableNo write fCableNo;
  end;

  TInfraRepoSensor = class(TDDDRepositoryRestCommand, IDomSensorQuery, IDomSensorCommand)
  public
    function SelectAllByProjectNo(const AProjectNo: TProjectNo): TCQRSResult;
    function SelectAllByEngineNo(const AProjectNo: TProjectNo;
      const AEngineNo: TEngineNo): TCQRSResult;
    function SelectAllByTagName(const aTagName: TTagName): TCQRSResult;
    function SelectOneByTagName(const AProjectNo: TProjectNo; const AEngineNo: TEngineNo;
      const aTagName: TTagName): TCQRSResult;
    function SelectOneBySubTagName(const AProjectNo: TProjectNo; const AEngineNo: TEngineNo;
      const aSubTagName: TTagName): TCQRSResult;
    function GetAll(out aAggregates: TEngElecPartItemObjArray): TCQRSResult;
//    function SelectAllByTagName(const aTagName: TTagName;
//      out aAggretates: TEngElecPartCollect): TCQRSResult;
//    function GetAll(out aAggregates: TEngElecPartCollect): TCQRSResult;
    function SelectAll(out aAggretates: TEngElecPartItemObjArray): TCQRSResult;
    function Get(out aAggregate: TEngElecPartItem): TCQRSResult;
    function GetPrev(out aAggregate: TEngElecPartItem): TCQRSResult;
    function GetNext(out aAggregate: TEngElecPartItem): TCQRSResult;
//    function GetCount: Integer;

    function Add(const aAggregate: TEngElecPartItem): TCQRSResult;
    function Update(const aUpdatedAggregate: TEngElecPartItem): TCQRSResult;
    function DeleteSelected(const aDeletedAggregate: TEngElecPartItem): TCQRSResult;
    function DeleteAllSelected: TCQRSResult;
//    function Commit: TCQRSResult; ==> Commit를 살린 후 실행하면 cqrsBadRequest 반환되고 DB 저장 안됨
//    function Rollback: TCQRSResult;
  end;

  TInfraRepoSensorFactory = class(TDDDRepositoryRestFactory)
  private
  protected
    fRest: TRest;
  public
    constructor Create(aRest: TRest; aOwner: TDDDRepositoryRestManager=nil); reintroduce;
  end;

implementation

{ TInfraRepoTodoFactory }

{ TInfraRepoSensor }

function TInfraRepoSensor.Add(const aAggregate: TEngElecPartItem): TCQRSResult;
begin
  Result := ORMAdd(aAggregate);
end;

//function TInfraRepoSensor.Commit: TCQRSResult;
//begin
//
//end;

function TInfraRepoSensor.DeleteSelected(
  const aDeletedAggregate: TEngElecPartItem): TCQRSResult;
begin
  Result := Delete();
end;

function TInfraRepoSensor.DeleteAllSelected: TCQRSResult;
begin
  Result := DeleteAll;
end;

function TInfraRepoSensor.Get(out aAggregate: TEngElecPartItem): TCQRSResult;
begin
  Result := ORMGetAggregate(aAggregate);
end;

//function TInfraRepoSensor.GetAll(
//  out aAggregates: TEngElecPartCollect): TCQRSResult;
//begin
//  Result := ORMGetAllAggregates(aAggregates);
//end;

function TInfraRepoSensor.GetAll(
  out aAggregates: TEngElecPartItemObjArray): TCQRSResult;
begin
  Result := ORMGetAllAggregates(aAggregates);
end;

function TInfraRepoSensor.GetNext(
  out aAggregate: TEngElecPartItem): TCQRSResult;
begin
  Result := ORMGetNextAggregate(aAggregate);
end;

function TInfraRepoSensor.GetPrev(
  out aAggregate: TEngElecPartItem): TCQRSResult;
begin

end;

//function TInfraRepoSensor.Rollback: TCQRSResult;
//begin
//
//end;

function TInfraRepoSensor.SelectAll(
  out aAggretates: TEngElecPartItemObjArray): TCQRSResult;
begin
  Result := ORMSelectAll('',[]);
end;

function TInfraRepoSensor.SelectAllByEngineNo(const AProjectNo: TProjectNo;
  const AEngineNo: TEngineNo): TCQRSResult;
begin
  Result := ORMSelectAll('ProjectNo=? AND EngineNo=?', [AProjectNo,AEngineNo], (''=AEngineNo));
end;

function TInfraRepoSensor.SelectAllByProjectNo(const AProjectNo: TProjectNo): TCQRSResult;
begin
  Result := ORMSelectAll('ProjectNo=?', [AProjectNo], (''=AProjectNo));
end;

function TInfraRepoSensor.SelectAllByTagName(const aTagName: TTagName): TCQRSResult;
begin
  Result := ORMSelectAll('EngSensor_TagName=?', [aTagName], (''=aTagName));
end;

function TInfraRepoSensor.SelectOneBySubTagName(const AProjectNo: TProjectNo;
  const AEngineNo: TEngineNo; const aSubTagName: TTagName): TCQRSResult;
begin
  Result := ORMSelectAll('ProjectNo=? AND EngineNo=? AND EngSensor_SubTagName=?',
    [AProjectNo,AEngineNo,aSubTagName], (''=aSubTagName));
end;

function TInfraRepoSensor.SelectOneByTagName(const AProjectNo: TProjectNo;
  const AEngineNo: TEngineNo; const aTagName: TTagName): TCQRSResult;
begin
  Result := ORMSelectAll('ProjectNo=? AND EngineNo=? AND EngSensor_TagName=?',
    [AProjectNo,AEngineNo,aTagName], (''=aTagName));
end;

//function TInfraRepoSensor.SelectAll(
//  out aAggretates: TEngElecPartCollect): TCQRSResult;
//begin
//
//end;
//
//function TInfraRepoSensor.SelectAllByTagName(const aTagName: TTagName;
//  out aAggretates: TEngElecPartCollect): TCQRSResult;
//begin
//
//end;

function TInfraRepoSensor.Update(
  const aUpdatedAggregate: TEngElecPartItem): TCQRSResult;
begin
  Result := ORMUpdate(aUpdatedAggregate);
end;

{ TInfraRepoSensorFactory }

constructor TInfraRepoSensorFactory.Create(aRest: TRest;
  aOwner: TDDDRepositoryRestManager);
begin
  inherited Create(IDomSensorCommand,TInfraRepoSensor,TEngElecPartItem,aRest,TSQLRecordEngElecPartItem,aOwner);
  fRest := aRest;
  AddFilterOrValidate(['*'], TSynFilterTrim.Create);
//  AddFilterOrValidate(['EngSensor_TagName'],TSynValidateNonVoidText.Create);
end;

//initialization
//  TDDDRepositoryRestFactory.ComputeSQLRecord([TEngElecPartItem]); //from mORMotDDD

end.
