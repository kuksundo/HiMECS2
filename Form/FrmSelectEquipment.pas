unit FrmSelectEquipment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvSmoothTileList,AdvGDIP,
  AdvSmoothTileListImageVisualizer, AdvSmoothTileListHTMLVisualizer,
  Vcl.ComCtrls, Vcl.ExtCtrls, ShellApi, GDIPPictureContainer, AdvGlowButton,
  Vcl.Imaging.jpeg, Vcl.ImgList,Vcl.Buttons, //Data.DBXJSON, Data.DBXJSONCommon,
  Vcl.StdCtrls, Vcl.Menus, CopyData, TimerPool,

  HiMECSConst2, JHP.BaseConfigCollect, UnitFrameTileList2, UnitProjectFileClass2,
  UnitHiMECSMonitorListClass2, UnitHiMECSEquipListClass;

type
  TeditType = (ftInsert,ftEdit);

  TSelectEquipF = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    AdvGlowButton1: TAdvGlowButton;
    Image1: TImage;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    LoadFromFile1: TMenuItem;
    SaveToFile1: TMenuItem;
    Timer1: TTimer;
    N1: TMenuItem;
    ExecuteAll1: TMenuItem;
    ExecuteAuto1: TMenuItem;
    ExecuteManual1: TMenuItem;
    ExecuteSelectedTile1: TMenuItem;
    N2: TMenuItem;
    DeleteItem1: TMenuItem;
    N3: TMenuItem;
    AddNewTile1: TMenuItem;
    ShowAllMonitor1: TMenuItem;
    N4: TMenuItem;
    HideAllMonitor1: TMenuItem;
    TileListFrame: TTileListFrame;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadFromFile1Click(Sender: TObject);
    procedure SaveToFile1Click(Sender: TObject);
    procedure tileListTileDblClick(Sender: TObject; ATile: TAdvSmoothTile;
      State: TTileState);
    procedure ExecuteAll1Click(Sender: TObject);
    procedure ExecuteSelectedTile1Click(Sender: TObject);
    procedure ExecuteAuto1Click(Sender: TObject);
    procedure ExecuteManual1Click(Sender: TObject);
    procedure DeleteItem1Click(Sender: TObject);
    procedure AddNewTile1Click(Sender: TObject);
    procedure ShowAllMonitor1Click(Sender: TObject);
    procedure HideAllMonitor1Click(Sender: TObject);
    procedure TileListFrametileListTileDblClick(Sender: TObject;
      Tile: TAdvSmoothTile; State: TTileState);
  private
    FProjectFile: TProjectFile;
    FFilePath: string;
    FFirst: Boolean;
    FeditType : TeditType;
    FMonitorList: THiMECSMonitorList;
    FPJHTimerPool: TPJHTimerPool;

    property EditType : TeditType read FeditType write FeditType;
    procedure AddNewEquip2List;
//    function Create_newApp(aEditType:Integer;aPath:String) : TJSONObject;
//    function JSONObject2AutoRunClass(AJSONObject: TJSONObject;
//      AdvSmoothTileContent:TAdvSmoothTileContent): integer;
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;
    procedure OnDisableAppStatus(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);

    function AddTileFromProjectFile(var AProjectFile: TProjectFile): integer;
    function AddTileFromProjectFileItem(AItem:TProjectFileItem): integer;
  public
//    procedure SetConfigTile(ATile: TAdvSmoothTile);
//    function Get_JsonValues(aJsonPair:TJSONPair):String;
    procedure LoadTileFromFile(AFileName: string; AIsAppend: Boolean);

//    procedure LoadConfigForm2Var(AForm: TnewMonApp_Frm; AVar: THiMECSMonitorListItem);
//    procedure LoadVar2ConfigForm(AForm: TnewMonApp_Frm; AVar: THiMECSMonitorListItem);
    procedure LoadVar2Form(ATile: TAdvSmoothTile; AVar: THiMECSMonitorListItem);

    procedure LoadMonitor(AVar: THiMECSMonitorListItem);
    procedure ExecuteList(AIsAll: Boolean=true; AIsAuto: Boolean=true;
        AIsSelected: Boolean=true);
    procedure ExecuteAuto;
    procedure ExecuteManual;
    procedure ExecuteSelectedTile;
    procedure ShowWindowFromSelectedTile(AWinMsgAction: integer; AMonItem: THiMECSMonitorListItem = nil);
    procedure ShowEquipmentInfoFromSelectedTile(AEquipItem: TProjectFileItem = nil);
  end;

  procedure CreateSelectEquipForm(var AProjectFile: TProjectFile);
