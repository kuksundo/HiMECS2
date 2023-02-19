unit FrmEGCSSimulate2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, AdvPanel,
  ShadowButton, UnitHookConst;

type
  TEGCSOpSimF = class(TForm)
    ShadowButton1: TShadowButton;
    ShadowButton2: TShadowButton;
    ShadowButton3: TShadowButton;
    ShadowButton4: TShadowButton;
    ShadowButton5: TShadowButton;
    ShadowButton6: TShadowButton;
    ShadowButton7: TShadowButton;
    AdvPanel1: TAdvPanel;
    SystemModeCheck: TCheckBox;
    Edit1: TEdit;
    ShadowButton8: TShadowButton;
    ShadowButton9: TShadowButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ShadowButton1Click(Sender: TObject);
    procedure ShadowButton2Click(Sender: TObject);
    procedure ShadowButton3Click(Sender: TObject);
    procedure ShadowButton4Click(Sender: TObject);
    procedure ShadowButton5Click(Sender: TObject);
    procedure ShadowButton6Click(Sender: TObject);
    procedure ShadowButton7Click(Sender: TObject);
  private
    procedure WndProc(var Messages: TMessage); override;
    procedure LogKeyStroke(wParam: WPARAM);
    procedure ProcessKeyDown(Key: Word);
  public
    FCurrentBtnTag: integer;
    FSystemMode, FHookMode: Boolean;

    procedure ChangeBtnColor(ATag: integer);
  end;

var
  EGCSOpSimF: TEGCSOpSimF;
  hMappingFile_K : THandle;
  pShMem_K : PShareMem_KeyBd;

implementation

uses FrmParamManage2, UnitVesselData2;

{$R *.dfm}

{ TEGCSOpSimF }

procedure TEGCSOpSimF.ChangeBtnColor(ATag: integer);
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

procedure TEGCSOpSimF.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not FHookMode then
    ProcessKeyDown(Key);
end;

procedure TEGCSOpSimF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FHookMode then
    if StopHook then
      ;

//  Action := caFree;
end;

procedure TEGCSOpSimF.FormCreate(Sender: TObject);
begin
  FHookMode := StartHook(Handle, MY_WM_HOOKKEY);
  FSystemMode := SystemModeCheck.Checked;
end;

procedure TEGCSOpSimF.LogKeyStroke(wParam: WPARAM);
var
  LKeyStroke: word;
begin
  LKeyStroke := pShMem_K^.KeyBdStruct.vkCode;
//  ShowMessage(IntToStr(LKeyStroke));
//  case LKeyStroke of
//    VK_DOWN, VK_NEXT,
//    VK_UP, VK_PRIOR,
//    VK_OEM_PERIOD : ProcessKeyDown(LKeyStroke);
//  end;
  ProcessKeyDown(LKeyStroke);
end;

procedure TEGCSOpSimF.ProcessKeyDown(Key: Word);
var
  i: integer;
begin
//  ShowMessage(IntToStr(Key));
  if (Key = VK_DOWN) or (Key = VK_NEXT) then
  begin
    if FSystemMode then
    begin
      if FCurrentBtnTag = 7 then
        FCurrentBtnTag := 1
      else
        Inc(FCurrentBtnTag);

      ChangeBtnColor(FCurrentBtnTag);
      SendMessage(ParamManageF.Handle, MSG_KEY_SHIFT, FCurrentBtnTag, Ord(shptEGCS));
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
      SendMessage(ParamManageF.Handle, MSG_KEY_SHIFT, FCurrentBtnTag, Ord(shptEGCS))
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

procedure TEGCSOpSimF.ShadowButton1Click(Sender: TObject);
begin
  ParamManageF.SetSimData4EGCS(1);
end;

procedure TEGCSOpSimF.ShadowButton2Click(Sender: TObject);
begin
  ParamManageF.SetSimData4EGCS(2);
end;

procedure TEGCSOpSimF.ShadowButton3Click(Sender: TObject);
begin
  ParamManageF.SetSimData4EGCS(3);
end;

procedure TEGCSOpSimF.ShadowButton4Click(Sender: TObject);
begin
  ParamManageF.SetSimData4EGCS(4);
end;

procedure TEGCSOpSimF.ShadowButton5Click(Sender: TObject);
begin
  ParamManageF.SetSimData4EGCS(5);
end;

procedure TEGCSOpSimF.ShadowButton6Click(Sender: TObject);
begin
  ParamManageF.SetSimData4EGCS(6);
end;

procedure TEGCSOpSimF.ShadowButton7Click(Sender: TObject);
begin
  ParamManageF.SetSimData4EGCS(7);
end;

procedure TEGCSOpSimF.WndProc(var Messages: TMessage);
var
  x,y:integer;
  s:array[0..255]of char;
  LIgnoreKey: Boolean;
begin
  try
    if pShMem_K = nil then
    begin
      hMappingFile_K := OpenFileMapping(FILE_MAP_READ, False, MappingFileName_KeyBd);
      if hMappingFile_K=0 then Exception.Create('KeyBoard ShareMM(WndProc) Fail!');
      pShMem_K :=  MapViewOfFile(hMappingFile_K, FILE_MAP_READ,0,0,0);
      if pShMem_K = nil then
      begin
        CloseHandle(hMappingFile_K);
        Exception.Create('KeyBoard ShareMM(WndProc) Fail!');
      end;
    end;

    if pShMem_K = nil then exit;

    if Messages.Msg = MY_WM_HOOKKEY then
    begin
//      if pShMem_K^.KeyDown then
      if pShMem_K^.KeyUp then
        LogKeyStroke(Messages.WParam);

//      ControlCheck.Checked := pShMem_K.IsCtrlPressed;
//      ShiftCheck.Checked := pShMem_K.IsShiftPressed;
//      AltCheck.Checked := pShMem_K.IsAltPressed;
    end
    else Inherited;
  finally
  end;
end;

end.
