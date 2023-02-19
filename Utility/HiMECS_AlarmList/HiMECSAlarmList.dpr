program HiMECSAlarmList;

uses
  Forms,
  mormot.db.raw.sqlite3.static,
  UnitCopyWatchList in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\UnitCopyWatchList.pas' {CopyWatchListF},
  WatchConst2 in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\Watch2\WatchConst2.pas',
  UtilUnit in '..\..\..\..\..\..\..\project\util\VisualComm\util\UtilUnit.pas',
  UnitJSONPersist2 in '..\..\..\..\Common\UnitJSONPersist2.pas',
  UnitSelectUser in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Forms\UnitSelectUser.pas' {SelectUserF},
  UnitRttiUtil2 in '..\..\..\..\Common\UnitRttiUtil2.pas',
  UnitConfigIniClass2 in '..\..\..\..\..\..\..\project\common\UnitConfigIniClass2.pas',
  Bcrypt in '..\..\..\..\..\..\..\project\OpenSrc\lib\bcrypt-for-delphi-master\Bcrypt.pas',
  SCrypt in '..\..\..\..\..\..\..\project\OpenSrc\lib\scrypt-for-delphi-master\SCrypt.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  VarRecUtils in '..\..\..\..\..\..\..\project\common\openarr\source\VarRecUtils.pas',
  uSMBIOS in '..\..\..\..\..\..\..\project\OpenSrc\lib\TSmBios\Common\uSMBIOS.pas',
  UnitModbusComConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusCommunication\UnitModbusComConst.pas',
  UnitFontUtil in '..\..\..\..\Common\UnitFontUtil.pas',
  XSuperObject in '..\..\..\..\OpenSrc\lib\x-superobject-master\XSuperObject.pas',
  FrmSensorCableRoute2 in '..\..\Form\FrmSensorCableRoute2.pas',
  FrmSensorCableRouteEdit2 in '..\..\Form\FrmSensorCableRouteEdit2.pas',
  UnitFramePdfView2 in '..\..\..\..\Common\Frame\UnitFramePdfView2.pas',
  UnitFrameIPCMonitorAll2 in '..\..\..\..\NoGitHub\Frame2\UnitFrameIPCMonitorAll2.pas',
  FrmHiMECSAlarmList in 'FrmHiMECSAlarmList.pas' {FormAlarmList};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormAlarmList, FormAlarmList);
  Application.Run;
end.
