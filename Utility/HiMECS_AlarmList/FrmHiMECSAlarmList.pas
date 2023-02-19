unit FrmHiMECSAlarmList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, DropTarget, DragDropText,
  AdvOfficeStatusBar, AdvOfficeStatusBarStylers, CalcExpress, DragDrop,
  DropSource, JvDialogs, Vcl.ImgList, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  iXYPlot, iComponent, iVCLComponent, iCustomComponent, iPlotComponent, iPlot,
  NxColumnClasses, NxColumns, NxScrollControl, NxCustomGridControl,
  NxCustomGrid, NxGrid, Vcl.ComCtrls, JvExComCtrls, JvComCtrls, JvStatusBar,
  Generics.Collections,
  mormot.core.os, mormot.core.unicode, mormot.orm.core, mormot.rest.sqlite3, mormot.db.raw.sqlite3.static,
  AdvOfficePager, UnitFrameIPCMonitorAll2, TimerPool, DeCAL, HiMECSConst,
  UnitEngineParameterClass2, WatchConst2, UnitDragDropRecord2, Data.DB,
  UnitAlarmConfigClass2, UnitAlarmConst, FrmHiMECSAlarmConfig,
  NxCollection, AdvSmoothPanel, AdvSmoothExpanderPanel,
  cyMathParser, AeroButtons, AdvOfficeButtons, AdvGroupBox, JvExControls,
  JvLabel, CurvyControls, DateUtils, UnitFrameWatchGrid2,
  UnitHiMECSAlarmRecord, UnitHiMECSAlarmRestClient, UnitHiMECSManualClass2;

const
  DefaultPassPhrase = 'DefaultPassPhrase';
  //DefaultConfigFileName = 'DefaultAlarm.config';
  DefaultEncryption = False;
  DefaultAlarmListCellColor = clWhite;
  DefaultAlarmListCellColor4True = clYellow;
  DefaultAlarmListTextColor = clRed;

type
  //SQLite3에서 제공하는 데이터 타입
  TSQLParamType = (sptNull, sptBlob, sptReal, sptInteger, sptText);
  TSQLParamDict = TDictionary<string, TSQLParamType>;
  TAlarmDelayDict = TDictionary<string, TAlarmListClass>;

  TFormAlarmList = class(TForm)
    PageControl1: TAdvOfficePager;
    ItemsTabSheet: TAdvOfficePage;
    JvStatusBar1: TJvStatusBar;
    Label4: TLabel;
    EnableAlphaCB: TCheckBox;
    JvTrackBar1: TJvTrackBar;
    StayOnTopCB: TCheckBox;
    AllowUserlevelCB: TComboBox;
    SaveListCB: TCheckBox;
    ImageList1: TImageList;
    JvSaveDialog1: TJvSaveDialog;
    JvOpenDialog1: TJvOpenDialog;
    EngParamSource2: TDropTextSource;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    DropTextTarget1: TDropTextTarget;
    ApplicationEvents1: TApplicationEvents;
    WatchListPopup: TPopupMenu;
    Items1: TMenuItem;
    AddtoCalculated1: TMenuItem;
    N5: TMenuItem;
    LoadWatchListFromFile1: TMenuItem;
    SaveWatchLittoNewName1: TMenuItem;
    N3: TMenuItem;
    DeleteItem1: TMenuItem;
    N10: TMenuItem;
    Properties1: TMenuItem;
    AlarmListTabSheet: TAdvOfficePage;
    AlarmListGrid: TNextGrid;
    Ack: TNxCheckBoxColumn;
    TimeIn: TNxTextColumn;
    EngNo: TNxTextColumn;
    TagDesc: TNxTextColumn;
    AlarmType: TNxTextColumn;
    AlarmMsg: TNxTextColumn;
    Priority: TNxTextColumn;
    AlarmListPopup: TPopupMenu;
    Config2: TMenuItem;
    N2: TMenuItem;
    DeleteItem2: TMenuItem;
    SetAlarmEnable1: TMenuItem;
    SetAlarmDisable1: TMenuItem;
    N1: TMenuItem;
    LoadAlarmDataFromDB1: TMenuItem;
    N4: TMenuItem;
    ClearAllDB1: TMenuItem;
    TimeOut: TNxTextColumn;
    est1: TMenuItem;
    Timer1: TTimer;
    cyMathParser1: TcyMathParser;
    ImageList32x32: TImageList;
    NxFlipPanel1: TNxFlipPanel;
    CurvyPanel1: TCurvyPanel;
    JvLabel2: TJvLabel;
    JvLabel6: TJvLabel;
    CurvyPanel2: TCurvyPanel;
    Label1: TLabel;
    rg_period: TAdvOfficeRadioGroup;
    dt_begin: TDateTimePicker;
    dt_end: TDateTimePicker;
    cb_engProjNo: TComboBox;
    CurvyPanel3: TCurvyPanel;
    AeroButton1: TAeroButton;
    AeroButton4: TAeroButton;
    TagName: TNxTextColumn;
    FWG: TFrameWatchGrid2;
    IPCMonitorAll1: TFrameIPCMonitor2;
    Find1: TMenuItem;
    N6: TMenuItem;
    FindNext1: TMenuItem;
    Gotoitem1: TMenuItem;
    ShowWirePath1: TMenuItem;
    N7: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EnableAlphaCBClick(Sender: TObject);
    procedure JvTrackBar1Change(Sender: TObject);
    procedure StayOnTopCBClick(Sender: TObject);
    procedure SaveWatchLittoNewName1Click(Sender: TObject);
    procedure LoadWatchListFromFile1Click(Sender: TObject);
    procedure Config2Click(Sender: TObject);
    procedure SetAlarmEnable1Click(Sender: TObject);
    procedure SetAlarmDisable1Click(Sender: TObject);
    procedure LoadAlarmDataFromDB1Click(Sender: TObject);
    procedure ClearAllDB1Click(Sender: TObject);
    procedure est1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure AckChange(Sender: TObject);
    procedure rg_periodClick(Sender: TObject);
    procedure AeroButton4Click(Sender: TObject);
    procedure AeroButton1Click(Sender: TObject);
    procedure Find1Click(Sender: TObject);
    procedure FindNext1Click(Sender: TObject);
    procedure AlarmListGridCellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure AlarmListGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Gotoitem1Click(Sender: TObject);
    procedure ShowWirePath1Click(Sender: TObject);
  private
    FPJHTimerPool: TPJHTimerPool;
    FCalculatedItemTimerHandle: integer; //Calculated Item display용 Timer Handle
    FEngineParameterTarget: TEngineParameterDataFormat;
    FEngParamSource: TEngineParameterDataFormat;
    FEngineParameterItemRecord: TEngineParameterItemRecord; //Save폼에 값 전달시 사용
    FMousePoint: TPoint;
    FFilePath,                       //파일을 저장할 경로
    FWatchListFileName: string;

    ////////////////////////////////////////////////////////////////////////////
//    FDataBase: TSivak3Database;
//    FQuery: TSivak3Query;
//    FExec: TSivak3Exec;
    ////////////////////////////////////////////////////////////////////////////
    FAlarmConfig : TAlarmConfig;
    FAlarmListClass: TAlarmListClass;
    FAlarmStrList: TStringList;

    FAlarmSettDoing: Boolean;
    FFirst: Boolean;

    FAlarmDelayDict: TAlarmDelayDict;

    FAlarmRestClient: THiMECSAlarmRestClient;
    FAlarmRecord: TOrmModel;

    procedure InitAlarmList;
    //Sensor DB에서
    procedure LoadWatchListFromFile();
    procedure AddAlarm2List(AParameterIndex: integer; AIsDigitalAlarm: Boolean = False);
    function AddData2AlarmListMap(AParameterIndex: integer;
      AUniqueTagName, AAlarmDesc: string): TAlarmListClass;
    function DeleteDataFromAlarmListMap_DB_IfNoAck(AUniqueTagName: string): integer;
    procedure AddAlarmItem2AlarmListGrid(APIndex: integer; AALRecord: TAlarmListClass);
    procedure ChangeColor2AlarmListGrid(APIndex: integer; ACellColor: TColor = DefaultAlarmListCellColor4True;
      ATextColor: TColor = $7FFFFFFF);
    procedure DisplayAlarm2ItemGrid(APIndex: integer; ACellColor: TColor = DefaultAlarmListCellColor4True;
      ATextColor: TColor = $7FFFFFFF);
    procedure GetCellNTextColorFromAlarmClass(var ACellColor, ATextColor: TColor);
    procedure AlarmAcknowledge(ARow: integer);
    function GetUniqueTagName(APIndex: integer): string;
    //UniqueTagName에서 '_EngineNo' 제거
    function GetUnUniqueTagName(AUniqueTagName: string): string;
    //UnUniqueTagName에서 Sensor TagName 발췌
    function GetSensorTagNameFrmUnUnique(AUnUniqueTagName: string): string;
    procedure UpdateAlarmListGrid(AGridRowIdx: integer; ATime: TDateTime);
    procedure DeleteAlaramFromAlarmListGrid(AGridRowIdx: integer);

    procedure CheckMinFault(APIndex: integer; AUniqueTagName: string);
    procedure CheckMaxFault(APIndex: integer; AUniqueTagName: string);
    procedure CheckMinWarn(APIndex: integer; AUniqueTagName: string);
    procedure CheckMaxWarn(APIndex: integer; AUniqueTagName: string);
    procedure CheckDigital(APIndex: integer; AUniqueTagName: string);

    procedure LoadConfigCollect2Form(AForm: TAlarmConfigF);
    procedure LoadConfigForm2Collect(AForm: TAlarmConfigF);
    procedure LoadConfigCollectFromFile(AFileName: string; AIsEncrypt: Boolean);
    procedure SetConfig;
    procedure SetAlarmListGridFont(AFontJson: string);

    function CheckDBFile(AFileName: string): Boolean;
