unit FrmACPLayout2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, HotSpotImage,
  Vcl.ExtCtrls,
  UnitEngineElecPartClass2;

type
  TACPLayoutF = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    HotSpotImage1: THotSpotImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure CreateOrShowMCPLayOutForm(AInfoRec: TPLCChannelInfoRec);

var
  ACPLayoutF: TACPLayoutF;

implementation

uses UnitHotSpotImgUtil;

{$R *.dfm}

procedure CreateOrShowMCPLayOutForm(AInfoRec: TPLCChannelInfoRec);
begin
  ACPLayoutF := TACPLayoutF.Create(nil);
  try
    DisplayHotSpotByName(ACPLayoutF.HotSpotImage1, AInfoRec.FTerminalName);
    ACPLayoutF.ShowModal;
  finally
    ACPLayoutF.Free;
  end;
end;

end.
