unit UnitFrameWatchGrid2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, system.Generics.Collections,
  NxColumnClasses, NxColumns, NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid,
  JvStatusBar, System.Types, StrUtils, NxCells, Vcl.ComCtrls, Clipbrd,
  TimerPool, DragDrop, DropSource, DragDropText, DropTarget,
  UnitEngineParameterClass2, UnitFrameIPCMonitorAll2, HiMECSConst, UnitDragDropRecord2,
  CopyData, UnitParameterManager2, Vcl.ImgList, UnitSynLog2,
  mormot.core.log, mormot.core.base, mormot.core.os, mormot.core.unicode,
{$IFDEF USE_YURIMATHPARSER}
  Parser, ParseTypes, ValueTypes
{$ELSE}
  cyMathParser
{$ENDIF}

 {$IFDEF USECODESITE} ,CodeSiteLogging, JvComponentBase, JvAppHotKey {$ENDIF}
  ;

type
  TDeleteEngineParamterFromGrid = procedure(AIndex: integer) of object;
  TWatchValue2Screen_Analog = procedure(Name: string; AValue: string;
                                AEPIndex: integer) of object;
  TDisplayMessage = procedure(Msg: string; AIsSaveLog: Boolean = True; AMsgLevel: TSynLogInfo = sllInfo) of object;

  TFrameWatchGrid2 = class(TFrame)
    NextGrid1: TNextGrid;
    SimpleDisplay: TNxImageColumn;
    TrendDisplay: TNxImageColumn;
    ItemName: TNxTextColumn;
    Value: TNxButtonColumn;
    FUnit: TNxTextColumn;
    XYDisplay: TNxImageColumn;
    AlarmEnable: TNxImageColumn;
    EngParamSource2: TDropTextSource;
    DropTextTarget1: TDropTextTarget;
    ImageList1: TImageList;
    IsAvg: TNxCheckBoxColumn;
    AvgValue: TNxTextColumn;
    ExcelRange: TNxButtonColumn;
    ItemType: TNxTextColumn;
    Description: TNxTextColumn;
    SensorType: TNxTextColumn;
    CollectIndex: TNxNumberColumn;
    NxIndex: TNxIncrementColumn;
    TagName: TNxTextColumn;
    Address: TNxTextColumn;
    procedure NextGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NextGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NextGrid1CustomDrawCell(Sender: TObject; ACol, ARow: Integer;
      CellRect: TRect; CellState: TCellState);
    procedure NextGrid1CellDblClick(Sender: TObject; ACol, ARow: Integer);
    procedure NextGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NextGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure NextGrid1SelectCell(Sender: TObject; ACol, ARow: Integer);
    procedure DropTextTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure ExcelRangeButtonClick(Sender: TObject);
  private
    FIPCMonitorAll: TFrameIPCMonitor2;
    FStatusBar: TJvStatusBar;
    FHandle: THandle;
    FProgramMode: TProgramMode;
{$IFDEF USE_YURIMATHPARSER}
    FyuriParser: TParser;
{$ELSE}
    FcyMathParser1: TcyMathParser;
{$ENDIF}
    FGridItemMoveMode: Boolean;
    FCurrentFindRowIdx: integer; //NextGrid에서 Find할떄 Next Index를 저장하기 위함
    FCurrentFindStr, FCurrentColName: string;

    procedure SetConfigEngParamItemData(AIndex: Integer);
    function ReAssignFormulaValueList(AFormula: string; AIndex: integer = -1): TStringList;
    procedure SendFormCopyData(ToHandle: integer; AForm:TForm);
    procedure cyMathParser1CustomOperationParse(Sender: TObject; AStackInfo: TStackInfo;
      const Arguments: array of Extended; var Rslt: Extended);
  protected
    procedure WMMultiCopyBegin(var Msg: TMessage); message WM_MULTICOPY_BEGIN;
    procedure WMMultiCopyEnd(var Msg: TMessage); message WM_MULTICOPY_END;
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;
    procedure WmChangeCopyMode(var Msg: TMessage); message WParam_CHANGECOPYMODE;

    function CheckExistTagNameInEngParamCollect(AParameterSource: TParameterSource;
                                                  ATagName: string): integer;
    function GetEventName(AEPItem: TEngineParameterItem): string;
    procedure SaveGrid(AGrid: TNextGrid; AStm: TStream);
    procedure LoadGrid(AGrid: TNextGrid; AStm: TStream);
    //HiMECS_Watch2 에서만 사용되는 그래프 관련 시트 숨김
    procedure HideGraphSheet(AIndex: integer);
    procedure ConnectGridNParamItem(AGridRowIndex, AItemIndex: integer;
      AParamCollect: TEngineParameterCollect = nil);
    procedure DisplayMessage(AMsg: string);

    procedure OnDisplayCalculatedItemValue(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnDisplayElapsedTime4AvgCalc(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnAvgCalc(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
  public
    FKeyBdShiftState: TShiftState;
    FMousePoint: TPoint;
    FCalculatedItemTimerHandle: integer; //Calculated Item display용 Timer Handle
    FDisplayElapsedTimeHandle: integer; //평균값 계산시 경과 시간 표시하는 Timer Handle
    FAvgCalcTimerHandle: integer;//평균값을 계산하는 Timer Handle
    FPJHTimerPool: TPJHTimerPool;
    FEngineParameterItemRecord: TEngineParameterItemRecord; //Save폼에 값 전달시 사용
    FCompoundItemList: TList<integer>; //Calculated Item List
    FDragCopyMode: TParamDragCopyMode; //Multi Drag 시에 Popup Menu에서 선택한 값이 저장 됨
    FMultiDragOn: integer; //Multi Drag 시작 시 = 1, 진행중 = 2, Drag 완료 = 0
    FTempParamItemRecord: TEngineParameterItemRecord;

    FEngineParameterTarget: TEngineParameterDataFormat;
    FEngParamSource: TEngineParameterDataFormat;

    FEventName4Item,//Grid에서 마우스 클릭 시 해당 아이템의 EventName이 저장 됨.
    FCurrentWatchListFileName: string;

    //Procedure List
    FDeleteEngineParamterFromGrid: TDeleteEngineParamterFromGrid;
    FWatchValue2Screen_Analog: TWatchValue2Screen_Analog;
    FDisplayMessage: TDisplayMessage;
    FPM: TParameterManager;
    FIsAvgDisplay4Items: Boolean; //True: 각 Item에 대한 평균값을 계산하여 보여줌
    FAvgCalcInterval: integer;//평균값을 계산하는 타이머 Interval
    FAverageQSize: integer;//평균값 계산에 사용되는 원형큐 크기
    FElapsedTimeOfAvgCalc: word;
    FFindNextStartRowIndex: integer;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure InitVar;
    procedure DestroyVar;

    function CreateIPCMonitor(AEP_DragDrop: TEngineParameterItemRecord;
      ADragCopyMode: TParamDragCopyMode = dcmCopyOnlyNonExist): integer;
    function CreateIPCMonitor_2(AEP_DragDrop: TEngineParameterItemRecord;
      ADragCopyMode: TParamDragCopyMode = dcmCopyOnlyNonExist): integer;

    procedure ShowProperties(AParamCollect: TEngineParameterCollect = nil);
    //Grid Items의 선택 된 Row만 삭제
    procedure DeleteGridItem(ASkipDlg: Boolean = False);
    function AddCalculated2Grid(AFormula, ADesc: string; AFromMenu: Boolean;
      AIdx: integer = -1; AParam: TEngineParameterCollect = nil): integer;
    procedure AddCalculated2GridFromMenu;
    procedure AppendEngineParameterFromFile(AFileName: string; AEngParamFileFormat: integer;
                          AEngParamEncrypt, AIsMDIChileMode: Boolean);
    procedure FreeStrListFromGrid(AIndex: integer = -1);
    procedure AddEngineParameter2Grid(AIdx: integer); overload;
    procedure AddEngineParameter2Grid(AParam: TEngineParameterCollect = nil;
      AParamItemKind: TEngParamListItemKind=eplikSensorType); overload;
    procedure AddEngineParameter2GridOnlyCreate(AIdx: integer;
      AParamItemKind: TEngParamListItemKind=eplikSensorType); overload;
    procedure UpdateGridFromEngParam2Index(AEPItem: TEngineParameterItem; AIdx: integer);
    procedure GetItemsFromParamFile2Collect(AFileName: string; AEngParamFileFormat: integer;
                          AEngParamEncrypt: Boolean; AIsMDIChileMode: Boolean = False;
                          AEngParam: TEngineParameter=nil);
    function GetTagNameFromGrid(AIdx: integer): string;
    function GetItemIndexFromGrid(ATagName: string): integer;
    function GetItemIndexFromFindNext(ATagName: string; AIgnoreCase: Boolean=True): integer;
    function GetEngParamItemFromGridIdx(AIdx: integer=-1): TEngineParameterItem;
    //이 함수를 호출하기 전에 반드시 FEngineParameterItemRecord에 데이터를 저장 해야 함.
    function SendEngParam2HandleWindow(var AMultiWatchHandle: TpjhArrayHandle;
      AProcessName: string; ADestHandle: Integer = -1): THandle;

    //IPCClient와 IPCMonitor이 동시에 존재할 때 EngineParameter를 서로 공유하기 위함(EngiParamClientp에서 사용)
    procedure SetEngParamCollect2IPCMonotorAll(ASource: TEngineParameterCollect);
    procedure SetEngParam2IPCMonitorAll(ASource: TEngineParameter);

    //이 프레임을 포함하는 폼에서 반드시 아래 함수를 실행 해야 함.
    procedure SetIPCMonitorAll(AIPCMonitor: TFrameIPCMonitor2);
    procedure SetStatusBar(AStatusBar: TJvStatusBar);
    //WM_CopyData Message가 AHandle로 전달 됨
    procedure SetMainFormHandle(AHandle: THandle);
    procedure SetDeleteEngineParamterFromGrid(AFunc: TDeleteEngineParamterFromGrid);
    procedure SetWatchValue2Screen_Analog(AFunc: TWatchValue2Screen_Analog);
    //////////////////////////////////////////////////////////////

    //pmWatchList: Items Grid에 Value만 표시함
    //pmAlarmList: Items Grid에 Value + Alarm을 표시함
    procedure SetProgramMode(AMode: TProgramMode);
    //AUniqueEngName: ProjNo_EngNo
    procedure SelectTagName4RunCondition(AUniqueEngName: string;
      ADestGrid: TNextGrid);
    procedure ClearCompountList;
    //EngineParameterCollect에서 해당 Engine의 Item을 삭제함
    procedure DeleteEngParamPerEngine(AProjNo, AEngNo: string);
    function CheckExistTagNameInGrid(ATagName: string): integer;

    function ProcessItemsDrop(ADragCopyMode: TParamDragCopyMode = dcmCopyOnlyNonExist): integer;
    procedure ProcessCopyMode(AShiftState: TShiftState; APoint: TPoint);
    procedure PopupCopyMode(AShiftState: TShiftState; APoint: TPoint);

    procedure GridItemMoveUp;
    procedure GridItemMoveDown;

    procedure InitAvgMode;
    procedure FinalizeAvgMode;
    procedure StartAvgCalc;
    function StopAvgCalc: Boolean;
    procedure SelectAllItems4Avg;
    procedure RestartAvgCalc(AUseFinalize: Boolean; AQSize: integer);
    procedure SaveAvg2File(AFileName: string);
    procedure ShowTagNameColumn;
    procedure ShowFindForm;
    procedure FindGridFromOption(AOption: integer; AFindStr: string);
    procedure FindGridFromIndex(AFromIndex: integer; AFindStr, AColName: string);
    procedure FindNextGrid;
  end;

implementation

uses FrmEngParamConfig, UnitCopyModeMenu, CommonUtil, WatchConst2,
  UnitSelectTagName, CircularArray, FrmFindWatchGrid, UnitCopyWatchList2
{$IFDEF USE_YURIMATHPARSER}
  , ValueUtils
{$ENDIF}
  ;

{$R *.dfm}

//AFromMenu: true = Add Calculated Menu를 클릭한 경우
//           false = Drag Drop으로 CreateIPCMonitor 한 경우
function TFrameWatchGrid2.AddCalculated2Grid(AFormula, ADesc: string;
  AFromMenu: Boolean; AIdx: integer; AParam: TEngineParameterCollect): integer;
var
  i: integer;
  Lstr, LStr2: string;
  LStrList: TStringList;
  LEP_DragDrop: TEngineParameterItemRecord;
begin
//  Result := AIdx;
  LStrList := ReAssignFormulaValueList(AFormula);

  if AFromMenu then
  begin
    Result := NextGrid1.AddRow();
    HideGraphSheet(Result);

    LEP_DragDrop.FSharedName := AFormula;
    LEP_DragDrop.FSensorType := stCalculated;
    LEP_DragDrop.FParameterSource := psManualInput;
    LEP_DragDrop.FTagName := 'V_' + formatDateTime('yyyymmddhhnnss',now);//'Calculated_'+IntToStr(j);

    if ADesc = '' then
      LEP_DragDrop.FDescription := AFormula
    else
      LEP_DragDrop.FDescription := ADesc;

    NextGrid1.CellByName['ItemName',Result].AsString := LEP_DragDrop.FDescription;

    //기존 Item이 존재하면
    if Result > 0 then
    begin
      LEP_DragDrop.FProjNo := TEngineParameterItem(NextGrid1.Row[Result-1].Data).ProjNo;
      LEP_DragDrop.FEngNo := TEngineParameterItem(NextGrid1.Row[Result-1].Data).EngNo;
    end;

    i := FIPCMonitorAll.MoveEngineParameterItemRecord(LEP_DragDrop);

    if i = -1 then
      i := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Count - 1;

    NextGrid1.Row[Result].Data := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i];
    Result := i;
  end
  else
  begin
    Result := AIdx;//FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Count - 1;

    if Assigned(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result].NextGridRow) then
    begin
      i := NextGrid1.GetRowIndex(TRow(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result].NextGridRow));

      if (i > -1) and (i < NextGrid1.RowCount) and (i = Result) then
      begin
        NextGrid1.CellByName['ItemName',i].AsString :=
          FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result].Description;
        NextGrid1.Row[Result].Data := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result];
      end;
    end
    else
    begin
      NextGrid1.Row[Result].Data := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result];
    end;
  end;

