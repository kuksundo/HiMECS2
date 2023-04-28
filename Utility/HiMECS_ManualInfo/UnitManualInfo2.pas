unit UnitManualInfo2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.ComCtrls, Vcl.ExtCtrls, Word2010, Vcl.Menus, ActiveX,
  OtlTask, OtlCommon, OtlCollections, OtlParallel, OtlTaskControl,
  OtlEventMonitor, OtlComm, PdfiumCtrl, PdfiumCore,
  mormot.core.os,
  UnitHiMECSManualClass2, CommonUtil;

const
  WM_FUTURE_RESULT = WM_USER + 1;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    JvDirectoryEdit1: TJvDirectoryEdit;
    Label1: TLabel;
    Button1: TButton;
    ListView1: TListView;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    ChangeManualFilePath1: TMenuItem;
    FileText1: TMenuItem;
    Label2: TLabel;
    JvDirectoryEdit2: TJvDirectoryEdit;
    CheckBox1: TCheckBox;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    EngTypeEdit: TEdit;
    Button10: TButton;
    Label3: TLabel;
    Button11: TButton;
    GetDrawNofrompdffile1: TMenuItem;
    Label4: TLabel;
    PrefixDrawNoEdit: TEdit;
    Button12: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ChangeManualFilePath1Click(Sender: TObject);
    procedure FileText1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure GetDrawNofrompdffile1Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
  private
    FHiMECSManualInfo: THiMECSManualInfo;
    FGetManualInfoFuture: IOmniFuture<Boolean>;
    wordApp : _Application;
    FCount: integer;
    FCtrl: TPdfControl;

//    FOTLMonitor    : TOmniEventMonitor;
    FScanTask      : IOmniTaskControl;

    procedure OTLMonitorTaskMessage(const task: IOmniTaskControl; const msg: TOmniMessage);
    procedure OTLMonitorTaskTerminated(const task: IOmniTaskControl);
    procedure FutureResult(var msg: TOmniMessage); message WM_FUTURE_RESULT;

    function GetManualInfoFromFile(AFileName: string;
      AItem: THiMECSOpManualItem; AHeaderIndex: TOleEnum = wdHeaderFooterFirstPage;
      AIsSavePdf: Boolean=false; APdfFolderName: string=''): boolean;//wdHeaderFooterFirstPage
    function GetManualInfoFromFileName(AFileName: string; out ASecNo, ARevNo: string): string;
    function GetControlSystemInfoFromFileName(AFileName: string; AIgnorePrefix: Boolean;
      out ASystem, APart: string): string;
    function GetControlSystemInfoFromFileName2(AFileName: string; AIgnorePrefix: Boolean;
      out ASystem, APart: string): string;
    function GetSvcLetterInfoFromFileName(AFileName: string; out ASystem, APart: string): string;
    procedure GetCategory(ADir: string);
    procedure GetManualInfo(const task: IOmniTask);
    procedure OnGetManualInfoCompleted(const task: IOmniTaskControl);
    procedure GetOpManualInfoFromFolder(AFolderName: string);
    procedure GetControlSystemInfoFromFolder(AFolderName: string; AIgnorePrefix: Boolean=True);
    procedure GetControlSystemInfoFromFolder2(AFolderName: string; AIgnorePrefix: Boolean=True);
    procedure GetDrawingsInfoFromFolder(AFolderName: string);
    function GetDrawNumberFromPdfFile(APdfFileName, APrefixDrawNo: string): string;
    procedure GetSvcLetterInfoFromFolder(AFolderName: string);
    procedure InitPDFCtrl;
    procedure FinalizePDFCtrl;
    procedure SplitPDfFileFromContents(APdfFileName: string);
  public
    procedure ManualNDrawingInfo2ListView(AManualInfo: THiMECSManualInfo);
    procedure ManualInfo2ListView(AManualInfo: THiMECSManualInfo);
    procedure DrawingInfo2ListView(AManualInfo: THiMECSManualInfo);
    procedure SvcLetterInfo2ListView(AManualInfo: THiMECSManualInfo);
    procedure AddManualItem2ListView(AManualItem: THiMECSOpManualItem);
  end;

var
  Form1: TForm1;

implementation

uses UnitFolderSelect, RegExpr, UnitStringUtil, UnitPdfiumUtil;

{$R *.dfm}

procedure TForm1.AddManualItem2ListView(AManualItem: THiMECSOpManualItem);
begin

