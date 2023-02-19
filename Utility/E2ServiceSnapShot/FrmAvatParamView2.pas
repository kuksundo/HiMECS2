unit FrmAvatParamView2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, NxGridView6,
  NxColumns6, NxControls6, NxCustomGrid6, NxVirtualGrid6, NxGrid6, Winapi.ActiveX,
  DragDropInternet,DropSource,DragDropFile,DragDropFormats, DragDrop, DropTarget,
  Vcl.ImgList, JvPageList,
  JvExControls, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  Vcl.Menus, JvgLabel, AdvSmoothLabel, Vcl.StdCtrls, TimerPool,
  mormot.core.text, mormot.core.variants, mormot.rest.sqlite3, mormot.orm.core,
  UnitE2SRecord2, HiMECSConst, UnitEngineParamRecord2, UnitEngineParameterClass2;

type
  TAvatParamViewF = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Splitter1: TSplitter;
    ParamGrid: TNextGrid6;
    NxReportGridView61: TNxReportGridView6;
    NxIncrementColumn61: TNxIncrementColumn6;
    Description: TNxTextColumn6;
    Value: TNxTextColumn6;
    Descriptor: TNxTextColumn6;
    DropEmptyTarget1: TDropEmptyTarget;
    DataFormatAdapterOutlook: TDataFormatAdapter;
    DataFormatAdapterTarget: TDataFormatAdapter;
    DataFormatAdapter1: TDataFormatAdapter;
    DropEmptySource1: TDropEmptySource;
    DataFormatAdapter2: TDataFormatAdapter;
    ImageList1: TImageList;
    ParameterType: TNxIconColumn6;
    ValuePageList: TJvPageList;
    MapPage: TJvStandardPage;
    AnalogPage: TJvStandardPage;
    DiscretePage: TJvStandardPage;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    MatrixGrid: TAdvStringGrid;
    PopupMenu1: TPopupMenu;
    SaveToSqlite1: TMenuItem;
    OpenDialog1: TOpenDialog;
    LoadFromFile1: TMenuItem;
    N1: TMenuItem;
    LoadFromSqlite1: TMenuItem;
    xAxisLabel: TJvgLabel;
    yAxisLabel: TJvgLabel;
    FUnit: TNxTextColumn6;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Bevel1: TBevel;
    LoadDescritionFromSqlite1: TMenuItem;
    MapDescLabel: TAdvSmoothLabel;
    UpdateSqliteFromParamNo1: TMenuItem;
    UpdateSqlite4TagName1: TMenuItem;
    SaveToTxtParamNo1: TMenuItem;
    N2: TMenuItem;
    ParamNo: TNxTextColumn6;
    SaveDialog1: TSaveDialog;
    Parameters1: TMenuItem;
    SlowTurning1: TMenuItem;
    N3: TMenuItem;
    DeleteItems1: TMenuItem;
    N4: TMenuItem;
    ClearAllItems1: TMenuItem;
    OnlyParameter1: TMenuItem;
    All1: TMenuItem;
    AnalogDescriptionLabel: TAdvSmoothLabel;
    DiscreteDescLabel: TAdvSmoothLabel;
    AddSensorDataToSqliteFromSensorDB1: TMenuItem;
    EngineStart1: TMenuItem;
    MPSystem1: TMenuItem;
    BuildUp1: TMenuItem;
    Optimization1: TMenuItem;
    Injection1: TMenuItem;
    SpeedControl1: TMenuItem;
    CBOpened1: TMenuItem;
    CBClosed1: TMenuItem;
    DVT1: TMenuItem;
    Splitter2: TSplitter;
    Panel8: TPanel;
    Splitter3: TSplitter;
    GasTrip1: TMenuItem;
    PilotTrip1: TMenuItem;
    ForUITextPool1: TMenuItem;
    ForParameterNDescriptorDB1: TMenuItem;
    DataSourceRG: TRadioGroup;
    ForParamDescBaseDB1: TMenuItem;
    ForParamofHullNoDB1: TMenuItem;
    ShowFileInfo1: TMenuItem;
    ParamInfoDBCheck: TCheckBox;
    CompareParameterFromSnapShotFile1: TMenuItem;
    N5: TMenuItem;
    ForParamDescBaseDBFromDSDofSnapshot1: TMenuItem;
    ShowNavigationList1: TMenuItem;
    LoadTestSnapshot1: TMenuItem;
    UpdateSqlite4ValueFromParamno1: TMenuItem;
    AddonlynewparamtoParamDB1: TMenuItem;
    All2: TMenuItem;
    Label1: TLabel;
    DescFilterEdit: TEdit;
    UpdateToSqlite1: TMenuItem;
    UpdateCategoryEnumFromCategory1: TMenuItem;
    AllParamNo1: TMenuItem;
    GTParamNo1: TMenuItem;
    PTParamNo1: TMenuItem;
    StartBlock1: TMenuItem;
    IsForcedAddCheck: TCheckBox;
    NewDBonlyParameter1: TMenuItem;
    New1: TMenuItem;
    Measurand4AVAT21: TMenuItem;
    Command4AVAT21: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure DropEmptyTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure LoadFromFile1Click(Sender: TObject);
    procedure LoadFromSqlite1Click(Sender: TObject);
    procedure LoadDescritionFromSqlite1Click(Sender: TObject);
    procedure UpdateSqliteFromParamNo1Click(Sender: TObject);
    procedure UpdateSqlite4TagName1Click(Sender: TObject);
    procedure SlowTurning1Click(Sender: TObject);
    procedure ClearAllItems1Click(Sender: TObject);
    procedure OnlyParameter1Click(Sender: TObject);
    procedure All1Click(Sender: TObject);
    procedure AddSensorDataToSqliteFromSensorDB1Click(Sender: TObject);
    procedure ParamGridSelect(Sender: TObject; ACol, ARow: Integer);
    procedure EngineStart1Click(Sender: TObject);
    procedure DeleteItems1Click(Sender: TObject);
    procedure BuildUp1Click(Sender: TObject);
    procedure Optimization1Click(Sender: TObject);
    procedure Injection1Click(Sender: TObject);
    procedure CBOpened1Click(Sender: TObject);
    procedure CBClosed1Click(Sender: TObject);
    procedure DVT1Click(Sender: TObject);
    procedure GasTrip1Click(Sender: TObject);
    procedure PilotTrip1Click(Sender: TObject);
    procedure ForUITextPool1Click(Sender: TObject);
    procedure ForParameterNDescriptorDB1Click(Sender: TObject);
    procedure ForParamDescBaseDB1Click(Sender: TObject);
    procedure ForParamofHullNoDB1Click(Sender: TObject);
    procedure ShowFileInfo1Click(Sender: TObject);
    procedure CompareParameterFromSnapShotFile1Click(Sender: TObject);
    procedure ForParamDescBaseDBFromDSDofSnapshot1Click(Sender: TObject);
    procedure ShowNavigationList1Click(Sender: TObject);
    procedure LoadTestSnapshot1Click(Sender: TObject);
    procedure UpdateSqlite4ValueFromParamno1Click(Sender: TObject);
    procedure AddonlynewparamtoParamDB1Click(Sender: TObject);
    procedure All2Click(Sender: TObject);
    procedure DescFilterEditChange(Sender: TObject);
    procedure UpdateCategoryEnumFromCategory1Click(Sender: TObject);
    procedure AllParamNo1Click(Sender: TObject);
    procedure GTParamNo1Click(Sender: TObject);
    procedure PTParamNo1Click(Sender: TObject);
    procedure StartBlock1Click(Sender: TObject);
    procedure NewDBonlyParameter1Click(Sender: TObject);
    procedure Measurand4AVAT21Click(Sender: TObject);
    procedure Command4AVAT21Click(Sender: TObject);
  private
    FPJHTimerPool: TPJHTimerPool;
    FEngineParameter4E2S: TSnapShot4E2S;
    FJson: String;

    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;
    procedure WorkerResult(var msg: TMessage); message MSG_WORKER_RESULT;
    procedure CompareParamResult(var msg: TMessage); message MSG_COMPARE_PARAM_RESULT;
    procedure OnGetStream(Sender: TFileContentsStreamOnDemandClipboardFormat;
      Index: integer; out AStream: IStream);
    procedure OnDescFilterChange(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);

    procedure SaveParamNo2TxtFile(AFileName, AParamKind: string);
    procedure DeleteSelectedItem(AIdx: integer);
    procedure LoadParamListFromTxt(AFileName: string);
    procedure Save2Sqlite(AIsOnlyParamSave: Boolean);
    procedure Save2Sqlite4UITextPool;
    procedure Save2Sqlite4ParamNDescriptor;
    procedure Save2Sqlite4ParamDescBaseFromCSVFile(AFileName: string);
    procedure Save2Sqlite4ParamDescBaseFromSnapShotDSD();
    procedure Save2Sqlite4ParamBaseFromSnapShot(AFileName: string);
    procedure Save2Sqlite4Param4HullNoFromSnapShot();
    procedure Save2Sqlite4Param4HullNoFromBaseDB();
    procedure Save2Sqlite4Param4HullNoFromEngParam();
    procedure Save2Sqlite4ParamOnlyFromSnapShot(AValueInfoType: string);

    function GetParamValueFromSubType(const ASubType: string; const AIdx: integer): string;
    function GetParamValueFromSensorType(const ASubType: TParameterType; const AIdx: integer): string;
    procedure GetMapData2Grid(AGridRowIdx: integer; AParamType: TParameterType);
    procedure GetDescript2Label(AGridRowIdx: integer; AParamType: TParameterType);
  public
    FParamDBFileName: string;//HiMECS Main Unit에서 DB 파일명 할당함.

    procedure DisplayValueInformations;
    procedure DisplayValueInformationsFromEngParam;
    procedure DisplayValueMonitorings;
    procedure DisplayValueStates;
    procedure DisplayValueStatesFromEngParam;

    procedure DisplayValueInfoNStatesFromEngParamRec(const ASqliteFileName: string);
    procedure DisplayValueInfoNStatesFromEngParam(const ASEngineParameter: TEngineParameter);
    procedure SetEngParamItem2Grid(AEngineParameterItem: TEngineParameterItem); overload;
    procedure SetEngParamItem2Grid(AEngineParameterItem: TEngineParameterItem; AGridRowIdx: integer); overload;

    procedure DisplayParameter2Grid;
  end;

  procedure CreateAvatParamView(const AFileName, AFileName2: string); overload;
  procedure CreateAvatParamView(const AStream1, AStream2: TStream); overload;

