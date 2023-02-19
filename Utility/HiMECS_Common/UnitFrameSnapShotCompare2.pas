unit UnitFrameSnapShotCompare2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NxColumnClasses,
  NxColumns, NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid,
  Vcl.Menus,
  mormot.core.variants,
  UnitE2SRecord2;

type
  TSnapShotCompareFrame2 = class(TFrame)
    NextGrid1: TNextGrid;
    ParamDesc: TNxTextColumn;
    CurrentValue: TNxTextColumn;
    FileValue: TNxTextColumn;
    Apply: TNxCheckBoxColumn;
    PopupMenu1: TPopupMenu;
    SelectAll1: TMenuItem;
    DeSelectAll1: TMenuItem;
    procedure SelectAll1Click(Sender: TObject);
    procedure DeSelectAll1Click(Sender: TObject);
  private
    procedure SelectAllApply2Grid(AIsSelectAll: Boolean=True);
    procedure ReverseSelectAllApply2Grid;
  public
    procedure LoadCompareResult2GridFromList(ACompareResultList: TStrings);
  end;

implementation

//uses ;

{$R *.dfm}

{ TSnapShotCompareFrame }

procedure TSnapShotCompareFrame2.DeSelectAll1Click(Sender: TObject);
begin
  SelectAllApply2Grid(False);
end;

procedure TSnapShotCompareFrame2.LoadCompareResult2GridFromList(
  ACompareResultList: TStrings);
var
  LDoc: Variant;
  i, LRow: integer;
begin
//  TDocVariant.New(LDoc);
  NextGrid1.BeginUpdate;
  try
    for i := 0 to ACompareResultList.Count - 1 do
    begin
      LDoc := _JsonFast(ACompareResultList.Strings[i]);
      LRow := NextGrid1.AddRow;
      NextGrid1.CellsByName['ParamDesc', LRow] := LDoc.ParamDesc;
      NextGrid1.CellsByName['CurrentValue', LRow] := LDoc.CurrentValue;
      NextGrid1.CellsByName['FileValue', LRow] := LDoc.FileValue;
    end;
  finally
    NextGrid1.EndUpdate();
  end;
end;

procedure TSnapShotCompareFrame2.ReverseSelectAllApply2Grid;
var
  i: integer;
begin
  for i := 0 to NextGrid1.RowCount - 1 do
  begin
    if NextGrid1.CellByName['Apply', i].AsInteger = 0 then
      NextGrid1.CellByName['Apply', i].AsInteger := 1
    else
      NextGrid1.CellByName['Apply', i].AsInteger := 0;
  end;
end;

procedure TSnapShotCompareFrame2.SelectAll1Click(Sender: TObject);
begin
  SelectAllApply2Grid();
end;

procedure TSnapShotCompareFrame2.SelectAllApply2Grid(AIsSelectAll: Boolean);
var
  i, LValue: integer;
begin
  if AIsSelectAll then
    LValue := 1
  else
    LValue := 0;

  for i := 0 to NextGrid1.RowCount - 1 do
    NextGrid1.CellByName['Apply', i].AsInteger := LValue;
end;

end.