//  if Assigned(NextGrid1.Row[Result].Data) then
//    TStringList(NextGrid1.Row[Result].Data).Free;

  FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result].FormulaValueList :=
    LStrList.Text;
  FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result].FormulaValueStringList := LStrList;
  FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result].NextGridRow := NextGrid1.Row[Result];
  FCompoundItemList.add(Result);

  if FCalculatedItemTimerHandle = -1 then
    FCalculatedItemTimerHandle := FPJHTimerPool.Add(OnDisplayCalculatedItemValue,1000);
end;

//Calculated Item이 있을 경우 삭제에 주의 해야 함.
procedure TFrameWatchGrid2.AddCalculated2GridFromMenu;
var
  i,j: integer;
  Lstr, LStr2: string;
  LStrList, LtmpList: TStringList;
  LEP_DragDrop: TEngineParameterItemRecord;
  LMemoryStream: TMemoryStream;
  LCopyWatchListF: TCopyWatchListF;
begin
  LCopyWatchListF := TCopyWatchListF.Create(nil);
  try
    with LCopyWatchListF do
    begin
//      LMemoryStream := TMemoryStream.Create;
//      try
//        NextGrid1.SaveToStream(LMemoryStream);
//        LMemoryStream.Position := 0;
//        SelectGrid.LoadFromStream(LMemoryStream);
//      finally
//        FreeAndNil(LMemoryStream);
//      end;

      LMemoryStream := TMemoryStream.Create;
      try
        SaveGrid(NextGrid1,LMemoryStream);
        LMemoryStream.Position := 0;
        LoadGrid(FWG.NextGrid1,LMemoryStream);
      finally
        FreeAndNil(LMemoryStream);
      end;

//      NextGrid1.SaveToTextFile(TEMPFILENAME);
//      FWG.NextGrid1.LoadFromTextFile(TEMPFILENAME);

      Sel4XYGraphPanel.Visible := False;
      FormulaPanel.Visible := True;

//      FWG.NextGrid1.Columns.Item[0].Visible := False;
      FWG.NextGrid1.Columns.Item[1].Visible := False;
      FWG.NextGrid1.Columns.Item[2].Visible := False;
      FWG.NextGrid1.Columns.Item[5].Visible := False;
      FWG.NextGrid1.Columns.Item[6].Visible := False;
      FWG.NextGrid1.Columns.Item[7].Visible := False;
      FWG.NextGrid1.Columns.Column['TagName'].Visible := True;

//      FWG.NextGrid1.Options := FWG.NextGrid1.Options - [goMultiSelect];

      for i := 0 to FWG.NextGrid1.RowCount - 1 do
      begin
        FWG.NextGrid1.CellByName['ItemName',i].AsString :=
          FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].Description;
        FWG.NextGrid1.CellByName['TagName',i].AsString :=
          FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].TagName;
      end;

      if ShowModal = mrOK then
      begin
        AddCalculated2Grid(ExprEdt.Text, ItemNameEdit.Text, True);
      end;
    end;//with

  finally
    FreeAndNil(LCopyWatchListF);
  end;
end;

procedure TFrameWatchGrid2.AddEngineParameter2Grid(
  AParam: TEngineParameterCollect; AParamItemKind: TEngParamListItemKind);
var
  i: integer;
begin
  if not Assigned(AParam) then
    AParam := FIPCMonitorAll.FEngineParameter.EngineParameterCollect;

  NextGrid1.BeginUpdate();
  try
    for i := 0 to AParam.Count - 1 do
      AddEngineParameter2GridOnlyCreate(i, AParamItemKind);
//      AddEngineParameter2Grid(i);
  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure TFrameWatchGrid2.AddEngineParameter2GridOnlyCreate(AIdx: integer;
  AParamItemKind: TEngParamListItemKind);
var
  j: integer;
  LEngParamItem: TEngineParameterItem;
begin
  LEngParamItem := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx];

  if (AParamItemKind <> eplikModbus) and (LEngParamItem.TagName = 'DUMMY') then
    exit;

  if (LEngParamItem.TagName = '') then
    exit;

  FIPCMonitorAll.CreateIPCMonitorOnlyCreate(LEngParamItem);

  j := NextGrid1.AddRow();

  HideGraphSheet(j);

  with LEngParamItem, NextGrid1 do
  begin
    if Description = '' then
      CellsByName['ItemName', j] := TagName
    else
      CellsByName['ItemName', j] := Description;

    CellsByName['FUnit', j] := FUnit;

    if ParameterSource = psManualInput then
      CellsByName['Value', j] := Value
    else
    if (SensorType = stParam) and (ParameterSource = psECS_AVAT2) then
      CellsByName['Value', j] := Value;

    CellByName['ExcelRange',j].AsString := FExcelRange;
    CellsByName['TagName', j] := TagName;
    CellsByName['Address', j] := Address;

    if (AParamItemKind = eplikModbus) and (LEngParamItem.TagName = 'DUMMY') then
      RowVisible[j] := False;

    if (LEngParamItem.SensorType = stCalculated) and
      (LEngParamItem.ParameterSource = psManualInput) then
      AddCalculated2Grid(LEngParamItem.SharedName,
                          LEngParamItem.Description,
                          False, AIdx)
    else
    begin
      ConnectGridNParamItem(j,AIdx);
    end;
  end;
end;

procedure TFrameWatchGrid2.AddEngineParameter2Grid(AIdx: integer);
var
  j: integer;
  LStr: string;
  LStrList: TStringList;