end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  if EngTypeEdit.Text = '' then
    ShowMessage('EngTypeEdit is null')
  else
    FHiMECSManualInfo.SetRelFilePathBothOpmanualNDrawings(EngTypeEdit.Text);
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  if JvDirectoryEdit1.Directory = '' then
  begin
    ShowMessage('Select folder first.');
    JvDirectoryEdit1.SetFocus;
    exit;
  end;

  GetControlSystemInfoFromFolder2(JvDirectoryEdit1.Directory, True);
  ListView1.Clear;
  ManualNDrawingInfo2ListView(FHiMECSManualInfo);
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  if JvDirectoryEdit1.Directory = '' then
  begin
    ShowMessage('Select folder first.');
    JvDirectoryEdit1.SetFocus;
    exit;
  end;

  GetSvcLetterInfoFromFolder(JvDirectoryEdit1.Directory);
  ListView1.Clear;
  SvcLetterInfo2ListView(FHiMECSManualInfo);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//  FGetManualInfoFuture := Parallel.Future<Boolean>(GetManualInfo,
//    Parallel.TaskConfig.OnTerminated(OnGetManualInfoCompleted));

  FScanTask := CreateTask(GetManualInfo, 'GetManualInfo')
//    .MonitorWith(FOTLMonitor)
    .SetParameter('FolderName', JvDirectoryEdit1.Text)
    .SetParameter('IsSavePDF', CheckBox1.Checked)
    .SetParameter('PdfFolderName', JvDirectoryEdit2.Text)
    .OnMessage(Self)
    .OnTerminated(OnGetManualInfoCompleted)
    .Run;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LStr: string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  OpenDialog1.InitialDir := GetCurrentDir;

  if OpenDialog1.Execute() then
  begin
    LStr := OpenDialog1.FileName;
    FHiMECSManualInfo.Clear;
    ListView1.Clear;
    FHiMECSManualInfo.LoadFromJSONFile(LStr);
    ManualNDrawingInfo2ListView(FHiMECSManualInfo);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  wordApp : _Application;
  doc : WordDocument;
  LSections: Sections;
  LSection: Section;
  LHeaders: HeadersFooters;
  LHeader: HeaderFooter;
  LTable: Table;
  LCell: Cell;
  LFields: Fields;
  LField: Field;
  filename : OleVariant;
  i,j,k,m,n: integer;
  LStr,LStr2: string;
begin
  filename := '"E:\pjh\project\util\HiMECS\Application\Bin\Doc\Manual\H35DF 원본\LDF07-cooling water spec\G07100_1K_Cooling Water Treatment_Fresh water.doc"';
  try
    wordApp := CoWordApplication.Create;
    wordApp.visible := False;

    doc := wordApp.documents.open( filename, emptyparam,emptyparam,emptyparam,
      emptyparam,emptyparam,emptyparam,emptyparam,
      emptyparam,emptyparam,emptyparam,emptyparam,
      emptyparam,emptyparam,emptyparam,emptyparam );

    LSections := doc.Sections;
    for i := 1 to LSections.Count do
    begin
      LSection := LSections.Item(i);
      LHeaders := LSection.Headers;
      LHeader := LHeaders.Item(wdHeaderFooterFirstPage); //wdHeaderFooterFirstPage,wdHeaderFooterPrimary
      ShowMessage(LHeader.Range.Text);

//      LTable := LHeader.Range.Tables.Item(1);
//      LCell := LTable.Cell(3,1);
//      LStr := LCell.Range.Text;
//      LStr2 := strToken(LStr, #13);
//      ShowMessage(LStr2);
//      LCell := LTable.Cell(3,2);
//      LStr := LCell.Range.Text;
//      LStr2 := strToken(LStr, #13);
//      ShowMessage(LStr2);
//      LCell := LHeader.Range.Cells.Item(1);
//      ShowMessage(LCell.Range.Text);
//      ShowMessage(LHeader.Range.Text);

//      for j := 1 to LHeaders.Count do
//      begin
//        LHeader := LHeaders.Item(j);
//        ShowMessage(LHeader.Range.Text);
//        LFields := LHeader.Range.Fields;