var
  AvatParamViewF: TAvatParamViewF;

implementation

uses UnitSynZip2, System.Zip, UnitStringUtil, UnitDragUtil
{$IFDEF USE_OMNITHREAD}
  ,OtlCollections
  ,OtlCommon
  ,OtlSync
  ,OtlTask
  ,OtlParallel
{$ENDIF}

  {$IFDEF USE_TIMER}
  , DSiWin32
  {$ENDIF}
  ,FrmSnapShotCompareResult2
  ,FrmAvatSnapShotNavigation2
;

{$R *.dfm}

procedure CreateAvatParamView(const AFileName, AFileName2: string);
begin
  AvatParamViewF := TAvatParamViewF.Create(nil);
  try
    with AvatParamViewF do
    begin
      if Pos('process-value-informations', AFileName) > 0 then
      begin
        FEngineParameter4E2S.ProcessValueInformations(AFileName);
        DisplayValueInformations;
      end;

      if Pos('process-value-monitorings', AFileName2) > 0 then
      begin
        FEngineParameter4E2S.ProcessValueMonitorings(AFileName2);
        DisplayValueMonitorings;
      end;

      if Pos('process-value-states', AFileName2) > 0 then
      begin
        FEngineParameter4E2S.ProcessValuestates(AFileName2);
        DisplayValuestates;
      end;

      ShowModal;
    end;
  finally
    AvatParamViewF.Free;
  end;
end;

procedure CreateAvatParamView(const AStream1, AStream2: TStream);
begin
  AvatParamViewF := TAvatParamViewF.Create(nil);
  try
    with AvatParamViewF do
    begin
      FEngineParameter4E2S.ProcessValueInformations(AStream1);
      DisplayValueInformations;
      FEngineParameter4E2S.ProcessValuestates(AStream2);
      DisplayValueStates;
      ShowModal;
    end;
  finally
    AvatParamViewF.Free;
  end;
end;

procedure TAvatParamViewF.AddonlynewparamtoParamDB1Click(Sender: TObject);
begin
  FEngineParameter4E2S.AddOnlyNewParamDescBaseRecFromEngParam();
end;

procedure TAvatParamViewF.AddSensorDataToSqliteFromSensorDB1Click(
  Sender: TObject);
