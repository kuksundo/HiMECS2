unit ConfigOptionClass2;

interface

uses classes, SysUtils, JHP.BaseConfigCollect, HiMECSConst2, GpCommandLineParser,
  Generics.Legacy, JHP.BaseCommandLineOption;
{Boolean Type은 CommandLine에 /OneForm 유무에 따라 True/False가 결정됨}
{/p"E:\temp\MK2" /OneForm /DelRegistry /SkipReg /rip:"10.1.1.1"}
{/SkipReg DecKind=123 /Masterpw="7beAJ75XB5nPZWDD714cJQ==" }
type
  TWatchCommandLineOption = class//TJHPBaseCommandLineOption
    FRCSIPAddress, //Reg Code Server IP Address
    FRCSPort, //Reg Code Server Port No
    FMasterPwd //Master Pwd ()
    : string;

    FSkipRegCheck, //Reg check skip을 위해서는 Master Passwd를 전달해 주어야 함
    FDeleteRegInfo,
    FIsZip //dfc 파일이 zip 파일 내에 존재한 경우 True
    : Boolean;

    FDecryptKind4SkipRegCheck //Skip Reg Check 시 암호를 Decrypt하는 방법 선택
    : integer;

    FConfigFileName,
    FWatchListFileName,
    FDummyFormHandle,
    FSharedMMName //Auto 실행시 gpShared MM Name을 지정함
    : string;
    FAutoExecute,
    FAlarmMode,
    FMDIChildMode,
    FIsDisplayTrend,
    FIsDisplaySimple,
    FIsOnlyOneForm
    : Boolean;
    FUserLevel
    : integer;
  public
    class function CommandLineParse(var AWatchCLO: TWatchCommandLineOption;
      var AErrMsg: string): boolean;

    [CLPName('p'), CLPLongName('param'), CLPDescription('param file name'), CLPDefault('')]//, '<path>'
    property WatchListFileName: string read FWatchListFileName write FWatchListFileName;
    [CLPName('c'), CLPLongName('ConfigFile'), CLPDescription('Config File Name'), CLPDefault('')]
    property ConfigFileName: string read FConfigFileName write FConfigFileName;
    [CLPName('a'), CLPLongName('AutoExcute', 'Auto'), CLPDescription('Enable autotest mode.')]
    property AutoExecute: boolean read FAutoExecute write FAutoExecute;
    [CLPName('m'), CLPLongName('MDIChildMode', 'MDI'), CLPDescription('Enable MDI Child mode.')]
    property MDIChildMode: boolean read FMDIChildMode write FMDIChildMode;
    [CLPName('r'), CLPLongName('AlarmMode', 'Alarm'), CLPDescription('Enable Alarm Mode.')]
    property AlarmMode: boolean read FAlarmMode write FAlarmMode;
    [CLPLongName('DisplayTrend', 'Trend'), CLPDescription('Display Trend Sheet When Start.')]
    property IsDisplayTrend: boolean read FIsDisplayTrend write FIsDisplayTrend;
    [CLPLongName('DisplaySimple', 'Simple'), CLPDescription('Display Simple Sheet When Start.')]
    property IsDisplaySimple: boolean read FIsDisplaySimple write FIsDisplaySimple;
    [CLPLongName('OneForm', 'OnlyOneForm'), CLPDescription('Load Only One form from *.dfc file')]
    property IsOnlyOneForm: boolean read FIsOnlyOneForm write FIsOnlyOneForm;
    [CLPName('d'), CLPDescription('Dummy Handle'), CLPDefault('')]//'<days>'
    property DummyFormHandle: string read FDummyFormHandle write FDummyFormHandle;
    [CLPName('u'), CLPDescription('User Level'), CLPDefault('0')]
    property UserLevel: integer read FUserLevel write FUserLevel;
    [CLPLongName('SkipReg'), CLPDescription('Skip Reginfo check')]
    property SkipRegCheck: Boolean read FSkipRegCheck write FSkipRegCheck;
    [CLPLongName('rip'), CLPDescription('/rip:"xx.xx.xx.xx"'), CLPDefault('')]
    property RCSIPAddress: string read FRCSIPAddress write FRCSIPAddress;
    [CLPLongName('rport'), CLPDescription('Reg Code Server Port No'), CLPDefault('')]
    property RCSPort: string read FRCSPort write FRCSPort;
    [CLPLongName('Masterpw'), CLPDescription('Master Pwd'), CLPDefault('')]
    property MasterPwd: string read FMasterPwd write FMasterPwd;
    [CLPLongName('DelRegistry'), CLPDescription('Delete Reginfo from registry')]
    property DeleteRegInfo: boolean read FDeleteRegInfo write FDeleteRegInfo;
    [CLPName('DecKind'), CLPDescription('Decrypt Method for master passwd of Skip Reg Check'), CLPDefault('0')]
    property DecryptKind4SkipRegCheck: integer read FDecryptKind4SkipRegCheck write FDecryptKind4SkipRegCheck;

    [CLPLongName('IsZip', 'IsFromZipFile'), CLPDescription('Load form from zip file')]
    property IsZip: boolean read FIsZip write FIsZip;

    [CLPLongName('smn'), CLPDescription('gpShared Memory Name')]
    property SharedMMName: string read FSharedMMName write FSharedMMName;
  end;

  TConfigOptionCollect = class;
  TConfigOptionItem = class;

  TMQServerTopicItem = class(TCollectionItem)
  private
    FTopicName: string;
  published
    property TopicName: string read FTopicName write FTopicName;
  end;

  TMQServerTopicCollect<T: TMQServerTopicItem> = class(Generics.Legacy.TCollection<T>)
  end;

  TConfigOption = class(TpjhBase)
  private
    FConfigOptionCollect: TConfigOptionCollect;
    FMQServerTopicCollect: TMQServerTopicCollect<TMQServerTopicItem>;

    FModbusFileName: string;
    FDefaultSoundFileName: string;
    FAverageSize: integer; //평균을 위한 배열 size

    FNameFontSize,
    FValueFontSize: integer; //Display font size

    FSelectAlarmValue: integer;//0:not used, 1: original, 2: this
    FSelDisplayInterval: integer;//0: By Event, 1: By Timer
    FDisplayInterval: integer; //값을 화면에 표시하는 Timer Intervel
    FAliveSendInterval: integer;

    FMinAlarmValue: double; //Fault보다 낮은 레벨
    FMaxAlarmValue: double; //Fault보다 낮은 레벨
    FMinFaultValue: double;
    FMaxFaultValue: double;

    FMinAlarmColor: Longint; //Alarm 발생시 표시색
    FMaxAlarmColor: Longint;
    FMinFaultColor: Longint;
    FMaxFaultColor: Longint;

    FMinAlarmBlink: Boolean; //Alarm 발생시 Blink
    FMaxAlarmBlink: Boolean;
    FMinFaultBlink: Boolean;
    FMaxFaultBlink: Boolean;

    FViewAvgValue: Boolean;
    FSubWatchClose: Boolean;//프로그램 종료시에 sub watch list 종료 여부
    FZoomToFitTrend: Boolean; //Trend 표시 될때마다 ZoomtoFit 실행 여부
    FRingBufferSize: LongWord;
    FFormCaption: string;//Watch2 Form Caption
    FEngParamEncrypt: Boolean;//Engine Parameter file Encryption
    FEngParamFileFormat: integer; //0: XML, 1: JSON
    FMonDataSource: integer; //0: By IPC, 1: By DB, 2: By MQ

    FMQServerIP,
    FMQServerPort,
    FMQServerTopic,
    FMQServerUserId,
    FMQServerPasswd: string;
    FWatchListFileName,
    FConfigFileName: string;
    FDisplayAverageValue: Boolean;
  public
    FDisplayAverageValueChanged,
    FMQServerIPChanged,
    FMQServerPortChanged,
    FMQServerTopicChanged,
    FWatchListFileNameChanged,
    FAverageSizeChanged: Boolean;

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    procedure InitValueChanged;
    procedure CheckValueChanged(AOldValue: TConfigOption);
    procedure SetTopic2StrList(out AList: TStringList);
  published
    property ConfigOptionCollect: TConfigOptionCollect read FConfigOptionCollect write FConfigOptionCollect;
    property MQServerTopicCollect: TMQServerTopicCollect<TMQServerTopicItem> read FMQServerTopicCollect write FMQServerTopicCollect;

    property FormCaption: string read FFormCaption write FFormCaption;
    property ModbusFileName: string read FModbusFileName write FModbusFileName;
    property DefaultSoundFileName: string read FDefaultSoundFileName write FDefaultSoundFileName;
    property AverageSize: integer read FAverageSize write FAverageSize;
    property NameFontSize: integer read FNameFontSize write FNameFontSize;
    property ValueFontSize: integer read FValueFontSize write FValueFontSize;
    property SelDisplayInterval: integer read FSelDisplayInterval write FSelDisplayInterval;
    property DisplayInterval: integer read FDisplayInterval write FDisplayInterval;
    property AliveSendInterval: integer read FAliveSendInterval write FAliveSendInterval;

    property SelectAlarmValue: integer read FSelectAlarmValue write FSelectAlarmValue;
    property MinAlarmValue: double read FMinAlarmValue write FMinAlarmValue;
    property MinFaultValue: double read FMinFaultValue write FMinFaultValue;
    property MaxAlarmValue: double read FMaxAlarmValue write FMaxAlarmValue;
    property MaxFaultValue: double read FMaxFaultValue write FMaxFaultValue;
    property MinAlarmColor: Longint read FMinAlarmColor write FMinAlarmColor;
    property MaxAlarmColor: Longint read FMaxAlarmColor write FMaxAlarmColor;
    property MinFaultColor: Longint read FMinFaultColor write FMinFaultColor;
    property MaxFaultColor: Longint read FMaxFaultColor write FMaxFaultColor;
    property MinAlarmBlink: Boolean read FMinAlarmBlink write FMinAlarmBlink;
    property MaxAlarmBlink: Boolean read FMaxAlarmBlink write FMaxAlarmBlink;
    property MinFaultBlink: Boolean read FMinFaultBlink write FMinFaultBlink;
    property MaxFaultBlink: Boolean read FMaxFaultBlink write FMaxFaultBlink;
    property ViewAvgValue: Boolean read FViewAvgValue write FViewAvgValue;
    property SubWatchClose: Boolean read FSubWatchClose write FSubWatchClose;
    property ZoomToFitTrend: Boolean read FZoomToFitTrend write FZoomToFitTrend;
    property RingBufferSize: LongWord read FRingBufferSize write FRingBufferSize;
    property EngParamEncrypt: Boolean read FEngParamEncrypt write FEngParamEncrypt;
    property EngParamFileFormat: Integer read FEngParamFileFormat write FEngParamFileFormat;
    property MonDataSource: Integer read FMonDataSource write FMonDataSource;

    property MQServerIP : string read FMQServerIP write FMQServerIP;
    property MQServerPort : string read FMQServerPort write FMQServerPort;
    property MQServerTopic : string read FMQServerTopic write FMQServerTopic;
    property MQServerUserId : string read FMQServerUserId write FMQServerUserId;
    property MQServerPasswd : string read FMQServerPasswd write FMQServerPasswd;

    property WatchListFileName : string read FWatchListFileName write FWatchListFileName;
    property ConfigFileName : string read FConfigFileName write FConfigFileName;
    //Items에 Avg 보여줌
    property DisplayAverageValue : Boolean read FDisplayAverageValue write FDisplayAverageValue;
  end;

  TConfigOptionItem = class(TCollectionItem)
  private
  published
    //property PartName: string read FPartName write FPartName;
  end;

  TConfigOptionCollect = class(TCollection)
  private
    function GetItem(Index: Integer): TConfigOptionItem;
    procedure SetItem(Index: Integer; const Value: TConfigOptionItem);
  public
    function  Add: TConfigOptionItem;
    function Insert(Index: Integer): TConfigOptionItem;
    property Items[Index: Integer]: TConfigOptionItem read GetItem  write SetItem; default;
  end;

