unit UnitTileListBase;

interface

uses classes, SysUtils, ExtCtrls, Vcl.Graphics, JHP.BaseConfigCollect;

type
  THiMECSTileListBase = class(TpjhBase)
  private
    FListTitle,
    FListPath: string;
    //TAdvSmoothTileList(Monitoring List/Communication List) ¼³Á¤°ª
    FTileRowNum,
    FTileColNum: integer;
    FLauncherHandle: THandle;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

  published
    property TileRowNum: integer read FTileRowNum write FTileRowNum;
    property TileColNum: integer read FTileColNum write FTileColNum;
    property LauncherHandle: THandle read FLauncherHandle write FLauncherHandle;
  end;

implementation

{ THiMECSTileListBase }

constructor THiMECSTileListBase.Create(AOwner: TComponent);
begin

end;

destructor THiMECSTileListBase.Destroy;
begin

  inherited;
end;

end.
