unit FrmSnapShotCompareResult2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFrameSnapShotCompare2,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TSSCompareResultF = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    SSCompareFrame1: TSnapShotCompareFrame2;
  private
    { Private declarations }
  public
  end;

  procedure CreatenShowSSCompareResultForm(ACompareResultList: TStrings);

var
  SSCompareResultF: TSSCompareResultF;

implementation

{$R *.dfm}

procedure CreatenShowSSCompareResultForm(ACompareResultList: TStrings);
var
  LSSCompareResultF: TSSCompareResultF;
begin
  LSSCompareResultF := TSSCompareResultF.Create(nil);
  try
    LSSCompareResultF.SSCompareFrame1.LoadCompareResult2GridFromList(ACompareResultList);
    LSSCompareResultF.ShowModal;
  finally
    LSSCompareResultF.Free;
  end;
end;

{ TSSCompareResultF }

end.
