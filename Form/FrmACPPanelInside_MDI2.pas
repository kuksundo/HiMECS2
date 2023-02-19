unit FrmACPPanelInside_MDI2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, HotSpotImage,
  UnitEngineElecPartClass2, FrameACPPanelInside;

type
  TACPInsideMDIF = class(TForm)
    FrameACP: TFrame2;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function Create_ACPPanelInside: integer;

var
  ACPInsideMDIF: TACPInsideMDIF;

implementation

uses UnitFormUtil, UnitHotSpotImgUtil;

{$R *.dfm}

function Create_ACPPanelInside: integer;
var
  i: integer;
begin
  i := CheckMDIChildAndShow(Application.MainForm, TACPInsideMDIF.ClassName);

  if i = -1 then
  begin
    TACPInsideMDIF.Create(Application);
    Result := i;
  end;
end;

procedure TACPInsideMDIF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
