unit UnitFrameProjInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.Samples.Spin, Vcl.StdCtrls, JvExControls, JvLabel, NxEdit,
  UnitProjectBaseClass2;

type
  THiMECSProjInfoFrame = class(TFrame)
    JvLabel1: TJvLabel;
    JvLabel3: TJvLabel;
    JvLabel7: TJvLabel;
    JvLabel8: TJvLabel;
    JvLabel9: TJvLabel;
    JvLabel10: TJvLabel;
    JvLabel11: TJvLabel;
    JvLabel12: TJvLabel;
    JvLabel13: TJvLabel;
    JvLabel14: TJvLabel;
    JvLabel15: TJvLabel;
    JvLabel16: TJvLabel;
    JvLabel17: TJvLabel;
    JvLabel18: TJvLabel;
    JvLabel19: TJvLabel;
    JvLabel20: TJvLabel;
    JvLabel22: TJvLabel;
    JvLabel23: TJvLabel;
    JvLabel24: TJvLabel;
    JvLabel25: TJvLabel;
    JvLabel21: TJvLabel;
    ProjNametEdit: TNxButtonEdit;
    ProjNoEdit: TNxButtonEdit;
    ProjSeqNoEdit: TEdit;
    SiteNameEdit: TNxButtonEdit;
    SiteNoEdit: TNxButtonEdit;
    PlandNameEdit: TNxButtonEdit;
    PlantNoEdit: TNxButtonEdit;
    ShipNameEdit: TNxButtonEdit;
    ShipNoEdit: TNxButtonEdit;
    EquipCountEdit: TSpinEdit;
    AssyFacEdit: TNxButtonEdit;
    TestFacEdit: TNxButtonEdit;
    SJRDeptEdit: TNxButtonEdit;
    SADeptEdit: TNxButtonEdit;
    JJRDeptEdit: TNxButtonEdit;
    ShipOwnerEdit: TNxButtonEdit;
    ClassNameEdit: TNxButtonEdit;
    AssyStartDatePicker: TDateTimePicker;
    InternalTestDatePicker: TDateTimePicker;
    FATDatePicker: TDateTimePicker;
    DeliveryDatePicker: TDateTimePicker;
  private
    { Private declarations }
  public
    procedure LoadProjInfo2Form(AProjInfo: TVesselInfo);
    procedure LoadProjInfo2Object(AProjInfo: TVesselInfo);
  end;

implementation

{$R *.dfm}

{ THiMECSProjInfoFrame }

procedure THiMECSProjInfoFrame.LoadProjInfo2Form(
  AProjInfo: TVesselInfo);
begin
  with AProjInfo do
  begin
    ProjNametEdit.Text := ProjectName;
    ProjNoEdit.Text := ProjectNo;
    ProjSeqNoEdit.Text := ProjectSeqNo;
    SiteNameEdit.Text := SiteName;
    SiteNoEdit.Text := SiteNo;
    PlandNameEdit.Text := PlantName;
    PlantNoEdit.Text := PlantNo;
    ShipNameEdit.Text := ShipName;
    ShipNoEdit.Text := ShipNo;
    EquipCountEdit.Value := StrToInt(EquipCount);
    AssyFacEdit.Text := AssyFactory;
    TestFacEdit.Text := TestFactory;
    SJRDeptEdit.Text := SJDept;
    SADeptEdit.Text := SWDept;
    JJRDeptEdit.Text := JJDept;
    ShipOwnerEdit.Text := ShipOwner;
    ClassNameEdit.Text := ClassSociety;
    AssyStartDatePicker.Date := AssyStartDate;
    InternalTestDatePicker.Date := InternalTestDate;
    FATDatePicker.Date := FATDate;
    DeliveryDatePicker.Date := DeliveryDate;
  end;
end;

procedure THiMECSProjInfoFrame.LoadProjInfo2Object(AProjInfo: TVesselInfo);
begin
  with AProjInfo do
  begin
    ProjectName := ProjNametEdit.Text;
    ProjectNo := ProjNoEdit.Text;
    ProjectSeqNo := ProjSeqNoEdit.Text;
    SiteName := SiteNameEdit.Text;
    SiteNo := SiteNoEdit.Text;
    PlantName := PlandNameEdit.Text;
    PlantNo := PlantNoEdit.Text;
    ShipName := ShipNameEdit.Text;
    ShipNo := ShipNoEdit.Text;
    EquipCount := IntToStr(EquipCountEdit.Value);
    AssyFactory := AssyFacEdit.Text;
    TestFactory := TestFacEdit.Text;
    SJDept := SJRDeptEdit.Text;
    SWDept := SADeptEdit.Text;
    JJDept := JJRDeptEdit.Text;
    ShipOwner := ShipOwnerEdit.Text;
    ClassSociety := ClassNameEdit.Text;
    AssyStartDate := AssyStartDatePicker.Date;
    InternalTestDate := InternalTestDatePicker.Date;
    FATDate := FATDatePicker.Date;
    DeliveryDate := DeliveryDatePicker.Date;
  end;
end;

end.
