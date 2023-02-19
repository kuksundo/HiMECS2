unit UnitStatusDisplayCommandLineOption2;

interface

uses classes, GpCommandLineParser;

type
  TStatusDisplayCLO2 = class//CLO: CommandLineOption
    FParamFileName,
    FJsonParamList: string;
  public
    [CLPName('p'), CLPLongName('ParamDB'), CLPDescription('Engine Parameter DB Name'), CLPDefault('')]
    property ParamFileName: string read FParamFileName write FParamFileName;
    [CLPName('j'), CLPLongName('JsonParam', 'ParamList'), CLPDescription('Json Param Collect.')]
    property JsonParamList: string read FJsonParamList write FJsonParamList;
  end;

implementation

end.
