unit FrmSimulateParamEdit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  pjhComboBox, Vcl.Samples.Spin, Vcl.ImgList, AeroButtons,
  NxColumnClasses, NxColumns, NxScrollControl, NxCustomGridControl,
  NxCustomGrid, NxGrid, GpSharedMemory,
  mormot.core.json, mormot.core.variants, mormot.core.unicode, mormot.core.base,
  mormot.core.data, mormot.core.text,
  UnitSimulateParamRecord2, UnitSimulateParamCommandLineOption2, UnitIPCClientAll2;

type
  TSimulateParamEditF = class(TForm)
    SystemNameCB: TComboBoxInc;
    ProdTypeCB: TComboBox;
    SubSystemNameCB: TComboBoxInc;
    SubjectEdit: TEdit;
    Panel1: TPanel;
    JsonParamCollectMemo: TMemo;
    CSVValuesMemo: TMemo;
    SeqNoSpinEdit: TSpinEdit;
    CourseLevelCB: TComboBox;
    ActivityLevelCB: TComboBox;
    DelsySecsEdit: TEdit;
    AeroButton1: TAeroButton;
    btn_Close: TAeroButton;
    ImageList16x16: TImageList;
    DFMTextMemo: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ModelNameCB: TComboBoxInc;
    Label14: TLabel;
    ProjectNameCB: TComboBoxInc;
    EnableCheck: TCheckBox;
    ParamGrid: TNextGrid;
    NxIndex: TNxIncrementColumn;
    ItemName: TNxTextColumn;
    Value: TNxButtonColumn;
    TagName: TNxTextColumn;
    Label15: TLabel;
    ParamSrcListEdit: TEdit;
    Button1: TButton;
    Label16: TLabel;
    CaptionEdit: TEdit;
    Label17: TLabel;
    PageIndexSpinEdit: TSpinEdit;
    DescEdit: TMemo;
    UseBalloonCheck: TCheckBox;
    Label18: TLabel;
    CommandJsonEdit: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ProdTypeCBSelect(Sender: TObject);
    procedure SystemNameCBSelect(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ModelNameCBChange(Sender: TObject);
  private
    FgpSharedMM: TGpSharedMemory;
  public
    FTargetFormHandle: integer;

    procedure FillInFormFromVariant(ADoc: Variant);
    procedure FillInParamGrid;
    function GetValueCSVFromGrid: string;
    function GetVariantFromForm: variant;
    function GetVarInputValueFromForm: variant;
    function SaveParamDetail2SimPramRecFromForm(AIPCClientAll:TIPCClientAll): integer;
    procedure SendSimulateParamData2gpShMM(ASimParamData: string);
  end;

procedure FillInModelKind(ASelectedIndex: integer; ADestCombo: TComboBox);
procedure FillInSystemKind(ASelectedProdIndex, ASelectedModelIndex: integer; ADestCombo: TComboBox);
procedure FillInSubSystemKind(ASelectedIndex, ASelectedIndex2: integer; ADestCombo: TComboBox);

function CreateOrShowParamEditFormFromDB(ASimParamSearchRec: TSimParamSearchRec;
  ASimulateParamCLO: TSimulateParamCLO2; AIPCClientAll:TIPCClientAll): integer; //AJsonParamCollect, ACSVData, AParamSrcList, AAdditionalData: string

var
  SimulateParamEditF: TSimulateParamEditF;

implementation

uses UnitVesselData2, UnitHGSCurriculumData, UnitFGSSData, UnitSCRData,
  UnitEGCSData, UnitCopyData;

{$R *.dfm}

procedure FillInModelKind(ASelectedIndex: integer; ADestCombo: TComboBox);
begin
  case TShipProductType(ASelectedIndex) of
    shptME:;
    shptGE:;
    shptCB:;
    shptTR:;
    shptGEN:;
    shptAMS:;
    shptSWBD:;
    shptMOTOR:;
    shptSCR:g_SCRModelKind.SetType2Combo(ADestCombo);
    shptBWTS:;
    shptFGSS: g_FGSSModelKind.SetType2Combo(ADestCombo);
    shptCOPT:;
    shptPROPELLER:;
    shptEGR:;
    shptVDR:;
    shptEGCS: g_EGCSModelKind.SetType2Combo(ADestCombo);
  end;
end;

procedure FillInSubSystemKind(ASelectedIndex, ASelectedIndex2: integer; ADestCombo: TComboBox);
begin
  case TShipProductType(ASelectedIndex) of
    shptME:;
    shptGE:;
    shptCB:;
    shptTR:;
    shptGEN:;
    shptAMS:;
    shptSWBD:;
    shptMOTOR:;
    shptSCR: SubSystem2Combo_SCR(ASelectedIndex, ASelectedIndex2, ADestCombo);
    shptBWTS:;
    shptFGSS:;
    shptCOPT:;
    shptPROPELLER:;
    shptEGR:;
    shptVDR:;
    shptEGCS: SubSystem2Combo_EGCS(ASelectedIndex, ASelectedIndex2, ADestCombo);
  end;
end;

procedure FillInSystemKind(ASelectedProdIndex, ASelectedModelIndex: integer; ADestCombo: TComboBox);
begin
  case TShipProductType(ASelectedProdIndex) of
    shptME:;
    shptGE:;
    shptCB:;
    shptTR:;
    shptGEN:;
    shptAMS:;
    shptSWBD:;
    shptMOTOR:;
    shptSCR:begin
      if TSCRModelKind(ASelectedModelIndex) = smkNoNoxHP_2S then
        g_SCRSystemKind_HP2S.SetType2Combo(ADestCombo)
      else
        g_SCRSystemKind.SetType2Combo(ADestCombo);
    end;
    shptBWTS:;
    shptFGSS:;
    shptCOPT:;
    shptPROPELLER:;
    shptEGR:;
    shptVDR:;
    shptEGCS: g_EGCSSystemKind.SetType2Combo(ADestCombo);
  end;
end;

{ TSimulateParamEditF }

function CreateOrShowParamEditFormFromDB(ASimParamSearchRec: TSimParamSearchRec;
  ASimulateParamCLO: TSimulateParamCLO2; AIPCClientAll:TIPCClientAll): integer; //AJsonParamCollect, ACSVData, AParamSrcList, AAdditionalData: string
var
  LSimulateParamEditF: TSimulateParamEditF;
  LSQLSimulateParamRecord: TSQLSimulateParamRecord;
  LDoc: Variant;
  LAdditioinalDataRec: TAdditioinalDataRec;
begin
  if not Assigned(g_SimulateParamDB) then
  begin
    ShowMessage('Please select the ParamDB first!');
    exit;
  end;

  LSimulateParamEditF := TSimulateParamEditF.Create(nil);
  try
    LSQLSimulateParamRecord := GetSimulateParamRecordFromSearchRec(ASimParamSearchRec);
    try
      if LSQLSimulateParamRecord.IsUpdate then
        LDoc := GetVariantFromSimulateParamRecord(LSQLSimulateParamRecord)
      else
      begin
        LDoc := LSQLSimulateParamRecord.GetSimpleFieldsAsDocVariant;
        LDoc.ProductType := Ord(ASimParamSearchRec.fProductType);
        LDoc.ModelName := ASimParamSearchRec.fModelName;
      end;
//        TDocVariant.New(LDoc);

      if (ASimulateParamCLO.JsonParamCollect <> '') and (ASimulateParamCLO.CSVValues <> '') then
      begin
        LDoc.JsonParamCollect := ASimulateParamCLO.JsonParamCollect;
        LDoc.CSVValues := ASimulateParamCLO.CSVValues;
        LDoc.ParamSourceList := ASimulateParamCLO.ParamSourceList;
      end;

      if ASimulateParamCLO.AdditionalData <> '' then
      begin
        RecordLoadJson(LAdditioinalDataRec, ASimulateParamCLO.AdditionalData, TypeInfo(TAdditioinalDataRec));
        LDoc.DFPageIndex := LAdditioinalDataRec.FPageIndex;
        LDoc.DFPageCaption := LAdditioinalDataRec.FCaption;
        LDoc.SimParamJsonData := LAdditioinalDataRec.FJson4SimParamEditData;
        LSimulateParamEditF.FTargetFormHandle := LAdditioinalDataRec.FFormHandle;
      end
      else
      begin
        if VarIsVoid(LDoc.DFPageIndex) then
          LDoc.DFPageIndex := -1;

        if VarIsVoid(LDoc.DFPageCaption) then
          LDoc.DFPageCaption := '';

//        if VarIsVoid(LDoc.SimParamJsonData) then
          LDoc.SimParamJsonData := '';
      end;

      if ASimulateParamCLO.SimulateCompValuesJson <> '' then
        LDoc.CommandJson := ASimulateParamCLO.SimulateCompValuesJson;

      LSimulateParamEditF.FillInFormFromVariant(LDoc);

      Result := LSimulateParamEditF.ShowModal;

      if Result = mrOK then
      begin
        LSimulateParamEditF.SaveParamDetail2SimPramRecFromForm(AIPCClientAll);
      end;

    finally
      LSQLSimulateParamRecord.Free;
    end;
  finally
    LSimulateParamEditF.Free;
  end;
end;

procedure TSimulateParamEditF.Button1Click(Sender: TObject);
begin
  CSVValuesMemo.Text := GetValueCSVFromGrid;
end;

procedure TSimulateParamEditF.FillInFormFromVariant(ADoc: Variant);
  procedure ReFillFormFromJson;
  var
    LDoc: Variant;
    LJson: string;
  begin
    LJson := ADOc.SimParamJsonData;
    LDoc := _JSON(StringToUTF8(LJson));

//    ShowMessage('LJson : ' + LJson );
    if ProdTypeCB.ItemIndex <= 0 then
      ProdTypeCB.ItemIndex := LDoc.ProductType;

    if ModelNameCB.ItemIndex <= 0 then
    begin
      FillInModelKind(ProdTypeCB.ItemIndex, TComboBox(ModelNameCB));

      if ModelNameCB.Items.Count = 0 then
        ModelNameCB.Text := LDoc.ModelName
      else
        ModelNameCB.ItemIndex := g_SCRModelKind.ToOrdinal(LDoc.ModelName);

      ModelNameCBChange(ModelNameCB);
    end;

    if SystemNameCB.Text = '' then
      SystemNameCB.Text := LDoc.SystemName;

    if SubSystemNameCB.Text = '' then
      SubSystemNameCB.Text := LDoc.SubSystemName;

    if SubjectEdit.Text = '' then
      SubjectEdit.Text := LDoc.Subject;

    if DescEdit.Text = '' then
      DescEdit.Text := LDoc.Desc;

    if ProjectNameCB.Text = '' then
      ProjectNameCB.Text := LDoc.ProjectName;

    if CommandJsonEdit.Text = '' then
      CommandJsonEdit.Text := LDoc.CommandJson;

//    if SeqNoSpinEdit.Value = -1 then
      SeqNoSpinEdit.Value := LDoc.SeqNo;
  end;
begin
  if ADoc.ProductType > -1 then
    ProdTypeCB.ItemIndex := ADoc.ProductType;


  if ADoc.ModelName <> '' then
  begin
    FillInModelKind(ProdTypeCB.ItemIndex, TComboBox(ModelNameCB));

    if ModelNameCB.Items.Count = 0 then
      ModelNameCB.Text := ADoc.ModelName
    else
      ModelNameCB.ItemIndex := g_SCRModelKind.ToOrdinal(ADoc.ModelName);

    ModelNameCBChange(ModelNameCB);
    EnableCheck.Checked := ADoc.Enable;
  end;

  ProjectNameCB.Text := ADoc.ProjectName;
  SystemNameCB.Text := ADoc.SystemName;
  SubSystemNameCB.Text := ADoc.SubSystemName;
  SubjectEdit.Text := ADoc.Subject;
  DescEdit.Text := ADoc.Desc;
  CommandJsonEdit.Text := ADoc.CommandJson;
  UseBalloonCheck.Checked := ADoc.UseBalloon;

  if ADoc.CourseLevel > -1 then
    CourseLevelCB.ItemIndex := ADoc.CourseLevel;

  if ADoc.ActivityLevel > -1 then
    ActivityLevelCB.ItemIndex := ADoc.ActivityLevel;

  SeqNoSpinEdit.Value := ADoc.SeqNo;
  DelsySecsEdit.Text := ADoc.DelaySecs;

  JsonParamCollectMemo.Text := ADoc.JsonParamCollect;
  CSVValuesMemo.Text := ADoc.CSVValues;
  DFMTextMemo.Text := ADoc.DFMText;
  ParamSrcListEdit.Text := ADOc.ParamSourceList;
  CaptionEdit.Text := ADOc.DFPageCaption;
  PageIndexSpinEdit.Value := ADOc.DFPageIndex;

  if (JsonParamCollectMemo.Text <> '') and (CSVValuesMemo.Text <> '') then
    FillInParamGrid;

//  if ADOc.SimParamJsonData <> '' then
  if not VarIsVoid(ADOc.SimParamJsonData) then
    ReFillFormFromJson;
end;

procedure TSimulateParamEditF.FillInParamGrid;
var
  LDynUtf8, LCSVDynUtf8: TRawUTF8DynArray;
  LDynArr, LCSVDynArr: TDynArray;
  LUtf8, LCSVUtf8: RawUTF8;
  i, j: integer;
  LDoc: variant;
  LDocData: TDocVariantData;
begin
  ParamGrid.BeginUpdate;
  try
    ParamGrid.ClearRows;

//    LDoc2 := _JSON(JsonParamCollectMemo.Text);
    LUtf8 := JsonParamCollectMemo.Text;//'[{"TagName":"aaaa", "Desc":"Desc1"},{"TagName":"bbbb", "Desc":"Desc2"}]';
    LDynArr.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8);
    LDynArr.LoadFromJSON(PUTF8Char(LUtf8));
    for i := 0 to LDynArr.Count - 1 do
    begin
      ParamGrid.AddRow();
      LDoc := _JSON(LDynUtf8[i]);
      ParamGrid.CellsByName['ItemName', i] := LDoc.Description;
      ParamGrid.CellsByName['TagName', i] := LDoc.TagName;
    end;

    LCSVUtf8 := CSVValuesMemo.Text;
