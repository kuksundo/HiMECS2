{
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2013-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Implements a frame that displays a message and progress bar. Designed for use
 * with the TUserDataPathDlg dialogue box to indicate progress when moving the
 * user database.
}


unit FrProgress;


interface


uses
  // Delphi
  Controls, StdCtrls, ComCtrls, Classes, ExtCtrls, Forms,
  // Project
  UStructs;

type
  ///  <summary>Frame that displays a message and a progress bar.</summary>
  ///  <remarks>For use from TUserDataPathDlg to indicate progress when moving
  ///  the user database.</remarks>
  TProgressFrame = class(TFrame)
    pnlBody: TPanel;
    prgProgress: TProgressBar;
    lblDescription: TLabel;
  private
    ///  <summary>Getter for Description property.</summary>
    function GetDescription: string;
    ///  <summary>Setter for Description property.</summary>
    procedure SetDescription(const Value: string);
    ///  <summary>Getter for Progress property.</summary>
    function GetProgress: Integer;
    ///  <summary>Setter for Progress property.</summary>
    procedure SetProgress(const Value: Integer);
    ///  <summary>Getter for Range property.</summary>
    function GetRange: TRange;
    ///  <summary>Setter for Range property.</summary>
    procedure SetRange(const Value: TRange);
  public
    ///  <summary>Displays the frame aligned above the given control.</summary>
    ///  <remarks>NOTE: The frame should only be displayed this way: do not set
    ///  the frame's Visible property to True otherwise the frame will not be
    ///  size and aligned correctly.</remarks>
    procedure Show(const AlignToCtrl: TWinControl);
    ///  <summary>Brief description of operation for which progres bar is
    ///  showing progress.</summary>
    ///  <remarks>This description is displayed in the frame.</remarks>
    property Description: string read GetDescription write SetDescription;
    ///  <summary>Amount of progress to be displayed in progress bar.</summary>
    ///  <remarks>If this value falls outside the range specified by the Range
    ///  property it will be constrained to fit the range.</remarks>
    property Progress: Integer read GetProgress write SetProgress;
    ///  <summary>Specifies the range of values to be displayed by the progress
    ///  bar.</summary>
    ///  <remarks>The value of the Progress property is constrained to lie
    ///  within this range.</remarks>
    property Range: TRange read GetRange write SetRange;
  end;


implementation


uses
  // Delphi
  UCtrlArranger;

{$R *.dfm}

{ TUserDataPathDlgProgressFrame }

function TProgressFrame.GetDescription: string;
begin
  Result := lblDescription.Caption;
end;

function TProgressFrame.GetProgress: Integer;
begin
  Result := prgProgress.Position;
end;

function TProgressFrame.GetRange: TRange;
begin
  Result := TRange.Create(prgProgress.Min, prgProgress.Max);
end;

procedure TProgressFrame.SetDescription(const Value: string);
begin
  lblDescription.Caption := Value;
end;

procedure TProgressFrame.SetProgress(const Value: Integer);
begin
  prgProgress.Position := GetRange.Constrain(Value);
end;

procedure TProgressFrame.SetRange(const Value: TRange);
begin
  prgProgress.Min := Value.Min;
  prgProgress.Max := Value.Max;
  prgProgress.Position := Value.Constrain(prgProgress.Position);
end;

procedure TProgressFrame.Show(const AlignToCtrl: TWinControl);
begin
  TCtrlArranger.SetLabelHeight(lblDescription);
  lblDescription.Top := 8;
  TCtrlArranger.MoveBelow(lblDescription, prgProgress, 8);
  Self.ClientHeight := TCtrlArranger.BottomOf(prgProgress, 16);
  Self.Width := AlignToCtrl.ClientWidth - 16;
  if AlignToCtrl <> Self.Parent then
    Self.Left := AlignToCtrl.Left + 8
  else
    Self.Left := 8;
  Self.Top := AlignToCtrl.Top + (AlignToCtrl.Height - Self.Height) div 2;
  lblDescription.Left := 4;
  lblDescription.Width := pnlBody.ClientWidth - 8;
  prgProgress.Left := 4;
  prgProgress.Width := pnlBody.ClientWidth - 8;
  Self.Enabled := True;
  inherited Show;
end;

end.
