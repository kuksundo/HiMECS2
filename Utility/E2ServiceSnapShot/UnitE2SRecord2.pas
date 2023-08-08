unit UnitE2SRecord2;

interface

uses System.Classes, System.SysUtils, Dialogs, System.Zip, Winapi.Windows,
  Messages, System.Generics.Collections,
{$IFDEF USE_TIMER}
  DSiWin32,
{$ENDIF}
{$IFDEF USE_OMNITHREAD}
  OtlCommon,
  OtlSync,
  OtlTask,
  OtlParallel,
{$ENDIF}
  mormot.core.base, mormot.rest.sqlite3, mormot.orm.core, mormot.core.variants,
  mormot.core.data, mormot.core.unicode, mormot.core.text, mormot.core.os,
  mormot.core.json,
  UnitEngineParameterClass2, HiMECSConst2, UnitEngineParamRecord2;

type
  TE2SUnit = packed record
    symbol: string;
  end;

  TE2SdiscreteValue = packed record
    value: string;
    plcValue: integer;//1.10.0 에서 추가됨
    key: integer;
  end;

  TE2SdiscreteValueA = array of TE2SdiscreteValue;

  TE2SAxisEntry = packed record
    descriptor: string;
    displayName: string;
    Funit: TE2SUnit; //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
    decimals: integer;
  end;

  TE2SValueInformations = packed record
    Fsubtype: string; //@subtype의 @를 F로 대체 해야 함
    descriptor: string;
    displayName: string;
    plcName: string;
    visibilityLevel: string;
    //unitId는 Reserved key이기 떄문에 실제 파일의 unitId를 FunitId로 변경 해야 함
    FunitId: TE2SUnit;
    decimals: integer;
    //type는 Reserved key이기 떄문에 실제 파일의 type를 Ftype로 변경 해야 함
    Ftype: string;//'PARAMETER', 'MEASURAND', 'COMMAND'
    group: string;
    renderingHints: array of string;//array//variant
    xAxisEntry: TE2SAxisEntry;
    yAxisEntry: TE2SAxisEntry;
    discreteValues: array of TE2SdiscreteValue;
    ParamNo: string;//실제 snapshot file에는 없는 항목임. AssignEngParamFromValueInformation()에서 채워 넣음
  end;

  TE2SValueInformationsA = array of TE2SValueInformations;

  TE2S_ValueInformations = packed record
    Atype: string; //@type의 @를 A로 대체 해야 함
    version: string; //@version의 @를 ''로 대체 해야 함
    processValueInformations: TE2SValueInformationsA;
  end;

  TE2SMonitoringValueLimit = packed record
    number: double; //Limit Value
    Funit: TE2SUnit; //'{"symbol":"V"}', unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
    decimalPlaces: integer; //소수점 자리수
  end;

  TE2SMonitoringValue = packed record
    delay: integer;
    isActive: boolean;
    messageType: string; //'HIGH', 'LOW'
    monitoringType: string; //'ALARM','MESSAGE','FAILURE','ALARM_GT','ALARM_PT','ALARM_LR','ALARM_LL','SYSTEM'
    monitoringStatus: string;//'LIMIT_NOT_REACHED','LIMIT_REACHED_WITHOUT_ALARM'
    monitoringEnforcement: string;//'FORCE_NOTHING'
    limit: TE2SMonitoringValueLimit;
  end;

  TE2S_ValueMonitoring = packed record
    monitoringIndex: integer;
    monitoringId: integer;
    pvId: string; //process value state의 descriptor를 가리킴
    sensor: boolean;
    value: TE2SMonitoringValue;
    displayName: string;
  end;

  TE2S_ValueMonitoringA = array of TE2S_ValueMonitoring;

  TE2SValueStatesFlags = array of integer;
  TE2Svalues = TArray<double>;//array of double;

  TE2SValueStatesAnalogValue = packed record
    number: double;//analog value
    Funit: TE2SUnit;//'{"symbol":"V"}'
    decimalPlaces: integer; //소수점 자리수
  end;

  TE2SMapxAxis = packed record
    displayName: string;
    Funit: TE2SUnit;
    values: TE2Svalues;//variant;//TE2Svalues;
    decimalPlaces: integer;
    orientation: string;
    dataStructureId: string;
  end;

  TE2SMapyAxis = packed record
    empty: boolean;
    displayName: string;
    Funit: TE2SUnit;
    values: TE2Svalues;//variant;//TE2Svalues;
    decimalPlaces: integer;
    orientation: string;
    dataStructureId: string;
  end;

  TE2SMapValue = TArray<double>;//array of double;
  TE2SMapValue2 = array of TE2SMapValue;

  TE2SMap = packed record
    value: TE2SMapValue2;//variant;
    Funit: TE2SUnit;
    decimalPlaces: integer;
  end;

  TE2ScharacteristicMapValue = packed record
    xAxis: TE2SMapxAxis;
    yAxis: TE2SMapyAxis;
    map: TE2SMap;
    value: double;
  end;

  TE2SValueStatesLimits = packed record
    warningLow: TE2SValueStatesAnalogValue;//variant;
    warningHigh: TE2SValueStatesAnalogValue;
    alarmLow: TE2SValueStatesAnalogValue;//variant;
    alarmHigh: TE2SValueStatesAnalogValue;//variant;
  end;

  TE2SAxisMinMax = packed record
    min: double;
    max: double;
  end;

  TE2SValueStatesConstraint = packed record
    Fsubtype: string; //@subtype의 @를 F로 대체 해야 함
    possibleValues: array of integer;
    discreteValues: array of TE2SdiscreteValue;
    min: variant;//1.7976931348623157E308를 string으로 읽음
    max: variant;
    xAxis: TE2SAxisMinMax;
    yAxis: TE2SAxisMinMax;
  end;

  TE2SStringValueValue = packed record
    value: string;
    encoding: string;
  end;

  TE2S_ValueStates = packed record
    descriptor: string;
    enabled: Boolean;
    writable: Boolean;
    flags: TE2SValueStatesFlags;
    characteristicMapValue: TE2ScharacteristicMapValue;
    stringValueValue: TE2SStringValueValue;
    analogValue: TE2SValueStatesAnalogValue;
    discreteValue: TE2SdiscreteValue;
    instantValue: Int64;
    sourceTime: TTimeLog;
    limits: TE2SValueStatesLimits;
    constraint: TE2SValueStatesConstraint;
  end;

  TE2S_ValueStatesA = array of TE2S_ValueStates;

  TE2SdiscreteValuesA = array of TE2SdiscreteValue;

  TE2S_DiscreteValueList = packed record
    Atype: string; //@type의 @를 A로 대체 해야 함
    version: string; //@version의 @를 ''로 대체 해야 함
    discreteValues: variant; //array of TE2SdiscreteValuesA
  end;

  TE2SaxisInformation = packed record
    lowerBound: double;
    upperBound: double;
  end;

  TE2ShistoryAxisConfiguration = packed record
    nameKey: string;
    axisInformation: TE2SaxisInformation;
  end;

  TE2ShistoryConfiguration = packed record
    color: variant;
    strokeType: string;
    historyAxisConfiguration: TE2ShistoryAxisConfiguration;
    inHistory: boolean;
    inHistoryE2Pilot: boolean;
  end;

  TE2ShistoryConfigurations = packed record
    pvId: string;
    historyConfiguration: TE2ShistoryConfiguration;
  end;

  TE2ShistoryConfigurationsA = array of TE2ShistoryConfigurations;

  TE2S_HistoryConfigurations = packed record
    Atype: string; //@type의 @를 A로 대체 해야 함
    version: string; //@version의 @를 ''로 대체 해야 함
    historyConfigurations: variant; //array
  end;

  TE2S_SnapShotInfo = packed record
    Atype: string; //@type의 @를 A로 대체 해야 함
    version: string; //@version의 @를 ''로 대체 해야 함
    hostName: string;
    zonedDateTime: string;
    javaVersion: string;
    userName: string;
    osName: string;
    userTimeZone: string;
    panelSerialNumber: string;
  end;

  TE2S_SnapShotMetaData = packed record
    Atype: string; //@type의 @를 A로 대체 해야 함
    version: string; //@version의 @를 ''로 대체 해야 함
    snapshotVersion: string;
    uuid: string;
    uri: string;
    creationTime: string;
    applicationName: string;
    applicationVersion: string;
    product: string;
    communicationType: string;
    userProfile: string;
  end;


  TE2S_DSD_Locales = packed record
    language: string;
    country: string;
    variant: string;
  end;

  TE2S_DSD_LocalesA = array of TE2S_DSD_Locales;

  //Data_Structure_Document = DSD
  TE2S_DSD_Entries = packed record
    dataStructureId: string;
    locales: TE2S_DSD_LocalesA;//array of TE2S_DSD_Locales;
    documentation: array of string;
  end;

  TE2S_DSD_EntriesA = array of TE2S_DSD_Entries;

  TE2S_Ui_Data_Structure_Documentation = packed record
    Atype: string; //@type의 @를 A로 대체 해야 함
    version: string; //@version의 @를 ''로 대체 해야 함
    entries: TE2S_DSD_EntriesA; //array of TE2S_DSD_Entries
  end;

  TE2S_TextKey = packed record
    key: string;
  end;

  TE2S_Ui_Text_Entries = packed record
    textKey: TE2S_TextKey;
    defaultText: string;
    locales: TE2S_DSD_LocalesA;//array
    texts: array of string;//array
  end;

  TE2S_Ui_Text_EntriesA = array of TE2S_Ui_Text_Entries;

  TE2S_Ui_Text_Pool = packed record
    Atype: string; //@type의 @를 A로 대체 해야 함
    version: string; //@version의 @를 ''로 대체 해야 함
    entries: TE2S_Ui_Text_EntriesA; //array of TE2S_Ui_Text_Entries
  end;

  TE2S_PermissinMapEntries = packed record
    FOPERATOR: boolean;//OPERATOR는 FOPERATOR로 변경 후 Loading 해야 함
    SPECIALIST: boolean;
    SERVICE: boolean;
  end;

  TE2S_PermissionMap = packed record
    entries: TE2S_PermissinMapEntries;
  end;

  TE2S_DSD_PermissionMap = packed record
    dataStructureId: string;
    permissionsMap: TE2S_PermissionMap;
  end;

  TE2S_DSD_PermissionMapA = array of TE2S_DSD_PermissionMap;

  TE2S_PermissionConfiguration = packed record
    Atype: string; //@type의 @를 A로 대체 해야 함
    version: string; //@version의 @를 ''로 대체 해야 함
    permissionConfigurations: TE2S_DSD_PermissionMapA; //array of TE2S_DSD_PermissionMap
  end;

  TE2S_ParametersToRestore = packed record
    Atype: string; //@type의 @를 A로 대체 해야 함
    version: string; //@version의 @를 ''로 대체 해야 함
    list: TRawUTF8DynArray;//array
  end;

  TE2S_Value  = packed record
    value: double;
  end;

  TE2S_Gauge = packed record
    minValue: TE2S_Value;
    maxValue: TE2S_Value;
    axisStart: TE2S_Value;
    axisEnd: TE2S_Value;
    currentValue: string;
    targetValue: variant; //nullable
    requestedValue: variant; //nullable
    limitValue: variant; //nullable
    scaleMode: string;
    additionalInfoPid: variant; //nullable
    ticksAndLabels: variant; //nullable
    decimalPlaces: string;
    withReservedSpace: variant; //nullable
    initiallySelected: variant; //nullable
  end;

  TE2S_pvId = packed record
    pvId: variant; //nullable
  end;

  TE2S_pvIdA = array of TE2S_pvId;

  TE2S_yAxis = packed record
    title: string;
    min: integer;
    max: integer;
  end;

  TE2S_Bar = packed record
    title: variant;
    max: variant;
    min: variant; //null
    marker: variant; //null
  end;

  TE2S_BarsA = array of TE2S_Bar;

  TE2S_barGraph = packed record
    barGraphType: string;
    yAxis: TE2S_yAxis;
    leftBars: TE2S_BarsA;
    rightBars: TE2S_BarsA;
    meanLeft: variant;//null;
    meanRight: variant;//null
    backgroundLeftMin: variant;//null
    backgroundLeftMax: variant;//null
    backgroundRightMin: variant;//null
    backgroundRightMax: variant;//null
    numberOfCylinders: variant;//null
  end;

  TE2S_section_row = packed record
    Fsubtype: string; //@subtype의 @를 F로 대체 해야 함
    gauge: TE2S_Gauge;
    barGraph: TE2S_barGraph;
    titleKey: variant;//string;
    descriptors: TE2S_pvIdA;//variant;//null
  end;

  TE2S_section_rowA = array of TE2S_section_row;

  TE2S_section = packed record
    uuid: string;
    titleKeys: TRawUTF8DynArray;
    rows: TE2S_section_rowA;
    contentRestriction: string;
  end;

  TE2S_sectionA = array of TE2S_section;

  TE2S_Entries = packed record
    title: string;
    text: string;
    cmdPvId: string;
    statusIndicatorDescriptor: string;
    controlType: string;
  end;

  TE2S_EntriesA = array of TE2S_Entries;

  TE2S_inputDescriptor = packed record
    Fsubtype: string; //@subtype의 @를 F로 대체 해야 함
    entries: TE2S_EntriesA;
    uuid: string;
    rendererDescriptor: string;
    wrapSectionIndex: integer;
    descriptors: TRawUTF8DynArray;
    visibleTimeRange: LongInt;
    sections: TE2S_sectionA;
  end;

  TE2S_inputDescriptorA = array of TE2S_inputDescriptor;

  TE2S_nodeDisplayData = packed record
    titleKey: variant;//null
    descriptionKey,
    icon: string;
  end;

//  TnodeDescriptorA = array of TnodeDescriptor;

  TE2S_authorization = packed record
    requiredLevel: integer;
  end;

  TE2S_Label = packed record
    key: string;
  end;

  TE2S_axisDescriptor= packed record
    Flabel: TE2S_Label;//label은 Reserved key이기 떄문에 실제 파일의 label을 Flabel로 변경 후 Loading 해야 함
    value: string;
    average: TRawUTF8DynArray;
    offset: double;
  end;

  TE2S_axisDescriptorA = array of TE2S_axisDescriptor;

  TES_spiderDiagramDescriptor = packed record
    Flabel: TE2S_Label;//label은 Reserved key이기 떄문에 실제 파일의 label을 Flabel로 변경 후 Loading 해야 함
    axisDescriptors: TE2S_axisDescriptorA;
  end;

  TES_spiderDiagramDescriptorA = array of TES_spiderDiagramDescriptor;

  TE2S_inputDescriptorChildren = packed record
    Fsubtype: string; //@subtype의 @를 F로 대체 해야 함
    testCommandId: variant;//null
    testModeLabel: variant;//null
    sections: TE2S_sectionA;
    entries: TE2S_EntriesA;
    spiderDiagramDescriptors: TES_spiderDiagramDescriptorA;
    uuid: string;
    rendererDescriptor: string;
    wrapSectionIndex: integer;
    descriptors: TRawUTF8DynArray;
    visibleTimeRange: integer;
  end;

  TE2S_inputDescriptorChildrenA = array of TE2S_inputDescriptorChildren;

  TE2S_nodeChildren = packed record
    pageId: string;
    displayData: TE2S_nodeDisplayData;
    pageLayout: string;
    inputDescriptor: TE2S_inputDescriptorChildrenA;//array
    authorization: TE2S_authorization;
    children: variant;//array
    isReadOnly: Boolean;
    technicalDescription: variant; //null
  end;

  TE2S_nodeChildrenA = array of TE2S_nodeChildren;

  TE2S_nodeDescriptor = packed record
    pageId: string;
    displayData: TE2S_nodeDisplayData;
    inputDescriptor: TE2S_inputDescriptorA;//array
    authorization: TE2S_authorization;
    children: TE2S_nodeChildrenA;
    isReadOnly: Boolean;
    technicalDescription: variant;
  end;

  TE2S_nodeDescriptorA = array of TE2S_nodeDescriptor;

  TE2S_navigation = packed record
    Atype: string; //@type의 @를 A로 대체 해야 함
    version: string; //@version의 @를 ''로 대체 해야 함
    nodeDescriptors: TE2S_nodeDescriptorA;//array
    structureType: string;
  end;

// BigInteger Type이 안되서 구현 보류함
//  TE2S_CurrentTimeInfo = packed record
//    Atype: string; //@type의 @를 A로 대체 해야 함
//    version: string; //@version의 @를 ''로 대체 해야 함
//    currentTime: BigInteger; //1610960434412000000
//    currentTimeInterpolated: BigInteger; //1610960434779041950
//  end;

  TSnapShot4E2S = class
  private
{$IFDEF USE_OMNITHREAD}
    FMainFormHandle: THandle;
    FZipCancelToken: IOmniCancellationToken;
    FWorker  : IOmniParallelLoop<integer>;
{$ENDIF}
    FZip: TZipFile;
    FZipFileInfoList: TDictionary<string, TStringList>;
    //True : SnapShot File Load시 Value-Info 대신 미리 저장된 DB로 부터 Value-Info를 가져와서 속도를 향상 시킴
    FIsParamInfoFromDB: Boolean;

    function GetEngParamIndexFromDescriptor(ADesc: string; AEngineParameter: TEngineParameter=nil): integer;
    function GetEngParamIndexFromXAxisKey(AKey: string; AEngineParameter: TEngineParameter=nil): string;
    function GetEngParamIndexFromYAxisKey(AKey: string; AEngineParameter: TEngineParameter=nil): string;
    function GetEngParamIndexFromDescriptKey(ADescKey: string; AEngineParameter: TEngineParameter=nil): integer;

    function GetValueStateIndexFromDescriptor(ADesc: string): integer;

    procedure SetEngParamRecValueFromValueStateIndex(AStateIdx: integer; ARecord: TEngineParamRecord);
    procedure SetParameter4AVAT2ValueFromEngParamIndex(AEngParamIdx: integer; ARecord: TParameter4AVAT2; AEngineParameter: TEngineParameter=nil);
    procedure AssignParam4AVAT2FromEngParam(AEngineParameter: TEngineParameter=nil);
  public
{$IFDEF USE_OMNITHREAD}
    FParamCompareWait : IOmniWaitableValue;
{$ENDIF}
    FEngineParameter,
    FEngParam4Compare: TEngineParameter;
