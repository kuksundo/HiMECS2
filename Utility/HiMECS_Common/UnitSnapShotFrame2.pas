unit UnitSnapShotFrame2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, decTreeView,
  Vcl.StdCtrls, Vcl.ExtCtrls, TimerPool,
  UnitE2SRecord2, UnitEngineParamRecord2, UnitEngineParameterClass2, UnitEngineParamConst,
  JvExComCtrls, JvComCtrls, JvCheckTreeView;

type
  TSnapShotFrame2 = class(TFrame)
    Panel2: TPanel;
    ManualSearchEdit: TEdit;
    Panel3: TPanel;
    DescRB: TRadioButton;
    Desc_EngRB: TRadioButton;
    ParamNoRB: TRadioButton;
    SnapShotCheckTV: TdecTreeView;
    procedure ManualSearchEditChange(Sender: TObject);
  private
    FSnapShot4E2S: TSnapShot4E2S;
    FEngineParameter: TEngineParameter;
    FParamSrcLlst, FSystemlst: TStringList;

    FPJHTimerPool: TPJHTimerPool;
    FParamSearchMode: Boolean;
    FSearchParamList: TStringList;

    procedure OnSnapShotSearchChange(Sender : TObject; Handle : Integer;
            Interval : Cardinal; ElapsedTime : LongInt);
    procedure LoadSearchTreeFromSSSearch(ASearchText: string);//; ASortMethod: TManualSortMethod=msmMSNo);
    procedure LoadParameter2TVBySortMtehod(ARootNode: TTreeNode; AParam: TEngineParameter);//; ASortMethod: TParamSortMethod);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadSnapShotItemFromTxt(AFileName: string);
    procedure LoadSnapShotParamFromDB(ADBFileName: string);
    //Param Info는 DB에서 읽어오고　Value는 SanpShot File의 Value States에서 가져옴(속도 개선을 위함)
    procedure LoadSnapShotUsingDB(ADBFileName: string=DF_AVAT2_PARAM_DEFAULT_DB_NAME);

    procedure LoadParameter2TVFromParam4AVAT2(AParameter4AVAT2: TParameter4AVAT2; ARoot: TTreeNode=nil);
    procedure LoadParameter2TVFromEngParamItem(AEngineParameterItem: TEngineParameterItem; ARoot: TTreeNode=nil);
    procedure LoadParameter2TVFromEngParameter(AEngineParameter: TEngineParameter; ARoot: TTreeNode=nil);
  end;

implementation

uses UnitTreeViewUtil, HiMECSConst;

{$R *.dfm}

{ TSnapShotFrame }

constructor TSnapShotFrame2.Create(AOwner: TComponent);
begin
  inherited;

  FPJHTimerPool := TPJHTimerPool.Create(nil);
  FSnapShot4E2S := TSnapShot4E2S.Create;
  FEngineParameter := TEngineParameter.Create(nil);
  FParamSrcLlst := TStringList.Create;
  FParamSrcLlst.CaseSensitive := False;
  FSystemlst := TStringList.Create;
  FSystemlst.CaseSensitive := False;
  FSearchParamList := TStringList.Create;

  g_ParameterCategory4AVAT2.InitArrayRecord(R_ParameterCategory4AVAT2);
  g_ParameterSubCategory4AVAT2.InitArrayRecord(R_ParameterSubCategory4AVAT2);
end;

destructor TSnapShotFrame2.Destroy;
var
  i: integer;
begin
  if Assigned(FSearchParamList) then
  begin
    for i := 0 to FSearchParamList.Count - 1 do
    begin
      TEngineParameter(FSearchParamList.Objects[i]).EngineParameterCollect.Clear;
      TEngineParameter(FSearchParamList.Objects[i]).Free;
    end;

    FreeAndNil(FSearchParamList);
  end;

  FSnapShot4E2S.Free;
  FParamSrcLlst.Free;
  FSystemlst.Free;
  FEngineParameter.Free;
  FPJHTimerPool.RemoveAll;
  FreeAndNil(FPJHTimerPool);

  inherited;
end;

procedure TSnapShotFrame2.LoadParameter2TVBySortMtehod(ARootNode: TTreeNode;
  AParam: TEngineParameter);
begin
  LoadParameter2TVFromEngParameter(AParam, ARootNode);
end;

procedure TSnapShotFrame2.LoadParameter2TVFromEngParameter(
  AEngineParameter: TEngineParameter; ARoot: TTreeNode);
var
  i: integer;
  LEngineParameterItem: TEngineParameterItem;
begin
  FSystemlst.Clear;

  for i := 0 to AEngineParameter.EngineParameterCollect.Count - 1 do
  begin
    LEngineParameterItem := AEngineParameter.EngineParameterCollect.Items[i];
    LoadParameter2TVFromEngParamItem(LEngineParameterItem, ARoot);
  end;
end;

procedure TSnapShotFrame2.LoadParameter2TVFromEngParamItem(
  AEngineParameterItem: TEngineParameterItem; ARoot: TTreeNode=nil);
