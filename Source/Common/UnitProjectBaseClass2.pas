unit UnitProjectBaseClass2;

interface

uses System.SysUtils, Classes, Generics.Legacy, JHP.BaseConfigCollect;

type
  TProjectInfoItem = class(TCollectionItem)
  private
    FProjectNo, //�����ȣ
    FEngNo,    //��������
    FEngType, //����Ÿ��
    FInternalTester //��ü �ÿ��� ����� �̸�
    : string;
  published
    property ProjectNo: string read FProjectNo write FProjectNo;
    property EngNo: string read FEngNo write FEngNo;
    property EngType: string read FEngType write FEngType;
    property InternalTester: string read FInternalTester write FInternalTester;
  end;

  TProjectInfoCollect<T: TProjectInfoItem> = class(Generics.Legacy.TCollection<T>)
  private
  public
  end;

  TVesselInfo = class(TpjhBase)
  private
    FProjectInfoCollect: TProjectInfoCollect<TProjectInfoItem>;

    FProjectName, //�����
    FProjectNo,   //�����ȣ
    FProjectSeqNo,//�������(1�� ���縦 �������� �и��Ͽ� ���� �� ��� ����)
    FSiteName,
    FSiteNo,
    FPlantName,
    FPlantNo,
    FShipName,    //ȣ����
    FShipNo,      //ȣ����ȣ
    FEquipCount,//��ġ�� ��� ����(��: ����)
    FAssyFactory, //��������
    FTestFactory, //�ÿ�������
    FSJDept, //�������μ�
    FSWDept, //����+HEAD �μ�
    FJJDept, //�������μ�
    FShipOwner,  //�����̸�
    FClassSociety, //�����̸�
    FEvaluatedBy,  //
    FOperatedBy,
    FFACTester,
    FModule1,
    FModule2,
    FModule3,
    FModule4 : string;

    FInternalTestDate: TDateTime;
    FFATDate: TDateTime; //Factory Acceptance Test Date
    FDeliveryDate: TDateTime; //����
    FAssyStartDate: TDateTime; //���� ������

    FGetDataCompleted: Boolean; //����ü�� DB�κ��� �����͸� ä������ True
  public
    //���� �������� JSON ����Ʈ�� ������ (TreeGrid Data_Url�� ���)
    FProcessList: TStringList;

    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Clear;
    property GetDataCompleted: Boolean read FGetDataCompleted write FGetDataCompleted;
  published
    property ProjectInfoCollect: TProjectInfoCollect<TProjectInfoItem> read FProjectInfoCollect write FProjectInfoCollect;

    property ProjectName: string read FProjectName write FProjectName;
    property ProjectNo: string read FProjectNo write FProjectNo;
    property ProjectSeqNo: string read FProjectSeqNo write FProjectSeqNo;
    property SiteName: string read FSiteName write FSiteName;
    property SiteNo: string read FSiteNo write FSiteNo;
    property PlantName: string read FPlantName write FPlantName;
    property PlantNo: string read FPlantNo write FPlantNo;
    property ShipName: string read FShipName write FShipName;
    property ShipNo: string read FShipNo write FShipNo;
    property EquipCount: string read FEquipCount write FEquipCount;
    property AssyFactory: string read FAssyFactory write FAssyFactory;
    property TestFactory: string read FTestFactory write FTestFactory;
    property SJDept: string read FSJDept write FSJDept;
    property SWDept: string read FSWDept write FSWDept;
    property JJDept: string read FJJDept write FJJDept;
    property ShipOwner: string read FShipOwner write FShipOwner;
    property ClassSociety: string read FClassSociety write FClassSociety;
    property EvaluatedBy: string read FEvaluatedBy write FEvaluatedBy;
    property OperatedBy: string read FOperatedBy write FOperatedBy;
    property Module1: string read FModule1 write FModule1;
    property Module2: string read FModule2 write FModule2;
    property Module3: string read FModule3 write FModule3;
    property Module4: string read FModule4 write FModule4;
    property InternalTestDate: TDateTime read FInternalTestDate write FInternalTestDate;
    property FATDate: TDateTime read FFATDate write FFATDate;
    property DeliveryDate: TDateTime read FDeliveryDate write FDeliveryDate;
    property AssyStartDate: TDateTime read FAssyStartDate write FAssyStartDate;
  end;

implementation

{ TProjectInfoCollect }

{ TProjectInfo }

procedure TVesselInfo.Clear;
begin
;
end;

constructor TVesselInfo.Create(AOwner: TComponent);
begin
  FProjectInfoCollect := TProjectInfoCollect<TProjectInfoItem>.Create;
  FProcessList := TStringList.Create;
end;

destructor TVesselInfo.Destroy;
begin
  inherited Destroy;

  FProjectInfoCollect.Free;
  FProcessList.Free;
end;

end.
