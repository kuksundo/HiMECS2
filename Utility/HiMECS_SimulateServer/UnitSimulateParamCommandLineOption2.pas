unit UnitSimulateParamCommandLineOption2;

interface

uses classes, GpCommandLineParser;

type
  //Watch2���� Simulate Data�� DB�� ������ �� SimulateParamServer�� ������ �ִ�
  //Design Form�� ���� PageIndex �� Tap Caption
  TAdditioinalDataRec = packed record
    FPageIndex: integer;
    FCaption : string;
    //SimulateParamEdit Form�� Data�� JSON���� ���� ��
    //���� �Է� ���� �ű� �Է� ���� ǥ���Ͽ� �ߺ� �Է� �ð��� ���̱� ����
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
  //Watch2���� "Move pjhValue To Item and Save To DB" �޴� Ŭ�� �� �ߺ� �Է� ������ ���� FrmSimulateParamEdit.TSimulateParamEditF���� ������ Watch2�� ������ ��
  gp_EventName4SimAutoFillInData = 'SendSimulateAutoFillInData2gpShMM';
  gp_EventName4SimCommandJson = 'SendSimulateCommandJson2gpShMM';
  //ParamServer���� Description�� StatusDisplay�� ������
  //�����δ� gpSM�� �̿��Ͽ� ����Ÿ ������ Event.Create(NOTIFY_SHMM_EVENT_NAME)����Ͽ� StatusDisplay�� �뺸��
  gp_EventName4StatusDisplay = 'SendSimulate4StatusDisplay';

implementation

end.