//    LDocData.InitJSON(LCSVUtf8);
    LCSVDynArr.Init(TypeInfo(TRawUTF8DynArray), LCSVDynUtf8);

//    LVar := _JSON(LDocData.Value[i]);
//    LUtf8 := LVar.CSVValues;
    CSVToRawUTF8DynArray(PUTF8Char(LCSVUtf8),LCSVDynUtf8);

    for j := Low(LCSVDynUtf8) to High(LCSVDynUtf8) do
      ParamGrid.CellsByName['Value', j] := LCSVDynUtf8[j];

  finally
    ParamGrid.EndUpdate();
  end;
end;

procedure TSimulateParamEditF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(FgpSharedMM) then
    FreeAndNil(FgpSharedMM);
end;

procedure TSimulateParamEditF.FormCreate(Sender: TObject);
begin
  FgpSharedMM := nil;
  FTargetFormHandle := 0;

  g_ShipProductType.SetType2List(ProdTypeCB.Items);
  AcademyCourseLevel2List(CourseLevelCB.Items);
  AcademyActivityLevel2List(ActivityLevelCB.Items);
end;

function TSimulateParamEditF.GetValueCSVFromGrid: string;
var
  i: integer;
begin
  Result := '{';

  for i := 0 to ParamGrid.RowCount - 1 do
    Result := Result + ParamGrid.CellsByName['Value',i] + ',';

  Delete(Result, Length(Result), 1);
  Result := Result + '}';