//    FEngineParamRecord: TEngineParamRecord;

    FValueInformations: TE2S_ValueInformations;
    FValueMonitoringA: TE2S_ValueMonitoringA;
    FValueStatesA: TE2S_ValueStatesA;
    FUi_DSD: TE2S_Ui_Data_Structure_Documentation;
    FUi_TextPool: TE2S_Ui_Text_Pool;
    FPLCInfo: TE2S_PLCInfo;
    FSnapShotInfo: TE2S_SnapShotInfo;
    FSnapShotMetaData: TE2S_SnapShotMetaData;
    FDiscreteValueList: TE2S_DiscreteValueList;
    FHistoryConfigurations: TE2S_HistoryConfigurations;
    FPermissionConfiguration: TE2S_PermissionConfiguration;
    FParametersToRestore: TE2S_ParametersToRestore;
    FUi_Navigation: TE2S_navigation;

    FIsParamCompareMode: Boolean;
    FResultCompareList: TStringList;

    constructor Create;
    destructor Destroy;

    procedure ClearZipFileInfoList;

    procedure ProcessValueInformations(const AFileName: string); overload;
    procedure ProcessValueInformations(const AStream: TStream); overload;
    procedure ProcessValueMonitorings(const AFileName: string); overload;
    procedure ProcessValueMonitorings(const AStream: TStream); overload;
    procedure ProcessValueStates(const AFileName: string); overload;
    procedure ProcessValueStates(const AStream: TStream); overload;
    procedure ProcessDataStructureDocumentation(const AFileName: string); overload;
    procedure ProcessDataStructureDocumentation(const AStream: TStream); overload;
    procedure ProcessUiTextPool(const AFileName: string); overload;
    procedure ProcessUiTextPool(const AStream: TStream); overload;
    procedure ProcessPlcInformation(const AFileName: string); overload;
    procedure ProcessPlcInformation(const AStream: TStream); overload;
    procedure ProcessSnapShotInformation(const AStream: TStream);
    procedure ProcessSnapShotMetaData(const AStream: TStream);
    procedure ProcessPermissionConfiguration(const AStream: TStream);
    procedure ProcessParametersToRestore(const AStream: TStream);
    procedure ProcessUiNavigation(const AStream: TStream);
    procedure ProcessTestStream(AFileName: string);

    procedure SetEngParamValueFromValueStateIndex(AStateIdx, AEngParamIdx: integer; AEngineParameter: TEngineParameter=nil);
    function GetParamTypeFromValueInfoIndex(AIdx: integer): TParameterType;
    function GetParamTypeFromValueStateIndex(AIdx: integer): TParameterType;
    function GetParamTypeFromValueInfoType(AType: string; AIsYAxisExist: Boolean): TParameterType;
    function GetParamNoFromDisplayNameOfProcessValueInfo(ADisplayName: string): string;
    function GetParamNoFromDescriptorOfProcessValueInfo(ADescriptor: string): string;

    //구현 실패- 추후 재 도전할 것
    procedure DiscreteValueList(const AFileName: string); overload;
    procedure DiscreteValueList(const AStream: TStream); overload;
    procedure HistoryConfigurations(const AFileName: string);

    //Avat Snapshot file(.e2s)로 부터 데이터 가져옴
{$IFDEF USE_OMNITHREAD}
    procedure AssignEngParamFromAvatSnapshotUsingOmni(const AE2SFileName: string;
      AFormHandle: THandle; AIsParamInfoFromDB: Boolean=True; ADBFileName: string=DF_AVAT2_PARAM_DEFAULT_DB_NAME;
      AEngineParameter: TEngineParameter=nil);
    //AssignEngParamFromAvatSnapshotUsingOmni함수 실행 완료 후 아래 함수가 실행 되어야 함
    //Zip 파일을 읽는 함수 실행 후 실행 되어야 함
    procedure AssignEtcDataFromAvatSnapshotUsingOmni(AFormHandle: THandle=0; AEngineParameter: TEngineParameter=nil);
{$ELSE}
    //AIsAdd : True = Descriptor를 기존의 EngineParameter에서 비교하지 않고 무조건 추가함
    procedure AssignEngParamFromAvatSnapshot(const AE2SFileName: string; AEngineParameter: TEngineParameter=nil; AForcedAddItem: Boolean=False);
{$ENDIF}
    procedure AssignEngParamFromSqlite(const ASqliteFileName: string; AForcedAddItem: Boolean=False; AEngineParameter: TEngineParameter=nil);
    procedure AssignEngParamMissedFieldFromSqlite(const ASqliteFileName: string; AEngineParameter: TEngineParameter=nil);

    //For TEngineParameter
    procedure AssignEngParamFromValueInformationFile(const AFileName: string;
      AForcedAddItem: Boolean=False; AEngineParameter: TEngineParameter=nil);
    procedure AssignEngParamFromValueInformationStream(const AStream: TStream; AForcedAddItem: Boolean=False; AEngineParameter: TEngineParameter=nil);
    { Snapshot file로 부터 아래의 값들이 Assign 됨
      ParamNo, ParamType, SensorType, FUnit, RadixPosition, descriptor,
      XAxisDescriptor, XAxisDisplayKey, XAxisUnit, XAxisDecimal
    }
    procedure AssignEngParamFromValueInformation(AForcedAddItem: Boolean=False; AEngineParameter: TEngineParameter=nil);
    //SnapShot File의 Value-Information 대신에 미리 저장된 DB에서 데이터 읽어옴(속도 개선)
    procedure AssignEngParamFromDB4ValueInfo(ADBFileName: string=DF_AVAT2_PARAM_DEFAULT_DB_NAME; AEngineParameter: TEngineParameter=nil);
    procedure AssignEngParamDescriptionFromDSDStream(const AStream: TStream; AEngineParameter: TEngineParameter=nil);
    procedure AssignEngParamDescriptionFromDSD(AEngineParameter: TEngineParameter=nil);
    procedure AssignEngParamDisplayFromTextPoolStream(const AStream: TStream; AEngineParameter: TEngineParameter=nil);
    procedure AssignEngParamDisplayFromTextPool(AEngineParameter: TEngineParameter=nil);

    procedure AssignEngParamFromValueStatesFile(const AFileName: string; AEngineParameter: TEngineParameter=nil);
    procedure AssignEngParamFromValueStatesStream(const AStream: TStream; AEngineParameter: TEngineParameter=nil);
    procedure AssignEngParamFromValueStates(AEngineParameter: TEngineParameter=nil; AParam4AVAT2DB: TRestClientDB = nil);

    procedure AssignEngParamFromValueMonitoringStream(const AStream: TStream; AEngineParameter: TEngineParameter=nil);

    procedure AssignPLCInfoFromPlcInfoStream(const AStream: TStream);
    procedure AssignSnapShotInfoFromSnapShotInfoStream(const AStream: TStream);
    procedure AssignSnapShotMetaDataFromSnapShotMetaDataStream(const AStream: TStream);
    procedure AssignPermissionConfigurationFromPCStream(const AStream: TStream);

    //For TEngineParamRecord
    procedure AssignValueInfoFromValueInformationFile(const AFileName: string);
    procedure AssignValueInfoFromValueInformationStream(const AStream: TStream);
    procedure AssignEngParamRecFromValueInformation(ARecord: TEngineParamRecord; AIdx: integer);

    procedure AssignValueStateFromValueStatesFile(const AFileName: string);
    procedure AssignValueStateFromValueStatesStream(const AStream: TStream);
    procedure AssignEngParamRecFromValueStates(ARecord: TEngineParamRecord; AIdx: integer);
    procedure AssignEngParamRecFromEngParamItem(AItem: TEngineParameterItem; ARecord: TEngineParamRecord);
    procedure AssignEngParamItemFromEngParamRec(ARecord: TEngineParamRecord; AItem: TEngineParameterItem);

    procedure AddOrUpdateEngParamRecFromValueInfoState;
    procedure AddOrUpdateEngParamRecFromEngParam(AEngineParamDB: TRestClientDB;
      AUseParamNo: Boolean = false; AEngineParameter: TEngineParameter=nil);
    procedure AddOrUpdateEngParamRec4TagName(AEngineParamDB: TRestClientDB);
    procedure AddOrUpdateEngParamRecValueFromEngParam(AEngineParamDB: TRestClientDB;
      AEngineParameter: TEngineParameter=nil);

    //For TPLCInfoRec4Avat2
    procedure AddOrUpdatePLCInfoRecFromPLCInfo(AEngineParamDB: TRestClientDB);
    procedure AssignPLCInfoRecFromPLCInfo(const ASrc: TE2S_PLCInfo; var ADest: TPLCInfoRec4Avat2);

    //For TDiscreteValue4Avat2
    procedure AddOrUpdateDiscreteValueRecFromValueInfoState(AEngineParamDB: TRestClientDB;
      AEngineParameter: TEngineParameter=nil);
    procedure AssignDiscreteValueRecFromValueInfoState(const AIdx: integer; var ADest: TDiscreteValue4Avat2);

    //For TE2S_ParametersToRestore
    procedure AssignParametersToRestoreFromPRStream(const AStream: TStream);

    //For UiTextPool
    procedure AddOrUpdateUITextPoolRecFromUITextPool(AUITextPoolDB: TRestClientDB);
    procedure AssignUITextPoolRecFromUITextPool(AUITextPoolDB: TRestClientDB);
    function GetDisplayTextFromTextPool(ADisplayName: string): string;

    //For ParamNDescriptor
    procedure AddOrUpdateParamNDescriptorRecFromParamNDescriptor(AParamNDescriptorDB: TRestClientDB);
    procedure UpdateParamNDescriptorRec4DDescFromParamDescBase(AParamNDescriptorRec4Avat2: TParamNDescriptorRec4Avat2; AParamDescBaseDB: TRestClientDB);
    procedure AssignParamNDescriptorRecFromParamNDescriptor(AParamNDescriptorDB: TRestClientDB);

    //For TParamDescBase4AVAT2
    procedure AddOrUpdateParamDescBaseRecFromCSVFile(ACSVFile: String;
      AParamNDescriptorDB: TRestClientDB);
    procedure AddOrUpdateParamDescBaseRecFromXlsFile(AXlsFile: String;
      AParamNDescriptorDB: TRestClientDB);
    function AddOnlyNewParamDescBaseRecFromEngParam(AEngineParameter: TEngineParameter=nil;
      AParamDescBaseDB: TRestClientDB=nil): integer;
    function AssignEngParamItem2ParamDescBaseRec(const AEngParamItem: TEngineParameterItem;
      out AParamDescBase4AVAT2: TParamDescBase4AVAT2): integer;

    //For TParameter4AVAT2
    procedure SetParam4AVAT2ValueFromValueStateIndex(AStateIdx: integer; AParameter4AVAT2: TParameter4AVAT2);
    function AssignParam4AVAT2FromValueInformation(AValueInfoType: string;
      AEngineParameter: TEngineParameter=nil;
      AParam4AVAT2DB: TRestClientDB = nil; AIsDescriptFromBaseDB: Boolean=True): integer;
    function AddOrUpdateParam4AVAT2FromSnapShot(AParam4AVAT2DB, AParamNDescriptorDB: TRestClientDB;
      AValueInfoType: string; AEngineParameter: TEngineParameter=nil): integer;
    function AssignEngParamRec2EngParamItem(const AParameter4AVAT2: TParameter4AVAT2;
      out AEngParameter: TEngineParameter): integer;
    procedure AddOrUpdateParam4AVAT2FromEngParam(AParam4AVAT2DB, AParamNDescriptorDB: TRestClientDB;
      AEngineParameter: TEngineParameter=nil);
    //AIsOverWrite : True = Description_Eng <> ''일때도 변경함
    //               False = Description_Eng = ''일때만 변경함
    procedure AddOrUpdateParameter4AVAT2FromSnapShotDSD(AParameter4AVAT2DB: TRestClientDB; AIsOverWrite: Boolean);

{$IFDEF USE_OMNITHREAD}
    //SnapShot File 내용과 FEngineParameter 의 내용을 비교하여 TEngineParameter를 반환 함
    procedure CompareParamFromSnapShotFile(ASnapShotFN: string; AFormHandle: THandle;
      AIsParamInfoFromDB: Boolean; ADBFN: string=DF_AVAT2_PARAM_DEFAULT_DB_NAME);
{$ENDIF}
    function CompareParamBetweenEngParam(AOriginal, AModified: TEngineParameter): TStringList;
    function CompareParamByParameterType(AOriginalItem, AModifiedItem: TEngineParameterItem;
      out ADiffList: TStringList): Boolean;
    function CompareParam4MatrixData(AOriginalItem, AModifiedItem: TEngineParameterItem; out ADiffList: TStringList): Boolean;
    function CompareArray1D(AOriginalItem, AModifiedItem: TEngineParameterItem; out ADiffList: TStringList): Boolean;
    function CompareArray2D(AOriginalItem, AModifiedItem: TEngineParameterItem; out ADiffList: TStringList): Boolean;

    procedure AssignMatrixData2Array1D(AData: string; var AAryData: TArray<string>);
    function GetParamDiffList2Jason(AOriginalItem: TEngineParameterItem; AModifiedValue: string): string;
    function GetNavListFromSnapShot: TStringList;

    procedure ShowZipFileInfo;
    procedure ShowZipFileInfoBriefly;
  end;

implementation

uses UnitRttiUtil2, StrUtils, UnitStringUtil, UnitExcelUtil,
  UnitEngineParamConst, UnitZipFileUtil, UnitArrayUtil
{$IFDEF USE_OMNITHREAD}
  ,OtlCollections
{$ENDIF}
  ;

{ TEngineParameter4E2S }

procedure TSnapShot4E2S.AssignEngParamMissedFieldFromSqlite(
  const ASqliteFileName: string; AEngineParameter: TEngineParameter);
//Description, ParameterCatetory4AVAT2 등을 Avat2Param.sqlite에서 TEngineParameter에 저장함
var
  LEngineParamDB: TRestClientDB;
  LEngineParamModel: TOrmModel;
  LEngineParamRecord: TEngineParamRecord;
  LEngineParameterItem: TEngineParameterItem;
  i: integer;
begin
  LEngineParamDB := InitEngineParamClient2(ASqliteFileName, LEngineParamModel);
  try
    if not Assigned(AEngineParameter) then
      AEngineParameter := FEngineParameter;

    with AEngineParameter.EngineParameterCollect do
    begin
      for i := 0 to Count - 1 do
      begin
        LEngineParameterItem := Items[i];

        if LEngineParameterItem.ParamNo <> '' then
        begin
          LEngineParamRecord := GetEngParamRecFromParamNo(LEngineParameterItem.ParamNo,
            LEngineParamDB);
          try
            if LEngineParamRecord.IsUpdate then
            begin
              LEngineParameterItem.Description_Eng := LEngineParamRecord.Description_Eng;
              LEngineParameterItem.Description_Kor := LEngineParamRecord.Description_Kor;
              LEngineParameterItem.ParameterCatetory4AVAT2 := LEngineParamRecord.ParameterCatetory4AVAT2;
              LEngineParameterItem.ParameterSubCatetory4AVAT2 := LEngineParamRecord.ParameterSubCatetory4AVAT2;
              LEngineParameterItem.ParameterCatetory := LEngineParamRecord.ParameterCatetory;
              if LEngineParameterItem.TagName = '' then
                LEngineParameterItem.TagName := LEngineParameterItem.ParamNo;
            end;
          finally
            LEngineParamRecord.Free;
          end;
        end;
      end;
    end;
  finally
    DestroyEngineParamClient(LEngineParamDB, LEngineParamModel);
  end;
end;

procedure TSnapShot4E2S.AssignDiscreteValueRecFromValueInfoState(
  const AIdx: integer; var ADest: TDiscreteValue4Avat2);
begin
//  ADest.PossibleValue := FValueStatesA[AIdx].constraint.possibleValues;
//  FValueStatesA[AIdx].discreteValue.value;

end;

//SnapShot File의 dataStructureDocumentation에서 descriptor를 이용하여 Description_Eng를 가져옴
procedure TSnapShot4E2S.AssignEngParamDescriptionFromDSD(AEngineParameter: TEngineParameter);
var
  i, j, k, LValue: integer;
  LDescriptor, LStr: string;
//  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  with AEngineParameter do
  begin
    for i := 0 to Length(FUi_DSD.entries)-1 do
    begin
      LDescriptor := FUi_DSD.entries[i].dataStructureId;
      j := GetEngParamIndexFromDescriptor(LDescriptor, AEngineParameter);

      if j = -1 then
      begin
//        j := EngineParameterCollect.Add.Index;
        Continue;
      end;

      with EngineParameterCollect.Items[j] do
      begin
          //DSD.entries.documentation이 현재는 1개 뿐이므로 for 문을 생략함
//        for k := Low(FUi_DSD.entries[i].documentation) to High(FUi_DSD.entries[i].documentation) do
//        begin
        if High(FUi_DSD.entries[i].documentation) >= 0 then
          Description_Eng := FUi_DSD.entries[i].documentation[0];
//        end;
      end;//with
    end;//for
  end;//with
end;

procedure TSnapShot4E2S.AssignEngParamDescriptionFromDSDStream(
  const AStream: TStream; AEngineParameter: TEngineParameter);
begin
  ProcessDataStructureDocumentation(AStream);
  AssignEngParamDescriptionFromDSD(AEngineParameter);
end;

procedure TSnapShot4E2S.AssignEngParamDisplayFromTextPool(AEngineParameter: TEngineParameter);
var
  i, j, k, LValue: integer;
  LKey, LStr, LIdx: string;
//  LDynArr: TDynArray;
  LUtf8: RawUTF8;
  LDoc: TDocVariantData;
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  with AEngineParameter do
  begin
    for i := 0 to Length(FUi_TextPool.entries)-1 do
    begin
      LKey := FUi_TextPool.entries[i].textKey.key;
//      LDoc.InitJSON(LKey);
//      LKey := LDoc.Value[0];

      //Description을 채우기
      j := GetEngParamIndexFromDescriptKey(LKey, AEngineParameter);

      if j = -1 then
        continue;

      with EngineParameterCollect.Items[j] do
      begin
        Description := FUi_TextPool.entries[i].defaultText;

        if Description_Eng = '' then
          Description_Eng := '***' + Description + '***';
      end;//with

      //X축 Label 채우기
      LStr := GetEngParamIndexFromXAxisKey(LKey, AEngineParameter);

      if LStr = '' then
        Continue;

      while True do
      begin
        LIdx := strToken(LStr, ',');

        if LIdx = '' then
          break;

        j := StrToIntDef(LIdx, -1);

        if j = -1 then
          continue;

        with EngineParameterCollect.Items[j] do
        begin
          if (ParameterType = ptMatrix1f) or (ParameterType = ptMatrix2f) then
          begin
            XAxisDisplayKey := LKey;
            XAxisDisplayName := FUi_TextPool.entries[i].defaultText;
          end;
        end;//with
      end;//while

      //Y축 Label 채우기
      LStr := GetEngParamIndexFromYAxisKey(LKey, AEngineParameter);

      if LStr = '' then
        Continue;

      while True do
      begin
        LIdx := strToken(LStr, ',');

        if LIdx = '' then
          break;

        j := StrToIntDef(LIdx, -1);

        if j = -1 then
          continue;

        with EngineParameterCollect.Items[j] do
        begin
          if ParameterType = ptMatrix2f then
          begin
            YAxisDisplayKey := LKey;
            YAxisDisplayName := FUi_TextPool.entries[i].defaultText;
          end;
        end;//with
      end;//while
    end;//for
  end;//with