var
  i: integer;
  LStr, LStr2, LStr3: string;
  LTreeNode: TTreeNode;
  LIndex, LIconImgIndex: integer;
begin
//  try
//      LStr := g_ParameterCatetory4AVAT2.ToString(AParam.EngineParameterCollect.Items[i].ParameterCatetory4AVAT2);
    LStr := AEngineParameterItem.Address;//Category

    if LStr = '' then
      LStr := g_ParameterCategory4AVAT2.ToString(AEngineParameterItem.ParameterCatetory4AVAT2);

    LIndex := FSystemlst.IndexOf(LStr);

    if LIndex < 0 then
    begin
      LTreeNode := SnapShotCheckTV.Items.AddChild(ARoot, LStr);
      FSystemlst.AddObject(LStr, LTreeNode);
      SetNodeImages(LTreeNode, False);
    end
    else
    begin
      LTreeNode := TTreeNode(FSystemlst.Objects[LIndex]);
    end;

//      LStr3 := g_ParameterSubCatetory4AVAT2.ToString(AParam.EngineParameterCollect.Items[i].ParameterSubCatetory4AVAT2);
    LStr3 := AEngineParameterItem.FCode;
    LStr := LStr + ';' + LStr3;
    LIndex := FSystemlst.IndexOf(LStr);

    if LIndex < 0 then
    begin
      LTreeNode := SnapShotCheckTV.Items.AddChild(LTreeNode, LStr3);
      FSystemlst.AddObject(LStr, LTreeNode);
      SetNodeImages(LTreeNode, False);
    end
    else
    begin
      LTreeNode := TTreeNode(FSystemlst.Objects[LIndex]);
    end;

    LStr2 := AEngineParameterItem.Description + ' : ' + AEngineParameterItem.Value;

    LTreeNode := SnapShotCheckTV.Items.AddChildObject(LTreeNode,
         LStr2, AEngineParameterItem);

    if LIconImgIndex = -1 then
      SetNodeImages(LTreeNode, False)
    else
      SetNodeImages2Index(LTreeNode, LIconImgIndex);
//  finally
//  end;
end;

procedure TSnapShotFrame2.LoadParameter2TVFromParam4AVAT2(AParameter4AVAT2: TParameter4AVAT2; ARoot: TTreeNode);
var
  LItemIndex: integer;
  LEngineParameterItem: TEngineParameterItem;
begin
//  FEngineParameter.EngineParameterCollect.Clear;
//  try
    LItemIndex := FSnapShot4E2S.AssignEngParamRec2EngParamItem(AParameter4AVAT2, FEngineParameter);
    LEngineParameterItem := FEngineParameter.EngineParameterCollect.Items[LItemIndex];
    LoadParameter2TVFromEngParamItem(LEngineParameterItem, ARoot);
//  finally
//
//  end;
end;

