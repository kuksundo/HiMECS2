unit UnitFrameMCPPanelInside2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg,
  HotSpotImage;

type
  TMCPPanelInsideFrame = class(TFrame)
    HotSpotImage1: THotSpotImage;
    procedure HotSpotImage1HotSpotClick(Sender: TObject; HotSpot: THotSpot);
  private
    { Private declarations }
  public
  end;

implementation

uses FrmMCPPanel_X30, FrmMCPPanel_Relay1, FrmMCPPanel_SW1, FrmMCPPanel_X04,
  FrmMCPPanel_X04_07, FrmMCPPanel_X05, FrmMCPPanel_X12_01, FrmMCPPanel_X20,
  FrmMCPPanel_X23, FrmMCPPanel_X24, FrmMCPPanel_X25, FrmMCPPanel_X31,
  UnitEngineElecPartClass2, FrmMCPPLC2;

{$R *.dfm}

procedure TMCPPanelInsideFrame.HotSpotImage1HotSpotClick(Sender: TObject; HotSpot: THotSpot);
var
  LInfoRec: TPLCChannelInfoRec;
begin
  if HotSpot.Name = 'MCP_PLC' then
    CreateOrShowMCPPLCForm(LInfoRec)
  else
  if HotSpot.Name = 'MCP_X30' then
    FrmMCPPanel_X30.Create_MCPPanel_X30
  else
  if HotSpot.Name = 'MCP_X31' then
    FrmMCPPanel_X31.Create_MCPPanel_X31
  else
  if HotSpot.Name = 'MCPPanel_X04_07' then
    FrmMCPPanel_X04_07.Create_MCPPanel_X04_07
  else
  if HotSpot.Name = 'MCP_SW1' then
    FrmMCPPanel_SW1.Create_MCPPanel_SW1
  else
  if HotSpot.Name = 'MCP_X12_01' then
    FrmMCPPanel_X12_01.Create_MCPPanel_X12_01
  else
  if HotSpot.Name = 'MCP_X05' then
    FrmMCPPanel_X05.Create_MCPPanel_X05
  else
  if HotSpot.Name = 'MCP_Relay1' then
    FrmMCPPanel_Relay1.Create_MCPPanel_Relay1
  else
  if HotSpot.Name = 'MCP_X20' then
    FrmMCPPanel_X20.Create_MCPPanel_X20
  else
  if HotSpot.Name = 'MCP_X25' then
    FrmMCPPanel_X25.Create_MCPPanel_X25
  else
  if HotSpot.Name = 'MCP_X24' then
    FrmMCPPanel_X24.Create_MCPPanel_X24
  else
  if HotSpot.Name = 'MCP_X23_IE37' then
    FrmMCPPanel_X23.Create_MCPPanel_X23;
end;

end.
