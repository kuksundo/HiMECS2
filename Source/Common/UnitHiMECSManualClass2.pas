unit UnitHiMECSManualClass2;

interface

uses System.SysUtils, Classes, Vcl.ComCtrls, Generics.Legacy, JHP.BaseConfigCollect,
  mormot.core.base, mormot.core.variants, mormot.rest.sqlite3, mormot.orm.core, mormot.rest.Client,
  HiMECSConst, UnitHiMECSManualRecord2, UnitEngineMasterData;

type
  TManualItemKind = (mikNull, mikOpManual, mikMaintenance, mikDrawings, mikSvcLetter, mikFinal);

  THiMECSOpManualItem = class(TCollectionItem)
  public
    procedure Assign(Source: TPersistent); override;
{$I HiMECSManual.inc}
  end;

  THiMECSOpManualCollect<T: THiMECSOpManualItem> = class(Generics.Legacy.TCollection<T>)
  private
    FManualLanguage: TManualLanguage;
  public
  published
    property ManualLanguage: TManualLanguage read FManualLanguage write FManualLanguage;
  end;

  THiMECSMaintenanceManualItem = class(THiMECSOpManualItem)
  private
  public
  published
  end;

  TMaintenanceManualCollect<T: THiMECSMaintenanceManualItem> = class(Generics.Legacy.TCollection<T>)
  private
    FManualLanguage: TManualLanguage;
  public
  published
    property ManualLanguage: TManualLanguage read FManualLanguage write FManualLanguage;
  end;

  THiMECSDrawingItem = class(THiMECSOpManualItem)
  public
    procedure Assign(Source: TPersistent); override;
//{$I HiMECSManual.inc}
  end;

  TDrawingCollect<T: THiMECSDrawingItem> = class(Generics.Legacy.TCollection<T>)
  private
    FDrawingLanguage: TManualLanguage;
  public
  published
    property DrawingLanguage: TManualLanguage read FDrawingLanguage write FDrawingLanguage;
  end;

  THiMECSSvcLetterItem = class(THiMECSOpManualItem)
  private
  public
  published
  end;

  TSvcLetterCollect<T: THiMECSSvcLetterItem> = class(Generics.Legacy.TCollection<T>)
  private
    FServiceLetterLanguage: TManualLanguage;
  public
  published
    property ServiceLetterLanguage: TManualLanguage read FServiceLetterLanguage write FServiceLetterLanguage;
  end;

  THiMECSManualInfo = class(TpjhBase)
  private
    FOpManualCollect: THiMECSOpManualCollect<THiMECSOpManualItem>;
    FDrawingCollect: TDrawingCollect<THiMECSDrawingItem>;
    FSvcLetterCollect: TSvcLetterCollect<THiMECSSvcLetterItem>;
    FMaintenanceManualCollect: TMaintenanceManualCollect<THiMECSMaintenanceManualItem>;
    //ConfigJSONClass�� �̿��Ͽ� ȯ�漳�� ���� ���� �ÿ� ���� CollectItem Index�� �����ϱ� ����
    FConfigItemIndex:integer;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(ASource: THiMECSManualInfo);

    function LoadFromSqliteFile(ADBFileName: string): integer;//; AEngParamKind: TEngParamListItemKind
    function SaveToSqliteFile(ADBFileName: string; AItemIndex: integer=-1): integer;
    function LoadFromJSONArray(AJsonArray: RawUTF8; AIsAdd: Boolean=False): integer;
    procedure SetDescFromSecNo(const AFileName, ASecNo: string;
      AHiMECSOpManualItem: THiMECSOpManualItem);
    procedure SetDescFromDrawNo(const AFileName, ADrawNo: string;
      AHiMECSOpManualItem: THiMECSOpManualItem);
    procedure SetDescFromFileName(const ADBFileName, ADrawFileName: string;
      AHiMECSOpManualItem: THiMECSOpManualItem);
    procedure SetRelFilePathBothOpmanualNDrawings(const AEngType: string);
    procedure AssignDesc2ManualItemFromRecord(AHiMECSOpManualItem: THiMECSOpManualItem;
      AHiMECSManualRecord: THiMECSManualRecord);

    procedure ManualInfo2ListView(AListView: TListView);
    procedure AddManualItem2ListView(AManualItem: THiMECSOpManualItem; AListView: TListView);
    procedure DrawingInfo2ListView(AListView: TListView);
    procedure AddDrawItem2ListView(ADrawItem: THiMECSDrawingItem; AListView: TListView);
    procedure SvcLetterInfo2ListView(AListView: TListView);
    procedure AddSvcLetterItem2ListView(ASvcLetterItem: THiMECSSvcLetterItem; AListView: TListView);

    property ConfigItemIndex: integer read FConfigItemIndex write FConfigItemIndex;
  published
    property OpManual: THiMECSOpManualCollect<THiMECSOpManualItem> read FOpManualCollect write FOpManualCollect;
    property Drawings: TDrawingCollect<THiMECSDrawingItem> read FDrawingCollect write FDrawingCollect;
    property SvcLetter: TSvcLetterCollect<THiMECSSvcLetterItem> read FSvcLetterCollect write FSvcLetterCollect;
    property MaintenanceManual: TMaintenanceManualCollect<THiMECSMaintenanceManualItem> read FMaintenanceManualCollect write FMaintenanceManualCollect;
  end;

