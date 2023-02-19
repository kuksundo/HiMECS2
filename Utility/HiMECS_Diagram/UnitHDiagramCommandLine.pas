unit UnitHDiagramCommandLine;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.StrUtils,
  GpCommandLineParser;

type
  THiMECSDiagramCommandLine = class
  strict private
    FURL: string;
  public
    [CLPLongName('URL'), CLPDescription('URL', '')]
    property URL: string read FURL write FURL;
  end;

var
  g_HiMECSDiagramCommandLine: THiMECSDiagramCommandLine;

implementation

initialization
  g_HiMECSDiagramCommandLine := nil;
  g_HiMECSDiagramCommandLine := THiMECSDiagramCommandLine.Create;

finalization
  if Assigned(g_HiMECSDiagramCommandLine) then
    FreeAndNil(g_HiMECSDiagramCommandLine);
end.
