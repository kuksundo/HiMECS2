unit FrmACPPLC2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, HotSpotImage,
  Vcl.ExtCtrls,
  UnitEngineElecPartClass2;

type
  TACPPLCF = class(TForm)
    SM_MX213: TPanel;
    Panel1: TPanel;
    HotSpotImage1: THotSpotImage;
    Panel2: TPanel;
    Panel3: TPanel;
    HotSpotImage2: THotSpotImage;
    Panel4: TPanel;
    Panel5: TPanel;
    HotSpotImage3: THotSpotImage;
    Panel6: TPanel;
    Panel7: TPanel;
    HotSpotImage8: THotSpotImage;
    Panel8: TPanel;
    Panel9: TPanel;
    HotSpotImage9: THotSpotImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure CreateOrShowACPPLCForm(AInfoRec: TPLCChannelInfoRec);

var
  ACPPLCF: TACPPLCF;

implementation

uses FrmPLCChnnelInfo2;

{$R *.dfm}

procedure CreateOrShowACPPLCForm(AInfoRec: TPLCChannelInfoRec);
begin
  ACPPLCF := TACPPLCF.Create(nil);
  try
    ACPPLCF.ShowModal;
  finally
    ACPPLCF.Free;
  end;
end;

end.
