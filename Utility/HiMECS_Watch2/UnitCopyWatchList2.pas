unit UnitCopyWatchList2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ImgList,
  AdvToolBtn, Vcl.Menus, AdvEdit, UnitFrameWatchGrid2;

type
  TCopyWatchListF = class(TForm)
    Sel4XYGraphPanel: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ImageList1: TImageList;
    ChannelListCB: TComboBox;
    Label1: TLabel;
    ChClearCB: TCheckBox;
    FormulaPanel: TPanel;
    ExprEdt: TEdit;
    Label2: TLabel;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    rigonometric1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    sin1: TMenuItem;
    cos1: TMenuItem;
    tan1: TMenuItem;
    Etc1: TMenuItem;
    arcsin1: TMenuItem;
    arccos1: TMenuItem;
    ctan1: TMenuItem;
    AdvToolButton2: TAdvToolButton;
    Label3: TLabel;
    ItemNameEdit: TEdit;
    N5: TMenuItem;
    neg1: TMenuItem;
    log1: TMenuItem;
    ln2: TMenuItem;
    exp2: TMenuItem;
    sqrt2: TMenuItem;
    sqr1: TMenuItem;
    logn1: TMenuItem;
    int1: TMenuItem;
    frac1: TMenuItem;
    abs2: TMenuItem;
    ceil1: TMenuItem;
    floor1: TMenuItem;
    ldexp1: TMenuItem;
    lnxp11: TMenuItem;
    max1: TMenuItem;
    min1: TMenuItem;
    roundto1: TMenuItem;
    sign1: TMenuItem;
    sum1: TMenuItem;
    MultiItemsFunction1: TMenuItem;
    Sum2: TMenuItem;
    Average1: TMenuItem;
    N7: TMenuItem;
    Logic1: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    Custom1: TMenuItem;
    N32WayValve1: TMenuItem;
    FWG: TFrameWatchGrid2;
    procedure Button1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure sin1Click(Sender: TObject);
    procedure cos1Click(Sender: TObject);
    procedure tan1Click(Sender: TObject);
    procedure ctan1Click(Sender: TObject);
    procedure arcsin1Click(Sender: TObject);
    procedure arccos1Click(Sender: TObject);
    procedure arctan1Click(Sender: TObject);
    procedure sinh1Click(Sender: TObject);
    procedure cosh1Click(Sender: TObject);
    procedure tanh1Click(Sender: TObject);
    procedure coth1Click(Sender: TObject);
    procedure Abs1Click(Sender: TObject);
    procedure Sqrt1Click(Sender: TObject);
    procedure Ln1Click(Sender: TObject);
    procedure Exp1Click(Sender: TObject);
    procedure Power1Click(Sender: TObject);
    procedure heaviside1Click(Sender: TObject);
    procedure neg1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure log1Click(Sender: TObject);
    procedure ln2Click(Sender: TObject);
    procedure exp2Click(Sender: TObject);
    procedure sqrt2Click(Sender: TObject);
    procedure sqr1Click(Sender: TObject);
    procedure logn1Click(Sender: TObject);
    procedure int1Click(Sender: TObject);
    procedure frac1Click(Sender: TObject);
    procedure abs2Click(Sender: TObject);
    procedure ceil1Click(Sender: TObject);
    procedure floor1Click(Sender: TObject);
    procedure ldexp1Click(Sender: TObject);
    procedure lnxp11Click(Sender: TObject);
    procedure max1Click(Sender: TObject);
    procedure min1Click(Sender: TObject);
    procedure roundto1Click(Sender: TObject);
    procedure sign1Click(Sender: TObject);
    procedure sum1Click(Sender: TObject);
    procedure Sum2Click(Sender: TObject);
    procedure Average1Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N32WayValve1Click(Sender: TObject);
    procedure FWGNextGrid1DblClick(Sender: TObject);
    procedure FWGNextGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FWGNextGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FWGNextGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FWGNextGrid1SelectCell(Sender: TObject; ACol, ARow: Integer);
  private
    procedure InsertFunction2Edit(AMenuItem: TMenuItem);
    function GetSumFormula: string;
    procedure InsertSum2Edit;
    procedure DeleteLastChar(var AStr: string);
  public
    FTagName: string;

    procedure CopyFromMS(AStream: TStream);
    procedure CopyFromFile(AFileName:string);
  end;

var
  CopyWatchListF: TCopyWatchListF;

implementation

//uses UtilUnit;

{$R *.dfm}

//ASourceString의 APos 위치에 AInsertString을 삽입함
function InsertStringAtCursor(ASourceString, AInsertString: string; APos: integer): string;
var
  LStr, LStr2: string;
