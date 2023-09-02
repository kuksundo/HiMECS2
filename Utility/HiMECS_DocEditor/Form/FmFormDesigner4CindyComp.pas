unit FmFormDesigner4CindyComp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FmFormDesignerBase, cyResizer,
  Vcl.Menus, Vcl.StdActns, System.Actions, Vcl.ActnList, AdvOfficeTabSet,
  AdvOfficeTabSetStylers, AdvToolBar, AdvToolBarStylers, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers, Vcl.ImgList, Vcl.ComCtrls, AdvGlowButton,
  Vcl.ExtCtrls;

type
  TFormDesigner4CindyComp = class(TFormDesignerBaseF)
    cyResizer1: TcyResizer;
    CindyTBImageList: TImageList;
    AdvToolBar17: TAdvToolBar;
    AdvGlowButton51: TAdvGlowButton;
    AdvGlowButton52: TAdvGlowButton;
    AdvGlowButton53: TAdvGlowButton;
    AdvGlowButton54: TAdvGlowButton;
    AdvGlowButton55: TAdvGlowButton;
    AdvGlowButton6: TAdvGlowButton;
    AdvGlowButton7: TAdvGlowButton;
    AdvGlowButton8: TAdvGlowButton;
    AdvGlowButton9: TAdvGlowButton;
    AdvGlowButton10: TAdvGlowButton;
    AdvGlowButton11: TAdvGlowButton;
    AdvGlowButton12: TAdvGlowButton;
    PanDesigning: TPanel;
    StatusBar1: TStatusBar;
    ActionList2: TActionList;
    actALToGrid: TAction;
    actMakeSameWidth: TAction;
    actMakeSameHeight: TAction;
    actMakeSameSize: TAction;
    actSpaceEqualHorz: TAction;
    actIncSpaceHorz: TAction;
    actDecSpaceHorz: TAction;
    actRemoveSpaceHorz: TAction;
    actSpaceEqualVert: TAction;
    actIncSpaceVert: TAction;
    actDecSpaceVert: TAction;
    actRemoveSpaceVert: TAction;
    procedure actALLeftExecute(Sender: TObject);
    procedure actALRightExecute(Sender: TObject);
    procedure actALVCenterExecute(Sender: TObject);
    procedure actALTopExecute(Sender: TObject);
    procedure actALBottomExecute(Sender: TObject);
    procedure actALHCenterExecute(Sender: TObject);
    procedure actALToGridExecute(Sender: TObject);
    procedure actMakeSameWidthExecute(Sender: TObject);
    procedure actMakeSameHeightExecute(Sender: TObject);
    procedure actMakeSameSizeExecute(Sender: TObject);
    procedure actALVCenterWindowExecute(Sender: TObject);
    procedure actALHCenterWindowExecute(Sender: TObject);
    procedure actSpaceEqualHorzExecute(Sender: TObject);
    procedure actDecSpaceHorzExecute(Sender: TObject);
    procedure actRemoveSpaceHorzExecute(Sender: TObject);
    procedure actIncSpaceHorzExecute(Sender: TObject);
    procedure actSpaceEqualVertExecute(Sender: TObject);
    procedure actIncSpaceVertExecute(Sender: TObject);
    procedure actDecSpaceVertExecute(Sender: TObject);
    procedure actRemoveSpaceVertExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ToggleDesignerActivate;
    function DeleteSelectedControls: integer;
  end;

var
  FormDesigner4CindyComp: TFormDesigner4CindyComp;

implementation

{$R *.dfm}

{ TFormDesigner4CindyComp }

procedure TFormDesigner4CindyComp.actALBottomExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.AlignSelection(acBottomEdges, true);
end;

procedure TFormDesigner4CindyComp.actALHCenterExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.AlignSelection(acHorizontalsCenters, false);
end;

procedure TFormDesigner4CindyComp.actALHCenterWindowExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.CenterSelection(true, false);
end;

procedure TFormDesigner4CindyComp.actALLeftExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.AlignSelection(acLeftEdges, true);
end;

procedure TFormDesigner4CindyComp.actALRightExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.AlignSelection(acRightEdges, true);
end;

procedure TFormDesigner4CindyComp.actALToGridExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.AlignSelectionToGrid;
end;

procedure TFormDesigner4CindyComp.actALTopExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.AlignSelection(acTopEdges, true);
end;

procedure TFormDesigner4CindyComp.actALVCenterExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.AlignSelection(acVerticalCenters, true);
end;

procedure TFormDesigner4CindyComp.actALVCenterWindowExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.CenterSelection(false, true);
end;

procedure TFormDesigner4CindyComp.actDecSpaceHorzExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.SpaceSelectionEquallyHorizontally(-5, false);
end;

procedure TFormDesigner4CindyComp.actDecSpaceVertExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.SpaceSelectionEquallyVertically(-5, false);
end;

procedure TFormDesigner4CindyComp.actIncSpaceHorzExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.SpaceSelectionEquallyHorizontally(5, false);
end;

procedure TFormDesigner4CindyComp.actIncSpaceVertExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.SpaceSelectionEquallyVertically(5, false);
end;

procedure TFormDesigner4CindyComp.actMakeSameHeightExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.MakeSelectionSameSize(false, true);
end;

procedure TFormDesigner4CindyComp.actMakeSameSizeExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.MakeSelectionSameSize(true, true);
end;

procedure TFormDesigner4CindyComp.actMakeSameWidthExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.MakeSelectionSameSize(true, false);
end;

procedure TFormDesigner4CindyComp.actRemoveSpaceHorzExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.SpaceSelectionEquallyHorizontally(0, true);
end;

procedure TFormDesigner4CindyComp.actRemoveSpaceVertExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.SpaceSelectionEquallyVertically(0, true);
end;

procedure TFormDesigner4CindyComp.actSpaceEqualHorzExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.SpaceSelectionEquallyHorizontally(0, false);
end;

procedure TFormDesigner4CindyComp.actSpaceEqualVertExecute(Sender: TObject);
begin
  inherited;

  cyResizer1.SpaceSelectionEquallyVertically(0, false);
end;

function TFormDesigner4CindyComp.DeleteSelectedControls: integer;
var
  i: Integer;
  Sav: TControl;
begin
  Result := 0;

  for i := cyResizer1.HandlingControlList.Count-1 downto 0 do
  begin
    Sav := cyResizer1.HandlingControlList[i].Control;
    cyResizer1.HandlingControlList.RemoveFromIndex(i);
    Inc(Result);
    Sav.Free;
  end;
end;

procedure TFormDesigner4CindyComp.ToggleDesignerActivate;
begin
  if not cyResizer1.Active
  then begin
    cyResizer1.Activate(PanDesigning);
//    SBActivate.Caption := 'Deactivate designing mode';
  end
  else begin
    cyResizer1.Deactivate;
//    SBActivate.Caption := 'Activate designing mode';
  end;
end;

end.
