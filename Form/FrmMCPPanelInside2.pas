unit FrmMCPPanelInside2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, UnitEngineElecPartClass2,
  UnitFrameMCPPanelInside2;

type
  TMCPPanelInsideF = class(TForm)
    FrameMCP: TMCPPanelInsideFrame;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure CreateOrShowMCPInsideForm(AInfoRec: TPLCChannelInfoRec);

var
  MCPPanelInsideF: TMCPPanelInsideF;

implementation

uses UnitFormUtil, UnitHotSpotImgUtil;

{$R *.dfm}

procedure CreateOrShowMCPInsideForm(AInfoRec: TPLCChannelInfoRec);
begin
  MCPPanelInsideF := TMCPPanelInsideF.Create(nil);
  try
    if AInfoRec.FTerminalName <> '' then
      DisplayHotSpotByName(MCPPanelInsideF.FrameMCP.HotSpotImage1, AInfoRec.FPanelName + '_' + AInfoRec.FTerminalName);

    MCPPanelInsideF.ShowModal;
  finally
    MCPPanelInsideF.Free;
  end;
end;

procedure TMCPPanelInsideF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