//    procedure GetFields2Grid(ADb: TSivak3Database; ATableName: String; AGrid: TNextGrid);

    procedure DB_Create_Table;
    function DB_Alarm_insert(ARecord: TAlarmListClass): integer;//ALevel: integer; ATime: TDateTime; ATagname, AAlarmDesc : string): integer;
    procedure DB_Alarm_Ack_Update(ATagName: string; ATime: TDateTime);
    procedure DB_Alarm_Release_Update(ATagName: string; ATime: TDateTime);
    procedure DB_Alarm_Acked_Update(ASeqNo: integer; ATime: TDateTime);
    procedure DB_Alarm_Select(ASql: string; AParamList: TSQLParamDict; AValueList: TStringList);
    procedure DB_Alarm_Delect(ASql: string; AParamList: TSQLParamDict);
    procedure LoadAlarmDataFromDB;
    procedure ClearAllDB;
    procedure TestDBInsert;
    ///////////////////////////////////////////////////////////////////////////

    procedure WatchValue2Screen_Analog(Name: string; AValue: string;
                                AEPIndex: integer); virtual;
    procedure WatchValue2Screen_Analog2;
    procedure WatchValue2Screen_Digital(Name: string; AValue: string;
                                AEPIndex: integer); virtual;
    procedure SetAlarmEnable(AEnable: Boolean);

    function GetFromDay(ADate: TDateTime): TDateTime;
    function GetToDay(ADate: TDateTime): TDateTime;
    procedure DB_Alarm_Acked_Update_Zeos(ASeqNo: integer; ATime: TDateTime);
    procedure ChildFormClose(Sender: TObject; var Action: TCloseAction);
    procedure LoadManualInfo;
    function GetFullFilePathFromManualInfo(var ADrawingPath, AManualPath: string): Boolean;
    function GetDbPathFromApplicationsFolder: string;
  protected
    FSettings : TConfigSettings;
    FHiMECSManualInfo: THiMECSManualInfo;
    FCellColor, FTextColor: TColor;

  public
    procedure InitVar;
    procedure GotoItemGridFromAlarmListRowIdx(ARowIdx: integer);
    procedure GotoItemGridFromTagName(ATagName: string);
    function GetTagNameFromAlarmListRowIdx(ARowIdx: integer): string;
    function GetEngItemFromTagName(var ATagName: string): TEngineParameterItem;
    procedure CreateNShowWirePathForm(AEngParam: TEngineParameterItem);
    procedure ShowWirePath;
  end;

var
  FormAlarmList: TFormAlarmList;

implementation

uses mormot.core.datetime, UnitFontUtil, UnitStringUtil, UnitEngineParamConst,
  UnitFolderUtil2,
  UnitCopyWatchList, CopyData, UtilUnit, JHP.BaseConfigCollect, FrmSensorCableRoute2,
  DomSensorTypes2;

{$R *.dfm}

procedure TFormAlarmList.AddAlarm2List(AParameterIndex: integer;
  AIsDigitalAlarm: Boolean);
var
  LStr: string;
begin
  if FAlarmSettDoing then
    exit;

  LStr := GetUniqueTagName(AParameterIndex);

  if AIsDigitalAlarm then
    CheckDigital(AParameterIndex,LStr)
  else
  begin
    CheckMinFault(AParameterIndex,LStr);
    CheckMaxFault(AParameterIndex,LStr);
    CheckMinWarn(AParameterIndex,LStr);
    CheckMaxWarn(AParameterIndex,LStr);
  end;
end;

procedure TFormAlarmList.AddAlarmItem2AlarmListGrid(APIndex: integer; AALRecord: TAlarmListClass);
begin
  AlarmListGrid.InsertRow(0);

  AlarmListGrid.CellsByName['TimeIn',0] := FormatDateTime('yyyy-mm-dd hh:nn:ss.z', TimeLogToDateTime(AALRecord.FIssueDateTime));
  AlarmListGrid.CellsByName['EngNo',0] := AALRecord.FEngineNo;
  AlarmListGrid.CellsByName['TagDesc',0] := AALRecord.FTagDesc;
  AlarmListGrid.CellsByName['TagName',0] := AALRecord.FTagName;
  AlarmListGrid.CellsByName['AlarmType',0] := g_AlarmKind4AVAT2.ToString(TAlarmKind4AVAT2(AALRecord.FAlarmType));
  AlarmListGrid.CellsByName['AlarmMsg',0] := AALRecord.FAlarmDesc;
  AlarmListGrid.CellsByName['Priority',0] := ArarmPriority2String(TAlarmPriority(AALRecord.FAlarmPriority));
  AlarmListGrid.Row[0].Data := AALRecord;

  //if not AALRecord.FNeedAck then
    //TNxCheckBoxColumn(AlarmListGrid.Cell[0,0]).Visible := False;
end;

function TFormAlarmList.AddData2AlarmListMap(AParameterIndex: integer;
  AUniqueTagName, AAlarmDesc: string): TAlarmListClass;
var
  i: integer;
  LStr: string;
begin
  Result := nil;

  i := FAlarmStrList.IndexOf(AUniqueTagName);

  if i = -1 then
  begin
    with IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParameterIndex] do
    begin
      Result:= TAlarmListClass.Create;
      Result.FTagName := AUniqueTagName;
      Result.FValue := Value;
      Result.FAlarmDesc := AAlarmDesc;
      Result.FAlarmType := Ord(AlarmKind4AVAT2);
      Result.FIssueDateTime := TimeLogFromDateTime(now);
      Result.FEngineNo := EngNo;
      Result.FAlarmPriority := Ord(AlarmPriority);
      Result.FTagDesc := Description;
      Result.FNeedAck := MinAlarmNeedAck;
      Result.FAcknowledgedTime := 0;
      Result.FReleaseDateTime := 0;
      Result.FSuppressed := False;
      Result.FParamIndex := AParameterIndex;
    end;//with

    DB_Alarm_insert(Result);
    FAlarmStrList.InsertObject(0, AUniqueTagName, Result);
    //FAlarmListMap.putPair([LStr,Result]);
  end;
end;

procedure TFormAlarmList.AeroButton1Click(Sender: TObject);
var
  LSQLParamDict: TSQLParamDict;
  LValueList: TStringList;
  LSQL: string;
  i,j: integer;
begin
  LSQLParamDict := TSQLParamDict.Create;
  LValueList := TStringList.Create;
  try
    LSQL := 'select * from AlarmList where IssueDateTime >= :Fromday and IssueDateTime <= :ToDay';//ReleaseDateTime = 0';
    LSQLParamDict.Add('Fromday', sptReal);
    LSQLParamDict.Add('ToDay', sptReal);
    LValueList.Add(FloatToStr(GetFromDay(dt_begin.DateTime)));
    LValueList.Add(FloatToStr(GetToDay(dt_end.DateTime)));
    DB_Alarm_Select(LSQL, LSQLParamDict, LValueList);

//    if FQuery.Active then
//    begin
//      AlarmListGrid.ClearRows;
//
//      for i := 0 to FQuery.RecordCount - 1 do
//      begin
//        j := AlarmListGrid.AddRow();
//
//        //TNxCheckBoxColumn(AlarmListGrid.Cell[0,j]).Visible := Boolean(FQuery.FieldByName('NeedAcked').AsInteger);
//
//        AlarmListGrid.Cells[CI_TIME_IN,i] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',TDateTime(FQuery.Fields[3].AsFloat));
//
//        if FQuery.Fields[4].AsFloat > 0 then
//          AlarmListGrid.Cells[CI_TIME_OUT,i] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',TDateTime(FQuery.Fields[4].AsFloat));
//        AlarmListGrid.Cells[CI_ENGINE_NO,i] := FQuery.Fields[1].AsString;
//        AlarmListGrid.Cells[CI_TAG_DESC,i] := FQuery.Fields[6].AsString;
//        AlarmListGrid.Cells[CI_ALARMMSG,i] := FQuery.Fields[7].AsString;
//        AlarmListGrid.Cells[CI_ALARMPRIO,i] := ArarmPriority2String(TAlarmPriority(FQuery.Fields[8].AsInteger));
//        FQuery.Next;
//      end;
//    end;
  finally
    LValueList.Free;
    LSQLParamDict.Free;
  end;
end;

procedure TFormAlarmList.AeroButton4Click(Sender: TObject);
begin
  close;
end;

procedure TFormAlarmList.AlarmAcknowledge(ARow: integer);
var
 LAlarmListClass: TAlarmListClass;
 LStr: string;
 i: integer;
