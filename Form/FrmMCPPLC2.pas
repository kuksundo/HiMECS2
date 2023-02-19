unit FrmMCPPLC2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, HotSpotImage,
  Vcl.ExtCtrls,
  FrmPLCChnnelInfo2, UnitEngineElecPartClass2;

type
  TMCPPLCF = class(TForm)
    MCP_MC210: TPanel;
    Panel1: TPanel;
    HotSpot_1KA01_MC210: THotSpotImage;
    Panel2: TPanel;
    Panel3: TPanel;
    HotSpot_1KA02_CM202: THotSpotImage;
    Panel4: TPanel;
    Panel5: TPanel;
    HotSpot_1T01_NT255: THotSpotImage;
    Panel6: TPanel;
    Panel7: TPanel;
    HotSpot_1KA04_DIO232: THotSpotImage;
    Panel8: TPanel;
    Panel9: TPanel;
    HotSpot_1KA05_GIO212_1: THotSpotImage;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    HotSpot_1KA07_AIO216_1: THotSpotImage;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    HotSpot_1KA09_AIO208SI: THotSpotImage;
    HotSpot_1KA08_AIO216_2: THotSpotImage;
    HotSpot_1KA06_GIO212_2: THotSpotImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HotSpot_1KA08_AIO216_2HotSpotDblClick(Sender: TObject;
      HotSpot: THotSpot);
    procedure HotSpot_1KA04_DIO232HotSpotDblClick(Sender: TObject;
      HotSpot: THotSpot);
    procedure HotSpot_1KA01_MC210HotSpotDblClick(Sender: TObject;
      HotSpot: THotSpot);
    procedure HotSpot_1KA02_CM202HotSpotDblClick(Sender: TObject;
      HotSpot: THotSpot);
  private
    procedure SetHotSpotFromName(AHotSpotImg: THotSpotImage; AName: string);
  public
    FPLCChannelInfoRec: TPLCChannelInfoRec;

    procedure DisplayHotSpotByPLCChannelInfoRec(APLCChannelInfoRec: TPLCChannelInfoRec);
    procedure DisplayPLCChInfoByHotSpotDblClk(AHotSpot: THotSpot);
  end;

  procedure CreateOrShowMCPPLCForm(AInfoRec: TPLCChannelInfoRec);
  function CrerateMDIChildPLCChInfoForm(AInfoRec: TPLCChannelInfoRec): integer;
var
  MCPPLCF: TMCPPLCF;

implementation

uses UnitFormUtil, UnitHotSpotImgUtil;

{$R *.dfm}

procedure CreateOrShowMCPPLCForm(AInfoRec: TPLCChannelInfoRec);
begin
  MCPPLCF := TMCPPLCF.Create(nil);
  try
    MCPPLCF.DisplayHotSpotByPLCChannelInfoRec(AInfoRec);
    MCPPLCF.ShowModal;
  finally
//    MCPPLCF.Free;
  end;
end;

function CrerateMDIChildPLCChInfoForm(AInfoRec: TPLCChannelInfoRec): integer;
var
  i: integer;
begin
  i := CheckMDIChildAndShow(Application.MainForm, TMCPPLCF.ClassName);

  if i = -1 then
  begin
    MCPPLCF := TMCPPLCF.Create(Application);
    MCPPLCF.DisplayHotSpotByPLCChannelInfoRec(AInfoRec);
    Result := i;
  end;

  MCPPLCF.Show;
end;

procedure TMCPPLCF.DisplayHotSpotByPLCChannelInfoRec(APLCChannelInfoRec: TPLCChannelInfoRec);
var
  LHotSpotImage: THotSpotImage;
begin
  LHotSpotImage := GetHotSpotImgByName(TForm(Self), APLCChannelInfoRec.FPLCModuleName);

  if Assigned(LHotSpotImage) then
  begin
    DisplayHotSpotByID(LHotSpotImage, APLCChannelInfoRec.FPlcChNo);
  end;
end;

procedure TMCPPLCF.DisplayPLCChInfoByHotSpotDblClk(AHotSpot: THotSpot);
begin
  FPLCChannelInfoRec := Default(TPLCChannelInfoRec);
  FPLCChannelInfoRec.FTagName := AHotSpot.Name;
  FPLCChannelInfoRec.FDesc := AHotSpot.Hint;

  CrerateOrShowPLCChInfoForm(FPLCChannelInfoRec);
end;

procedure TMCPPLCF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMCPPLCF.HotSpot_1KA01_MC210HotSpotDblClick(Sender: TObject;
  HotSpot: THotSpot);
begin
  DisplayPLCChInfoByHotSpotDblClk(HotSpot);
end;

procedure TMCPPLCF.HotSpot_1KA02_CM202HotSpotDblClick(Sender: TObject;
  HotSpot: THotSpot);
begin
  DisplayPLCChInfoByHotSpotDblClk(HotSpot);
end;

procedure TMCPPLCF.HotSpot_1KA04_DIO232HotSpotDblClick(Sender: TObject;
  HotSpot: THotSpot);
begin
  DisplayPLCChInfoByHotSpotDblClk(HotSpot);
end;

procedure TMCPPLCF.HotSpot_1KA08_AIO216_2HotSpotDblClick(Sender: TObject;
  HotSpot: THotSpot);
begin
  DisplayPLCChInfoByHotSpotDblClk(HotSpot);
end;

procedure TMCPPLCF.SetHotSpotFromName(AHotSpotImg: THotSpotImage;
  AName: string);
begin

end;

end.
