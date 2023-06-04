unit FrmConfigProjectFile2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.Buttons, Vcl.ExtCtrls, UnitProjectFileClass2,
  Vcl.Samples.Spin;

type
  TConfigProjectFileForm = class(TForm)
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    users: TTabSheet;
    Label1: TLabel;
    OptionFilenameEdit: TJvFilenameEdit;
    EncryptOptionCB: TCheckBox;
    ListView1: TListView;
    Label2: TLabel;
    ListView2: TListView;
    Label3: TLabel;
    PrjDescriptMemo: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    UserFilenameEdit: TJvFilenameEdit;
    Label6: TLabel;
    RunListFilenameEdit: TJvFilenameEdit;
    Label7: TLabel;
    MonitorFilenameEdit: TJvFilenameEdit;
    EncryptRunListCB: TCheckBox;
    EncryptMonitorCB: TCheckBox;
    Splitter1: TSplitter;
    ProjectItemLV: TListView;
    BtnPanel: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label8: TLabel;
    ProjectItemEdit: TEdit;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn3: TBitBtn;
    SpinButton1: TSpinButton;
    Label9: TLabel;
    DisplayOnTabCB: TCheckBox;
    Label10: TLabel;
    ImageFilenameEdit: TJvFilenameEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ProjectItemLVClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
  private
    FOnAddMode: Boolean;
    FOnDeleteMode: Boolean;

    procedure ListViewExchangeItems(lv: TListView; const i, j: Integer);
  public
    FProjectFile: TProjectFile;
    FExecFromHiMECS: Boolean;//HiMECS에서 실행하면 True, HiMECSProject.exe에서 실행하면 False
    FSaveAs: Boolean;

    procedure ItemData2Form(AProjectItem: TListItem);
    procedure ConfigData2Form(AProjectFile: TProjectFile; AIndex: integer);
    procedure FormData2ItemVar(var AProjectFileItem: TProjectFileItem;
      AHiMECSHomePath: string='');
    procedure ClearForm;
  end;

  procedure CreateProjectFileForm(var AProjectFile: TProjectFile);
var
  ConfigProjectFileForm: TConfigProjectFileForm;

implementation

uses FrmSelectProject2, CommonUtil, HiMECSConst;

{$R *.dfm}

procedure CreateProjectFileForm(var AProjectFile: TProjectFile);
var
  LConfigProjectFileForm: TConfigProjectFileForm;
  LProjectFileItem: TProjectFileItem;
begin
  if AProjectFile = nil then
    exit;

  LConfigProjectFileForm := TConfigProjectFileForm.Create(nil);
  try
    with LConfigProjectFileForm do
    begin
      SetCurrentDir(ExtractFilePath(Application.ExeName));
      OptionFilenameEdit.InitialDir := '.\config';
      UserFilenameEdit.InitialDir := '.\config';

      //기존 Project file에 Item만 신규로 추가할 경우 Project List View를 Hide 함
      if AProjectFile.FIsAddNewItem then
      begin
        BtnPanel.Visible := False;
        ProjectItemLV.Visible := False;
        Splitter1.Visible := False;
      end;

      ConfigData2Form(AProjectFile,-1);

      if ShowModal = mrOK then
      begin
        if AProjectFile.FIsAddNewItem then
          LProjectFileItem := AProjectFile.ProjectFileCollect.Add
        else
          LProjectFileItem := AProjectFile.ProjectFileCollect.Items[ProjectItemLV.Selected.Index];

        FormData2ItemVar(LProjectFileItem);

        if not AProjectFile.FIsAddNewItem then
          ProjectItemLV.Items[LProjectFileItem.Index].Caption := LProjectFileItem.ProjectItemName;
      end;
    end;
  finally
    FreeAndNil(LConfigProjectFileForm);
  end;

end;

procedure TConfigProjectFileForm.BitBtn3Click(Sender: TObject);
var
  LRunName, LParam: string;
begin
  LRunName := HiMECSOptionAppName;
  LParam := '';

  if OptionFilenameEdit.FileName <> '' then
    LParam := OptionFilenameEdit.FileName;
