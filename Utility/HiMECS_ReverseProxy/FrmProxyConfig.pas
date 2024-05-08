unit FrmProxyConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, JvExMask, JvToolEdit;

type
  TTraderConfigF = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    TRFilenameEdit: TJvFilenameEdit;
    RealTypeFileEdit: TJvFilenameEdit;
    Label3: TLabel;
    CompanyFilenameEdit: TJvFilenameEdit;
    Label4: TLabel;
    JvFilenameEdit1: TJvFilenameEdit;
    TabSheet2: TTabSheet;
    Edit1: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    JvFilenameEdit2: TJvFilenameEdit;
    Label7: TLabel;
    Edit2: TEdit;
    Label8: TLabel;
    Edit3: TEdit;
    TabSheet3: TTabSheet;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label9: TLabel;
    Edit4: TEdit;
    Label10: TLabel;
    Edit5: TEdit;
    procedure TRFilenameEditButtonClick(Sender: TObject);
    procedure RealTypeFileEditButtonClick(Sender: TObject);
    procedure CompanyFilenameEditButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TraderConfigF: TTraderConfigF;

implementation

{$R *.dfm}

procedure TTraderConfigF.CompanyFilenameEditButtonClick(Sender: TObject);
begin
  CompanyFilenameEdit.InitialDir := ExtractFilePath(Application.ExeName);
end;

procedure TTraderConfigF.RealTypeFileEditButtonClick(Sender: TObject);
begin
  RealTypeFileEdit.InitialDir := ExtractFilePath(Application.ExeName);
end;

procedure TTraderConfigF.TRFilenameEditButtonClick(Sender: TObject);
begin
  TRFilenameEdit.InitialDir := ExtractFilePath(Application.ExeName);
end;

end.
