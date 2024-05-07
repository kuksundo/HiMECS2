unit FrmPortForward;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, JvExButtons,
  JvBitBtn, Vcl.ExtCtrls, Vcl.ComCtrls, JvExComCtrls, JvListView;

type
  TForm1 = class(TForm)
    JvListView1: TJvListView;
    Panel1: TPanel;
    JvBitBtn1: TJvBitBtn;
    JvBitBtn2: TJvBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
