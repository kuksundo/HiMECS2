unit FrmSCRSimulate2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ShadowButton, Vcl.ExtCtrls, AdvPanel,
  Vcl.StdCtrls, Vcl.AppEvnts;

type
  TSCROpSimF = class(TForm)
    ShadowButton1: TShadowButton;
    ShadowButton2: TShadowButton;
    ShadowButton3: TShadowButton;
    ShadowButton4: TShadowButton;
    ShadowButton5: TShadowButton;
    ShadowButton6: TShadowButton;
    AdvPanel1: TAdvPanel;
    ShadowButton7: TShadowButton;
    SystemModeCheck: TCheckBox;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure ShadowButton1Click(Sender: TObject);
    procedure ShadowButton2Click(Sender: TObject);
    procedure ShadowButton3Click(Sender: TObject);
    procedure ShadowButton4Click(Sender: TObject);
    procedure ShadowButton5Click(Sender: TObject);
    procedure ShadowButton6Click(Sender: TObject);
    procedure ShadowButton7Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FCurrentBtnTag: integer;
    FSystemMode: Boolean;

    procedure ChangeBtnColor(ATag: integer);
  public
//    procedure SetSimData4Venting;
//    procedure SetSimData4Sealing;
//    procedure SetSimData4Heating;
//    procedure SetSimData4StandbyHeating;
//    procedure SetSimData4Regeneration;
//    procedure SetSimData4DosingUnitReady;
//    procedure SetSimData4DosingUnitInjection;
  end;

var
  SCROpSimF: TSCROpSimF;

implementation

uses FrmParamManage2, UnitVesselData2, UnitSCRData;

{$R *.dfm}

procedure TSCROpSimF.ChangeBtnColor(ATag: integer);
var
  i: integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TShadowButton then
    begin
      if Components[i].Tag = ATag then
        TShadowButton(Components[i]).Color := clGreen
      else
        TShadowButton(Components[i]).Color := clAqua;
    end;
  end;
end;

procedure TSCROpSimF.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: integer;
begin
  if (Key = VK_DOWN) or (Key = VK_NEXT) then
  begin
    if FSystemMode then
    begin
      if FCurrentBtnTag = 7 then
        FCurrentBtnTag := 1
      else
        Inc(FCurrentBtnTag);

      ChangeBtnColor(FCurrentBtnTag);
      SendMessage(ParamManageF.Handle, MSG_KEY_SHIFT, FCurrentBtnTag, Ord(shptSCR));
    end
    else
      SendMessage(ParamManageF.Handle, MSG_KEY_DOWN, 0, 0);
  end
  else
  if (Key = VK_UP) or (Key = VK_PRIOR) then
  begin
    if FSystemMode then
    begin
      if FCurrentBtnTag = 1 then
        FCurrentBtnTag := 7
      else
        Dec(FCurrentBtnTag);

      ChangeBtnColor(FCurrentBtnTag);
      SendMessage(ParamManageF.Handle, MSG_KEY_SHIFT, FCurrentBtnTag, Ord(shptSCR))
    end
    else
      SendMessage(ParamManageF.Handle, MSG_KEY_UP, 0, 0);
  end
  else
  if Key = VK_OEM_PERIOD then
  begin                                          //Close Conditiion Form
    SendMessage(ParamManageF.Handle, MSG_COMMAND, 1, 0);
  end
  else
  begin
    FSystemMode := not FSystemMode;
    SystemModeCheck.Checked := FSystemMode;

    if FSystemMode then
      i := 1
    else
     i := 0;

    SendMessage(ParamManageF.Handle, MSG_SYSTEM_MODE, i, 0)
  end;
end;

procedure TSCROpSimF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Action := caFree;
end;

procedure TSCROpSimF.FormCreate(Sender: TObject);
begin
  FSystemMode := SystemModeCheck.Checked;
end;

procedure TSCROpSimF.ShadowButton1Click(Sender: TObject);
begin
  ParamManageF.SetSimData4SCR(1);
end;

procedure TSCROpSimF.ShadowButton2Click(Sender: TObject);
begin
  ParamManageF.SetSimData4SCR(2);
end;

procedure TSCROpSimF.ShadowButton3Click(Sender: TObject);
begin
  ParamManageF.SetSimData4SCR(3);
end;

procedure TSCROpSimF.ShadowButton4Click(Sender: TObject);
begin
  ParamManageF.SetSimData4SCR(4);
end;

procedure TSCROpSimF.ShadowButton5Click(Sender: TObject);
begin
  ParamManageF.SetSimData4SCR(5);
end;

procedure TSCROpSimF.ShadowButton6Click(Sender: TObject);
begin
  ParamManageF.SetSimData4SCR(6);
end;

procedure TSCROpSimF.ShadowButton7Click(Sender: TObject);
begin
  ParamManageF.SetSimData4SCR(7);
end;

end.