end;

procedure TSnapShot4E2S.AssignEngParamDisplayFromTextPoolStream(
  const AStream: TStream; AEngineParameter: TEngineParameter);
begin
  ProcessUiTextPool(AStream);
  AssignEngParamDisplayFromTextPool(AEngineParameter);
end;

{$IFDEF USE_OMNITHREAD}
procedure TSnapShot4E2S.AssignEngParamFromAvatSnapshotUsingOmni(
  const AE2SFileName: string; AFormHandle: THandle; AIsParamInfoFromDB: Boolean;
  ADBFileName: string; AEngineParameter: TEngineParameter);
var
  i: Integer;
  LZipStream: TFileStream;
  LInfoStream, LStateStream,
  LMonioringStream, LPlcInfoStream,
  LSnapShotStream, LSnapShotMetaDataStream,
  LDSDStream, LTextPoolStream,
  LPCStream, LParametersToRestoreStream,
  LNavigationStream: TStream;
  LocalHeader: TZipHeader;
//  Lwait : IOmniWaitableValue;
  {$IFDEF USE_TIMER}
  startTime   : int64;
  {$ENDIF}
begin
  {$IFDEF USE_TIMER}
  startTime := DSiTimeGetTime64;
  {$ENDIF}

  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  if ADBFileName = '' then
    ADBFileName := DF_AVAT2_PARAM_DEFAULT_DB_NAME;

  ClearZipFileInfoList;

  FMainFormHandle := AFormHandle;
  FIsParamInfoFromDB := AIsParamInfoFromDB;
  LInfoStream := nil;
  LStateStream := nil;
  LPlcInfoStream := nil;
  LSnapShotStream := nil;
  LSnapShotMetaDataStream := nil;
  LDSDStream := nil;
  LTextPoolStream := nil;
  LPCStream := nil;
  LParametersToRestoreStream := nil;
  LNavigationStream := nil;

  LZipStream := TFileStream.Create(AE2SFileName, fmOpenRead);
//  try
    if Assigned(FZip) then
      FreeAndNil(FZip);

    FZip := TZipFile.Create;
//    try
      FZip.Open(LZipStream, zmRead);

//      Lwait := CreateWaitableValue;
      FZipCancelToken := CreateOmniCancellationToken;
      FWorker := Parallel.ForEach(0, FZip.FileCount - 1)
        .CancelWith(FZipCancelToken)
//        .NumTasks(3)
        .PreserveOrder
        .NoWait
        .OnStop(
          procedure (const task: IOmniTask)
          begin
            // because of NoWait, OnStop delegate is invoked from the worker code;
            //we must not destroy the worker at that point or the program will block
            task.Invoke(
              procedure begin
                LInfoStream.Free;
                LStateStream.Free;
                LPlcInfoStream.Free;
                LSnapShotStream.Free;
                LSnapShotMetaDataStream.Free;
                LDSDStream.Free;
                LTextPoolStream.Free;
                LPCStream.Free;
                LParametersToRestoreStream.Free;
                LNavigationStream.Free;
                LZipStream.Free;

                AssignEngParamFromValueStates(AEngineParameter);
                AssignEngParamDisplayFromTextPool(AEngineParameter);

                FreeAndNil(FZip);

                if not FIsParamCompareMode then
                  SendMessage(FMainFormHandle, MSG_WORKER_RESULT, 0, 0);
                //ShowMessage('Macro Stopped!');
    {$IFDEF USE_TIMER}
    ShowMessage('AssignEngParamFromAvatSnapshotUsingOmni : ' + FormatDateTime('s.zzz', DSiElapsedTime64(startTime)/MSecsPerDay));
    {$ENDIF}
              end
            );//Invoke

            if FIsParamCompareMode then
              FParamCompareWait.Signal;
          end
      ); //OnStop

      FWorker.Execute(
        procedure (const task: IOmniTask; const i: integer)
        var
          Li: integer;
          LZipFileName: string;
        begin

          LZipFileName := FZip.FileNames[i];

          if Pos('process-value-informations', LZipFileName) > 0 then
          begin
            FZip.Read(i, TStream(LInfoStream), LocalHeader);
            FZipFileInfoList.Add(LZipFileName, GetZipFileInfo2StrList(LocalHeader, LZipFileName, FZip.FileComment[i]));

            if Assigned(LInfoStream) then
            begin
              if FIsParamInfoFromDB then
                AssignEngParamFromDB4ValueInfo(ADBFileName, AEngineParameter)
              else
              begin
                ProcessValueInformations(LInfoStream);
                AssignEngParamFromValueInformation(True, AEngineParameter);
              end;
           end
          end
          else
          if Pos('process-value-states', LZipFileName) > 0 then
          begin
            FZip.Read(i, TStream(LStateStream), LocalHeader);
            FZipFileInfoList.Add(LZipFileName, GetZipFileInfo2StrList(LocalHeader, LZipFileName, FZip.FileComment[i]));

            if Assigned(LStateStream) then
            begin
              ProcessValueStates(LStateStream);
            end;
          end
          else
          if Pos('process-value-monitorings', LZipFileName) > 0 then
          begin
            FZip.Read(i, TStream(LMonioringStream), LocalHeader);
            FZipFileInfoList.Add(LZipFileName, GetZipFileInfo2StrList(LocalHeader, LZipFileName, FZip.FileComment[i]));

            if Assigned(LMonioringStream) then
            begin
              ProcessValueMonitorings(LMonioringStream);
            end;
          end
          else
          if Pos('ui.data.structure.documentation', LZipFileName) > 0 then
          begin
            FZip.Read(i, TStream(LDSDStream), LocalHeader);
            FZipFileInfoList.Add(LZipFileName, GetZipFileInfo2StrList(LocalHeader, LZipFileName, FZip.FileComment[i]));

            if Assigned(LDSDStream) then
            begin
              ProcessDataStructureDocumentation(LDSDStream);
            end;
          end
          else
          if Pos('ui.text.pool', LZipFileName) > 0 then
          begin
            FZip.Read(i, TStream(LTextPoolStream), LocalHeader);
            FZipFileInfoList.Add(LZipFileName, GetZipFileInfo2StrList(LocalHeader, LZipFileName, FZip.FileComment[i]));

            if Assigned(LTextPoolStream) then
            begin
              ProcessUiTextPool(LTextPoolStream);
            end;
          end
          else
          if Pos('plc-information', LZipFileName) > 0 then
          begin
            FZip.Read(i, TStream(LPlcInfoStream), LocalHeader);
            FZipFileInfoList.Add(LZipFileName, GetZipFileInfo2StrList(LocalHeader, LZipFileName, FZip.FileComment[i]));

            if Assigned(LPlcInfoStream) then
            begin
              ProcessPlcInformation(LPlcInfoStream);
            end;
          end
          else
          if Pos('snapshot-info', LZipFileName) > 0 then
          begin
            FZip.Read(i, TStream(LSnapShotStream), LocalHeader);
            FZipFileInfoList.Add(LZipFileName, GetZipFileInfo2StrList(LocalHeader, LZipFileName, FZip.FileComment[i]));

            if Assigned(LSnapShotStream) then
            begin
              ProcessSnapShotInformation(LSnapShotStream);
            end;
          end
          else
          if Pos('snapshot-meta-data', LZipFileName) > 0 then
          begin
            FZip.Read(i, TStream(LSnapShotMetaDataStream), LocalHeader);
            FZipFileInfoList.Add(LZipFileName, GetZipFileInfo2StrList(LocalHeader, LZipFileName, FZip.FileComment[i]));

            if Assigned(LSnapShotMetaDataStream) then
            begin
              ProcessSnapShotMetaData(LSnapShotMetaDataStream);
            end;
          end
          else
          if Pos('permissionConfigurations', LZipFileName) > 0 then
          begin
            FZip.Read(i, TStream(LPCStream), LocalHeader);
            FZipFileInfoList.Add(LZipFileName, GetZipFileInfo2StrList(LocalHeader, LZipFileName, FZip.FileComment[i]));

            if Assigned(LPCStream) then
            begin
              ProcessPermissionConfiguration(LPCStream);
            end;
          end
          else
          if Pos('parameters-to-restore-list', LZipFileName) > 0 then
          begin
            FZip.Read(i, TStream(LParametersToRestoreStream), LocalHeader);
            FZipFileInfoList.Add(LZipFileName, GetZipFileInfo2StrList(LocalHeader, LZipFileName, FZip.FileComment[i]));

            if Assigned(LParametersToRestoreStream) then
            begin
              ProcessParametersToRestore(LParametersToRestoreStream);
            end;
          end
          else
          if Pos('ui.navigation/', LZipFileName) > 0 then
          begin
            FZip.Read(i, TStream(LNavigationStream), LocalHeader);
            FZipFileInfoList.Add(LZipFileName, GetZipFileInfo2StrList(LocalHeader, LZipFileName, FZip.FileComment[i]));

            if Assigned(LNavigationStream) then
            begin
              ProcessUiNavigation(LNavigationStream);
            end;
          end;
        end
      );

//    finally
//    end;
//  finally
//  end;
end;

{$ELSE}
procedure TSnapShot4E2S.AssignEngParamFromAvatSnapshot(
  const AE2SFileName: string; AEngineParameter: TEngineParameter; AForcedAddItem: Boolean);
var
  Zip: TZipFile;
  i: Integer;
  LZipStream: TFileStream;
  LInfoStream, LStateStream,
  LMonioringStream, LPlcInfoStream,
  LSnapShotStream, LSnapShotMetaDataStream,
  LDSDStream, LTextPoolStream,
  LPCStream, LParametersToRestoreStream: TStream;
  LocalHeader: TZipHeader;
  {$IFDEF USE_TIMER}
  startTime   : int64;
  {$ENDIF}
begin
  {$IFDEF USE_TIMER}
  startTime := DSiTimeGetTime64;
  {$ENDIF}

  LInfoStream := nil;
  LStateStream := nil;
  LPlcInfoStream := nil;
  LSnapShotStream := nil;
  LSnapShotMetaDataStream := nil;
  LDSDStream := nil;
  LTextPoolStream := nil;
  LPCStream := nil;
  LParametersToRestoreStream := nil;

  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  LZipStream := TFileStream.Create(AE2SFileName, fmOpenRead);
  try
    Zip := TZipFile.Create;
    try
      Zip.Open(LZipStream, zmRead);

      for i := 0 to Zip.FileCount - 1 do
      begin
        if Pos('process-value-informations', Zip.FileNames[i]) > 0 then
          Zip.Read(i, TStream(LInfoStream), LocalHeader)
        else
        if Pos('process-value-states', Zip.FileNames[i]) > 0 then
          Zip.Read(i, TStream(LStateStream), LocalHeader)
        else
        if Pos('process-value-monitorings', Zip.FileNames[i]) > 0 then
          Zip.Read(i, TStream(LMonioringStream), LocalHeader)
        else
        if Pos('ui.data.structure.documentation', Zip.FileNames[i]) > 0 then
          Zip.Read(i, TStream(LDSDStream), LocalHeader)
        else
        if Pos('ui.text.pool', Zip.FileNames[i]) > 0 then
          Zip.Read(i, TStream(LTextPoolStream), LocalHeader)
        else
        if Pos('plc-information', Zip.FileNames[i]) > 0 then
          Zip.Read(i, TStream(LPlcInfoStream), LocalHeader)
        else
        if Pos('snapshot-info', Zip.FileNames[i]) > 0 then
          Zip.Read(i, TStream(LSnapShotStream), LocalHeader)
        else
        if Pos('snapshot-meta-data', Zip.FileNames[i]) > 0 then
          Zip.Read(i, TStream(LSnapShotMetaDataStream), LocalHeader)
        else
        if Pos('permissionConfigurations', Zip.FileNames[i]) > 0 then
          Zip.Read(i, TStream(LPCStream), LocalHeader)
        else
        if Pos('parameters-to-restore-list', Zip.FileNames[i]) > 0 then
          Zip.Read(i, TStream(LParametersToRestoreStream), LocalHeader)
      end;

      if Assigned(LInfoStream) then
        AssignEngParamFromValueInformationStream(LInfoStream, AForcedAddItem, AEngineParameter);

      if Assigned(LStateStream) then
        AssignEngParamFromValueStatesStream(LStateStream, AEngineParameter);

      if Assigned(LMonioringStream) then
        AssignEngParamFromValueMonitoringStream(LMonioringStream, AEngineParameter);

      if Assigned(LDSDStream) then
        AssignEngParamDescriptionFromDSDStream(LDSDStream, AEngineParameter);

      if Assigned(LTextPoolStream) then
        AssignEngParamDisplayFromTextPoolStream(LTextPoolStream, AEngineParameter);

      if Assigned(LPlcInfoStream) then
        AssignPLCInfoFromPlcInfoStream(LPlcInfoStream);

      if Assigned(LSnapShotStream) then
        AssignSnapShotInfoFromSnapShotInfoStream(LSnapShotStream);

      if Assigned(LSnapShotMetaDataStream) then
        AssignSnapShotInfoFromSnapShotInfoStream(LSnapShotMetaDataStream);

      if Assigned(LPCStream) then
        AssignPermissionConfigurationFromPCStream(LPCStream);

      if Assigned(LParametersToRestoreStream) then
        AssignParametersToRestoreFromPRStream(LParametersToRestoreStream);
    finally
      Zip.Free;
    end;
  finally
    LInfoStream.Free;
    LStateStream.Free;
    LPlcInfoStream.Free;
    LSnapShotStream.Free;
    LSnapShotMetaDataStream.Free;
    LDSDStream.Free;
    LTextPoolStream.Free;
    LPCStream.Free;
    LParametersToRestoreStream.Free;
    LZipStream.Free;
  end;

  {$IFDEF USE_TIMER}
  ShowMessage(FormatDateTime('s.zzz', DSiElapsedTime64(startTime)/MSecsPerDay));
  {$ENDIF}
end;
{$ENDIF}

procedure TSnapShot4E2S.AssignEngParamFromDB4ValueInfo(ADBFileName: string;
  AEngineParameter: TEngineParameter);
var
  LParameter4AVAT2: TParameter4AVAT2;
  LItemIndex: integer;
  LEngineParameterItem: TEngineParameterItem;
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  InitParam4AVAT2Client(ADBFileName);
  try
    LParameter4AVAT2 := GetAllParam4AVAT2Rec();

    while LParameter4AVAT2.FillOne do
    begin
      LItemIndex := AssignEngParamRec2EngParamItem(LParameter4AVAT2, AEngineParameter);
      LEngineParameterItem := AEngineParameter.EngineParameterCollect.Items[LItemIndex];
    end;//while
  finally
    DestroyParam4AVAT2Client;
  end;
end;

procedure TSnapShot4E2S.AssignParam4AVAT2FromEngParam(AEngineParameter: TEngineParameter);
begin

end;

function TSnapShot4E2S.AssignParam4AVAT2FromValueInformation(
  AValueInfoType: string; AEngineParameter: TEngineParameter; AParam4AVAT2DB: TRestClientDB;
  AIsDescriptFromBaseDB: Boolean): integer;
var
  i, j, LValue: integer;
  LParamNo, LDisplayName: string;
  LEngineParamDB: TRestClientDB;
  LParameter4AVAT2: TParameter4AVAT2;
  LParamDescBase4AVAT2: TParamDescBase4AVAT2;
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  Result := 0;

  for i := 0 to Length(FValueInformations.processValueInformations)-1 do
  begin
    if FValueInformations.processValueInformations[i].Ftype = AValueInfoType then//'PARAMETER'
    begin
      LDisplayName := FValueInformations.processValueInformations[i].displayName;
      LParamNo := GetParamNoFromDisplayNameOfProcessValueInfo(LDisplayName);
      LParameter4AVAT2 := GetParam4AVAT2RecFromParamNo(LParamNo, AParam4AVAT2DB);

      with LParameter4AVAT2 do
      begin
        //ParamNo가 숫자로만 구성되어 있으면 정상임
        if TryStrToInt(LParamNo, LValue) then
        begin
          ParamNo := LParamNo;

          LParamDescBase4AVAT2 := GetParamDescBaseRecFromParamNo(ParamNo);

          if LParamDescBase4AVAT2.IsUpdate then
          begin
            if AIsDescriptFromBaseDB then
              Description := LParamDescBase4AVAT2.Description
            else
              Description := GetDisplayTextFromTextPool(LDisplayName);

            CategoryEnum := g_ParameterCategory4AVAT2.ToType(LParamDescBase4AVAT2.Category);
            SubCategoryEnum := g_ParameterSubCategory4AVAT2.ToType(LParamDescBase4AVAT2.SubCategory);
            Category := LParamDescBase4AVAT2.Category;
            SubCategory := LParamDescBase4AVAT2.SubCategory;
          end
          else
          begin
            Description := GetDisplayTextFromTextPool(LDisplayName);
          end;
        end
        else
        begin
          Description := GetDisplayTextFromTextPool(LDisplayName);
        end;

        descriptor := FValueInformations.processValueInformations[i].Descriptor;
        ParameterType := GetParamTypeFromValueInfoIndex(i);
        SensorType := g_SensorType.ToType(FValueInformations.processValueInformations[i].Ftype);//'PARAMETER' or 'MEASURAND'
        unitId := FValueInformations.processValueInformations[i].FunitId.symbol;
        Scale := FValueInformations.processValueInformations[i].decimals;

        ParameterSource := psECS_AVAT2;

        if (ParameterType = ptMatrix1f) or (ParameterType = ptMatrix2f) then
        begin
          XAxisDescriptor := FValueInformations.processValueInformations[i].xAxisEntry.descriptor;
          XAxisDisplayKey := FValueInformations.processValueInformations[i].xAxisEntry.displayName;
          XAxisUnit := FValueInformations.processValueInformations[i].xAxisEntry.Funit.symbol;
          XAxisDecimal := FValueInformations.processValueInformations[i].xAxisEntry.decimals;