begin
  LAlarmListClass := TAlarmListClass(AlarmListGrid.Row[ARow].Data);

  if Assigned(LAlarmListClass) then
  begin
    LStr := GetUniqueTagName(LAlarmListClass.FParamIndex);
    i := FAlarmStrList.IndexOf(LStr);

    if i > -1 then //Data가 Map에 존재하면
    begin
      if LAlarmListClass.FNeedAck then
      begin
        DB_Alarm_Acked_Update_Zeos(LAlarmListClass.FSeqNo, now);
        FreeAndNil(LAlarmListClass);
        AlarmListGrid.Row[ARow].Data := nil;
        FAlarmStrList.Delete(i);
      end;
    end;
  end;
end;

procedure TFormAlarmList.AlarmListGridCellDblClick(Sender: TObject; ACol,
  ARow: Integer);
var
  LRect: TRect;
begin
  LRect := AlarmListGrid.GetHeaderRect;

  if PtInRect(LRect, FMousePoint) then
    exit;

//  ShowProperties;
end;

procedure TFormAlarmList.AlarmListGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  FMousePoint.X := X;
  FMousePoint.Y := Y;
end;

procedure TFormAlarmList.ChangeColor2AlarmListGrid(APIndex: integer; ACellColor,
  ATextColor: TColor);
var
  LCol: integer;
begin
  if (APIndex > -1) and (APIndex < AlarmListGrid.RowCount) then
  begin
    for LCol := 0 to AlarmListGrid.Columns.Count - 1 do
    begin
      if ACellColor <> $7FFFFFFF then
      begin
        AlarmListGrid.Cell[LCol, APIndex].Color := ACellColor;
      end;

      if ATextColor <> $7FFFFFFF then
      begin
        AlarmListGrid.Cell[LCol, APIndex].TextColor := ATextColor;
      end;
    end;
  end;
end;

function TFormAlarmList.CheckDBFile(AFileName: string): Boolean;
begin
  if AFileName = '' then
  begin
    Result := True;
    exit;
  end;

  if FileExists(AFileName) then
  begin
    Result := True;
  end
  else
    Result := False;
end;

procedure TFormAlarmList.CheckDigital(APIndex: integer;
  AUniqueTagName: string);
var
  j, LRow: integer;
  LSuccess, LAlarm: Boolean;
  LSeqNo: integer;
  LAlarmListClass: TAlarmListClass;
  LAlarmMessage: string;
  LDelay: TDateTime;
begin
  with IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex] do
  begin

    if not AlarmEnable then //inhibit
      exit;

    if (AlarmKind4AVAT2 = akaEvent) or (AlarmKind4AVAT2 = akaMessage) then
      exit;

    if not Alarm then//not analog type
    begin
      if StrToFloatDef(Value, 0.0) > 0.0 then
      begin
        case Contact of
          1: LAlarm := True; //A 접점
          2: LAlarm := False;//B 접점
          else
            LAlarm := True;//기타 값은 A접점으로 간주함
        end;
      end
      else
      begin
        case Contact of
          1: LAlarm := False; //A 접점
          2: LAlarm := True;//B 접점
          else
            LAlarm := False;//기타 값은 A접점으로 간주함
        end;
      end;

      if LAlarm then
      begin
        if MaxFaultDelay > 0 then
        begin
          //Alarm Delay
          if MaxFaultStartTime = 0 then
          begin
            MaxFaultStartTime := now;
            exit;
          end
          else
          begin
            LDelay := now - MaxFaultStartTime;

            //Delay 시간이 경과 하지 않은 경우
            if LDelay < MaxFaultDelay then
              exit;
          end;
        end;

        LAlarmListClass := nil;
        LAlarmMessage := Description;
        LAlarmListClass := AddData2AlarmListMap(APIndex, AUniqueTagName, LAlarmMessage);

        if Assigned(LAlarmListClass) then
        begin
          AddAlarmItem2AlarmListGrid(APIndex, LAlarmListClass);
          ChangeColor2AlarmListGrid(APIndex, FCellColor, FTextColor);
          DisplayAlarm2ItemGrid(APIndex, MaxAlarmColor);
        end;
      end
      else
      begin //Alarm 해제
        LRow := DeleteDataFromAlarmListMap_DB_IfNoAck(AUniqueTagName);
        ChangeColor2AlarmListGrid(LRow);
      end;
    end;
  end;//with
end;

procedure TFormAlarmList.CheckMaxFault(APIndex: integer;
  AUniqueTagName: string);
var
  j, LRow: integer;
  LSuccess: Boolean;
  LSeqNo: integer;
  LAlarmListClass: TAlarmListClass;
  LAlarmMessage: string;
  LDelay: TDateTime;
begin
  with IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex] do
  begin
    if MaxFaultEnable then
    begin //Fault 발생
      if StrToFloatDef(Value, 0.0) > MaxFaultValue then
      begin
        if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxFaultDelay > 0 then
        begin
          //Alarm Delay
          if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxFaultStartTime = 0 then
          begin
            IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxFaultStartTime := now;
            exit;
          end
          else
          begin
            LDelay := now - IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxFaultStartTime;

            //Delay 시간이 경과 하지 않은 경우
            if LDelay < IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxFaultDelay then
              exit;
          end;
        end;

        LAlarmMessage := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].Description + 'High Alarm';
        LAlarmListClass := AddData2AlarmListMap(APIndex,AUniqueTagName, LAlarmMessage);

        if Assigned(LAlarmListClass) then
        begin
          AddAlarmItem2AlarmListGrid(APIndex, LAlarmListClass);
          DisplayAlarm2ItemGrid(APIndex, MaxFaultColor);
        end;
      end
      else
      if StrToFloatDef(Value, 0.0) <= (MaxFaultValue - MaxFaultDeadBand) then
      begin //Alarm 해제
        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxFaultStartTime := 0;
        LRow := DeleteDataFromAlarmListMap_DB_IfNoAck(AUniqueTagName);

        if (LRow > -1) and (LRow < AlarmListGrid.RowCount) then
        begin
          for j := 0 to AlarmListGrid.Columns.Count - 1 do
            AlarmListGrid.Cell[j, LRow].Color := DefaultAlarmListCellColor;
        end;
      end;
    end;
  end;//with
end;

procedure TFormAlarmList.CheckMaxWarn(APIndex: integer;
  AUniqueTagName: string);
var
  j, LRow: integer;
  LSuccess: Boolean;
  LSeqNo: integer;
  LAlarmListClass: TAlarmListClass;
  LAlarmMessage: string;
  LDelay: TDateTime;
begin
  with IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex] do
  begin
    if MaxAlarmEnable then
    begin //Alarm 발생
      if StrToFloatDef(Value, 0.0) > MaxAlarmValue then
      begin
        if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxAlarmDelay > 0 then
        begin
          //Alarm Delay
          if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxAlarmStartTime = 0 then
          begin
            IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxAlarmStartTime := now;
            exit;
          end
          else
          begin
            LDelay := now - IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxAlarmStartTime;

            //Delay 시간이 경과 하지 않은 경우
            if LDelay < IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxAlarmDelay then
              exit;
          end;
        end;

        LAlarmMessage := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].Description + 'High Alarm';
        LAlarmListClass := AddData2AlarmListMap(APIndex,AUniqueTagName, LAlarmMessage);

        if Assigned(LAlarmListClass) then
        begin
          AddAlarmItem2AlarmListGrid(APIndex, LAlarmListClass);
          DisplayAlarm2ItemGrid(APIndex, MaxAlarmColor);
        end;
      end
      else
      if StrToFloatDef(Value, 0.0) <= (MaxAlarmValue - MaxAlarmDeadBand) then
      begin //Alarm 해제
        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MaxAlarmStartTime := 0;
        LRow := DeleteDataFromAlarmListMap_DB_IfNoAck(AUniqueTagName);

        if (LRow > -1) and (LRow < AlarmListGrid.RowCount) then
        begin
          for j := 0 to AlarmListGrid.Columns.Count - 1 do
            AlarmListGrid.Cell[j, LRow].Color := DefaultAlarmListCellColor;
        end;
      end;
    end;
  end;//with
end;

procedure TFormAlarmList.CheckMinFault(APIndex: integer;
  AUniqueTagName: string);
var
  j, LRow: integer;
  LSuccess: Boolean;
  LSeqNo: integer;
  LAlarmListClass: TAlarmListClass;
  LAlarmMessage: string;
  LDelay: TDateTime;
