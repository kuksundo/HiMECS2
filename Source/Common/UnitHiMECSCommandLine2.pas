unit UnitHiMECSCommandLine2;
//Project Source에 UnitHiMECSCommandLine Unit Name이 UnitHiMECS unit보다 먼저 나와야 함
//왜냐하면 UnitHiMECSCommandLine Initialization 의 CommandLineParser함수 실행 후 UnitHiMECS Initialization이 실행 되어야 하기 때문임
interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.StrUtils,
  GpCommandLineParser;

type
  THiMECSCommandLine = class
  strict private
    FRCSIPAddress, //Reg Code Server IP Address
    FRCSPort, //Reg Code Server Port No
    FMasterPwd //Master Pwd ()
    : string;

    FSkipRegCheck, //Reg check skip을 위해서는 Master Passwd를 전달해 주어야 함
    FDeleteRegInfo
    : Boolean;

    FDecryptKind4SkipRegCheck //Skip Reg Check 시 암호를 Decrypt하는 방법 선택
    : integer;

    FUserFileName,
    FProjectFileName,
    FRegSvrIPAddr,
    FRegSvrPort,
    FRegSvrRoot: string;
  public
    class function CommandLineParse(var AHiMECSCLO: THiMECSCommandLine;
      var AErrMsg: string): boolean;

    [CLPLongName('UF'), CLPDescription('User File Name', '')]
    property UserFileName: string read FUserFileName write FUserFileName;
    [CLPLongName('PF'), CLPDescription('Project File Name', '')]
    property ProjectFileName: string read FProjectFileName write FProjectFileName;
    [CLPLongName('IP'), CLPDescription('Reg Server IP Address', '')]
    property RegSvrIPAddr: string read FRegSvrIPAddr write FRegSvrIPAddr;
    [CLPLongName('PO'), CLPDescription('Reg Server Port', '')]
    property RegSvrPort: string read FRegSvrPort write FRegSvrPort;
    [CLPLongName('RO'), CLPDescription('Reg Server Root', '')]
    property RegSvrRoot: string read FRegSvrRoot write FRegSvrRoot;

    [CLPLongName('SkipReg'), CLPDescription('Skip Reginfo check')]
    property SkipRegCheck: Boolean read FSkipRegCheck write FSkipRegCheck;
    [CLPLongName('rip'), CLPDescription('/rip:"xx.xx.xx.xx"'), CLPDefault('')]
    property RCSIPAddress: string read FRCSIPAddress write FRCSIPAddress;
    [CLPLongName('rport'), CLPDescription('Reg Code Server Port No'), CLPDefault('')]
    property RCSPort: string read FRCSPort write FRCSPort;
    [CLPLongName('Masterpw'), CLPDescription('Master Pwd'), CLPDefault('')]
    property MasterPwd: string read FMasterPwd write FMasterPwd;
    [CLPLongName('DelRegistry'), CLPDescription('Delete Reginfo from registry')]
    property DeleteRegInfo: boolean read FDeleteRegInfo write FDeleteRegInfo;
    [CLPName('DecKind'), CLPDescription('Decrypt Method for master passwd of Skip Reg Check'), CLPDefault('0')]
    property DecryptKind4SkipRegCheck: integer read FDecryptKind4SkipRegCheck write FDecryptKind4SkipRegCheck;
  end;

var
  g_HiMECSCommandLine: THiMECSCommandLine;

implementation

{ THiMECSCommandLine }

class function THiMECSCommandLine.CommandLineParse(
  var AHiMECSCLO: THiMECSCommandLine; var AErrMsg: string): boolean;
var
  LStr: string;
begin
  AErrMsg := '';
  AHiMECSCLO := THiMECSCommandLine.Create;
  try
//      CommandLineParser.Options := [opIgnoreUnknownSwitches];
    Result := CommandLineParser.Parse(AHiMECSCLO);
  except
    on E: ECLPConfigurationError do begin
      AErrMsg := '*** Configuration error ***' + #13#10 +
        Format('%s, position = %d, name = %s',
          [E.ErrorInfo.Text, E.ErrorInfo.Position, E.ErrorInfo.SwitchName]);
      Exit;
    end;
  end;

  if not Result then
  begin
    AErrMsg := Format('%s, position = %d, name = %s',
      [CommandLineParser.ErrorInfo.Text, CommandLineParser.ErrorInfo.Position,
       CommandLineParser.ErrorInfo.SwitchName]) + #13#10;
    for LStr in CommandLineParser.Usage do
      AErrMsg := AErrMSg + LStr + #13#10;
  end
  else
  begin
  end;
end;

initialization
  g_HiMECSCommandLine := nil;
  g_HiMECSCommandLine := THiMECSCommandLine.Create;

//  if Assigned(g_HiMECSCommandLine) then
    CommandLineParser.Parse(g_HiMECSCommandLine);

finalization
  if Assigned(g_HiMECSCommandLine) then
    FreeAndNil(g_HiMECSCommandLine);

end.