//HiMECSConfig.exe에서는 SetCurrentDir을 하지 않으므로 아래 루틴이 불필요함.
//    if (Pos('..\',LParam) = 0) and
//      (Pos('.\',LParam) > 0)  then //'..'이 존재하지 않고 '.'이 존재하면
//      LParam := replaceString(LParam, '.\', '..\');

    LParam := '/a' + LParam;

  if not EncryptOptionCB.Checked then
    LParam := LParam + ' /e' + 'FALSE';//BoolToStr(EncryptOptionCB.Checked);

  if not FExecFromHiMECS then
    SetCurrentDir('..\');

  ExecNewProcess2(LRunName, LParam);

  if not FExecFromHiMECS then
    SetCurrentDir(ExtractFilePath(Application.ExeName));
end;

procedure TConfigProjectFileForm.BitBtn4Click(Sender: TObject);
var
  LRunName, LParam: string;
begin
  LRunName := HiMECSCommLauncher;
  LParam := '';

  if RunListFilenameEdit.FileName <> '' then
  begin
    LParam := RunListFilenameEdit.FileName;
    if (Pos('..\',LParam) = 0) and
      (Pos('.\',LParam) > 0)  then //'..'이 존재하지 않고 '.'이 존재하면
      LParam := replaceString(LParam, '.\', '..\');

    LParam := '/L' + LParam;
  end;

  if not FExecFromHiMECS then
    SetCurrentDir('..\');

  ExecNewProcess2(LRunName, LParam);

  if not FExecFromHiMECS then
    SetCurrentDir(ExtractFilePath(Application.ExeName));
end;

procedure TConfigProjectFileForm.BitBtn5Click(Sender: TObject);
var
  LRunName, LParam: string;
begin
  LRunName := HiMECSMonitorLauncher;
  LParam := '';

  if MonitorFilenameEdit.FileName <> '' then
  begin
    LParam := MonitorFilenameEdit.FileName;
    if (Pos('..\',LParam) = 0) and
      (Pos('.\',LParam) > 0)  then //'..'이 존재하지 않고 '.'이 존재하면
      LParam := replaceString(LParam, '.\', '..\');

    LParam := '/L' + LParam;
  end;

  if not FExecFromHiMECS then
    SetCurrentDir('..\');

  ExecNewProcess2(LRunName, LParam);

  if not FExecFromHiMECS then
    SetCurrentDir(ExtractFilePath(Application.ExeName));
end;

procedure TConfigProjectFileForm.BitBtn6Click(Sender: TObject);
begin
  FSaveAs := True;
end;

procedure TConfigProjectFileForm.Button1Click(Sender: TObject);
var
  LProjectFileItem: TProjectFileItem;
begin
  LProjectFileItem := FProjectFile.ProjectFileCollect.Add;

  with ProjectItemLV.Items.Add do
  begin
    Caption := 'Project Item' + IntToStr(ProjectItemLV.Items.Count);
    LProjectFileItem.ProjectItemName := Caption;
    SubItems.Add('');
    ConfigData2Form(FProjectFile, LProjectFileItem.Index);
  end;

  ProjectItemLV.ItemIndex := ProjectItemLV.Items.Count - 1;
end;

procedure TConfigProjectFileForm.Button2Click(Sender: TObject);
var
  i: integer;
begin
  if Assigned(ProjectItemLV.Selected) then
  begin
    FOnDeleteMode := True;
    i := ProjectItemLV.Selected.Index;
    FProjectFile.ProjectFileCollect.Delete(i);
    ProjectItemLV.Items.Delete(i);
    ClearForm;
  end
  else
    ShowMessage('Select List First!');
end;

procedure TConfigProjectFileForm.Button3Click(Sender: TObject);
var
  LProjectFileItem: TProjectFileItem;
begin
  LProjectFileItem := FProjectFile.ProjectFileCollect.Items[ProjectItemLV.Selected.Index];
  FormData2ItemVar(LProjectFileItem, 'E:\pjh\project\util\HiMECS\Application\Bin\');
end;

procedure TConfigProjectFileForm.ClearForm;
begin
  ProjectItemEdit.Text := '';
  OptionFilenameEdit.Text := '';
  RunListFilenameEdit.FileName := '';
  MonitorFilenameEdit.FileName := '';
  ImageFilenameEdit.FileName := '';
  EncryptOptionCB.Checked := False;
  EncryptRunListCB.Checked := False;
  EncryptMonitorCB.Checked := False;
  PrjDescriptMemo.Text := '';
  UserFilenameEdit.FileName := '';
  DisplayOnTabCB.Checked := False;
end;

procedure TConfigProjectFileForm.ConfigData2Form(AProjectFile: TProjectFile;
  AIndex: integer);
var
  i: integer;
  LStr: string;
  LListItem: TListItem;
begin
  //파일로 부터 처음 로드할 때
  if AIndex < 0 then
  begin
    FOnAddMode := True;
    ProjectItemLV.Clear;

    for i := 0 to AProjectFile.ProjectFileCollect.Count - 1 do
    begin
      LListItem := ProjectItemLV.Items.Add;
      LStr := AProjectFile.ProjectFileCollect.Items[i].ProjectItemName;
      if LStr = '' then
        LStr := 'Project Item' + IntToStr(ProjectItemLV.Items.Count);
        
      LListItem.Caption := LStr;
      AIndex := 0;
    end;

    FProjectFile.Assign(AProjectFile);
    ProjectItemLV.ItemIndex := 0;
  end;
  
  with AProjectFile.ProjectFileCollect.Items[AIndex] do
  begin
    ProjectItemEdit.Text := ProjectItemName;
    OptionFilenameEdit.Text := OptionsFileName;
    RunListFilenameEdit.FileName := RunListFileName;
    MonitorFilenameEdit.FileName := MonitorFileName;
    ImageFilenameEdit.FileName := ImgFileName;
    EncryptOptionCB.Checked := OptionFileEncrypt;
    EncryptRunListCB.Checked := RunListFileEncrypt;
    EncryptMonitorCB.Checked := MonitorFileEncrypt;
    PrjDescriptMemo.Text := ProjectItemDescript;
    UserFilenameEdit.FileName := UserFileName;
    DisplayOnTabCB.Checked := IsDisplayOnTab;
  end;
end;

procedure TConfigProjectFileForm.FormCreate(Sender: TObject);
begin
  FProjectFile := TProjectFile.Create(nil);
  FOnAddMode := False;
  FOnDeleteMode := False;
  FSaveAs := False;
end;

//AHiMECSHomePath 맨 끝에 '\' 추가할 것
procedure TConfigProjectFileForm.FormData2ItemVar(var AProjectFileItem: TProjectFileItem;
  AHiMECSHomePath: string='');
var
  LPath: string;
begin
  if AHiMECSHomePath = '' then
    AHiMECSHomePath := ExtractFilePath(Application.ExeName);

  with AProjectFileItem do
  begin
    ProjectItemName := ProjectItemEdit.Text;//ProjectItemLV.Items[AIndex].Caption;
    OptionsFileName := ExtractRelativePathBaseApplication(AHiMECSHomePath,
                                    OptionFilenameEdit.FileName);
    RunListFileName := ExtractRelativePathBaseApplication(AHiMECSHomePath,
                                    RunListFilenameEdit.FileName);
    MonitorFileName := ExtractRelativePathBaseApplication(AHiMECSHomePath,
                                    MonitorFilenameEdit.FileName);
    ImgFileName := ExtractRelativePathBaseApplication(AHiMECSHomePath,
                                    ImageFilenameEdit.FileName);
    OptionFileEncrypt := EncryptOptionCB.Checked;
    RunListFileEncrypt := EncryptRunListCB.Checked;
    MonitorFileEncrypt := EncryptMonitorCB.Checked;
    ProjectItemDescript := PrjDescriptMemo.Text;

    if UserFileNameEdit.FileName = '' then
      UserFileNameEdit.FileName := ExtractFilePath(AHiMECSHomePath) +
                            'Config\DefaultHiMECS.user';
    UserFileName := ExtractRelativePathBaseApplication(AHiMECSHomePath,
                                    UserFilenameEdit.FileName);
    IsDisplayOnTab := DisplayOnTabCB.Checked;
  end;
end;

procedure TConfigProjectFileForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FProjectFile);
end;

procedure TConfigProjectFileForm.ItemData2Form(AProjectItem: TListItem);
var
  i: integer;
begin
  i := AProjectItem.Index;
  ConfigData2Form(FProjectFile,i);
end;

{
move down :
  ListViewExchangeItems(lst_detile,lst_detile.Selected.Index,lst_detile.Selected.Index+1);
move up :
  ListViewExchangeItems(lst_detile,lst_detile.Selected.Index,lst_detile.Selected.Index-1);
}
procedure TConfigProjectFileForm.ListViewExchangeItems(lv: TListView; const i,
  j: Integer);
var
  tempLI: TListItem;
begin
  lv.Items.BeginUpdate;
  try
    tempLI := TListItem.Create(lv.Items);
    tempLI.Assign(lv.Items.Item[i]);
    lv.Items.Item[i].Assign(lv.Items.Item[j]);
    lv.Items.Item[j].Assign(tempLI);
    tempLI.Free;
  finally
    lv.Items.EndUpdate
  end;
end;

procedure TConfigProjectFileForm.ProjectItemLVClick(Sender: TObject);
begin
  if ProjectItemLV.SelCount > 0 then
  begin
    ItemData2Form(ProjectItemLV.Selected);
  end;
end;

procedure TConfigProjectFileForm.SpinButton1DownClick(Sender: TObject);
begin
  ListViewExchangeItems(ProjectItemLV,ProjectItemLV.Selected.Index,ProjectItemLV.Selected.Index+1);
end;

procedure TConfigProjectFileForm.SpinButton1UpClick(Sender: TObject);
begin
  ListViewExchangeItems(ProjectItemLV,ProjectItemLV.Selected.Index,ProjectItemLV.Selected.Index-1);
end;

end.