begin
  FIPCMonitorAll.MoveEngineParameterItemRecord2(FEngineParameterItemRecord,AIdx);

  if (FEngineParameterItemRecord.FTagName = 'DUMMY') or (FEngineParameterItemRecord.FTagName = '') then
    exit;

  if CheckExistTagNameInGrid(FEngineParameterItemRecord.FTagName) <> -1 then
    exit;

  FIPCMonitorAll.CreateIPCMonitor(FEngineParameterItemRecord, False, dcmCopyOnlyNonExist);

  j := NextGrid1.AddRow();

  HideGraphSheet(j);

  if FEngineParameterItemRecord.FDescription = '' then
    NextGrid1.CellsByName['ItemName', j] := FEngineParameterItemRecord.FTagName
  else
    NextGrid1.CellsByName['ItemName', j] := FEngineParameterItemRecord.FDescription;

  NextGrid1.CellsByName['FUnit', j] := FEngineParameterItemRecord.FFUnit;

  if FEngineParameterItemRecord.FParameterSource = psManualInput then
    NextGrid1.CellsByName['Value', j] := FEngineParameterItemRecord.FValue
  else
  if (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].SensorType = stParam) and
    (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].ParameterSource = psECS_AVAT2) then
    NextGrid1.CellsByName['Value', j] := FEngineParameterItemRecord.FValue;

  NextGrid1.CellByName['ExcelRange',j].AsString := FEngineParameterItemRecord.FFExcelRange;
  NextGrid1.CellsByName['TagName', j] := FEngineParameterItemRecord.FTagName;

  //WT1600의 경우 복수개를 한개의 프로그램에서 모니터링 할 때 List에 저장 됨
//  if FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].ParameterSource = psWT1600 then
//  begin
//    LStr := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].ProjNo + '_' +
//      FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].EngNo;
//    FIPCMonitorAll.SetEventData_WT1600_List(LStr);
//  end;

  if (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].SensorType = stCalculated) and
    (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].ParameterSource = psManualInput) then
    AddCalculated2Grid(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].SharedName,
                        FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].Description,
                        False, AIdx)
  else
  begin
    ConnectGridNParamItem(j,AIdx);
  end;
//  if FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].FormulaValueList <> '' then
//  begin
//    NextGrid1.CellByName['ItemName',j].AsString :=
//      FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].Description;
//
//    LStr := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].FormulaValueList;
//    LStrList := TStringList.Create;
//    LStrList.Text := LStr;
//    NextGrid1.Row[j].Data := LStrList;
//    FCompoundItemList.add(j);
//
//    if FCalculatedItemTimerHandle = -1 then
//      FCalculatedItemTimerHandle := FPJHTimerPool.Add(OnDisplayCalculatedItemValue,1000);
//  end;
end;

procedure TFrameWatchGrid2.AppendEngineParameterFromFile(AFileName: string;
  AEngParamFileFormat: integer; AEngParamEncrypt, AIsMDIChileMode: Boolean);
var
  LEngineParam: TEngineParameter;
  AEPItemRecord: TEngineParameterItem;
  i: integer;
begin
  LEngineParam := TEngineParameter.Create(nil);
  try
    if AEngParamFileFormat = 0 then //JSON format
      LEngineParam.LoadFromJSONFile(AFileName,
                ExtractFileName(AFileName),AEngParamEncrypt)
    else
    if AEngParamFileFormat = 1 then //XML format
      LEngineParam.LoadFromFile(AFileName,
                ExtractFileName(AFileName),AEngParamEncrypt);
    //LEngineParam.LoadFromFile(AFileName);

    FIPCMonitorAll.FEngineParameter.ExeName := LEngineParam.ExeName;
    FIPCMonitorAll.FEngineParameter.FilePath := LEngineParam.FilePath;

    if not AIsMDIChileMode then
    begin
      FIPCMonitorAll.FEngineParameter.FormWidth := LEngineParam.FormWidth;
      FIPCMonitorAll.FEngineParameter.FormHeight := LEngineParam.FormHeight;
      FIPCMonitorAll.FEngineParameter.FormTop := LEngineParam.FormTop;
      FIPCMonitorAll.FEngineParameter.FormLeft := LEngineParam.FormLeft;
    end;
    FIPCMonitorAll.FEngineParameter.AllowUserLevelWatchList := LEngineParam.AllowUserLevelWatchList;

    for i := 0 to LEngineParam.EngineParameterCollect.Count - 1 do
    begin
      AEPItemRecord := LEngineParam.EngineParameterCollect.Items[i];
      if CheckExistTagNameInEngParamCollect(AEPItemRecord.ParameterSource,AEPItemRecord.TagName) = -1 then
      begin //동일한 태그가 존재하지 않으면 추가
        FIPCMonitorAll.FEngineParameter.EngineParameterCollect.AddEngineParameterItem(AEPItemRecord);
      end;
    end;
  finally
    LEngineParam.Free;
  end;
end;

function TFrameWatchGrid2.CheckExistTagNameInEngParamCollect(AParameterSource: TParameterSource;
  ATagName: string): integer;
var
  i: integer;
begin
  Result := -1;

  for i := 0 to FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    if (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].ParameterSource =
                                                AParameterSource) and
        (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].TagName =
                                                ATagName) then
    begin
      Result := i;
      exit;
    end;
  end;
end;

function TFrameWatchGrid2.CheckExistTagNameInGrid(ATagName: string): integer;
var
  i: integer;
begin
  Result := -1;

  for i := 0 to NextGrid1.RowCount - 1 do
  begin
    if NextGrid1.CellsByName['TagName', i] = ATagName then
    begin
      Result := i;
      exit;
    end;
  end;
end;

procedure TFrameWatchGrid2.ClearCompountList;
var
  i,j: integer;
begin
  for j := FCompoundItemList.Count - 1 downto 0 do
  begin
    i := FCompoundItemList.Items[j];

    if Assigned(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].FormulaValueStringList) then
      FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].FormulaValueStringList.Free;
  end;

  FCompoundItemList.Clear;
end;

procedure TFrameWatchGrid2.ConnectGridNParamItem(AGridRowIndex,
  AItemIndex: integer; AParamCollect: TEngineParameterCollect);
begin
  if not Assigned(AParamCollect) then
  begin
    if Assigned(FIPCMonitorAll.FEngineParameter) then
      AParamCollect := FIPCMonitorAll.FEngineParameter.EngineParameterCollect;
  end;

  NextGrid1.Row[AGridRowIndex].Data := AParamCollect.Items[AItemIndex];
  AParamCollect.Items[AItemIndex].NextGridRow := NextGrid1.Row[AGridRowIndex];
end;

constructor TFrameWatchGrid2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  InitVar;
end;

function TFrameWatchGrid2.CreateIPCMonitor(AEP_DragDrop: TEngineParameterItemRecord;
  ADragCopyMode: TParamDragCopyMode): integer;
var
  i, j: integer;
begin
  Result := FIPCMonitorAll.CreateIPCMonitor(AEP_DragDrop, False, ADragCopyMode);

  //신규 Item 이면 Grid에 추가함
  if Result = -1 then
  begin
    i := NextGrid1.AddRow();

    if ADragCopyMode <> dcmCopyOnlyExist then
    begin
      //신규 Item이기 때문에 맨 마지막 Index가 추가한 Record 임
      j := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Count - 1;

      if (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].SensorType = stCalculated) and
        (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].ParameterSource = psManualInput) then
      begin
        AddCalculated2Grid(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].SharedName,
                            FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].Description,
                            False, i);
      end
      else
      begin
        if AEP_DragDrop.FDescription = '' then
          NextGrid1.CellsByName['ItemName', i] := AEP_DragDrop.FTagName
        else
          NextGrid1.CellsByName['ItemName', i] := AEP_DragDrop.FDescription;

        NextGrid1.CellsByName['FUnit', i] := AEP_DragDrop.FFUnit;

        if AEP_DragDrop.FParameterSource = psManualInput then
          NextGrid1.CellsByName['Value', i] := AEP_DragDrop.FValue
        else
        if (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].SensorType = stParam) and
          (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].ParameterSource = psECS_AVAT2) then
          NextGrid1.CellsByName['Value', i] := AEP_DragDrop.FValue;

        ConnectGridNParamItem(i,j);
      end;

      NextGrid1.ClearSelection;
      //FWG.NextGrid1.Selected[i] := True;
      NextGrid1.ScrollToRow(i);
      HideGraphSheet(i);
    end;
  end
  else
  begin //신규 Item이 아니더라도 Calculated인 경우는 추가 작업 필요
    //Calculated 설정이 안되어 있으면
    if (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result].SensorType = stCalculated) and
      (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result].ParameterSource = psManualInput) then
    begin
      if FCompoundItemList.IndexOf(Result) = -1 then
      begin
        AddCalculated2Grid(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result].SharedName,
                            FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Result].Description,
                            False, Result);
      end;
    end
    else
    begin
      NextGrid1.ClearSelection;
      NextGrid1.ScrollToRow(Result);
      NextGrid1.Row[Result].Selected := True;
    end;
  end;
end;

function TFrameWatchGrid2.CreateIPCMonitor_2(
  AEP_DragDrop: TEngineParameterItemRecord;
  ADragCopyMode: TParamDragCopyMode): integer;
var
  i, j: integer;
