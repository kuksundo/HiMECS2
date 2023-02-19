unit FrmPLCChnnelInfo2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  JvExControls, JvLabel, UnitEngineElecPartClass2, CopyData;

type
  TPLCChannelInfoF = class(TForm)
    Panel1: TPanel;
    JvLabel10: TJvLabel;
    DescEdit: TEdit;
    JvLabel1: TJvLabel;
    TagNameEdit: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure CrerateOrShowPLCChInfoForm(AInfoRec: TPLCChannelInfoRec);

var
  PLCChannelInfoF: TPLCChannelInfoF;

implementation

uses UnitFormUtil;

{$R *.dfm}

procedure CrerateOrShowPLCChInfoForm(AInfoRec: TPLCChannelInfoRec);
begin
  PLCChannelInfoF := TPLCChannelInfoF.Create(nil);
  try
    PLCChannelInfoF.TagNameEdit.Text := AInfoRec.FTagName;
    PLCChannelInfoF.DescEdit.Text := AInfoRec.FDesc;
    PLCChannelInfoF.ShowModal;
  finally
    PLCChannelInfoF.Free;
  end;
end;

procedure CrerateMDIChildPLCChInfoForm(AInfoRec: TPLCChannelInfoRec);
begin

end;

procedure TPLCChannelInfoF.Button1Click(Sender: TObject);
begin
  if TagNameEdit.Text = '' then
    ShowMessage('Tag Name is null!')
  else
    SendCopyData2(Application.MainFormHandle, TagNameEdit.Text, 1);
end;

end.