var
  SelectEquipF: TSelectEquipF;

implementation

uses UnitStringUtil, HiMECSCommonWinMessage, FrmConfigProjectFile2;

{$R *.dfm}

procedure CreateSelectEquipForm(var AProjectFile: TProjectFile);
var
  LSelectEquipF: TSelectEquipF;
  LStr: string;
begin
  if AProjectFile = nil then
    exit;

  LSelectEquipF := TSelectEquipF.Create(nil);
  try
    with LSelectEquipF do
    begin
      FProjectFile := AProjectFile;
      AddTileFromProjectFile(FProjectFile);

      if ShowModal = mrOK then
      begin
        if Assigned(TileListFrame.tileList.SelectedTile) then
          AProjectFile.CurrentProjectIndex := TileListFrame.tileList.SelectedTile.Index;
      end;
    end;
  finally
    FreeAndNil(LSelectEquipF);
  end;

end;

procedure TSelectEquipF.AddNewEquip2List;
begin
  FProjectFile.FShowMode := psmAdd;
  CreateProjectFileForm(FProjectFile);
end;

procedure TSelectEquipF.AddNewTile1Click(Sender: TObject);
begin
//  SetConfigTile(TileListFrame.tileList.SelectedTile);
end;

function TSelectEquipF.AddTileFromProjectFile(
  var AProjectFile: TProjectFile): integer;
var
  i: integer;
begin
  for i := 0 to AProjectFile.ProjectFileCollect.Count - 1 do
  begin
    AddTileFromProjectFileItem(AProjectFile.ProjectFileCollect.Items[i]);
  end;
end;

function TSelectEquipF.AddTileFromProjectFileItem(
  AItem: TProjectFileItem): integer;
var
  lTile : TAdvSmoothTile;
begin
  Result := -1;
  lTile := TileListFrame.tileList.Tiles.Add;

  with lTile do
  begin
//    DisplayName := AItem.ProjectItemName;
//    Data := AItem.ProjectItemDescript;
    Content.Text := AItem.ProjectItemDescript;
    Content.TextPosition := tpBottomCenter;
//    StatusIndicator := 'Auto';
    Content.Hint := AItem.ProjectItemDescript;
    Content.Image.LoadFromFile('E:\pjh\Dev\Lang\Delphi\Project\HiMECS2\Bin\Doc\Img\GE1.png');
    ItemOject := AItem;
    Result := Index;
  end;
end;

procedure TSelectEquipF.AdvGlowButton1Click(Sender: TObject);
begin
  AddNewEquip2List;
end;

//function TSelectEquipF.Create_newApp(aEditType: Integer;
//  aPath: String): TJSONObject;
//var
//  lTitle : String;
//  lJsonArray : TJSONArray;
//  lJsonObj : TJSONObject;
//  LnewApp_Frm : TnewMonApp_Frm;
//begin
//  LnewApp_Frm := TnewMonApp_Frm.Create(nil);
//  try
//    with LnewApp_Frm do
//    begin
//      case aEditType of
//        0 : //new App
//        begin
//          lTitle := ExtractFileName(aPath);
//          appTitle.Text := Copy(lTitle,0,LastDelimiter('.',lTitle)-1);
//          appPath.Text := aPath;
//          ProgNameEdit.Text := '.\HiMECS_Watch2p.exe';
//        end;
//      end;
//
//      if ShowModal = mrOk then
//      begin
//        Result := TJSONObject.Create;
//
//        Result.AddPair('MONTITLE',appTitle.Text).
//               AddPair('AUTOLOAD', BoolToStr(AutoRunCB.Checked)).
//               AddPair('MONFILENAME',appPath.Text).
//               AddPair('MONICON',FIconPath).
//               AddPair('MONDESC',appDesc.Text).
//               AddPair('RUNPROGNAME',ProgNameEdit.Text).
//               AddPair('RUNPARAM',RunParamEdit.Text).
//               AddPair('USEPROGRELATIVEPATH',BoolToStr(ProgRelPathCB.Checked)).
//               AddPair('USERELATIVEPATH', BoolToStr(RelPathCB.Checked));
//      end
//      else
//        Result := nil;
//    end;
//  finally
//    FreeAndNil(LnewApp_Frm);
//  end;
//end;

