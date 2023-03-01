program HiMECSWatch2;

{$R 'PipeFlowDesigneR_RegInfo.res' '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\PipeFlowDesigneR_RegInfo.rc'}

uses
  mormot.db.raw.sqlite3.static,
  Forms,
  WatchConfig2 in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\WatchConfig2.pas' {WatchConfigF},
  HiMECSConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\HiMECSConst.pas',
  UnitAxisSelect in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\UnitAxisSelect.pas' {AxisSelectF},
  UnitAlarmConfig in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\UnitAlarmConfig.pas' {AlarmConfigF},
  UnitAlarmList in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\UnitAlarmList.pas',
  WatchConst2 in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\WatchConst2.pas',
  UnitCopyWatchList2 in 'UnitCopyWatchList2.pas' {CopyWatchListF},
  frmMainInterface in '..\..\..\..\..\..\..\project\util\VisualComm\frmMainInterface.pas',
  pjhDesignCompIntf in '..\..\..\..\..\..\..\project\util\VisualComm\Component\pjhDesignCompIntf.pas',
  UtilUnit in '..\..\..\..\..\..\..\project\util\VisualComm\util\UtilUnit.pas',
  pjhPanel in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\pjhPanel.pas',
  frmDocInterface in '..\..\..\..\..\..\..\project\util\VisualComm\frmDocInterface.pas',
  ScrollPanel2 in '..\..\..\..\..\..\..\project\util\VisualComm\Component\ScrollPanel2.pas',
  UnitSetMatrix2 in '..\HiMECS_Common\UnitSetMatrix2.pas',
  UnitCaptionInput in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\UnitCaptionInput.pas' {CaptionInputF},
  IPCThrd_HiMECS_MDI in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\IPCThrd_HiMECS_MDI.pas',
  CommonUtil in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusComm_kumo\common\CommonUtil.pas',
  UnitCopyModeMenu in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\UnitCopyModeMenu.pas' {CopyModeMenuF},
  WindowUtil in '..\..\..\..\..\..\..\project\common\WindowUtil.pas',
  IPCMonitorInterface in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\CommonFrame\IPCMonitorInterface.pas',
  UnitSelectUser in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\UnitSelectUser.pas' {SelectUserF},
  Generics.Legacy in '..\..\..\..\..\..\..\project\common\Generics.Legacy.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitModbusComConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\UnitModbusComConst.pas',
  pjhPipeFlowInterface in '..\..\..\..\..\..\..\project\util\VisualComm\Component\pjhxIOComp\pjhPipeFlowInterface.pas',
  UnitSelectControl in '..\..\..\..\..\..\..\project\common\UnitSelectControl.pas',
  pjhTJvTransparentButtonConst in '..\..\..\..\..\..\..\project\util\VisualComm\Component\pjhJvComp\pjhTJvTransparentButtonConst.pas',
  UnitRevFlowInterface in '..\..\..\..\..\..\..\project\util\VisualComm\Component\pjhxIOComp\UnitRevFlowInterface.pas',
  UnitPipeData in '..\..\..\..\..\..\..\vcl\pjhComponent\xIOComp\UnitPipeData.pas',
  UnitEnumHelper in '..\..\..\..\..\..\..\project\common\UnitEnumHelper.pas',
  UnitSimulateParamCommandLineOption2 in '..\HiMECS_SimulateServer\UnitSimulateParamCommandLineOption2.pas',
  UnitHGSCurriculumData in '..\..\..\..\..\..\..\project\util\GSManage\CertManage\UnitHGSCurriculumData.pas',
  FrmStringsEdit in '..\..\..\..\..\..\..\project\common\Forms\FrmStringsEdit.pas' {pjhStringsEditorDlg},
  UnitSimulateCommonData in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SimulateParamServer\UnitSimulateCommonData.pas',
  sndkey32 in '..\..\..\..\..\..\..\project\OpenSrc\lib\DelphiDabbler\sndkey32.pas',
  UnitTransparentBtnInterface in '..\..\..\..\..\..\..\project\util\VisualComm\Component\pjhJvComp\UnitTransparentBtnInterface.pas',
  UnitSimulateParamRecord2 in '..\HiMECS_SimulateServer\UnitSimulateParamRecord2.pas',
  UnitVesselData2 in '..\..\..\GSManage\VesselList\UnitVesselData2.pas',
  HiMECSWatchCommon2 in '..\HiMECS_Common\HiMECSWatchCommon2.pas',
  UnitParameterManager2 in '..\HiMECS_Common\UnitParameterManager2.pas' {$R *.res},
  UnitFrameWatchGrid2 in '..\HiMECS_Common\UnitFrameWatchGrid2.pas' {FrameWatchGrid2: TFrame},
  UnitFrameIPCMonitorAll2 in '..\..\..\..\NoGitHub\Frame2\UnitFrameIPCMonitorAll2.pas' {FrameIPCMonitor2: TFrame},
  HiMECS_Watch2 in 'HiMECS_Watch2.pas' {WatchF2},
  UnitJHCustomComponent in '..\..\..\..\..\..\..\vcl\pjhComponent\xIOComp\UnitJHCustomComponent.pas',
  FrmInputEdit in '..\..\..\..\..\..\..\project\common\Forms\FrmInputEdit.pas',
  UnitBalloonConst2 in 'UnitBalloonConst2.pas',
  pjhBalloonCompIntf in '..\..\..\..\..\..\..\project\util\VisualComm\Component\pjhDelphiStandardComp\pjhBalloonCompIntf.pas',
  Delphi.Mocks.Helpers in '..\..\..\..\OpenSrc\lib\Delphi-Mocks-master\Source\Delphi.Mocks.Helpers.pas';

{$R *.res}

begin
  //system.ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  {$IFDEF USECODESITE}
    //CodeSite.Enabled := True;
//    CodeSite.Enabled := CodeSite.Installed;
//
//    if CodeSite.Enabled then
//    begin
//      {Destination := TCodeSiteDestination.Create(Application);
//      Destination.LogFile.Active := True;
//      Destination.LogFile.FileName :=
//        ChangeFileExt(ExtractFileName(Application.ExeName), '.csl');
//      Destination.LogFile.FilePath := '$(MyDocs)\My CodeSite Files\Logs\';
//      CodeSite.Destination := Destination;  }
//      CodeSite.Clear;
//    end;
  {$ENDIF}
  //Application.ShowMainForm := False;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TWatchF2, WatchF2);
  Application.Run;
end.