end;

function TSimulateParamEditF.GetVariantFromForm: variant;
var
  LStr: string;
begin
  TDocVariant.New(Result);

  Result.ProductType := ProdTypeCB.ItemIndex;
  Result.ModelName := ModelNameCB.Text;
  Result.ProjectName := ProjectNameCB.Text;
  Result.SystemName := SystemNameCB.Text;
  Result.SubSystemName := SubSystemNameCB.Text;
  Result.Subject := SubjectEdit.Text;
  Result.Desc := DescEdit.Text;
  Result.CommandJson := CommandJsonEdit.Text;
  Result.CourseLevel := CourseLevelCB.ItemIndex;
  Result.ActivityLevel := ActivityLevelCB.ItemIndex;
  Result.SeqNo := SeqNoSpinEdit.Value;
  Result.DelaySecs := StrToIntDef(DelsySecsEdit.Text,0);
  Result.Enable := EnableCheck.Checked;
  Result.UseBalloon := UseBalloonCheck.Checked;

  Result.ParamSourceList := ParamSrcListEdit.Text;
  Result.JsonParamCollect := JsonParamCollectMemo.Text;
  LStr := CSVValuesMemo.Text;
  LStr := LStr.TrimLeft(['{']);
  LStr := LStr.TrimRight(['}']);
  Result.CSVValues := LStr;
  Result.DFMText := DFMTextMemo.Text;

  Result.DFPageCaption := CaptionEdit.Text;
  Result.DFPageIndex := PageIndexSpinEdit.Value;
