unit FrmTestAvatSnapShot;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Menus,
  mormot.core.zip, mormot.core.variants, mormot.core.data, mormot.core.base, mormot.core.json,
  UnitEngineParamRecord2, UnitSnapShotFrame2;

type
  TTestAvatSSF = class(TForm)
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    ListView1: TListView;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    OpenDialog2: TOpenDialog;
    PopupMenu1: TPopupMenu;
    LoadParameterFromDB1: TMenuItem;
    Clear1: TMenuItem;
    SShotFrame1: TSnapShotFrame2;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure LoadParameterFromDB1Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ProcessValueInformations(const AFileName: string);
    procedure ProcessValueInformations2(const AFileName: string);
    procedure ProcessValueMonitorings(const AFileName: string);
    procedure ProcessValueStates(const AFileName: string);
    procedure PlcInformation(const AFileName: string);
    procedure DiscreteValueList(const AFileName: string);
    procedure HistoryConfigurations(const AFileName: string);
    procedure UITextPool(const AFileName: string);
  end;

var
  TestAvatSSF: TTestAvatSSF;

implementation

{$R *.dfm}

uses UnitSynZip2, System.Zip, UnitStringUtil, UnitE2SRecord2, FrmAvatParamView2,
  UnitArrayUtil;

procedure TTestAvatSSF.Button10Click(Sender: TObject);
//type
//  TMyvalue = packed record
//    characteristicMapValue: TE2ScharacteristicMapValue;//variant;//TE2Svalues;
//  end;
//  TMyvalues = array of TMyvalue;
//const
//  JsonValues = '[{"values":[1,2,3]}]';
var
  LArrDoc: TDocVariantData;
//  MyVal: TMyvalues;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
//  LArrDoc.InitJSONFromFile(OpenDialog1.FileName);
//  LUtf8 := LArrDoc.ToJSON();
//  LDynArr.Init(TypeInfo(TMyvalues), MyVal);
//  LDynArr.LoadFromJSON(PUTF8Char(JsonValues), @JSON_[mFast]);
//  Memo1.Lines.Add(RecordSaveJson(MyVal[0], TypeInfo(TMyvalue)));
//  Memo1.Lines.Add(TpjhArray<double>.GetAsString(MyVal[0].characteristicMapValue));
end;

procedure TTestAvatSSF.Button11Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    UITextPool(OpenDialog1.FileName);
  end;
end;

procedure TTestAvatSSF.Button1Click(Sender: TObject);
var
  Zip: TZipFile;
  i: Integer;
  LZipStream: TFileStream;
  LInfoStream, LStateStream: TStream;
  LocalHeader: TZipHeader;
begin
  if OpenDialog1.Execute then
  begin
    LInfoStream := nil;
    LStateStream := nil;

    LZipStream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
    try
      Zip := TZipFile.Create;
      try
        Zip.Open(LZipStream, zmRead);

        for i := 0 to Zip.FileCount - 1 do
        begin
          if Pos('process-value-informations', Zip.FileNames[i]) > 0 then
            Zip.Read(i, TStream(LInfoStream), LocalHeader)
          else
          if Pos('process-value-states', Zip.FileNames[i]) > 0 then
            Zip.Read(i, TStream(LStateStream), LocalHeader);
//          Memo1.Lines.Add(Zip.FileNames[i] + ':'#9 + Zip.FileComment[i]);
        end;

        if Assigned(LInfoStream) and Assigned(LStateStream) then
          CreateAvatParamView(LInfoStream, LStateStream);
//          CreateAvatParamView(LInfoStream, LStateStream);
      finally
        Zip.Free;
      end;

//      UnZipUsingSynZip(OpenDialog1.FileName);
    finally
      LInfoStream.Free;
      LStateStream.Free;
      LZipStream.Free;
    end;
  end;
end;

procedure TTestAvatSSF.Button2Click(Sender: TObject);
var
  i: integer;
  iZipFile: TZipFile;
  iFilename: string;
  iDateTime: TDateTime;
  iCompressedSize: cardinal;
  iUnCompressedSize: cardinal;
  iCRC32: cardinal;
  iCompressionMethod: word;
  iFileComment: string;
  iListItem: TlistItem;