var
  LSrc, LDest: string;
begin
  OpenDialog1.Title := 'Select Source Sensor DB';

  if OpenDialog1.Execute() then
  begin
    LSrc := OpenDialog1.FileName;
    OpenDialog1.Title := 'Select Destination DB To Add';

    if OpenDialog1.Execute() then
    begin
      LDest := OpenDialog1.FileName;
      AddSensorData2SqliteFromSensorDB(LSrc, LDest);
    end;
  end;
end;

procedure TAvatParamViewF.All1Click(Sender: TObject);
begin
  Save2Sqlite(False);
end;

procedure TAvatParamViewF.All2Click(Sender: TObject);
begin
  DisplayParameter2Grid;
end;

procedure TAvatParamViewF.AllParamNo1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SaveParamNo2TxtFile(SaveDialog1.FileName, 'ALL');
  end;
end;

procedure TAvatParamViewF.BuildUp1Click(Sender: TObject);
begin
  LoadParamListFromTxt(PPARM_ROOT_FOLDER+PARAM_MPSYSTEM_BUILDUP_FILE_NAME);
end;

procedure TAvatParamViewF.CBClosed1Click(Sender: TObject);
begin
  LoadParamListFromTxt(PPARM_ROOT_FOLDER+PARAM_SPEEDCONTROL_CBCLOSED_FILE_NAME);
end;

procedure TAvatParamViewF.CBOpened1Click(Sender: TObject);
begin
  LoadParamListFromTxt(PPARM_ROOT_FOLDER+PARAM_SPEEDCONTROL_CBOPENED_FILE_NAME);
end;

procedure TAvatParamViewF.ClearAllItems1Click(Sender: TObject);
begin
  FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Clear;
  ParamGrid.ClearRows;
end;

procedure TAvatParamViewF.Command4AVAT21Click(Sender: TObject);
begin
  Save2Sqlite4ParamOnlyFromSnapShot('COMMAND');
end;