procedure TSelectEquipF.DeleteItem1Click(Sender: TObject);
var
  LAutoRunItem: THiMECSMonitorListItem;
begin
  if Assigned(TileListFrame.tileList.SelectedTile) then
  begin
    if MessageDlg('Are you sure delete selected item?',
                                mtConfirmation, [mbYes, mbNo], 0)= mrYes then
    begin
      LAutoRunItem := TileListFrame.tileList.SelectedTile.ItemOject as THiMECSMonitorListItem;
      FMonitorList.MonitorListCollect.Delete(LAutoRunItem.Index);
      TileListFrame.tileList.SelectedTile.ItemOject := nil;
      TileListFrame.tileList.Tiles.Delete(TileListFrame.tileList.SelectedTile.Index);
    end;
  end;
end;

procedure TSelectEquipF.ExecuteList(AIsAll: Boolean; AIsAuto: Boolean;
  AIsSelected: Boolean);
var
  i: integer;
  LHandle,LProcessID: THandle;
  LAutoRunItem: THiMECSMonitorListItem;
begin
  SetCurrentDir(FFilePath);

  for i := 0 to FMonitorList.MonitorListCollect.Count - 1 do
  begin
    if not AIsAll then
    begin
      if AIsAuto then
      begin
        if not FMonitorList.MonitorListCollect.Items[i].IsAutoLoad then
          continue;
      end
      else
      begin
        if AIsSelected then
        begin
          LAutoRunItem := TileListFrame.tileList.SelectedTile.ItemOject as THiMECSMonitorListItem;
          LoadMonitor(LAutoRunItem);
          exit;
        end
        else
        if FMonitorList.MonitorListCollect.Items[i].IsAutoLoad then
          continue;
      end;
    end;

    LAutoRunItem := TileListFrame.tileList.Tiles.Items[i].ItemOject as THiMECSMonitorListItem;
    LoadMonitor(LAutoRunItem);
  end;
end;

procedure TSelectEquipF.ExecuteAuto;
begin
  ExecuteList(False);
end;

procedure TSelectEquipF.ExecuteAuto1Click(Sender: TObject);
begin
  ExecuteAuto;
end;

procedure TSelectEquipF.ExecuteManual;
begin
  ExecuteList(False, False, False);
end;

procedure TSelectEquipF.ExecuteManual1Click(Sender: TObject);
begin
  ExecuteManual;
end;

procedure TSelectEquipF.ExecuteSelectedTile;
begin
  ExecuteList(False, False, True);
end;

procedure TSelectEquipF.ExecuteSelectedTile1Click(Sender: TObject);
begin
  ExecuteSelectedTile;
end;

procedure TSelectEquipF.FormCreate(Sender: TObject);
begin
  FFilePath := ExtractFilePath(Application.ExeName);
  SetCurrentDir(FFilePath);

  TileListFrame.InitVar;
//  TileListFrame.FAddNewApp2List := AddNewEquip2List;

  FMonitorList := THiMECSMonitorList.Create(Self);
  FPJHTimerPool := TPJHTimerPool.Create(Self);
  FFirst := True;
end;


procedure TSelectEquipF.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  Timer1.Enabled := False;

  TileListFrame.DestroyVar;

  FPJHTimerPool.RemoveAll;
  FreeAndNil(FPJHTimerPool);

  for i := 0 to FMonitorList.MonitorListCollect.Count - 1 do
    SendMessage(FMonitorList.MonitorListCollect.Items[i].AppHandle, WM_CLOSE, 0, 0);

  FMonitorList.MonitorListCollect.Clear;
  FreeAndNil(FMonitorList);
end;

//function TSelectEquipF.Get_JsonValues(aJsonPair: TJSONPair): String;
//var
//  lstr : String;
//  ljsonValue : TJSONValue;
//begin
//  ljsonValue := aJsonPair.JsonValue;
//  Result := ljsonValue.Value;
//end;

procedure TSelectEquipF.HideAllMonitor1Click(Sender: TObject);
var
  i: integer;
  LMonItem: THiMECSMonitorListItem;
begin
  for i := 0 to TileListFrame.tileList.Tiles.Count - 1 do
  begin
    LMonItem := TileListFrame.tileList.Tiles[i].ItemOject as THiMECSMonitorListItem;
    ShowWindowFromSelectedTile(SW_MINIMIZE,LMonItem);
  end;