//        for k := 1 to LFields.Count do
//        begin
//          LField := LFields.Item(k);
//          ShowMessage(IntToStr(LField.Index));
//        end;
//      end;
    end;
  finally
    wordApp.quit(EmptyParam, EmptyParam, EmptyParam);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  LStr: string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  SaveDialog1.InitialDir := GetCurrentDir;

  if SaveDialog1.Execute() then
  begin
    LStr := SaveDialog1.FileName;

    FHiMECSManualInfo.SaveToJSONFile(LStr);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  LStr: string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  SaveDialog1.InitialDir := GetCurrentDir;

  if SaveDialog1.Execute() then
  begin
    LStr := SaveDialog1.FileName;

    FHiMECSManualInfo.SaveToSqliteFile(LStr);
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  LStr: string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  OpenDialog1.InitialDir := GetCurrentDir;
  OpenDialog1.Filter := 'Sqlite|*.sqlite|All Files|*.*';

  if OpenDialog1.Execute() then
  begin
    LStr := OpenDialog1.FileName;
    FHiMECSManualInfo.Clear;
    ListView1.Clear;
    FHiMECSManualInfo.LoadFromSqliteFile(LStr);
    ManualNDrawingInfo2ListView(FHiMECSManualInfo);
//    Self.ManualInfo2ListView(FHiMECSManualInfo);
//    Self.DrawingInfo2ListView(FHiMECSManualInfo);
  end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  if JvDirectoryEdit1.Directory = '' then
  begin
    ShowMessage('Select folder first.');
    JvDirectoryEdit1.SetFocus;
    exit;
  end;

  GetOpManualInfoFromFolder(JvDirectoryEdit1.Directory);
  ManualInfo2ListView(FHiMECSManualInfo);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  if JvDirectoryEdit1.Directory = '' then
  begin
    ShowMessage('Select folder first.');
    JvDirectoryEdit1.SetFocus;
    exit;
  end;

  GetControlSystemInfoFromFolder(JvDirectoryEdit1.Directory, False);
  ListView1.Clear;
  ManualInfo2ListView(FHiMECSManualInfo);
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  LStr: string;
begin
  OpenDialog1.Filter := 'pdf|*.pdf|All Files|*.*';

  if OpenDialog1.Execute() then
  begin
    InitPDFCtrl;
    try
      LStr := OpenDialog1.FileName;
      SplitPDfFileFromContents(LStr);
    finally
      FinalizePDFCtrl;
    end;
  end;
end;

procedure TForm1.ChangeManualFilePath1Click(Sender: TObject);
var
  LForm: TFolderSelectF;
  i: integer;
begin
  LForm := TFolderSelectF.Create(nil);
  try
    if LForm.ShowModal = mrOK then
    begin
      if LForm.JvDirectoryEdit1.Directory <> '' then
      begin
        ListView1.Items.BeginUpdate;
        try
          for i := 0 to ListView1.Items.Count - 1 do
          begin
            if ListView1.Items[i].Selected then
            begin
              if Assigned(ListView1.Items[i].Data) then
              begin
                THiMECSOpManualItem(ListView1.Items[i].Data).FilePath := LForm.JvDirectoryEdit1.Directory;
                ListView1.Items[i].SubItems[6] := LForm.JvDirectoryEdit1.Directory;
              end;
            end;
          end;
        finally
          ListView1.Items.EndUpdate;
        end;
      end;
    end;
  finally
    LForm.Free;
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Label2.Enabled := CheckBox1.Checked;
  JvDirectoryEdit2.Enabled := CheckBox1.Checked;
end;

procedure TForm1.DrawingInfo2ListView(AManualInfo: THiMECSManualInfo);
begin
  AManualInfo.DrawingInfo2ListView(ListView1);
end;

procedure TForm1.FileText1Click(Sender: TObject);
var
  LHiMECSOpManualItem: THiMECSOpManualItem;
  filename : OleVariant;
begin
  filename := '"E:\pjh\project\util\HiMECS\Application\Bin\Doc\Manual\H35DF 원본\LDF01-engine design & data\G01500 1A_H35DF_Measuring record sheet.doc"';
//  filename := '"E:\pjh\project\util\HiMECS\Application\Bin\Doc\Manual\H35DF 원본\LDF06-lube oil spec\G06200_1B_H35DF_List of Lubricating Oil.doc"';

  LHiMECSOpManualItem := FHiMECSManualInfo.OpManual.Add;
  if not GetManualInfoFromFile(filename,LHiMECSOpManualItem) then
    GetManualInfoFromFile(filename,LHiMECSOpManualItem,wdHeaderFooterPrimary);
end;

procedure TForm1.FinalizePDFCtrl;
begin
  FCtrl.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FHiMECSManualInfo := THiMECSManualInfo.Create(nil);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FHiMECSManualInfo.Free;
end;

procedure TForm1.FutureResult(var msg: TOmniMessage);
var
  LHiMECSOpManualItem: THiMECSOpManualItem;
