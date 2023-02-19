program E2ServiceSnapShot2;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  UnitStringUtil in '..\..\..\..\..\..\..\project\common\UnitStringUtil.pas',
  UnitCompressUtil in '..\..\..\..\..\..\..\project\common\UnitCompressUtil.pas',
  UnitEnumHelper in '..\..\..\..\..\..\..\project\common\UnitEnumHelper.pas',
  UnitSimpleGenericEnum in '..\..\..\..\..\..\..\project\common\UnitSimpleGenericEnum.pas',
  UnitEngineMasterData in '..\..\..\..\..\..\..\project\util\GSManage\VesselList\UnitEngineMasterData.pas',
  UnitDragUtil in '..\..\..\..\..\..\..\project\common\UnitDragUtil.pas',
  HiMECSConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\HiMECSConst.pas',
  VarRecUtils in '..\..\..\..\..\..\..\project\common\openarr\source\VarRecUtils.pas',
  UnitExcelUtil in '..\..\..\..\..\..\..\project\common\UnitExcelUtil.pas',
  UnitSnapShotFrame2 in '..\HiMECS_Common\UnitSnapShotFrame2.pas' {SnapShotFrame2: TFrame},
  UnitZipFileUtil in '..\..\..\..\..\..\..\project\common\UnitZipFileUtil.pas',
  UnitDBXJsonUtil in '..\..\..\..\..\..\..\project\common\UnitDBXJsonUtil.pas',
  uSMBIOS in '..\..\..\..\..\..\..\project\OpenSrc\lib\TSmBios\Common\uSMBIOS.pas',
  IniPersist in '..\..\..\..\..\..\..\project\common\robstechcorner\rtti\IniPersist.pas',
  FrmAvatParamView2 in 'FrmAvatParamView2.pas' {AvatParamViewF},
  FrmAvatSnapShotNavigation2 in 'FrmAvatSnapShotNavigation2.pas' {SnapShotNaviF},
  FrmSnapShotCompareResult2 in 'FrmSnapShotCompareResult2.pas' {SSCompareResultF},
  UnitE2SRecord2 in 'UnitE2SRecord2.pas',
  UnitFrameSnapShotCompare2 in '..\HiMECS_Common\UnitFrameSnapShotCompare2.pas' {SnapShotCompareFrame2: TFrame},
  UnitFrameSnapShotNaviTV2 in '..\HiMECS_Common\UnitFrameSnapShotNaviTV2.pas' {SSNaviTVFrame: TFrame},
  FrmTestAvatSnapShot in 'FrmTestAvatSnapShot.pas' {TestAvatSSF},
  UnitSynZip2 in '..\..\..\..\Common\UnitSynZip2.pas',
  UnitEngineParamConst in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Source\Common\UnitEngineParamConst.pas',
  UnitArrayUtil in '..\..\..\..\..\..\..\project\common\UnitArrayUtil.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAvatParamViewF, AvatParamViewF);
  Application.Run;
end.