begin
  Result := FIPCMonitorAll.CreateIPCMonitor(AEP_DragDrop, False, ADragCopyMode);

  //신규 Item 이면
  if not (ADragCopyMode = dcmCopyOnlyExist) and (Result = -1) then
  begin
    j := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Count - 1;

    if (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].SensorType = stCalculated) and
      (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].ParameterSource = psManualInput) then
      i := AddCalculated2Grid(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].SharedName,
                          FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].Description,
                          False, 0)
    else
    begin
      i := NextGrid1.AddRow();

      if AEP_DragDrop.FDescription = '' then
        NextGrid1.CellsByName['ItemName', i] := AEP_DragDrop.FTagName
      else
        NextGrid1.CellsByName['ItemName', i] := AEP_DragDrop.FDescription;

      NextGrid1.CellsByName['FUnit', i] := AEP_DragDrop.FFUnit;

      if AEP_DragDrop.FParameterSource = psManualInput then
        NextGrid1.CellsByName['Value', i] := AEP_DragDrop.FValue
      else
      if (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].SensorType = stParam) and
        (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[j].ParameterSource = psECS_AVAT2) then
        NextGrid1.CellsByName['Value', i] := AEP_DragDrop.FValue;
    end;

    NextGrid1.ClearSelection;
    //FWG.NextGrid1.Selected[i] := True;
    NextGrid1.ScrollToRow(i);
    HideGraphSheet(i);
  end;
end;

procedure TFrameWatchGrid2.cyMathParser1CustomOperationParse(Sender: TObject;
  AStackInfo: TStackInfo; const Arguments: array of Extended; var Rslt: Extended);
begin

end;

procedure TFrameWatchGrid2.DeleteEngParamPerEngine(AProjNo, AEngNo: string);
var
  LEP: TEngineParameterCollect;
  i, LRow: integer;
begin
  LEP := FIPCMonitorAll.FEngineParameter.EngineParameterCollect;

  NextGrid1.BeginUpdate;
  try
    for i := LEP.Count - 1 downto 0 do
    begin
      if (LEP.Items[i].ProjNo = AProjNo) and (LEP.Items[i].EngNo = AEngNo) then
      begin
        if Assigned(LEP.Items[i].NextGridRow) then
        begin
          LRow := NextGrid1.GetRowIndex(TRow(LEP.Items[i].NextGridRow));

          if (LRow >= 0) and (LRow < LEP.Count) then
            NextGrid1.Row[LRow].Selected := True;
        end;
      end;
    end;//for

    //Selected 된 Row만 삭제함
    DeleteGridItem(True);
  finally
    NextGrid1.EndUpdate;
  end;
end;

procedure TFrameWatchGrid2.DeleteGridItem(ASkipDlg: Boolean);
var
  i: integer;
  LStr: string;
begin
  if NextGrid1.SelectedCount > 0 then
  begin
    if not ASkipDlg then
      ASkipDlg := MessageDlg(IntToStr(NextGrid1.SelectedCount) + ' row(s) selected.' + #13#10 +
                          'Are you sure selected row(s) delete?',
                              mtConfirmation, [mbYes, mbNo], 0)= mrYes;
    if ASkipDlg then
    begin
      if FIPCMonitorAll.AssignedIPCMonitor(psECS_Woodward) then
        FIPCMonitorAll.FCompleteReadMap_Woodward := False;

      if FIPCMonitorAll.AssignedIPCMonitor(psECS_kumo) then
        FIPCMonitorAll.FCompleteReadMap_kumo := False;

      if FIPCMonitorAll.AssignedIPCMonitor(psECS_AVAT) then
        FIPCMonitorAll.FCompleteReadMap_Avat := False;

      //Grid Item 삭제 시에 Timer 함수에서 접근시 AVE 발생하기 때문
      if FCalculatedItemTimerHandle <> -1 then
        FPJHTimerPool.Enabled[FCalculatedItemTimerHandle] := False;

      for i := NextGrid1.RowCount - 1 Downto 0 do
      begin
        if NextGrid1.Row[i].Selected then
        begin
          if Assigned(FDeleteEngineParamterFromGrid) then
            FDeleteEngineParamterFromGrid(i)
          else
          begin
            FreeStrListFromGrid(i);
            NextGrid1.DeleteRow(i);
            FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Delete(i);
          end;
        end;
      end;

      //삭제시 Calculated Item은 FWG.NextGrid1.Data에 저장된 StringList의 내용(TagName=Grid.RowIndex)을 갱신해야 함
      for i := 0 to NextGrid1.RowCount - 1 do
      begin
        if FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].FormulaValueList <> '' then
        begin
          //Formula Fetch
          LStr := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].SharedName;
          ReAssignFormulaValueList(LStr, i);
        end;
      end;

      if FCalculatedItemTimerHandle <> -1 then
        FPJHTimerPool.Enabled[FCalculatedItemTimerHandle] := True;

      if FIPCMonitorAll.AssignedIPCMonitor(psECS_Woodward) then
        FIPCMonitorAll.FCompleteReadMap_Woodward := True;

      if FIPCMonitorAll.AssignedIPCMonitor(psECS_kumo) then
        FIPCMonitorAll.FCompleteReadMap_kumo := True;

      if FIPCMonitorAll.AssignedIPCMonitor(psECS_AVAT) then
        FIPCMonitorAll.FCompleteReadMap_Avat := True;
    end;
  end;
end;

destructor TFrameWatchGrid2.Destroy;
begin
  DestroyVar;

  inherited;
end;

procedure TFrameWatchGrid2.DestroyVar;
begin
  FreeStrListFromGrid;
  FinalizeAvgMode;

  FPJHTimerPool.RemoveAll;
  FPJHTimerPool.Free;

{$IFDEF USE_YURIMATHPARSER}
  FyuriParser.Free;
{$ELSE}
  FcyMathParser1.Free;
{$ENDIF}

  FPM.Free;
  FEngParamSource.Free;
  FEngineParameterTarget.Free;
  FCompoundItemList.Free;
end;

procedure TFrameWatchGrid2.DisplayMessage(AMsg: string);
begin
  if Assigned(FDisplayMessage) then
  begin
    FDisplayMessage(AMsg);
  end;
end;

procedure TFrameWatchGrid2.DropTextTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
begin
  // Determine if we got our custom format.
  if (FEngineParameterTarget.HasData) then
  begin
    FEngineParameterTarget.EPD.FEPItem.AssignTo(FTempParamItemRecord);

    case FEngineParameterTarget.EPD.FDragDataType of
      dddtSingleRecord: begin
        if ssCtrl in FEngineParameterTarget.EPD.FShiftState then
          PopupCopyMode(FEngineParameterTarget.EPD.FShiftState, FMousePoint)
        else
          FDragCopyMode := dcmCopyOnlyNonExist;

        ProcessCopyMode(FEngineParameterTarget.EPD.FShiftState, APoint);//(FEngineParameterTarget.EPD.FEPItem, ADragCopyMode);
      end;

      dddtMultiRecord: begin//ShowMessage(IntToStr(FEngineParameterTarget.EPD.FSourceHandle));
        if ssCtrl in FEngineParameterTarget.EPD.FShiftState then
          PopupCopyMode(FEngineParameterTarget.EPD.FShiftState, FMousePoint)
        else
          FDragCopyMode := dcmCopyOnlyNonExist;
//          SendHandleCopyData(FEngineParameterTarget.EPD.FSourceHandle, Handle, WParam_REQMULTIRECORD);

        if FDragCopyMode <> dcmCopyCancel then
          SendHandleCopyDataWithShift(FEngineParameterTarget.EPD.FSourceHandle,
            FHandle, WParam_REQMULTIRECORD,
            FEngineParameterTarget.EPD.FShiftState,
            Ord(FDragCopyMode));

        if Assigned(FDisplayMessage) then
          FDisplayMessage(DateTimeToStr(now) + ' : Send WParam_REQMULTIRECORD to ' + IntToStr(FEngineParameterTarget.EPD.FSourceHandle));
//          FStatusBar.SimpleText := DateTimeToStr(now) + ' : Send WParam_REQMULTIRECORD to ' + IntToStr(FEngineParameterTarget.EPD.FSourceHandle);
      end;
    end;
  end;
end;

procedure TFrameWatchGrid2.ExcelRangeButtonClick(Sender: TObject);
begin
  NextGrid1.Columns[NextGrid1.SelectedColumn].Editor.AsString := Clipboard.AsText;
end;

//Grid.Data의 StringList 해제
procedure TFrameWatchGrid2.FinalizeAvgMode;
var
  i: integer;
  LEngineParameterItem: TEngineParameterItem;
begin
  if FDisplayElapsedTimeHandle > 0 then
    FPJHTimerPool.Remove(FDisplayElapsedTimeHandle);

  if FAvgCalcTimerHandle > 0 then
    FPJHTimerPool.Remove(FAvgCalcTimerHandle);

  for i := 0 to NextGrid1.RowCount - 1 do
  begin
//    if NextGrid1.CellByName['IsAvg',i].AsBoolean then
//    begin
      LEngineParameterItem := TEngineParameterItem(NextGrid1.Row[i].Data);
      if Assigned(LEngineParameterItem) and Assigned(LEngineParameterItem.FPCircularArray) then
      begin
        TCircularArray(LEngineParameterItem.FPCircularArray).Free;
        LEngineParameterItem.FPCircularArray := nil;
      end;

      NextGrid1.CellByName['AvgValue',i].AsString := '';
//    end;
  end;
end;

procedure TFrameWatchGrid2.FindGridFromIndex(AFromIndex: integer;
  AFindStr, AColName: string);
var
  i: integer;
begin
  if AFromIndex >= NextGrid1.RowCount then
    exit;

  for i := AFromIndex to NextGrid1.RowCount - 1 do
  begin
    if AFindStr = NextGrid1.CellsByName[AColName,i] then
    begin
//      if not NextGrid1.IsRowInView(i) then
        NextGrid1.ScrollToRow(i);

      NextGrid1.Row[i].Selected := True;
      NextGrid1.Refresh;
      FCurrentFindRowIdx := i;
      Break;
    end;
  end;

end;

procedure TFrameWatchGrid2.FindGridFromOption(AOption: integer;
  AFindStr: string);
var
  LStr: string;
begin
  if AFindStr <> '' then
  begin
    case AOption of
      0: LStr := 'TagName';//Tag Name
      1: LStr := 'ItemName';//Tag Desc
      2: begin
        LStr := 'Address';//Modbus Address(Decimal)
        AFindStr := IntToHex(StrToIntDef(AFindStr, 0),4);
      end;
      3: LStr := 'Address';//Modbus Address(Hex)
    end;
  end;

  FCurrentFindRowIdx := 0;
  FCurrentFindStr := AFindStr;
  FCurrentColName := LStr;

  FindGridFromIndex(FCurrentFindRowIdx, FCurrentFindStr, FCurrentColName);