procedure TSnapShotFrame2.LoadSearchTreeFromSSSearch(ASearchText: string);
// code from https://forums.embarcadero.com/thread.jspa?messageID=84669
// modified as a method
// further modified to include case insensitive search and node selection
var
  LEngineParameter: TEngineParameter;
  ANode, NextNode: TTreeNode;
  ALevel, i, j, LParentRem: Integer;
  CurrStr, LStr: string;
  Keep, KeepParent, KeepAncestors: Boolean;
  LevelRem: Integer;

  function GetBufStart(Buffer: string; var Level: Integer): string;
  var
    Pos: Integer;
  begin
    Pos := 1;
    Level := 0;

    while (CharInSet(Buffer[Pos], [' ', #9])) do
    begin
      Inc(Pos);
      Inc(Level);
    end;

    Result := Copy(Buffer, Pos, Length(Buffer) - Pos + 1);
  end;
begin
  SnapShotCheckTV.Items.Clear;
  //JvCheckTreeView1.Items.BeginUpdate;

  ASearchText:= Lowercase(ASearchText); // insures a case insensitive search
  FParamSearchMode:= Length(ASearchText) <> 0; // true searcxh box not empty

  if FParamSearchMode then
  begin
    try
      try
        for i := 0 to FSearchParamList.Count - 1 do
          TEngineParameter(FSearchParamList.Objects[i]).Free;

        FSearchParamList.Clear;

        LEngineParameter := TEngineParameter.Create(Self);
        LEngineParameter.Assign(FEngineParameter);
        FSearchParamList.AddObject(LEngineParameter.EngineParameterCollect.FEngProjNo, LEngineParameter);

        // Search algorithm
        LevelRem:= 0; // 26 May 2011
        KeepParent:= false;

        for i := 0 to FSearchParamList.Count - 1 do
        begin
          LEngineParameter := TEngineParameter(FSearchParamList.Objects[i]);

          for j := LEngineParameter.EngineParameterCollect.Count - 1 downto 0 do // List is scanned from bottom to top
          begin
            if DescRB.Checked then
              LStr := LEngineParameter.EngineParameterCollect.Items[j].Description
            else
            if Desc_EngRB.Checked then
              LStr := LEngineParameter.EngineParameterCollect.Items[j].Description_Eng
            else
            if ParamNoRB.Checked then
              LStr := LEngineParameter.EngineParameterCollect.Items[j].ParamNo;

            if LStr = '' then
              continue;

            CurrStr := GetBufStart(LStr, ALevel);
            CurrStr:= Lowercase(CurrStr); // insures a case insensitive search

            if ALevel >= LevelRem then // node is a leaf
            begin
              Keep:= pos(ASearchText, CurrStr) > 0; // Search string found if true

              if Keep then
              begin
                KeepParent:= true; // parent branch must be kept
                KeepAncestors:= true;
                LParentRem:= ALevel - 1;
              end
              else
                LEngineParameter.EngineParameterCollect.Delete(j);
            end; // if ALevel = LevelRem

            if ALevel = LevelRem - 1 then // node is a branch
            begin
              KeepParent:= false;

              if KeepAncestors and (ALevel = LParentRem) then
              begin
                KeepParent:= true;
                LParentRem:= LParentRem - 1;
              end;

              if not KeepParent then
                LEngineParameter.EngineParameterCollect.Delete(j)
              else if ALevel = 0 then
                KeepAncestors:= False;
            end;

            LevelRem:= ALevel;
          end;//for j

          // Ready to build the treeview. If the "search string" is empty, all the
          // content of List will be used to fill the treeview. Otherwise, a filtered
          // list containing only the matched items and their parent will populate
          // the treeview.
          ANode := SnapShotCheckTV.Items.AddChild(nil, FSearchParamList.Strings[i]);

          LoadParameter2TVBySortMtehod(ANode, TEngineParameter(FSearchParamList.Objects[i]));//, ASortMethod);
        end;//for i

      finally
        //JvCheckTreeView1.Items.EndUpdate;
        if FParamSearchMode then
          SnapShotCheckTV.FullExpand;
      end;
    except
      Invalidate;  // force repaint on exception
      raise;
    end;
  end//if FParamSearchMode
  else
  begin
    SnapShotCheckTV.Items.Clear;
    ANode := SnapShotCheckTV.Items.AddChild(nil, LEngineParameter.EngineParameterCollect.FEngProjNo);

    LoadParameter2TVBySortMtehod(ANode, LEngineParameter);//, FCurrentSortMethod);
  end;
end;

procedure TSnapShotFrame2.LoadSnapShotParamFromDB(ADBFileName: string);
var
  LParameter4AVAT2: TParameter4AVAT2;
  LRootTN: TTreeNode;
begin
  InitParam4AVAT2Client(ADBFileName);
  try
    SnapShotCheckTV.Items.BeginUpdate;
    LParameter4AVAT2 := GetAllParam4AVAT2Rec();
    LRootTN := SnapShotCheckTV.Items.AddChild(nil, 'SetUp');

    while LParameter4AVAT2.FillOne do
    begin
      LoadParameter2TVFromParam4AVAT2(LParameter4AVAT2, LRootTN);
    end;//while
  finally
    SnapShotCheckTV.Items.EndUpdate;
    DestroyParam4AVAT2Client;
  end;
end;

procedure TSnapShotFrame2.LoadSnapShotUsingDB(ADBFileName: string);
var
  LParameter4AVAT2: TParameter4AVAT2;
  LRootTN: TTreeNode;
  LItemIndex: integer;
  LEngineParameterItem: TEngineParameterItem;
begin
  InitParam4AVAT2Client(ADBFileName);
  try
    SnapShotCheckTV.Items.BeginUpdate;
    LParameter4AVAT2 := GetAllParam4AVAT2Rec();
    LRootTN := SnapShotCheckTV.Items.AddChild(nil, 'SetUp');

    while LParameter4AVAT2.FillOne do
    begin
      LItemIndex := FSnapShot4E2S.AssignEngParamRec2EngParamItem(LParameter4AVAT2, FEngineParameter);
      LEngineParameterItem := FEngineParameter.EngineParameterCollect.Items[LItemIndex];
      FSnapShot4E2S.AssignEngParamFromValueStates;
    end;//while
  finally
    SnapShotCheckTV.Items.EndUpdate;
    DestroyParam4AVAT2Client;
  end;
end;

procedure TSnapShotFrame2.LoadSnapShotItemFromTxt(AFileName: string);
begin
  if FileExists(AFileName) then
  begin
    SnapShotCheckTV.LoadFromFile(AFileName);
  end;
end;

procedure TSnapShotFrame2.ManualSearchEditChange(Sender: TObject);
begin
  FPJHTimerPool.AddOneShot(OnSnapShotSearchChange,500);
end;

procedure TSnapShotFrame2.OnSnapShotSearchChange(Sender: TObject;
  Handle: Integer; Interval: Cardinal; ElapsedTime: Integer);
begin
  LoadSearchTreeFromSSSearch(ManualSearchEdit.Text);
end;

end.