end;

function TSimulateParamEditF.GetVarInputValueFromForm: variant;
begin
  TDocVariant.New(Result);

  Result.ProductType := ProdTypeCB.ItemIndex;
  Result.ModelName := ModelNameCB.Text;
  Result.ProjectName := ProjectNameCB.Text;
  Result.SystemName := SystemNameCB.Text;
  Result.SubSystemName := SubSystemNameCB.Text;
  Result.Subject := SubjectEdit.Text;
  Result.Desc := DescEdit.Text;
  Result.CommandJson := CommandJsonEdit.Text;
  Result.CourseLevel := CourseLevelCB.ItemIndex;
  Result.ActivityLevel := ActivityLevelCB.ItemIndex;
  Result.SeqNo := SeqNoSpinEdit.Value;
  Result.DelaySecs := StrToIntDef(DelsySecsEdit.Text,0);
  Result.Enable := EnableCheck.Checked;
  Result.UseBalloon := UseBalloonCheck.Checked;

  Result.ParamSourceList := ParamSrcListEdit.Text;
  Result.DFPageCaption := CaptionEdit.Text;
  Result.DFPageIndex := PageIndexSpinEdit.Value;
end;

procedure TSimulateParamEditF.ModelNameCBChange(Sender: TObject);
begin
  FillInSystemKind(ProdTypeCB.ItemIndex, ModelNameCB.ItemIndex, TComboBox(SystemNameCB));