//          XAxisDisplayName :=

          if ParameterType = ptMatrix2f then
          begin
            YAxisDescriptor := FValueInformations.processValueInformations[i].yAxisEntry.descriptor;
            YAxisDisplayKey := FValueInformations.processValueInformations[i].yAxisEntry.displayName;
            YAxisUnit := FValueInformations.processValueInformations[i].yAxisEntry.Funit.symbol;
            YAxisDecimal := FValueInformations.processValueInformations[i].yAxisEntry.decimals;
//            YAxisDisplayName :=
          end;
        end;

        j := GetValueStateIndexFromDescriptor(descriptor);

        if j <> -1 then
        begin
          SetEngParamValueFromValueStateIndex(j, i, AEngineParameter);
          SetParam4AVAT2ValueFromValueStateIndex(j, LParameter4AVAT2);
        end;
      end;//with

      AddOrUpdatedParam4AVAT2Rec(LParameter4AVAT2, AParam4AVAT2DB);
      Inc(Result);
    end;//'PARAMETER'
  end;  //for
end;

procedure TSnapShot4E2S.AssignParametersToRestoreFromPRStream(
  const AStream: TStream);
begin
  ProcessParametersToRestore(AStream);
end;

procedure TSnapShot4E2S.AssignParamNDescriptorRecFromParamNDescriptor(
  AParamNDescriptorDB: TRestClientDB);
begin

end;

procedure TSnapShot4E2S.AddOrUpdateParam4AVAT2FromEngParam(AParam4AVAT2DB,
  AParamNDescriptorDB: TRestClientDB; AEngineParameter: TEngineParameter);
var
  i, j, LValue: integer;
  LParamNo, LDisplayName: string;
  LEngineParamDB: TRestClientDB;
  LParameter4AVAT2: TParameter4AVAT2;//parameter별 category 및 value 저장됨 (호선별 Snapshot param 저장됨)
  LParamDescBase4AVAT2: TParamDescBase4AVAT2; //parameter별 category 저장됨(xls 파일에서 읽어 생성함)
//  LEngParamItem: TEngineParameterItem;
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  with AEngineParameter.EngineParameterCollect do
  begin
    for i := 0 to Count - 1 do
    begin
      with Items[i] do
      begin
        if ParamNo = '' then
          LParameter4AVAT2 := GetParam4AVAT2RecFromDescriptor(descriptor)
        else
          LParameter4AVAT2 := GetParam4AVAT2RecFromParamNo(ParamNo);

        //ParamNo가 숫자로만 구성되어 있으면 정상임
        if TryStrToInt(ParamNo, LValue) then
        begin
          LParameter4AVAT2.ParamNo := ParamNo;
          LParamDescBase4AVAT2 := GetParamDescBaseRecFromParamNo(ParamNo);

          if LParamDescBase4AVAT2.IsUpdate then
          begin
            LParameter4AVAT2.Description := LParamDescBase4AVAT2.Description;
            LParameter4AVAT2.CategoryEnum := g_ParameterCategory4AVAT2.ToType(LParamDescBase4AVAT2.Category);
            LParameter4AVAT2.SubCategoryEnum := g_ParameterSubCategory4AVAT2.ToType(LParamDescBase4AVAT2.SubCategory);
            LParameter4AVAT2.Category := LParamDescBase4AVAT2.Category;
            LParameter4AVAT2.SubCategory := LParamDescBase4AVAT2.SubCategory;
            LParameter4AVAT2.Description_Eng := LParamDescBase4AVAT2.Description_Eng;
            LParameter4AVAT2.Description_Kor := LParamDescBase4AVAT2.Description_Kor;
          end
          else
          begin
            LParameter4AVAT2.Description := Description;
//            LParameter4AVAT2.Category := LParamDescBase4AVAT2.Category;
//            LParameter4AVAT2.SubCategory := LParamDescBase4AVAT2.SubCategory;
          end;
        end
        else
        begin
          LParameter4AVAT2.Description := Description;
//          LParameter4AVAT2.Category := LParamDescBase4AVAT2.Category;
//          LParameter4AVAT2.SubCategory := LParamDescBase4AVAT2.SubCategory;
        end;

        LParameter4AVAT2.descriptor := descriptor;
        LParameter4AVAT2.ParameterType := ParameterType;
        LParameter4AVAT2.SensorType := SensorType;//'PARAMETER' or 'MEASURAND'
        LParameter4AVAT2.unitId := FUnit;
        LParameter4AVAT2.Scale := StrToIntDef(Scale, 0);

        LParameter4AVAT2.ParameterSource := ParameterSource;

        if (ParameterType = ptMatrix1f) or (ParameterType = ptMatrix2f) then
        begin
          LParameter4AVAT2.XAxisDescriptor := XAxisDescriptor;
          LParameter4AVAT2.XAxisDisplayKey := XAxisDisplayKey;
          LParameter4AVAT2.XAxisUnit := XAxisUnit;
          LParameter4AVAT2.XAxisDecimal := XAxisDecimal;
          LParameter4AVAT2.XAxisDisplayName := XAxisDisplayName;

          if ParameterType = ptMatrix2f then
          begin
            LParameter4AVAT2.YAxisDescriptor := YAxisDescriptor;
            LParameter4AVAT2.YAxisDisplayKey := YAxisDisplayKey;
            LParameter4AVAT2.YAxisUnit := YAxisUnit;
            LParameter4AVAT2.YAxisDecimal := YAxisDecimal;
            LParameter4AVAT2.YAxisDisplayName := YAxisDisplayName;
          end;
        end;

        SetParameter4AVAT2ValueFromEngParamIndex(i, LParameter4AVAT2, AEngineParameter);
      end;//with

      AddOrUpdatedParam4AVAT2Rec(LParameter4AVAT2);
    end;//for
  end;//with
end;

function TSnapShot4E2S.AddOrUpdateParam4AVAT2FromSnapShot(AParam4AVAT2DB,
  AParamNDescriptorDB: TRestClientDB; AValueInfoType: string; AEngineParameter: TEngineParameter): integer;
begin
  Result := AssignParam4AVAT2FromValueInformation(AValueInfoType, AEngineParameter, AParam4AVAT2DB, False);
//  AssignParam4AVAT2FromValueStates(AEngineParameter, AParam4AVAT2DB);
end;

procedure TSnapShot4E2S.AddOrUpdateParamDescBaseRecFromCSVFile(ACSVFile: String;
  AParamNDescriptorDB: TRestClientDB);
var
  LParamDescBaseRec: TParamDescBase4AVAT2;
  LCSVList: TStringList;
  LUTF8DynArr: TRawUTF8DynArray;
  LDynArr: TDynArray;
  LUTF8: RawUTF8;
  LParamNo: string;
  i: integer;
begin
  if not FileExists(ACSVFile) then
    exit;

  LCSVList := TStringList.Create;
  try
    LCSVList.LoadFromFile(ACSVFile);
    LDynArr.Init(TypeInfo(TRawUTF8DynArray), LUTF8DynArr);

    for i := 1 to LCSVList.Count - 1 do
    begin
      LDynArr.Clear;
      LUTF8 := StringToUTF8(LCSVList.Strings[i]);
      CSVToRawUTF8Dynarray(@LUTF8[1], LUTF8DynArr, ';', False, True);
      LParamNo := LUTF8DynArr[0];
      LParamDescBaseRec := GetParamDescBaseRecFromParamNo(LParamNo);
      try
        LParamDescBaseRec.ParamNo := LParamNo;
        LParamDescBaseRec.Category := LUTF8DynArr[10];
        LParamDescBaseRec.SubCategory := LUTF8DynArr[11];
        LParamDescBaseRec.Description := LUTF8DynArr[1];
        LParamDescBaseRec.Description_Eng := LUTF8DynArr[2]; //이 필드에 멀티라인이 있어서 사용 불가 함
        LParamDescBaseRec.Description_Kor := LUTF8DynArr[8];
        LParamDescBaseRec.unitId := LUTF8DynArr[3];
        LParamDescBaseRec.Scale := StrToIntDef(LUTF8DynArr[4],0);
        LParamDescBaseRec.AlarmKind := LUTF8DynArr[5];
        LParamDescBaseRec.ValueKind := LUTF8DynArr[6];
        LParamDescBaseRec.DefaultValue := LUTF8DynArr[13];
        LParamDescBaseRec.MinValue := LUTF8DynArr[12];
        LParamDescBaseRec.MaxValue := LUTF8DynArr[14];
        LParamDescBaseRec.Note := LUTF8DynArr[7];

        AddOrUpdatedParamDescBaseRec(LParamDescBaseRec, AParamNDescriptorDB);
      finally
        LParamDescBaseRec.Free;
      end;
    end;
  finally
    LCSVList.Free;
  end;
end;

//New Param을 Load 하기 위해서는 ParamInfoDBCheck를 해제한 후 Sanpshot file을 Drop 할 것
function TSnapShot4E2S.AddOnlyNewParamDescBaseRecFromEngParam(
  AEngineParameter: TEngineParameter; AParamDescBaseDB: TRestClientDB): integer;
var
  i: integer;
  LEngParamItem: TEngineParameterItem;
  LParamDescBase4AVAT2: TParamDescBase4AVAT2; //parameter별 category 저장됨(xls 파일에서 읽어 생성함)
  LNewParamList: TStringList;
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  LNewParamList := TStringList.Create;

  try
    with AEngineParameter.EngineParameterCollect do
    begin
      for i := 0 to Count - 1 do
      begin
        LEngParamItem := Items[i];

        with LEngParamItem do
        begin
          if ParamNo = '' then
            Continue;

          LParamDescBase4AVAT2 := GetParamDescBaseRecFromParamNo(ParamNo, AParamDescBaseDB);

          try
            //ParamNo가 기존 DB에 없으면 추가함
            if not LParamDescBase4AVAT2.IsUpdate then
            begin
              AssignEngParamItem2ParamDescBaseRec(LEngParamItem, LParamDescBase4AVAT2);
              AddOrUpdatedParamDescBaseRec(LParamDescBase4AVAT2);
              LNewParamList.Add(LEngParamItem.ParamNo);
            end;
          finally
            LParamDescBase4AVAT2.Free;
          end;
        end;
      end;//for
    end;//with
  finally
    LNewParamList.SaveToFile(ExeVersion.ProgramFilePath + 'AddedNewParam.txt');
    Result := LNewParamList.Count;
    LNewParamList.Free;
    ShowMessage(IntToStr(Result) + ' Items are added to '+ #13#10 +
      ExeVersion.ProgramFilePath + 'AddedNewParam.txt');
  end;
end;

procedure TSnapShot4E2S.AddOrUpdateParameter4AVAT2FromSnapShotDSD(
  AParameter4AVAT2DB: TRestClientDB; AIsOverWrite: Boolean);
var
  LParameter4AVAT2: TParameter4AVAT2;
  LE2S_DSD_EntriesA: TE2S_DSD_EntriesA;
  LParamNo, LDescriptor, LDesc: string;
  i: integer;
begin
  g_ParameterCategory4AVAT2.InitArrayRecord(R_ParameterCategory4AVAT2);
  g_ParameterSubCategory4AVAT2.InitArrayRecord(R_ParameterSubCategory4AVAT2);
  LE2S_DSD_EntriesA := FUi_DSD.entries;

  for i := 0 to High(LE2S_DSD_EntriesA) do
  begin
    LDescriptor := LE2S_DSD_EntriesA[i].dataStructureId;
    LParamNo := GetParamNoFromDescriptorOfProcessValueInfo(LDescriptor);

    //기존 ParamDB에서 레코드를 가져옴()
    LParameter4AVAT2 := GetParam4AVAT2RecFromParamNo(LParamNo);
    try
      //ParamNo가 이미 ParamDB에 존재하면
      if LParameter4AVAT2.IsUpdate then
//      if LParameter4AVAT2.ParamNo <> '' then
      begin
        if High(LE2S_DSD_EntriesA[i].documentation) < 0 then
          Continue;

        LDesc := LE2S_DSD_EntriesA[i].documentation[0];

//        if Pos('Duration for keeping the speed controller', LDesc) > 0 then
//          LParamNo := LDescriptor;

        if AIsOverWrite then
          LParameter4AVAT2.Description_Eng := LDesc
        else
        if LParameter4AVAT2.Description_Eng = '' then
          LParameter4AVAT2.Description_Eng := LDesc
        else
          Continue;
      end
      else
      begin

      end;

      AddOrUpdatedParam4AVAT2Rec(LParameter4AVAT2, AParameter4AVAT2DB);
    finally
      LParameter4AVAT2.Free;
    end;
  end;//while
end;

procedure TSnapShot4E2S.AddOrUpdateParamDescBaseRecFromXlsFile(AXlsFile: String;
  AParamNDescriptorDB: TRestClientDB);
var
  LExcel: OleVariant;
  LWorkBook: OleVariant;
  LRange: OleVariant;
  LWorksheet: OleVariant;
  LStr, LStr2: string;
  LIdx, LLastRow: integer;
  LParamDescBaseRec: TParamDescBase4AVAT2;
  LParamNo: string;
begin
  if not FileExists(AXlsFile) then
  begin
    ShowMessage('File(' + AXlsFile + ')이 존재하지 않습니다');
    exit;
  end;

  g_ParameterCategory4AVAT2.InitArrayRecord(R_ParameterCategory4AVAT2);
  g_ParameterSubCategory4AVAT2.InitArrayRecord(R_ParameterSubCategory4AVAT2);

  LExcel := GetActiveExcelOleObject(True);
  LWorkBook := LExcel.Workbooks.Open(AXlsFile);
  LExcel.Visible := False;
  LExcel.ScreenUpdating := False;
  LExcel.DisplayStatusBar := False;
  LExcel.EnableEvents := False;
  LWorksheet := LExcel.ActiveSheet;
  LLastRow := GetLastRowNumFromExcel(LWorkSheet);

  LStr := 'A';
  LIdx := 2;
  LRange := LWorksheet.range[LStr+IntToStr(LIdx)];

  while LRange.FormulaR1C1 <> '' do
  begin
    LParamNo := LRange.FormulaR1C1;

    LParamDescBaseRec := GetParamDescBaseRecFromParamNo(LParamNo);
    try
      LParamDescBaseRec.ParamNo := LRange.FormulaR1C1;

      LRange := LWorksheet.range['K'+IntToStr(LIdx)];
      LStr2 := LRange.FormulaR1C1;
      LParamDescBaseRec.Category := LStr2;
//      LParamDescBaseRec.CategoryEnum := g_ParameterCategory4AVAT2.ToType(LStr2);

      LRange := LWorksheet.range['L'+IntToStr(LIdx)];
      LStr2 := LRange.FormulaR1C1;
      LParamDescBaseRec.SubCategory := LStr2;
//      LParamDescBaseRec.SubCategoryEnum := g_ParameterSubCategory4AVAT2.ToType(LStr2);

      LRange := LWorksheet.range['B'+IntToStr(LIdx)];
      LParamDescBaseRec.Description := LRange.FormulaR1C1;

      LRange := LWorksheet.range['C'+IntToStr(LIdx)];
      LParamDescBaseRec.Description_Eng := LRange.FormulaR1C1;

      LRange := LWorksheet.range['I'+IntToStr(LIdx)];
      LParamDescBaseRec.Description_Kor := LRange.FormulaR1C1;

      LRange := LWorksheet.range['D'+IntToStr(LIdx)];
      LParamDescBaseRec.unitId := LRange.FormulaR1C1;

      LRange := LWorksheet.range['E'+IntToStr(LIdx)];
      LParamDescBaseRec.Scale := LRange.FormulaR1C1;

      LRange := LWorksheet.range['F'+IntToStr(LIdx)];
      LParamDescBaseRec.AlarmKind := LRange.FormulaR1C1;

      LRange := LWorksheet.range['G'+IntToStr(LIdx)];
      LParamDescBaseRec.ValueKind := LRange.FormulaR1C1;

      LRange := LWorksheet.range['N'+IntToStr(LIdx)];
      LParamDescBaseRec.DefaultValue := LRange.FormulaR1C1;

      LRange := LWorksheet.range['M'+IntToStr(LIdx)];
      LParamDescBaseRec.MinValue := LRange.FormulaR1C1;

      LRange := LWorksheet.range['O'+IntToStr(LIdx)];
      LParamDescBaseRec.MaxValue := LRange.FormulaR1C1;

      LRange := LWorksheet.range['J'+IntToStr(LIdx)];
      LParamDescBaseRec.Usage := LRange.FormulaR1C1;

      LRange := LWorksheet.range['H'+IntToStr(LIdx)];
      LParamDescBaseRec.Note := LRange.FormulaR1C1;

      if LParamNo <> '' then
        AddOrUpdatedParamDescBaseRec(LParamDescBaseRec, AParamNDescriptorDB);

      Inc(LIdx);
      LRange := LWorksheet.range[LStr+IntToStr(LIdx)];
    finally
      LParamDescBaseRec.Free;
    end;
  end; //while

  LWorkBook.Close;
  LExcel.Quit;
end;

procedure TSnapShot4E2S.AssignPermissionConfigurationFromPCStream(
  const AStream: TStream);
begin
  ProcessPermissionConfiguration(AStream);
end;

procedure TSnapShot4E2S.AssignPLCInfoFromPlcInfoStream(const AStream: TStream);
begin
  ProcessPlcInformation(AStream);
end;

procedure TSnapShot4E2S.AssignPLCInfoRecFromPLCInfo(const ASrc: TE2S_PLCInfo;
  var ADest: TPLCInfoRec4Avat2);
//var
//  LDoc: variant;
//  LUtf8: RawUTF8;
begin
//  TDocVariant.New(LDoc);
//  LDoc := RecordSaveJson(ASrc, TypeInfo(TE2S_PLCInfo));
  ADest.E2S_PLCInfo := ASrc;
end;

procedure TSnapShot4E2S.AssignSnapShotInfoFromSnapShotInfoStream(
  const AStream: TStream);
begin

end;

procedure TSnapShot4E2S.AssignSnapShotMetaDataFromSnapShotMetaDataStream(
  const AStream: TStream);
begin

end;

procedure TSnapShot4E2S.AssignUITextPoolRecFromUITextPool(AUITextPoolDB: TRestClientDB);
begin

end;

procedure TSnapShot4E2S.AssignEngParamFromSqlite(const ASqliteFileName: string;
  AForcedAddItem: Boolean; AEngineParameter: TEngineParameter);