end;

//function TSelectEquipF.JSONObject2AutoRunClass(AJSONObject: TJSONObject;
//  AdvSmoothTileContent:TAdvSmoothTileContent): integer;
//var
//  LAutoRunItem: THiMECSMonitorListItem;
//  LStr: string;
//begin
//  LAutoRunItem := FMonitorList.MonitorListCollect.Add;
//  Result := LAutoRunItem.Index;
//  LAutoRunItem.IsAutoLoad := StrToBool(Get_JsonValues(AJSONObject.get('AUTOLOAD')));
//  LAutoRunItem.MonitorDesc := Get_JsonValues(AJSONObject.get('MONDESC'));
//  LAutoRunItem.MonitorTitle := Get_JsonValues(AJSONObject.get('MONTITLE'));
//  Lstr := Get_JsonValues(AJSONObject.get('USERELATIVEPATH'));
//  if StrToBool(LStr) then
//    LStr := ExtractRelativePathBaseApplication(FFilePath, Get_JsonValues(AJSONObject.get('MONFILENAME')))
//  else
//    LStr := Get_JsonValues(AJSONObject.get('MONFILENAME'));
//
//  LAutoRunItem.MonitorFileName := LStr;
//
//  Lstr := Get_JsonValues(AJSONObject.get('USEPROGRELATIVEPATH'));
//  if StrToBool(LStr) then
//    LStr := ExtractRelativePathBaseApplication(FFilePath, Get_JsonValues(AJSONObject.get('RUNPROGNAME')))
//  else
//    LStr := Get_JsonValues(AJSONObject.get('RUNPROGNAME'));
//
//  LAutoRunItem.RunProgramName := LStr;
//  LAutoRunItem.RunParameter := Get_JsonValues(AJSONObject.get('RUNPARAM'));
//  LAutoRunItem.MonitorImage := TileListFrame.ConvertImage2String(AdvSmoothTileContent.Image);
//end;

//procedure TSelectEquipF.LoadConfigForm2Var(AForm: TnewMonApp_Frm;
//  AVar: THiMECSMonitorListItem);
//var
//  LStr: string;
//begin
//  with AForm do
//  begin
//    AVar.MonitorTitle := appTitle.Text;
//    AVar.IsAutoLoad := AutoRunCB.Checked;
//    if RelPathCB.Checked then
//      LStr := ExtractRelativePathBaseApplication(FFilePath, appPath.Text)
//    else
//      LStr := appPath.Text;
//
//    AVar.MonitorFileName := LStr;
//
//    if ProgRelPathCB.Checked then
//      LStr := ExtractRelativePathBaseApplication(FFilePath, ProgNameEdit.Text)
//    else
//      LStr := ProgNameEdit.Text;
//
//    AVar.RunProgramName := LStr;
//    AVar.MonitorDesc := appDesc.Text;
//    with GDIPPictureContainer1.Items do
//    begin
//      Clear;
//      Add;
//      Items[Count-1].Picture.Assign(Icon.Picture);
//      AVar.MonitorImage := TileListFrame.ConvertImage2String(Items[Count-1].Picture);
//    end;
//  end;
//end;

procedure TSelectEquipF.LoadFromFile1Click(Sender: TObject);
begin
  SetCurrentDir(FFilepath);
  OpenDialog1.InitialDir := '..\Config';

  if OpenDialog1.Execute then
  begin
    if OpenDialog1.FileName <> '' then
    begin
      LoadTileFromFile(OpenDialog1.FileName, False);
    end;
  end;
end;

procedure TSelectEquipF.LoadMonitor(AVar: THiMECSMonitorListItem);
var
  LHandle,LProcessID: THandle;
begin
//  LProcessId := ExecNewProcess2(AVar.RunProgramName,
//                                '/p'+AVar.MonitorFileName);
//  LHandle := DSiGetProcessWindow(LProcessId);
//  AVar.AppHandle := LHandle;
end;

//AIsAppend = True: 기존 List에 추가함
//            False: 기존 List Clear;
procedure TSelectEquipF.LoadTileFromFile(AFileName: string; AIsAppend: Boolean);
var
  lTile : TAdvSmoothTile;
  //LMemStream: TMemoryStream;
  i: integer;