end;

procedure TFrameWatchGrid2.FindNextGrid;
begin
  FindGridFromIndex(FCurrentFindRowIdx+1, FCurrentFindStr, FCurrentColName);
end;

procedure TFrameWatchGrid2.FreeStrListFromGrid(AIndex: integer);
var
  i,j: integer;
  LStr: string;
begin
  for j := FCompoundItemList.Count - 1 downto 0 do
  begin
    i := FCompoundItemList.Items[j];

    if AIndex = -1 then //모든 List Free(OnDestroy시에)
    begin
      if Assigned(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].FormulaValueStringList) then
        FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].FormulaValueStringList.Free;
    end
    else //DeleteItem선택시에 실행됨
    begin
      if AIndex = i then
      begin
        FCompoundItemList.delete(j);
        if Assigned(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].FormulaValueStringList) then
          FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].FormulaValueStringList.Free;
      end;
//      else
//      if i > AIndex then
//        FCompoundItemList.Items[j] := i - 1;
    end;
  end;//for
end;

function TFrameWatchGrid2.GetEngParamItemFromGridIdx(
  AIdx: integer): TEngineParameterItem;
begin
  Result := nil;

  if AIdx = -1 then
    AIdx := NextGrid1.SelectedRow;

  if (AIdx > -1) and (AIdx < NextGrid1.RowCount) then
    Result := TEngineParameterItem(NextGrid1.Row[AIdx].Data);
end;

function TFrameWatchGrid2.GetEventName(AEPItem: TEngineParameterItem): string;
begin
  Result := AEPItem.SharedName + '_' + ParameterSource2SharedMN(AEPItem.ParameterSource);
end;

function TFrameWatchGrid2.GetItemIndexFromFindNext(ATagName: string;
  AIgnoreCase: Boolean): integer;
var
  i: integer;
  LStr: string;
begin
  Result := -1;

  if AIgnoreCase then
    ATagName := UpperCase(ATagName);

  if FFindNextStartRowIndex > NextGrid1.RowCount - 1 then
    FFindNextStartRowIndex := 0;

  for i := FFindNextStartRowIndex to NextGrid1.RowCount - 1 do
  begin
    if Assigned(NextGrid1.Row[i].Data) then
    begin
      if AIgnoreCase then
        LStr := UpperCase(TEngineParameterItem(NextGrid1.Row[i].Data).TagName)
      else
        LStr := TEngineParameterItem(NextGrid1.Row[i].Data).TagName;

      if PosEx(ATagName, LStr) > 0 then
      begin
        Result := i;
        FFindNextStartRowIndex := i+1;
        Exit;
      end;
    end;
  end;
end;

function TFrameWatchGrid2.GetItemIndexFromGrid(ATagName: string): integer;
var
  i: integer;
begin
  Result := -1;

  for i := 0 to NextGrid1.RowCount - 1 do
  begin
    if Assigned(NextGrid1.Row[i].Data) then
    begin
      if TEngineParameterItem(NextGrid1.Row[i].Data).TagName = ATagName then
      begin
        Result := i;
        Exit;
      end;
    end;
  end;
end;

procedure TFrameWatchGrid2.GetItemsFromParamFile2Collect(AFileName: string;
  AEngParamFileFormat: integer; AEngParamEncrypt, AIsMDIChileMode: Boolean;
  AEngParam: TEngineParameter);
begin
  if AEngParam = nil then
    AEngParam := FIPCMonitorAll.FEngineParameter;

  if NextGrid1.RowCount > 0 then
  begin
    if MessageDlg('Do you want to apppend the watch list to the grid?',
                              mtConfirmation, [mbYes, mbNo], 0)= mrYes then
    begin
      AppendEngineParameterFromFile(AFileName, AEngParamFileFormat,
              AEngParamEncrypt, AIsMDIChileMode);
    end
    else
    begin
      AEngParam.EngineParameterCollect.Clear;
      FCompoundItemList.clear;
      NextGrid1.ClearRows;

      if AEngParamFileFormat = 0 then //JSON format
        AEngParam.LoadFromJSONFile(AFileName,
          ExtractFileName(AFileName),AEngParamEncrypt)
      else
      if AEngParamFileFormat = 1 then //XML format
        AEngParam.LoadFromFile(AFileName,
                  ExtractFileName(AFileName),AEngParamEncrypt)
      else
      if AEngParamFileFormat = 2 then //DB format
      begin
        if AEngParamEncrypt then
          AEngParam.LoadFromSqliteFile4Secure(AFileName)
        else
          AEngParam.LoadFromSqliteFile(AFileName);
      end;
    end;
  end
  else
  begin
    if AEngParamFileFormat = 0 then //JSON format
      AEngParam.LoadFromJSONFile(AFileName,
        ExtractFileName(AFileName),AEngParamEncrypt)
    else
    if AEngParamFileFormat = 1 then //XML format
      AEngParam.LoadFromFile(AFileName,
                ExtractFileName(AFileName), AEngParamEncrypt)
    else
    if AEngParamFileFormat = 2 then //DB format
    begin
      if AEngParamEncrypt then
        AEngParam.LoadFromSqliteFile4Secure(AFileName)
      else
        AEngParam.LoadFromSqliteFile(AFileName);
    end;
  end;

  FCurrentWatchListFileName := AFileName;
end;

function TFrameWatchGrid2.GetTagNameFromGrid(AIdx: integer): string;
begin
  Result := '';

  if Assigned(NextGrid1.Row[AIdx].Data) then
    Result := TEngineParameterItem(NextGrid1.Row[AIdx].Data).TagName;
end;

procedure TFrameWatchGrid2.GridItemMoveDown;
begin
  NextGrid1.MoveRow(NextGrid1.SelectedRow, NextGrid1.SelectedRow + 1);
  NextGrid1.SelectedRow := NextGrid1.SelectedRow + 1;
end;

procedure TFrameWatchGrid2.GridItemMoveUp;
begin
  NextGrid1.MoveRow(NextGrid1.SelectedRow, NextGrid1.SelectedRow - 1);
  NextGrid1.SelectedRow := NextGrid1.SelectedRow - 1;
end;

procedure TFrameWatchGrid2.HideGraphSheet(AIndex: integer);
begin
  NextGrid1.CellByName['SimpleDisplay', AIndex].AsInteger := -1;
  NextGrid1.CellByName['TrendDisplay', AIndex].AsInteger := -1;
  NextGrid1.CellByName['XYDisplay', AIndex].AsInteger := -1;
  NextGrid1.CellByName['AlarmEnable', AIndex].AsInteger := -1;
end;

procedure TFrameWatchGrid2.InitAvgMode;
var
  i,j: integer;
  LEngineParameterItem: TEngineParameterItem;
begin
  if FIsAvgDisplay4Items then
  begin
    NextGrid1.ColumnByName['IsAvg'].Visible := True;
    NextGrid1.ColumnByName['AvgValue'].Visible := True;

    j := 0;
    for i := 0 to NextGrid1.RowCount - 1 do
    begin
      if NextGrid1.CellByName['IsAvg',i].AsBoolean then
        inc(j);
    end;
  end;

  if FAverageQSize < 1 then
    FAverageQSize := 1000;

  for i := 0 to NextGrid1.RowCount - 1 do
  begin
//    if NextGrid1.CellByName['IsAvg',i].AsBoolean then
//    begin

      LEngineParameterItem := TEngineParameterItem(NextGrid1.Row[i].Data);

      if Assigned(LEngineParameterItem) then
        if not Assigned(LEngineParameterItem.FPCircularArray) then
          LEngineParameterItem.FPCircularArray := TCircularArray.Create(FAverageQSize);
//    end;
  end;

end;

procedure TFrameWatchGrid2.InitVar;
begin
  FCompoundItemList := TList<integer>.Create;
  FEngineParameterTarget := TEngineParameterDataFormat.Create(DropTextTarget1);
  FEngParamSource := TEngineParameterDataFormat.Create(EngParamSource2);
  FPJHTimerPool := TPJHTimerPool.Create(Self);
  FPM := TParameterManager.Create;
{$IFDEF USE_YURIMATHPARSER}
  FyuriParser := TParser.Create(Self);
{$ELSE}
  FcyMathParser1 := TcyMathParser.Create(Self);
  FcyMathParser1.OnCustomOperationParse := cyMathParser1CustomOperationParse;
{$ENDIF}

  NextGrid1.DoubleBuffered := False;
  FCurrentFindRowIdx := 0;
end;

procedure TFrameWatchGrid2.LoadGrid(AGrid: TNextGrid; AStm: TStream);
var
  i, j: integer;
  ACount: integer;
  Len: integer;
  S: string;
  Lss: TStringStream;
  LStrList: TStringList;
  LStrArr: System.Types.TStringDynArray;
begin
  Lss := TStringStream.Create;
  LStrList := TStringList.Create;
  try
    Lss.CopyFrom(AStm,0);

    AGrid.BeginUpdate;
    AGrid.ClearRows;

    LStrList.LineBreak := #13;
    LStrList.Text := Lss.DataString;
    ACount := StrToIntDef(LStrList.Strings[0],0);
    AGrid.AddRow(ACount);

    for i := 0 to ACount - 1 do
    begin
      LStrArr := SplitString(LStrList.Strings[i+1], ';');

      for j := 0 to High(LStrArr) do
      begin
        AGrid.Cells[j,i] := LStrArr[j];
      end;
    end;

  finally
    Lss.Free;
    LStrList.Free;
    AGrid.EndUpdate;
  end;

