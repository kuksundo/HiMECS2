unit FrmSensorCableRoute2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  DropSource, DragDropText, DragDrop, DropTarget, Vcl.Menus,
  FrmSensorCableRouteEdit2, FrmPLCChnnelInfo2,
  UnitFrameEngParamDecTV2, Vcl.ImgList, decTreeView;
  // Oz.SGL
//  Oz.SGL.Heap,
//  Oz.SGL.Collections     ;
type
  TSensorCableRouteF2 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    FrameDecTV1: TFrameDecTreeView2;
    ShowPLCChannel1: TMenuItem;
    ShowPanelLayout1: TMenuItem;
    ShowPanelInside1: TMenuItem;
    N1: TMenuItem;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditItems1Click(Sender: TObject);
    procedure FrameDecTV1NewSubItem1Click(Sender: TObject);
    procedure ShowPanelLayout1Click(Sender: TObject);
    procedure ShowPanelInside1Click(Sender: TObject);
    procedure ShowPLCChannel1Click(Sender: TObject);
  private
    procedure EditItems;
  public
    procedure ExecTargetDrop(ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
    procedure ShowPLCChnnel;
    procedure ShowPanelLayout;
    procedure ShowPanelInside;
  end;

var
  SensorCableRouteF2: TSensorCableRouteF2;

implementation

uses UnitEngineElecPartClass2, CopyData,
  FrmMCPPLC2, FrmACPPLC2, FrmMCPLayout2, FrmACPLayout2, FrmMCPPanelInside2, FrmACPPanelInside2;

{$R *.dfm}

procedure TSensorCableRouteF2.EditItems;
var
  LSensorCableRouteEditF: TSensorCableRouteEditF;
  LJson: string;
begin
  LSensorCableRouteEditF := TSensorCableRouteEditF.Create(nil);
  try
    with LSensorCableRouteEditF do
    begin
      FrameDecTV1.ReArrangeDataItemIndexFromNode;
      FrameDecTV1.GetJsonFromTreeView(LJson);
      EditFrameDecTV1.decTreeView1.Items.Clear;
      EditFrameDecTV1.LoadFromJsonString(nil, LJson, False, True);

      if ShowModal = mrOK then
      begin
        EditFrameDecTV1.ReArrangeDataItemIndexFromNode;
        EditFrameDecTV1.GetJsonFromTreeView(LJson);
        FrameDecTV1.decTreeView1.Items.Clear;
        FrameDecTV1.LoadFromJsonString(nil, LJson, False, True);
      end;
    end;
  finally
    LSensorCableRouteEditF.Free
  end;
end;

procedure TSensorCableRouteF2.EditItems1Click(Sender: TObject);
begin
  EditItems;
end;

procedure TSensorCableRouteF2.ExecTargetDrop(ShiftState: TShiftState;
  APoint: TPoint; var Effect: Integer);
begin
  // Determine if we got our custom format.
//  if (FHiMECSMenuItemDataFormat.HasData) then
//  begin
//    LHiMECSMenuItem := THiMECSMenuItem.Create(nil);
//    try
//      FHiMECSMenuItemDataFormat.MenuItemRecord.FMenuItem.AssignToHiMECSMenuItem(LHiMECSMenuItem);
//      AddHiMECSMenuItem2Node(LHiMECSMenuItem);
//    finally
//      LHiMECSMenuItem.Free;
//    end;
//  end;
end;

procedure TSensorCableRouteF2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  SendMessage(TWinControl(Owner).Handle, WM_CABLEROUTEFORMCLOSE, 0, 0);
end;

procedure TSensorCableRouteF2.FrameDecTV1NewSubItem1Click(Sender: TObject);
begin
  FrameDecTV1.NewSubItem1Click(Sender);
//  EditItems;
end;

procedure TSensorCableRouteF2.ShowPanelInside;
var
  LPLCChannelInfoRec: TPLCChannelInfoRec;
begin
  LPLCChannelInfoRec := FrameDecTV1.GetPanelInfoRecFromTV(FrameDecTV1.decTreeView1.Selected);

  if LPLCChannelInfoRec.FPanelName = 'MCP' then
    CreateOrShowMCPInsideForm(LPLCChannelInfoRec)
  else
  if LPLCChannelInfoRec.FPanelName = 'ACP' then
    CreateOrShowACPInsideForm(LPLCChannelInfoRec);
end;

procedure TSensorCableRouteF2.ShowPanelInside1Click(Sender: TObject);
begin
  ShowPanelInside;
end;

procedure TSensorCableRouteF2.ShowPanelLayout;
var
  LPLCChannelInfoRec: TPLCChannelInfoRec;
begin
  LPLCChannelInfoRec := FrameDecTV1.GetPanelInfoRecFromTV(FrameDecTV1.decTreeView1.Selected);

  if LPLCChannelInfoRec.FPanelName = 'MCP' then
    CreateOrShowMCPLayOutForm(LPLCChannelInfoRec)
  else
  if LPLCChannelInfoRec.FPanelName = 'ACP' then
    FrmACPLayout2.CreateOrShowMCPLayOutForm(LPLCChannelInfoRec);
end;

procedure TSensorCableRouteF2.ShowPanelLayout1Click(Sender: TObject);
begin
  ShowPanelLayout;
end;

procedure TSensorCableRouteF2.ShowPLCChannel1Click(Sender: TObject);
begin
//  CreateOrShowMCPPLCForm;
  ShowPLCChnnel;
end;

procedure TSensorCableRouteF2.ShowPLCChnnel;
var
  LPLCChannelInfoRec: TPLCChannelInfoRec;
begin
  LPLCChannelInfoRec := FrameDecTV1.GetPLCInfoRecFromTV;

  if LPLCChannelInfoRec.FPanelName = 'MCP' then
    CreateOrShowMCPPLCForm(LPLCChannelInfoRec)
  else
  if LPLCChannelInfoRec.FPanelName = 'ACP' then
    CreateOrShowACPPLCForm(LPLCChannelInfoRec);
end;

end.