begin
  SetCurrentDir(FFilePath);

  if not FileExists(AFileName) then
  begin
    ShowMessage('File not exist : '+AFileName);
    exit;
  end;

  if not AIsAppend then
  begin
    FMonitorList.MonitorListCollect.Clear;
    TileListFrame.tileList.Tiles.Clear;
  end;

  FMonitorList.LoadFromJSONFile(AFileName);

  for i := 0 to FMonitorList.MonitorListCollect.Count - 1 do
  begin
    lTile := TileListFrame.tileList.Tiles.Add;
    LoadVar2Form(lTile,FMonitorList.MonitorListCollect.Items[i]);
  end; //for
end;

//procedure TSelectEquipF.LoadVar2ConfigForm(AForm: TnewMonApp_Frm;
//  AVar: THiMECSMonitorListItem);
//begin
//  with AForm do
//  begin
//    appTitle.Text := AVar.MonitorTitle;
//    AutoRunCB.Checked := AVar.IsAutoLoad;
//    appPath.Text := AVar.MonitorFileName;
//    appDesc.Text := AVar.MonitorDesc;
//    ProgNameEdit.Text := AVar.RunProgramName;
//    RunParamEdit.Text := AVar.RunParameter;
//
//    with GDIPPictureContainer1.Items do
//    begin
//      Clear;
//      Add;
//      if AVar.MonitorImage <> '' then
//      begin
//        Items[Count-1].Picture.LoadFromStream(TileListFrame.ConvertString2Stream(AVar.MonitorImage));
//        Icon.Picture.Assign(Items[Count-1].Picture);
//        Icon.Invalidate;
//      end;
//    end;
//  end;
//end;

procedure TSelectEquipF.LoadVar2Form(ATile: TAdvSmoothTile; AVar: THiMECSMonitorListItem);
begin
  with ATile do
  begin
    Content.Text := AVar.MonitorTitle;
    Content.TextPosition := tpBottomCenter;

    if AVar.IsAutoLoad then
      StatusIndicator := 'Auto'
    else
      StatusIndicator := '';

    Content.Hint := AVar.MonitorFileName;
    DisplayName := AVar.MonitorDesc;
    ItemOject := AVar;

    if AVar.MonitorImage <> '' then
      Content.Image.LoadFromStream(TileListFrame.ConvertString2Stream(AVar.MonitorImage));
  end;
end;

procedure TSelectEquipF.OnDisableAppStatus(Sender: TObject; Handle: Integer;
  Interval: Cardinal; ElapsedTime: Integer);
begin
end;

procedure TSelectEquipF.SaveToFile1Click(Sender: TObject);
begin
  TileListFrame.SaveTile2File(TpjhBase(FMonitorList));
end;

//procedure TSelectEquipF.SetConfigTile(ATile: TAdvSmoothTile);
//var
//  LnewApp_Frm : TnewMonApp_Frm;
//  LAutoRunItem: THiMECSMonitorListItem;
//begin
//  if not Assigned(ATile) then
//    exit;
//
//  LnewApp_Frm := TnewMonApp_Frm.Create(nil);
//  try
//    LAutoRunItem := ATile.ItemOject as THiMECSMonitorListItem;
//
//    LoadVar2ConfigForm(LnewApp_Frm, LAutoRunItem);
//
//    with LnewApp_Frm do
//    begin
//      if ShowModal = mrOk then
//      begin
//        LoadConfigForm2Var(LnewApp_Frm, LAutoRunItem);
//        LAutoRunItem.TileIndex := ATile.Index;
//        LoadVar2Form(ATile, LAutoRunItem);
//      end;
//    end;
//  finally
//    FreeAndNil(LnewApp_Frm);
//  end;
//end;

procedure TSelectEquipF.ShowAllMonitor1Click(Sender: TObject);
var
  i: integer;
  LMonItem: THiMECSMonitorListItem;
begin
  for i := 0 to TileListFrame.tileList.Tiles.Count - 1 do
  begin
    LMonItem := TileListFrame.tileList.Tiles[i].ItemOject as THiMECSMonitorListItem;
    ShowWindowFromSelectedTile(SW_RESTORE,LMonItem);
  end;
end;

procedure TSelectEquipF.ShowEquipmentInfoFromSelectedTile(
  AEquipItem: TProjectFileItem);
var
  LEquipItem: TProjectFileItem;
