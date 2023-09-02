unit FmFormDesignerBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FmHelpAware, Vcl.Menus, Vcl.StdActns,
  System.Actions, Vcl.ActnList, AdvOfficeTabSet, AdvOfficeTabSetStylers,
  AdvToolBar, AdvToolBarStylers, AdvOfficeStatusBar, AdvOfficeStatusBarStylers,
  Vcl.ImgList, Vcl.ComCtrls, AdvGlowButton;

type
  TFormDesignerBaseF = class(THelpAwareForm)
    AdvToolBarPager2: TAdvToolBarPager;
    AdvPage4: TAdvPage;
    AdvToolBar10: TAdvToolBar;
    AdvGlowButton26: TAdvGlowButton;
    AdvGlowButton27: TAdvGlowButton;
    AdvGlowButton28: TAdvGlowButton;
    AdvGlowButton29: TAdvGlowButton;
    AdvGlowButton30: TAdvGlowButton;
    AdvToolBar11: TAdvToolBar;
    AdvGlowButton31: TAdvGlowButton;
    AdvGlowButton32: TAdvGlowButton;
    AdvGlowButton33: TAdvGlowButton;
    RunButton: TAdvGlowButton;
    AdvToolBar12: TAdvToolBar;
    AdvGlowButton35: TAdvGlowButton;
    AdvGlowButton36: TAdvGlowButton;
    AdvGlowButton37: TAdvGlowButton;
    AdvToolBar13: TAdvToolBar;
    AdvGlowButton38: TAdvGlowButton;
    AdvGlowButton39: TAdvGlowButton;
    AdvGlowButton40: TAdvGlowButton;
    AdvToolBar14: TAdvToolBar;
    AdvGlowButton41: TAdvGlowButton;
    AdvPage5: TAdvPage;
    AdvToolBar15: TAdvToolBar;
    AdvGlowButton42: TAdvGlowButton;
    AdvGlowButton43: TAdvGlowButton;
    AdvGlowButton45: TAdvGlowButton;
    AdvToolBar16: TAdvToolBar;
    AdvGlowButton46: TAdvGlowButton;
    AdvGlowButton47: TAdvGlowButton;
    AdvGlowButton48: TAdvGlowButton;
    AdvGlowButton49: TAdvGlowButton;
    AdvGlowButton50: TAdvGlowButton;
    AdvToolBar1: TAdvToolBar;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    AdvGlowButton3: TAdvGlowButton;
    AdvGlowButton4: TAdvGlowButton;
    AdvGlowButton5: TAdvGlowButton;
    AdvPage6: TAdvPage;
    PageControl1: TPageControl;
    ImageList1: TImageList;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvOfficeTabSetOfficeStyler1: TAdvOfficeTabSetOfficeStyler;
    ActionList1: TActionList;
    actNew: TAction;
    actNewSDI: TAction;
    actPreview: TAction;
    actPropsView: TAction;
    actUndelete: TAction;
    actOpen: TAction;
    actOpenSDI: TAction;
    actSave: TAction;
    actSaveAs: TAction;
    actCloseAll: TAction;
    actClose: TAction;
    actSaveSaveAll: TAction;
    actCopy: TAction;
    actCut: TAction;
    actPaste: TAction;
    actDelete: TAction;
    actLock: TAction;
    actUnlock: TAction;
    actUnlockAll: TAction;
    actSelectAll: TAction;
    actAlignToGrid: TAction;
    actBringToFront: TAction;
    actSendToBack: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowTileVertical1: TWindowTileVertical;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowArrange1: TWindowArrange;
    actEnabled: TAction;
    actEnableAll: TAction;
    actChangeData: TAction;
    actZoom100: TAction;
    actPrint: TAction;
    actALLeft: TAction;
    actALRight: TAction;
    actALTop: TAction;
    actALBottom: TAction;
    actALHSpace: TAction;
    actALVSpace: TAction;
    actALHCenter: TAction;
    actALVCenter: TAction;
    actALHCenterWindow: TAction;
    actALVCenterWindow: TAction;
    actRepProps: TAction;
    actRun: TAction;
    actDebugWin: TAction;
    actExit: TAction;
    actBreakPoint: TAction;
    actWindowbar: TAction;
    actStatusBar: TAction;
    PopupMenu1: TPopupMenu;
    Enable1: TMenuItem;
    N7: TMenuItem;
    Cut2: TMenuItem;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    Delete2: TMenuItem;
    N2: TMenuItem;
    Align2: TMenuItem;
    actALLeft2: TMenuItem;
    actALRight2: TMenuItem;
    actALHSpace2: TMenuItem;
    actALHCenter2: TMenuItem;
    actALHCenterWindow2: TMenuItem;
    N10: TMenuItem;
    actALTop2: TMenuItem;
    actALBottom2: TMenuItem;
    actALVSpace2: TMenuItem;
    actALVCenter2: TMenuItem;
    actALVCenterWindow2: TMenuItem;
    AlignToGrid1: TMenuItem;
    Bringtofront1: TMenuItem;
    Sendtoback2: TMenuItem;
    N6: TMenuItem;
    Lock2: TMenuItem;
    Unlock1: TMenuItem;
    N4: TMenuItem;
    BreakPoint1: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
  private
    { Private declarations }
  public
    class function Execute(AOwner: TComponent): Boolean;
      {Displays dialog box and adds xxx if user OKs.
        @param AOwner [in] Component that owns dialog box.
        @param CatList [in] List of categories available for deletion.
      }
  end;

var
  FormDesignerBaseF: TFormDesignerBaseF;

implementation

{$R *.dfm}

{ TFormDesignerBaseF }

class function TFormDesignerBaseF.Execute(AOwner: TComponent): Boolean;
begin
  with InternalCreate(AOwner) do
    try
      Result := ShowModal = mrOK;
    finally
      Free;
    end;
end;

end.