begin
  LHiMECSOpManualItem := msg.MsgData.AsObject as THiMECSOpManualItem;
  FHiMECSManualInfo.AddManualItem2ListView(LHiMECSOpManualItem, ListView1);
end;

procedure TForm1.GetCategory(ADir: string);
begin

end;

function TForm1.GetControlSystemInfoFromFileName(AFileName: string;
  AIgnorePrefix: Boolean; out ASystem, APart: string): string;
var
  LStr: string;
begin
  Result := '';
  LStr := ExtractFileName(AFileName);

  if (not AIgnorePrefix) then
  begin
    ASystem := 'ControlSystem';

    if (Pos('ControlSystem', LStr) = 0) then
      exit;
  end
  else
    ASystem := strToken(LStr, '_');

  APart := strToken(LStr, '.');
  APart := APart.Replace('_', ' ');

  Result := ASystem + '_' + APart;
end;

function TForm1.GetControlSystemInfoFromFileName2(AFileName: string;
  AIgnorePrefix: Boolean; out ASystem, APart: string): string;
var
  LStr: string;
begin
  Result := '';
  LStr := ExtractFileName(AFileName);

  if (Pos('ControlSystem', LStr) = 0) then
    exit;

  if (not AIgnorePrefix) then
  begin
    ASystem := 'ControlSystem';

    if (Pos('ControlSystem', LStr) = 0) then
      exit;
  end
  else
    ASystem := strToken(LStr, '_');

  APart := strToken(LStr, '.');
  APart := APart.Replace('_', ' ');

  Result := ASystem + '_' + APart;
end;

procedure TForm1.GetControlSystemInfoFromFolder(AFolderName: string; AIgnorePrefix: Boolean);
var
  LHiMECSDrawingItem: THiMECSDrawingItem;
  LManualFileList: TStringList;
  i: integer;
  LStr, LSystem, LPart: string;
begin
  LManualFileList := GetFileListFromDir(AFolderName, '*.*', False);
  try
    for i := 0 to LManualFileList.Count - 1 do
    begin
      LStr := GetControlSystemInfoFromFileName(LManualFileList.Strings[i], AIgnorePrefix, LSystem, LPart);

      if LStr <> '' then
      begin
        LHiMECSDrawingItem := FHiMECSManualInfo.Drawings.Add;
        LHiMECSDrawingItem.FileName := ExtractFileName(LManualFileList.Strings[i]);
        LHiMECSDrawingItem.FilePath := ExtractFilePath(LManualFileList.Strings[i]);

        LHiMECSDrawingItem.Category_No := 'DR';//Drawing
        LSystem := LSystem.Insert(7, ' ');
        LHiMECSDrawingItem.SystemDesc_Eng := LSystem;
        LHiMECSDrawingItem.PartDesc_Eng := LPart;
      end;
    end;
  finally
    LManualFileList.Free;
  end;
end;

procedure TForm1.GetControlSystemInfoFromFolder2(AFolderName: string;
  AIgnorePrefix: Boolean);
var
  LHiMECSDrawingItem: THiMECSDrawingItem;
  LManualFileList: TStringList;
  i: integer;
  LStr, LSystem, LPart: string;
begin
  LManualFileList := GetFileListFromDir(AFolderName, '*.*', False);
  try
    for i := 0 to LManualFileList.Count - 1 do
    begin
      LStr := GetControlSystemInfoFromFileName2(LManualFileList.Strings[i], AIgnorePrefix, LSystem, LPart);

      if LStr <> '' then
      begin
        LHiMECSDrawingItem := FHiMECSManualInfo.Drawings.Add;
        LHiMECSDrawingItem.FileName := ExtractFileName(LManualFileList.Strings[i]);
        LHiMECSDrawingItem.FilePath := ExtractFilePath(LManualFileList.Strings[i]);
        LHiMECSDrawingItem.DrawNumber := GetDrawNumberFromPdfFile(LManualFileList.Strings[i], PrefixDrawNoEdit.Text);
        LHiMECSDrawingItem.Category_No := 'DR';//Drawing
        LSystem := LSystem.Insert(7, ' ');
        LHiMECSDrawingItem.SystemDesc_Eng := LSystem;
        LHiMECSDrawingItem.PartDesc_Eng := LPart;
      end;
    end;
  finally
    LManualFileList.Free;
  end;
end;

procedure TForm1.GetDrawingsInfoFromFolder(AFolderName: string);
begin

end;