//  AGrid.BeginUpdate;
//  AGrid.ClearRows;
//  AStm.ReadBuffer(ACount, SizeOf(integer)); //read RowCount
//  AGrid.AddRow(ACount);
//  for i := 0 to ACount - 1 do begin
//    for j := 0 to AGrid.Columns.Count - 1 do begin
//      AStm.ReadBuffer(Len, SizeOf(integer));
//      if Len <> 0 then begin  //if length=0, nothing in stream
//        SetLength(S, Len);
//        AStm.ReadBuffer(S[1], Len);
//        AGrid.Cells[j, i] := S;
//      end;
//    end;
//  end;
//  AGrid.EndUpdate;
end;

procedure TFrameWatchGrid2.NextGrid1CellDblClick(Sender: TObject; ACol,
  ARow: Integer);
var
  LRect: TRect;
begin
  LRect := NextGrid1.GetHeaderRect;

  if PtInRect(LRect, FMousePoint) then
    exit;

  ShowProperties;
end;

procedure TFrameWatchGrid2.NextGrid1CustomDrawCell(Sender: TObject; ACol,
  ARow: Integer; CellRect: TRect; CellState: TCellState);
begin
  //if (ARow mod 2) = 0 then
  //  FWG.NextGrid1.Cell[ACol, ARow].Color := $00E9FFD2;
end;

procedure TFrameWatchGrid2.NextGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FKeyBdShiftState := Shift;

  case Key of
    vk_delete: begin
      DeleteGridItem;
          //DeleteEngineParamterFromGrid(FWG.NextGrid1.SelectedRow);
    end;
    vk_Up: begin
      if FGridItemMoveMode then
        GridItemMoveUp;
    end;
    vk_Down: begin
      if FGridItemMoveMode then
        GridItemMoveDown;
    end;
    VK_HANJA: begin
      FGridItemMoveMode := True;
    end;
  end;
end;

procedure TFrameWatchGrid2.NextGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FKeyBdShiftState := Shift;

  case Key of
    VK_HANJA: begin
      FGridItemMoveMode := False;
    end;
  end;
end;

procedure TFrameWatchGrid2.NextGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: integer;
  LEngineParameterItem: TEngineParameterItem;
  LRect: TRect;
  LPoint: TPoint;
  LEPD: TEngineParameter_DragDrop;
begin
  LRect := NextGrid1.GetHeaderRect;
  LPoint.X := X;
  LPoint.Y := Y;

  if PtInRect(LRect, LPoint) then
    exit;

  if NextGrid1.SelectedCount > 0 then
  begin
    if (DragDetectPlus(TWinControl(Sender).Handle, Point(X,Y))) then
    begin
      if NextGrid1.SelectedCount = 1 then
      begin
        i := NextGrid1.SelectedRow;
        FIPCMonitorAll.MoveEngineParameterItemRecord2(FEngineParameterItemRecord,i);
        FEngineParameterItemRecord.AssignTo(LEPD.FEPItem);
        LEPD.FDragDataType := dddtSingleRecord;
        LEPD.FShiftState := Shift;//FKeyBdShiftState;
        FEngParamSource.EPD := LEPD;

        //Matrix Data Move가 누락됨. 나중에 추가할 것.
      end
      else
      begin
        LEPD.FSourceHandle := Handle;
        LEPD.FShiftState := Shift;//FKeyBdShiftState;
        LEPD.FDragDataType := dddtMultiRecord;
        FEngParamSource.EPD := LEPD;
      end;

      EngParamSource2.Execute;
    end;
  end;
end;

procedure TFrameWatchGrid2.NextGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  FMousePoint.X := X;
  FMousePoint.Y := Y;
end;

procedure TFrameWatchGrid2.NextGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer);
var
  LEngineParameterItem: TEngineParameterItem;
  Li: integer;
begin
  if not Assigned(FIPCMonitorAll.FEngineParameter) then
    exit;

  if NextGrid1.SelectedCount = 1 then
  begin
    Li := NextGrid1.SelectedRow;
    LEngineParameterItem :=
              FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[Li];
    TNxButtonColumn(NextGrid1.ColumnByName['Value']).ShowButton := //.Item[3]
                        LEngineParameterItem.ParameterType in TMatrixTypes;
    FEventName4Item := GetEventName(LEngineParameterItem);
  end;
end;

procedure TFrameWatchGrid2.OnAvgCalc(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
var
  i, LRow: integer;
  tmpdouble: double;
  LEP: TEngineParameterCollect;
  LStr: string;
begin
  System.TMonitor.Enter(Self);
  try
    if FIsAvgDisplay4Items then //Average Mode
    begin
//      DSA.DisplayMessage(#13#10+TimeToStr(Time)+' Data Received by timer in Average Mode!', 0);
      LEP := FIPCMonitorAll.FEngineParameter.EngineParameterCollect;

      for i := 0 to LEP.Count - 1 do
      begin
        if Assigned(LEP.Items[i].NextGridRow) then
        begin
          LRow := NextGrid1.GetRowIndex(TRow(LEP.Items[i].NextGridRow));

          if NextGrid1.CellByName['IsAvg',LRow].AsBoolean then //Average Calc Mode
          begin
            if Pos('.', LEP.Items[i].Value) > 0 then
              tmpdouble := StrToFloatDef(LEP.Items[i].Value, 0.0)
            else
              tmpdouble := StrToIntDef(LEP.Items[i].Value, 0)/1;

            if Assigned(LEP.Items[i].FPCircularArray) then
            begin
              TCircularArray(LEP.Items[i].FPCircularArray).Put(tmpdouble);
              tmpdouble := TCircularArray(LEP.Items[i].FPCircularArray).Average;
              if LEP.Items[i].RadixPosition = 0 then
                LStr := Format('%d', [Round(tmpdouble)])
              else
                LStr := FormatFloat(LEP.Items[i].DisplayFormat, tmpdouble);

              NextGrid1.CellByName['AvgValue',LRow].AsString := LStr;
            end;
          end;
        end;
      end;
    end;
  finally
    System.TMonitor.Exit(Self);
  end;
end;

procedure TFrameWatchGrid2.OnDisplayCalculatedItemValue(Sender: TObject;
  Handle: Integer; Interval: Cardinal; ElapsedTime: Integer);
var
  i,j,k,m,r: integer;
  LStrList: TStringList;
  LValue: Double;
  LCalcResult: Double;
{$IFDEF USE_YURIMATHPARSER}
  Script: TScript;
{$ENDIF}
begin
  FPJHTimerPool.Enabled[Handle] := False;
  try
    for m := FCompoundItemList.Count - 1 downto 0 do
    begin
      i := FCompoundItemList.Items[m];

      if i > (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Count - 1) then
      begin
        DisplayMessage('TFrameWatchGrid.OnDisplayCalculatedItemValue => if i > (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Count - 1 : i = ' + IntToStr(i));
        exit;
      end;

      if FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].SharedName = '' then
      begin
        DisplayMessage('TFrameWatchGrid.OnDisplayCalculatedItemValue => if FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].SharedName = '' then exit');
        exit;
      end;

      LStrList := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].FormulaValueStringList;

      if Assigned(LStrList) then
      begin
//{$IFNDEF USE_YURIMATHPARSER}
        FcyMathParser1.Expression :=
          FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].SharedName;
//{$ENDIF}

        //TagName=3 형식으로 저장됨
        for j := 0 to LStrList.Count - 1 do
        begin
          k := StrToInt(LStrList.ValueFromIndex[j]);
          //k가 Collect 범위 내에 존재 하면
          if k < FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Count then
          begin
            LValue := StrToFloatDef(
              FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[k].Value,0.0);

//{$IFDEF USE_YURIMATHPARSER}
//          FyuriParser.AddConstant(LStrList.Names[j], LValue);
//{$ELSE}
            FcyMathParser1.Variables.SetValue(LStrList.Names[j], LValue);
//{$ENDIF}

//          {$IFDEF USECODESITE}
//          CodeSite.EnterMethod('FcyMathParser1.Variables.SetValue ===>');
//          try
//            CodeSite.Send('LStrList.Names[j]', LStrList.Names[j]);
//            CodeSite.Send('LValue', LValue);
//          {$ENDIF}
//
//          {$IFDEF USECODESITE}
//          finally
//            CodeSite.ExitMethod('FcyMathParser1.Variables.SetValue <===');
//          end;
//          {$ENDIF}
          end;//if
        end;//for
      end;//if

{$IFDEF USE_YURIMATHPARSER}
      try
        FyuriParser.StringToScript(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].SharedName, Script);
        try
          LCalcResult :=  FyuriParser.Execute(Script)^;
        except
          LCalcResult := 0;
        end;
      finally
        Script := nil;
      end;
{$ELSE}
      try
        FcyMathParser1.Parse;

        if FcyMathParser1.GetLastError = 0 then
        begin
          LCalcResult := FcyMathParser1.ParserResult;

//          {$IFDEF USECODESITE}
//          CodeSite.EnterMethod('FcyMathParser1.Expression ===>');
//          try
//            CodeSite.Send('FcyMathParser1.Expression', FcyMathParser1.Expression);
//            CodeSite.Send('FcyMathParser1.ParserResult', FcyMathParser1.ParserResult);
//          {$ENDIF}
//
//          {$IFDEF USECODESITE}
//          finally
//            CodeSite.ExitMethod('FcyMathParser1.Expression <===');
//          end;
//          {$ENDIF}
        end
        else
        begin
          LCalcResult := 0;
        end;
      except
        LCalcResult := 0;
      end;
{$ENDIF}

      FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].Value :=
        FormatFloat(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].DisplayFormat, LCalcResult);
//        Format('%.2f', [LCalcResult]);
      r := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].RadixPosition;

      if r = 0 then
        FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].Value :=
          Format('%d', [Round(LCalcResult)]);

      if Assigned(FWatchValue2Screen_Analog) then
        FWatchValue2Screen_Analog('', '', i);
    end;//for
  finally
    FPJHTimerPool.Enabled[Handle] := True;
  end;
end;

procedure TFrameWatchGrid2.OnDisplayElapsedTime4AvgCalc(Sender: TObject;
  Handle: Integer; Interval: Cardinal; ElapsedTime: Integer);