procedure TAvatParamViewF.CompareParameterFromSnapShotFile1Click(
  Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
{$IFDEF USE_OMNITHREAD}
    FEngineParameter4E2S.CompareParamFromSnapShotFile(OpenDialog1.FileName, Handle, ParamInfoDBCheck.Checked);
{$ENDIF}
  end;
end;

procedure TAvatParamViewF.CompareParamResult(var msg: TMessage);
begin
//  ShowMessage(FEngineParameter4E2S.FResultCompareList.Text);
  CreatenShowSSCompareResultForm(FEngineParameter4E2S.FResultCompareList);
end;

procedure TAvatParamViewF.DeleteItems1Click(Sender: TObject);
begin
  DeleteSelectedItem(ParamGrid.SelectedRow);
end;

procedure TAvatParamViewF.DeleteSelectedItem(AIdx: integer);
begin
  FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Delete(AIdx);
  ParamGrid.DeleteRow(AIdx);
  ParamGrid.Update;
end;

procedure TAvatParamViewF.DisplayParameter2Grid;
{$IFDEF USE_TIMER}
var
  startTime   : int64;
{$ENDIF}
begin
{$IFDEF USE_TIMER}
  startTime := DSiTimeGetTime64;
{$ENDIF}

  ParamGrid.BeginUpdate();
  ParamGrid.ClearRows;
  try
    case DataSourceRG.ItemIndex of
      0: begin //From Snapshot file
        DisplayValueInformations;
        DisplayValueStates;
      end;
      1: begin //From FEngineParameter
//        DisplayValueInformationsFromEngParam;
//        DisplayValueStatesFromEngParam;
        DisplayValueInfoNStatesFromEngParam(FEngineParameter4E2S.FEngineParameter);
      end;
    end;
  finally
    ParamGrid.EndUpdate();
    ShowMessage('Loading is completed from SnapShot File');
  end;

{$IFDEF USE_TIMER}
  ShowMessage('DisplayParameter2Grid : ' + FormatDateTime('s.zzz', DSiElapsedTime64(startTime)/MSecsPerDay));
{$ENDIF}
end;

procedure TAvatParamViewF.DisplayValueInfoNStatesFromEngParam(
  const ASEngineParameter: TEngineParameter);
var
  i: integer;
begin
  with ASEngineParameter.EngineParameterCollect do
  begin
    ParamGrid.AddRow(Count);

    for i := 0 to Count - 1 do
    begin
//      SetEngParamItem2Grid(Items[i]);
      SetEngParamItem2Grid(Items[i], i);
    end;
  end;
end;

procedure TAvatParamViewF.DisplayValueInfoNStatesFromEngParamRec(const ASqliteFileName: string);
begin
  FEngineParameter4E2S.AssignEngParamFromSqlite(ASqliteFileName);
  ParamGrid.ClearRows;
  DisplayValueInfoNStatesFromEngParam(FEngineParameter4E2S.FEngineParameter);
end;

procedure TAvatParamViewF.DisplayValueInformations;
var
  i, LRow: integer;
  LParameterType: TParameterType;
  LSensorType: TSensorType;
begin
  with FEngineParameter4E2S do
  begin
    for i := 0 to Length(FValueInformations.processValueInformations)-1 do
    begin
      LRow := ParamGrid.AddRow.Index;
      ParamGrid.CellBy['Description',LRow].AsString := GetDisplayTextFromTextPool(FValueInformations.processValueInformations[i].displayName);
//      ParamGrid.CellBy['Descriptor',LRow].AsString := FValueInformations.processValueInformations[i].Fsubtype;
      ParamGrid.CellBy['Descriptor',LRow].AsString := FValueInformations.processValueInformations[i].Descriptor;
      LParameterType := GetParamTypeFromValueInfoIndex(i);
      ParamGrid.CellBy['ParameterType',LRow].AsInteger := Ord(LParameterType);
      ParamGrid.CellBy['Value',LRow].AsString := GetParamValueFromSensorType(LParameterType, i);
      ParamGrid.CellBy['FUnit',LRow].AsString := FValueInformations.processValueInformations[i].FunitId.symbol;

      if FValueInformations.processValueInformations[i].Fsubtype = 'characteristic-map' then
        ParamGrid.CellBy['Value',LRow].AsString := 'Map'
      else
        ParamGrid.CellBy['Value',LRow].AsString := GetParamValueFromSubType(FValueInformations.processValueInformations[i].Fsubtype, i);
    end;
  end;
end;

procedure TAvatParamViewF.DisplayValueInformationsFromEngParam;
var
  i, LRow: integer;
begin
  ParamGrid.ClearRows;

  with FEngineParameter4E2S.FEngineParameter do
  begin
    for i := 0 to EngineParameterCollect.Count - 1 do
    begin
      LRow := ParamGrid.AddRow.Index;
      ParamGrid.CellBy['Description',LRow].AsString := EngineParameterCollect.Items[i].Description;
      ParamGrid.CellBy['Descriptor',LRow].AsString := EngineParameterCollect.Items[i].descriptor;
      ParamGrid.CellBy['ParameterType',LRow].AsInteger := Ord(EngineParameterCollect.Items[i].ParameterType);
      ParamGrid.CellBy['Value',LRow].AsString := GetParamValueFromSensorType(EngineParameterCollect.Items[i].ParameterType, i);
      ParamGrid.CellBy['FUnit',LRow].AsString := EngineParameterCollect.Items[i].FUnit;
    end;
  end;
end;

procedure TAvatParamViewF.DisplayValueMonitorings;
var
  i, LRow: integer;
begin
  with FEngineParameter4E2S do
  begin
    for i := 0 to Length(FValueMonitoringA)-1 do
    begin
//      LRow := MonitorGrid.AddRow.Index;
//      MonitorGrid.CellBy['monitoringIndex',LRow].AsInteger := FValueMonitoringA[i].monitoringIndex;
//      MonitorGrid.CellBy['monitoringId',LRow].AsInteger := FValueMonitoringA[i].monitoringId;
//      MonitorGrid.CellBy['pvId',LRow].AsString := FValueMonitoringA[i].pvId;
    end;
  end;
end;

procedure TAvatParamViewF.DisplayValueStates;
var
  i, j, LRow: integer;
  LMatched: Boolean;
begin
  with FEngineParameter4E2S do
  begin
    for i := 0 to Length(FValueStatesA)-1 do
    begin
  //    LRow := MonitorGrid.AddRow.Index;
  //    MonitorGrid.CellBy['monitoringIndex',LRow].AsString := FValueStatesA[i].descriptor;
  //    MonitorGrid.CellBy['monitoringId',LRow].AsInteger := FValueStatesA[i].analogValue.number;
  //    MonitorGrid.CellBy['pvId',LRow].AsFloat := FValueStatesA[i].characteristicMapValue.value;
      if i <= ParamGrid.RowCount - 1  then
      begin
        LMatched := False;

        for j := 0 to High(FValueInformations.processValueInformations) do
        begin
          if FValueInformations.processValueInformations[j].Descriptor = FValueStatesA[i].descriptor then
          begin
            LMatched := True;
            break;
          end;
        end;

        if LMatched then
        begin
          if FValueInformations.processValueInformations[j].Fsubtype = 'analog' then
            ParamGrid.CellBy['Value',i].AsFloat := FValueStatesA[i].analogValue.number
          else
          if FValueInformations.processValueInformations[j].Fsubtype = 'discrete' then
            ParamGrid.CellBy['Value',i].AsString := GetDisplayTextFromTextPool(FValueStatesA[i].discreteValue.value);

//          ParamGrid.CellBy['Descriptor',i].AsString := FValueStatesA[i].constraint.Fsubtype
        end;

  //      if FValueInformations.processValueInformations[i].Descriptor = FValueStatesA[i].descriptor then
  //      begin
  //
  //      end;
      end;
    end;
  end;
end;

procedure TAvatParamViewF.DisplayValueStatesFromEngParam;
var
  i, j, LRow: integer;
  LMatched: Boolean;
begin
  with FEngineParameter4E2S.FEngineParameter do
  begin
    for j := 0 to EngineParameterCollect.Count - 1 do
    begin
      if EngineParameterCollect.Items[j].Descriptor = ParamGrid.CellBy['Descriptor',j].AsString then
      begin
        LMatched := True;
        LRow := j;
      end
      else
      begin
        for i := 0 to ParamGrid.RowCount - 1 do
        begin
          if EngineParameterCollect.Items[j].Descriptor = ParamGrid.CellBy['Descriptor',i].AsString then
          begin
            LMatched := True;
            LRow := i;
            break;
          end
        end;
      end;

      if LMatched then
      begin
        LMatched := False;

        if (EngineParameterCollect.Items[j].ParameterType = ptAnalog) or
          (EngineParameterCollect.Items[j].ParameterType = ptDigital) then
          ParamGrid.CellBy['Value',LRow].AsString := EngineParameterCollect.Items[j].Value
        else
        if (EngineParameterCollect.Items[j].ParameterType = ptMatrix1f) or
          (EngineParameterCollect.Items[j].ParameterType = ptMatrix2f) then
          ParamGrid.CellBy['Value',LRow].AsString := EngineParameterCollect.Items[j].Value;
      end;
    end;//for
  end;//with
end;

procedure TAvatParamViewF.DropEmptyTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  LTargetStream: TStream;
  LStr: RawByteString;
  LProcessOK: Boolean;
  LFileName: string;
begin
  LFileName := '';
  // 윈도우 탐색기에서 Drag 했을 경우
  if (DataFormatAdapter1.DataFormat <> nil) then
  begin
    LFileName := (DataFormatAdapter1.DataFormat as TFileDataFormat).Files.Text;

    if LFileName <> '' then
    begin
{$IFDEF USE_OMNITHREAD}
      FEngineParameter4E2S.AssignEngParamFromAvatSnapshotUsingOmni(LFileName, Handle, ParamInfoDBCheck.Checked);
{$ELSE}
      FEngineParameter4E2S.AssignEngParamFromAvatSnapshot(LFileName);
      DisplayParameter2Grid;
{$ENDIF}
      exit;
    end;
  end;

  // OutLook에서 첨부파일을 Drag 했을 경우
  if (TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames.Count > 0) then
  begin
    LFileName := TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat).FileNames[0];

    if ExtractFileExt(LFileName) <> '.msg' then
    begin
      LTargetStream := GetStreamFromDropDataFormat(TVirtualFileStreamDataFormat(DataFormatAdapterTarget.DataFormat));
      try
        if not Assigned(LTargetStream) then
          ShowMessage('Not Assigned');

        LStr := StreamToRawByteString(LTargetStream);

        exit;
      finally
        if Assigned(LTargetStream) then
          LTargetStream.Free;
      end;
    end;
  end;

  // OutLook에서 메일을 Drag 했을 경우
  if not LProcessOK and (DataFormatAdapterOutlook.DataFormat <> nil) then
  begin
