unit FrmConfig2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Mask, JvExControls, JvComCtrls,
  JvExMask, JvToolEdit, UnitHiMECSConfigCollect2, HiMECSConst;

type
  TConfigF = class(TForm)
    PageControl1: TPageControl;
    Tabsheet2: TTabSheet;
    Label1: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    TabSheet1: TTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    TabSheet4: TTabSheet;
    Label14: TLabel;
    Label15: TLabel;
    PortNumEdit: TEdit;
    JvIPAddress1: TJvIPAddress;
    MenuFilenameEdit: TJvFilenameEdit;
    FormPathEdit: TJvDirectoryEdit;
    Label8: TLabel;
    ConfigPathEdit: TJvDirectoryEdit;
    Label9: TLabel;
    DocPathEdit: TJvDirectoryEdit;
    Label10: TLabel;
    ExePathEdit: TJvDirectoryEdit;
    Label13: TLabel;
    LogPathEdit: TJvDirectoryEdit;
    Label3: TLabel;
    EngInfoFilenameEdit: TJvFilenameEdit;
    Label2: TLabel;
    ParamFilenameEdit: TJvFilenameEdit;
    TabSheet3: TTabSheet;
    CBExtAppInMDI: TCheckBox;
    Label4: TLabel;
    UserFilenameEdit: TJvFilenameEdit;
    Label5: TLabel;
    BplPathEdit: TJvDirectoryEdit;
    Label11: TLabel;
    ProjInfoFilenameEdit: TJvFilenameEdit;
    ConfFileFormatRG: TRadioGroup;
    EngParamEncryptCB: TCheckBox;
    TabSheet5: TTabSheet;
    SelProtocolRG: TRadioGroup;
    UpdateCB: TCheckBox;
    URLEdit: TEdit;
    GroupBox1: TGroupBox;
    Label16: TLabel;
    HostEdit: TEdit;
    Label17: TLabel;
    PortEdit: TEdit;
    Label18: TLabel;
    UserIdEdit: TEdit;
    Label19: TLabel;
    PasswdEdit: TEdit;
    Label20: TLabel;
    DirEdit: TEdit;
    Label21: TLabel;
    CBUseMonLauncher: TCheckBox;
    CBUseCommLauncher: TCheckBox;
    Label12: TLabel;
    KillProcFilenameEdit: TJvFilenameEdit;
    Label22: TLabel;
    ManualInfoFilenameEdit: TJvFilenameEdit;
    Panel2: TPanel;
    RelativeCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure SelProtocolRGClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EngInfoFilenameEditAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure MenuFilenameEditAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure UserFilenameEditAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure ParamFilenameEditAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure ProjInfoFilenameEditAfterDialog(Sender: TObject;
      var AName: string; var AAction: Boolean);
    procedure ManualInfoFilenameEditAfterDialog(Sender: TObject;
      var AName: string; var AAction: Boolean);
    procedure KillProcFilenameEditAfterDialog(Sender: TObject;
      var AName: string; var AAction: Boolean);
    procedure FormPathEditAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure ConfigPathEditAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure DocPathEditAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure ExePathEditAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure BplPathEditAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure LogPathEditAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
  private
    procedure SetConfigData(Sender: TObject);
    procedure SetDefault2Config(AForm: TConfigF);
  public
    FHiMECSConfig: THiMECSConfig;

    procedure LoadConfigCollect2Form(AForm: TConfigF);
    procedure LoadConfigForm2Collect(AForm: TConfigF);
    procedure LoadConfigCollectFromFile(AFileName: string; AIsEncrypt: Boolean);
    procedure SaveConfig(AFileName: string; AIsEncrypt: Boolean);
  end;

var
  ConfigF: TConfigF;

implementation

uses CommonUtil;

{$R *.dfm}

{ TConfigF }

