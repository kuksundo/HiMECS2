unit UnitSimulateParamCommandLineOption2;

interface

uses classes, GpCommandLineParser;

type
  //Watch2에서 Simulate Data를 DB에 저장할 때 SimulateParamServer에 전달해 주는
  //Design Form의 현재 PageIndex 및 Tap Caption
  TAdditioinalDataRec = packed record
    FPageIndex: integer;
    FCaption : string;
    //SimulateParamEdit Form의 Data가 JSON으로 전달 됨
    //이전 입력 값을 신규 입력 폼에 표시하여 중복 입력 시간을 줄이기 위함
    FJson4SimParamEditData : string;
    FFormHandle: integer;
  end;

  TSimulateParamCLO2 = class//CLO: CommandLineOption
    FConfigFileName,
    FParamFileName,
    fParamSourceList,
    FJsonParamCollect,
    FCSVValues,
    FAdditionalData,
    FSimulateCompValuesJson,
    FSkipMsg: string;
  public
    [CLPName('c'), CLPLongName('ConfigFile'), CLPDescription('Config File Name'), CLPDefault('')]
    property ConfigFileName: string read FConfigFileName write FConfigFileName;
    [CLPName('p'), CLPLongName('ParamDB'), CLPDescription('Engine Parameter DB Name'), CLPDefault('')]
    property ParamFileName: string read FParamFileName write FParamFileName;
    [CLPName('s'), CLPLongName('ParamSource', 'ParamSourceList'), CLPDescription('Param Source List CSV')]
    property ParamSourceList: string read fParamSourceList write fParamSourceList;
    [CLPName('j'), CLPLongName('JsonParam', 'ParamList'), CLPDescription('Json Param Collect')]
    property JsonParamCollect: string read FJsonParamCollect write FJsonParamCollect;
    [CLPName('v'), CLPLongName('CSVValues', 'CSV'), CLPDescription('CSV Values.')]
    property CSVValues: string read FCSVValues write FCSVValues;
    [CLPName('a'), CLPLongName('AdditionalData', 'additional'), CLPDescription('Additional Data')]
    property AdditionalData: string read FAdditionalData write FAdditionalData;
    [CLPName('d'), CLPLongName('SimulateCompValuesJson', 'Component Values'), CLPDescription('Component Values Data')]
    property SimulateCompValuesJson: string read FSimulateCompValuesJson write FSimulateCompValuesJson;
    [CLPName('o'), CLPLongName('OmitMsg', 'Omit Show Message when start'), CLPDescription('Omit Show Message when start'), CLPDefault('False')]
    property SkipMsg: string read FSkipMsg write FSkipMsg;
  end;

const
  gp_SimParam_SHARED_MAX_SIZE = 20000000;
  gp_SimParam_SHARED_DATA_NAME = 'SharedData_{C9989AE6-22A4-41ED-A97A-9040FF58C875}';
  gp_NOTIFY_SHMM_EVENT_NAME_4_WATCH2 = gp_SimParam_SHARED_DATA_NAME + '_NotifyEvent';
  gp_EventNameSpace = 'HiMECS_Watch2';
  gp_EventName4SimEditData = 'SendSimulateParamEditData2gpShMM';
  //Watch2에서 "Move pjhValue To Item and Save To DB" 메뉴 클릭 시 중복 입력 방지를 위해 FrmSimulateParamEdit.TSimulateParamEditF에서 정보를 Watch2에 전달해 줌
  gp_EventName4SimAutoFillInData = 'SendSimulateAutoFillInData2gpShMM';
  gp_EventName4SimCommandJson = 'SendSimulateCommandJson2gpShMM';
  //ParamServer에서 Description을 StatusDisplay에 전달함
  //실제로는 gpSM을 이용하여 데이타 전달후 Event.Create(NOTIFY_SHMM_EVENT_NAME)사용하여 StatusDisplay에 통보함
  gp_EventName4StatusDisplay = 'SendSimulate4StatusDisplay';

implementation

end.
