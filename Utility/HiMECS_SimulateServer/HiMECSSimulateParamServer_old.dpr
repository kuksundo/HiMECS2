program HiMECSSimulateParamServer_old;

uses
  Vcl.Forms,
  {$IfDef USE_REGCODE}
  UnitRegistrationUtil,
  {$EndIf USE_REGCODE}
  mormot.db.raw.sqlite3.static,
  FrmParamManage2 in 'FrmParamManage2.pas' {ParamManageF},
  UnitSimulateParamRecord in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SimulateParamServer\UnitSimulateParamRecord.pas',
  VarRecUtils in '..\..\..\..\..\..\..\project\common\openarr\source\VarRecUtils.pas',
  UnitHGSCurriculumData in '..\..\..\..\..\..\..\project\util\GSManage\CertManage\UnitHGSCurriculumData.pas',
  FrameGSFileList in '..\..\..\..\..\..\..\project\common\Frames\FrameGSFileList.pas',
  UnitGSFileRecord in '..\..\..\..\..\..\..\project\util\GSManage\UnitGSFileRecord.pas',
  FrmFileSelect in '..\..\..\..\..\..\..\project\util\GSManage\FrmFileSelect.pas',
  UnitElecServiceData in '..\..\..\..\..\..\..\project\util\GSManage\UnitElecServiceData.pas',
  FrmSimulateParamEdit in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\FrmSimulateParamEdit.pas',
  UnitGSFileData in '..\..\..\..\..\..\..\project\util\GSManage\UnitGSFileData.pas',
  UnitCommandLineUtil in '..\..\..\..\..\..\..\project\common\UnitCommandLineUtil.pas',
  GpCommandLineParser in '..\..\..\..\..\..\..\project\common\GpDelphiUnit\src\GpCommandLineParser.pas',
  UnitSimulateParamCommandLineOption in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SimulateParamServer\UnitSimulateParamCommandLineOption.pas',
  UnitFGSSData in '..\..\..\..\..\..\..\project\util\GSManage\FGSSManage\UnitFGSSData.pas',
  UnitBase64Util in '..\..\..\..\..\..\..\project\common\UnitBase64Util.pas',
  UnitVesselData in '..\..\..\..\..\..\..\project\util\GSManage\VesselList\UnitVesselData.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitModbusComConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\UnitModbusComConst.pas',
  UnitStrategy4SimulateEventIntf in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SimulateParamServer\UnitStrategy4SimulateEventIntf.pas',
  UnitSCRData in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SCRManage\UnitSCRData.pas',
  UnitFormUtil in '..\..\..\..\..\..\..\project\common\UnitFormUtil.pas',
  FrmSCRSimulate in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SimulateParamServer\FrmSCRSimulate.pas' {SCROpSimF},
  IPC.Events in '..\..\..\..\..\..\..\project\common\IPC.Events.pas',
  UnitNextGridFrame in '..\..\..\..\..\..\..\project\common\Frames\UnitNextGridFrame.pas' {Frame1: TFrame},
  UnitParameterManager in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\UnitParameterManager.pas',
  UnitCopyWatchList in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\UnitCopyWatchList.pas' {CopyWatchListF},
  UnitEngParamConfig in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\UnitEngParamConfig.pas' {EngParamItemConfigForm},
  UnitSetMatrix in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\UnitSetMatrix.pas' {SetMatrixForm},
  UnitSelectUser in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\UnitSelectUser.pas' {SelectUserF},
  UnitCopyModeMenu in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\UnitCopyModeMenu.pas' {CopyModeMenuF},
  WatchConst2 in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\WatchConst2.pas',
  UnitEGCSData in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\EGCSManage\UnitEGCSData.pas',
  FrmEGCSSimulate in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SimulateParamServer\FrmEGCSSimulate.pas' {EGCSOpSimF},
  UnitHookConst in '..\..\..\..\..\..\..\project\util\MacroManagement\UnitHookConst.pas',
  UnitVesselData2 in '..\..\..\GSManage\VesselList\UnitVesselData2.pas';

{$R *.res}

  function ProcessCommandLineParse: Boolean;
  var
    LCLO: TpjhCommandLine<TSimulateParamCLO>;
    LStr: string;
  begin
    Result := False;
    LCLO := TpjhCommandLine<TSimulateParamCLO>.Create;
    try
      LCLO.CommandLineParse(LStr);

      Result := (LCLO.FCommandLine.JsonParamCollect <> '') and
        (LCLO.FCommandLine.CSVValues <> '');

      if Result then
      begin
        CreateParamManageR(LCLO);
//        CreateParamManageR(LCLO.FCommandLine.JsonParamCollect,
//          LCLO.FCommandLine.CSVValues, LCLO.FCommandLine.fParamSourceList,
//          LCLO.FCommandLine.FParamFileName, LCLO.FCommandLine.FAdditionalData);
      end;
    finally
      LCLO.Free;
    end;
  end;
begin

  {$IfDef USE_REGCODE}
    //UnitCryptUtil.EncryptString_Syn('{F821E37C-3396-4116-BA75-44584EC5E60B}', True)
    CheckRegistration('z6ebxalCblfdZrR/ApkRClfTbECFVKR11jxj2zkeuvyU6sDairtQ7GjIot1YfkL3KAWz9IBfP3M94xrYl1JcJg==', [crmHTTP]);
  {$EndIf USE_REGCODE}

  if ProcessCommandLineParse then
    halt(0);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TParamManageF, ParamManageF);
  Application.Run;
end.