end;

procedure TSimulateParamEditF.ProdTypeCBSelect(Sender: TObject);
begin
  FillInModelKind(ProdTypeCB.ItemIndex, TComboBox(ModelNameCB));
  FillInSystemKind(ProdTypeCB.ItemIndex, ModelNameCB.ItemIndex, TComboBox(SystemNameCB));
end;

function TSimulateParamEditF.SaveParamDetail2SimPramRecFromForm(AIPCClientAll:TIPCClientAll): integer;
var
  LDoc: Variant;
  LStr: string;
begin
  LDoc := GetVariantFromForm;
  Result := AddOrUpdateSimulateParamFromVariant(LDoc, False, nil);

  if FTargetFormHandle > 0 then
  begin
    LDoc := GetVarInputValueFromForm;
    LStr := LDoc;

    AIPCClientAll.SendData2gpSM(gp_EventName4SimAutoFillInData, LStr);
    SendCopyData4(FTargetFormHandle, '', 3);

//    SendSimulateParamData2gpShMM(LStr);
    FTargetFormHandle := -1;
  end
  else
    ShowMessage('Target Form Handle is invalid.' + #13#10 + 'So, can not send Input data to Watch2 by gpSharedMM!');

  ShowMessage('Data Save Is OK!');
end;

procedure TSimulateParamEditF.SendSimulateParamData2gpShMM(ASimParamData: string);
var
  LStrList: TStringList;
begin
  if not Assigned(FgpSharedMM) then
    FgpSharedMM := TGpSharedMemory.Create(gp_SimParam_SHARED_DATA_NAME, 0, gp_SimParam_SHARED_MAX_SIZE);

  LStrList := TStringList.Create;
  try
    LStrList.Add(IntToStr(GetCurrentProcessId));
    LStrList.Add(ASimParamData);

    if FgpSharedMM.AcquireMemory(True, INFINITE) <> nil then
    begin
      if FgpSharedMM.IsWriting then
        LStrList.SaveToStream(FgpSharedMM.AsStream);
    end;

    if FgpSharedMM.Acquired then
      FgpSharedMM.ReleaseMemory;

//Watch2에서 "Move pjhValue To Item and Save To DB" 실행 시 에러 발생하여 SendCopyData4()를 주석처리 함 (21.12.08)
//    SendCopyData4(FTargetFormHandle, '', 3);
//    FNotifySharedMMEvent.Signal;
  finally
    LStrList.Free;
  end;
end;

procedure TSimulateParamEditF.SystemNameCBSelect(Sender: TObject);
begin
  FillInSubSystemKind(ProdTypeCB.ItemIndex, SystemNameCB.ItemIndex, SubSystemNameCB);
end;

end.