procedure TForm1.GetDrawNofrompdffile1Click(Sender: TObject);
var
  LStr: string;
begin
  if JvDirectoryEdit1.Directory = '' then
  begin
    ShowMessage('Select folder first.');
    JvDirectoryEdit1.SetFocus;
    exit;
  end;

  GetControlSystemInfoFromFolder2(JvDirectoryEdit1.Directory, True);
  ListView1.Clear;
  ManualNDrawingInfo2ListView(FHiMECSManualInfo);

//  OpenDialog1.Filter := 'PDF|*.pdf|All Files|*.*';
//  if OpenDialog1.Execute() then
//  begin
//    LStr := 'B94-';
//    FindTextFromPdfFile(OpenDialog1.FileName, LStr, 14);
//    ShowMessage(LStr);
//  end;
end;

function TForm1.GetDrawNumberFromPdfFile(APdfFileName, APrefixDrawNo: string): string;
var
  LRect: TRect;
  LStr: string;
begin
  Result := '';
  LStr := APrefixDrawNo;//'B94-';
  LRect := FindTextFromPdfFile(APdfFileName, LStr, 14);

  Result := LStr;
end;

procedure TForm1.GetManualInfo(const task: IOmniTask);
var
  LHiMECSOpManualItem: THiMECSOpManualItem;
  LCategoryList, LManualFileList: TStringList;
  LStr, LFolderName, LPdfFolderName: string;
  i: integer;
  LIsSavePDF: boolean;

  procedure GetManualFileListFromDir(ADir: string);
  var j: integer;
  begin
    LManualFileList := GetFileListFromDir(ADir, '*.doc', False);
    try
      for j := 0 to LManualFileList.Count - 1 do
      begin
        if task.CancellationToken.IsSignalled then
          System.break;

        LStr := ExtractFileName(LManualFileList.Strings[j]);

        if Pos('~', LStr) > 0 then
        begin
          DeleteFile(LStr);
          Continue;
        end;

        if (Pos('G00000', LStr) < 1) then
        begin
          LHiMECSOpManualItem := FHiMECSManualInfo.OpManual.Add;
          LHiMECSOpManualItem.FileName := LStr;
          if LIsSavePDF then
            LHiMECSOpManualItem.FilePath := IncludeTrailingPathDelimiter(LPdfFolderName)
          else
            LHiMECSOpManualItem.FilePath := IncludeTrailingPathDelimiter(LPdfFolderName);//ExtractFilePath(LManualFileList.Strings[j]);

          if not GetManualInfoFromFile(LManualFileList.Strings[j],LHiMECSOpManualItem,wdHeaderFooterFirstPage,LIsSavePDF,LPdfFolderName) then
            GetManualInfoFromFile(LManualFileList.Strings[j],LHiMECSOpManualItem,wdHeaderFooterPrimary, LIsSavePDF,LPdfFolderName);

          inc(FCount);
          task.Comm.Send(WM_FUTURE_RESULT, LHiMECSOpManualItem);
//          task.Invoke(
//            procedure
//            begin
//              AddManualItem2ListView(LHiMECSOpManualItem);
//            end);
        end;
      end;
    finally
      LManualFileList.Free;
    end;
  end;
begin
  CoInitialize(nil);
//  wordApp := CoWordApplication.Create;
//  wordApp.visible := False;
  try
    FCount := 0;
    LFolderName := task.Param['FolderName'];
    LIsSavePDF := task.Param['IsSavePDF'];
    LPdfFolderName := task.Param['PdfFolderName'];
    //Category를 위해 폴더명만 가져옴
    LCategoryList := GetFileListFromDir(LFolderName, '*.*', false, faDirectory);

    if LCategoryList.Count > 0 then
    begin
      FHiMECSManualInfo.Clear;

      for i := 0 to LCategoryList.Count - 1 do
      begin
        GetManualFileListFromDir(LCategoryList.Strings[i]);
      end;

  //    task.Invoke(
  //      procedure
  //      begin
  //        ManualInfo2ListView(FHiMECSManualInfo);
  //      end);
    end;
  finally
//    wordApp.quit(EmptyParam, EmptyParam, EmptyParam);
    CoUnInitialize;
  end;
end;

function TForm1.GetManualInfoFromFile(AFileName: string;
  AItem: THiMECSOpManualItem; AHeaderIndex: TOleEnum;
  AIsSavePdf: Boolean; APdfFolderName: string):boolean;
