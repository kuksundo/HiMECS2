unit FrmStatusDisplay2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GDIPPictureContainer,
  AdvSmoothStepControl, Vcl.ExtCtrls,
  IPC.Events, IPC.SharedMem, GpSharedMemory, UnitCommandLineUtil,
  UnitSimulateCommonData, UnitStatusDisplayCommandLineOption2, Vcl.StdCtrls,
  mormot.core.variants, mormot.core.base, mormot.core.unicode,
  Vcl.Menus;

type
  TThreadRecvEvent = class(TThread)
  private
  protected
    procedure Execute; override;
  public
    FRecvEvent: Event;
    FStop, FPause: Boolean;

    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure ReStart;
  end;

  TThreadNextStepEvent = class(TThread)
  private
  protected
    procedure Execute; override;
  public
    FNextStepEvent: Event;
    FStop: Boolean;
    FNextStepSM: SharedMemory<TSimCommonData>;

    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure ReStart;
  end;

  TStatusDisplayF = class(TForm)
    GDIPPictureContainer1: TGDIPPictureContainer;
    Panel1: TPanel;
    StatusStepControl: TAdvSmoothStepControl;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    AdjustDescriptHeight1: TMenuItem;
    N1: TMenuItem;
    ShowShortCut1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure StatusStepControlKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure AdjustDescriptHeight1Click(Sender: TObject);
    procedure ShowShortCut1Click(Sender: TObject);
  private
    FCLO: TpjhCommandLine<TStatusDisplayCLO2>;
    FgpSharedMM: TGpSharedMemory;
    FDocData: TDocVariantData;
    FParamListJson: string;
    FThreadRecvEvent: TThreadRecvEvent;
    FThreadNextStepEvent: TThreadNextStepEvent;
    FCurrentSystemName,
    FCurrentSubSystemName,
    FSystemName4CondForm,
    FSubSystemName4CondForm: string;
    FIsShowCondForm: boolean;
//    FItemID,
    FProductKind: integer;
  protected
//    procedure CreatePaams(var Params: TCreateParams); override;
  public
    procedure InitVar;
    procedure InitializeStepControl;
    procedure FinalizeVar;
    procedure UpdateStepControl;
    procedure RecvParamFromSharedMM;
    procedure GetDocFromSharedMM;
    procedure AddStep(ACaption, ADescription, AImageName: string);
    procedure GetParamListFromVariant2StatusDisplay(ADoc: Variant);
    procedure SetNextStep(AStep: integer=1);
    procedure MoveNextStep(AStepIndex: integer);
    procedure StepControlClear;
    procedure DisplaySystemMode2Caption(AIsSystemMode: Boolean);
    procedure ProcessCommand(ACommand: integer);
    procedure ShowConditionForm;
    procedure HideConditionForm(ASystemName, ASubSystemName: string);
    procedure AdjustStepControlDescHeight;
  end;

var
  StatusDisplayF: TStatusDisplayF;

implementation

uses UnitFormUtil, Venting_Entry_Condition, Sealing_Entry_Condition,
  Heating_Entry_Condition, StandbyHeating_Entry_Condition, Regeneration_Entry_Condition,
  DosingUnitReady_Entry_Condition, DosingUnitInjection_Entry_Condition, UnitBase64Util,
  FrmInputEdit;

{$R *.dfm}

{ TForm1 }

procedure TStatusDisplayF.AddStep(ACaption, ADescription, AImageName: string);
begin
  with StatusStepControl.StepActions.Add do
  begin
    InActiveContent.CaptionLocation := tlCenterLeft;
    InActiveContent.ImageName := AImageName;
    InActiveContent.Caption := ACaption;
    InActiveContent.Description.Text := ADescription;
    ActiveContent.Assign(InActiveContent);
    ProcessedContent.Assign(InActiveContent);
  end;
end;

//procedure TStatusDisplayF.CreatePaams(var Params: TCreateParams);
//begin
//  inherited;
//
////  Params.ExStyle := WS_EX_APPWINDOW;
//  Params.WndParent := GetDesktopWindow();
//end;

