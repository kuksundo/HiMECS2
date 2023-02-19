unit FrmFindWatchGrid;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  JvExControls, JvLabel;

type
  TFindWatchGridF = class(TForm)
    FindStrEdit: TEdit;
    OptionRG: TRadioGroup;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FindWatchGridF: TFindWatchGridF;

implementation

{$R *.dfm}

end.
