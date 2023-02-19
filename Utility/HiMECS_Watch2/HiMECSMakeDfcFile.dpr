program HiMECSMakeDfcFile;

uses
  Vcl.Forms,
  FrmMakeDfcFile in 'FrmMakeDfcFile.pas' {MakeDfcFileF},
  UnitFrameFileList2 in '..\..\..\..\Common\Frame\UnitFrameFileList2.pas' {JHPFileListFrame},
  UnitDragUtil in '..\..\..\..\..\..\..\project\common\UnitDragUtil.pas',
  FrmFileList in '..\..\..\..\Common\Form\FrmFileList.pas' {FileListF},
  UnitJHPFileData in '..\..\..\..\Common\DataType\UnitJHPFileData.pas',
  UnitEnumHelper2 in '..\..\..\..\..\..\..\project\common\UnitEnumHelper2.pas',
  FrmFileSelect in '..\..\..\..\Common\Form\FrmFileSelect.pas',
  UnitJHPFileRecord in '..\..\..\..\Common\DataType\UnitJHPFileRecord.pas',
  UnitOrmFileClient in 'UnitOrmFileClient.pas',
  DesignFormConfigClass2 in '..\HiMECS_Watch\DesignFormConfigClass2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMakeDfcFileF, MakeDfcFileF);
  Application.CreateForm(TFileListF, FileListF);
  Application.Run;
end.
