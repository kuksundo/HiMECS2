unit FrmMCPPanelInside_MDI2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitEngineElecPartClass2,
  UnitFrameMCPPanelInside2;

type
  TMCPPanelInsideMDIF = class(TForm)
    FrameMCP: TMCPPanelInsideFrame;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function Create_MCPPanelInside: integer;

var
  MCPPanelInsideMDIF: TMCPPanelInsideMDIF;

implementation

uses UnitFormUtil, UnitHotSpotImgUtil;

{$R *.dfm}

function Create_MCPPanelInside: integer;
var
  i: integer;
begin
  i := CheckMDIChildAndShow(Application.MainForm, TMCPPanelInsideMDIF.ClassName);

  if i = -1 then
  begin
    TMCPPanelInsideMDIF.Create(Application);
    Result := i;
  end;
end;

//exports
//  Create_MCPPanelInside;

procedure TMCPPanelInsideMDIF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
