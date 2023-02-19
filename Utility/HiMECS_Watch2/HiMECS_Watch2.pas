unit HiMECS_Watch2;
{ 실행 방법
  HiMECS_Watch2p.exe /pEngParamFileName Command = Param파일 읽어서 Command에 따라 표시함.
                     /mAlarmlist = Alarmlist mode로 시작함
                     /uUserLevel = UserLevel 프로그램 시작함(0..3)
  Command = DISPLAYTREND: CopyData로 받은 Engparamd을 Trend로 보여줌
            SIMPLE: CopyData로 받은 Engparamd을 Simple로 보여줌

  2013.5.21
  - HiMECS_Watch2p.manifest 파일 적용, release 모드일 경우에만(볼랜드포럼에서 참조)
    : 관리자 권한으로 실행 됨(F9로 실행 안됨)
    : Debug 모드에서는 사용자 권한으로 실행(F9 실행 됨)
  2011.1.3:
    1) iPlotDataCursor.pas 수정: AddMenuItems함수에 UserMenuItem 추가
  2011.11.2:
    1) iPlotDataCursor.pas 수정: DeltaX mode시 X,Y값 변수 추가
                               : SetData_DeltaX함수 추가
    2) iPlotChannel.pas 수정:DataCursorUpate 함수 수정
      (data cursor의 DeltaX mode를 이용해 구간내 Y값을 가져오기 위함)
  2011.11.26:
    1) popup menu item의 tag는 user level로 사용됨-Timer 함수에서 처리
  2011.11.30
  1) watch list file name 변경: x xxxxxxxxxxx x
                                -             -
                                실행프로그램  User Level
    실행프로그램: 1: HiMECS_Watch2p.exe
                  2: HiMECS_WatchSavep.exe
  2011.12.12
  1) UnitFrameIPCMonitorAll 적용함

}
//{$DEFINE USE_PACKAGE}//HiMECS.inc file로 대체함
//HiMECS_Watch2_Nobpl.exe 실행시에는 HiMECS.inc 내용 중에  {$DEFINE USE_PACKAGE}를 Comment 처리 한 후 실행 해야 함
{$I HiMECS.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  system.Generics.Collections,
  Dialogs, ComCtrls, iComponent, iVCLComponent, iCustomComponent, Vcl.AppEvnts,
  iPlotComponent, iPlot, StdCtrls, ExtCtrls,SyncObjs, iniFiles, DeCALIO,
  Menus, iProgressComponent, iLedBar, ShadowButton, SuperStream,//janSQL,
  iPositionComponent, iScaleComponent, iGaugeComponent, iAngularGauge, iXYPlotChannel,
  iPlotToolBar, iPlotObjects,iPlotChannelCustom, iTypes,
  DragDrop, DropTarget, DragDropFormats, DragDropText, AdvTrackBar,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, iXYPlot, NxColumns, NxColumnClasses,
  ImgList, JvDialogs, DropSource, JvExComCtrls, JvStatusBar, JclDebug, JvComCtrls,
  DB, UnitAlarmConfig, Mask, JvExMask, JvComponent, JvAppHotKey,
  JvToolEdit, AdvOfficeStatusBar,// cyMathParser, //CalcExpress, sql3_defs
  AdvOfficeStatusBarStylers, AdvOfficePager, pjhFormDesigner,
  DesignFormConfigClass2, pjhPanel, JvComponentBase, JvDockTree,
  JvDockControlForm, JvDockVIDStyle, JvDockVSNetStyle, TimerPool,
  UnitAlarmConfigClass2, DeCAL, WatchConfig2, CircularArray, WatchConst2,
  FrmEngParamConfig, Watch2Interface, UnitCopyData, GpCommandLineParser,
  GpSharedMemory, GpLists, GpSharedEvents, //, IPC.Events
  //IPCThrd_LBX, IPCThrdMonitor_LBX, IPCThrd_WT1600, IPCThrdMonitor_WT1600,
  //IPCThrd_ECS_kumo, IPCThrdMonitor_ECS_kumo, IPCThrd_MEXA7000, IPCThrdMonitor_MEXA7000,
  //IPCThrd_MT210, IPCThrdMonitor_MT210, IPCThrd_FlowMeter, IPCThrdMonitor_FlowMeter,
  //IPCThrd_DYNAMO, IPCThrdMonitor_DYNAMO, IPCThrd_ECS_AVAT, IPCThrdMonitor_ECS_AVAT,
  //IPCThrd_GasCalc, IPCThrdMonitor_GasCalc,
  ModbusComStruct, ConfigOptionClass2, UnitDragDropRecord2, HiMECSConst,
  Cromis.Comm.IPC, Cromis.Threading, IPCThrd_HiMECS_MDI, JvExExtCtrls, JvExtComponent,
  JvItemsPanel, UnitParameterManager2, NxCollection, cyResizer,
  UnitSTOMPClass, UnitWorker4OmniMsgQ, UnitMQConst, UnitSynLog2,
  mormot.core.base, mormot.core.rtti, mormot.core.variants, mormot.core.data,
  mormot.core.text, mormot.core.log, mormot.core.json,
  UnitEngineParameterClass2, UnitMultiStateRecord2, UnitSimulateParamRecord2,
  pjhTJvTransparentButtonConst, UnitFileType
  //UnitSelectControl
 {$IFDEF USECODESITE} ,CodeSiteLogging {$ENDIF}

{$IFDEF NOUSE_PACKAGE} //NoBpl.exe Compile시 필요함(Class not found 해결책)
  //for pjhDelphiStandard
  ,pjhDelphiStandardCompConst, pjhTPanel, pjhTImage, pjhTBevel, pjhTGridPanel,
  pjhTLedPanel, pjhTShadowButton,

  //for pjhIOCompStd
  pjhIOCompStdConst, pjhiAnalogDisplay, pjhiAnalogOutPut, pjhiAngularGauge,
  pjhiEdit, pjhiGradient, pjhiIntegerOutput, pjhiKnob, pjhiLabel, pjhiLedBar,
  pjhiLedRectangle, pjhiLedRound, pjhiLedSpiral, pjhiLinearGauge, pjhiOdometer,
  pjhiSevenSegmentAnalog, pjhiSevenSegmentBinary, pjhiSevenSegmentHexaDecimal,
  pjhiSevenSegmentInteger, pjhiSlider, pjhiSwitchLed, pjhiSwitchPanel,
  pjhiSwitchRotary, pjhiSwitchSlider, pjhiSwitchToggle, pjhiThermoMeter,

  //for IOCompPro
  pjhIOCompProConst, pjhiAngularLogGauge, pjhiCompass, pjhiDualCompass,
  pjhiLCDMatrix, pjhiLedArrow, pjhiLedDiamond, pjhiLogGauge, pjhiMotor,
  pjhiPanel, pjhiPipe, pjhiPipeJoint, pjhiRotationDisplay, pjhiSlidingScale,
  pjhiSwitchLever, pjhiSwitchRocker, pjhiTank, pjhiValve,

  //for pjhTMSComp
  pjhTMSCompConst, pjhadvProgressBar, pjhadvCircularProgress,

  //for pjhTMSSmoothComp
  pjhTMSSmoothCompConst, pjhadvSmoothGauge, pjhadvSmoothLabel, pjhadvSmoothPanel,
  pjhadvSmoothTrackBar, pjhadvSmoothStatusIndicator, pjhadvSmoothProgressBar,
  pjhadvSmoothToggleButton, pjhadvSmoothLedLabel, pjhadvSmoothExpanderPanel,
  pjhadvSmoothExpanderButtonPanel, pjhadvSmoothTimeLine, pjhadvSmoothCalculator,
  pjhadvSmoothCalculatorDropDown,

  //for pjhJvComp
  pjhJvCompConst, JvGIFCtrl, pjhTJvLabel, pjhTJvTransparentButton,

  //for pjhxIOComp
  pjhxIOCompConst, pjhiLedArrow_pjh, pjhiMotor_pjh, pjhiPipe_pjh,
  pjhiPipeJoint_pjh, pjhiTank_pjh, pjhiValve_pjh, pjhjvGIFAnimator_pjh,
  pjhiPanel_jvGIFAni_pjh, pjhiValve2_pjh, pjhiTank2_pjh, pjhiPipeJoint2_pjh,
  pjhiPipe2_pjh
{$ENDIF}

// {$IFDEF USE_PACKAGE}
  //, pjhFlowChartCompnents
// {$ELSE}
//  ,frmDesignManagerDockUnit, CalcExpress, pjhTShadowButton,
// {$ENDIF}
  , UnitFrameWatchGrid2, UnitFrameIPCMonitorAll2, pjhDesignCompIntf
 ;

Const
  DYNAMIC_PAGE_INDEX = 5; //pageControl의 0~4는 고정 페이지, 5부터 동적 생성함

type
  TCreateFuncFromBPL = function: TForm;
  TRegisterpjhClassProc = procedure of object;

//  TEventData_MEXA7000_2 = packed record
//    CO2: Double;//String 변수는 공유메모리에 사용 불가함
//    CO_L: Double;
//    O2: Double;
//    NOx: Double;
//    THC: Double;
//    CH4: Double;
//    non_CH4: Double;
//    CollectedValue: Double;
// end;

  PDoublePoint = ^TDoublePoint;
  TDoublePoint = class
    X: Double;
    Y: Double;
  end;

  TWatchF2 = class(TForm, IWatch2Interface)
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    Config1: TMenuItem;
    N1: TMenuItem;
    Close1: TMenuItem;
    WatchListPopup: TPopupMenu;
    Items1: TMenuItem;
    AddtoSimple1: TMenuItem;
    AddToSimple3: TMenuItem;
    AddToSimpleInNewWindow1: TMenuItem;
    AddtoTrend1: TMenuItem;
    AddtoTrend2: TMenuItem;
    AddtoNewTrendWindow1: TMenuItem;
    N12: TMenuItem;
    AddAlarmValue1: TMenuItem;
    AddFaultValue1: TMenuItem;
    N6: TMenuItem;
    DeleteFromTrend1: TMenuItem;
    DeleteAlarmValueFromTrend1: TMenuItem;
    DeleteFaultValueFromTrend1: TMenuItem;
    N8: TMenuItem;
    LoadDatafromfile1: TMenuItem;
    LoadTrendDataFromFileUsingWatchList1: TMenuItem;
    AddtoSimple2: TMenuItem;
    AddtoXYGraph2: TMenuItem;
    AddtoXYGraph1: TMenuItem;
    AddToXYGraphFromFile1: TMenuItem;
    AddtoXYGraphinNewWindow1: TMenuItem;
    N7: TMenuItem;
    AddtoXAxis1: TMenuItem;
    AddtoXAxis2: TMenuItem;
    N11: TMenuItem;
    DeleteFromXYGraph1: TMenuItem;
    N5: TMenuItem;
    DataSave1: TMenuItem;
    NotifyAlarmList1: TMenuItem;
    N9: TMenuItem;
    LoadWatchListFromFile1: TMenuItem;
    N3: TMenuItem;
    DeleteItem1: TMenuItem;
    N10: TMenuItem;
    Properties1: TMenuItem;
    JvSaveDialog1: TJvSaveDialog;
    JvOpenDialog1: TJvOpenDialog;
    PopupMenu2: TPopupMenu;
    Add1: TMenuItem;
    Average1: TMenuItem;
    MinValue1: TMenuItem;
    MaxValue1: TMenuItem;
    N4: TMenuItem;
    LoadFromFile1: TMenuItem;
    AddtoCalculated1: TMenuItem;
    PageControl1: TAdvOfficePager;
    ItemsTabSheet: TAdvOfficePage;
    SimpleTabSheet: TAdvOfficePage;
    MinMaxTabSheet: TAdvOfficePage;
    JvStatusBar1: TJvStatusBar;
    EnableAlphaCB: TCheckBox;
    JvTrackBar1: TJvTrackBar;
    StayOnTopCB: TCheckBox;
    AllowUserlevelCB: TComboBox;
    SaveListCB: TCheckBox;
    DisplayPanel: TPanel;
    Label1: TLabel;
    WatchLabel: TLabel;
    AvgPanel: TPanel;
    Label2: TLabel;
    AvgLabel: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    CurLabel: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    MinLabel: TLabel;
    MaxLabel: TLabel;
    Button1: TButton;
    TrendTabSheet: TAdvOfficePage;
    iPlot1: TiPlot;
    XYGraphTabSheet: TAdvOfficePage;
    iXYPlot1: TiXYPlot;
    Button2: TButton;
    Button3: TButton;
    ConstantEdit: TEdit;
    SaveWatchLittoNewName1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    AdjustParameter1: TMenuItem;
    N14: TMenuItem;
    ShowGridRowIndex1: TMenuItem;
    SellectAll1: TMenuItem;
    ShowEventName1: TMenuItem;
    NxAlertWindow1: TNxAlertWindow;
    ShowWindowsHandle1: TMenuItem;
    ShowMQName1: TMenuItem;
    N16: TMenuItem;
    CheckedAvgAllSelected1: TMenuItem;
    UnCheckedAvgAllSelected1: TMenuItem;
    ResetAvgValue1: TMenuItem;
    LoadItemsFromFile1: TMenuItem;
    N17: TMenuItem;
    ShowEngineName1: TMenuItem;
    ShowScrollBar1: TMenuItem;
    SaveSimulateValuetoDB1: TMenuItem;
    ShowMultiStateValues1: TMenuItem;
    ShowNodeIndex1: TMenuItem;
    DropTextTarget4Tag: TDropTextTarget;
    ShowTagName1: TMenuItem;
    SetSimulateParamDBName1: TMenuItem;
    N20: TMenuItem;
    LoadMultiStatValuesfromDB1: TMenuItem;
    StayItemTabCheck: TCheckBox;
    SaveItemsToFile1: TMenuItem;
    LoadOneFormFromWatchList1: TMenuItem;
    IPCMonitorAll1: TFrameIPCMonitor2;
    FWG: TFrameWatchGrid2;
    UpdateItemsDetailFromDB1: TMenuItem;
    UpdateTagNameFromDBBasedOnAddress1: TMenuItem;
    N22: TMenuItem;
    AdjustParameterTagName1: TMenuItem;
    N23: TMenuItem;
    DesignForm1: TMenuItem;
    FindItemsByTagname1: TMenuItem;
    N24: TMenuItem;
    MakeModbusCommand1: TMenuItem;
    DB1: TMenuItem;
    Xls1: TMenuItem;
    FindItemFlipPanel: TNxFlipPanel;
    Label4: TLabel;
    FindTagNameEdit: TEdit;
    Button4: TButton;
    TagRB: TRadioButton;
    DescRB: TRadioButton;
    PopupMenu3: TPopupMenu;
    LoadDesginFormFromdfcFile1: TMenuItem;
    LoadDesignFormFromdfmfile1: TMenuItem;
    SavecurrentpagetodfmFileText1: TMenuItem;
    SaveOnlyDFM1: TMenuItem;
    N13: TMenuItem;
    SetComponentConnectMode1: TMenuItem;
    SetComponentValueMode1: TMenuItem;
    SetAllTransBtnActionKind21: TMenuItem;
    ChangePage1: TMenuItem;
    LoadDFMFromFile1: TMenuItem;
    N21: TMenuItem;
    ChangePageincurrentpage1: TMenuItem;
    LoadDFMFromFileincurrentpage1: TMenuItem;
    EditPropertyValue4Simulate1: TMenuItem;
    ShowUnAssignedList1: TMenuItem;
    N18: TMenuItem;
    ConvertBinToTextDFM1: TMenuItem;
    SaveTextToBinDFM1: TMenuItem;
    N19: TMenuItem;
    ChangeTabCaption1: TMenuItem;
    ChangeTabIndex1: TMenuItem;
    FullScreen1: TMenuItem;
    abShowHide1: TMenuItem;
    CaptionShowHide1: TMenuItem;
    Refresh1: TMenuItem;
    InitializeCompValues1: TMenuItem;
    ClearMainFormCaption1: TMenuItem;
    ShowDFMFileName1: TMenuItem;
    N2: TMenuItem;
    AdjustparameterIndex1: TMenuItem;
    MovepjhValueToItemValue1: TMenuItem;
    MovepjhValueTogpSharedMM1: TMenuItem;
    MovepjhValueToItemandSaveToDB1: TMenuItem;
    N15: TMenuItem;
    LoadDesignPanel1: TMenuItem;
    MoveItemValueTopjhValue1: TMenuItem;
    SetCreateItem4Selected1: TMenuItem;
    N25: TMenuItem;
    AddNew1: TMenuItem;
    AddNewFromSelected1: TMenuItem;
    SaveItemsToDB1: TMenuItem;
    EditPropertyValue4Simulate2: TMenuItem;
    MergeCommandJsonwith1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Config1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Average1Click(Sender: TObject);
    procedure MinValue1Click(Sender: TObject);
    procedure MaxValue1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure AddtoTrend2Click(Sender: TObject);
    procedure LoadFromFile1Click(Sender: TObject);
    procedure AddtoXYGraph1Click(Sender: TObject);
    procedure AddtoXYGraphFromTrendData1Click(Sender: TObject);
    procedure EnableAlphaCBClick(Sender: TObject);
    procedure DataSave1Click(Sender: TObject);
    procedure LoadDatafromfile1Click(Sender: TObject);
    procedure LoadWatchListFromFile1Click(Sender: TObject);
    procedure iPlot1ToolBarButtonClick(Index: Integer;
      ButtonType: TiPlotToolBarButtonType);
    procedure AddtoNewTrendWindow1Click(Sender: TObject);
    procedure DeleteFromTrend1Click(Sender: TObject);
    procedure AddToSimple3Click(Sender: TObject);
    procedure AddToSimpleInNewWindow1Click(Sender: TObject);
    procedure LoadTrendDataFromFileUsingWatchList1Click(Sender: TObject);
    procedure JvStatusBar1Click(Sender: TObject);
    procedure JvTrackBar1Change(Sender: TObject);
    procedure AddToXYGraphFromFile1Click(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure DeleteFromXYGraph1Click(Sender: TObject);
    procedure AddAlarmValue1Click(Sender: TObject);
    procedure DeleteAlarmValueFromTrend1Click(Sender: TObject);
    procedure DeleteFaultValueFromTrend1Click(Sender: TObject);
    procedure StayOnTopCBClick(Sender: TObject);
    procedure AddtoCalculated1Click(Sender: TObject);
    procedure PageControl1InsertPage(Sender: TObject; APage: TAdvOfficePage);
    procedure LoadDesignPanel1Click(Sender: TObject);
    procedure CloseDesignPanel1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; FromPage, ToPage: Integer;
      var AllowChange: Boolean);
    procedure PageControl1ClosePage(Sender: TObject; PageIndex: Integer;
      var Allow: Boolean);
    procedure PageControl1ClosedPage(Sender: TObject; PageIndex: Integer);
    procedure SaveWatchLittoNewName1Click(Sender: TObject);
    procedure LoadDesginFormFromdfcFile1Click(Sender: TObject);
    procedure LoadDesignFormFromdfmfile1Click(Sender: TObject);
    procedure SaveOnlyDFM1Click(Sender: TObject);
    procedure ValueButtonClick(Sender: TObject);
    procedure ChangeTabCaption1Click(Sender: TObject);
    procedure ApplicationEvents1ShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FullScreen1Click(Sender: TObject);
    procedure abShowHide1Click(Sender: TObject);
    procedure CaptionShowHide1Click(Sender: TObject);
    procedure DisplayPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure iXYPlot1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AdjustParameter1Click(Sender: TObject);
    procedure AdjustparameterIndex1Click(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure InitializeCompValues1Click(Sender: TObject);
    procedure Refresh1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DeleteItem1Click(Sender: TObject);
    procedure SellectAll1Click(Sender: TObject);
    procedure FWGNextGrid1SelectCell(Sender: TObject; ACol, ARow: Integer);
    procedure ShowEventName1Click(Sender: TObject);
    procedure ShowWindowsHandle1Click(Sender: TObject);
    procedure ShowMQName1Click(Sender: TObject);
    procedure CheckedAvgAllSelected1Click(Sender: TObject);
    procedure UnCheckedAvgAllSelected1Click(Sender: TObject);
    procedure ResetAvgValue1Click(Sender: TObject);
    procedure LoadItemsFromFile1Click(Sender: TObject);
    procedure ShowEngineName1Click(Sender: TObject);
    procedure ConvertBinToTextDFM1Click(Sender: TObject);
    procedure SaveTextToBinDFM1Click(Sender: TObject);
    procedure MovepjhValueToItemValue1Click(Sender: TObject);
    procedure SaveSimulateValuetoDB1Click(Sender: TObject);
    procedure ShowGridRowIndex1Click(Sender: TObject);
    procedure ShowMultiStateValues1Click(Sender: TObject);
    procedure ShowNodeIndex1Click(Sender: TObject);
    procedure SetComponentConnectMode1Click(Sender: TObject);
    procedure FWGNextGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DropTextTarget4TagDrop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure ShowUnAssignedList1Click(Sender: TObject);
    procedure ShowTagName1Click(Sender: TObject);
    procedure ShowScrollBar1Click(Sender: TObject);
    procedure SetSimulateParamDBName1Click(Sender: TObject);
    procedure MovepjhValueToItemandSaveToDB1Click(Sender: TObject);
    procedure ClearMainFormCaption1Click(Sender: TObject);
    procedure MovepjhValueTogpSharedMM1Click(Sender: TObject);
    procedure LoadMultiStatValuesfromDB1Click(Sender: TObject);
    procedure SetComponentValueMode1Click(Sender: TObject);
    procedure SavecurrentpagetodfmFileText1Click(Sender: TObject);
    procedure EditPropertyValue4Simulate1Click(Sender: TObject);
    procedure SaveItemsToFile1Click(Sender: TObject);
    procedure LoadOneFormFromWatchList1Click(Sender: TObject);
    procedure ChangePage1Click(Sender: TObject);
    procedure LoadDFMFromFile1Click(Sender: TObject);
    procedure ChangePageincurrentpage1Click(Sender: TObject);
    procedure LoadDFMFromFileincurrentpage1Click(Sender: TObject);
    procedure UpdateItemsDetailFromDB1Click(Sender: TObject);
    procedure UpdateTagNameFromDBBasedOnAddress1Click(Sender: TObject);
    procedure ShowcurrentDFMFileName1Click(Sender: TObject);
    procedure AdjustParameterTagName1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FindItemsByTagname1Click(Sender: TObject);
    procedure DescRBClick(Sender: TObject);
    procedure TagRBClick(Sender: TObject);
    procedure FindTagNameEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChangeTabIndex1Click(Sender: TObject);
    procedure Xls1Click(Sender: TObject);
    procedure DB1Click(Sender: TObject);
    procedure ShowDFMFileName1Click(Sender: TObject);
    procedure MoveItemValueTopjhValue1Click(Sender: TObject);
    procedure SetCreateItem4Selected1Click(Sender: TObject);
    procedure AddNew1Click(Sender: TObject);
    procedure AddNewFromSelected1Click(Sender: TObject);
    procedure SaveItemsToDB1Click(Sender: TObject);
    procedure EditPropertyValue4Simulate2Click(Sender: TObject);
    procedure MergeCommandJsonwith1Click(Sender: TObject);
    procedure FindComponentByName1Click(Sender: TObject);
    procedure CheckCircularofNextStep1Click(Sender: TObject);
  private
    FFilePath: string;      //파일을 저장할 경로
    FProgramMode: TProgramMode;
    FIsMDIChileMode: Boolean;//HiMECS에서 MDI Child로 실행할 경우 True
    //FCurrentUserLevel: THiMECSUserLevel;
    FWatchListFileName: string;//실행시 파라미터로 입력 받음(파라미터 저장파일)

    FCriticalSection: TCriticalSection;
    FPJHTimerPool: TPJHTimerPool;

    FMonitorStart: Boolean; //타이머 동작 완료하면 True
    FFirst: Boolean; //타이머 동작 완료하면 True
    FMsgList: TStringList;  //Message를 저장하는 리스트

    //FEngineParameter: TEngineParameter;

    FPackageModules : array of HModule;
    FCreateFuncFromBPL : array of TCreateFuncFromBPL;
    FDesignManagerForm: TForm; //Design Control Form from bpl
    FDesignManagerFormClass: TFormClass; //Design Control Form Class
    FColsedPageIndex: integer; //tab close시에 tag 접근시 에러 방지 목적

    FBplFileList: TStringList;
    FPackageHandles : array of HModule;

    FDummyFormHandle: string;
    FControlPressedOnGrid: Boolean;

    //IPC Thread -->
    Flags: TClientFlags;
    IPCClient_HiMECS_MDI: TIPCClient_HiMECS_MDI;

    FpjhSTOMPClass: TpjhSTOMPClass;
    FCommandLine: TWatchCommandLineOption;
    FComponentConnectMode: Boolean;//pjhxIOComp 컴포넌트의 NextStep 설정 모드(PopUp Menu에서 선택함)
    FSrcCompConnectMode,//Alt+1 를 누르는 동안 True
    FDestCompConnectMode: Boolean; // Alt+2 를 누르는 동안 True
    FMultiCompConnectMode: Boolean; // Shift 를 누르는 동안 True
    FConnectClearMode: Boolean; // Alt+D 를 누르는 동안 True

    FCreateTagItemMode: Boolean;//Mouse로 선택한 Component에 Item 생성 및 할당 모드(PopUp Menu에서 선택함)
    FCreateTagItemWhenAltKeyDown: Boolean;// Alt Key 를 누르는 동안 True
    FCheckCircularNextStepMode: Boolean;//Popup에서 "Check Circular of NextStep"를 선택하면 True
    FCheckCircularNextStepList: TStringList;

    FRevSrcCompConnectMode,//Alt+3 를 누르는 동안 True
    FRevDestCompConnectMode: Boolean; // Alt+4 를 누르는 동안 True
    FRevSrcCheckCompMode,//Alt+5 를 누르는 동안 True
    FRevMultiCompConnectMode: Boolean; // Shift 를 누르는 동안 True
    FRevConnectClearMode: Boolean; // Alt+R 를 누르는 동안 True

    //MultiConnectMode로 Component 선택 시 맨 마지막에 선택된 Component 저장
    //FIsCreateJson4ClearLastSelectedControl = True인 경우 마지막 Component의 xStep = nil로 setting 하는
    //Json을 FSimulateCompValuesJson4ConnectNextStep에 추가하여  Circulation을 방지하기 위함
    FLastSelectedControlWhenMultiConnect: TControl;
    FSrcComponent4NextStep: TWinControl;
    //Step properties name list with comma
//    FXStepNameListWithComma: string;
//    FpjhSelector: TpjhCyResizer;
    FpjhSelector: TCyResizer;
    FEEPTarget4Tag: TEngineParameterDataFormat;

    FSimulateParamDBName: string;
    //Object Inspector에서 Comp Value 변경된 List를 Json으로 저장함.
    //Json format은 SetCompValueFromOI함수 참조
    FSimulateCompValuesJson: string;
    //ComponentConnectMode 선택 후 MultiConnect를 Json으로 자동 생성하여 저장하는 변수
    //생성된 Json을 FSimulateCompValuesJson에 Merge하여 SimulateDB(CommandJson)에 저장함
    //"Edit Connect NextStep Json" 메뉴에서 확인 가능함
    FSimulateCompValuesJson4ConnectNextStep: string;
    FSimParamJsonData4Edit,//Param Server의 TSimulateParamEditF 화면에 사용하여 중복 입력 간소화
    FSimParamJsonData4Watch2: string;//Watch2 Process간 Simulate Value를 공유하기 위함
    //Multi Connect 시에 선택한 Component의 NextStep value를 nil로 할당하는 Json을
    //FSimulateCompValuesJson4ConnectNextStep 에 추가할지 여부
    FIsCreateJson4ClearNextStep,
    //선택된 Control의 xStep을 nil로 Setting 하는 Json을 생성함
    FIsCreateJson4ClearLastSelectedControl: Boolean;

    FIgnorePageCloseConfirm: Boolean;//True: Design Form Close시 확인 창 팝업 방지
    FIsLoadingDFC: Boolean;
//    FgpSharedMM: TGpSharedMemory;
//    FGpSharedEventProducer: TGpSharedEventProducer;
//    FGpSharedEventListener: TGpSharedEventListener;

    procedure GpSEEventReceivedNotify(Sender: TObject;
      producerHandle: TGpSEHandle; const producerName, eventName,
      eventData: string);

    procedure SetWatchListFileName(AFileName: string);
    procedure SetSimulateParamDBName;
    procedure OnConnect(Sender: TIPCThread_HiMECS_MDI; Connecting: Boolean);
    procedure OnSignal(Sender: TIPCThread_HiMECS_MDI; Data: TEventData_HiMECS_MDI);
    procedure UpdateStatusBar(var Msg: TMessage); message WM_UPDATESTATUS_HiMECS_MDI;
    //IPC Thread <--

    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;
    procedure WMDesignManagerClose(var Msg: TMessage); message WM_DESIGNMANAGER_CLOSE;
    procedure WMClose(var Msg: TMessage); message WM_CLOSE;
    procedure WMButtonClick(var Msg: TMessage); message WM_BUTTON_CLICK_NOTIFY;  //TpjhTJvTransparentButton 컴포넌트가 보내는 Click Msg
    procedure WorkerResult(var msg: TMessage); message MSG_RESULT;

    //Caption Bar 색상 변경을 위함(실패)
    procedure WMNCPaint(var Msg: TWMNCPaint) ; message WM_NCPAINT;
    procedure WMNCACTIVATE(var Msg: TWMNCActivate) ; message WM_NCACTIVATE;
    procedure DrawCaptionText(AText: string; ABrushColor: TColor);

    procedure ProcessResults;
    procedure OnWindowCaptionDrag;
    procedure pjhPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ToggleTabShow;

    procedure DeleteItem2pjhTagInfo(AIndex: integer);

    procedure OnChangeDispPanelColor(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnResetSrcCompConnectMode(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnResetDestCompConnectMode(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnResetRevSrcCompConnectMode(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnResetRevDestCompConnectMode(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnResetRevSrcCheckCompMode(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnResetConnectClearMode(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnResetMultiCompConnectMode(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnResetCreateTagItemMode(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnRefreshTab(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);

    procedure GetEngineParameterFromSavedWatchListFile(AFileName: string;
      AAutoStart, AOnlyOneFormOpen: Boolean);
    function GetTagNameFromDescriptor(ADescriptor: string): string;
    procedure DeleteEngineParamterFromGrid(AIndex: integer);

    function GetAxisFromString(AAxes: String): TAxis;
    procedure GetVariantFromItemList4SimulateData(var ADoc: variant);
    function GetJsonAdditionalData4Simulate: string;

//    procedure GetFields2Grid(ADb: TSivak3Database; ATableName: String; AGrid: TNextGrid);

    procedure MyMouseEvent(var Msg: TMsg;var Handled: Boolean);
    function GetDesignPanel(LPage: TAdvOfficePage): TELDesignPanel;
    function GetDesignControl(LPage: TAdvOfficePage): TControl;
    function GetTpjhPanelOfCurrentPage(APageIndex: integer = -1): TpjhPanel;
    function GetBalloonCompFromCurPage: TControl;//TpjhTPanelWithBalloon;
    procedure UnloadAddInPackage(var AOwner: TComponent; AModule: THandle);
    procedure DestroyDynamicPanel;
    procedure DestroyComponentOnPage(LPage: TAdvOfficePage);
    function LoadNCreateOrShowDM: Boolean;
    procedure AssignPanel2Designer(AForm: TForm);
    procedure AssignPanel2DropTraget;
    procedure SaveDesignMode2ControlTag(APageIndex: Integer);
    //Items로 부터 Simulate Data를 생성하여 DB에 저장함
    procedure SaveSimulateValue2DB;
    procedure MovepjhValueToItemValueNSaveDB;
    procedure FillInParamNItemGridFromVariantOfSimData(ADoc: variant);
    procedure MergeCommandJsonFromJsonOfSimData(ASrcJson: string; var ADestJson: string);
    procedure UpdateItemValueFromSimData;
    procedure UpdateComponentValueFromCommandJson;

    procedure ShowHideGridRowIndex(AShowIndex: Boolean = True);
    procedure RemoveControlsOnPanel(AControl: TPanel);
    function CommandLineParse(var AErrMsg: string): boolean;
    procedure SetCompDataFromTransBtn(ARecToPass: TRecToPass);
    procedure SetCompData2Text(ARecToPass: TRecToPass);
    procedure SetCompDate2LoadDfmFile(APageIndex: integer);
    procedure SetCompValueFromOI(ARecToPass: TRecToPass2);//변경된 Component value를 Object Inspector로부터 전달 받아서 저장함
    procedure SaveSimulateParamData2Json(ARecToPass: TCopyDataStruct);
    function RecvSimulateParamDataFromgpShMM(var AData: string): integer;
    procedure SendSimulateParamData2gpShMM(AData: string);
    procedure MoveReceivedgpSHMMValue2ItemValueNCommandJson(AData: string);
    procedure MoveReceivedgpSHMMValue2ComponentValue(AData: string);
    procedure SendShortCut2DesignScreen4ShowBalloon;

    procedure OnGetHandlingKeyInfo(Sender: TObject; Key: Word; ShiftState: TShiftState; KeyDown: Boolean; var Job: TKeyJob);
    procedure OnPostProcessMouseInfo(aPoint: TPoint; var aControl: TControl;
      var ControlRect, HandlerRect: TRect; var Job: TControlJob);
    //HiMECS.exe에서 Shift + Paramter Drag하여 Watch2 화면의 Component에 Drop하면 pjhTag에 해당 Parameter가 할달됨
    procedure SetTagInfo2ComponentUsingMouse(APoint: Tpoint);
    function CreatepjhSelector: TCyResizer;
    procedure CreateNActivatepjhSelector(ApjhPanel: TpjhPanel=nil);
    //아래 FindComponentByNameUsingSelector 함수는 미완성임(사용불가)
    procedure FindComponentByNameUsingSelector(ACompName: string='');
    procedure FindComponentByNameUsingBalloon(ACompName: string='');
    function GetComponentByNameFrompjhPanel(var ACompName: string): TControl;
    function GetBalloonRecord2Json4FindComponent(ACompName: string): TBalloonRecord;
    function GetComponentPositionFromControl(AControl: TControl): TPoint;

    procedure InitJsonCompValue4Simulate;
    procedure AddJsonCompValue4Simulate(ARecToPass: TRecToPass2; var ADestJson: string);
    procedure EditJsonCompValue4Simulate(var AJson: string);
    procedure FindNSetCompValueFromDesignForm(const ACompName, APropName, AValue: string);
    function FindNGetCompStringValueFromDesignForm(const ACompName, APropName: string): string;
    procedure FindNAddCompValueFromCommandJson(ARecToPass: TRecToPass2; var ADestJson: string);
    procedure AddCompValue2Json(const ACompName, APropName, AValue: string; AValueType: integer; var ADestJson: string);
    procedure UdateGridItemDetailFromFile(AFileName: string='');
    procedure UdateTagNameOfGridItemFromFile(AFileName: string='');

    procedure FindItemByTagName(const ATagName: string; AIgnoreCase : boolean=true);
    procedure MakeModbusCommandFromGrid(AType: TOfficeFileType);
  public
    //FOnExit: Boolean; //프로그램 종료시 True
    FStartTrend: Boolean;
    FOwnerHandle: THandle;//Owner form handle
    FOwnerListIndex: integer;//TList에 저장되는 Index(해제시에 필요함)
    FAddressMap: DMap;      //Modbus Map 데이타 저장 구초체
    FConfigOption: TConfigOption;
    FDesignFormConfig: TDesignFormConfig; //Design Form Config Class
    FWatchHandles : array of THandle;

    FTrendDataMap: DMap;
    FTrendDataMapFromFile: DMap;
    FXYDataMap: DMultiMap;

    FXYDataIndex: array[0..1] of integer; //[0] = x 축 Index, [1] = Y 축 Index
    //FSharedName: string;//공유 메모리 이름
    //FFuncCode: string;//Modbus Function Code
    //FAddress: string;//Modbus Address
    FLabelName: string; //모니터링하고자 하는 데이타의 이름을 저장함.
    FWatchName: string; //component 이름을 저장함.(FunctionCode+Address)
    FWatchValue: string; //모니터링 데이타

    //Option변경시에 파일이름이 같을 경우 Readmap을 하지 않기 위해 필요함
    FCurrentModbusFileName: string;

    //FWatchValueRecord: TEventData_MEXA7000; //유승원 요청사항, 모든 데이타를 한개의 차트에 표시하기 위함.
    FEnterWatchValue2Screen,
    FEnterWatchAnalogValue2DesignScreen: Boolean;

    FWatchValueMin: double; //Min data
    FWatchValueMax: double; //Max data
    FWatchValueSum: double; //Sum data
    FWatchValueAvg: double; //Average data
    FWatchCA: TCircularArray;// Circular Array

    FCurrentAryIndex: integer; //처음에 배열에 저장시에 평균값 구하기 위함
    FFirstCalcAry: boolean; //처음 배열을 채워갈때는 True, 한번 다 채우면 False
    FCurrentEPIndex4Watch: integer; //Simple에 표시될 Engine Parameter Index
    FPrevEPIndex4Watch: integer; //Simple에 표시될 이미지 지우기 위함(한개만 표시되어야 함)

    FIsAverageValueGraph: boolean;//평균값을 그래프로 표현하면 True
    FAverageValueChannel: integer;// FIsCurrentValueGraph=true 일 경우 채널 번호
    FAverageValueX: double;

    FIsMinValueGraph: boolean;//최소값을 그래프로 표현하면 True
    FMinValueChannel: integer;// FIsCurrentValueGraph=true 일 경우 채널 번호
    FMinValueX: double;

    FIsMaxValueGraph: boolean;//최대값을 그래프로 표현하면 True
    FMaxValueChannel: integer;// FIsCurrentValueGraph=true 일 경우 채널 번호
    FMaxValueX: double;

    FCurrentChangeColor: Longint; //Warning 또는 Alarm시에 변경할 색상
    FBlinkEnable: Boolean; //Blink Mode이면 True
    FBlinkOn : Boolean;//Blink시에 깜박이용으로 사용

//    FTaskPool: TTaskPool;
    FIsAutoFree: Boolean; //True: Close시에 자동 메모리 해제
    FSimulatePropertyValueMode: Boolean; //True : Object Inspector로 부터 수신한 Comp Value를 저장
    FTempTabHeight: integer;

//    procedure OnMessageComplete(const Msg: ITaskMessage);
//    procedure OnAsynchronousIPCTask(const ATask: ITask);
//    procedure SendAliveOk;

    procedure InitVar;
    procedure InitSTOMP;
    procedure DestroySTOMP;
    procedure DisplayMessage(Msg: string; AIsSaveLog: Boolean = False; AMsgLevel: TSynLogInfo = sllInfo);
    procedure WatchValue2Screen_Analog(Name: string; AValue: string;
                                AEPIndex: integer);
    procedure WatchValue2Screen_Digital(Name: string; AValue: string;
                                AEPIndex: integer);
    procedure WatchValue2Screen_Once(APageIndex: integer=-1);
    procedure WatchValue2Screen_2;
    procedure WatchValue2ScreenOnceAfterIPCTrigger;
    procedure WatchAnalogValue2DesignScreen;
    procedure WatchDigitalValue2DesignScreen(Name: string; AValue: string;
                                AEPIndex: integer);
    procedure AdjustParamIndexOfComponents;
    procedure AdjustParamTagNameNDescOfComponents;
    function GetparamIndexFromCollect(ATagName: string; var ADesc: string): integer;
    function GetTagNameFromCollectByIndex(AIndex: integer; var ADesc: string): string;
    procedure InitializeComponentValues;
    procedure LockUnLockValue2Screen(AIsLock: Boolean);
    procedure MovepjhValue2ItemValue(AIsReverseDir: Boolean=False);
    //현재 Page에서 TpjhTJvTransparentButton2 컴포넌트를 찾아서
    //pjhBtnActionKind 필드를 tbakLoadDFMFromFile로 변경함
    procedure SetpjhBtnActionKind4TransparentBtn(AActionKind: TJvTransBtnActionKind;
      AOnlyCurrentPage: Boolean; APageIndex: integer=-1);
    function ShowpjhTagUnAssignedList: TStringList;
    function GetPjhPanelFromIndex(APageIndex: integer=-1): TPjhPanel;
    procedure RefreshControlsOnActivePage();

    procedure Value2Screen_ECS_kumo(AHiMap: THiMap; AEPIndex: integer; AModbusMode: integer);
    procedure Value2Screen_ECS_AVAT(AHiMap: THiMap; AEPIndex: integer; AModbusMode: integer);
    procedure Value2Screen_Analog_ECS_kumo(AName: string; AValue: Integer; AMaxVal: real);
    procedure Value2Screen_Digital_ECS(Name: string; AValue: Integer;
                                    AMaxVal: real; AContact: integer);
    procedure GetDataFromTrendGraph2XYMap(AArray: DArray);
    procedure AddData2TrendMap(AParameterIndex: integer; AXValue, AYValue: double);
    procedure AddData2TrendMapFromFile(AKeyName: string; AXValue, AYValue: double);
    procedure AddData2XYMap(AParameterIndex: integer; AXValue, AYValue: double);
    procedure DisplayTrend(AXValueisDateTime: Boolean; ATime: TDateTime);
    procedure DisplayTrendFromMap(APlot: TiPlot; AMap: DMap);
    procedure DisplayXYGraphRealTime(APlotChannel: TiXYPlotChannel);
    function MakeXYDataFromFile(AArray: DArray; AFileName: string; AIsFirst: Boolean; AXYMap: DMultiMap; AIsDuplicate: Boolean): boolean;
    procedure FillXYMapFromFile(AXYMap: DMultiMap; AList: TStringList;
                                    AIsDuplicated: Boolean; AStr: string);
    function GetTrendDataFromTagName(ATagName: string; AMap: DMap): DArray;
    procedure DisplayXYGraphWithDup(APlotChannel: TiXYPlotChannel; AMap: DMultiMap);
    procedure DisplayXYGraphWithOutDup(APlotChannel: TiXYPlotChannel; AMap: DMultiMap);
    procedure SaveDMap2File(AFileName: string; AMap: DMap);
    procedure LoadTrendDataMapFromFile(AFileName: string);
    procedure LoadTrendDataFromFile(AFileName: string; AIsFirstFile: Boolean;
                AIsUseWatchList: Boolean);
    procedure OpenTrendDataFile(AIsUseWatchList: Boolean);
    procedure SaveDMultiMap2File(AFileName: string; AMap: DMultiMap);
    procedure ReplaceOrAddMap(AMap: DMultiMap; AKey, AValue: double; AIsXAxis:Boolean);
    procedure XYDataAdd2Map(AMap: DMultiMap; AKey, AValue: double; AIsXAxis:Boolean);
    function PrepareXYGraph(AArray: DArray; AIsChannelClear: Boolean): Boolean;

    procedure GetXYPeriod(var Ai,Aj: integer);
    function GetPeriodDataFromTrend(AIndex, Ai, Aj: integer; ADataType: TPeriodDataType): double;
    procedure SelectTrendItemsForXYGraph;
    procedure SelectItemsClick(Sender: TObject);
    procedure CalcAverageFromTrend(Sender: TObject);
    procedure CalcSumFromTrend(Sender: TObject);
    procedure CalcMinFromTrend(Sender: TObject);
    procedure CalcMaxFromTrend(Sender: TObject);
    procedure CalcDiffFromTrend(Sender: TObject);
    procedure CalcPointSpanFromTrend(Sender: TObject);
    procedure CalcPointFromTrend(Sender: TObject);

    function AddChannelAndYAxis(AParamIndex: integer; ACheckTrendType: TTrendDataType): integer;
    procedure DeleteAllTrend;
    procedure UpdateChannelIndex(AIndex: integer);
    procedure UpdateYAxisIndex(AIndex: integer);
    procedure AddToSimple(AParamIndex: integer);
    procedure AddToNewWindow(ACommand: string);
    function AddToXYGraphInRealTime: Boolean;
    function DetermineIndexForXYGraph(AIsChClear: Boolean): Boolean;

    procedure DisplayMessage2SB(Msg: string);
    procedure ChangeDispPanelColor(AColor: TColor);
    procedure ChangeAlarmListMode;

    procedure ApplyAvgSize;
    procedure ApplyOption;
    procedure ApplyCommandLineOption;
    procedure ApplyOption4AvgCalc;

    procedure CreateIPCMonitor(AEP_DragDrop: TEngineParameterItemRecord; ADragCopyMode: TParamDragCopyMode = dcmCopyOnlyNonExist);

    function GetFileNameFromWatchList: string;
    procedure LoadConfigDataXml2Var(AFileName: string = '');
    procedure LoadConfigDataVar2Form(AMonitorConfigF : TWatchConfigF);
    procedure SaveConfigData2Xml;
    procedure SaveConfigDataForm2Xml(AMonitorConfigF : TWatchConfigF);
    procedure SetConfigData;
    procedure SetAlarm4OriginalOption(AValue: double; AEPIndex: integer);
    procedure SetAlarm4ThisOption(AValue: double);
    procedure SaveWatchList(AFileName: string; ASaveRelativeFolder: Boolean;
      AIsOneFormMode: Boolean);
    procedure SetWatchFormState2Param(AParam: TEngineParameter);
    procedure GetWatchFormStateFromParam2Form(AParam: TEngineParameter);
    procedure SaveDesignForm(AFileName: string; AIsOnlyOneForm: Boolean=False);
    procedure SaveOnlyDFMofCurPage(AFileName: string);
    procedure SaveItemsToFile(AFileName: string=''; APropmtSaveConfirm: Boolean=False);
    procedure LoadDesignForm(const AFileName: string; AOnlyOneFormOpen: Boolean);
    procedure LoadDesignFormFromMenu(AFileName: string; AIsFromdfc: Boolean);
    procedure LoadDesignFormFromDFM(AFileName: string);
    procedure LoadDesignFormFromDFCByPageIndex(APageIndex: integer);//*_dfc파일에서 PageIndex를 이용하여 DFM Load 함
    procedure LoadDesignComponentPackage;
    procedure LoadDesignComponentPackageFromOnlyComp(ADfc: TDesignFormConfig);
    procedure LoadDesignComponentPackageAll;
    procedure AddBpllist2DFConfig(ABplist: TStringList;ADfc: TDesignFormConfig);
    procedure GetBplNamesFromDesignPanel(ABplNameList: TStringList;
                                        AAdvOfficePage: TAdvOfficePage);
    procedure IPCAll_Final;

    procedure SaveWatchListFileOfSummary(AFileName: string);

    //For IWatch2Interface
    //Object Inspector에서 컴포넌트 연결시 사용됨
    procedure GetTagNames(ATagNameList, ADescriptList: TStringList);
    procedure GetLoadedPackages(APackageList: TStringList);
    //For IWatch2Interface

    procedure SetMatrix;
    procedure ReadComponentsProc(Reader: TReader; const Message: string; var Handled: Boolean);
    function GetMultiStateMeaning(AEngParamItem: TEngineParameterItem): string;
    //AStateMeaning을 DB에서 검색하여 숫자로 바꿔 반환함
    function GetMultiStateValueFromIndex(AIdx: integer; AStateMeaning: string): string;
    function GetScaledValueFrompjhValue(AIdx: integer; AValue: string): string;

    procedure SetSourceComponent(aControl: TControl);
    procedure SetDestinationConnect(aControl: TControl);
    procedure ClearXStep(aControl: TControl);
    procedure SetMultiSelectConnect(aControl: TControl; Job: TControlJob);
    //마우스로 선택된 Component의 NextStep Property Value에서 AWillDeleteControl이
    //할당 되어 있다면 nil로 변경함
    procedure DeleteNextRef(AWillDeleteControl: TWinControl);
    //현재 page의 모든 Component의 NextStep Property를 nil로 변경함
    //MultiSelect를 이용하여 CommandJson을 만들떄 필요함
    procedure ClearAllNextStepProperty;
    procedure CheckCirculationOfNextStep(AStartNextStep: TControl; ANextList: TStringList);

    procedure SetRevSourceComponent(aControl: TControl);
    procedure SetRevSrcCheckComp(aControl: TControl);
    procedure SetRevDestinationConnect(aControl: TControl);
    procedure SetRevMultiSelectConnect(aControl: TControl; Job: TControlJob);

    procedure SetCreateItem4SelectedComponent(aControl: TControl; Job: TControlJob);
    procedure CreateItem4SelectedComponent(ApjhDCI: IpjhDesignCompInterface);
    procedure CreateNewItem(AEngParamItem: TEngineParameterItem=nil);
    procedure CreateNewItemSelected();

    procedure ProcessKeyEventFrompjhSelector(AShiftState: TShiftState; ACharCode: word);
    procedure ProcessKeyEvent4NextStep(AShiftState: TShiftState; ACharCode: word);
    procedure ProcessKeyEvent4CreateItem(AShiftState: TShiftState; ACharCode: word);
    procedure ProcessMouseEventFrompjhSelector(aPoint: TPoint; aControl: TControl;
      ControlRect, HandlerRect: TRect; Job: TControlJob);
    procedure ProcessMouseEvent4NextStep(aPoint: TPoint; aControl: TControl;
      ControlRect, HandlerRect: TRect; Job: TControlJob);
    procedure ProcessMouseEvent4CreateItem(aPoint: TPoint; aControl: TControl;
      ControlRect, HandlerRect: TRect; Job: TControlJob);
    procedure ProcessMouseEvent4CheckCircularNextStep(aPoint: TPoint; aControl: TControl;
      ControlRect, HandlerRect: TRect; Job: TControlJob);

    property WatchListFileName: string read FWatchListFileName write SetWatchListFileName;
  published
    function GetHiMECSA2Version(const AAABB, ACCdd: integer): string;
  end;

  procedure DoublePointIO(obj : TObject; stream : TObjStream; direction : TObjIODirection;
              version : Integer; var callSuper : Boolean);

var
  WatchF2: TWatchF2;

implementation

uses CommonUtil, UnitAxisSelect, UnitCopyWatchList2, frmMainInterface, FrmInputEdit,
  pjhDesignCompIntf2, UtilUnit, jclNTFS, VCL.cyGraphics,
  HiMECSWatchCommon2, pjhclasses, UnitSetMatrix2, UnitCaptionInput,
  WindowUtil, otlComm, StompTypes, UnitFormUtil,
  UnitVesselData2, UnitBase64Util2, pjhPipeFlowInterface, UnitRevFlowInterface,
  UnitSimulateParamCommandLineOption2, UnitRttiUtil2, UnitDFMUtil, XSuperObject,
  FrmStringsEdit, UnitSimulateCommonData, sndkey32, UnitTransparentBtnInterface,
  JHP.Util.Bit, UnitJHCustomComponent, pjhBalloonCompIntf;

{$R *.dfm}

//List에 있는 TagName과 연결되어 있는 Component만 골라서 값을 0으로 초기화 함.
procedure TWatchF2.InitializeComponentValues;
var
  i, j, k, PnlIndex: integer;
  LStr: string;
  LPanel: TpjhPanel;
  IpjhDI: IpjhDesignCompInterface;
begin
  for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].ParameterSource = psManualInput then
      continue;

    IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].Value := '0';
    LStr := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TagName;

    for k := 5 to PageControl1.AdvPageCount - 1 do
    begin
      with PageControl1.AdvPages[k] do
      begin
        for j := 0 to ComponentCount - 1 do
        begin
          //find panel component(only one exist on Page)
          if Components[j].ClassType = TpjhPanel then
          begin
            PnlIndex := j;
            break;
          end;
        end;//for

        LPanel := Components[PnlIndex] as TpjhPanel;

        for j := 0 to LPanel.ComponentCount - 1 do
        begin
          if Supports(LPanel.Components[j], IpjhDesignCompInterface, IpjhDI) then
          begin
            if IpjhDI.pjhTagInfo.TagName =  LStr then
            begin
              PnlIndex := GetparamIndexFromCollect(IpjhDI.pjhTagInfo.TagName, LStr);
              if PnlIndex <> -1 then
              begin
                IpjhDI.pjhValue := '0';
              end;
            end;
          end;
        end;//for
      end;//with
    end;
  end;

end;

procedure TWatchF2.InitializeCompValues1Click(Sender: TObject);
begin
  InitializeComponentValues;
end;

procedure TWatchF2.InitJsonCompValue4Simulate;
begin
  FSimulateCompValuesJson := '{Components: []}';
  FSimulateCompValuesJson4ConnectNextStep := '{Components: []}';
end;

procedure TWatchF2.InitSTOMP;
var
  i: integer;
  LStrList: TStringList;
begin
  DestroySTOMP;

  if FConfigOption.MQServerTopicCollect.Count = 0 then
    FConfigOption.MQServerTopicCollect.Add.TopicName := IPCMonitorAll1.GetEngineName;//'UniqueEngineName';

  if FConfigOption.MQServerTopicCollect.Items[0].TopicName = '' then
    FConfigOption.MQServerTopicCollect.Items[0].TopicName := MQ_DEFAULT_Q_NAME;

  if FConfigOption.MQServerIP = '' then
    FConfigOption.MQServerIP := MQ_DEFAULT_SERVER_IP;

  if FConfigOption.MQServerPort = '' then
    FConfigOption.MQServerPort := MQ_DEFAULT_PORT;

  if FConfigOption.MQServerUserId = '' then
    FConfigOption.MQServerUserId := MQ_DEFAULT_USER_ID;

  if FConfigOption.MQServerPasswd = '' then
    FConfigOption.MQServerPasswd := MQ_DEFAULT_PASSED;

  if not Assigned(FpjhSTOMPClass) then
  begin
    LStrList := TStringList.Create;
    try
      FConfigOption.SetTopic2StrList(LStrList);
      FpjhSTOMPClass := TpjhSTOMPClass.Create(FConfigOption.MQServerUserId,
                                              FConfigOption.MQServerPasswd,
                                              FConfigOption.MQServerIP,
                                              LStrList,
                                              Self.Handle);
    finally
      LStrList.Free;
    end;
  end;
end;

procedure TWatchF2.InitVar;
var
  LStr: string;
begin
  FpjhSelector := nil;
  FFilePath := ExtractFilePath(Application.ExeName); //맨끝에 '\' 포함됨
  FProgramMode := pmWatchList;
  SetCurrentDir(FFilePath);
  FCriticalSection := TCriticalSection.Create;
  FAddressMap := DMap.Create;
  FConfigOption := TConfigOption.Create(nil);
  FDesignFormConfig := TDesignFormConfig.Create(nil);
  FPJHTimerPool := TPJHTimerPool.Create(nil);
  FEEPTarget4Tag := TEngineParameterDataFormat.Create(DropTextTarget4Tag);
  //FEngineParameter := TEngineParameter.Create(nil);
//  FCommandLine := TWatchCommandLineOption.Create;
//  FgpSharedMM := TGpSharedMemory.Create(gp_SimParam_SHARED_DATA_NAME, 0, gp_SimParam_SHARED_MAX_SIZE);
//  FGpSharedEventProducer := TGpSharedEventProducer.Create(Self);
//  FGpSharedEventProducer.Namespace := gp_EventNameSpace;
//  FGpSharedEventProducer.PublishedEvents.Add(gp_EventName4SimEditData);
//  FGpSharedEventProducer.Active := True;
//
//  FGpSharedEventListener := TGpSharedEventListener.Create(Self);
//  FGpSharedEventListener.Namespace := gp_EventNameSpace;
////  FGpSharedEventListener.MonitorEvent(gp_EventName4SimEditData);
//  FGpSharedEventListener.MonitoredEvents.Add(gp_EventName4SimEditData);
//  FGpSharedEventListener.OnEventReceived := GpSEEventReceivedNotify;
//  FGpSharedEventListener.Active := True;

  IPCMonitorAll1.InitgpSharedMemory4Listener(SHARED_DATA_NAME, gp_EventNameSpace, gp_EventName4SimEditData, GpSEEventReceivedNotify);
  IPCMonitorAll1.FGpSharedEventListener.MonitoredEvents.Add(gp_EventName4SimCommandJson);

  FWG.FCalculatedItemTimerHandle := -1;
  FWG.SetIPCMonitorAll(IPCMonitorAll1);
  FWG.SetStatusBar(JvStatusBar1);
  FWG.SetMainFormHandle(Handle);
  FWG.SetDeleteEngineParamterFromGrid(DeleteEngineParamterFromGrid);
  FWG.SetWatchValue2Screen_Analog(WatchValue2Screen_Analog); //Calculated Items을 계산하여 EngineParameter에 저장함
  FWG.NextGrid1.DoubleBuffered := False;
  FWG.FDisplayMessage := DisplayMessage;
  InitSynLog;

  IPCMonitorAll1.FNextGrid := FWG.NextGrid1;
  IPCMonitorAll1.FPageControl := PageControl1;
  //모든 Item 적용 후 한번 만 실행됨(Design Form에 수신된 데이터 적욯하는 함수 임)
  IPCMonitorAll1.SetValue2ScreenEvent4OnceAfterIPCTrigger(WatchValue2ScreenOnceAfterIPCTrigger);
  //Item별로 실행됨, Simulate Mode에서는 Page 이동 기능만 실행 됨
  IPCMonitorAll1.FWatchValue2Screen_AnalogEvent := WatchValue2Screen_Analog;
  IPCMonitorAll1.FWatchValue2Screen_DigitalEvent := WatchValue2Screen_Digital;
  IPCMonitorAll1.FStatusBar := JvStatusBar1;

//  if FConfigOption.MonDataSource <> 0 then
    IPCMonitorAll1.SetIsUseIPCSharedMMEvent(FConfigOption.MonDataSource = 0);

    //ApplyOption 함수에서 실행함
//  if FConfigOption.MonDataSource = 2 then //MonDataSource = By MQ
//    InitSTOMP;

//  FTaskPool := TTaskPool.Create(5);
//  FTaskPool.OnTaskMessage := OnMessageComplete;
//  FTaskPool.Initialize;

  FTrendDataMap := DMap.Create;
  TObjStream.RegisterClass(TDoublePoint, DoublePointIO, 1);

  FTrendDataMapFromFile := DMap.Create;

  FXYDataMap := DMultiMap.Create;

  FMsgList := TStringList.Create;
  FMonitorStart := False;
  FFirst := True;

  LoadDesignComponentPackageAll;

  FCurrentAryIndex := 0;
  FCurrentEPIndex4Watch := -1;
  FPrevEPIndex4Watch := -1;
  FFirstCalcAry := True;
  FXYDataIndex[0] := -1;
  FXYDataIndex[1] := -1;

  CommandLineParse(LStr);
  LoadConfigDataXml2Var(FCommandLine.ConfigFileName);
  ApplyOption;
  ApplyCommandLineOption; //Config file load 후 실행해야 Command line option이 적용 됨

  if FConfigOption.WatchListFileName <> '' then
  begin
    GetEngineParameterFromSavedWatchListFile(FConfigOption.WatchListFileName, True, False);
    FProgramMode := pmWatchList;
  end;

  FWatchCA := TCircularArray.Create(FConfigOption.AverageSize);
  iPlot1.RemoveAllYAxes;
  iPlot1.RemoveAllChannels;

  iPlot1.DataCursor[0].SelectItemMenuClick := SelectItemsClick;
  iPlot1.DataCursor[0].AverageMenuClick := CalcAverageFromTrend;
  iPlot1.DataCursor[0].SumMenuClick := CalcSumFromTrend;
  iPlot1.DataCursor[0].MinMenuClick := CalcMinFromTrend;
  iPlot1.DataCursor[0].MaxMenuClick := CalcMaxFromTrend;
  iPlot1.DataCursor[0].DiffMenuClick := CalcDiffFromTrend;
  iPlot1.DataCursor[0].PointSpanMenuClick := CalcPointSpanFromTrend;
  iPlot1.DataCursor[0].PointMenuClick := CalcPointFromTrend;

  SetLength(FPackageModules, 1);
  FPackageModules[0] := 0;
  SetLength(FCreateFuncFromBPL, 1);
  FDesignManagerForm := nil;
  FSimParamJsonData4Edit := '';

  InitJsonCompValue4Simulate();
  FCheckCircularNextStepList := TStringList.Create;
end;

procedure TWatchF2.AssignPanel2Designer(AForm: TForm);
var
  IbMI : IbplMainInterface;
  LPage: TAdvOfficePage;
  LDesignPanel: TELDesignPanel;
  LPanel: TpjhPanel;
begin
  if Assigned(AForm) then
  begin
    if Supports(AForm, IbplMainInterface, IbMI) then
    begin
      IbMI.BplOwner := Self;

      with IbMI.Designer do
      begin
        Active := False;
        LPage := PageControl1.ActivePage;
        LDesignPanel := nil;
        LDesignPanel := GetDesignPanel(LPage);

        if Assigned(LDesignPanel) then
        begin
          LPanel := TpjhPanel(GetDesignControl(LPage));
          DesignControl := LPanel;

          DesignPanel := LDesignPanel;
          Active := IntToBool(DesignPanel.Tag);
        end
        else
        begin
          exit;
        end;

        //DesignControl := WatchF2;

        //PrepareOIInterface의 FPropForm <> nil 조건을 만족하기 위해 PrepareOIInterface보다 먼저 실행 되어야 함
//        IbMI.InitializePackage;
//        IbMI.PrepareOIInterface(LPanel);

//        if LPanel.Tag = 0 then //0일 경우 처음 생성한 것임
//          Active := True
//        else
//        begin
//          Active := IntToBool(LPanel.Tag);

        if Active then
          FDesignManagerForm.Show;
//        end;

        DesignPanel.FormRefresh;
        //DesignControlRefresh; //이거 실행하면 컴포넌트가 Run Mode에서 안보임
      end;//with

      //PrepareOIInterface의 FPropForm <> nil 조건을 만족하기 위해 PrepareOIInterface보다 먼저 실행 되어야 함
      IbMI.InitializePackage;
      IbMI.PrepareOIInterface(LPanel);
      //IbMI.SetDockStyle(JvDockVSNetStyle1);
      //AForm.Show;
    end;
  end;
end;

procedure TWatchF2.AssignPanel2DropTraget;
var
  LPanel: TpjhPanel;
begin
  LPanel := GetTpjhPanelOfCurrentPage;

  if Assigned(LPanel) then
  begin
    try
      //Tag를 마우스로 드래그하여 컴포넌트에 Drop 하기 위함
      DropTextTarget4Tag.Target := LPanel;
    except

    end;
  end;
end;

procedure TWatchF2.IPCAll_Final;
begin
  IPCMonitorAll1.DestroyIPCMonitorAll;
end;

procedure TWatchF2.iPlot1ToolBarButtonClick(Index: Integer;
  ButtonType: TiPlotToolBarButtonType);
begin
  if iptbbtEdit = ButtonType then
  begin
    FormStyle := fsNormal;
  end;

end;

procedure TWatchF2.iXYPlot1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  OnWindowCaptionDrag;
end;

procedure TWatchF2.JvStatusBar1Click(Sender: TObject);
begin
  JvStatusBar1.SimplePanel := not JvStatusBar1.SimplePanel;
  SaveListCB.Visible := not SaveListCB.Visible;
  AllowUserlevelCB.Visible := not AllowUserlevelCB.Visible;
  StayOnTopCB.Visible := not StayOnTopCB.Visible;
  EnableAlphaCB.Visible := not EnableAlphaCB.Visible;
  JvTrackBar1.Visible := not JvTrackBar1.Visible;
end;

procedure TWatchF2.JvTrackBar1Change(Sender: TObject);
begin
  if EnableAlphaCB.Checked then
    AlphaBlendValue := JvTrackBar1.Position;
end;

procedure TWatchF2.LoadConfigDataVar2Form(AMonitorConfigF: TWatchConfigF);
var
  i: integer;
begin
  AMonitorConfigF.CaptionEdit.Text := FConfigOption.FormCaption;

  AMonitorConfigF.MapFilenameEdit.FileName := FConfigOption.ModbusFileName;
  AMonitorConfigF.AvgEdit.Text := IntToStr(FConfigOption.AverageSize);

  if WatchListFileName = '' then
    WatchListFileName := FConfigOption.WatchListFileName;

  AMonitorConfigF.WatchFileNameEdit.Text := WatchListFileName;

  AMonitorConfigF.IntervalRG.ItemIndex := FConfigOption.SelDisplayInterval;
  AMonitorConfigF.IntervalEdit.Text := IntToStr(FConfigOption.DisplayInterval);
  AMonitorConfigF.AliveIntervalEdit.Text := IntToStr(FConfigOption.AliveSendInterval);

  AMonitorConfigF.SelAlarmValueRG.ItemIndex := FConfigOption.SelectAlarmValue;
  AMonitorConfigF.MinAlarmEdit.Text := FloatToStr(FConfigOption.MinAlarmValue);
  AMonitorConfigF.MaxAlarmEdit.Text := FloatToStr(FConfigOption.MaxAlarmValue);
  AMonitorConfigF.MinFaultEdit.Text := FloatToStr(FConfigOption.MinFaultValue);
  AMonitorConfigF.MaxFaultEdit.Text := FloatToStr(FConfigOption.MaxFaultValue);
  AMonitorConfigF.MinAlarmColorSelector.SelectedColor := TColor(FConfigOption.MinAlarmColor);
  AMonitorConfigF.MaxAlarmColorSelector.SelectedColor := TColor(FConfigOption.MaxAlarmColor);
  AMonitorConfigF.MinFaultColorSelector.SelectedColor := TColor(FConfigOption.MinFaultColor);
  AMonitorConfigF.MaxFaultColorSelector.SelectedColor := TColor(FConfigOption.MaxFaultColor);
  AMonitorConfigF.MinAlarmBlinkCB.Checked := FConfigOption.MinAlarmBlink;
  AMonitorConfigF.MaxAlarmBlinkCB.Checked := FConfigOption.MaxAlarmBlink;
  AMonitorConfigF.MaxFaultBlinkCB.Checked := FConfigOption.MinFaultBlink;
  AMonitorConfigF.MinFaultBlinkCB.Checked := FConfigOption.MaxFaultBlink;
  AMonitorConfigF.ViewAvgValueCB.Checked := FConfigOption.ViewAvgValue;
  AMonitorConfigF.SubWatchCloseCB.Checked := FConfigOption.SubWatchClose;
  AMonitorConfigF.ZoomToFitCB.Checked := FConfigOption.ZoomToFitTrend;
  AMonitorConfigF.DefaultSoundEdit.FileName := FConfigOption.DefaultSoundFileName;
  AMonitorConfigF.NameFontSizeEdit.Text := IntToStr(FConfigOption.NameFontSize);
  AMonitorConfigF.ValueFontSizeEdit.Text := IntToStr(FConfigOption.ValueFontSize);
  AMonitorConfigF.RingBufSizeEdit.Text := IntToStr(FConfigOption.RingBufferSize);
  AMonitorConfigF.EngParamEncryptCB.Checked := FConfigOption.EngParamEncrypt;
  AMonitorConfigF.ConfFileFormatRG.ItemIndex := FConfigOption.EngParamFileFormat;
  AMonitorConfigF.MonDataFromRG.ItemIndex := FConfigOption.MonDataSource;

  //MQ Server
  AMonitorConfigF.MQIPAddress.Text := FConfigOption.MQServerIP;
  AMonitorConfigF.MQPortEdit.Text := FConfigOption.MQServerPort;
  AMonitorConfigF.MQUserEdit.Text := FConfigOption.MQServerUserId;
  AMonitorConfigF.MQPasswdEdit.Text := FConfigOption.MQServerPasswd;

  for i := 0 to FConfigOption.MQServerTopicCollect.Count - 1 do
    AMonitorConfigF.MQTopicLB.Items.Add(FConfigOption.MQServerTopicCollect.Items[i].TopicName);

  AMonitorConfigF.DispAvgValueCB.Checked := FConfigOption.DisplayAverageValue;

  case FConfigOption.SelectAlarmValue of
    0: AMonitorConfigF.AlarmValueGB.Enabled := False;
    1: AMonitorConfigF.AlarmValueGB.Enabled := False;
    2: AMonitorConfigF.AlarmValueGB.Enabled := True;
  end;

  case FConfigOption.SelDisplayInterval of
    0: AMonitorConfigF.IntervalEdit.Enabled := False;
    1: AMonitorConfigF.IntervalEdit.Enabled := True;
  end;
end;

procedure TWatchF2.LoadConfigDataXml2Var(AFileName: string);
var
  LOption: TConfigOption;
begin
  if AFileName = '' then
    AFileName := ChangeFileExt(Application.ExeName, CONFIG_FILE_EXT);

  if FileExists(AFileName) then
  begin
    LOption := TConfigOption.Create(nil);
    try
      CopyObject(FConfigOption, LOption);
      FConfigOption.LoadFromJSONFile(AFileName, '', False);
      FConfigOption.InitValueChanged;
      FConfigOption.CheckValueChanged(LOption);
      IPCMonitorAll1.FModbusMapFileName := FConfigOption.ModbusFileName;
    finally
      LOption.Free;
    end;
  end;
end;

procedure TWatchF2.LoadDatafromfile1Click(Sender: TObject);
begin
  OpenTrendDataFile(False);
end;

procedure TWatchF2.LoadDesginFormFromdfcFile1Click(Sender: TObject);
begin
  LoadDesignFormFromMenu('', True);
end;

//동적 생성 DFM 파일을 읽기위한 Component Bpl Load
//Bpl 파일 이름은 각 Component 속성 pjhBplFileName에서 가져와 저장함
procedure TWatchF2.LoadDesignComponentPackage;
var
  i: integer;
  LStr, LDFName: string;
  LStrList: TStringList;
begin
  SetCurrentDir(FFilePath);

  if FDesignFormConfig.DesignFormConfigCollect.Count > 0 then
  begin
    if Assigned(FBplFileList) then
    begin
      for i := 0 to FBplFileList.Count - 1 do
        UnLoadPackage(HModule(FBplFileList.Objects[i]));
      FBplFileList.Clear;
    end
    else
      FBplFileList := TStringList.Create;
  end;

  LStrList := TStringList.Create;

  try
    for i := 0 to FDesignFormConfig.DesignFormConfigCollect.Count - 1 do
    begin
      LStr := FDesignFormConfig.DesignFormConfigCollect.Items[i].BplFileList;
      if LStr <> '' then
      begin
        while LStr <> '' do
        begin
          LDFName := GetTokenWithComma(LStr);
          if LStrList.IndexOf(LDFName) = -1 then
            LStrList.Add(LDFName);
        end;
      end;
    end;

    SetLength(FPackageHandles, LStrList.Count);

    for i := 0 to LStrList.Count - 1 do
    begin
      FPackageHandles[i] := LoadPackage('..\Bpls\' + LStrList.Strings[i]);
      FBplFileList.AddObject(LStrList.Strings[i], Pointer(FPackageHandles[i]));
    end;
  finally
    LStrList.Free;
  end;
end;

procedure TWatchF2.LoadDesignComponentPackageAll;
var
  i: integer;
  LStrList: TStringList;
  LRegisterpjhClassProc: TRegisterpjhClassProc;
begin
  if Assigned(FBplFileList) then
  begin
    for i := 0 to FBplFileList.Count - 1 do
      UnLoadPackage(HModule(FBplFileList.Objects[i]));
    FBplFileList.Clear;
  end
  else
    FBplFileList := TStringList.Create;

  try
    SetCurrentDir(FFilePath);

    LStrList := GetFileListFromDir('..\Bpls\', '*.bpl', false);
    SetLength(FPackageHandles, LStrList.Count);

    //ExtLib_XE5.bpl 보다 pjhCommonUnit4ExtLib.bpl이 반드시 먼저 Load 되어야 함
    for i := Low(FPackageHandles) to High(FPackageHandles) do
    begin
//      if (LStrList.Strings[i] <> 'pjhCommonUnit4ExtLib.bpl') and
//         (LStrList.Strings[i] <> 'pjhCompSharedPkg.bpl') and
//         (LStrList.Strings[i] <> 'ExtLib_DXE5.bpl') then
//      begin
        FPackageHandles[i] := LoadPackage(LStrList.Strings[i]);
        FBplFileList.AddObject(LStrList.Strings[i], Pointer(FPackageHandles[i]));
{$IFDEF NOUSE_PACKAGE}
        if Pos('pjhDelphiStandardPkg.bpl', LStrList.Strings[i]) > 0 then
        begin
          @LRegisterpjhClassProc := GetProcAddress(FPackageHandles[i], 'RegisterpjhClass');
          LRegisterpjhClassProc;
        end;
{$ENDIF}
    end;//for
  finally
    LStrList.Free;
  end;
end;

//Load from DFM 메뉴로 컴포넌트 Load시 기존 FBplFileList에 bpl file 추가함.
//ADfc의 내용을 FDesignFormConfig에 추가함
procedure TWatchF2.LoadDesignComponentPackageFromOnlyComp(ADfc: TDesignFormConfig);
var
  i,PrevPackSize: integer;
  LStr, LDFName: string;
  LStrList,LStrList2: TStringList;
begin
  SetCurrentDir(FFilePath);

  if not Assigned(FBplFileList) then
    FBplFileList := TStringList.Create;

  LStrList := TStringList.Create;
  LStrList2 := TStringList.Create;

  try
    //전역의 BplFileList를 가져옴
    for i := 0 to FDesignFormConfig.DesignFormConfigCollect.Count - 1 do
    begin
      LStr := FDesignFormConfig.DesignFormConfigCollect.Items[i].BplFileList;
      if LStr <> '' then
      begin
        while LStr <> '' do
        begin
          LDFName := GetTokenWithComma(LStr);
          if LStrList2.IndexOf(LDFName) = -1 then
            LStrList2.Add(LDFName);
        end;
      end;
    end;
//    System.EnumModules(EnumModulesFunc, LStrList2);

    for i := 0 to ADfc.DesignFormConfigCollect.Count - 1 do
    begin
      LStr := ADfc.DesignFormConfigCollect.Items[i].BplFileList;
      if LStr <> '' then
      begin
        while LStr <> '' do
        begin
          LDFName := GetTokenWithComma(LStr);
          if LStrList2.IndexOf(LDFName) = -1 then //새로운 bpl이면 load하기 위해
          begin
            LStrList.Add(LDFName);
            LStrList2.Add(LDFName);
          end;
        end;
      end;
    end;

    if LStrList.Count > 0 then
    begin
      with FDesignFormConfig.DesignFormConfigCollect.Add do
      begin
        BplFileList := LStrList.CommaText;
        DesignFormCaption := PageControl1.ActivePage.Caption;
        DesignFormIndex := 0;
        DesignFormFileName := '';
      end;
    end;

    PrevPackSize := High(FPackageHandles) + 1;
    //LStrList에는 아직 Load되지 않은 BPL file list가 있음
    SetLength(FPackageHandles, PrevPackSize + LStrList.Count);

    for i := PrevPackSize to PrevPackSize + LStrList.Count - 1 do
    begin
      FPackageHandles[i] := LoadPackage('..\Bpls\' + LStrList.Strings[i-PrevPackSize]);
      FBplFileList.AddObject(LStrList.Strings[i-PrevPackSize], Pointer(FPackageHandles[i]));
    end;
  finally
    LStrList2.Free;
    LStrList.Free;
  end;
end;

//동적으로 생성한 디자인 폼을 파일로부터 읽어들임
//AFileName: Watchlist 파일 이름임. + _pageIndex 를 붙여서 파일을 읽어 들임
procedure TWatchF2.LoadDesignForm(const AFileName: string; AOnlyOneFormOpen: Boolean);
var
  i,j: integer;
  LStr, LFileName, LDFName, LOriginalFilePath, LFilePath: string;
  LPage: TAdvOfficePage;
  LPanel: TpjhPanel;
  LIsLoadFrom_dfc: boolean;
begin
  if FCommandLine.IsOnlyOneForm then
    PageControl1.TabSettings.Height := PageControl1.TabSettings.Height - 1;

  LFileName := AFileName;

  //AFileName의 끝부분에  _dfc가 없으면  추가함
  LStr := Copy(LFileName, Length(LFileName) - 3, 4);
  LIsLoadFrom_dfc := Pos(DESIGNFORM_FILENAME, LStr) > 0;

  if not LIsLoadFrom_dfc then
  begin
    i := PosRev('_', LFileName);

    if i > 0 then
      LFileName := Copy(LFileName, 1, i-1);

    LFileName := LFileName + DESIGNFORM_FILENAME;
  end;

  if not FileExists(LFileName) then
  begin
    //ShowMessage(AFileName + ' file not found.');
    exit;
  end;

//  LOriginalFilePath := GetCurrentDir();
  LFileName := RelToAbs(LFIleName, FFilePath);
//  LFilePath := ExtractFilePath(LFileName);
//  LFileName := ExtractFileName(LFileName);

//  if LFilePath <> '' then
//    SetCurrentDir(LFilePath);

  FDesignFormConfig.DesignFormConfigCollect.Clear;
  FDesignFormConfig.LoadFromFile(LFileName,'',False);
  LFilePath := ExtractFilePath(LFileName);

  for i := 0 to FDesignFormConfig.DesignFormConfigCollect.Count - 1 do
  begin
    //DesignFormFileName에는 상대경로 + FileName이 저장됨
    LDFName := FDesignFormConfig.DesignFormConfigCollect.Items[i].DesignFormFileName;
    LDFName := ExtractFileName(LDFName);

    if (not LIsLoadFrom_dfc) and (ExtractFileName(LFileName) <> LDFName)then
      continue;

    LStr := FDesignFormConfig.DesignFormConfigCollect.Items[i].DesignFormCaption;

    if LStr = '' then
      LStr := 'DefaultName';

    if LIsLoadFrom_dfc then
    begin
      //PageControl1.RemoveAdvPage(PageControl1.ActivePage);
      j := PageControl1.AddAdvPage(LStr);
      PageControl1.ActivePageIndex := j;
//      LPage := PageControl1.ActivePage;
//      LPage := PageControl1.AdvPages[j];
      PageControl1InsertPage(Self, PageControl1.ActivePage); //Design Panel 생성
    end;
//    else
//    begin
//      LPage := PageControl1.ActivePage;
//    end;

    LoadDesignFormFromDFM(LFilePath+LDFName);
//    LPanel := TpjhPanel(GetDesignControl(LPage));
//    try
//      LoadFromDFM(LDFName, TWinControl(LPanel), ReadComponentsProc);
//    except
//
//    end;

//    LPage.Hint := LFilePath + LDFName;

    //첫번째 DFM 파일만 Load함
    if AOnlyOneFormOpen and (i = 0) then
    begin
      //팝업 메뉴에서 "Load One Form From Watch List"를 선택하면
      //현재 Page에서 TpjhTJvTransparentButton2 컴포넌트를 찾아서
      //pjhBtnActionKind 필드를 tbakLoadDFMFromFile로 변경함
      SetpjhBtnActionKind4TransparentBtn(tbakLoadDFMFromFile, True);
      Break;
    end;
  end;//for

  Caption := FDesignFormConfig.MainFormCaption;
  BorderStyle := TBorderStyle(FDesignFormConfig.BorderStyle);
  PageControl1.TabSettings.Height := FDesignFormConfig.TabHeight;
//  SetCurrentDir(LOriginalFilePath);
end;

procedure TWatchF2.LoadDesignFormFromMenu(AFileName: string; AIsFromdfc: Boolean);
var
  LStr: string;
begin
  if AFileName = '' then
    AFileName := GetFileNameFromWatchList;

  LStr := AFileName;
  LStr := Copy(LStr, Length(LStr) -3 , 4);

  if LStr <> DESIGNFORM_FILENAME then
  begin
    if AIsFromdfc then
    begin
      ShowMessage('''dfc'' should be included at the end of the Design Form File Name!');
      exit;
    end;
  end
  else
  begin
    if not AIsFromdfc then
    begin
      ShowMessage('''dfc'' should not be included at the end of the Design Form File Name!');
      exit;
    end;
  end;

  if AIsFromdfc then
    LoadDesignForm(AFileName, False)
  else
    ;
end;

procedure TWatchF2.LoadDesignFormFromDFCByPageIndex(APageIndex: integer);
var
  i, j, LPageIdx: integer;
  LDFMName, LCaption, LFilePath, LOriginalFilePath: string;
  LPage: TAdvOfficePage;
  LPanel: TpjhPanel;
//  LDesignPanel: TELDesignPanel;
begin
  if FCommandLine.IsOnlyOneForm then
  begin
    FTempTabHeight := PageControl1.TabSettings.Height;
//    PageControl1.Invalidate;
//    PageControl1.ActivePage.Invalidate;
    PageControl1.TabSettings.Height := FTempTabHeight - 1;
  end;

//  LOriginalFilePath := GetCurrentDir();
  LFilePath := ExtractFilePath(FWG.FCurrentWatchListFileName);
  LFilePath := RelToAbs(LFIlePath, FFilePath);
//  SetCurrentDir(LFilePath);

  for i := 0 to FDesignFormConfig.DesignFormConfigCollect.Count - 1 do
  begin
    LPageIdx := FDesignFormConfig.DesignFormConfigCollect.Items[i].DesignFormIndex;

    if LPageIdx = APageIndex then
    begin
      LDFMName := FDesignFormConfig.DesignFormConfigCollect.Items[i].DesignFormFileName;
      LDFMName := ExtractFileName(LDFMName);
      LCaption := FDesignFormConfig.DesignFormConfigCollect.Items[i].DesignFormCaption;

      if LCaption = '' then
        LCaption := 'DefaultName';

      FIsLoadingDFC := True;
      try
        FIgnorePageCloseConfirm := True;
        PageControl1.CloseActivePage;
      finally
        FIsLoadingDFC := False;
      end;

      j := PageControl1.AddAdvPage(LCaption);
      PageControl1.ActivePageIndex := j;
      LPage := PageControl1.ActivePage;
      PageControl1InsertPage(Self, LPage); //Design Panel 생성

      LPanel := TpjhPanel(GetDesignControl(LPage));

      try
        LoadDesignFormFromDFM(LFilePath+LDFMName);
//        LoadFromDFM(LDFMName, TWinControl(LPanel), ReadComponentsProc);
//        SetpjhBtnActionKind4TransparentBtn(tbakLoadDFMFromFile, True, j);
      except

      end;

//      LPage.Hint := LFilePath + LDFMName;
      Break;
    end;
  end;

  if FCommandLine.IsOnlyOneForm then
    FPJHTimerPool.AddOneShot(OnRefreshTab,100);
//  SetCurrentDir(LOriginalFilePath);
end;

procedure TWatchF2.LoadDesignFormFromDFM(AFileName: string);
var
  LPage: TAdvOfficePage;
  LPanel: TpjhPanel;
  LDFName: string;
  LDesignFormConfig: TDesignFormConfig;
//  LStrLst: TStringList;
begin
  LPage := PageControl1.ActivePage;
  LPanel := TpjhPanel(GetDesignControl(LPage));

  if LPanel.ComponentCount > 0 then
  begin
    ShowMessage('This action should be on empty form.'+#13#10+'Try again on new page');
    exit;
  end;

  if AFileName = '' then
    LDFName := GetFileNameFromWatchList
  else
    LDFName := AFileName;

  try
//    LPanel.Hide;
    LoadFromDFM(LDFName, TWinControl(LPanel), ReadComponentsProc);

    if FCommandLine.IsOnlyOneForm then
      SetpjhBtnActionKind4TransparentBtn(tbakLoadDFMFromFile, FCommandLine.IsOnlyOneForm);

    LPage.Hint := LDFName;//dfm 파일 이름을 sheet의 hint에 저장 함
  finally
  end;
end;

procedure TWatchF2.LoadDesignFormFromdfmfile1Click(Sender: TObject);
begin
  LoadDesignFormFromDFM('');
end;

procedure TWatchF2.LoadDesignPanel1Click(Sender: TObject);
begin
  //처음 생성시 Insert 함수 실행됨
  if LoadNCreateOrShowDM then
  begin
    AssignPanel2Designer(FDesignManagerForm);
    FDesignManagerForm.Show;
  end;
end;

procedure TWatchF2.LoadDFMFromFile1Click(Sender: TObject);
begin
  SetpjhBtnActionKind4TransparentBtn(tbakLoadDFMFromFile, True);
end;

procedure TWatchF2.LoadDFMFromFileincurrentpage1Click(Sender: TObject);
begin
  SetpjhBtnActionKind4TransparentBtn(tbakLoadDFMFromFile, False);
end;

procedure TWatchF2.LoadFromFile1Click(Sender: TObject);
begin
  LoadTrendDataMapFromFile('');
  DisplayTrendFromMap(iPlot1, FTrendDataMap);
end;

procedure TWatchF2.LoadItemsFromFile1Click(Sender: TObject);
begin
//  SetCurrentDir(FFilePath);
  JvOpenDialog1.InitialDir := RelToAbs(WatchListPath, FFilePath);
  JvOpenDialog1.Filter := '*.*';

  if JvOpenDialog1.Execute then
  begin
    if jvOpenDialog1.FileName <> '' then
    begin
//      WatchListFileName := ExtractFileName(jvOpenDialog1.FileName);
      FWG.GetItemsFromParamFile2Collect(jvOpenDialog1.FileName, FConfigOption.EngParamFileFormat,
                FConfigOption.EngParamEncrypt);
      FWG.AddEngineParameter2Grid;
      ApplyOption4AvgCalc;
    end;
  end;
end;

procedure TWatchF2.LoadMultiStatValuesfromDB1Click(Sender: TObject);
var
  LEngParamList: RawUtf8;
begin
  //FSimulateParamDBName에 DB Name 선택 후 할당
  //MultiState를 Simulation하기 위해서는 수동으로 이 함수를 실행해야 함.
  SetSimulateParamDBName;
  g_SimulateParamDB := InitSimulateParamClient(FSimulateParamDBName, SimulateParamModel);
  LEngParamList := GetEngineMultiStateList2JSONArrayFromSqlite(g_SimulateParamDB);
  IPCMonitorAll1.FEngineParameter.LoadFromJSONArrayOfMultiState(LEngParamList);
end;

//Result = Create하면 True
//         Show하면 False
function TWatchF2.LoadNCreateOrShowDM: Boolean;
var
  IbMI : IbplMainInterface;
begin
  if FPackageModules[0] = 0 then
{$IFDEF USE_PACKAGE}
    FPackageModules[0] := LoadPackage('..\Forms\DesignManagerDock.bpl');
{$ELSE}
    FPackageModules[0] := 1;
{$ENDIF};

  if FPackageModules[0] <> 0 then
  begin
    try
      //@FCreateFuncFromBPL[0] := GetProcAddress(FPackageModules[0], 'Create_VisualCommForms');
    except
      ShowMessage('Package Create function: '+
        ' not found!');
      exit;
    end;

    if not Assigned(FDesignManagerFormClass) then
      FDesignManagerFormClass := TFormClass(Classes.GetClass('TfrmDesignManagerDock'));
      //FDesignManagerFormClass := Classes.GetClass('TfrmMain');

    if Assigned(FDesignManagerFormClass) then
    begin
      if not Assigned(FDesignManagerForm) then
      begin
        //Application.CreateForm(TComponentClass(FDesignManagerFormClass), FDesignManagerForm);
        FDesignManagerForm := FDesignManagerFormClass.Create(Self);
        Result := True;
      end
      else
      begin
        FDesignManagerForm.Show;
        Result := False;
      end;
    end;
  end;
end;

procedure TWatchF2.LoadOneFormFromWatchList1Click(Sender: TObject);
begin
//  SetCurrentDir(FFilePath);
  JvOpenDialog1.InitialDir := RelToAbs(WatchListPath, FFilePath);
  JvOpenDialog1.Filter := '*.*';

  if JvOpenDialog1.Execute then
  begin
    if jvOpenDialog1.FileName <> '' then
    begin
      WatchListFileName := ExtractFileName(jvOpenDialog1.FileName);
      GetEngineParameterFromSavedWatchListFile(jvOpenDialog1.FileName, False, True);
    end;
  end;
end;

//파일의 첫줄은 반드시 헤더가 있어야 함.
procedure TWatchF2.LoadTrendDataFromFile(AFileName: string;
  AIsFirstFile: Boolean; AIsUseWatchList: Boolean);
var
  LStr, LIndexList: TStringList;
  LStr2,LStr3,LStr4: string;
  tmpdouble2, tmpdouble: double;
  i,j,k,LColumnCount,tmpCount: integer;
begin
  LStr:= TStringList.Create;
  try
    LStr.LoadFromFile(AFileName,TEncoding.UTF8);

    if LStr.Count = 0 then //실패했을 경우 다시 읽어 들임
    begin
      LStr.LoadFromFile(AFileName);
    end;

    if LStr.Count > 0 then
    begin
      if AIsFirstFile and (not AIsUseWatchList) then
      begin
        FTrendDataMapFromFile.Clear;
        iPlot1.RemoveAllChannels;
        iPlot1.RemoveAllYAxes;
        FWG.NextGrid1.ClearRows;
      end;

      LStr2 := LStr.Strings[0]; //Head Read
      GetTokenWithComma(LStr2); //시간은 먼저 읽어서 없앰

      LColumnCount := strTokenCount(LStr.Strings[0], ',');
      //index 0은 날짜시간이므로 제외함
      if AIsFirstFile and (not AIsUseWatchList) then
      begin //복수개의 파일중에 첫번째 파일이면 헤더 처리
        for i := 1 to LColumnCount - 1 do
        begin
          k := iPlot1.AddChannel;
          j := iPlot1.AddYAxis;
          FWG.NextGrid1.AddRow();

          LStr3 := GetTokenWithComma(LStr2);
          FWG.NextGrid1.CellByName['SimpleDisplay', i-1].AsInteger := -1;
          FWG.NextGrid1.CellByName['TrendDisplay', i-1].AsInteger := 1;
          FWG.NextGrid1.CellByName['ItemName', i-1].AsString := LStr3;
          iPlot1.YAxis[j].Title := LStr3;
          iPlot1.YAxis[j].ScaleLinesColor := iPlot1.Channel[k].Color;
          iPlot1.YAxis[j].LabelsFont.Color := iPlot1.Channel[k].Color;
          iPlot1.Channel[k].YAxisName := iPlot1.YAxis[j].Name;
          iPlot1.Channel[k].TitleText := LStr3;
          //iPlot1.Channel[k].Name := 'C_'+ iPlot1.YAxis[j].Name;
        end;
      end;
    end;

    if not AIsUseWatchList then
    begin
      for i := 1 to LStr.Count - 1 do
      begin
        LStr2 := LStr.Strings[i];
        LStr3 := GetTokenWithComma(LStr2);
        tmpdouble2 := StrToDateTime(LStr3);

        for j := 0 to LColumnCount - 2 do
        begin
          LStr3 := GetTokenWithComma(LStr2);
          tmpdouble := StrToFloatDef(LStr3,0.0);
          iPlot1.Channel[j].AddXY(tmpdouble2, tmpdouble);
          if AIsUseWatchList then
            LStr4 := GetTagNameFromDescriptor(FWG.NextGrid1.CellByName['ItemName', j].AsString)
          else
            LStr4 := FWG.NextGrid1.CellByName['ItemName', j].AsString;

          AddData2TrendMapFromFile(LStr4, tmpdouble2, tmpdouble);
        end;//for
      end;//for
    end
    else //if AIsUseWatchList
    begin
      //Channel 수가 표시할 데이터 종류보다 작으면 데이터 종류만큼 채널 생성
      //if iPlot1.ChannelCount < FWG.NextGrid1.SelectedCount then
      //begin
        //iPlot1.RemoveAllChannels;
        //iPlot1.RemoveAllYAxes;
        DeleteAllTrend;
        //그리드에서 선택된 데이터만 Trend에 추가
        for i := 0 to FWG.NextGrid1.RowCount - 1 do
          if FWG.NextGrid1.Row[i].Selected then
            AddChannelAndYAxis(i, tdtValue);
      //end;

      LIndexList := TStringList.Create;
      try
        //k := 0;//각 Index별 간격을 저장하기 위한 기준값 초기화
        for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
        begin
          if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrend then
          begin
            if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].YAxesMinValue <> 0 then
              iPlot1.YAxis[LColumnCount].Min := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].YAxesMinValue;
            if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].YAxesSpanValue <> 0 then
              iPlot1.YAxis[LColumnCount].Span := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].YAxesSpanValue;

            LStr2 := LStr.Strings[0];
            LStr3 := GetTokenWithComma(LStr2); //맨 앞 시간 제거
            for j := 1 to LColumnCount - 1 do
            begin
              LStr3 := GetTokenWithComma(LStr2);
              if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TagName = LStr3 then
              begin
                LIndexList.Add(IntToStr(j)); //이전 값과의 차이를 저장함(속도 향상을 위해)
                //k := j;
                break;
              end;
            end;
          end;
        end;//for

        LIndexList.Sort;

        for i := 1 to LStr.Count - 1 do
        begin
          LStr2 := LStr.Strings[i];
          LStr3 := GetTokenWithComma(LStr2);
          tmpdouble2 := StrToDateTime(LStr3);

          tmpCount := 0;
          for j := 0 to LIndexList.Count - 1 do
          begin
            LColumnCount := StrToInt(LIndexList.Strings[j]) - tmpCount;
            tmpCount := StrToInt(LIndexList.Strings[j]);
            for k := 1 to LColumnCount do
              LStr3 := GetTokenWithComma(LStr2);
            tmpdouble := StrToFloatDef(LStr3,0.0);
            iPlot1.Channel[j].AddXY(tmpdouble2, tmpdouble);
          end;//for
        end;//for
      finally
        FreeAndNil(LIndexList);
      end;
    end;
  finally
    FreeAndNil(LStr);
  end;
end;

procedure TWatchF2.LoadTrendDataFromFileUsingWatchList1Click(Sender: TObject);
begin
  OpenTrendDataFile(True);
end;

procedure TWatchF2.LoadTrendDataMapFromFile(AFileName: string);
begin
  if AFileName = '' then
  begin
    JvOpenDialog1.InitialDir := FFilePath;
    JvOpenDialog1.Filter := '*.dmap||*.*';
    if JvOpenDialog1.Execute then
    begin
      if jvOpenDialog1.FileName <> '' then
      begin
        AFileName := jvOpenDialog1.FileName;
      end;
    end;
  end;

  if not FileExists(AFileName) then
    exit;

  FTrendDataMap.Clear;
  FTrendDataMap := TObjStream.ReadObjectInfile(AFileName, []) as DMap;
end;

procedure TWatchF2.LoadWatchListFromFile1Click(Sender: TObject);
begin
//  SetCurrentDir(FFilePath);
  JvOpenDialog1.InitialDir := RelToAbs(WatchListPath, FFilePath);
  JvOpenDialog1.Filter := '*.*';

  if JvOpenDialog1.Execute then
  begin
    if jvOpenDialog1.FileName <> '' then
    begin
      WatchListFileName := ExtractFileName(jvOpenDialog1.FileName);
      GetEngineParameterFromSavedWatchListFile(jvOpenDialog1.FileName, False, False);
      //LoadDesignFormFromMenu(jvOpenDialog1.FileName+DESIGNFORM_FILENAME, True);
    end;
  end;
end;

procedure TWatchF2.LockUnLockValue2Screen(AIsLock: Boolean);
begin
  FEnterWatchValue2Screen := AIsLock;
  FEnterWatchAnalogValue2DesignScreen := AIsLock;
end;

procedure TWatchF2.SaveConfigData2Xml;
var
  Lstr: string;
begin
  Lstr := ChangeFileExt(Application.ExeName, CONFIG_FILE_EXT);
  FConfigOption.SaveToJSONFile(Lstr, '', False);
end;

procedure TWatchF2.SaveConfigDataForm2Xml(AMonitorConfigF: TWatchConfigF);
var
  Lstr: string;
  i: integer;
begin
  Lstr := ChangeFileExt(Application.ExeName, CONFIG_FILE_EXT);

  FConfigOption.FormCaption := AMonitorConfigF.CaptionEdit.Text;
  FConfigOption.ModbusFileName := AMonitorConfigF.MapFilenameEdit.FileName;
  FCurrentModbusFileName := FConfigOption.ModbusFileName;
  FConfigOption.AverageSize := StrToIntDef(AMonitorConfigF.AvgEdit.Text,1);
  WatchListFileName := AMonitorConfigF.WatchFileNameEdit.Text;

  FConfigOption.SelDisplayInterval :=AMonitorConfigF.IntervalRG.ItemIndex;
  FConfigOption.DisplayInterval := StrToIntDef(AMonitorConfigF.IntervalEdit.Text,0);
  FConfigOption.AliveSendInterval := StrToIntDef(AMonitorConfigF.AliveIntervalEdit.Text,0);

  FConfigOption.SelectAlarmValue := AMonitorConfigF.SelAlarmValueRG.ItemIndex;
  FConfigOption.MinFaultValue := StrToFloatDef(AMonitorConfigF.MinFaultEdit.Text,0.0);
  FConfigOption.MaxAlarmValue := StrToFloatDef(AMonitorConfigF.MaxAlarmEdit.Text,0.0);
  FConfigOption.MinFaultValue := StrToFloatDef(AMonitorConfigF.MinFaultEdit.Text,0.0);
  FConfigOption.MaxFaultValue := StrToFloatDef(AMonitorConfigF.MaxFaultEdit.Text,0.0);
  FConfigOption.MinAlarmColor := Longint(AMonitorConfigF.MinAlarmColorSelector.SelectedColor);
  FConfigOption.MaxAlarmColor := Longint(AMonitorConfigF.MaxAlarmColorSelector.SelectedColor);
  FConfigOption.MinFaultColor := Longint(AMonitorConfigF.MinFaultColorSelector.SelectedColor);
  FConfigOption.MaxFaultColor := Longint(AMonitorConfigF.MaxFaultColorSelector.SelectedColor);
  FConfigOption.MinAlarmBlink := AMonitorConfigF.MinAlarmBlinkCB.Checked;
  FConfigOption.MaxAlarmBlink := AMonitorConfigF.MaxAlarmBlinkCB.Checked;
  FConfigOption.MinFaultBlink := AMonitorConfigF.MinFaultBlinkCB.Checked;
  FConfigOption.MaxFaultBlink := AMonitorConfigF.MaxFaultBlinkCB.Checked;
  FConfigOption.ViewAvgValue := AMonitorConfigF.ViewAvgValueCB.Checked;
  FConfigOption.SubWatchClose := AMonitorConfigF.SubWatchCloseCB.Checked;
  FConfigOption.ZoomToFitTrend := AMonitorConfigF.ZoomToFitCB.Checked;
  FConfigOption.DefaultSoundFileName := AMonitorConfigF.DefaultSoundEdit.FileName;
  FConfigOption.NameFontSize := StrToIntDef(AMonitorConfigF.NameFontSizeEdit.Text,20);
  FConfigOption.ValueFontSize := StrToIntDef(AMonitorConfigF.ValueFontSizeEdit.Text,70);
  FConfigOption.RingBufferSize := StrToIntDef(AMonitorConfigF.RingBufSizeEdit.Text,0);
  FConfigOption.EngParamEncrypt := AMonitorConfigF.EngParamEncryptCB.Checked;
  FConfigOption.EngParamFileFormat := AMonitorConfigF.ConfFileFormatRG.ItemIndex;
  FConfigOption.MonDataSource := AMonitorConfigF.MonDataFromRG.ItemIndex;

  //MQ Server
  FConfigOption.MQServerIP := AMonitorConfigF.MQIPAddress.Text;
  FConfigOption.MQServerPort := AMonitorConfigF.MQPortEdit.Text;
  FConfigOption.MQServerUserId := AMonitorConfigF.MQUserEdit.Text;
  FConfigOption.MQServerPasswd := AMonitorConfigF.MQPasswdEdit.Text;

  FConfigOption.MQServerTopicCollect.Clear;
  for i := 0 to AMonitorConfigF.MQTopicLB.Count - 1 do
    FConfigOption.MQServerTopicCollect.Add.TopicName := AMonitorConfigF.MQTopicLB.Items[i];
  FConfigOption.DisplayAverageValue := AMonitorConfigF.DispAvgValueCB.Checked;

  FConfigOption.SaveToJSONFile(Lstr);
end;

procedure TWatchF2.SavecurrentpagetodfmFileText1Click(Sender: TObject);
var
  LTextFileName: string;
  LPanel: TpjhPanel;
begin
  JvSaveDialog1.InitialDir := ExtractFilePath(PageControl1.ActivePage.Hint);//FFilePath;
  JvSaveDialog1.Filter := '*.dfm|*.*';

  if JvSaveDialog1.Execute then
  begin
    LTextFileName := JvSaveDialog1.FileName;

    if FileExists(LTextFileName) then
    begin
      if MessageDlg('File is already existed. Are you overwrite? if No press, then the data is not saved!',
        mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;

    LPanel := GetTpjhPanelOfCurrentPage;
    SaveBinDFM2TextDFMFromControl(TWincontrol(LPanel), LTextFileName);
  end;
end;

//동적으로 생성한 디자인 폼을 저장함
//AFileName: Watchlist 파일 이름임. + _pageIndex 를 붙여서 저장함
procedure TWatchF2.SaveDesignForm(AFileName: string; AIsOnlyOneForm: Boolean);
var
  i,j: integer;
  LPanel: TpjhPanel;
  LStr: string;
  LBplFileNameList: TStringList;
  LStrLst: TStringList;
  LPage: TAdvOfficePage;
begin
  SetCurrentDir(FFilePath);

  if not AIsOnlyOneForm then
  begin
    //만약 기존에 파일이 존재하면 모두 삭제함(AFileName__x, __dfc)
    LStrLst := GetFileListFromDir(ExtractFilePath(AFileName), ExtractFileName(AFileName) + HiMECS_DesignFormSuffix + '*', false);
    try
      for i := 0 to LStrLst.Count - 1 do
      begin
        if UpperCase(ExtractFileName(LStrLst.Strings[i])) <> UpperCase(ExtractFileName(AFileName)) then
          DeleteFile(LStrLst.Strings[i]);
      end;

    finally
      LStrLst.Free;
    end;
  end;

  //Design Form이 존재할 경우
  if PageControl1.AdvPageCount > DYNAMIC_PAGE_INDEX then
  begin
    FDesignFormConfig.DesignFormConfigCollect.Clear;
    LBplFileNameList := TStringList.Create;
    try
      for i := DYNAMIC_PAGE_INDEX to PageControl1.AdvPageCount - 1 do
      begin
        if AIsOnlyOneForm then
        begin
          LStr := PageControl1.AdvPages[i].Hint;
          LStr := AbsToRel(LStr, FFilePath);
        end
        else
          LStr := AFileName + HiMECS_DesignFormSuffix + IntToStr(i); //'__'

        LPanel := TpjhPanel(GetDesignControl(PageControl1.AdvPages[i]));
        //1이면 Design Mode임을 뜻합. 저장시에는 0으로 초기화 함. LoadDFM 실행 시 Tag도 Update 되기 때문임
        //LPanel은 DFM File에 저장되기 때문에 TDesignPanel에 Active여부 저장하는 걸로 수정함 : 2022.10.22
        //        LPanel.Tag := 0;
        SaveToDFM2(LStr, TWinControl(LPanel));//Change by pjh 2021.11.3 Text Format으로 저장함
//          SaveComponentToFile(TComponent(LPanel), LStr);

        if not AIsOnlyOneForm then
        begin
          with FDesignFormConfig.DesignFormConfigCollect.Add do
          begin
            for j := DYNAMIC_PAGE_INDEX to PageControl1.AdvPageCount - 1 do
            begin
              LPage := PageControl1.AdvPages[j];
              GetBplNamesFromDesignPanel(LBplFileNameList, LPage);
            end;

            BplFileList := LBplFileNameList.CommaText;
            DesignFormCaption := PageControl1.AdvPages[i].Caption;
            DesignFormIndex := i;
            DesignFormFileName := LStr;
  //          ShowMessage('SaveDesignForm ==>' + LStr);
          end;
        end;
      end; //for

      if not AIsOnlyOneForm then
      begin
        FDesignFormConfig.MainFormCaption := Caption;
        FDesignFormConfig.BorderStyle := ord(BorderStyle);
        FDesignFormConfig.TabHeight := PageControl1.TabSettings.Height;

        FDesignFormConfig.SaveToFile(AFileName + DESIGNFORM_FILENAME);
      end;
    finally
      FreeAndNil(LBplFileNameList);
    end;
  end;
end;

//Tab Change시에 FromPage의 TDesignPanel.Tag에 Designer.Active상태 저장
//(TpjhPanel.Tag에서 TDesignPanel.Tag로 변경함)
//Page 복원시에 적용하기 위함
procedure TWatchF2.SaveDesignMode2ControlTag(APageIndex: Integer);
var
  IbMI : IbplMainInterface;
  LPage: TAdvOfficePage;
//  LPanel: TpjhPanel;
  LDesignPanel: TELDesignPanel;
  i: integer;
begin
  if APageIndex >= PageControl1.AdvPageCount then
    exit;

  LPage := PageControl1.AdvPages[APageIndex];
  LDesignPanel := GetDesignPanel(LPage);
//  LPanel := TpjhPanel(GetDesignControl(LPage));

  if not Assigned(LDesignPanel) then
  begin
    ShowMessage('SaveDesignMode2ControlTag 함수에서 LDesignPanel 을 가져올 수 없음!');
    exit;
  end;

  //Design Manager Form이 Load된 경우
  if Assigned(FDesignManagerForm) then
  begin
    if Supports(FDesignManagerForm, IbplMainInterface, IbMI) then
    begin
      LDesignPanel.Tag := BoolToInt(IbMI.Designer.Active)//+1;//0일 경우 처음 생성한 것임
//      LPanel.Tag := BoolToInt(IbMI.Designer.Active)//+1;//0일 경우 처음 생성한 것임
    end;
  end;
end;

procedure TWatchF2.SaveDMap2File(AFileName: string; AMap: DMap);
begin
  if AFileName = '' then
  begin
    JvSaveDialog1.InitialDir := FFilePath;
    JvSaveDialog1.Filter :=  '*.dmap||*.*';

    if JvSaveDialog1.Execute then
    begin
      AFileName := JvSaveDialog1.FileName;

      if FileExists(AFileName) then
      begin
        if MessageDlg('File is already existed. Are you overwrite? if No press, then the data is not saved!.',
        mtConfirmation, [mbYes, mbNo], 0)= mrNo then
          exit;
      end;
    end;
  end;

  TObjStream.WriteObjectToFile(AFileName, [], AMap);
end;

procedure TWatchF2.SaveDMultiMap2File(AFileName: string; AMap: DMultiMap);
var
  it: DIterator;
  LDoublePoint: TDoublePoint;
  LStr, LStr2: string;
begin
  it := AMap.startKey;
  SetToValue(it);

  while not atEnd(it) do
  begin
    LDoublePoint := GetObject(it) as TDoublePoint;
    LStr := format('%f'+#9+'%f',[LDoublePoint.X,LDoublePoint.Y]);
    LStr2 := 'dat';
    SaveData2DateFile(AFileName, LStr2, LStr, soFromEnd);
    Advance(it);
  end;//while
end;

procedure TWatchF2.SaveItemsToDB1Click(Sender: TObject);
var
  LFileName: string;
begin
//  SetCurrentDir(FFilePath);
  JvSaveDialog1.InitialDir := RelToAbs('..\db', FFilePath);

  if JvSaveDialog1.Execute then
  begin
    LFileName := JvSaveDialog1.FileName;

    if FileExists(LFileName) then
    begin
      if MessageDlg('File is already existed. Are you overwrite? if No press, then the data is not saved!.',
      mtConfirmation, [mbYes, mbNo], 0)= mrNo then
        exit;
    end;

    if TEngineParameter.SaveEngParamCollect2DB(LFileName, IPCMonitorAll1.FEngineParameter.EngineParameterCollect, False) <> -1 then
      ShowMessage('Items are saved to db (' + LFileName + ')');
  end;
end;

procedure TWatchF2.SaveItemsToFile(AFileName: string; APropmtSaveConfirm: Boolean);
begin
//  SetCurrentDir(FFilePath);
  JvSaveDialog1.InitialDir := RelToAbs(WatchListPath, FFilePath);

  if AFileName = '' then
  begin
    if JvSaveDialog1.Execute then
    begin
      AFileName := JvSaveDialog1.FileName;
    end;
  end;

  if APropmtSaveConfirm and FileExists(AFileName) then
  begin
    if MessageDlg('File is already existed. Are you overwrite? if No press, then the data is not saved!.',
    mtConfirmation, [mbYes, mbNo], 0)= mrNo then
      exit;
  end;

  if not FIsMDIChileMode then
    SetWatchFormState2Param(IPCMonitorAll1.FEngineParameter);

  if FConfigOption.EngParamFileFormat = 0 then //JSON format
    IPCMonitorAll1.FEngineParameter.SaveToJSONFile(AFileName,
              ExtractFileName(AFileName),FConfigOption.EngParamEncrypt)
  else
  if FConfigOption.EngParamFileFormat = 1 then //XML format
    IPCMonitorAll1.FEngineParameter.SaveToFile(AFileName,
              ExtractFileName(AFileName),FConfigOption.EngParamEncrypt);
end;

procedure TWatchF2.SaveItemsToFile1Click(Sender: TObject);
begin
  SaveItemsToFile('',True);
end;

procedure TWatchF2.SaveOnlyDFM1Click(Sender: TObject);
var
  LFileName: string;
begin
  SetCurrentDir(FFilePath);
  JvSaveDialog1.InitialDir := ExtractFilePath(PageControl1.ActivePage.Hint);//'..\WatchList';

  if JvSaveDialog1.Execute then
  begin
    LFileName := JvSaveDialog1.FileName;

    if FileExists(LFileName) then
    begin
      if MessageDlg('File is already existed. Are you overwrite? if No press, then the data is not saved!.',
      mtConfirmation, [mbYes, mbNo], 0)= mrNo then
        exit;
    end;

    SaveOnlyDFMofCurPage(LFileName);
  end;
end;

//현재 페이지의 컴포넌트를 저장함.
procedure TWatchF2.SaveOnlyDFMofCurPage(AFileName: string);
var
  LPanel: TpjhPanel;
begin
  LPanel := GetTpjhPanelOfCurrentPage;
  SaveToDFM(AFileName, TWinControl(LPanel));
//  SaveComponentToFile(TComponent(LPanel), AFileName);
end;

procedure TWatchF2.SaveSimulateParamData2Json(ARecToPass: TCopyDataStruct);
begin
//  FSimParamJsonData4Edit := String(ARecToPass.StrMsg);
  RecvSimulateParamDataFromgpShMM(FSimParamJsonData4Edit);
//  ShowMessage(IntToStr(ARecToPass.cbData) + ' : ' + IntToStr(Length(FSimParamJsonData4Edit)));
end;

procedure TWatchF2.SaveSimulateValue2DB;
var
  LDoc: variant;
  LParamSrcList,
  LJsonParamCollect,
  LCSVValues,
  LAdditionalData,
  LSimulateCompValuesJson: string;
  LProcessID: THandle;
  LParam: string;
//  Llst: TStringList;
begin
  if FWG.NextGrid1.RowCount = 0 then
    exit;

  if FSimulateParamDBName = '' then
  begin
    if MessageDlg('SimulateParamDB name is empty.' + #3#10 + 'Do you want to set the paramDB Name?' +#13#10 +
      'If select "No" then defaule DB name(HGSSimulateParameter.sqlite) is used.',
      mtConfirmation, [mbYes, mbNo], 0)= mrYes then
      SetSimulateParamDBName();
  end;

  LAdditionalData := GetJsonAdditionalData4Simulate();
  GetVariantFromItemList4SimulateData(LDoc);
  LJsonParamCollect := _JSON(LDoc.JsonParamCollect);
  LCSVValues := LDoc.CSVValues;
  LParamSrcList := LDoc.ParamSourceList;

  if (LJsonParamCollect <> '') and (LCSVValues <> '') then
  begin
//    Llst := TStringList.Create;
//    try
      SetCurrentDir(FFilePath);
      LParamSrcList := MakeRawUTF8ToBin64(LParamSrcList);
      LJsonParamCollect := MakeRawUTF8ToBin64(LJsonParamCollect);
      LCSVValues := MakeRawUTF8ToBin64(LCSVValues);
      LAdditionalData := MakeRawUTF8ToBin64(LAdditionalData);
      LSimulateCompValuesJson := MakeRawUTF8ToBin64(FSimulateCompValuesJson);
      LParam := '/j' + LJsonParamCollect;

      if FSimulateParamDBName <> '' then
        LParam := LParam + ' /p'+ FSimulateParamDBName;

      LParam := LParam + ' /v'+ LCSVValues;
      LParam := LParam + ' /s'+ LParamSrcList;
      LParam := LParam + ' /a'+ LAdditionalData; //Param Sever Edit Form을 띄울때 기 입력한 기본 정보를 표시해줌
      LParam := LParam + ' /d'+ LSimulateCompValuesJson; //Param Server에 저장할 Component Value list를 Json으로 전달함
//      Llst.Text := LParam;
//      Llst.SaveToFile('c:\temp\pjh.txt', TEncoding.UTF8);
//      LParam := '/p' + 'c:\temp\pjh.txt';
      LProcessId := ExecNewProcess2(IncludeTrailingPathDelimiter(FFilePath)+SimulateParamServerName, LParam);
//    finally
//      Llst.Free;
//    end;
  end;
end;

procedure TWatchF2.SaveSimulateValuetoDB1Click(Sender: TObject);
begin
  SaveSimulateValue2DB;
end;

procedure TWatchF2.SaveWatchList(AFileName: string; ASaveRelativeFolder: Boolean;
  AIsOneFormMode: Boolean);
var
  i, LChCount: integer;
  LStr, LWatchListPath: string;
  LUser, LUser2: THiMECSUserLevel;
  LDeleteFileList : TStringList;
begin
  if ASaveRelativeFolder then
  begin
    LWatchListPath := ExtractFilePath(ExtractRelativePathBaseApplication(FFilePath, AFileName));//WatchListPath;
    AFileName := ExtractFileName(AFileName);
  end
  else
    LWatchListPath := '';

  //Administrator 이상의 권한만 저장 가능함
  if (IPCMonitorAll1.FCurrentUserLevel <= HUL_Administrator) and
      (AllowUserlevelCB.Enabled) and (AllowUserlevelCB.Text <> '') then
  begin
    i := Length(AFileName);
    LStr := System.Copy(AFileName,i,1);

    if LStr <> '' then
    begin
      i := StrToIntDef(LStr,-1);
      //사용자 지정 파일 이름이면 끝문자가 숫자가 아닐 수 있음
      if i <> -1 then
      begin
        LUser := THiMECSUserLevel(i);
        LUser2 := String2UserLevel(AllowUserlevelCB.Text);

        if LUser2 <> LUser then  //ComboBox User Level과 filename의 user level 비교
        begin
          if FileExists(LWatchListPath+AFileName) then
          begin
            if MessageDlg('ComboBox User and FileName user level are different.'+#13#10+'Change file name to ComboBox User Level?',
                                        mtConfirmation, [mbYes, mbNo], 0)= mrYes then
            begin
              LDeleteFileList := TStringList.Create;
              try
                GetFiles(LDeleteFileList, LWatchListPath+AFileName);
                for i := 0 to LDeleteFileList.Count - 1 do
                  ;//DeleteFile(LDeleteFileList.Strings[i]);
              finally
                LDeleteFileList.Free;
              end;

              //DeleteFile(LWatchListPath+AFileName);
              AFileName := formatDateTime('yyyymmddhhnnsszz',now)+
              IntToStr(FConfigOption.EngParamFileFormat) + IntToStr(Ord(LUser2));
            end;
          end;
        end;
      end;//if LUser <> -1
    end;

    IPCMonitorAll1.FEngineParameter.AllowUserLevelWatchList := String2UserLevel(AllowUserlevelCB.Text);
  end
  else
    IPCMonitorAll1.FEngineParameter.AllowUserLevelWatchList := IPCMonitorAll1.FCurrentUserLevel;

  IPCMonitorAll1.FEngineParameter.ExeName := ExtractFileName(Application.ExeName);

//하기 SetWatchFormState2Param는 SaveItemsToFile()에서 실행됨
//  if not FIsMDIChileMode and SaveListCB.Checked then
//    SetWatchFormState2Param(IPCMonitorAll1.FEngineParameter);

  LChCount := 0;

  for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrend then
    begin
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].YAxesMinValue :=
            iPlot1.YAxis[LChCount].Min;
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].YAxesSpanValue :=
            iPlot1.YAxis[LChCount].Span;
      Inc(LChCount);
    end;
  end;

  if LWatchListPath <> '' then
  begin
    SetCurrentDir(FFilePath);
    if not setcurrentdir(LWatchListPath) then
      createdir(LWatchListPath);
  end;

  SetCurrentDir(FFilePath);

  if AFileName = '' then //file name 앞에 프로그램명(1=HiMECS_Watch2.exe) 붙임
    LStr := LWatchListPath+formatDateTime('1yyyymmddhhnnsszz',now)+
      IntToStr(FConfigOption.EngParamFileFormat) +
      IntToStr(Ord(IPCMonitorAll1.FEngineParameter.AllowUserLevelWatchList))
  else
    LStr := LWatchListPath+AFileName;

  SaveItemsToFile(LStr);

  if not AIsOneFormMode then
    SaveWatchListFileOfSummary(LStr);

  SaveDesignForm(LStr, AIsOneFormMode);
end;

procedure TWatchF2.SaveWatchListFileOfSummary(AFileName: string);
var
  LFS: TJclFileSummary;
  LFSI: TJclFileSummaryInformation;
begin
//  LFS:= TJclFileSummary.Create(AFileName, fsaReadWrite, fssDenyAll);
//  try
//    LFS.GetPropertySet(TJclFileSummaryInformation, LFSI);
//    if Assigned(LFSI) then
//    begin
//      LFSI.Template := IPCMonitorAll1.FEngineParameter.ProjectFileName;
//    end;
//  finally
//    FreeAndNil(LFSI);
//    LFS.Free;
//  end;
end;

procedure TWatchF2.SaveWatchLittoNewName1Click(Sender: TObject);
var
  LFileName: string;
begin
//  SetCurrentDir(FFilePath);
  JvSaveDialog1.InitialDir := RelToAbs(WatchListPath, FFilePath);

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

  SaveWatchList(LFileName, True, FCommandLine.IsOnlyOneForm);
end;

procedure TWatchF2.SelectItemsClick(Sender: TObject);
begin
  SelectTrendItemsForXYGraph;
end;

procedure TWatchF2.SelectTrendItemsForXYGraph;
var
  i: integer;
begin
  with TCopyWatchListF.Create(nil) do
  begin
    FWG.NextGrid1.SaveToTextFile(TEMPFILENAME);
    FWG.NextGrid1.LoadFromTextFile(TEMPFILENAME);

    for i := 0 to iXYPlot1.ChannelCount - 1 do
    begin
      ChannelListCB.AddItem(iXYPlot1.Channel[i].Name,self);
    end;

    while True do
    begin
      if ShowModal = mrOK then
      begin
        if ChannelListCB.Text = '' then
        begin
          ShowMessage('Select channel!');
          ChannelListCB.SetFocus;
          continue;
        end;

        for i := 0 to FWG.NextGrid1.RowCount - 1 do
          FWG.NextGrid1.CellByName['IsAvg',i].AsBoolean := FWG.NextGrid1.Row[i].Selected; //hidden field

        FWG.NextGrid1.SaveToTextFile(TEMPFILENAME);
        FWG.NextGrid1.ClearRows;
        FWG.NextGrid1.LoadFromTextFile(TEMPFILENAME);

        for i := 0 to FWG.NextGrid1.RowCount - 1 do
          FWG.NextGrid1.Row[i].Selected := FWG.NextGrid1.CellByName['IsAvg',i].AsBoolean;

        if DetermineIndexForXYGraph(ChClearCB.Checked) then //X,Y의 Parameter Index 저장
        begin
          //DataViewZHorz에 select 된 Channel index 저장
          iXYPlot1.DataViewZHorz := ChannelListCB.ItemIndex;
          iXYPlot1.Channel[ChannelListCB.ItemIndex].MarkersVisible := True;
          iXYPlot1.Channel[ChannelListCB.ItemIndex].MarkersStyle := TiPlotMarkerStyle(1);
          break;
        end;
      end
      else
        break;
    end;
  end;//with
end;

procedure TWatchF2.SellectAll1Click(Sender: TObject);
begin
  FWG.NextGrid1.SelectAll;
end;

procedure TWatchF2.SendShortCut2DesignScreen4ShowBalloon;
begin
    if IPCMonitorAll1.FIsUseBalloon then  //UseBalloon = True이면
    begin
      AppActivateWithHandle(Handle); //자신을 Activate 시켜서 Key Code를 수신 가능하게 함(SendKey32.pas)
//          SendKeys('{F7}', True);
//          ExcuteKeyUp(VK_F7);//Balloon Component에서 F7을 누르면 Balloon을 보여줌
      ExcuteKeyDown(VK_F7);//Balloon Component에서 F7을 누르면 Balloon을 보여줌
      IPCMonitorAll1.FIsUseBalloon := False;
    end;
end;

procedure TWatchF2.SendSimulateParamData2gpShMM(AData: string);
//var
//  LStrList: TStringList;
begin
  IPCMonitorAll1.SendData2gpSM(gp_EventName4SimEditData, AData);
//  LStrList := TStringList.Create;
//  try
//    LStrList.Add(IntToStr(GetCurrentProcessId));
//    LStrList.Add(AData);
//
//    if IPCMonitorAll1.FgpSharedMM.AcquireMemory(True, INFINITE) <> nil then
//    begin
//      if IPCMonitorAll1.FgpSharedMM.IsWriting then
//        LStrList.SaveToStream(IPCMonitorAll1.FgpSharedMM.AsStream);
//    end;
//
//    if IPCMonitorAll1.FgpSharedMM.Acquired then
//      IPCMonitorAll1.FgpSharedMM.ReleaseMemory;
//
//    IPCMonitorAll1.FGpSharedEventProducer.BroadcastEvent(gp_EventName4SimEditData,
//              FormatDateTime('hh:mm:ss.zzz', Now));//  finally
//    LStrList.Free;
//  end;
end;

//procedure TWatchF2.SendAliveOk;
//var
//  AsyncTask: ITask;
//begin
//  AsyncTask := FTaskPool.AcquireTask(OnAsynchronousIPCTask, 'AsyncTask');
//  //AsyncTask.Values.Ensure('ComputerName').AsString := eComputerName.Text;
//  AsyncTask.Values.Ensure('ServerName').AsString := FDummyFormHandle;//HIMECS_CROMIS_SERVER_NAME;
//  AsyncTask.Run;
//end;

procedure TWatchF2.SetAlarm4OriginalOption(AValue: double; AEPIndex: integer);
var
  LSoundF: string;
begin
  if AEPIndex < 0 then
    exit;

  if (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxFaultEnable) and
    (AValue > IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxFaultValue) then
  begin
    FCurrentChangeColor := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxFaultColor;
    FBlinkEnable := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxFaultBlink;

    if FBlinkEnable then
      FBlinkOn := not FBlinkOn
    else
      FPJHTimerPool.AddOneShot(OnChangeDispPanelColor,100);

    if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxFaultSoundEnable then
    begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxFaultSoundFilename = '' then
        LSoundF := FConfigOption.DefaultSoundFileName
      else
        LSoundF := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxFaultSoundFilename;

      ExecuteSound(LSoundF);
    end;
  end
  else
  if (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxAlarmEnable) and
    (AValue > IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxAlarmValue) then
  begin
    FCurrentChangeColor := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxAlarmColor;
    FBlinkEnable := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxAlarmBlink;

    if FBlinkEnable then
      FBlinkOn := not FBlinkOn
    else
      FPJHTimerPool.AddOneShot(OnChangeDispPanelColor,100);

    if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxAlarmSoundEnable then
    begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxAlarmSoundFilename = '' then
        LSoundF := FConfigOption.DefaultSoundFileName
      else
        LSoundF := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MaxAlarmSoundFilename;

      ExecuteSound(LSoundF);
    end;
  end
  else
  if (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinFaultEnable) and
    (AValue < IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinFaultValue) then
  begin
    FCurrentChangeColor := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinFaultColor;
    FBlinkEnable := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinFaultBlink;

    if FBlinkEnable then
      FBlinkOn := not FBlinkOn
    else
      FPJHTimerPool.AddOneShot(OnChangeDispPanelColor,100);

    if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinFaultSoundEnable then
    begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinFaultSoundFilename = '' then
        LSoundF := FConfigOption.DefaultSoundFileName
      else
        LSoundF := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinFaultSoundFilename;

      ExecuteSound(LSoundF);
    end;
  end
  else
  if (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinAlarmEnable) and
    (AValue < IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinAlarmValue) then
  begin
    FCurrentChangeColor := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinAlarmColor;
    FBlinkEnable := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinAlarmBlink;

    if FBlinkEnable then
      FBlinkOn := not FBlinkOn
    else
      FPJHTimerPool.AddOneShot(OnChangeDispPanelColor,100);

    if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinAlarmSoundEnable then
    begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinAlarmSoundFilename = '' then
        LSoundF := FConfigOption.DefaultSoundFileName
      else
        LSoundF := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].MinAlarmSoundFilename;

      ExecuteSound(LSoundF);
    end;
  end
  else
  begin
    FBlinkEnable := False;
    FBlinkOn := False;
    ChangeDispPanelColor(clBlack);
    ExecuteSound('', true);
  end;
end;

procedure TWatchF2.SetAlarm4ThisOption(AValue: double);
begin
  if AValue > FConfigOption.MaxAlarmValue then
  begin
    FCurrentChangeColor := FConfigOption.MaxAlarmColor;
    FBlinkEnable := FConfigOption.MaxAlarmBlink;

    if FBlinkEnable then
      FBlinkOn := not FBlinkOn
    else
      FPJHTimerPool.AddOneShot(OnChangeDispPanelColor,100);
  end
  else
  if AValue > FConfigOption.MaxFaultValue then
  begin
    FCurrentChangeColor := FConfigOption.MaxFaultColor;
    FBlinkEnable := FConfigOption.MaxFaultBlink;

    if FBlinkEnable then
      FBlinkOn := not FBlinkOn
    else
      FPJHTimerPool.AddOneShot(OnChangeDispPanelColor,100);
  end
  else
  if AValue < FConfigOption.MinAlarmValue then
  begin
    FCurrentChangeColor := FConfigOption.MinAlarmColor;
    FBlinkEnable := FConfigOption.MinAlarmBlink;

    if FBlinkEnable then
      FBlinkOn := not FBlinkOn
    else
      FPJHTimerPool.AddOneShot(OnChangeDispPanelColor,100);
  end
  else
  if AValue < FConfigOption.MinFaultValue then
  begin
    FCurrentChangeColor := FConfigOption.MinFaultColor;
    FBlinkEnable := FConfigOption.MinFaultBlink;

    if FBlinkEnable then
      FBlinkOn := not FBlinkOn
    else
      FPJHTimerPool.AddOneShot(OnChangeDispPanelColor,100);
  end
  else
  begin
    FBlinkEnable := False;
    FBlinkOn := False;
    ChangeDispPanelColor(clBlack);
  end;
end;

procedure TWatchF2.SetCompData2Text(ARecToPass: TRecToPass);
var
  LData, LCompName, LPropertyName: string;
  i,j,k: integer;
  LPanel: TpjhPanel;
  LTargetList: TStringList;
//  LComponent: TComponent;
begin
  LTargetList := TStringList.Create;
  try
    LData := String(ARecToPass.StrMsg);
    LCompName := String(ARecToPass.StrSrcFormName);
    LTargetList.Delimiter := ';';
    LTargetList.DelimitedText := LCompName;

    for k := LTargetList.Count - 1 downto 0 do
    begin
      LCompName := LTargetList.Strings[k];

      for j := 5 to PageControl1.AdvPageCount - 1 do
      begin
//        LComponent := PageControl1.AdvPages[j].FindComponent(LCompName);
//
//        if Assigned(LComponent) then
//        begin
          LPanel := GetTpjhPanelOfCurrentPage(j);

          for i := 0 to LPanel.ComponentCount - 1 do
          begin
            if LPanel.Components[i].Name = LCompName then
            begin
              LPropertyName := TControl(LPanel.Components[i]).Hint;
//              LPropertyName := TControl(LComponent).Hint;

              if LPropertyName <> '' then
              begin
                SetValue3(TObject(LPanel.Components[i]), LData, LPropertyName);
//                SetValue3(TObject(LComponent), LData, LPropertyName);
                break;
              end;
            end;
          end;//for i
//        end;
      end;//for j
    end;//for k

  finally
    LTargetList.Free;
  end;
end;

procedure TWatchF2.SetCompDataFromTransBtn(ARecToPass: TRecToPass);
var
  LData, LCompName, LPropertyName: string;
  LBtnActionKind: integer;
begin
  LBtnActionKind := ARecToPass.iHandle;

  if LBtnActionKind = Ord(tbakSendText) then
  begin
    SetCompData2Text(ARecToPass);
  end;
//  else
//  if LBtnActionKind = Ord(tbakLoadDFMFromFile) then
//  begin
//    SetCompDate2LoadDfmFile(ARecToPass);
//  end;
end;

procedure TWatchF2.SetCompDate2LoadDfmFile(APageIndex: integer);
var
  LDFMFileName: string;
begin
  LDFMFileName := FWG.FCurrentWatchListFileName + HiMECS_DesignFormSuffix + IntToStr(APageIndex); //DFM File Name

  if FileExists(LDFMFileName) then
  begin

  end;
end;

procedure TWatchF2.SetComponentConnectMode1Click(Sender: TObject);
{**ConnectMode 사용 방법
1) Popup Menu에서 Set Connect Mode 선택
2) 다이얼로그 선택(Yse/No) - 아래 소스의 Comment 참조
   - 메인 라인 Multi 선택시에는 3가지 Option 모두 Yes
   - 분기 라인 Multi 선택시에는 두번째 만 Yes(FIsCreateJson4ClearNextStep)
   - 메인 라인 선택 후 분기 라인 선택 시 Set Connect Mode를 해제 후 다시 선택 해야 함
   - 메인 라인 선택 했을 때의 FSimulateCompValuesJson4ConnectNextStep 내용 과
     분기 라인 선택 했을 때의 FSimulateCompValuesJson4ConnectNextStep 내용을 비교하여(Delphi이 Compare를 이용함)
     분기 라인 마지막에 선택 된 Control의 NextStep을 NextStep2로 옮기고
     상기 Control의 메인 라인 선택 시의 NextStep을 복사해 주어야 함
     (NextStep이 분기 라인 마지막 Control의 NextStep으로 Overwrite 되기 때문임)
3) Popup Menu에서 Set Connect Mode 해제
4) Popup Menu에서 Merge CommandJson with Connect NextStep 클릭
   -  FSimulateCompValuesJson4ConnectNextStep 내용을 FSimulateCompValuesJson에 병합함
5) Popup Menu에서 Set Property Value Mode 선택
6) 각 Component Property 변경(OI 사용)
7) Popup Menu에서 Set Property Value Mode 해제
8) Popup Menu에서 Move pjhValue To Item and Save To DB 클릭
   - FSimulateCompValuesJson을 SimulateDB에 저장
}
var
  LStr, LxStepName: string;
  LPFI: IpjhPipeFlowInterface;
begin
  if (FCreateTagItemMode) and (not FComponentConnectMode) then
  begin
    FCreateTagItemMode := False;
    SetCreateItem4Selected1.Checked := False;
  end;

  FComponentConnectMode := not FComponentConnectMode;
  SetComponentConnectMode1.Checked := FComponentConnectMode;

  if FComponentConnectMode then
  begin
    Caption := Caption + '(NextStep Connect Mode)';

    //Make Command Json시에 필요홤, 역방향으로 NextStep 설정시 기존 NextStep과 충돌 가능성 있기 때문임
    if MessageDlg('Clear NextStep value for all Components?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      ClearAllNextStepProperty;

<<<<<<< HEAD
    FIsCreateJson4ClearNextStep := MessageDlg('Create Json for Clear NextStep to selected before setting nextstep?',mtConfirmation, [mbYes, mbNo], 0) = mrYes;
=======
    //선택된 Control의 xStep을 nil로 Setting 하는 Json을 생성함
    FIsCreateJson4ClearNextStep := MessageDlg('Create json 4 Clear NextStep to selected before setting nextstep?',mtConfirmation, [mbYes, mbNo], 0) = mrYes;

    //마지막에 선택된 Control의 xStep을 nil로 Setting 하는 Json을 생성함(메인라인 선택 시에는 yes, 분기 라인 선택시에는 No)
    FIsCreateJson4ClearLastSelectedControl := MessageDlg('Create json 4 Clear NextStep of last selected control?',mtConfirmation, [mbYes, mbNo], 0) = mrYes;
>>>>>>> a88235ae635a7fc9450e996babb20997451f7403
  end
  else
  begin
    if FIsCreateJson4ClearLastSelectedControl then
    begin
      if Assigned(FLastSelectedControlWhenMultiConnect) then
      begin
        if Supports(FLastSelectedControlWhenMultiConnect, IpjhPipeFlowInterface, LPFI) then
        begin
          //XStep 필드 이름 list를 comma로 구분하여 반환함
          LStr := LPFI.GetXStepNameListWithComma;

          while LStr <> '' do
          begin
            LxStepName := GetTokenWithComma(LStr);
            AddCompValue2Json(FLastSelectedControlWhenMultiConnect.Name, LxStepName, '', 7, FSimulateCompValuesJson4ConnectNextStep);
          end;
        end;
      end;
    end;

    FIsCreateJson4ClearNextStep := False;
    FIsCreateJson4ClearLastSelectedControl := False;
    FLastSelectedControlWhenMultiConnect := nil;
    LStr := Caption;
    Caption := strToken(LStr,'(');
  end;

  CreateNActivatepjhSelector();
end;

procedure TWatchF2.SetComponentValueMode1Click(Sender: TObject);
var
  LStr: string;
begin
  FSimulatePropertyValueMode := not FSimulatePropertyValueMode;
  SetComponentValueMode1.Checked := FSimulatePropertyValueMode;

  if FSimulatePropertyValueMode then
  begin
    Caption := Caption + '(Make Command Json Mode)';

    if MessageDlg('Init Json Component Value?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      InitJsonCompValue4Simulate;
  end
  else
  begin
    LStr := Caption;
    Caption := strToken(LStr,'(');
  end;
end;

procedure TWatchF2.SetCompValueFromOI(ARecToPass: TRecToPass2);
begin
//  {Components: [
//    {"CompName": "xxx",
//     "Properties": [
//        {"PropName": "yyy1", "PropTyprKind": 1, "Value": zzz},
//        {"PropName": "yyy2", "PropTyprKind": 1, "Value": zzz}
//        ...
//     ]
//    }
//    ...
//  ]
//  }
  AddJsonCompValue4Simulate(ARecToPass, FSimulateCompValuesJson);
//  ShowMessage(String(ARecToPass.CompName)+':'+String(ARecToPass.PropName)+':'+String(ARecToPass.Value));
end;

procedure TWatchF2.SetConfigData;
var
  EngMonitorConfigF: TWatchConfigF;
begin
  EngMonitorConfigF := TWatchConfigF.Create(Application);
  with EngMonitorConfigF do
  begin
    try
      LoadConfigDataVar2Form(EngMonitorConfigF);
      if ShowModal = mrOK then
      begin
        SaveConfigDataForm2Xml(EngMonitorConfigF);
        LoadConfigDataXml2Var;
        //FExhTempAvg_A.Size := FConfigOption.AverageSize;
        ApplyAvgSize;
        ApplyOption;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TWatchF2.SetCreateItem4Selected1Click(Sender: TObject);
begin
  if (FComponentConnectMode) and (not FCreateTagItemMode) then
  begin
    FComponentConnectMode := False;
    SetComponentConnectMode1.Checked := False;
  end;

  FCreateTagItemMode := not FCreateTagItemMode;
  SetCreateItem4Selected1.Checked := FCreateTagItemMode;

  CreateNActivatepjhSelector();
end;

procedure TWatchF2.SetCreateItem4SelectedComponent(aControl: TControl;
  Job: TControlJob);
var
  LControl: TWinControl;
  IpjhDI: IpjhDesignCompInterface;
begin
  if Assigned(aControl) and  (aControl.InheritsFrom(TWinControl)) then
    LControl := aControl as TWinControl
  else
    exit;

  if Assigned(LControl) then
  begin
    if Supports(LControl, IpjhDesignCompInterface, IpjhDI) then
    begin
      if Job = cjInserted then
      begin
        if FpjhSelector.HandlingControlList.Count = 1 then
        begin
          CreateItem4SelectedComponent(IpjhDI);
//          Caption := 'Source : ' + LControl.Name;
        end
      end
      else
      if Job = cjRemoved then
      begin

      end;
    end;
  end;
end;

procedure TWatchF2.SetDestinationConnect(aControl: TControl);
var
  LControl: TComponent;
  LPFI: IpjhPipeFlowInterface;
  LStr: string;
begin
//  LControl := FindVCLWindow(Mouse.CursorPos) as TComponent;
  LControl := aControl;

  if Assigned(LControl) then
  begin
    if Assigned(FSrcComponent4NextStep) then
    begin
      if Supports(FSrcComponent4NextStep, IpjhPipeFlowInterface, LPFI) then
      begin
        if LPFI.SetNextStepAuto(LControl) then
        begin
//          LStr := 'Component[' + FSrcComponent4NextStep.Name +
//            ']''s NextStep is set to ' + LControl.Name;
          Caption := Caption + '  ==>   ' + LControl.Name;
//          ShowMessage(LStr);
        end
        else
//          ShowMessage('There is no empty NextStep!');
      end;
    end;
  end;
end;

procedure TWatchF2.SetMatrix;
var
  LSetMatrixForm: TSetMatrixForm;
  i,j: integer;
  LStr: string;
begin
  i := FWG.NextGrid1.SelectedRow;

  if not (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].ParameterType in TMatrixTypes) then
  begin
    ShowMessage('ParameterType should be one of Matrix types!');
    exit;
  end;

  LSetMatrixForm := TSetMatrixForm.Create(Self);
  try
    LSetMatrixForm.FParamItemIndex := i;
    LSetMatrixForm.FEngineParameter.Assign(IPCMonitorAll1.FEngineParameter);
    LSetMatrixForm.MoveParameter2Grid;
    LSetMatrixForm.SetDisplay;
    LSetMatrixForm.ShowModal;
  finally
    j := IPCMonitorAll1.FEngineParameter.ComparePublicMatrix(LSetMatrixForm.FEngineParameter);

    if j <> 0 then
    begin
      LStr := 'Parameter data is modified. Do you want to accept?'+#13#10#13#10+
          'Yes: Adapt to current parameter on memory, No: discard changed.';
      if MessageDlg(LStr, mtConfirmation, [mbYes, mbNo], 0)= mrYes then
      begin
        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Clear;
        IPCMonitorAll1.FEngineParameter.MatrixCollect.Clear;
        IPCMonitorAll1.FEngineParameter.Assign(LSetMatrixForm.FEngineParameter);
      end;
    end;

    FreeAndNil(LSetMatrixForm);
  end;
end;

procedure TWatchF2.SetMultiSelectConnect(aControl: TControl; Job: TControlJob);
var
  LSelectedControl, LSrcControl: TWinControl;
  LPFI, LPFI2: IpjhPipeFlowInterface;
  LStr, LxStepName: string;
begin
//  LControl := FindVCLWindow(Mouse.CursorPos);
  if Assigned(aControl) and  (aControl.InheritsFrom(TWinControl)) then
    LSelectedControl := aControl as TWinControl
  else
    exit;

  if Assigned(LSelectedControl) then
  begin
    if Supports(LSelectedControl, IpjhPipeFlowInterface, LPFI) then
    begin
      //기 선택된게 없으면 추가
//      if FpjhSelector.HandlingControlList.IndexOf(LControl) = -1 then
//      begin
//        if FpjhSelector.HandlingControlList.InsertControl(LControl) then
//        begin
      LStr := '';

      if Job = cjInserted then
      begin
        LSrcControl := FSrcComponent4NextStep;

        if FpjhSelector.HandlingControlList.Count = 1 then
        begin
          FSrcComponent4NextStep := LSelectedControl;
          Caption := 'Source : ' + LSelectedControl.Name;
        end
        else
        if FpjhSelector.HandlingControlList.Count > 1 then
        begin
          if Supports(FSrcComponent4NextStep, IpjhPipeFlowInterface, LPFI2) then
          begin
            if LPFI2.SetNextStepAuto(LSelectedControl) then
            begin
              FSrcComponent4NextStep := LSelectedControl;
              //XStep 필드 이름 list를 comma로 구분하여 반환함
              LStr := LPFI2.GetXStepNameListWithComma;
              Caption := Caption + ' ==> ' + LSelectedControl.Name;
            end
            else
              ShowMessage(LSelectedControl.Name + ' is conflicted!!');
          end;
        end;

        //FSimulateCompValuesJson4ConnectNextStep에 nil을 할당하는 Json을 추가함
        if FIsCreateJson4ClearNextStep then
        begin
<<<<<<< HEAD
=======
          //FComponentConnectMode = False가 될때 마지막 선택된 Component의 xStep을 nil로 할당하는 Json을 생성하는데 사용함
          FLastSelectedControlWhenMultiConnect := LSelectedControl;
//          FXStepNameListWithComma := LStr;

>>>>>>> a88235ae635a7fc9450e996babb20997451f7403
          while LStr <> '' do
          begin
            LxStepName := GetTokenWithComma(LStr);
            AddCompValue2Json(LSrcControl.Name, LxStepName, '', 7, FSimulateCompValuesJson4ConnectNextStep);
          end;
        end;

        if Assigned(LSrcControl) then
          //FSimulateCompValuesJson4ConnectNextStep에 추가함
          AddCompValue2Json(LSrcControl.Name, 'NextStep', LSelectedControl.Name, 7, FSimulateCompValuesJson4ConnectNextStep);
      end
      else
      if Job = cjRemoved then
      begin
//        FpjhSelector.HandlingControlList.RemoveControl(LControl);
        DeleteNextRef(LSelectedControl);
      end;
//        end;
//      end
//      else//기 선택된게 있으면 삭제
//      begin
//      end;
    end;
  end;
end;

procedure TWatchF2.SetpjhBtnActionKind4TransparentBtn(
  AActionKind: TJvTransBtnActionKind; AOnlyCurrentPage: Boolean; APageIndex: integer);
var
  IpjhIntf: IpjhTransparentBtnIntf;
  LValue: string;
  LpjhPanel: TpjhPanel;
  LControl: TControl;
  Lidx: integer;

  procedure _SetpjhBtnActionKind;
  var
    i: integer;
  begin
    if not Assigned(LpjhPanel) then
        exit;

    with LpjhPanel do
    begin
      for i := 0 to ComponentCount - 1 do
      begin
        LControl := Components[i] as TControl;

        if Supports(LControl, IpjhTransparentBtnIntf, IpjhIntf) then
          IpjhIntf.ChangepjhBtnActionKind(AActionKind);
      end;//for
    end;//with

  end;

begin
  if AOnlyCurrentPage then
  begin
    LpjhPanel := GetPjhPanelFromIndex(APageIndex);
    _SetpjhBtnActionKind();
  end
  else
  begin
    for Lidx := DYNAMIC_PAGE_INDEX to PageControl1.AdvPageCount - 1 do
    begin
      LpjhPanel := TpjhPanel(GetDesignControl(PageControl1.AdvPages[Lidx]));
      _SetpjhBtnActionKind();
    end;
  end;
end;

procedure TWatchF2.SetRevDestinationConnect(aControl: TControl);
var
  LControl: TComponent;
  LPFI: IpjhPipeRevFlowInterface;
  LStr: string;
begin
  LControl := aControl;

  if Assigned(LControl) then
  begin
    if Assigned(FSrcComponent4NextStep) then
    begin
      if Supports(FSrcComponent4NextStep, IpjhPipeRevFlowInterface, LPFI) then
      begin
        if LPFI.SetRevNextStepAuto(LControl) then
        begin
          Caption := Caption + '  ==>   ' + LControl.Name;
        end;
      end;
    end;
  end;
end;

procedure TWatchF2.SetRevMultiSelectConnect(aControl: TControl;
  Job: TControlJob);
begin

end;

procedure TWatchF2.SetRevSrcCheckComp(aControl: TControl);
var
  LControl: TComponent;
  LPFI: IpjhPipeRevFlowInterface;
  LStr: string;
begin
  LControl := aControl;

  if Assigned(LControl) then
  begin
    if Assigned(FSrcComponent4NextStep) then
    begin
      if Supports(FSrcComponent4NextStep, IpjhPipeRevFlowInterface, LPFI) then
      begin
        if LPFI.SetRevPrevStep4Source(LControl) then
        begin
          Caption := Caption + '  ==>   ' + LControl.Name;
        end;
      end;
    end;
  end;
end;

procedure TWatchF2.SetRevSourceComponent(aControl: TControl);
var
  LControl: TWinControl;
  LPFI: IpjhPipeFlowInterface;
  LStr: string;
begin
  LControl := aControl as TWinControl;

  if Assigned(LControl) then
  begin
    if Supports(LControl, IpjhPipeFlowInterface, LPFI) then
    begin
      FSrcComponent4NextStep := LControl;
      LStr := 'RevSource = ' + LControl.Name;
      Caption := LStr;
    end
    else
      FSrcComponent4NextStep := Nil;
  end;
end;

procedure TWatchF2.SetSimulateParamDBName;
begin
  JvOpenDialog1.Filter := '';

  if JvOpenDialog1.Execute then
  begin
    FSimulateParamDBName := JvOpenDialog1.FileName;
  end;
end;

procedure TWatchF2.SetSimulateParamDBName1Click(Sender: TObject);
begin
  SetSimulateParamDBName;
end;

procedure TWatchF2.SetSourceComponent(aControl: TControl);
var
  LControl: TWinControl;
  LPFI: IpjhPipeFlowInterface;
  LStr: string;
begin
//이전 함수에서 아래 검사 실행 함
//  if FComponentConnectMode then
//  begin
//  LControl := FindVCLWindow(Mouse.CursorPos);
  LControl := aControl as TWinControl;

  if Assigned(LControl) then
  begin
    if Supports(LControl, IpjhPipeFlowInterface, LPFI) then
    begin
      FSrcComponent4NextStep := LControl;
      LStr := 'Source = ' + LControl.Name;
//        'Component[' + LControl.ClassName + '] is selected.' +#13#10 +
//        'Please select Next Step Component!';
      Caption := LStr;
//      ShowMessage(LStr);
    end
    else
      FSrcComponent4NextStep := Nil;
  end;
//  end;
end;

procedure TWatchF2.SetTagInfo2ComponentUsingMouse(APoint: TPoint);
var
  LControl: TComponent;
  IpjhDI: IpjhDesignCompInterface;
  LPanel: TpjhPanel;
  LStr: string;
begin
//  LControl := FindVCLWindow(Mouse.CursorPos) as TComponent;
  if not Assigned(FpjhSelector) then
    FpjhSelector := CreatepjhSelector();

  LPanel := GetTpjhPanelOfCurrentPage();
  LControl := FpjhSelector.DetermineControlAtPos(LPanel, APoint);//Mouse.CursorPos);

  if Assigned(LControl) then
  begin
    if Supports(LControl, IpjhDesignCompInterface, IpjhDI) then
    begin
      if IpjhDI.pjhTagInfo.TagName <> FEEPTarget4Tag.EPD.FEPItem.FTagName then
      begin
        //Items Page에 Drop한 Paramter가 없으면 추가
        FWG.ProcessItemsDrop();

        IpjhDI.pjhTagInfo.TagName := FEEPTarget4Tag.EPD.FEPItem.FTagName;
        IpjhDI.pjhTagInfo.ParamIndex := FWG.GetItemIndexFromGrid(FEEPTarget4Tag.EPD.FEPItem.FTagName);
        IpjhDI.pjhTagInfo.Description := FEEPTarget4Tag.EPD.FEPItem.FDescription;

        LStr := LControl.Name + ' : ' + #13#10;
        LStr := LStr + 'TagName = ' + IpjhDI.pjhTagInfo.TagName + #13#10;
        LStr := LStr + 'ParamIndex = ' + IntToStr(IpjhDI.pjhTagInfo.ParamIndex) + #13#10;
        LStr := LStr + 'Description = ' + IpjhDI.pjhTagInfo.Description;
        ShowMessage(LStr);
      end;
    end;
  end;
end;

procedure TWatchF2.SetWatchFormState2Param(AParam: TEngineParameter);
begin
  AParam.FormWidth := Width;
  AParam.FormHeight := Height;
  AParam.FormTop := Top;
  AParam.FormLeft := Left;
  AParam.FormState := TpjhWindowState(WindowState);
  AParam.SaveWatchForm := SaveListCB.Checked;
  AParam.StayOnTop := StayOnTopCB.Checked;
  AParam.UseAlphaBlend := EnableAlphaCB.Checked;
  AParam.AlphaValue := JvTrackBar1.Position;
  AParam.TabShow := PageControl1.TabSettings.Height > 0;
  AParam.BorderShow := BorderStyle <> bsNone;
end;

procedure TWatchF2.SetWatchListFileName(AFileName: string);
begin
  FWatchListFileName := AFileName;
  FConfigOption.WatchListFileName := FWatchListFileName;
end;

procedure TWatchF2.ShowcurrentDFMFileName1Click(Sender: TObject);
begin
  ShowMessage(PageControl1.ActivePage.Hint);
end;

procedure TWatchF2.ShowDFMFileName1Click(Sender: TObject);
begin
  ShowMessage(PageControl1.ActivePage.Hint + '( ' + IntToStr(PageControl1.ActivePage.PageIndex) + ' )');
end;

procedure TWatchF2.ShowEngineName1Click(Sender: TObject);
begin
  ShowMessage(IPCMonitorAll1.GetEventData_PLCMODBUS_ListName);
end;

procedure TWatchF2.ShowEventName1Click(Sender: TObject);
begin
  ShowMessage(FWG.FEventName4Item);
end;

procedure TWatchF2.ShowGridRowIndex1Click(Sender: TObject);
begin
  ShowHideGridRowIndex;
end;

procedure TWatchF2.ShowHideGridRowIndex(AShowIndex: Boolean);
var
  i: integer;
  LColumn: TNxCustomColumn;
  LExistIndex: Boolean;
begin
  i := FWG.NextGrid1.Columns.Count;

  LExistIndex := FWG.NextGrid1.Columns.Item[i-1].Name = 'ParamIndex';

  if AShowIndex then
  begin
    if LExistIndex then
      exit
    else
    begin
      LColumn := FWG.NextGrid1.Columns.Add(TNxIncrementColumn, 'Index');
      LColumn.Name := 'ParamIndex';
    end;
  end
  else
  begin

  end;
end;

procedure TWatchF2.ShowMQName1Click(Sender: TObject);
var
  LStr: string;
  i: integer;
begin
  LStr := 'MQ Server IP : ' + FConfigOption.MQServerIP + #13#10 +
    'MQ Server Port : ' + FConfigOption.MQServerPort + #13#10 +
    'MQ User : ' + FConfigOption.MQServerUserId + #13#10 +
    'MQ Queue Name : ';

  for i := 0 to FConfigOption.MQServerTopicCollect.Count - 1 do
    LStr := LStr + FConfigOption.MQServerTopicCollect.Items[i].TopicName + #13#10;

  ShowMessage(LStr);
end;

procedure TWatchF2.ShowMultiStateValues1Click(Sender: TObject);
begin
  if FWG.NextGrid1.SelectedRow = -1 then
    ShowMessage('Please select the MultiState Item!')
  else
    ShowMessage(IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[FWG.NextGrid1.SelectedRow].MultiStateValues);
end;

procedure TWatchF2.ShowNodeIndex1Click(Sender: TObject);
begin
 ShowMessage(IntToStr(IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[FWG.NextGrid1.SelectedRow].NodeIndex));
end;

function TWatchF2.ShowpjhTagUnAssignedList: TStringList;
var
  LPanel: TpjhPanel;
  IpjhDI: IpjhDesignCompInterface;
  LStr: string;
  j, LCount: integer;

  function CheckTagName(AClassNme: string): Boolean;
  var
    LStr2: string;
  begin
    LStr2 := UpperCase(AClassNme);

    Result := Pos('VALVE', LStr2) > 0;

    if not Result then
      Result := Pos('MOTOR', LStr2) > 0
    else
      exit;

    if not Result then
      Result := Pos('TANK', LStr2) > 0;
  end;
begin
  LCount := 0;
  Result := TStringList.Create;
  LPanel := GetTpjhPanelOfCurrentPage;

  for j := 0 to LPanel.ComponentCount - 1 do
  begin
    if Supports(LPanel.Components[j], IpjhDesignCompInterface, IpjhDI) then
    begin
      if IpjhDI.pjhTagInfo.TagName =  '' then
      begin
        if CheckTagName(LPanel.Components[j].ClassName) then
        begin
          Inc(LCount);
          LStr := '(' + IntToStr(LCount) + ') Name : ' + LPanel.Components[j].Name;
          LStr := LStr + ', Class : ' + LPanel.Components[j].ClassName;
          Result.Add(LStr);
        end;
      end;
    end;
  end;//for
end;

procedure TWatchF2.ShowScrollBar1Click(Sender: TObject);
begin
  ShowMessage(FFilePath);
//  ShowMessage(IntToStr(GetBitVal(256,0)));
end;

procedure TWatchF2.ShowTagName1Click(Sender: TObject);
begin
  FWG.ShowTagNameColumn;
end;

procedure TWatchF2.ShowUnAssignedList1Click(Sender: TObject);
var
  LStrList: TStringList;
begin
  try
    LStrList := ShowpjhTagUnAssignedList;
    ShowMessage(LStrList.Text);
  finally
    LStrList.Free;
  end;
end;

procedure TWatchF2.ShowWindowsHandle1Click(Sender: TObject);
begin
  ShowMessage(IntToStr(Handle));
end;

procedure TWatchF2.StayOnTopCBClick(Sender: TObject);
begin
  if StayOnTopCB.Checked then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;

procedure DoublePointIO(obj: TObject; stream: TObjStream;
  direction: TObjIODirection; version: Integer; var callSuper: Boolean);
begin
  with obj as TDoublePoint do
    stream.TransferItemsEx([x,y], [@x,@y],[ssvtDateTime,ssvtDouble], direction, version);
    //stream.transferItems([x,y], [@x,@y], direction, version);
    //stream.TransferBlocks([FBitmapData], [FBitmapSize], direction);
  //callSuper := False;
end;

procedure TWatchF2.TagRBClick(Sender: TObject);
begin
  DescRB.Checked := TagRB.Checked;
end;

procedure TWatchF2.Timer1Timer(Sender: TObject);
var
  i,j: integer;
begin
  Timer1.Enabled := False;
  try
    if FMonitorStart then
    begin
      DisplayMessage('');
    end;

    if FBlinkEnable then
    begin
      if FBlinkOn then
        ChangeDispPanelColor(TColor(FCurrentChangeColor))
      else
        ChangeDispPanelColor(clBlack);
    end;

    if FFirst then
    begin
      FFirst := False;
      UserLevel2Strings(AllowUserlevelCB.Items);
      FWG.NextGrid1.PopupMenu := WatchListPopup;

      AdjustComponentByUserLevel;

      if FConfigOption.AliveSendInterval = 0 then
        Timer1.Interval := 10000
      else
        Timer1.Interval := FConfigOption.AliveSendInterval;

      ///======================================================================
      //LStr := Format('%s (%X)', [Application.Title, GetCurrentProcessID]);
      //Label4.Caption := IntToStr(GetCurrentProcessID);
      try
//        IPCClient_HiMECS_MDI := TIPCClient_HiMECS_MDI.Create(Handle, Self.Caption);
        //IPCClient_HiMECS_MDI := TIPCClient_HiMECS_MDI.Create(GetCurrentProcessID, LStr);
        //IPCClient_HiMECS_MDI.OnConnect := OnConnect;
        //IPCClient_HiMECS_MDI.OnSignal := OnSignal;
//        IPCClient_HiMECS_MDI.Activate;

//        if IPCClient_HiMECS_MDI.State <> stConnected then
//          OnConnect(nil, False);
      except
//        Application.HandleException(ExceptObject);
//        Application.Terminate;
      end;
    end;

    //SendAliveOk;
  finally
    FMonitorStart := True;
    Timer1.Enabled := True;
  end;//try

end;

procedure TWatchF2.ToggleTabShow;
begin
  if PageControl1.TabSettings.Height = 0 then
    PageControl1.TabSettings.Height := 26
  else
    PageControl1.TabSettings.Height := 0;
end;

procedure TWatchF2.FillInParamNItemGridFromVariantOfSimData(ADoc: variant);
var
  LDynUtf8, LCSVDynUtf8: TRawUTF8DynArray;
  LDynArr, LCSVDynArr: TDynArray;
  LUtf8, LCSVUtf8: RawUTF8;
  LDoc: variant;
  i, j: integer;
  LTagName, LSrcName: string;
  LGpIntegerList: TGpIntegerList;
begin
  with FWG.NextGrid1 do
  begin
    BeginUpdate;
    LGpIntegerList := TGpIntegerList.Create;
    try
      LUtf8 := ADoc.JsonParamCollect;//'[{"TagName":"aaaa", "Desc":"Desc1"},{"TagName":"bbbb", "Desc":"Desc2"}]';
      LDynArr.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8);
      LDynArr.LoadFromJSON(PUTF8Char(LUtf8));
      LSrcName := ADoc.ParamSourceList;
      LSrcName := GetTokenWithComma(LSrcName);

      for i := 0 to LDynArr.Count - 1 do
      begin
//        AddRow();
        LDoc := _JSON(LDynUtf8[i]);
        LTagName := LDoc.TagName;

        j := IPCMonitorAll1.CheckExistTagName(String2ParameterSource(LSrcName), LTagName);
//        j := FWG.CheckExistTagNameInGrid(LTagName);

        if j = -1 then
          continue;

        if LGpIntegerList.IndexOf(j) = -1 then
          LGpIntegerList.Add(j);
      end;

      LCSVUtf8 := ADoc.CSVValues;
      LCSVDynArr.Init(TypeInfo(TRawUTF8DynArray), LCSVDynUtf8);

      CSVToRawUTF8DynArray(PUTF8Char(LCSVUtf8),LCSVDynUtf8);

      for i := 0 to LGpIntegerList.Count - 1 do
      begin
        j := LGpIntegerList.Items[i];

        if j <= High(LCSVDynUtf8) then
        begin
          IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].Value := LCSVDynUtf8[j];
          CellsByName['Value', j] := LCSVDynUtf8[j];
        end;
      end;
    finally
      FWG.NextGrid1.EndUpdate();
      LGpIntegerList.Free;
    end;
  end;//with
end;

procedure TWatchF2.FillXYMapFromFile(AXYMap: DMultiMap; AList: TStringList;
  AIsDuplicated: Boolean; AStr: string);
//AStr: 'x축tagname;y축tagname'
var
  LStr2,LStr3,TagX,TagY: string;
  i,j,k,LColumnCount,X_Index,Y_Index: integer;
  tmpdouble, tmpdouble2: double;
  IsXFirst: boolean;
begin
  LColumnCount := strTokenCount(AList.Strings[0], ',');
  TagX := strToken(AStr,';'); //X축 Tag name
  TagY := strToken(AStr,';'); //Y축 Tag name
    
  for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayXY then
    begin
      LStr2 := AList.Strings[0];
      LStr3 := GetTokenWithComma(LStr2); //맨 앞 시간 제거
      for j := 1 to LColumnCount - 1 do
      begin
        LStr3 := GetTokenWithComma(LStr2);
        if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TagName = LStr3 then
        begin
          if LStr3 = TagX then
            X_Index := j
          else
            Y_Index := j;
          break;
        end;
      end;
    end;
  end;//for

  if X_Index <= Y_Index then  //X축 Index 숫자가 작으면 True
    IsXFirst := True
  else
    IsXFirst := False;
      
  for i := 1 to AList.Count - 1 do
  begin
    LStr2 := AList.Strings[i];
    LStr3 := GetTokenWithComma(LStr2);

    if IsXFirst then  //Index가 작은 것 부터 먼저 값을 가져옴
      LColumnCount := X_Index
    else
      LColumnCount := Y_Index;

    for k := 1 to LColumnCount do
      LStr3 := GetTokenWithComma(LStr2);
        
    if IsXFirst then
      tmpdouble := StrToFloatDef(LStr3,0.0) //x값
    else
      tmpdouble2 := StrToFloatDef(LStr3,0.0); //Y값
        
    if IsXFirst then
      LColumnCount := Y_Index - X_index
    else
      LColumnCount := X_Index - Y_Index;
          
    for k := 1 to LColumnCount do
      LStr3 := GetTokenWithComma(LStr2);
        
    if IsXFirst then
      tmpdouble2 := StrToFloatDef(LStr3,0.0)
    else
      tmpdouble := StrToFloatDef(LStr3,0.0);

    if AIsDuplicated then
      XYDataAdd2Map(AXYMap, tmpdouble, tmpdouble2, True)
    else
      ReplaceOrAddMap(AXYMap, tmpdouble, tmpdouble2, True);
  end;//for
end;

procedure TWatchF2.FindComponentByNameUsingBalloon(ACompName: string);
var
  LJson: TBalloonRecord;
  LpjhTPanelWithBalloon: TControl;
begin
  LpjhTPanelWithBalloon := GetBalloonCompFromCurPage();

  if Assigned(LpjhTPanelWithBalloon) then
  begin
    LJson := GetBalloonRecord2Json4FindComponent(ACompName);

    AddCompValue2Json(LpjhTPanelWithBalloon.Name, 'BalloonHeader', LJson.Header, 7, FSimulateCompValuesJson);
    AddCompValue2Json(LpjhTPanelWithBalloon.Name, 'BalloonText', LJson.Text, 7, FSimulateCompValuesJson);
    AddCompValue2Json(LpjhTPanelWithBalloon.Name, 'BalloonShowOnlyMine', 'True', 7, FSimulateCompValuesJson);
    AddCompValue2Json(LpjhTPanelWithBalloon.Name, 'BalloonFindCompName', LJson.CompName, 7, FSimulateCompValuesJson);
    AddCompValue2Json(LpjhTPanelWithBalloon.Name, 'BalloonX', IntToStr(LJson.X), 7, FSimulateCompValuesJson);
    AddCompValue2Json(LpjhTPanelWithBalloon.Name, 'BalloonY', IntToStr(LJson.Y), 7, FSimulateCompValuesJson);
    AddCompValue2Json(LpjhTPanelWithBalloon.Name, 'BalloonHideIfMouseMove', 'True', 7, FSimulateCompValuesJson);

    IPCMonitorAll1.FIsUseBalloon := True;
    MoveReceivedgpSHMMValue2ComponentValue(FSimulateCompValuesJson);
  end
  else
    ShowMessage('Can not found the balloon component.');
end;

procedure TWatchF2.FindComponentByNameUsingSelector(ACompName: string);
var
  LComp: TControl;
  LpjhPanel: TpjhPanel;
  LRect: TRect;
begin
  LComp := GetComponentByNameFrompjhPanel(ACompName);

  if Assigned(LComp) then
  begin
    if not Assigned(FpjhSelector) then
      FpjhSelector := CreatepjhSelector();

    try
      LpjhPanel := GetTpjhPanelOfCurrentPage;

      LRect := ClientToScreenRect(LpjhPanel, LRect);
      LRect := ScreenToClientRect(LComp, LRect);

      FpjhSelector.InsertControlsInRect(TWinControl(LComp), LRect);
      FpjhSelector.Activate(LpjhPanel);
    finally
      ShowMessage('Finding Success!');
      FpjhSelector.DeActivate;
    end;
  end;
end;

procedure TWatchF2.FindComponentByName1Click(Sender: TObject);
begin
  FindComponentByNameUsingBalloon;
end;

procedure TWatchF2.FindItemByTagName(const ATagName: string;
  AIgnoreCase: boolean);
var
  LIdx: integer;
begin
  if ATagName = '' then
    exit;

  LIdx := FWG.GetItemIndexFromFindNext(ATagName);

  if LIdx <> -1 then
  begin
    FWG.NextGrid1.ScrollToRow(LIdx);
    FWG.NextGrid1.ClearSelection;
    FWG.NextGrid1.Selected[LIdx] := True;
//    FWG.NextGrid1.Invalidate;
  end;
end;

procedure TWatchF2.FindItemsByTagname1Click(Sender: TObject);
begin
  FindItemsByTagname1.Checked := not FindItemsByTagname1.Checked;

  FindItemFlipPanel.Visible := FindItemsByTagname1.Checked;
  FindItemFlipPanel.Expanded := FindItemsByTagname1.Checked;
end;

procedure TWatchF2.FindNAddCompValueFromCommandJson(ARecToPass: TRecToPass2; var ADestJson: string);
var
  LCompName, LPropName, LValue: string;
begin
  LCompName := String(ARecToPass.CompName);
  LPropName :=  String(ARecToPass.PropName);
  LValue := String(ARecToPass.Value);

  AddCompValue2Json(LCompName, LPropName, LValue, ARecToPass.ValueType, ADestJson);
end;

function TWatchF2.FindNGetCompStringValueFromDesignForm(const ACompName,
  APropName: string): string;
var
  i: integer;
  LPanel: TpjhPanel;
  LValue: string;
begin
  Result := '';

  //Design Form이 존재할 경우
  if PageControl1.AdvPageCount > DYNAMIC_PAGE_INDEX then
  begin
    for i := DYNAMIC_PAGE_INDEX to PageControl1.AdvPageCount - 1 do
    begin
      LPanel := TpjhPanel(GetDesignControl(PageControl1.AdvPages[i]));

      LValue := FindNGetCompStringValue(LPanel, ACompName, APropName);

      if LValue <> '' then
      begin
        Result := LValue;
        Break;
      end;
    end;
  end;
end;

procedure TWatchF2.FindNSetCompValueFromDesignForm(const ACompName, APropName,
  AValue: string);
var
  i: integer;
  LPanel: TpjhPanel;
begin
  //Design Form이 존재할 경우
  if PageControl1.AdvPageCount > DYNAMIC_PAGE_INDEX then
  begin
    for i := DYNAMIC_PAGE_INDEX to PageControl1.AdvPageCount - 1 do
    begin
      LPanel := TpjhPanel(GetDesignControl(PageControl1.AdvPages[i]));

      if FindNSetCompValue(LPanel, ACompName, APropName, AValue) then
      begin
        Break;
      end;
    end;
  end;
end;

procedure TWatchF2.FindTagNameEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_Return: begin
      Button4Click(nil);
    end;
  end;
end;

procedure TWatchF2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  LUserLevel: THiMECSUserLevel;
  it: DIterator;
  LArray: DArray;
  i: integer;
  LDeleteFileList: TStringList;
begin
  if Assigned(FpjhSelector) then
    FpjhSelector.Free;

  FMonitorStart := False;
  Timer1.Enabled := False;
  SendMessage(FOwnerHandle, WM_WATCHFORM_CLOSE, FOwnerListIndex, 0);

  FCheckCircularNextStepList.Free;
  FCommandLine.Free;
  FEEPTarget4Tag.Free;
  FPJHTimerPool.RemoveAll;
  FPJHTimerPool.Free;


//  FreeAndNil(FgpSharedMM);
//
//  FGpSharedEventProducer.Free;
//  FGpSharedEventListener.Free;
//  FThreadRecvEvent.FStop := True;
//  FThreadRecvEvent.ReStart;

  IPCMonitorAll1.FinalgpSharedMemory4Listener;

  if FConfigOption.MonDataSource = 2 then //MonDataSource = By MQ
    DestroySTOMP;

  if SaveListCB.Checked then
  begin
    if MessageDlg('SaveList CheckBox is checked and ' + #13#10 +
        'File is already existed. ( ' + FConfigOption.WatchListFileName + ' )' + #13#10 +
        'Are you overwrite? if No press, then the data is not saved!',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      SaveWatchList(FConfigOption.WatchListFileName, False, FCommandLine.IsOnlyOneForm)
  end
  else
  begin
    if FConfigOption.WatchListFileName <> '' then
    begin
      if FileExists(WatchListPath+WatchListFileName) then
      begin
        //LUserLevel := IPCMonitorAll1.FCurrentUserLevel;
        //if IPCMonitorAll1.CheckUserLevelForWatchListFile(WatchListFilename, LUserLevel) then
        //begin
          //if MessageDlg('Do you want to delete the watch list file?',
          //                        mtConfirmation, [mbYes, mbNo], 0)= mrYes then
          //begin
          //  LDeleteFileList := TStringList.Create;
          //  try
          //    GetFiles(LDeleteFileList, WatchListPath+WatchListFileName);
          //    for i := 0 to LDeleteFileList.Count - 1 do
          //      DeleteFile(LDeleteFileList.Strings[i]);
          //  finally
          //    LDeleteFileList.Free;
          //  end;
          //end;
        //end;
      end;
    end;
  end;

  if FConfigOption.SubWatchClose then
    for i := Low(FWatchHandles) to High(FWatchHandles) do
      SendMessage(FWatchHandles[i], WM_CLOSE, 0, 0);

  FWatchHandles := nil;

  IPCAll_Final;

  FCriticalSection.Free;

  ObjFree(FAddressMap);
  FAddressMap.free;

  it := FTrendDataMap.start;
  while not atEnd(it) do
  begin
    LArray := GetObject(it) as DArray;
    ObjFree(LArray);
    advance(it);
    //LArray.Free;
  end;

  ObjFree(FTrendDataMap);
  FTrendDataMap.Free;

  it := FTrendDataMapFromFile.start;
  while not atEnd(it) do
  begin
    LArray := GetObject(it) as DArray;
    ObjFree(LArray);
    advance(it);
    //LArray.Free;
  end;

  ObjFree(FTrendDataMapFromFile);
  FTrendDataMapFromFile.Free;

  //Grid.Data의 StringList 해제
//  FreeStrListFromGrid;

  ObjFree(FXYDataMap);
  FXYDataMap.Free;


  FConfigOption.Free;
  FDesignFormConfig.Free;

  //IPCMonitorAll1.FEngineParameter.Free;

  FMsgList.Free;
  FWatchCA.Free;

  DestroyDynamicPanel;
  CloseDesignPanel1Click(nil);

  if Assigned(FPackageModules) then
  begin
    for i := Low(FPackageModules) to High(FPackageModules) do
      if FPackageModules[i] <> 0 then
        UnloadAddInPackage(TComponent(Self), HMODULE(FPackageModules[i]));
        //UnloadPackage(FPackageModules[i]);

    FPackageModules := nil;
  end;

  if Assigned(FPackageHandles) then
  begin
    for i := Low(FPackageHandles) to High(FPackageHandles) do
      if FPackageHandles[i] <> 0 then
        UnloadAddInPackage(TComponent(Self), HMODULE(FPackageHandles[i]));
        //UnloadPackage(FPackageModules[i]);
    FPackageHandles := nil;
  end;

  FCreateFuncFromBPL := nil;
  FBplFileList.Free;

//  IPCClient_HiMECS_MDI.Free;

//  FTaskPool.Finalize;
//  FTaskPool.Free;

  if FIsAutoFree then
    Action := caFree;
end;

//Trend에서 Channel Delete 시에 Channel Index를 재조정하는 함수
procedure TWatchF2.UpdateChannelIndex(AIndex: integer);
var
  i,j: integer;
begin
  for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendChannelIndex;
    if AIndex < j then
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendChannelIndex := j - 1;

    j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendAlarmIndex;
    if AIndex < j then
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendAlarmIndex := j - 1;

    j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendFaultIndex;
    if AIndex < j then
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendFaultIndex := j - 1;
  end;
end;

procedure TWatchF2.UpdateComponentValueFromCommandJson;
begin
  //공유메모리에 데이터를 전달한 주체가 내가 아닌 경우는 Result = -1
  //내가 보낸 데이터 이면 Result = 1
  if RecvSimulateParamDataFromgpShMM(FSimParamJsonData4Watch2) <> 1 then
    MoveReceivedgpSHMMValue2ComponentValue(FSimParamJsonData4Watch2);
end;

procedure TWatchF2.UpdateItemsDetailFromDB1Click(Sender: TObject);
begin
  UdateGridItemDetailFromFile();
end;

procedure TWatchF2.UpdateItemValueFromSimData;
begin
  //공유메모리에 데이터를 전달한 주체가 내가 아닌 경우는 Result = -1
  //내가 보낸 데이터 이면 Result = 1
  if RecvSimulateParamDataFromgpShMM(FSimParamJsonData4Watch2) <> 1 then
    MoveReceivedgpSHMMValue2ItemValueNCommandJson(FSimParamJsonData4Watch2);
end;

procedure TWatchF2.UpdateStatusBar(var Msg: TMessage);
const
  ConnectStr: Array[Boolean] of PChar = ('Not Connected', 'Connected');
begin
  JvStatusBar1.SimpleText := ConnectStr[Boolean(Msg.WParam)];
end;

procedure TWatchF2.UpdateTagNameFromDBBasedOnAddress1Click(Sender: TObject);
begin
  UdateTagNameOfGridItemFromFile();
end;

procedure TWatchF2.UpdateYAxisIndex(AIndex: integer);
var
  i,j: integer;
begin
  for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendYAxisIndex;
    if AIndex < j then
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendYAxisIndex := j - 1;
  end;
end;

procedure TWatchF2.Value2Screen_Analog_ECS_kumo(AName: string; AValue: Integer;
  AMaxVal: real);
var
  LisPress: boolean;
  LComponent, LComponent2: TComponent;
  Le: Single;
  LPos: integer;
  LStr: string;
begin
  FCriticalSection.Enter;

  try
    LisPress := False;
    LComponent2 := nil;

    LComponent := FindComponent(AName);
    if Assigned(LComponent) then
    begin
      Le := (AValue * AMaxVal) / 4095;

      if (AName = 'AI_ENGINERPM') then //Engine RPM
      begin
        with TPanel(LComponent) do
          Caption := IntToStr(Round(Le));

        with TiAngularGauge(FindComponent(AName+'_G')) do
          Position := Round(Le);

        with TPanel(FindComponent(AName+'_P')) do
          Caption := IntToStr(Round(Le));

      end
      else if (AName = 'AI_TC_A_RPM') or (AName = 'AI_TC_B_RPM') then
      begin
        with TPanel(LComponent) do
          Caption := IntToStr(Round(Le));

        with TiAngularGauge(FindComponent(AName+'_G')) do
          Position := Round(Le);

        with TPanel(FindComponent(AName+'_P')) do
          Caption := IntToStr(Round(Le));
      end
      else
      begin
        if System.Pos('AI_EXH_',AName) > 0 then
        begin
          LComponent2 := FindComponent(AName+'_L');
          if Assigned(LComponent2) then
            TiLedBar(LComponent2).Position := Round(Le);

          TPanel(LComponent).Caption := IntToStr(Round(Le));

          LPos := Pos('AI_EXH_A_',AName);
          if LPos > 0 then
          begin
            LStr := Copy(AName,LPos+9,Length(AName)-LPos-8);
            if StrToIntDef(LStr,FConfigOption.AverageSize+1) <= FConfigOption.AverageSize then
            begin //숫자가 아닌것은 FConfigOption.AverageSize 보다 1 크게
              //FExhTempAvg_A.Put(Le);
              //LComponent2 := FindComponent('AI_EXH_A_Avg');
              //if Assigned(LComponent2) then
              //  TPanel(LComponent2).Caption := IntToStr(Round(FExhTempAvg_A.Average));
                //TiSevenSegmentInteger(LComponent2).Value := Round(FExhTempAvg_A.Average);

              //LComponent2 := nil;
              //LComponent2 := FindComponent('AI_EXH_A_Avg_L');
              //if Assigned(LComponent2) then
              //  TiLedBar(LComponent2).Position := Round(FExhTempAvg_A.Average);
            end;
          end
          else
          begin
            LPos := Pos('AI_EXH_B',AName);
            if LPos > 0 then
            begin
              LStr := Copy(AName,LPos+9,Length(AName)-LPos-8);
              if StrToIntDef(LStr,FConfigOption.AverageSize+1) <= FConfigOption.AverageSize then
              begin //숫자가 아닌것은 FConfigOption.AverageSize 보다 1 크게
                //FExhTempAvg_B.Put(Le);
                //LComponent2 := FindComponent('AI_EXH_B_Avg');
                //if Assigned(LComponent2) then
                //  TPanel(LComponent2).Caption := IntToStr(Round(FExhTempAvg_B.Average));
                  //TiSevenSegmentInteger(LComponent2).Value := Round(FExhTempAvg_B.Average);

                //LComponent2 := nil;
                //LComponent2 := FindComponent('AI_EXH_B_Avg_L');
                //if Assigned(LComponent2) then
                // TiLedBar(LComponent2).Position := Round(FExhTempAvg_B.Average);
              end;
            end;
          end;
        end
        else
        begin
          //with TiAnalogDisplay(LComponent) do
          //begin
            //Value := Le;
            {if LisPress then
              Caption := format('%.2f', [AValue * AMaxVal])
            else
              Caption := format('%.f', [AValue * AMaxVal]);
            }
          //end;
        end;
      end;
    end;//if Assigned(LComponent)
  finally
    FCriticalSection.Leave;
  end;
end;

procedure TWatchF2.Value2Screen_Digital_ECS(Name: string; AValue: Integer;
  AMaxVal: real; AContact: integer);
begin

end;

procedure TWatchF2.Value2Screen_ECS_AVAT(AHiMap: THiMap; AEPIndex: integer; AModbusMode: integer);
var
  Le: Single;
  LIsFloat: boolean;
  LStr: string;
begin
  if AHiMap.FAlarm then //Analog data
  begin
    if AModbusMode = 3 then
      Le := AHiMap.FValue
    else
      Le := AHiMap.FValue * AHiMap.FMaxval;

    LIsFloat := IsFloat(Le);

    if LIsFloat then
    begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].RadixPosition > 1 then
        LStr := IntToStr(IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].RadixPosition)
      else
        LStr := '1';

      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].Value := format('%.'+LStr+'f',[Le]);
    end
    else
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].Value := IntToStr(Round(Le));

    WatchValue2Screen_Analog(AHiMap.FName, FWatchValue, AEPIndex);
  end
  else //Digital data
  begin

  end;
end;

//AModbusMode = 3 Rtu mode simulate
procedure TWatchF2.Value2Screen_ECS_kumo(AHiMap: THiMap; AEPIndex: integer; AModbusMode: integer);
var
  Le: Single;
begin
  if AHiMap.FAlarm then //Analog data
  begin
    if AModbusMode = 3 then
      Le := AHiMap.FValue
    else
      Le := (AHiMap.FValue * AHiMap.FMaxval) / 4095;

    if (AHiMap.FName = 'AI_ENGINERPM') then //Engine RPM
    begin
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].Value := IntToStr(Round(Le));
    end
    else if (AHiMap.FName = 'AI_TC_A_RPM') or (AHiMap.FName = 'AI_TC_B_RPM') then
    begin
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].Value := IntToStr(Round(Le));
    end
    else
    begin
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].Value := IntToStr(Round(Le));
    end;

    WatchValue2Screen_Analog(AHiMap.FName, FWatchValue, AEPIndex);
  end
  else //Digital data
  begin

  end;
end;

procedure TWatchF2.ValueButtonClick(Sender: TObject);
begin
  SetMatrix;
end;

procedure TWatchF2.DataSave1Click(Sender: TObject);
var
  i,j,LHandle: integer;
  LProcessId: THandle;
begin
  if FWG.NextGrid1.SelectedCount > 0 then
  begin
    SetCurrentDir(FFilePath);
    LProcessId := ExecNewProcess2(IncludeTrailingPathDelimiter(FFilePath)+HiMECSWatchSaveName);
    LHandle := DSiGetProcessWindow(LProcessId);
    SetLength(FWatchHandles, Length(FWatchHandles)+1);
    FWatchHandles[High(FWatchHandles)] := LHandle;

    for i := 0 to FWG.NextGrid1.RowCount - 1 do
    begin
      if FWG.NextGrid1.Row[i].Selected then
      begin
        IPCMonitorAll1.MoveEngineParameterItemRecord2(FWG.FEngineParameterItemRecord,i);
        FWG.FPM.SendEPCopyData(Handle, LHandle,FWG.FEngineParameterItemRecord);
        //exit;
      end;
    end;
  end;
end;

procedure TWatchF2.DB1Click(Sender: TObject);
begin
  MakeModbusCommandFromGrid(oftSqlite);
end;

procedure TWatchF2.DeleteAlarmValueFromTrend1Click(Sender: TObject);
var
  i,j: integer;
begin
  for i := 0 to FWG.NextGrid1.RowCount - 1 do
  begin
    if FWG.NextGrid1.Row[i].Selected then
    begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendAlarm then
      begin
        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendAlarm := false;
        j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendAlarmIndex;
        iPlot1.DeleteChannel(j);
        UpdateChannelIndex(j);
      end;
    end;
  end;
end;

procedure TWatchF2.DeleteAllTrend;
var
  i,j: integer;
begin
  for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrend := False;
    IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendAlarm := False;
    IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendFault := False;
    FWG.NextGrid1.CellByName['TrendDisplay', i].AsInteger := -1;
  end;

  iPlot1.RemoveAllYAxes;
  iPlot1.RemoveAllChannels;
end;

procedure TWatchF2.DeleteEngineParamterFromGrid(AIndex: integer);
begin
  FWG.FreeStrListFromGrid(AIndex);
  DeleteFromTrend1Click(nil);
  DeleteItem2pjhTagInfo(AIndex);
  FWG.NextGrid1.DeleteRow(AIndex);
  IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Delete(AIndex);
end;

procedure TWatchF2.DeleteFaultValueFromTrend1Click(Sender: TObject);
var
  i,j: integer;
begin
  for i := 0 to FWG.NextGrid1.RowCount - 1 do
  begin
    if FWG.NextGrid1.Row[i].Selected then
    begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendFault then
      begin
        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendFault := false;
        j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendFaultIndex;
        iPlot1.DeleteChannel(j);
        UpdateChannelIndex(j);
      end;
    end;
  end;
end;

procedure TWatchF2.DeleteFromTrend1Click(Sender: TObject);
var
  i,j: integer;
begin
  for i := FWG.NextGrid1.RowCount - 1 downto 0 do
  begin
    if FWG.NextGrid1.Row[i].Selected then
    begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrend then
      begin
        if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendAlarm then
        begin
          IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendAlarm := false;
          j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendAlarmIndex;
          iPlot1.DeleteChannel(j);
        end;

        if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendFault then
        begin
          IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendFault := false;
          j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendFaultIndex;
          iPlot1.DeleteChannel(j);
        end;

        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrend := false;
        j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendChannelIndex;
        iPlot1.DeleteChannel(j);
        UpdateChannelIndex(j);
        j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendYAxisIndex;
        iPlot1.DeleteYAxis(j);
        UpdateYAxisIndex(j);
      end;

      FWG.NextGrid1.CellByName['TrendDisplay', i].AsInteger := -1;
    end;
  end;
end;

procedure TWatchF2.DeleteFromXYGraph1Click(Sender: TObject);
var
  i,j: integer;
begin
  for i := 0 to FWG.NextGrid1.RowCount - 1 do
  begin
    //if FWG.NextGrid1.Row[i].Selected then
    //begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayXY then
      begin
        for j := 0 to iXYPlot1.ChannelCount - 1 do
          iXYPlot1.Channel[j].Clear;

        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayXY := False;
        FWG.NextGrid1.CellByName['XYDisplay', i].AsInteger := -1;
        FXYDataIndex[0] := -1;
        FXYDataIndex[1] := -1;
      end;
    //end;
  end;
end;

//Items(Grid)에서 Item 삭제 시 pjhTagName 설정값도 삭제하기 위함
//AIndex: 삭제할 Grid Row Index
procedure TWatchF2.DeleteItem1Click(Sender: TObject);
begin
  FWG.DeleteGridItem;
end;

procedure TWatchF2.DeleteItem2pjhTagInfo(AIndex: integer);
var
  i, j, k: integer;
  LPage: TAdvOfficePage;
  LPanel: TpjhPanel;
  IpjhDI: IpjhDesignCompInterface;
begin
    j := 5;

    while j < PageControl1.AdvPageCount do
    begin
      LPage := PageControl1.AdvPages[j];

      for k := 0 to LPage.ComponentCount - 1 do
      begin
        //find panel component(only one exist on Page)
        if LPage.Components[k].ClassType = TpjhPanel then
        begin
          LPanel := LPage.Components[k] as TpjhPanel;

          for i := 0 to LPanel.ComponentCount - 1 do
          begin
            if Supports(LPanel.Components[i], IpjhDesignCompInterface, IpjhDI) then
            begin
              if IpjhDI.pjhTagInfo.TagName = FWG.NextGrid1.CellsByName['ItemName', AIndex] then
              begin
                IpjhDI.pjhTagInfo.TagName := '';
                IpjhDI.pjhTagInfo.ParamIndex := 0;
                IpjhDI.pjhValue := '';
                Break;
              end;
            end;
          end;//for

          break;
        end;//if
      end;//for

      inc(j);
    end;//while
end;

procedure TWatchF2.DeleteNextRef(AWillDeleteControl: TWinControl);
var
  i: integer;
  LControl: TControl;
  LPFI: IpjhPipeFlowInterface;
begin
  for i := 0 to FpjhSelector.HandlingControlList.Count - 1 do
  begin
    LControl := FpjhSelector.HandlingControlList.Items[i].Control;

    if Supports(LControl, IpjhPipeFlowInterface, LPFI) then
    begin
      LPFI.DeleteNextStep(AWillDeleteControl);
    end;
  end;
end;

procedure TWatchF2.DescRBClick(Sender: TObject);
begin
  TagRB.Checked := DescRB.Checked;
end;

procedure TWatchF2.DestroyComponentOnPage(LPage: TAdvOfficePage);
var
  j,k: integer;
  LPanel: TpjhPanel;
begin
  for j := 0 to LPage.ComponentCount - 1 do
  begin
    if LPage.Components[j] is TpjhPanel then
    begin
      LPanel := LPage.Components[j] as TpjhPanel;

      for k := LPanel.ComponentCount - 1 downto 0 do
      begin
//        ShowMessage(LPanel.Components[k].Name);
        LPanel.Components[k].Free;
      end;
    end;
  end;
end;

procedure TWatchF2.DestroyDynamicPanel;
var
  i: integer;
  LPage: TAdvOfficePage;
  LPanel: TpjhPanel;
begin
  for i := DYNAMIC_PAGE_INDEX to PageControl1.AdvPageCount - 1 do
  begin
    LPage := PageControl1.AdvPages[i];
    DestroyComponentOnPage(LPage);
//    LPanel := TpjhPanel(GetDesignControl(LPage));
//    if not Assigned(LPanel) then
//      ShowMessage('aaa');
//    Application.RemoveComponent(TComponent(LPanel));
  end;
end;

procedure TWatchF2.DestroySTOMP;
begin
  if Assigned(FpjhSTOMPClass) then
  begin
    FpjhSTOMPClass.DisConnectStomp;
    FpjhSTOMPClass.Free;
  end;
end;

procedure TWatchF2.DisplayMessage(Msg: string; AIsSaveLog: Boolean; AMsgLevel: TSynLogInfo);
var
  ILog: ISynLog;
  i: integer;
begin
  if (Msg = '') and (FMsgList.Count > 0) then
    Msg := FMsgList.Strings[0];

  //MsgLed.Caption := Msg;
  i := FMsgList.IndexOf(Msg);
  //메세지 출력 후 리스트에서 삭제함(매번 Timer함수에 의해 다시 들어오기 때문임)
  if i > -1 then
    FMsgList.Delete(i);

  if AIsSaveLog then
  begin
    ILog := TSynLog.Enter;
    ILog.Log(AMsgLevel,Msg);
  end;
end;

procedure TWatchF2.DisplayMessage2SB(Msg: string);
begin
  JvStatusBar1.SimplePanel := True;
  JvStatusBar1.SimpleText := Msg;
end;

procedure TWatchF2.DisplayPanelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  OnWindowCaptionDrag;
end;

//AXValueisDataTime: X 축 값이 시간일 경우 true
//                             횟수일 경우 false
procedure TWatchF2.DisplayTrend(AXValueisDateTime: Boolean; ATime: TDateTime);
var
  i,j: integer;
  tmpdouble, tmpdouble2: double;
begin
  if not FStartTrend then
    exit;

  tmpdouble2 := 0.0;

  if AXValueisDateTime then
    tmpdouble2 := ATime;

  for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrend then
    begin
      if not AXValueisDateTime then
      begin
        tmpdouble2 := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].PlotXValue;
        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].PlotXValue :=
            IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].PlotXValue + 1.0;
      end;
      j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendChannelIndex;
      tmpdouble := StrToFloatDef(IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].Value,0.0);
      //if AXValueisDateTime then
      //  iPlot1.Channel[j].AddYNow(tmpdouble)
      //else
        iPlot1.Channel[j].AddXY(tmpdouble2, tmpdouble);

      //iPlot1.Channel[j].AddYElapsedTime(LValue);
      if FConfigOption.ZoomToFitTrend then
        iPlot1.Channel[j].YAxis.ZoomToFit;
      //AddData2TrendMap(i, tmpdouble2, tmpdouble);

      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendAlarm then
      begin
        j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendAlarmIndex;
        if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].MinAlarmEnable then
          tmpdouble := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].MinAlarmValue
        else
          tmpdouble := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].MaxAlarmValue;

        iPlot1.Channel[j].AddXY(tmpdouble2, tmpdouble);
      end;

      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrendFault then
      begin
        j := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendFaultIndex;
        if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].MinFaultEnable then
          tmpdouble := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].MinFaultValue
        else
          tmpdouble := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].MaxFaultValue;

        iPlot1.Channel[j].AddXY(tmpdouble2, tmpdouble);
      end;
    end;

  end;

end;

procedure TWatchF2.DisplayTrendFromMap(APlot: TiPlot; AMap: DMap);
var
  it, it2: Diterator;
  LArray: DArray;
  LDoublePoint: TDoublePoint;
  i: integer;
  LStr: string;
begin
  it := AMap.start;
  SetToKey(it);
  //APlot.ClearAllData;
  APlot.AddXAxis;
  LStr := getString(it);
  SetToValue(it);

  while not atEnd(it) do
  begin
    LArray := GetObject(it) as DArray;
    it2 := LArray.start;
    i := APlot.AddYAxis;
    Aplot.YAxis[i].Title := LStr;
    i := APlot.AddChannel;
    while not atEnd(it2) do
    begin
      LDoublePoint := GetObject(it2) as TDoublePoint;
      APlot.Channel[i].AddXY(LDoublePoint.X, LDoublePoint.Y);
      //ShowMessage(FloatToStr(GetInteger(it2)));
      advance(it2);
    end;
    advance(it);
  end;
end;

//AMap안에 DArray로 데이터 저장됨
procedure TWatchF2.DisplayXYGraphRealTime(APlotChannel: TiXYPlotChannel);
var
  i,j: integer;
  tmpdouble, tmpdouble2: double;
begin
  if (FXYDataIndex[0] = -1) or (FXYDataIndex[1] = -1) then
    exit;

  i := FXYDataIndex[0];
  j := FXYDataIndex[1];

  tmpdouble := StrToFloatDef(IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].Value,0.0);
  tmpdouble2 := StrToFloatDef(IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[j].Value,0.0);

  APlotChannel.AddXY(tmpdouble, tmpdouble2);
end;

procedure TWatchF2.DisplayXYGraphWithDup(APlotChannel: TiXYPlotChannel;
  AMap: DMultiMap);
var
  Li: integer;
  it, LArrIt: DIterator;
  LMultiMap: DMultiMap;
  //LArray: DArray;
  LDoublePoint: TDoublePoint;
  LStr: string;
begin
  APlotChannel.Clear;
  it := AMap.startKey;
  SetToKey(it);
  LStr := getString(it);
  APlotChannel.XAxis.TitleShow := True;
  APlotChannel.XAxis.Title := strToken(LStr,';');
  APlotChannel.YAxis.TitleShow := True;
  APlotChannel.YAxis.Title := strToken(LStr,';');

  SetToValue(it);

  while not atEnd(it) do
  begin
    LMultiMap := GetObject(it) as DMultiMap;
    LArrIt := LMultiMap.start;
    while not atEnd(LArrIt) do
    begin
      LDoublePoint := GetObject(LArrIt) as TDoublePoint;
      APlotChannel.AddXY(LDoublePoint.X, LDoublePoint.Y);
      Advance(LArrIt);
    end;
    Advance(it);
  end;//while
end;

//AMap안에 DMultiMap으로 데이터 저장됨
procedure TWatchF2.DisplayXYGraphWithOutDup(APlotChannel: TiXYPlotChannel;
  AMap: DMultiMap);
var
  Li: integer;
  it: DIterator;
  LDoublePoint: TDoublePoint;
begin
  APlotChannel.Clear;
  it := AMap.startKey;
  SetToValue(it);

  while not atEnd(it) do
  begin
    LDoublePoint := GetObject(it) as TDoublePoint;
    APlotChannel.AddXY(LDoublePoint.X, LDoublePoint.Y);
    Advance(it);
  end;//while
end;

//Design Form위의 컴포넌트에 데이터 보여줌
procedure TWatchF2.WatchAnalogValue2DesignScreen;
var
  i, j, PnlIndex: integer;
//  LPanel: TpjhPanel;
  IpjhDI: IpjhDesignCompInterface;
  IpjhDI2: IpjhDesignCompInterface2; //Plot용 Interface(Channel 값 할당)
  LValue: string;
  tmpdouble: double;
  LEP: TEngineParameterCollect;
begin
  if FEnterWatchAnalogValue2DesignScreen then
    exit
  else
    FEnterWatchAnalogValue2DesignScreen := True;

  try
    with PageControl1.AdvPages[PageControl1.ActivePageIndex] do
    begin
      PnlIndex := -1;

      for i := 0 to ComponentCount - 1 do
      begin
        //find panel component(only one exist on Page)
        if Components[i].ClassType = TpjhPanel then
        begin
          PnlIndex := i;
          break;
        end;
      end;//for

      if PnlIndex = -1 then
        exit;

      with Components[PnlIndex] as TpjhPanel do
      begin
        LEP := IPCMonitorAll1.FEngineParameter.EngineParameterCollect;

        for i := 0 to ComponentCount - 1 do
        begin
          LValue := '';

          if Supports(Components[i], IpjhDesignCompInterface2, IpjhDI2) then
          begin
            if IpjhDI2.pjhTagInfoList.Count = IpjhDI2.pjhChannelCount then
            begin
              for j := 0 to IpjhDI2.pjhChannelCount - 1 do
              begin
                PnlIndex := TpjhTagInfo(IpjhDI2.pjhTagInfoList.Objects[j]).ParamIndex;
                IpjhDI2.SetpjhValues2Channel(PnlIndex,
                  LEP.Items[IpjhDI.pjhTagInfo.ParamIndex].Value,
                  LEP.Items[IpjhDI.pjhTagInfo.ParamIndex].Value);
              end;
            end;
          end
          else if Supports(Components[i], IpjhDesignCompInterface, IpjhDI) then
          begin
            if IpjhDI.pjhTagInfo.TagName <> '' then
            begin
              if IpjhDI.pjhTagInfo.ParamIndex < LEP.Count then
              begin
                PnlIndex := IpjhDI.pjhTagInfo.ParamIndex;

                if FConfigOption.DisplayAverageValue and
                  LEP.Items[PnlIndex].IsAverageValue then
                begin
                  tmpdouble := TCircularArray(LEP.Items[PnlIndex].FPCircularArray).Average;

                  if LEP.Items[PnlIndex].RadixPosition = 0 then
                    LValue := Format('%d', [Round(tmpdouble)])
                  else
                    LValue := FormatFloat(LEP.Items[PnlIndex].DisplayFormat, tmpdouble);

                  IpjhDI.pjhValue := LValue;
                end
                else
                begin
                  if LEP.Items[PnlIndex].MultiStateItemIndex <> -1 then
                    LValue := GetMultiStateMeaning(LEP.Items[PnlIndex]);
//                  else
//                  if LEP.Items[PnlIndex].FUseBalloon then  //UseBalloon = True이면
//                  if IPCMonitorAll1.FIsUseBalloon then  //FIsUseBalloon = True이면
//                  begin
//                    LValue := LEP.Items[PnlIndex].Description_Eng;
//                  end;

                  if LValue = '' then
                    LValue := LEP.Items[PnlIndex].Value;

                  if LEP.Items[PnlIndex].Contact = 2 then
                  begin
                    if LValue = '0' then
                      LValue := '1'
                    else
                      LValue := '0';
                  end;

                  IpjhDI.pjhValue := LValue;
                  LValue := '';
                end;
              end;//IpjhDI.pjhTagInfo.ParamIndex < LEP.Count
            end;//IpjhDI.pjhTagInfo.TagName <> ''
          end;
        end;//for
      end;//with
    end;//with
  finally
    FEnterWatchAnalogValue2DesignScreen := False;
  end;
end;

procedure TWatchF2.WatchDigitalValue2DesignScreen(Name, AValue: string;
  AEPIndex: integer);
begin
  WatchAnalogValue2DesignScreen;
end;

procedure TWatchF2.WatchValue2ScreenOnceAfterIPCTrigger;
begin
  WatchAnalogValue2DesignScreen;
end;

procedure TWatchF2.WatchValue2Screen_2;
begin
  WatchAnalogValue2DesignScreen;
end;

procedure TWatchF2.WatchValue2Screen_Analog(Name: string; AValue: string;
  AEPIndex: integer);
var
  tmpdouble: double;
  //tmpValue: string;
  i: integer;
begin
  if FEnterWatchValue2Screen then
    exit
  else
    FEnterWatchValue2Screen := True;

  try
    with IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex] do
    begin
      //Simulation Mode 이면
      if FModBusMode = 3 then
      begin
        //Stick Check Box가 Check 되지 않은 경우에만 페이지 자동 이동함
        if not StayItemTabCheck.Checked then
        begin
          if FDFPageCaption <> '' then
          begin
            if (FDFPageIndex > 0) and (PageControl1.AdvPageCount > FDFPageIndex ) then
            begin
              if PageControl1.AdvPages[FDFPageIndex].Caption = FDFPageCaption then
                PageControl1.ActivePageIndex := FDFPageIndex;
            end;
          end;
        end;
      end;

      tmpdouble := StrToFloatDef(Value, 0.0);

      if FCurrentEPIndex4Watch = AEPIndex then
        FWatchCA.Put(tmpdouble);

      DisplayTrend(true,now);
      DisplayXYGraphRealTime( iXYPlot1.Channel[0] );

      case PageControl1.ActivePageIndex of
        0: begin //Items
          //for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
          //begin
            FWG.NextGrid1.CellsByName['Value', AEPIndex] := Value;
          //end;
        end;
        1: begin //simple
          if FCurrentEPIndex4Watch > -1 then
          begin
            WatchLabel.Caption := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[FCurrentEPIndex4Watch].Value;
            AvgLabel.Caption := format('%.2f',[FWatchCA.Average]);
          end;

          if FConfigOption.SelectAlarmValue = 2 then //FConfigOption(this) 사용일 경우
            SetAlarm4ThisOption(tmpDouble)
          else
          if FConfigOption.SelectAlarmValue = 1 then //original 사용일 경우
            SetAlarm4OriginalOption(tmpDouble, FCurrentEPIndex4Watch);
        end;
        2: begin //Min/Max
          if FCurrentEPIndex4Watch > -1 then
          begin
            MinLabel.Caption := format('%.2f',[FWatchCA.Min]);//FloatToStr(FWatchValueMin);
            MaxLabel.Caption := format('%.2f',[FWatchCA.Max]);//FloatToStr(FWatchValueMax);
            CurLabel.Caption := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[FCurrentEPIndex4Watch].Value;
          end;
        end;
        3: begin //Trend
        end;
        4: begin //XY Graph
        end;
  //      else
  //        WatchAnalogValue2DesignScreen(Name,AValue,AEPIndex);
      end;//case
    end;//with
  finally
    FEnterWatchValue2Screen := False;
  end;
end;

procedure TWatchF2.WatchValue2Screen_Digital(Name, AValue: string;
  AEPIndex: integer);
var
  LDouble: double;
  i: integer;
  LValue: string;
begin
  if FEnterWatchValue2Screen then
    exit
  else
    FEnterWatchValue2Screen := True;

  try
    LValue := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AEPIndex].Value;

    if LValue = '' then
      exit;

    LDouble := StrToFloatDef(LValue, 0.0);

    case PageControl1.ActivePageIndex of
      0: begin //Items
        if LValue = '0' then
          FWG.NextGrid1.CellsByName['Value', AEPIndex] := 'False'
        else
          FWG.NextGrid1.CellsByName['Value', AEPIndex] := 'True';
      end;
      1: begin //simple
        if FCurrentEPIndex4Watch > -1 then
        begin
          if LValue = '0' then
            WatchLabel.Caption := 'False'
          else
            WatchLabel.Caption := 'True';
        end;

        if FConfigOption.SelectAlarmValue = 2 then //FConfigOption(this) 사용일 경우
          SetAlarm4ThisOption((LDouble))
        else
        if FConfigOption.SelectAlarmValue = 1 then //original 사용일 경우
          SetAlarm4OriginalOption(Double(LDouble), FCurrentEPIndex4Watch);
      end;
      2: begin //Min/Max
      end;
      3: begin //Trend
      end;
      4: begin //XY Graph
      end;
//      else
//        WatchDigitalValue2DesignScreen(Name,AValue,AEPIndex);
    end;//case
  finally
    FEnterWatchValue2Screen := False;
  end;
end;

procedure TWatchF2.WatchValue2Screen_Once(APageIndex: integer);
var
  i: integer;
  tmpdouble: double;
  LValue: string;
begin
  if FEnterWatchValue2Screen then
    exit
  else
    FEnterWatchValue2Screen := True;

  FWG.NextGrid1.BeginUpdate;
  try
    with IPCMonitorAll1.FEngineParameter.EngineParameterCollect do
    begin
      for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
      begin
//        if Items[i].Alarm then //Analog data
//        begin
        LValue := Items[i].Value;

        if LValue = '' then
            Continue;

        tmpdouble := StrToFloatDef(LValue, 0.0);

        if FCurrentEPIndex4Watch = i then
          FWatchCA.Put(tmpdouble);

        DisplayTrend(true,now);
        DisplayXYGraphRealTime( iXYPlot1.Channel[0] );

        if APageIndex = -1 then
          APageIndex := PageControl1.ActivePageIndex;

        case APageIndex of
          0: begin //Items
            if Items[i].Alarm then //Analog data
              FWG.NextGrid1.CellsByName['Value', i] := Items[i].Value
            else
            begin //Digital data
              if LValue = '0' then
                FWG.NextGrid1.CellsByName['Value', i] := 'False'
              else
                FWG.NextGrid1.CellsByName['Value', i] := 'True';
            end;
          end;
          1: begin //simple
            if Items[i].Alarm then //Analog data
            begin
              if FCurrentEPIndex4Watch > -1 then
              begin
                WatchLabel.Caption := Items[FCurrentEPIndex4Watch].Value;
                AvgLabel.Caption := format('%.2f',[FWatchCA.Average]);
              end;
            end
            else
            begin  //Digital data
              if FCurrentEPIndex4Watch > -1 then
              begin
                if LValue = '0' then
                  WatchLabel.Caption := 'False'
                else
                  WatchLabel.Caption := 'True';
              end;
            end;

            if FConfigOption.SelectAlarmValue = 2 then //FConfigOption(this) 사용일 경우
              SetAlarm4ThisOption(tmpDouble)
            else
            if FConfigOption.SelectAlarmValue = 1 then //original 사용일 경우
              SetAlarm4OriginalOption(tmpDouble, FCurrentEPIndex4Watch);
          end;
          2: begin //Min/Max
            if FCurrentEPIndex4Watch > -1 then
            begin
              MinLabel.Caption := format('%.2f',[FWatchCA.Min]);//FloatToStr(FWatchValueMin);
              MaxLabel.Caption := format('%.2f',[FWatchCA.Max]);//FloatToStr(FWatchValueMax);
              CurLabel.Caption := Items[FCurrentEPIndex4Watch].Value;
            end;
          end;
          3: begin //Trend
          end;
          4: begin //XY Graph
          end;
        end;//case
//        end//if Analog data
      end;//for
    end;//with

    if PageControl1.ActivePageIndex > 4 then
      WatchAnalogValue2DesignScreen;
  finally
    FWG.NextGrid1.EndUpdate;
    FEnterWatchValue2Screen := False;
  end;
end;

procedure TWatchF2.WMButtonClick(var Msg: TMessage);
begin
  case TJvTransBtnActionKind(Msg.LParam) of
    tbakChangePage: PageControl1.ActivePageIndex := Msg.WParam;
    tbakLoadDFMFromFile: LoadDesignFormFromDFCByPageIndex(Msg.WParam);
  end;
end;

procedure TWatchF2.WMClose(var Msg: TMessage);
begin
  Close;
end;

procedure TWatchF2.WMCopyData(var Msg: TMessage);
var
  LDragCopyMode: TParamDragCopyMode;
begin
  case Msg.WParam of
    0: begin
      FProgramMode := pmWatchList;
//      FPM.SendEPCopyData(PCopyDataStruct(Msg.LParam)^.dwData, FWG.Handle, PEngineParameterItemRecord(PCopyDataStruct(Msg.LParam)^.lpData)^);

      LDragCopyMode := PEngineParameterItemRecord(PCopyDataStruct(Msg.LParam)^.lpData)^.FParamDragCopyMode;

//  {$IFDEF USECODESITE}
//  CodeSite.EnterMethod('TWatchF2.WMCopyData ===>');
//  try
//    CodeSite.Send('Msg.WParam', Ord(LDragCopyMode));
//    CodeSite.Send('FWG.Handle', FWG.Handle);
//    CodeSite.Send('FRadixPosition', PEngineParameterItemRecord(PCopyDataStruct(Msg.LParam)^.lpData)^.FRadixPosition);
//  finally
//    CodeSite.ExitMethod('TWatchF2.WMCopyData <===');
//  end;
//  {$ENDIF}

      if LDragCopyMode <> dcmCopyCancel then //HiMECS에서 모드가 전송 되어 오는 경우
        CreateIPCMonitor(PEngineParameterItemRecord(PCopyDataStruct(Msg.LParam)^.lpData)^, LDragCopyMode)
      else//마우스로 모드 선택하는 경우
        CreateIPCMonitor(PEngineParameterItemRecord(PCopyDataStruct(Msg.LParam)^.lpData)^, FWG.FDragCopyMode);
      //PageControl1.Pages[PageControl1.PageCount - 1].TabVisible := False;
    end;
    1: begin
      ChangeAlarmListMode;
    end;
    2: begin
      //Transparent Btn Component에서 전송함
      SetCompDataFromTransBtn(PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^);
    end;
    3: begin
      //FrmSimulateParamEdit->SaveParamDetail2SimPramRecFromForm 에서 전송함
//      SaveSimulateParamData2Json(PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^);
      SaveSimulateParamData2Json(PCopyDataStruct(Msg.LParam)^);
    end;
    4: begin
      //pjhObjectInspectorBpl unit의 TfrmProps.PropInspModified함수에서 전송함.
      //위 함수는 property Inspector의 InEditor에서 엔터키를 입력 시 실행 됨.
      //디자인 폼의 컴포넌트 Property 값을 변경시 변경 값을 JSON Format으로 전송함
      if FSimulatePropertyValueMode then
        //ARecToPass: TRecToPass
        SetCompValueFromOI(PRecToPass2(PCopyDataStruct(Msg.LParam)^.lpData)^);
    end;
  end;
end;

procedure TWatchF2.WMDesignManagerClose(var Msg: TMessage);
begin
  //CloseDesignPanel1Click(nil);

end;

procedure TWatchF2.WMNCACTIVATE(var Msg: TWMNCActivate);
begin
  inherited;

//  if FSimulatePropertyValueMode then
//    DrawCaptionText(Caption, clHighlight);
end;

procedure TWatchF2.WMNCPaint(var Msg: TWMNCPaint);
begin
  inherited;

//  if FSimulatePropertyValueMode then
//    DrawCaptionText('Caption', clHighlight);
end;

procedure TWatchF2.WorkerResult(var msg: TMessage);
begin
  ProcessResults;
end;

procedure TWatchF2.Xls1Click(Sender: TObject);
begin
  MakeModbusCommandFromGrid(oftExcel);
end;

procedure TWatchF2.XYDataAdd2Map(AMap: DMultiMap; AKey, AValue: double;
  AIsXAxis: Boolean);
var
  LDoublePoint : TDoublePoint;
begin
  LDoublePoint := TDoublePoint.Create;
  if AIsXAxis then  //Key Is X Axis
  begin
    LDoublePoint.X := AKey;
    LDoublePoint.Y := AValue;
  end
  else
  begin
    LDoublePoint.Y := AKey;
    LDoublePoint.X := AValue;
  end;
  AMap.putPair([AKey, LDoublePoint]);
end;

procedure TWatchF2.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FWG.FKeyBdShiftState := Shift;

  case Key of
    vk_control: FControlPressedOnGrid := False;
  end;
end;

procedure TWatchF2.FormCreate(Sender: TObject);
begin
  InitVar;
end;

procedure TWatchF2.CalcAverageFromTrend(Sender: TObject);
var
  LChIndex, Li, Lj: integer;
  LXValue, LYValue: double;
begin
  GetXYPeriod(Li,Lj);

  LChIndex := iXYPlot1.HelpContext; //X축 Parameter index
  LXValue := GetPeriodDataFromTrend(LChIndex,Li,Lj,pdtAverage);

  LChIndex := iXYPlot1.Tag; //Y축 Parameter index
  LYValue := GetPeriodDataFromTrend(LChIndex,Li,Lj,pdtAverage);

  LChIndex := iXYPlot1.DataViewZHorz; //XY Graph Channel Index
  iXYPlot1.Channel[LChIndex].AddXY(LXValue, LYValue);
end;

procedure TWatchF2.CalcDiffFromTrend(Sender: TObject);
begin
  ;
end;

procedure TWatchF2.CalcMaxFromTrend(Sender: TObject);
var
  LChIndex, Li, Lj: integer;
  LXValue, LYValue: double;
begin
  GetXYPeriod(Li,Lj);

  LChIndex := iXYPlot1.HelpContext; //X축 Parameter index
  LXValue := GetPeriodDataFromTrend(LChIndex,Li,Lj,pdtMax);

  LChIndex := iXYPlot1.Tag; //Y축 Parameter index
  LYValue := GetPeriodDataFromTrend(LChIndex,Li,Lj,pdtMax);

  LChIndex := iXYPlot1.DataViewZHorz; //XY Graph Channel Index
  iXYPlot1.Channel[LChIndex].AddXY(LXValue, LYValue);
end;

procedure TWatchF2.CalcMinFromTrend(Sender: TObject);
var
  LChIndex, Li, Lj: integer;
  LXValue, LYValue: double;
begin
  GetXYPeriod(Li,Lj);

  LChIndex := iXYPlot1.HelpContext; //X축 Parameter index
  LXValue := GetPeriodDataFromTrend(LChIndex,Li,Lj,pdtMin);

  LChIndex := iXYPlot1.Tag; //Y축 Parameter index
  LYValue := GetPeriodDataFromTrend(LChIndex,Li,Lj,pdtMin);

  LChIndex := iXYPlot1.DataViewZHorz; //XY Graph Channel Index
  iXYPlot1.Channel[LChIndex].AddXY(LXValue, LYValue);
end;

procedure TWatchF2.CalcPointFromTrend(Sender: TObject);
var
  LChIndex, Li, Lj: integer;
  LXValue, LYValue: double;
begin
  Li := iPlot1.Channel[0].CalcIndex(iPlot1.DataCursor[0].ValueX);
  Lj := Li;

  LChIndex := iXYPlot1.HelpContext; //X축 Parameter index
  LXValue := GetPeriodDataFromTrend(LChIndex,Li,Lj,pdtPoint);

  LChIndex := iXYPlot1.Tag; //Y축 Parameter index
  LYValue := GetPeriodDataFromTrend(LChIndex,Li,Lj,pdtPoint);

  LChIndex := iXYPlot1.DataViewZHorz; //XY Graph Channel Index
  iXYPlot1.Channel[LChIndex].AddXY(LXValue, LYValue);
end;

procedure TWatchF2.CalcPointSpanFromTrend(Sender: TObject);
var
  LChIndex, Li, Lj, i: integer;
  LXValue, LYValue: double;
begin
  GetXYPeriod(Li,Lj);

  for i := Li to Lj do
  begin
    LChIndex := iXYPlot1.HelpContext; //X축 Parameter index
    LXValue := GetPeriodDataFromTrend(LChIndex,i,i,pdtPoint);

    LChIndex := iXYPlot1.Tag; //Y축 Parameter index
    LYValue := GetPeriodDataFromTrend(LChIndex,i,i,pdtPoint);

    LChIndex := iXYPlot1.DataViewZHorz; //XY Graph Channel Index
    iXYPlot1.Channel[LChIndex].AddXY(LXValue, LYValue);
  end;
end;

procedure TWatchF2.CalcSumFromTrend(Sender: TObject);
var
  LChIndex, Li, Lj: integer;
  LXValue, LYValue: double;
begin
  GetXYPeriod(Li,Lj);

  LChIndex := iXYPlot1.HelpContext; //X축 Parameter index
  LXValue := GetPeriodDataFromTrend(LChIndex,Li,Lj,pdtSum);

  LChIndex := iXYPlot1.Tag; //Y축 Parameter index
  LYValue := GetPeriodDataFromTrend(LChIndex,Li,Lj,pdtSum);

  LChIndex := iXYPlot1.DataViewZHorz; //XY Graph Channel Index
  iXYPlot1.Channel[LChIndex].AddXY(LXValue, LYValue);
end;

procedure TWatchF2.CaptionShowHide1Click(Sender: TObject);
begin
  ToggleBorderStyle(TForm(Self));
end;

procedure TWatchF2.ChangeAlarmListMode;
var
  i: integer;
begin
{  FProgramMode := pmAlarmList;
  PageControl1.Pages[0].Caption := 'Alarm Items';
  PageControl1.Pages[PageControl1.PageCount - 1].TabVisible := True;

  for i := 1 to PageControl1.PageCount - 2 do
    PageControl1.Pages[i].TabVisible := False;

  FWG.NextGrid1.PopupMenu := AlarmListPopup;
  TabSheet5.PopupMenu := nil;
  SaveListCB.Checked := True;

  InitAlarmList;
  LoadConfigCollectFromFile(FFilePath+DefaultAlarmListConfigFileName, DefaultEncryption);
  }
end;

procedure TWatchF2.ChangeDispPanelColor(AColor: TColor);
var
  LColor: TColor;
begin
  DisplayPanel.Color := AColor;
  WatchLabel.Color := DisplayPanel.Color;
  AvgLabel.Color := DisplayPanel.Color;
  Label1.Color := DisplayPanel.Color;
  Label3.Color := DisplayPanel.Color;
  Label2.Color := DisplayPanel.Color;

  LColor := CalcComplementalColor(DisplayPanel.Color);

  WatchLabel.Font.Color := LColor;
  AvgLabel.Font.Color := LColor;
  Label1.Font.Color := LColor;
  Label3.Font.Color := LColor;
  Label2.Font.Color := LColor;
end;

procedure TWatchF2.ChangePage1Click(Sender: TObject);
begin
  SetpjhBtnActionKind4TransparentBtn(tbakChangePage, True);
end;

procedure TWatchF2.ChangePageincurrentpage1Click(Sender: TObject);
begin
  SetpjhBtnActionKind4TransparentBtn(tbakChangePage, False);
end;

procedure TWatchF2.ChangeTabCaption1Click(Sender: TObject);
var
  LCaptionInputF: TCaptionInputF;
begin
  if PageControl1.ActivePage.TabIndex < 4 then
  begin
    ShowMessage('Current tab should be greater than 4!');
    exit;
  end;

  LCaptionInputF := TCaptionInputF.Create(Application);
  with LCaptionInputF do
  begin
    try
      CaptionNameEdit.Text := PageControl1.ActivePage.Caption;

      if ShowModal = mrOK then
      begin
        if CaptionNameEdit.Text = '' then
        begin
          ShowMessage('Caption should not be blank!');
          exit;
        end;

        PageControl1.ActivePage.Caption := CaptionNameEdit.Text;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TWatchF2.ChangeTabIndex1Click(Sender: TObject);
var
  LCaptionInputF: TCaptionInputF;
  LIdx: integer;
begin
  if PageControl1.ActivePage.TabIndex < 4 then
  begin
    ShowMessage('Current tab should be greater than 4!');
    exit;
  end;

  LCaptionInputF := TCaptionInputF.Create(Application);

  with LCaptionInputF do
  begin
    try
      Caption := 'Change Tab Index';
      Label1.Caption := 'Tab Index';
      LIdx := PageControl1.ActivePageIndex;
      CaptionNameEdit.Text := IntToStr(LIdx);

      if ShowModal = mrOK then
      begin
        if CaptionNameEdit.Text = '' then
        begin
          ShowMessage('Tab Index should not be blank!');
          exit;
        end;

        PageControl1.ActivePage.PageIndex := StrToIntDef(CaptionNameEdit.Text, 5);
      end;
    finally
      Free;
    end;
  end;
end;

procedure TWatchF2.CheckCircularofNextStep1Click(Sender: TObject);
var
  LPanel: TpjhPanel;
begin
  FCheckCircularNextStepMode := not FCheckCircularNextStepMode;
  CheckCircularofNextStep1.Checked := FCheckCircularNextStepMode;

  CreateNActivatepjhSelector;
end;

procedure TWatchF2.CheckCirculationOfNextStep(AStartNextStep: TControl; ANextList: TStringList);
var
  LPanel: TpjhPanel;
  LPFI: IpjhPipeFlowInterface;
  i: integer;
  LStr, LxStepName: string;
  LControl: TControl;
//  LNextList: TStringList;
begin
  if not Assigned(AStartNextStep) then
    exit;

//  LNextList := TStringList.Create;
  try
    if Supports(AStartNextStep, IpjhPipeFlowInterface, LPFI) then
    begin
      if ANextList.IndexOf(AStartNextStep.Name) <> -1 then
      begin
        ShowMessage('Circulation found at "' + AStartNextStep.Name + '"');
        FindComponentByNameUsingBalloon(AStartNextStep.Name);
        exit;
      end;

      ANextList.Add(AStartNextStep.Name);
      LStr := LPFI.GetNextStepListWithComma;

      while LStr <> '' do
      begin
        LxStepName := GetTokenWithComma(LStr);
        LControl := GetComponentByNameFrompjhPanel(LxStepName);
        CheckCirculationOfNextStep(LControl, ANextList);
      end;
    end;

  finally
//    LNextList.Free;
  end;
end;

procedure TWatchF2.CheckedAvgAllSelected1Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to FWG.NextGrid1.RowCount - 1 do
    if FWG.NextGrid1.Row[i].Selected then
      FWG.NextGrid1.CellByName['IsAvg',i].AsBoolean := True;
end;

procedure TWatchF2.EditJsonCompValue4Simulate(var AJson: string);
var
  LStr: string;
  LSO: ISuperObject;
begin
//  LStr := JSONReformat(FSimulateCompValuesJson, jsonHumanReadable);
  LSO := SO(AJson);
  LStr := LSO.AsJson(True);

  if TpjhStringsEditorDlg.Execute(LStr) then
  begin
    LSO := SO(LStr);
    AJson := LSO.AsJson(False);
  end;
end;

procedure TWatchF2.EditPropertyValue4Simulate1Click(Sender: TObject);
begin
  EditJsonCompValue4Simulate(FSimulateCompValuesJson);
end;

procedure TWatchF2.EditPropertyValue4Simulate2Click(Sender: TObject);
begin
  EditJsonCompValue4Simulate(FSimulateCompValuesJson4ConnectNextStep);
end;

procedure TWatchF2.EnableAlphaCBClick(Sender: TObject);
begin
  AlphaBlend := EnableAlphaCB.Checked;
end;

procedure TWatchF2.ClearAllNextStepProperty;
var
  j, PnlIndex: integer;
  LPanel: TpjhPanel;
  LControl: TControl;
begin
  LPanel := GetTpjhPanelOfCurrentPage;

  for j := 0 to LPanel.ComponentCount - 1 do
  begin
    if LPanel.Components[j].InheritsFrom(TWinControl) then
    begin
      LControl := TControl(LPanel.Components[j]);

      ClearXStep(LControl);
    end;
  end;//for
end;

procedure TWatchF2.ClearMainFormCaption1Click(Sender: TObject);
begin
  Caption := FConfigOption.FormCaption;
  FDesignFormConfig.MainFormCaption := '';
end;

procedure TWatchF2.ClearXStep(aControl: TControl);
var
  LControl: TWinControl;
  LPFI: IpjhPipeFlowInterface;
  LStr: string;
begin
  LControl := aControl as TWinControl;

  if Assigned(LControl) then
  begin
    if Supports(LControl, IpjhPipeFlowInterface, LPFI) then
    begin
      LPFI.ClearXStep;
      LStr := LControl.Name + '''s xStep is cleared';
      Caption := LStr;
    end;
  end;
end;

procedure TWatchF2.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TWatchF2.CloseDesignPanel1Click(Sender: TObject);
var
  IbMI : IbplMainInterface;
begin
  if Assigned(FDesignManagerForm) then
  begin
    if Supports(FDesignManagerForm, IbplMainInterface, IbMI) then
    begin
      IbMI.DestroyOIInterface;
      //IbMI.Designer.Active := False;
    end;

    FDesignManagerForm.Close;
    //FDesignManagerForm := nil;
    FreeAndNil(FDesignManagerForm);
  end;

  if Assigned(FDesignManagerFormClass) then
    FDesignManagerFormClass := nil;
end;

function TWatchF2.CommandLineParse(var AErrMsg: string): boolean;
var
  LStr: string;
begin
  AErrMsg := '';
  FCommandLine := TWatchCommandLineOption.Create;
//  try
    try
//      CommandLineParser.Options := [opIgnoreUnknownSwitches];
      Result := CommandLineParser.Parse(FCommandLine);
    except
      on E: ECLPConfigurationError do begin
        AErrMsg := '*** Configuration error ***' + #13#10 +
          Format('%s, position = %d, name = %s',
            [E.ErrorInfo.Text, E.ErrorInfo.Position, E.ErrorInfo.SwitchName]);
        Exit;
      end;
    end;

    if not Result then
    begin
      AErrMsg := Format('%s, position = %d, name = %s',
        [CommandLineParser.ErrorInfo.Text, CommandLineParser.ErrorInfo.Position,
         CommandLineParser.ErrorInfo.SwitchName]) + #13#10;
      for LStr in CommandLineParser.Usage do
        AErrMsg := AErrMSg + LStr + #13#10;
    end
    else
    begin
    end;
//  finally cl.Free; end;
end;

procedure TWatchF2.Config1Click(Sender: TObject);
begin
  SetConfigData;
end;

procedure TWatchF2.ConvertBinToTextDFM1Click(Sender: TObject);
var
  LBinFileName, LTextFileName: string;
  LPanel: TpjhPanel;
  LDesignFormConfig: TDesignFormConfig;
begin
  LPanel := GetTpjhPanelOfCurrentPage;

  if LPanel.ComponentCount > 0 then
  begin
    ShowMessage('This action should be on empty form.' + #13#10 + 'Try again on new page');
    exit;
  end;

  JvOpenDialog1.InitialDir := FFilePath;
  JvOpenDialog1.Filter := '*.dfm|*.*';

  if JvOpenDialog1.Execute then
  begin
    if JvOpenDialog1.FileName <> '' then
    begin
      LBinFileName := JvOpenDialog1.FileName;
    end;
  end;

  JvSaveDialog1.InitialDir := FFilePath;
  JvSaveDialog1.Filter := '*.dfm|*.*';

  if JvSaveDialog1.Execute then
  begin
    LTextFileName := JvSaveDialog1.FileName;

    if FileExists(LTextFileName) then
    begin
      if MessageDlg('File is already existed. Are you overwrite? if No press, then the data is not saved!',
        mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
  end;

  SaveBinDFM2TextDFM(LBinFileName, LTextFileName, TWincontrol(LPanel), ReadComponentsProc);
end;

procedure TWatchF2.CreateIPCMonitor(
  AEP_DragDrop: TEngineParameterItemRecord; ADragCopyMode: TParamDragCopyMode);
var
  i, j, LResult: integer;
begin
  //From IPC가 아니면 IPC를 생성하지 않음, From MQ는 직접 OnSignal 함수를 호출 함
  if FConfigOption.MonDataSource <> 0 then
    exit;

  LResult := FWG.CreateIPCMonitor(AEP_DragDrop, ADragCopyMode);

  //신규 Item 이면
  if not (ADragCopyMode = dcmCopyOnlyExist) and (LResult = -1) then
  begin
   //Administrator이상의 권한자 만이 Config form에서 level 조정 가능함
    if IPCMonitorAll1.FCurrentUserLevel <= HUL_Administrator then
    begin
      AllowUserlevelCB.Enabled := True;
    end;

    if AllowUserlevelCB.Text = '' then
      AllowUserlevelCB.Text := UserLevel2String(IPCMonitorAll1.FCurrentUserLevel);
  end;

  if FCommandLine.IsDisplayTrend or AEP_DragDrop.FIsDisplayTrend then
  begin
    i := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1;
    AddChannelAndYAxis(i, tdtValue);
    PageControl1.ActivePage := TrendTabSheet;
  end
  else
  if FCommandLine.IsDisplaySimple or AEP_DragDrop.FIsDisplaySimple then
  begin
    i := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1;
    AddToSimple(i);
    PageControl1.ActivePage := SimpleTabSheet;
  end
end;

procedure TWatchF2.CreateItem4SelectedComponent(ApjhDCI: IpjhDesignCompInterface);
var
  ConfigData: TEngParamItemConfigForm2;
  LEngineParameterItem,LEPIRefGridData: TEngineParameterItem;
  LIdx: integer;
begin
  LEngineParameterItem := nil;
  LEPIRefGridData := nil;
  ConfigData := TEngParamItemConfigForm2.Create(Self);

  try
    with ConfigData do
    begin
      if ApjhDCI.pjhTagInfo.TagName <> '' then
        LEPIRefGridData := FWG.GetEngParamItemFromGridIdx(ApjhDCI.pjhTagInfo.ParamIndex);

      if Assigned(LEPIRefGridData) then
        LoadConfigEngParamItem2Form(LEPIRefGridData);

      if ShowModal = mrOK then
      begin
        LEngineParameterItem := TEngineParameterItem.Create(nil);
        try
          LoadConfigForm2EngParamItem(LEngineParameterItem);
          LEngineParameterItem.AssignTo(FWG.FTempParamItemRecord);
          LIdx := FWG.ProcessItemsDrop();//(dcmCopyOnlyExist);

          //새로운 Item이 Grid에 추가된 경우
          if LIdx = -1 then
          begin
            LEPIRefGridData := FWG.GetEngParamItemFromGridIdx(FWG.NextGrid1.RowCount-1);
            ApjhDCI.pjhTagInfo.ParamIndex := LEPIRefGridData.Index;
            ApjhDCI.pjhTagInfo.TagName := LEPIRefGridData.TagName;
            ApjhDCI.pjhTagInfo.Description := LEPIRefGridData.Description;
          end
          else
          begin
            LEPIRefGridData := FWG.GetEngParamItemFromGridIdx(LIdx);
            LEPIRefGridData.Assign(LEngineParameterItem);
          end;
        finally
          FreeAndNil(LEngineParameterItem);
        end;
//        UpdateGridFromEngParam2Index(LEngineParameterItem, AIndex);
      end;
    end;//with
  finally
    FreeAndNil(ConfigData);
  end;
end;

procedure TWatchF2.CreateNActivatepjhSelector(ApjhPanel: TpjhPanel);
var
  LPanel: TpjhPanel;
begin
  if ApjhPanel = nil then
    LPanel := GetTpjhPanelOfCurrentPage
  else
    LPanel := ApjhPanel;

  if not Assigned(FpjhSelector) then
  begin
   FpjhSelector := CreatepjhSelector();
  end;

  if FComponentConnectMode or FCreateTagItemMode or FCheckCircularNextStepMode then
    FpjhSelector.Activate(LPanel)
  else
    FpjhSelector.DeActivate;
end;

procedure TWatchF2.CreateNewItem(AEngParamItem: TEngineParameterItem);
var
  ConfigData: TEngParamItemConfigForm2;
  LEngineParameterItem: TEngineParameterItem;
  LIdx: integer;
begin
  ConfigData := TEngParamItemConfigForm2.Create(Self);

  try
    with ConfigData do
    begin
      if Assigned(AEngParamItem) then
        LoadConfigEngParamItem2Form(AEngParamItem);

      if ShowModal = mrOK then
      begin
        LEngineParameterItem := TEngineParameterItem.Create(nil);
        try
          LoadConfigForm2EngParamItem(LEngineParameterItem);
          LEngineParameterItem.AssignTo(FWG.FTempParamItemRecord);
          LIdx := FWG.ProcessItemsDrop();//(dcmCopyOnlyExist);

          //새로운 Item이 Grid에 추가된 경우
          if LIdx = -1 then
          begin
            ShowMessage('New Items (' + LEngineParameterItem.TagName + ') are added to the grid!');
          end;
        finally
          FreeAndNil(LEngineParameterItem);
        end;
      end;
    end;
  finally
    FreeAndNil(ConfigData);
  end;

end;

procedure TWatchF2.CreateNewItemSelected;
var
  LEngParamItem: TEngineParameterItem;
begin
  LEngParamItem := FWG.GetEngParamItemFromGridIdx();
  CreateNewItem(LEngParamItem);
end;

function TWatchF2.CreatepjhSelector: TCyResizer;
begin
  //TcyResizer.HandlingSingleControlChanged내 ScreenToClient에서 Control.parant가 필요함
  Result := TCyResizer.Create(Self);
  Result.OnGetHandlingKeyInformation := OnGetHandlingKeyInfo;
  Result.OnPostProcessMouseInformation := OnPostProcessMouseInfo;
  Result.Options := [roMouseSelect, roMouseMultiSelect, roMouseUnselectAll,
             roKeySelect, roKeyMultiSelect, roKeyUnselectAll, roOutsideParentRect];
end;

procedure TWatchF2.Average1Click(Sender: TObject);
begin
  FIsAverageValueGraph := True;
  FAverageValueChannel := iPlot1.AddChannel;
  iPlot1.Channel[FAverageValueChannel].VisibleInLegend := False;
  FAverageValueX := 0;
  Average1.Enabled := False;
end;

procedure TWatchF2.MinValue1Click(Sender: TObject);
begin
  FIsMinValueGraph := True;
  FMinValueChannel := iPlot1.AddChannel;
  iPlot1.Channel[FMinValueChannel].VisibleInLegend := False;
  FMinValueX := 0;
  MinValue1.Enabled := False;
end;

procedure TWatchF2.MoveItemValueTopjhValue1Click(Sender: TObject);
//var
//  LDoc: variant;
begin
  MovepjhValue2ItemValue(True);;
//  GetVariantFromItemList4SimulateData(LDoc);
//  SendSimulateParamData2gpShMM(LDoc);
end;

procedure TWatchF2.MovepjhValue2ItemValue(AIsReverseDir: Boolean);
var
  i, j, PnlIndex: integer;
  LEP: TEngineParameterCollect;
  IpjhDI: IpjhDesignCompInterface;
  LValue: string;
begin
  with PageControl1.AdvPages[PageControl1.ActivePageIndex] do
  begin
    PnlIndex := -1;

    for i := 0 to ComponentCount - 1 do
    begin
      //find panel component(Only one exist on Page)
      if Components[i].ClassType = TpjhPanel then
      begin
        PnlIndex := i;
        break;
      end;
    end;//for

    if PnlIndex = -1 then
      exit;

    with Components[PnlIndex] as TpjhPanel do
    begin
      LEP := IPCMonitorAll1.FEngineParameter.EngineParameterCollect;

      if LEP.Count = 0 then
      begin
        ShowMessage('Items count is 0');
        exit;
      end;

      for i := 0 to ComponentCount - 1 do
      begin
        if Supports(Components[i], IpjhDesignCompInterface, IpjhDI) then
        begin
          if IpjhDI.pjhTagInfo.TagName <> '' then
          begin
            if IpjhDI.pjhTagInfo.ParamIndex < LEP.Count then
            begin
              if AIsReverseDir then
                IpjhDI.pjhValue := LEP.Items[j].Value
              else
              begin
                j := IpjhDI.pjhTagInfo.ParamIndex;
                LValue := GetMultiStateValueFromIndex(j, IpjhDI.pjhValue);

//              if LValue = IpjhDI.pjhValue then
//                LValue := GetScaledValueFrompjhValue(j, LValue);

                if LValue <> '' then
                  LEP.Items[j].Value := LValue;

//              LEP.Items[j].Description := Components[i].Name;
              end;
            end;
          end;
        end;
      end;//for
    end;//with
  end;//with

  if not AIsReverseDir then
    WatchValue2Screen_Once(0);
end;

procedure TWatchF2.MovepjhValueTogpSharedMM1Click(Sender: TObject);
var
  LDoc: variant;
//  LStr: string;
begin
  MovepjhValue2ItemValue;
  GetVariantFromItemList4SimulateData(LDoc);
  SendSimulateParamData2gpShMM(LDoc);
end;

procedure TWatchF2.MovepjhValueToItemandSaveToDB1Click(Sender: TObject);
begin
  MovepjhValueToItemValueNSaveDB;
end;

procedure TWatchF2.MovepjhValueToItemValue1Click(Sender: TObject);
begin
  MovepjhValue2ItemValue;
end;

procedure TWatchF2.MovepjhValueToItemValueNSaveDB;
begin
  MovepjhValue2ItemValue;
  SaveSimulateValue2DB;
end;

procedure TWatchF2.MoveReceivedgpSHMMValue2ComponentValue(AData: string);
var
  LSO: ISuperObject;
//var
//  LCompDAUtf8, LPropertyDAUtf8: TRawUTF8DynArray;
//  LCompDA, LPropertyDA: TDynArray;
//  LCompUtf8, LPropUtf8: RawUTF8;
//  LDoc, LDoc2, LDoc3: variant;
  LCompName, LPropName, LValue: string;
  Li, j: integer;
  LPanel: TpjhPanel;
begin
//  {Components: [
//    {"CompName": "xxx",
//     "Properties": [
//        {"PropName": "yyy1", "PropTyprKind": 1, "Value": zzz},
//        {"PropName": "yyy2", "PropTyprKind": 1, "Value": zzz}
//        ...
//     ]
//    }
//    ...
//  ]
//  }

  FSimulateCompValuesJson := AData;
  LPanel := GetTpjhPanelOfCurrentPage;

  LSO := TSuperObject.Create(AData);

  with LSO.A['Components'] do
  begin
//    for Li := 0 to Length - 1 do
    for Li := Length - 1 downto 0 do
    begin
      LCompName := O[Li].S['CompName'];

      with O[Li].A['Properties'] do
      begin
        for j := 0 to Length - 1 do
//        for j := Length - 1 downto 0 do
        begin
          LPropName := O[j].S['PropName'];
          LValue := O[j].S['Value'];

          if FindNSetCompValue(LPanel, LCompName, LPropName, LValue) then
            ;
//          FindNSetCompValueFromDesignForm(LCompName, LPropName, LValue);
        end;//for j
      end;//with
    end;//For Li

    SendShortCut2DesignScreen4ShowBalloon();
  end;//with LSO.A['Components']

//  LDoc := _Json(AData);
//
//  LCompUtf8 := LDoc.Components;
//  LCompDA.Init(TypeInfo(TRawUTF8DynArray), LCompDAUtf8);
//  LCompDA.LoadFromJSON(PUTF8Char(LCompUtf8));
//
//  for i := 0 to LCompDA.Count - 1 do
//  begin
//    LDoc2 := _JSON(LCompDAUtf8[i]);
//    LCompName := LDoc2.CompName;
//    LPropUtf8 := LDoc2.Properties;
//
//    LPropertyDA.Init(TypeInfo(TRawUTF8DynArray), LPropertyDAUtf8);
//    LPropertyDA.LoadFromJSON(PUTF8Char(LPropUtf8));
//
//    for j := 0 to LPropertyDA.Count - 1 do
//    begin
//      LDoc3 := _JSON(LPropertyDAUtf8[j]);
//      LPropName := LDoc3.PropName;
//      LValue := LDoc3.Value;
//    end;//for
//  end;//for
end;

procedure TWatchF2.MoveReceivedgpSHMMValue2ItemValueNCommandJson(AData: string);
var
  LDoc: variant;
begin
  LDoc := _Json(AData);
  //Json(AData)에서 CSV를 발췌하여 EngParam.value에 할당 함
  FillInParamNItemGridFromVariantOfSimData(LDoc);

  MergeCommandJsonFromJsonOfSimData(LDoc.CommandJson, FSimulateCompValuesJson);
end;

procedure TWatchF2.MyMouseEvent(var Msg: TMsg; var Handled: Boolean);
begin
  DefWindowProc(Handle, Msg.message, Msg.wParam, Msg.lParam);
  case Msg.message of
    WM_LButtonDown: begin
      //ShowMessage('LButton Down');
      Caption := IntToStr(Random(Msg.message));
    end;
  end;

end;

procedure TWatchF2.UdateGridItemDetailFromFile(AFileName: string);
var
  LEngineParameter: TEngineParameter;
  LExt: string;
  LFileFormat: integer;
begin
//  SetCurrentDir(FFilePath);

  if AFileName = '' then
  begin
    JvOpenDialog1.InitialDir := RelToAbs('..\db', FFilePath);
    JvOpenDialog1.Filter := '*.*';

    if JvOpenDialog1.Execute then
    begin
      if jvOpenDialog1.FileName <> '' then
      begin
        AFileName := jvOpenDialog1.FileName;
      end;
    end;
  end;

  LExt := UpperCase(ExtractFileExt(AFileName));

  LEngineParameter := TEngineParameter.Create(nil);
  try
    if (LExt = '.SQLITE') or (LExt = '.DB') or (LExt = '.DB3') then
      LFileFormat := 2
    else
      LFileFormat := 0;

    //DB(jvOpenDialog1.FileName)로부터 Item을 읽어와서 LEngineParameter에 저장함
    FWG.GetItemsFromParamFile2Collect(jvOpenDialog1.FileName, LFileFormat, False, False, LEngineParameter);
    //LEngineParameter와 IPCMonitorAll1.FEngineParameter.EngineParameterCollect의 TagName을 비교하여 Update 함
    LEngineParameter.EngineParameterCollect.UpdateEngineParameterCollectByTagName(IPCMonitorAll1.FEngineParameter.EngineParameterCollect);
    FWG.AddEngineParameter2Grid;
    ShowMessage('Items(Detail info) are changed!');
  finally
    LEngineParameter.Free;
  end;
end;

procedure TWatchF2.UdateTagNameOfGridItemFromFile(AFileName: string);
var
  LEngineParameter: TEngineParameter;
  LExt: string;
  LFileFormat: integer;
begin
//  SetCurrentDir(FFilePath);

  if AFileName = '' then
  begin
    JvOpenDialog1.InitialDir := RelToAbs('..\db', FFilePath);
    JvOpenDialog1.Filter := '*.*';

    if JvOpenDialog1.Execute then
    begin
      if jvOpenDialog1.FileName <> '' then
      begin
        AFileName := jvOpenDialog1.FileName;
      end;
    end;
  end;

  LExt := UpperCase(ExtractFileExt(AFileName));

  LEngineParameter := TEngineParameter.Create(nil);
  try
    if (LExt = '.SQLITE') or (LExt = '.DB') or (LExt = '.DB3') then
      LFileFormat := 2
    else
      LFileFormat := 0;

    //DB(jvOpenDialog1.FileName)로부터 Item을 읽어와서 LEngineParameter에 저장함
    FWG.GetItemsFromParamFile2Collect(jvOpenDialog1.FileName, LFileFormat, False, False, LEngineParameter);
    //LEngineParameter와 IPCMonitorAll1.FEngineParameter.EngineParameterCollect의 TagName을 비교하여 Update 함
    LEngineParameter.EngineParameterCollect.UpdateTagNameFromAddress4Collect(IPCMonitorAll1.FEngineParameter.EngineParameterCollect, True);
    FWG.AddEngineParameter2Grid;
    ShowMessage('TagNames are changed!');
  finally
    LEngineParameter.Free;
  end;
end;

procedure TWatchF2.UnCheckedAvgAllSelected1Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to FWG.NextGrid1.RowCount - 1 do
    if FWG.NextGrid1.Row[i].Selected then
      FWG.NextGrid1.CellByName['IsAvg',i].AsBoolean := not FWG.NextGrid1.Row[i].Selected;
end;

procedure TWatchF2.UnloadAddInPackage(var AOwner: TComponent; AModule: THandle);
var
  i: integer;
  M: TMemoryBasicInformation;
begin
  for i := AOwner.ComponentCount - 1 downto 0 do
  begin
    VirtualQuery(Classes.GetClass(AOwner.Components[i].ClassName), M, SizeOf(M));

    if (AModule = 0) or (HMODULE(M.AllocationBase) = AModule) then
    begin
      //FreeAndNil(AOWner.Components[i]);
      AOWner.Components[i].Free;
    end;
  end;

  UnRegisterModuleClasses(AModule);
  UnLoadPackage(AModule);
end;

procedure TWatchF2.UpButtonClick(Sender: TObject);
begin
  FWG.NextGrid1.MoveRow(FWG.NextGrid1.SelectedRow, FWG.NextGrid1.SelectedRow - 1);
  FWG.NextGrid1.SelectedRow := FWG.NextGrid1.SelectedRow - 1;
end;

procedure TWatchF2.DownButtonClick(Sender: TObject);
begin
  FWG.NextGrid1.MoveRow(FWG.NextGrid1.SelectedRow, FWG.NextGrid1.SelectedRow + 1);
  FWG.NextGrid1.SelectedRow := FWG.NextGrid1.SelectedRow + 1;
end;

procedure TWatchF2.DrawCaptionText(AText: string; ABrushColor: TColor);
var  ACanvas : TCanvas;
begin
  ACanvas := TCanvas.Create;
  try
    ACanvas.Handle := GetWindowDC(Self.Handle);

    with ACanvas do
    begin
      Brush.Color := ABrushColor;//clActiveCaption;
      Font.Name := 'Tahoma';
      Font.Size := 8;
      Font.Color := clred;
      Font.Style := [fsItalic, fsBold];
      TextOut(GetSystemMetrics(SM_CYMENU) +
              GetSystemMetrics(SM_CXBORDER),
              Round((GetSystemMetrics(SM_CYCAPTION) -
              Abs(Font.Height))/2) +1,
              AText);
    end;
  finally
    ReleaseDC(Self.Handle, ACanvas.Handle);
    ACanvas.Free;
  end;
end;

{Mouse로 Item을 Drag하여 Design Form의 Component 위에 떨어 뜨리면 pjhTag 정보가 할당 됨}
procedure TWatchF2.DropTextTarget4TagDrop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
begin
  if FEEPTarget4Tag.HasData then
  begin
    FEEPTarget4Tag.EPD.FEPItem.AssignTo(FWG.FTempParamItemRecord);

    case FEEPTarget4Tag.EPD.FDragDataType of
      dddtSingleRecord: begin
        if ssShift in FEEPTarget4Tag.EPD.FShiftState then
          SetTagInfo2ComponentUsingMouse(APoint);
      end;
    end;
  end;
end;

//procedure TWatchF2.OnAsynchronousIPCTask(const ATask: ITask);
//var
//  Result: IIPCData;
//  Request: IIPCData;
//  IPCClient: TIPCClient;
//  TimeStamp: TDateTime;
//begin
//  IPCClient := TIPCClient.Create;
//  try
//    //IPCClient.ComputerName := ATask.Values.Get('ComputerName').AsString;
//    IPCClient.ServerName := ATask.Values.Get('ServerName').AsString;
//
//    Request := AcquireIPCData;
//    Request.ID := IntToStr(Handle);// DateTimeToStr(Now);
//    Request.Data.WriteUTF8String('Command', Caption);
//    Result := IPCClient.ExecuteRequest(Request);
//
//    {if IPCClient.AnswerValid then
//    begin
//      ATask.Message.Ensure('ID').AsString := Result.ID;
//      TimeStamp := Result.Data.ReadDateTime('TDateTime');
//      ATask.Message.Ensure('TDateTime').AsString := DateTimeToStr(TimeStamp);
//      ATask.Message.Ensure('Integer').AsInteger := Result.Data.ReadInteger('Integer');
//      ATask.Message.Ensure('Real').AsFloat := Result.Data.ReadReal('Real');
//      ATask.Message.Ensure('String').AsString := string(Result.Data.ReadUTF8String('String'));
//      ATask.SendMessageAsync;
//    end;
//    }
//  finally
//    IPCClient.Free;
//  end;
//end;

procedure TWatchF2.OnChangeDispPanelColor(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  ChangeDispPanelColor(TColor(FCurrentChangeColor));
end;

procedure TWatchF2.OnRefreshTab(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  PageControl1.TabSettings.Height := FTempTabHeight;
//  PageControl1.Invalidate;
//  PageControl1.ActivePage.Invalidate;
//    PageControl1.ActivePage.Repaint;
end;

procedure TWatchF2.OnResetConnectClearMode(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  FConnectClearMode := False;
end;

procedure TWatchF2.OnResetCreateTagItemMode(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  FCreateTagItemWhenAltKeyDown := False;
end;

procedure TWatchF2.OnResetDestCompConnectMode(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  FDestCompConnectMode := False;
end;

procedure TWatchF2.OnResetMultiCompConnectMode(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  FMultiCompConnectMode := False;
end;

procedure TWatchF2.OnResetRevDestCompConnectMode(Sender: TObject;
  Handle: Integer; Interval: Cardinal; ElapsedTime: Integer);
begin
  FRevDestCompConnectMode := False;
end;

procedure TWatchF2.OnResetRevSrcCheckCompMode(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  FRevSrcCheckCompMode := False;
end;

procedure TWatchF2.OnResetRevSrcCompConnectMode(Sender: TObject;
  Handle: Integer; Interval: Cardinal; ElapsedTime: Integer);
begin
  FRevSrcCompConnectMode := False;
end;

procedure TWatchF2.OnResetSrcCompConnectMode(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  FSrcCompConnectMode := False;
end;

procedure TWatchF2.OnConnect(Sender: TIPCThread_HiMECS_MDI;
  Connecting: Boolean);
begin
  PostMessage(Handle, WM_UPDATESTATUS_HiMECS_MDI, WPARAM(Connecting), 0);
end;

procedure TWatchF2.OnGetHandlingKeyInfo(Sender: TObject; Key: Word;
  ShiftState: TShiftState; KeyDown: Boolean; var Job: TKeyJob);
begin
  ProcessKeyEventFrompjhSelector(ShiftState, Key);
end;

procedure TWatchF2.OnPostProcessMouseInfo(aPoint: TPoint;
  var aControl: TControl; var ControlRect, HandlerRect: TRect;
  var Job: TControlJob);
begin
  ProcessMouseEventFrompjhSelector(aPoint, aControl, ControlRect, HandlerRect, Job);
end;

{//Memory Leak 때문에 Calc32 Component 사용 불가함->cyMathparser로 대체 함 => 2013.9.11
procedure TWatchF2.OnDisplayCalculatedItemValue(Sender: TObject;
  Handle: Integer; Interval: Cardinal; ElapsedTime: Integer);
var
  it: DIterator;
  i,j,k,r: integer;
  LNameStrings, LStrList: TStringList;
  Largs : array [0..100] of extended;
  LDouble: Double;
begin
  LNameStrings := TStringList.Create;
  try
    it := FCompoundItemList.start;
    while iterateOver(it) do
    begin
      i := GetInteger(it);

      if i > (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1) then
        exit;

      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].SharedName = '' then
        exit;

      CalcExpress1.Formula :=
        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].SharedName;

      LNameStrings.Clear;
      LStrList := TStringList(FWG.NextGrid1.Row[i].Data);
      for j := 0 to TStringList(FWG.NextGrid1.Row[i].Data).Count - 1 do
      begin
        LNameStrings.Add(LStrList.Names[j]);
        k := StrToInt(LStrList.ValueFromIndex[j]);
        //k가 Collect 범위 내에 존재 하면
        if k < IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count then
          Largs[j] := StrToFloatDef(
            IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[k].Value,0.0);
      end;

      CalcExpress1.Variables := LNameStrings;//.Assign(LNameStrings);
      try
        LDouble := CalcExpress1.calc(Largs);
      except
        LDouble := 0;
      end;
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].Value :=
        Format('%.2f', [LDouble]);
      r := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].RadixPosition;
      if r = 0 then
        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].Value :=
          Format('%d', [Round(LDouble)]);

      WatchValue2Screen_Analog('', '', i);
    end;//while

  finally
    FreeAndNil(LNameStrings);
  end;
end;
}
//procedure TWatchF2.OnMessageComplete(const Msg: ITaskMessage);
//begin
//{  ListBox1.Items.Add(Format('ASynchronous Response with ID: %s', [Msg.Values.Get('ID').AsString]));
//  ListBox1.Items.Add(Format('Response: TDateTime [%s]', [Msg.Values.Get('TDateTime').AsString]));
//  ListBox1.Items.Add(Format('Response: Integer [%d]', [Msg.Values.Get('Integer').AsInteger]));
//  ListBox1.Items.Add(Format('Response: Real [%f]', [Msg.Values.Get('Real').AsFloat]));
//  ListBox1.Items.Add(Format('Response: String [%s]', [Msg.Values.Get('String').AsString]));
//  ListBox1.Items.Add('-----------------------------------------------------------');
//}
//end;

procedure TWatchF2.OnSignal(Sender: TIPCThread_HiMECS_MDI; Data: TEventData_HiMECS_MDI);
begin
  Flags := Data.Flags;
end;

procedure TWatchF2.OnWindowCaptionDrag;
const
  sc_DragMove = $F012;
begin
  ReleaseCapture;
  Perform( wm_SysCommand, sc_DragMove, 0 );
end;

//AIsUseWatchList = True : WatchList 및 Trend Data 설정이 완료된 상태임
//                         Load Watch List From File를 먼저 실행 해야 함.
//                         따라서 읽어오는 파일 내용이 WatchList와 일치해야 함.
//        False: 파일 내용 만으로 Watch List 재구성함.(Parameter내용이 불완전함)
procedure TWatchF2.OpenTrendDataFile(AIsUseWatchList: Boolean);
var
  LFileName: string;
  i: integer;
  LIsFirst: Boolean;
begin
  JvOpenDialog1.Options := JvOpenDialog1.Options + [ofAllowMultiSelect];
  JvOpenDialog1.InitialDir := FFilePath;

  if JvOpenDialog1.Execute then
  begin
    for i := 0 to JvOpenDialog1.Files.Count - 1 do
    begin
      LIsFirst := i = 0;

      LFileName := JvOpenDialog1.Files[i];
      LoadTrendDataFromFile(LFileName, LIsFirst, AIsUseWatchList);
      PageControl1.ActivePage := TrendTabSheet;
    end;
  end;
end;

procedure TWatchF2.PageControl1Change(Sender: TObject);
var
  i: integer;
begin
  if FIsLoadingDFC then
    exit;

  if PageControl1.ActivePageIndex >= DYNAMIC_PAGE_INDEX then
  begin
    AssignPanel2Designer(FDesignManagerForm);
    AssignPanel2DropTraget;
  end;

  //FColsedPageIndex := -1;
end;

procedure TWatchF2.PageControl1Changing(Sender: TObject; FromPage,
  ToPage: Integer; var AllowChange: Boolean);
begin
  if FromPage >= DYNAMIC_PAGE_INDEX then
    if FColsedPageIndex <> FromPage then
      SaveDesignMode2ControlTag(FromPage);
end;

procedure TWatchF2.PageControl1ClosedPage(Sender: TObject; PageIndex: Integer);
begin
  FColsedPageIndex := -1;
end;

procedure TWatchF2.PageControl1ClosePage(Sender: TObject; PageIndex: Integer;
  var Allow: Boolean);
begin
  if PageIndex >= DYNAMIC_PAGE_INDEX then
  begin
    if FIgnorePageCloseConfirm then
    begin
      FColsedPageIndex := PageIndex;
      DestroyComponentOnPage(PageControl1.AdvPages[PageIndex]);
      FIgnorePageCloseConfirm := False;
    end
    else
    if MessageDlg('Are you sure to close this tab?',
                              mtConfirmation, [mbYes, mbNo], 0)= mrYes then
    begin
      FColsedPageIndex := PageIndex;
      DestroyComponentOnPage(PageControl1.AdvPages[PageIndex]);
    end
    else
      Allow := False;
  end;
end;

procedure TWatchF2.PageControl1InsertPage(Sender: TObject;
  APage: TAdvOfficePage);
var
  LDesignPanel: TELDesignPanel;
  LPanel: TpjhPanel;
  si: TScrollInfo;
begin
  APage.ShowClose := True;
  APage.PopupMenu := PopupMenu3;
  LDesignPanel := TELDesignPanel.Create(APage);
  LDesignPanel.Parent := APage;
  LDesignPanel.Align := alClient;
//  LDesignPanel.AutoScroll := True;
//  LDesignPanel.VertScrollBar.Visible := True;

//  APage.Tag := 999;//for showscrollbar
  LPanel := TpjhPanel.Create(APage); //LoadDFMFromFile() 샐행 후 LPanel 속성도 파일내용으로 Update됨(Name 및 Tag 값이 파일에서 읽어옴
//  LPanel.Name := 'DesignPanel_' + IntToStr(APage.PageIndex);
  LPanel.Parent := LDesignPanel;
  LPanel.Align := alClient;
  LPanel.OnMouseDown := pjhPanelMouseDown;

  if LPanel.ShowScrollBar then
  begin
    si.cbSize := SizeOf(TScrollInfo);
    si.fMask := SIF_ALL or SIF_DISABLENOSCROLL;
    si.nMin := 0;
    si.nMax := 3 * LPanel.ClientHeight;
    si.nPage := LPanel.ClientHeight div 2;
    si.nPos := 0;
    SetScrollInfo(LPanel.Handle, SB_VERT, si, true);
    si.nMax := 2 * LPanel.ClientWidth;
    si.nPage := LPanel.ClientWidth div 2;
    SetScrollInfo(LPanel.Handle, SB_HORZ, si, true);
  end;

  AssignPanel2Designer(FDesignManagerForm);
end;

procedure TWatchF2.pjhPanelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  OnWindowCaptionDrag;
end;

function TWatchF2.PrepareXYGraph(AArray: DArray; AIsChannelClear: Boolean): Boolean;
var
  i,j,k: integer;
  LXYInfo: TXYGraphInfo;
  it: Diterator;
begin
  Result := False;

  for i := 0 to FWG.NextGrid1.RowCount - 1 do
  begin
    if FWG.NextGrid1.Row[i].Selected then
    begin
      LXYInfo := TXYGraphInfo.Create;
      LXYInfo.FTagname := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].Description;
      LXYInfo.FParameterIndex := i;
      AArray.add([LXYInfo]);

      if AArray.Size = 2 then
      begin
        with TAxisSelectF.Create(nil) do
        begin
          try
            XYSelectGrid.AddRow(2);

            it := AArray.start;
            LXYInfo := GetObject(it) as TXYGraphInfo;
            XYSelectGrid.Cells[0,0] := LXYInfo.FTagname;

            advance(it);
            LXYInfo := GetObject(it) as TXYGraphInfo;
            XYSelectGrid.Cells[0,1] := LXYInfo.FTagname;

            while True do
            begin
              if ShowModal = mrOK then
              begin
                if ((XYSelectGrid.Cells[1,0] = 'X') and (XYSelectGrid.Cells[1,1] = 'X')) or
                  ((XYSelectGrid.Cells[1,0] = 'Y') and (XYSelectGrid.Cells[1,1] = 'Y')) then
                begin
                  ShowMessage('X and Y axis should be selected only once!');
                  continue;
                end;

                if (XYSelectGrid.Cells[1,0] = '') or (XYSelectGrid.Cells[1,1] = '') then
                begin
                  ShowMessage('Choose X or Y Axis!');
                  XYSelectGrid.SelectCell(1,0);
                  continue;
                end;

                if AIsChannelClear then
                  DeleteFromXYGraph1Click(nil); //XY Graph 초기화(기존 데이터 제거)

                it := AArray.start;
                LXYInfo := GetObject(it) as TXYGraphInfo;
                LXYInfo.FAxis := GetAxisFromString(XYSelectGrid.Cells[1,0]);

                if XYSelectGrid.Cells[2,0] <> '' then
                begin
                  LXYInfo.FUseConstant := XYSelectGrid.Cell[2,0].AsBoolean;
                end;

                LXYInfo.FIsDuplicated := CheckBox1.Checked;
                j := LXYInfo.FParameterIndex;
                IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[j].IsDisplayXY := True;
                FWG.NextGrid1.CellByName['XYDisplay', j].AsInteger := 1;

                advance(it);
                LXYInfo := GetObject(it) as TXYGraphInfo;
                LXYInfo.FAxis := GetAxisFromString(XYSelectGrid.Cells[1,1]);

                if XYSelectGrid.Cells[2,1] <> '' then
                begin
                  LXYInfo.FUseConstant := XYSelectGrid.Cell[2,1].AsBoolean;
                end;

                j := LXYInfo.FParameterIndex;
                IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[j].IsDisplayXY := True;
                FWG.NextGrid1.CellByName['XYDisplay', j].AsInteger := 1;
                Result := True;

                if AIsChannelClear then
                begin
                  for k := 0 to iXYPlot1.ChannelCount - 1 do
                    iXYPlot1.Channel[k].Clear;//그래프 초기화
                end;

                break;
              end
              else
              begin
                exit;
              end;
            end;
          finally
            free;
          end;
        end;

        break;
      end;//LStrList.Count = 2
    end;
  end; //for
end;

procedure TWatchF2.ProcessKeyEvent4CreateItem(AShiftState: TShiftState;
  ACharCode: word);
begin
  if ssAlt in AShiftState then
  begin
    FCreateTagItemWhenAltKeyDown := True;
    FPJHTimerPool.AddOneShot(OnResetCreateTagItemMode, 100);
  end;
end;

procedure TWatchF2.ProcessKeyEvent4NextStep(AShiftState: TShiftState; ACharCode: word);
begin
  if ssAlt in AShiftState then
  begin
    if (ACharCode = Ord('1')) then
    begin
      FSrcCompConnectMode := True;
      FPJHTimerPool.AddOneShot(OnResetSrcCompConnectMode,200);
    end
    else
    if (ACharCode = Ord('2')) then
    begin
      FDestCompConnectMode := True;
      FPJHTimerPool.AddOneShot(OnResetDestCompConnectMode,200);
    end
    else
    if (ACharCode = Ord('3')) then
    begin
      FRevSrcCompConnectMode := True;
      FPJHTimerPool.AddOneShot(OnResetRevSrcCompConnectMode,200);
    end
    else
    if (ACharCode = Ord('4')) then
    begin
      FRevDestCompConnectMode := True;
      FPJHTimerPool.AddOneShot(OnResetRevDestCompConnectMode,200);
    end
    else
    if (ACharCode = Ord('5')) then
    begin
      FRevSrcCheckCompMode := True;
      FPJHTimerPool.AddOneShot(OnResetRevSrcCheckCompMode,200);
    end
    else
    if (ACharCode = Ord('D')) then
    begin
      FConnectClearMode := True;
      FPJHTimerPool.AddOneShot(OnResetConnectClearMode,200);
    end
  end
  else
  if ssShift in AShiftState then
  begin
//      if (ACharCode = Ord('Q')) then
//      begin
      FMultiCompConnectMode := True;
      FPJHTimerPool.AddOneShot(OnResetMultiCompConnectMode,100);
//      end;
  end;
end;

procedure TWatchF2.ProcessKeyEventFrompjhSelector(AShiftState: TShiftState;
  ACharCode: word);
begin
  if FComponentConnectMode then
    ProcessKeyEvent4NextStep(AShiftState, ACharCode)
  else
  if FCreateTagItemMode then
    ProcessKeyEvent4CreateItem(AShiftState, ACharCode);
end;

procedure TWatchF2.ProcessMouseEvent4CheckCircularNextStep(aPoint: TPoint;
  aControl: TControl; ControlRect, HandlerRect: TRect; Job: TControlJob);
begin
  FCheckCircularNextStepList.Clear;
  CheckCirculationOfNextStep(aControl, FCheckCircularNextStepList);
end;

procedure TWatchF2.ProcessMouseEvent4CreateItem(aPoint: TPoint;
  aControl: TControl; ControlRect, HandlerRect: TRect; Job: TControlJob);
begin
  if FCreateTagItemWhenAltKeyDown then //Alt Key 버튼을 누르는 동안(Button Up 후 0.1초 후 리셋됨)
  begin
    SetCreateItem4SelectedComponent(aControl, Job);
  end;
end;

procedure TWatchF2.ProcessMouseEvent4NextStep(aPoint: TPoint;
  aControl: TControl; ControlRect, HandlerRect: TRect; Job: TControlJob);
begin
  if FSrcCompConnectMode then //Alt+1 버튼을 누르는 동안(Button Up 후 1초 후 리셋됨)
  begin
    SetSourceComponent(aControl); //Mouse로 선택한 컴포넌트 저장
  end
  else
  if FDestCompConnectMode then //Alt+2 버튼을 누르는 동안(Button Up 후 1초 후 리셋됨)
  begin
    SetDestinationConnect(aControl) //Source Component의 "Next Step"에 Mouse로 선택한 컴포넌트 연결
  end
  else
  if FRevSrcCompConnectMode then //Alt+3 버튼을 누르는 동안(Button Up 후 1초 후 리셋됨)
  begin
    SetRevSourceComponent(aControl); //Mouse로 선택한 컴포넌트 저장
  end
  else
  if FRevDestCompConnectMode then //Alt+4 버튼을 누르는 동안(Button Up 후 1초 후 리셋됨)
  begin
    SetRevDestinationConnect(aControl) //Source Component의 "Next Step"에 Mouse로 선택한 컴포넌트 연결
  end
  else
  if FRevSrcCheckCompMode then //Alt+5 버튼을 누르는 동안(Button Up 후 1초 후 리셋됨)
  begin
    SetRevSrcCheckComp(aControl) //Source Component의 "Next Step"에 Mouse로 선택한 컴포넌트 연결
  end
  else
  if FConnectClearMode then //Alt+D 버튼을 누르는 동안(Button Up 후 1초 후 리셋됨)
  begin
    ClearXStep(aControl) //Source Component의 "Next Step"에 Mouse로 선택한 컴포넌트 연결
  end
  else
  if FMultiCompConnectMode then //Shift 버튼을 누르는 동안(Button Up 후 0.1초 후 리셋됨)
  begin
    SetMultiSelectConnect(aControl, Job) //Source Component의 "Next Step"에 Mouse로 선택한 컴포넌트 연결
  end;
end;

procedure TWatchF2.ProcessMouseEventFrompjhSelector(aPoint: TPoint; aControl: TControl;
  ControlRect, HandlerRect: TRect; Job: TControlJob);
begin
  //PopUp Menu에서 "Set ComponentConnectMode"를 Check 상태로 변경
  if FComponentConnectMode then
    ProcessMouseEvent4NextStep(aPoint, aControl, ControlRect, HandlerRect, Job)
  else
  if FCreateTagItemMode then //PopUp Menu에서 "Set Create Item 4 Selected" 를 Check 상태로 변경
    ProcessMouseEvent4CreateItem(aPoint, aControl, ControlRect, HandlerRect, Job)
  else
  if FCheckCircularNextStepMode then
    ProcessMouseEvent4CheckCircularNextStep(aPoint, aControl, ControlRect, HandlerRect, Job)
end;

procedure TWatchF2.ProcessResults;
var
  msg: TOmniMessage;
  LStompFrame: IStompFrame;
begin
  while FpjhSTOMPClass.GetResponseQMsg(msg) do
  begin
    LStompFrame := msg.MsgData.AsInterface as IStompFrame;
    IPCMonitorAll1.ProcessDataFromMQ(LStompFrame.GetBody);
//    Memo1.Lines.Add('******' + LEventData.EngineName + '****** Pulse Event OK!');
  end;
end;

procedure TWatchF2.Properties1Click(Sender: TObject);
begin
  FWG.ShowProperties;
end;

procedure TWatchF2.ReadComponentsProc(Reader: TReader; const Message: string;
  var Handled: Boolean);
begin
  Handled := True;
  ShowMessage(Message);
end;

function TWatchF2.RecvSimulateParamDataFromgpShMM(var AData: string): integer;
var
  LStrList: TStringList;
begin
  Result := -1;

  LStrList := TStringList.Create;
  try
    if IPCMonitorAll1.FgpSharedMM.AcquireMemory(False, INFINITE) <> nil then
    begin
//      if not FgpSharedMM.Modified then
      LStrList.LoadFromStream(IPCMonitorAll1.FgpSharedMM.AsStream);

      if IntToStr(GetCurrentProcessId) = LStrList.Strings[0] then
        Result := 1;

      AData := LStrList.Strings[1];
//      ShowMessage(LStrList.text);
    end;
  finally
    if IPCMonitorAll1.FgpSharedMM.Acquired then
      IPCMonitorAll1.FgpSharedMM.ReleaseMemory;

    LStrList.Free;
  end;
end;

procedure TWatchF2.Refresh1Click(Sender: TObject);
var
  LPanel: TpjhPanel;
  LDFName: string;
  i,j: integer;
begin
  j := PageControl1.ActivePageIndex;

  if FDesignFormConfig.DesignFormConfigCollect.Count > (j - 5) then
  begin
    LDFName := '';

    if not FCommandLine.IsOnlyOneForm then
      LDFName := FDesignFormConfig.DesignFormConfigCollect.Items[j-5].DesignFormFileName;

    if LDFName = '' then
      LDFName := PageControl1.ActivePage.Hint; //Page Hint에 Full Path Form File Name이  저장 되어 있음

    PageControl1.ActivePage.Caption := FDesignFormConfig.DesignFormConfigCollect.Items[j-5].DesignFormCaption;
    LPanel := GetTpjhPanelOfCurrentPage;
    RemoveControlsOnPanel(LPanel);
    LoadDesignFormFromDFM(LDFName);

//    LoadFromDFM(LDFName, TWinControl(LPanel), ReadComponentsProc);
//    LoadComponentFromFile(TComponent(LPanel), LDFName);

    NxAlertWindow1.Caption := '※.Design Form Name';
    NxAlertWindow1.Text := ExtractFilepath(LDFName) + #13#10 + ExtractFileName(LDFName);
    NxAlertWindow1.Width := Length(NxAlertWindow1.Text) * 6;
    NxAlertWindow1.Popup;
  end;
end;

procedure TWatchF2.RefreshControlsOnActivePage;
var
  i, j, PnlIndex: integer;
  LPanel: TpjhPanel;
  IpjhDI: IpjhDesignCompInterface;
begin
  with PageControl1.ActivePage do
  begin
    LPanel := GetTpjhPanelOfCurrentPage;

    for i := 0 to LPanel.ComponentCount - 1 do
    begin
      if Supports(LPanel.Components[i], IpjhDesignCompInterface, IpjhDI) then
      begin
        TControl(LPanel.Components[i]).Refresh;
      end;
    end;//for
  end;//with
end;

procedure TWatchF2.RemoveControlsOnPanel(AControl: TPanel);
var
  i: integer;
begin
  for i := AControl.ControlCount - 1 downto 0 do
    AControl.Controls[i].Free;
end;

//x축이 key값이면 AIsXAxis = true
procedure TWatchF2.ReplaceOrAddMap(AMap: DMultiMap; AKey, AValue: double;
  AIsXAxis: Boolean);
var
  it: DIterator;
  LDoublePoint : TDoublePoint;
begin
  it := AMap.locate([AKey]);
  LDoublePoint := GetObject(it) as TDoublePoint;
  if Assigned(LDoublePoint) then
  begin
    if AIsXAxis then  //Key Is X Axis
      LDoublePoint.Y := AValue
    else
      LDoublePoint.X := AValue
  end
  else
  begin
    LDoublePoint := TDoublePoint.Create;
    if AIsXAxis then  //Key Is X Axis
    begin
      LDoublePoint.X := AKey;
      LDoublePoint.Y := AValue;
    end
    else
    begin
      LDoublePoint.Y := AKey;
      LDoublePoint.X := AValue;
    end;
    AMap.putPair([AKey, LDoublePoint]);
  end;
end;

procedure TWatchF2.ResetAvgValue1Click(Sender: TObject);
var
  i: integer;
begin
  FWG.StopAvgCalc;

  for i := 0 to FWG.NextGrid1.RowCount - 1 do
    if FWG.NextGrid1.CellByName['IsAvg',i].AsBoolean then
      FWG.NextGrid1.CellByName['IsAvg',i].AsBoolean := False;
end;

procedure TWatchF2.MakeModbusCommandFromGrid(AType: TOfficeFileType);
var
  LEngParamDic: TObjectDictionary<string, TEngineParameterCollect>;
  LEngParam, LEngParamSrc: TEngineParameterCollect;
  LEngParamItem, LEngParamItemSrc: TEngineParameterItem;
  LFileName, LKey: string;
  i: integer;
begin
  if AType = oftSqlite then
  begin
    JvSaveDialog1.InitialDir := FFilePath + 'db';
    JvSaveDialog1.Filter := '*.sqlite|*.*';
  end
  else if AType = oftExcel then
  begin
    JvSaveDialog1.InitialDir := FFilePath + 'db';
    JvSaveDialog1.Filter := '*.xls|*.xlsx|*.*';
  end;


  if JvSaveDialog1.Execute then
  begin
    LFileName := JvSaveDialog1.FileName;

    if FileExists(LFileName) then
    begin
      if MessageDlg('File is already existed. Are you overwrite? if No press, then the data is not saved!',
        mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
  end;

  //string: Function Code
  //Modbus Function Code별로 TEngineParameterCollect 생성하여 LEngParamDic에 저장함
  //주소가 같더라도 Function Code가 다르면 Sort할때 분리해야 하기 때문임.
  LEngParamDic := TObjectDictionary<string, TEngineParameterCollect>.Create([doOwnsValues]);
  try
    LEngParamSrc := IPCMonitorAll1.FEngineParameter.EngineParameterCollect;

    for i := 0 to LEngParamSrc.Count - 1 do
    begin
      LEngParamItemSrc := LEngParamSrc.Items[i];

      if LEngParamItemSrc.Address = '' then
        Continue;

      if not LEngParamDic.ContainsKey(LEngParamItemSrc.FCode) then
        LEngParamDic.Add(LEngParamItemSrc.FCode, TEngineParameterCollect.Create(TEngineParameterItem));

      if LEngParamDic.TryGetValue(LEngParamItemSrc.FCode, LEngParam) then
      begin
        LEngParamItem := LEngParam.Add;
        LEngParamItem.Assign(LEngParamItemSrc);
      end;
    end;

    for LKey in LEngParamDic.Keys do
    begin
      LEngParam := LEngParamDic.Items[LKey];

      if LEngParam.Count = 0 then
        break;

      LEngParam.Sort;

      if AType = oftSqlite then
        TEngineParameter.SaveEngParamCollect2DB(LFileName, LEngParam)
      else if AType = oftExcel then
        TEngineParameter.SaveToExcelFile(LFileName, LEngParam);
    end;
  finally
    LEngParamDic.Free;
  end;
end;

function TWatchF2.MakeXYDataFromFile(AArray: DArray;AFileName: string; AIsFirst: Boolean;
  AXYMap: DMultiMap; AIsDuplicate: Boolean): Boolean;
//AArray: tagname과 axes(aX, aY) 정보 있음.
//AIsDuplicate: true = 중복데이터 허용
//              false = 기존데이터는 replace
var
  LArray, LArray2, LArray3: DArray;
  LDoublePoint, LDoublePoint2: TDoublePoint;
  it, it2, it3: Diterator;
  LXYInfo: TXYGraphInfo;
  LChange: Boolean;
  LMultiMap: DMultiMap;
  LStr: string;
  LStrList: TStringList;
begin
  Result := True;
  LStrList:= TStringList.Create;
  try
    LStrList.LoadFromFile(AFileName);

    if LStrList.Count > 0 then
    begin
      LArray3 := DArray.Create;

      try
        //LArray3에 데이터 저장 후 최종적으로 MultiMap에 저장함.
        LMultiMap := DMultiMap.Create;
        it3 := AArray.start;
        LXYInfo := GetObject(it3) as TXYGraphInfo;
        LStr := LXYInfo.FTagname;

        advance(it3);
        LXYInfo := GetObject(it3) as TXYGraphInfo;
        if LXYInfo.FAxis = aY then
          LStr := LStr + ';' + LXYInfo.FTagname
        else if LXYInfo.FAxis = aX then
          LStr := LXYInfo.FTagname + ';' + LStr;
        
        FillXYMapFromFile(LMultiMap, LStrList, AIsDuplicate, LStr);
        AXYMap.putPair([LStr,LMultiMap])
      finally
        ObjFree(LArray3);
        LArray3.Free;
      end;
    end;
  finally
    FreeAndNil(LStrList);
  end;
end;

procedure TWatchF2.MaxValue1Click(Sender: TObject);
begin
  FIsMaxValueGraph := True;
  FMaxValueChannel := iPlot1.AddChannel;
  iPlot1.Channel[FMaxValueChannel].VisibleInLegend := False;
  FMaxValueX := 0;
  MaxValue1.Enabled := False;
end;

procedure TWatchF2.MergeCommandJsonFromJsonOfSimData(ASrcJson: string; var ADestJson: string);
var
  LSOSrc, LSODest: ISuperObject;
  LRecToPass2: TRecToPass2;
  LCompName, LPropName, LValue: string;
  Li, j: integer;
begin //다른 Watch2로부터 수신한 CommandJson을 현재 폼의 FSimulateCompValuesJson(ADestJson)에 Merge함.
  LSOSrc := TSuperObject.Create(ASrcJson);
  LSODest := TSuperObject.Create(ADestJson);

  with LSOSrc.A['Components'] do
  begin
    for Li := 0 to Length - 1 do
    begin
      LCompName := O[Li].S['CompName'];
      StrLCopy(LRecToPass2.CompName, PChar(LCompName), High(LRecToPass2.CompName));

      with O[Li].A['Properties'] do
      begin
        for j := 0 to Length - 1 do
        begin
          LPropName := O[j].S['PropName'];
          LValue := O[j].S['Value'];

          StrLCopy(LRecToPass2.PropName, PChar(LPropName), High(LRecToPass2.PropName));
          StrLCopy(LRecToPass2.Value, PChar(LValue), High(LRecToPass2.Value));

          FindNAddCompValueFromCommandJson(LRecToPass2, ADestJson);
        end;//for j
      end;//with
    end;//For Li
  end;//with LSOSrc.A['Components']
end;

procedure TWatchF2.MergeCommandJsonwith1Click(Sender: TObject);
begin
  MergeCommandJsonFromJsonOfSimData(FSimulateCompValuesJson4ConnectNextStep, FSimulateCompValuesJson);
end;

procedure TWatchF2.abShowHide1Click(Sender: TObject);
begin
  ToggleTabShow;
end;

procedure TWatchF2.AddAlarmValue1Click(Sender: TObject);
var
  i: integer;
begin
  if FWG.NextGrid1.SelectedCount = 1 then
  begin
    i := FWG.NextGrid1.SelectedRow;

    if not IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrend then
    begin
      ShowMessage('Please execute ''Add To Trend'' Frist!');
      exit;
    end;

    if (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].MinAlarmEnable) or
      (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].MaxAlarmEnable) then
    begin
      AddChannelAndYAxis(i, tdtAlarm);
    end
    else
    begin
      ShowMessage('Please set the Min or Max Alarm Enable in configuration!');
      exit;
    end;

  end
  else
    ShowMessage('Selected item should be only one for this function');
end;

procedure TWatchF2.AddBpllist2DFConfig(ABplist: TStringList;
  ADfc: TDesignFormConfig);
var
  i: integer;
  LStr: string;
begin
  LStr := '';

  for i := 0 to ABplist.Count - 1 do
    ABplist.Strings[i] := ExtractFileName(ABplist.Strings[i]);

  ADfc.DesignFormConfigCollect.Add.BplFileList := ABplist.CommaText;
end;

//ACheckTrendType=
//Alarm 과 Fault의 경우에는 Channel만 생성하고 Y Axis는 생성 안함
//Alarm과 Fault의 경우 이미 IsDisplayTrend 상태임
function TWatchF2.AddChannelAndYAxis(AParamIndex: integer; ACheckTrendType: TTrendDataType): integer;
var
  i,j,k: integer;
begin
  case ACheckTrendType of //기존 display시에는 중복 방지하기 위함
    tdtValue: begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].IsDisplayTrend then
        exit;
    end;
    tdtAlarm: begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].IsDisplayTrendAlarm then
        exit;
    end;
    tdtFault: begin
      if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].IsDisplayTrendFault then
        exit;
    end;
  end;

  k := iPlot1.AddChannel;

  case ACheckTrendType of //기존 display시에는 중복 방지하기 위함
    tdtValue: begin
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].IsDisplayTrend := True;
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].TrendChannelIndex := k;
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].PlotXValue := 0;
      FWG.NextGrid1.CellByName['TrendDisplay', AParamIndex].AsInteger := 1;

      j := iPlot1.AddYAxis;
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].TrendYAxisIndex := j;
      iPlot1.YAxis[j].Name := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].TagName;
      iPlot1.YAxis[j].ScaleLinesColor := iPlot1.Channel[k].Color;
      iPlot1.YAxis[j].LabelsFont.Color := iPlot1.Channel[k].Color;
      iPlot1.YAxis[j].Min := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].YAxesMinValue;
      iPlot1.YAxis[j].Span := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].YAxesSpanValue;
      iPlot1.Channel[k].YAxisName := iPlot1.YAxis[j].Name;
      iPlot1.Channel[k].TitleText := iPlot1.YAxis[j].Name;
      iPlot1.Channel[k].Name := 'C_'+ iPlot1.YAxis[j].Name;
      iPlot1.YAxis[j].Title := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].Description;
      iPlot1.YAxis[j].Name := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].TagName;
    end;
    tdtAlarm: begin
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].IsDisplayTrendAlarm := True;
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].TrendAlarmIndex := k;
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].PlotXValue := 0;
      i := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].TrendYAxisIndex;
      iPlot1.Channel[k].YAxisName := iPlot1.YAxis[i].Name;
      iPlot1.Channel[k].TitleText := iPlot1.YAxis[i].Name + '''s Alarm';
      iPlot1.Channel[k].Name := 'C_'+ iPlot1.YAxis[i].Name + '_Alarm';
    end;
    tdtFault: begin
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].IsDisplayTrendFault := True;
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].TrendFaultIndex := k;
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].PlotXValue := 0;
      i := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].TrendYAxisIndex;
      iPlot1.Channel[k].YAxisName := iPlot1.YAxis[i].Name;
      iPlot1.Channel[k].TitleText := iPlot1.YAxis[i].Name + '''s Fault';
      iPlot1.Channel[k].Name := 'C_'+ iPlot1.YAxis[i].Name + '_Fault';
    end;
  end;

  PageControl1.ActivePage := TrendTabSheet;
end;

procedure TWatchF2.AddCompValue2Json(const ACompName, APropName, AValue: string;
  AValueType: integer; var ADestJson: string);
var
  LSO: ISuperObject;
  LResult: string;
  LAdd, LIsPropAdd: Boolean;
  Li,j, LCompNameIdx, LPropNameIdx, LLength: integer;
begin
  LCompNameIdx := -1;
  LPropNameIdx := -1;

  LSO := TSuperObject.Create(ADestJson);

  with LSO.A['Components'] do
  begin
    for Li := 0 to Length - 1 do
    begin
      //Json에 CompName이 존재하므로 CompName을 추가하지 않고 Property를 검사함
      if O[Li].S['CompName'] = ACompName then
      begin
        LCompNameIdx := Li;

        with O[Li].A['Properties'] do
        begin
          for j := 0 to Length - 1 do
          begin
            if O[j].S['PropName'] = APropName then
            begin
              LPropNameIdx := j;
            end;
          end;//for
        end;
      end;
    end;//for
  end;//with

  LAdd := LCompNameIdx = -1;

  if LAdd then//CompName & Property Add
  begin
    LCompNameIdx := LSO.A['Components'].Length;
//      LCompNameIdx := 0;
    LPropNameIdx := 0;

    With LSO.A['Components'].O[LCompNameIdx] do
    begin
      S['CompName'] := ACompName;
    end;//with
  end
  else //Property Add or Update(Delete and Add)
  begin
    LIsPropAdd := LPropNameIdx = -1;

    if not LIsPropAdd then
    begin
      LSO.A['Components'].O[LCompNameIdx].A['Properties'].Delete(
        function(Arg: IMember): Boolean
        begin
          with Arg.AsObject do
            Result := S['PropName'] = APropName
        end);
    end;

    LPropNameIdx := LSO.A['Components'].O[LCompNameIdx].A['Properties'].Length;
  end;

  With LSO.A['Components'].O[LCompNameIdx] do
  begin
    with A['Properties'].O[LPropNameIdx] do
    begin
      S['PropName'] := APropName;
      I['PropTyprKind'] := AValueType;
      S['Value'] := AValue;
    end;
  end;

  ADestJson := LSO.AsJSON;
end;

procedure TWatchF2.AddData2TrendMap(AParameterIndex: integer; AXValue, AYValue: double);
var
  it: Diterator;
  LArray: DArray;
  LDoublePoint: TDoublePoint;
  LStr: string;
begin
  LStr := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParameterIndex].TagName;
  it := FTrendDataMap.locate( [LStr] );

  if not atEnd(it) then
  begin
    LArray := GetObject(it) as DArray;

    LDoublePoint := TDoublePoint.Create;
    LDoublePoint.X := AXValue;
    LDoublePoint.Y := AYValue;
    LArray.add([LDoublePoint]);
  end
  else
  begin
    LArray := DArray.Create;

    LDoublePoint := TDoublePoint.Create;
    LDoublePoint.X := AXValue;
    LDoublePoint.Y := AYValue;
    LArray.add([LDoublePoint]);

    FTrendDataMap.putPair([LStr, LArray]);
  end;

end;

procedure TWatchF2.AddData2TrendMapFromFile(AKeyName: string; AXValue,
  AYValue: double);
var
  it: Diterator;
  LArray: DArray;
  LDoublePoint: TDoublePoint;
begin
  it := FTrendDataMapFromFile.locate( [AKeyName] );

  if not atEnd(it) then
  begin
    LArray := GetObject(it) as DArray;

    LDoublePoint := TDoublePoint.Create;
    LDoublePoint.X := AXValue;
    LDoublePoint.Y := AYValue;
    LArray.add([LDoublePoint]);
  end
  else
  begin
    LArray := DArray.Create;

    LDoublePoint := TDoublePoint.Create;
    LDoublePoint.X := AXValue;
    LDoublePoint.Y := AYValue;
    LArray.add([LDoublePoint]);

    FTrendDataMapFromFile.putPair([AKeyName, LArray]);
  end;
end;

procedure TWatchF2.AddData2XYMap(AParameterIndex: integer; AXValue,
  AYValue: double);
var
  it: Diterator;
  LArray: DArray;
  LDoublePoint: TDoublePoint;
  LStr: string;
begin
  LStr := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParameterIndex].TagName;
  it := FXYDataMap.locate( [LStr] );

  if not atEnd(it) then
  begin
    LArray := GetObject(it) as DArray;

    LDoublePoint := TDoublePoint.Create;
    LDoublePoint.X := AXValue;
    LDoublePoint.Y := AYValue;
    LArray.add([LDoublePoint]);
  end
  else
  begin
    LArray := DArray.Create;

    LDoublePoint := TDoublePoint.Create;
    LDoublePoint.X := AXValue;
    LDoublePoint.Y := AYValue;
    LArray.add([LDoublePoint]);

    FXYDataMap.putPair([LStr, LArray]);
  end;
end;

procedure TWatchF2.AddJsonCompValue4Simulate(ARecToPass: TRecToPass2; var ADestJson: string);
//기존의 JSON(FSimulateCompValuesJson)에 수신된 Component name 및 Value를 추가함.
var
  LSO: ISuperObject;
  LResult, LCompName, LPropName, LValue: string;
  LAdd, LIsPropAdd: Boolean;
  Li,j, LCompNameIdx, LPropNameIdx, LLength: integer;
begin
//  LCompNameIdx := -1;
//  LPropNameIdx := -1;
//
//  LCompName := String(ARecToPass.CompName);
//  LPropName :=  String(ARecToPass.PropName);
//  LValue := String(ARecToPass.Value);

  //Size가 255보다 크면 SendCopy로 보낼수가 없으므로 LValue에 아래 내용을 보내고
  //직접 컴포넌트에서 Value를 가져옴
  if LValue = 'Length is over 255!' then
    LValue := FindNGetCompStringValueFromDesignForm(LCompName, LPropName);

  FindNAddCompValueFromCommandJson(ARecToPass, ADestJson);

//  LSO := TSuperObject.Create(ADestJson);
//
////  LResult := LSO.A['Components'].Where(function(Arg: IMember): Boolean
////    begin
////      with Arg.AsObject do
////        Result := S['CompName'] = LCompName
////    end).AsJson;
////
////  //CompName이 기존 JSON에 없으면 Add 존재하면 Update
////  LAdd := LResult = '[]';
//
//  with LSO.A['Components'] do
//  begin
//    for Li := 0 to Length - 1 do
//    begin
//      //Json에 CompName이 존재하므로 CompName을 추가하지 않고 Property를 검사함
//      if O[Li].S['CompName'] = LCompName then
//      begin
//        LCompNameIdx := Li;
//
//        with O[Li].A['Properties'] do
//        begin
//          for j := 0 to Length - 1 do
//          begin
//            if O[j].S['PropName'] = LPropName then
//            begin
//              LPropNameIdx := j;
//            end;
//          end;//for
//        end;
//      end;
//    end;//for
//  end;//with
//
//  LAdd := LCompNameIdx = -1;
//
//  if LAdd then//CompName & Property Add
//  begin
//    LCompNameIdx := LSO.A['Components'].Length;
////      LCompNameIdx := 0;
//    LPropNameIdx := 0;
//
//    With LSO.A['Components'].O[LCompNameIdx] do
//    begin
//      S['CompName'] := LCompName;
//    end;//with
//  end
//  else //Property Add or Update(Delete and Add)
//  begin
//    LIsPropAdd := LPropNameIdx = -1;
//
//    if not LIsPropAdd then
//    begin
//      LSO.A['Components'].O[LCompNameIdx].A['Properties'].Delete(
//        function(Arg: IMember): Boolean
//        begin
//          with Arg.AsObject do
//            Result := S['PropName'] = LPropName
//        end);
//    end;
//
//    LPropNameIdx := LSO.A['Components'].O[LCompNameIdx].A['Properties'].Length;
//  end;
//
//  With LSO.A['Components'].O[LCompNameIdx] do
//  begin
//    with A['Properties'].O[LPropNameIdx] do
//    begin
//      S['PropName'] := LPropName;
//      I['PropTyprKind'] := ARecToPass.ValueType;
//      S['Value'] := LValue;
//    end;
//  end;
//
//  ADestJson := LSO.AsJSON;
end;

procedure TWatchF2.AddNew1Click(Sender: TObject);
begin
  CreateNewItem();
end;

procedure TWatchF2.AddNewFromSelected1Click(Sender: TObject);
begin
  CreateNewItemSelected();
end;

function TWatchF2.DetermineIndexForXYGraph(AIsChClear: Boolean): Boolean;
var
  LArray: DArray;
  LXYInfo: TXYGraphInfo;
  it: Diterator;
  LStr: string;
  i,j: integer;
begin
  Result := True;

  if FWG.NextGrid1.SelectedCount <> 2 then
  begin
    ShowMessage('XY Graph needs only 2 items!' + #13#10 +
      'But you have selected ' + IntToStr(FWG.NextGrid1.SelectedCount) + ' items.');
    Result := False;
    exit;
  end;

  LArray := DArray.Create;
  try
    if PrepareXYGraph(LArray, AIsChClear) then
    begin
      for j := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
      begin
        IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[j].UseXYGraphConstant := False;
      end;

      it := LArray.start;
      LXYInfo := GetObject(it) as TXYGraphInfo;
      LStr := LXYInfo.FTagname;
      i := LXYInfo.FParameterIndex;
      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].UseXYGraphConstant := LXYInfo.FUseConstant;

      advance(it);
      LXYInfo := GetObject(it) as TXYGraphInfo;

      IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[LXYInfo.FParameterIndex].UseXYGraphConstant := LXYInfo.FUseConstant;

      if LXYInfo.FAxis = aX then
      begin
        iXYPlot1.XAxis[0].Title := LXYInfo.FTagname;
        iXYPlot1.YAxis[0].Title := LStr;
        //X축 Index를 HelpContext에 저장
        iXYPlot1.HelpContext := LXYInfo.FParameterIndex;
        //Y축 Index를 Tag에  저장
        iXYPlot1.Tag := i;
      end
      else
      begin
        iXYPlot1.XAxis[0].Title := LStr;
        iXYPlot1.YAxis[0].Title := LXYInfo.FTagname;
        //X축 Index를 HelpContext에 저장
        iXYPlot1.HelpContext := i;
        //Y축 Index를 Tag에  저장
        iXYPlot1.Tag := LXYInfo.FParameterIndex;
      end;

    end;
  finally
    ObjFree(LArray);
    LArray.Free;
  end;
end;

procedure TWatchF2.AddtoCalculated1Click(Sender: TObject);
//var
//  i,j: integer;
//  Lstr, LStr2: string;
//  LStrList, LtmpList: TStringList;
//  LEP_DragDrop: TEngineParameterItemRecord;
//  LMemoryStream: TMemoryStream;
//  LCopyWatchListF: TCopyWatchListF;
begin
  FWG.AddCalculated2GridFromMenu;
//  LCopyWatchListF := TCopyWatchListF.Create(nil);
//  try
//    with LCopyWatchListF do
//    begin
//      //LMemoryStream := TMemoryStream.Create;
//      //try
//        //FWG.NextGrid1.SaveToStream(LMemoryStream);
//        //LMemoryStream.Position := 0;
//        //SelectGrid.LoadFromStream(LMemoryStream);
//      //finally
//        //FreeAndNil(LMemoryStream);
//      //end;
//
//      FWG.NextGrid1.SaveToTextFile(TEMPFILENAME);
//      SelectGrid.LoadFromTextFile(TEMPFILENAME);
//
//      Sel4XYGraphPanel.Visible := False;
//      FormulaPanel.Visible := True;
//
//      SelectGrid.Columns.Item[0].Visible := False;
//      SelectGrid.Columns.Item[1].Visible := False;
//      SelectGrid.Columns.Item[4].Visible := False;
//      SelectGrid.Columns.Item[5].Visible := False;
//      SelectGrid.Columns.Item[6].Visible := False;
//      SelectGrid.Columns.Item[7].Visible := False;
//
//      SelectGrid.Options := SelectGrid.Options - [goMultiSelect];
//
//      for i := 0 to SelectGrid.RowCount - 1 do
//        SelectGrid.Cell[3,i].AsString :=
//          IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TagName;
//
//      if ShowModal = mrOK then
//      begin
//        FWG.AddCalculated2Grid(ExprEdt.Text, ItemNameEdit.Text, True);
//      end;
//    end;//with
//
//  finally
//    FreeAndNil(LCopyWatchListF);
//  end;
end;

procedure TWatchF2.AddtoNewTrendWindow1Click(Sender: TObject);
var
  LCommand: string;
begin
  LCommand := HiMECSWatchName2 + ' ___ ' + 'DISPLAYTREND';
  AddToNewWindow(LCommand);
end;

procedure TWatchF2.AddToNewWindow(ACommand: string);
var
  i,LHandle: integer;
  LProcessId: THandle;
begin
  if FWG.NextGrid1.SelectedCount > 0 then
  begin
    SetCurrentDir(FFilePath);
    LProcessId := ExecNewProcess2(ACommand);
    LHandle := DSiGetProcessWindow(LProcessId);
    SetLength(FWatchHandles, Length(FWatchHandles)+1);
    FWatchHandles[High(FWatchHandles)] := LHandle;

    if Pos('SIMPLE', ACommand) > 0 then
    begin
      i := FWG.NextGrid1.SelectedRow;
      IPCMonitorAll1.MoveEngineParameterItemRecord2(FWG.FEngineParameterItemRecord,i);
      FWG.FEngineParameterItemRecord.FIsDisplaySimple := True;
      FWG.FPM.SendEPCopyData(Handle, LHandle, FWG.FEngineParameterItemRecord);
    end
    else
    if Pos('DISPLAYTREND', ACommand) > 0 then
    begin
      for i := 0 to FWG.NextGrid1.RowCount - 1 do
      begin
        if FWG.NextGrid1.Row[i].Selected then
        begin
          IPCMonitorAll1.MoveEngineParameterItemRecord2(FWG.FEngineParameterItemRecord,i);
          FWG.FEngineParameterItemRecord.FIsDisplayTrend := True;
          FWG.FPM.SendEPCopyData(Handle, LHandle,FWG.FEngineParameterItemRecord);
        end;
      end;
    end;
  end;
end;

procedure TWatchF2.AddToSimple(AParamIndex: integer);
begin
  Label1.Caption := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].Description;
  Label3.Caption := Label1.Caption;

  if FCurrentEPIndex4Watch > -1 then
    FPrevEPIndex4Watch := FCurrentEPIndex4Watch;

  FCurrentEPIndex4Watch := AParamIndex;
  if FPrevEPIndex4Watch > -1 then
  begin
    FWG.NextGrid1.CellByName['SimpleDisplay', FPrevEPIndex4Watch].AsInteger := -1;
    IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[FPrevEPIndex4Watch].IsDisplaySimple := False;
  end;

  FWG.NextGrid1.CellByName['SimpleDisplay', AParamIndex].AsInteger := 1;
  IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].IsDisplaySimple := True;

  if (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].SensorType = stParam) or
    (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].ParameterSource = psManualInput) then
    WatchLabel.Caption := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AParamIndex].Value;

  if FCurrentEPIndex4Watch <> FPrevEPIndex4Watch then
  begin
    //FWatchCA.Size := 0;
    //FWatchCA.Size := FConfigOption.AverageSize;
    FWatchCA.ClearBuffer;
  end;
end;

procedure TWatchF2.AddToSimple3Click(Sender: TObject);
begin
  AddToSimple(FWG.NextGrid1.SelectedRow);
end;

procedure TWatchF2.AddToSimpleInNewWindow1Click(Sender: TObject);
var
  LCommand: string;
begin
  if FWG.NextGrid1.SelectedCount > 1 then
  begin
    ShowMessage('You must select only one item for simple display!');
    exit;
  end;

  LCommand := HiMECSWatchName2 + ' ___ ' + 'SIMPLE';
  AddToNewWindow(LCommand);
end;

procedure TWatchF2.AddtoTrend2Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to FWG.NextGrid1.RowCount - 1 do
  begin
    if FWG.NextGrid1.Row[i].Selected then
    begin
      AddChannelAndYAxis(i, tdtValue);
    end;
  end;
end;

function TWatchF2.AddToXYGraphInRealTime: Boolean;
var
  LArray: DArray;
  LXYInfo: TXYGraphInfo;
  it: Diterator;
  LStr: string;
  i: integer;
begin
  Result := False;

  if FWG.NextGrid1.SelectedCount <> 2 then
  begin
    ShowMessage('XY Graph needs only 2 items!' + #13#10 +
      'But you have selected ' + IntToStr(FWG.NextGrid1.SelectedCount) + ' items.');
    exit;
  end;

  LArray := DArray.Create;
  try
    if PrepareXYGraph(LArray, True) then
    begin
      it := LArray.start;
      LXYInfo := GetObject(it) as TXYGraphInfo;
      //FXYDataIndex[0] := LXYInfo.FParameterIndex;
      LStr := LXYInfo.FTagname;
      i := LXYInfo.FParameterIndex;

      advance(it);
      LXYInfo := GetObject(it) as TXYGraphInfo;
      //FXYDataIndex[1] := LXYInfo.FParameterIndex;

      if LXYInfo.FAxis = aX then
      begin
        iXYPlot1.XAxis[0].Title := LXYInfo.FTagname;
        iXYPlot1.YAxis[0].Title := LStr;
        FXYDataIndex[0] := LXYInfo.FParameterIndex;
        FXYDataIndex[1] := i;
      end
      else
      begin
        iXYPlot1.XAxis[0].Title := LStr;
        iXYPlot1.YAxis[0].Title := LXYInfo.FTagname;
        FXYDataIndex[0] := i;
        FXYDataIndex[1] := LXYInfo.FParameterIndex;
      end;

      Result := True;
    end;
  finally
    ObjFree(LArray);
    LArray.Free;
  end;

end;

procedure TWatchF2.AdjustParameter1Click(Sender: TObject);
begin
  AdjustParamIndexOfComponents;
end;

procedure TWatchF2.AdjustparameterIndex1Click(Sender: TObject);
begin
  AdjustParamIndexOfComponents;
end;

procedure TWatchF2.AdjustParameterTagName1Click(Sender: TObject);
begin
  AdjustParamTagNameNDescOfComponents();
end;

procedure TWatchF2.AdjustParamIndexOfComponents;
var
  i, j, k, PnlIndex: integer;
  LStr: string;
  LPanel: TpjhPanel;
  IpjhDI: IpjhDesignCompInterface;
  IpjhDI2: IpjhDesignCompInterface2; //Plot용 Interface(Channel 값 할당)
begin
  for k := 5 to PageControl1.AdvPageCount - 1 do
  begin
    with PageControl1.AdvPages[k] do
    begin
      for i := 0 to ComponentCount - 1 do
      begin
        //find panel component(only one exist on Page)
        if Components[i].ClassType = TpjhPanel then
        begin
          PnlIndex := i;
          break;
        end;
      end;//for

      LPanel := Components[PnlIndex] as TpjhPanel;

      for i := 0 to LPanel.ComponentCount - 1 do
      begin
        if Supports(LPanel.Components[i], IpjhDesignCompInterface2, IpjhDI2) then
        begin
          if IpjhDI2.pjhTagInfoList.Count = IpjhDI2.pjhChannelCount then
          begin
            for j := 0 to IpjhDI2.pjhChannelCount - 1 do
            begin
              PnlIndex := GetparamIndexFromCollect(TpjhTagInfo(IpjhDI2.pjhTagInfoList.Objects[j]).TagName, LStr);
              if PnlIndex <> -1 then
              begin
                TpjhTagInfo(IpjhDI2.pjhTagInfoList.Objects[j]).ParamIndex := PnlIndex;
                TpjhTagInfo(IpjhDI2.pjhTagInfoList.Objects[j]).Description := LStr;
              end;
            end;
          end;
        end
        else if Supports(LPanel.Components[i], IpjhDesignCompInterface, IpjhDI) then
        begin
          if IpjhDI.pjhTagInfo.TagName <> '' then
          begin
            PnlIndex := GetParamIndexFromCollect(IpjhDI.pjhTagInfo.TagName, LStr);
            if PnlIndex <> -1 then
            begin
              IpjhDI.pjhTagInfo.ParamIndex := PnlIndex;
              IpjhDI.pjhTagInfo.Description := LStr;
            end;
          end;
        end;
      end;//for
    end;//with
  end;
end;

procedure TWatchF2.AdjustParamTagNameNDescOfComponents;
var
  i, j, k, PnlIndex: integer;
  LStr, LTagName: string;
  LPanel: TpjhPanel;
  IpjhDI: IpjhDesignCompInterface;
  IpjhDI2: IpjhDesignCompInterface2; //Plot용 Interface(Channel 값 할당)
begin
  for k := 5 to PageControl1.AdvPageCount - 1 do
  begin
    with PageControl1.AdvPages[k] do
    begin
      for i := 0 to ComponentCount - 1 do
      begin
        //find panel component(only one exist on Page)
        if Components[i].ClassType = TpjhPanel then
        begin
          PnlIndex := i;
          break;
        end;
      end;//for

      LPanel := Components[PnlIndex] as TpjhPanel;

      for i := 0 to LPanel.ComponentCount - 1 do
      begin
        if Supports(LPanel.Components[i], IpjhDesignCompInterface2, IpjhDI2) then
        begin
          if IpjhDI2.pjhTagInfoList.Count = IpjhDI2.pjhChannelCount then
          begin
            for j := 0 to IpjhDI2.pjhChannelCount - 1 do
            begin
              if IpjhDI.pjhTagInfo.TagName <> '' then
              begin
                LTagName := GetTagNameFromCollectByIndex(IpjhDI.pjhTagInfo.ParamIndex, LStr);

                if LTagName <> '' then
                begin
                  IpjhDI.pjhTagInfo.TagName := LTagName;
                  IpjhDI.pjhTagInfo.Description := LStr;
                end;
              end;
            end;
          end;
        end
        else if Supports(LPanel.Components[i], IpjhDesignCompInterface, IpjhDI) then
        begin
          if IpjhDI.pjhTagInfo.TagName <> '' then
          begin
            LTagName := GetTagNameFromCollectByIndex(IpjhDI.pjhTagInfo.ParamIndex, LStr);

            if LTagName <> '' then
            begin
              IpjhDI.pjhTagInfo.TagName := LTagName;
              IpjhDI.pjhTagInfo.Description := LStr;
            end;
          end;
        end;
      end;//for
    end;//with
  end;
end;

procedure TWatchF2.AddtoXYGraph1Click(Sender: TObject);
begin
  AddToXYGraphInRealTime;
end;

procedure TWatchF2.AddToXYGraphFromFile1Click(Sender: TObject);
var
  LArray: DArray;
  LFileName: string;
  i: integer;
  LIsFirst: Boolean;
begin
  if FWG.NextGrid1.SelectedCount <> 2 then
  begin
    ShowMessage('XY Graph needs only 2 items!' + #13#10 +
      'But you have selected ' + IntToStr(FWG.NextGrid1.SelectedCount) + ' items.');
    exit;
  end;

  LArray := DArray.Create;
  try
    if PrepareXYGraph(LArray, True) then
    begin
      FXYDataMap.clear;
      JvOpenDialog1.Options := JvOpenDialog1.Options + [ofAllowMultiSelect];
      JvOpenDialog1.InitialDir := FFilePath;

      if JvOpenDialog1.Execute then
      begin
        for i := 0 to JvOpenDialog1.Files.Count - 1 do
        begin
          LIsFirst := i = 0;

          LFileName := JvOpenDialog1.Files[i];
          if MakeXYDataFromFile(LArray, LFileName, LIsFirst, FXYDataMap, False) then
            LFileName := 'Success';
        end;

        if LFileName = 'Success' then
        begin
          DisplayXYGraphWithDup(iXYPlot1.Channel[0] ,FXYDataMap);
          PageControl1.ActivePage := XYGraphTabSheet;
        end;
      end;
    end;
  finally
    ObjFree(LArray);
    LArray.Free;
  end;
end;

procedure TWatchF2.AddtoXYGraphFromTrendData1Click(Sender: TObject);
var
  LArray: DArray;
begin
  if FWG.NextGrid1.SelectedCount <> 2 then
  begin
    ShowMessage('XY Graph needs only 2 items!' + #13#10 +
      'But you have selected ' + IntToStr(FWG.NextGrid1.SelectedCount) + ' items.');
    exit;
  end;

  LArray := DArray.Create;
  try
    if PrepareXYGraph(LArray, True) then
    begin
      FXYDataMap.clear;
      GetDataFromTrendGraph2XYMap(LArray);
      DisplayXYGraphWithDup(iXYPlot1.Channel[0] ,FXYDataMap);
      PageControl1.ActivePage := XYGraphTabSheet;
    end;
  finally
    ObjFree(LArray);
    LArray.Free;
  end;
end;

procedure TWatchF2.ApplicationEvents1Activate(Sender: TObject);
begin
//  if Assigned(IPCClient_HiMECS_MDI) then
//  begin
//    if IPCClient_HiMECS_MDI.State <> stConnected then
//    begin
//      IPCClient_HiMECS_MDI.MakeCurrent;
//      ShowMessage('IPCClient_HiMECS_MDI.MakeCurrent');
//    end;
//  end;
end;

procedure TWatchF2.ApplicationEvents1ShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
  //(GetKeyState(VK_SHIFT) < 0) and
  //(GetKeyState(VK_CONTROL) < 0) then

  //Alt key가 눌려 졌으면 exit
//  if HiWord(GetKeyState(VK_MENU)) = 0 then
//    exit;

  //Shift key가 눌려 졌으면 exit
//  if HiWord(GetKeyState(VK_SHIFT)) = 0 then
//    exit;

  //Control key가 눌려 졌으면 exit
//  if HiWord(GetKeyState(VK_CONTROL)) = 0 then
//    exit;

  if (Msg.CharCode = VK_F2) then
  begin
    //ShowMessage('F2 pressed!') ;
    ToggleBorderStyle(TForm(Self));
    ToggleWindowMaxmize(TForm(Self));
    Handled := True;
  end;

  if (Msg.CharCode = VK_F3) then
    ToggleTabShow;

  if (Msg.CharCode = VK_F4) then
    ToggleBorderStyle(TForm(Self));

  if (Msg.CharCode = VK_F5) then
    ToggleStayOnTop(TForm(Self));

  if (Msg.CharCode = VK_F6) then
    ResetWindowPosition(TForm(Self));

  //Alt key가 눌려 졌으면
//  if GetKeyState(VK_MENU) < 0 then
//  begin
//    ProcessKeyEvent4NextStep(Msg.CharCode);
////    Handled := True;
//  end;

end;

procedure TWatchF2.ApplyAvgSize;
begin
  FCriticalSection.Enter;
  try
    FCurrentAryIndex := 0;
    FFirstCalcAry := True;
    FWatchCA.Size := FConfigOption.AverageSize;
  finally
    FCriticalSection.Leave;
  end;//try
end;

procedure TWatchF2.ApplyCommandLineOption;
begin
  if FCommandLine.WatchListFileName <> '' then
    FConfigOption.WatchListFileName := FCommandLine.WatchListFileName;

  if FCommandLine.UserLevel <> 0 then
    IPCMonitorAll1.FCurrentUserLevel := THiMECSUserLevel(FCommandLine.UserLevel);

  if FCommandLine.AlarmMode then
    ChangeAlarmListMode;

  if FCommandLine.DummyFormHandle <> '' then
  begin
    FDummyFormHandle := FCommandLine.DummyFormHandle;
//    SendAliveOk;
  end;

  FIsMDIChileMode := FCommandLine.MDIChildMode;
end;

procedure TWatchF2.ApplyOption;
var
  i: integer;
begin
  if FConfigOption.MonDataSource = 2 then //MonDataSource = By MQ
    InitSTOMP;

  if not FFirst and (FConfigOption.AliveSendInterval > 0) then
    Timer1.Interval := FConfigOption.AliveSendInterval;

  if FCurrentModbusFileName <> FConfigOption.ModbusFileName then
  begin
    if FileExists(FConfigOption.ModbusFileName) then
    begin
//      IPCMonitorAll1.SetModbusMapFileName(FConfigOption.ModbusFileName, psECS_AVAT);
    end;
  end;

  //Simple에 보여줌
  AvgPanel.Visible := FConfigOption.ViewAvgValue;

  ApplyOption4AvgCalc;

  if FConfigOption.NameFontSize > 0 then
    Label1.Font.Size := FConfigOption.NameFontSize;

  if FConfigOption.ValueFontSize > 0 then
    WatchLabel.Font.Size := FConfigOption.ValueFontSize;

  if FConfigOption.FormCaption <> '' then
    Caption := FConfigOption.FormCaption;

  for i := 0 to iPlot1.ChannelCount - 1 do
    iPlot1.Channel[i].RingBufferSize := FConfigOption.RingBufferSize;
end;

procedure TWatchF2.ApplyOption4AvgCalc;
var
  LUseQFilalize: Boolean;
begin
  //Items에 보여줌
  if FConfigOption.DisplayAverageValue then
  begin
    LUseQFilalize := not FConfigOption.FDisplayAverageValueChanged and
          FConfigOption.FAverageSizeChanged;
    FWG.RestartAvgCalc(LUseQFilalize, FConfigOption.AverageSize)
  end;
end;

procedure TWatchF2.FormShow(Sender: TObject);
begin
  Label1.Caption := FLabelName;
  Label3.Caption := FLabelName;
  Self.Caption := Self.Caption + FLabelName;
end;

procedure TWatchF2.FullScreen1Click(Sender: TObject);
begin
  ToggleBorderStyle(TForm(Self));
  ToggleWindowMaxmize(TForm(Self));
end;

procedure TWatchF2.FWGNextGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_control: begin
      if (ssCtrl in Shift) then
      begin
        FControlPressedOnGrid := True;
      end;
    end;
    vk_up: begin
      JvTrackBar1.Position := JvTrackBar1.Position + 1;
    end;
    vk_down: begin
      JvTrackBar1.Position := JvTrackBar1.Position - 1;
    end;
  end;
end;

Procedure TWatchF2.FWGNextGrid1SelectCell(Sender: TObject; ACol, ARow: Integer);
begin
  ShowEventName1.Enabled := FWG.NextGrid1.SelectedCount = 1;
  FWG.NextGrid1SelectCell(Sender, ACol, ARow);
end;

function TWatchF2.GetAxisFromString(AAxes: String): TAxis;
begin
  if AAxes = 'X' then
    Result := aX
  else if AAxes = 'Y' then
    Result := aY
  else if AAxes = 'Z' then
    Result := aZ;
end;

procedure TWatchF2.GetBplNamesFromDesignPanel(ABplNameList: TStringList;
  AAdvOfficePage: TAdvOfficePage);
var
  j, PnlIndex: integer;
  LPanel: TpjhPanel;
  IpjhDI: IpjhDesignCompInterface;
  LStr: string;
begin
  with AAdvOfficePage do
  begin
    for j := 0 to ComponentCount - 1 do
    begin
      //find panel component(only one exist on Page)
      if Components[j].ClassType = TpjhPanel then
      begin
        PnlIndex := j;
        break;
      end;
    end;//for

    LPanel := Components[PnlIndex] as TpjhPanel;

    for j := 0 to LPanel.ComponentCount - 1 do
    begin
      if Supports(LPanel.Components[j], IpjhDesignCompInterface, IpjhDI) then
      begin
        LStr := IpjhDI.pjhBplFileName;
        if ABplNameList.IndexOf(LStr) = -1 then
        begin
          ABplNameList.Add(LStr);
        end;
      end;
    end;//for
  end;
end;

function TWatchF2.GetComponentByNameFrompjhPanel(var ACompName: string): TControl;
var
  LComp: TComponent;
  LpjhPanel: TpjhPanel;
begin
  if ACompName = '' then
    ACompName := CreateInputEdit('Find Component', 'Component Name', '');

  LpjhPanel := GetTpjhPanelOfCurrentPage;
  LComp := LpjhPanel.FindComponent(ACompName);

  Result := TControl(LComp);
end;

function TWatchF2.GetComponentPositionFromControl(AControl: TControl): TPoint;
begin
  if Assigned(AControl) then
  begin
    Result.X := AControl.Left + (AControl.Width div 2);
    Result.Y := AControl.Top;
  end
  else
  begin
    Result.X := -1;
    Result.Y := -1;
  end;
end;

function TWatchF2.GetPjhPanelFromIndex(APageIndex: integer): TPjhPanel;
var
  i, PnlIndex: integer;
begin
  Result := nil;

  if APageIndex = -1 then
    APageIndex := PageControl1.ActivePageIndex;

  with PageControl1.AdvPages[APageIndex] do
  begin
    PnlIndex := -1;

    for i := 0 to ComponentCount - 1 do
    begin
      //find panel component(Only one exist on Page)
      if Components[i].ClassType = TpjhPanel then
      begin
        PnlIndex := i;
        break;
      end;
    end;//for

    if PnlIndex = -1 then
      exit;

    Result := Components[PnlIndex] as TpjhPanel;
  end;
end;

procedure TWatchF2.GetDataFromTrendGraph2XYMap(AArray: DArray);
var
  i,j: integer;
  LXYInfo: TXYGraphInfo;
  it: Diterator;
  tmpdouble, tmpdouble2: double;
  LSmallerCount: integer;
  ChannelX, ChannelY: integer;
  LMultiMap: DMultiMap;
  LStr, LStr2: string;
  LIsDuplicated: Boolean;
begin
  it := AArray.start;
  LXYInfo := GetObject(it) as TXYGraphInfo;
  i := LXYInfo.FParameterIndex;
  LIsDuplicated := LXYInfo.FIsDuplicated;

  if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrend then
  begin
    if LXYInfo.FAxis = aX then
    begin
      ChannelX := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendChannelIndex;
      LStr := LXYInfo.FTagname;
    end
    else
    begin
      ChannelY := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TrendChannelIndex;
      LStr2 := LXYInfo.FTagname;
    end;
  end;

  advance(it);
  LXYInfo := GetObject(it) as TXYGraphInfo;
  j := LXYInfo.FParameterIndex;

  if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[j].IsDisplayTrend then
  begin
    if LXYInfo.FAxis = aX then
    begin
      ChannelX := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[j].TrendChannelIndex;
      LStr := LXYInfo.FTagname + ';' + LStr2;
    end
    else
    begin
      ChannelY := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[j].TrendChannelIndex;
      LStr := LStr + ';' + LXYInfo.FTagname;
    end;
  end;

  //X,Y중 데이터 수가 더 작은 것 선택
  if iPlot1.Channel[i].Count > iPlot1.Channel[j].Count then
    LSmallerCount := iPlot1.Channel[j].Count - 1
  else
    LSmallerCount := iPlot1.Channel[i].Count - 1;

  LMultiMap := DMultiMap.Create;

  for i := 0 to LSmallerCount do
  begin
    tmpdouble := iPlot1.Channel[ChannelX].DataY[i];
    tmpdouble2 := iPlot1.Channel[ChannelY].DataY[i];

    if LIsDuplicated then
      XYDataAdd2Map(LMultiMap, tmpdouble, tmpdouble2, True)
    else
      ReplaceOrAddMap(LMultiMap, tmpdouble, tmpdouble2, True);
  end;

  FXYDataMap.putPair([LStr,LMultiMap])
end;

function TWatchF2.GetDesignControl(LPage: TAdvOfficePage): TControl;
var
  i: integer;
begin
  Result := nil;

  for i := 0 to LPage.ComponentCount - 1 do
  begin
    if LPage.Components[i] is TpjhPanel then
    begin
      Result := TControl(LPage.Components[i]);
      break;
    end;
  end;
end;

function TWatchF2.GetDesignPanel(LPage: TAdvOfficePage): TELDesignPanel;
var
  i: integer;
begin
  Result := nil;

  for i := 0 to LPage.ComponentCount - 1 do
  begin
    if LPage.Components[i] is TELDesignPanel then
    begin
      Result := TELDesignPanel(LPage.Components[i]);
      break;
    end;
  end;
end;

//AAutoStart: True = 프로그램 시작시에 watch file name을 parameter로 입력받는 경우
//            False = LoadFromFile 메뉴로 실행되는 경우
procedure TWatchF2.GetEngineParameterFromSavedWatchListFile(AFileName: string;
  AAutoStart, AOnlyOneFormOpen: Boolean);
var
  i,j,k: integer;
  LStr: string;
  LUserLevel: THiMECSUserLevel;
  LStrList: TStringList;
begin
  if AFileName = '' then
  begin
    if Pos('\', FConfigOption.WatchListFileName) = 0 then
      AFileName := WatchListPath + FConfigOption.WatchListFileName
    else
      AFileName := FConfigOption.WatchListFileName;
  end;

  if FileExists(AFileName) then
  begin
    SetWatchListFileName(AFileName);

    FWG.GetItemsFromParamFile2Collect(AFileName, FConfigOption.EngParamFileFormat,
                FConfigOption.EngParamEncrypt, FIsMDIChileMode);

    FWG.NextGrid1.ClearRows;
    iPlot1.RemoveAllChannels;
    iPlot1.RemoveAllYAxes;

    //Administrator이상의 권한자 만이 Save user level 조정 가능함
    if IPCMonitorAll1.FCurrentUserLevel <= HUL_Administrator then
    begin
      AllowUserlevelCB.Enabled := True;
    end;

    AllowUserlevelCB.Text := UserLevel2String(IPCMonitorAll1.FEngineParameter.AllowUserLevelWatchList);

    if AllowUserlevelCB.Text = '' then
      AllowUserlevelCB.Text := UserLevel2String(IPCMonitorAll1.FCurrentUserLevel);

    if not FIsMDIChileMode then
    begin
      if (IPCMonitorAll1.FEngineParameter.FormWidth > 0) and
        (IPCMonitorAll1.FEngineParameter.FormHeight > 0) then
      begin
        GetWatchFormStateFromParam2Form(IPCMonitorAll1.FEngineParameter);
      end;
    end;

    //Form을 Refresh할때 필요함
    FCommandLine.IsOnlyOneForm := AOnlyOneFormOpen;

    LoadDesignForm(AFileName+DESIGNFORM_FILENAME, AOnlyOneFormOpen);

    FWG.NextGrid1.BeginUpdate;
    FIsLoadingDFC := True;
    try
      for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
      begin
        //DisplayFormat 속성이 나중에 추가 되었기 때문에 적용 안된 WatchList파일의 경우 적용하기 위함
        if (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].SensorType <> stParam) and
          (IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].DisplayFormat = '') then
        begin
          IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].DisplayFormat :=
            GetDisplayFormat(IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].RadixPosition,
                            IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].DisplayThousandSeperator);
        end;

        FWG.AddEngineParameter2Grid(i);

        if FWG.FEngineParameterItemRecord.FIsDisplayTrend then
        begin
          IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].IsDisplayTrend := False;
          AddChannelAndYAxis(i, tdtValue);
        end;

        if FWG.FEngineParameterItemRecord.FIsDisplaySimple then
        begin
          AddToSimple(i);
        end;
      end; //for

    finally
      FIsLoadingDFC := False;
      FWG.NextGrid1.EndUpdate;
    end;

    if (AAutoStart) and (not AOnlyOneFormOpen) then
    begin
      if PageControl1.AdvPageCount >= 5 then
        PageControl1.ActivePageIndex := 5;
    end;

//    Refresh1Click(nil);
  end
  else
  begin
    LStr := 'File not found : ' + AFileName;
    DisplayMessage(LStr);
    ShowMessage(LStr);
  end;

  if FConfigOption.DisplayAverageValue then
  begin
    FWG.FIsAvgDisplay4Items := True;
    FWG.FAverageQSize := FConfigOption.AverageSize;
    FWG.InitAvgMode;//각 Item에 Avg Q 생성
    FWG.SelectAllItems4Avg;
    FWG.StartAvgCalc;
  end;
end;

//procedure TWatchF2.GetFields2Grid(ADb: TSivak3Database; ATableName: String;
//  AGrid: TNextGrid);
//var
//  LnxTextColumn: TnxTextColumn;
//  LnxIncColumn: TnxIncrementColumn;
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
//    LnxIncColumn := TnxIncrementColumn(AGrid.Columns.Add(TnxIncrementColumn, 'No'));
//    LnxIncColumn.Name := 'No';
//    LnxIncColumn.Header.Alignment := taCenter;
//    LnxIncColumn.Sorted := True;
//    LnxIncColumn.SortKind := skDescending;
//    LnxIncColumn.SortType := stNumeric;
//
//    for Li := 0 to LStrList.Count - 1 do
//    begin
//      with AGrid do
//      begin
//        LnxTextColumn := TnxTextColumn(Columns.Add(TnxTextColumn, LStrList[Li]));
//        LnxTextColumn.Name := LStrList[Li];
//        LnxTextColumn.Header.Alignment := taCenter;
//        LnxTextColumn.Options := [coCanClick,coCanInput,coEditing,coEditorAutoSelect,coPublicUsing,coShowTextFitHint];
//      end;
//    end;
//  finally
//    LStrList.Free;
//  end;
//end;

function TWatchF2.GetFileNameFromWatchList: string;
begin
  Result := '';
  SetCurrentDir(FFilePath);
  JvOpenDialog1.InitialDir := ExtractFilePath(PageControl1.ActivePage.Hint);// '..\WatchList';
  JvOpenDialog1.Filter := '*.*';
  if JvOpenDialog1.Execute then
  begin
    if jvOpenDialog1.FileName <> '' then
    begin
      Result := jvOpenDialog1.FileName;
    end;
  end;
end;

function TWatchF2.GetHiMECSA2Version(const AAABB, ACCdd: integer): string;
begin
  Result := IntToStr(ExtractBitsLRFromInt(AAABB, 5,4));//Major
  Result := Result + '.' + IntToStr(ExtractBitsLRFromInt(AAABB, 13,4));//Minor
  Result := Result + '.' + IntToStr(ExtractBitsLRFromInt(ACCdd, 5,4));//Revision
end;

function TWatchF2.GetJsonAdditionalData4Simulate: string;
var
  LAdditioinalDataRec: TAdditioinalDataRec;
begin
  LAdditioinalDataRec.FPageIndex := PageControl1.ActivePageIndex;
  LAdditioinalDataRec.FCaption := PageControl1.AdvPages[PageControl1.ActivePageIndex].Caption;
  LAdditioinalDataRec.FJson4SimParamEditData := FSimParamJsonData4Edit;
  LAdditioinalDataRec.FFormHandle := integer(Handle);

  Result := RecordSaveJson(LAdditioinalDataRec, TypeInfo(TAdditioinalDataRec));
end;

procedure TWatchF2.GetLoadedPackages(APackageList: TStringList);
var
  i: integer;
begin
  if not Assigned(FBplFileList) then
    FBplFileList := TStringList.Create;

  for i := 0 to FBplFileList.Count - 1 do
  begin
    if APackageList.IndexOf(FBplFileList.Strings[i]) = -1 then
    begin
      APackageList.AddObject(FBplFileList.Strings[i], Pointer(FBplFileList.Objects[i]));
    end;
  end;
end;

function TWatchF2.GetMultiStateMeaning(
  AEngParamItem: TEngineParameterItem): string;
var
  LIdx: integer;
  LCount: integer;
begin
  Result := '';

  if AEngParamItem.MultiStateItemIndex <> -1 then //-1
  begin
    LIdx := AEngParamItem.MultiStateItemIndex;
    LCount := 1;

    while LCount <= AEngParamItem.MultiStateItemCount do
    begin
      if LIdx = -1 then
      begin
        inc(LIdx);
        Continue;
      end;

      if IntToStr(IPCMonitorAll1.FEngineParameter.MultiStateCollect.Items[LIdx].StateValue) = AEngParamItem.Value then
      begin
        Result := IPCMonitorAll1.FEngineParameter.MultiStateCollect.Items[LIdx].StateMeaning;
        break;
      end
      else
      begin
        inc(LIdx);
        inc(LCount);
      end;
    end;
  end;
end;

function TWatchF2.GetMultiStateValueFromIndex(AIdx: integer;
  AStateMeaning: string): string;
var
  LItem: TEngineParameterItem;
  LIdx: integer;
  LCount: integer;
begin
  Result := AStateMeaning;

  if Assigned(FWG.NextGrid1.Row[AIdx].Data) then
  begin
    LItem := TEngineParameterItem(FWG.NextGrid1.Row[AIdx].Data);

    if LItem.MultiStateItemIndex <> -1 then //-1
    begin
      LIdx := LItem.MultiStateItemIndex;
      LCount := 1;

      while LCount <= LItem.MultiStateItemCount do
      begin
        if LIdx = -1 then
        begin
          inc(LIdx);
          Continue;
        end;

        if IPCMonitorAll1.FEngineParameter.MultiStateCollect.Items[LIdx].StateMeaning = AStateMeaning then//LItem.Value
        begin
          Result := IntToStr(IPCMonitorAll1.FEngineParameter.MultiStateCollect.Items[LIdx].StateValue);
          break;
        end
        else
        begin
          inc(LIdx);
          inc(LCount);
        end;
      end; //while
    end;
  end;
end;

function TWatchF2.GetparamIndexFromCollect(ATagName: string; var ADesc: string): integer;
var
  i: integer;
begin
  Result := -1;

  for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    if ATagName = IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TagName then
    begin
      Result := i;
      ADesc := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].Description;
      break;
    end;
  end;
end;

function TWatchF2.GetPeriodDataFromTrend(AIndex, Ai, Aj: integer; ADataType: TPeriodDataType): double;
var
  i: integer;
  LCA: TCircularArray;
begin
  if IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AIndex].UseXYGraphConstant then
  begin
    Result := StrToFloatDef(ConstantEdit.Text, 0.0);
    exit;
  end;

  LCA := TCircularArray.Create(Aj-Ai+1);
  try
    AIndex := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AIndex].TrendChannelIndex;
    for i := Ai to Aj do
      LCA.Put(iPlot1.Channel[AIndex].DataY[i]);

    case ADataType of
      pdtAverage: Result := LCA.Average;
      pdtSum: Result := LCA.Sum;
      pdtMin: Result := LCA.Min;
      pdtMax: Result := LCA.Max;
      pdtPoint: Result := LCA.FData[0];
    end;
  finally
    FreeAndNil(LCA);
  end;
end;

function TWatchF2.GetScaledValueFrompjhValue(AIdx: integer; AValue: string): string;
var
  LItem: TEngineParameterItem;
  LScale: double;
  LIntValue: integer;
begin
  LIntValue := 0;

  if Assigned(FWG.NextGrid1.Row[AIdx].Data) then
  begin
    LItem := TEngineParameterItem(FWG.NextGrid1.Row[AIdx].Data);
    LScale := StrToFloatDef(LItem.Scale, 1.0);
    LIntValue := StrToIntDef(AValue,0);

    if LScale <> 0 then
      LIntValue := Trunc(LIntValue * LScale);
  end;

  Result := IntToStr(LIntValue);
end;

function TWatchF2.GetTagNameFromCollectByIndex(AIndex: integer;
  var ADesc: string): string;
begin
  Result := '';

  if AIndex < IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count then
  begin
    Result := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AIndex].TagName;
    ADesc := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[AIndex].Description;
  end;
end;

function TWatchF2.GetTagNameFromDescriptor(ADescriptor: string): string;
var
  i: integer;
begin
  Result := '';

  for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    if ADescriptor = IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].Description then
    begin
      Result := IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TagName;
      exit;
    end;
  end;
end;

//Tag Name과 Description을 각각의 StringList에 반환함
procedure TWatchF2.GetTagNames(ATagNameList, ADescriptList: TStringList);
var
  i: integer;
begin
  //ShowMessage('GetTagNames');
  for i := 0 to IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    ATagNameList.Add(IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].TagName);
    ADescriptList.Add(IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Items[i].Description);
  end;
end;

function TWatchF2.GetTpjhPanelOfCurrentPage(APageIndex: integer): TpjhPanel;
var
  LPage: TAdvOfficePage;
begin
  if APageIndex = -1 then
    LPage := PageControl1.ActivePage
  else
    LPage := PageControl1.AdvPages[APageIndex];

  Result := TpjhPanel(GetDesignControl(LPage));
end;

function TWatchF2.GetTrendDataFromTagName(ATagName: string; AMap: DMap): DArray;
var
  it: Diterator;
begin
  Result := nil;
  it := AMap.locate([ATagName]);

  if not atEnd(it) then
    Result := GetObject(it) as DArray;
end;

procedure TWatchF2.GetVariantFromItemList4SimulateData(var ADoc: variant);
var
  LParamJson, LValueCSV, LSrcCSV: string;
begin
  TDocVariant.New(ADoc);
  ADoc.ProductType := -1;
  ADoc.CourseLevel := -1;
  ADoc.ActivityLevel := -1;

  IPCMonitorAll1.GetParamList4SimulateData(LParamJson, LValueCSV, LSrcCSV);
  ADoc.JsonParamCollect := LParamJson;
  ADoc.CSVValues := LValueCSV;
  ADoc.ParamSourceList := LSrcCSV;
  ADoc.CommandJson := FSimulateCompValuesJson;
end;

procedure TWatchF2.GetWatchFormStateFromParam2Form(AParam: TEngineParameter);
begin
  Width := AParam.FormWidth;
  Height := AParam.FormHeight;
  Top := AParam.FormTop;
  Left := AParam.FormLeft;
  WindowState := TWindowState(AParam.FormState);

  StayOnTopCB.Checked := AParam.StayOnTop;
  SaveListCB.Checked := AParam.SaveWatchForm;
  EnableAlphaCB.Checked := AParam.UseAlphaBlend;
  JvTrackBar1.Position := AParam.AlphaValue;

  if not AParam.TabShow then
    PageControl1.TabSettings.Height := 0;
  if not AParam.BorderShow then
    BorderStyle := bsNone;
end;

procedure TWatchF2.GetXYPeriod(var Ai, Aj: integer);
var
  i: integer;
begin
  Ai := iPlot1.Channel[0].CalcIndex(iPlot1.DataCursor[0].DeltaX_P1_ValueX);
  Aj := iPlot1.Channel[0].CalcIndex(iPlot1.DataCursor[0].DeltaX_P2_ValueX);

  if Ai > Aj then
  begin
    i := Ai;
    Ai := Aj;
    Aj := i;
  end;
end;

procedure TWatchF2.GpSEEventReceivedNotify(Sender: TObject;
  producerHandle: TGpSEHandle; const producerName, eventName,
  eventData: string);
begin
  if producerHandle <> IPCMonitorAll1.FGpSharedEventProducer.ProducerHandle then
  begin
    //Watch2에서 "Move pjhValue To gpSharedMM" 메뉴를 클릭 시 이 함수가 트리거 됨
    //여러 Watch2 폼에서 Items Value를 서로 교환하여 공유하기 위해 사용 됨
    if (eventName = gp_EventName4SimEditData) then
      UpdateItemValueFromSimData
    //SimulateParamSever에서 Transfer 버튼 클릭시 CommandJson을 전송 후 이 함수가 트리거 됨.
    else if (eventName = gp_EventName4SimCommandJson) then
      UpdateComponentValueFromCommandJson;
    //Watch2에서 "Move pjhValue To Item and Save To DB" 메뉴 클릭 시 중복 입력 방지를 위해 FrmSimulateParamEdit.TSimulateParamEditF에서 정보를 Watch2에 전달해 줌
//    else if (eventName = gp_EventName4SimAutoFillInData) then
//      ;
  end;
end;

procedure TWatchF2.Button1Click(Sender: TObject);
begin
  FWatchValueMax := 0;
  FWatchValueMin := 0;
end;

procedure TWatchF2.Button2Click(Sender: TObject);
begin
  FStartTrend := True;
end;

procedure TWatchF2.Button3Click(Sender: TObject);
begin
  FStartTrend := False;
end;

procedure TWatchF2.Button4Click(Sender: TObject);
begin
  FindItemByTagName(FindTagNameEdit.Text);
end;

procedure TWatchF2.SaveTextToBinDFM1Click(Sender: TObject);
var
  LBinFileName, LTextFileName: string;
  LPanel: TpjhPanel;
  LDesignFormConfig: TDesignFormConfig;
begin
  LPanel := GetTpjhPanelOfCurrentPage;

  if LPanel.ComponentCount > 0 then
  begin
    ShowMessage('This action should be on empty form.' + #13#10 + 'Try again on new page');
    exit;
  end;

  JvOpenDialog1.InitialDir := FFilePath;
  JvOpenDialog1.Filter := '*.dfm|*.*';

  if JvOpenDialog1.Execute then
  begin
    if JvOpenDialog1.FileName <> '' then
    begin
      LTextFileName := JvOpenDialog1.FileName;
    end;
  end;

  JvSaveDialog1.InitialDir := FFilePath;
  JvSaveDialog1.Filter := '*.dfm|*.*';

  if JvSaveDialog1.Execute then
  begin
    LBinFileName := JvSaveDialog1.FileName;

    if FileExists(LBinFileName) then
    begin
      if MessageDlg('File is already existed. Are you overwrite? if No press, then the data is not saved!',
        mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        exit;
    end;
  end;

  SaveTextDFM2BinDFM(LTextFileName, LBinFileName, TWincontrol(LPanel));
end;

end.




