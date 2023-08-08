program HiMECS2;

{$R 'HiMECS_RegInfo.res' '..\..\..\..\..\..\project\util\HiMECS\Application\Source\HiMECS_RegInfo.rc'}

uses
  RunOne_HiMECS,
  Forms,
  mormot.db.raw.sqlite3.static,
  System.SysUtils,
  MainUnit2 in '..\Form\MainUnit2.pas' {MainForm},
  UnitHiMECSUserClass2 in 'Common\UnitHiMECSUserClass2.pas',
  UnitEngineBaseClass2 in 'Common\UnitEngineBaseClass2.pas',
  UnitMenuBaseClass2 in 'Common\UnitMenuBaseClass2.pas',
  HiMECSInterface in '..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\HiMECSInterface.pas',
  UnitVesselBaseClass2 in 'Common\UnitVesselBaseClass2.pas',
  CommonUtil in '..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusComm_kumo\common\CommonUtil.pas',
  FrmConfig2 in '..\Form\FrmConfig2.pas' {ConfigF},
  FrmParamList2 in '..\Form\FrmParamList2.pas' {FormParamList},
  EngineConst in '..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\EngineConst.pas',
  FrmLogin2 in '..\Form\FrmLogin2.pas' {FrmLogin},
  FrmSelectProject2 in '..\Form\FrmSelectProject2.pas' {SelectProjectForm},
  UnitSetMatrix2 in '..\Utility\HiMECS_Common\UnitSetMatrix2.pas' {SetMatrixForm},
  FrmConfigProjectFile2 in '..\Form\FrmConfigProjectFile2.pas' {ConfigProjectFileForm},
  FrmSetScalarValue2 in '..\Form\FrmSetScalarValue2.pas',
  UnitDummyForm in '..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\UnitDummyForm.pas' {DummyForm},
  UnitHiMECSMonitorListClass2 in 'Common\UnitHiMECSMonitorListClass2.pas',
  UnitHiMECSExeCollect2 in 'Common\UnitHiMECSExeCollect2.pas',
  UnitAutoRunClass2 in 'Common\UnitAutoRunClass2.pas',
  MonitornewApp_Unit in '..\..\..\..\..\..\project\util\HiMECS\Application\Utility\MON_LAUNCHER\Source\Forms\Common\MonitornewApp_Unit.pas' {newMonApp_Frm},
  CommnewApp_Unit in '..\..\..\..\..\..\project\util\HiMECS\Application\Utility\MON_LAUNCHER\Source\Forms\Common\CommnewApp_Unit.pas' {newCommApp_Frm},
  UnitTileConfig in '..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\UnitTileConfig.pas' {TileConfigF},
  IPCThrd_HiMECS_MDI in '..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\IPCThrd_HiMECS_MDI.pas',
  UnitKillProcessListClass2 in 'Common\UnitKillProcessListClass2.pas',
  UnitKillProcessList in '..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\UnitKillProcessList.pas' {KillProcessListF},
  FrmPdfViewMDIChild2 in '..\Form\FrmPdfViewMDIChild2.pas' {PDFViewMDIChildF},
  UnitEngineParamConst in '..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\UnitEngineParamConst.pas',
  UnitHiMECSCommandLine2 in 'Common\UnitHiMECSCommandLine2.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitModbusComConst in '..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\UnitModbusComConst.pas',
  UnitE2SRecord2 in '..\Utility\E2ServiceSnapShot\UnitE2SRecord2.pas',
  FrmAvatParamView2 in '..\Utility\E2ServiceSnapShot\FrmAvatParamView2.pas' {AvatParamViewF},
  UnitStringUtil in '..\..\..\..\..\..\project\common\UnitStringUtil.pas',
  UnitFormUtil in '..\..\..\..\..\..\project\common\UnitFormUtil.pas',
  UnitTreeViewUtil in '..\..\..\..\..\..\project\common\UnitTreeViewUtil.pas',
  FrmSensorCableRoute2 in '..\Form\FrmSensorCableRoute2.pas' {SensorCableRouteF},
  UnitEngineElecPartClass2 in 'Common\UnitEngineElecPartClass2.pas',
  DomSensorCQRS2 in '..\Utility\SensorList\Dom\DomSensorCQRS2.pas',
  DomSensorInterfaces2 in '..\Utility\SensorList\Dom\DomSensorInterfaces2.pas',
  DomSensorServices2 in '..\Utility\SensorList\Dom\DomSensorServices2.pas',
  DomSensorTypes2 in '..\Utility\SensorList\Dom\DomSensorTypes2.pas',
  FrmSensorCableRouteEdit2 in '..\Form\FrmSensorCableRouteEdit2.pas',
  MenuSaveUnit in '..\..\..\..\..\..\project\util\HiMECS\Application\Utility\MenuEditor\Forms\MenuSaveUnit.pas',
  FrmElecPart2 in '..\Form\FrmElecPart2.pas' {ElecPartF},
  UnitFramePdfView2 in '..\..\..\Common\Frame\UnitFramePdfView2.pas' {PdfViewFrame: TFrame},
  FrmPdfView2 in '..\Form\FrmPdfView2.pas',
  FrmSnapShotCompareResult2 in '..\Utility\E2ServiceSnapShot\FrmSnapShotCompareResult2.pas',
  FrmAvatSnapShotNavigation2 in '..\Utility\E2ServiceSnapShot\FrmAvatSnapShotNavigation2.pas' {SnapShotNaviF},
  FrmInputData1 in '..\..\..\..\..\..\project\common\Frames\FrmInputData1.pas',
  UnitSimulateParamCommandLineOption in '..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SimulateParamServer\UnitSimulateParamCommandLineOption.pas',
  UnitSimulateCommonData in '..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SimulateParamServer\UnitSimulateCommonData.pas',
  UnitEnumHelper in '..\..\..\..\..\..\project\common\UnitEnumHelper.pas',
  FormAboutDefs in '..\..\..\..\..\..\project\common\Forms\TFormAbout\FormAboutDefs.pas',
  FormAbout in '..\..\..\..\..\..\project\common\Forms\TFormAbout\FormAbout.pas',
  UnitStreamUtil in '..\..\..\..\..\..\project\common\UnitStreamUtil.pas',
  JHP.Util.gpSharedMem in '..\..\..\Common\JHP.Util.gpSharedMem.pas',
  JHP.Util.Bit in '..\..\..\Common\JHP.Util.Bit.pas',
  JHP.Util.Common in '..\..\..\Common\JHP.Util.Common.pas',
  CheckComboBox in '..\..\..\OpenSrc\lib\deltoo-master\Controls\CheckComboBox.pas',
  FrmMCPPanelInside_MDI2 in '..\Form\FrmMCPPanelInside_MDI2.pas' {MCPPanelInsideMDIF},
  FrameACPPanelInside in '..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\HotImgForm\Frame4FormStyleSwitch\FrameACPPanelInside.pas' {Frame2: TFrame},
  FrameLOPPanelInside in '..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\HotImgForm\Frame4FormStyleSwitch\FrameLOPPanelInside.pas' {Frame3: TFrame},
  FrmLOPPanelInside_MDI in '..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\HotImgForm\FrmLOPPanelInside_MDI.pas' {LOPPanelInsideMDIF},
  FrmACPPanelInside_MDI2 in '..\Form\FrmACPPanelInside_MDI2.pas',
  UnitNxInspectorUtil in '..\..\..\Common\UnitNxInspectorUtil.pas',
  UnitHiMECSRestAPIInterface in '..\Utility\HiMECS_Common\UnitHiMECSRestAPIInterface.pas',
  UnitFrameTileList2 in '..\..\..\Common\UnitFrameTileList2.pas' {TileListFrame: TFrame},
  FrmEngParamConfig2 in '..\Form\FrmEngParamConfig2.pas' {EngParamItemConfigForm2},
  UnitFrameEngParamDecTV2 in '..\Utility\HiMECS_Common\UnitFrameEngParamDecTV2.pas' {FrameDecTreeView2: TFrame},
  FrmSelectEquipment in '..\Form\FrmSelectEquipment.pas' {SelectEquipF},
  UnitHiMECSEquipListClass in 'Common\UnitHiMECSEquipListClass.pas',
  UnitTileListBase in 'Common\UnitTileListBase.pas',
  UnitProjectGroupClass in 'Common\UnitProjectGroupClass.pas';

{$R *.res}

  //var
  //Destination: TCodeSiteDestination;
begin
  //system.ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