implementation

uses UnitRttiUtil2;

{ THiMECSManualInfo }

procedure THiMECSManualInfo.AddDrawItem2ListView(ADrawItem: THiMECSDrawingItem;
  AListView: TListView);
var
  LListItem: TListItem;
begin
  AListView.Items.BeginUpdate;
  try
    LListItem:= AListView.Items.Add;
    LListItem.Data := ADrawItem;
    LListItem.Caption:= ADrawItem.FileName;
    LListItem.SubItems.Add(ADrawItem.SectionNo);
    LListItem.SubItems.Add(ADrawItem.RevNo);
    LListItem.SubItems.Add(ADrawItem.Category_No);
    LListItem.SubItems.Add(ADrawItem.SystemDesc_Eng);
    LListItem.SubItems.Add(ADrawItem.SystemDesc_Kor);
    LListItem.SubItems.Add(ADrawItem.PartDesc_Eng);
    LListItem.SubItems.Add(ADrawItem.PartDesc_Kor);
    LListItem.SubItems.Add(ADrawItem.FilePath);
    LListItem.SubItems.Add(ADrawItem.RelFilePath);
    LListItem.SubItems.Add(ADrawItem.DrawNumber);
    LListItem.MakeVisible(False);
  finally
    AListView.Items.EndUpdate;
  end;
end;

procedure THiMECSManualInfo.AddManualItem2ListView(
  AManualItem: THiMECSOpManualItem; AListView: TListView);
var
  LListItem: TListItem;
begin
  AListView.Items.BeginUpdate;
  try
    LListItem:= AListView.Items.Add;
    LListItem.Data := AManualItem;
    LListItem.Caption:= AManualItem.FileName;
    LListItem.SubItems.Add(AManualItem.SectionNo);
    LListItem.SubItems.Add(AManualItem.RevNo);
    LListItem.SubItems.Add(AManualItem.Category_No);
    LListItem.SubItems.Add(AManualItem.SystemDesc_Eng);
    LListItem.SubItems.Add(AManualItem.SystemDesc_Kor);
    LListItem.SubItems.Add(AManualItem.PartDesc_Eng);
    LListItem.SubItems.Add(AManualItem.PartDesc_Kor);
    LListItem.SubItems.Add(AManualItem.FilePath);
    LListItem.SubItems.Add(AManualItem.RelFilePath);
    LListItem.MakeVisible(False);
  finally
    AListView.Items.EndUpdate;
  end;
end;

procedure THiMECSManualInfo.AddSvcLetterItem2ListView(
  ASvcLetterItem: THiMECSSvcLetterItem; AListView: TListView);
var
  LListItem: TListItem;
begin
  AListView.Items.BeginUpdate;
  try
    LListItem:= AListView.Items.Add;
    LListItem.Data := ASvcLetterItem;
    LListItem.Caption:= ASvcLetterItem.FileName;
    LListItem.SubItems.Add(ASvcLetterItem.SectionNo);
    LListItem.SubItems.Add(ASvcLetterItem.RevNo);
    LListItem.SubItems.Add(ASvcLetterItem.Category_No);
    LListItem.SubItems.Add(ASvcLetterItem.SystemDesc_Eng);
    LListItem.SubItems.Add(ASvcLetterItem.SystemDesc_Kor);
    LListItem.SubItems.Add(ASvcLetterItem.PartDesc_Eng);
    LListItem.SubItems.Add(ASvcLetterItem.PartDesc_Kor);
    LListItem.SubItems.Add(ASvcLetterItem.FilePath);
    LListItem.SubItems.Add(ASvcLetterItem.RelFilePath);
    LListItem.SubItems.Add(ASvcLetterItem.DrawNumber);
    LListItem.MakeVisible(False);
  finally
    AListView.Items.EndUpdate;
  end;
end;

procedure THiMECSManualInfo.Assign(ASource: THiMECSManualInfo);
var
  i: integer;