//    SendReqOLEmailInfo;
//    ShowMessage('Outlook Mail Dropped');
  end;
end;

procedure TAvatParamViewF.DVT1Click(Sender: TObject);
begin
  LoadParamListFromTxt(PPARM_ROOT_FOLDER+PARAM_DVT_FILE_NAME);
end;

procedure TAvatParamViewF.DescFilterEditChange(Sender: TObject);
begin
  FPJHTimerPool.AddOneShot(OnDescFilterChange,500);
end;

procedure TAvatParamViewF.EngineStart1Click(Sender: TObject);
begin
  LoadParamListFromTxt(PPARM_ROOT_FOLDER+PARAM_ENGINE_START_FILE_NAME);
end;

procedure TAvatParamViewF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
//  Release;
//  AvatParamViewF := nil;
end;

procedure TAvatParamViewF.FormCreate(Sender: TObject);
begin
  FPJHTimerPool := TPJHTimerPool.Create(nil);
  FEngineParameter4E2S := TSnapShot4E2S.Create;
end;

procedure TAvatParamViewF.FormDestroy(Sender: TObject);
begin
  if Assigned(FPJHTimerPool) then
  begin
    FPJHTimerPool.RemoveAll;
    FreeAndNil(FPJHTimerPool);
  end;

  FEngineParameter4E2S.Free;
  AvatParamViewF := nil;
end;

procedure TAvatParamViewF.ForParamDescBaseDB1Click(Sender: TObject);
begin
  OpenDialog1.Title := 'Select CSV File';

  if OpenDialog1.Execute then
  begin
    Save2Sqlite4ParamDescBaseFromCSVFile(OpenDialog1.FileName);
  end;
end;

procedure TAvatParamViewF.ForParamDescBaseDBFromDSDofSnapshot1Click(
  Sender: TObject);
begin
  Save2Sqlite4ParamDescBaseFromSnapShotDSD;
end;

procedure TAvatParamViewF.ForParameterNDescriptorDB1Click(Sender: TObject);
begin
  Save2Sqlite4ParamNDescriptor;
end;

procedure TAvatParamViewF.ForParamofHullNoDB1Click(Sender: TObject);
begin
  Save2Sqlite4Param4HullNoFromSnapShot;
end;

procedure TAvatParamViewF.ForUITextPool1Click(Sender: TObject);
begin
  Save2Sqlite4UITextPool;
end;

procedure TAvatParamViewF.GasTrip1Click(Sender: TObject);
begin
  LoadParamListFromTxt(PPARM_ROOT_FOLDER+PARAM_GAS_TRIP_FILE_NAME);
end;

procedure TAvatParamViewF.GetDescript2Label(AGridRowIdx: integer;
  AParamType: TParameterType);
var
  LDesc: string;
begin
  case AParamType of
    ptDefault: DiscreteDescLabel.Caption.Text :=
      FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].Description_Eng;
    ptAnalog: AnalogDescriptionLabel.Caption.Text :=
      FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].Description_Eng;
    ptDigital: DiscreteDescLabel.Caption.Text :=
      FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].Description_Eng;
    ptBool: ;
    ptMatrix1: ;
    ptMatrix2: ;
    ptMatrix3: ;
    ptMatrix1f,
    ptMatrix2f: begin
      MapDescLabel.Caption.Text :=
        FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].Description_Eng;
    end;
    ptMatrix3f: ;
  end;
  end;

procedure TAvatParamViewF.GetMapData2Grid(AGridRowIdx: integer;
  AParamType: TParameterType);
var
  LVar, LVar2, LVar3: variant;
  i, j, LRow, LCol: integer;
begin
  MatrixGrid.BeginUpdate;
  try
    MatrixGrid.Clear;
    MatrixGrid.RowCount := 2;
    MatrixGrid.ColCount := 2;
    LCol := 0;

    //y축 Header
    if AParamType = ptMatrix2f then
    begin
      if FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].YAxisData = '' then
        exit;
      LVar3 := _Json(FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].YAxisData);
      MatrixGrid.RowCount := LVar3._Count+1;
      MatrixGrid.FixedCols := 1;
      MatrixGrid.ColCount := 2;
      LCol := 1;

      yAxisLabel.Caption :=
        FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].YAxisDisplayName +
        '(' + FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].YAxisUnit + ')';

      for i := 0 to LVar3._Count - 1 do
      begin
        MatrixGrid.Cells[0, i+1] := LVar3.Value(i);
      end;
    end
    else
      yAxisLabel.Caption := '';

    if FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].XAxisData = '' then
      exit;

    LVar3 := _Json(FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].XAxisData);
    MatrixGrid.ColCount := LCol + LVar3._Count;
    LRow := 0;
    xAxisLabel.Caption :=
      FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].XAxisDisplayName +
      '(' + Utf8ToString(FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].XAxisUnit) + ')';
    //x축 Header
    for i := 0 to LVar3._Count - 1 do
    begin
      MatrixGrid.Cells[i+LCol, LRow] := LVar3.Value(i);
    end;

    if FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].MatrixData = '' then
      exit;

    LVar := _Json(FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AGridRowIdx].MatrixData);

    for i := 0 to LVar._Count - 1 do
    begin
      LVar2 := LVar.Value(i);

      for j := 0 to  LVar2._Count - 1 do
      begin
        MatrixGrid.Cells[j+LCol, i+1] := LVar2.Value(j);
      end;
    end;
  finally
    MatrixGrid.EndUpdate;
    MatrixGrid.Height := MatrixGrid.DefaultRowHeight * MatrixGrid.RowCount + 4;
    yAxisLabel.Height := MatrixGrid.Height;
  end;
end;

function TAvatParamViewF.GetParamValueFromSensorType(
  const ASubType: TParameterType; const AIdx: integer): string;
begin
  case ASubType of
    ptDigital,
    ptAnalog: Result := FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AIdx].value;
    ptMatrix1f: begin
      Result := FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AIdx].Value;
    end;
    ptMatrix2f: begin
      Result := FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Items[AIdx].Value;//Result := 'Map';//
    end;
  end;
end;

function TAvatParamViewF.GetParamValueFromSubType(
  const ASubType: string; const AIdx: integer): string;
begin
  if ASubType = 'discrete' then
    Result := FEngineParameter4E2S.FValueInformations.processValueInformations[AIdx].discreteValues[0].value;