var
  LEngineParamDB: TRestClientDB;
  LEngineParamModel: TOrmModel;
  LIsDistroy: Boolean;
  LEngineParamRecord: TEngineParamRecord;
  LEngineParameterItem: TEngineParameterItem;
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  try
    LIsDistroy := ASqliteFileName <> '';

    if LIsDistroy then
    begin
      LEngineParamModel := nil;
      LEngineParamDB := InitEngineParamClient2(ASqliteFileName, LEngineParamModel);
    end
    else
    begin
      InitEngineParamClient(ASqliteFileName);
      LEngineParamDB := g_EngineParamDB;
    end;

    LEngineParamRecord := GetEngParamRecFromDescriptor('',LEngineParamDB);

    if not AForcedAddItem then
      AEngineParameter.EngineParameterCollect.Clear;

    while LEngineParamRecord.FillOne do
    begin
      LEngineParameterItem := AEngineParameter.EngineParameterCollect.Add;
      AssignEngParamItemFromEngParamRec(LEngineParamRecord, LEngineParameterItem);
    end;
  finally
    if LIsDistroy then
      DestroyEngineParamClient(LEngineParamDB, LEngineParamModel);
  end;
end;

procedure TSnapShot4E2S.AddOrUpdateDiscreteValueRecFromValueInfoState(
  AEngineParamDB: TRestClientDB; AEngineParameter: TEngineParameter);
var
  LDV4Avat2: TDiscreteValue4Avat2;
  LDescriptor: string;
  i,j,k: integer;
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  for i := 0 to High(FValueStatesA) do
  begin
    LDescriptor := FValueStatesA[i].descriptor;
    LDV4Avat2 := GetDiscreteValueRecFromDescriptor(LDescriptor, AEngineParamDB);

    for j := Low(FValueStatesA[i].constraint.possibleValues) to High(FValueStatesA[i].constraint.possibleValues) do
    begin
      LDV4Avat2.Descriptor := FValueStatesA[i].descriptor;
      LDV4Avat2.Key := FValueStatesA[i].constraint.discreteValues[j].key;
      LDV4Avat2.PossibleValue := FValueStatesA[i].constraint.possibleValues[j];
      LDV4Avat2.DiscreteValue := FValueStatesA[i].constraint.discreteValues[j].value;
      k := GetEngParamIndexFromDescriptor(LDV4Avat2.Descriptor, AEngineParameter);

      if k <> -1 then
        LDV4Avat2.DisplayName := AEngineParameter.EngineParameterCollect.Items[k].Description;
//      AssignDiscreteValueRecFromValueInfoState(i, LDV4Avat2);
      AddOrUpdatedDiscreteValueRec(LDV4Avat2, AEngineParamDB);
    end;
  end;
end;

procedure TSnapShot4E2S.AddOrUpdateEngParamRec4TagName(
  AEngineParamDB: TRestClientDB);
var
  i, j: integer;
  LEngineParamRecord: TEngineParamRecord;
  LEngineParameterItem: TEngineParameterItem;
begin
  LEngineParamRecord := GetEngParamRec(AEngineParamDB);
  try
    with LEngineParamRecord do
    begin
      while FillOne do
      begin
        if Description <> 'DUMMY' then
        begin
          if (ParamNo = '') then
          begin
            if descriptor <> '' then
              TagName := 'D_' + descriptor
            else
              TagName := 'A_' + IntToStr(BlockNo) + '_' + Address;
          end
          else
          if ParamNo <> '' then
          begin
            TagName := 'P_' + ParamNo;
          end;

          LEngineParamRecord.IsUpdate := True;
          AddOrUpdatedEngParamRec(LEngineParamRecord, AEngineParamDB);
        end;
      end;
    end;
  finally
    LEngineParamRecord.Free;
  end;
end;

procedure TSnapShot4E2S.AddOrUpdateEngParamRecFromEngParam(
  AEngineParamDB: TRestClientDB; AUseParamNo: Boolean;
  AEngineParameter: TEngineParameter);
var
  i: integer;
  LEngineParamRecord: TEngineParamRecord;
  LEngineParameterItem: TEngineParameterItem;
  LAddOrUpdate: Boolean;
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  with AEngineParameter.EngineParameterCollect do
  begin
    for i := 0 to Count - 1 do
    begin
      LAddOrUpdate := False;
      LEngineParameterItem := Items[i];
      try
        if AUseParamNo then
        begin
          LEngineParamRecord := GetEngParamRecFromParamNo(LEngineParameterItem.ParamNo, AEngineParamDB);

          if LEngineParameterItem.ParamNo <> '' then
            LAddOrUpdate := True;
        end
        else
        begin
          LEngineParamRecord := GetEngParamRecFromDescriptor(LEngineParameterItem.descriptor, AEngineParamDB);
          LAddOrUpdate := True;
        end;

        if LAddOrUpdate then
        begin
          AssignEngParamRecFromEngParamItem(LEngineParameterItem, LEngineParamRecord);
          AddOrUpdatedEngParamRec(LEngineParamRecord, AEngineParamDB);
        end;
      finally
        LEngineParamRecord.Free;
      end;
    end;
  end;
end;

procedure TSnapShot4E2S.AddOrUpdateEngParamRecFromValueInfoState;
var
  i, j: integer;
  LDescriptor: string;
  LEngineParamRecord: TEngineParamRecord;
begin
  for i := 0 to Length(FValueInformations.processValueInformations)-1 do
  begin
    LDescriptor := FValueInformations.processValueInformations[i].Descriptor;
    try
      LEngineParamRecord := GetEngParamRecFromDescriptor(LDescriptor);
      AssignEngParamRecFromValueInformation(LEngineParamRecord, i);
      AssignEngParamRecFromValueStates(LEngineParamRecord, i);

      AddOrUpdatedEngParamRec(LEngineParamRecord);
    finally
      LEngineParamRecord.Free;
    end;
  end;
end;

procedure TSnapShot4E2S.AddOrUpdateEngParamRecValueFromEngParam(
  AEngineParamDB: TRestClientDB; AEngineParameter: TEngineParameter);
var
  i: integer;
  LEngineParamRecord: TEngineParamRecord;
  LEngineParameterItem: TEngineParameterItem;
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  with AEngineParameter.EngineParameterCollect do
  begin
    for i := 0 to Count - 1 do
    begin
      LEngineParameterItem := Items[i];

      if LEngineParameterItem.ParamNo <> '' then
      begin
        LEngineParamRecord := GetEngParamRecFromParamNo(LEngineParameterItem.ParamNo, AEngineParamDB);

        try
          if LEngineParamRecord.IsUpdate then
          begin
            LEngineParamRecord.Value := LEngineParameterItem.Value;
            AddOrUpdatedEngParamRec(LEngineParamRecord, AEngineParamDB);
          end;
        finally
          LEngineParamRecord.Free;
        end;
      end;
    end;//for
  end;//with
end;

procedure TSnapShot4E2S.AddOrUpdateParamNDescriptorRecFromParamNDescriptor(
  AParamNDescriptorDB: TRestClientDB);
var
  LParamNDescriptorRec4Avat2: TParamNDescriptorRec4Avat2;
  LDoc: variant;
//  LDynArr: TDynArray;
  LUtf8: RawUTF8;
  i, LAdd, LUpdate: integer;
  LKey, LDefaultText, LDescriptor: string;
begin
  LAdd := 0;
  LUpdate := 0;

  InitParamBaseClient(DF_AVAT2_PARAM_BASE_DB_NAME);
  try
    for i := 0 to Length(FValueInformations.processValueInformations)-1 do
    begin
//      LKey := FValueInformations.processValueInformations[i].FunitId;
//      LDoc := _JsonFast(LKey);
//      LKey := LDoc.symbol;
      LDescriptor := FValueInformations.processValueInformations[i].descriptor;

      LParamNDescriptorRec4Avat2 := GetParamNDescriptorRecFromDescriptor(LDescriptor, AParamNDescriptorDB);
      try
        LParamNDescriptorRec4Avat2.subtype := FValueInformations.processValueInformations[i].Fsubtype;
        LParamNDescriptorRec4Avat2.descriptor := FValueInformations.processValueInformations[i].descriptor;
        LParamNDescriptorRec4Avat2.ParamNo := FValueInformations.processValueInformations[i].ParamNo;
        LParamNDescriptorRec4Avat2.displayName := FValueInformations.processValueInformations[i].displayName;
        LParamNDescriptorRec4Avat2.displayText := GetDisplayTextFromTextPool(LParamNDescriptorRec4Avat2.displayName);
        LParamNDescriptorRec4Avat2.plcName := FValueInformations.processValueInformations[i].plcName;
        LParamNDescriptorRec4Avat2.unitId := FValueInformations.processValueInformations[i].FunitId.symbol;
        LParamNDescriptorRec4Avat2.FFgroup := FValueInformations.processValueInformations[i].group;
        LParamNDescriptorRec4Avat2.FFtype := FValueInformations.processValueInformations[i].Ftype;
        LParamNDescriptorRec4Avat2.decimals := FValueInformations.processValueInformations[i].decimals;

        UpdateParamNDescriptorRec4DDescFromParamDescBase(LParamNDescriptorRec4Avat2, nil);

        if LParamNDescriptorRec4Avat2.IsUpdate then
          Inc(LUpdate)
        else
          Inc(LAdd);

        AddOrUpdatedParamNDescriptorRec(LParamNDescriptorRec4Avat2, AParamNDescriptorDB);
      finally
        LParamNDescriptorRec4Avat2.Free;
      end;
    end;//for
  finally
    DestroyParamBaseClient();

    ShowMessage('Add Records : ' + IntToStr(LAdd) + #13#10 +
      'Update Records : ' + IntToStr(LUpdate));
  end;
end;

procedure TSnapShot4E2S.AddOrUpdatePLCInfoRecFromPLCInfo(
  AEngineParamDB: TRestClientDB);
var
  LPLCInfoRec4Avat2: TPLCInfoRec4Avat2;
begin
  with FPLCInfo do
  begin
    LPLCInfoRec4Avat2 := GetPLCInfoRecFromSqlite(AEngineParamDB);
    try
      AssignPLCInfoRecFromPLCInfo(FPLCInfo, LPLCInfoRec4Avat2);
      AddOrUpdatedPLCInfoRec(LPLCInfoRec4Avat2, AEngineParamDB);
    finally
      LPLCInfoRec4Avat2.Free;
    end;
  end;
end;

procedure TSnapShot4E2S.AddOrUpdateUITextPoolRecFromUITextPool(
  AUITextPoolDB: TRestClientDB);
var
  LUITextPoolRec4Avat2: TUITextPoolRec4Avat2;
  LDoc: variant;
//  LDynArr: TDynArray;
  LUtf8: RawUTF8;
  i, LAdd, LUpdate: integer;
  LKey, LDefaultText: string;
begin
//  TDocVariant.New(LDoc);
//  LDoc := RecordSaveJson(FUi_TextPool, TypeInfo(TE2S_Ui_Text_Pool));
  LAdd := 0;
  LUpdate := 0;

  try
    for i := 0 to Length(FUi_TextPool.entries)-1 do
    begin
      LKey := FUi_TextPool.entries[i].textKey.key;
//      LDoc.InitJSON(LKey);
//      LDoc := _JsonFast(LKey);
//      LKey := LDoc.key;
      LDefaultText := FUi_TextPool.entries[i].defaultText;

      LUITextPoolRec4Avat2 := GetUITextPoolRecFromTextKey(LKey, AUITextPoolDB);
      try
        LUITextPoolRec4Avat2.entries_textKey := Lkey;
        LUITextPoolRec4Avat2.entries_defaultText := LDefaultText;

        LUITextPoolRec4Avat2.Atype := FUi_TextPool.Atype;
        LUITextPoolRec4Avat2.version := FUi_TextPool.version;

        if LUITextPoolRec4Avat2.IsUpdate then
          Inc(LUpdate)
        else
          Inc(LAdd);

        AddOrUpdatedUITextPoolRec(LUITextPoolRec4Avat2, AUITextPoolDB);
      finally
        LUITextPoolRec4Avat2.Free;
      end;
    end;
  finally
    ShowMessage('Add Records : ' + IntToStr(LAdd) + #13#10 +
      'Update Records : ' + IntToStr(LUpdate));
  end;
end;

procedure TSnapShot4E2S.AssignEngParamFromValueInformation(AForcedAddItem: Boolean;
  AEngineParameter: TEngineParameter);
var
  i, j, LValue: integer;
  LDescriptor, LStr: string;
  LEngineParamDB: TRestClientDB;
  LParamDescBase4AVAT2: TParamDescBase4AVAT2;
  LIsYAxisExist: Boolean;
//  LEngineParamModel: TOrmModel;
//  LEngineParamRecord: TEngineParamRecord;
begin
//  LEngineParamModel := nil;
//  LEngineParamDB := InitEngineParamClient2('.\db\'+ENG_PARAM_DEFAULT_DB_NAME, LEngineParamModel);
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  InitParamBaseClient(DF_AVAT2_PARAM_BASE_DB_NAME);
  try
    with AEngineParameter do
    begin
      for i := 0 to Length(FValueInformations.processValueInformations)-1 do
      begin
        LDescriptor := FValueInformations.processValueInformations[i].Descriptor;

        if AForcedAddItem then
          j := EngineParameterCollect.Add.Index
        else
        begin
          j := GetEngParamIndexFromDescriptor(LDescriptor, AEngineParameter);

          if j = -1 then
          begin
            j := EngineParameterCollect.Add.Index;
          end;
        end;

        with EngineParameterCollect.Items[j] do
        begin
          SensorType := g_SensorType.ToType(FValueInformations.processValueInformations[i].Ftype);//'PARAMETER' or 'MEASURAND'

          DescriptionKey := FValueInformations.processValueInformations[i].displayName;

          if SensorType = stParam then
          begin
            LStr := GetParamNoFromDisplayNameOfProcessValueInfo(DescriptionKey);

            if TryStrToInt(LStr, LValue) then
            begin
              FValueInformations.processValueInformations[i].ParamNo := LStr;
              ParamNo := LStr;
              TagName := 'P_' + LStr;
              ParameterCatetory := pcAvat2Param;
  //            LEngineParamRecord := GetEngParamRecFromParamNo(ParamNo, LEngineParamDB);
              LParamDescBase4AVAT2 := GetParamDescBaseRecFromParamNo(ParamNo);

              if LParamDescBase4AVAT2.IsUpdate then
              begin
                ParameterCatetory4AVAT2 := g_ParameterCategory4AVAT2.ToType(LParamDescBase4AVAT2.Category);
                ParameterSubCatetory4AVAT2 := g_ParameterSubCategory4AVAT2.ToType(LParamDescBase4AVAT2.SubCategory);
              end;
            end;
          end;

          LStr := FValueInformations.processValueInformations[i].Fsubtype;
          LIsYAxisExist := FValueInformations.processValueInformations[i].yAxisEntry.descriptor <> '';
          ParameterType := GetParamTypeFromValueInfoType(LStr, LIsYAxisExist);

          FUnit := FValueInformations.processValueInformations[i].FunitId.symbol;
          RadixPosition := FValueInformations.processValueInformations[i].decimals;
          descriptor := FValueInformations.processValueInformations[i].descriptor;

          ParameterSource := psECS_AVAT2;

          if (ParameterType = ptMatrix1f) or (ParameterType = ptMatrix2f) then
          begin
            XAxisDescriptor := FValueInformations.processValueInformations[i].xAxisEntry.descriptor;
            XAxisDisplayKey := FValueInformations.processValueInformations[i].xAxisEntry.displayName;
            XAxisUnit := FValueInformations.processValueInformations[i].xAxisEntry.Funit.symbol;
            XAxisDecimal := FValueInformations.processValueInformations[i].xAxisEntry.decimals;

            if ParameterType = ptMatrix2f then
            begin
              YAxisDescriptor := FValueInformations.processValueInformations[i].yAxisEntry.descriptor;
              YAxisDisplayKey := FValueInformations.processValueInformations[i].yAxisEntry.displayName;
              YAxisUnit := FValueInformations.processValueInformations[i].yAxisEntry.Funit.symbol;
              YAxisDecimal := FValueInformations.processValueInformations[i].yAxisEntry.decimals;
            end;
          end;
        end;
      end;
    end;
  finally
    DestroyParamBaseClient;
//    DestroyEngineParamClient(LEngineParamDB, LEngineParamModel);
  end;

//    if FValueInformations.processValueInformations[i].Fsubtype = 'characteristic-map' then
end;

procedure TSnapShot4E2S.AssignEngParamFromValueInformationFile(
  const AFileName: string; AForcedAddItem: Boolean; AEngineParameter: TEngineParameter);
begin
  ProcessValueInformations(AFileName);
  AssignEngParamFromValueInformation(AForcedAddItem, AEngineParameter);
end;

procedure TSnapShot4E2S.AssignEngParamFromValueInformationStream(
  const AStream: TStream; AForcedAddItem: Boolean; AEngineParameter: TEngineParameter);
begin
  ProcessValueInformations(AStream);
  AssignEngParamFromValueInformation(AForcedAddItem, AEngineParameter);
end;

procedure TSnapShot4E2S.AssignEngParamFromValueMonitoringStream(
  const AStream: TStream; AEngineParameter: TEngineParameter);
begin
  ProcessValueMonitorings(AStream);
end;

procedure TSnapShot4E2S.AssignEngParamFromValueStates(
  AEngineParameter: TEngineParameter; AParam4AVAT2DB: TRestClientDB);
var
  i, j, LRow: integer;
begin
  for i := 0 to High(FValueStatesA) do
  begin
    j := GetEngParamIndexFromDescriptor(FValueStatesA[i].descriptor, AEngineParameter);

    if j <> -1 then
      SetEngParamValueFromValueStateIndex(i, j, AEngineParameter);
  end;
end;

procedure TSnapShot4E2S.AssignEngParamFromValueStatesFile(
  const AFileName: string; AEngineParameter: TEngineParameter);
begin
  ProcessValueStates(AFileName);
end;

procedure TSnapShot4E2S.AssignEngParamFromValueStatesStream(
  const AStream: TStream; AEngineParameter: TEngineParameter);
begin
  ProcessValueStates(AStream);
  AssignEngParamFromValueStates(AEngineParameter);
end;

function TSnapShot4E2S.AssignEngParamItem2ParamDescBaseRec(
  const AEngParamItem: TEngineParameterItem;
  out AParamDescBase4AVAT2: TParamDescBase4AVAT2): integer;
begin
  AParamDescBase4AVAT2.ParamNo := AEngParamItem.ParamNo;
  AParamDescBase4AVAT2.unitId := AEngParamItem.FUnit;
  AParamDescBase4AVAT2.Scale := StrToIntDef(AEngParamItem.Scale, 0);
  AParamDescBase4AVAT2.Description := AEngParamItem.Description;
  AParamDescBase4AVAT2.Description_Eng := AEngParamItem.Description_Eng;
  AParamDescBase4AVAT2.Description_Kor := AEngParamItem.Description_Kor;
  AParamDescBase4AVAT2.MinValue := AEngParamItem.MinLimitValue;
  AParamDescBase4AVAT2.MaxValue := AEngParamItem.MaxLimitValue;