begin
  LStr := Copy(ASourceString, 1, APos);
  LStr2 := Copy(ASourceString, APos+1, Length(ASourceString));
  Result := LStr + AInsertString + LStr2;
end;

{ TForm2 }

procedure TCopyWatchListF.Abs1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.abs2Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));

end;

procedure TCopyWatchListF.arccos1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.arcsin1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.arctan1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.Average1Click(Sender: TObject);
var
  LAverage: string;
begin
  if FormulaPanel.Visible then
  begin
    if FWG.NextGrid1.SelectedCount > 1 then
    begin
      LAverage := GetSumFormula;
      LAverage := LAverage + '/' + IntToStr(FWG.NextGrid1.SelectedCount);
      ExprEdt.Text := InsertStringAtCursor(ExprEdt.Text, LAverage, ExprEdt.SelStart);
      ExprEdt.SelStart := Length(ExprEdt.Text);
    end
    else
      ShowMessage('This function is used only when multi-items selected!');
  end;
end;

procedure TCopyWatchListF.Button1Click(Sender: TObject);
begin
  FWGNextGrid1DblClick(nil);
end;

procedure TCopyWatchListF.ceil1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.CopyFromFile(AFileName: string);
begin
  FWG.NextGrid1.LoadFromTextFile(AFileName);
end;

procedure TCopyWatchListF.CopyFromMS(AStream: TStream);
begin
  FWG.NextGrid1.LoadFromStream(AStream);
end;

procedure TCopyWatchListF.cos1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.cosh1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.coth1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.ctan1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.DeleteLastChar(var AStr: string);
begin
  AStr := Copy(AStr, 1, Length(AStr)-1);
end;

procedure TCopyWatchListF.Exp1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.exp2Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.floor1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.frac1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.FWGNextGrid1DblClick(Sender: TObject);
begin
  if FormulaPanel.Visible then
  begin
    if FWG.NextGrid1.SelectedRow > -1 then
    begin
      ExprEdt.Text := InsertStringAtCursor(ExprEdt.Text,
        FWG.NextGrid1.CellByName['TagName', FWG.NextGrid1.SelectedRow].AsString,
        ExprEdt.SelStart );
      ExprEdt.SelStart := Length(ExprEdt.Text);
    end;
  end;
end;

procedure TCopyWatchListF.FWGNextGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
;
end;

procedure TCopyWatchListF.FWGNextGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ;
end;

procedure TCopyWatchListF.FWGNextGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
;
end;

procedure TCopyWatchListF.FWGNextGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer);
begin
;
end;

function TCopyWatchListF.GetSumFormula: string;
var
  i: integer;
begin
  Result := '(';

  for i := 0 to FWG.NextGrid1.RowCount - 1 do
    if FWG.NextGrid1.Row[i].Selected then
      Result := Result + FWG.NextGrid1.CellByName['ItemName', i].AsString + '+';

  DeleteLastChar(Result);
  Result := Result + ')';
end;

procedure TCopyWatchListF.heaviside1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.InsertFunction2Edit(AMenuItem: TMenuItem);
var
  LPos: integer;
begin
  if FormulaPanel.Visible then
  begin
    LPos := ExprEdt.SelStart;
    ExprEdt.Text := InsertStringAtCursor(ExprEdt.Text,AMenuItem.Caption, ExprEdt.SelStart);
    ExprEdt.SelStart := LPos + Length(AMenuItem.Caption);
  end;
end;

procedure TCopyWatchListF.InsertSum2Edit;
var
  LSum: string;
begin
  if FormulaPanel.Visible then
  begin
    if FWG.NextGrid1.SelectedCount > 1 then
    begin
      LSum := GetSumFormula;
      ExprEdt.Text := InsertStringAtCursor(ExprEdt.Text, LSum, ExprEdt.SelStart);
      ExprEdt.SelStart := Length(ExprEdt.Text);
    end
    else
      ShowMessage('This function is used only when multi-items selected!');
  end;
end;

procedure TCopyWatchListF.int1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.ldexp1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.Ln1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.ln2Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.lnxp11Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.log1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.logn1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.max1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));

end;

procedure TCopyWatchListF.min1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.N10Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.N11Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.N2Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.N32WayValve1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.N3Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.N4Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.N5Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.N6Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.N7Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.N8Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.N9Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.neg1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.Power1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.roundto1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.sign1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.sin1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.sinh1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.sqr1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.Sqrt1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.sqrt2Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.sum1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.Sum2Click(Sender: TObject);
begin
  InsertSum2Edit;
end;

procedure TCopyWatchListF.tan1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

procedure TCopyWatchListF.tanh1Click(Sender: TObject);
begin
  InsertFunction2Edit(TMenuItem(Sender));
end;

end.