end;

procedure TAvatParamViewF.GTParamNo1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SaveParamNo2TxtFile(SaveDialog1.FileName, '(GT)');
  end;
end;

procedure TAvatParamViewF.Injection1Click(Sender: TObject);
begin
  LoadParamListFromTxt(PPARM_ROOT_FOLDER+PARAM_MPSYSTEM_INJECTION_FILE_NAME);
end;

procedure TAvatParamViewF.LoadDescritionFromSqlite1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    FEngineParameter4E2S.AssignEngParamMissedFieldFromSqlite(OpenDialog1.FileName);
  end;
end;

procedure TAvatParamViewF.LoadFromFile1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
{$IFDEF USE_OMNITHREAD}
    FEngineParameter4E2S.AssignEngParamFromAvatSnapshotUsingOmni(OpenDialog1.FileName, Handle, ParamInfoDBCheck.Checked, '');
//    FEngineParameter4E2S.AssignEngParamFromAvatSnapshotUsingOmni(OpenDialog1.FileName, Handle, ParamInfoDBCheck.Checked, '', FEngineParameter4E2S.FEngineParameter);
{$ELSE}
    FEngineParameter4E2S.AssignEngParamFromAvatSnapshot(OpenDialog1.FileName, nil, IsForcedAddCheck.Checked);
    DisplayParameter2Grid;
{$ENDIF}
  end;
end;

procedure TAvatParamViewF.LoadFromSqlite1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    DisplayValueInfoNStatesFromEngParamRec(OpenDialog1.FileName);
  end;
end;

procedure TAvatParamViewF.LoadParamListFromTxt(AFileName: string);
var
  LStrList: TStringList;
  i: integer;
  LParamNo: string;
  LEngineParamDB: TRestClientDB;
  LEngineParamModel: TOrmModel;
  LEngineParamRecord: TEngineParamRecord;
  LEngineParamItem: TEngineParameterItem;
begin
  if not FileExists(AFileName) then
  begin
    ShowMessage('File(' + AFileName + ') not found.');
    exit;
  end;

  LStrList := TStringList.Create;
  LEngineParamModel := nil;
  LEngineParamDB := InitEngineParamClient2(FParamDBFileName, LEngineParamModel);
//  FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Clear;
  ParamGrid.ClearRows;
  LEngineParamItem := TEngineParameterItem.Create(nil);
  try
    LStrList.LoadFromFile(AFileName);

    for i := 0 to LStrList.Count - 1 do
    begin
      LParamNo := LStrList.Strings[i];
      LEngineParamRecord := GetEngParamRecFromParamNo(LParamNo, LEngineParamDB);

      if LEngineParamRecord.IsUpdate then
      begin
//        LEngineParamItem := FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.Add;
        FEngineParameter4E2S.AssignEngParamItemFromEngParamRec(LEngineParamRecord,LEngineParamItem);
        SetEngParamItem2Grid(LEngineParamItem);
      end;//if
    end;//for
  finally
    LEngineParamItem.Free;
    LStrList.Free;
    DestroyEngineParamClient(LEngineParamDB, LEngineParamModel);
  end;
end;

procedure TAvatParamViewF.LoadTestSnapshot1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    FEngineParameter4E2S.ProcessTestStream(OpenDialog1.FileName);
  end;
end;

procedure TAvatParamViewF.Measurand4AVAT21Click(Sender: TObject);
begin
  Save2Sqlite4ParamOnlyFromSnapShot('MEASURAND');
end;

procedure TAvatParamViewF.NewDBonlyParameter1Click(Sender: TObject);
begin
  Save2Sqlite4ParamOnlyFromSnapShot('PARAMETER');
end;

