unit UnitFrameSnapShotNaviTV2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  StrUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, VirtualTrees;

type
  PNodeData = ^TNodeData;
  TNodeData = record
    Caption,
    StaticText,
    ForeignText,
    Value: String;
    Category,
    ImageIndex,
    Level: Integer;
  end;

  TSSNaviTVFrame = class(TFrame)
    Panel1: TPanel;
    Edit1: TEdit;
    VST1: TVirtualStringTree;
    Panel2: TPanel;
    PopupMenu1: TPopupMenu;
    procedure Edit1Change(Sender: TObject);
    procedure VST1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VST1InitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure VST1NewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: string);
    procedure VST1GetPopupMenu(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; const P: TPoint; var AskParent: Boolean;
      var PopupMenu: TPopupMenu);
    procedure VST1DrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
      Node: PVirtualNode; Column: TColumnIndex; const Text: string;
      const CellRect: TRect; var DefaultDraw: Boolean);
  private
    procedure SearchForText(Sender: TBaseVirtualTree; Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadSnapShotNavi2Grid;

  end;

implementation

uses UnitVirtualTreeUtil, UnitE2SRecord2, UnitEngineParamConst;

{$R *.dfm}

constructor TSSNaviTVFrame.Create(AOwner: TComponent);
begin
  inherited;

  g_Navigation4AVAT2.InitArrayRecord(R_Navigation4AVAT2);
  g_Measurands4AVAT2.InitArrayRecord(R_Measurands4AVAT2);
  g_TestMode4AVAT2.InitArrayRecord(R_TestMode4AVAT2);
  g_Tuning4AVAT2.InitArrayRecord(R_Tuning4AVAT2);
  g_SystemInfo4AVAT2.InitArrayRecord(R_SystemInfo4AVAT2);
  g_Snapshot4AVAT2.InitArrayRecord(R_Snapshot4AVAT2);

  //  VST1.TreeOptions.PaintOptions := VST1.TreeOptions.PaintOptions - [toShowTreeLines];
  VST1.ButtonStyle := bsTriangle;
end;

destructor TSSNaviTVFrame.Destroy;
begin

  inherited;
end;

procedure TSSNaviTVFrame.Edit1Change(Sender: TObject);
var
  LFoundNode: PVirtualNode;
begin
  LFoundNode := VST1.IterateSubtree(nil, SearchForText, Pointer(Edit1.Text));

  if Assigned(LFoundNode) then
  begin
    VST1.FocusedNode := LFoundNode;
    VST1.Selected[LFoundNode] := True;
  end;
end;

procedure TSSNaviTVFrame.LoadSnapShotNavi2Grid;
var
  i: integer;
  LRoot, LChild: PVirtualNode;
  LData: PNodeData;

  procedure SetNodeData(AData: PNodeData);
  begin
    AData^.Caption := g_Navigation4AVAT2.ToString(i);
    AData^.Category := i;
  end;

  procedure AddSubCategory(ACategory: integer);
  var
    Li: integer;
  begin
    case TE2S_Navigation4AVAT2(ACategory) of
      e2snMeasurands: begin
        for Li := 1 to Ord(High(TE2S_Measurands4AVAT2))-1 do
        begin
          LChild := VST1.AddChild(LRoot);
          LData := VST1.GetNodeData(LChild);
          LData^.Caption := g_Measurands4AVAT2.ToString(Li);
          LData^.Category := i;
        end;
      end;
      e2snTestMode: begin
        for Li := 1 to Ord(High(TE2S_TestMode4AVAT2))-1 do
        begin
          LChild := VST1.AddChild(LRoot);
          LData := VST1.GetNodeData(LChild);
          LData^.Caption := g_TestMode4AVAT2.ToString(Li);
          LData^.Category := i;
        end;
      end;
      e2snTuning: begin
        for Li := 1 to Ord(High(TE2S_Tuning4AVAT2))-1 do
        begin
          LChild := VST1.AddChild(LRoot);
          LData := VST1.GetNodeData(LChild);
          LData^.Caption := g_Tuning4AVAT2.ToString(Li);
          LData^.Category := i;
        end;
      end;
      e2snSystemInformation: begin
        for Li := 1 to Ord(High(TE2S_SystemInfo4AVAT2))-1 do
        begin
          LChild := VST1.AddChild(LRoot);
          LData := VST1.GetNodeData(LChild);
          LData^.Caption := g_SystemInfo4AVAT2.ToString(Li);
          LData^.Category := i;
        end;
      end;
      e2snSnapShots: begin
        for Li := 1 to Ord(High(TE2S_Snapshot4AVAT2))-1 do
        begin
          LChild := VST1.AddChild(LRoot);
          LData := VST1.GetNodeData(LChild);
          LData^.Caption := g_Snapshot4AVAT2.ToString(Li);
          LData^.Category := i;
        end;
      end;
    end;//case
  end;
begin
  VST1.NodeDataSize := SizeOf(TNodeData);

  for i := 1 to Ord(High(TE2S_Navigation4AVAT2))-1 do
  begin
    LRoot := VST1.AddChild(nil);
    LData := VST1.GetNodeData(LRoot);

    SetNodeData(LData);
    AddSubCategory(i);

//    VST1.Expanded[LRoot] := True;
  end;
end;

procedure TSSNaviTVFrame.SearchForText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  NodeData: PNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  Abort := AnsiStartsStr(String(Data), NodeData.Caption);
end;

procedure TSSNaviTVFrame.VST1DrawText(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
var
  BackMode, Position: integer;
begin
//  Position := Pos(AnsiLowerCase(Edit1.Text), AnsiLowerCase(Text));
//
//  if Position > 0 then
  if StartsText(Edit1.Text, Text) and (Node = Sender.FocusedNode) then
  begin
    BackMode := GetBkMode(TargetCanvas.Handle);
    TargetCanvas.Brush.Color := clYellow;
//    TargetCanvas.FillRect(Rect(
//      CellRect.Left + TargetCanvas.TextWidth(Copy(Text,1,Position-1)),
//      CellRect.Top +3,
//      CellRect.Left + TargetCanvas.TextWidth(Copy(Text,1,Position-1)) +
//        TargetCanvas.TextWidth(Copy(Text, Position, Length(Edit1.Text))),
//      CellRect.Bottom - 3));

    TargetCanvas.FillRect(Rect(
      CellRect.Left,
      CellRect.Top + 1,
      CellRect.Left + TargetCanvas.TextWidth(Copy(Text, 1, Length(Edit1.Text))),
      CellRect.Bottom - 1));

    SetBkMode(TargetCanvas.Handle, BackMode);
  end;
end;

procedure TSSNaviTVFrame.VST1GetPopupMenu(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; const P: TPoint;
  var AskParent: Boolean; var PopupMenu: TPopupMenu);
begin
  case Column of
    0:
      PopupMenu := PopupMenu1
  else
    PopupMenu := nil;
  end;
end;

procedure TSSNaviTVFrame.VST1GetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PNodeData;
begin
  Data := Sender.GetNodeData(Node);
  CellText := '';

  case Column of
    0: // main column (has two different captions)
      case TextType of
        ttNormal:
          CellText := Data.Caption;
        ttStatic:
          CellText := Data.StaticText;
      end;
    1: CellText := Data.Value;
    2:
      if TextType = ttNormal then
        CellText := Data.Value;
  end;
end;

procedure TSSNaviTVFrame.VST1InitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PNodeData;
begin
  Data := Sender.GetNodeData(Node);

  with Data^ do
  begin
    Level := Sender.GetNodeLevel(Node);
  end;
end;

procedure TSSNaviTVFrame.VST1NewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: string);
var
  Data: PNodeData;
begin
  Data := Sender.GetNodeData(Node);

  if Assigned(Data) then
  begin
    case Column of
      0: Data^.Caption := Text;
      1: Data^.Value := Text;
    end;
  end;
end;

end.