begin
  with IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex] do
  begin
    if MinFaultEnable then
    begin //Fault 발생
      if StrToFloatDef(Value, 0.0) < MinFaultValue then
      begin
        if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinFaultDelay > 0 then
        begin
          //Alarm Delay
          if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinFaultStartTime = 0 then
          begin
            IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinFaultStartTime := now;
            exit;
          end
          else
          begin
            LDelay := now - IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinFaultStartTime;

            //Delay 시간이 경과 하지 않은 경우
            if LDelay < IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinFaultDelay then
              exit;
          end;
        end;

        LAlarmMessage := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].Description + 'Low Alarm';
        LAlarmListClass := AddData2AlarmListMap(APIndex,AUniqueTagName, LAlarmMessage);

        if Assigned(LAlarmListClass) then
        begin
          AddAlarmItem2AlarmListGrid(APIndex, LAlarmListClass);
          DisplayAlarm2ItemGrid(APIndex, MinFaultColor);
        end
        else
        begin

        end;
      end
      else
      if StrToFloatDef(Value, 0.0) >= (MinFaultValue+MinFaultDeadBand) then
      begin //Alarm 해제
        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinFaultStartTime := 0;

        LRow := DeleteDataFromAlarmListMap_DB_IfNoAck(AUniqueTagName);

        if (LRow > -1) and (LRow < AlarmListGrid.RowCount) then
        begin
          for j := 0 to AlarmListGrid.Columns.Count - 1 do
            AlarmListGrid.Cell[j, LRow].Color := DefaultAlarmListCellColor;
        end;
      end;
    end;
  end;//with
end;

procedure TFormAlarmList.CheckMinWarn(APIndex: integer;
  AUniqueTagName: string);
var
  j, LRow: integer;
  LSuccess: Boolean;
  LSeqNo: integer;
  LAlarmListClass: TAlarmListClass;
  LAlarmMessage: string;
  LDelay: TDateTime;
begin
  with IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex] do
  begin
    if MinAlarmEnable then
    begin //Alarm 발생
      if StrToFloatDef(Value, 0.0) < MinAlarmValue then
      begin
        if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinAlarmDelay > 0 then
        begin
          //Alarm Delay
          if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinAlarmStartTime = 0 then
          begin
            IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinAlarmStartTime := now;
            exit;
          end
          else
          begin
            LDelay := now - IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinAlarmStartTime;

            //Delay 시간이 경과 하지 않은 경우
            if LDelay < IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinAlarmDelay then
              exit;
          end;
        end;

        LAlarmMessage := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].Description + 'Low Alarm';
        LAlarmListClass := AddData2AlarmListMap(APIndex,AUniqueTagName, LAlarmMessage);

        if Assigned(LAlarmListClass) then
        begin
          AddAlarmItem2AlarmListGrid(APIndex, LAlarmListClass);
          DisplayAlarm2ItemGrid(APIndex, MinAlarmColor);
        end;
      end
      else
      if StrToFloatDef(Value, 0.0) >= (MinAlarmValue+MinAlarmDeadBand) then
      begin //Alarm 해제
        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].MinAlarmStartTime := 0;
        LRow := DeleteDataFromAlarmListMap_DB_IfNoAck(AUniqueTagName);

        if (LRow > -1) and (LRow < AlarmListGrid.RowCount) then
        begin
          for j := 0 to AlarmListGrid.Columns.Count - 1 do
            AlarmListGrid.Cell[j, LRow].Color := DefaultAlarmListCellColor;
        end;
      end;
    end;
  end;//with
end;

procedure TFormAlarmList.ChildFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action   := caFree;
end;

procedure TFormAlarmList.ClearAllDB;
var
  LSQLParamDict: TSQLParamDict;
  LSQL: string;
  i: integer;
begin
  LSQLParamDict := TSQLParamDict.Create;
  try
    LSQL := 'delete from AlarmList';
    DB_Alarm_Delect(LSQL, LSQLParamDict);
  finally
    LSQLParamDict.Free;
  end;

end;

procedure TFormAlarmList.ClearAllDB1Click(Sender: TObject);
begin
  ClearAllDB;
end;

procedure TFormAlarmList.Config2Click(Sender: TObject);
begin
  SetConfig;
end;

procedure TFormAlarmList.CreateNShowWirePathForm(
  AEngParam: TEngineParameterItem);
var
  LSensorCableRouteF: TSensorCableRouteF2;
  LSensorRouteDBName,
  LManualPath, LDrawingPath: string;
  LEngParamFileIsDB: Boolean;
begin
  LSensorCableRouteF := TSensorCableRouteF2.Create(Self);
  LSensorCableRouteF.OnClose := ChildFormClose;

  if (AEngParam.ManualNo = '') or (AEngParam.DrawingNo = '') then
  begin
    ShowMessage('The Engparam.ManualNo value is null');
  end
  else
  begin
    LManualPath := AEngParam.ManualNo;
    LDrawingPath := AEngParam.DrawingNo;

    if GetFullFilePathFromManualInfo(LDrawingPath, LManualPath) then
      LSensorCableRouteF.FrameDecTV1.SetFileName(FFilePath, LDrawingPath, LManualPath);
  end;

  LSensorCableRouteF.FrameDecTV1.SetAppPath(FFilePath);

  LSensorRouteDBName := GetDbPathFromApplicationsFolder() + DefaultSensorRouteDBFileName;

  LSensorCableRouteF.FrameDecTV1.LoadFromFileDB(LSensorRouteDBName,
    AEngParam.ProjNo, AEngParam.EngNo, AEngParam.TagName, FWatchListFileName,
    True);//, LEngParamFileIsDB

  try
    LSensorCableRouteF.ShowModal;
  finally
    LSensorCableRouteF.Free;
  end;
end;

procedure TFormAlarmList.DB_Alarm_Acked_Update(ASeqNo: integer;
  ATime: TDateTime);
begin

end;

procedure TFormAlarmList.DB_Alarm_Acked_Update_Zeos(ASeqNo: integer;
  ATime: TDateTime);
var
  LIssueDate: TDateTime;
  LSQL: string;
begin
//  ZQuery1.Close;
//  ZQuery1.SQL.Clear;
//  LSQL := 'UPDATE ALARMLIST SET ';
//  LSQL := LSQL + 'AckedDateTime = :AckedDateTime';
//  LSQL := LSQL + ' WHERE ';
//  LSQL := LSQL + 'SeqNo = :SeqNo and ';
//  LSQL := LSQL + 'ReleaseDateTime > 0 and';
//  LSQL := LSQL + 'AckedDateTime = 0';
//  ZQuery1.SQL.Add(LSQL);
//  ZQuery1.Prepare;
//
//  if ZQuery1.Params.Count > 0 then
//  begin
//    ZQuery1.ParamByName('AckedDateTime').AsFloat := ATime;
//    ZQuery1.ParamByName('SeqNo').AsInteger := ASeqNo;
//    ZQuery1.ExecSQL;
//  end;
end;

procedure TFormAlarmList.DB_Alarm_Delect(ASql: string;
  AParamList: TSQLParamDict);
var
  LKey: String;
begin
//  FQuery.Close;
//  FQuery.SQL.Clear;
//  FQuery.SQL.Add(ASql);
//  FQuery.Prepare;
//
//  if FQuery.Params.Count = AParamList.Count then
//  begin
//    for LKey in AParamList.Keys do
//    begin
//      case AParamList.Items[LKey] of
//        sptNull: FQuery.ParamByName(LKey).AsInteger;
//        sptReal: FQuery.ParamByName(LKey).AsFloat;
//        sptInteger: FQuery.ParamByName(LKey).AsInteger;
//        sptText: FQuery.ParamByName(LKey).AsString;
//        sptBlob: FQuery.ParamByName(LKey).AsBlob;
//      end;
//    end;
//
//    FQuery.ExecSQL;
//  end;
end;

function TFormAlarmList.DB_Alarm_insert(ARecord: TAlarmListClass): integer;
var
  LIssueDate: TDateTime;
  LSQL: string;
  Rec: TOrmHiMECSAlarmList;
begin
  Result := -1;

  Rec := TOrmHiMECSAlarmList.Create;
  try
    ARecord.AssignAlarmListClass2Record(Rec);

    if FAlarmRestClient.Orm.Add(Rec,true) = 0 then
      ShowMessage('Error adding the data')
  finally
    Rec.Free;
  end;
end;

procedure TFormAlarmList.DB_Alarm_Release_Update(ATagName: string;
  ATime: TDateTime);
var
  Rec: TOrmHiMECSAlarmList;
begin
  Rec := TOrmHiMECSAlarmList.Create(FAlarmRestClient.Orm, 'TagName=? and ReleaseDateTime=?',[StringToUTF8(ATagName),0]);
  try
    if Rec.ID<>0 then
    begin
      Rec.ReleaseDateTime := TimeLogFromDateTime(ATime);

      if not FAlarmRestClient.Orm.Update(Rec) then
        ShowMessage('Error update the ReleaseDateTime')
    end;
  finally
    Rec.Free;
  end;
end;

procedure TFormAlarmList.DB_Alarm_Select(ASql: string;
  AParamList: TSQLParamDict; AValueList: TStringList);
var
  LKey: String;
  i: integer;
begin
//  FQuery.Close;
//  FQuery.SQL.Clear;
//  FQuery.SQL.Add(ASql);
//  FQuery.Prepare;
//
//  if (FQuery.Params.Count = AParamList.Count) and
//    (AParamList.Count = AValueList.Count) then
//  begin
//    i := 0;
//
//    for LKey in AParamList.Keys do
//    begin
//      case AParamList.Items[LKey] of
//        sptNull: FQuery.ParamByName(LKey).AsInteger := StrToInt(AValueList.Strings[i]);
//        sptReal: FQuery.ParamByName(LKey).AsFloat :=  StrToFloat(AValueList.Strings[i]);
//        sptInteger: FQuery.ParamByName(LKey).AsInteger := StrToInt(AValueList.Strings[i]);
//        sptText: FQuery.ParamByName(LKey).AsString := AValueList.Strings[i];
//        //sptBlob: FQuery.ParamByName(LKey).AsBlob := StrToInt(AValueList.Strings[i]);
//      end;
//
//      inc(i);
//    end;
//
//    FQuery.Open;
//  end;
end;

