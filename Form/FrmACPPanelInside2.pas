unit FrmACPPanelInside2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, HotSpotImage,
  UnitEngineElecPartClass2, FrameACPPanelInside;

type
  TACPInsideF = class(TForm)
    FrameACP: TFrame2;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure CreateOrShowACPInsideForm(AInfoRec: TPLCChannelInfoRec);

var
  ACPInsideF: TACPInsideF;

implementation

uses UnitHotSpotImgUtil;

{$R *.dfm}

procedure CreateOrShowACPInsideForm(AInfoRec: TPLCChannelInfoRec);
begin
  ACPInsideF := TACPInsideF.Create(nil);
  try
    DisplayHotSpotByName(ACPInsideF.FrameACP.HotSpotImage1, AInfoRec.FTerminalName);
    ACPInsideF.ShowModal;
  finally
    ACPInsideF.Free;
  end;
end;

end.