end;

procedure TSnapShot4E2S.AssignEngParamItemFromEngParamRec(
  ARecord: TEngineParamRecord; AItem: TEngineParameterItem);
var
  LDoc: variant;
  LUtf8: RawUTF8;
begin
  TDocVariant.New(LDoc);
  LoadRecordPropertyToVariant(ARecord, LDoc);
  LoadRecordPropertyFromVariant(AItem, LDoc);
end;

function TSnapShot4E2S.AssignEngParamRec2EngParamItem(
  const AParameter4AVAT2: TParameter4AVAT2;
  out AEngParameter: TEngineParameter): integer;
var
  LEngineParameterItem: TEngineParameterItem;
begin
  LEngineParameterItem := AEngParameter.EngineParameterCollect.Add;
  Result := LEngineParameterItem.Index;

  with LEngineParameterItem do
  begin
    ParamNo := AParameter4AVAT2.ParamNo;
    Description := AParameter4AVAT2.Description;
    Description_Eng := AParameter4AVAT2.Description_Eng;
    Description_Kor := AParameter4AVAT2.Description_Kor;
    FUnit := AParameter4AVAT2.unitId;
    Value := AParameter4AVAT2.Value;
    MinLimitValue := AParameter4AVAT2.MinValue;
    MaxLimitValue := AParameter4AVAT2.MaxValue;
    ParameterCatetory4AVAT2 := AParameter4AVAT2.CategoryEnum;
    ParameterSubCatetory4AVAT2 := AParameter4AVAT2.SubCategoryEnum;
    Scale := IntToStr(AParameter4AVAT2.Scale);
    DFAlarmKind := g_DFAlarmKind.ToTypeFromEnumString(AParameter4AVAT2.AlarmKind);
    descriptor :=  AParameter4AVAT2.descriptor;
    Notes :=  AParameter4AVAT2.Note;
    XAxisDescriptor :=  AParameter4AVAT2.XAxisDescriptor;
    XAxisDisplayKey :=  AParameter4AVAT2.XAxisDisplayKey;
    XAxisDisplayName :=  AParameter4AVAT2.XAxisDisplayName;
    XAxisUnit :=  AParameter4AVAT2.XAxisUnit;
    XAxisDecimal :=  AParameter4AVAT2.XAxisDecimal;
    XAxisData :=  AParameter4AVAT2.XAxisData;
    YAxisDescriptor :=  AParameter4AVAT2.YAxisDescriptor;
    YAxisDisplayKey :=  AParameter4AVAT2.YAxisDisplayKey;
    YAxisDisplayName :=  AParameter4AVAT2.YAxisDisplayName;
    YAxisUnit :=  AParameter4AVAT2.YAxisUnit;
    YAxisDecimal :=  AParameter4AVAT2.YAxisDecimal;
    YAxisData :=  AParameter4AVAT2.YAxisData;
    MatrixData :=  AParameter4AVAT2.MatrixData;
    ParameterType :=  AParameter4AVAT2.ParameterType;
    SensorType :=  AParameter4AVAT2.SensorType;
    ParameterSource :=  AParameter4AVAT2.ParameterSource;

    //임시로 아래 필드 사용함
    Address :=  AParameter4AVAT2.Category;
    FCode :=  AParameter4AVAT2.SubCategory;
  end;
end;

procedure TSnapShot4E2S.AssignEngParamRecFromEngParamItem(
  AItem: TEngineParameterItem; ARecord: TEngineParamRecord);
var
  LDoc: variant;
  LUtf8: RawUTF8;
begin
  TDocVariant.New(LDoc);
  LoadRecordPropertyToVariant(AItem, LDoc);
  LoadEngParamRecFromVariant(ARecord, LDoc);
end;

procedure TSnapShot4E2S.AssignEngParamRecFromValueInformation(
  ARecord: TEngineParamRecord; AIdx: integer);
var
  i, j: integer;
  LDescriptor: string;
begin
  with ARecord do
  begin
    DescriptionKey := FValueInformations.processValueInformations[AIdx].displayName;
    ParameterType := GetParamTypeFromValueInfoIndex(AIdx);
    SensorType := g_SensorType.ToType(FValueInformations.processValueInformations[AIdx].Ftype);//'PARAMETER' or 'MEASURAND'
    FUnit := FValueInformations.processValueInformations[AIdx].FunitId.symbol;
    RadixPosition := FValueInformations.processValueInformations[AIdx].decimals;
    descriptor := FValueInformations.processValueInformations[AIdx].descriptor;

    if (ParameterType = ptMatrix1f) or (ParameterType = ptMatrix2f) then
    begin
      XAxisDescriptor := FValueInformations.processValueInformations[AIdx].xAxisEntry.descriptor;
      XAxisDisplayKey := FValueInformations.processValueInformations[AIdx].xAxisEntry.displayName;
      XAxisUnit := FValueInformations.processValueInformations[AIdx].xAxisEntry.Funit.symbol;
      XAxisDecimal := FValueInformations.processValueInformations[AIdx].xAxisEntry.decimals;

      if ParameterType = ptMatrix2f then
      begin
        YAxisDescriptor := FValueInformations.processValueInformations[AIdx].yAxisEntry.descriptor;
        YAxisDisplayKey := FValueInformations.processValueInformations[AIdx].yAxisEntry.displayName;
        YAxisUnit := FValueInformations.processValueInformations[AIdx].yAxisEntry.Funit.symbol;
        YAxisDecimal := FValueInformations.processValueInformations[AIdx].yAxisEntry.decimals;
      end;
    end;
  end;
end;

procedure TSnapShot4E2S.AssignValueInfoFromValueInformationFile(
  const AFileName: string);
begin
  ProcessValueInformations(AFileName);
//  AssignEngParamRecFromValueInformation;
end;

procedure TSnapShot4E2S.AssignValueInfoFromValueInformationStream(
  const AStream: TStream);
begin
  ProcessValueInformations(AStream);
//  AssignEngParamRecFromValueInformation;
end;

procedure TSnapShot4E2S.AssignEngParamRecFromValueStates(
  ARecord: TEngineParamRecord; AIdx: integer);
var
  i, j, LRow: integer;
  LMatched: Boolean;
begin
  if ARecord.descriptor <> FValueStatesA[AIdx].descriptor then
  begin
    for i := 0 to High(FValueStatesA) do
    begin
      if ARecord.descriptor = FValueStatesA[i].descriptor then
      begin
        AIdx := i;
        break;
      end;
    end;
  end;

  SetEngParamRecValueFromValueStateIndex(AIdx, ARecord);
end;

{$IFDEF USE_OMNITHREAD}
procedure TSnapShot4E2S.AssignEtcDataFromAvatSnapshotUsingOmni(
  AFormHandle: THandle; AEngineParameter: TEngineParameter);
begin
  Async(
    procedure begin
      AssignEngParamDescriptionFromDSD(AEngineParameter);
      AssignEngParamDisplayFromTextPool(AEngineParameter);
    end).
  Await(
    procedure begin
    end
  );

//  Parallel.Async(
//    procedure begin
//
//    end,
//    Parallel.TaskConfig.OnTerminated(
//      procedure begin
//      end
//    )
//  );
end;
{$ENDIF}

procedure TSnapShot4E2S.AssignMatrixData2Array1D(AData: string;
  var AAryData: TArray<string>);
var
  LAryValue, LAryValue2: string;
begin
  LAryValue := AData;

  TrimLeftChar(LAryValue, '[');
  TrimRightChar(LAryValue, ']');
  LAryValue2 := strToken(LAryValue, ',');

  while LAryValue2 <> '' do
  begin
    SetLength(AAryData, Length(AAryData)+1);
    AAryData[High(AAryData)] := LAryValue2;
    LAryValue2 := strToken(LAryValue, ',');
  end;
end;

procedure TSnapShot4E2S.AssignValueStateFromValueStatesFile(
  const AFileName: string);
begin
  ProcessValueStates(AFileName);
end;

procedure TSnapShot4E2S.AssignValueStateFromValueStatesStream(
  const AStream: TStream);
begin
  ProcessValueStates(AStream);
//  AssignEngParamRecFromValueStates;
end;

procedure TSnapShot4E2S.ClearZipFileInfoList;
var
  LValue: TStringList;
begin
  for LValue in FZipFileInfoList.Values do
    LValue.Free;

  FZipFileInfoList.Clear;
end;

function TSnapShot4E2S.CompareArray1D(AOriginalItem,
  AModifiedItem: TEngineParameterItem; out ADiffList: TStringList): Boolean;
var
  LOriginAry, LModAry: TArray<string>;
  LStr1, LStr2: string;
  i,j: integer;
begin
  LStr1 := AOriginalItem.MatrixData;
  TrimLeftChar(LStr1, '[');
  TrimRightChar(LStr1, ']');

  LStr2 := AModifiedItem.MatrixData;
  TrimLeftChar(LStr2, '[');
  TrimRightChar(LStr2, ']');

  AssignMatrixData2Array1D(LStr1, LOriginAry);
  AssignMatrixData2Array1D(LStr2, LModAry);

  for i := Low(LOriginAry) to High(LOriginAry) do
  begin
    if LOriginAry[i] <> LModAry[i] then
      ADiffList.Add(GetParamDiffList2Jason(AOriginalItem, AModifiedItem.Value));
  end;
end;

function TSnapShot4E2S.CompareArray2D(AOriginalItem,
  AModifiedItem: TEngineParameterItem; out ADiffList: TStringList): Boolean;
var
  LStr1, LStr2: string;
  i, j: integer;
  LOriginAry, LModAry: TArray<string>;
  LOriginList, LModList: TStringList;

  procedure ArrayData2List(LAryData: string; LList: TStringList);
  var
    LTempStr: string;
  begin
    TrimLeftChar(LAryData, '[');
    TrimRightChar(LAryData, ']');

    LTempStr := strToken(LAryData, ']');

    while LTempStr <> '' do
    begin
      LTempStr := LTempStr + ']';
      LList.Add(LTempStr);
      TrimLeftChar(LAryData, ',');
      LTempStr := strToken(LAryData, ']');
    end;
  end;
begin
  LOriginList := TStringList.Create;
  LModList := TStringList.Create;

  try
    LStr1 := AOriginalItem.MatrixData;
    ArrayData2List(LStr1, LOriginList);

    LStr1 := AModifiedItem.MatrixData;
    ArrayData2List(LStr1, LModList);

    for i := 0 to LOriginList.Count - 1 do
    begin
      AssignMatrixData2Array1D(LOriginList.Strings[i], LOriginAry);
      AssignMatrixData2Array1D(LModList.Strings[i], LModAry);

      for j := Low(LOriginAry) to High(LOriginAry) do
      begin
        if LOriginAry[j] <> LModAry[j] then
          ADiffList.Add(GetParamDiffList2Jason(AOriginalItem, AModifiedItem.Value));
      end;
    end;//for
  finally
    LOriginList.Free;
    LModList.Free;
  end;
end;

function TSnapShot4E2S.CompareParam4MatrixData(AOriginalItem,
  AModifiedItem: TEngineParameterItem; out ADiffList: TStringList): Boolean;
begin
  case AModifiedItem.ParameterType of
    ptMatrix1f: begin
      Result := CompareArray1D(AOriginalItem, AModifiedItem, ADiffList);
    end;
    ptMatrix2f: begin
      Result := CompareArray2D(AOriginalItem, AModifiedItem, ADiffList);
    end;
  end;
end;

function TSnapShot4E2S.CompareParamBetweenEngParam(AOriginal,
  AModified: TEngineParameter): TStringList;
var
  i,j: integer;
begin
  Result := TStringList.Create;
  try
    for i := 0 to AOriginal.EngineParameterCollect.Count - 1 do
    begin
      j := GetEngParamIndexFromDescriptor(AOriginal.EngineParameterCollect.Items[i].descriptor, AModified);

      if j <> -1 then
      begin
        if CompareParamByParameterType(AOriginal.EngineParameterCollect.Items[i],
          AModified.EngineParameterCollect.Items[j], Result) then
        begin
        end;
      end;
    end;//for i
  finally
//    ShowMessage(Result.Text);
  end;
end;

function TSnapShot4E2S.CompareParamByParameterType(AOriginalItem, AModifiedItem: TEngineParameterItem;
  out ADiffList: TStringList): Boolean;
begin
  case AOriginalItem.ParameterType of
    ptDefault: ;
    ptBool,
    ptAnalog,
    ptDigital: begin
      Result := AOriginalItem.Value <> AModifiedItem.Value;

      if Result then
        ADiffList.Add(GetParamDiffList2Jason(AOriginalItem, AModifiedItem.Value));
    end;
    ptMatrix1: ;
    ptMatrix2: ;
    ptMatrix3: ;
    ptMatrix1f,
    ptMatrix2f: begin
      Result := CompareParam4MatrixData(AOriginalItem, AModifiedItem, ADiffList);
    end;
    ptMatrix3f: ;
  end;
end;

{$IFDEF USE_OMNITHREAD}
procedure TSnapShot4E2S.CompareParamFromSnapShotFile(
  ASnapShotFN: string; AFormHandle: THandle; AIsParamInfoFromDB: Boolean; ADBFN: string);
var
  LColl: TOmniBlockingCollection;
  Lvalue: TOmniValue;
begin
//  LColl := TOmniBlockingCollection.Create;
//  LColl.Add(Result);
//  LColl.CompleteAdding;
  FIsParamCompareMode := True;
  AssignEngParamFromAvatSnapshotUsingOmni(ASnapShotFN, AFormHandle, AIsParamInfoFromDB, ADBFN, FEngParam4Compare);

  Async(
    procedure begin
      FParamCompareWait.WaitFor;

      if Assigned(FResultCompareList) then
        FResultCompareList.Free;

      FResultCompareList := CompareParamBetweenEngParam(FEngineParameter, FEngParam4Compare);
    end)
  .Await(
    procedure begin
//      LColl.Take(Lvalue);
      FIsParamCompareMode := False;
      SendMessage(AFormHandle, MSG_COMPARE_PARAM_RESULT, 0, 0);
//      ShowMessage('FWait.WaitFor : ' + IntToStr(FEngParam4Compare.EngineParameterCollect.Count));
//      ShowMessage('FWait.WaitFor : ' + IntToStr(TEngineParameter(LValue.AsObject).EngineParameterCollect.Count));
    end);
end;
{$ENDIF}

constructor TSnapShot4E2S.Create;
begin
{$IFDEF USE_OMNITHREAD}
  FParamCompareWait := CreateWaitableValue;
{$ENDIF}
  FZip := nil;

  FEngineParameter := TEngineParameter.Create(nil);
  FEngParam4Compare := TEngineParameter.Create(nil);
  FZipFileInfoList := TDictionary<string, TStringList>.Create;

  g_ParameterCategory4AVAT2.InitArrayRecord(R_ParameterCategory4AVAT2);
  g_ParameterSubCategory4AVAT2.InitArrayRecord(R_ParameterSubCategory4AVAT2);

  FIsParamCompareMode := False;
  FResultCompareList := nil;
end;

destructor TSnapShot4E2S.Destroy;
begin
  if Assigned(FResultCompareList) then
    FResultCompareList.Free;

  ClearZipFileInfoList;

  FZipFileInfoList.Free;
  FEngParam4Compare.Free;
  FEngineParameter.Free;
end;

procedure TSnapShot4E2S.DiscreteValueList(const AStream: TStream);
var
  LDoc, LDoc2: TDocVariantData;
  LArrDoc: variant;
  i, j: integer;
  LE2SdiscreteValue: TE2SdiscreteValue;
  LE2SdiscreteValueA: TE2SdiscreteValueA;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
  LDoc2.InitJSON(LUtf8);

  for i := 0 to LDoc2.Count-1 do
  begin
    if _Safe(LDoc2.Values[i]).Kind = dvArray then
    begin
      LArrDoc := LDoc2.Values[i];
      break;
    end;
  end;

  LUtf8 := LArrDoc;
  LDoc.InitJSON(LUtf8);
  LDynArr.Init(TypeInfo(TE2SdiscreteValuesA), LE2SdiscreteValueA);

  for i := 0 to LDoc.Count - 1 do
  begin
    LArrDoc := LDoc.Values[i];
    LUtf8 := LArrDoc;
    LDynArr.LoadFromJSON(PUTF8Char(LUtf8));

    for j := 0 to LDynArr.Count - 1 do
    begin
      LE2SdiscreteValue := LE2SdiscreteValueA[j];
//      Memo1.Lines.Add(RecordSaveJson(LE2SdiscreteValue, TypeInfo(TE2SdiscreteValue)));
    end;
  end;
end;

procedure TSnapShot4E2S.DiscreteValueList(const AFileName: string);
var
  LDoc, LDoc2: TDocVariantData;
  LArrDoc: variant;
  i, j: integer;
  LE2SdiscreteValue: TE2SdiscreteValue;
  LE2SdiscreteValueA: TE2SdiscreteValueA;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  LDoc.InitJSONFromFile(AFileName);
  LUtf8 := LDoc.ToJSON();
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
  LDoc2.InitJSON(LUtf8);

  for i := 0 to LDoc2.Count-1 do
  begin
    if _Safe(LDoc2.Values[i]).Kind = dvArray then
    begin
      LArrDoc := LDoc2.Values[i];
      break;
    end;
  end;

  LUtf8 := LArrDoc;
  LDoc.InitJSON(LUtf8);
  LDynArr.Init(TypeInfo(TE2SdiscreteValuesA), LE2SdiscreteValueA);

  for i := 0 to LDoc.Count - 1 do
  begin
    LArrDoc := LDoc.Values[i];
    LUtf8 := LArrDoc;
    LDynArr.LoadFromJSON(PUTF8Char(LUtf8));

    for j := 0 to LDynArr.Count - 1 do
    begin
      LE2SdiscreteValue := LE2SdiscreteValueA[j];
//      Memo1.Lines.Add(RecordSaveJson(LE2SdiscreteValue, TypeInfo(TE2SdiscreteValue)));
    end;
  end;
end;

function TSnapShot4E2S.GetEngParamIndexFromXAxisKey(AKey: string;
  AEngineParameter: TEngineParameter): string;
var
  i: integer;
  LStr: string;
