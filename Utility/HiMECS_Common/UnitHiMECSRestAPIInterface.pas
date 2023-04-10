unit UnitHiMECSRestAPIInterface;

interface

uses
  mormot.core.base, mormot.core.interfaces, mormot.orm.core, mormot.orm.base;

type
  TRestAPIParam = packed record
    MethodName: RawUTF8;
    ParamJson: RawUTF8;
  end;

  TRestAPIResponse = packed record
    Id: integer;
    MethodName: RawUTF8;
    Response: RawUTF8;
  end;

  TRestAPIResponseDoc = packed record
    Id: integer;
    MethodName: RawUTF8;
    ProjName: RawUTF8;
    DeviceName: RawUTF8;
    DocName: RawUTF8;
    ContentType: RawUTF8; //System, Part, SectionNo(�˻��� ������)
    SearchText: RawUTF8;
    Response: RawUTF8;
  end;

  TRestAPIResponseDocContent = packed record
    Id: integer;
    Desc: RawUTF8; //FlatList Item ��� ǥ��
    Msg: RawUTF8;  //FlatList Item �ϴ� ǥ��
    DocName: RawUTF8;
//    System: RawUTF8;
//    Part: RawUTF8;
//    SectionNo: RawUTF8;
  end;

  TRestAPIResponseDynArr = array of TRestAPIResponse;
  TRestAPIResponse2DynArr = array of TRestAPIResponseDoc;
  TTRestAPIResponseDocContent2DynArr = array of TRestAPIResponseDocContent;

  IHiMECSRestAPI = interface(IInvokable)
    ['{A513830B-DE11-4E74-9CE1-457FBCD9B048}']
    function ServerExecByJson(const AJson: TRestAPIParam): RawUTF8;
    function ServerExecByParam(const AMethodName, AParamJson: RawUTF8): RawUTF8;
//    function GetListByParam(const AMethodName, AParamJson: RawUTF8): RawJson;
    function GetListByParam(const AMethodName, AParamJson: RawUTF8): TRestAPIResponseDynArr;
    function GetRawData(const AMethodName, AFileName: RawUTF8): RawBlob;
    function PutRawData(const AImage: RawBlob): integer;
    function GetBlob(const AMethodName, AFileName: RawUTF8): TServiceCustomAnswer;
  end;

  //TOrmHiMECSRestAPI �̸��� ����ϸ� "routing name is already used" Error �߻���
  //TOrm + HiMECSRestAPI�� IHiMECSRestAPI�� �����ϴ� �� ����(2022-08-26)
  TOrmHiMECSRestAPIDB = class(TOrm)
  private
    FName: RawUTF8;
    FTime: TModTime;
  published
    property Name: RawUTF8 read FName write FName;
    property Time: TModTime read FTime write FTime;
  end;

  function CreateHiMECSRestAPIModel: TOrmModel;

implementation

function CreateHiMECSRestAPIModel: TOrmModel;
begin
  result := TOrmModel.Create([TOrmHiMECSRestAPIDB]);
end;

initialization
  TInterfaceFactory.RegisterInterfaces([TypeInfo(IHiMECSRestAPI)]);
end.