begin
  if OpenDialog1.Execute then
  begin
    if FileExists(OpenDialog1.FileName) then
    begin
      iZipFile := TZipFile.Create;
      try
        ListView1.Items.Clear;
        try
          { Open zip file for reading }
          iZipFile.Open(OpenDialog1.FileName, zmReadWrite);
          for i := 0 to iZipFile.FileCount - 1 do
          begin
            iFilename := iZipFile.FileNames[i];
            iListItem := ListView1.Items.Add;
            iListItem.Caption := iFilename;
            iDateTime := FileDateToDateTime
              (iZipFile.FileInfo[i].ModifiedDateTime);
            iListItem.SubItems.Add(DateTimeToStr(iDateTime)); { 0 }
            iCompressedSize := iZipFile.FileInfo[i].CompressedSize;
            iListItem.SubItems.Add(FormatByteString(iCompressedSize)); { 1 }
            iUnCompressedSize := iZipFile.FileInfo[i].UncompressedSize;
            iListItem.SubItems.Add(FormatByteString(iUnCompressedSize)); { 2 }
            iCRC32 := iZipFile.FileInfo[i].CRC32;
            iListItem.SubItems.Add(IntToStr(iCRC32)); { 3 }
            iCompressionMethod := iZipFile.FileInfo[i].CompressionMethod;
//            iListItem.SubItems.Add
//              (ZipCompressionToStr(iCompressionMethod)); { 4 }
            iFileComment := iZipFile.FileComment[i];
            iListItem.SubItems.Add(iFileComment); { 5 }
          end;
          { Close the zip file }
          iZipFile.Close;
        except
          on E: Exception do
          begin
            ShowMessage(E.ClassName + #10#13 + E.Message);
          end;
        end;
      finally
        iZipFile.Free;
      end;
    end;
  end;
end;

procedure TTestAvatSSF.Button3Click(Sender: TObject);
begin
//  if (OpenDialog1.Execute) and (OpenDialog2.Execute) then
  if (OpenDialog1.Execute) then
  begin
    ProcessValueInformations(OpenDialog1.FileName);
//    CreateAvatParamView(OpenDialog1.FileName, OpenDialog2.FileName);
  end;
end;

procedure TTestAvatSSF.Button4Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    ProcessValueMonitorings(OpenDialog1.FileName);
  end;
end;

procedure TTestAvatSSF.Button5Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    ProcessValueStates(OpenDialog1.FileName);
  end;
end;

procedure TTestAvatSSF.Button6Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    PlcInformation(OpenDialog1.FileName);
  end;
end;

procedure TTestAvatSSF.Button7Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    DiscreteValueList(OpenDialog1.FileName);
  end;
end;

procedure TTestAvatSSF.Button8Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    HistoryConfigurations(OpenDialog1.FileName);
  end;
end;

procedure TTestAvatSSF.Button9Click(Sender: TObject);
begin
  Memo1.Clear;
end;

procedure TTestAvatSSF.Clear1Click(Sender: TObject);
begin
  SShotFrame1.SnapShotCheckTV.Items.Clear;
end;

procedure TTestAvatSSF.DiscreteValueList(const AFileName: string);
var
  LDoc, LDoc2: TDocVariantData;
  LArrDoc: variant;
  i, j: integer;
  LE2SdiscreteValue: TE2SdiscreteValue;
  LE2SdiscreteValueA: TE2SdiscreteValueA;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  LDoc.InitJSONFromFile(AFileName);
  LUtf8 := LDoc.ToJSON();
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', [rfReplaceAll]);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', [rfReplaceAll]);
  LDoc2.InitJSON(LUtf8);

  for i := 0 to LDoc2.Count-1 do
  begin
    if _Safe(LDoc2.Values[i]).Kind = dvArray then
    begin
      LArrDoc := LDoc2.Values[i];
      break;
    end;
  end;

  LUtf8 := LArrDoc;
  LDoc.InitJSON(LUtf8);
  LDynArr.Init(TypeInfo(TE2SdiscreteValuesA), LE2SdiscreteValueA);

  for i := 0 to LDoc.Count - 1 do
  begin
    LArrDoc := LDoc.Values[i];
    LUtf8 := LArrDoc;
    LDynArr.LoadFromJSON(PUTF8Char(LUtf8));

    for j := 0 to LDynArr.Count - 1 do
    begin
      LE2SdiscreteValue := LE2SdiscreteValueA[j];
      Memo1.Lines.Add(RecordSaveJson(LE2SdiscreteValue, TypeInfo(TE2SdiscreteValue)));
    end;
  end;
end;

