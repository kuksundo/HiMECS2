unit FrmHiMECSAlarmConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, JvExControls, JvComCtrls, JvToolEdit,
  Mask, JvExMask, ComCtrls, IniPersist, Vcl.Samples.Spin, UnitConfigIniClass2,
  JvExStdCtrls, JvCombobox, JvColorCombo, AdvGlowButton, AdvOfficeSelectors;

type
  TConfigSettings = class (TINIConfigBase)
  private
    FSharedName: String;
    FServerIP: string;
    FServerPort: string;
    FUserId: string;
    FUserPasswd: string;
  public
    [IniValue('Comm Server','Shared Name','')]
    property SharedName : String read FSharedName write FSharedName;
    [IniValue('Comm Server','Server IP','')]
    property ServerIP : String read FServerIP write FServerIP;
    [IniValue('Comm Server','Server Port','')]
    property ServerPort : String read FServerPort write FServerPort;
    [IniValue('Comm Server','User ID','')]
    property UserId : String read FUserId write FUserId;
    [IniValue('Comm Server','PassWord','')]
    property UserPasswd : String read FUserPasswd write FUserPasswd;
  end;

  TAlarmConfigF = class(TForm)
    PageControl1: TPageControl;
    Tabsheet2: TTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    AlarmDBFilenameEdit: TJvFilenameEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ManualFileEdit: TJvFilenameEdit;
    Label2: TLabel;
    AlarmItemFileEdit: TJvFilenameEdit;
    RelPathCB: TCheckBox;
    TabSheet1: TTabSheet;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label9: TLabel;
    Label23: TLabel;
    ServerIPEdit: TEdit;
    UserEdit: TEdit;
    PasswdEdit: TEdit;
    ReConnectIntervalEdit: TSpinEdit;
    ServerPortEdit: TEdit;
    SharedNameEdit: TEdit;
    TabSheet3: TTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ServerEdit: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    TableNameCombo: TComboBox;
    SpinEdit1: TSpinEdit;
    CreateDBIntervalRG: TRadioGroup;
    ED_csv: TEdit;
    Label4: TLabel;
    FontDialog1: TFontDialog;
    Button1: TButton;
    TabSheet4: TTabSheet;
    AlarmCellColorSelector: TAdvOfficeColorSelector;
    Label5: TLabel;
    Label11: TLabel;
    AlarmTextColorSelector: TAdvOfficeColorSelector;
    Label14: TLabel;
    ShutdownCellColorSelector: TAdvOfficeColorSelector;
    Label15: TLabel;
    ShutdownTextColorSelector: TAdvOfficeColorSelector;
    procedure FontDialog1Apply(Sender: TObject; Wnd: HWND);
    procedure Button1Click(Sender: TObject);
  private
    FAlarmFont: string;

    procedure SetFAlarmFont(AFontJson: string);
  published
    property AlarmFont: string read FAlarmFont write SetFAlarmFont;
  end;

var
  AlarmConfigF: TAlarmConfigF;

implementation

uses UnitFontUtil;

{$R *.dfm}

procedure TAlarmConfigF.Button1Click(Sender: TObject);
begin
  FontDialog1.Execute();
end;

procedure TAlarmConfigF.FontDialog1Apply(Sender: TObject; Wnd: HWND);
begin
  AlarmFont := SetFont2Json(TFontDialog(Sender).Font);
end;

procedure TAlarmConfigF.SetFAlarmFont(AFontJson: string);
begin
  FAlarmFont := AFontJson;
  LoadFontFromJson(AFontJson, FontDialog1.Font);
end;

end.