procedure TConfigF.BplPathEditAfterDialog(Sender: TObject; var AName: string;
  var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.ConfigPathEditAfterDialog(Sender: TObject; var AName: string;
  var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.DocPathEditAfterDialog(Sender: TObject; var AName: string;
  var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.EngInfoFilenameEditAfterDialog(Sender: TObject;
  var AName: string; var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.ExePathEditAfterDialog(Sender: TObject; var AName: string;
  var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.FormCreate(Sender: TObject);
begin
  FHiMECSConfig := THiMECSConfig.Create(Self);
end;

procedure TConfigF.FormDestroy(Sender: TObject);
begin
  if Assigned(FHiMECSConfig) then
    FreeAndNil(FHiMECSConfig);
end;

procedure TConfigF.FormPathEditAfterDialog(Sender: TObject; var AName: string;
  var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.KillProcFilenameEditAfterDialog(Sender: TObject;
  var AName: string; var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.LoadConfigCollect2Form(AForm: TConfigF);
begin
  AForm.MenuFilenameEdit.Text := FHiMECSConfig.MenuFileName;
  AForm.EngInfoFilenameEdit.Text := FHiMECSConfig.EngineInfoFileName;
  AForm.ParamFilenameEdit.Text := FHiMECSConfig.ParamFileName;
  AForm.ProjInfoFilenameEdit.Text := FHiMECSConfig.ProjectInfoFileName;
  AForm.UserFilenameEdit.Text := FHiMECSConfig.UserFileName;
  AForm.ManualInfoFilenameEdit.Text := FHiMECSConfig.ManualInfoFileName;
  AForm.KillProcFilenameEdit.Text := FHiMECSConfig.KillProcListFileName;

  AForm.FormPathEdit.Text :=   FHiMECSConfig.HiMECSFormPath;
  AForm.ConfigPathEdit.Text := FHiMECSConfig.ConfigPath;
  AForm.DocPathEdit.Text := FHiMECSConfig.DocPath;
  AForm.ExePathEdit.Text := FHiMECSConfig.ExesPath;
  AForm.BplPathEdit.Text := FHiMECSConfig.BplsPath;
  AForm.LogPathEdit.Text := FHiMECSConfig.LogPath;

  SetDefault2Config(AForm);

  AForm.CBExtAppInMDI.Checked := FHiMECSConfig.ExtAppInMDI;
  AForm.CBUseMonLauncher.Checked := FHiMECSConfig.UseMonLauncher;
  AForm.CBUseCommLauncher.Checked := FHiMECSConfig.UseCommLauncher;
  AForm.EngParamEncryptCB.Checked := FHiMECSConfig.EngParamEncrypt;
  AForm.ConfFileFormatRG.ItemIndex := FHiMECSConfig.EngParamFileFormat;

  AForm.SelProtocolRG.ItemIndex := FHiMECSConfig.UpdateProtocol;
  AForm.HostEdit.Text := FHiMECSConfig.FTPHost;
  AForm.PortEdit.Text := IntToStr(FHiMECSConfig.FTPPort);
  AForm.UserIdEdit.Text := FHiMECSConfig.FTPUserID;
  AForm.PasswdEdit.Text := FHiMECSConfig.FTPPasswd;
  AForm.DirEdit.Text := FHiMECSConfig.FTPDirectory;
  AForm.URLEdit.Text := FHiMECSConfig.ServerURL;
  AForm.UpdateCB.Checked := FHiMECSConfig.UpdateWhenStart;
end;

procedure TConfigF.LoadConfigCollectFromFile(AFileName: string;
  AIsEncrypt: Boolean);
begin
  if AFileName <> '' then
  begin
    FHiMECSConfig.Clear;
    FHiMECSConfig.LoadFromJSONFile(AFileName,ExtractFileName(AFileName),AIsEncrypt);
  end
  else
    ShowMessage('Config File name is empty!');
end;

procedure TConfigF.LoadConfigForm2Collect(AForm: TConfigF);
var
  LPath: string;
begin
  LPath := ExtractFilePath(Application.ExeName);

  with FHiMECSConfig, AForm do
  begin
    SetDefault2Config(AForm);

    MenuFileName := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(MenuFilenameEdit.Text)))
                              + ExtractFileName(MenuFilenameEdit.Text);
    EngineInfoFileName := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(EngInfoFilenameEdit.Text)))
                              + ExtractFileName(EngInfoFilenameEdit.Text);
    ParamFileName := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(ParamFilenameEdit.Text)))
                              + ExtractFileName(AForm.ParamFilenameEdit.Text);
    ProjectInfoFileName := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(ProjInfoFilenameEdit.Text)))
                              + ExtractFileName(ProjInfoFilenameEdit.Text);
    UserFileName := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(UserFilenameEdit.Text)))
                              + ExtractFileName(UserFilenameEdit.Text);
    ManualInfoFileName := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(ManualInfoFilenameEdit.Text)))
                              + ExtractFileName(ManualInfoFilenameEdit.Text);
    KillProcListFileName := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(KillProcFilenameEdit.Text)))
                              + ExtractFileName(KillProcFilenameEdit.Text);

    HiMECSFormPath := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(FormPathEdit.Text)))
                              + ExtractFileName(FormPathEdit.Text);
    ConfigPath := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(ConfigPathEdit.Text)))
                              + ExtractFileName(ConfigPathEdit.Text);
    DocPath := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(DocPathEdit.Text)))
                              + ExtractFileName(DocPathEdit.Text);
    ExesPath := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(ExePathEdit.Text)))
                              + ExtractFileName(AForm.ExePathEdit.Text);
    BplsPath := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(BplPathEdit.Text)))
                              + ExtractFileName(BplPathEdit.Text);
    LogPath := IncludeTrailingBackslash(ExtractRelativePath(
                              LPath, ExtractFilePath(LogPathEdit.Text)))
                              + ExtractFileName(LogPathEdit.Text);
    ExtAppInMDI := CBExtAppInMDI.Checked;
    UseMonLauncher := CBUseMonLauncher.Checked;
    UseCommLauncher := CBUseCommLauncher.Checked;
    EngParamEncrypt := EngParamEncryptCB.Checked;
    EngParamFileFormat := ConfFileFormatRG.ItemIndex;

    UpdateProtocol := SelProtocolRG.ItemIndex;
    FTPHost := HostEdit.Text;
    FTPPort := StrToIntDef(PortEdit.Text, -1);
    FTPUserID := UserIdEdit.Text;
    FTPPasswd := PasswdEdit.Text;
    FTPDirectory := DirEdit.Text;
    ServerURL := URLEdit.Text;
    UpdateWhenStart := UpdateCB.Checked;
  end;