begin
//  if ASource is THiMECSManualInfo then
//  begin
    if Assigned(OpManual) then
      OpManual.Clear;

    for i := 0 to THiMECSManualInfo(ASource).OpManual.Count - 1 do
      with OpManual.Add do
        Assign(THiMECSManualInfo(ASource).OpManual.Items[i]);
//  end;
end;

procedure THiMECSManualInfo.AssignDesc2ManualItemFromRecord(
  AHiMECSOpManualItem: THiMECSOpManualItem;
  AHiMECSManualRecord: THiMECSManualRecord);
begin
  if AHiMECSManualRecord.IsUpdate then
  begin
    AHiMECSOpManualItem.SystemDesc_Eng := AHiMECSManualRecord.SystemDesc_Eng;
    AHiMECSOpManualItem.SystemDesc_Kor := AHiMECSManualRecord.SystemDesc_Kor;
    AHiMECSOpManualItem.PartDesc_Eng := AHiMECSManualRecord.PartDesc_Eng;
    AHiMECSOpManualItem.PartDesc_Kor := AHiMECSManualRecord.PartDesc_Kor;
  end;
end;

procedure THiMECSManualInfo.Clear;
begin

end;

constructor THiMECSManualInfo.Create(AOwner: TComponent);
begin
  FOpManualCollect := THiMECSOpManualCollect<THiMECSOpManualItem>.Create;
  FDrawingCollect := TDrawingCollect<THiMECSDrawingItem>.Create;
  FSvcLetterCollect := TSvcLetterCollect<THiMECSSvcLetterItem>.Create;
  FMaintenanceManualCollect := TMaintenanceManualCollect<THiMECSMaintenanceManualItem>.Create;
end;

destructor THiMECSManualInfo.Destroy;
begin
  inherited;

  FSvcLetterCollect.Free;
  FMaintenanceManualCollect.Free;
  FDrawingCollect.Free;
  FOpManualCollect.Free;
end;

procedure THiMECSManualInfo.DrawingInfo2ListView(AListView: TListView);
var
  LListItem: TListItem;
  i: integer;
begin
  for i := 0 to Drawings.Count - 1 do
    AddDrawItem2ListView(Drawings.Items[i], AListView);
end;

function THiMECSManualInfo.LoadFromJSONArray(AJsonArray: RawUTF8;
  AIsAdd: Boolean): integer;
var
  LItem: TObject;
  LDocData: TDocVariantData;
  LVar: variant;
  LStr: string;
  i, LRow: integer;
begin
  //AJsonArray = [] ������ Engine Parameter List��
  LDocData.InitJSON(AJsonArray);
  try
    if Assigned(OpManual) then
    begin
      if not AIsAdd then
        OpManual.Clear;

      for i := 0 to LDocData.Count - 1 do
      begin
        LVar := _JSON(LDocData.Value[i]);
        LStr := LVar.Category_No;

        if LStr = '' then
        begin
//          ShowMessage('Category_No field is null');
          exit;
        end
        else if LStr = 'OM' then
          LItem := TObject(OpManual.Add)
        else if LStr = 'DR' then
          LItem := TObject(Drawings.Add);

        LoadRecordPropertyFromVariant(LItem, LVar);
      end;
    end;
  finally
    Result := LDocData.Count;
  end;
end;

function THiMECSManualInfo.LoadFromSqliteFile(ADBFileName: string): integer;
var
  LSQLRestClientURI: TRestClientURI;
  LHiMECSManualModel: TSQLModel;
  LUtf8: RawUtf8;
begin
  LSQLRestClientURI := InitHiMECSManualClient2(ADBFileName, LHiMECSManualModel);
  try
    LUtf8 := GetHiMECSManualList2JSONArrayFromProductModel(LSQLRestClientURI);//(stParam)
    LoadFromJSONArray(LUtf8);
  finally
    LHiMECSManualModel.Free;
    LSQLRestClientURI.Free;
  end;
end;

procedure THiMECSManualInfo.ManualInfo2ListView(AListView: TListView);
var
  LListItem: TListItem;
  i: integer;
begin
  for i := 0 to OpManual.Count - 1 do
    AddManualItem2ListView(OpManual.Items[i], AListView);
end;

function THiMECSManualInfo.SaveToSqliteFile(ADBFileName: string; AItemIndex: integer): integer;
var
  LUtf8: RawUTF8;
  LDoc: variant;
  i: integer;
  LSQLRestClientURI: TRestClientURI;
  LHiMECSManualModel: TSQLModel;
