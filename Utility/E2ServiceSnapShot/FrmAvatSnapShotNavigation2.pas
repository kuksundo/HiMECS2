unit FrmAvatSnapShotNavigation2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, StrUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.StdCtrls,
  UnitFrameSnapShotNaviTV2;

type
  TSnapShotNaviF = class(TForm)
    SSNaviTVFrame: TSSNaviTVFrame;
  private
    function MakeJsonFromSSNaviEnum: string;
  public
  end;

  procedure CreateOrShowSnapShotNavigation;
var
  SnapShotNaviF: TSnapShotNaviF;

implementation

uses UnitVirtualTreeUtil, UnitE2SRecord2, UnitEngineParamConst;

{$R *.dfm}

procedure CreateOrShowSnapShotNavigation;
begin
  SnapShotNaviF := TSnapShotNaviF.Create(nil);
  try
    SnapShotNaviF.SSNaviTVFrame.LoadSnapShotNavi2Grid;
    SnapShotNaviF.ShowModal;
  finally
    SnapShotNaviF.Free;
  end;
end;

{ TSnapShotNaviF }
function TSnapShotNaviF.MakeJsonFromSSNaviEnum: string;
begin

end;

end.