begin
  Result := '';

  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  with AEngineParameter do
  begin
    for i := 0 to EngineParameterCollect.Count - 1 do
    begin
      if EngineParameterCollect.Items[i].XAxisDisplayKey = AKey then
      begin
        LStr := IntToStr(i);

        if Result = '' then
          Result := LStr
        else
          Result := Result + ',' + LStr;
      end;
    end;
  end;
end;

function TSnapShot4E2S.GetEngParamIndexFromYAxisKey(AKey: string;
  AEngineParameter: TEngineParameter): string;
var
  i: integer;
  LStr: string;
begin
  Result := '';

  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  with AEngineParameter do
  begin
    for i := 0 to EngineParameterCollect.Count - 1 do
    begin
      if EngineParameterCollect.Items[i].YAxisDisplayKey = AKey then
      begin
        LStr := IntToStr(i);

        if Result = '' then
          Result := LStr
        else
          Result := Result + ',' + LStr;
      end;
    end;
  end;
end;

function TSnapShot4E2S.GetNavListFromSnapShot: TStringList;
var
  i: integer;
begin
  Result := TStringList.Create;

  for i := Low(FUi_Navigation.nodeDescriptors) to High(FUi_Navigation.nodeDescriptors) do
//    Result.Add(FUi_Navigation.nodeDescriptors[i].displayData.descriptionKey);
    Result.Add(FUi_Navigation.nodeDescriptors[i].displayData.descriptionKey);
end;

function TSnapShot4E2S.GetDisplayTextFromTextPool(ADisplayName: string): string;
var
  i: integer;
  LKey: string;
//  LDoc: TDocVariantData;
begin
  Result := '';

  for i := 0 to Length(FUi_TextPool.entries)-1 do
  begin
    LKey := FUi_TextPool.entries[i].textKey.key;
//    LDoc.InitJSON(LKey);
//    LKey := LDoc.Value[0];

    if ADisplayName = LKey then
    begin
      Result := FUi_TextPool.entries[i].defaultText;
      break;
    end;

//    LDoc.Clear;
  end;
end;

function TSnapShot4E2S.GetEngParamIndexFromDescriptKey(ADescKey: string;
  AEngineParameter: TEngineParameter): integer;
var
  i: integer;
begin
  Result := -1;

  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  with AEngineParameter do
  begin
    for i := 0 to EngineParameterCollect.Count - 1 do
    begin
      if EngineParameterCollect.Items[i].DescriptionKey = ADescKey then
      begin
        Result := i;
        Break;
      end;
    end;
  end;
end;

function TSnapShot4E2S.GetEngParamIndexFromDescriptor(
  ADesc: string; AEngineParameter: TEngineParameter): integer;
var
  i: integer;
begin
  Result := -1;

  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  with AEngineParameter do
  begin
    for i := 0 to EngineParameterCollect.Count - 1 do
    begin
      if EngineParameterCollect.Items[i].descriptor = ADesc then
      begin
        Result := i;
        Break;
      end;
    end;
  end;
end;

function TSnapShot4E2S.GetParamDiffList2Jason(
  AOriginalItem: TEngineParameterItem; AModifiedValue: string): string;
begin
  Result := '{"ParamDesc":"'+ AOriginalItem.Description + '", "CurrentValue": "' +
    AOriginalItem.Value + '", "FileValue": "' + AModifiedValue + '"}';
end;

function TSnapShot4E2S.GetParamNoFromDescriptorOfProcessValueInfo(
  ADescriptor: string): string;
var
  i: integer;
begin
  Result := '';

  for i := 0 to Length(FValueInformations.processValueInformations)-1 do
  begin
    if ADescriptor = FValueInformations.processValueInformations[i].Descriptor then
    begin
      Result := FValueInformations.processValueInformations[i].ParamNo;
      Break;
    end;
  end;
end;

function TSnapShot4E2S.GetParamNoFromDisplayNameOfProcessValueInfo(
  ADisplayName: string): string;
begin
  Result := ADisplayName.Replace('dds.Par', '');
  Result := Result.Replace('dds.Cur', '');
  Result := Result.Replace('dds.Map', '');
  Result := Result.Replace('dds.', '');
  Result := LeftStr(Result, 5);
end;

function TSnapShot4E2S.GetParamTypeFromValueInfoIndex(AIdx: integer): TParameterType;
var
  LSubType: string;
  LIaYAxisExist: Boolean;
begin
  LSubType := FValueInformations.processValueInformations[AIdx].Fsubtype;
  LIaYAxisExist := FValueInformations.processValueInformations[AIdx].yAxisEntry.descriptor <> '';

  Result := GetParamTypeFromValueInfoType(LSubType, LIaYAxisExist);
end;

function TSnapShot4E2S.GetParamTypeFromValueInfoType(
  AType: string; AIsYAxisExist: Boolean): TParameterType;
begin
  if AType = 'analog' then
    Result := ptAnalog
  else
  if AType = 'discrete' then
    Result := ptDigital
  else
  if AType = 'characteristic-map' then
  begin
    if AIsYAxisExist then
      Result := ptMatrix2f
    else
      Result := ptMatrix1f;
  end
  else
  if AType = 'string' then
    Result := ptString
  else
    Result := ptDefault;
end;

function TSnapShot4E2S.GetParamTypeFromValueStateIndex(
  AIdx: integer): TParameterType;
var
  LSubType: string;
begin
  LSubType := FValueStatesA[AIdx].constraint.Fsubtype;

  if LSubType = 'analog-value-min-max-constraint' then
    Result := ptAnalog
  else
  if LSubType = 'discrete-value-constraint' then
    Result := ptDigital
  else
  if LSubType = 'characteristic-map-constraint' then
  begin
    if FValueInformations.processValueInformations[AIdx].yAxisEntry.descriptor = '' then
      Result := ptMatrix1f
    else
      Result := ptMatrix2f;
  end;
end;

function TSnapShot4E2S.GetValueStateIndexFromDescriptor(ADesc: string): integer;
var
  i: integer;
begin
  Result := -1;

  for i := 0 to High(FValueStatesA) do
  begin
    begin
      if FValueStatesA[i].descriptor = ADesc then
      begin
        Result := i;
        Break;
      end;
    end;
  end;
end;

procedure TSnapShot4E2S.SetEngParamRecValueFromValueStateIndex(
  AStateIdx: integer; ARecord: TEngineParamRecord);
begin
  case ARecord.ParameterType of
    ptDefault: ;
    ptAnalog: begin
      ARecord.Value :=
        Utf8ToString(VariantToUTF8(FValueStatesA[AStateIdx].analogValue.number));
    end;
    ptDigital: begin
      ARecord.Value :=
        FValueStatesA[AStateIdx].discreteValue.value;
    end;
    ptBool: ;
    ptMatrix1: ;
    ptMatrix2: ;
    ptMatrix3: ;
    ptMatrix1f: begin
      ARecord.XAxisData :=
        TpjhArray<double>.GetAsString(FValueStatesA[AStateIdx].characteristicMapValue.xAxis.values);

      ARecord.MatrixData :=
        TpjhArray<double>.GetAsString(FValueStatesA[AStateIdx].characteristicMapValue.xAxis.values);
    end;
    ptMatrix2f: begin
      ARecord.XAxisData :=
        TpjhArray<double>.GetAsString(FValueStatesA[AStateIdx].characteristicMapValue.xAxis.values);

      ARecord.YAxisData :=
        TpjhArray<double>.GetAsString(FValueStatesA[AStateIdx].characteristicMapValue.yAxis.values);

      ARecord.MatrixData :=
        TpjhArray<double>.GetAsStringFrom2Dimension(FValueStatesA[AStateIdx].characteristicMapValue.map.value);
    end;
    ptMatrix3f: ;
  end;
end;

procedure TSnapShot4E2S.SetEngParamValueFromValueStateIndex(
  AStateIdx, AEngParamIdx: integer; AEngineParameter: TEngineParameter);
var
  LValue: string;
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  with AEngineParameter do
  begin
    case EngineParameterCollect.Items[AEngParamIdx].ParameterType of
      ptDefault: ;
      ptAnalog: begin
        EngineParameterCollect.Items[AEngParamIdx].Value :=
          Utf8ToString(VariantToUTF8(FValueStatesA[AStateIdx].analogValue.number));
        EngineParameterCollect.Items[AEngParamIdx].MinLimitValue :=
          VariantToUTF8(FValueStatesA[AStateIdx].constraint.min);
        EngineParameterCollect.Items[AEngParamIdx].MaxLimitValue :=
          VariantToUTF8(FValueStatesA[AStateIdx].constraint.max);
      end;
      ptDigital: begin
        LValue := FValueStatesA[AStateIdx].discreteValue.value;

        if Pos('ddv.', LValue) <> -1 then
          strTokenRev(LValue, '_');

        EngineParameterCollect.Items[AEngParamIdx].Value := LValue;
      end;
      ptBool: ;
      ptMatrix1: ;
      ptMatrix2: ;
      ptMatrix3: ;
      ptMatrix1f: begin
        EngineParameterCollect.Items[AEngParamIdx].Value :=
          FloatToStr(FValueStatesA[AStateIdx].characteristicMapValue.value);

        EngineParameterCollect.Items[AEngParamIdx].XAxisData :=
          TpjhArray<double>.GetAsString(FValueStatesA[AStateIdx].characteristicMapValue.xAxis.values);

        EngineParameterCollect.Items[AEngParamIdx].MatrixData :=
          TpjhArray<double>.GetAsStringFrom2Dimension(FValueStatesA[AStateIdx].characteristicMapValue.map.value);
      end;
      ptMatrix2f: begin
        EngineParameterCollect.Items[AEngParamIdx].Value :=
          FloatToStr(FValueStatesA[AStateIdx].characteristicMapValue.value);

        EngineParameterCollect.Items[AEngParamIdx].XAxisData :=
          TpjhArray<double>.GetAsString(FValueStatesA[AStateIdx].characteristicMapValue.xAxis.values);

        EngineParameterCollect.Items[AEngParamIdx].YAxisData :=
          TpjhArray<double>.GetAsString(FValueStatesA[AStateIdx].characteristicMapValue.yAxis.values);

        EngineParameterCollect.Items[AEngParamIdx].MatrixData :=
          TpjhArray<double>.GetAsStringFrom2Dimension(FValueStatesA[AStateIdx].characteristicMapValue.map.value);
      end;
      ptMatrix3f: ;
    end;
  end;
end;

procedure TSnapShot4E2S.SetParam4AVAT2ValueFromValueStateIndex(AStateIdx: integer;
  AParameter4AVAT2: TParameter4AVAT2);
var
  LValue: string;
begin
  if not Assigned(AParameter4AVAT2) then
    exit;

  with AParameter4AVAT2 do
  begin
    case ParameterType of
      ptDefault: ;
      ptAnalog: begin
        Value := Utf8ToString(VariantToUTF8(FValueStatesA[AStateIdx].analogValue.number));
        MinValue := VariantToUTF8(FValueStatesA[AStateIdx].constraint.min);
        MaxValue := VariantToUTF8(FValueStatesA[AStateIdx].constraint.max);
      end;
      ptDigital: begin
        LValue := FValueStatesA[AStateIdx].discreteValue.value;

        if Pos('ddv.', LValue) <> -1 then
          strTokenRev(LValue, '_');

        Value := LValue;
      end;
      ptBool: ;
      ptMatrix1: ;
      ptMatrix2: ;
      ptMatrix3: ;
      ptMatrix1f: begin
        Value := FloatToStr(FValueStatesA[AStateIdx].characteristicMapValue.value);
        XAxisData := TpjhArray<double>.GetAsString(FValueStatesA[AStateIdx].characteristicMapValue.xAxis.values);
        MatrixData := TpjhArray<double>.GetAsStringFrom2Dimension(FValueStatesA[AStateIdx].characteristicMapValue.map.value);
      end;
      ptMatrix2f: begin
        Value := FloatToStr(FValueStatesA[AStateIdx].characteristicMapValue.value);
        XAxisData := TpjhArray<double>.GetAsString(FValueStatesA[AStateIdx].characteristicMapValue.xAxis.values);
        YAxisData := TpjhArray<double>.GetAsString(FValueStatesA[AStateIdx].characteristicMapValue.yAxis.values);
        MatrixData := TpjhArray<double>.GetAsStringFrom2Dimension(FValueStatesA[AStateIdx].characteristicMapValue.map.value);
      end;
      ptMatrix3f: ;
    end;
  end;
end;

procedure TSnapShot4E2S.SetParameter4AVAT2ValueFromEngParamIndex(
  AEngParamIdx: integer; ARecord: TParameter4AVAT2; AEngineParameter: TEngineParameter);
begin
  if not Assigned(AEngineParameter) then
    AEngineParameter := FEngineParameter;

  case ARecord.ParameterType of
    ptDefault: ;
    ptAnalog,
    ptDigital,
    ptBool: begin
      ARecord.Value :=
        AEngineParameter.EngineParameterCollect.Items[AEngParamIdx].Value;
    end;
    ptMatrix1: ;
    ptMatrix2: ;
    ptMatrix3: ;
    ptMatrix1f: begin
      ARecord.XAxisData :=
        AEngineParameter.EngineParameterCollect.Items[AEngParamIdx].XAxisData;
      ARecord.MatrixData :=
        AEngineParameter.EngineParameterCollect.Items[AEngParamIdx].MatrixData;
    end;
    ptMatrix2f: begin
      ARecord.XAxisData :=
        AEngineParameter.EngineParameterCollect.Items[AEngParamIdx].XAxisData;
      ARecord.YAxisData :=
        AEngineParameter.EngineParameterCollect.Items[AEngParamIdx].YAxisData;
      ARecord.MatrixData :=
        AEngineParameter.EngineParameterCollect.Items[AEngParamIdx].MatrixData;
    end;
    ptMatrix3f: ;
  end;
end;

procedure TSnapShot4E2S.ShowZipFileInfo;
var
  LValue: TStringList;
  LFileInfo: string;
begin
  for LValue in FZipFileInfoList.Values do
    LFileInfo := LFileInfo + LValue.Text + #13#10 + '==========================' + #13#10;

  ShowMessage(LFileInfo);
end;

procedure TSnapShot4E2S.ShowZipFileInfoBriefly;
var
  LValue: TStringList;
  LFileInfo: string;
  i: integer;
begin
  for LValue in FZipFileInfoList.Values do
    LFileInfo := LFileInfo + LValue.Strings[0] + #13#10;

  LFileInfo := LFileInfo + '==========================' + #13#10;

  for i := 2 to LValue.Count - 1 do
    LFileInfo := LFileInfo + LValue.Strings[i] + #13#10;

  ShowMessage(LFileInfo);
end;

procedure TSnapShot4E2S.ProcessSnapShotInformation(const AStream: TStream);
var
  LDoc: TDocVariantData;
  LUtf8: RawUTF8;
begin
  FSnapShotInfo := Default(TE2S_SnapShotInfo);
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
  LDoc.InitJSON(LUtf8);
  RecordLoadJson(FSnapShotInfo, LUtf8, TypeInfo(TE2S_SnapShotInfo));
end;

procedure TSnapShot4E2S.UpdateParamNDescriptorRec4DDescFromParamDescBase(
  AParamNDescriptorRec4Avat2: TParamNDescriptorRec4Avat2; AParamDescBaseDB: TRestClientDB);
var
  LParamDescBase4AVAT2: TParamDescBase4AVAT2;
  LParamNo: string;
  i, LAdd, LUpdate: integer;
begin
  LAdd := 0;
  LUpdate := 0;

  LParamNo := AParamNDescriptorRec4Avat2.ParamNo;

  LParamDescBase4AVAT2 := GetParamDescBaseRecFromParamNo(LParamNo, AParamDescBaseDB);
  try
    if LParamDescBase4AVAT2.IsUpdate then
    begin
      AParamNDescriptorRec4Avat2.Description := LParamDescBase4AVAT2.Description;
      AParamNDescriptorRec4Avat2.Description_Eng := LParamDescBase4AVAT2.Description_Eng;
      AParamNDescriptorRec4Avat2.Description_Kor := LParamDescBase4AVAT2.Description_Kor;
      AParamNDescriptorRec4Avat2.Category := LParamDescBase4AVAT2.Category;
      AParamNDescriptorRec4Avat2.SubCategory := LParamDescBase4AVAT2.SubCategory;
      AParamNDescriptorRec4Avat2.Note := LParamDescBase4AVAT2.Note;
    end;
  finally
    LParamDescBase4AVAT2.Free;
  end;
end;

procedure TSnapShot4E2S.HistoryConfigurations(const AFileName: string);
begin

end;

procedure TSnapShot4E2S.ProcessPlcInformation(const AFileName: string);
var
  LDoc, LDoc2: TDocVariantData;
  LUtf8: RawUTF8;
begin
  LDoc.InitJSONFromFile(AFileName);
  LUtf8 := LDoc.ToJSON();
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
  LDoc2.InitJSON(LUtf8);
  RecordLoadJson(FPLCInfo, LUtf8, TypeInfo(TE2S_PLCInfo));
end;

procedure TSnapShot4E2S.ProcessValueInformations(
  const AFileName: string);
var
  LFileStream: TFileStream;
//  LDoc, LDoc2: TDocVariantData;
//  LArrDoc: variant;
//  i, LCount: integer;
////  LE2SValueInformations: TE2SValueInformations;
////  LESValueInformationsA: TE2SValueInformationsA;
//  LDynArr: TDynArray;
//  LUtf8: RawUTF8;
begin
  LFileStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    ProcessValueInformations(LFileStream);
  finally
    LFileStream.Free;
  end;
//  FValueInformations := Default(TE2S_ValueInformations);
//  LDoc.InitJSONFromFile(AFileName);
//  LUtf8 := LDoc.ToJSON();
//  //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
//  LUtf8 := StringReplace(LUtf8, 'unit', 'Funit', [rfReplaceAll]);
//  //@type을 Attt로 대체 해야 함(아래의 Replace시 @type이 변경 되는 것 방지)
//  LUtf8 := StringReplace(LUtf8, '@type', 'Attt', []);
//  //type을 Ftype로 대체 해야 함
//  LUtf8 := StringReplace(LUtf8, 'type', 'Ftype', []);
//  //Attt를 Atype로 대체 해야 함
//  LUtf8 := StringReplace(LUtf8, 'Attt', 'Atype', []);
//  //@version의 @를 ''로 대체 해야 함
//  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
//  //@subtype의 @를 F로 대체 해야 함
//  LUtf8 := StringReplace(LUtf8, '@subtype', 'Fsubtype', []);
//
//  LDoc2.InitJSON(LUtf8);
//
//  for i := 0 to LDoc2.Count-1 do
//  begin
//    if _Safe(LDoc2.Values[i]).Kind = dvArray then
//    begin
//      LArrDoc := LDoc2.Values[i];
//    end
//    else
//    begin
//      FValueInformations.Atype :=  LDoc2.Value['Atype'];
//      FValueInformations.version :=  LDoc2.Value['version'];
//    end;
//  end;
//
//  LUtf8 := LArrDoc;
//  LDynArr.Init(TypeInfo(TE2SValueInformationsA), FValueInformations.processValueInformations);
//  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));
////  SetLength(FValueInformations.processValueInformations, LDynArr.Count);
////
////  for i := 0 to LDynArr.Count - 1 do
////  begin
////    FValueInformations.processValueInformations[i] := LESValueInformationsA[i];
////  end;
end;