begin
//  if Not FileExists(AFileName) then
//    exit;

  TDocVariant.New(LDoc);
  LSQLRestClientURI := InitHiMECSManualClient2(ADBFileName, LHiMECSManualModel);
  try
    for i := 0 to OpManual.Count - 1 do
    begin
      LoadRecordPropertyToVariant(OpManual.Items[i], LDoc);
      AddOrUpdateHiMECSManualFromVariant(LDoc, False, LSQLRestClientURI);
    end;

    for i := 0 to Drawings.Count - 1 do
    begin
      LoadRecordPropertyToVariant(Drawings.Items[i], LDoc);
      AddOrUpdateHiMECSManualFromVariant(LDoc, False, LSQLRestClientURI);
    end;

    for i := 0 to SvcLetter.Count - 1 do
    begin
      LoadRecordPropertyToVariant(SvcLetter.Items[i], LDoc);
      AddOrUpdateHiMECSManualFromVariant(LDoc, False, LSQLRestClientURI);
    end;

    for i := 0 to MaintenanceManual.Count - 1 do
    begin
      LoadRecordPropertyToVariant(MaintenanceManual.Items[i], LDoc);
      AddOrUpdateHiMECSManualFromVariant(LDoc, False, LSQLRestClientURI);
    end;

  finally
    LHiMECSManualModel.Free;
    LSQLRestClientURI.Free;
  end;
end;

procedure THiMECSManualInfo.SetDescFromDrawNo(const AFileName, ADrawNo: string;
  AHiMECSOpManualItem: THiMECSOpManualItem);
var
  LHiMECSManualRecord: THiMECSManualRecord;
begin
  InitHiMECSManualClient(AFileName);
  LHiMECSManualRecord := GetHiMECSManualFromDrawNo(ADrawNo);
  try
    AssignDesc2ManualItemFromRecord(AHiMECSOpManualItem, LHiMECSManualRecord);
  finally
    LHiMECSManualRecord.Free;
  end;
end;

procedure THiMECSManualInfo.SetDescFromFileName(const ADBFileName,
  ADrawFileName: string; AHiMECSOpManualItem: THiMECSOpManualItem);
var
  LHiMECSManualRecord: THiMECSManualRecord;
begin
  InitHiMECSManualClient(ADBFileName);
  LHiMECSManualRecord := GetHiMECSManualFromFileName(ADrawFileName);

  try
    AssignDesc2ManualItemFromRecord(AHiMECSOpManualItem, LHiMECSManualRecord);
  finally
    LHiMECSManualRecord.Free;
  end;
end;

procedure THiMECSManualInfo.SetDescFromSecNo(const AFileName, ASecNo: string;
  AHiMECSOpManualItem: THiMECSOpManualItem);
var
  LHiMECSManualRecord: THiMECSManualRecord;
begin
  InitHiMECSManualClient(AFileName);
  LHiMECSManualRecord := GetHiMECSManualFromSectionNo(ASecNo);

  try
    AssignDesc2ManualItemFromRecord(AHiMECSOpManualItem, LHiMECSManualRecord);
  finally
    LHiMECSManualRecord.Free;
  end;
end;

procedure THiMECSManualInfo.SetRelFilePathBothOpmanualNDrawings(const AEngType: string);
var
  i: integer;
  LManualItem: THiMECSOpManualItem;
  LDrawingItem: THiMECSDrawingItem;
  LSvcLetterItem: THiMECSSvcLetterItem;
  LMaintenanceItem: THiMECSMaintenanceManualItem;
begin
  for i := 0 to FOpManualCollect.Count - 1 do
  begin
    LManualItem := FOpManualCollect.Items[i];
    LManualItem.RelFilePath := AEngType;
  end;

  for i := 0 to FDrawingCollect.Count - 1 do
  begin
    LDrawingItem := FDrawingCollect.Items[i];
    LDrawingItem.RelFilePath := AEngType;
  end;

  for i := 0 to FSvcLetterCollect.Count - 1 do
  begin
    LSvcLetterItem := FSvcLetterCollect.Items[i];
    LSvcLetterItem.RelFilePath := AEngType;
  end;

  for i := 0 to FMaintenanceManualCollect.Count - 1 do
  begin
    LMaintenanceItem := FMaintenanceManualCollect.Items[i];
    LMaintenanceItem.RelFilePath := AEngType;
  end;
end;

procedure THiMECSManualInfo.SvcLetterInfo2ListView(AListView: TListView);
var
  LListItem: TListItem;
  i: integer;
begin
  for i := 0 to FSvcLetterCollect.Count - 1 do
    AddSvcLetterItem2ListView(FSvcLetterCollect.Items[i], AListView);
end;

{HiMECSOpManualItem }

procedure THiMECSOpManualItem.Assign(Source: TPersistent);
begin
{$I AssignHiMECSManualItem.inc}
end;

{ THiMECSDrawingItem }

procedure THiMECSDrawingItem.Assign(Source: TPersistent);
begin
{$I AssignHiMECSManualItem.inc}
end;

end.
