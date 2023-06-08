unit MainUnit2;
{
2013.5.28
- 복수개의 EngineParameter 사용 가능
  : .himecs 파일에 여러 엔진 option file 저장 가능
  : engine parameter 창에서 해당 엔진 double-click 하면 engine info 정보 갱신 됨
2013.5.21
- HiMECS.manifest 파일 적용, release 모드일 경우에만(볼랜드포럼에서 참조)
  : 관리자 권한으로 실행 됨(F9로 실행 안됨)
  : Debug 모드에서는 사용자 권한으로 실행(F9 실행 됨)
2011.3.28
- ChildForm 생성시 Border Icon이 안 나오는 문제 해결
  : WM_SIZE 메세지 함수 삭제해서 해결함.
2011.3.21
- 검게 변하는 문제가 다시 발생함.
  : CustomDrawItem event에 EngineInfoInspector.Invalidate 추가함. 아래 문제는 해결안됨.
2011.3.15
- NxInspetctor 의 내용이 다른 윈도우에 가렸을때 검게 변하는 문제 해결함
  : NxScrollContol.WMEraseBkGnd 함수에 invalidate 추가함. (2011.1.28 조치 삭제함)
2011.2.11
- 외부 프로그램을 MDI Child로 생성하는 함수 추가
- Window cascade, horizontal, vertical 추가

2011.1.28
- NextInspector에서 내용이 까많게 나오는 문제 해결
  : OnMouseMove, OnMouseDown, OnMouseUp Event에 EngineInfoInspector.Invalidate 추가함.
}
interface

uses
  DragDrop, DropSource, DragDropFormats, DropTarget, DragDropText,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, NxCollection, NxToolBox, ExtCtrls, ImgList, AdvSplitter,
  AdvNavBar, HiMECSInterface, UnitHiMECSFormCollect2, HiMECSConst, AdvToolBar,TypInfo,
  AdvSmoothTileList,AdvGDIP, Clipbrd,
  AdvSmoothTileListImageVisualizer, AdvSmoothTileListHTMLVisualizer,
  NxScrollControl, NxInspector, NxPropertyItems,
  NxPropertyItemClasses, JvDialogs, StdCtrls, StdActns, ActnList,
  ComCtrls,
  AdvTabSet, AdvOfficeTabSet,//, JvCheckTreeView, JvComCtrls, JvExComCtrls,
  AdvOfficeTabSetStylers, AdvToolBarStylers, AdvMenus, UnitDragDropRecord2,
  CopyData, TimerPool, GDIPPictureContainer,
  AdvSmoothSplashScreen, Types, jpeg, WUpdate,
  AdvOfficeStatusBar, Cromis.Comm.IPC, Vcl.AppEvnts,
  JvComponentBase, JvAppHotKey, System.Actions,
  AdvSmartMessageBox, AdvOfficePager,
  mormot.core.variants, mormot.core.text, mormot.core.json, mormot.core.base,
  mormot.core.data, mormot.core.unicode,
  MonitornewApp_Unit, CommnewApp_Unit,
  UnitAutoRunClass2, UnitTileConfig,
  UnitEngineBaseClass2, UnitHiMECSExeCollect2, FrmConfig2, UnitEngineParameterClass2,
  UnitHiMECSUserClass2, UnitMenuBaseClass2, FrmEngParamConfig2, UnitProjectBaseClass2,
  UnitProjectFileClass2, UnitFrameTileList2, UnitHiMECSConfigCollect2, UnitHiMECSMonitorListClass2,
  IPCThrd_HiMECS_MDI, UnitKillProcessList, UnitKillProcessListClass2,
  UnitParameterManager2, UnitHiMECSManualClass2, UnitHiMECSCommandLine,
  UnitEngineParamRecord2, UnitEngineParamConst, decTreeView, FormAboutDefs,
  EasterEgg, JvExComCtrls, JvComCtrls, UnitHiMECSRestServer, //UnitHiMECSHttpApiServer2,
  JHP.Util.gpSharedMem, GpSharedEvents, JvCheckTreeView, CheckComboBox,
  JvCaptionButton, Vcl.Buttons, cyBaseButton, cyBitBtn, UnitHiMECSRestAPIInterface,
  UnitProjectGroupClass
  ;//, FrmModalAndMDIForm;

type
  TWMTraceData = record
    Msg: Cardinal;
    X: Smallint;
    Y: Smallint;
    Flag: TClientFlag;
    Result: Longint;
  end;

  TLabelRec = record
    XLabel: TLabel;
    YLabel: TLabel;
  end;

  TMainForm = class(TForm, IConfigChanged)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Settings1: TMenuItem;
    Software1: TMenuItem;
    Connect1: TMenuItem;
    DisConnect1: TMenuItem;
    N1: TMenuItem;
    Configuration1: TMenuItem;
    Project1: TMenuItem;
    N3: TMenuItem;
    Download2: TMenuItem;
    CheckVersion1: TMenuItem;
    Openproject1: TMenuItem;
    CloseProject1: TMenuItem;
    SmallImageList: TImageList;
    LargeImageList: TImageList;
    AdvNavBar1: TAdvNavBar;
    EngineInfoPanel: TAdvNavBarPanel;
    EngineModbusPanel: TAdvNavBarPanel;
    ProjectInfoPanel: TAdvNavBarPanel;
    EngMaintenancePanel: TAdvNavBarPanel;
    MonitoringPanel: TAdvNavBarPanel;
    AdvSplitter1: TAdvSplitter;
    JvOpenDialog1: TJvOpenDialog;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    FileClose1: TWindowClose;
    FileSave1: TAction;
    FileSaveAs1: TAction;
    FileExit1: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowTileVertical1: TWindowTileVertical;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowArrangeAll1: TWindowArrange;
    HelpAbout1: TAction;
    ActionMDICascade: TAction;
    ActionMDITileHorizontal: TAction;
    ActionMDITileVertical: TAction;
    ActionMDIArrange: TAction;
    ActionMDIMinimize: TAction;
    acLaunchNotepad: TAction;
    MainMenuImageList: TImageList;
    Window1: TMenuItem;
    Cascade1: TMenuItem;
    Horizontal1: TMenuItem;
    Vertical1: TMenuItem;
    EngineInfoPopupMenu: TPopupMenu;
    SaveEngineInfo1: TMenuItem;
    CallapseAll1: TMenuItem;
    ExpandAll1: TMenuItem;
    N2: TMenuItem;
    LoadAllInfo1: TMenuItem;
    Options1: TMenuItem;
    LoadEngineInfo1: TMenuItem;
    JvSaveDialog1: TJvSaveDialog;
    imTreeView: TImageList;
    ModbusPopUp: TPopupMenu;
    MenuItem3: TMenuItem;
    SortbySystem1: TMenuItem;
    SortbySensor1: TMenuItem;
    CreateCategory1: TMenuItem;
    CopyItem1: TMenuItem;
    LoadParameterfromfile1: TMenuItem;
    N4: TMenuItem;
    MDITabPopup: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem4: TMenuItem;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvPopupMenu1: TAdvPopupMenu;
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    ImageListThrobber: TImageList;
    Timer1: TTimer;
    N5: TMenuItem;
    Clearallparameter1: TMenuItem;
    CreateSubCategory1: TMenuItem;
    N6: TMenuItem;
    DeleteItem1: TMenuItem;
    SavetoFile1: TMenuItem;
    AddtoNewWatch1: TMenuItem;
    N7: TMenuItem;
    Property1: TMenuItem;
    CallapseAll2: TMenuItem;
    ExpandAll2: TMenuItem;
    N8: TMenuItem;
    AddtoNewWatch21: TMenuItem;
    AddtoAlarmList1: TMenuItem;
    AdvSmoothSplashScreen1: TAdvSmoothSplashScreen;
    GDIPPictureContainer1: TGDIPPictureContainer;
    AddtoSaveList1: TMenuItem;
    WebUpdate1: TWebUpdate;
    StatusBarPro1: TAdvOfficeStatusBar;
    ModbusDropTarget: TDropTextTarget;
    EngParamSource: TDropTextSource;
    ProjectInfoInspector: TNextInspector;
    NxTextItem6: TNxTextItem;
    ProjInfoPopupMenu: TPopupMenu;
    MenuItem2: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    LoadProjectInfo1: TMenuItem;
    SaveProjectInfo1: TMenuItem;
    N9: TMenuItem;
    SaveAsProject1: TMenuItem;
    CreateProject1: TMenuItem;
    EngineInfoInspector: TNextInspector;
    SelectEngineCombo: TNxComboBoxItem;
    NxTextItem1: TNxTextItem;
    NxTextItem2: TNxTextItem;
    NxTextItem3: TNxTextItem;
    NxTextItem4: TNxTextItem;
    ComponentsNxItem: TNxTextItem;
    AddDummy1: TMenuItem;
    CommunicationPanel: TAdvNavBarPanel;
    TileConfigPopup: TPopupMenu;
    LoadFromFile1: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    ExecuteAll1: TMenuItem;
    ExecuteSelectedTile1: TMenuItem;
    TileConfig2: TMenuItem;
    N10: TMenuItem;
    ListConfig1: TMenuItem;
    N11: TMenuItem;
    ShowAllMonitor1: TMenuItem;
    HideAllMonitor1: TMenuItem;
    NxTextItem5: TNxTextItem;
    CopyParameterToMonitor1: TMenuItem;
    JvApplicationHotKey1: TJvApplicationHotKey;
    ManualPanel: TAdvNavBarPanel;
    Panel2: TPanel;
    ManualSearchEdit: TEdit;
    AdvSmartMessageBox1: TAdvSmartMessageBox;
    MDITabSet: TAdvOfficeMDITabSet;
    AdvOfficeTabSet1: TAdvOfficeTabSet;
    N12: TMenuItem;
    N13: TMenuItem;
    ShowNodeIndex1: TMenuItem;
    N14: TMenuItem;
    MinimizeAll1: TMenuItem;
    MaxmizeAll1: TMenuItem;
    RestoreAll1: TMenuItem;
    Panel3: TPanel;
    SystemRB: TRadioButton;
    PartRB: TRadioButton;
    SectionRB: TRadioButton;
    ShowMultiState1: TMenuItem;
    ShowDrawing1: TMenuItem;
    MonTileListFrame: TTileListFrame;
    CommTileListFrame: TTileListFrame;
    SortbySensorSystem1: TMenuItem;
    ShowWirePath1: TMenuItem;
    ManualPopup: TPopupMenu;
    FileInfo1: TMenuItem;
    Panel4: TPanel;
    Panel1: TPanel;
    SrchTextEdit: TEdit;
    FormAbout1: TFormAbout;
    Help1: TMenuItem;
    About1: TMenuItem;
    EngModbusTV: TJvCheckTreeView;
    ManualCheckTV: TJvCheckTreeView;
    JvTreeView1: TJvTreeView;
    Button1: TButton;
    Button2: TButton;
    EngModbusFilterCheck: TCheckBox;
    ModbusFilterCheckcb: TCheckComboBox;
    ModbusFilterClearBtn: TButton;
    ShowManual1: TMenuItem;
    ShowDiagram1: TMenuItem;
    EngCountPanel: TPanel;
    JvCaptionButton1: TJvCaptionButton;
    EngBtn1: TcyBitBtn;
    EngBtn2: TcyBitBtn;
    EngBtn3: TcyBitBtn;
    EngBtn4: TcyBitBtn;
    ParameterPanel: TAdvNavBarPanel;
    ParameterTV: TJvCheckTreeView;
    Panel5: TPanel;
    ParameterSrchEdit: TEdit;
    Panel6: TPanel;
    ParameterFilterCheck: TCheckBox;
    ParameterFilterCheckCB: TCheckComboBox;
    ParameterFilterClearBtn: TButton;
    ParameterPopup: TPopupMenu;
    EngModbusSource: TDropTextSource;
    ParamDropTarget: TDropTextTarget;
    Property2: TMenuItem;
    ShowSelectedParameterList1: TMenuItem;
    N15: TMenuItem;
    ShowParameterListToNewForm1: TMenuItem;
    MaintenanceTV: TJvCheckTreeView;
    Panel7: TPanel;
    MaintenanceSrchEdit: TEdit;
    Panel8: TPanel;
    RadioButton1: TRadioButton;
    RadioButton3: TRadioButton;
    SelectEquipment1: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EngineInfoInspectorMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EngineInfoInspectorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AdvNavBar1SplitterMove(Sender: TObject; OldSplitterPosition,
      NewSplitterPosition: Integer);
    procedure Cascade1Click(Sender: TObject);
    procedure Horizontal1Click(Sender: TObject);
    procedure Vertical1Click(Sender: TObject);
    procedure MinimizeAll1Click(Sender: TObject);
    procedure MaxmizeAll1Click(Sender: TObject);
    procedure RestoreAll1Click(Sender: TObject);
    procedure ExpandAll1Click(Sender: TObject);
    procedure LoadAllInfo1Click(Sender: TObject);

    procedure Options1Click(Sender: TObject);
    procedure LoadEngineInfo1Click(Sender: TObject);
    procedure SaveEngineInfo1Click(Sender: TObject);
    procedure SortbySystem1Click(Sender: TObject);
    procedure SortbySensor1Click(Sender: TObject);
    procedure LoadParameterfromfile1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure ModbusDropTargetDrop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure CreateCategory1Click(Sender: TObject);
    procedure Clearallparameter1Click(Sender: TObject);
    procedure CreateSubCategory1Click(Sender: TObject);
    procedure ModbusDropTargetDragOver(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure DeleteItem1Click(Sender: TObject);
    procedure SavetoFile1Click(Sender: TObject);
    procedure AddtoNewWatch1Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure EngineInfoInspectorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EngineInfoInspectorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EngineInfoInspectorAfterEdit(Sender: TObject; Item: TNxPropertyItem);
    procedure CallapseAll2Click(Sender: TObject);
    procedure ExpandAll2Click(Sender: TObject);
    procedure CallapseAll1Click(Sender: TObject);
    procedure CopyItem1Click(Sender: TObject);
    procedure AddtoNewWatch21Click(Sender: TObject);
    procedure AddtoAlarmList1Click(Sender: TObject);
    procedure AddtoSaveList1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure LoadProjectInfo1Click(Sender: TObject);
    procedure SaveProjectInfo1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure SaveAsProject1Click(Sender: TObject);
    procedure SelectEngineComboCloseUp(Sender: TNxPropertyItem);
    procedure AddDummy1Click(Sender: TObject);
    procedure SrchTextEditChange(Sender: TObject);

    procedure MonTileListFrametileListTileDblClick(Sender: TObject;
      ATile: TAdvSmoothTile; State: TTileState);
    procedure CommTileListFrametileListTileDblClick(Sender: TObject;
      ATile: TAdvSmoothTile; State: TTileState);
    procedure CommTileListFrametileListMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MonTileListFrametileListMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TileConfig2Click(Sender: TObject);
    procedure LoadFromFile1Click(Sender: TObject);
    procedure ExecuteSelectedTile1Click(Sender: TObject);
    procedure StatusBarPro1Click(Sender: TObject);
    procedure MDITabSetTabClick(Sender: TObject; TabIndex: Integer);
    procedure ListConfig1Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure ShowAllMonitor1Click(Sender: TObject);
    procedure HideAllMonitor1Click(Sender: TObject);
    procedure WebUpdate1FileProgress(Sender: TObject; FileName: string; Pos,
      Size: Integer);
    procedure CopyParameterToMonitor1Click(Sender: TObject);
    procedure ManualSearchEditChange(Sender: TObject);
    procedure ShowNodeIndex1Click(Sender: TObject);
    procedure ShowMultiState1Click(Sender: TObject);
    procedure SortbySensorSystem1Click(Sender: TObject);
    procedure ShowWirePath1Click(Sender: TObject);
    procedure FileInfo1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure EngModbusTVDblClick(Sender: TObject);
    procedure EngModbusTVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EngModbusTVKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EngModbusTVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ManualCheckTVDblClick(Sender: TObject);
    procedure ManualCheckTVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ManualCheckTVKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ManualCheckTVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EngModbusTVCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EngModbusFilterCheckClick(Sender: TObject);
    procedure ModbusFilterClearBtnClick(Sender: TObject);
    procedure ModbusFilterCheckcbCloseUp(Sender: TObject);
    procedure ShowManual1Click(Sender: TObject);
    procedure ShowDrawing1Click(Sender: TObject);
    procedure ShowDiagram1Click(Sender: TObject);
    procedure EngBtn1Click(Sender: TObject);
    procedure EngBtn2Click(Sender: TObject);
    procedure EngBtn3Click(Sender: TObject);
    procedure EngBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure JvCaptionButton1Click(Sender: TObject);
    procedure SystemRBClick(Sender: TObject);
    procedure PartRBClick(Sender: TObject);
    procedure SectionRBClick(Sender: TObject);
    procedure ManualSearchEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ParameterSrchEditChange(Sender: TObject);
    procedure ParameterFilterCheckClick(Sender: TObject);
    procedure ParameterFilterCheckCBCloseUp(Sender: TObject);
    procedure ParameterFilterClearBtnClick(Sender: TObject);
    procedure ParameterTVDblClick(Sender: TObject);
    procedure ParameterTVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ParameterTVKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ParameterTVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ParamDropTargetDragOver(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure ParamDropTargetDrop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure Property1Click(Sender: TObject);
    procedure Property2Click(Sender: TObject);
    procedure ShowSelectedParameterList1Click(Sender: TObject);
    procedure ShowParameterListToNewForm1Click(Sender: TObject);
    procedure MaintenanceTVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MaintenanceTVDblClick(Sender: TObject);
    procedure MaintenanceTVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MaintenanceTVKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SelectEquipment1Click(Sender: TObject);
  private
    FEgg: TEasternEgg;
    FOldPanelProc: TWndMethod;
    FNewClient,
    FOldClient: Pointer;

    FFirst: Boolean; //타이머 동작 완료하면 True
//    FPackageModules : array of HModule;
    FWatchHandles : TpjhArrayHandle;//Parameter 창 PopupMenu에서 Ass to Multi-Watch 창을 띄운 경우의 Handle을 저장 함
    //FAutoRunHandles: TpjhArrayHandle;
    //FMonitorHandles: TpjhArrayHandle;
    FPackageList_Exes: TStringList;
//    FCreateChildFromBPL : array of TCreateChildFromBPL;
    FPJHTimerPool: TPJHTimerPool;

    FApplicationPath: string;

    FMouseClickModbusTV_X,
    FMouseClickModbusTV_Y,
    FMouseClickParamTV_X,
    FMouseClickParamTV_Y,
    FMouseClickManualTV_X,
    FMouseClickManualTV_Y,
    FMouseClickMaintenanceTV_X,
    FMouseClickMaintenanceTV_Y
    : Integer;

    FHiMECSUser: THiMECSUser;
    FHiMECSForms: THiMECSForms; //xml로 부터 MDI Child form(bpl) list를 저장함
    FHiMECSExes: THiMECSExes; //xml로 부터 Exe List를 저장함
    //FEngineInfoCollect: TICEngine; //Engine Basic Info
    //FEngineInfoList: TStringList;
    //FProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ProjectInfo로 데체함
//    FProjectInfoCollect: TVesselInfo; //Project Info(공사번호 등...)
    FCurrentSelectedProjectFile: TProjectFile;//project file
    FProjectGroup: THiMECSProjectGroup;//Vessel 단위 관리
    FCurrentProjectFileIndex: integer;//현재 선택된 Project File의 PeojectGroup Index
    FMenuBase: TMenuBase;
    //FHiMECSOptions: THiMECSOptions;
    //FHiMECSConfig: THiMECSConfig;
    //FEngineParameter: TEngineParameter;
    FSearchParamList: TStringList;
    FCurrentModbusFileName, //Sort할때 현재 사용중인 파일이름이 필요함
    FCurrentParamFileName,
    FCurrentManualInfoFileName,
    FUserFileName: string;//Login에 필요한 User File name

    //Engine Parameter에서 Properties 메뉴를 선택하거나
    //Engine Info에서 Engine Select 할때 변경 됨
    FCOI: integer;//FCurrentOptionIndex: 사용중인 FHiMECSOptions.HiMECSOptionsCollect Index
    //FCEI: integer;//FCurrentEngineInfoIndex: 사용중인 FEngineInfoList Index
    FCurrentUserLevel: THiMECSUserLevel;
    FCurrentUserIndex: integer;  //User List에서 현재 User의 Index 저장
    FMDIChildCount: Integer;
    FWindowList: array of Integer;

    FEngineParameterItemRecord: TEngineParameterItemRecord; //Watch폼에 값 전달시 사용

    FMultiWatchHandle,
    FAlarmListHandle: THandle;

    FTick: integer;
    FProcInfo: TProcessInformation;
    FModbusDragFormatTarget: TGenericDataFormat;
    FParamDragFormatTarget: TGenericDataFormat;

    FEngModbusSource: TEngineParameterDataFormat;
    FEngParamSource: TEngineParameterDataFormat;
    //FEP_DragDrop: TEngineParameter_DragDrop; //drag drop 으로 받은 record
    FParameterDragMode: Boolean;//Treeview에서 마우스 클릭시 True,False 됨.
    FParamCopyMode: integer;//Ord(TParamDragCopyMode)가 저장 됨
    FArrayEngineParameterItemRecord : array of TEngineParameterItemRecord;

    //---------------------------------------------
    // For TreeView Drag & Drop
    FCurrentNode: TTreeNode;
    CurrentPos: Char;
    GhostNode: TTreeNode;

    //Key Map
    FKeyBdShiftState: TShiftState;
    FTempState: integer;
    FControlPressed,
    FControlPressedManualTV,
    FControlPressedMaintenanceTV
    : Boolean;
    FParamSearchMode: Boolean;//Parameter Treeview searchmode

    //FIPCServer: TIPCServer;
    FCurrentEngParamSortMethod: TParamSortMethod;
    FCurrentManualSortMethod: TManualSortMethod;
    FCurrentManualSearchSrc: TManualSearchSrc;
    FSelectedTile: TAdvSmoothTileList;
    //FMonitorList: TStringList;
    //FApplicationList: TStringList;

    FStatusText: string;
    FKillProcessList: TKillProcessList;
    FPM: TParameterManager;
    FJHP_gpShM: TJHP_gpShM;

    //FilterCheckcb 내용이 변경 여부 판단하기 위해 이전 값 저장용
    FFilterText4Modbus: string;
    FFilterText4Parameter: string;
    //HiMECS Diagram(Chromium)에서 axios로 Model Json data 요청할 때 응답하기 위함
    FHiMECSHTTPAPIServer: THiMECSHTTPAPIServer;

    //FIsProjectClosed: Boolean; //True = Project Close 상태

    procedure GpSMEventReceivedNotify(Sender: TObject;
      producerHandle: TGpSEHandle; const producerName, eventName,
      eventData: string);
    procedure OnEggShowRegInfo(msg: string);
    procedure OnEggDelRegInfo(msg: string);
    procedure PanelMsgProc(var Msg: TMessage);
    procedure MDIClientProc(var Msg: TMessage);
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;
//    procedure WMCableRouteFormColse(var Msg: TMessage); message WM_CABLEROUTEFORMCLOSE;
    procedure MoveNode(ATreeView: TTreeView; ATargetNode, ASourceNode: TTreeNode);
//---------------------------------------------
    procedure CreateProc;
    procedure DestroyProc(AFreePrjFile: Boolean=true);
    procedure DestroyObjectFromList(AList: TStringList);
    procedure DoTile(TileMode: TTileMode);
    procedure CreateExtMDIChild(const AWindowTitle: string);
    function ReparentWindowForWindow(const WindowTitle: string): THandle;
    procedure ReparentWindow(AHandle: HWND);
    procedure CloseExtMDIChild;

    procedure PackageLoad_MDIChild;

    procedure CreateChildFormAll;
    function CreateOrShowChildFormFromBpl(Aform: string; var AIndex: integer):Boolean;
    function CreateOrShowMDIChild(AForm: TFormClass): TForm;
    function CreateDummyMDIChild(AClientHandle: integer = -1): TForm;
    function CreateMIDChild(AForm: TFormClass; const Args: string; AIsMaxForm: Boolean=False): TForm;
    function CreateModalNMIDChild(AForm: TFormClass; const Args: string;
      AIsModal: Boolean=False; AIsMaxForm: Boolean=False): TForm;
    procedure CreateNShowWirePathForm(AEngParam: TEngineParameterItem; AIsCreateNewForm: Boolean);
    procedure ChildFormClose(Sender: TObject; var Action: TCloseAction);
    procedure NxButtonItemButtonClick(Sender: TNxPropertyItem);

    procedure LoadMenuFromFile(AFileName: string; AIsUseLevel: Boolean);
    procedure SetHiMECSMainMenu(AMenuBase: TMenuBase);
    function InsertMenuItem(AMenu: TMenuItem; AInsertIndex: Integer; ANested: string;
      AOnClick: TNotifyEvent = nil; Action: TContainedAction = nil;
      AShortCut: TShortCut = 0): TMenuItem;
    procedure SetControlEvent(AControl: TControl; AInsertIndex: integer; AEvent: string);
    procedure SetMenuImageIndex(AMenuItem: TMenuItem; AInsertIndex: integer);

    procedure AddDefaultData2File(AFileName: string);
    procedure LoadConfigCollect2Form(AForm: TConfigF);
    procedure LoadConfigForm2Collect(AForm: TConfigF);
    procedure LoadConfigCollectFromFile(AIndex: integer);
    function GetSearchListFromDeviceName(const ADeviceName, AInfoName: string): TStringList;

    //Engine Info
    procedure LoadEngineInfo(AFileName:string; AIsEncrypt: Boolean; AIsAdd2Combo: Boolean = True; AIs2Inspector: Boolean = False);
    procedure SetEngineInfo2Inspector(AIndex: integer; AIsAdd2Combo: Boolean=false);
    procedure SaveEngineInfo(AFileName:string; AIsEncrypt: Boolean);

    //Engine Parameter
    function LoadParamterFromFile_(AFileName: string; var AParamObj: TEngineParameter;
      AParamFileFormat: integer; AIsEncrypt: Boolean; AEPKind: TEngParamListItemKind=eplikModbus): integer;
    function LoadParamterFromFile(AFileName: string; AEPKind: TEngParamListItemKind): integer;
    procedure LoadParameterList2TV(ASortMethod: TParamSortMethod; ATV: TJvCheckTreeView=nil;
      AOptIdx: integer = -1; AEPKind: TEngParamListItemKind=eplikNull);
    procedure LoadParameter2TreeView(ASortMethod: TParamSortMethod;
      ARootNode: TTreeNode = nil; AIndex: integer = -1; ATV: TJvCheckTreeView=nil; AEPKind: TEngParamListItemKind=eplikNull);
//    procedure LoadParameter2TreeView(AFileName:string; ASortMethod: TParamSortMethod;
//      ARootNode: TTreeNode = nil; AIndex: integer = -1; ATV: TJvCheckTreeView=nil);
    procedure LoadParameter2TVBySortMtehod(ARootNode: TTreeNode; AParam: TEngineParameter;
      ASortMethod: TParamSortMethod; ATV: TJvCheckTreeView=nil; AEPKind: TEngParamListItemKind=eplikNull);
    procedure LoadParameter2SystemTV(ARoot: TTreeNode; AParam: TEngineParameter; AUseSensorType: Boolean=False; ATV: TJvCheckTreeView=nil);
    procedure LoadParameter2SensorTV(ARoot: TTreeNode; AParam: TEngineParameter; ATV: TJvCheckTreeView=nil);
    procedure SaveParamTV2File(AFileName:string; AIsEncrypt: Boolean; ATV: TJvCheckTreeView=nil);
    procedure LoadSearchTreeFromEngParam(ASearchTypes: TSensorTypes; ASearchText: string; ASortMethod: TParamSortMethod; ATV: TJvCheckTreeView=nil);
    //EngParam을 복사하지 않고 원본에서 삭제할 Item을 FIsHideItem = True로 변경함
    procedure LoadSearchTreeFromEngParam2(ASearchTypes: TSensorTypes; ASearchText: string;
      ASortMethod: TParamSortMethod; ATV: TJvCheckTreeView=nil; AEPKind: TEngParamListItemKind=eplikModbus);
    procedure LoadSearchTreeFromEngParamSensorType(ASearchTypes: TSensorTypes;
      ASortMethod: TParamSortMethod; ATV: TJvCheckTreeView=nil; AEPKind: TEngParamListItemKind=eplikModbus);
    function GetSensorTypesFromParamSearchCheck(AFilter: string): TSensorTypes;
    function IsIncludeSensorTypesFromEngParamItem(const AEngineParameterItem: TEngineParameterItem; ASensorTypes: TSensorTypes): Boolean;
    //FSearchParamList에 HiMECSConfig.EngineParameter를 복사함
    procedure InitSearchParamList(ADeviceName: string='');
    procedure ClearHideItemsOfEngParamFromProj(AEPKind: TEngParamListItemKind=eplikModbus);
    //검색 결과를 JSON으로 반환함
    function GetSearchTree2JsonFromSearchParamList(ASearchTypes: TSensorTypes; ASearchText: string; ASearchFieldName: integer=0): RawUTF8;
    procedure ShowPropertyForm(ATV: TJvCheckTreeView; AIsParamTV: Bool = False);
    function GetEngParamFromHiMECSConfigByEPKind(AEPKind: TEngParamListItemKind; AIndex: integer): TEngineParameter;
    function GetEngParamFromItem(AEPItem: TEngineParameterItem; AIndex: integer=-1): TEngineParameter;

    //Project Info
    procedure LoadProjectInfo(AFileName:string; AIsEncrypt: Boolean=False; AIs2Inspector: Boolean = False);
    procedure SaveProjectInfo(AFileName:string; AIsEncrypt: Boolean=False);
    procedure SetProjectInfo2Inspector;

    //Manual Info\
    procedure LoadManualInfoFromFile(AFileName: string; AIndex: integer = -1);
    procedure SetManualInfo2Inspector;
    procedure LoadManualInfo2TV(AManualKind : TManualItemKinds; ASortMethod: TManualSortMethod = msmMSNo; ATV: TJvCheckTreeView=nil);
    procedure LoadManualInfo2TreeView(AManualKind : TManualItemKinds; ASortMethod: TManualSortMethod; ARootNode: TTreeNode = nil; AIndex: integer = -1; ATV: TJvCheckTreeView=nil);
//    procedure LoadManualInfo2TreeView(AFileName:string;
//      ASortMethod: TManualSortMethod; ARootNode: TTreeNode = nil; AIndex: integer = -1; ATV: TJvCheckTreeView=nil);
    procedure LoadManualInfo2MsNoTV(ARoot: TTreeNode; AManualInfo: THiMECSManualInfo; AManualKind : TManualItemKinds; ATV: TJvCheckTreeView=nil);
    procedure LoadManualInfo2PlateNoTV(ARoot: TTreeNode; AManualInfo: THiMECSManualInfo; AManualKind : TManualItemKinds; ATV: TJvCheckTreeView=nil);
    procedure LoadSearchTreeFromManualInfoSrc(ASearchSrc: TManualSearchSrc; AManualKind : TManualItemKinds; ASortMethod: TManualSortMethod=msmMSNo; ATV: TJvCheckTreeView=nil);
    procedure LoadSearchTreeFromManualInfo(ASearchText: string; AManualKind : TManualItemKinds; ASortMethod: TManualSortMethod=msmMSNo;
      ASearchSrc: TManualSearchSrc=mssSystem;ATV: TJvCheckTreeView=nil);
    procedure LoadSearchTreeFromManualInfo2(ASearchText: string; AManualKind : TManualItemKinds; ASortMethod: TManualSortMethod=msmMSNo;
      ASearchSrc: TManualSearchSrc=mssSystem; ATV: TJvCheckTreeView=nil);
    function GetFullFilePathFromManualInfo(var ADrawingPath, AManualPath: string): Boolean;
    procedure CreateMDI4PDF(AFileName, ASystemDesc: string; APageB: integer; ADocType: THiMECSDocType);
    procedure ClearHideItemsOfManualInfoFromProj;
    procedure SetHideItemsOfManualInfoBySearchTxt(AManual: THiMECSManualInfo; AKind: TManualItemKind; ASearchSrc: TManualSearchSrc; ASearchText: string);
    function GetSearchTree2JsonFromManualInfo(ADeviceName: string; ASortMethod: TManualSortMethod; ASearchText: string; ASearchSrc: TManualSearchSrc=mssNull): RawUTF8;
    function GetManualSearchSrcFromForm: TManualSearchSrc;

    //시간이 소요되는 Engine Parameter Load 를 Async로 함
    procedure AsyncLoadInfoData;

    function GetNodeStrFromTreeView(ATV: TJvCheckTreeView; ACommandRec: TCommandRec; out AJson: string): integer;
    procedure ParameterItem2ParamList(ANode: TTreeNode; AForm: TForm);

    procedure PackageLoad_Exe; //사용하지 않음 나중에 재확인 할것
    function AddExeToList(APackageName:string): Boolean;
    procedure SendAlarmCopyData(ToHandle: integer; AEP:TEngineParameterItemRecord);
    procedure SendUserLevelCopyData(ToHandle: integer; AUserLevel:THiMECSUserLevel);
    procedure SendParamCopyData(ToHandle: integer; AEP:TEngineParameterItem);

    procedure DisplayMessage(AMessage: string; ASaveType: TMessageSaveType;
                            AMessageType: TMessageType);
    procedure SaveMsg2File(AMessage: string; AMessaggeType: TMessageType);

    procedure DoConfigChange;

    procedure OnParamChange(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnModbusChange(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnManualInfoChange(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure OnProcessKill(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    //procedure MoveEngineParameterItemRecord(var ASourceRecord: TEngineParameterItemRecord;
    //                         AEPItemRecord:TEngineParameterItem);
    procedure MoveMatrixData2ItemRecord(var ARecord: TEngineParameterItemRecord;
                             AEPItem:TEngineParameterItem);
    procedure SendEngParam2HandleWindow(AEPItemRecord: TEngineParameterItem;
                    ADestHandle: Integer = -1);
    procedure CopyParameter2AllMonitor;

    procedure LoadWatchListAll;
    function ExecLaunchList(AProgName, AParam: string): THandle;//; AHandles: TpjhArrayHandle);
    function CheckWatchListOfSummary(AFileName: string): Boolean;
    procedure Add2MultiNode(ANode: TTreeNode; AIsForWatch: Boolean;
      AMultiSelect: boolean; ADestHandle: integer = -1; AForm: TForm = nil);
    procedure Add2AlarmList(ANode: TTreeNode; AAddSibling: boolean=false);
    procedure Add2WatchSave(ANode: TTreeNode; AAddSibling: boolean=false);
    procedure Add2ParamViewList(AFormHandle: THandle; ANode: TTreeNode; AAddSibling: boolean=false);
    procedure ShowParamList(ANode: TTreeNode; AIsCreateNewForm: Boolean);
    procedure Add2xxxList(ANode: TTreeNode; var AHandle: THandle;
                      AHandleArray: TpjhArrayHandle; AExeName: String;
                      AAddSibling: boolean=false);
    function GetJsonOfWirePathFromTagName(ATagName: string): string;

    procedure ApplyChangedProjectItem;
    function ProcessCommandLineParameter(var AUserID, APasswd, APrjFileName: string;
      var AIsPreventOnVM, AIsIgnoreMachineID: Boolean):Boolean;
    procedure OnExecuteRequest(const Request, Response: IIPCData);

    procedure TileConfig(ATile: TAdvSmoothTileList);
    procedure LoadTileConfig2Form(AConfigF: TTileConfigF; AType: integer);
    procedure LoadTileConfigForm2Collect(AConfigF: TTileConfigF; AType: integer);
    procedure TileConfigChange(AType: integer);
    procedure SetConfigAutoRunTile(ATile: TAdvSmoothTile);
    procedure SetConfigMonitorTile(ATile: TAdvSmoothTile);
    procedure ShowWindowFromSelectedTile;
    procedure ShowManualFileInfo();
    procedure ShowMaintenanceFileInfo();

    procedure LoadKillProcess;
    procedure ExecProcessKill;

    function GetMultiStateMeaning(AEngParamItem: TEngineParameterItem): string;
    function GetSensorIconImgIndex(ASensorType: TSensorType): integer;
    function GetDbPathFromApplicationsFolder: string;

    function SensorTypeSelectChanged4Modbus(out ASensorTypes: TSensorTypes): Boolean;
    function SensorTypeSelectChanged4Parameter(out ASensorTypes: TSensorTypes): Boolean;
    procedure ProcessCmdFromCommServer(const AJsonEventData: string);

    procedure InitEnum;
    procedure InitHttpApiServer;
    procedure InitHTTPRestServer;
  public
    procedure ApplyConfigChange;
    procedure SetEngineType(AType: string);
    procedure AddCategory2ParamTV(Node: TTreeNode; ASubNode: boolean);
    procedure AddItem2ParamTV(Node: TTreeNode);
    function CopyItem2EngineParamCollect(Node: TTreeNode): integer;
    procedure UpdateProgress4Splash(Percentage: integer);
    function LoginProcess(AAutoLogin: Boolean = false; AUserId: string = '';
      APasswd: string = ''): Boolean; //Login 성공시 true
    function LoadUserFileName(AFileName, AUserId, APasswd: string): Boolean;
    function CheckUserFromUserFile(AUserID, APasswd, AUserFileName: string): Boolean;
    procedure Init(AAutoStart: Boolean = False; AFirstStart: Boolean = True);
    procedure PackageLoadFromMenu;
    function SelectProject(AProjectFileName: string=''): Boolean;
    function SubProcessSelectProject(AFileName: string): Boolean;
    function SelectUserFile: Boolean;
    procedure SetEngineCount2Form;
    procedure HideAllEngineCountBtn;
    procedure DisableAllEngCountBtn;
    procedure SetEngCountBtnColor(ACyBitBtn: TCyBitBtn; AColor: TColor);
    //NavBar에 해당 엔진의 데이타 표시함
    procedure SetEngineData2NavBar(AOptIdx: integer=-1);
    procedure ClearNavBar;

    procedure LoadAutoRunList;
    procedure LoadAutoRunTileFromFile(AFileName: string; AIsAppend: Boolean;
      AAutoRunList: TAutoRunList);
    procedure LoadAutoRunVar2Form(ATile: TAdvSmoothTile; AVar: TAutoRunItem);
    procedure LoadAutoRunConfigForm2Var(AForm: TnewCommApp_Frm; AVar: TAutoRunItem);
    procedure LoadAutoRunVar2ConfigForm(AForm: TnewCommApp_Frm; AVar: TAutoRunItem);
    procedure LoadAutoRun(AVar: TAutoRunItem);
    procedure ExecuteAutoRunList(AAutoRunList: TAutoRunList;
      AIsAll: Boolean=true; AIsAuto: Boolean=true; AIsSelected: Boolean=true);
    procedure ExecuteSelectedTile(ATile: TAdvSmoothTileList);
    procedure ShowWindowFromSelectedCommTile(AWinMsgAction: integer;AAutoRunItem: TAutoRunItem = nil);
    procedure SetAutoRunList2Inspector(AIndex: integer);

    procedure LoadMonitorFormList;
    procedure LoadMonitorTileFromFile(AFileName: string; AIsAppend: Boolean;
      AHiMECSMonitorList: THiMECSMonitorList);
    procedure LoadMonitorVar2Form(ATile: TAdvSmoothTile; AVar: THiMECSMonitorListItem);
    procedure LoadMonitorConfigForm2Var(AForm: TnewMonApp_Frm; AVar: THiMECSMonitorListItem);
    procedure LoadMonitorVar2ConfigForm(AForm: TnewMonApp_Frm; AVar: THiMECSMonitorListItem);
    procedure LoadMonitor(AVar: THiMECSMonitorListItem);
    procedure ExecuteMonitorList(AHiMECSMonitorList: THiMECSMonitorList;
      AIsAll: Boolean=true; AIsAuto: Boolean=true; AIsSelected: Boolean=true);
    procedure ShowWindowFromSelectedMonTile(AWinMsgAction: integer; AMonItem: THiMECSMonitorListItem = nil);

    procedure SetMonWindow2Top;
    function DoExternalUpdate(AFileName: string; ACheckOnly: Boolean = False): Boolean;
    procedure ShowPanelInside(APanelKind: TPanelKind4AVAT2);
    procedure ShowWirePath;
    procedure ShowWirePathUsingDiagram;
    procedure ShowDrawing;
    procedure ShowManual;
    procedure ShowMultiStateValue;

    //Mobile에서 사용할 JSON 반환 함수들(RN API)
    function GetDocContentOfManual2Json(ARec: TRestAPIResponseDoc): RawUTF8;
    function GetDocContentOfDrawing2Json(ARec: TRestAPIResponseDoc): RawUTF8;
    function GetDocContentOfParameter2Json(ARec: TRestAPIResponseDoc): RawUTF8;

    function GetProjectList2Json4Mobile: RawUTF8;
    function GetDeviceList2Json4Mobile(ARec: TRestAPIResponseDoc): RawUTF8;
    function GetDocList2Json4Mobile(ARec: TRestAPIResponseDoc) : RawUTF8;
    function GetDocContents2Json4Mobile(ARec: TRestAPIResponseDoc): RawUTF8;
    function GetDocPdf2Json4Mobile(ARec: TRestAPIResponseDoc): RawUTF8;
  published  //SetMethod 함수는 publisthed에 선언된 함수만 가능함
    procedure SetConfigData(Sender: TObject);
    function SetConfigEngParamItemData(AEPItem:TEngineParameterItem; AIdx: integer): Boolean;
    procedure ExecApplication(Sender: TObject);
    procedure ExecBpl(Sender: TObject);
    procedure RunCommunicationManager(Sender: TObject);
    procedure LogOutProcess;
    procedure ProgramExit;
    procedure LoginClick;
    procedure SaveAsConfigData;  //.option save
    function GetCurrentOptionIndex(ANode:TTreeNode): integer;
    function GetEngineType(AIndex: integer): string;
    function ProcessSelectProject(AFirstLoad: Boolean;
      AAutoStart: Boolean = False; APrjFileName: string=''): Boolean;
    procedure OpenProject;
    procedure CloseProject(AFreePrjFile: Boolean=true);
    function DoUpdateVersion(ACheckOnly: Boolean = False): Boolean;
    procedure EditProcessKillList;
    procedure ShowMCPPanelInside;
    procedure ShowACPPanelInside;
    procedure ShowLOPPanelInside;
    //Equipment select
    procedure SelectEquipment;
  end;

var
  MainForm: TMainForm;

implementation

uses JvgXMLSerializer_Encrypt, UnitProcessUtil, EngineConst, FrmLogin2, FrmParamList2,
  FrmSelectProject2, jclNTFS, UnitDummyForm, JHP.BaseConfigCollect, FrmPdfViewMDIChild2,
  PdfiumCore, UnitEngineBaseClassUtil2, GpCommandLineParser,
  UnitFolderUtil2, UnitFileUtil, UnitBase64Util2,
  UnitStringUtil, FrmAvatParamView2, UnitFormUtil, UnitTreeViewUtil,
  FrmSensorCableRoute2, DomSensorTypes2, UnitHiMECS2, UnitEncryptedRegInfo2,
  FrmMCPPanelInside2, FrmMCPPanelInside_MDI2, FrmACPPanelInside2, FrmACPPanelInside_MDI2,
  FrmLOPPanelInside, FrmLOPPanelInside_MDI,
  UnitEngineElecPartClass2, UnitNxInspectorUtil, FrmSelectEquipment,
  OtlParallel, OtlComm, mormot.core.os;

{$R *.dfm}

function GetBufStart(Buffer: string; var Level: Integer): string;
var
  Pos: Integer;
begin
  Pos := 1;
  Level := 0;

  while (CharInSet(Buffer[Pos], [' ', #9])) do
  begin
    Inc(Pos);
    Inc(Level);
  end;

  Result := Copy(Buffer, Pos, Length(Buffer) - Pos + 1);
end;

procedure SetNodeImages(Node : TTreeNode; HasChildren : boolean);
begin
  if HasChildren then begin
    Node.HasChildren    := true;
    Node.ImageIndex     := cClosedBook;
    Node.SelectedIndex  := cOpenBook;
  end else begin
    Node.ImageIndex     := cClosedPage;
    Node.SelectedIndex  := cOpenPage;
  end; {if}
end; {SetNodeImages}

procedure TMainForm.CallapseAll1Click(Sender: TObject);
begin
  EngineInfoInspector.CollapseAll;
end;

procedure TMainForm.CallapseAll2Click(Sender: TObject);
begin
  EngModbusTV.FullCollapse;
end;

procedure TMainForm.Cascade1Click(Sender: TObject);
begin
  if (FormStyle = fsMDIForm) and (ClientHandle <> 0) then
    SendMessage(ClientHandle, WM_MDICASCADE, 0, 0);
end;

function TMainForm.CheckUserFromUserFile(AUserID, APasswd,
  AUserFileName: string): Boolean;
var
  i: integer;
  LUser: THiMECSUser;
begin
  Result := False;

  LUser := THiMECSUser.Create(nil);
  try
    SetCurrentDir(ExtractFilePath(Application.ExeName));

    LUser.LoadFromJSONFile(AUserFileName,
                          ExtractFileName(AUserFileName),
                          True);

    for i := 0 to LUser.HiMECSUserCollect.Count - 1 do
    begin
      if (LUser.HiMECSUserCollect.Items[i].UserID = AUserID) and
        (LUser.HiMECSUserCollect.Items[i].Password = APasswd) then
      begin
        Result := True;
        Break;
      end
    end;//for

  finally
    LUser.Free;
  end;
end;

//AFileName의 Summary Information.Template = FCurrentSelectedProjectFile.ProjectFileName 이면 True
function TMainForm.CheckWatchListOfSummary(AFileName: string): Boolean;
var
  LFS: TJclFileSummary;
  LFSI: TJclFileSummaryInformation;
begin
  Result := False;

  LFS:= TJclFileSummary.Create(AFileName, fsaRead, fssDenyAll);
  try
    LFS.GetPropertySet(TJclFileSummaryInformation, LFSI);
    if Assigned(LFSI) then
    begin
                       //상대경로임
      if LFSI.Template = FCurrentSelectedProjectFile.ProjectFileName then
      begin
        Result := True;
      end;
    end;
  finally
    FreeAndNil(LFSI);
    LFS.Free;
  end;
end;

procedure TMainForm.ChildFormClose(Sender: TObject; var Action: TCloseAction);
begin
//  AdvToolBar1.RemoveMDIChildMenu(TForm(Sender));
  MDITabSet.RemoveTab(TForm(Sender));
  Action   := caFree;
end;

procedure TMainForm.Clearallparameter1Click(Sender: TObject);
begin
  EngModbusTV.Items.Clear;
  EngModbusTV.Items.AddChild(nil, 'Parameter');
end;

procedure TMainForm.ClearHideItemsOfEngParamFromProj(AEPKind: TEngParamListItemKind);
var
  i, j: integer;
  LEngineParameter: TEngineParameter;
  LHiMECSConfig: THiMECSConfig;
  LEngParamItem: TEngineParameterItem;
begin
//  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
//  begin
    LEngineParameter := GetEngParamFromHiMECSConfigByEPKind(AEPKind, FCOI);

//    LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
//
//    if AEPKind = eplikModbus then
//      LEngineParameter := LHiMECSConfig.ModbusList
//    else
//    if AEPKind = eplikParameter then
//      LEngineParameter := LHiMECSConfig.EngineParameter;

    for j := LEngineParameter.EngineParameterCollect.Count - 1 downto 0 do
    begin
      LEngParamItem := LEngineParameter.EngineParameterCollect.Items[j];

      if LEngParamItem.FIsHideItem then
        LEngParamItem.FIsHideItem := False;
    end;
//  end;
end;

procedure TMainForm.ClearHideItemsOfManualInfoFromProj;
var
  i, j: integer;
  LHiMECSManualInfo: THiMECSManualInfo;
  LHiMECSConfig: THiMECSConfig;
  LManualItem: THiMECSOpManualItem;
begin
  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
  begin
    LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;
    LHiMECSManualInfo := LHiMECSConfig.ManualInfo;

    for j := LHiMECSManualInfo.OpManual.Count - 1 downto 0 do
    begin
      LManualItem := LHiMECSManualInfo.OpManual.Items[j];

      if LManualItem.FIsHideItem then
        LManualItem.FIsHideItem := False;
    end;

    for j := LHiMECSManualInfo.Drawings.Count - 1 downto 0 do
    begin
      LManualItem := LHiMECSManualInfo.Drawings.Items[j];

      if LManualItem.FIsHideItem then
        LManualItem.FIsHideItem := False;
    end;

    for j := LHiMECSManualInfo.SvcLetter.Count - 1 downto 0 do
    begin
      LManualItem := LHiMECSManualInfo.SvcLetter.Items[j];

      if LManualItem.FIsHideItem then
        LManualItem.FIsHideItem := False;
    end;

    for j := LHiMECSManualInfo.MaintenanceManual.Count - 1 downto 0 do
    begin
      LManualItem := LHiMECSManualInfo.MaintenanceManual.Items[j];

      if LManualItem.FIsHideItem then
        LManualItem.FIsHideItem := False;
    end;
  end;
end;

procedure TMainForm.ClearNavBar;
var
  i: integer;
begin
  for i := 1 to 6 do
    EngineInfoInspector.Items[i].Clear;
//  EngineInfoInspector.PopupMenu := nil;

  EngModbusTV.Items.Clear;
//  EngModbusTV.PopupMenu := nil;

  ManualCheckTV.Items.Clear;
  ProjectInfoInspector.Items[0].Clear;
  MonTileListFrame.tileList.Tiles.Clear;
  CommTileListFrame.tileList.Tiles.Clear;
end;

procedure TMainForm.CloseExtMDIChild;
var
  I: Integer;
  AHandle: HWND;
  LProcessID, LWndProcess: Cardinal;
begin
  for I := Low(FWindowList) to High(FWindowList) do
  begin
    AHandle := FWindowList[I];
    if Windows.IsWindow(AHandle) then
    begin
      //GetWindowThreadProcessId(AHandle, LProcessID);
      Windows.SendMessage(AHandle, WM_CLOSE, 0, 0);
      Windows.SendMessage(AHandle, WM_QUIT, 0, 0);
      WaitForInputIdle(LWndProcess, INFINITE);
      //CloseHandle(LWndProcess); // Leaks calc.exe somehow???
    end;
  end;

  for i := 0 to MDIChildCount - 1 do
    MDIChildren[i].Close;
end;

procedure TMainForm.CloseProject(AFreePrjFile: Boolean);
begin
{  if FIsProjectClosed then
  begin
    ShowMessage('There is no opened project.');
    exit;
  end
  else
    FIsProjectClosed := True;
}
  if AFreePrjFile then
    if Dialogs.MessageDlg('Are you sure to close project?' +#13#10,
        mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo then
      exit;

  DestroyProc(AFreePrjFile);

  HideAllEngineCountBtn();

  ClearNavBar();

  SetCurrentDir(FApplicationPath);
  LoadMenuFromFile(DefaultMenuFileNameOnLogIn, True);
end;

function TMainForm.CopyItem2EngineParamCollect(Node: TTreeNode): integer;
var
  AEPItemRecord: TEngineParameterItem;
  LEngineParameterItem: TEngineParameterItem;
  LEngineParameter: TEngineParameter;
//  LHiMECSConfig: THiMECSConfig;
begin
  Result := -1;
//  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
  AEPItemRecord := TEngineParameterItem(Node.Data);
  LEngineParameter := GetEngParamFromItem(AEPItemRecord);
  LEngineParameterItem := LEngineParameter.EngineParameterCollect.AddEngineParameterItem(AEPItemRecord);
//  LEngineParameterItem :=
//    LHiMECSConfig.EngineParameter.EngineParameterCollect.AddEngineParameterItem(AEPItemRecord);
  Result := LEngineParameterItem.Index;
end;

procedure TMainForm.CopyParameter2AllMonitor;
var
  i,j: integer;
  LHiMECSMonitorList: THiMECSMonitorList;
  LHandle: THandle;
begin
  FParamCopyMode := Ord(dcmCopyOnlyExist);
  FEngineParameterItemRecord.FParamDragCopyMode := dcmCopyOnlyExist;
  try
    for i := Low(FWatchHandles) to High(FWatchHandles) do
    begin
      SendMessage(FWatchHandles[i], WM_MULTICOPY_BEGIN, 0, 0);
      Add2MultiNode(FCurrentNode, False, False, FWatchHandles[i]);
      SendMessage(FWatchHandles[i], WM_MULTICOPY_END, 0, 0);
    end;

    for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
    begin
      LHiMECSMonitorList := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor;

      for j := 0 to LHiMECSMonitorList.MonitorListCollect.Count - 1 do
      begin
        LHandle := LHiMECSMonitorList.MonitorListCollect.Items[j].AppHandle;
        SendMessage(LHandle, WM_MULTICOPY_BEGIN, 0, 0);
        Add2MultiNode(FCurrentNode, False, False, LHandle);
        SendMessage(LHandle, WM_MULTICOPY_END, 0, 0);
      end;
    end;
  finally
    FParamCopyMode := Ord(dcmCopyCancel);
    FEngineParameterItemRecord.FParamDragCopyMode := dcmCopyCancel;
  end;
end;

procedure TMainForm.CopyParameterToMonitor1Click(Sender: TObject);
begin
  CopyParameter2AllMonitor;
end;

procedure TMainForm.CreateCategory1Click(Sender: TObject);
begin
  if EngModbusTV.Selected <> nil then
    AddCategory2ParamTV(EngModbusTV.Selected, False);
end;

procedure TMainForm.CreateChildFormAll;
var
  i,j: Integer;
begin
  for i := 0 to FHiMECSForms.PackageCollect.Count - 1 do
  begin
    for j := Low(FHiMECSForms.PackageCollect.Items[i].FCreateChildFromBPL) to High(FHiMECSForms.PackageCollect.Items[i].FCreateChildFromBPL) do
      if Assigned(FHiMECSForms.PackageCollect.Items[i].FCreateChildFromBPL[j]) then
        FHiMECSForms.PackageCollect.Items[i].FCreateChildFromBPL[j];
  end;
  //if Assigned(FCreateEngineInfo) then
  //  FCreateEngineInfo;
end;

function TMainForm.CreateDummyMDIChild(AClientHandle: integer): TForm;
var
  i: integer;
  bCreated: Bool;
  LTabItem: TOfficeTabCollectionItem;
begin
  bCreated := False;
  Result := nil;

  if not bCreated then
  begin
    Result := TDummyForm.Create(Self);
    TDummyForm(Result).FMainFormHandle := Self.Handle;
    //TDummyForm(Result).Caption := IntToStr(AClientHandle);
    //TDummyForm(Result).FClientFormHandle := ;
//    AdvToolBar1.AddMDIChildMenu(Result);
    Result.OnClose := ChildFormClose;
    LTabItem := MDITabSet.AddTab(Result);
    LTabItem.Tag := AClientHandle;//Result.Handle;
    //Memo1.Lines.Add(IntToStr(AClientHandle)+#13#10);
    ShowWindow(Result.Handle, SW_HIDE);
    //Result.Hide;
  end;
end;

procedure TMainForm.CreateExtMDIChild(const AWindowTitle: string);
var
  LHandle: THandle;
begin
  LHandle := ReparentWindowForWindow(AWindowTitle);
  if LHandle = 0 then
  begin
    ShowMessage('Error create mdi child form');
  end;
end;

procedure TMainForm.CreateMDI4PDF(AFileName, ASystemDesc: string;
  APageB: integer; ADocType: THiMECSDocType);
var
  LObj: variant;
  LArgs: string;
  LForm: TForm;
begin
  LArgs := '';

  TDocVariant.New(LObj);
  LObj.FileName := ChangeFileExt(AFileName, '.pdf');
  LObj.PageNo := APageB;
  LObj.SystemDesc_Eng := ASystemDesc;
  LObj.DocType := Ord(ADocType);
  LArgs := VariantSaveJson(LObj);
  LForm := CreateMIDChild(TPDFViewMDIChildF, LArgs, True);//CreateModalNMIDChild(TPDFViewF, LArgs, False, True);
end;

function TMainForm.CreateMIDChild(AForm: TFormClass;
  const Args: string; AIsMaxForm: Boolean): TForm;
var
  LObj: variant;
begin
  Result := AForm.Create(Application);
  SendCopyData2(Result.Handle, Args, 0);

  if AIsMaxForm then
    Result.WindowState := wsMaximized;

//  AdvToolBar1.AddMDIChildMenu(Result);
  LObj := _JSON(Args);

  Result.Caption := LObj.SystemDesc_Eng;
  Result.OnClose := ChildFormClose;
  MDITabSet.AddTab(Result);
  Result.Show;
end;

function TMainForm.CreateModalNMIDChild(AForm: TFormClass;
  const Args: string; AIsModal, AIsMaxForm: Boolean): TForm;
begin
  if AIsModal then
    Result := AForm.Create(Application)
  else
    Result := AForm.Create(Application);

  SendCopyData2(Result.Handle, Args, 0);

  if AIsMaxForm then
    Result.WindowState := wsMaximized;

//  AdvToolBar1.AddMDIChildMenu(Result);
  if AIsModal then
  begin
    Result.ShowModal;
    Result.Release;
  end
  else
  begin
    Result.OnClose := ChildFormClose;
    MDITabSet.AddTab(Result);
    Result.Show;
  end;
end;

procedure TMainForm.CreateNShowWirePathForm(AEngParam: TEngineParameterItem; AIsCreateNewForm: Boolean);
var
  LSensorCableRouteF: TSensorCableRouteF2;
  LSensorRouteDBName,
  LEngParamFileName, LManualPath, LDrawingPath: string;
  LEngParamFileIsDB: Boolean;
  LOfficeTabCollectionItem: TOfficeTabCollectionItem;
//  LHandle: THandle;
begin
  //폼이 생성된 적이 없으면 한개를 생성해야 함
  if not AIsCreateNewForm then
    AIsCreateNewForm := MDITabSet.AdvOfficeTabCount = 0;

  if AIsCreateNewForm then
  begin
    LSensorCableRouteF := TSensorCableRouteF2.Create(Self);
    LSensorCableRouteF.OnClose := ChildFormClose;
    MDITabSet.AddTab(LSensorCableRouteF);
//    LHandle := LSensorCableRouteF.Handle;
  end
  else
  begin
    LOfficeTabCollectionItem := MDITabSet.AdvOfficeTabs[MDITabSet.ActiveTabIndex];
    LSensorCableRouteF := TSensorCableRouteF2(MDITabSet.GetChildForm(LOfficeTabCollectionItem));
  end;

  LManualPath := AEngParam.ManualNo;
  LDrawingPath := AEngParam.DrawingNo;

  if GetFullFilePathFromManualInfo(LDrawingPath, LManualPath) then
    LSensorCableRouteF.FrameDecTV1.SetFileName(FApplicationPath, LDrawingPath, LManualPath);

  LSensorCableRouteF.FrameDecTV1.SetAppPath(FApplicationPath);

//  LJson :=  GetJsonOfWirePathFromTagName(ATagName);
//  LSensorCableRouteF.FrameDecTV1.LoadFromJsonString(LJson);

  LSensorRouteDBName := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.SensorRouteFileName;

  if (LSensorRouteDBName = '\') or (LSensorRouteDBName = '') then
    LSensorRouteDBName := GetDbPathFromApplicationsFolder() + DefaultSensorRouteDBFileName
  else
    LSensorRouteDBName := GetDbPathFromApplicationsFolder() + LSensorRouteDBName;
  
  LEngParamFileName := FApplicationPath + FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ParamFileName;

  LEngParamFileIsDB := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.EngParamFileFormat = 2;//Sqlite format
  LSensorCableRouteF.FrameDecTV1.LoadFromFileDB(LSensorRouteDBName,
    AEngParam.ProjNo, AEngParam.EngNo, AEngParam.TagName, LEngParamFileName,
    True);//, LEngParamFileIsDB

  LSensorCableRouteF.Show;
end;

procedure TMainForm.CommTileListFrametileListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FSelectedTile := CommTileListFrame.TileList;
end;

procedure TMainForm.CommTileListFrametileListTileDblClick(Sender: TObject;
  ATile: TAdvSmoothTile; State: TTileState);
begin
  ShowWindowFromSelectedCommTile(SW_RESTORE);
end;

procedure TMainForm.CopyItem1Click(Sender: TObject);
begin
  if (EngModbusTV.Selected <> nil)
                          and Assigned(EngModbusTV.Selected.Data) then
    AddItem2ParamTV(EngModbusTV.Selected);
end;

procedure TMainForm.DeleteItem1Click(Sender: TObject);
begin
  if Dialogs.MessageDlg(EngModbusTV.Selected.Text + ' 를 지우시겠습니까? ' +#13#10,
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    EngModbusTV.Selected.DeleteChildren;
    EngModbusTV.Selected.Delete;
  end;
end;

procedure TMainForm.DisableAllEngCountBtn;
var
  i: integer;
  LEngBtn: TCyBitBtn;
begin
  for i := 1 to 4 do
  begin
    LEngBtn := FindComponent('EngBtn' + IntToStr(i)) as TCyBitBtn;

    if LEngBtn <> nil then
    begin
      SetEngCountBtnColor(LEngBtn, clGray);
//      LEngBtn.Degrade.FromColor := clGray;
//      LEngBtn.Degrade.ToColor := clGray;
    end;
  end;
end;

procedure TMainForm.DisplayMessage(AMessage: string;
  ASaveType: TMessageSaveType; AMessageType: TMessageType);
begin
  case ASaveType of
    mstNoSave:;
    mstFile: SaveMsg2File(AMessage, AMessageType);
    mstDB:;
  end;
end;

function TMainForm.ExecLaunchList(AProgName, AParam: string): THandle;
//  AHandles: TpjhArrayHandle);
var
  LProcessID: THandle;
begin
  LProcessId := ExecNewProcess2(AProgName, AParam);
  Result := DSiGetProcessWindow(LProcessId);
  CreateDummyMDIChild(LProcessId);
  SendUserLevelCopyData(Result,FCurrentUserLevel);

  //SetLength(FMonitorHandles, Length(AHandles)+1);
  //AHandles[High(FMonitorHandles)] := LHandle;
end;

procedure TMainForm.DoConfigChange;
var
  cnt : integer;
  icc : IConfigChanged;
begin
  if FKillProcessList.KillProcTimerHandle > -1 then
    FPJHTimerPool.Remove(FKillProcessList.KillProcTimerHandle);

  LoadKillProcess;

  for cnt := 0 to -1 + Screen.FormCount do
  begin
    if Supports(Screen.Forms[cnt], IConfigChanged, icc) then
      icc.ApplyConfigChange;
  end;
end;
function TMainForm.DoExternalUpdate(AFileName: string;  ACheckOnly: Boolean): Boolean;
var
  LHandle,LProcessID: THandle;
begin
  //Result: Update가 존재하여 실행했으면 True
  if not FileExists(AFileName) then
  begin
    exit;
  end;

  SetCurrentDir(ExtractFilePath(Application.ExeName));
  LProcessId := ExecNewProcess2(HiMECSAutoUpdateName, AFileName);
  LHandle := DSiGetProcessWindow(LProcessId);
end;

procedure TMainForm.DoTile(TileMode: TTileMode);
const
  TileParams: array[TTileMode] of Word = (MDITILE_HORIZONTAL, MDITILE_VERTICAL);
var
  LForm: TForm;
begin
  LForm := MainForm;
  if (LForm.FormStyle = fsMDIForm) and (LForm.ClientHandle <> 0) then
    SendMessage(LForm.ClientHandle, WM_MDITILE, TileParams[TileMode], 0);
end;

procedure TMainForm.ModbusDropTargetDragOver(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  TreeNode: TTreeNode;
begin
  TreeNode := EngModbusTV.GetNodeAt(APoint.X, APoint.Y);

  if (TreeNode <> nil) then
  begin
    // Select the item to provide visual feedback
    TreeNode.Selected := True;
    // Override the default drop effect if you need to:
    //Effect := DROPEFFECT_COPY;
  end else
    // Reject the drop
    Effect := DROPEFFECT_NONE;
end;

procedure TMainForm.ModbusDropTargetDrop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  DFP: RDragFormatParam;
  TreeNode, TreeNode2: TTreeNode;
  LStr, LStr2: string;
  Li: integer;
  LHiMECSConfig: THiMECSConfig;
begin
  TreeNode := EngModbusTV.GetNodeAt(APoint.X, APoint.Y);

  if (TreeNode <> nil) then
  begin
    // Determine if we got our custom format.
    if (FModbusDragFormatTarget.HasData) then
    begin
      LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
      // Extract the dropped data into our custom struct.
      FModbusDragFormatTarget.GetDataHere(DFP, sizeof(DFP));
      LStr2 := DFP.FCollectIndex;

      while True do
      begin
        LStr := strToken(LStr2,',');
        if LStr = '' then
          break;
        Li := StrToInt(LStr);
        TreeNode2 := EngModbusTV.Items.AddChild(TreeNode,
          LHiMECSConfig.ModbusList.EngineParameterCollect.Items[Li].Description);
                //FEngineParameter.EngineParameterCollect.Items[Li].Description);
      end;
      //ShowMessage(DFP.FCollectIndex);
      // Display the data.
    end
    else
      ShowMessage(TDropTextTarget(Sender).Text);
  end;
end;

procedure TMainForm.ExecApplication(Sender: TObject);
var
  i: integer;
  LStr: string;
  LHiMECSConfig: THiMECSConfig;
  LProcessId, LHandle: Integer;
begin
  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
  i := TMenuItem(Sender).Tag;
  LStr := FMenuBase.HiMECSMenuCollect.Items[i].DLLName;
  LStr := IncludeTrailingPathDelimiter(LHiMECSConfig.ExesPath) + LStr;
  LProcessId := ExecNewProcess2(LStr, ExtractFilePath(LStr));
  LHandle := DSiGetProcessWindow(LProcessId);

  if LHiMECSConfig.ExtAppInMDI then
  begin
    CreateDummyMDIChild(LProcessId);
    LStr := FMenuBase.HiMECSMenuCollect.Items[i].Caption;
    CreateExtMDIChild(LStr);
  end;
end;

procedure TMainForm.ExecBpl(Sender: TObject);
var
  i: integer;
  LStr: string;
  LHiMECSConfig: THiMECSConfig;
begin
  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
  i := TMenuItem(Sender).Tag;
  LStr := FMenuBase.HiMECSMenuCollect.Items[i].DLLName;

  if pos('BPL', Uppercase(ExtractFileExt(LStr))) <> 0 then
  begin
    LStr := IncludeTrailingPathDelimiter(LHiMECSConfig.BplsPath) + LStr;

    if FileExists(LStr) then
    begin
      //ExecNewProcess2(LStr, ExtractFilePath(LStr));
    end;
  end;

{  if FHiMECSConfig.ExtAppInMDI then
  begin
    LStr := FMenuBase.HiMECSMenuCollect.Items[i].Caption;
    CreateExtMDIChild(LStr);
  end;
  }
end;

procedure TMainForm.ExecuteAutoRunList(AAutoRunList: TAutoRunList; AIsAll,
  AIsAuto, AIsSelected: Boolean);
var
  i: integer;
  LHandle,LProcessID: THandle;
  LAutoRunItem: TAutoRunItem;
begin
  SetCurrentDir(FApplicationPath);

  for i := 0 to AAutoRunList.AutoRunCollect.Count - 1 do
  begin
    if not AIsAll then
    begin
      if AIsAuto then
      begin
        if not AAutoRunList.AutoRunCollect.Items[i].IsAutoRun then
          continue;
      end
      else
      begin
        if AIsSelected then
        begin
          LAutoRunItem := CommTileListFrame.tileList.SelectedTile.ItemOject as TAutoRunItem;
          LoadAutoRun(LAutoRunItem);
          exit;
        end
        else
        if AAutoRunList.AutoRunCollect.Items[i].IsAutoRun then
          continue;
      end;
    end;

//두개의 프로젝트 동시에 열때 실행옵션(External Execute)이 같은 경우 첫번째 runparameter만 실행 됨
//    LAutoRunItem := CommTileListFrame.tileList.Tiles.Items[i].ItemOject as TAutoRunItem;
    LAutoRunItem := AAutoRunList.AutoRunCollect.Items[i];
    LoadAutoRun(LAutoRunItem);
  end;
end;

procedure TMainForm.ExecuteMonitorList(AHiMECSMonitorList: THiMECSMonitorList;
  AIsAll, AIsAuto, AIsSelected: Boolean);
var
  i: integer;
  LHandle,LProcessID: THandle;
  LAutoRunItem: THiMECSMonitorListItem;
begin
  SetCurrentDir(FApplicationPath);

  for i := 0 to AHiMECSMonitorList.MonitorListCollect.Count - 1 do
  begin
    if not AIsAll then
    begin
      if AIsAuto then
      begin
        if not AHiMECSMonitorList.MonitorListCollect.Items[i].IsAutoLoad then
          continue;
      end
      else
      begin
        if AIsSelected then
        begin
          LAutoRunItem := MonTileListFrame.tileList.SelectedTile.ItemOject as THiMECSMonitorListItem;
          LoadMonitor(LAutoRunItem);
          exit;
        end
        else
        if AHiMECSMonitorList.MonitorListCollect.Items[i].IsAutoLoad then
          continue;
      end;
    end;

//두개의 프로젝트 동시에 열때 실행옵션(External Execute)이 같은 경우 첫번째 runparameter만 실행 됨
//    LAutoRunItem := MonTileListFrame.tileList.Tiles.Items[i].ItemOject as THiMECSMonitorListItem;
    LAutoRunItem := AHiMECSMonitorList.MonitorListCollect.Items[i];
    LoadMonitor(LAutoRunItem);
  end;
end;

procedure TMainForm.ExecuteSelectedTile(ATile: TAdvSmoothTileList);
begin
//  SetCurrentDir(FApplicationPath+'Applications');
  if ATile.Tag = 1 then
    ExecuteMonitorList(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSMonitor, False, False, True)
  else
  if ATile.Tag = 2 then
    ExecuteAutoRunList(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSAutoRun, False, False, True);
//  SetCurrentDir(FApplicationPath);
end;

procedure TMainForm.ExecuteSelectedTile1Click(Sender: TObject);
begin
  ExecuteSelectedTile(FSelectedTile);
end;

procedure TMainForm.ExpandAll1Click(Sender: TObject);
begin
  EngineInfoInspector.ExpandAll;
end;

procedure TMainForm.ExpandAll2Click(Sender: TObject);
begin
  EngModbusTV.FullExpand;

end;

procedure TMainForm.DestroyObjectFromList(AList: TStringList);
var
  i: integer;
begin
  for i := 0 to AList.Count - 1 do
    TObject(AList.Objects[i]).Free;

  AList.Free;
end;

procedure TMainForm.DestroyProc(AFreePrjFile: Boolean);
var
  i,j: integer;
  LModule: HModule;
  LHiMECSConfig: THiMECSConfig;
begin
  SelectEngineCombo.Lines.Clear;// := '';
  SelectEngineCombo.Value := '';

  CloseExtMDIChild;

  if Assigned(FKillProcessList) then
    FreeAndNil(FKillProcessList);

  if not Assigned(FPJHTimerPool) then //이거 주석처리 하면 처음 시작시 AV 발생함
    exit;

  if Assigned(FPJHTimerPool) then
  begin
    FPJHTimerPool.RemoveAll;
    FreeAndNil(FPJHTimerPool);
  end;

  for i := 0 to FHiMECSForms.PackageCollect.Count - 1 do
  begin
    if FHiMECSForms.PackageCollect.Items[i].FPackageHandle <> 0 then
    begin
      UnloadPackage(FHiMECSForms.PackageCollect.Items[i].FPackageHandle);
    end;
  end;

  for i := Low(FWatchHandles) to High(FWatchHandles) do
    SendMessage(FWatchHandles[i], WM_CLOSE, 0, 0);

  //for i := Low(FAutoRunHandles) to High(FAutoRunHandles) do
  //  SendMessage(FAutoRunHandles[i], WM_CLOSE, 0, 0);

  //for i := Low(FMonitorHandles) to High(FMonitorHandles) do
  //  SendMessage(FMonitorHandles[i], WM_CLOSE, 0, 0);

  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
  begin
    if Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor) then
    begin
      if FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.UseMonLauncher then
        PostMessage(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor.LauncherHandle,
          WM_CLOSE, 0, 0)
      else
        for j := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor.MonitorListCollect.Count - 1 do
          PostMessage(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor.MonitorListCollect.Items[j].AppHandle,
            WM_CLOSE, 0, 0);
    end;

    if Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSAutoRun) then
    begin
      if FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.UseCommLauncher then
        PostMessage(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSAutoRun.LauncherHandle,
          WM_CLOSE, 0, 0)
      else
        for j := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSAutoRun.AutoRunCollect.Count - 1 do
          SendMessage(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSAutoRun.AutoRunCollect.Items[j].AppHandle,
            WM_CLOSE, 0, 0);
    end;

    LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;

    if Assigned(LHiMECSConfig.EngineParameter) then
      LHiMECSConfig.EngineParameter.Free;

    if Assigned(LHiMECSConfig.ModbusList) then
      LHiMECSConfig.ModbusList.Free;

    if Assigned(LHiMECSConfig.ProjectInfo) then
      LHiMECSConfig.ProjectInfo.Free;

    if Assigned(LHiMECSConfig.EngineInfo) then
      LHiMECSConfig.EngineInfo.Free;

    if Assigned(LHiMECSConfig.ManualInfo) then
      LHiMECSConfig.ManualInfo.Free;

    LHiMECSConfig.Free;

    //Close 실패한 Process를 다시한번 강제 종료함
    if Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor) then
    begin
      Sleep(50);

      if Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor) then
      begin
        if not FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.UseMonLauncher then
          for j := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor.MonitorListCollect.Count - 1 do
            KillProcessId(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor.MonitorListCollect.Items[j].AppProcessId);
      end;

      FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor.Free;
    end;

    if Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSAutoRun) then
    begin
      Sleep(50);

      if not FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.UseCommLauncher then
        for j := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSAutoRun.AutoRunCollect.Count - 1 do
          KillProcessId(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSAutoRun.AutoRunCollect.Items[j].AppProcessId);

      FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSAutoRun.Free;
    end;
  end;

  FCurrentSelectedProjectFile.ProjectFileCollect.Clear;

  FWatchHandles := nil;
  //FAutoRunHandles := nil;
  //FMonitorHandles := nil;

  if Assigned(FHiMECSExes) then
    FreeAndNil(FHiMECSExes);

  if Assigned(FPackageList_Exes) then
  begin
    for i := 0 to FPackageList_Exes.Count - 1 do
    begin
      LModule := HModule(FPackageList_Exes.Objects[i]);
      UnloadPackage(LModule);
    end;

    FreeAndNil(FPackageList_Exes);
  end;

  if Assigned(FModbusDragFormatTarget) then
    FreeAndNil(FModbusDragFormatTarget);

  if Assigned(FParamDragFormatTarget) then
    FreeAndNil(FParamDragFormatTarget);

  if Assigned(FEngModbusSource) then
    FreeAndNil(FEngModbusSource);

  if Assigned(FEngParamSource) then
    FreeAndNil(FEngParamSource);

  if Assigned(FHiMECSForms) then
    FreeAndNil(FHiMECSForms);

  //if Assigned(FEngineInfoCollect) then
    //FreeAndNil(FEngineInfoCollect);

  //if Assigned(FEngineInfoList) then
  //begin
  //  for i := 0 to FEngineInfoList.Count - 1 do
  //  begin
  //    TICEngine(FEngineInfoList.Objects[i]).ICEngineCollect.Clear;
  //    TICEngine(FEngineInfoList.Objects[i]).Free;
  //  end;

  //  FreeAndNil(FEngineInfoList);
  //end;

//  if Assigned(FProjectInfoCollect) then
//    FreeAndNil(FProjectInfoCollect);

  //if Assigned(FEngineParameter) then
    //FreeAndNil(FEngineParameter);

  if Assigned(FSearchParamList) then
  begin
    for i := 0 to FSearchParamList.Count - 1 do
    begin
      TEngineParameter(FSearchParamList.Objects[i]).EngineParameterCollect.Clear;
      TEngineParameter(FSearchParamList.Objects[i]).Free;
    end;

    FreeAndNil(FSearchParamList);
  end;

  if AFreePrjFile then
    if Assigned(FProjectGroup) then
      FreeAndNil(FProjectGroup);

  //if Assigned(FHiMECSOptions) then
    //FreeAndNil(FHiMECSOptions);

  if Assigned(FHiMECSHTTPAPIServer) then
    FHiMECSHTTPAPIServer.Free;
end;

procedure TMainForm.FileInfo1Click(Sender: TObject);
begin
  ShowManualFileInfo();
end;

procedure TMainForm.ModbusFilterCheckcbCloseUp(Sender: TObject);
var
  LSensorTypes: TSensorTypes;
begin
  if SensorTypeSelectChanged4Modbus(LSensorTypes) then
    LoadSearchTreeFromEngParamSensorType(LSensorTypes, FCurrentEngParamSortMethod, EngModbusTV, eplikModbus);
end;

procedure TMainForm.ModbusFilterClearBtnClick(Sender: TObject);
begin
  ModbusFilterCheckcb.SetAll(False);
  ModbusFilterCheckcbCloseUp(nil);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DestroyProc();
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  LAutoStart: Boolean;
begin
//{$IFDEF USE_REGCODE} //이 코드는 UnitFrameIPCMonitorAll.pas로 이동함
//  if not TRegistrationF.IsRegistrationValid(FRegInfo) then
//  begin
//    ShowMessage('Product is not registered!');
//    TerminateProcess(GetCurrentProcess, 0);
////    Halt(0);
//  end;
//{$ENDIF}

{  FIPCServer := TIPCServer.Create;
  FIPCServer.OnExecuteRequest := OnExecuteRequest;
  FIPCServer.ServerName := HIMECS_CROMIS_SERVER_NAME;
  FIPCServer.Start;
}
  LAutoStart := ParamCount > 1;

  FPM := TParameterManager.Create;

  FJHP_gpShM := TJHP_gpShM.Create(HiMECS_gpSMName4CommServer);
  //SharedMemory를 공유할 Producer와 Listener의 EventName은 동일해야 함
  FJHP_gpShM.InitgpSMEvent(HiMECS_gpNameSpace4CommServer,
    HiMECS_gpEventName4HiMECS,[gkProducer]);
  FJHP_gpShM.InitgpSMEvent(HiMECS_gpNameSpace4CommServer,
    HiMECS_gpEventName4HiMECSCommServer,[gpListener], GpSMEventReceivedNotify);

  FApplicationPath := ExtractFilePath(Application.ExeName); //맨끝에 '\' 포함됨
  SetCurrentDir(FApplicationPath);

  InitEnum();
  InitHTTPRestServer();
//  InitHttpApiServer();

  Init(LAutoStart,True);

  EngineInfoInspector.DoubleBuffered := False;
  ProjectInfoInspector.DoubleBuffered := False;
  FParamCopyMode := 0;
  FCurrentManualSearchSrc := mssSystem;

  FEgg := TEasternEgg.Create('Show Reg Info', [ssCtrl],'REG',Self, OnEggShowRegInfo);
  FEgg.AddEgg2ObjDic('Delete Reg Info', [ssCtrl],'DREG', OnEggDelRegInfo);
//  FEgg.FOnEggShowRegInfo := OnEggShowRegInfo;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
//{$IFDEF USE_REGCODE} //이 코드는 UnitFrameIPCMonitorAll.pas로 이동함
//  FRegInfo.Free;
//{$ENDIF}
  FPM.Free;
  FJHP_gpShM.Free;

  //FIPCServer.Stop;
  //FreeAndNil(FIPCServer);
end;

procedure TMainForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  LDragRect: TRect;
  LPosition: TPoint;
begin
{  if FParameterDragMode then
  begin
    LPosition.x := x;
    LPosition.Y := y;

    GetWindowRect(EngModbusTV.Handle, LDragRect);
    // Is position outside screen coordinates...
    if (not PtInRect(LDragRect, LPosition)) then
    begin
      Windows.GetClientRect(EngModbusTV.Handle, LDragRect);
      // ... and inside client coordinates
      if not(PtInRect(LDragRect, LPosition)) then
      begin
        //if (not Windows.ClientToScreen(Handle, LPosition)) then
        //begin
            // Transfer the structure to the drop source data object and execute the drag.
            FEngParamSource.SetDataHere(FEP_DragDrop, sizeof(FEP_DragDrop));

            EngParamSource.Execute;
            FParameterDragMode := False;
        //end;
      end
      else
        FParameterDragMode := False;
    end
    else
      FParameterDragMode := False;
  end;
}
end;

//현재 선택된 ParameterItem의 Parameter Index 반환
//없으면 -1 반환 함
function TMainForm.GetCurrentOptionIndex(
  ANode:TTreeNode): integer;
begin
  if (ANode.Level = 0) and (ANode.Count = 0) then
  begin
    Result := -1;
    exit;
  end;

  while ANode.Level > 0 do
    ANode := ANode.Parent;

  Result := ANode.Index;
end;

function TMainForm.GetDbPathFromApplicationsFolder: string;
begin
//  Result := FApplicationPath + 'Applications\db\'
  Result := FApplicationPath + 'db\'
end;

function TMainForm.GetDeviceList2Json4Mobile(ARec: TRestAPIResponseDoc): RawUTF8;
var
  LDynArr: TDynArray;
  LDynArrResponse: TRestAPIResponseDoc;
  LUtf8: RawUTF8;
  LRec: TRestAPIResponseDoc;
  i: integer;
begin
  LDynArr.Init(TypeInfo(TRestAPIResponse2DynArr), LDynArrResponse);

  LRec.MethodName := 'DeviceList';

  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
  begin
    if Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.ProjectInfo) then
    begin
      if ARec.ProjName = FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.ProjectInfo.ShipNo then
      begin
        LRec.ProjName := ARec.ProjName;
        LRec.Response := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName;
//        LVar.ProjectItemDescript := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemDescript;

        if LDynArr.IndexOf(LRec) < 0 then
        begin
          LRec.Id := i + 1;
          LDynArr.Add(LRec);
        end;
      end;
    end;
  end;

  Result := LDynArr.SaveToJson();
  //Client에서 escaped char가 자동으로 추가 되기 때문에 Base64로 Encoding하여 전송함
  Result := MakeRawUTF8ToBin64(Result, False);

//var
//  i: integer;
//  LVar: variant;
//  LUtf8: RawUTF8;
//  LDynUtf8: TRawUTF8DynArray;
//  LDynArr: TDynArray;
//begin
//  TDocVariant.New(LVar);
//  LDynArr.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8);
//
//  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
//  begin
//    if Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.ProjectInfo) then
//    begin
//      if AProjName = FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.ProjectInfo.ShipNo then
//      begin
//        LVar.ProjectItemName := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName;
//        LVar.ProjectItemDescript := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemDescript;
//        LUtf8 := LVar;
//
//        LDynArr.Add(LUtf8);
//      end;
//    end;
//  end;
//
//  Result := LDynArr.SaveToJSON;
//  //Client에서 escaped char가 자동으로 추가 되기 때문에 Base64로 Encoding하여 전송함
//  Result := MakeRawUTF8ToBin64(Result, False);
end;

function TMainForm.GetDocContentOfDrawing2Json(ARec: TRestAPIResponseDoc): RawUTF8;
var
  i,j: integer;
  LVar: variant;
  LUtf8: RawUTF8;
  LDynUtf8: TRawUTF8DynArray;
  LDynArr: TDynArray;
  LHiMECSManualInfo: THiMECSManualInfo;
begin
  TDocVariant.New(LVar);
  LDynArr.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8);

  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
  begin
    if ARec.DeviceName = FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName then
    begin
      LHiMECSManualInfo := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.ManualInfo;

      for j := 0 to LHiMECSManualInfo.Drawings.Count - 1 do
      begin
        LVar.Contents := LHiMECSManualInfo.Drawings.Items[j].SystemDesc_Eng;
        LUtf8 := LVar;
        LDynArr.Add(LUtf8);
      end;

      Break;
    end;
  end;

  Result := LDynArr.SaveToJSON;
end;

function TMainForm.GetDocContentOfManual2Json(ARec: TRestAPIResponseDoc): RawUTF8;
var
  i,j: integer;
//  LVar: variant;
  LUtf8: RawUTF8;
//  LDynUtf8: TRawUTF8DynArray;
//  LDynArr: TDynArray;
  LHiMECSManualInfo: THiMECSManualInfo;
  LManualSearchSrc: TManualSearchSrc;
  LManualSortMethod: TManualSortMethod;
begin
  LUtf8 := '';

  if ARec.ContentType = '' then
    ARec.ContentType := 'System';

  LManualSearchSrc := g_ManualSearchSrc.ToType(ARec.ContentType); //System or Part
  LUtf8 := GetSearchTree2JsonFromManualInfo(ARec.DeviceName, msmMSNo, ARec.SearchText, LManualSearchSrc);
//  LUtf8 := GetSearchTree2JsonFromManualInfo(ADeviceName, msmMSNo, ASearchText, mssSystem);

  Result := LUtf8;
//
//  TDocVariant.New(LVar);
//  LDynArr.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8);
//
//  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
//  begin
//    if ADeviceName = FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName then
//    begin
//      LHiMECSManualInfo := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.ManualInfo;
//
//      for j := 0 to LHiMECSManualInfo.OpManual.Count - 1 do
//      begin
//        LVar.Contents := LHiMECSManualInfo.OpManual.Items[j].SystemDesc_Eng;
//        LUtf8 := LVar;
//        LDynArr.Add(LUtf8);
//      end;
//
//      Break;
//    end;
//  end;
//
//  Result := LDynArr.SaveToJSON;
end;

function TMainForm.GetDocContentOfParameter2Json(ARec: TRestAPIResponseDoc): RawUTF8;
var
  LVar: variant;
  LUtf8: RawUTF8;
  LSensorType: TSensorType;
begin
  LUtf8 := '';
  LSensorType := g_SensorType.ToType(ARec.ContentType);

  //FSearchParamList에 HiMECSConfig.EngineParameter를 복사함
  InitSearchParamList(ARec.DeviceName);
  LUtf8 := GetSearchTree2JsonFromSearchParamList([LSensorType], ARec.SearchText, 0);

  Result := LUtf8;
end;

//AJsonMenuName : {"DeviceName": "Eng#1", "MenuName":"Manual", "SensorType":"Parameter", "SearchText":""}
function TMainForm.GetDocContents2Json4Mobile(ARec: TRestAPIResponseDoc): RawUTF8;
var
//  LDynArr: TDynArray;
//  LDynArrResponse: TRestAPIResponseDoc;
  LUtf8: RawUTF8;
  LRec: TRestAPIResponseDoc;
begin
//  LDynArr.Init(TypeInfo(TRestAPIResponse2DynArr), LDynArrResponse);

  ARec.MethodName := 'DocContent';

  if ARec.DocName = 'Manual' then
  begin
//    LType := LVar.ContentType;//System, Part, SectionNo(검색할 문서명)
    LUtf8 := GetDocContentOfManual2Json(ARec);
  end
  else if ARec.DocName = 'Drawing' then
  begin
    LUtf8 := GetDocContentOfDrawing2Json(ARec);
  end
  else if ARec.DocName = 'Parameter' then
  begin
//    LType := LVar.SensorType;//Engine Parameter 검색 창에서의 Filter 명과 동일
    LUtf8 := GetDocContentOfParameter2Json(ARec);
  end;

//  Result := StringReplaceAll(Result,'''', '\''');
//  Result := StringReplaceAll(Result,'&', '\&');
  LUtf8 := StringReplaceAll(LUtf8,'’', '');
  LUtf8 := StringReplaceAll(LUtf8,'''', '');
  LUtf8 := StringReplaceAll(LUtf8,'&', 'and');
  FileFromString(LUtf8, 'e:\temp\aaa.txt');
//  Result := LDynArr.SaveToJson();
  //Client에서 escaped char가 자동으로 추가 되기 때문에 Base64로 Encoding하여 전송함
  Result := MakeRawUTF8ToBin64(LUtf8, False);
//  LUtf8 := MakeBase64ToUTF8(Result, False);
//  FileFromString(LUtf8, 'c:\temp\aaa2.txt');
//var
////  LDocData: TDocVariantData;
//  LMenuName,
//  LDeviceName,
//  LType,
//  LSearchText: RawUTF8;
//  LVar: variant;
//begin
////  LDocData.InitJSON(AJsonMenuName);
//  LVar := _JSON(AJsonMenuName);
//  LDeviceName := LVar.DeviceName;
//  LMenuName := LVar.MenuName;
//  LSearchText := LVar.SearchText;
//
//  if LMenuName = 'Manual' then
//  begin
//    LType := LVar.ContentType;//System, Part, SectionNo(검색할 문서명)
//    Result := GetDocContentOfManual2Json(LDeviceName, LType, LSearchText);
//  end
//  else if LMenuName = 'Drawing' then
//  begin
//    Result := GetDocContentOfDrawing2Json(LDeviceName, LType, LSearchText);
//  end
//  else if LMenuName = 'Parameter' then
//  begin
//    LType := LVar.SensorType;//Engine Parameter 검색 창에서의 Filter 명과 동일
//    Result := GetDocContentOfParameter2Json(LDeviceName, LType, LSearchText);
//  end
end;

function TMainForm.GetEngineType(AIndex: integer): string;
var
  LHiMECSConfig: THiMECSConfig;
begin
  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig;
  Result := LHiMECSConfig.EngineInfo.GetEngineType;
end;

function TMainForm.GetEngParamFromHiMECSConfigByEPKind(
  AEPKind: TEngParamListItemKind; AIndex: integer): TEngineParameter;
begin
  Result := nil;

  if AEPKind = eplikModbus then
    Result := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig.ModbusList
  else
    Result := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig.EngineParameter;
end;

function TMainForm.GetEngParamFromItem(
  AEPItem: TEngineParameterItem; AIndex: integer): TEngineParameter;
begin
  Result := nil;

  if AIndex = -1 then
    AIndex := FCOI;

  if AEPItem.ParamNo = '' then
    Result := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig.ModbusList
  else
    Result := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig.EngineParameter;
end;

function TMainForm.GetFullFilePathFromManualInfo(var ADrawingPath, AManualPath: string): Boolean;
var
  LHiMECSManualInfo: THiMECSManualInfo;
  i: integer;
begin
  Result := False;
  LHiMECSManualInfo := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ManualInfo;

  for i := 0 to LHiMECSManualInfo.OpManual.Count - 1 do
  begin
    if LHiMECSManualInfo.OpManual.Items[i].FileName = AManualPath then
    begin
      AManualPath := LHiMECSManualInfo.OpManual.Items[i].FilePath + AManualPath;
      Break;
    end;
  end;

  for i := 0 to LHiMECSManualInfo.Drawings.Count - 1 do
  begin
    if LHiMECSManualInfo.Drawings.Items[i].FileName = ADrawingPath then
    begin
      ADrawingPath := LHiMECSManualInfo.Drawings.Items[i].FilePath + ADrawingPath;
      Break;
    end;
  end;

  Result := (ExtractFilePath(AManualPath) + ExtractFilePath(ADrawingPath)) <> '';
end;

function TMainForm.GetSearchListFromDeviceName(
  const ADeviceName, AInfoName: string): TStringList;
var
  i: integer;
  LHiMECSConfig: THiMECSConfig;
  LEngineParameter: TEngineParameter;
  LHiMECSManualInfo: THiMECSManualInfo;

  procedure AddObject2List;
  begin
    if AInfoName = 'Engine Param' then
    begin
      LEngineParameter := TEngineParameter.Create(Self);
      LEngineParameter.Assign(LHiMECSConfig.EngineParameter);
      Result.AddObject(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName, LEngineParameter);
    end
    else
    if AInfoName = 'Manual Info' then
    begin
      LHiMECSManualInfo := THiMECSManualInfo.Create(Self);
      LHiMECSManualInfo.Assign(LHiMECSConfig.ManualInfo);
      Result.AddObject(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName, LHiMECSManualInfo);
    end;
  end;
begin
  Result := TStringList.Create;

  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
  begin
    if ADeviceName <> '' then
    begin
      if FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName = ADeviceName then
      begin
        LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;
        AddObject2List;
      end;
    end
    else
    begin
      LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;
      AddObject2List;
    end;
  end;
end;

function TMainForm.GetNodeStrFromTreeView(ATV: TJvCheckTreeView; ACommandRec: TCommandRec;
  out AJson: string): integer;
var
  LTV: TJvCheckTreeView;
  LSensorTypes: TSensorTypes;
begin
  LTV := TJvCheckTreeView.Create(nil);
  LTV.Parent := TWinControl(Self);
  try
//    CopySubtree(ATV.Items.GetFirstNode, JvTreeView1, JvTreeView1.Items.GetFirstNode);
    CopySubtree(ATV.Items.GetFirstNode, LTV, LTV.Items.GetFirstNode);
//    LTV.Items.Assign(ATV.Items);
//    LTV.Assign(ATV);

    if ACommandRec.Cmd = HiMECS_Cmd_GetManList then
    begin
      if ACommandRec.ParamStr <> '' then
        LoadSearchTreeFromManualInfo2(ACommandRec.ParamStr, [mikOpManual],
          TManualSortMethod(ACommandRec.ParamInt),
          TManualSearchSrc(ACommandRec.ParamInt2),
          LTV); //msmMSNo
    end
    else
    if ACommandRec.Cmd = HiMECS_Cmd_GetSensorListWithFilter then
    begin
      if ACommandRec.ParamStr <> '' then
      begin
        LSensorTypes := GetSensorTypesFromParamSearchCheck(FFilterText4Modbus);
        LoadSearchTreeFromEngParam2(LSensorTypes, ACommandRec.ParamStr, TParamSortMethod(ACommandRec.ParamInt), LTV, eplikModbus); //
      end;
    end
    else
    if ACommandRec.Cmd = HiMECS_Cmd_GetParamListWithFilter then
    begin
      if ACommandRec.ParamStr <> '' then
      begin
        LSensorTypes := GetSensorTypesFromParamSearchCheck(FFilterText4Parameter);
        LoadSearchTreeFromEngParam2(LSensorTypes, ACommandRec.ParamStr, TParamSortMethod(ACommandRec.ParamInt), LTV, eplikParameter); //
      end;
    end;

    AJson := GetStringFromTreeView(LTV);
  finally
    LTV.Free;
  end;

end;

function TMainForm.GetProjectList2Json4Mobile: RawUTF8;
var
  LDynArr: TDynArray;
  LDynArrResponse: TRestAPIResponseDynArr;
  LUtf8: RawUTF8;
  LRec: TRestAPIResponse;
  i: integer;
begin
  LDynArr.Init(TypeInfo(TRestAPIResponseDynArr), LDynArrResponse);

  LRec.MethodName := 'ProjectList';

  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
  begin
    LRec.Response := StringToUTF8(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.ProjectInfo.ShipNo);

    if LDynArr.IndexOf(LRec) < 0 then
    begin
      LRec.Id := i + 1;
      LDynArr.Add(LRec);
    end;
  end;

  Result := LDynArr.SaveToJson();
  //Client에서 escaped char가 자동으로 추가 되기 때문에 Base64로 Encoding하여 전송함
  Result := MakeRawUTF8ToBin64(Result, False);
end;

function TMainForm.GetJsonOfWirePathFromTagName(ATagName: string): string;
begin
  Result := '';
end;

function TMainForm.GetManualSearchSrcFromForm: TManualSearchSrc;
begin
  Result := FCurrentManualSearchSrc;
end;

function TMainForm.GetDocList2Json4Mobile(ARec: TRestAPIResponseDoc): RawUTF8;
var
  LDynArr: TDynArray;
  LDynArrResponse: TRestAPIResponseDoc;
  LUtf8: RawUTF8;
  LRec: TRestAPIResponseDoc;
begin
  LDynArr.Init(TypeInfo(TRestAPIResponse2DynArr), LDynArrResponse);

  LRec.MethodName := 'DocList';
  LRec.ProjName := ARec.ProjName;
  LRec.DeviceName := ARec.DeviceName;

  LRec.Id := 1;
  LRec.Response := 'Manual';
  LDynArr.Add(LRec);

  LRec.Id := 2;
  LRec.Response := 'Drawing';
  LDynArr.Add(LRec);

  LRec.Id := 3;
  LRec.Response := 'Parameter';
  LDynArr.Add(LRec);

  Result := LDynArr.SaveToJson();
  //Client에서 escaped char가 자동으로 추가 되기 때문에 Base64로 Encoding하여 전송함
  Result := MakeRawUTF8ToBin64(Result, False);

//var
//  LDoc: TDocVariantData;
//begin
//  LDoc.Init;
//
//  LDoc.AddValue('DeviceName',ADeviceName);
//  LDoc.AddValue('1','Manual');
//  LDoc.AddValue('2','Drawing');
//  LDoc.AddValue('3','Parameter');
//
//  Result := LDoc.ToJson;
end;

function TMainForm.GetDocPdf2Json4Mobile(ARec: TRestAPIResponseDoc): RawUTF8;
var
  LDynArr: TDynArray;
  LDynArrResponse: TRestAPIResponseDoc;
  LUtf8: RawUTF8;
  LRec: TRestAPIResponseDoc;
begin
  LUtf8 := RelToAbs(ARec.DocName, ExtractFilePath(Application.ExeName));

  if FileExists(LUtf8) then
  begin
    LDynArr.Init(TypeInfo(TRestAPIResponse2DynArr), LDynArrResponse);
    LRec.MethodName := 'GetDocPdf';
//    LRec.ProjName := ARec.ProjName;
    LRec.Response := FileToBase64(LUtf8);
    LRec.Id := 1;
    LDynArr.Add(LRec);

    Result := LDynArr.SaveToJson();
    Result := MakeRawUTF8ToBin64(Result, False);

//    Result := StringFromFile(ARec.DocName);
//    Result := FileToBase64(ARec.DocName);
  end;
end;

function TMainForm.GetMultiStateMeaning(
  AEngParamItem: TEngineParameterItem): string;
var
  LIdx, LCount: integer;
begin
  Result := '';

  if not Assigned(AEngParamItem) then
    exit;

  if AEngParamItem.MultiStateItemIndex = -1 then
    exit;

  if AEngParamItem.MultiStateItemCount <> 0 then //-1
  begin
    LIdx := AEngParamItem.MultiStateItemIndex;
    LCount := 0;

    while LCount <= AEngParamItem.MultiStateItemCount do
    begin
      if IntToStr(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ModbusList.MultiStateCollect.Items[LIdx].StateValue) = AEngParamItem.Value then
      begin
        Result := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ModbusList.MultiStateCollect.Items[LIdx].StateMeaning;
        break;
      end
      else
        inc(LIdx);
        inc(LCount);
    end;
  end;
end;

function TMainForm.GetSearchTree2JsonFromManualInfo(
  ADeviceName: string; ASortMethod: TManualSortMethod; ASearchText: string;
  ASearchSrc: TManualSearchSrc): RawUTF8;
var
  LHiMECSManualInfo: THiMECSManualInfo;
  ALevel, i, j, LParentRem, Idx: Integer;
  CurrStr, LStr, LStr2: string;
  Keep, KeepParent, KeepAncestors: Boolean;
  LevelRem: Integer;
  LSearchManualList: TStringList;
  LRec: TRestAPIResponseDocContent;
  LUtf8: RawUTF8;
  LDynUtf8: TTRestAPIResponseDocContent2DynArr;//TRawUTF8DynArray;
  LDynArr: TDynArray;
begin
  Result := '';
  LDynArr.Init(TypeInfo(TTRestAPIResponseDocContent2DynArr), LDynUtf8);

  ASearchText:= Lowercase(ASearchText); // insures a case insensitive search

  try
    try
      LSearchManualList := GetSearchListFromDeviceName(ADeviceName, 'Manual Info');

      Idx := 0;
      // Search algorithm
      LevelRem:= 0;
      KeepParent:= false;

      for i := 0 to LSearchManualList.Count - 1 do
      begin
        LHiMECSManualInfo := THiMECSManualInfo(LSearchManualList.Objects[i]);

        SetHideItemsOfManualInfoBySearchTxt(LHiMECSManualInfo, mikOpManual, ASearchSrc, ASearchText);
        SetHideItemsOfManualInfoBySearchTxt(LHiMECSManualInfo, mikDrawings, ASearchSrc, ASearchText);

        for j := LHiMECSManualInfo.OpManual.Count - 1 downto 0 do
        begin
          if not LHiMECSManualInfo.OpManual.Items[j].FIsHideItem then
          begin
            LRec.Desc := LHiMECSManualInfo.OpManual.Items[j].SystemDesc_Eng;
            LRec.Msg := LHiMECSManualInfo.OpManual.Items[j].PartDesc_Eng;
    //                LRec.SectionNo := LHiMECSManualInfo.OpManual.Items[j].SectionNo;
            LRec.DocName :=  LHiMECSManualInfo.OpManual.Items[j].RelFilePath+
              LHiMECSManualInfo.OpManual.Items[j].FileName;

            LDynArr.Add(LRec);
          end;
        end;

        for j := LHiMECSManualInfo.Drawings.Count - 1 downto 0 do
        begin
          if not LHiMECSManualInfo.Drawings.Items[j].FIsHideItem then
          begin
            LRec.Desc := LHiMECSManualInfo.Drawings.Items[j].SystemDesc_Eng;
            LRec.Msg := LHiMECSManualInfo.Drawings.Items[j].PartDesc_Eng;
    //                LRec.SectionNo := LHiMECSManualInfo.Drawings.Items[j].SectionNo;
            LRec.DocName :=  LHiMECSManualInfo.Drawings.Items[j].RelFilePath+
              LHiMECSManualInfo.Drawings.Items[j].FileName;

            LDynArr.Add(LRec);
          end;
        end;

//        for j := LHiMECSManualInfo.OpManual.Count - 1 downto 0 do // List is scanned from bottom to top
//        begin
//          case ASearchSrc of
//            mssSystem: LStr := LHiMECSManualInfo.OpManual.Items[j].SystemDesc_Eng;
//            mssPart: begin
//              LStr := LHiMECSManualInfo.OpManual.Items[j].PartDesc_Eng;
//              LStr2 := LHiMECSManualInfo.OpManual.Items[j].SystemDesc_Eng;
//            end;
//            mssSection: LStr := LHiMECSManualInfo.OpManual.Items[j].SectionNo;
//          else
//            begin
//              LStr := LHiMECSManualInfo.OpManual.Items[j].PartDesc_Eng + ';' +
//                LHiMECSManualInfo.OpManual.Items[j].SystemDesc_Eng + ';' +
//                LHiMECSManualInfo.OpManual.Items[j].SectionNo;
//            end;
//          end;//case
//
//          if Length(ASearchText) = 0 then
//          begin
//            Keep := True;
//          end
//          else
//          begin
//            if LStr = '' then
//            begin
//              CurrStr:= '';
//            end
//            else
//            begin
//              CurrStr := GetBufStart(LStr, ALevel);
//              CurrStr:= Lowercase(CurrStr); // insures a case insensitive search
//            end;
//
//            if ALevel >= LevelRem then // node is a leaf
//            begin
//              Keep:= pos(ASearchText, CurrStr) > 0; // Search string found if true
//
//              if Keep then
//              begin
//                KeepParent:= true; // parent branch must be kept
//                KeepAncestors:= true;
//                LParentRem:= ALevel - 1;
//              end
//              else
//                LHiMECSManualInfo.OpManual.Delete(j);
//            end; // if ALevel = LevelRem
//
//            if ALevel = LevelRem - 1 then // node is a branch
//            begin
//              KeepParent:= false;
//              if KeepAncestors and (ALevel = LParentRem) then
//              begin
//                KeepParent:= true;
//                LParentRem:= LParentRem - 1;
//              end;
//
//              if not KeepParent then
//                LHiMECSManualInfo.OpManual.Delete(j)
//              else if ALevel = 0 then
//                KeepAncestors:= False;
//            end;
//
//            LevelRem:= ALevel;
//          end;//else
//
//          if Keep then
//          begin
//            Inc(Idx);
//            LRec.Id := Idx;
//
//            case ASearchSrc of
//              mssSystem,
//              mssSection,
//              mssPart: begin
//                LRec.Desc := LHiMECSManualInfo.OpManual.Items[j].SystemDesc_Eng;
//                LRec.Msg := LHiMECSManualInfo.OpManual.Items[j].PartDesc_Eng;
////                LRec.SectionNo := LHiMECSManualInfo.OpManual.Items[j].SectionNo;
//              end;
//            else
//              begin
//              end;
//            end;//case
//
//            LRec.DocName :=  LHiMECSManualInfo.OpManual.Items[j].RelFilePath+
//              LHiMECSManualInfo.OpManual.Items[j].FileName;
//
//            LDynArr.Add(LRec);
//          end;//keep
//        end;//for j
      end;//for i

      Result := LDynArr.SaveToJSON;
    finally
      DestroyObjectFromList(LSearchManualList);
    end;
  except
    Invalidate;  // force repaint on exception
    raise;
  end;
end;

function TMainForm.GetSearchTree2JsonFromSearchParamList(ASearchTypes: TSensorTypes;
  ASearchText: string; ASearchFieldName: integer): RawUTF8;
var
  LEngineParameter: TEngineParameter;
  ALevel, i, j, LParentRem: Integer;
  CurrStr, LStr: string;
  Keep, KeepParent, KeepAncestors: Boolean;
  LevelRem: Integer;
  LParamSearchMode: Boolean;
  LVar: variant;
  LUtf8: RawUTF8;
  LDynUtf8: TRawUTF8DynArray;
  LDynArr: TDynArray;
begin
  Result := '';
  TDocVariant.New(LVar);
  LDynArr.Init(TypeInfo(TRawUTF8DynArray), LDynUtf8);

  ASearchText:= Lowercase(ASearchText); // insures a case insensitive search
  LParamSearchMode:= (ASearchTypes <> []) or (Length(ASearchText) <> 0); // true searcxh box not empty

  if LParamSearchMode then
  begin
    try
      // Search algorithm
      LevelRem:= 0;
      KeepParent:= false;

      for i := 0 to FSearchParamList.Count - 1 do
      begin
        LEngineParameter := TEngineParameter(FSearchParamList.Objects[i]);

        for j := LEngineParameter.EngineParameterCollect.Count - 1 downto 0 do // List is scanned from bottom to top
        begin
          if ASearchTypes <> [] then
          begin
            if not IsIncludeSensorTypesFromEngParamItem(LEngineParameter.EngineParameterCollect.Items[j], ASearchTypes) then
            begin
              LEngineParameter.EngineParameterCollect.Delete(j);
              Continue;
            end;
          end;

          if Length(ASearchText) = 0 then
          begin
            Keep := True;
          end
          else
          begin
            case ASearchFieldName of
              0: LStr := LEngineParameter.EngineParameterCollect.Items[j].Description;
              1: LStr := LEngineParameter.EngineParameterCollect.Items[j].TagName;
            end;

            CurrStr := GetBufStart(LStr, ALevel);
            CurrStr:= Lowercase(CurrStr); // insures a case insensitive search

            if ALevel >= LevelRem then // node is a leaf
            begin
              Keep:= pos(ASearchText, CurrStr) > 0; // Search string found if true

              if Keep then
              begin
                KeepParent:= true; // parent branch must be kept
                KeepAncestors:= true;
                LParentRem:= ALevel - 1;
              end
              else
                LEngineParameter.EngineParameterCollect.Delete(j);
            end; // if ALevel = LevelRem

            if ALevel = LevelRem - 1 then // node is a branch
            begin
              KeepParent:= false;

              if KeepAncestors and (ALevel = LParentRem) then
              begin
                KeepParent:= true;
                LParentRem:= LParentRem - 1;
              end;

              if not KeepParent then
                LEngineParameter.EngineParameterCollect.Delete(j)
              else if ALevel = 0 then
                KeepAncestors:= False;
            end;

            LevelRem:= ALevel;
          end;//else

          if Keep then
          begin
            LVar.TagName := LEngineParameter.EngineParameterCollect.Items[j].TagName;
            LVar.Desc := LEngineParameter.EngineParameterCollect.Items[j].Description;
            LUtf8 := LVar;
            LDynArr.Add(LUtf8);
          end;
        end;//for j

        Result := LDynArr.SaveToJSON;
      end;//for i

    finally

    end;
  end;//if
end;

function TMainForm.GetSensorIconImgIndex(ASensorType: TSensorType): integer;
begin
  case ASensorType of
    stDI: Result := 0;
    stDO: Result := 0;
    stmA: Result := cmA;
    stRTD: Result := cRTD;
    stTC: Result := cThermoCouple;
    stPickup: Result := cPickUp;
    else
      Result := -1;
  end;
end;

function TMainForm.GetSensorTypesFromParamSearchCheck(AFilter: string): TSensorTypes;
var
  LEngParamFilterKinds: TEngParamFilterKinds;
begin
  Result := [];

  LEngParamFilterKinds := SetStr2EngParamFilterKinds(AFilter);

  if epfkSensor in LEngParamFilterKinds then
    Result := [stmA, stRTD, stTC, stPickup, stDI, stDO];

//  if epfkParam in LEngParamFilterKinds then
//    Result := Result + [stParam];

  if epfkModbus in LEngParamFilterKinds then
    Result := Result + [stmA, stRTD, stTC, stPickup, stDI, stDO, stConfig, stCalculated, stVoltage, stCommand, stSolValve, stControlValve, stPump, stFan, stRelay, stAlarm, stActuator, stVoltage];

  if epfkAlarm in LEngParamFilterKinds then
    Result := Result + [stAlarm];

  if efkActuator in LEngParamFilterKinds then
    Result := Result + [stActuator];
end;

procedure TMainForm.GpSMEventReceivedNotify(Sender: TObject;
  producerHandle: TGpSEHandle; const producerName, eventName,
  eventData: string);
begin
  //HiMECS Process에서 Braodcast할 때에도 이 함수가 Trigger 됨
  //다른 Process에서 FJHP_gpShM을 생성 후 event를 Broadcast했을 경우에만 if문 톻과함
  if producerHandle <> FJHP_gpShM.FgpEP.ProducerHandle then
  begin
    if (eventName = HiMECS_gpEventName4HiMECSCommServer) then
      ProcessCmdFromCommServer(eventData);
//    else if (eventName = gp_EventName4SimCommandJson) then
//      UpdateComponentValueFromCommandJson;
  end;
end;

procedure TMainForm.HideAllEngineCountBtn;
var
  i: integer;
  LEngBtn: TCyBitBtn;
begin
  for i := 4 downto 1 do
  begin
    LEngBtn := FindComponent('EngBtn' + IntToStr(i)) as TCyBitBtn;

    if LEngBtn <> nil then
      LEngBtn.Visible := False;
  end;
end;

procedure TMainForm.HideAllMonitor1Click(Sender: TObject);
var
  i: integer;
  LAdvNavBarPanel: TAdvNavBarPanel;
  LMonItem: THiMECSMonitorListItem;
  LAutoRunItem: TAutoRunItem;
begin
  LAdvNavBarPanel := AdvNavBar1.Panels[AdvNavBar1.ActiveTabIndex];
  if LAdvNavBarPanel.Name = 'MonitoringPanel' then
  begin
    for i := 0 to MonTileListFrame.tileList.Tiles.Count - 1 do
    begin
      LMonItem := MonTileListFrame.tileList.Tiles[i].ItemOject as THiMECSMonitorListItem;
      ShowWindowFromSelectedMonTile(SW_MINIMIZE ,LMonItem);
    end;
  end
  else
  if LAdvNavBarPanel.Name = 'CommunicationPanel' then
  begin
    for i := 0 to CommTileListFrame.tileList.Tiles.Count - 1 do
    begin
      LAutoRunItem := CommTileListFrame.tileList.Tiles[i].ItemOject as TAutoRunItem;
      ShowWindowFromSelectedCommTile(SW_MINIMIZE, LAutoRunItem);
    end;
  end;
end;

procedure TMainForm.Horizontal1Click(Sender: TObject);
begin
  DoTile(tbHorizontal);
end;

procedure TMainForm.TileConfig2Click(Sender: TObject);
begin
  TileConfig(FSelectedTile);
end;

//AFirstStart: Logout 후 Login 시에 False
//           : 프로그램 처음 시작시에는 True
procedure TMainForm.Init(AAutoStart: Boolean = False; AFirstStart: Boolean = True);
var
  LPasswd, LUserId, LProjectFileName: string;
  LIsPreventOnVM,
  LIsIgnoreMachineID: Boolean;
begin
  PDFiumDllDir := IncludeTrailingPathDelimiter(FApplicationPath) + 'Dlls\';

  if not Assigned(FMenuBase) then
    FMenuBase := TMenuBase.Create(Self);

  if AAutoStart then
  begin
    //param으로 입력된 Id,Passwd,ProjectFileName을 LUserId,LPasswd 및 LProjectFileName에 가져옴
    ProcessCommandLineParameter(LUserId, LPasswd, LProjectFileName, LIsPreventOnVM, LIsIgnoreMachineID);
    SetPreventOnVM(LIsPreventOnVM);
    SetIgnoreMachineID(LIsIgnoreMachineID);
  end;

  if not LoginProcess(AAutoStart,LUserId, LPasswd) then
  begin
    //FreeAndNil(FHiMECSConfig);
    FreeAndNil(FHiMECSUser);

    if AFirstStart then
      Halt(0)
    else
    begin
      LoadMenuFromFile(DefaultMenuFileNameOnLogOut, True);
      exit;
    end;
  end;

  ProcessSelectProject(AFirstStart, AAutoStart, LProjectFileName);
end;

procedure TMainForm.InitEnum;
begin
  g_ParameterCategory4AVAT2.InitArrayRecord(R_ParameterCategory4AVAT2);
  g_ParameterSubCategory4AVAT2.InitArrayRecord(R_ParameterSubCategory4AVAT2);
  g_ManualSearchSrc.InitArrayRecord(R_ManualSearchSrc);
end;

procedure TMainForm.InitHttpApiServer;
begin
//  if not Assigned(FHiMECSHttpApiServer) then
//  begin
//    FHiMECSHttpApiServer := THiMECSHttpApiServer.Create('E:\pjh\project\util\HiMECS\Application\Bin\Applications\');
//  end;
end;

procedure TMainForm.InitHTTPRestServer;
begin
  FHiMECSHTTPAPIServer := THiMECSHTTPAPIServer.Create();
end;

procedure TMainForm.InitSearchParamList(ADeviceName: string);
var
  i: integer;
begin
  for i := 0 to FSearchParamList.Count - 1 do
    TEngineParameter(FSearchParamList.Objects[i]).Free;

  FSearchParamList.Clear;
  FSearchParamList := GetSearchListFromDeviceName(ADeviceName, 'Engine Param');
end;

function TMainForm.InsertMenuItem(AMenu: TMenuItem; AInsertIndex: Integer;
  ANested: string; AOnClick: TNotifyEvent; Action: TContainedAction;
  AShortCut: TShortCut): TMenuItem;
var
  LStr: string;
  LIndex: integer;
begin
  Result := nil;

  LStr := strToken(ANested, ',');
  LIndex := StrToInt(LStr);

  if ANested <> '' then
  begin
    Result := InsertMenuItem(AMenu.Items[LIndex], AInsertIndex, ANested);
  end
  else
  begin
    Result := TMenuItem.Create(Self);
    Result.Caption := FMenuBase.HiMECSMenuCollect.Items[AInsertIndex].Caption;
    Result.Hint := FMenuBase.HiMECSMenuCollect.Items[AInsertIndex].Hint;
    //Result.OnClick := AOnClick;
    Result.ShortCut := AShortCut;
    Result.Action := Action;
    //SetControlEvent를 위해 FMenuBase.HiMECSMenuCollect index를 저장함
    Result.Tag := AInsertIndex;

    SetControlEvent(TControl(Result), AInsertIndex,
        FMenuBase.HiMECSMenuCollect.Items[AInsertIndex].EventName);
    SetMenuImageIndex(Result, AInsertIndex);
    AMenu.Insert(LIndex, Result);
  end;
end;

function TMainForm.IsIncludeSensorTypesFromEngParamItem(
  const AEngineParameterItem: TEngineParameterItem;
  ASensorTypes: TSensorTypes): Boolean;
begin
  Result := AEngineParameterItem.SensorType in ASensorTypes;

//  if (not Result) and (stParam in ASensorTypes) and (AEngineParameterItem.ParamNo <> '') then
//    Result := True;
end;

procedure TMainForm.JvCaptionButton1Click(Sender: TObject);
//var
//  LRec: TRestAPIResponseDoc;
begin
  SelectEquipment;
end;

procedure TMainForm.MaintenanceTVDblClick(Sender: TObject);
var
  LNode: TTreeNode;
  LFileName: string;
begin
  LNode := MaintenanceTV.GetNodeAt( FMouseClickMaintenanceTV_X, FMouseClickMaintenanceTV_Y );

  if not FControlPressedMaintenanceTV then
  begin
    if Assigned(LNode) and Assigned(LNode.Data) then
    begin
      if TObject(LNode.Data) is THiMECSMaintenanceManualItem then
      begin
        LFileName := IncludeTrailingPathDelimiter(THiMECSMaintenanceManualItem(LNode.Data).FilePath) +
          THiMECSMaintenanceManualItem(LNode.Data).FileName;
        CreateMDI4PDF(LFileName, THiMECSMaintenanceManualItem(LNode.Data).SystemDesc_Eng,
          THiMECSMaintenanceManualItem(LNode.Data).PageNo_B, hdtMtManual);
      end
      else
      if TObject(LNode.Data) is THiMECSSvcLetterItem then
      begin
        LFileName := IncludeTrailingPathDelimiter(THiMECSSvcLetterItem(LNode.Data).FilePath) +
          THiMECSSvcLetterItem(LNode.Data).FileName;
        CreateMDI4PDF(LFileName,THiMECSSvcLetterItem(LNode.Data).SystemDesc_Eng,
          THiMECSSvcLetterItem(LNode.Data).PageNo_B, hdtSvcLetter);
      end
    end;

    FControlPressedMaintenanceTV := False;
  end;
end;

procedure TMainForm.MaintenanceTVKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
//    vk_delete: DeleteItem1Click(EngModbusTV);
    vk_control: FControlPressedMaintenanceTV := True;
  end;
end;

procedure TMainForm.MaintenanceTVKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
//    vk_delete: DeleteItem1Click(EngModbusTV);
    vk_control: FControlPressedMaintenanceTV := False;
  end;
end;

procedure TMainForm.MaintenanceTVMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseClickMaintenanceTV_X := X;
  FMouseClickMaintenanceTV_Y := Y;
end;

procedure TMainForm.ManualCheckTVDblClick(Sender: TObject);
var
  LNode: TTreeNode;
  LFileName: string;
  i,j: integer;

//  procedure _CreateMDI(AFileName, ASystemDesc: string; APageB: integer);
//  begin
//    TDocVariant.New(LObj);
//    LObj.FileName := ChangeFileExt(AFileName, '.pdf');
//    LObj.PageNo := APageB;
//    LObj.SystemDesc_Eng := ASystemDesc;
//    LArgs := VariantSaveJson(LObj);
//    LForm := CreateMIDChild(TPDFViewMDIChildF, LArgs, True);//CreateModalNMIDChild(TPDFViewF, LArgs, False, True);
//  end;
begin
  LNode := ManualCheckTV.GetNodeAt( FMouseClickManualTV_X, FMouseClickManualTV_Y );

  if not FControlPressedManualTV then
  begin
    if Assigned(LNode) then
    begin
      if TObject(LNode.Data) is THiMECSOpManualItem then
      begin
        LFileName := IncludeTrailingPathDelimiter(THiMECSOpManualItem(LNode.Data).FilePath) +
          THiMECSOpManualItem(LNode.Data).FileName;
        CreateMDI4PDF(LFileName, THiMECSOpManualItem(LNode.Data).SystemDesc_Eng,
          THiMECSOpManualItem(LNode.Data).PageNo_B, hdtOpManual);
      end
      else
      if TObject(LNode.Data) is THiMECSDrawingItem then
      begin
        LFileName := IncludeTrailingPathDelimiter(THiMECSDrawingItem(LNode.Data).FilePath) +
          THiMECSDrawingItem(LNode.Data).FileName;
        CreateMDI4PDF(LFileName,THiMECSDrawingItem(LNode.Data).SystemDesc_Eng,
          THiMECSDrawingItem(LNode.Data).PageNo_B, hdtDrawing);
      end
    end;

    FControlPressedManualTV := False;
  end;
//  else
//    ShowPropertyForm(ManualCheckTV);
end;

procedure TMainForm.ManualCheckTVKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
//    vk_delete: DeleteItem1Click(EngModbusTV);
    vk_control: FControlPressedManualTV := True;
  end;
end;

procedure TMainForm.ManualCheckTVKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
//    vk_delete: DeleteItem1Click(EngModbusTV);
    vk_control: FControlPressedManualTV := False;
  end;
end;

procedure TMainForm.ManualCheckTVMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMouseClickManualTV_X := X;
  FMouseClickManualTV_Y := Y;

//  FControlPressedManualTV := not(ssCtrl in Shift);
end;

{
procedure TMainForm.EngModbusTVDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  //Node: TTreeNode;
  //Expanded: Boolean;
  LTargetNode, LSourceNode: TTreeNode;
  i:integer;
begin
{  if FParameterDragMode then
    exit;

  if (Sender = EngModbusTV) then
  begin
    with EngModbusTV do
    begin
      LTargetNode := GetNodeAt( X, Y ); //Get Target Node
      LSourceNode := Selected;

      if (LTargetNode = nil) or (LTargetNode = LSourceNode) then
      begin
        EndDrag(False);
        Exit;
      end;
    end;

    MoveNode(EngModbusTV, LTargetNode, LSourceNode);
    LSourceNode.Free;
  end
  else if (Sender <> EngModbusTV) then
  begin
    for i := 0 to MDIChildCount - 1 do
    begin
      if MDIChildren[i] is TFormParamList then
      begin
        ShowMessage(TFormParamList(MDIChildren[i]).NextGrid1.Caption);
        break;
      end;
    end;//for
  end;
}
{end;

procedure TMainForm.EngModbusTVDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if FParameterDragMode then
    exit;
  //if (Sender = EngModbusTV) then
  //begin
//    Accept := True;
  //end;
end;
}
procedure TMainForm.EngModbusTVCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  IRect: TRect;
  MColor, BColor: TColor;
begin
{  BColor := clWhite;
  MColor := clBlack;

  IRect := Node.DisplayRect(true);

  if Node = EngModbusTV.Selected then
  begin
    BColor := clBlue;
    MColor := clWhite;
  end;

  EngModbusTV.Canvas.Brush.Color := BColor;
  EngModbusTV.Canvas.Font.Color := MColor;

  Sender.Canvas.TextOut(IRect.Left, IRect.Top, Node.Text);
}

{  with sender as TTreeView do
  begin
    DefaultDraw := true;

    if (cdsSelected in State) or (cdsFocused in state) or (cdsChecked in State) then
    begin
      //when the tree has focus
      Canvas.font.Color := clHighlightText;
      Canvas.Brush.Color := clHighlight;
    end else
    begin
      //all other times
      Canvas.font.Color := clBlack;
      Canvas.Brush.Color := clWhite;
      //this here will keep the selected item highlighted
      if Assigned(Node) then
        if Assigned(Selected) then
          if Node = Selected then
          begin
            Canvas.font.Color := clHighlightText;
            Canvas.Brush.Color := clHighlight;
          end;
    end;
  end;
}
end;

procedure TMainForm.EngModbusTVDblClick(Sender: TObject);
var
  LNode: TTreeNode;
  LForm: TForm;
  i,j: integer;
begin
  LNode := EngModbusTV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );

  if FControlPressed then
  begin
    //if LNode.AbsoluteIndex = 0 then
    if Assigned(LNode) then
    begin
      LForm := CreateOrShowMDIChild(TFormParamList);
      if Assigned(LForm) then
      begin
        Add2MultiNode(LNode,False,False,-1,LForm);
      end;
    end
    else
    if Assigned(LNode) then
    begin
      if TObject(LNode.Data) is TEngineParameterItem then
      begin
        LForm := CreateOrShowMDIChild(TFormParamList);
        if Assigned(LForm) then
        begin
          ParameterItem2ParamList(LNode,LForm);
        end;
      end;
    end;

    FControlPressed := False;
  end
  else
    ShowPropertyForm(EngModbusTV);
end;

procedure TMainForm.EngModbusTVKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LStr: string;
begin
  case Key of
    vk_delete: DeleteItem1Click(EngModbusTV);
    vk_control: FControlPressed := True;
  end;

  if (ssCtrl in Shift) and (Key = Ord('C')) then
  begin
    LStr := EngModbusTV.Selected.Text;
    ClipBoard.AsText := TrimLeft(strTokenRev(LStr, ':'));
  end;
end;

procedure TMainForm.EngModbusTVKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_delete: DeleteItem1Click(EngModbusTV);
    vk_control: FControlPressed := False;
  end;
end;

procedure TMainForm.EngModbusTVMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  LNode, LRootNode: TTreeNode;
  LEngineParameterItem: TEngineParameterItem;
  LEPD: TEngineParameter_DragDrop;
begin
  FMouseClickModbusTV_X := X;
  FMouseClickModbusTV_Y := Y;

  LNode := EngModbusTV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );
  if Assigned(LNode) then
  begin
    LRootNode := GetRootNode(LNode);

    if Assigned(LRootNode) then
      FCOI := LRootNode.Index;

    FCurrentNode := LNode;

    if (DragDetectPlus(TWinControl(Sender).Handle, Point(X,Y))) then
    begin
      if TObject(LNode.Data) is TEngineParameterItem then
      begin
        if EngModbusTV.SelectionCount = 1 then
        begin
          FParameterDragMode := True;

          LEngineParameterItem := TEngineParameterItem(LNode.Data);
          //LEngineParameterItem.AssignTo(FEngineParameterItemRecord);
          LEngineParameterItem.AssignTo(LEPD.FEPItem);
          LEPD.FEPItem.FFExcelRange := FApplicationPath + FCurrentModbusFileName;
          //MoveMatrixData2ItemRecord(FEngineParameterItemRecord, LEngineParameterItem);
          MoveMatrixData2ItemRecord(LEPD.FEPItem, LEngineParameterItem);

          // Transfer the structure to the drop source data object and execute the drag.
          //SetLength(LDynArray, 1);//Length(FEngineParameterItemRecord));
          //Move(FEngineParameterItemRecord, LDynArray[Low(LDynArray)], SizeOf(FEngineParameterItemRecord));
          LEPD.FDragDataType := dddtSingleRecord;
          LEPD.FShiftState := Shift;//FKeyBdShiftState;
          FEngModbusSource.EPD := LEPD;
          //FEngParamSource.DragDataType := dddtSingleRecord;
          EngModbusSource.Execute;
        end
        else
        begin  //Multi Select 후 Shift 누른 상태에서 Drag하면 실행되는 루틴
          FParameterDragMode := True;
          LEPD.FDragDataType := dddtMultiRecord;
          LEPD.FShiftState := Shift;//FKeyBdShiftState;
          LEPD.FSourceHandle := Handle;
          FEngModbusSource.EPD := LEPD;
          EngModbusSource.Execute;
        end;
      end
      else
      begin //선택한 노드의 하위 노드 존재 시 실행되는 루틴
        //FArrayEngineParameterItemRecord에 데이터 저장
        //Add2MultiNode(LNode, False);
        //Clipbrd에 데이터 복사
        FParameterDragMode := True;
        LEPD.FSourceHandle := Handle;
        LEPD.FShiftState := Shift;//FKeyBdShiftState;
        LEPD.FDragDataType := dddtMultiRecord;
        FEngModbusSource.EPD := LEPD;
//        FCurrentNode := LNode;
        //Caption := IntToStr(Handle);
        EngModbusSource.Execute;
      end;
    end
    else
      FParameterDragMode := False;
  end;

  if ssCtrl in Shift then
    FControlPressed := False;
end;

procedure TMainForm.ListConfig1Click(Sender: TObject);
var
  LAdvNavBarPanel: TAdvNavBarPanel;
  LFrame: TTileListFrame;
begin
  LAdvNavBarPanel := AdvNavBar1.Panels[AdvNavBar1.ActiveTabIndex];
  if LAdvNavBarPanel.Name = 'MonitoringPanel' then
  begin
    LFrame := MonTileListFrame;
    SetConfigMonitorTile(LFrame.tileList.SelectedTile);
  end
  else
  if LAdvNavBarPanel.Name = 'CommunicationPanel' then
  begin
    LFrame := CommTileListFrame;
    SetConfigAutoRunTile(LFrame.tileList.SelectedTile);
  end;
end;

procedure TMainForm.LoadAllInfo1Click(Sender: TObject);
begin
//  if High(FPackageModules) < 0 then
    PackageLoad_MDIChild;

  CreateChildFormAll;
end;

procedure TMainForm.LoadAutoRun(AVar: TAutoRunItem);
var
  LHandle,LProcessID: THandle;
  LRunName: string;
  LHiMECSConfig: THiMECSConfig;
  LParam: string;
begin
  LRunName := AVar.AppPath;
  if Pos('.',LRunName) > 0  then //'.'이 존재 하면
    LRunName := replaceString(LRunName, '.\', '.\Applications\');

  LParam := AVar.RunParameter;

  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;

  if LHiMECSConfig.ExtAppInMDI then
    LParam := LParam + ' /C';  //MDI Child Mode

  LProcessId := ExecNewProcess2(LRunName, LParam);
  LHandle := DSiGetProcessWindow(LProcessId);
  AVar.AppHandle := LHandle;
  AVar.AppProcessId := LProcessId;

  if LHiMECSConfig.ExtAppInMDI then
  begin
    CreateDummyMDIChild(LProcessId);
    ReparentWindow(LHandle);
  end;
end;

procedure TMainForm.LoadAutoRunConfigForm2Var(AForm: TnewCommApp_Frm;
  AVar: TAutoRunItem);
var
  LStr: string;
begin
  with AForm do
  begin
    AVar.AppTitle := appTitle.Text;
    AVar.IsAutoRun := AutoRunCB.Checked;

    if RelPathCB.Checked then
      LStr := ExtractRelativePathBaseApplication(FApplicationPath+'Applications\', appPath.Text)
    else
      LStr := appPath.Text;

    AVar.AppPath := LStr;
    AVar.AppDesc := appDesc.Text;
    AVar.RunParameter := RunParamEdit.Text;

    with GDIPPictureContainer1.Items do
    begin
      Clear;
      Add;
      Items[Count-1].Picture.Assign(Icon.Picture);
      AVar.AppImage := CommTileListFrame.ConvertImage2String(Items[Count-1].Picture);

      Items[Count-1].Picture.Assign(DisableIcon.Picture);
      AVar.AppDisableImage := CommTileListFrame.ConvertImage2String(Items[Count-1].Picture);
    end;
  end;
end;

procedure TMainForm.LoadAutoRunList;
var
  i, LHandle: integer;
  LStr,
  LParam, LProgName: string;
  LAutoRunList: TAutoRunList;
begin
  CommTileListFrame.InitVar;
  //MonTileListFrame.TileList.FAddNewApp2List := AddNewApp2List;

  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
  begin
    LStr := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].RunListFileName;

    if LStr <> '' then
    begin
      if FileExists(LStr) then
      begin
        if Pos('..',LStr) = 0  then //'..'이 없는 경우
          LStr := replaceString(LStr, '.\', '..\');

        LAutoRunList := TAutoRunList.Create(Self);
        FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSAutoRun := LAutoRunList;

        if FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.UseCommLauncher then
        begin
          LProgName := HiMECSCommLauncher;
          LParam := '/A' + LStr;
          LHandle := ExecLaunchList(LProgName,LParam);//, FAutoRunHandles);
          LAutoRunList.LauncherHandle := LHandle;
        end
        else
        begin
          if Pos('..',LStr) > 0  then //'..'이 존재 하면
            LStr := replaceString(LStr, '..\', '.\');

          LoadAutoRunTileFromFile(LStr, True, LAutoRunList);
          ExecuteAutoRunList(LAutoRunList, False, True, False);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.LoadAutoRunTileFromFile(AFileName: string;
  AIsAppend: Boolean; AAutoRunList: TAutoRunList);
var
  lTile : TAdvSmoothTile;
  i: integer;
begin
  SetCurrentDir(FApplicationPath);

  if not FileExists(AFileName) then
  begin
    ShowMessage('File not exist : '+ AFileName + ' (From .rlist)');
    exit;
  end;

  if not AIsAppend then
  begin
    AAutoRunList.AutoRunCollect.Clear;
    CommTileListFrame.tileList.Tiles.Clear;
  end;

  AAutoRunList.LoadFromJSONFile(AFileName);

  for i := 0 to AAutoRunList.AutoRunCollect.Count - 1 do
  begin
    lTile := CommTileListFrame.tileList.Tiles.Add;
    LoadAutoRunVar2Form(lTile,AAutoRunList.AutoRunCollect.Items[i]);
  end; //for
end;

procedure TMainForm.LoadAutoRunVar2ConfigForm(AForm: TnewCommApp_Frm;
  AVar: TAutoRunItem);
begin
  with AForm do
  begin
    appTitle.Text := AVar.AppTitle;
    AutoRunCB.Checked := AVar.IsAutoRun;
    appPath.Text := AVar.AppPath;
    appDesc.Text := AVar.AppDesc;
    RunParamEdit.Text := AVar.RunParameter;

    with GDIPPictureContainer1.Items do
    begin
      Clear;
      Add;
      if AVar.AppImage <> '' then
      begin
        Items[Count-1].Picture.LoadFromStream(CommTileListFrame.ConvertString2Stream(AVar.AppImage));
        Icon.Picture.Assign(Items[Count-1].Picture);
        Icon.Invalidate;
      end;

      if AVar.AppDisableImage <> '' then
      begin
        Items[Count-1].Picture.LoadFromStream(CommTileListFrame.ConvertString2Stream(AVar.AppDisableImage));
        DisableIcon.Picture.Assign(Items[Count-1].Picture);
        DisableIcon.Invalidate;
      end;
    end;
  end;
end;

procedure TMainForm.LoadAutoRunVar2Form(ATile: TAdvSmoothTile;
  AVar: TAutoRunItem);
begin
  with ATile do
  begin
    Content.Text := AVar.AppTitle;
    Content.TextPosition := tpBottomCenter;

    if AVar.IsAutoRun then
      StatusIndicator := 'Auto'
    else
      StatusIndicator := '';

    Content.Hint := AVar.AppPath;
    DisplayName := AVar.AppDesc;
    ItemOject := AVar;

    if AVar.AppImage <> '' then
      Content.Image.LoadFromStream(CommTileListFrame.ConvertString2Stream(AVar.AppDisableImage));
  end;

  TileConfigChange(2);
end;

procedure TMainForm.LoadConfigCollect2Form(AForm: TConfigF);
var
  LHiMECSConfig: THiMECSConfig;
begin
  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
  AForm.FHiMECSConfig.Assign(TPersistent(LHiMECSConfig));
  AForm.LoadConfigCollect2Form(AForm);
//
//  with LHiMECSConfig, AForm do
//  begin
//    MenuFilenameEdit.Text := MenuFileName;
//    EngInfoFilenameEdit.Text := EngineInfoFileName;
//    ParamFilenameEdit.Text := ParamFileName;
//    ProjInfoFilenameEdit.Text := ProjectInfoFileName;
//    UserFilenameEdit.Text := UserFileName;
//    KillProcFilenameEdit.Text := KillProcListFileName;
//
//    FormPathEdit.Text := HiMECSFormPath;
//    ConfigPathEdit.Text := ConfigPath;
//    DocPathEdit.Text := DocPath;
//    ExePathEdit.Text := ExesPath;
//    BplPathEdit.Text := BplsPath;
//    LogPathEdit.Text := LogPath;
//
//    CBExtAppInMDI.Checked := ExtAppInMDI;
//    CBUseMonLauncher.Checked := UseMonLauncher;
//    CBUseCommLauncher.Checked := UseCommLauncher;
//    EngParamEncryptCB.Checked := EngParamEncrypt;
//    ConfFileFormatRG.ItemIndex := EngParamFileFormat;
//
//    SelProtocolRG.ItemIndex := UpdateProtocol;
//    HostEdit.Text := FTPHost;
//    PortEdit.Text := IntToStr(FTPPort);
//    UserIdEdit.Text := FTPUserID;
//    PasswdEdit.Text := FTPPasswd;
//    DirEdit.Text := FTPDirectory;
//    URLEdit.Text := ServerURL;
//    UpdateCB.Checked := UpdateWhenStart;
//  end;
end;

//.option file load
procedure TMainForm.LoadConfigCollectFromFile(AIndex: integer);
var
  LHiMECSConfig: THiMECSConfig;
  LFileName: string;
  LIsEncrypt: Boolean;
begin
  if not Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig) then
    FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig := THiMECSConfig.Create(Self);

  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig;

  LFileName := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].OptionsFileName;
  LIsEncrypt := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].OptionFileEncrypt;

  if LFileName <> '' then
  begin
    LHiMECSConfig.Clear;
    LHiMECSConfig.LoadFromJSONFile(LFileName,ExtractFileName(LFileName),LIsEncrypt);
    
    //if not exist directory then create directory
    if (LHiMECSConfig.HiMECSFormPath <> '') and (LHiMECSConfig.HiMECSFormPath <> '\') then
      if not ForceDirectories(LHiMECSConfig.HiMECSFormPath) then
        ShowMessage('Creation fail for ' + LHiMECSConfig.HiMECSFormPath + ' folder!');

    if (LHiMECSConfig.ConfigPath <> '') and (LHiMECSConfig.ConfigPath <> '\') then
      if not ForceDirectories(LHiMECSConfig.ConfigPath) then
        ShowMessage('Creation fail for ' + LHiMECSConfig.ConfigPath + ' folder!(from HiMECSFormPath option)');

    if (LHiMECSConfig.DocPath <> '') and (LHiMECSConfig.DocPath <> '\') then
      if not ForceDirectories(LHiMECSConfig.DocPath) then
        ShowMessage('Creation fail for ' + LHiMECSConfig.DocPath + ' folder!(from DocPath option)');

    if (LHiMECSConfig.ExesPath <> '') and (LHiMECSConfig.ExesPath <> '\') then
      if not ForceDirectories(LHiMECSConfig.ExesPath) then
        ShowMessage('Creation fail for ' + LHiMECSConfig.ExesPath + ' folder!(from ExesPath option)');

    if (LHiMECSConfig.BplsPath <> '') and (LHiMECSConfig.BplsPath <> '\') then
      if not ForceDirectories(LHiMECSConfig.BplsPath) then
        ShowMessage('Creation fail for ' + LHiMECSConfig.BplsPath + ' folder!(from BplsPath option)');

    if (LHiMECSConfig.LogPath <> '') and (LHiMECSConfig.LogPath <> '\') then
      if not ForceDirectories(LHiMECSConfig.LogPath) then
        ShowMessage('Creation fail for ' + LHiMECSConfig.LogPath + ' folder!(from LogPath option)');
  end
  else
    ShowMessage('Config File name is empty!');
end;

procedure TMainForm.LoadConfigForm2Collect(AForm: TConfigF);
var
  LPath: string;
  LHiMECSConfig: THiMECSConfig;
begin
  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
  AForm.LoadConfigForm2Collect(AForm);
  LHiMECSConfig.Assign(TPersistent(AForm.FHiMECSConfig));
end;

procedure TMainForm.LoadMonitorConfigForm2Var(AForm: TnewMonApp_Frm;
  AVar: THiMECSMonitorListItem);
var
  LStr: string;
begin
  with AForm do
  begin
    AVar.MonitorTitle := appTitle.Text;
    AVar.IsAutoLoad := AutoRunCB.Checked;
    if RelPathCB.Checked then
      LStr := ExtractRelativePathBaseApplication(FApplicationPath+'Applications\', appPath.Text)
    else
      LStr := appPath.Text;

    AVar.MonitorFileName := LStr;

    if ProgRelPathCB.Checked then
      LStr := ExtractRelativePathBaseApplication(FApplicationPath+'Applications\', ProgNameEdit.Text)
    else
      LStr := ProgNameEdit.Text;

    AVar.RunProgramName := LStr;
    AVar.MonitorDesc := appDesc.Text;
    with GDIPPictureContainer1.Items do
    begin
      Clear;
      Add;
      Items[Count-1].Picture.Assign(Icon.Picture);
      AVar.MonitorImage := MonTileListFrame.ConvertImage2String(Items[Count-1].Picture);
    end;
  end;
end;

procedure TMainForm.LoadEngineInfo(AFileName:string; AIsEncrypt: Boolean;
  AIsAdd2Combo: Boolean; AIs2Inspector: Boolean);
var
  LHiMECSConfig: THiMECSConfig;
begin
  if not FileExists(AFileName) then
  begin
    DisplayMessage('Engine information file: ' + AFileName + ' not found!',
                                                            mstFile,mtError);
    exit;
  end;

  SetCurrentDir(FApplicationPath);

  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;

  if not Assigned(LHiMECSConfig.EngineInfo) then
    LHiMECSConfig.EngineInfo := TICEngine.Create(Self);

  LHiMECSConfig.EngineInfo.LoadFromJsonFile(AFileName,ExtractFileName(AFileName),AIsEncrypt);

//  if AIsAdd2Combo then
//    SelectEngineCombo.Lines.Add(GetEngineType(FCOI));

  if AIs2Inspector then
    SetEngineInfo2Inspector(FCOI, AIsAdd2Combo);
end;

procedure TMainForm.LoadEngineInfo1Click(Sender: TObject);
begin
  JvOpenDialog1.InitialDir := FApplicationPath;
  if JvOpenDialog1.Execute then
  begin
    if jvOpenDialog1.FileName <> '' then
    begin
      LoadEngineInfo(JvOpenDialog1.FileName, False, False, True);
    end;
  end;
end;

procedure TMainForm.LoadFromFile1Click(Sender: TObject);
begin
  JvOpenDialog1.InitialDir := FApplicationPath;

  if JvOpenDialog1.Execute then
  begin
    if JvOpenDialog1.FileName <> '' then
    begin
      //LoadTileFromFile(JvOpenDialog1.FileName, False);
    end;
  end;
end;

procedure TMainForm.LoadKillProcess;
var
  LHiMECSConfig: THiMECSConfig;
begin
  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;

  if not FileExists(LHiMECSConfig.KillProcListFileName) then
    exit;

  FKillProcessList.KillProcessListCollect.Clear;
  FKillProcessList.KillProcListFileName := LHiMECSConfig.KillProcListFileName;
  FKillProcessList.LoadFromJSONFile(LHiMECSConfig.KillProcListFileName);
  ExecProcessKill;
  FKillProcessList.KillProcTimerHandle := FPJHTimerPool.Add(OnProcessKill, 600000);
end;

procedure TMainForm.LoadManualInfo2MsNoTV(ARoot: TTreeNode;
  AManualInfo: THiMECSManualInfo; AManualKind : TManualItemKinds; ATV: TJvCheckTreeView=nil);
var
  i: integer;
  LTreeNode,
  LPartTreeNode2: TTreeNode;
  LStr, LStr2: string;
  LStrlst, LSystemlst: TStringList;
  LIndex: integer;

  procedure AddItem2TV(ACategory, ASystem, APart: string; AItemObj: TObject);
  begin
    LIndex := LStrlst.IndexOf(LStr);
    
    if LIndex < 0 then
    begin
      LTreeNode := ATV.Items.AddChild(ARoot, LStr);
      LStrlst.AddObject(LStr, LTreeNode);
      SetNodeImages(LTreeNode, True);
    end
    else
    begin
      LTreeNode := TTreeNode(Lstrlst.Objects[LIndex]);
    end;

    LStr := LStr + ';' + ASystem;
    LIndex := LSystemlst.IndexOf(LStr);
    
    if LIndex < 0 then
    begin
      LStr2 := strToken(LStr, ';');
      LTreeNode := ATV.Items.AddChild(LTreeNode, LStr);
      LSystemlst.AddObject(LStr2+';'+LStr, LTreeNode);
      SetNodeImages(LTreeNode, True);
    end
    else
    begin
      LTreeNode := TTreeNode(LSystemlst.Objects[LIndex]);
    end;

    if APart = '' then
//        LStr2 := AParam.EngineParameterCollect.Items[i].Tagname
    else
      LStr2 := APart;

    LPartTreeNode2 := ATV.Items.AddChildObject(LTreeNode,
           LStr2, AItemObj);
    SetNodeImages(LPartTreeNode2, False);
  end;
begin
  if ATV = nil then
    ATV := ManualCheckTV;

  if not Assigned(AManualInfo) then
    exit;

  LStrlst := TStringList.Create;
  LSystemlst := TStringList.Create;
  LStrlst.CaseSensitive := False;
  ATV.Items.BeginUpdate;

  try
    if mikOpManual in AManualKind then
    begin
      for i := 0 to AManualInfo.OpManual.Count - 1 do
      begin
        LStr := 'Operation Manual';

        with AManualInfo.OpManual.Items[i] do
        begin
          if not FIsHideItem then
            AddItem2TV(LStr, SystemDesc_Eng, PartDesc_Eng, TObject(AManualInfo.OpManual.Items[i]));
        end;//with
      end;//for
    end;

    if mikDrawings in AManualKind then
    begin
      for i := 0 to AManualInfo.Drawings.Count - 1 do
      begin
        LStr := 'Drawing';

        with AManualInfo.Drawings.Items[i] do
        begin
          if not FIsHideItem then
            AddItem2TV(LStr, SystemDesc_Eng, PartDesc_Eng, TObject(AManualInfo.Drawings.Items[i]));
        end;//with
      end;//for
    end;

    if mikSvcLetter in AManualKind then
    begin
      for i := 0 to AManualInfo.SvcLetter.Count - 1 do
      begin
        LStr := 'Service Letter';

        with AManualInfo.SvcLetter.Items[i] do
        begin
          if not FIsHideItem then
            AddItem2TV(LStr, SystemDesc_Eng, PartDesc_Eng, TObject(AManualInfo.SvcLetter.Items[i]));
        end;//with
      end;//for
    end;

    if mikMaintenance in AManualKind then
    begin
      for i := 0 to AManualInfo.MaintenanceManual.Count - 1 do
      begin
        LStr := 'Maintenance';

        with AManualInfo.MaintenanceManual.Items[i] do
        begin
          if not FIsHideItem then
            AddItem2TV(LStr, SystemDesc_Eng, PartDesc_Eng, TObject(AManualInfo.MaintenanceManual.Items[i]));
        end;//with
      end;//for
    end;
  finally
    ATV.Items.EndUpdate;
    LSystemlst.Free;
    LStrlst.Free;
  end;
end;

procedure TMainForm.LoadManualInfo2PlateNoTV(ARoot: TTreeNode;
  AManualInfo: THiMECSManualInfo; AManualKind : TManualItemKinds; ATV: TJvCheckTreeView=nil);
begin
  if ATV = nil then
    ATV := ManualCheckTV;
end;

//procedure TMainForm.LoadManualInfo2TreeView(AFileName: string;
//  ASortMethod: TManualSortMethod; ARootNode: TTreeNode; AIndex: integer; ATV: TJvCheckTreeView);
//var
//  LStr: string;
//  LHiMECSManualInfo: THiMECSManualInfo;
//  LEPList: TStringList;
//  LHiMECSConfig: THiMECSConfig;
//  LIndex: integer;
//begin
//  if ATV = nil then
//    ATV := ManualCheckTV;
//
//  if AIndex = -1 then
//    LIndex := FCOI
//  else
//    LIndex := AIndex;
//
//  if ARootNode = nil then
//  begin
//    ATV.Items.Clear;
//    ATV.Items.BeginUpdate;
//
//    LStr := FCurrentSelectedProjectFile.ProjectFileCollect.Items[LIndex].ProjectItemName;
//    ARootNode := ATV.Items.AddChild(nil, LStr);
//  end;
//
//  try
//    SetCurrentDir(FApplicationPath);
//    LHiMECSManualInfo := THiMECSManualInfo.Create(Self);
//    LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[LIndex].HiMECSConfig;
//
//    if AFileName = '' then
//    begin
//      FCurrentManualInfoFileName := LHiMECSConfig.ManualInfoFileName;
//    end
//    else
//    begin
//      FCurrentManualInfoFileName := AFileName;
//    end;
//
//    if not FileExists(FCurrentManualInfoFileName) then
//    begin
//      ShowMessage('Manual Info File: "' + FCurrentManualInfoFileName + '" not exist(From HiMECSConfig.ManualInfoFileName)!');
//      exit;
//    end;
//
//    LHiMECSManualInfo.LoadFromJSONFile(FCurrentManualInfoFileName);
//
//    if Assigned(LHiMECSConfig.ManualInfo) then
//    begin
//      LHiMECSConfig.ManualInfo.Free;
//      LHiMECSConfig.ManualInfo := nil;
//    end;
//
//    LHiMECSConfig.ManualInfo := LHiMECSManualInfo;
//    if LHiMECSManualInfo.OpManual.Count <= 0 then
//      exit;
//
//    case ASortMethod of
//      msmMSNo: LoadManualInfo2MsNoTV(ARootNode, LHiMECSManualInfo, ATV);
//      msmPlateNo: LoadManualInfo2PlateNoTV(ARootNode, LHiMECSManualInfo, ATV);
//    end;//case
//  finally
//    ATV.Items.EndUpdate;
//  end;
//end;

procedure TMainForm.LoadManualInfo2TreeView(AManualKind : TManualItemKinds;
  ASortMethod: TManualSortMethod; ARootNode: TTreeNode; AIndex: integer; ATV: TJvCheckTreeView);
var
  LStr: string;
  LHiMECSManualInfo: THiMECSManualInfo;
  LEPList: TStringList;
  LHiMECSConfig: THiMECSConfig;
begin
  if ATV = nil then
    ATV := ManualCheckTV;

  if AIndex = -1 then
    AIndex := FCOI;

  if ARootNode = nil then
  begin
    ATV.Items.Clear;
//    ATV.Items.BeginUpdate;

    LStr := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].ProjectItemName;
    ARootNode := ATV.Items.AddChild(nil, LStr);
  end;

  try
    LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig;
    LHiMECSManualInfo := LHiMECSConfig.ManualInfo;

    if LHiMECSManualInfo.OpManual.Count <= 0 then
      exit;

    case ASortMethod of
      msmMSNo: LoadManualInfo2MsNoTV(ARootNode, LHiMECSManualInfo, AManualKind, ATV);
      msmPlateNo: LoadManualInfo2PlateNoTV(ARootNode, LHiMECSManualInfo, AManualKind, ATV);
    end;//case
  finally
//    ATV.Items.EndUpdate;
  end;
end;

procedure TMainForm.LoadManualInfo2TV(AManualKind : TManualItemKinds;
  ASortMethod: TManualSortMethod; ATV: TJvCheckTreeView);
var
  i,LIndex: integer;
  LStr: string;
  LRootNode: TTreeNode;
  LRootList: TStringList;
//  LHiMECSConfig: THiMECSConfig;
begin
  if ATV = nil then
    ATV := ManualCheckTV;

  LRootList := TStringList.Create;
  try
//    for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
//    begin
      i := FCOI;

      LStr := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName;
      LIndex := -1;
      LIndex := LRootList.IndexOf(LStr);

      if LIndex < 0 then
      begin
        LRootNode := ATV.Items.AddChild(nil, LStr);
        LRootList.AddObject(LStr, LRootNode);
      end
      else
        LRootNode := TTreeNode(LRootList.Objects[LIndex]);

//      LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;
//      LStr := LHiMECSConfig.ManualInfoFileName;
      LoadManualInfo2TreeView(AManualKind, ASortMethod, LRootNode, i, ATV);
      FCurrentManualSortMethod := ASortMethod;
//    end;//for
  finally
    FreeAndNil(LRootList);
  end;
end;

procedure TMainForm.LoadManualInfoFromFile(AFileName: string; AIndex: integer);
var
  LHiMECSConfig: THiMECSConfig;
begin
  if AIndex = -1 then
    AIndex := FCOI;

  SetCurrentDir(FApplicationPath);
  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig;

  if not Assigned(LHiMECSConfig.ManualInfo) then
    LHiMECSConfig.ManualInfo := THiMECSManualInfo.Create(Self);

  if AFileName = '' then
  begin
    FCurrentManualInfoFileName := LHiMECSConfig.ManualInfoFileName;
  end
  else
  begin
    FCurrentManualInfoFileName := AFileName;
  end;

  if not FileExists(FCurrentManualInfoFileName) then
  begin
    ShowMessage('Manual Info File: "' + FCurrentManualInfoFileName + '" not exist(From HiMECSConfig.ManualInfoFileName)!');
    exit;
  end;

  LHiMECSConfig.ManualInfo.LoadFromJSONFile(FCurrentManualInfoFileName);
end;

procedure TMainForm.LoadMenuFromFile(AFileName: string; AIsUseLevel: Boolean);
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));

  if AFileName = '' then
  begin
    AFileName := DefaultMenuFileNameOnLogIn;
    ShowMessage('Menu File name is empty!(From THiMECSUserItem.MenuFileName)' + #13#10 + 'File: ' + DefaultMenuFileNameOnLogIn + ' is loaded.');
  end;

  FMenuBase.HiMECSMenuCollect.Clear;
  FMenuBase.LoadFromJSONFile(AFileName,ExtractFileName(AFileName), DefaultMenuEncryption);
  SetHiMECSMainMenu(FMenuBase);
end;

procedure TMainForm.LoadMonitor(AVar: THiMECSMonitorListItem);
var
  LHandle,LProcessID: THandle;
  LRunName: string;
  LHiMECSConfig: THiMECSConfig;
  LParam: string;
begin
  LRunName := AVar.RunProgramName;
  if Pos('.',LRunName) > 0  then //'.'이 존재 하면
    LRunName := replaceString(LRunName, '.\', '.\Applications\');

  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;

  LParam := '/p' + AVar.MonitorFileName;

  if LHiMECSConfig.ExtAppInMDI then
    LParam := LParam + ' /C';  //MDI Child Mode

  LProcessId := ExecNewProcess2(LRunName, LParam);
  LHandle := DSiGetProcessWindow(LProcessId);
  AVar.AppHandle := LHandle;
  AVar.AppProcessId := LProcessId;

  if LHiMECSConfig.ExtAppInMDI then
  begin
    CreateDummyMDIChild(LProcessId);
    ReparentWindow(LHandle);
  end;
end;

procedure TMainForm.LoadMonitorFormList;
var
  i, LHandle: integer;
  LStr,
  LParam, LProgName: string;
  LHiMECSMonitorList: THiMECSMonitorList;
begin
  MonTileListFrame.InitVar;
  //MonTileListFrame.TileList.FAddNewApp2List := AddNewApp2List;

  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
  begin
    LStr := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].MonitorFileName;

    if LStr <> '' then
    begin
      if FileExists(LStr) then
      begin
        if Pos('..',LStr) = 0  then //'..'이 없는 경우
          LStr := replaceString(LStr, '.\', '..\');

        LHiMECSMonitorList := THiMECSMonitorList.Create(Self);
        FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor := LHiMECSMonitorList;

        if FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig.UseMonLauncher then
        begin
          LProgName := HiMECSMonitorLauncher;
          LParam := '/A' + LStr;
          LHandle := ExecLaunchList(LProgName,LParam);//, FMonitorHandles);
          LHiMECSMonitorList.LauncherHandle := LHandle;
        end
        else
        begin
          if Pos('..',LStr) > 0  then //'..'이 존재 하면
            LStr := replaceString(LStr, '..\', '.\');

          LoadMonitorTileFromFile(LStr, True, LHiMECSMonitorList);
          ExecuteMonitorList(LHiMECSMonitorList, False, True, False);
        end;
      end;
    end;
  end;
end;

procedure TMainForm.LoadParameter2SensorTV(ARoot: TTreeNode;
   AParam: TEngineParameter; ATV: TJvCheckTreeView=nil);
var
  i: integer;
  LTreeNode,
  LPartTreeNode2: TTreeNode;
  LStr, LStr2, LStr3: string;
  LStrlst, LSensorlst: TStringList;
  LIndex, LIconImgIndex: integer;
  LSensorType: TSensorType;
  LEngParamItem: TEngineParameterItem;
begin
  if ATV = nil then
    ATV := EngModbusTV;

  LStrlst := TStringList.Create;
  LSensorlst := TStringList.Create;
  try
    ATV.Items.BeginUpdate;

    for i := 0 to AParam.EngineParameterCollect.Count - 1 do
    begin
      LEngParamItem := AParam.EngineParameterCollect.Items[i];

      if UpperCase(LEngParamItem.Tagname) = 'DUMMY' then
        continue;

      LIconImgIndex := -1;
      LStr := ParameterSource2String(LEngParamItem.ParameterSource);
      LStrlst.CaseSensitive := False;
      LIndex := LStrlst.IndexOf(LStr);

      if LIndex < 0 then
      begin
        LTreeNode := ATV.Items.AddChild(ARoot, LStr);
        LStrlst.AddObject(LStr, LTreeNode);
        SetNodeImages(LTreeNode, False);
      end
      else
      begin
        LTreeNode := TTreeNode(Lstrlst.Objects[LIndex]);
      end;

      LSensorType := LEngParamItem.SensorType;

//      if (LSensorType = stDI) or (LSensorType =  stDO) or (LSensorType = stmA) or
//        (LSensorType = stRTD) or (LSensorType = stTC) or (LSensorType = stPickup) or
//        (LSensorType = stActuator) then
      if LSensorType = stParam then
      begin
        LStr3 := g_SensorType.ToString(stParam);
      end
      else
      begin
        LStr3 := g_SensorType.ToString(LSensorType);
        LIconImgIndex := GetSensorIconImgIndex(LSensorType);
      end;

      LStr := LStr + ';' + LStr3;
      LSensorlst.CaseSensitive := False;
      LIndex := LSensorlst.IndexOf(LStr);

      if LIndex < 0 then
      begin
        LTreeNode := ATV.Items.AddChild(LTreeNode, LStr3);
        LSensorlst.AddObject(LStr, LTreeNode);
        SetNodeImages(LTreeNode, False);
      end
      else
      begin
        LTreeNode := TTreeNode(LSensorlst.Objects[LIndex]);
      end;

//      LStr := LStr + ';' + g_SensorType.ToString(LSensorType);
//      LStr3 := LStr;
//      LSensorlst.CaseSensitive := False;
//      LIndex := LSensorlst.IndexOf(LStr3);
//
//      if LIndex < 0 then
//      begin
//        LStr2 := strToken(LStr3, ';');
//        LTreeNode := ATV.Items.AddChild(LTreeNode, LStr3);
//        LSensorlst.AddObject(LStr2+';'+LStr3, LTreeNode);
//        SetNodeImages(LTreeNode, False);
//      end
//      else
//      begin
//        LTreeNode := TTreeNode(LSensorlst.Objects[LIndex]);
//      end;
//
//      if LStr2 = '' then
//      begin
//
//      end;

      LPartTreeNode2 := ATV.Items.AddChildObject(LTreeNode,
             LEngParamItem.Description,
             AParam.EngineParameterCollect.Items[i]);

      if LIconImgIndex = -1 then
        SetNodeImages(LPartTreeNode2, False)
      else
        SetNodeImages2Index(LPartTreeNode2, LIconImgIndex);
    end;//for
  finally
    ATV.Items.EndUpdate;
    LSensorlst.Free;
    LStrlst.Free;
  end;
end;

procedure TMainForm.LoadParameter2SystemTV(ARoot: TTreeNode;
   AParam: TEngineParameter; AUseSensorType: Boolean; ATV: TJvCheckTreeView);
var
  i: integer;
  LTreeNode,
  LPartTreeNode2: TTreeNode;
  LStr, LStr2, LStr3: string;
  LParamSrcLlst, LSystemlst: TStringList;
  LIndex, LIconImgIndex: integer;
  LSensorType: TSensorType;
  LEngParamItem: TEngineParameterItem;
begin
  if ATV = nil then
    ATV := EngModbusTV;

  LParamSrcLlst := TStringList.Create;
  LSystemlst := TStringList.Create;
  try
    ATV.Items.BeginUpdate;

    for i := 0 to AParam.EngineParameterCollect.Count - 1 do
    begin
      LEngParamItem := AParam.EngineParameterCollect.Items[i];

      if UpperCase(LEngParamItem.Tagname) = 'DUMMY' then
        continue;

      if LEngParamItem.FIsHideItem then
        continue;

      LStr := ParameterSource2String(LEngParamItem.ParameterSource);

      if LStr = '' then
        continue;

      LIconImgIndex := -1;
      LParamSrcLlst.CaseSensitive := False;
      LIndex := LParamSrcLlst.IndexOf(LStr);

      if LIndex < 0 then
      begin
        LTreeNode := ATV.Items.AddChild(ARoot, LStr);
        LParamSrcLlst.AddObject(LStr, LTreeNode);
        SetNodeImages(LTreeNode, False);
      end
      else
      begin
        LTreeNode := TTreeNode(LParamSrcLlst.Objects[LIndex]);
      end;

//      if LEngParamItem.SensorType = stParam then
      if AUseSensorType then
      begin
        LStr3 := g_SensorType.ToString(LEngParamItem.SensorType);
//      else
//        LStr3 := 'Sensors';

        LStr := LStr + ';' + LStr3;
        LSystemlst.CaseSensitive := False;
        LIndex := LSystemlst.IndexOf(LStr);

        if LIndex < 0 then
        begin
          LTreeNode := ATV.Items.AddChild(LTreeNode, LStr3);
          LSystemlst.AddObject(LStr, LTreeNode);
          SetNodeImages(LTreeNode, False);
        end
        else
        begin
          LTreeNode := TTreeNode(LSystemlst.Objects[LIndex]);
        end;
      end;

      if LEngParamItem.SensorType = stParam then
      begin
        LStr3 := g_ParameterCategory4AVAT2.ToString(LEngParamItem.ParameterCatetory4AVAT2);

        LStr := LStr + ';' + LStr3;
        LSystemlst.CaseSensitive := False;
        LIndex := LSystemlst.IndexOf(LStr);

        if LIndex < 0 then
        begin
          LTreeNode := ATV.Items.AddChild(LTreeNode, LStr3);
          LSystemlst.AddObject(LStr, LTreeNode);
          SetNodeImages(LTreeNode, False);
        end
        else
        begin
          LTreeNode := TTreeNode(LSystemlst.Objects[LIndex]);
        end;

        LStr3 := g_ParameterSubCategory4AVAT2.ToString(LEngParamItem.ParameterSubCatetory4AVAT2);
      end
      else
      begin
        LStr3 := ParameterCatetory2String(LEngParamItem.ParameterCatetory);
      end;

      LStr := LStr + ';' + LStr3;
      LSystemlst.CaseSensitive := False;
      LIndex := LSystemlst.IndexOf(LStr);
      if LIndex < 0 then
      begin
        LTreeNode := ATV.Items.AddChild(LTreeNode, LStr3);
        LSystemlst.AddObject(LStr, LTreeNode);
        SetNodeImages(LTreeNode, False);
      end
      else
      begin
        LTreeNode := TTreeNode(LSystemlst.Objects[LIndex]);
      end;

      if LEngParamItem.Description = '' then
        LStr2 := LEngParamItem.Tagname
      else
        LStr2 := LEngParamItem.Description;

      LSensorType := LEngParamItem.SensorType;

      if LSensorType = stParam then
        LStr2 := LStr2 + ' : ' + LEngParamItem.Value
      else
      if LSensorType = stMeasurand then
        LStr2 := LStr2 + ' : ' + LEngParamItem.Descriptor
      else
      if (LSensorType = stDI) or (LSensorType =  stDO) or (LSensorType = stmA) or
        (LSensorType = stRTD) or (LSensorType = stTC) or (LSensorType = stPickup) or
        (LSensorType = stActuator) then
        LIconImgIndex := GetSensorIconImgIndex(LSensorType);

      LPartTreeNode2 := ATV.Items.AddChildObject(LTreeNode,
             LStr2, LEngParamItem);

      if LIconImgIndex = -1 then
        SetNodeImages(LPartTreeNode2, False)
      else
        SetNodeImages2Index(LPartTreeNode2, LIconImgIndex);
    end;//for
  finally
    ATV.Items.EndUpdate;
    LSystemlst.Free;
    LParamSrcLlst.Free;
  end;
end;

//procedure TMainForm.LoadParameter2TreeView(AFileName:string;
//  ASortMethod: TParamSortMethod; ARootNode: TTreeNode; AIndex: integer; ATV: TJvCheckTreeView);
//var
//  LStr: string;
//  LEngineParameter: TEngineParameter;
//  LEPList: TStringList;
//  LHiMECSConfig: THiMECSConfig;
//  LIndex: integer;
//begin
//  if ATV = nil then
//    ATV := EngModbusTV;
//
//  if AIndex = -1 then
//    LIndex := FCOI
//  else
//    LIndex := AIndex;
//
//  FCurrentEngParamSortMethod := ASortMethod;
//
//  if ARootNode = nil then
//  begin
//    ATV.Items.Clear;
////    ATV.Items.BeginUpdate;
//
//    LStr := FCurrentSelectedProjectFile.ProjectFileCollect.Items[LIndex].ProjectItemName;
//    ARootNode := ATV.Items.AddChild(nil, LStr);
//  end;
//
//  SetCurrentDir(FApplicationPath);
//  //FEngineParameter.EngineParameterCollect.Clear;
//  LEngineParameter := TEngineParameter.Create(Self);
//  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[LIndex].HiMECSConfig;
//
//  if AFileName = '' then
//  begin
//    FCurrentModbusFileName := LHiMECSConfig.ParamFileName;
//  end
//  else
//  begin
//    FCurrentModbusFileName := AFileName;
//  end;
//
//  if not FileExists(FCurrentModbusFileName) then
//  begin
//    ShowMessage('Param File(FCurrentModbusFileName): "' + FCurrentModbusFileName + '" not exist!(From HiMECSConfig.ParamFileName)');
//    exit;
//  end;
//
//  if LHiMECSConfig.EngParamFileFormat = 0 then //XML format
//    LEngineParameter.LoadFromFile(FCurrentModbusFileName,
//              ExtractFileName(FCurrentModbusFileName),
//              LHiMECSConfig.EngParamEncrypt)
//  else
//  if LHiMECSConfig.EngParamFileFormat = 1 then //JSON format
//    LEngineParameter.LoadFromJSONFile(FCurrentModbusFileName,
//              ExtractFileName(FCurrentModbusFileName),
//              LHiMECSConfig.EngParamEncrypt)
//  else
//  if LHiMECSConfig.EngParamFileFormat = 2 then //Sqlite DB format
//  begin
////      LEngineParameter.LoadFromSqliteFile(FCurrentModbusFileName);
//    if LEngineParameter.LoadFromSqliteFile4Secure(FCurrentModbusFileName) = -1 then
//      ShowMessage('Fail to load parameter from DB => "' + FCurrentModbusFileName + '"');
//  end;
//
//  if Assigned(LHiMECSConfig.EngineParameter) then
//  begin
//    LHiMECSConfig.EngineParameter.Free;
//    LHiMECSConfig.EngineParameter := nil;
//  end;
//
//  LHiMECSConfig.EngineParameter := LEngineParameter;
//
//  if LEngineParameter.EngineParameterCollect.Count <= 0 then
//    exit;
//
//  LoadParameter2TVBySortMtehod(ARootNode, LEngineParameter, ASortMethod, ATV);
//end;

procedure TMainForm.LoadParameter2TreeView(ASortMethod: TParamSortMethod;
  ARootNode: TTreeNode; AIndex: integer; ATV: TJvCheckTreeView; AEPKind: TEngParamListItemKind);
var
  LStr: string;
  LEngineParameter: TEngineParameter;
  LEPList: TStringList;
  LHiMECSConfig: THiMECSConfig;
begin
  if ATV = nil then
    ATV := EngModbusTV;

  if AIndex = -1 then
    AIndex := FCOI;

  FCurrentEngParamSortMethod := ASortMethod;

  if ARootNode = nil then
  begin
    ATV.Items.Clear;
//    ATV.Items.BeginUpdate;

    LStr := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].ProjectItemName;
    ARootNode := ATV.Items.AddChild(nil, LStr);
  end;

  LEngineParameter := GetEngParamFromHiMECSConfigByEPKind(AEPKind, AIndex);

//  if AEPKind = eplikModbus then
//    LEngineParameter := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig.ModbusList
//  else
//    LEngineParameter := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig.EngineParameter;

  if not Assigned(LEngineParameter) or (LEngineParameter.EngineParameterCollect.Count <= 0) then
  begin
    ShowMessage('There is no EngineParameter in the HiMECSConfig.EngineParameter! (ProjIndex = ' + IntToStr(AIndex) + ')');
    exit;
  end;

  LoadParameter2TVBySortMtehod(ARootNode, LEngineParameter, ASortMethod, ATV, AEPKind);
end;

procedure TMainForm.LoadParameter2TVBySortMtehod(ARootNode: TTreeNode;
  AParam: TEngineParameter; ASortMethod: TParamSortMethod; ATV: TJvCheckTreeView;
  AEPKind: TEngParamListItemKind);
begin
  if ATV = nil then
    ATV := EngModbusTV;

  case ASortMethod of
    smSystem: LoadParameter2SystemTV(ARootNode, AParam, False, ATV);
    smSensor: LoadParameter2SensorTV(ARootNode, AParam, ATV);
    smSensor_System: LoadParameter2SystemTV(ARootNode, AParam, True, ATV);
    smSystem_Sensor: ;
  end;//case
end;

procedure TMainForm.LoadParameterfromfile1Click(Sender: TObject);
begin
  JvOpenDialog1.InitialDir := FApplicationPath+'doc';
  JvOpenDialog1.Filter := '*.param||*.*';

  if JvOpenDialog1.Execute then
  begin
    if jvOpenDialog1.FileName <> '' then
    begin
      LoadParamterFromFile(JvOpenDialog1.FileName, eplikParameter);
//      LoadParameter2TreeView(JvOpenDialog1.FileName, smSystem);
    end;
  end;
end;

procedure TMainForm.LoadParameterList2TV(ASortMethod: TParamSortMethod;
  ATV: TJvCheckTreeView; AOptIdx: integer; AEPKind: TEngParamListItemKind);
var
  i,LIndex: integer;
  LStr: string;
  LRootNode: TTreeNode;
  LRootList: TStringList;
  LHiMECSConfig: THiMECSConfig;

  procedure _LoadParam2TV(AIdx: integer);
  begin
    if FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].IsDisplayOnTab then
    else
    begin
      LStr := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].ProjectItemName;

      LIndex := LRootList.IndexOf(LStr);

      if LIndex < 0 then
      begin
        LRootNode := ATV.Items.AddChild(nil, LStr);
        //LRootNode.Tag := i;
        LRootList.AddObject(LStr, LRootNode);
      end
      else
        LRootNode := TTreeNode(LRootList.Objects[LIndex]);

//      LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].HiMECSConfig;
//      LStr := LHiMECSConfig.ParamFileName;
      LoadParameter2TreeView(ASortMethod, LRootNode, AIdx, ATV, AEPKind);
    end;
  end;
begin
//  if ATV = nil then
//    ATV := EngModbusTV;

  LRootList := TStringList.Create;
  try
    if AOptIdx = -1 then
    begin
      for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
      begin
        _LoadParam2TV(i);
      end;//for
    end
    else
    begin
      _LoadParam2TV(AOptIdx);
    end;
  finally
    FreeAndNil(LRootList);
  end;
end;

function TMainForm.LoadParamterFromFile(AFileName: string; AEPKind: TEngParamListItemKind): integer;
var
  LHiMECSConfig: THiMECSConfig;
  LParamObj: TEngineParameter;
begin
  if AFileName = '' then
    exit;

  SetCurrentDir(FApplicationPath);

  if not FileExists(AFileName) then
  begin
    ShowMessage('Param File(FCurrentxxxFileName): "' + AFileName + '" not exist!(From HiMECSConfig.xxxFileName)');
    exit;
  end;

  LParamObj := nil;
  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;

  LoadParamterFromFile_(AFileName, LParamObj,
    LHiMECSConfig.EngParamFileFormat, LHiMECSConfig.EngParamEncrypt, AEPKind);

  if AEPKind = eplikModbus then
  begin
    FCurrentModbusFileName := AFileName;
    LHiMECSConfig.ModbusList := LParamObj;
  end
  else
  begin
    FCurrentParamFileName := AFileName;
    LHiMECSConfig.EngineParameter := LParamObj;
  end;
end;

function TMainForm.LoadParamterFromFile_(AFileName: string;
  var AParamObj: TEngineParameter; AParamFileFormat: integer; AIsEncrypt: Boolean;
  AEPKind: TEngParamListItemKind): integer;
begin
  if AFileName = '' then
    exit;

  if not Assigned(AParamObj) then
    AParamObj := TEngineParameter.Create(Self)
  else
    AParamObj.EngineParameterCollect.Clear;

  if AParamFileFormat = 0 then //XML format
    AParamObj.LoadFromFile(AFileName,
              ExtractFileName(AFileName),
              AIsEncrypt)
  else
  if AParamFileFormat = 1 then //JSON format
    AParamObj.LoadFromJSONFile(AFileName,
              ExtractFileName(AFileName),
              AIsEncrypt)
  else
  if AParamFileFormat = 2 then //Sqlite DB format
  begin
//      LHiMECSConfig.EngineParameter.LoadFromSqliteFile(FCurrentModbusFileName);
    if AParamObj.LoadFromSqliteFile4Secure(AFileName, AEPKind) = -1 then
      ShowMessage('Fail to load parameter from DB => "' + AFileName + '"');
  end;
end;

procedure TMainForm.LoadProjectInfo(AFileName: string; AIsEncrypt: Boolean; AIs2Inspector: Boolean);
var
  LStr: string;
  i,LNodeIndex,LLastIndex: integer;
  LPropertyItem: TNxPropertyItem;
  LComboItem: TNxComboBoxItem;
begin
  if not FileExists(AFileName) then
  begin
    DisplayMessage('Project information file: ' + AFileName + ' not found!',
                                                            mstFile,mtError);
    exit;
  end;

  SetCurrentDir(FApplicationPath);

  if not Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ProjectInfo) then
    FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ProjectInfo := TEquipInfo4EngMaker.Create(Self);
  
  FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ProjectInfo.LoadFromJSONFile(AFileName,ExtractFileName(AFileName),AIsEncrypt);

  if AIs2Inspector then
    SetProjectInfo2Inspector;
end;

procedure TMainForm.LoadProjectInfo1Click(Sender: TObject);
begin
  JvOpenDialog1.InitialDir := FApplicationPath;
  if JvOpenDialog1.Execute then
  begin
    if jvOpenDialog1.FileName <> '' then
    begin
      LoadProjectInfo(JvOpenDialog1.FileName, False);
    end;
  end;
end;

procedure TMainForm.LoadSearchTreeFromEngParam(ASearchTypes: TSensorTypes;
  ASearchText: string; ASortMethod: TParamSortMethod; ATV: TJvCheckTreeView=nil);
// code from https://forums.embarcadero.com/thread.jspa?messageID=84669
// modified as a method
// further modified to include case insensitive search and node selection
var
  LEngineParameter: TEngineParameter;
  ANode, NextNode: TTreeNode;
  ALevel, i, j, LParentRem: Integer;
  CurrStr, LStr: string;
  Keep, KeepParent, KeepAncestors: Boolean;
  LevelRem: Integer;
  LHiMECSConfig: THiMECSConfig;
begin
  if ATV = nil then
    ATV := EngModbusTV;

  ATV.Items.Clear;
  //ATV.Items.BeginUpdate;

  ASearchText:= Lowercase(ASearchText); // insures a case insensitive search
  FParamSearchMode:= (ASearchTypes <> []) or (Length(ASearchText) <> 0); // true searcxh box not empty

  if FParamSearchMode then
  begin
    try
      try
    //FSearchParamList에 HiMECSConfig.EngineParameter를 복사함
        InitSearchParamList('');

        // Search algorithm
        LevelRem:= 0; // 26 May 2011
        KeepParent:= false;

        for i := 0 to FSearchParamList.Count - 1 do
        begin
          LEngineParameter := TEngineParameter(FSearchParamList.Objects[i]);

          for j := LEngineParameter.EngineParameterCollect.Count - 1 downto 0 do // List is scanned from bottom to top
          begin
            if ASearchTypes <> [] then
            begin
              if not IsIncludeSensorTypesFromEngParamItem(LEngineParameter.EngineParameterCollect.Items[j], ASearchTypes) then
              begin
                LEngineParameter.EngineParameterCollect.Delete(j);
                Continue;
              end;
            end;

            if Length(ASearchText) = 0 then
              Continue;

            LStr := LEngineParameter.EngineParameterCollect.Items[j].Description;
            //CurrStr := GetBufStart(PChar(List[i]), ALevel);
            CurrStr := GetBufStart(LStr, ALevel);
            CurrStr:= Lowercase(CurrStr); // insures a case insensitive search

            if ALevel >= LevelRem then // node is a leaf
            begin
              Keep:= pos(ASearchText, CurrStr) > 0; // Search string found if true

              if Keep then
              begin
                KeepParent:= true; // parent branch must be kept
                KeepAncestors:= true;
                LParentRem:= ALevel - 1;
              end
              else
                LEngineParameter.EngineParameterCollect.Delete(j);
            end; // if ALevel = LevelRem

            if ALevel = LevelRem - 1 then // node is a branch
            begin
              KeepParent:= false;

              if KeepAncestors and (ALevel = LParentRem) then
              begin
                KeepParent:= true;
                LParentRem:= LParentRem - 1;
              end;

              if not KeepParent then
                LEngineParameter.EngineParameterCollect.Delete(j)
              else if ALevel = 0 then
                KeepAncestors:= False;
            end;

            LevelRem:= ALevel;
          end;//for j

          // Ready to build the treeview. If the "search string" is empty, all the
          // content of List will be used to fill the treeview. Otherwise, a filtered
          // list containing only the matched items and their parent will populate
          // the treeview.
          //ATV.Items.Clear;
          //ATV.Items.BeginUpdate;

          ANode := ATV.Items.AddChild(nil, FSearchParamList.Strings[i]);

          LoadParameter2TVBySortMtehod(ANode, TEngineParameter(FSearchParamList.Objects[i]), ASortMethod, ATV);

//          case ASortMethod of
//            smSystem: LoadParameter2SystemTV(ANode, TEngineParameter(FSearchParamList.Objects[i]));
//            smSensor: LoadParameter2SensorTV(ANode, TEngineParameter(FSearchParamList.Objects[i]));
//          end;//case

        end;//for i

      finally
        //ATV.Items.EndUpdate;
        if FParamSearchMode then
          ATV.FullExpand;
      end;
    except
      Invalidate;  // force repaint on exception
      raise;
    end;
  end//if FParamSearchMode
  else
  begin
    ATV.Items.Clear;

    for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
    begin
      LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;
      ANode := ATV.Items.AddChild(nil, FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName);

      LoadParameter2TVBySortMtehod(ANode, LHiMECSConfig.EngineParameter, FCurrentEngParamSortMethod, ATV);

//      case FCurrentEngParamSortMethod of
//        smSystem: LoadParameter2SystemTV(ANode, LHiMECSConfig.EngineParameter);
//        smSensor: LoadParameter2SensorTV(ANode, LHiMECSConfig.EngineParameter);
//      end;//case
    end;//
    //ATV.FullExpand;
  end;
end;

procedure TMainForm.LoadSearchTreeFromEngParam2(ASearchTypes: TSensorTypes;
  ASearchText: string; ASortMethod: TParamSortMethod; ATV: TJvCheckTreeView;
  AEPKind: TEngParamListItemKind);
var
  LEngineParameter: TEngineParameter;
  ANode, NextNode: TTreeNode;
  ALevel, i, j, LParentRem: Integer;
  CurrStr, LStr: string;
  Keep, KeepParent, KeepAncestors: Boolean;
  LevelRem: Integer;
//  LHiMECSConfig: THiMECSConfig;
  LEngParamItem: TEngineParameterItem;
begin
  if ATV = nil then
    ATV := EngModbusTV;

  ATV.Items.Clear;

  ASearchText:= Lowercase(ASearchText); // insures a case insensitive search
  FParamSearchMode:= (ASearchTypes <> []) or (Length(ASearchText) <> 0); // true searcxh box not empty

  if FParamSearchMode then
  begin
    try
      try
//        for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
//        begin
          i := FCOI;
          LEngineParameter := GetEngParamFromHiMECSConfigByEPKind(AEPKind, i);

//          LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;
//
//          if AEPKind = eplikModbus then
//            LEngineParameter := LHiMECSConfig.ModbusList
//          else
//          if AEPKind = eplikParameter then
//            LEngineParameter := LHiMECSConfig.EngineParameter;

          LevelRem:= 0;
          KeepParent:= false;

          for j := LEngineParameter.EngineParameterCollect.Count - 1 downto 0 do // List is scanned from bottom to top
          begin
            LEngParamItem := LEngineParameter.EngineParameterCollect.Items[j];

            if ASearchTypes <> [] then
            begin
              if not IsIncludeSensorTypesFromEngParamItem(LEngParamItem, ASearchTypes) then
              begin
                LEngParamItem.FIsHideItem := True;
                Continue;
              end;
            end;

            if Length(ASearchText) = 0 then
              Continue;

            LStr := LEngParamItem.Description;
            //CurrStr := GetBufStart(PChar(List[i]), ALevel);
            CurrStr := GetBufStart(LStr, ALevel);
            CurrStr:= Lowercase(CurrStr); // insures a case insensitive search

            if ALevel >= LevelRem then // node is a leaf
            begin
              Keep:= pos(ASearchText, CurrStr) > 0; // Search string found if true

              if Keep then
              begin
                KeepParent:= true; // parent branch must be kept
                KeepAncestors:= true;
                LParentRem:= ALevel - 1;
              end
              else
                LEngParamItem.FIsHideItem := True;
            end; // if ALevel = LevelRem

            if ALevel = LevelRem - 1 then // node is a branch
            begin
              KeepParent:= false;

              if KeepAncestors and (ALevel = LParentRem) then
              begin
                KeepParent:= true;
                LParentRem:= LParentRem - 1;
              end;

              if not KeepParent then
                LEngParamItem.FIsHideItem := True
              else if ALevel = 0 then
                KeepAncestors:= False;
            end;

            LevelRem:= ALevel;
          end;//for j
//        end;//for i

//        for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
//        begin
//          LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;
//          LEngineParameter := LHiMECSConfig.EngineParameter;

          ANode := ATV.Items.AddChild(nil, FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName);

          LoadParameter2TVBySortMtehod(ANode, LEngineParameter, ASortMethod, ATV);
//        end;//for i
      finally
        if FParamSearchMode then
          ATV.FullExpand;
      end;
    except
      Invalidate;  // force repaint on exception
      raise;
    end;
  end//if FParamSearchMode
  else
  begin
    ATV.Items.Clear;

//    for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
//    begin
      i := FCOI;
      LEngineParameter := GetEngParamFromHiMECSConfigByEPKind(AEPKind, i);

//      LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;

//      if AEPKind = eplikModbus then
//        LEngineParameter := LHiMECSConfig.ModbusList
//      else
//      if AEPKind = eplikParameter then
//        LEngineParameter := LHiMECSConfig.EngineParameter;

      ANode := ATV.Items.AddChild(nil, FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName);

      LoadParameter2TVBySortMtehod(ANode, LEngineParameter, FCurrentEngParamSortMethod, ATV);
//    end;//
    //ATV.FullExpand;
  end;
end;

procedure TMainForm.LoadSearchTreeFromEngParamSensorType(ASearchTypes: TSensorTypes;
  ASortMethod: TParamSortMethod; ATV: TJvCheckTreeView; AEPKind: TEngParamListItemKind);
var
  LSearchText: string;
begin
  ClearHideItemsOfEngParamFromProj(AEPKind);

  if AEPKind = eplikModbus then
    LSearchText := SrchTextEdit.Text
  else
  if AEPKind = eplikParameter then
    LSearchText := ParameterSrchEdit.Text;

  LoadSearchTreeFromEngParam2(ASearchTypes, LSearchText, ASortMethod, ATV, AEPKind);
end;

procedure TMainForm.LoadSearchTreeFromManualInfo(ASearchText: string;
  AManualKind : TManualItemKinds; ASortMethod: TManualSortMethod;
  ASearchSrc: TManualSearchSrc; ATV: TJvCheckTreeView);
var
  LHiMECSManualInfo: THiMECSManualInfo;
  ANode, NextNode: TTreeNode;
  ALevel, i, j, LParentRem: Integer;
  CurrStr, LStr: string;
  Keep, KeepParent, KeepAncestors: Boolean;
  LevelRem: Integer;
  LHiMECSConfig: THiMECSConfig;
  LSearchMode: Boolean;
  LSearchManualList: TStringList;
begin
  if ATV = nil then
    ATV := ManualCheckTV;

  ATV.Items.Clear;

  ASearchText:= Lowercase(ASearchText); // insures a case insensitive search
  LSearchMode:= Length(ASearchText) <> 0; // true searcxh box not empty

  if LSearchMode then
  begin
    try
      LSearchManualList := TStringList.Create;
      try
        for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
        begin
//          LHiMECSConfig.Assign(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig);
          LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;
          LHiMECSManualInfo := THiMECSManualInfo.Create(Self);
          LHiMECSManualInfo.Assign(LHiMECSConfig.ManualInfo);
          LSearchManualList.AddObject(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName, LHiMECSManualInfo);
        end;

        // Search algorithm
        LevelRem:= 0;
        KeepParent:= false;

        for i := 0 to LSearchManualList.Count - 1 do
        begin
          LHiMECSManualInfo := THiMECSManualInfo(LSearchManualList.Objects[i]);

          for j := LHiMECSManualInfo.OpManual.Count - 1 downto 0 do // List is scanned from bottom to top
          begin
            Caption := IntToStr(j);

            case ASearchSrc of
              mssSystem: LStr := LHiMECSManualInfo.OpManual.Items[j].SystemDesc_Eng;
              mssPart: LStr := LHiMECSManualInfo.OpManual.Items[j].PartDesc_Eng;
              mssSection: LStr := LHiMECSManualInfo.OpManual.Items[j].SectionNo;
            end;//case

            if LStr = '' then
            begin
              CurrStr:= '';
            end
            else
            begin
              CurrStr := GetBufStart(LStr, ALevel);
              CurrStr:= Lowercase(CurrStr); // insures a case insensitive search
            end;

            if ALevel >= LevelRem then // node is a leaf
            begin
              Keep:= pos(ASearchText, CurrStr) > 0; // Search string found if true

              if Keep then
              begin
                KeepParent:= true; // parent branch must be kept
                KeepAncestors:= true;
                LParentRem:= ALevel - 1;
              end
              else
                LHiMECSManualInfo.OpManual.Delete(j);
            end; // if ALevel = LevelRem

            if ALevel = LevelRem - 1 then // node is a branch
            begin
              KeepParent:= false;
              if KeepAncestors and (ALevel = LParentRem) then
              begin
                KeepParent:= true;
                LParentRem:= LParentRem - 1;
              end;

              if not KeepParent then
                LHiMECSManualInfo.OpManual.Delete(j)
              else if ALevel = 0 then
                KeepAncestors:= False;
            end;

            LevelRem:= ALevel;
          end;//for j

          ANode := ATV.Items.AddChild(nil, LSearchManualList.Strings[i]);

          case ASortMethod of
            msmMSNo: LoadManualInfo2MsNoTV(ANode, THiMECSManualInfo(LSearchManualList.Objects[i]), AManualKind, ATV);
            msmPlateNo: LoadManualInfo2PlateNoTV(ANode, THiMECSManualInfo(LSearchManualList.Objects[i]), AManualKind, ATV);
          end;//case
        end;//for i

      finally
        LSearchManualList.Free;

        if LSearchMode then
          ATV.FullExpand;
      end;
    except
      Invalidate;  // force repaint on exception
      raise;
    end;
  end//if FParamSearchMode
  else
  begin
    ATV.Items.Clear;

    for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
    begin
      LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;
      ANode := ATV.Items.AddChild(nil, FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName);

      case ASortMethod of
        msmMSNo: LoadManualInfo2MsNoTV(ANode, LHiMECSConfig.ManualInfo, AManualKind, ATV);
        msmPlateNo: LoadManualInfo2PlateNoTV(ANode, LHiMECSConfig.ManualInfo, AManualKind, ATV);
      end;//case
    end;//
  end;
end;

procedure TMainForm.LoadSearchTreeFromManualInfo2(ASearchText: string;
  AManualKind : TManualItemKinds; ASortMethod: TManualSortMethod; ASearchSrc: TManualSearchSrc; ATV: TJvCheckTreeView);
var
  i: integer;
  LSearchMode: Boolean;
  LHiMECSConfig: THiMECSConfig;
  LHiMECSManualInfo: THiMECSManualInfo;
  ANode, NextNode: TTreeNode;
begin
  if ATV = nil then
    ATV := ManualCheckTV;

  ATV.Items.Clear;

  ASearchText:= Lowercase(ASearchText); // insures a case insensitive search
  LSearchMode:= Length(ASearchText) <> 0; // true searcxh box not empty

  if LSearchMode then
  begin
    try
      try
//        for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
//        begin
          i := FCOI;
          LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;
          LHiMECSManualInfo := LHiMECSConfig.ManualInfo;

          SetHideItemsOfManualInfoBySearchTxt(LHiMECSManualInfo, mikOpManual, ASearchSrc, ASearchText);
          SetHideItemsOfManualInfoBySearchTxt(LHiMECSManualInfo, mikDrawings, ASearchSrc, ASearchText);

          ANode := ATV.Items.AddChild(nil, FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName);

          case ASortMethod of
            msmMSNo: LoadManualInfo2MsNoTV(ANode, LHiMECSManualInfo, AManualKind, ATV);
            msmPlateNo: LoadManualInfo2PlateNoTV(ANode, LHiMECSManualInfo, AManualKind, ATV);
          end;//case
//        end;//for i

      finally
        if LSearchMode then
          ATV.FullExpand;
      end;
    except
      Invalidate;  // force repaint on exception
      raise;
    end;
  end//if LSearchMode
  else
  begin
    ATV.Items.Clear;

//    for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
//    begin
      i := FCOI;
      LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSConfig;
      ANode := ATV.Items.AddChild(nil, FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].ProjectItemName);

      case ASortMethod of
        msmMSNo: LoadManualInfo2MsNoTV(ANode, LHiMECSConfig.ManualInfo, AManualKind, ATV);
        msmPlateNo: LoadManualInfo2PlateNoTV(ANode, LHiMECSConfig.ManualInfo, AManualKind, ATV);
      end;//case
//    end;//for i
  end;
end;

procedure TMainForm.LoadSearchTreeFromManualInfoSrc(ASearchSrc: TManualSearchSrc;
  AManualKind : TManualItemKinds; ASortMethod: TManualSortMethod;
  ATV: TJvCheckTreeView);
begin
  ClearHideItemsOfManualInfoFromProj;
  LoadSearchTreeFromManualInfo2(ManualSearchEdit.Text, AManualKind, ASortMethod, ASearchSrc, ATV);
end;

//AType = 1: MonitorListTile
//        2: CommListTile
procedure TMainForm.LoadTileConfig2Form(AConfigF: TTileConfigF; AType: integer);
begin
  if AType = 1 then
  begin
    AConfigF.RowNumEdit.Text := IntToStr(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSMonitor.TileRowNum);
    AConfigF.ColNumEdit.Text := IntToStr(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSMonitor.TileColNum);
  end
  else
  if AType = 2 then
  begin
    AConfigF.RowNumEdit.Text := IntToStr(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSAutoRun.TileRowNum);
    AConfigF.ColNumEdit.Text := IntToStr(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSAutoRun.TileColNum);
  end;
end;

//AType = 1: MonitorListTile
//        2: CommListTile
procedure TMainForm.LoadTileConfigForm2Collect(AConfigF: TTileConfigF; AType: integer);
begin
  if AType = 1 then
  begin
    FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSMonitor.TileRowNum := StrToIntDef(AConfigF.RowNumEdit.Text, 3);
    FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSMonitor.TileColNum := StrToIntDef(AConfigF.ColNumEdit.Text, 1);
  end
  else
  if AType = 2 then
  begin
    FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSAutoRun.TileRowNum := StrToIntDef(AConfigF.RowNumEdit.Text, 3);
    FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSAutoRun.TileColNum := StrToIntDef(AConfigF.ColNumEdit.Text, 1);
  end;
end;

procedure TMainForm.LoadMonitorTileFromFile(AFileName: string; AIsAppend: Boolean;
  AHiMECSMonitorList: THiMECSMonitorList);
var
  lTile : TAdvSmoothTile;
  i: integer;
begin
  SetCurrentDir(FApplicationPath);

  if not FileExists(AFileName) then
  begin
    ShowMessage('File not exist : '+ AFileName + ' (From .mlist)');
    exit;
  end;

  if not AIsAppend then
  begin
    AHiMECSMonitorList.MonitorListCollect.Clear;
    MonTileListFrame.tileList.Tiles.Clear;
  end;

  AHiMECSMonitorList.LoadFromJSONFile(AFileName);

  for i := 0 to AHiMECSMonitorList.MonitorListCollect.Count - 1 do
  begin
    lTile := MonTileListFrame.tileList.Tiles.Add;
    LoadMonitorVar2Form(lTile,AHiMECSMonitorList.MonitorListCollect.Items[i]);
  end; //for
end;

function TMainForm.LoadUserFileName(AFileName, AUserId, APasswd: string): Boolean;
var
  i: integer;
begin
  if not FileExists(AFileName) then
  begin
    ShowMessage('File: ' + AFileName + ' not exist! (From .himecs file''s UserFile)');
    exit;
  end;

  FHiMECSUser.LoadFromJSONFile(AFileName,
                        ExtractFileName(AFileName),
                        True);

//  if FHiMECSUser.UpdateWhenStart then
//  begin
//    if DoExternalUpdate(FHiMECSUSer.AutoUpdateFileName, True) then
//      exit;
//  end;

  for i := 0 to FHiMECSUser.HiMECSUserCollect.Count - 1 do
  begin
    if (FHiMECSUser.HiMECSUserCollect.Items[i].UserID = AUserId) and
      (FHiMECSUser.HiMECSUserCollect.Items[i].Password = APasswd) then
    begin
      FCurrentUserIndex := i;
      FCurrentUserLevel := FHiMECSUser.HiMECSUserCollect.Items[i].UserLevel;

      StatusBarPro1.Panels[2].Text := AUserId;
      StatusBarPro1.Panels[3].Text := UserLevel2String(FHiMECSUser.HiMECSUserCollect.Items[i].UserLevel);

      Result := True;
      Break;
    end
  end;//for

end;

procedure TMainForm.LoadMonitorVar2ConfigForm(AForm: TnewMonApp_Frm;
  AVar: THiMECSMonitorListItem);
begin
  with AForm do
  begin
    appTitle.Text := AVar.MonitorTitle;
    AutoRunCB.Checked := AVar.IsAutoLoad;
    appPath.Text := AVar.MonitorFileName;
    appDesc.Text := AVar.MonitorDesc;
    ProgNameEdit.Text := AVar.RunProgramName;
    RunParamEdit.Text := AVar.RunParameter;

    with GDIPPictureContainer1.Items do
    begin
      Clear;
      Add;
      if AVar.MonitorImage <> '' then
      begin
        Items[Count-1].Picture.LoadFromStream(MonTileListFrame.ConvertString2Stream(AVar.MonitorImage));
        Icon.Picture.Assign(Items[Count-1].Picture);
        Icon.Invalidate;
      end;
    end;
  end;
end;

procedure TMainForm.LoadMonitorVar2Form(ATile: TAdvSmoothTile;
  AVar: THiMECSMonitorListItem);
begin
  with ATile do
  begin
    Content.Text := AVar.MonitorTitle;
    Content.TextPosition := tpBottomCenter;

    if AVar.IsAutoLoad then
      StatusIndicator := 'Auto'
    else
      StatusIndicator := '';

    Content.Hint := AVar.MonitorFileName;
    DisplayName := AVar.MonitorDesc;
    ItemOject := AVar;

    if AVar.MonitorImage <> '' then
      Content.Image.LoadFromStream(MonTileListFrame.ConvertString2Stream(AVar.MonitorImage));
  end;

  TileConfigChange(1);
end;

procedure TMainForm.LoadWatchListAll;
var
  LStrLst: TStringList;
  LProgName, LParam: string;
  i: integer;
begin
  //LStrLst := TStringList.Create;
  try
    LStrLst := GetFileListFromFolder('.\WatchList\', '*.*', false);
    for i := 0 to LStrLst.Count - 1 do
    begin
      if not CheckWatchListOfSummary(LStrLst.Strings[i]) then
        Continue;

      LProgName := ExtractFileName(LStrLst.Strings[i]);
      if Pos('_', LProgName) > 0 then
        continue;
      //FEngineParameter.LoadFromFile(LStrLst.Strings[i]);
      //LProgName := '.\Applications\' + FEngineParameter.ExeName;
      LProgName := System.Copy(LProgName,1,1);
      if LProgName = '1' then
        LProgName := '.\Applications\' + HiMECSWatchName2
      else
      if LProgName = '2' then
        LProgName := '.\Applications\' + HiMECSWatchSaveName;

      LParam := '/p' + ExtractFilename(LStrLst.Strings[i]);
      ExecLaunchList(LProgName, LParam);//, FMonitorHandles);
    end;//for

  finally
    LStrLst.Free;
  end;
end;

procedure TMainForm.LoginClick;
begin
  Init(False);
end;

function TMainForm.LoginProcess(AAutoLogin: Boolean = false;
  AUserId: string = ''; APasswd: string = ''): Boolean;
var
  LUserID, LPasswd, LUserFileName: string;
begin
  Result := False;

  if Assigned(FHiMECSUser) then
    FHiMECSUser.HiMECSUserCollect.Clear
  else
    FHiMECSUser := THiMECSUser.Create(nil);

  if FUserFileName = '' then
    FUserFileName := '.\config\'+DefaultUserFileName;

  if AAutoLogin then
  begin
    Result := LoadUserFileName(FUserFileName, AUserId, APasswd);
    exit;
  end;

  while true do
  begin
    if TFrmLogin.Execute(LUserID, LPasswd, LUserFileName) = mrOK then
    begin
      if LUserFileName <> '' then
        FUserFileName := LUserFileName;

      Result := LoadUserFileName(FUserFileName, LUserID, LPasswd);

      if Result then
      begin
        break;
      end
      else
      begin
        ShowMessage('Incorrect UserID or Password.' + #13#10#13#10 + 'Try input again.');
        continue;
      end;
    end//if
    else
      break;
  end;//while
end;

procedure TMainForm.LogOutProcess;
var
  i: integer;
begin
  LoadMenuFromFile(DefaultMenuFileNameOnLogOut, True);
  DestroyProc;

  for i := 1 to 6 do
    EngineInfoInspector.Items[i].Clear;

  StatusBarPro1.Panels[2].Text := 'Log out';
  StatusBarPro1.Panels[3].Text := '';
  EngModbusTV.Items.Clear;
  EngineInfoInspector.PopupMenu := nil;
  EngModbusTV.PopupMenu := nil;
  MonTileListFrame.tileList.Tiles.Clear;
  CommTileListFrame.tileList.Tiles.Clear;
  //Init(False);
end;

procedure TMainForm.MDIClientProc(var Msg: TMessage);
var
  rc: TRect;
begin
  Msg.Result := CallWindowProc(FOldClient, ClientHandle, Msg.Msg, Msg.WParam, Msg.LParam);

  if (Msg.Msg = WM_SIZE) then
  begin
    if GetWindowRect(ClientHandle, rc) then
    begin
      //MDIPanel.Left := (RectWidth(rc) - MDIPanel.Width) div 2;
      //MDIPanel.Top := (RectHeight(rc) - MDIPanel.Height) div 2;
      //MDIPanel.Invalidate;
    end;
  end;
end;

procedure TMainForm.MenuItem1Click(Sender: TObject);
begin
  MenuItem1.Checked := not MenuItem1.Checked;
  MDITabSet.Visible := MenuItem1.Checked;
end;

procedure TMainForm.MenuItem2Click(Sender: TObject);
begin
  ProjectInfoInspector.CollapseAll;
end;

procedure TMainForm.MenuItem5Click(Sender: TObject);
begin
  ProjectInfoInspector.ExpandAll;
end;

procedure TMainForm.MenuItem7Click(Sender: TObject);
begin
  MonTileListFrame.SaveTile2File(TpjhBase(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSMonitor));
end;

{
procedure TMainForm.MoveEngineParameterItemRecord(var ASourceRecord: TEngineParameterItemRecord;
  AEPItemRecord: TEngineParameterItem);
begin
  ASourceRecord.FLevelIndex := AEPItemRecord.LevelIndex;
  ASourceRecord.FNodeIndex := AEPItemRecord.NodeIndex;
  ASourceRecord.FAbsoluteIndex := AEPItemRecord.AbsoluteIndex;
  ASourceRecord.FMaxValue := AEPItemRecord.MaxValue;
  ASourceRecord.FContact := AEPItemRecord.Contact;
  ASourceRecord.FBlockNo := AEPItemRecord.BlockNo;

  ASourceRecord.FSharedName := AEPItemRecord.SharedName;
  ASourceRecord.FTagName := AEPItemRecord.Tagname;
  ASourceRecord.FDescription := AEPItemRecord.Description;
  ASourceRecord.FAddress := AEPItemRecord.Address;
  ASourceRecord.FFCode := AEPItemRecord.FCode;
  ASourceRecord.FUnit := AEPItemRecord.FFUnit;
  ASourceRecord.FMinMaxType := AEPItemRecord.MinMaxType;
  ASourceRecord.FAlarm := AEPItemRecord.Alarm;
  ASourceRecord.FRadixPosition := AEPItemRecord.RadixPosition;

  ASourceRecord.FSensorType := AEPItemRecord.SensorType;
  ASourceRecord.FParameterCatetory := AEPItemRecord.ParameterCatetory;
  ASourceRecord.FParameterType := AEPItemRecord.ParameterType;
  ASourceRecord.FParameterSource := AEPItemRecord.ParameterSource;

  ASourceRecord.FMinAlarmEnable := AEPItemRecord.MinAlarmEnable;
  ASourceRecord.FMaxAlarmEnable := AEPItemRecord.MaxAlarmEnable;
  ASourceRecord.FMinFaultEnable := AEPItemRecord.MinFaultEnable;
  ASourceRecord.FMaxFaultEnable := AEPItemRecord.MaxFaultEnable;

  ASourceRecord.FMinAlarmValue := AEPItemRecord.MinAlarmValue;
  ASourceRecord.FMaxAlarmValue := AEPItemRecord.MaxAlarmValue;
  ASourceRecord.FMinFaultValue := AEPItemRecord.MinFaultValue;
  ASourceRecord.FMaxFaultValue := AEPItemRecord.MaxFaultValue;

  ASourceRecord.FMinAlarmColor := AEPItemRecord.MinAlarmColor;
  ASourceRecord.FMaxAlarmColor := AEPItemRecord.MaxAlarmColor;
  ASourceRecord.FMinFaultColor := AEPItemRecord.MinFaultColor;
  ASourceRecord.FMaxFaultColor := AEPItemRecord.MaxFaultColor;

  ASourceRecord.FMinAlarmBlink := AEPItemRecord.MinAlarmBlink;
  ASourceRecord.FMaxAlarmBlink := AEPItemRecord.MaxAlarmBlink;
  ASourceRecord.FMinFaultBlink := AEPItemRecord.MinFaultBlink;
  ASourceRecord.FMaxFaultBlink := AEPItemRecord.MaxFaultBlink;

  ASourceRecord.FMinAlarmSoundEnable := AEPItemRecord.MinAlarmSoundEnable;
  ASourceRecord.FMaxAlarmSoundEnable := AEPItemRecord.MaxAlarmSoundEnable;
  ASourceRecord.FMinFaultSoundEnable := AEPItemRecord.MinFaultSoundEnable;
  ASourceRecord.FMaxFaultSoundEnable := AEPItemRecord.MaxFaultSoundEnable;

  ASourceRecord.FMinAlarmSoundFilename := AEPItemRecord.MinAlarmSoundFilename;
  ASourceRecord.FMaxAlarmSoundFilename := AEPItemRecord.MaxAlarmSoundFilename;
  ASourceRecord.FMinFaultSoundFilename := AEPItemRecord.MinFaultSoundFilename;
  ASourceRecord.FMaxFaultSoundFilename := AEPItemRecord.MaxFaultSoundFilename;

  ASourceRecord.FAllowUserLevelWatchList := FCurrentUserLevel;

  ASourceRecord.FIsDisplayTrend := AEPItemRecord.IsDisplayTrend;
  ASourceRecord.FIsDisplaySimple := AEPItemRecord.IsDisplaySimple;
  ASourceRecord.FTrendChannelIndex := AEPItemRecord.TrendChannelIndex;
  ASourceRecord.FPlotXValue := AEPItemRecord.PlotXValue;
  ASourceRecord.FMinValue := AEPItemRecord.MinValue;
  ASourceRecord.FMinValue_Real := AEPItemRecord.MinValue_Real;
  ASourceRecord.FYAxesMinValue := AEPItemRecord.YAxesMinValue;
  ASourceRecord.FYAxesSpanValue := AEPItemRecord.YAxesSpanValue;

  ASourceRecord.FCurrentSelectedProjectFileName := FCurrentSelectedProjectFile.ProjectFileName;
end;
}

procedure TMainForm.ParamDropTargetDragOver(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  TreeNode: TTreeNode;
begin
  TreeNode := ParameterTV.GetNodeAt(APoint.X, APoint.Y);

  if (TreeNode <> nil) then
  begin
    // Select the item to provide visual feedback
    TreeNode.Selected := True;
    // Override the default drop effect if you need to:
    //Effect := DROPEFFECT_COPY;
  end else
    // Reject the drop
    Effect := DROPEFFECT_NONE;
end;

procedure TMainForm.ParamDropTargetDrop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
var
  DFP: RDragFormatParam;
  TreeNode, TreeNode2: TTreeNode;
  LStr, LStr2: string;
  Li: integer;
  LHiMECSConfig: THiMECSConfig;
begin
  TreeNode := ParameterTV.GetNodeAt(APoint.X, APoint.Y);

  if (TreeNode <> nil) then
  begin
    // Determine if we got our custom format.
    if (FParamDragFormatTarget.HasData) then
    begin
      LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
      // Extract the dropped data into our custom struct.
      FParamDragFormatTarget.GetDataHere(DFP, sizeof(DFP));
      LStr2 := DFP.FCollectIndex;

      while True do
      begin
        LStr := strToken(LStr2,',');
        if LStr = '' then
          break;
        Li := StrToInt(LStr);
        TreeNode2 := ParameterTV.Items.AddChild(TreeNode,
          LHiMECSConfig.EngineParameter.EngineParameterCollect.Items[Li].Description);
                //FEngineParameter.EngineParameterCollect.Items[Li].Description);
      end;
      //ShowMessage(DFP.FCollectIndex);
      // Display the data.
    end
    else
      ShowMessage(TDropTextTarget(Sender).Text);
  end;
end;

procedure TMainForm.ParameterFilterCheckCBCloseUp(Sender: TObject);
var
  LSensorTypes: TSensorTypes;
begin
  if SensorTypeSelectChanged4Parameter(LSensorTypes) then
    LoadSearchTreeFromEngParamSensorType(LSensorTypes, FCurrentEngParamSortMethod, ParameterTV, eplikParameter);
end;

procedure TMainForm.ParameterFilterCheckClick(Sender: TObject);
begin
  ParameterFilterCheckCB.Enabled := ParameterFilterCheck.Checked;
  ParameterFilterClearBtn.Enabled := ParameterFilterCheck.Checked;
end;

procedure TMainForm.ParameterFilterClearBtnClick(Sender: TObject);
begin
  ParameterFilterCheckcb.SetAll(False);
  ParameterFilterCheckcbCloseUp(nil);
end;

procedure TMainForm.ParameterSrchEditChange(Sender: TObject);
begin
  FPJHTimerPool.AddOneShot(OnParamChange,500);
end;

procedure TMainForm.ParameterTVDblClick(Sender: TObject);
var
  LNode: TTreeNode;
  LForm: TForm;
  i,j: integer;
begin
  LNode := ParameterTV.GetNodeAt( FMouseClickParamTV_X, FMouseClickParamTV_Y );

  if FControlPressed then
  begin
    //if LNode.AbsoluteIndex = 0 then
    if Assigned(LNode) then
    begin
      LForm := CreateOrShowMDIChild(TFormParamList);
      if Assigned(LForm) then
      begin
        Add2MultiNode(LNode,False,False,-1,LForm);
      end;
    end
    else
    if Assigned(LNode) then
    begin
      if TObject(LNode.Data) is TEngineParameterItem then
      begin
        LForm := CreateOrShowMDIChild(TFormParamList);
        if Assigned(LForm) then
        begin
          ParameterItem2ParamList(LNode,LForm);
        end;
      end;
    end;

    FControlPressed := False;
  end
  else
    ShowPropertyForm(ParameterTV, True);
end;

procedure TMainForm.ParameterTVKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LStr: string;
begin
  case Key of
    vk_delete: DeleteItem1Click(ParameterTV);
    vk_control: FControlPressed := True;
  end;

  if (ssCtrl in Shift) and (Key = Ord('C')) then
  begin
    LStr := ParameterTV.Selected.Text;
    ClipBoard.AsText := TrimLeft(strTokenRev(LStr, ':'));
  end;
end;

procedure TMainForm.ParameterTVKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_delete: DeleteItem1Click(ParameterTV);
    vk_control: FControlPressed := False;
  end;
end;

procedure TMainForm.ParameterTVMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  LNode, LRootNode: TTreeNode;
  LEngineParameterItem: TEngineParameterItem;
  LEPD: TEngineParameter_DragDrop;
begin
  FMouseClickParamTV_X := X;
  FMouseClickParamTV_Y := Y;

  LNode := ParameterTV.GetNodeAt( FMouseClickParamTV_Y, FMouseClickParamTV_Y );

  if Assigned(LNode) then
  begin
    LRootNode := GetRootNode(LNode);

    if Assigned(LRootNode) then
      FCOI := LRootNode.Index;

    FCurrentNode := LNode;

    if (DragDetectPlus(TWinControl(Sender).Handle, Point(X,Y))) then
    begin
      if TObject(LNode.Data) is TEngineParameterItem then
      begin
        if ParameterTV.SelectionCount = 1 then
        begin
          FParameterDragMode := True;

          LEngineParameterItem := TEngineParameterItem(LNode.Data);
          //LEngineParameterItem.AssignTo(FEngineParameterItemRecord);
          LEngineParameterItem.AssignTo(LEPD.FEPItem);
          LEPD.FEPItem.FFExcelRange := FApplicationPath + FCurrentModbusFileName;
          //MoveMatrixData2ItemRecord(FEngineParameterItemRecord, LEngineParameterItem);
          MoveMatrixData2ItemRecord(LEPD.FEPItem, LEngineParameterItem);

          // Transfer the structure to the drop source data object and execute the drag.
          //SetLength(LDynArray, 1);//Length(FEngineParameterItemRecord));
          //Move(FEngineParameterItemRecord, LDynArray[Low(LDynArray)], SizeOf(FEngineParameterItemRecord));
          LEPD.FDragDataType := dddtSingleRecord;
          LEPD.FShiftState := Shift;//FKeyBdShiftState;
          FEngParamSource.EPD := LEPD;
          //FEngParamSource.DragDataType := dddtSingleRecord;
          EngParamSource.Execute;
        end
        else
        begin  //Multi Select 후 Shift 누른 상태에서 Drag하면 실행되는 루틴
          FParameterDragMode := True;
          LEPD.FDragDataType := dddtMultiRecord;
          LEPD.FShiftState := Shift;//FKeyBdShiftState;
          LEPD.FSourceHandle := Handle;
          FEngParamSource.EPD := LEPD;
          EngParamSource.Execute;
        end;
      end
      else
      begin //선택한 노드의 하위 노드 존재 시 실행되는 루틴
        //FArrayEngineParameterItemRecord에 데이터 저장
        //Add2MultiNode(LNode, False);
        //Clipbrd에 데이터 복사
        FParameterDragMode := True;
        LEPD.FSourceHandle := Handle;
        LEPD.FShiftState := Shift;//FKeyBdShiftState;
        LEPD.FDragDataType := dddtMultiRecord;
        FEngParamSource.EPD := LEPD;
//        FCurrentNode := LNode;
        //Caption := IntToStr(Handle);
        EngParamSource.Execute;
      end;
    end
    else
      FParameterDragMode := False;
  end;

  if ssCtrl in Shift then
    FControlPressed := False;
end;

procedure TMainForm.MonTileListFrametileListMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FSelectedTile := MonTileListFrame.TileList;
end;

procedure TMainForm.MonTileListFrametileListTileDblClick(Sender: TObject;
  ATile: TAdvSmoothTile; State: TTileState);
begin
  ShowWindowFromSelectedMonTile(SW_RESTORE);
end;

procedure TMainForm.MoveMatrixData2ItemRecord(
  var ARecord: TEngineParameterItemRecord; AEPItem: TEngineParameterItem);
var
  LIdx: integer;
  LHiMECSConfig: THiMECSConfig;
begin
  if (AEPItem.ParameterSource <> psECS_AVAT2 ) and (AEPItem.ParameterType in TMatrixTypes) then
  begin
    LIdx := AEPItem.MatrixItemIndex;
    LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
    LHiMECSConfig.EngineParameter.MatrixCollect.Items[LIdx].AssignTo(ARecord);
  end;
end;

//TreeView의 노드들 이동시킴(서브 노드 포함)
procedure TMainForm.MoveNode(ATreeView: TTreeView; ATargetNode, ASourceNode: TTreeNode);
var
  LNode: TTreeNode;
  i: integer;
begin
  With ATreeView do
  begin
    LNode := Items.AddChild(ATargetNode, ASourceNode.Text);
    for i := 0 to ASourceNode.Count - 1 do
    begin
      MoveNode(ATreeView, LNode, ASourceNode.Item[i]);
    end;
  end;
end;

procedure TMainForm.SrchTextEditChange(Sender: TObject);
begin
  FPJHTimerPool.AddOneShot(OnModbusChange,500);
end;

procedure TMainForm.ManualSearchEditChange(Sender: TObject);
begin
  FPJHTimerPool.AddOneShot(OnManualInfoChange,500);
end;

procedure TMainForm.ManualSearchEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    OnManualInfoChange(Sender, 0, 0, 0);
end;

procedure TMainForm.MaxmizeAll1Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to MDIChildCount - 1 do
    MDIChildren[i].WindowState := wsMaximized;
end;

procedure TMainForm.EditProcessKillList;
var
  LForm: TKillProcessListF;
  LFileName: string;
  i, j: integer;
begin
  //LForm := CreateOrShowMDIChild(TKillProcessListF);
  LForm := TKillProcessListF.Create(Self);

  if Assigned(LForm) then
  begin
    try
      for i := 0 to FKillProcessList.KillProcessListCollect.Count - 1 do
      begin
        j := TKillProcessListF(LForm).ProcessLB.Items.Add(
          FKillProcessList.KillProcessListCollect.Items[i].ProcessName);
        TKillProcessListF(LForm).ProcessLB.Checked[j] :=
          FKillProcessList.KillProcessListCollect.Items[i].KillEnable;
      end;

      if LForm.ShowModal = mrOK then
      begin
        if TKillProcessListF(LForm).ProcessLB.Items.Count > 0 then
          FKillProcessList.KillProcessListCollect.Clear;

        for i := 0 to TKillProcessListF(LForm).ProcessLB.Items.Count - 1 do
        begin
          with FKillProcessList.KillProcessListCollect.Add do
          begin
            ProcessName := TKillProcessListF(LForm).ProcessLB.Items[i];
            KillEnable := TKillProcessListF(LForm).ProcessLB.Checked[i];
          end;
        end;//for

        if FKillProcessList.KillProcListFileName <> '' then
          FKillProcessList.SaveToJSONFile(FKillProcessList.KillProcListFileName);
      end;

    finally
      LForm.Free;
    end;
  end;
end;

procedure TMainForm.EngBtn1Click(Sender: TObject);
var
  LEngBtn: TCyBitBtn;
begin
  LEngBtn := Sender as TCyBitBtn;

  DisableAllEngCountBtn();
  SetEngCountBtnColor(LEngBtn, clLime);
  SetEngineData2NavBar(0);
end;

procedure TMainForm.EngBtn2Click(Sender: TObject);
var
  LEngBtn: TCyBitBtn;
begin
  LEngBtn := Sender as TCyBitBtn;

  DisableAllEngCountBtn();
  SetEngCountBtnColor(LEngBtn, clLime);
  SetEngineData2NavBar(1);
end;

procedure TMainForm.EngBtn3Click(Sender: TObject);
var
  LEngBtn: TCyBitBtn;
begin
  LEngBtn := Sender as TCyBitBtn;

  DisableAllEngCountBtn();
  SetEngCountBtnColor(LEngBtn, clLime);
  SetEngineData2NavBar(2);
end;

procedure TMainForm.EngBtn4Click(Sender: TObject);
var
  LEngBtn: TCyBitBtn;
begin
  LEngBtn := Sender as TCyBitBtn;

  DisableAllEngCountBtn();
  SetEngCountBtnColor(LEngBtn, clLime);
  SetEngineData2NavBar(3);
end;

procedure TMainForm.EngineInfoInspectorAfterEdit(Sender: TObject;
  Item: TNxPropertyItem);
var
  LStr: string;
  LHiMECSConfig: THiMECSConfig;
begin
  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;

  if Item.Name = 'CylinderCount' then
    LHiMECSConfig.EngineInfo.CylinderCount := Item.AsInteger
  else
  if Item.Name = 'Bore' then
    LHiMECSConfig.EngineInfo.Bore := Item.AsInteger
  else
  if Item.Name = 'Stroke' then
    LHiMECSConfig.EngineInfo.Stroke := Item.AsInteger
  else
  if Item.Name = 'FuelType' then
    LHiMECSConfig.EngineInfo.FuelType := String2FuelType(Item.AsString)
  else
  if Item.Name = 'CylinderConfiguration' then
    LHiMECSConfig.EngineInfo.CylinderConfiguration := String2CylinderConfiguration(Item.AsString);

  LStr := GetEngineType(FCOI);
  EngineInfoInspector.items.ItemByName['EngineType'].AsString := LStr;

  EngineInfoInspector.Invalidate;
end;

procedure TMainForm.EngineInfoInspectorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
    EngineInfoInspector.Invalidate;

  FEgg.CheckKeydown(Key, Shift);
end;

procedure TMainForm.EngineInfoInspectorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  EngineInfoInspector.Invalidate;
end;

procedure TMainForm.EngineInfoInspectorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  EngineInfoInspector.Invalidate;
end;

procedure TMainForm.EngineInfoInspectorMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
//  EngineInfoInspector.Invalidate;
end;

procedure TMainForm.NxButtonItemButtonClick(Sender: TNxPropertyItem);
var
  i: integer;
begin
  if Sender.Caption = 'Generator' then
  begin
    CreateOrShowChildFormFromBpl('GeneratorInfo',i);
  end
  else
  if Sender.Caption = 'Starting box & terminal box' then
  begin
    CreateOrShowChildFormFromBpl('DFEngineECUInfo',i);
  end
  else
    ShowMessage('No additional information!');
end;

procedure TMainForm.OnEggDelRegInfo(msg: string);
begin
  if DeleteRegisterInfoFromRegistry then
    ShowMessage(msg);
end;

procedure TMainForm.OnEggShowRegInfo(msg: string);
begin
  FormAbout1.LicenseText.Text := GetRegisterInfoFromRegistry;
  About1Click(nil);
end;

procedure TMainForm.OnExecuteRequest(const Request, Response: IIPCData);
var
  Command: AnsiString;
begin
  Command := Request.Data.ReadUTF8String('Command');
  //ListBox1.Items.Add(Format('%s Request Recieved (Sent at: %s)', [Command, Request.ID]));

  Response.Data.WriteDateTime('TDateTime', Now);
  Response.Data.WriteInteger('Integer', 5);
  Response.Data.WriteReal('Real', 5.33);
  Response.Data.WriteUTF8String('String', 'to je testni string');
  //Caption := Format('%d requests processed', [FRequestCount]);
end;

procedure TMainForm.OnManualInfoChange(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
var
  LManualSearchSrc: TManualSearchSrc;
begin
//  LoadSearchTreeFromManualInfo(ManualSearchEdit.Text);
  LManualSearchSrc := GetManualSearchSrcFromForm;
  LoadSearchTreeFromManualInfoSrc(LManualSearchSrc, [mikOpManual]);
end;

procedure TMainForm.OnModbusChange(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
var
  LSensorTypes: TSensorTypes;
begin
  SensorTypeSelectChanged4Modbus(LSensorTypes);
  LoadSearchTreeFromEngParamSensorType(LSensorTypes, FCurrentEngParamSortMethod, EngModbusTV, eplikModbus);
end;

procedure TMainForm.OnProcessKill(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
  ExecProcessKill;
end;

procedure TMainForm.OnParamChange(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
var
  LSensorTypes: TSensorTypes;
begin
  SensorTypeSelectChanged4Parameter(LSensorTypes);
  LoadSearchTreeFromEngParamSensorType(LSensorTypes, FCurrentEngParamSortMethod, ParameterTV,eplikParameter);
end;

procedure TMainForm.OpenProject;
begin
  if not Assigned(FMenuBase) then
    FMenuBase := TMenuBase.Create(Self);

  ProcessSelectProject(False);
//    FIsProjectClosed := False;
end;

procedure TMainForm.Options1Click(Sender: TObject);
begin
  SetConfigData(Sender);
end;

//Menu file에서 Bpl 파일 이름을 가져온 후 메뉴 클릭시 실행 됨
procedure TMainForm.PackageLoadFromMenu;
begin

end;

procedure TMainForm.PackageLoad_Exe;
var
  i: integer;
  LStr: string;
  LHiMECSConfig: THiMECSConfig;
begin
  SetCurrentDir(FApplicationPath);
  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
  LStr := LHiMECSConfig.ExesPath;

  FHiMECSExes.ExeCollect.Clear;
  FHiMECSExes.LoadFromJSONFile(LStr + DefaultExesFileName,DefaultExesFileName,True);

  for i := 0 to FHiMECSExes.ExeCollect.Count - 1 do
    AddExeToList(FHiMECSExes.ExeCollect.Items[i].ExeName);
end;

procedure TMainForm.PackageLoad_MDIChild;
var
  i: integer;
  LStr, LFuncName, LPath: string;
  LHiMECSConfig: THiMECSConfig;
begin
  SetCurrentDir(FApplicationPath);
  LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
  LStr := IncludeTrailingPathDelimiter(LHiMECSConfig.ConfigPath);

  if FileExists(LStr+DefaultFormsFileName) then
  begin
    FHiMECSForms.PackageCollect.Clear;
    FHiMECSForms.LoadFromJSONFile(LStr+DefaultFormsFileName,DefaultFormsFileName,True);

    LPath := IncludeTrailingPathDelimiter(LHiMECSConfig.HiMECSFormPath);
//    LPath := LPath.replace('.\', FApplicationPath);

    for i := 0 to FHiMECSForms.PackageCollect.Count - 1 do
    begin               //FHiMECSConfig.HiMECSFormPath는 PackageName에 포함되어 있음
      FHiMECSForms.PackageCollect.Items[i].FPackageHandle :=
        LoadPackage(LPath+FHiMECSForms.PackageCollect.Items[i].PackageName);

      if FHiMECSForms.PackageCollect.Items[i].FPackageHandle <> 0 then
      begin
        try
          LStr := FHiMECSForms.PackageCollect.Items[i].CreateFuncName;

          while True do
          begin
            LFuncName := strToken(LStr, ';');

            if LFuncName = '' then
              Break;

            SetLength(FHiMECSForms.PackageCollect.Items[i].FCreateChildFromBPL,
              Length(FHiMECSForms.PackageCollect.Items[i].FCreateChildFromBPL) + 1);
            @FHiMECSForms.PackageCollect.Items[i].FCreateChildFromBPL[High(FHiMECSForms.PackageCollect.Items[i].FCreateChildFromBPL)] :=
              GetProcAddress(FHiMECSForms.PackageCollect.Items[i].FPackageHandle, PWideChar(LFuncName));

            SetLength(FHiMECSForms.PackageCollect.Items[i].FCreateFuncNameAry,
              Length(FHiMECSForms.PackageCollect.Items[i].FCreateFuncNameAry) + 1);
            FHiMECSForms.PackageCollect.Items[i].FCreateFuncNameAry[High(FHiMECSForms.PackageCollect.Items[i].FCreateFuncNameAry)] := LFuncName;
          end;
        except
          ShowMessage('Package Create function: '+ FHiMECSForms.PackageCollect.Items[i].CreateFuncName +
            ' not found!');
        end;
      end;
    end;
  end;

end;

procedure TMainForm.PanelMsgProc(var Msg: TMessage);
begin
  if (Msg.Msg = WM_CHILDACTIVATE) then
    //MDIPanel.SendToBack;

  FOldPanelProc(Msg);
end;

procedure TMainForm.ParameterItem2ParamList(ANode: TTreeNode; AForm: TForm);
var
  i,j: integer;
  LMatrixItem: TMatrixItem;
  LHiMECSConfig: THiMECSConfig;
begin
  TEngineParameterItem(ANode.Data).AssignTo(FEngineParameterItemRecord);
  //TFormParamList(AForm).Parameter2Grid(FEngineParameterItemRecord);
  j := TFormParamList(AForm).CreateIPCMonitor(FEngineParameterItemRecord, False);

  if j = -1 then
    j := TFormParamList(AForm).IPCMonitorAll1.FEngineParameter.EngineParameterCollect.Count - 1;

  if TEngineParameterItem(ANode.Data).IsMatrixData then
  begin
    LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
    i := TEngineParameterItem(ANode.Data).MatrixItemIndex;
    LMatrixItem := LHiMECSConfig.EngineParameter.MatrixCollect.Items[i];
    i := TFormParamList(AForm).AssignMatrixItem(LMatrixItem);
    TFormParamList(AForm).SetNodeIndex(j,i);
  end;
end;

procedure TMainForm.EngModbusFilterCheckClick(Sender: TObject);
begin
  ModbusFilterCheckcb.Enabled := EngModbusFilterCheck.Checked;
  ModbusFilterClearBtn.Enabled := EngModbusFilterCheck.Checked;
end;

procedure TMainForm.PartRBClick(Sender: TObject);
begin
  if PartRB.Checked then
    FCurrentManualSearchSrc := mssPart;
end;

procedure TMainForm.ProcessCmdFromCommServer(const AJsonEventData: string);
var
  LCommandRec: TCommandRec;
  LRespondRec: TRespondRec;
  LTVTxt, LJson: string;
begin
  LJson := FJHP_gpShM.RecvDataFromgpSM;
  RecordLoadJson(LCommandRec, LJson, TypeInfo(TCommandRec));

  if LCommandRec.Cmd = '' then
    exit
  else
  if LCommandRec.Cmd = HiMECS_Cmd_GetManList then
  begin
    GetNodeStrFromTreeView(ManualCheckTV, LCommandRec, LTVTxt);
  end
  else
  if LCommandRec.Cmd = HiMECS_Cmd_GetSensorListWithFilter then
  begin
    GetNodeStrFromTreeView(EngModbusTV, LCommandRec, LTVTxt);
  end;

  LRespondRec.Cmd := LCommandRec.Cmd;
  LRespondRec.Respond := LTVTxt;
  LJson := RecordSaveJson(LRespondRec, TypeInfo(TRespondRec));
//  ShowMessage(LJson);

  FJHP_gpShM.SendData2gpSM(HiMECS_gpEventName4HiMECS, LJson);
end;

function TMainForm.ProcessCommandLineParameter(var AUserID, APasswd, APrjFileName: string;
  var AIsPreventOnVM, AIsIgnoreMachineID: Boolean):Boolean;
var
  i,j: integer;
  LHiMECSUser: THiMECSUser;
begin
  if Assigned(g_HiMECSCommandLine) then
    CommandLineParser.Parse(g_HiMECSCommandLine);

    if FileExists(g_HiMECSCommandLine.UserFileName) then
    begin
      try
        LHiMECSUser := THiMECSUser.Create(nil);
        LHiMECSUser.LoadFromJSONFile(g_HiMECSCommandLine.UserFileName,
                                  ExtractFileName(g_HiMECSCommandLine.UserFileName),
                                  True);

        if LHiMECSUser.HiMECSUserCollect.Count > 0 then
        begin
          AUserID := LHiMECSUser.HiMECSUserCollect.Items[0].UserID;
          APasswd := LHiMECSUser.HiMECSUserCollect.Items[0].Password;
          AIsPreventOnVM := LHiMECSUser.HiMECSUserCollect.Items[0].IsPreventOnVM;
          AIsIgnoreMachineID := LHiMECSUser.HiMECSUserCollect.Items[0].IsIgnoreMachineID;
        end;
      finally
        LHiMECSUser.HiMECSUserCollect.Clear;
        FreeAndNil(LHiMECSUser);
      end;
    end;

    if FileExists(g_HiMECSCommandLine.ProjectFileName) then
    begin
      APrjFileName := g_HiMECSCommandLine.ProjectFileName;
    end
    else
      ShowMessage('Project File from param does not exists: ' + #13#10 +
        g_HiMECSCommandLine.ProjectFileName);

//  for i := 1 to ParamCount do
//  begin
//    LStr := ParamStr(i);
//    j := Pos('/UF', UpperCase(LStr)); //User File Parameter(.id)
//
//    if j > 0 then  //UF 제거
//    begin
//      LStr := Copy(LStr, j+3, Length(LStr)-j-1);
//
//      if FileExists(LStr) then
//      begin
//        try
//          LHiMECSUser := THiMECSUser.Create(nil);
//          LHiMECSUser.LoadFromJSONFile( LStr,
//                                    ExtractFileName(LStr),
//                                    True);
//
//          if LHiMECSUser.HiMECSUserCollect.Count > 0 then
//          begin
//            AUserID := LHiMECSUser.HiMECSUserCollect.Items[0].UserID;
//            APasswd := LHiMECSUser.HiMECSUserCollect.Items[0].Password;
//          end;
//        finally
//          LHiMECSUser.HiMECSUserCollect.Clear;
//          FreeAndNil(LHiMECSUser);
//        end;
//      end
//      else
//        ShowMessage('User File from param does not exists: ' + #13#10 + LStr);
//    end
//    else
//    begin
//      j := Pos('/PF', UpperCase(LStr)); //Project File Name Parameter(.himecs)
//      if j > 0 then
//      begin ///PF 제거
//        LStr := Copy(LStr, j+3, Length(LStr)-j-1);
//
//        if FileExists(LStr) then
//        begin
//          APrjFileName := LStr;
//        end
//        else
//          ShowMessage('Project File from param does not exists: ' + #13#10 + LStr);
//      end;
//    end;
//  end;
end;

procedure TMainForm.ExecProcessKill;
var
  i: integer;
  LProcName: string;
begin
  for i := 0 to FKillProcessList.KillProcessListCollect.Count - 1 do
  begin
    if not FKillProcessList.KillProcessListCollect.Items[i].KillEnable then
      Continue;

    LProcName := FKillProcessList.KillProcessListCollect.Items[i].ProcessName;

    if IsRunningProcess(LProcName) then
    begin
      UnitProcessUtil.KillProcess(LProcName);
      DisplayMessage('Process: ' + LProcName + ' kill Succeeded!', mstFile,mtInformation);
    end;
  end;
end;

function TMainForm.ProcessSelectProject(AFirstLoad: Boolean;
  AAutoStart: Boolean = False; APrjFileName: string=''): Boolean;
var
  LStr: String;
  i: integer;
begin
  Result := SelectProject(APrjFileName);

  if not Result  then
  begin
    if AFirstLoad then //처음 로그인 후 실행 됨
    begin
      SetCurrentDir(FApplicationPath);
      LoadMenuFromFile(DefaultMenuFileNameOnLogIn, True);
    end
    else  //Open Project후에 reopen 할때
    begin

    end;

    exit;
  end;

  LStr := IncludeTrailingBackslash(ExtractRelativePath(
                            ExtractFilePath(Application.ExeName),
                            ExtractFilePath(FCurrentSelectedProjectFile.ProjectFileName)))+
                            ExtractFileName(FCurrentSelectedProjectFile.ProjectFileName);
  if System.Pos('.\', LStr) = 0 then
    LStr := '.\' + LStr;

  //상대경로를 저장함
  if FCurrentSelectedProjectFile.ProjectFileName = '' then
    FCurrentSelectedProjectFile.ProjectFileName := LStr;

  SetCurrentDir(FApplicationPath);

  //AdvSmoothSplashScreen1.Show;
  AdvSmoothSplashScreen1.BeginUpdate;

  LStr := AdvSmoothSplashScreen1.BasicProgramInfo.ProgramVersion.Text;

  if Pos('Version', LStr) = 0 then
    AdvSmoothSplashScreen1.BasicProgramInfo.ProgramVersion.Text := 'Version: '+ AdvSmoothSplashScreen1.BasicProgramInfo.ProgramVersion.Text;

  AdvSmoothSplashScreen1.BasicProgramInfo.ProgramVersion.Location := ilCustom;
  AdvSmoothSplashScreen1.BasicProgramInfo.ProgramVersion.PosX := 365;
  AdvSmoothSplashScreen1.EndUpdate;
  AdvSmoothSplashScreen1.ListItemsSettings.Rect.Left := 100;
  AdvSmoothSplashScreen1.ListItemsSettings.Rect.Top := 180;
  AdvSmoothSplashScreen1.ListItemsSettings.Rect.Height := 50;

  FFirst := True;

  if not Assigned(FModbusDragFormatTarget) then
  begin
    FModbusDragFormatTarget := TGenericDataFormat.Create(ModbusDropTarget);
    FModbusDragFormatTarget.AddFormat(sDragFormatParam);
  end;

  if not Assigned(FParamDragFormatTarget) then
  begin
    FParamDragFormatTarget := TGenericDataFormat.Create(ParamDropTarget);
    FParamDragFormatTarget.AddFormat(sDragFormatParam);
  end;

  if not Assigned(FEngModbusSource) then
    FEngModbusSource := TEngineParameterDataFormat.Create(EngModbusSource);

  if not Assigned(FEngParamSource) then
    FEngParamSource := TEngineParameterDataFormat.Create(EngParamSource);

  //FEngParamSource.AddFormat(sDragFormatParam);

  //FHiMECSFormPath := '..\bpl\';
  if not ForceDirectories('.\config\') then
    ShowMessage('Creation fail for '+FApplicationPath+'\config\ folder!');

  try
    for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
    begin
      if ExtractFileName(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].OptionsFileName) = '' then
        FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].OptionsFileName := DefaultOptionsFileName;

      LStr := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].OptionsFileName;
      //'..' 과 '.'이 없는 경우 절대 경로 임
      if (Pos('..',LStr) = 0) and (Pos('.',LStr) = 0) then
      begin
        LStr := '.\config\' + ExtractFileName(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].OptionsFileName);
      end;

      if not FileExists(LStr) then
        AddDefaultData2File(LStr);

      FCOI := i;
      //FHiMECSConfig로 Option file 로드함
      LoadConfigCollectFromFile(FCOI);
      LoadEngineInfo(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.EngineInfoFileName, False);
      LoadProjectInfo(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ProjectInfoFileName, False);
      LoadParamterFromFile(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ModbusFileName,
        eplikModbus);
      LoadParamterFromFile(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ParamFileName,
        eplikParameter);
      LoadManualInfoFromFile(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ManualInfoFileName);
//      AsyncLoadInfoData();
      //FHiMECSOptions.AddFromHiMECSConfigCollect(
      //  FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].OptionsFileName,
      //  FHiMECSConfig);

      //with AdvSmoothSplashScreen1.ListItems.Add do
      //begin
      //  BeginUpdate;
      //  HTMLText := '<IMG src="0"><FONT size="20" color="#A45302">Loading Options...</FONT><br>';
      //  EndUpdate;
      //end;

      UpdateProgress4Splash(10);
    end;//for
  finally
    with AdvSmoothSplashScreen1.ListItems.Add do
    begin
      BeginUpdate;
      HTMLText := '<IMG src="1"><FONT size="20" color="#A45302">Loading Menu items...</FONT><br>';
      EndUpdate;
    end;
    //LStr := IncludeTrailingPathDelimiter(FHiMECSConfig.ConfigPath);

    FCOI := 0;

    if FHiMECSUser.HiMECSUserCollect.Items[FCurrentUserIndex].MenuFileName <> '' then
      LoadMenuFromFile(FHiMECSUser.HiMECSUserCollect.Items[FCurrentUserIndex].MenuFileName, True)
    else
      LoadMenuFromFile(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.MenuFileName, True);

    UpdateProgress4Splash(20);

    with AdvSmoothSplashScreen1.ListItems.Add do
    begin
      BeginUpdate;
      HTMLText := '<IMG src="2"><FONT size="20" color="#A45302">Loading Packages...</FONT><br>';
      EndUpdate;
    end;

    PackageLoad_MDIChild;

    UpdateProgress4Splash(30);
  end;

  MenuItem1.Checked := True;//MDI Tab show

  with AdvSmoothSplashScreen1.ListItems.Add do
  begin
    BeginUpdate;
    HTMLText := '<IMG src="3"><FONT size="20" color="#A45302">Loading Engine Info...</FONT><br>';
    EndUpdate;
  end;

  UpdateProgress4Splash(40);

  with AdvSmoothSplashScreen1.ListItems.Add do
  begin
    BeginUpdate;
    HTMLText := '<IMG src="4"><FONT size="20" color="#A45302">Loading Engine Parameters...</FONT><br>';
    EndUpdate;
  end;

  //화면 상단에 엔진 번호의 버튼을 활성화 함
  SetEngineCount2Form();
  LoadKillProcess;

  UpdateProgress4Splash(100);
  FParameterDragMode := True;
  //SetLength(FWatchHandles, 1);
  FMultiWatchHandle := 0;
  EngineInfoInspector.PopupMenu := EngineInfoPopupMenu;
  EngModbusTV.PopupMenu := ModbusPopUp;
  AdvSmoothSplashScreen1.Hide;

  EngineInfoInspector.DoubleBuffered := False;
  AdvNavBar1.ActiveTabIndex := 0;

//  if FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.UpdateWhenStart then
//  begin
//    if DoUpdateVersion(True) then
//    begin
//      //ShowMessage('A New Version is avaliable.');
//    end;
//  end;

  {MDIPanel.Parent := nil;
  MDIPanel.ParentWindow := self.ClientHandle;
  //MDIPanel.Enabled:= False;
  MDIPanel.DoubleBuffered := true;
  FOldPanelProc := MDIPanel.WindowProc;
  MDIPanel.WindowProc := PanelMsgProc;
  FNewClient := MakeObjectInstance(MDIClientProc);
  FOldClient := Pointer(SetWindowLong(ClientHandle, GWL_WNDPROC, Integer(FNewClient)));
  }

end;

procedure TMainForm.ProgramExit;
begin
  Close;
end;

procedure TMainForm.Property1Click(Sender: TObject);
begin
  ShowPropertyForm(EngModbusTV);
end;

procedure TMainForm.Property2Click(Sender: TObject);
begin
  ShowPropertyForm(ParameterTV);
end;

procedure TMainForm.ReparentWindow(AHandle: HWND);
var
  I: Integer;
begin
  if AHandle<>0 then
  begin
    SetLength(FWindowList, Length(FWindowList)+1);
    I := High(FWindowList);
    FWindowList[I] := AHandle;
    Windows.SetParent(AHandle, ClientHandle);
    Inc(FMDIChildCount);
    //ActionMDICascade.Execute;
    //AdvToolBar1.AddMDIChildMenu(Result);
    //MDITabSet.AddTab(Result);
  end;
end;

function TMainForm.ReparentWindowForWindow(const WindowTitle: string): THandle;
begin
  Result := FindWindowEx(0,0,nil,PChar(WindowTitle));//FindWindow(PChar(WindowTitle), nil);
  if Result <> 0 then
    ReparentWindow(Result);
end;

procedure TMainForm.RestoreAll1Click(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to MDIChildCount - 1 do
    MDIChildren[i].WindowState := wsNormal;
end;

procedure TMainForm.RunCommunicationManager;
var
  i: integer;
  LHiMECSConfig: THiMECSConfig;
begin
  i := -1;
  CreateOrShowChildFormFromBpl('CommunicationMonitor',i);

  if i > -1 then
  begin
    LHiMECSConfig := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig;
    TForm(MDIChildren[i]).Hint := LHiMECSConfig.ExesPath;
    TForm(MDIChildren[i]).Tag := Integer(LHiMECSConfig.ExtAppInMDI);
  end;
end;

procedure TMainForm.SaveAsConfigData;
var
  LFileName: string;
  //F : TextFile;
begin
  JvSaveDialog1.InitialDir := FApplicationPath;
  JvSaveDialog1.Filter :=  '*.option';

  if JvSaveDialog1.Execute then
  begin
    LFileName := JvSaveDialog1.FileName;

    if FileExists(LFileName) then
    begin
      if MessageDlg('File is already exist. Are you overwrite? if No press, then save is cancelled.',
                                mtConfirmation, [mbYes, mbNo], 0)= mrNo then
        exit
      else
      begin
        //AssignFile(F, LFileName);
        //Rewrite(F);
        //CloseFile(F);
      end;
    end;

    LFileName := ChangeFileExt(LFileName, '.option');
    //FHiMECSOptions.Add2HiMECSConfigCollect(FHiMECSConfig,FCOI);
    FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.SaveToFile(LFileName, ExtractFileName(LFileName),
      FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].OptionFileEncrypt);
    ShowMessage(LFileName + ' is saved!');
  end;
end;

procedure TMainForm.SaveAsProject1Click(Sender: TObject);
var
  LFileName: string;
  F : TextFile;
begin
  JvSaveDialog1.InitialDir := FApplicationPath;
  JvSaveDialog1.Filter :=  '*.himecs';

  if JvSaveDialog1.Execute then
  begin
    LFileName := JvSaveDialog1.FileName;

    if FileExists(LFileName) then
    begin
      if MessageDlg('File is already exist. Are you overwrite? if No press, then save is cancelled.',
      mtConfirmation, [mbYes, mbNo], 0)= mrNo then
        //FEngineInfoCollect.LoadFromFile(LFileName, ExtractFileName(LFileName), False)
      else
      begin
        AssignFile(F, LFileName);
        Rewrite(F);
        CloseFile(F);

        LFileName := ChangeFileExt(LFileName, '.himecs');
        FCurrentSelectedProjectFile.SaveToFile(LFileName, ExtractFileName(LFileName), True);
      end;
    end;
  end;
end;

procedure TMainForm.SaveEngineInfo(AFileName: string; AIsEncrypt: Boolean);
var
  LEngineInfo: TICEngine;
begin
  ChangeFileExt(AFileName, '.einfo');

//  LEngineInfo := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.EngineInfo;
  LEngineInfo := TICEngine.Create(nil);
  try
    EngineInfoInspector2Class(EngineInfoInspector, LEngineInfo, True);
    LEngineInfo.SaveToJsonFile(AFileName, ExtractFileName(AFileName), AIsEncrypt);
  finally
    LEngineInfo.Free;
  end;
end;

procedure TMainForm.SaveEngineInfo1Click(Sender: TObject);
var
  LFileName: string;
  F : TextFile;
begin
  JvSaveDialog1.InitialDir := FApplicationPath;
  JvSaveDialog1.Filter :=  '*.einfo||*.*';

  if JvSaveDialog1.Execute then
  begin
    LFileName := JvSaveDialog1.FileName;

    if FileExists(LFileName) then
    begin
      if MessageDlg('File is already exist. Are you overwrite? if No press, then data is appended.',
      mtConfirmation, [mbYes, mbNo], 0)= mrNo then
        //FEngineInfoCollect.LoadFromFile(LFileName, ExtractFileName(LFileName), False)
      else
      begin
        AssignFile(F, LFileName);
        Rewrite(F);
        CloseFile(F);
      end;
    end;

    SaveEngineInfo(JvSaveDialog1.FileName, False);
  end;
end;

procedure TMainForm.SaveMsg2File(AMessage: string; AMessaggeType: TMessageType);
var
  LExt: string;
begin
  AMessage := FormatDateTime('yyyy-mm-dd hh:nn:ss',now) + ' => ' + AMessage;
  LExt := 'log';

  case AMessaggeType of
    mtError: SaveData2DateFile(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.LogPath,LExt,AMessage,soFromEnd);
    mtInformation: SaveData2DateFile(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.LogPath,LExt,AMessage,soFromEnd);
    mtAlarm: ;
    mtFault: ;
    mtShutdown: ;
  end;

end;

procedure TMainForm.SaveParamTV2File(AFileName: string; AIsEncrypt: Boolean; ATV: TJvCheckTreeView=nil);
var
  LEngineParameter: TEngineParameter;
  LEngineParameterItem,LEngineParameterItem2: TEngineParameterItem;
  i: integer;
  LEngParamList: RawUtf8;
begin
  if ATV = nil then
    ATV := EngModbusTV;

  LEngineParameter:= TEngineParameter.Create(nil);
  try
    for i := 0 to ATV.Items.Count - 1 do
    begin
      LEngineParameterItem := TEngineParameterItem(ATV.Items[i].Data);

      if Assigned(LEngineParameterItem) then
      begin
        LEngineParameterItem2 := LEngineParameter.EngineParameterCollect.AddEngineParameterItem(LEngineParameterItem);
        LEngineParameterItem2.LevelIndex := ATV.Items[i].Level;
        LEngineParameterItem2.NodeIndex := ATV.Items[i].Index;
      end;
    end;//for

    if FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.EngParamFileFormat = 0 then //XML format
      LEngineParameter.SaveToFile(AFileName, ExtractFileName(AFileName), AIsEncrypt)
    else
    if FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.EngParamFileFormat = 1 then //JSON format
      LEngineParameter.SaveToJSONFile(AFileName, ExtractFileName(AFileName), AIsEncrypt)
    else
    if FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.EngParamFileFormat = 2 then //Sqlite DB format
    begin
      LEngineParameter.SaveToSqliteFile(AFileName, LEngineParameterItem2.Index)
    end;
  finally
    LEngineParameter.Free;
  end;
end;

procedure TMainForm.SaveProjectInfo(AFileName: string; AIsEncrypt: Boolean);
var
  i,j,k:integer;
begin
  ChangeFileExt(AFileName, '.pinfo');

  with FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ProjectInfo do
  begin
    ProjectName := ProjectInfoInspector.items.ItemByName['FProjName'].AsString;
    ProjectNo := ProjectInfoInspector.items.ItemByName['FProjNo'].AsString;
    ShipNo := ProjectInfoInspector.items.ItemByName['FShipNo'].AsString;
    SiteName := ProjectInfoInspector.items.ItemByName['FSiteName'].AsString;
    SiteNo := ProjectInfoInspector.items.ItemByName['FSiteNo'].AsString;
    EquipCount := ProjectInfoInspector.items.ItemByName['FEquipCount'].AsString;
    ShipOwner := ProjectInfoInspector.items.ItemByName['FShipOwner'].AsString;
    ClassSociety := ProjectInfoInspector.items.ItemByName['FClassSociety'].AsString;

    SaveToJSONFile(AFileName, ExtractFileName(AFileName), AIsEncrypt);
  end;
end;

procedure TMainForm.SaveProjectInfo1Click(Sender: TObject);
var
  LFileName: string;
  F : TextFile;
begin
  JvSaveDialog1.InitialDir := FApplicationPath;
  JvSaveDialog1.Filter :=  '*.pinfo||*.*';

  if JvSaveDialog1.Execute then
  begin
    LFileName := JvSaveDialog1.FileName;

    if FileExists(LFileName) then
    begin
      if MessageDlg('File is already exist. Are you overwrite? if No press, then data is appended.',
      mtConfirmation, [mbYes, mbNo], 0)= mrNo then
        //FEngineInfoCollect.LoadFromFile(LFileName, ExtractFileName(LFileName), False)
      else
      begin
        AssignFile(F, LFileName);
        Rewrite(F);
        CloseFile(F);
      end;
    end;

    SaveProjectInfo(JvSaveDialog1.FileName, False);
  end;
end;

procedure TMainForm.SavetoFile1Click(Sender: TObject);
var
  LFileName: string;
  F : TextFile;
begin
  JvSaveDialog1.InitialDir := FApplicationPath;
  JvSaveDialog1.Filter :=  '*.param||*.*';

  if JvSaveDialog1.Execute then
  begin
    LFileName := JvSaveDialog1.FileName;

    if FileExists(LFileName) then
    begin
      if MessageDlg('이전에 작업한자료가 있습니다. 덮어쓰시겠습니까? No를 누르면 기존자료에 추가됨.',
      mtConfirmation, [mbYes, mbNo], 0)= mrNo then
        //FEngineInfoCollect.LoadFromFile(LFileName, ExtractFileName(LFileName), False)
      else
      begin
        AssignFile(F, LFileName);
        Rewrite(F);
        CloseFile(F);
      end;
    end;

    SaveParamTV2File(JvSaveDialog1.FileName, FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.EngParamEncrypt);
  end;
end;

procedure TMainForm.SectionRBClick(Sender: TObject);
begin
  if SectionRB.Checked then
    FCurrentManualSearchSrc := mssSection;
end;

procedure TMainForm.SelectEngineComboCloseUp(Sender: TNxPropertyItem);
begin
//  FCOI := SelectEngineCombo.ItemIndex;
//  SetEngineInfo2Inspector(SelectEngineCombo.ItemIndex);
//  SetAutoRunList2Inspector(SelectEngineCombo.ItemIndex);
end;

procedure TMainForm.SelectEquipment;
begin
  CreateSelectEquipForm(FCurrentSelectedProjectFile);
  ShowMessage(IntToStr(FCurrentSelectedProjectFile.CurrentProjectIndex));
end;

procedure TMainForm.SelectEquipment1Click(Sender: TObject);
begin
  SelectEquipment();
end;

//Project Select 해서 Project File Read 성공하면 True return
//Cancel Button 누르거나 Project File Read 실패하면 False return
//AProjectFileName <> '' : AutoLogin 되어 Param으로 부터 파일이름 입력 받는 경우 임.
function TMainForm.SelectProject(AProjectFileName: string=''): Boolean;
var
  LSelectProjectForm: TSelectProjectForm;
  LFileName: string;
  i: integer;
begin
  Result := False;
  //SetCurrentDir(FApplicationPath+'projects\');

  if AProjectFileName <> '' then
  begin
    i := Pos('projects\',AProjectFileName);

    if i = 0 then
    begin
      AProjectFileName := '.\projects\' + ExtractFileName(AProjectFileName);
    end;

    if SubProcessSelectProject(AProjectFileName) then
    begin
      Result := True;
    end
    else
      ShowMessage('Current user is not allowed to access this project file');

    exit;
  end;

  LSelectProjectForm := TSelectProjectForm.Create(Self);
  try
    with LSelectProjectForm do
    begin
      FExecFromHiMECS := True;

      ListData2LV('.\projects\*.himecs');

      CreateBtn.Enabled :=
        FHiMECSUser.HiMECSUserCollect.Items[FCurrentUserIndex].UserLevel <= HUL_Administrator;

      while true do
      begin
        if ShowModal = mrOK then
        begin
          if projectLV.SelCount > 0 then
          begin
            LFileName := projectLV.ItemFocused.Caption;
            LFileName := projectLV.ItemFocused.SubItems[0]+LFileName;

            if SubProcessSelectProject(LFileName) then
            begin
              Result := True;
              break;
            end
            else
              ShowMessage('Current user is not allowed to access this project file');
          end
          else
            ShowMessage('Select Project File Name!');
        end//if ShowModal
        else
          break;
      end;//while
    end;//with
  finally
    LSelectProjectForm.Free;
  end;

end;

function TMainForm.SelectUserFile: Boolean;
var
  LSelectProjectForm: TSelectProjectForm;
  LStr: string;
begin
  Result := False;
  SetCurrentDir(FApplicationPath);

  LSelectProjectForm := TSelectProjectForm.Create(Self);
  try
    with LSelectProjectForm do
    begin
      ListData2LV('.user');

      if ShowModal = mrOK then
      begin
        if projectLV.Items.Count > 0 then
        begin
          LStr := projectLV.ItemFocused.Caption;
          LStr := projectLV.ItemFocused.SubItems[0]+LStr;
          FCurrentSelectedProjectFile.ProjectFileName := LStr;
          Result := True;
        end;
      end;
    end;
  finally
    LSelectProjectForm.Free;
  end;
end;

procedure TMainForm.SendAlarmCopyData(ToHandle: integer;
  AEP: TEngineParameterItemRecord);
var
  cd : TCopyDataStruct;
begin
  with cd do
  begin
    dwData := Handle;
    cbData := sizeof(AEP);
    lpData := @AEP;
  end;//with
                                   //WParam = 1: TAlarmListRecord
  SendMessage(ToHandle, WM_COPYDATA, 1, LongInt(@cd));
end;

procedure TMainForm.SendEngParam2HandleWindow(
  AEPItemRecord: TEngineParameterItem; ADestHandle: Integer = -1);
var
  LHandle,LProcessID: THandle;
  LForm: TForm;
  LParam: string;
begin
  LForm := nil;

  if ADestHandle = -1 then
  begin
    if FMultiWatchHandle = 0 then
    begin
      if FControlPressed then
      begin
        LForm := CreateDummyMDIChild;
        LParam := '/d' + IntToStr(LForm.Handle);
      end
      else
        LParam := '';

      LProcessId := ExecNewProcess2(IncludeTrailingPathDelimiter(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ExesPath)+HiMECSWatchName2, LParam);
      FMultiWatchHandle := DSiGetProcessWindow(LProcessId);

      if Assigned(LForm) then
        TDummyForm(LForm).FClientFormHandle := FMultiWatchHandle;

      SetLength(FWatchHandles, Length(FWatchHandles)+1);
      FWatchHandles[High(FWatchHandles)] := FMultiWatchHandle;
    end;
  end;

  AEPItemRecord.AssignTo(FEngineParameterItemRecord);
  MoveMatrixData2ItemRecord(FEngineParameterItemRecord, AEPItemRecord);

  //MoveEngineParameterItemRecord(FEngineParameterItemRecord,AEPItemRecord);
  if ADestHandle = -1 then
  begin
    FPM.SendEPCopyData(Handle, FMultiWatchHandle, FEngineParameterItemRecord);

    if FControlPressed then
      ReparentWindow(FMultiWatchHandle);
  end
  else
    FPM.SendEPCopyData(Handle, ADestHandle,FEngineParameterItemRecord)
end;

procedure TMainForm.SendParamCopyData(ToHandle: integer;
  AEP: TEngineParameterItem);
var
  cd : TCopyDataStruct;
begin
  with cd do
  begin
    dwData := Handle;
    cbData := sizeof(AEP);
    lpData := @AEP;
  end;//with

  SendMessage(ToHandle, WM_COPYDATA, 0, LongInt(@cd));
end;

procedure TMainForm.SendUserLevelCopyData(ToHandle: integer;
  AUserLevel: THiMECSUserLevel);
var
  cd : TCopyDataStruct;
begin
  with cd do
  begin
    dwData := Handle;
    cbData := ord(AUserLevel);
    lpData := nil;
  end;//with
                                    //WParam = 2: User Level Send
  SendMessage(ToHandle, WM_COPYDATA, 2, LongInt(@cd));
end;

function TMainForm.SensorTypeSelectChanged4Modbus(out ASensorTypes: TSensorTypes): Boolean;
begin
  Result := False;

  if (EngModbusFilterCheck.Checked) then
  begin
    if (ModbusFilterCheckcb.Text <> FFilterText4Modbus) then
    begin
      FFilterText4Modbus := ModbusFilterCheckcb.Text;
      Result := True;
    end;

    ASensorTypes := GetSensorTypesFromParamSearchCheck(FFilterText4Modbus);
  end
  else
    ASensorTypes := [];
end;

function TMainForm.SensorTypeSelectChanged4Parameter(
  out ASensorTypes: TSensorTypes): Boolean;
begin
  Result := False;

  if (ParameterFilterCheck.Checked) then
  begin
    if (ParameterFilterCheckCB.Text <> FFilterText4Parameter) then
    begin
      FFilterText4Parameter := ParameterFilterCheckCB.Text;
      Result := True;
    end;

    ASensorTypes := GetSensorTypesFromParamSearchCheck(FFilterText4Parameter);
  end
  else
    ASensorTypes := [];
end;

//option file 생성,저장
procedure TMainForm.SetConfigData(Sender: TObject);
var
  ConfigData: TConfigF;
  LStr: string;
begin
  ConfigData := nil;
  ConfigData := TConfigF.Create(Self);
  try
    with ConfigData do
    begin
      Self.LoadConfigCollect2Form(ConfigData);

      MenuFilenameEdit.InitialDir := FApplicationPath + 'Config';
      EngInfoFilenameEdit.InitialDir := FApplicationPath + 'Doc';
      ParamFilenameEdit.InitialDir := FApplicationPath + 'Doc';
      ProjInfoFilenameEdit.InitialDir := FApplicationPath + 'Doc';
      KillProcFilenameEdit.InitialDir := FApplicationPath + 'Config';

      if ShowModal = mrOK then
      begin
        SetCurrentDir(FApplicationPath);
        Self.LoadConfigForm2Collect(ConfigData);
        SaveConfig(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].OptionsFileName,
          FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].OptionFileEncrypt);
//        LStr := IncludeTrailingPathDelimiter(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ConfigPath);
//        FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.SaveToFile(
//          FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].OptionsFileName,
//          ExtractFileName(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].OptionsFileName),
//          FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].OptionFileEncrypt);
        DoConfigChange;
      end;
    end;//with
  finally
    ConfigData.Free;
    ConfigData := nil;
  end;//try
end;

function TMainForm.SetConfigEngParamItemData(AEPItem:TEngineParameterItem; AIdx: integer): Boolean;
var
  ConfigData: TEngParamItemConfigForm2;
  LStr: string;
  LEngineParameter: TEngineParameter;
begin
  Result := False;
  ConfigData := nil;
  ConfigData := TEngParamItemConfigForm2.Create(Self);
  try
    with ConfigData do
    begin
      if AEPItem.TagName = 'New' then
      begin
        TagNameEdit.Enabled := True;
        DescEdit.Enabled := True;
        AddressEdit.Enabled := True;
        FCEdit.Enabled := True;
      end;

      LoadConfigEngParamItem2Form(AEPItem);

      ViewMatrixButton.Visible := AEPItem.IsMatrixData;

      if ShowModal = mrOK then
      begin
        SetCurrentDir(FApplicationPath);
        LoadConfigForm2EngParamItem(AEPItem);//FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].HiMECSConfig.EngineParameter

        if Dialogs.MessageDlg('Do you save a changed parameter to the '''+
                          FCurrentModbusFileName+'''?' +#13#10,
          mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
        begin
          LEngineParameter := GetEngParamFromItem(AEPItem, AIdx);

          if FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].HiMECSConfig.EngParamFileFormat = 0 then //XML format
            LEngineParameter.SaveToFile(FCurrentModbusFileName,
                  ExtractFileName(FCurrentModbusFileName),False)
          else
          if FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].HiMECSConfig.EngParamFileFormat = 1 then //JSON format
            LEngineParameter.SaveToJSONFile(FCurrentModbusFileName,
                  ExtractFileName(FCurrentModbusFileName),False)
          else
          if FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].HiMECSConfig.EngParamFileFormat = 2 then //Sqlite format
            LEngineParameter.SaveToSqliteFile(FCurrentModbusFileName, AEPItem.Index);

//          if FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].HiMECSConfig.EngParamFileFormat = 0 then //XML format
//            FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].HiMECSConfig.EngineParameter.SaveToFile(FCurrentModbusFileName,
//                  ExtractFileName(FCurrentModbusFileName),False)
//          else
//          if FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].HiMECSConfig.EngParamFileFormat = 1 then //JSON format
//            FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].HiMECSConfig.EngineParameter.SaveToJSONFile(FCurrentModbusFileName,
//                  ExtractFileName(FCurrentModbusFileName),False)
//          else
//          if FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].HiMECSConfig.EngParamFileFormat = 2 then //Sqlite format
//            FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIdx].HiMECSConfig.EngineParameter.SaveToSqliteFile(FCurrentModbusFileName, AEPItem.Index);
        end;

        Result := True;
      end;
    end;//with
  finally
    ConfigData.Free;
    ConfigData := nil;
  end;//try
end;

procedure TMainForm.SetConfigMonitorTile(ATile: TAdvSmoothTile);
var
  LnewApp_Frm : TnewMonApp_Frm;
  LMonitorItem: THiMECSMonitorListItem;
begin
  LnewApp_Frm := TnewMonApp_Frm.Create(nil);
  try
    LMonitorItem := ATile.ItemOject as THiMECSMonitorListItem;

    LoadMonitorVar2ConfigForm(LnewApp_Frm, LMonitorItem);

    if LnewApp_Frm.ShowModal = mrOk then
    begin
      LoadMonitorConfigForm2Var(LnewApp_Frm, LMonitorItem);
      LMonitorItem.TileIndex := ATile.Index;
      LoadMonitorVar2Form(ATile, LMonitorItem);
    end;
  finally
    FreeAndNil(LnewApp_Frm);
  end;
end;

procedure TMainForm.SetAutoRunList2Inspector(AIndex: integer);
var
  lTile : TAdvSmoothTile;
  LAutoRunList: TAutoRunList;
  i: integer;
begin
  LAutoRunList := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSAutoRun;

  if not Assigned(LAutoRunList) then
    exit;

  LAutoRunList.AutoRunCollect.Clear;

  for i := 0 to LAutoRunList.AutoRunCollect.Count - 1 do
  begin
    lTile := CommTileListFrame.tileList.Tiles.Add;
    LoadAutoRunVar2Form(lTile,LAutoRunList.AutoRunCollect.Items[i]);
  end; //for
end;

procedure TMainForm.SetConfigAutoRunTile(ATile: TAdvSmoothTile);
var
  LnewApp_Frm : TnewCommApp_Frm;
  LAutoRunItem: TAutoRunItem;
begin
  LnewApp_Frm := TnewCommApp_Frm.Create(nil);
  try
    LAutoRunItem := ATile.ItemOject as TAutoRunItem;

    LoadAutoRunVar2ConfigForm(LnewApp_Frm, LAutoRunItem);

    with LnewApp_Frm do
    begin
      if ShowModal = mrOk then
      begin
        LoadAutoRunConfigForm2Var(LnewApp_Frm, LAutoRunItem);
        LAutoRunItem.TileIndex := ATile.Index;
        LoadAutoRunVar2Form(ATile, LAutoRunItem);
      end;
    end;
  finally
    FreeAndNil(LnewApp_Frm);
  end;
end;

//AControl의 AEvent에 FuncName 함수 연결함.
//DLLName이 Self인 경우 TMainForm의 멤버함수에서 FuncName 검색함.
procedure TMainForm.SetControlEvent(AControl: TControl; AInsertIndex: integer; AEvent: string);
var
  LPropInfo: PPropInfo;
  LMethod: TMethod;
begin
  //Set OnClick Event
  if (UpperCase(FMenuBase.HiMECSMenuCollect.Items[AInsertIndex].DLLName) = 'SELF') or
    (UpperCase(ExtractFileExt(FMenuBase.HiMECSMenuCollect.Items[AInsertIndex].DLLName)) = '.EXE') then
  begin
    LPropInfo := GetPropInfo(AControl.ClassInfo, AEvent); //'OnClick'

    if Assigned(LPropInfo) then
    begin
      LMethod.Code := nil;
      LMethod.Code := MethodAddress(FMenuBase.HiMECSMenuCollect.Items[AInsertIndex].FuncName);
      if Assigned(LMethod.Code) then
      begin
        //요주의: 멤버 함수가 속해있는 Owner Class를 Method.Data에 할당해야 함
        LMethod.Data := Self;
        SetMethodProp(AControl, LPropInfo, LMethod);
      end;
    end;
  end;
end;

procedure TMainForm.SetEngCountBtnColor(ACyBitBtn: TCyBitBtn; AColor: TColor);
begin
  ACyBitBtn.Degrade.FromColor := AColor;
  ACyBitBtn.Degrade.ToColor := AColor;
end;

procedure TMainForm.SetEngineCount2Form;
var
  i: integer;
  LEngBtn: TCyBitBtn;
begin
  HideAllEngineCountBtn();

  for i := FCurrentSelectedProjectFile.ProjectFileCollect.Count downto 1 do
  begin
    LEngBtn := FindComponent('EngBtn' + IntToStr(i)) as TCyBitBtn;

    if LEngBtn <> nil then
    begin
      LEngBtn.Caption := FCurrentSelectedProjectFile.ProjectFileCollect.Items[i-1].ProjectItemName;
      LEngBtn.Visible := True;

      if i = (FCOI+1) then
        LEngBtn.OnClick(LEngBtn);
    end;
  end;
end;

procedure TMainForm.SetEngineData2NavBar(AOptIdx: integer);
begin
  if AOptIdx <> -1 then
    FCOI := AOptIdx;

  try
    ClearNavBar();
//    LoadEngineInfo(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.EngineInfoFileName, False);

    if Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.EngineInfo) then
    begin
//      SelectEngineCombo.ItemIndex := 0;
      SetEngineInfo2Inspector(FCOI);
      EngineInfoInspector.Invalidate;
    end;
  except
  end;

  if FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].IsDisplayOnTab then
  else
  begin
    if Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ProjectInfo) then
    begin
      SetProjectInfo2Inspector;
      ProjectInfoInspector.Invalidate;
    end;
  end;
//    LoadProjectInfo(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ProjectInfoFileName, False);

  LoadParameterList2TV(smSystem, EngModbusTV, FCOI, eplikModbus);
  LoadParameterList2TV(smSystem, ParameterTV, FCOI, eplikParameter);
  LoadManualInfo2TV([mikOpManual, mikDrawings], msmMSNo);
  LoadManualInfo2TV([mikMaintenance, mikSvcLetter], msmMSNo, MaintenanceTV);
end;

procedure TMainForm.SetEngineInfo2Inspector(AIndex: integer; AIsAdd2Combo: Boolean);
var
  LEngineInfo: TICEngine;
begin
  EngineInfoInspector.Items[1].Clear;
  LEngineInfo := FCurrentSelectedProjectFile.ProjectFileCollect.Items[AIndex].HiMECSConfig.EngineInfo;

  if not Assigned(LEngineInfo) then
  begin
    ShowMessage('Project->Option->EngineInfo(Index = ' + IntToStr(AIndex) + ') not assigned!');
    exit;
  end;

  EngineInfoClass2Inspector(LEngineInfo, EngineInfoInspector, AIndex, NxButtonItemButtonClick, AIsAdd2Combo);
end;

procedure TMainForm.SetEngineType(AType: string);
begin
{  Result := IntToStr(FEngineInfoCollect.CylinderCount) + 'H';
  Result := Result + IntToStr(FEngineInfoCollect.Bore) + '/';
  Result := Result + IntToStr(FEngineInfoCollect.Stroke);
  Result := Result + FuelType2DispName(FEngineInfoCollect.FuelType);
  Result := Result + DispName2CylinderConfiguration(FEngineInfoCollect.CylinderConfiguration);
}end;

procedure TMainForm.SetHideItemsOfManualInfoBySearchTxt(AManual: THiMECSManualInfo;
  AKind: TManualItemKind; ASearchSrc: TManualSearchSrc; ASearchText: string);
var
  ALevel, j, LParentRem: Integer;
  CurrStr, LStr: string;
  Keep, KeepParent, KeepAncestors: Boolean;
  LevelRem: Integer;
  LHiMECSOpManualItem: THiMECSOpManualItem;

  procedure _SetHideItem(AHiMECSOpManualItem: THiMECSOpManualItem);
  begin
    case ASearchSrc of
      mssSystem: LStr := AHiMECSOpManualItem.SystemDesc_Eng;
      mssPart: LStr := AHiMECSOpManualItem.PartDesc_Eng;
      mssSection: LStr := AHiMECSOpManualItem.SectionNo;
    end;//case

    if LStr = '' then
    begin
      CurrStr:= '';
    end
    else
    begin
      CurrStr := GetBufStart(LStr, ALevel);
      CurrStr:= Lowercase(CurrStr); // insures a case insensitive search
    end;

    if ALevel >= LevelRem then // node is a leaf
    begin
      Keep:= pos(ASearchText, CurrStr) > 0; // Search string found if true

      if Keep then
      begin
        KeepParent:= true; // parent branch must be kept
        KeepAncestors:= true;
        LParentRem:= ALevel - 1;
      end
      else
      begin
        AHiMECSOpManualItem.FIsHideItem := True;
      end;
    end; // if ALevel = LevelRem

    if ALevel = LevelRem - 1 then // node is a branch
    begin
      KeepParent:= false;
      if KeepAncestors and (ALevel = LParentRem) then
      begin
        KeepParent:= true;
        LParentRem:= LParentRem - 1;
      end;

      if not KeepParent then
        AHiMECSOpManualItem.FIsHideItem := True
      else if ALevel = 0 then
        KeepAncestors:= False;
    end;

    LevelRem:= ALevel;
  end;//procedure
begin
  if ASearchText = '' then
    exit;

  LevelRem:= 0;
  KeepParent:= false;

  if AKind = mikOpManual then
  begin
    for j := AManual.OpManual.Count - 1 downto 0 do // List is scanned from bottom to top
    begin
//      Caption := IntToStr(j);
      LHiMECSOpManualItem := AManual.OpManual.Items[j];
      _SetHideItem(LHiMECSOpManualItem);
    end;//for j
  end
  else
  if AKind = mikMaintenance then
  begin
    for j := AManual.MaintenanceManual.Count - 1 downto 0 do // List is scanned from bottom to top
    begin
      LHiMECSOpManualItem := AManual.MaintenanceManual.Items[j];
      _SetHideItem(LHiMECSOpManualItem);
    end;//for j
  end
  else
  if AKind = mikDrawings then
  begin
    for j := AManual.Drawings.Count - 1 downto 0 do // List is scanned from bottom to top
    begin
      LHiMECSOpManualItem := AManual.Drawings.Items[j];
      _SetHideItem(LHiMECSOpManualItem);
    end;//for j
  end;
end;

procedure TMainForm.SetHiMECSMainMenu(AMenuBase: TMenuBase);
var
  LMenuItem: TMenuItem;
  Li,Lj: integer;
begin
  MainMenu1.Items.Clear;

  //Main Menu Insert
  for Li := 0 to FMenuBase.HiMECSMenuCollect.Count - 1 do
  begin
    LMenuItem := TMenuItem.Create(Self);
    LMenuItem.Caption := FMenuBase.HiMECSMenuCollect.Items[Li].Caption;
    LMenuItem.Hint := FMenuBase.HiMECSMenuCollect.Items[Li].Hint;

    if FMenuBase.HiMECSMenuCollect.Items[Li].FuncName <> ''  then
    begin
      //LMenuItem.ShortCut := nil;
      //LMenuItem.Action := nil;

      //SetControlEvent를 위해 FMenuBase.HiMECSMenuCollect index를 저장함
      LMenuItem.Tag := Li;

      SetControlEvent(TControl(LMenuItem), Li,
          FMenuBase.HiMECSMenuCollect.Items[Li].EventName);
      SetMenuImageIndex(LMenuItem, Li);
    end;

    if FMenuBase.HiMECSMenuCollect.Items[Li].LevelIndex = 0 then
      MainMenu1.Items.Insert(FMenuBase.HiMECSMenuCollect.Items[Li].NodeIndex,LMenuItem)
    else
    if FMenuBase.HiMECSMenuCollect.Items[Li].LevelIndex =
                        FMenuBase.HiMECSMenuCollect.Items[Li-1].LevelIndex then
    begin
      Lj := FMenuBase.HiMECSMenuCollect.Items[Li].ParentMenuIndex;
      MainMenu1.Items[Lj].Insert(FMenuBase.HiMECSMenuCollect.Items[Li].NodeIndex, LMenuItem);
    end
    else
    if (FMenuBase.HiMECSMenuCollect.Items[Li].LevelIndex - 1) =
                      FMenuBase.HiMECSMenuCollect.Items[Li-1].LevelIndex then
    begin
      Lj := FMenuBase.HiMECSMenuCollect.Items[Li].ParentMenuIndex;
      MainMenu1.Items[Lj].Insert(FMenuBase.HiMECSMenuCollect.Items[Li].NodeIndex,LMenuItem);
    end
    else
    if FMenuBase.HiMECSMenuCollect.Items[Li-1].LevelIndex >
                        FMenuBase.HiMECSMenuCollect.Items[Li].LevelIndex then
    begin
      Lj := FMenuBase.HiMECSMenuCollect.Items[Li].ParentMenuIndex;
      while FMenuBase.HiMECSMenuCollect.Items[Lj].LevelIndex >
            FMenuBase.HiMECSMenuCollect.Items[Li].LevelIndex do
        Lj := FMenuBase.HiMECSMenuCollect.Items[Li].ParentMenuIndex;

      MainMenu1.Items[Lj].Insert(FMenuBase.HiMECSMenuCollect.Items[Li].NodeIndex,LMenuItem)
    end;
  end;
end;

procedure TMainForm.SetManualInfo2Inspector;
begin

end;

procedure TMainForm.SetMenuImageIndex(AMenuItem: TMenuItem; AInsertIndex: integer);
begin
  if Assigned(MainMenu1.Images) then
  begin
    AMenuItem.ImageIndex := FMenuBase.HiMECSMenuCollect.Items[AInsertIndex].ImageIndex;
  end;
end;

procedure TMainForm.SetMonWindow2Top;
var
  i,j: integer;
begin
  ShowWindow(Self.Handle,SW_SHOWMINNOACTIVE);//SW_SHOWNOACTIVATE);

  for i := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Count - 1 do
  begin
    if not Assigned(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor) then
      continue;

    for j := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor.MonitorListCollect.Count - 1 do
      BringWindowToTop(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSMonitor.MonitorListCollect.Items[j].AppHandle);

    //for j := 0 to FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSAutoRun.AutoRunCollect.Count - 1 do
      //SendMessage(FCurrentSelectedProjectFile.ProjectFileCollect.Items[i].HiMECSAutoRun.AutoRunCollect.Items[j].AppHandle,
       // WM_SHOW, 0, 0);
  end;
end;

procedure TMainForm.SetProjectInfo2Inspector;
begin
  ProjectInfoInspector.Items[0].Clear;

  with FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ProjectInfo do
  begin
    AddItemsToInspector(ProjectInfoInspector, TNxTextItem, 0,
                                            'FProjNo','Project No.', ProjectNo);
    AddItemsToInspector(ProjectInfoInspector, TNxTextItem, 0,
                                            'FProjName','Project Name', ProjectName);
    AddItemsToInspector(ProjectInfoInspector, TNxTextItem, 0,
                                            'FSiteNo','Site No.', SiteNo);
    AddItemsToInspector(ProjectInfoInspector, TNxTextItem, 0,
                                            'FSiteName','Site Name', SiteName);
    AddItemsToInspector(ProjectInfoInspector, TNxTextItem, 0,
                                            'FShipNo','Hull No.', ShipNo);
    AddItemsToInspector(ProjectInfoInspector, TNxTextItem, 0,
                                            'FEquipCount','Num. of Engine', EquipCount);
    AddItemsToInspector(ProjectInfoInspector, TNxTextItem, 0,
                                            'FShipOwner','Ship Owner', ShipOwner);
    AddItemsToInspector(ProjectInfoInspector, TNxTextItem, 0,
                                            'FClassSociety','Class', ClassSociety);
  end;
end;

procedure TMainForm.ShowACPPanelInside;
begin
  ShowPanelInside(pkaACP);
end;

procedure TMainForm.ShowAllMonitor1Click(Sender: TObject);
var
  i: integer;
  LAdvNavBarPanel: TAdvNavBarPanel;
  LMonItem: THiMECSMonitorListItem;
  LAutoRunItem: TAutoRunItem;
begin
  LAdvNavBarPanel := AdvNavBar1.Panels[AdvNavBar1.ActiveTabIndex];
  if LAdvNavBarPanel.Name = 'MonitoringPanel' then
  begin
    for i := 0 to MonTileListFrame.tileList.Tiles.Count - 1 do
    begin
      LMonItem := MonTileListFrame.tileList.Tiles[i].ItemOject as THiMECSMonitorListItem;
      ShowWindowFromSelectedMonTile(SW_RESTORE,LMonItem);
    end;
  end
  else
  if LAdvNavBarPanel.Name = 'CommunicationPanel' then
  begin
    for i := 0 to CommTileListFrame.tileList.Tiles.Count - 1 do
    begin
      LAutoRunItem := CommTileListFrame.tileList.Tiles[i].ItemOject as TAutoRunItem;
      ShowWindowFromSelectedCommTile(SW_RESTORE, LAutoRunItem);
    end;
  end;
end;

procedure TMainForm.ShowDiagram1Click(Sender: TObject);
begin
  ShowWirePathUsingDiagram();
end;

procedure TMainForm.ShowDrawing;
var
  LNode: TTreeNode;
  LEngineParameterItem: TEngineParameterItem;
  LFullFilePath, LDummy: string;
begin
  LNode := EngModbusTV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );

  if Assigned(LNode) then
  begin
    if TObject(LNode.Data) is TEngineParameterItem then
    begin
      LEngineParameterItem := TEngineParameterItem(LNode.Data);
      LFullFilePath := LEngineParameterItem.DrawingNo;

      if not GetFullFilePathFromManualInfo(LFullFilePath, LDummy) then
      begin
        ShowMessage('File Name is empty!');
        exit;
      end;

      if FileExists(LFullFilePath) then
        CreateMDI4PDF(LFullFilePath, LEngineParameterItem.Description,
          0, hdtDrawing)
      else
        ShowMessage('File not found : ' + LFullFilePath);
    end;
  end;
end;

procedure TMainForm.ShowDrawing1Click(Sender: TObject);
begin
  ShowDrawing();
end;

procedure TMainForm.ShowLOPPanelInside;
begin
  ShowPanelInside(pkaLOP);
end;

procedure TMainForm.ShowMaintenanceFileInfo;
var
  LNode: TTreeNode;
  LStr: string;
  LHiMECSMaintenanceManualItem: THiMECSMaintenanceManualItem;
  LHiMECSSvcLetterItem: THiMECSSvcLetterItem;
begin
  LNode := MaintenanceTV.GetNodeAt( FMouseClickMaintenanceTV_X, FMouseClickMaintenanceTV_Y );

  if Assigned(LNode) then
  begin
    if TObject(LNode.Data) is THiMECSMaintenanceManualItem then
    begin
      LHiMECSMaintenanceManualItem := THiMECSMaintenanceManualItem(LNode.Data);
//      LFileName := IncludeTrailingPathDelimiter(LHiMECSOpManualItem.FilePath) +
//        LHiMECSOpManualItem.FileName;
      LStr := 'File Path : ' + LHiMECSMaintenanceManualItem.FilePath + #13#10 +
        'File Name : ' + LHiMECSMaintenanceManualItem.FileName + #13#10 +
        'MS No : ' + LHiMECSMaintenanceManualItem.MSNumber;
    end
    else
    if TObject(LNode.Data) is THiMECSSvcLetterItem then
    begin
      LHiMECSSvcLetterItem := THiMECSSvcLetterItem(LNode.Data);
//      LFileName := IncludeTrailingPathDelimiter(LHiMECSDrawingItem.FilePath) +
//        LHiMECSDrawingItem.FileName;
      LStr := 'File Path : ' + LHiMECSSvcLetterItem.FilePath + #13#10 +
        'File Name : ' + LHiMECSSvcLetterItem.FileName + #13#10 +
        'MS No : ' + LHiMECSSvcLetterItem.MSNumber;
    end;

    ShowMessage(LStr);
  end;
end;

procedure TMainForm.ShowManual;
var
  LNode: TTreeNode;
  LEngineParameterItem: TEngineParameterItem;
  LFullFilePath, LDummy: string;
begin
  LNode := EngModbusTV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );

  if Assigned(LNode) then
  begin
    if TObject(LNode.Data) is TEngineParameterItem then
    begin
      LEngineParameterItem := TEngineParameterItem(LNode.Data);
      LFullFilePath := LEngineParameterItem.ManualNo;

      if not GetFullFilePathFromManualInfo(LDummy, LFullFilePath) then
      begin
        ShowMessage('File Name is empty!');
        exit;
      end;

      if FileExists(LFullFilePath) then
        CreateMDI4PDF(LFullFilePath, LEngineParameterItem.Description,
          0, hdtOpManual)
      else
        ShowMessage('File not found : ' + LFullFilePath);
    end;
  end;
end;

procedure TMainForm.ShowManual1Click(Sender: TObject);
begin
  ShowManual();
end;

procedure TMainForm.ShowManualFileInfo;
var
  LNode: TTreeNode;
  LStr: string;
  LHiMECSOpManualItem: THiMECSOpManualItem;
  LHiMECSDrawingItem: THiMECSDrawingItem;
begin
  LNode := ManualCheckTV.GetNodeAt( FMouseClickManualTV_X, FMouseClickManualTV_Y );

  if Assigned(LNode) then
  begin
    if TObject(LNode.Data) is THiMECSOpManualItem then
    begin
      LHiMECSOpManualItem := THiMECSOpManualItem(LNode.Data);
//      LFileName := IncludeTrailingPathDelimiter(LHiMECSOpManualItem.FilePath) +
//        LHiMECSOpManualItem.FileName;
      LStr := 'File Path : ' + LHiMECSOpManualItem.FilePath + #13#10 +
        'File Name : ' + LHiMECSOpManualItem.FileName + #13#10 +
        'MS No : ' + LHiMECSOpManualItem.MSNumber;
    end
    else
    if TObject(LNode.Data) is THiMECSDrawingItem then
    begin
      LHiMECSDrawingItem := THiMECSDrawingItem(LNode.Data);
//      LFileName := IncludeTrailingPathDelimiter(LHiMECSDrawingItem.FilePath) +
//        LHiMECSDrawingItem.FileName;
      LStr := 'File Path : ' + LHiMECSDrawingItem.FilePath + #13#10 +
        'File Name : ' + LHiMECSDrawingItem.FileName + #13#10 +
        'MS No : ' + LHiMECSDrawingItem.MSNumber;
    end;

    ShowMessage(LStr);
  end;
end;

procedure TMainForm.ShowMCPPanelInside;
begin
  ShowPanelInside(pkaMCP);
end;

procedure TMainForm.ShowMultiState1Click(Sender: TObject);
begin
  ShowMultiStateValue();
end;

procedure TMainForm.ShowMultiStateValue;
var
  LNode: TTreeNode;
  LEngineParameterItem: TEngineParameterItem;
  LStr: string;
begin
  LNode := EngModbusTV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );

  if Assigned(LNode) then
  begin
    if TObject(LNode.Data) is TEngineParameterItem then
    begin
      LEngineParameterItem := TEngineParameterItem(LNode.Data);
      LStr := GetMultiStateMeaning(LEngineParameterItem);

      if LStr = '' then
        LStr := 'There is no State value.';

      ShowMessage(LStr);
    end;
  end;
end;

procedure TMainForm.ShowNodeIndex1Click(Sender: TObject);
begin
  ShowMessage(IntToStr(TICEngineComponentItem(EngineInfoInspector.Items[29].ObjectReference).Index));
end;

procedure TMainForm.ShowPanelInside(APanelKind: TPanelKind4AVAT2);
var
  AInfoRec: TPLCChannelInfoRec;
begin
  case APanelKind of
    pkaMCP: Create_MCPPanelInside;//CreateOrShowMCPInsideForm(AInfoRec);
    pkaACP: Create_ACPPanelInside;
    pkaLOP: Create_LOPPanelInside;
    pkaICM: ;
    pkaCMM: ;
  end;
end;

procedure TMainForm.ShowPropertyForm(ATV: TJvCheckTreeView; AIsParamTV: Bool);
var
  LNode: TTreeNode;
  LEngineParameterItem: TEngineParameterItem;
  LIdx: integer;
begin
  if ATV.SelectionCount = 1 then
  begin
    if AIsParamTV then
      LNode := ATV.GetNodeAt( FMouseClickParamTV_X, FMouseClickParamTV_Y )
    else
      LNode := ATV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );

    if Assigned(LNode) then
    begin
      if TObject(LNode.Data) is TEngineParameterItem then
      begin
        LEngineParameterItem := TEngineParameterItem(LNode.Data);

        if LNode.Text = 'New' then
          LEngineParameterItem.TagName := LNode.Text;

        LIdx := GetCurrentOptionIndex(LNode);

        //Property창에서 OK 버튼 누르면 True 반환 됨
        if SetConfigEngParamItemData(LEngineParameterItem, LIdx) then
          if LNode.Text = 'New' then
            LNode.Text := LEngineParameterItem.TagName;
      end
      else
      if LNode.Level = 0 then  //root node
      begin
        FCOI := LNode.Index;
        ApplyChangedProjectItem;
      end;

       // ShowMessage(IntToStr(LNode.AbsoluteIndex)+':'+IntToStr(LNode.Index)+':'+IntToStr(LNode.Level));
    end;
  end
  else
  if ATV.SelectionCount > 1 then
  begin

  end;
end;

procedure TMainForm.ShowSelectedParameterList1Click(Sender: TObject);
var
  LNode: TTreeNode;
begin
  LNode := ParameterTV.GetNodeAt( FMouseClickParamTV_X, FMouseClickParamTV_Y );

  if Assigned(LNode) then
  begin
    ShowParamList(LNode, False);
  end;
end;

procedure TMainForm.ShowWindowFromSelectedCommTile(AWinMsgAction: integer;
  AAutoRunItem: TAutoRunItem);
var
  LAutoRunItem: TAutoRunItem;
  MyPopup: HWnd;
begin
  if AAutoRunItem = nil then
    LAutoRunItem := CommtileListFrame.tileList.SelectedTile.ItemOject as TAutoRunItem
  else
    LAutoRunItem := AAutoRunItem;

  if LAutoRunItem.AppHandle > 0 then
  begin
    MyPopup := GetLastActivePopup(LAutoRunItem.AppHandle);

    if AWinMsgAction = SW_RESTORE then
    begin
      BringWindowToTop(LAutoRunItem.AppHandle);
      if IsIconic(MyPopup) then
      begin
        ShowWindow(MyPopup, SW_RESTORE);  // 최소화 상태이면 원래 크기로
      end else
        BringWindowToTop(MyPopup);        // 최상위 윈도우로

      SetForegroundWindow(MyPopup);
    end
    else
    if AWinMsgAction = SW_MINIMIZE then
      ShowWindow(MyPopup, SW_MINIMIZE);
  end;
end;

procedure TMainForm.ShowWindowFromSelectedMonTile(AWinMsgAction: integer;
  AMonItem: THiMECSMonitorListItem);
var
  LMonItem: THiMECSMonitorListItem;
  MyPopup: HWnd;
begin
  if AMonItem = nil then
    LMonItem := MontileListFrame.tileList.SelectedTile.ItemOject as THiMECSMonitorListItem
  else
    LMonItem := AMonitem;

  if LMonItem.AppHandle > 0 then
  begin
    MyPopup := GetLastActivePopup(LMonItem.AppHandle);

    if AWinMsgAction = SW_RESTORE then
    begin
      BringWindowToTop(LMonItem.AppHandle);
      if IsIconic(MyPopup) then
      begin
        ShowWindow(MyPopup, SW_RESTORE);  // 최소화 상태이면 원래 크기로
      end else
        BringWindowToTop(MyPopup);        // 최상위 윈도우로

      SetForegroundWindow(MyPopup);
    end
    else
    if AWinMsgAction = SW_MINIMIZE then
      ShowWindow(MyPopup, SW_MINIMIZE);
  end;
end;

procedure TMainForm.ShowWindowFromSelectedTile;
begin

end;

procedure TMainForm.ShowWirePath;
var
  LNode: TTreeNode;
  LEngineParameterItem: TEngineParameterItem;
begin
  LNode := EngModbusTV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );

  if Assigned(LNode) then
  begin
    if TObject(LNode.Data) is TEngineParameterItem then
    begin
      LEngineParameterItem := TEngineParameterItem(LNode.Data);
      CreateNShowWirePathForm(LEngineParameterItem, False);
    end;
  end;
end;

procedure TMainForm.ShowWirePath1Click(Sender: TObject);
begin
  ShowWirePath();
end;

procedure TMainForm.ShowWirePathUsingDiagram;
var
  LProcessID: THandle;
  LNode: TTreeNode;
  LEngineParameterItem: TEngineParameterItem;
  LParam: string;
begin
  LNode := EngModbusTV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );

  if Assigned(LNode) then
  begin
    if TObject(LNode.Data) is TEngineParameterItem then
    begin
      LEngineParameterItem := TEngineParameterItem(LNode.Data);
      LParam := '/URL:"file://E:\pjh\Dev\Lang\React\Project\himecs_diagram\build\index.html"';
      LProcessID := ExecNewProcess2(HiMECSDiagramAppName, LParam);
      LProcessID := DSiGetProcessWindow(LProcessId);
//      SendUserLevelCopyData(Result,FCurrentUserLevel);
    end;
  end;                                                                            ;
end;

procedure TMainForm.SortbySensor1Click(Sender: TObject);
begin
  LoadParameterList2TV(smSensor);
end;

procedure TMainForm.SortbySensorSystem1Click(Sender: TObject);
begin
  LoadParameterList2TV(smSensor_System);
end;

procedure TMainForm.SortbySystem1Click(Sender: TObject);
begin
  LoadParameterList2TV(smSystem);
end;

procedure TMainForm.StatusBarPro1Click(Sender: TObject);
begin
  StatusBarPro1.SimplePanel := not StatusBarPro1.SimplePanel;
end;

function TMainForm.SubProcessSelectProject(AFileName: string): Boolean;
var
  LUserId, LPasswd, LUserFileName: string;
  LFS: TJclFileSummary;
  LFSI: TJclFileSummaryInformation;
begin
  Result := False;

  LUserId := FHiMECSUser.HiMECSUserCollect.Items[FCurrentUserIndex].UserID;
  LPasswd := FHiMECSUser.HiMECSUserCollect.Items[FCurrentUserIndex].Password;

//권한 문제로 이 부분에서 AV 발생하여 주석 처리 함 //2016.9.23
//  LFS:= TJclFileSummary.Create(AFileName, fsaRead, fssDenyAll);
//  try
//    LFS.GetPropertySet(TJclFileSummaryInformation, LFSI);
//    if Assigned(LFSI) then
//    begin
//      LUserFileName := LFSI.LastAuthor;
//    end;
//  finally
//    FreeAndNil(LFSI);
//    LFS.Free;
//  end;

  //.himecs file을 복사하거나 압축하면 Property Summary 정보 없어짐(NTFS)
  //User File Name 정보가 없을 경우 Project File 내 User File Name 가져옴
  if LUserFileName = '' then
  begin
    if not Assigned(FCurrentSelectedProjectFile) then
    begin
      FProjectGroup.ProjectGroupCollect.Items[FCurrentProjectFileIndex];

//      FCurrentSelectedProjectFile := TProjectFile.Create(Self);
    end
    else
      FCurrentSelectedProjectFile.ProjectFileCollect.Clear;

    FCurrentSelectedProjectFile.LoadFromJSONFile(AFileName, ExtractFileName(AFileName), True);
    LUserFileName := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].UserFileName;
  end;

  //Project File 별로 user file이 할당됨(한번 더 검사함)
  if CheckUserFromUserFile(LUserId, LPasswd, LUserFileName) then
  begin
    //if not FIsProjectClosed then
    CloseProject(False);
    CreateProc;

    FCurrentSelectedProjectFile.ProjectFileName := AFileName;
    Result := True;
  end;

//  FIsProjectClosed := not Result;
end;

procedure TMainForm.SystemRBClick(Sender: TObject);
begin
  if SystemRB.Checked then
    FCurrentManualSearchSrc := mssSystem;
end;

procedure TMainForm.TileConfig(ATile: TAdvSmoothTileList);
var
  ConfigData: TTileConfigF;
  LStr: string;
begin
  ConfigData := nil;
  ConfigData := TTileConfigF.Create(Self);
  try
    with ConfigData do
    begin
      LoadTileConfig2Form(ConfigData, ATile.Tag);

      if ShowModal = mrOK then
      begin
        LoadTileConfigForm2Collect(ConfigData, ATile.Tag);
        LStr := IncludeTrailingPathDelimiter(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ConfigPath);
        if ATile.Tag = 1 then
        begin
          FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSMonitor.SaveToJSONFile(
            LStr + ExtractFileName(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].MonitorFileName),
            ExtractFileName(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].MonitorFileName),
            FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].MonitorFileEncrypt);
        end
        else
        if ATile.Tag = 2 then
        begin
          FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSAutoRun.SaveToJSONFile(
            LStr + ExtractFileName(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].RunListFileName),
            ExtractFileName(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].RunListFileName),
            FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].RunListFileEncrypt);
        end;

        TileConfigChange(ATile.Tag);
      end;
    end;//with
  finally
    ConfigData.Free;
    ConfigData := nil;
  end;//try
end;

procedure TMainForm.TileConfigChange(AType: integer);
begin
  if AType = 1 then //MonTileListFrame.TileList
  begin
    MonTileListFrame.TileList.Rows := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSMonitor.TileRowNum;
    MonTileListFrame.TileList.Columns := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSMonitor.TileColNum;
  end
  else
  if AType = 2 then//CommTileListFrame.TileList
  begin
    CommTileListFrame.TileList.Rows := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSAutoRun.TileRowNum;
    CommTileListFrame.TileList.Columns := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSAutoRun.TileColNum;
  end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  if FFirst then
  begin
    FFirst := False;
    //LoadWatchListAll;
    LoadAutoRunList;
    LoadMonitorFormList;

//    SetMonWindow2Top;
  end;

  // Update the throbber to indicate that the application is responding to
  // messages (i.e. isn't blocked).
  FTick := (FTick + 1) mod 12;
  StatusBarPro1.Panels[0].ImageIndex := FTick;
  Update;
end;

procedure TMainForm.UpdateProgress4Splash(Percentage: integer);
begin
  AdvSmoothSplashScreen1.ProgressBar.Position := Percentage
end;

//ACheckOnly가 True 일때 Update가 필요하면 True
function TMainForm.DoUpdateVersion(ACheckOnly: Boolean = False): Boolean;
begin
  Result := False;

  case FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.UpdateProtocol of
    0: begin
      WebUpdate1.UpdateType := httpUpdate;//HTTP
      WebUpdate1.URL := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ServerURL;
      end;
    1: begin
      WebUpdate1.UpdateType := httpUpdate;//HTTPS
      WebUpdate1.URL := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ServerURL;
      WebUpdate1.UserID := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.FTPUserID;
      WebUpdate1.Password := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.FTPPasswd;
      end;
    2: begin
      WebUpdate1.UpdateType := ftpUpdate;//FTP
      WebUpdate1.Host := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.FTPHost;
      WebUpdate1.UserID := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.FTPUserID;
      WebUpdate1.Password := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.FTPPasswd;
      WebUpdate1.FTPDirectory := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.FTPDirectory;
      WebUpdate1.Port := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.FTPPort
      end;
    3: begin
      WebUpdate1.UpdateType := fileUpdate;//Network File
      WebUpdate1.URL := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ServerURL;
      end;
  end;

  Result := WebUpdate1.NewVersionAvailable;

  if not ACheckOnly then
    if MessageDlg('A New Version is avaliable.' + #13#10 + 'Are you want to update new version?',
        mtConfirmation, [mbYes, mbNo], 0)= mrYes then
      WebUpdate1.DoThreadUpdate;
end;

function TMainForm.CreateOrShowChildFormFromBpl(Aform: string; var AIndex: integer):Boolean;
var
  i: integer;
begin
  Result := False;

//  i := CheckMDIChildAndShow(Self, Aform);
//
//  if i = -1 then
//  begin
    for i := 0 to FHiMECSForms.PackageCollect.Count - 1 do
    begin
      if Pos(Aform, FHiMECSForms.PackageCollect.Items[i].PackageName) > 0 then
      begin
        if Assigned(FHiMECSForms.PackageCollect.Items[i].FCreateChildFromBPL[0]) then
        begin
          FHiMECSForms.PackageCollect.Items[i].FCreateChildFromBPL[0];
          Caption := Caption + ': MDI ChildCount = ' + IntToStr(MDIChildCount);
          AIndex := MDIChildCount - 1;
          break;
        end
        else
        begin
          ShowMessage(FHiMECSForms.PackageCollect.Items[i].PackageName + ' ('
            + FHiMECSForms.PackageCollect.Items[i].FCreateFuncNameAry[0] + ')');
        end;
      end;//if
    end;//for
//  end;
end;

function TMainForm.CreateOrShowMDIChild(AForm: TFormClass): TForm;
var
  i: integer;
  bCreated: Bool;
begin
  bCreated := False;
  Result := nil;

  for i := 0 to MDIChildCount - 1 do
  begin
    if MDIChildren[i] is AForm then
    begin
      MDIChildren[i].Show;
      ShowWindow(MDIChildren[i].Handle, SW_SHOW);
      Result := MDIChildren[i];
      bCreated := True;
      break;
    end;
  end;//for

  if not bCreated then
  begin
    Result := AForm.Create(Application);
//    AdvToolBar1.AddMDIChildMenu(Result);
    Result.OnClose := ChildFormClose;
    MDITabSet.AddTab(Result);
    Result.Show;
  end;
end;

procedure TMainForm.CreateProc;
begin
  if not Assigned(FHiMECSForms) then
    FHiMECSForms := THiMECSForms.Create(Self);

  if not Assigned(FHiMECSExes) then
    FHiMECSExes := THiMECSExes.Create(Self);

  //if not Assigned(FEngineInfoCollect) then
   // FEngineInfoCollect := TICEngine.Create(Self);
  //if not Assigned(FEngineInfoList) then
  //  FEngineInfoList := TStringList.Create;

//  if not Assigned(FProjectInfoCollect) then
//    FProjectInfoCollect := TVesselInfo.Create(Self);

  if not Assigned(FPackageList_Exes) then
    FPackageList_Exes := TStringList.Create;

  //if not Assigned(FEngineParameter) then
    //FEngineParameter := TEngineParameter.Create(Self);

  if not Assigned(FSearchParamList) then
    FSearchParamList := TStringList.Create;

  if not Assigned(FPJHTimerPool) then
    FPJHTimerPool := TPJHTimerPool.Create(nil);

  if not Assigned(FProjectGroup) then
    FProjectGroup := THiMECSProjectGroup.Create(Self);

//  if not Assigned(FCurrentSelectedProjectFile) then
//    FCurrentSelectedProjectFile := TProjectFile.Create(Self);

  if not Assigned(FKillProcessList) then
    FKillProcessList := TKillProcessList.Create(Self);
  //if not Assigned(FHiMECSConfig) then
    //FHiMECSConfig := THiMECSConfig.Create(Self);

  //if not Assigned(FHiMECSOptions) then
  //begin
    //FHiMECSOptions := THiMECSOptions.Create(Self);
    //FHiMECSOptions.EPStrList := TStringList.Create;
  //end;
end;

procedure TMainForm.CreateSubCategory1Click(Sender: TObject);
begin
  if EngModbusTV.Selected <> nil then
    AddCategory2ParamTV(EngModbusTV.Selected, True);
end;

procedure TMainForm.Vertical1Click(Sender: TObject);
begin
  DoTile(tbVertical);
end;

procedure TMainForm.ShowParameterListToNewForm1Click(Sender: TObject);
var
  LNode: TTreeNode;
begin
  LNode := ParameterTV.GetNodeAt( FMouseClickParamTV_X, FMouseClickParamTV_Y );

  if Assigned(LNode) then
  begin
    ShowParamList(LNode, True);
  end;
end;

procedure TMainForm.ShowParamList(ANode: TTreeNode; AIsCreateNewForm: Boolean);
var
  LAvatParamViewF: TAvatParamViewF;
  LOfficeTabCollectionItem: TOfficeTabCollectionItem;
  LHandle: THandle;
begin
  //폼이 생성된 적이 없으면 한개를 생성해야 함
  if not AIsCreateNewForm then
    AIsCreateNewForm := MDITabSet.AdvOfficeTabCount = 0;

  if AIsCreateNewForm then
  begin
    LAvatParamViewF := TAvatParamViewF.Create(nil);
    LAvatParamViewF.OnClose := ChildFormClose;
    MDITabSet.AddTab(LAvatParamViewF);
    LHandle := LAvatParamViewF.Handle;
  end
  else
  begin
    LOfficeTabCollectionItem := MDITabSet.AdvOfficeTabs[MDITabSet.ActiveTabIndex];
    LAvatParamViewF := TAvatParamViewF(MDITabSet.GetChildForm(LOfficeTabCollectionItem));
  end;

  LAvatParamViewF.FParamDBFileName := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ParamFileName;
  Add2ParamViewList(LAvatParamViewF.Handle, ANode);
  LAvatParamViewF.Show;
end;

procedure TMainForm.WebUpdate1FileProgress(Sender: TObject; FileName: string;
  Pos, Size: Integer);
begin
  StatusBarPro1.Panels[3].Progress.max := size;
  StatusBarPro1.Panels[3].Progress.position := pos;
end;

procedure TMainForm.MinimizeAll1Click(Sender: TObject);
var
  i: integer;
begin
  for i := MDIChildCount -1 downto 0 do
    MDIChildren[i].WindowState := wsMinimized;
end;

//procedure TMainForm.WMCableRouteFormColse(var Msg: TMessage);
//begin
  //ChildFormClose()이 실행됨
//end;

procedure TMainForm.WMCopyData(var Msg: TMessage);
var
  i: integer;
  LHandle: integer;
  LNode: TTreeNode;
  LEngParamItem: TEngineParameterItem;
begin
  case Msg.WParam of
    WParam_REQMULTIRECORD: begin//Handle 수신 OK
      FKeyBdShiftState := PKbdShiftRec(PCopyDataStruct(Msg.LParam)^.lpData)^.FKbdShift;
//      Add2MultiNode(FCurrentNode, False, False, PCopyDataStruct(Msg.LParam)^.cbData);
      FParamCopyMode := PKbdShiftRec(PCopyDataStruct(Msg.LParam)^.lpData)^.ParamDragMode;
      FEngineParameterItemRecord.FParamDragCopyMode := TParamDragCopyMode(FParamCopyMode);
      LHandle := PKbdShiftRec(PCopyDataStruct(Msg.LParam)^.lpData)^.MyHandle;
      SendMessage(LHandle, WM_MULTICOPY_BEGIN, 0, 0);

      //Shift Key가 눌려진 상태이면 MultiSelect를 의미하고 Select Node만 전송해야 함
      if (ssShift in FKeyBdShiftState) then
      begin
        for i := EngModbusTV.SelectionCount - 1 downto 0 do
        begin
          LNode := EngModbusTV.SelectedItems[i];

          Add2MultiNode(LNode, False, False, LHandle);
        end;
      end
      else
        Add2MultiNode(FCurrentNode, False, False, LHandle);

      SendMessage(LHandle, WM_MULTICOPY_END, 0, 0);
      FKeyBdShiftState := [];
      FParamCopyMode := Ord(dcmCopyCancel);
      FEngineParameterItemRecord.FParamDragCopyMode := dcmCopyCancel;
    end;
    WParam_DISPLAYMSG: begin
      case PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^.iHandle of
        0: ;//ShowMessage(PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^.StrMsg); //MDI Child Caption 수신

        1: begin//Wire Path Form을 Display함(FrmPLCChannelInfo에서 TagName을 보냄)
          LEngParamItem := FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.EngineParameter.GetItemFromTagName(
            PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^.StrMsg);

          if Assigned(LEngParamItem) then
            CreateNShowWirePathForm(LEngParamItem, False);
        end;
      end;
    end;
  end;
  //AdvToolBar1.AddMDIChildMenu(TForm(PCopyDataStruct(Msg.LParam)^.lpData));
  //MDITabSet.AddTab(TForm(PCopyDataStruct(Msg.LParam)^.lpData));
end;

procedure TMainForm.About1Click(Sender: TObject);
begin
  FormAbout1.Show(False);
end;

procedure TMainForm.Add2AlarmList(ANode: TTreeNode; AAddSibling: boolean=false);
var
  LHandle,LProcessID: THandle;
  LEngineParameterItem: TEngineParameterItem;
  LNode: TTreeNode;
  Li: integer;
begin
  if not Assigned(ANode) then
    exit;

  if ANode.HasChildren then
  begin
    LNode := ANode.GetFirstChild;

    for Li := 0 to ANode.Count - 1 do
    begin
      Add2AlarmList(LNode, true);
      LNode := ANode.GetNextChild(LNode);
    end;

    exit;
  end;

  if TObject(ANode.Data) is TEngineParameterItem then
  begin
    if FAlarmListHandle = 0 then
    begin
      LProcessId := ExecNewProcess2(IncludeTrailingPathDelimiter(
        FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ExesPath)+HiMECSWatchName2+' '+AlarmListMode);
      FAlarmListHandle := DSiGetProcessWindow(LProcessId);
    end;

    LEngineParameterItem := TEngineParameterItem(ANode.Data);
    LEngineParameterItem.AssignTo(FEngineParameterItemRecord);
    //MoveEngineParameterItemRecord(FEngineParameterItemRecord,LEngineParameterItem);
    SendAlarmCopyData(FAlarmListHandle,FEngineParameterItemRecord);

    SetLength(FWatchHandles, Length(FWatchHandles)+1);
    FWatchHandles[High(FWatchHandles)] := FAlarmListHandle;

    if FControlPressed then
    begin
      CreateDummyMDIChild(LProcessId);
      ReparentWindow(FAlarmListHandle);
    end;
  end;

  if AAddSibling then
    Add2AlarmList(ANode.GetNextSibling);
end;

//AIsForWatch = True: Watch Window에 SendCopyData로 데이터 전달
//              False: Mouse Drag로 데이터 전달
procedure TMainForm.Add2MultiNode(ANode: TTreeNode;  AIsForWatch: Boolean;
  AMultiSelect: boolean; ADestHandle: integer = -1; AForm: TForm = nil);
var
  LEngineParameterItem: TEngineParameterItem;
  LNode: TTreeNode;
  Li: integer;
begin
  if not Assigned(ANode) then
    exit;

  if AMultiSelect then
  begin
    EngModbusTV.SelectionCount;

  end;

  if ANode.HasChildren then
  begin
    LNode := ANode.GetFirstChild;

    for Li := 0 to ANode.Count - 1 do
    begin
      Add2MultiNode(LNode, AIsForWatch, true, ADestHandle, AForm);
      LNode := ANode.GetNextChild(LNode);
    end;

    exit;
  end;

  if TObject(ANode.Data) is TEngineParameterItem then
  begin
    if AIsForWatch then //New Window에 전달함
      SendEngParam2HandleWindow(TEngineParameterItem(ANode.Data),ADestHandle)
    else
    begin
      if ADestHandle = -1 then//EngModbusTVDblClick시 실행 됨
      begin
        ParameterItem2ParamList(ANode,AForm);
      end
      else
        SendEngParam2HandleWindow(TEngineParameterItem(ANode.Data), ADestHandle);
    end;
  end;

  //if AAddSibling then
    //Add2MultiNode(ANode.GetNextSibling, AIsForWatch, False, ADestHandle, AForm);
end;

procedure TMainForm.Add2ParamViewList(AFormHandle: THandle; ANode: TTreeNode; AAddSibling: boolean);
var
  LHandle,LProcessID: THandle;
  LEngineParameterItem: TEngineParameterItem;
  LNode: TTreeNode;
  Li: integer;
begin
  if not Assigned(ANode) then
    exit;

  if ANode.HasChildren then
  begin
    LNode := ANode.GetFirstChild;

    for Li := 0 to ANode.Count - 1 do
    begin
      Add2ParamViewList(AFormHandle, LNode, true);
      LNode := ANode.GetNextChild(LNode);
    end;

    exit;
  end;

  if TObject(ANode.Data) is TEngineParameterItem then
  begin
    LEngineParameterItem := TEngineParameterItem(ANode.Data);
//    LEngineParameterItem.AssignTo(FEngineParameterItemRecord);
    SendParamCopyData(AFormHandle,LEngineParameterItem); //AvatParamViewF.Handle
  end;

//  if AAddSibling then
//    Add2ParamViewList(ANode.GetNextSibling);
end;

procedure TMainForm.Add2WatchSave(ANode: TTreeNode; AAddSibling: boolean);
var
  LHandle,LProcessID: THandle;
  LEngineParameterItem: TEngineParameterItem;
  LNode: TTreeNode;
  Li: integer;
begin
  if not Assigned(ANode) then
    exit;

  if ANode.HasChildren then
  begin
    LNode := ANode.GetFirstChild;

    for Li := 0 to ANode.Count - 1 do
    begin
      Add2WatchSave(LNode, true);
      LNode := ANode.GetNextChild(LNode);
    end;

    exit;
  end;

  if TObject(ANode.Data) is TEngineParameterItem then
  begin
    if FMultiWatchHandle = 0 then
    begin
      LProcessId := ExecNewProcess2(IncludeTrailingPathDelimiter(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ExesPath)+HiMECSWatchSaveName);
      FMultiWatchHandle := DSiGetProcessWindow(LProcessId);
      SetLength(FWatchHandles, Length(FWatchHandles)+1);
      FWatchHandles[High(FWatchHandles)] := FMultiWatchHandle;
    end;

    LEngineParameterItem := TEngineParameterItem(ANode.Data);
    LEngineParameterItem.AssignTo(FEngineParameterItemRecord);
    //MoveEngineParameterItemRecord(FEngineParameterItemRecord,LEngineParameterItem);
    FPM.SendEPCopyData(Handle, FMultiWatchHandle,FEngineParameterItemRecord);

    if FControlPressed then
    begin
      CreateDummyMDIChild(LProcessId);
      ReparentWindow(FMultiWatchHandle);
    end;
  end;

  if AAddSibling then
    Add2WatchSave(ANode.GetNextSibling);
end;

//Open array는 Setlength가 안됨. 때문에 Type 선언해서 변경함.
procedure TMainForm.Add2xxxList(ANode: TTreeNode; var AHandle: THandle;
  AHandleArray: TpjhArrayHandle; AExeName: String; AAddSibling: boolean);
var
  LHandle,LProcessID: THandle;
  LEngineParameterItem: TEngineParameterItem;
  LNode: TTreeNode;
  Li: integer;
begin
  if not Assigned(ANode) then
    exit;

  if ANode.HasChildren then
  begin
    LNode := ANode.GetFirstChild;

    for Li := 0 to ANode.Count - 1 do
    begin
      Add2xxxList(LNode,AHandle,AHandleArray,AExeName, true);
      LNode := ANode.GetNextChild(LNode);
    end;

    exit;
  end;

  if TObject(ANode.Data) is TEngineParameterItem then
  begin
    if AHandle = 0 then
    begin
      LProcessId := ExecNewProcess2(IncludeTrailingPathDelimiter(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ExesPath)+AExeName);
      AHandle := DSiGetProcessWindow(LProcessId);
      SetLength(AHandleArray, Length(AHandleArray)+1);
      AHandleArray[High(AHandleArray)] := AHandle;
    end;

    LEngineParameterItem := TEngineParameterItem(ANode.Data);
    LEngineParameterItem.AssignTo(FEngineParameterItemRecord);
    //MoveEngineParameterItemRecord(FEngineParameterItemRecord,LEngineParameterItem);
    FPM.SendEPCopyData(Handle,AHandle,FEngineParameterItemRecord);


    if FControlPressed then
    begin
      CreateDummyMDIChild(LProcessId);
      ReparentWindow(AHandle);
    end;
  end;

  if AAddSibling then
    Add2xxxList(ANode.GetNextSibling,AHandle,AHandleArray,AExeName);
end;

//ASubNode = True면 AddChild else Add
procedure TMainForm.AddCategory2ParamTV(Node: TTreeNode; ASubNode: boolean);
var
  Node1 : TTreeNode;
begin
  if ASubNode then
    Node1 := EngModbusTV.Items.AddChild(Node, 'New')
  else
    Node1 := EngModbusTV.Items.Add(Node, 'New');
end;

procedure TMainForm.AddDefaultData2File(AFileName: string);
begin
  FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.MenuFileName := DefaultMenuFileNameOnLogOut;

  FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.SaveToFile(AFileName, ExtractFileName(AFileName),
    FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].OptionFileEncrypt);
end;

procedure TMainForm.AddDummy1Click(Sender: TObject);
begin
  CreateDummyMDIChild;
end;

function TMainForm.AddExeToList(APackageName: string): Boolean;
var
  LStr: string;
begin
  Result := False;

  if (FPackageList_Exes.IndexOf(APackageName) = -1) then
  begin
    if (pos('bpl', ExtractFileExt(APackageName)) = 0) then
      LStr := APackageName + '.bpl'
    else
      LStr := APackageName;

    try
      FPackageList_Exes.AddObject(APackageName, Pointer(LoadPackage(APackageName)));
    except
      ShowMessage('Load Fail ' + APackageName + ' File');
    end;
  end
  else
    ShowMessage('Duplcate package file : ' + APackageName);
end;

procedure TMainForm.AddItem2ParamTV(Node: TTreeNode);
var
  Node1 : TTreeNode;
  i: integer;
begin
  i := CopyItem2EngineParamCollect(Node);
  Node1 := EngModbusTV.Items.AddObject(Node,
             'New', FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.EngineParameter.EngineParameterCollect.Items[i]);
  SetNodeImages(Node1, False);
end;

procedure TMainForm.AddtoAlarmList1Click(Sender: TObject);
var
  LNode: TTreeNode;
begin
  LNode := EngModbusTV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );

  if Assigned(LNode) then
  begin
    SetCurrentDir(FApplicationPath);
    Add2AlarmList(LNode);
    SetForegroundWindow(FAlarmListHandle);
  end;
end;

procedure TMainForm.AddtoNewWatch1Click(Sender: TObject);
var
  LNode: TTreeNode;
  LHandle,LProcessID: THandle;
  LEngineParameterItem: TEngineParameterItem;
begin
  LNode := EngModbusTV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );

  if Assigned(LNode) then
  begin
    if TObject(LNode.Data) is TEngineParameterItem then
    begin
      SetCurrentDir(FApplicationPath);
      LProcessId := ExecNewProcess2(IncludeTrailingPathDelimiter(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ExesPath)+HiMECSWatchName);
      LEngineParameterItem := TEngineParameterItem(LNode.Data);
      LEngineParameterItem.AssignTo(FEngineParameterItemRecord);
      //MoveEngineParameterItemRecord(FEngineParameterItemRecord,LEngineParameterItem);

      LHandle := DSiGetProcessWindow(LProcessId);
      FPM.SendEPCopyData(Handle, LHandle,FEngineParameterItemRecord);

      SetLength(FWatchHandles, Length(FWatchHandles)+1);
      FWatchHandles[High(FWatchHandles)] := LHandle;

      if FControlPressed then
      begin
        CreateDummyMDIChild(LHandle);
        ReparentWindow(LHandle);
      end;
      //FPJHTimerPool.AddOneShot(OnParamChange,500);
    end;
  end;
end;

procedure TMainForm.AddtoNewWatch21Click(Sender: TObject);
var
  LNode: TTreeNode;
  i: integer;
begin
//  LNode := EngModbusTV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );

  SetCurrentDir(FApplicationPath);

  FParamCopyMode := Ord(dcmCopyOnlyNonExist);
  FEngineParameterItemRecord.FParamDragCopyMode := dcmCopyOnlyNonExist;
  try
    for i := EngModbusTV.SelectionCount - 1 downto 0 do
    begin
      LNode := EngModbusTV.SelectedItems[i];

      if Assigned(LNode) then
      begin
        if i = EngModbusTV.SelectionCount - 1 then
          Add2MultiNode(LNode, True, False)
        else
        begin
          if FMultiWatchHandle <> 0 then
            Add2MultiNode(LNode, True, False, FMultiWatchHandle);
        end;
      end;
    end;
  finally
    FMultiWatchHandle := 0;
    FParamCopyMode := Ord(dcmCopyCancel);
    FEngineParameterItemRecord.FParamDragCopyMode := dcmCopyCancel;
  end;
end;

procedure TMainForm.AddtoSaveList1Click(Sender: TObject);
var
  LNode: TTreeNode;
begin
  LNode := EngModbusTV.GetNodeAt( FMouseClickModbusTV_X, FMouseClickModbusTV_Y );

  if Assigned(LNode) then
  begin
    SetCurrentDir(FApplicationPath);
    Add2WatchSave(LNode);
    //Add2xxxList(LNode,FMultiWatchHandle,FWatchHandles,HiMECSWatchSaveName);
    FMultiWatchHandle := 0;
  end;
end;

procedure TMainForm.AdvNavBar1SplitterMove(Sender: TObject; OldSplitterPosition,
  NewSplitterPosition: Integer);
begin
  EngineInfoInspector.Invalidate;
end;

procedure TMainForm.MDITabSetTabClick(Sender: TObject;
  TabIndex: Integer);
var
  LHandle, LProcessId: integer;
begin
  LProcessId := MDITabSet.AdvOfficeTabs[TabIndex].Tag;
  LHandle := DSiGetProcessWindow(LProcessId);
  SetForegroundWindow(LHandle);
end;

procedure TMainForm.ApplyChangedProjectItem;
begin
  ApplyConfigChange;
end;

procedure TMainForm.ApplyConfigChange;
begin
  SetEngineData2NavBar();
end;

procedure TMainForm.AsyncLoadInfoData;
begin
//  Parallel.Async(
//    procedure (const task: IOmniTask)
//    begin
//      LoadProjectInfo(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ProjectInfoFileName, False);
//      LoadParamterFromFile(FCurrentSelectedProjectFile.ProjectFileCollect.Items[FCOI].HiMECSConfig.ParamFileName);
//    
//          task.Invoke(
//            procedure
//            begin
//              DisplayMessage(rec.FMsg, rec.FDspTarget);
//            end
//          );
//        end;//while
//      end;//while
//    end,
//
//    Parallel.TaskConfig.OnMessage(Self).OnTerminated(
//      procedure
//      begin
//      end
//    )
//  );
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
//    CopySubtree(ManualCheckTV.Items.GetFirstNode, JvTreeView1, JvTreeView1.Items.GetFirstNode);
end;

procedure TMainForm.Button2Click(Sender: TObject);
//var
//  LJson: string;
begin
//  CreateJsonTreeViewFromTreeView(JvTreeView1, LJson, True);
//  LJson := GetStringFromTreeView(JvTreeView1);
//  ShowMessage(LJson);
//  LoadString2TreeView(JvTreeView1, LJson);
end;

end.