procedure TFormAlarmList.DB_Alarm_Ack_Update(ATagName: string;
  ATime: TDateTime);
var
  Rec: TOrmHiMECSAlarmList;
begin
  Rec := TOrmHiMECSAlarmList.Create(FAlarmRestClient.Orm, 'TagName=? and AcknowledgedTime=?',[StringToUTF8(ATagName),0]);
  try
    if Rec.ID<>0 then
    begin
      Rec.AcknowledgedTime := TimeLogFromDateTime(ATime);

      if not FAlarmRestClient.Orm.Update(Rec) then
        ShowMessage('Error update the AcknowledgedTime')
    end;
  finally
    Rec.Free;
  end;
end;

procedure TFormAlarmList.DB_Create_Table;
var
  LStr: string;
begin
  if FAlarmConfig.ManualFileName = '' then
  begin
    ShowMessage('ManualFileName empty!');
    exit;
  end;

  if FAlarmConfig.AlarmDBFileName = '' then
  begin
    ShowMessage('AlarmDBFileName empty!');
    exit;
  end;

  if not Assigned(FAlarmRestClient) then
  begin
    FAlarmRecord := CreateHiMECSAlarmListModel();
    FAlarmRestClient := THiMECSAlarmRestClient.Create(FAlarmRecord, nil, ChangeFileExt(Executable.ProgramFileName,'.db'), TRestServerDB, false, '');
    FAlarmRestClient.Server.Server.CreateMissingTables;
  end;
end;

//Result = AlarmListGrid의 RowIndex임.
procedure TFormAlarmList.DeleteAlaramFromAlarmListGrid(AGridRowIdx: integer);
begin
  AlarmListGrid.DeleteRow(AGridRowIdx);
end;

function TFormAlarmList.DeleteDataFromAlarmListMap_DB_IfNoAck(
  AUniqueTagName: string): integer;
var
  LSeqNo: integer;
  LAlarmListClass: TAlarmListClass;
  LNow: TDateTime;
begin
  Result := FAlarmStrList.IndexOf(AUniqueTagName);

  if Result > -1 then //Data가 Map에 존재하면
  begin
    LAlarmListClass := TAlarmListClass(FAlarmStrList.Objects[Result]);

    LSeqNo := LAlarmListClass.FSeqNo;
    LNow := now;

    if LAlarmListClass.FNeedAck then
    begin
      UpdateAlarmListGrid(Result, LNow);
    end
    else
    begin
      FreeAndNil(LAlarmListClass);
      FAlarmStrList.Delete(Result);
      DeleteAlaramFromAlarmListGrid(Result);
    end;

    DB_Alarm_Release_Update(LAlarmListClass.FTagName, LNow);
  end;
end;

procedure TFormAlarmList.DisplayAlarm2ItemGrid(APIndex: integer;
  ACellColor, ATextColor: TColor);
var
  LCol: integer;
begin
  if ACellColor = 0 then
    ACellColor := DefaultAlarmListCellColor4True;

  if ATextColor = 0 then
    ATextColor := DefaultAlarmListTextColor;

  with IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex] do
  begin
    for LCol := 0 to FWG.NextGrid1.Columns.Count - 1 do
    begin
      if ACellColor <> $7FFFFFFF then
      begin
        FWG.NextGrid1.Cell[LCol, APIndex].Color := ACellColor;
      end;

      if ATextColor <> $7FFFFFFF then
      begin
        FWG.NextGrid1.Cell[LCol, APIndex].TextColor := ATextColor;
      end;
    end;
  end;//with
end;

procedure TFormAlarmList.EnableAlphaCBClick(Sender: TObject);
begin
  AlphaBlend := EnableAlphaCB.Checked;
end;

procedure TFormAlarmList.est1Click(Sender: TObject);
begin
  TestDBInsert;
end;

procedure TFormAlarmList.Find1Click(Sender: TObject);
begin
  FWG.ShowFindForm;
end;

procedure TFormAlarmList.FindNext1Click(Sender: TObject);
begin
  FWG.FindNextGrid;
end;

procedure TFormAlarmList.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  i: integer;
  LAlarmListClass: TAlarmListClass;
begin
  IPCMonitorAll1.SetIsUseIPCSharedMMEvent(False);

  FSettings.Free;
  FPJHTimerPool.RemoveAll;
  FPJHTimerPool.Free;
  IPCMonitorAll1.DestroyIPCMonitorAll;
  FEngineParameterTarget.Free;
  FEngParamSource.Free;
  FHiMECSManualInfo.Free;
  //////////////////////////
  FAlarmConfig.Free;

  FAlarmRestClient.Free;
  FAlarmRecord.Free;

  for i := 0 to  FAlarmStrList.count - 1 do
  begin
    LAlarmListClass := TAlarmListClass(FAlarmStrList.Objects[i]);
    LAlarmListClass.Free;
  end;

  FAlarmStrList.Free;
  FAlarmDelayDict.Free;
end;

procedure TFormAlarmList.FormCreate(Sender: TObject);
begin
  InitVar;
  InitAlarmList;

  Timer1.Enabled := True;

  FWG.NextGrid1.DoubleBuffered := False;
  AlarmListGrid.DoubleBuffered := False;
  dt_begin.Date := Now;
  dt_end.Date   := Now;
end;

//procedure TFormAlarmList.GetFields2Grid(ADb: TSivak3Database;
//  ATableName: String; AGrid: TNextGrid);
//var
//  LnxTextColumn: TnxTextColumn;
//  LStrList: TStringList;
//  Li: integer;
//begin
//  LStrList := TStringList.Create;
//  try
//    ADb.GetFieldNames(LStrList, ATableName);
//
//    if LStrList.Count > 0 then
//    begin
//      with AGrid do
//      begin
//        ClearRows;
//        Columns.Clear;
//        //Columns.Add(TnxIncrementColumn,'No.');
//      end;
//    end;
//
//    for Li := 0 to LStrList.Count - 1 do
//    begin
//      with AGrid do
//      begin
//        LnxTextColumn := TnxTextColumn(Columns.Add(TnxTextColumn, LStrList[Li]));
//        LnxTextColumn.Name := LStrList[Li];
//        LnxTextColumn.Header.Alignment := taCenter;
//        LnxTextColumn.Options := [coCanClick,coCanInput,coCanSort,coEditing,coEditorAutoSelect,coPublicUsing,coShowTextFitHint];
//      end;
//    end;
//  finally
//    LStrList.Free;
//  end;
//end;

procedure TFormAlarmList.GetCellNTextColorFromAlarmClass(
  var ACellColor, ATextColor: TColor);
begin
  if FAlarmConfig.AlarmCellColor = '' then
    ACellColor := DefaultAlarmListCellColor4True
  else
    ACellColor := Str2Color(FAlarmConfig.AlarmCellColor);

  if FAlarmConfig.AlarmTextColor = '' then
    ATextColor := DefaultAlarmListTextColor
  else
    ATextColor := Str2Color(FAlarmConfig.AlarmTextColor);
end;

function TFormAlarmList.GetDbPathFromApplicationsFolder: string;
begin
  Result := GetParentFolder(FFilePath) + 'db\'
end;

function TFormAlarmList.GetEngItemFromTagName(
  var ATagName: string): TEngineParameterItem;
begin
  ATagName := GetUnUniqueTagName(ATagName);
  ATagName := GetSensorTagNameFrmUnUnique(ATagName);
  Result := IPCMonitorAll1.FEngineParameter.GetItemFromTagName(ATagName);
end;

function TFormAlarmList.GetFromDay(ADate: TDateTime): TDateTime;
var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  DecodeDate(ADate, Year, Month, Day);
  Result := EncodeDate(Year, Month, Day);
end;

function TFormAlarmList.GetFullFilePathFromManualInfo(var ADrawingPath,
  AManualPath: string): Boolean;
var
  i: integer;
begin
  for i := 0 to FHiMECSManualInfo.OpManual.Count - 1 do
  begin
    if FHiMECSManualInfo.OpManual.Items[i].FileName = AManualPath then
    begin
      AManualPath := FHiMECSManualInfo.OpManual.Items[i].FilePath + AManualPath;
      Break;
    end;
  end;

  for i := 0 to FHiMECSManualInfo.Drawings.Count - 1 do
  begin
    if FHiMECSManualInfo.Drawings.Items[i].FileName = ADrawingPath then
    begin
      ADrawingPath := FHiMECSManualInfo.Drawings.Items[i].FilePath + ADrawingPath;
      Break;
    end;
  end;

  Result := (ExtractFilePath(AManualPath) + ExtractFilePath(ADrawingPath)) <> '';
end;

function TFormAlarmList.GetSensorTagNameFrmUnUnique(
  AUnUniqueTagName: string): string;
begin
  Result := strToken(AUnUniqueTagName, '-');
  Result := Result + '-' + strToken(AUnUniqueTagName, '-');
