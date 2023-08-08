unit FrmSensorCableRouteEdit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, JvExMask, JvToolEdit, StdCtrls, JvExStdCtrls, JvHtControls,
  Buttons, ExtCtrls, NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid,
  Menus,
  NxColumnClasses, NxColumns,
  JvCombobox, ActnList, JvButton, JvCtrls, ImgList, Vcl.ComCtrls, JvExComCtrls,
  JvComCtrls, JvCheckTreeView, System.Actions,

//  MenuBaseClass, JvgXMLSerializer_Encrypt,
  UnitConfigIniClass2,
  UnitNextGridUtil2,
  DomSensorCQRS2,
  DomSensorInterfaces2,
  DomSensorServices2,
  DomSensorTypes2,
  UnitECUData2, HiMECSConst2,

  InfraSensorTypes2, DropSource, DragDropText, DragDrop, DropTarget,
  UnitFrameEngParamDecTV2, UnitFrameElecPartEdit2;

type
  TSensorCableRouteEditF = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Close1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Delete1: TMenuItem;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    Panel2: TPanel;
    ImageList2: TImageList;
    imTreeView: TImageList;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label17: TLabel;
    Panel3: TPanel;
    Bevel1: TBevel;
    Label10: TLabel;
    BitBtn1: TBitBtn;
    Button3: TButton;
    Button4: TButton;
    EncryptCB: TCheckBox;
    PassPhraseEdit: TEdit;
    Button1: TButton;
    BitBtn4: TBitBtn;
    PopupMenu2: TPopupMenu;
    ApplyProjectNotoAllNode1: TMenuItem;
    ApplyPanelInfotoAllNode1: TMenuItem;
    ApplyPLCInfotoAllNode1: TMenuItem;
    EditFrameDecTV1: TFrameDecTreeView2;
    FrameElecPartEdit11: TFrameElecPartEdit2;

    procedure FormCreate(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure EncryptCBClick(Sender: TObject);
    procedure SortCollectItembyNodeIndex1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure EditFrameDecTV1decTreeView1Click(Sender: TObject);
    procedure ApplyProjectNotoAllNode1Click(Sender: TObject);
    procedure ApplyPanelInfotoAllNode1Click(Sender: TObject);
    procedure ApplyPLCInfotoAllNode1Click(Sender: TObject);
  private
    procedure PopupCopyMode(AShiftState: TShiftState; APoint: TPoint);
  public
    FGridChanged: Boolean;

    procedure LoadMenuFromFile;
    procedure NodeItem2SensorCollectForm(ANode: TTreeNode);
    procedure SensorForm2NodeItem(ANode: TTreeNode);
    procedure ApplyProjectNo2AllNodes;
    procedure ApplyPanelInfo2AllNodes;
    procedure ApplyPLCInfo2AllNodes;

    function AddToMenu(Ami, ATarget: TMenuItem; AIsSubMenu: Boolean): TMenuItem;
    function AddMenuItem(Menu: TMenuItem; const Caption: string;
      OnClick: TNotifyEvent = nil; Action: TContainedAction = nil;
      ShortCut: TShortCut = 0; const Hint: string = ''; Tag: Integer = 0): TMenuItem;
    function InsertMenuItem(AMenu: TMenuItem; AInsertIndex: Integer; ANested: string;
      AOnClick: TNotifyEvent = nil; Action: TContainedAction = nil;
      AShortCut: TShortCut = 0): TMenuItem;

    function CheckMenuValid(AMenuIndex, ASubMenuIndex: integer;
                      var ACollectIndex: integer; ANested: string): Boolean;
    procedure ApplyProjectNo2Node(ANode: TTreeNode; AJson: string);
    procedure ApplyPanelInfo2Node(ANode: TTreeNode; AJson: string);
    procedure ApplyPLCInfo2Node(ANode: TTreeNode; AJson: string);
  end;

var
  SensorCableRouteEditF: TSensorCableRouteEditF;

implementation

uses MenuSaveUnit, UnitFormUtil, UnitTreeViewUtil, UnitStringUtil;

{$R *.dfm}

function TSensorCableRouteEditF.AddToMenu(Ami, ATarget: TMenuItem;
  AIsSubMenu: Boolean): TMenuItem;
begin
  //MainMenu1.Items.MenuIndex
end;

procedure TSensorCableRouteEditF.ApplyPanelInfo2AllNodes;
var
  LNode: TTreeNode;
begin
  LNode := GetRootNodeFromTreeView(EditFrameDecTV1.decTreeView1);
//  LNode := EditFrameDecTV1.decTreeView1.Selected;
  ExecuteWithAllChildren2(LNode, ApplyPanelInfo2Node, '');
end;

procedure TSensorCableRouteEditF.ApplyPanelInfo2Node(ANode: TTreeNode; AJson: string);
var
  LItem: TEngElecPartItem;
begin
  if not Assigned(ANode) then
    exit;

  LItem := TEngElecPartItem(ANode.Data);

  LItem.EngSensor.PanelName := FrameElecPartEdit11.PanelNameEdit.Text;
  LItem.EngSensor.TerminalName := FrameElecPartEdit11.TerminalNameEdit.Text;
  LItem.EngSensor.TerminalNo := FrameElecPartEdit11.TerminalNoEdit.Text;
  LItem.EngSensor.CableNo := FrameElecPartEdit11.CableNoEdit.Text;
  LItem.EngSensor.CableNote := FrameElecPartEdit11.CableNoteEdit.Text;
  LItem.EngSensor.TagName := FrameElecPartEdit11.TagNameEdit.Text;
  LItem.EngSensor.TagDesc := FrameElecPartEdit11.TagDescEdit.Text;
end;

procedure TSensorCableRouteEditF.ApplyPanelInfotoAllNode1Click(Sender: TObject);
begin
  ApplyPanelInfo2AllNodes;
end;

procedure TSensorCableRouteEditF.ApplyPLCInfo2AllNodes;
var
  LNode: TTreeNode;
begin
  LNode := GetRootNodeFromTreeView(EditFrameDecTV1.decTreeView1);
//  LNode := EditFrameDecTV1.decTreeView1.Selected;
  ExecuteWithAllChildren2(LNode, ApplyPLCInfo2Node, '');
end;

procedure TSensorCableRouteEditF.ApplyPLCInfo2Node(ANode: TTreeNode; AJson: string);
var
  LItem: TEngElecPartItem;
begin
  if not Assigned(ANode) then
    exit;

  LItem := TEngElecPartItem(ANode.Data);

  LItem.EngSensor.ModuleName := FrameElecPartEdit11.ModuleNameEdit.Text;
  LItem.EngSensor.ModuleNo := FrameElecPartEdit11.ModuleNoEdit.Text;
  LItem.EngSensor.SlotNo := FrameElecPartEdit11.SlotNoEdit.Text;
  LItem.EngSensor.ChannelNo := FrameElecPartEdit11.ChannelNoEdit.Text;
end;

procedure TSensorCableRouteEditF.ApplyPLCInfotoAllNode1Click(Sender: TObject);
begin
  ApplyPLCInfo2AllNodes;
end;

procedure TSensorCableRouteEditF.ApplyProjectNo2AllNodes;
var
  LNode: TTreeNode;
begin
  LNode := GetRootNodeFromTreeView(EditFrameDecTV1.decTreeView1);
//  LNode := EditFrameDecTV1.decTreeView1.Selected;
  ExecuteWithAllChildren2(LNode, ApplyProjectNo2Node, '');
end;

procedure TSensorCableRouteEditF.ApplyProjectNo2Node(ANode: TTreeNode; AJson: string);
var
  LItem: TEngElecPartItem;
begin
  if not Assigned(ANode) then
    exit;

  LItem := TEngElecPartItem(ANode.Data);

  LItem.ProjectNo := FrameElecPartEdit11.ProjectNoEdit.Text;
  LItem.ProjectName := FrameElecPartEdit11.ProjectNameEdit.Text;
  LItem.EngineNo := FrameElecPartEdit11.EngineNoEdit.Text;
end;

procedure TSensorCableRouteEditF.ApplyProjectNotoAllNode1Click(Sender: TObject);
begin
  ApplyProjectNo2AllNodes;
end;

procedure TSensorCableRouteEditF.BitBtn2Click(Sender: TObject);
var
  LNode: TTreeNode;
begin
  LNode := EditFrameDecTV1.decTreeView1.Selected;

  if MoveTreeNode(EditFrameDecTV1.decTreeView1) then
//    EditFrameDecTV1.SetNodeInfo2SensorRoute(LNode);
end;

procedure TSensorCableRouteEditF.BitBtn3Click(Sender: TObject);
begin
  if MoveTreeNode(EditFrameDecTV1.decTreeView1, True) then
//    EditFrameDecTV1.SetNodeInfo2SensorRoute(EditFrameDecTV1.decTreeView1.Selected);
end;

procedure TSensorCableRouteEditF.Button1Click(Sender: TObject);
begin
  //Root Node만 있으면 Skip(1개 이상의 Child Node가 있어야 함
  if EditFrameDecTV1.decTreeView1.Items.Count > 1 then
    SensorForm2NodeItem(EditFrameDecTV1.decTreeView1.Selected);
end;

procedure TSensorCableRouteEditF.Button3Click(Sender: TObject);
var
  LFileName:string;
//  LTJvgXMLSerializer_Encrypt: TJvgXMLSerializer_Encrypt;
  F : TextFile;
begin
  with TMenuSaveF.create(nil) do
  begin
    try
      if ShowModal = mrOK then
      begin
        LFileName := JvFilenameEdit1.FileName;

        if LFileName <> '' then
        begin
          if FileExists(LFileName) then
          begin

            if MessageDlg('이전에 작업한자료가 있습니다. 덮어쓰시겠습니까?',
            mtConfirmation, [mbYes, mbNo], 0)=mrNo then
              //FMenuBase.LoadFromFile(LFileName, ExtractFileName(LFileName),EncryptCB.Checked)
              exit
            //Append(F)
            else
            begin
              AssignFile(F, LFileName);
              Rewrite(F);
              CloseFile(F);
            end;
          end;

//          FMenuBase.SaveTreeViewToFile(JvCheckTreeView1, LFileName, EncryptCB.Checked);
        end
        else
          ShowMessage('File name is empty!');
      end;
    finally
      free;
    end;
  end;
end;

procedure TSensorCableRouteEditF.Button4Click(Sender: TObject);
begin
  LoadMenuFromFile;
end;

procedure TSensorCableRouteEditF.EditFrameDecTV1decTreeView1Click(
  Sender: TObject);
begin
  NodeItem2SensorCollectForm(EditFrameDecTV1.decTreeView1.Selected);
end;

procedure TSensorCableRouteEditF.EncryptCBClick(Sender: TObject);
begin
  Label10.Enabled := EncryptCB.Checked;
  PassPhraseEdit.Enabled := EncryptCB.Checked;
end;

function TSensorCableRouteEditF.CheckMenuValid(AMenuIndex, ASubMenuIndex: integer;
  var ACollectIndex: integer; ANested: string): Boolean;
var
  Li: integer;
begin
{  Result := True;
  ACollectIndex := -1;

  //MenuIndex가 존재하고 SubMenuIndex = -1인 항목이 없으면 에러(Result := False)
  if (AMenuIndex = -1) and (ASubMenuIndex = -1) then
  begin
    for Li := 0 to FMenuBase.HiMECSMenuCollect.Count - 1 do
    begin
      //if (FMenuBase.HiMECSMenuCollect.Items[Li].MenuIndex = AMenuIndex) and
      //  (FMenuBase.HiMECSMenuCollect.Items[Li].SubMenuIndex = ASubMenuIndex) then
      //begin
      //  ACollectIndex := Li;
      //  Result := False;
      //  exit;
      //end;
    end;
  end;

  for Li := 0 to FMenuBase.HiMECSMenuCollect.Count - 1 do
  begin
    if (FMenuBase.HiMECSMenuCollect.Items[Li].MenuIndex = AMenuIndex) and
      (FMenuBase.HiMECSMenuCollect.Items[Li].SubMenuIndex = ASubMenuIndex) and
      (FMenuBase.HiMECSMenuCollect.Items[Li].NestedSubMenuIndex = ANested) then
    begin
      ACollectIndex := Li;
      Result := False;
      exit;
    end;
  end;
}
end;

procedure TSensorCableRouteEditF.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TSensorCableRouteEditF.FormCreate(Sender: TObject);
begin
  UserLevel2Strings(FrameElecPartEdit11.UserLevelCB.Items);
  UserCatetory2Strings(FrameElecPartEdit11.CategoryCB.Items);
  //UserLevel2Strings(UserLevel.Items);
  //UserCatetory2Strings(Category.Items);
  FGridChanged := False;
end;

function TSensorCableRouteEditF.InsertMenuItem(AMenu: TMenuItem; AInsertIndex: Integer;
  ANested: string; AOnClick: TNotifyEvent; Action: TContainedAction;
  AShortCut: TShortCut): TMenuItem;
var
  LStr: string;
  LIndex: integer;
begin
  Result := nil;

  LStr := strToken(ANested, ',');
  LIndex := StrToInt(LStr);

  if ANested <> '' then
  begin
    Result := InsertMenuItem(AMenu.Items[LIndex], AInsertIndex, ANested);
  end
  else
  begin
    Result := TMenuItem.Create(Self);
//    Result.Caption := FMenuBase.HiMECSMenuCollect.Items[AInsertIndex].Caption;
//    Result.Hint := FMenuBase.HiMECSMenuCollect.Items[AInsertIndex].Hint;
    Result.OnClick := AOnClick;
    Result.ShortCut := AShortCut;
    Result.Action := Action;

    AMenu.Insert(LIndex, Result);
  end;

end;

{
procedure TMainForm.JvCheckTreeView1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  AnItem: TTreeNode;
  AttachMode: TNodeAttachMode;
  HT: THitTests;
begin
  if JvCheckTreeView1.Selected = nil then Exit;

  HT := JvCheckTreeView1.GetHitTestInfoAt(X, Y) ;
  AnItem := JvCheckTreeView1.GetNodeAt(X, Y) ;

  if (HT - [htOnItem, htOnIcon, htNowhere, htOnIndent] <> HT) then
  begin
    if (htOnItem in HT) or (htOnIcon in HT) then
      AttachMode := naAddChild
    else if htNowhere in HT then
      AttachMode := naAdd
    else if htOnIndent in HT then
      AttachMode := naInsert;

      JvCheckTreeView1.Selected.MoveTo(AnItem, AttachMode) ;
    end;
 end;
}

procedure TSensorCableRouteEditF.LoadMenuFromFile;
var
  LFileName:string;
//  LTJvgXMLSerializer_Encrypt: TJvgXMLSerializer_Encrypt;
  LMenuSaveF: TMenuSaveF;
begin
  LMenuSaveF := TMenuSaveF.create(nil);

  with LMenuSaveF do
  begin
    try
      OpenFormAtMousePoint(LMenuSaveF);

      if ShowModal = mrOK then
      begin
        LFileName := JvFilenameEdit1.FileName;
        if LFileName <> '' then
        begin
//          FMenuBase.LoadFromFile2TreeView(JvCheckTreeView1, LFileName, EncryptCB.Checked);

          {LTJvgXMLSerializer_Encrypt := TJvgXMLSerializer_Encrypt.Create(nil);
          try
            FMenuBase.HiMECSMenuCollect.Clear;
            FMenuBase.LoadFromFile(LFileName,PassPhraseEdit.Text,EncryptCB.Checked);
          finally
            LTJvgXMLSerializer_Encrypt.Free;
          end;}
        end
        else
          ShowMessage('File name is empty!');
      end;
    finally
      free;
    end;
  end;
end;

procedure TSensorCableRouteEditF.SensorForm2NodeItem(ANode: TTreeNode);
var
  LItem: TEngElecPartItem;
begin
  if not Assigned(ANode) then
    exit;

  LItem := TEngElecPartItem(ANode.Data);
  TIniConfigBase.LoadForm2Object(FrameElecPartEdit11, TObject(LItem), False);
//  LItem.EngSensor.PanelName := FrameElecPartEdit11.PanelNameEdit.Text;
//  LItem.EngSensor.TerminalName := FrameElecPartEdit11.TerminalNameEdit.Text;
//  LItem.EngSensor.TerminalNo := FrameElecPartEdit11.TerminalNoEdit.Text;
//  LItem.EngSensor.TagName := FrameElecPartEdit11.TagNameEdit.Text;
//  LItem.EngSensor.TagDesc := FrameElecPartEdit11.TagDescEdit.Text;
//  LItem.DLLFuncIndex := StrToIntDef(DLLFuncIndexEdit.Text,0);
//  LItem.AbsoluteIndex := StrToIntDef(FrameElecPartEdit11.AbsEdit.Text,0);
//  LItem.NodeIndex := StrToIntDef(FrameElecPartEdit11.NodeIndexEdit.Text,0);
//  LItem.LevelIndex := StrToIntDef(FrameElecPartEdit11.LevelEdit.Text,0);
//  LItem.UserLevel := String2UserLevel(UserLevelCB.Text);
//  LItem.UserCategory := String2UserCategory(CategoryCB.Text);
//  LItem.ImageListName := ImageListNameEdit.Text;
//  LItem.ImageIndex := StrToIntDef(ImageIndexEdit.Text,0);

//  ANode.Text := FrameElecPartEdit11.TagNameEdit.Text;
  ANode.Text := GetElecPartDisplayName(LItem);
end;

procedure TSensorCableRouteEditF.NodeItem2SensorCollectForm(ANode: TTreeNode);
var
  LItem: TObject;//TEngElecPartItem;
  LJson: string;
  LType: integer;
begin
  if not Assigned(ANode) then
    exit;

  LType := EditFrameDecTV1.GetJsonFromSelectedTV(ANode, LJson);

  case LType of
    1: LItem := TObject(ANode.Data);
    2: LItem := TObject(ANode.Data);
  end;

  TIniConfigBase.LoadObject2Form(FrameElecPartEdit11, TObject(LItem), False);

//  FrameElecPartEdit11.PanelNameEdit.Text := LItem.EngSensor.PanelName;
//  FrameElecPartEdit11.TerminalNameEdit.Text := LItem.EngSensor.TerminalName;
//  FrameElecPartEdit11.TerminalNoEdit.Text := LItem.EngSensor.TerminalNo;
//  FrameElecPartEdit11.TagNameEdit.Text := LItem.EngSensor.TagName;
//  FrameElecPartEdit11.TagDescEdit.Text := LItem.EngSensor.TagDesc;
//  DLLFuncIndexEdit.Text := IntToStr(LHiMECSMenuItem.DLLFuncIndex);
//  FrameElecPartEdit11.AbsEdit.Text := IntToStr(LItem.AbsoluteIndex);
//  FrameElecPartEdit11.NodeIndexEdit.Text := IntToStr(LItem.NodeIndex);
//  FrameElecPartEdit11.LevelEdit.Text := IntToStr(LItem.LevelIndex);
//  UserLevelCB.Text := UserLevel2String(LHiMECSMenuItem.UserLevel);
//  CategoryCB.Text := UserCategory2String(LHiMECSMenuItem.UserCategory);
//  ImageListNameEdit.Text := LHiMECSMenuItem.ImageListName;
//  ImageIndexEdit.Text := IntToStr(LHiMECSMenuItem.ImageIndex);
end;

procedure TSensorCableRouteEditF.PopupCopyMode(AShiftState: TShiftState;
  APoint: TPoint);
//var
//  LPoint: TPoint;
//  LMenu: TCopyModeMenuF;
begin
//  if ssCtrl in AShiftState then
//  begin
//    if FMultiDragOn < 2 then //0 또는 1이면 Popup
//    begin
//      LMenu := TCopyModeMenuF.Create(self);
//      try
//        LPoint := ClientToScreen(APoint);
//
//        if LMenu.ShowModal = mrOK then
//        begin
//          FDragCopyMode := TParamDragCopyMode(LMenu.Tag);
//
//          case TParamDragCopyMode(LMenu.Tag) of
//            dcmCopyOnlyNonExist: ;
//            dcmCopyOnlyExist: ;
//            dcmCopyAllOverWrite:  ;
//            dcmCopyCancel: ;
//          end;
//
//          if FMultiDragOn = 1 then
//            inc(FMultiDragOn);
//        end;
//      finally
//        LMenu.Free;
//      end;
//    end;
//  end;
end;

procedure TSensorCableRouteEditF.SortCollectItembyNodeIndex1Click(Sender: TObject);
begin
//  FMenuBase.SortCollectByAbsIndex(JvCheckTreeView1);
end;

function TSensorCableRouteEditF.AddMenuItem(Menu: TMenuItem; const Caption: string;
  OnClick: TNotifyEvent = nil; Action: TContainedAction = nil;
  ShortCut: TShortCut = 0; const Hint: string = ''; Tag: Integer = 0): TMenuItem;
begin
  Result := TMenuItem.Create(Menu);
  Result.Caption := Caption;
  Result.OnClick := OnClick;
  Result.ShortCut := ShortCut;

  if Hint = '' then
    Result.Hint := StripHotkey(Caption)
  else
    Result.Hint := Hint;

  Result.Tag := Tag;
  Result.Action := Action;
  Menu.Add(Result);
end;

end.