procedure TTestAvatSSF.HistoryConfigurations(const AFileName: string);
var
  LDoc, LDoc2: TDocVariantData;
  LArrDoc: variant;
  i, LCount: integer;
  LE2ShistoryConfigurations: TE2ShistoryConfigurations;
  LE2ShistoryConfigurationsA: TE2ShistoryConfigurationsA;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  LDoc.InitJSONFromFile(AFileName);
  LUtf8 := LDoc.ToJSON();
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', [rfReplaceAll]);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', [rfReplaceAll]);

  LDoc2.InitJSON(LUtf8);

  for i := 0 to LDoc2.Count-1 do
  begin
    if _Safe(LDoc2.Values[i]).Kind = dvArray then
    begin
      LArrDoc := LDoc2.Values[i];
      break;
    end;
  end;

  LUtf8 := LArrDoc;
  LDynArr.Init(TypeInfo(TE2ShistoryConfigurationsA), LE2ShistoryConfigurationsA);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));

  for i := 0 to LDynArr.Count - 1 do
  begin
    LE2ShistoryConfigurations := LE2ShistoryConfigurationsA[i];
    Memo1.Lines.Add(RecordSaveJson(LE2ShistoryConfigurations, TypeInfo(TE2ShistoryConfigurations)));
  end;
end;

procedure TTestAvatSSF.LoadParameterFromDB1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    SShotFrame1.LoadSnapShotParamFromDB(OpenDialog1.FileName);
end;

procedure TTestAvatSSF.PlcInformation(const AFileName: string);
var
  LDoc, LDoc2: TDocVariantData;
  LUtf8: RawUTF8;
  LE2S_PLCInfo: TE2S_PLCInfo;
begin
  LDoc.InitJSONFromFile(AFileName);
  LUtf8 := LDoc.ToJSON();
  //@type을 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@type', 'Atype', [rfReplaceAll]);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', [rfReplaceAll]);
  LDoc2.InitJSON(LUtf8);
  RecordLoadJson(LE2S_PLCInfo, LUtf8, TypeInfo(TE2S_PLCInfo));
  Memo1.Lines.Add(RecordSaveJson(LE2S_PLCInfo, TypeInfo(TE2S_PLCInfo)));
end;

procedure TTestAvatSSF.ProcessValueInformations(const AFileName: string);
var
  LDoc, LDoc2: TDocVariantData;
  LArrDoc: variant;
  i, LCount: integer;
  LE2SValueInformations: TE2SValueInformations;
  LESValueInformationsA: TE2SValueInformationsA;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  LDoc.InitJSONFromFile(AFileName);
  LUtf8 := LDoc.ToJSON();
  //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
  LUtf8 := StringReplace(LUtf8, 'unit', 'Funit', [rfReplaceAll]);
  //@type을 Attt로 대체 해야 함(아래의 Replace시 @type이 변경 되는 것 방지)
  LUtf8 := StringReplace(LUtf8, '@type', 'Attt', [rfReplaceAll]);
  //type을 Ftype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, 'type', 'Ftype', [rfReplaceAll]);
  //Attt를 Atype로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, 'Attt', 'Atype', [rfReplaceAll]);
  //@version의 @를 ''로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@version', 'version', [rfReplaceAll]);
  //@subtype의 @를 F로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@subFtype', 'Fsubtype', [rfReplaceAll]);

  LDoc2.InitJSON(LUtf8);

  for i := 0 to LDoc2.Count-1 do
  begin
    if _Safe(LDoc2.Values[i]).Kind = dvArray then
    begin
      LArrDoc := LDoc2.Values[i];
//      break;
    end
    else
    begin
      Memo1.Lines.Add(LDoc2.Names[i] + '=' + LDoc2.Values[i]);
    end;
  end;

  LUtf8 := LArrDoc;
  LDynArr.Init(TypeInfo(TE2SValueInformationsA), LESValueInformationsA);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));

  for i := 0 to LDynArr.Count - 1 do
  begin
    LE2SValueInformations := LESValueInformationsA[i];
    Memo1.Lines.Add(RecordSaveJson(LE2SValueInformations, TypeInfo(TE2SValueInformations)));
  end;
end;

procedure TTestAvatSSF.ProcessValueInformations2(const AFileName: string);
var
  LDoc, LArrDoc: TDocVariantData;
  LArrVar, LVar, LVar2, LVar3: variant;
  i, j, k, m: integer;
  LStr, LStr2: string;
begin
  LDoc.InitJSONFromFile(AFileName);

  for i := 0 to LDoc.Count-1 do
  begin
    if _Safe(LDoc.Values[i]).Kind = dvArray then
    begin
      LArrVar := LDoc.Values[i];
      for j := 0 to DocVariantData(LArrVar)^.Count - 1 do
      begin
        LStr := '';
        LVar := _Safe(LArrVar).Values[j];
