unit UnitProjectFileClass2;

interface

uses classes, JHP.BaseConfigCollect, HiMECSConst2, UnitHiMECSConfigCollect2,
  UnitHiMECSMonitorListClass2, UnitAutoRunClass2;

type
  TProjectShowMode = (psmNull, psmAdd, PsmView, psmFinal);

  TProjectFileCollect = class;
  TProjectFileItem = class;

  TProjectFile = class(TpjhBase)
  private
    FProjectFileCollect: TProjectFileCollect;
    FProjectDescript,
    FProjectFileName: string;

    FCurrentProjectIndex: integer;
  public
    FShowMode: TProjectShowMode;
    FSelectedProjectItem: TProjectFileItem;//Equipment View시에 파라미터 전달을 위해 임시로 사용함

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(Source: TProjectFile);

    property CurrentProjectIndex: integer read FCurrentProjectIndex write FCurrentProjectIndex;
  published
    property ProjectFileCollect: TProjectFileCollect read FProjectFileCollect write FProjectFileCollect;
    property ProjectDescript: string read FProjectDescript write FProjectDescript;
    property ProjectFileName: string read FProjectFileName write FProjectFileName;
  end;

  TProjectFileItem = class(TCollectionItem)
  private
    FProjectItemName,
    FOptionsFileName,
    FUserFileName,
    FRunListFileName, //Auto run program list file(자동 실행되는 통신 프로그램 리스트)
    FMonitorFileName, //Monitoring form list file(Watch List 파일임)
    FProjectItemDescript,
    FImgFileName //Project를 Select할때 표시되는 이미지 파일 이름(경로포함)
    : string;
    FUserLevel: THiMECSUserLevel;
    FOptionFileEncrypt: Boolean;//Engine Parameter file Encryption
    FRunListFileEncrypt: Boolean;//Run List file Encryption
    FMonitorFileEncrypt: Boolean;//Monitor file Encryption
    FIsDisplayOnTab: Boolean;//Parameter 창에 표시하지 않고 상단 탭에 Project Name 표시

    FHiMECSConfig: THiMECSConfig;
    FHiMECSMonitor: THiMECSMonitorList;
    FHiMECSAutoRun: TAutoRunList;
  public
    property HiMECSConfig: THiMECSConfig read FHiMECSConfig write FHiMECSConfig;
    property HiMECSMonitor: THiMECSMonitorList read FHiMECSMonitor write FHiMECSMonitor;
    property HiMECSAutoRun: TAutoRunList read FHiMECSAutoRun write FHiMECSAutoRun;

    procedure Assign(Source: TPersistent); override;
  published
    property ProjectItemName: string read FProjectItemName write FProjectItemName;
    property OptionsFileName: string read FOptionsFileName write FOptionsFileName;
    property UserFileName: string read FUserFileName write FUserFileName;
    property RunListFileName: string read FRunListFileName write FRunListFileName;
    property MonitorFileName: string read FMonitorFileName write FMonitorFileName;
    property ProjectItemDescript: string read FProjectItemDescript write FProjectItemDescript;
    property ImgFileName: string read FImgFileName write FImgFileName;
    property UserLevel: THiMECSUserLevel read FUserLevel write FUserLevel;
    property OptionFileEncrypt: Boolean read FOptionFileEncrypt write FOptionFileEncrypt;
    property RunListFileEncrypt: Boolean read FRunListFileEncrypt write FRunListFileEncrypt;
    property MonitorFileEncrypt: Boolean read FMonitorFileEncrypt write FMonitorFileEncrypt;
    property IsDisplayOnTab: Boolean read FIsDisplayOnTab write FIsDisplayOnTab;
  end;

  TProjectFileCollect = class(TCollection)
  private
    function GetItem(Index: Integer): TProjectFileItem;
    procedure SetItem(Index: Integer; const Value: TProjectFileItem);
  public
    function  Add: TProjectFileItem;
    function Insert(Index: Integer): TProjectFileItem;
    property Items[Index: Integer]: TProjectFileItem read GetItem  write SetItem; default;
  end;

implementation

{ TProjectFileCollect }

function TProjectFileCollect.Add: TProjectFileItem;
begin
  Result := TProjectFileItem(inherited Add);
end;

function TProjectFileCollect.GetItem(Index: Integer): TProjectFileItem;
begin
  Result := TProjectFileItem(inherited Items[Index]);
end;

function TProjectFileCollect.Insert(Index: Integer): TProjectFileItem;
begin
  Result := TProjectFileItem(inherited Insert(Index));
end;

procedure TProjectFileCollect.SetItem(Index: Integer;
  const Value: TProjectFileItem);
begin
  Items[Index].Assign(Value);
end;

{ TProjectFile }

procedure TProjectFile.Assign(Source: TProjectFile);
var
  i: integer;
begin
//  if Source is TProjectFile then
//  begin
    if Assigned(ProjectFileCollect) then
    begin
      FProjectFileCollect.Clear;

      for i := 0 to TProjectFile(Source).ProjectFileCollect.Count - 1 do
        with ProjectFileCollect.Add do
          Assign(TProjectFile(Source).ProjectFileCollect[i]);
    end;

    ProjectDescript := TProjectFile(Source).ProjectDescript;
//  end
//  else
//    inherited;
end;

procedure TProjectFile.Clear;
begin
;
end;

constructor TProjectFile.Create(AOwner: TComponent);
begin
  FProjectFileCollect := TProjectFileCollect.Create(TProjectFileItem);
end;

destructor TProjectFile.Destroy;
begin
  inherited Destroy;

  FProjectFileCollect.Free;
end;

{ TProjectFileItem }

procedure TProjectFileItem.Assign(Source: TPersistent);
begin
  if Source is TProjectFileItem then
  begin
    ProjectItemName := TProjectFileItem(Source).ProjectItemName;
    OptionsFileName := TProjectFileItem(Source).OptionsFileName;
    UserFileName := TProjectFileItem(Source).UserFileName;
    RunListFileName := TProjectFileItem(Source).RunListFileName;
    MonitorFileName := TProjectFileItem(Source).MonitorFileName;
    ImgFileName := TProjectFileItem(Source).ImgFileName;
    ProjectItemDescript := TProjectFileItem(Source).ProjectItemDescript;
    UserLevel := TProjectFileItem(Source).UserLevel;
    OptionFileEncrypt := TProjectFileItem(Source).OptionFileEncrypt;
    RunListFileEncrypt := TProjectFileItem(Source).RunListFileEncrypt;
    MonitorFileEncrypt := TProjectFileItem(Source).MonitorFileEncrypt;
  end
  else
    inherited;
end;

end.