procedure TStatusDisplayF.AdjustDescriptHeight1Click(Sender: TObject);
begin
  AdjustStepControlDescHeight;
end;

procedure TStatusDisplayF.AdjustStepControlDescHeight;
var
  LHeight: integer;
begin
  SetWindowPos(Handle, HWND_NOTOPMOST, 0,0,0,0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
  try
    LHeight := StrToIntDef(CreateInputEdit('Adjust Step Control Description Height',
      'Height', IntToStr(StatusStepControl.Appearance.DescriptionSize)), StatusStepControl.Appearance.DescriptionSize);

    if StatusStepControl.Appearance.DescriptionSize <> LHeight then
    begin
      StatusStepControl.Appearance.DescriptionSize := LHeight;
    end;
  finally
    SetWindowPos(Handle, HWND_TOPMOST, 0,0,0,0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
  end;
end;

procedure TStatusDisplayF.DisplaySystemMode2Caption(AIsSystemMode: Boolean);
begin
  if AIsSystemMode then
    Caption := 'System Mode'
  else
    Caption := 'Item Step Mode';
end;

procedure TStatusDisplayF.FinalizeVar;
begin
  FreeAndNil(FgpSharedMM);
  FThreadRecvEvent.FStop := True;
  FThreadRecvEvent.ReStart;
  FThreadNextStepEvent.FStop := True;
  FThreadNextStepEvent.ReStart;
end;

procedure TStatusDisplayF.FormCreate(Sender: TObject);
begin
//  FSharedData := SharedMemory<TSimCommonData>.Create(SHARED_DATA_NAME, SharedMemoryAccessReadWrite);
  InitVar;
  InitializeStepControl;
end;

procedure TStatusDisplayF.FormDeactivate(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST, 0,0,0,0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure TStatusDisplayF.FormShow(Sender: TObject);
begin
  SetWindowPos(Handle, HWND_TOPMOST, 0,0,0,0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE);
end;

procedure TStatusDisplayF.GetDocFromSharedMM;
begin
  //FParamListJson에 SharedMM Data 저장함.
  RecvParamFromSharedMM();
  FDocData.InitJSON(FParamListJson);
end;

procedure TStatusDisplayF.GetParamListFromVariant2StatusDisplay(ADoc: Variant);
begin
//  ADoc.Subject;
//  ADoc.Desc;
  AddStep(ADoc.Subject,ADoc.Desc,'');
end;

procedure TStatusDisplayF.HideConditionForm(ASystemName, ASubSystemName: string);
begin
  if ASystemName = 'Venting' then
    VentingEntryCondF.Close
  else
  if ASystemName = 'Sealing' then
    SealingEntryCondF.Close
  else
  if ASystemName = 'Heating' then
    HeatingEntryCondF.Close
  else
  if ASystemName = 'Standby Heating' then
    StandbyHeatingEntryCondF.Close
  else
  if ASystemName = 'Regeneration' then
    RegenerationEntryCondF.Close
  else
  if ASystemName = 'Dosing Unit' then
  begin
    if ASubSystemName = 'Ready' then
      DosingUnitReadyEntryCondF.Close
    else
    if ASubSystemName = 'Injection' then
      DosingUnitInjectionEntryCondF.Close
  end;

  FIsShowCondForm := False;
end;

procedure TStatusDisplayF.InitializeStepControl;
begin
  StatusStepControl.Appearance.DescriptionLayout := dlBottom;
//  StatusStepControl.Appearance.DescriptionSize := 75;
//  StatusStepControl.Appearance.ShapeStyle := sasNone;
//  StatusStepControl.Appearance.Layout := salPointer;
//  StatusStepControl.Appearance.LayoutSpacingHorizontal := 7;
//  StatusStepControl.Appearance.InActiveCaptionFont.Style := [fsBold];
//  StatusStepControl.Appearance.ActiveCaptionFont.Assign(StatusStepControl.Appearance.InActiveCaptionFont);
//  StatusStepControl.Appearance.ProcessedCaptionFont.Assign(StatusStepControl.Appearance.InActiveCaptionFont);

//  AddStep('Subject','Desc','1');
//  StatusStepControl.ActiveStep := 1;
//  StatusStepControl.StepActions.Clear;
end;

procedure TStatusDisplayF.InitVar;
var
  LErrMsg: string;
begin
  FgpSharedMM := TGpSharedMemory.Create(SHARED_DATA_NAME, 0, SHARED_MAX_SIZE);
  FThreadRecvEvent := TThreadRecvEvent.Create(True);
  FThreadRecvEvent.FreeOnTerminate := True;
  FThreadRecvEvent.Resume;

  FThreadNextStepEvent := TThreadNextStepEvent.Create(True);
  FThreadNextStepEvent.FreeOnTerminate := True;
  FThreadNextStepEvent.Resume;

  FCLO := TpjhCommandLine<TStatusDisplayCLO2>.Create;
  FCLO.CommandLineParse(LErrMsg);
  Timer1.Enabled := True;
end;

procedure TStatusDisplayF.MoveNextStep(AStepIndex: integer);
begin
  if FIsShowCondForm then
    HideConditionForm(FSystemName4CondForm, FSubSystemName4CondForm);

  if AStepIndex < 0 then
    StatusStepControl.ActiveStep := StatusStepControl.ActiveStep + 1
  else
  begin
    if StatusStepControl.ActiveStep <> AStepIndex then
      StatusStepControl.ActiveStep := AStepIndex;
  end;
end;

procedure TStatusDisplayF.ProcessCommand(ACommand: integer);
begin
  case ACommand of
    1: HideConditionForm(FCurrentSystemName, FCurrentSubSystemName);
  end;
end;

procedure TStatusDisplayF.RecvParamFromSharedMM;
var
  LStrList: TStringList;
begin
  LStrList := TStringList.Create;
  try
    if FgpSharedMM.AcquireMemory(False, INFINITE) <> nil then
    begin
//      if not FgpSharedMM.Modified then
      LStrList.LoadFromStream(FgpSharedMM.AsStream);
      FParamListJson := LStrList.Strings[1];
//      FParamListJson := LStrList.Text;
    end;

    if FgpSharedMM.Acquired then
      FgpSharedMM.ReleaseMemory;
  finally
    LStrList.Free;
  end;
end;

procedure TStatusDisplayF.SetNextStep(AStep: integer);
begin
  StatusStepControl.ActiveStep := StatusStepControl.ActiveStep + AStep;
end;

procedure TStatusDisplayF.ShowConditionForm;
begin
  if FCurrentSystemName = 'Venting' then
    Create_VentingEntryCondition
  else
  if FCurrentSystemName = 'Sealing' then
    Create_SealingEntryCondition
  else
  if FCurrentSystemName = 'Heating' then
    Create_HeatingEntryCondition
  else
  if FCurrentSystemName = 'Standby Heating' then
    Create_StandbyHeatingEntryCondition
  else
  if FCurrentSystemName = 'Regeneration' then
    Create_RegenerationEntryCondition
  else
  if FCurrentSystemName = 'Dosing Unit' then
  begin
    if FCurrentSubSystemName = 'Ready' then
      Create_DosingUnitReadyEntryCondition
    else
    if FCurrentSubSystemName = 'Injection' then
      Create_DosingUnitInjectionEntryCondition
  end;

  FSystemName4CondForm := FCurrentSystemName;
  FSubSystemName4CondForm := FCurrentSubSystemName;
  FIsShowCondForm := True;
end;

procedure TStatusDisplayF.ShowShortCut1Click(Sender: TObject);
var
  LStr: string;
begin
  LStr := 'F2: Full Screen' + #13#10;
  LStr := LStr + 'F3: Align Top' + #13#10;
  LStr := LStr + 'F4: Border Style' + #13#10;
  LStr := LStr + 'F5: Stay On Top';

  ShowMessage(LStr);
end;

procedure TStatusDisplayF.StatusStepControlKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
  begin
    DisplayFormOnMultiMonitor(Self,1);
    ToggleFullScreenWidth(Self,1)
  end
  else
  if Key = VK_F3 then
  begin
//    ToggleAlignTop(TForm(Self));
    ToggleAlignTop4MultiMonitor(TForm(Self));
  end
  else
  if Key = VK_F4 then
    ToggleBorderStyle(TForm(Self))
  else
  if Key = VK_F5 then
    ToggleStayOnTop4MultiMonitor(TForm(Self));
//    ToggleStayOnTop(TForm(Self));
end;

procedure TStatusDisplayF.StepControlClear;
begin
  StatusStepControl.StepActions.Clear;
end;

procedure TStatusDisplayF.Timer1Timer(Sender: TObject);
var
  LUtf8: RawUtf8;
  LParam: string;
begin
  Timer1.Enabled := False;

  if FCLO.FCommandLine.JsonParamList <> '' then
  begin
    LParam := FCLO.FCommandLine.JsonParamList;
    LUtf8 := StringToUtf8(LParam);
    LUtf8 := MakeBase64ToUTF8(LUtf8);
    FParamListJson := Utf8ToString(LUtf8);
    FDocData.InitJSON(FParamListJson);
    UpdateStepControl;
  end;
end;

procedure TStatusDisplayF.UpdateStepControl;
var
  i: integer;
  LDoc: Variant;
begin
  StatusStepControl.BeginUpdate;
  try
    StepControlClear;

    for i := 0 to FDocData.Count - 1 do
    begin
      LDoc := _JSON(FDocData.Value[i]);
//      FItemID := LDoc.ItemID;
      FProductKind := LDoc.ProductType;
      GetParamListFromVariant2StatusDisplay(LDoc);

      if i = 0 then
      begin
        FCurrentSystemName := LDoc.SystemName;
        FCurrentSubSystemName := LDoc.SubSystemName;

        if FProductKind = 1 then //SCR인 경우
        begin
          if FIsShowCondForm then
            HideConditionForm(FSystemName4CondForm, FSubSystemName4CondForm);

          ShowConditionForm;
        end;
      end;
    end;
  finally
    StatusStepControl.EndUpdate;
  end;
end;

{ TThreadRecvEvent }

constructor TThreadRecvEvent.Create(CreateSuspended: Boolean);
begin
  FRecvEvent := Event.Create(NOTIFY_SHMM_EVENT_NAME);

  inherited Create(CreateSuspended);
end;

destructor TThreadRecvEvent.Destroy;
begin
  inherited;
end;

procedure TThreadRecvEvent.Execute;
begin
  while not terminated do
  begin
    FRecvEvent.WaitForSignal();

    if FStop then
      break;

    StatusDisplayF.GetDocFromSharedMM;
    Synchronize(StatusDisplayF.UpdateStepControl);
  end;

  Terminate;
end;

procedure TThreadRecvEvent.ReStart;
begin
  FRecvEvent.Signal;
end;

{ TThreadNextStepEvent }

constructor TThreadNextStepEvent.Create(CreateSuspended: Boolean);
begin
  FNextStepEvent := Event.Create(NEXT_STEP_EVENT_NAME);
  FNextStepSM := SharedMemory<TSimCommonData>.Create(NEXTSTEP_SHARED_DATA_NAME, SharedMemoryAccessReadOnly);;

  inherited Create(CreateSuspended);
end;

destructor TThreadNextStepEvent.Destroy;
begin

  inherited;
end;

procedure TThreadNextStepEvent.Execute;
var
  data: SharedMemory<TSimCommonData>.Ptr;
begin
  while not terminated do
  begin
    FNextStepEvent.WaitForSignal();

    if FStop then
      break;

    try
      data := FNextStepSM.BeginAccess;

      if (FNextStepSM.Abandoned) then
        exit;

      if data^.Value = -1 then
      begin
        if data^.Command = -1 then
          StatusDisplayF.DisplaySystemMode2Caption(data^.IsSystemMode)
        else
        begin
          StatusDisplayF.ProcessCommand(data^.Command);
        end;
      end
      else
        StatusDisplayF.MoveNextStep(data^.Value);
    finally
      FNextStepSM.EndAccess;
    end;
  end;

  Terminate;
end;

procedure TThreadNextStepEvent.ReStart;
begin
  FNextStepEvent.Signal;
end;

end.