implementation

{ TInternalCombustionEngine }

procedure TConfigOption.CheckValueChanged(AOldValue: TConfigOption);
begin
  FDisplayAverageValueChanged := DisplayAverageValue <> AOldValue.DisplayAverageValue;
  FMQServerIPChanged := MQServerIP <> AOldValue.MQServerIP;
  FMQServerPortChanged := MQServerPort <> AOldValue.MQServerPort;
//  FMQServerTopicChanged := MQServerTopic <> AOldValue.MQServerTopic;
  FWatchListFileNameChanged := WatchListFileName <> AOldValue.WatchListFileName;
  FAverageSizeChanged := AverageSize <> AOldValue.AverageSize;
end;

constructor TConfigOption.Create(AOwner: TComponent);
begin
  FConfigOptionCollect := TConfigOptionCollect.Create(TConfigOptionItem);
  FMQServerTopicCollect := TMQServerTopicCollect<TMQServerTopicItem>.Create;
end;

destructor TConfigOption.Destroy;
begin
  inherited Destroy;

  FMQServerTopicCollect.Free;
  FConfigOptionCollect.Free;
end;

procedure TConfigOption.InitValueChanged;
begin
  FDisplayAverageValueChanged := False;
  FMQServerIPChanged := False;
  FMQServerPortChanged := False;
  FMQServerTopicChanged := False;
  FWatchListFileNameChanged := False;
  FAverageSizeChanged := False;
