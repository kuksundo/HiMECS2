unit DomSensorCQRS2;

interface

uses
  Sx.DDD.Core, mormot.core.interfaces,
  DomSensorTypes2;

type

  IDomSensorQuery = interface(ICQRSService)
    ['{132A9094-585F-4909-9EF6-35BBF97512DE}']
    function SelectAllByProjectNo(const AProjectNo: TProjectNo): TCQRSResult;
    function SelectAllByEngineNo(const AProjectNo: TProjectNo;
      const AEngineNo: TEngineNo): TCQRSResult;
    //Project No, Engine No에 관계없이 모든 TageName Return
    function SelectAllByTagName(const aTagName: TTagName): TCQRSResult;
    function SelectOneByTagName(const AProjectNo: TProjectNo; const AEngineNo: TEngineNo;
      const aTagName: TTagName): TCQRSResult;
    function SelectOneBySubTagName(const AProjectNo: TProjectNo; const AEngineNo: TEngineNo;
      const aSubTagName: TTagName): TCQRSResult;
    function GetAll(out aAggretates: TEngElecPartItemObjArray): TCQRSResult;
    function Get(out aAggregate: TEngElecPartItem): TCQRSResult;
    function GetPrev(out aAggregate: TEngElecPartItem): TCQRSResult;
    function GetNext(out aAggregate: TEngElecPartItem): TCQRSResult;
    function GetCount: Integer;
  end;

  IDomSensorCommand = interface(IDomSensorQuery)
   ['{46E28CE2-91C1-488D-B0F8-71DFFBC16821}']
    function Add(const aAggregate: TEngElecPartItem): TCQRSResult;
    function Update(const aUpdatedAggregate: TEngElecPartItem): TCQRSResult;
    function DeleteSelected(const aDeletedAggregate: TEngElecPartItem): TCQRSResult;
    function DeleteAllSelected: TCQRSResult;
    function Commit: TCQRSResult;
    function Rollback: TCQRSResult;
  end;

implementation

initialization
  TInterfaceFactory.RegisterInterfaces([
    TypeInfo(IDomSensorQuery), TypeInfo(IDomSensorCommand)]);

end.
