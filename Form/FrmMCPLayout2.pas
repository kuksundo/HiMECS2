unit FrmMCPLayout2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, HotSpotImage,
  Vcl.ExtCtrls,
  UnitEngineElecPartClass2;

type
  TMCPLayoutF = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    HotSpotImage1: THotSpotImage;
    procedure HotSpotImage1HotSpotClick(Sender: TObject; HotSpot: THotSpot);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure CreateOrShowMCPLayOutForm(AInfoRec: TPLCChannelInfoRec);

var
  MCPLayoutF: TMCPLayoutF;

implementation

uses FrmMCPPanel_SW1, UnitHotSpotImgUtil;

{$R *.dfm}

procedure CreateOrShowMCPLayOutForm(AInfoRec: TPLCChannelInfoRec);
begin
  MCPLayoutF := TMCPLayoutF.Create(nil);
  try
    DisplayHotSpotByName(MCPLayoutF.HotSpotImage1, AInfoRec.FTerminalName);
    MCPLayoutF.ShowModal;
  finally
    MCPLayoutF.Free;
  end;
end;

procedure TMCPLayoutF.HotSpotImage1HotSpotClick(Sender: TObject; HotSpot: THotSpot);
begin
  if HotSpot.Name = 'X01' then
  begin

  end
  else
  if HotSpot.Name = 'XF05' then
  begin
    Create_MCPPanel_SW1;
  end
  else
  if HotSpot.Name = 'XF01' then
  begin

  end
  else
  if HotSpot.Name = 'RELAY01' then
  begin

  end
end;

end.