begin
  FElapsedTimeOfAvgCalc := ElapsedTime div 1000;
end;

procedure TFrameWatchGrid2.PopupCopyMode(AShiftState: TShiftState;
  APoint: TPoint);
var
  LPoint: TPoint;
  LMenu: TCopyModeMenuF;
begin
  if ssCtrl in AShiftState then
  begin
    if FMultiDragOn < 2 then //0 또는 1이면 Popup
    begin
      LMenu := TCopyModeMenuF.Create(self);
      try
        LPoint := ClientToScreen(APoint);

        if LMenu.ShowModal = mrOK then
        begin
          FDragCopyMode := TParamDragCopyMode(LMenu.Tag);

          case TParamDragCopyMode(LMenu.Tag) of
            dcmCopyOnlyNonExist: ;
            dcmCopyOnlyExist: ;
            dcmCopyAllOverWrite:  ;
            dcmCopyCancel: ;
          end;

          if FMultiDragOn = 1 then
            inc(FMultiDragOn);
        end;
      finally
        LMenu.Free;
      end;
    end;
  end;
end;

procedure TFrameWatchGrid2.ProcessCopyMode(AShiftState: TShiftState;
  APoint: TPoint);
begin
  if FDragCopyMode <> dcmCopyCancel then
    ProcessItemsDrop(FDragCopyMode);
end;

function TFrameWatchGrid2.ProcessItemsDrop(ADragCopyMode: TParamDragCopyMode): integer;
begin
  Result := CreateIPCMonitor(FTempParamItemRecord, ADragCopyMode);
end;

//Result: Formula Value List(TagName=EngineParameterItem Index)
//Delphi Version 변경시 cyMathParser.pas 파일에 아래 내용 추가 (수정)할 것
//1. TVariables class의 procedure Clear 함수를 public로 옮긴다.
//2. TcyMathParser.InfixToPreFix함수에서 "case Current.TypeStack of" 부분을 아래와 같이 수정할 것
//    case Current.TypeStack of
//      tsValue, TsVariable:
//        begin
//          Variables.Add(Current.Name,0);
//          Prefix.Add(Current);
//        end;

function TFrameWatchGrid2.ReAssignFormulaValueList(AFormula: string;
  AIndex: integer): TStringList;
var
  i,j: integer;
  LStr: string;
  LStrList: TStringList;
begin
  Result:= TStringList.Create;
{$IFNDEF USE_YURIMATHPARSER}
  FcyMathParser1.Variables.Clear;
  FcyMathParser1.Expression := AFormula;//make variable list from the formula
{$ELSE}
  FyuriParser.
{$ENDIF}

  for i := 0 to FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    LStr := FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[i].TagName;

    j := FcyMathParser1.Variables.GetIndex(LStr);

    if j > -1 then
      Result.Add(LStr + '=' + IntToStr(i));
  end;

  if AIndex > -1 then
  begin
    if Assigned(FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIndex].FormulaValueStringList) then
      FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIndex].FormulaValueStringList.Free;

    FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIndex].FormulaValueStringList := Result;
    FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIndex].FormulaValueList :=
      Result.Text;
  end;
end;

procedure TFrameWatchGrid2.RestartAvgCalc(AUseFinalize: Boolean;
  AQSize: integer);
begin
  StopAvgCalc;

  //이전 설정이 AvgCalc 모드이고 Q Size가 변경 되었으면 Q 크기를 재설정하기 위해
  //Q를 재생성함
  if AUseFinalize then
    FinalizeAvgMode;

  FIsAvgDisplay4Items := True;
  FAverageQSize := AQSize;
  InitAvgMode;//각 Item에 Avg Q 생성
  SelectAllItems4Avg;
  StartAvgCalc;
end;

procedure TFrameWatchGrid2.SaveAvg2File(AFileName: string);
var
  LCsv, LHeader: string;
  i: integer;
begin
  for i := 0 to NextGrid1.RowCount - 1 do
  begin
    LCsv := LCsv + NextGrid1.CellByName['AvgValue',i].AsString + ',';
    LHeader := LHeader + NextGrid1.CellByName['ItemName',i].AsString + ',';
  end;

  LCsv := LeftStr(LCsv, Length(LCsv) - 1);
  LHeader := LeftStr(LHeader, Length(LHeader) - 1);

  if SaveData2FixedFile('CSVFile', AFileName, LCsv, soFromEnd) then
    SaveData2FixedFile('CSVFile',AFileName, LHeader, soFromBeginning);
end;

procedure TFrameWatchGrid2.SaveGrid(AGrid: TNextGrid; AStm: TStream);
var
  i, j: integer;
  Len: integer;
  S: string;
  Lss: TStringStream;