var
//  wordApp : _Application;
  doc : WordDocument;
  LSections: Sections;
  LSection: Section;
  LHeaders: HeadersFooters;
  LHeader: HeaderFooter;
  LTable: Table;
  LCell: Cell;
//  LFields: Fields;
//  LField: Field;
  filename, LPdfFileName : OleVariant;
  i: integer;
  LStr: string;
  LSecNo, LRevNo: string;

  function GetSectionNo: string;
  begin
    LCell := LTable.Cell(2,3);
    LStr := LCell.Range.Text;
    Result := strToken(LStr, #13);

    if Pos('Section No.', Result) > 0 then
    begin
      strToken(LStr, #13);
      Result := Trim(strToken(LStr, #13));
    end;
  end;

  function GetRevNo: string;
  begin
    LCell := LTable.Cell(2,4);
    LStr := LCell.Range.Text;
    Result := strToken(LStr, #13);

    if Pos('Rev.', Result) > 0 then
    begin
      Result := strToken(LStr, #13);
      if Result <> '' then
        exit;

      Result := Trim(strToken(LStr, #13));
    end;
  end;

  function GetSystemDesc_Eng: string;
  begin
    LCell := LTable.Cell(2,1);
    Result := LCell.Range.Text;
    Result := strToken(Result, #13);
  end;

  function GetSystemDesc_Kor: string;
  begin
    LCell := LTable.Cell(3,1);
    LStr := LCell.Range.Text;
    Result := strToken(LStr, #13);
  end;

  function GetPartDesc_Eng: string;
  begin
    LCell := LTable.Cell(2,2);
    Result := LCell.Range.Text;
    Result := strToken(Result, #13);
  end;

  function GetPartDesc_Kor: string;
  begin
    LCell := LTable.Cell(3,2);
    LStr := LCell.Range.Text;
    Result := strToken(LStr, #13);
  end;

begin
  try
    Result := True;
    wordApp := CoWordApplication.Create;
    wordApp.visible := False;
    filename := AFileName;
    try
      doc := wordApp.documents.open( filename, emptyparam,emptyparam,emptyparam,
        emptyparam,emptyparam,emptyparam,emptyparam,
        emptyparam,emptyparam,emptyparam,emptyparam,
        emptyparam,emptyparam,emptyparam,emptyparam );

      LSections := doc.Sections;
      LSection := LSections.Item(1);

      if Pos('G06100',filename) > 0 then
      begin
//        ShowMessage(LSection.Range.Text);
      end;

      LPdfFileName := ChangeFileExt(ExtractFileName(filename), '.pdf');
      LPdfFileName := IncludeTrailingPathDelimiter(APdfFolderName) + LPdfFileName;
      LStr := ExtractFileName(filename);
      GetManualInfoFromFileName(LStr, LSecNo, LRevNo);

      LHeaders := LSection.Headers;
      LHeader := LHeaders.Item(AHeaderIndex); //wdHeaderFooterPrimary
      LTable := LHeader.Range.Tables.Item(1);
      AItem.SectionNo := GetSectionNo;

      if (LSecNo <> '') and (AItem.SectionNo <> LSecNo) then
      begin
        Result := False;
        exit;
      end;

//      if (Length(AItem.SectionNo) <> 6) then
      if Pos('.', AItem.SectionNo) > 0 then
      begin
        Result := False;
        exit;
      end;

      AItem.RevNo := GetRevNo;

      if (LRevNo <> '') and (AItem.RevNo <> LRevNo) then
      begin
        Result := False;
        exit;
      end;

      AItem.SystemDesc_Eng := GetSystemDesc_Eng;
      AItem.SystemDesc_Kor := GetSystemDesc_Kor;
      AItem.PartDesc_Eng := GetPartDesc_Eng;
      AItem.PartDesc_Kor := GetPartDesc_Kor;
    except
      Result := False;
    end;

    if AIsSavePdf then
      doc.SaveAs2(LPdfFileName, wdFormatPDF, emptyparam,emptyparam,emptyparam,
        emptyparam,emptyparam,emptyparam,emptyparam,
        emptyparam,emptyparam,emptyparam,emptyparam,
        emptyparam,emptyparam,emptyparam,emptyparam);
  finally
//    doc.Close(wdDoNotSaveChanges,wdFormatDocument,False);
//    doc.Close(wdDoNotSaveChanges,wdFormatDocument,False);
    wordApp.quit(wdDoNotSaveChanges, EmptyParam, EmptyParam);
  end;

end;

function TForm1.GetManualInfoFromFileName(AFileName: string; out ASecNo, ARevNo: string): string;
var
  LStr: string;
begin
  LStr := ExtractFileName(AFileName);
  ASecNo := strToken(LStr, '_');
  ARevNo := strToken(LStr, '_');

  if Pos('.', ARevNo) > -1 then
    ARevNo := strToken(ARevNo, '.');

  Result := ASecNo + '_' + ARevNo;
end;

procedure TForm1.GetOpManualInfoFromFolder(AFolderName: string);
var
  LHiMECSOpManualItem: THiMECSOpManualItem;
  LManualFileList: TStringList;
  i: integer;
  LStr, LSecNo, LRevNo: string;
  LRegExpr: TRegExpr;
begin
  LManualFileList := GetFileListFromDir(AFolderName, '*.*', False);

  if LManualFileList.Count > 0 then
  begin
    FHiMECSManualInfo.Clear;

    SetCurrentDir(ExtractFilePath(Application.ExeName));
    OpenDialog1.InitialDir := GetCurrentDir;
    OpenDialog1.Filter := 'Sqlite|*.sqlite|All Files|*.*';

    if OpenDialog1.Execute() then
    begin
      LRegExpr := TRegExpr.Create;
      try
        LRegExpr.Expression := '[A-Z]\d{5}';
        for i := 0 to LManualFileList.Count - 1 do
        begin
          LStr := GetManualInfoFromFileName(LManualFileList.Strings[i], LSecNo, LRevNo);
          LHiMECSOpManualItem := FHiMECSManualInfo.OpManual.Add;
          LHiMECSOpManualItem.FileName := ExtractFileName(LManualFileList.Strings[i]);
          LHiMECSOpManualItem.FilePath := ExtractFilePath(LManualFileList.Strings[i]);

          if LRegExpr.Exec(LStr) then
          begin
            LHiMECSOpManualItem.SectionNo := LSecNo;
            LHiMECSOpManualItem.RevNo := LRevNo;
            FHiMECSManualInfo.SetDescFromSecNo(OpenDialog1.FileName, LSecNo,LHiMECSOpManualItem);
          end
          else
          if Pos('ControlSystem_', LStr) > 0 then
          begin
            FHiMECSManualInfo.SetDescFromFileName(OpenDialog1.FileName, ExtractFileName(LManualFileList.Strings[i]), LHiMECSOpManualItem);
          end;
        end;
      finally
        LRegExpr.Free;
      end;
    end;
  end;
end;

function TForm1.GetSvcLetterInfoFromFileName(AFileName: string; out ASystem,
  APart: string): string;
var
  LStr: string;
begin
  Result := '';
  LStr := ExtractFileName(AFileName);

  if (Pos('ServiceLetter', LStr) = 0) then
    exit;

  strToken(LStr, '_');
  ASystem := strToken(LStr, '_');

  APart := strToken(LStr, '_');

  Result := ASystem + '_' + APart;
end;

procedure TForm1.GetSvcLetterInfoFromFolder(AFolderName: string);
var
  LHiMECSSvcLetterItem: THiMECSSvcLetterItem;
  LManualFileList: TStringList;
  i: integer;
  LStr, LSystem, LPart: string;
begin
  LManualFileList := GetFileListFromDir(AFolderName, '*.*', False);
  try
    for i := 0 to LManualFileList.Count - 1 do
    begin
      LStr := GetSvcLetterInfoFromFileName(LManualFileList.Strings[i], LSystem, LPart);

      if LStr <> '' then
      begin
        LHiMECSSvcLetterItem := FHiMECSManualInfo.SvcLetter.Add;
        LHiMECSSvcLetterItem.FileName := ExtractFileName(LManualFileList.Strings[i]);
        LHiMECSSvcLetterItem.FilePath := ExtractFilePath(LManualFileList.Strings[i]);
        LHiMECSSvcLetterItem.Category_No := 'SL';//Service Letter
        LHiMECSSvcLetterItem.Category_Eng := 'Service Letter';//Service Letter
        LHiMECSSvcLetterItem.SystemDesc_Eng := LSystem;
        LHiMECSSvcLetterItem.PartDesc_Eng := LPart;
      end;
    end;
  finally
    LManualFileList.Free;
  end;
end;

procedure TForm1.InitPDFCtrl;
begin
  PDFiumDllDir := 'E:\pjh\project\util\HiMECS\Application\Bin\Applications\';
  FCtrl := TPdfControl.Create(Self);
  FCtrl.Align := alClient;
  FCtrl.Parent := Self;
  FCtrl.SendToBack; // put the control behind the buttons
  FCtrl.Color := clGray;
  FCtrl.ScaleMode := smFitWidth;
//  FCtrl.PageColor := RGB(255, 255, 200);
//  FCtrl.OnWebLinkClick := WebLinkClick;
end;

procedure TForm1.ManualInfo2ListView(AManualInfo: THiMECSManualInfo);
begin
  AManualInfo.ManualInfo2ListView(ListView1);
end;

procedure TForm1.ManualNDrawingInfo2ListView(AManualInfo: THiMECSManualInfo);
begin
  ManualInfo2ListView(AManualInfo);
  DrawingInfo2ListView(AManualInfo);
end;

procedure TForm1.OnGetManualInfoCompleted(const task: IOmniTaskControl);
begin
  ShowMessage(IntToStr(FCount) + ' 건 작업완료');
end;

procedure TForm1.OTLMonitorTaskMessage(const task: IOmniTaskControl;
  const msg: TOmniMessage);
begin

end;

procedure TForm1.OTLMonitorTaskTerminated(const task: IOmniTaskControl);
begin

end;

procedure TForm1.SplitPDfFileFromContents(APdfFileName: string);
var
  LPage, LPage2: TPdfPage;
  LPdfRect: TPdfRect;
  R: TRect;
  LContentsFileName, LPath, LSearchStr: string;//목차가 저장된 txt 파일
  LContentsList: TStringList;
  CharIndex, CharCount, i, LPageCount, LCount,
  LBeginPage, LEndPage: integer;
  LStrList: TStringList;
begin
  LContentsFileName := ChangeFileExt(APdfFileName, '.txt');
  LPath := ExtractFilePath(APdfFileName);
  FCtrl.LoadFromFile(APdfFileName);

  LContentsList := TStringList.Create;
  LStrList := TStringList.Create;
  try
    LContentsList.LoadFromFile(LContentsFileName);
    LContentsFileName := ChangeFileExt(APdfFileName, '');

    for i := 0 to LContentsList.Count - 1 do
    begin
      LPageCount := 0;
      LBeginPage := 0;
      LEndPage := 0;

      LSearchStr := LContentsList.Strings[i];
      FCtrl.PageIndex := 0;

      Repeat
        if (FCtrl.PageCount-1) = FCtrl.PageIndex then
          System.Break;

        LPage2 := FCtrl.CurrentPage;

        try
          if LPage2.BeginFind(LSearchStr, False, False, False) then
          begin
            if LPage2.FindNext(CharIndex, CharCount) then
            begin
              LCount := LPage2.GetTextRectCount(CharIndex, CharCount);
              LPdfRect := LPage2.GetTextRect(0);
              R := FCtrl.PageToDevice(LPdfRect);

              //검색된 문자 위치가 Title 위치이면
              if (R.Top> 700) and (R.Top < 800)then
              begin
                Inc(LPageCount);

                if LBeginPage = 0 then
                  LBeginPage := FCtrl.PageIndex+1
                else
                  LEndPage := FCtrl.PageIndex+1;
              end;
//                  ShowMessage(LSearchStr + ' = ' + IntToStr(FCtrl.PageIndex) + ', ' + FloatToStr(R.Top) + ':' + FloatToStr(R.Left));
              LPage2.EndFind;
              Continue;
            end
//            else
//            if FCtrl.PageIndex = 0 then
//              LStrList.Add(LSearchStr + ': ' + IntToStr(LBeginPage) + ' ~ ' + IntToStr(LEndPage));
          end
          else
          begin
            LPage2.EndFind;
            System.Break;
          end;
        finally

        end;
      until not FCtrl.GotoNextPage();

      LPath := IncludeTrailingPathDelimiter(LContentsFileName);
      EnsureDirectoryExists(LPath);

      SavePDFFileFromPageRange(FCtrl, LPath + LSearchStr + '.pdf', LBeginPage, LEndPage);

      LStrList.Add(LSearchStr + ': ' + IntToStr(LBeginPage) + ' ~ ' + IntToStr(LEndPage));
    end;//for

    ShowMessage('Created File Count : ' + IntToStr(LStrList.Count) + #13#10 + LStrList.Text);
  finally
    LContentsList.Free;
    LStrList.Free;
  end;
end;

procedure TForm1.SvcLetterInfo2ListView(AManualInfo: THiMECSManualInfo);
begin
  AManualInfo.SvcLetterInfo2ListView(ListView1);
end;

end.