//        Memo1.Lines.Add(LVar);
        for k := 0 to TDocVariantData(LVar).Count - 1 do
        begin
          if (TDocVariantData(LVar).Names[k] = 'unitId') then
          begin
              LStr := LStr + (TDocVariantData(LVar).Names[k] + ':' + DocVariantData(LVar.unitId)^.Names[0] + '=' + DocVariantData(LVar.unitId)^.Values[0]);
          end
          else
          if (TDocVariantData(LVar).Names[k] = 'unit')  then
          begin
            LStr := LStr +(TDocVariantData(LVar).Names[k] + ':' + DocVariantData(LVar.unit)^.Names[0] + '=' + DocVariantData(LVar.unit)^.Values[0]);
          end
          else
          if (TDocVariantData(LVar).Names[k] = 'decimals')  then
          begin
            LStr := LStr +(TDocVariantData(LVar).Names[k] + ':' + IntToStr(LVar.decimals));
          end
          else
          if (TDocVariantData(LVar).Names[k] = 'xAxisEntry')  then
          begin//{"descriptor":"202","displayName":"E300.2 Actual power","unit":{"symbol":"%"},"decimals":1}
            LVar2 := _Safe(LVar)^.Values[k];

            for m := 0 to _Safe(LVar2)^.Count - 1 do
            begin
              if _Safe(LVar.xAxisEntry)^.Names[m] = 'unit' then
              begin
                LStr := LStr + _Safe(LVar.xAxisEntry.unit)^.Names[0] + '=' + _Safe(LVar.xAxisEntry.unit)^.Values[0];
              end
              else
              if _Safe(LVar.xAxisEntry)^.Names[m] = 'decimals' then
              begin
                LStr := LStr + IntToStr(LVar.xAxisEntry.decimals);
              end
              else
                LStr := LStr + _Safe(LVar.xAxisEntry)^.Names[m] + '=' + _Safe(LVar.xAxisEntry)^.Values[m];
            end;
          end
          else
          if (TDocVariantData(LVar).Names[k] = 'yAxisEntry')  then
          begin //{"descriptor":"202","displayName":"E300.2 Actual power","unit":{"symbol":"%"},"decimals":1}
            LVar2 := _Safe(LVar)^.Values[k];

            for m := 0 to _Safe(LVar2)^.Count - 1 do
            begin
              if _Safe(LVar.xAxisEntry)^.Names[m] = 'unit' then
              begin
                LStr := LStr + _Safe(LVar.xAxisEntry.unit)^.Names[0] + '=' + _Safe(LVar.xAxisEntry.unit)^.Values[0];
              end
              else
              if _Safe(LVar.xAxisEntry)^.Names[m] = 'decimals' then
              begin
                LStr := LStr + IntToStr(LVar.xAxisEntry.decimals);
              end
              else
                LStr := LStr + _Safe(LVar.xAxisEntry)^.Names[m] + '=' + _Safe(LVar.xAxisEntry)^.Values[m];
            end;
          end
          else
          if (TDocVariantData(LVar).Names[k] = 'discreteValues')  then
          begin //[{"value":"off!","key":623},{"value":"on!","key":624}]
            LVar2 := _Safe(LVar)^.Values[k];

            for m := 0 to DocVariantData(LVar2)^.Count - 1 do
            begin
              LVar3 := LVar2.Value(m);
              LStr := LStr + LVar3.value + ',' + IntToStr(LVar3.key);
            end;
          end
          else
          if (TDocVariantData(LVar).Names[k] = 'renderingHints')  then
          begin
            LVar2 := _Safe(LVar)^.Values[k];

            if DocVariantData(LVar2)^.Count = 0 then //[]
              LStr := LStr +(TDocVariantData(LVar).Names[k] + ':' + TDocVariantData(LVar2).ToJSON())
            else//["formatAsDurationHMS"]
            begin
//              LStr := LStr +_Safe(LVar)^.Names[k] + ':' + VariantSaveJson(LVar2);
              for m := 0 to DocVariantData(LVar2)^.Count - 1 do
                LStr := LStr + LVar2.Value(m);
//              LStr := LStr + ']';
            end;
          end
          else
          begin
//            LStr2 := _Safe(LVar)^.Values[k];
//            if LStr2 = '6591' then
//             ShowMessage('');
            LStr := LStr +(_Safe(LVar)^.Names[k] + '=' + _Safe(LVar)^.Values[k]);
          end;
        end;
        Memo1.Lines.Add(LStr);
      end;
    end
    else
      Memo1.Lines.Add(LDoc.Names[i] + '=' + LDoc.Values[i]);// IntToStr(ord(_Safe(LDoc.Values[i]).Kind))
  end;