begin
  if AEquipItem = nil then
    LEquipItem := TileListFrame.tileList.SelectedTile.ItemOject as TProjectFileItem
  else
    LEquipItem := AEquipItem;

  FProjectFile.FShowMode := PsmView;
  FProjectFile.FSelectedProjectItem := LEquipItem;

  CreateProjectFileForm(FProjectFile);
end;

procedure TSelectEquipF.ShowWindowFromSelectedTile(AWinMsgAction: integer;
  AMonItem: THiMECSMonitorListItem);
var
  LMonItem: THiMECSMonitorListItem;
  MyPopup: HWnd;
begin
  if AMonItem = nil then
    LMonItem := TileListFrame.tileList.SelectedTile.ItemOject as THiMECSMonitorListItem
  else
    LMonItem := AMonitem;

  if LMonItem.AppHandle > 0 then
  begin
    MyPopup := GetLastActivePopup(LMonItem.AppHandle);

    if AWinMsgAction = SW_RESTORE then
    begin
      BringWindowToTop(LMonItem.AppHandle);
      if IsIconic(MyPopup) then
      begin
        ShowWindow(MyPopup, SW_RESTORE);  // 최소화 상태이면 원래 크기로
      end else
        BringWindowToTop(MyPopup);        // 최상위 윈도우로

      SetForegroundWindow(MyPopup);
    end
    else
    if AWinMsgAction = SW_MINIMIZE then
      ShowWindow(MyPopup, SW_MINIMIZE);
  end;
end;

procedure TSelectEquipF.TileListFrametileListTileDblClick(Sender: TObject;
  Tile: TAdvSmoothTile; State: TTileState);
begin
  ShowEquipmentInfoFromSelectedTile();
end;

procedure TSelectEquipF.tileListTileDblClick(Sender: TObject;
  ATile: TAdvSmoothTile; State: TTileState);
begin
  //SetConfigTile(ATile);
  ShowWindowFromSelectedTile(SW_RESTORE);
end;

procedure TSelectEquipF.WMCopyData(var Msg: TMessage);
var
  i,j: integer;
begin
  case Msg.WParam of //Echo
    WParam_SENDWINHANDLE: begin//Handle 수신 OK
      if PCopyDataStruct(Msg.LParam)^.dwData = Handle then
        SendHandleCopyData(PCopyDataStruct(Msg.LParam)^.cbData, Handle, WParam_RECVHANDLEOK);
    end;

    WParam_RECVHANDLEOK: begin
      if PCopyDataStruct(Msg.LParam)^.dwData = Handle then
      begin
        for i := 0 to FMonitorList.MonitorListCollect.Count - 1 do
        begin
          if PCopyDataStruct(Msg.LParam)^.cbData = FMonitorList.MonitorListCollect.Items[i].AppHandle then
          begin
            //FPJHTimerPool.Remove(FMonitorList.MonitorListCollect.Items[i].DisableTimerHandle);
            //FMonitorList.MonitorListCollect.Items[i].DisableTimerHandle := -1;
            //j := FMonitorList.MonitorListCollect.Items[i].TileIndex;
            //TileListFrame.tileList.Tiles[j].Content.Image.LoadFromStream(
            //  TileListFrame.ConvertString2Stream(
            //    FMonitorList.MonitorListCollect.Items[i].AppImage));
            break;
          end;
        end;
      end;
    end;

    WParam_FORMCLOSE: begin
      if PCopyDataStruct(Msg.LParam)^.dwData = Handle then
      begin
        for i := 0 to FMonitorList.MonitorListCollect.Count - 1 do
        begin
          if PCopyDataStruct(Msg.LParam)^.cbData = FMonitorList.MonitorListCollect.Items[i].AppHandle then
          begin
            //FPJHTimerPool.Remove(FMonitorList.MonitorListCollect.Items[i].DisableTimerHandle);
            //FMonitorList.MonitorListCollect.Items[i].DisableTimerHandle := -1;
            //j := FMonitorList.MonitorListCollect.Items[i].TileIndex;
            //TileListFrame.tileList.Tiles[j].Content.Image.LoadFromStream(
            //  TileListFrame.ConvertString2Stream(
            //    FMonitorList.MonitorListCollect.Items[i].AppDisableImage));
            break;
          end;
        end;
      end;
    end;

  end;
end;

procedure TSelectEquipF.ExecuteAll1Click(Sender: TObject);
begin
  ExecuteList;
end;

end.
