unit UnitVesselBaseClass2;

interface

uses System.SysUtils, Classes, Generics.Legacy, JHP.BaseConfigCollect, UnitEngineBaseClass2;

type
  TProjectInfoItem = class(TCollectionItem)
  private
    FProjectName, //�����
    FProjectNo, //�����ȣ
    FProjectSeqNo,//�������(1�� ���縦 �������� �и��Ͽ� ���� �� ��� ����)
    FEngNo,    //��������
    FEngType, //����Ÿ��
    FInternalTester //��ü �ÿ��� ����� �̸�
    : string;

    FSiteName,
    FSiteNo,
    FPlantName,
    FPlantNo,
    FAssyFactory, //��������
    FTestFactory, //�ÿ�������
    FSJDept, //�������μ�
    FSWDept, //����+HEAD �μ�
    FJJDept, //�������μ�
    FClassSociety, //�����̸�
    FEvaluatedBy,  //
    FOperatedBy,
    FFACTester,
    FModule1,
    FModule2,
    FModule3,
    FModule4 : string;

    FInternalTestDate: TDateTime;
    FFACDate: TDateTime; //Factory Acceptance Test Date
    FDeliveryDate: TDateTime; //����
    FAssyStartDate: TDateTime; //���� ������

    FGetDataCompleted: Boolean; //����ü�� DB�κ��� �����͸� ä������ True
  public
    property GetDataCompleted: Boolean read FGetDataCompleted write FGetDataCompleted;
  published
    property ProjectNo: string read FProjectNo write FProjectNo;
    property EngNo: string read FEngNo write FEngNo;
    property EngType: string read FEngType write FEngType;
    property InternalTester: string read FInternalTester write FInternalTester;
    property ProjectName: string read FProjectName write FProjectName;
    property ProjectSeqNo: string read FProjectSeqNo write FProjectSeqNo;
    property SiteName: string read FSiteName write FSiteName;
    property SiteNo: string read FSiteNo write FSiteNo;
    property PlantName: string read FPlantName write FPlantName;
    property PlantNo: string read FPlantNo write FPlantNo;
    property AssyFactory: string read FAssyFactory write FAssyFactory;
    property TestFactory: string read FTestFactory write FTestFactory;
    property SJDept: string read FSJDept write FSJDept;
    property SWDept: string read FSWDept write FSWDept;
    property JJDept: string read FJJDept write FJJDept;
    property ClassSociety: string read FClassSociety write FClassSociety;
    property EvaluatedBy: string read FEvaluatedBy write FEvaluatedBy;
    property OperatedBy: string read FOperatedBy write FOperatedBy;
    property Module1: string read FModule1 write FModule1;
    property Module2: string read FModule2 write FModule2;
    property Module3: string read FModule3 write FModule3;
    property Module4: string read FModule4 write FModule4;
    property InternalTestDate: TDateTime read FInternalTestDate write FInternalTestDate;
    property FACDate: TDateTime read FFACDate write FFACDate;
    property DeliveryDate: TDateTime read FDeliveryDate write FDeliveryDate;
    property AssyStartDate: TDateTime read FAssyStartDate write FAssyStartDate;
  end;

  TProjectInfoCollect<T: TProjectInfoItem> = class(Generics.Legacy.TCollection<T>)
  private
    procedure Test1;
  public
    //���� �������� JSON ����Ʈ�� ������ (TreeGrid Data_Url�� ���)
    FProcessList: TStringList;
  end;

  TVesselInfo = class(TpjhBase)
  private
    FProjectInfoCollect: TProjectInfoCollect<TProjectInfoItem>;

    FShipName,    //ȣ����
    FShipNo,      //ȣ����ȣ
    FMainEngineCount,//��ġ�� ���� ���� ����
    FGenEngineCount,//��ġ�� ������ ���� ����
    FShipOwner  //�����̸�
    : string;
  public
    FEngineList: TStringList;  //Object[] �� EngineBaseClass�� TICEngine�� ������

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Clear;
    //AEngineProjNo : Engine Project No + '_' + Engine Seq No
    function AddEneine2List(AEngineProjNo: string): integer;
    procedure DestroyEngineList;
  published
    property ProjectInfoCollect: TProjectInfoCollect<TProjectInfoItem> read FProjectInfoCollect write FProjectInfoCollect;

    property ShipName: string read FShipName write FShipName;
    property ShipNo: string read FShipNo write FShipNo;
    property MainEngineCount: string read FMainEngineCount write FMainEngineCount;
    property GenEngineCount: string read FGenEngineCount write FGenEngineCount;
    property ShipOwner: string read FShipOwner write FShipOwner;
  end;

implementation

{ TProjectInfo }

function TVesselInfo.AddEneine2List(AEngineProjNo: string): integer;
begin
  Result := FEngineList.AddObject(AEngineProjNo, TICEngine.Create(nil));
end;

procedure TVesselInfo.Clear;
var
  i: integer;
begin
  for i := FEngineList.Count - 1 downto 0 do
  begin
    TICEngine(FEngineList.Objects[i]).Clear;
  end;
end;

constructor TVesselInfo.Create(AOwner: TComponent);
begin
  FProjectInfoCollect := TProjectInfoCollect<TProjectInfoItem>.Create;
  FEngineList := TStringList.Create;
end;

destructor TVesselInfo.Destroy;
begin
  DestroyEngineList;
  FProjectInfoCollect.Free;

  inherited Destroy;
end;

procedure TVesselInfo.DestroyEngineList;
var
  i: integer;
begin
  for i := FEngineList.Count - 1 downto 0 do
  begin
    TICEngine(FEngineList.Objects[i]).Free;
  end;
end;

{ TProjectInfoCollect<T> }

procedure TProjectInfoCollect<T>.Test1;
begin

end;

end.
