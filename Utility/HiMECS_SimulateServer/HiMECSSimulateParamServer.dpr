program HiMECSSimulateParamServer;

uses
  mormot.db.raw.sqlite3.static,
  Vcl.Forms,
  UnitEngineMasterData in '..\..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitNextGridFrame in '..\..\..\..\..\..\..\project\common\Frames\UnitNextGridFrame.pas',
  UnitSCRData in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\SCRManage\UnitSCRData.pas',
  UnitEGCSData in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\EGCSManage\UnitEGCSData.pas',
  UnitFrameWatchGrid2 in '..\HiMECS_Common\UnitFrameWatchGrid2.pas' {FrameWatchGrid2: TFrame},
  UnitFrameIPCMonitorAll2 in '..\..\..\..\NoGitHub\Frame2\UnitFrameIPCMonitorAll2.pas' {FrameIPCMonitor2: TFrame},
  UnitSelectUser in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\UnitSelectUser.pas',
  UnitCopyModeMenu in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\UnitCopyModeMenu.pas',
  WatchConst2 in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\WatchConst2.pas',
  FrmParamManage2 in 'FrmParamManage2.pas' {ParamManageF},
  FrmSimulateParamEdit2 in 'FrmSimulateParamEdit2.pas' {SimulateParamEditF},
  UnitSimulateParamCommandLineOption2 in 'UnitSimulateParamCommandLineOption2.pas',
  UnitStatusDisplayCommandLineOption2 in 'UnitStatusDisplayCommandLineOption2.pas',
  UnitCommandLineUtil in '..\..\..\..\..\..\..\project\common\UnitCommandLineUtil.pas',
  UnitCopyWatchList2 in '..\HiMECS_Watch2\UnitCopyWatchList2.pas',
  UnitMEData4MAN in '..\..\..\MEManage\UnitMEData4MAN.pas';

{$R *.res}

  function ProcessCommandLineParse: Boolean;
  var
    LCLO: TpjhCommandLine<TSimulateParamCLO2>;
    LStr: string;
  begin
    Result := False;
    LCLO := TpjhCommandLine<TSimulateParamCLO2>.Create;
    try
      LCLO.CommandLineParse(LStr);

      Result := (LCLO.FCommandLine.JsonParamCollect <> '') and
        (LCLO.FCommandLine.CSVValues <> '');

      if Result then
      begin
        CreateParamManageR(LCLO);
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