end;

function TFormAlarmList.GetTagNameFromAlarmListRowIdx(ARowIdx: integer): string;
var
  LAlarmListClass: TAlarmListClass;
begin
  Result := '';

  if ARowIdx = -1 then
    exit;

  LAlarmListClass := TAlarmListClass(AlarmListGrid.Row[ARowIdx].Data);

  if Assigned(LAlarmListClass) then
  begin
    Result := LAlarmListClass.FTagName;
  end;
end;

function TFormAlarmList.GetToDay(ADate: TDateTime): TDateTime;
var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  DecodeDate(ADate + 1, Year, Month, Day);
  Result := EncodeDate(Year, Month, Day);
end;

function TFormAlarmList.GetUniqueTagName(APIndex: integer): string;
begin
  Result := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].TagName + '_'  +
    IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].EngNo;//여러 엔진중  파라미터 tagname의 중복을 피하기 위해 ShardName을 추가함
//    IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[APIndex].SharedName;//여러 엔진중  파라미터 tagname의 중복을 피하기 위해 ShardName을 추가함
end;

function TFormAlarmList.GetUnUniqueTagName(AUniqueTagName: string): string;
var
  i: integer;
begin
  TrimRightCharPos(AUniqueTagName, '_');
  Result := AUniqueTagName;
end;

procedure TFormAlarmList.Gotoitem1Click(Sender: TObject);
var
  LRect: TRect;
begin
  LRect := AlarmListGrid.GetHeaderRect;

  if PtInRect(LRect, FMousePoint) then
    exit;

  GotoItemGridFromAlarmListRowIdx(AlarmListGrid.SelectedRow);
end;

procedure TFormAlarmList.GotoItemGridFromAlarmListRowIdx(ARowIdx: integer);
var
  LTagName: string;
begin
  if ARowIdx = -1 then
    exit;

  LTagName := GetTagNameFromAlarmListRowIdx(ARowIdx);
  PageControl1.ActivePage := ItemsTabSheet;
  GotoItemGridFromTagName(LTagName);
end;

procedure TFormAlarmList.GotoItemGridFromTagName(ATagName: string);
begin
  ATagName := GetUnUniqueTagName(ATagName);
  FWG.FindGridFromOption(0, ATagName);
end;

procedure TFormAlarmList.UpdateAlarmListGrid(AGridRowIdx: integer;
  ATime: TDateTime);
//var
//  i: integer;
//  LALR: TAlarmListClass;
begin
//  for i := 0 to AlarmListGrid.RowCount - 1 do
//  begin
//    LALR := TAlarmListClass(AlarmListGrid.Row[i].Data);

//    if AAlarmListClass.FSeqNo = LALR.FSeqNo then
//    begin
      AlarmListGrid.CellsByName['TimeOut',AGridRowIdx] := FormatDateTime('yyyy-mm-dd hh:nn:ss', ATime);
//      break;
//    end;
//  end;
end;

procedure TFormAlarmList.InitAlarmList;
var
  LStr: string;
begin
  FAlarmDelayDict := TAlarmDelayDict.Create;
  FAlarmConfig := TAlarmConfig.Create(Self);
  LoadConfigCollectFromFile(FFilePath+DefaultAlarmListConfigFileName,
    DefaultEncryption);

  GetCellNTextColorFromAlarmClass(FCellColor, FTextColor);

  LoadManualInfo();

  if not CheckDBFile(FAlarmConfig.AlarmDBFileName) then
    DB_Create_Table;

  FWG.SetIPCMonitorAll(IPCMonitorAll1);

  LoadWatchListFromFile();

  FAlarmStrList := TStringList.Create;

  LoadAlarmDataFromDB();
end;

procedure TFormAlarmList.InitVar;
begin
  FSettings := TConfigSettings.create(ChangeFileExt(Application.ExeName, '.ini'));
  FFilePath := ExtractFilePath(Application.ExeName); //맨끝에 '\' 포함됨
  SetCurrentDir(FFilePath);

  IPCMonitorAll1.FNextGrid := FWG.NextGrid1;
  IPCMonitorAll1.FPageControl := PageControl1;
  IPCMonitorAll1.FWatchValue2Screen_AnalogEvent := WatchValue2Screen_Analog;
  IPCMonitorAll1.FWatchValue2Screen_DigitalEvent := WatchValue2Screen_Digital;
  IPCMonitorAll1.SetValue2ScreenEvent_2(WatchValue2Screen_Analog2);
  FPJHTimerPool := TPJHTimerPool.Create(nil);
  FCalculatedItemTimerHandle := -1;
  FEngineParameterTarget := TEngineParameterDataFormat.Create(DropTextTarget1);
  FEngParamSource := TEngineParameterDataFormat.Create(EngParamSource2);

  FHiMECSManualInfo := THiMECSManualInfo.Create(nil);
  FFirst := True;

  g_AlarmKind4AVAT2.InitArrayRecord(R_AlarmKind4AVAT2);
end;

procedure TFormAlarmList.JvTrackBar1Change(Sender: TObject);
begin
  if EnableAlphaCB.Checked then
    AlphaBlendValue := JvTrackBar1.Position;
end;

procedure TFormAlarmList.LoadAlarmDataFromDB;
var
  LSQLParamDict: TSQLParamDict;
  LValueList: TStringList;
  LSQL: string;
  i,j: integer;
begin
  LSQLParamDict := TSQLParamDict.Create;
  LValueList := TStringList.Create;
  try
    LSQL := 'select * from AlarmList where (IssueDateTime >= :Fromday and IssueDateTime <= :ToDay) or (ReleaseDateTime = 0)';
    LSQLParamDict.Add('Fromday', sptReal);
    LSQLParamDict.Add('ToDay', sptReal);
    LValueList.Add(FloatToStr(GetFromDay(now)));
    LValueList.Add(FloatToStr(GetToDay(now)));
    DB_Alarm_Select(LSQL, LSQLParamDict, LValueList);

//    if FQuery.Active then
//    begin
//      AlarmListGrid.ClearRows;
//
//      for i := 0 to FQuery.RecordCount - 1 do
//      begin
//        j := AlarmListGrid.AddRow();
//
//        TNxCheckBoxColumn(AlarmListGrid.Cell[0,j]).Visible := Boolean(FQuery.FieldByName('NeedAcked').AsInteger);
//
//        AlarmListGrid.Cells[CI_TIME_IN,i] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',TDateTime(FQuery.Fields[3].AsFloat));
//
//        if FQuery.Fields[4].AsFloat > 0 then
//          AlarmListGrid.Cells[CI_TIME_OUT,i] := FormatDateTime('yyyy-mm-dd hh:nn:ss.zzz',TDateTime(FQuery.Fields[4].AsFloat));
//
//        AlarmListGrid.Cells[CI_ENGINE_NO,i] := FQuery.Fields[1].AsString;
//        AlarmListGrid.Cells[CI_TAG_DESC,i] := FQuery.Fields[6].AsString;
//        AlarmListGrid.Cells[CI_ALARMMSG,i] := FQuery.Fields[7].AsString;
//        AlarmListGrid.Cells[CI_ALARMPRIO,i] := ArarmPriority2String(TAlarmPriority(FQuery.Fields[8].AsInteger));
//        FQuery.Next;
//      end;
//    end;
  finally
    LValueList.Free;
    LSQLParamDict.Free;
  end;
end;

procedure TFormAlarmList.LoadAlarmDataFromDB1Click(Sender: TObject);
begin
  LoadAlarmDataFromDB;
end;

procedure TFormAlarmList.LoadConfigCollect2Form(AForm: TAlarmConfigF);
begin
  AForm.ManualFileEdit.FileName := FAlarmConfig.ManualFileName;
  AForm.AlarmDBFilenameEdit.FileName := FAlarmConfig.AlarmDBFileName;
  AForm.AlarmItemFileEdit.FileName := FAlarmConfig.ModbusDBFileName;
  AForm.CreateDBIntervalRG.ItemIndex := FAlarmConfig.CreateDBInterval;
  AForm.RelPathCB.Checked := FAlarmConfig.IsRelativePath;
  AForm.AlarmFont := FAlarmConfig.AlarmFont;
  AForm.AlarmCellColorSelector.SelectedColor := Str2Color(FAlarmConfig.AlarmCellColor);
  AForm.AlarmTextColorSelector.SelectedColor := Str2Color( FAlarmConfig.AlarmTextColor);
  AForm.ShutdownCellColorSelector.SelectedColor := Str2Color( FAlarmConfig.ShutdownCellColor);
  AForm.ShutdownTextColorSelector.SelectedColor := Str2Color( FAlarmConfig.ShutdownTextColor);
end;

procedure TFormAlarmList.LoadConfigCollectFromFile(AFileName: string;
  AIsEncrypt: Boolean);
begin
  if AFileName <> '' then
  begin
    if not FileExists(AFileName) then
    begin
      ShowMessage('Config File name ('+AFileName+') is not exist!');
      exit;
    end;

    FAlarmConfig.Clear;
    FAlarmConfig.LoadFromJSONFile(AFileName,DefaultPassPhrase,AIsEncrypt);

    if FAlarmConfig.ManualFileName = '' then
      FAlarmConfig.ManualFileName := '.\sqlite3.dll';

    if FAlarmConfig.ModbusDBFileName <> '' then
      FWatchListFileName := FAlarmConfig.ModbusDBFileName;

    if FAlarmConfig.AlarmFont <> '' then
      SetAlarmListGridFont(FAlarmConfig.AlarmFont);
  end
  else
    ShowMessage('Config File name is empty!');
