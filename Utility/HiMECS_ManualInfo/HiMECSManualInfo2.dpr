program HiMECSManualInfo2;

uses
  Vcl.Forms,
  mormot.db.raw.sqlite3.static,
  UnitManualInfo2 in 'UnitManualInfo2.pas' {Form1},
  CommonUtil in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\ModbusComm_kumo\common\CommonUtil.pas',
  UnitFolderSelect in '..\..\..\..\..\..\..\project\util\HiMECS\Application\Utility\HiMECSManualInfo\UnitFolderSelect.pas' {FolderSelectF},
  RegExpr in '..\..\..\..\..\..\..\project\OpenSrc\lib\mORMot\SQLite3\Samples\ThirdPartyDemos\Migajek\synopse-sqlite-generator\RegExpr.pas',
  UnitStringUtil in '..\..\..\..\..\..\..\project\Common\UnitStringUtil.pas',
  UnitPdfiumUtil in '..\..\..\..\Common\UnitPdfiumUtil.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