end;

procedure TConfigOption.SetTopic2StrList(out AList: TStringList);
var
  i: integer;
begin
  for i := 0 to FMQServerTopicCollect.Count - 1 do
    AList.Add(FMQServerTopicCollect.Items[i].TopicName);
end;

{ TConfigOptionCollect }

function TConfigOptionCollect.Add: TConfigOptionItem;
begin
  Result := TConfigOptionItem(inherited Add);
end;

function TConfigOptionCollect.GetItem(Index: Integer): TConfigOptionItem;
begin
  Result := TConfigOptionItem(inherited Items[Index]);
end;

function TConfigOptionCollect.Insert(Index: Integer): TConfigOptionItem;
begin
  Result := TConfigOptionItem(inherited Insert(Index));
end;

procedure TConfigOptionCollect.SetItem(Index: Integer; const Value: TConfigOptionItem);
begin
  Items[Index].Assign(Value);
end;

{ TWatchCommandLineOption }

class function TWatchCommandLineOption.CommandLineParse(
  var AWatchCLO: TWatchCommandLineOption; var AErrMsg: string): boolean;
var
  LStr: string;
begin
  AErrMsg := '';
  AWatchCLO := TWatchCommandLineOption.Create;
  try
//      CommandLineParser.Options := [opIgnoreUnknownSwitches];
    Result := CommandLineParser.Parse(AWatchCLO);
  except
    on E: ECLPConfigurationError do begin
      AErrMsg := '*** Configuration error ***' + #13#10 +
        Format('%s, position = %d, name = %s',
          [E.ErrorInfo.Text, E.ErrorInfo.Position, E.ErrorInfo.SwitchName]);
      Exit;
    end;
  end;

  if not Result then
  begin
    AErrMsg := Format('%s, position = %d, name = %s',
      [CommandLineParser.ErrorInfo.Text, CommandLineParser.ErrorInfo.Position,
       CommandLineParser.ErrorInfo.SwitchName]) + #13#10;
    for LStr in CommandLineParser.Usage do
      AErrMsg := AErrMSg + LStr + #13#10;
  end
  else
  begin
  end;
end;

end.