procedure TAvatParamViewF.OnDescFilterChange(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  Description.Filter := DescFilterEdit.Text;
end;

procedure TAvatParamViewF.OnGetStream(
  Sender: TFileContentsStreamOnDemandClipboardFormat; Index: integer;
  out AStream: IStream);
var
  LStream: TStringStream;
begin
  LStream := TStringStream.Create;
  try
    LStream.WriteString(FJson);
    AStream := nil;
    AStream := TFixedStreamAdapter.Create(LStream, soOwned);
  except
    raise;
  end;
end;

procedure TAvatParamViewF.OnlyParameter1Click(Sender: TObject);
begin
  Save2Sqlite(True);
end;

procedure TAvatParamViewF.Optimization1Click(Sender: TObject);
begin
  LoadParamListFromTxt(PPARM_ROOT_FOLDER+PARAM_MPSYSTEM_OPTIMIZATION_FILE_NAME);
end;

procedure TAvatParamViewF.ParamGridSelect(Sender: TObject; ACol, ARow: Integer);
var
  LParamType: TParameterType;
begin
  if ParamGrid.SelectedRow = -1 then
    exit;

//  if ACol = ParamGrid.Columns.ItemBy['ParameterType'].Index then
//  begin
    LParamType := TParameterType(ParamGrid.CellBy['ParameterType', ARow].AsInteger);

    if (LParamType = ptMatrix1f) or (LParamType = ptMatrix2f) then //Map인 경우
    begin
      ValuePageList.ActivePage := MapPage;
      GetMapData2Grid(ARow, LParamType);
    end
    else
    if LParamType = ptAnalog then
    begin
      ValuePageList.ActivePage := AnalogPage;
//      GetDescript2Label(ARow, LParamType);
    end
    else
    if LParamType = ptDigital then
    begin
      ValuePageList.ActivePage := DiscretePage;
//      GetDescript2Label(ARow, LParamType);
    end
    else//LParamType = ptDefault
    begin
      ValuePageList.ActivePage := DiscretePage;
    end;

    GetDescript2Label(ARow, LParamType);
//  end;
end;

procedure TAvatParamViewF.PilotTrip1Click(Sender: TObject);
begin
  LoadParamListFromTxt(PPARM_ROOT_FOLDER+PARAM_PILOT_TRIP_FILE_NAME);
end;

procedure TAvatParamViewF.PTParamNo1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    SaveParamNo2TxtFile(SaveDialog1.FileName, '(PT)');
  end;
end;

procedure TAvatParamViewF.Save2Sqlite(AIsOnlyParamSave: Boolean);
var
  LEngineParamDB: TRestClientDB;
  LEngineParamModel: TOrmModel;
begin
  if OpenDialog1.Execute then
  begin
    LEngineParamModel := nil;
    LEngineParamDB := InitEngineParamClient2(OpenDialog1.FileName, LEngineParamModel);
    try
      FEngineParameter4E2S.AddOrUpdateEngParamRecFromEngParam(LEngineParamDB, AIsOnlyParamSave);
      FEngineParameter4E2S.AddOrUpdatePLCInfoRecFromPLCInfo(LEngineParamDB);
      FEngineParameter4E2S.AddOrUpdateDiscreteValueRecFromValueInfoState(LEngineParamDB);

      ShowMessage('Parameter is saved to ''' + OpenDialog1.FileName + ''' file succefully!');
    finally
      DestroyEngineParamClient(LEngineParamDB, LEngineParamModel);
    end;
  end;
end;

procedure TAvatParamViewF.Save2Sqlite4Param4HullNoFromBaseDB;
begin
  InitParamBaseClient(DF_AVAT2_PARAM_BASE_DB_NAME);
  try
//      FEngineParameter4E2S.AddOrUpdateParam4AVAT2FromSnapShot(nil, nil);
      FEngineParameter4E2S.AddOrUpdateParam4AVAT2FromEngParam(nil, nil);

      ShowMessage('Parameter DB is saved to ''' + SaveDialog1.FileName + ''' file successfully!');
  finally
    DestroyParamBaseClient;
  end;
end;

procedure TAvatParamViewF.Save2Sqlite4Param4HullNoFromEngParam;
begin

end;

procedure TAvatParamViewF.Save2Sqlite4Param4HullNoFromSnapShot();
begin
  SaveDialog1.Title := 'Select Param DB File Name';

  if SaveDialog1.Execute then
  begin
    InitParam4AVAT2Client(SaveDialog1.FileName);
    try
      case DataSourceRG.ItemIndex of
        //From Snapshot(BaseDB)
        0,1: Save2Sqlite4Param4HullNoFromBaseDB();
        //From EngParam
//        1: Save2Sqlite4Param4HullNoFromEngParam();
      end;
    finally
      DestroyParam4AVAT2Client;
    end;
  end;
end;

procedure TAvatParamViewF.Save2Sqlite4ParamBaseFromSnapShot(AFileName: string);
var
  LFileName: string;
begin
  SaveDialog1.Title := 'Select Engine Parameter DB File';

  if SaveDialog1.Execute then
  begin
    LFileName := SaveDialog1.FileName;

    SaveDialog1.Title := 'Select Parameter Descript Base DB File';

    if SaveDialog1.Execute then
    begin
      InitEngineParamClient(LFileName);
      InitParamBaseClient(SaveDialog1.FileName);
      try
        FEngineParameter4E2S.AddOrUpdateParameter4AVAT2FromSnapShotDSD(nil, False);

        ShowMessage('Parameter Descript Base DB is saved to ''' + SaveDialog1.FileName + ''' file succefully!');
      finally
        DestroyEngineParamClient;
        DestroyParamBaseClient;
      end;
    end;
  end;
end;

procedure TAvatParamViewF.Save2Sqlite4ParamDescBaseFromCSVFile(
  AFileName: string);
begin
  SaveDialog1.Title := 'Select Param Base DB File Name';

  if SaveDialog1.Execute then
  begin
    InitParamBaseClient(SaveDialog1.FileName);
    try
        FEngineParameter4E2S.AddOrUpdateParamDescBaseRecFromXlsFile(AFileName, nil);

        ShowMessage('Parameter Descript Base DB is saved to ''' + SaveDialog1.FileName + ''' file succefully!');
    finally
      DestroyParamBaseClient;
    end;
  end;
end;

procedure TAvatParamViewF.Save2Sqlite4ParamDescBaseFromSnapShotDSD;
begin
  SaveDialog1.Title := 'Select Param Base DB File Name';

  if SaveDialog1.Execute then
  begin
    InitParam4AVAT2Client(SaveDialog1.FileName);
    try
        FEngineParameter4E2S.AddOrUpdateParameter4AVAT2FromSnapShotDSD(nil, False);

        ShowMessage('Parameter Descript Base DB is saved to ''' + SaveDialog1.FileName + ''' file succefully!');
    finally
      DestroyParam4AVAT2Client;
    end;
  end;
end;

procedure TAvatParamViewF.Save2Sqlite4ParamNDescriptor;
begin
  if OpenDialog1.Execute then
  begin
    InitParamNDescriptorClient(OpenDialog1.FileName);
    try
      FEngineParameter4E2S.AddOrUpdateParamNDescriptorRecFromParamNDescriptor(nil);

      ShowMessage('Parameter No. and Descriptor is saved to ''' + OpenDialog1.FileName + ''' file succefully!');
    finally
      DestroyParamNDescriptorClient;
    end;
  end;
end;

procedure TAvatParamViewF.Save2Sqlite4ParamOnlyFromSnapShot(AValueInfoType: string);
var
  LParam4AVAT2DB: TRestClientDB;
  LParam4AVAT2Model: TOrmModel;
  LAddCount: integer;
begin
  LAddCount := 0;
  SaveDialog1.Title := 'Select Param DB File Name';

  if SaveDialog1.Execute then
  begin
    LParam4AVAT2Model := nil;
    LParam4AVAT2DB := InitParam4AVAT2Client2(SaveDialog1.FileName, LParam4AVAT2Model);
    try
      LAddCount := FEngineParameter4E2S.AddOrUpdateParam4AVAT2FromSnapShot(LParam4AVAT2DB, nil, AValueInfoType);
      ShowMessage('Parameter DB is saved to ''' + SaveDialog1.FileName + ''' file successfully!' + #13#10 +
                  'Added Items = ' + IntToStr(LAddCount));
    finally
      DestroyParam4AVAT2Client(LParam4AVAT2DB, LParam4AVAT2Model);
    end;
  end;
end;

procedure TAvatParamViewF.Save2Sqlite4UITextPool;
begin
  if OpenDialog1.Execute then
  begin
    InitUITextPoolClient(OpenDialog1.FileName);
    try
      FEngineParameter4E2S.AddOrUpdateUITextPoolRecFromUITextPool(nil);

      ShowMessage('UITextPool is saved to ''' + OpenDialog1.FileName + ''' file succefully!');
    finally
      DestroyUITextPoolClient;
    end;
  end;
end;

//AParamKind = 'ALL', '(GT)', '(PT)'
procedure TAvatParamViewF.SaveParamNo2TxtFile(AFileName, AParamKind: string);
var
  i: integer;
  LStr: string;
  LStrList: TStringList;
begin
  LStrList := TStringList.Create;
  try
    for i := 0 to ParamGrid.RowCount - 1 do
    begin
      if AParamKind <> 'ALL' then
      begin
        LStr := ParamGrid.CellBy['Description',i].AsString;

        if Pos(AParamKind, LStr) > 0 then
        begin
          LStr := ParamGrid.CellBy['ParamNo',i].AsString;

          if LStr <> '' then
          begin
            LStrList.Add(LStr);
          end;
        end;
      end;
    end;

    LStrList.SaveToFile(AFileName);
  finally
    LStrList.Free;
  end;
end;

procedure TAvatParamViewF.SetEngParamItem2Grid(
  AEngineParameterItem: TEngineParameterItem; AGridRowIdx: integer);
begin
  with AEngineParameterItem do
  begin
    ParamGrid.CellBy['ParamNo',AGridRowIdx].AsString := ParamNo;
    ParamGrid.CellBy['Description',AGridRowIdx].AsString := Description;
    ParamGrid.CellBy['Descriptor',AGridRowIdx].AsString := descriptor;
    ParamGrid.CellBy['ParameterType',AGridRowIdx].AsInteger := Ord(ParameterType);
    ParamGrid.CellBy['Value',AGridRowIdx].AsString := Value;//GetParamValueFromSensorType(ParameterType, i);
    ParamGrid.CellBy['FUnit',AGridRowIdx].AsString := FUnit;
  end;
end;

procedure TAvatParamViewF.SetEngParamItem2Grid(
  AEngineParameterItem: TEngineParameterItem);
var
  LRow: integer;
begin
//  with AEngineParameterItem do
//  begin
    LRow := ParamGrid.AddRow.Index;
    SetEngParamItem2Grid(AEngineParameterItem, LRow);
//    ParamGrid.CellBy['ParamNo',LRow].AsString := ParamNo;
//    ParamGrid.CellBy['Description',LRow].AsString := Description;
//    ParamGrid.CellBy['Descriptor',LRow].AsString := descriptor;
//    ParamGrid.CellBy['ParameterType',LRow].AsInteger := Ord(ParameterType);
//    ParamGrid.CellBy['Value',LRow].AsString := Value;//GetParamValueFromSensorType(ParameterType, i);
//    ParamGrid.CellBy['FUnit',LRow].AsString := FUnit;
//  end;
end;

procedure TAvatParamViewF.ShowFileInfo1Click(Sender: TObject);
begin
  FEngineParameter4E2S.ShowZipFileInfoBriefly;
end;

procedure TAvatParamViewF.ShowNavigationList1Click(Sender: TObject);
//var
//  LList: TStringList;
begin
//  LList := FEngineParameter4E2S.GetNavListFromSnapShot;
//  ShowMessage(LList.Text);
//  LList.Free;
  CreateOrShowSnapShotNavigation;
end;

procedure TAvatParamViewF.SlowTurning1Click(Sender: TObject);
begin
  LoadParamListFromTxt(PPARM_ROOT_FOLDER+PARAM_SLOW_TURNING_FILE_NAME);
end;

procedure TAvatParamViewF.StartBlock1Click(Sender: TObject);
begin
  LoadParamListFromTxt(PPARM_ROOT_FOLDER+PARAM_ENGINE_STARTBLOCK_FILE_NAME);
end;

procedure TAvatParamViewF.UpdateCategoryEnumFromCategory1Click(Sender: TObject);
begin
  UpdatedParamDescBaseRec2CategoryEnum();
end;

procedure TAvatParamViewF.UpdateSqlite4TagName1Click(Sender: TObject);
var
  LEngineParamDB: TRestClientDB;
  LEngineParamModel: TOrmModel;
begin
  if OpenDialog1.Execute then
  begin
    LEngineParamModel := nil;
    LEngineParamDB := InitEngineParamClient2(OpenDialog1.FileName, LEngineParamModel);
    try
      FEngineParameter4E2S.AddOrUpdateEngParamRec4TagName(LEngineParamDB);
    finally
      DestroyEngineParamClient(LEngineParamDB, LEngineParamModel);
    end;
  end;
end;

procedure TAvatParamViewF.UpdateSqlite4ValueFromParamno1Click(Sender: TObject);
var
  LEngineParamDB: TRestClientDB;
  LEngineParamModel: TOrmModel;
begin
  if OpenDialog1.Execute then
  begin
    LEngineParamModel := nil;
    LEngineParamDB := InitEngineParamClient2(OpenDialog1.FileName, LEngineParamModel);
    try
      FEngineParameter4E2S.AddOrUpdateEngParamRecValueFromEngParam(LEngineParamDB);
    finally
      DestroyEngineParamClient(LEngineParamDB, LEngineParamModel);
    end;
  end;
end;

procedure TAvatParamViewF.UpdateSqliteFromParamNo1Click(Sender: TObject);
var
  LEngineParamDB: TRestClientDB;
  LEngineParamModel: TOrmModel;
begin
  if OpenDialog1.Execute then
  begin
    LEngineParamModel := nil;
    LEngineParamDB := InitEngineParamClient2(OpenDialog1.FileName, LEngineParamModel);
    try
      FEngineParameter4E2S.AddOrUpdateEngParamRecFromEngParam(LEngineParamDB, True);
    finally
      DestroyEngineParamClient(LEngineParamDB, LEngineParamModel);
    end;
  end;
end;

procedure TAvatParamViewF.WMCopyData(var Msg: TMessage);
var
  LDragCopyMode: TParamDragCopyMode;
  LEngineParameterItem: TEngineParameterItem;
begin
  case Msg.WParam of
    0: begin
      LEngineParameterItem := TEngineParameterItem(PCopyDataStruct(Msg.LParam)^.lpData^);
      FEngineParameter4E2S.FEngineParameter.EngineParameterCollect.AddEngineParameterItem(LEngineParameterItem);
      SetEngParamItem2Grid(LEngineParameterItem);
    end;
  end;
end;

procedure TAvatParamViewF.WorkerResult(var msg: TMessage);
begin
  DisplayParameter2Grid;
{$IFDEF USE_OMNITHREAD}
  FEngineParameter4E2S.AssignEtcDataFromAvatSnapshotUsingOmni;
{$ENDIF}
end;

end.