end;

procedure TConfigF.LogPathEditAfterDialog(Sender: TObject; var AName: string;
  var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.ManualInfoFilenameEditAfterDialog(Sender: TObject;
  var AName: string; var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.MenuFilenameEditAfterDialog(Sender: TObject;
  var AName: string; var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.ParamFilenameEditAfterDialog(Sender: TObject;
  var AName: string; var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
//    AName := AbsToRel(AName, GetCurrentDir);
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.ProjInfoFilenameEditAfterDialog(Sender: TObject;
  var AName: string; var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

procedure TConfigF.SaveConfig(AFileName: string; AIsEncrypt: Boolean);
begin
  FHiMECSConfig.SaveToJSONFile(AFileName, ExtractFileName(AFileName),AIsEncrypt);
end;

procedure TConfigF.SelProtocolRGClick(Sender: TObject);
begin
  GroupBox1.Enabled := SelProtocolRG.ItemIndex = 2;
  URLEdit.Enabled := SelProtocolRG.ItemIndex <> 2;
  Label21.Enabled := SelProtocolRG.ItemIndex <> 2;
end;

procedure TConfigF.SetConfigData(Sender: TObject);
var
  LStr: string;
begin
  LoadConfigCollect2Form(self);

  if ShowModal = mrOK then
  begin
    LoadConfigForm2Collect(Self);
    LStr := IncludeTrailingPathDelimiter(FHiMECSConfig.ConfigPath);
    FHiMECSConfig.SaveToFile(LStr + DefaultOptionsFileName);
  end;
end;

procedure TConfigF.SetDefault2Config(AForm: TConfigF);
begin
  if AForm.FormPathEdit.Text = '' then
    AForm.FormPathEdit.Text := '.\Forms\';

  if AForm.ConfigPathEdit.Text = '' then
    AForm.ConfigPathEdit.Text := '.\Config\';

  if AForm.DocPathEdit.Text = '' then
    AForm.DocPathEdit.Text := '.\Doc\';

  if AForm.ExePathEdit.Text = '' then
    AForm.ExePathEdit.Text := '.\Applications\';

  if AForm.BplPathEdit.Text = '' then
    AForm.BplPathEdit.Text := '.\Bpls\';

  if AForm.LogPathEdit.Text = '' then
    AForm.LogPathEdit.Text := '.\Log\';
end;

procedure TConfigF.UserFilenameEditAfterDialog(Sender: TObject;
  var AName: string; var AAction: Boolean);
begin
  if RelativeCB.Checked then
  begin
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    AName := ExtractRelativePathBaseApplication(GetCurrentDir, AName);
  end;
end;

end.