end;

procedure TFormAlarmList.LoadConfigForm2Collect(AForm: TAlarmConfigF);
var
  LStr: string;
begin
  FAlarmConfig.ManualFileName := AForm.ManualFileEdit.FileName;//IncludeTrailingPathDelimiter(AForm.ManualFileEdit.FileName);

  if AForm.RelPathCB.Checked then
  begin
    LStr := ExtractRelativePathBaseApplication(FFilePath, AForm.AlarmDBFilenameEdit.FileName);
    FAlarmConfig.AlarmDBFileName := LStr;

    LStr := ExtractRelativePathBaseApplication(FFilePath, AForm.AlarmItemFileEdit.FileName);
    FAlarmConfig.ModbusDBFileName := LStr;

    LStr := ExtractRelativePathBaseApplication(FFilePath, AForm.ManualFileEdit.FileName);
    FAlarmConfig.ManualFileName := LStr;
  end
  else
  begin
    FAlarmConfig.AlarmDBFileName := AForm.AlarmDBFilenameEdit.FileName;
    FAlarmConfig.ModbusDBFileName := AForm.AlarmItemFileEdit.FileName;
    FAlarmConfig.ManualFileName := AForm.ManualFileEdit.FileName;
  end;

  FAlarmConfig.CreateDBInterval := AForm.CreateDBIntervalRG.ItemIndex;
  FAlarmConfig.IsRelativePath := AForm.RelPathCB.Checked;
  FAlarmConfig.AlarmFont := AForm.AlarmFont;
  FAlarmConfig.AlarmCellColor := Color2Str(AForm.AlarmCellColorSelector.SelectedColor);
  FAlarmConfig.AlarmTextColor := Color2Str(AForm.AlarmTextColorSelector.SelectedColor);
  FAlarmConfig.ShutdownCellColor := Color2Str(AForm.ShutdownCellColorSelector.SelectedColor);
  FAlarmConfig.ShutdownTextColor := Color2Str(AForm.ShutdownTextColorSelector.SelectedColor);
end;

procedure TFormAlarmList.LoadManualInfo;
begin
  FHiMECSManualInfo.LoadFromJSONFile(FAlarmConfig.ManualFileName);
end;

procedure TFormAlarmList.LoadWatchListFromFile;
var
  LStr: string;
begin
  if FileExists(FWatchListFileName) then
  begin
    LStr := ExtractFileExt(FWatchListFileName);

    if (Pos('sqlite', LStr) = 0) or (Pos('db', LStr) = 0) then
    begin
//      if IPCMonitorAll1.FEngineParameter.LoadFromSqliteFile4Secure(FWatchListFileName, eplikModbus) = -1 then
      if IPCMonitorAll1.FEngineParameter.LoadFromSqliteFile(FWatchListFileName, eplikModbus) = -1 then
        ShowMessage('Fail to load parameter from DB => "' + FWatchListFileName + '"')
      else
      begin
        FWG.AddEngineParameter2Grid(nil, eplikModbus);

        ShowMessage(IntToStr(IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count) +
          ' items are loaded from ModbusDB (' + FWatchListFileName + ')');
      end;
    end;
  end
  else
    ShowMessage('DB File (' + FWatchListFileName + ') is not exists!');
end;

procedure TFormAlarmList.LoadWatchListFromFile1Click(Sender: TObject);
begin
  SetCurrentDir(FFilePath);
  JvOpenDialog1.InitialDir := WatchListPath;
  JvOpenDialog1.Filter := '*.*';

  if JvOpenDialog1.Execute then
  begin
    if jvOpenDialog1.FileName <> '' then
    begin
      FWatchListFileName := jvOpenDialog1.FileName;
//      GetEngineParameterFromSavedFile(FWatchListFileName, False);
    end;
  end;

end;

procedure TFormAlarmList.AckChange(Sender: TObject);
var
  LRow: integer;
begin
  LRow := AlarmListGrid.SelectedRow;

  if AlarmListGrid.Cell[CI_ACKED, LRow].AsBoolean then
  begin
    AlarmAcknowledge(LRow);
  end
  else
    AlarmListGrid.Cell[CI_ACKED, LRow].AsBoolean := True;
end;

procedure TFormAlarmList.rg_periodClick(Sender: TObject);
begin
  dt_begin.Enabled := False;
  dt_end.Enabled   := False;
  case rg_period.ItemIndex of
    0 :
    begin
      dt_begin.Date := Now;
      dt_end.Date   := Now;
    end;
    1 :
    begin
      dt_begin.Date := StartOfTheWeek(Now);
      dt_end.Date   := EndOfTheWeek(Now);
    end;
    2 :
    begin
      dt_begin.Date := StartOfTheMonth(Now);
      dt_end.Date   := EndOfTheMonth(Now);
    end;
    3 :
    begin
      dt_begin.Enabled := True;
      dt_end.Enabled   := True;
    end;
  end;
end;


procedure TFormAlarmList.SaveWatchLittoNewName1Click(Sender: TObject);
var
  LFileName: string;
begin
  SetCurrentDir(FFilePath);
  JvSaveDialog1.InitialDir := '..\WatchList';

  if JvSaveDialog1.Execute then
  begin
    LFileName := JvSaveDialog1.FileName;

    if FileExists(LFileName) then
    begin
      if MessageDlg('File is already existed. Are you overwrite? if No press, then the data is not saved!.',
      mtConfirmation, [mbYes, mbNo], 0)= mrNo then
        exit;
    end;
  end;

//  SaveWatchFile(LFileName, '');
end;

procedure TFormAlarmList.SetAlarmDisable1Click(Sender: TObject);
begin
  SetAlarmEnable(False);
end;

procedure TFormAlarmList.SetAlarmEnable(AEnable: Boolean);
var
  i: integer;