procedure TSnapShot4E2S.ProcessPlcInformation(const AStream: TStream);
var
  LDoc, LDoc2: TDocVariantData;
  LUtf8: RawUTF8;
begin
  FPLCInfo := Default(TE2S_PLCInfo);
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
  LDoc2.InitJSON(LUtf8);
  RecordLoadJson(FPLCInfo, LUtf8, TypeInfo(TE2S_PLCInfo));
end;

procedure TSnapShot4E2S.ProcessDataStructureDocumentation(
  const AFileName: string);
begin

end;

procedure TSnapShot4E2S.ProcessDataStructureDocumentation(
  const AStream: TStream);
var
  LDoc, LDoc2: TDocVariantData;
  LArrDoc: variant;
  i, LCount: integer;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
//  LStream: TStream;
//  LSynAnsiConvert: TSynAnsiConvert;
begin
  FUi_DSD := Default(TE2S_Ui_Data_Structure_Documentation);
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);

  LDoc2.InitJSON(LUtf8,[dvoReturnNullForUnknownProperty]);
//
  for i := 0 to LDoc2.Count-1 do
  begin
    if _Safe(LDoc2.Values[i]).Kind = dvArray then
    begin
      LArrDoc := LDoc2.Values[i];
      break;
    end
  end;

  FUi_DSD.Atype :=  LDoc2.Value['Atype'];
  FUi_DSD.version :=  LDoc2.Value['version'];

  LUtf8 := LArrDoc;
  LDynArr.Init(TypeInfo(TE2S_DSD_EntriesA), FUi_DSD.entries);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));//동적 배열이 자동으로 SetLength 됨
end;

procedure TSnapShot4E2S.ProcessParametersToRestore(const AStream: TStream);
var
  LDoc: TDocVariantData;
  LArrDoc: variant;
  LDynArr: TDynArray;
//  LList: TRawUTF8DynArray;
  LUtf8: RawUTF8;
  i: integer;
begin
  FParametersToRestore := Default(TE2S_ParametersToRestore);
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
  LDoc.InitJSON(LUtf8);

  for i := 0 to LDoc.Count-1 do
  begin
    if _Safe(LDoc.Values[i]).Kind = dvArray then
    begin
      LArrDoc := LDoc.Values[i];
      break;
    end
  end;

  FParametersToRestore.Atype :=  LDoc.Value['Atype'];
  FParametersToRestore.version :=  LDoc.Value['version'];

  LUtf8 := LArrDoc;

  LDynArr.Init(TypeInfo(TRawUTF8DynArray), FParametersToRestore.list);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));//동적 배열이 자동으로 SetLength 됨

//  SetLength(FParametersToRestore.list, LDynArr.Count);
//
//  for i := 0 to LDynArr.Count - 1 do
//  begin
//    FParametersToRestore.list[i] := LDynArr[i];
//  end;
end;

procedure TSnapShot4E2S.ProcessPermissionConfiguration(const AStream: TStream);
var
  LDoc: TDocVariantData;
  LUtf8: RawUTF8;
begin
  FPermissionConfiguration := Default(TE2S_PermissionConfiguration);
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
  LDoc.InitJSON(LUtf8);
  RecordLoadJson(FPermissionConfiguration, LUtf8, TypeInfo(TE2S_PermissionConfiguration));
end;

procedure TSnapShot4E2S.ProcessSnapShotMetaData(const AStream: TStream);
var
  LDoc: TDocVariantData;
  LUtf8: RawUTF8;
begin
  FSnapShotMetaData := Default(TE2S_SnapShotMetaData);
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
  LDoc.InitJSON(LUtf8);
  RecordLoadJson(FSnapShotMetaData, LUtf8, TypeInfo(TE2S_SnapShotMetaData));
end;

procedure TSnapShot4E2S.ProcessTestStream(AFileName: string);
var
  LFileStream: TFileStream;
  LDoc, LDoc2: TDocVariantData;
  LArrDoc: variant;
  i, LCount: integer;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
  LTest: TE2S_nodeDescriptorA;//TE2S_nodeChildrenA;//TE2S_nodeChildren;//TE2S_inputDescriptorChildrenA;//TE2S_nodeDescriptor;
begin
  LFileStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(LFileStream)), LUtf8);
    //@type을 Attt로 대체 해야 함(아래의 Replace시 @type이 변경 되는 것 방지)
    LUtf8 := StringReplace(LUtf8, '@type', 'Attt', []);
    //type을 Ftype로 대체 해야 함
    LUtf8 := StringReplace(LUtf8, 'type', 'Ftype', [rfReplaceAll]);
    //Attt를 Atype로 대체 해야 함
    LUtf8 := StringReplace(LUtf8, 'Attt', 'Atype', []);
    //@version의 @를 ''로 대체 해야 함
    LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
    //@subtype의 @를 F로 대체 해야 함
    LUtf8 := StringReplace(LUtf8, '@subFtype', 'Fsubtype', [rfReplaceAll]);
    //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
    LUtf8 := StringReplace(LUtf8, 'unit', 'Funit', [rfReplaceAll]);
    //null는 에러가 발생하므로 스트링으로 변환
    LUtf8 := StringReplace(LUtf8, 'null', '" "', [rfReplaceAll]);
    LUtf8 := StringReplace(LUtf8, ',"children":[]', '', [rfReplaceAll]);

//    LDoc2.InitJSON(LUtf8,JSON_OPTIONS[true]);
    LDoc2.InitJSON(LUtf8,[dvoReturnNullForUnknownProperty]);
//    LArrDoc := _JSONFast(LUtf8);
//    LTest.barGraphType :=  LArrDoc.barGraph;

    for i := 0 to LDoc2.Count-1 do
    begin
      if _Safe(LDoc2.Values[i]).Kind = dvArray then
      begin
//        if LDoc2.Names[i] = 'children' then
//        begin
          LArrDoc := LDoc2.Values[i];
          break;
//        end;
      end;
    end;

  FUi_Navigation.Atype :=  LDoc2.Value['Atype'];
//    LTest.pageId :=  LDoc2.Value['pageId'];
//    LTest.barGraphType :=  LDoc2.Value['barGraph'];
//    LArrDoc :=  _JSON(LDoc2.Value['barGraph']);
//    LTest.barGraphType := LArrDoc.barGraphType;
//    LTest.numberOfCylinders := LArrDoc.numberOfCylinders;
//    LArrDoc := LDoc2.Values[1];
//    LTest.displayData.titleKey :=  LArrDoc.titleKey;
//    LTest.displayData.descriptionKey := LArrDoc.descriptionKey;
//    LTest.displayData.icon := LArrDoc.icon;
//
//    LArrDoc := LDoc2.Values[0];
//    LTest.inputDescriptor :=  LDoc2.Value['inputDescriptor'];

    LUtf8 := LArrDoc;
    LTest := Default(TE2S_nodeDescriptorA);
    LDynArr.Init(TypeInfo(TE2S_nodeDescriptorA), LTest);
    LDynArr.LoadFromJSON(PUTF8Char(LUtf8));
  finally
    LFileStream.Free;
  end;
end;

procedure TSnapShot4E2S.ProcessUiTextPool(const AFileName: string);
var
  LFS: TFileStream;
begin
  LFS := TFileStream.Create(AFileName, fmOpenRead);
  try
    ProcessUiTextPool(LFS);
  finally
    LFS.Free;
  end;
end;

procedure TSnapShot4E2S.ProcessUiNavigation(const AStream: TStream);
var
  LDoc, LDoc2: TDocVariantData;
  LArrDoc, LNodeDescriptorDoc, LChildrenDoc: variant;
  i, LCount: integer;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
//  LStream: TStream;
begin
  FUi_Navigation := Default(TE2S_navigation);
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //@type을 Attt로 대체 해야 함(아래의 Replace시 @type이 변경 되는 것 방지)
  LUtf8 := StringReplace(LUtf8, '@type', 'Attt', []);
  //type을 Ftype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, 'type', 'Ftype', [rfReplaceAll]);
  //Attt를 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, 'Attt', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
  //@subtype의 @를 F로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@subFtype', 'Fsubtype', [rfReplaceAll]);
  //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
  LUtf8 := StringReplace(LUtf8, 'unit', 'Funit', [rfReplaceAll]);
  //
//  LUtf8 := StringReplace(LUtf8, ',"children":[]', '', [rfReplaceAll]);

//  LUtf8 := StringReplace(LUtf8, 'null', '" "', [rfReplaceAll]);

  //Load nodeDescriptors
  LDoc2.InitJSON(LUtf8,[dvoReturnNullForUnknownProperty]);

  for i := 0 to LDoc2.Count-1 do
  begin
    if _Safe(LDoc2.Values[i]).Kind = dvArray then
    begin
      if LDoc2.Names[i] = 'nodeDescriptors' then
      begin
        LNodeDescriptorDoc := LDoc2.Values[i];
        break;
      end;
    end;
  end;

  FUi_Navigation.Atype :=  LDoc2.Value['Atype'];
  FUi_Navigation.version :=  LDoc2.Value['version'];
  FUi_Navigation.structureType :=  LDoc2.Value['structureType'];

  LDynArr.Init(TypeInfo(TE2S_nodeDescriptorA), FUi_Navigation.nodeDescriptors);
  LUtf8 := LNodeDescriptorDoc;
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));
//  LDynArr.LoadFromVariant(LNodeDescriptorDoc);

  //Load inputDescriptor and children
  for i := 0 to LDynArr.Count-1 do
  begin
    //pageId가 공란이면 바로 이전 배열 데이터에서 Read Error 발생한 것임(children)
//    if FUi_Navigation.nodeDescriptors[i].pageId = '' then
    //technicalDescription = Unassigned 이면 배열 데이터에서 Read Error 발생한 것임(children)
    //technicalDescription = Null이면 Read 정상 임
    //Error 방지를 위해 childres 배열을 제거 후 LoadFromJSON을 다시 한번 수행 함
    if FUi_Navigation.nodeDescriptors[i].technicalDescription <> Null then
    begin
//      RemoveChildrenContents;
    end;
    if _Safe(LDoc2.Values[i]).Kind = dvArray then
    begin
      if LDoc2.Names[i] = 'inputDescriptor' then
      begin
        LArrDoc := LDoc2.Values[i];
        break;
      end
      else if LDoc2.Names[i] = 'children' then
      begin
        LChildrenDoc := LDoc2.Values[i];
        break;
      end;
    end;
  end;

  LUtf8 := LArrDoc;

  if LUtf8 <> '' then
  begin
    LDynArr.Init(TypeInfo(TE2S_inputDescriptorA), FUi_Navigation.nodeDescriptors[0].inputDescriptor);
    LDynArr.LoadFromJSON(PUTF8Char(LUtf8));
  end;

  LUtf8 := LNodeDescriptorDoc;
  //Load inputDescriptor
  LDoc2.InitJSON(LUtf8,[dvoReturnNullForUnknownProperty]);

  for i := 0 to LDoc2.Count-1 do
  begin
    if _Safe(LDoc2.Values[i]).Kind = dvArray then
    begin
      if LDoc2.Names[i] = 'inputDescriptor' then
      begin
        LArrDoc := LDoc2.Values[i];
        break;
      end;
    end;
  end;

  LUtf8 := LChildrenDoc;
  if LUtf8 <> '' then
  begin
    LDynArr.Init(TypeInfo(TE2S_inputDescriptorA), FUi_Navigation.nodeDescriptors[0].children);
    LDynArr.LoadFromJSON(PUTF8Char(LUtf8));
  end;
end;

procedure TSnapShot4E2S.ProcessUiTextPool(const AStream: TStream);
var
  LDoc, LDoc2: TDocVariantData;
  LArrDoc: variant;
  i, LCount: integer;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
//  LStream: TStream;
begin
  FUi_TextPool := Default(TE2S_Ui_Text_Pool);
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);

  LDoc2.InitJSON(LUtf8,[dvoReturnNullForUnknownProperty]);
//
  for i := 0 to LDoc2.Count-1 do
  begin
    if _Safe(LDoc2.Values[i]).Kind = dvArray then
    begin
      LArrDoc := LDoc2.Values[i];
      break;
    end
  end;

  FUi_TextPool.Atype :=  LDoc2.Value['Atype'];
  FUi_TextPool.version :=  LDoc2.Value['version'];

  LUtf8 := LArrDoc;
  LDynArr.Init(TypeInfo(TE2S_Ui_Text_EntriesA), FUi_TextPool.entries);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));//동적 배열이 자동으로 SetLength 됨
end;

procedure TSnapShot4E2S.ProcessValueInformations(const AStream: TStream);
var
  LDoc, LDoc2: TDocVariantData;
  LArrDoc: variant;
  i, LCount: integer;
//  LE2SValueInformations: TE2SValueInformations;
//  LESValueInformationsA: TE2SValueInformationsA;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
//  LStream: TStream;
//  LSynAnsiConvert: TSynAnsiConvert;
begin
  FValueInformations := Default(TE2S_ValueInformations);
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
  LUtf8 := StringReplace(LUtf8, 'unit', 'Funit', [rfReplaceAll]);
  //@type을 Attt로 대체 해야 함(아래의 Replace시 @type이 변경 되는 것 방지)
  LUtf8 := StringReplace(LUtf8, '@type', 'Attt', []);
  //type을 Ftype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, 'type', 'Ftype', [rfReplaceAll]);
  //Attt를 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, 'Attt', 'Atype', []);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', []);
  //@subtype의 @를 F로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@subFtype', 'Fsubtype', [rfReplaceAll]);

  LDoc2.InitJSON(LUtf8,[dvoReturnNullForUnknownProperty]);
//
  for i := 0 to LDoc2.Count-1 do
  begin
    if _Safe(LDoc2.Values[i]).Kind = dvArray then
    begin
      LArrDoc := LDoc2.Values[i];
      break;
    end
  end;

  FValueInformations.Atype :=  LDoc2.Value['Atype'];
  FValueInformations.version :=  LDoc2.Value['version'];

  LUtf8 := LArrDoc;
  LDynArr.Init(TypeInfo(TE2SValueInformationsA), FValueInformations.processValueInformations);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));
//  SetLength(FValueInformations.processValueInformations, LDynArr.Count);
//
//  for i := 0 to LDynArr.Count - 1 do
//  begin
//    FValueInformations.processValueInformations[i] := LESValueInformationsA[i];
//  end;
end;

procedure TSnapShot4E2S.ProcessValueMonitorings(const AStream: TStream);
var
  LArrDoc: TDocVariantData;
  i, LCount: integer;
  LE2S_ValueStates: TE2S_ValueStates;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
  LUtf8 := StringReplace(LUtf8, 'unit', 'Funit', [rfReplaceAll]);

  //min, max의 1.7976931348623157E308를 1.7976931e308로 대체 해야 함
  LDynArr.Init(TypeInfo(TE2S_ValueMonitoringA), FValueMonitoringA);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));
end;

procedure TSnapShot4E2S.ProcessValueMonitorings(const AFileName: string);
var
  LArrDoc: TDocVariantData;
  i, LCount: integer;
//  LE2S_ValueMonitoring: TE2S_ValueMonitoring;
//  LE2S_ValueMonitoringA: TE2S_ValueMonitoringA;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  LArrDoc.InitJSONFromFile(AFileName);
  LUtf8 := LArrDoc.ToJSON();
  //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
  LUtf8 := StringReplace(LUtf8, 'unit', 'Funit', [rfReplaceAll]);
  LDynArr.Init(TypeInfo(TE2S_ValueMonitoringA), FValueMonitoringA);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));
//  SetLength(FValueMonitoringA, LDynArr.Count);
//
//  for i := 0 to LDynArr.Count - 1 do
//  begin
//    FValueMonitoringA[i] := LE2S_ValueMonitoringA[i];
//  end;
end;

procedure TSnapShot4E2S.ProcessValueStates(const AFileName: string);
var
  LArrDoc: TDocVariantData;
  i, LCount: integer;
  LE2S_ValueStates: TE2S_ValueStates;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  LArrDoc.InitJSONFromFile(AFileName);
  LUtf8 := LArrDoc.ToJSON();
  //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
  LUtf8 := StringReplace(LUtf8, 'unit', 'Funit', [rfReplaceAll]);
  //@subtype의 @를 F로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@subtype', 'Fsubtype', [rfReplaceAll]);
  //descriptor=''에서 limits가 한개 더 존재(오타로 추정됨)하여 삭제함
  LUtf8 := StringReplace(LUtf8, ',"limits":null},', '},', [rfReplaceAll]);

  //min, max의 1.7976931348623157E308를 1.7976931e308로 대체 해야 함
//  LUtf8 := StringReplace(LUtf8, '1.7976931348623157E308', '1.7976931e308', [rfReplaceAll]);
  LDynArr.Init(TypeInfo(TE2S_ValueStatesA), FValueStatesA);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));

//  for i := 0 to LDynArr.Count - 1 do
//  begin
//    LE2S_ValueStates := FValueStatesA[i];
//  end;
end;

procedure TSnapShot4E2S.ProcessValueStates(const AStream: TStream);
var
  LArrDoc: TDocVariantData;
  i, LCount: integer;
  LE2S_ValueStates: TE2S_ValueStates;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  Utf8ToRawUTF8(PUTF8Char(StreamToRawByteString(AStream)), LUtf8);
  //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
  LUtf8 := StringReplace(LUtf8, 'unit', 'Funit', [rfReplaceAll]);
  //@subtype의 @를 F로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@subtype', 'Fsubtype', [rfReplaceAll]);
  //descriptor=''에서 limits가 한개 더 존재(오타로 추정됨)하여 삭제함
  LUtf8 := StringReplace(LUtf8, ',"limits":null},', '},', [rfReplaceAll]);

  //min, max의 1.7976931348623157E308를 1.7976931e308로 대체 해야 함
  LDynArr.Init(TypeInfo(TE2S_ValueStatesA), FValueStatesA);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8), @JSON_[mFast]); //동적 배열이 자동으로 SetLength 됨
end;

end.