begin
  Lss := TStringStream.Create;
  try
    Len := AGrid.RowCount;
    Lss.WriteString(IntToStr(Len) + #13);

    for i := 0 to AGrid.RowCount - 1 do
    begin
      for j := 0 to AGrid.Columns.Count - 1 do
      begin
        Lss.WriteString(AGrid.Cells[j,i]);

        if j = (AGrid.Columns.Count - 1) then
          Lss.WriteString(#13)
        else
          Lss.WriteString(';');
      end;
    end;

    AStm.CopyFrom(Lss,0);
  finally
    Lss.Free;
  end;

//  AStm.WriteBuffer(Len, SizeOf(integer)); //write RowCount
//  for i := 0 to AGrid.RowCount - 1 do begin
//    for j := 0 to AGrid.Columns.Count - 1 do begin
//      S := AGrid[j, i];
//      Len := Length(S)*2;    //write length
//      AStm.WriteBuffer(Len, SizeOf(integer));
//      if Len <> 0 then begin
//        AStm.WriteBuffer(S[1], Len);   //write string if not empty
//      end;
//    end;
//  end;
end;

procedure TFrameWatchGrid2.SelectAllItems4Avg;
var
  i: integer;
begin
  for i := 0 to NextGrid1.RowCount - 1 do
    NextGrid1.CellByName['IsAvg',i].AsBoolean := True;
end;

procedure TFrameWatchGrid2.SelectTagName4RunCondition(AUniqueEngName: string;
  ADestGrid: TNextGrid);
var
  LTagInfoEditorDlg: TTagInfoEditorDlg;
  LTagList, LDescList, LValueList, LIndexList: TStringList;
  i, LIdx: integer;
  LUniqueEng: string;
  LItem: TListItem;
begin
  LTagInfoEditorDlg := TTagInfoEditorDlg.Create(nil);
  try
    LTagList := TStringList.Create;
    LDescList := TStringList.Create;
    LValueList := TStringList.Create;
    LIndexList := TStringList.Create;

    try
      for i := 0 to NextGrid1.RowCount - 1 do
      begin
        LUniqueEng := GetUniqueEngName(TEngineParameterItem(NextGrid1.Row[i].Data).ProjNo,
          TEngineParameterItem(NextGrid1.Row[i].Data).EngNo);

        if SameText(LUniqueEng, AUniqueEngName) then
        begin
          LTagList.Add(TEngineParameterItem(NextGrid1.Row[i].Data).TagName);
          LDescList.Add(TEngineParameterItem(NextGrid1.Row[i].Data).Description);
          LValueList.Add(TEngineParameterItem(NextGrid1.Row[i].Data).Value);
          LIndexList.Add(IntToStr(i));
        end;
      end;

      with LTagInfoEditorDlg do
      begin
        GetTagList(LTagList, LDescList, LValueList, LIndexList);

        LIdx := StrToIntDef(ADestGrid.CellByName['ParamIndex',ADestGrid.SelectedRow].AsString,-1);

        if (LIdx >= 0) and (LIdx < ListView1.Items.Count) then
        begin
          LItem := ListView1.Items[LIdx];
          LItem.MakeVisible(False);
          LItem.Selected := True;
          LItem.Focused := True;
        end;

        if Execute then
        begin
          ADestGrid.CellByName['TagName', ADestGrid.SelectedRow].AsString := ListView1.Selected.Caption;
          ADestGrid.CellByName['TagDesc', ADestGrid.SelectedRow].AsString := ListView1.Selected.SubItems.Strings[0];
          ADestGrid.CellByName['ParamIndex', ADestGrid.SelectedRow].AsString := IntToStr(FParamIndex);
        end;
      end;
    finally
      LTagList.Free;
      LDescList.Free;
      LValueList.Free;
      LIndexList.Free;
    end;
  finally
    LTagInfoEditorDlg.Free;
  end;
end;

function TFrameWatchGrid2.SendEngParam2HandleWindow(var AMultiWatchHandle: TpjhArrayHandle;
  AProcessName: string; ADestHandle: Integer): THandle;
var
  LHandle,LProcessID: THandle;
  LParam: string;
begin
  if ADestHandle = -1 then
  begin
//      SetCurrentDir(ExtractFilePath(AProcessName));
    LParam := '';
    if FileExists(AProcessName) then
    begin
      LProcessId := ExecNewProcess2(AProcessName, LParam);
      LHandle := DSiGetProcessWindow(LProcessId);

      if Assigned(AMultiWatchHandle) then
      begin
        SetLength(AMultiWatchHandle, Length(AMultiWatchHandle)+1);
        AMultiWatchHandle[High(AMultiWatchHandle)] := LHandle;
      end;
    end
    else
    begin
      ShowMessage('Process File not found : ' + AProcessName);
      exit;
    end;

//  AEPItemRecord.AssignTo(FEngineParameterItemRecord);
//  MoveMatrixData2ItemRecord(FEngineParameterItemRecord, AEPItemRecord);
  end
  else
    LHandle := ADestHandle;

  FPM.SendEPCopyData(Handle, LHandle, FEngineParameterItemRecord);

  Result := LHandle;
end;

procedure TFrameWatchGrid2.SendFormCopyData(ToHandle: integer; AForm: TForm);
var
  cd : TCopyDataStruct;
begin
  with cd do
  begin
    dwData := Handle;
    cbData := sizeof(AForm);
    lpData := @AForm;
  end;//with

  SendMessage(ToHandle, WM_COPYDATA, 0, LongInt(@cd));
end;

procedure TFrameWatchGrid2.SetConfigEngParamItemData(AIndex: Integer);
var
  ConfigData: TEngParamItemConfigForm2;
  LEngineParameterItem: TEngineParameterItem;
begin
  LEngineParameterItem := TEngineParameterItem(NextGrid1.Row[AIndex].Data);

  if Assigned(LEngineParameterItem) then
  begin
    ConfigData := nil;
    ConfigData := TEngParamItemConfigForm2.Create(Self);

    try
      with ConfigData do
      begin
        AdvOfficePager1.ActivePageIndex := 0;
        LoadConfigEngParamItem2Form(LEngineParameterItem);

        if ShowModal = mrOK then
        begin
          LoadConfigForm2EngParamItem(LEngineParameterItem);
          UpdateGridFromEngParam2Index(LEngineParameterItem, AIndex);

////          if LEngineParameterItem.ParameterSource = psManualInput then
//            NextGrid1.CellByName['Value', AIndex].AsString := LEngineParameterItem.Value;
//
////          if LEngineParameterItem.SensorType = stCalculated then
//            NextGrid1.CellByName['ItemName', AIndex].AsString := LEngineParameterItem.Description;
//            NextGrid1.CellByName['TagName', AIndex].AsString := LEngineParameterItem.TagName;
//            NextGrid1.CellByName['FUnit', AIndex].AsString := LEngineParameterItem.FUnit;
        end;
      end;//with
    finally
      ConfigData.Free;
      ConfigData := nil;
    end;//try
  end
  else
    ShowMessage('Not assigned Grid''s row index:' + IntToStr(AIndex));
end;

procedure TFrameWatchGrid2.SetDeleteEngineParamterFromGrid(
  AFunc: TDeleteEngineParamterFromGrid);
begin
  FDeleteEngineParamterFromGrid := AFunc;
end;

procedure TFrameWatchGrid2.SetEngParam2IPCMonitorAll(ASource: TEngineParameter);
begin
  FIPCMonitorAll.FEngineParameter.Assign(ASource);
end;

procedure TFrameWatchGrid2.SetEngParamCollect2IPCMonotorAll(
  ASource: TEngineParameterCollect);
begin
  FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Assign(ASource);
end;

procedure TFrameWatchGrid2.SetIPCMonitorAll(AIPCMonitor: TFrameIPCMonitor2);
begin
  FIPCMonitorAll := AIPCMonitor;
end;

procedure TFrameWatchGrid2.SetMainFormHandle(AHandle: THandle);
begin
  FHandle := AHandle;
end;

procedure TFrameWatchGrid2.SetProgramMode(AMode: TProgramMode);
begin
  FProgramMode := AMode;
end;

procedure TFrameWatchGrid2.SetStatusBar(AStatusBar: TJvStatusBar);
begin
  FStatusBar := AStatusBar;
end;

procedure TFrameWatchGrid2.SetWatchValue2Screen_Analog(
  AFunc: TWatchValue2Screen_Analog);
begin
  FWatchValue2Screen_Analog := AFunc;
end;

procedure TFrameWatchGrid2.ShowFindForm;
var
  LFindWatchGridF: TFindWatchGridF;
begin
  with TFindWatchGridF.Create(nil) do
  begin
    try
      if ShowModal = mrOK then
      begin
        FindGridFromOption(OptionRG.ItemIndex, FindStrEdit.Text);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TFrameWatchGrid2.ShowProperties(AParamCollect: TEngineParameterCollect);
var
  Li: integer;
begin
  if NextGrid1.SelectedCount > 1 then
  begin
    ShowMessage('This function allows when selected only one row!');
    exit;
  end;

  if not Assigned(FIPCMonitorAll) then
    exit;

  if NextGrid1.SelectedCount = 1 then
  begin
    Li := NextGrid1.SelectedRow;

    if not Assigned(AParamCollect) then
      if Assigned(FIPCMonitorAll.FEngineParameter) then
        AParamCollect := FIPCMonitorAll.FEngineParameter.EngineParameterCollect;

    if not Assigned(AParamCollect) then
      exit;

    if Li > AParamCollect.Count - 1 then
    begin
      ShowMessage('Selected Row Index is greater than Parameter Collect Index');
      exit;
    end;

    SetConfigEngParamItemData(Li);
  end;
end;

procedure TFrameWatchGrid2.ShowTagNameColumn;
var
  LColumn: TNxCustomColumn;
begin
  LColumn := NextGrid1.ColumnByName['TagName'];
  LColumn.Visible := not LColumn.Visible;
end;

procedure TFrameWatchGrid2.StartAvgCalc;
begin
  if FDisplayElapsedTimeHandle > 0 then
    FPJHTimerPool.Remove(FDisplayElapsedTimeHandle);

  if FAvgCalcTimerHandle > 0 then
    FPJHTimerPool.Remove(FAvgCalcTimerHandle);

  NextGrid1.Color := clYellow;

  if FAvgCalcInterval = 0 then
    FAvgCalcInterval := 1000;

  FDisplayElapsedTimeHandle := FPJHTimerPool.Add(OnDisplayElapsedTime4AvgCalc, 1000); //경과시간 표시
  FAvgCalcTimerHandle := FPJHTimerPool.Add(OnAvgCalc, FAvgCalcInterval);
end;

function TFrameWatchGrid2.StopAvgCalc: Boolean;
var
  i: integer;
begin
  Result := False;
  NextGrid1.Color := clWindow;

  FPJHTimerPool.Enabled[FDisplayElapsedTimeHandle] := False;
  FPJHTimerPool.Enabled[FAvgCalcTimerHandle] := False;

  Result := True;
end;

procedure TFrameWatchGrid2.UpdateGridFromEngParam2Index(AEPItem: TEngineParameterItem;
  AIdx: integer);
begin
  if AEPItem.Description = '' then
    NextGrid1.CellsByName['ItemName', AIdx] := AEPItem.TagName
  else
    NextGrid1.CellsByName['ItemName', AIdx] := AEPItem.Description;

  NextGrid1.CellsByName['FUnit', AIdx] := AEPItem.FUnit;

  if AEPItem.ParameterSource = psManualInput then
    NextGrid1.CellsByName['Value', AIdx] := AEPItem.Value
  else
  if (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].SensorType = stParam) and
    (FIPCMonitorAll.FEngineParameter.EngineParameterCollect.Items[AIdx].ParameterSource = psECS_AVAT2) then
    NextGrid1.CellsByName['Value', AIdx] := AEPItem.Value;

  NextGrid1.CellByName['ExcelRange',AIdx].AsString := AEPItem.FExcelRange;
  NextGrid1.CellsByName['TagName', AIdx] := AEPItem.TagName;
end;

procedure TFrameWatchGrid2.WmChangeCopyMode(var Msg: TMessage);
begin
  FMultiDragOn := Msg.WParam;
end;

//Parameter를 DropTarget에 보낼때만 사용됨.
//받을 경우에는 메인 폼에 WM_COPYDATA 함수를 생성 할 것
procedure TFrameWatchGrid2.WMCopyData(var Msg: TMessage);
var
  i, LCopyMode, LHandle: integer;
  LWatchHandles : TpjhArrayHandle;
begin
//  case Msg.WParam of
//    //User Level Receive
//    2: FIPCMonitorAll.FCurrentUserLevel := THiMECSUserLevel(PCopyDataStruct(Msg.LParam)^.cbData);
//    //dcmCopyOnlyExist Receive
//    3: CreateIPCMonitor(PEngineParameterItemRecord(PCopyDataStruct(Msg.LParam)^.lpData)^, dcmCopyOnlyExist);
//    else
//      CreateIPCMonitor(PEngineParameterItemRecord(PCopyDataStruct(Msg.LParam)^.lpData)^, FDragCopyMode);
//  end;

  case Msg.WParam of
    WParam_REQMULTIRECORD: begin//Handle 수신 OK
      FKeyBdShiftState := PKbdShiftRec(PCopyDataStruct(Msg.LParam)^.lpData)^.FKbdShift;
      LCopyMode := PKbdShiftRec(PCopyDataStruct(Msg.LParam)^.lpData)^.ParamDragMode;
      LHandle := PKbdShiftRec(PCopyDataStruct(Msg.LParam)^.lpData)^.MyHandle;
      SendMessage(LHandle, WM_MULTICOPY_BEGIN, 0, 0);

      for i := 0 to NextGrid1.RowCount - 1 do
      begin
        if NextGrid1.Row[i].Selected then
        begin
          FIPCMonitorAll.MoveEngineParameterItemRecord2(FEngineParameterItemRecord,i);
          FEngineParameterItemRecord.FParamDragCopyMode := TParamDragCopyMode(LCopyMode);
          SendEngParam2HandleWindow(LWatchHandles, '', LHandle);
        end;
      end;

      SendMessage(LHandle, WM_MULTICOPY_END, 0, 0);
      FKeyBdShiftState := [];
      FEngineParameterItemRecord.FParamDragCopyMode := dcmCopyCancel;
    end;
    WParam_DISPLAYMSG: begin//MDI Child Caption 수신
      //ShowMessage(PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^.StrMsg);
    end;
  end;

  {$IFDEF USECODESITE}
  CodeSite.EnterMethod('TFrameWatchGrid.WMCopyData ===>');
  try
    CodeSite.Send('Msg.WParam', Msg.WParam);
  finally
    CodeSite.ExitMethod('TFrameWatchGrid.WMCopyData <===');
  end;
  {$ENDIF}
end;

procedure TFrameWatchGrid2.WMMultiCopyBegin(var Msg: TMessage);
begin
  FMultiDragOn := 1;
end;

procedure TFrameWatchGrid2.WMMultiCopyEnd(var Msg: TMessage);
begin
  FMultiDragOn := 0;
end;

end.