begin
  FAlarmSettDoing := True;

  for i := 0 to FWG.NextGrid1.RowCount - 1 do
  begin
    if FWG.NextGrid1.Row[i].Selected then
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].AlarmEnable := AEnable;
  end;

  ShowMessage('Selected Item''s AlarmEnable set to ''' + BoolToStr(AEnable, true) + ''' is finished');
  FAlarmSettDoing := False;
end;

procedure TFormAlarmList.SetAlarmEnable1Click(Sender: TObject);
begin
  SetAlarmEnable(True);
end;

procedure TFormAlarmList.SetAlarmListGridFont(AFontJson: string);
var
  i: integer;
begin
  for i := 0 to AlarmListGrid.Columns.Count - 1 do
    LoadFontFromJson(AFontJson, AlarmListGrid.Columns.Item[i].Font);
end;

procedure TFormAlarmList.SetConfig;
var
  ConfigData: TAlarmConfigF;
begin
  ConfigData := nil;
  ConfigData := TAlarmConfigF.Create(Self);
  try
    with ConfigData do
    begin
      LoadConfigCollect2Form(ConfigData);

      if ShowModal = mrOK then
      begin
        SetCurrentDir(FFilePath);
        LoadConfigForm2Collect(ConfigData);
        FAlarmConfig.SaveToJSONFile(FFilePath + DefaultAlarmListConfigFileName);
      end;
    end;//with
  finally
    FreeAndNil(ConfigData);
  end;//try
end;

procedure TFormAlarmList.ShowWirePath;
var
  LEngineParameterItem: TEngineParameterItem;
  LTagName: string;
  LRect: TRect;
begin
  LRect := AlarmListGrid.GetHeaderRect;

  if PtInRect(LRect, FMousePoint) then
    exit;

  LTagName := GetTagNameFromAlarmListRowIdx(AlarmListGrid.SelectedRow);
  LEngineParameterItem := GetEngItemFromTagName(LTagName);

  if Assigned(LEngineParameterItem) then
    CreateNShowWirePathForm(LEngineParameterItem)
  else
    ShowMessage('TagName(' + LTagName + ') is not exist in the sensor list');
end;

procedure TFormAlarmList.ShowWirePath1Click(Sender: TObject);
begin
  ShowWirePath();
end;

procedure TFormAlarmList.StayOnTopCBClick(Sender: TObject);
begin
  if StayOnTopCB.Checked then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;

procedure TFormAlarmList.TestDBInsert;
var
  LSQL: string;
begin
//  ZConnection1.Database := FFilePath + 'AlarmList.db3';
//  ZConnection1.Connect;
//
//  if ZConnection1.Connected then
//  begin
//    ZQuery1.SQL.Clear;
//    LSQL := 'INSERT INTO ';
//    LSQL := LSQL + 'AlarmList' + ' ('#13#10;
//    LSQL := LSQL + 'EngineNo' + ',';
//    LSQL := LSQL + 'AlarmLevel' + ',';
//    LSQL := LSQL + 'IssueDateTime' + ',';
//    LSQL := LSQL + 'ReleaseDateTime' + ',';
//    LSQL := LSQL + 'TagName' + ',';
//    LSQL := LSQL + 'TagDesc' + ',';
//    LSQL := LSQL + 'AlarmMessage' + ',';
//    LSQL := LSQL + 'AlarmPriority' + ',';
//    LSQL := LSQL + 'AckedDateTime' + ',';
//    LSQL := LSQL + 'AlarmSuppressed' + ',';
//    LSQL := LSQL + 'NeedAcked' + ',';
//    LSQL := LSQL + 'SensorCode' + ')';
//    LSQL := LSQL + ' VALUES ('#13#10;
//    LSQL := LSQL + ':EngineNo, :AlarmLevel,:IssueDateTime,:ReleaseDateTime,';
//    LSQL := LSQL + ':TagName,:TagDesc,:AlarmMessage,:AlarmPriority,:AckedDateTime,';
//    LSQL := LSQL + ':AlarmSuppressed, :NeedAcked, :SensorCode' + ')';
//    ZQuery1.SQL.Add(LSQL);
//    ZQuery1.Prepare;
//    //FExec.CommandText.Add(LSQL);
//    if ZQuery1.Params.Count > 0 then
//    begin
//      ZQuery1.ParamByName('EngineNo').AsString := 'ARecord.FEngineNo';
//      ZQuery1.ParamByName('AlarmLevel').AsInteger := 1;
//      ZQuery1.ParamByName('IssueDateTime').AsFloat := 2;
//      ZQuery1.ParamByName('ReleaseDateTime').AsFloat := 3;
//      ZQuery1.ParamByName('TagName').AsString := 'ARecord.FTagName';
//      ZQuery1.ParamByName('TagDesc').AsString := 'ARecord.FTagDesc';
//      ZQuery1.ParamByName('AlarmMessage').AsString := 'ARecord.FAlarmDesc';
//      ZQuery1.ParamByName('AlarmPriority').AsInteger := 4;
//      ZQuery1.ParamByName('AckedDateTime').AsFloat := 0;
//      ZQuery1.ParamByName('AlarmSuppressed').AsInteger := 6;
//      ZQuery1.ParamByName('NeedAcked').AsInteger := 0;
//      ZQuery1.ParamByName('SensorCode').AsString :=' ARecord.FSensorCode';
//
//      ZQuery1.ExecSQL;
//
//    end;
//  end;

{  FQuery.Close;
  FQuery.SQL.Clear;
  LSQL := 'INSERT INTO ';
  LSQL := LSQL + CheckQuotation('AlarmList') + ' ('#13#10;
  LSQL := LSQL + CheckQuotation('EngineNo') + ',';
  LSQL := LSQL + CheckQuotation('AlarmLevel') + ',';
  LSQL := LSQL + CheckQuotation('IssueDateTime') + ',';
  LSQL := LSQL + CheckQuotation('ReleaseDateTime') + ',';
  LSQL := LSQL + CheckQuotation('TagName') + ',';
  LSQL := LSQL + CheckQuotation('TagDesc') + ',';
  LSQL := LSQL + CheckQuotation('AlarmMessage') + ',';
  LSQL := LSQL + CheckQuotation('AlarmPriority') + ',';
  LSQL := LSQL + CheckQuotation('AlarmAcked') + ',';
  LSQL := LSQL + CheckQuotation('AlarmSuppressed') + ',';
  LSQL := LSQL + CheckQuotation('SensorCode') + ')';
  LSQL := LSQL + ' VALUES ('#13#10;
  LSQL := LSQL + ':EngineNo, :AlarmLevel,:IssueDateTime,:ReleaseDateTime,';
  LSQL := LSQL + ':TagName,:TagDesc,:AlarmMessage,:AlarmPriority,:AlarmAcked,';
  LSQL := LSQL + ':AlarmSuppressed, :SensorCode' + ')';
  FQuery.SQL.Add(LSQL);
  FQuery.Prepare;

  if FQuery.Params.Count > 0 then
  begin
    FQuery.ParamByName('SensorCode').AsString := 'FSensorCode';
    FQuery.ParamByName('AlarmMessage').AsString := 'FAlarmDesc';
    FQuery.ParamByName('TagDesc').AsString := 'FTagDesc';
    FQuery.ParamByName('TagName').AsString := 'FTagName';
    FQuery.ParamByName('EngineNo').AsString := 'FEngineNo';
    FQuery.ParamByName('AlarmLevel').AsInteger := 0;
    FQuery.ParamByName('IssueDateTime').AsFloat := 1;
    FQuery.ParamByName('ReleaseDateTime').AsFloat := 2;
    FQuery.ParamByName('AlarmPriority').AsInteger := 3;
    FQuery.ParamByName('AlarmAcked').AsInteger := 4;
    FQuery.ParamByName('AlarmSuppressed').AsInteger := 5;

    FQuery.ExecSQL;
  end;
}
{  FQuery.Close;
  FQuery.SQL.Clear;
  LSQL := 'INSERT INTO ';
  LSQL := LSQL + CheckQuotation('AlarmList') + ' ('#13#10;
  LSQL := LSQL + CheckQuotation('EngineNo') + ',';
  LSQL := LSQL + CheckQuotation('AlarmLevel') + ',';
  LSQL := LSQL + CheckQuotation('IssueDateTime') + ',';
  LSQL := LSQL + CheckQuotation('ReleaseDateTime') + ',';
  LSQL := LSQL + CheckQuotation('TagName') + ',';
  LSQL := LSQL + CheckQuotation('TagDesc') + ',';
  LSQL := LSQL + CheckQuotation('AlarmMessage') + ',';
  LSQL := LSQL + CheckQuotation('AlarmPriority') + ',';
  LSQL := LSQL + CheckQuotation('AlarmAcked') + ',';
  LSQL := LSQL + CheckQuotation('AlarmSuppressed') + ',';
  LSQL := LSQL + CheckQuotation('SensorCode') + ')';
  LSQL := LSQL + ' VALUES ('#13#10;
  LSQL := LSQL + '''EngineNo'', 2,3,4,';
  LSQL := LSQL + '''TagName'',''TagDesc'',''AlarmMessage'',5,6,';
  LSQL := LSQL + '7, ''SensorCode''' + ')';
  FQuery.SQL.Add(LSQL);
  FQuery.ExecSQL;
}
end;

procedure TFormAlarmList.Timer1Timer(Sender: TObject);
var
  i,j: integer;
  LStr: string;
begin
  Timer1.Enabled := False;
  try
    if FFirst then
    begin
      IPCMonitorAll1.SetIsUseIPCSharedMMEvent(True);

      FFirst := False;
      for i := 1 to ParamCount do
      begin
        LStr := UpperCase(ParamStr(i));

        j := Pos('/P', LStr); //parameter file name
        if j > 0 then  //P 제거
        begin
          LStr := Copy(LStr, j+2, Length(LStr)-j-1);
          FWatchListFileName := LStr;
        end;
      end;//for

//      GetEngineParameterFromSavedFile(FWatchListFileName, False);

    end;//if FFirst

  finally
    //Timer1.Enabled := True;
  end;

end;

procedure TFormAlarmList.WatchValue2Screen_Analog(Name, AValue: string;
  AEPIndex: integer);
var
  tmpdouble: double;
  i: integer;
  LEPItem: TEngineParameterItem;
begin
  LEPItem := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex];

  try
    if LEPItem.AlarmEnable then
    begin
      tmpdouble := StrToFloatDef(LEPItem.Value, 0.0);

      if LEPItem.MinAlarmEnable then
        if tmpdouble < LEPItem.MinAlarmValue then
        begin
          AddAlarm2List(AEPIndex);
          exit;
        end;

      if LEPItem.MinFaultEnable then
        if tmpdouble < LEPItem.MinFaultValue then
        begin
          AddAlarm2List(AEPIndex);
          exit;
        end;

      if LEPItem.MaxAlarmEnable then
        if tmpdouble > LEPItem.MaxAlarmValue then
        begin
          AddAlarm2List(AEPIndex);
          exit;
        end;

      if LEPItem.MaxFaultEnable then
        if tmpdouble > LEPItem.MaxFaultValue then
        begin
          AddAlarm2List(AEPIndex);
          exit;
        end;
    end;
  finally
    case PageControl1.ActivePageIndex of
      0: begin //Items
          FWG.NextGrid1.CellsByName['Value', AEPIndex] := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].Value;
      end;
    end;
  end;
end;

procedure TFormAlarmList.WatchValue2Screen_Analog2;
begin

end;

procedure TFormAlarmList.WatchValue2Screen_Digital(Name, AValue: string;
  AEPIndex: integer);
var
  i: integer;
  LEPItem: TEngineParameterItem;
begin
  LEPItem := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex];

  if LEPItem.AlarmEnable then
  begin
    if LEPItem.Value <> '0' then  // => B접점 인 경우에는 0이 알람이므로 이 조건은 맞지 않음
      AddAlarm2List(AEPIndex, True);
  end;

  case PageControl1.ActivePageIndex of
    0: begin //Items
      if LEPItem.Value = '0' then
        FWG.NextGrid1.CellsByName['Value', AEPIndex] := 'False'
      else
        FWG.NextGrid1.CellsByName['Value', AEPIndex] := 'True';
    end;
  end;//case
end;

end.