end;

procedure TTestAvatSSF.ProcessValueMonitorings(const AFileName: string);
var
  LArrDoc: TDocVariantData;
  i, LCount: integer;
  LE2S_ValueMonitoring: TE2S_ValueMonitoring;
  LE2S_ValueMonitoringA: TE2S_ValueMonitoringA;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  LArrDoc.InitJSONFromFile(AFileName);
  LUtf8 := LArrDoc.ToJSON();
  //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
  LUtf8 := StringReplace(LUtf8, 'unit', 'Funit', [rfReplaceAll]);
  LDynArr.Init(TypeInfo(TE2S_ValueMonitoringA), LE2S_ValueMonitoringA);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8));

  for i := 0 to LDynArr.Count - 1 do
  begin
    LE2S_ValueMonitoring := LE2S_ValueMonitoringA[i];
    Memo1.Lines.Add(RecordSaveJson(LE2S_ValueMonitoring, TypeInfo(TE2S_ValueMonitoring)));
  end;
end;

procedure TTestAvatSSF.ProcessValueStates(const AFileName: string);
var
  LArrDoc: TDocVariantData;
  i, LCount: integer;
  LE2S_ValueStates: TE2S_ValueStates;
  LE2S_ValueStatesA: TE2S_ValueStatesA;
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
begin
  LArrDoc.InitJSONFromFile(AFileName);
  LUtf8 := LArrDoc.ToJSON();
  //unit는 Reserved key이기 떄문에 실제 파일의 unit를 Funit로 변경 후 Loading 해야 함
  LUtf8 := StringReplace(LUtf8, 'unit', 'Funit', [rfReplaceAll]);
  //@subtype의 @를 F로 대체 해야 함
  LUtf8 := StringReplace(LUtf8, '@subtype', 'Fsubtype', [rfReplaceAll]);
  //descriptor=''에서 limits가 한개 더 존재(오타로 추정됨)하여 삭제함
  LUtf8 := StringReplace(LUtf8, ',"limits":null},', '},', [rfReplaceAll]);

  //min, max의 1.7976931348623157E308를 1.7976931e308로 대체 해야 함
//  LUtf8 := StringReplace(LUtf8, '1.7976931348623157E308', '1.7976931e308', [rfReplaceAll]);
  LDynArr.Init(TypeInfo(TE2S_ValueStatesA), LE2S_ValueStatesA);
  LDynArr.LoadFromJSON(PUTF8Char(LUtf8), @JSON_[mFast]);

  for i := 0 to LDynArr.Count - 1 do
  begin
    LE2S_ValueStates := LE2S_ValueStatesA[i];
    Memo1.Lines.Add(LE2S_ValueStates.descriptor);
//    Memo1.Lines.Add(RecordSaveJson(LE2S_ValueStates, TypeInfo(TE2S_ValueStates)));
  end;
end;

procedure TTestAvatSSF.UITextPool(const AFileName: string);
var
  LSnapShot4E2S: TSnapShot4E2S;
begin
  LSnapShot4E2S := TSnapShot4E2S.Create;
  try
    LSnapShot4E2S.ProcessUiTextPool(AFileName);
    Memo1.Lines.Add(LSnapShot4E2S.FUi_TextPool.entries[Length(LSnapShot4E2S.FUi_TextPool.entries)-1].defaultText);
  finally
    LSnapShot4E2S.Free;
  end;
end;

(*
a := _json('{"arr":[1,2,3],"integer":2,"isnull":null,"str":"somestring","float":3.14,"subobject":{"a":"b","c":1}}');
for I := 0 to a._count-1 do
begin
  s := a.name(i);
  Writeln('Object name: ',s,' -------------');
  b := a._(i);
  if varisnull( b)  then
    Writeln('is null')
  else
  begin
    Writeln( 'Docvariantdata: ',Tdocvariantdata ( b).VarType );
    Writeln( 'kind: ',ord(_Safe(b).Kind) );
  end;
end;


  rec.InitJSON('[{"Field1":"Value1","Field2":null,"Field3":["elem1","elem2",3]}]', JSON_OPTIONS_FAST);
  json := rec.ToNonExpandedJSON;
  t := TSQLTableJSON.Create('', json);
  t.ToDocVariant(v, False);
  json := VariantSaveJSON(v);
  rec.InitJSON(json, JSON_OPTIONS[True]);
  json := rec.ToJSON;
*)
end.
