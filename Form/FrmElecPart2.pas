unit FrmElecPart2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFrameElecPartEdit2, DomSensorTypes2,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TElecPartF = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    ElecPartFrame: TFrameElecPartEdit2;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FAppPath,
    FDrawingFileName,
    FManualFileName: string;
  public
    procedure LoadEngElecPartItem2Form(AClass: TEngElecPartItem);
    procedure LoadEngElecPartItemFromForm(AClass: TEngElecPartItem);
    procedure SetAppPath(const APath: string);
    procedure SetFileName(const AAppPath, ADrawingFN, AManualFN: string);
    procedure ShowManual;
    procedure ShowDrawing;
  end;

  function ShowElecPartForm(AClass: TEngElecPartItem; APageIndex: integer = 0;
    AAppPath: string = ''; ADrawingFN: string=''; AManualFN: string=''): integer;

var
  ElecPartF: TElecPartF;

implementation

uses FrmPdfView2;

{$R *.dfm}

function ShowElecPartForm(AClass: TEngElecPartItem; APageIndex: integer;
  AAppPath, ADrawingFN, AManualFN: string): integer;
var
  LForm: TElecPartF;
begin
  LForm := TElecPartF.Create(nil);
  try
    LForm.SetFileName(AAppPath, ADrawingFN, AManualFN);
    LForm.LoadEngElecPartItem2Form(AClass);
    LForm.ElecPartFrame.PageControl1.ActivePageIndex := APageIndex;
    Result := LForm.ShowModal;

    if Result = mrOK then
    begin
      LForm.LoadEngElecPartItemFromForm(AClass);
    end;
  finally
    LForm.Free;
  end;
end;

{ TElecPartF }

procedure TElecPartF.Button1Click(Sender: TObject);
begin
  ShowDrawing;
end;

procedure TElecPartF.Button2Click(Sender: TObject);
begin
  ShowManual;
end;

procedure TElecPartF.LoadEngElecPartItem2Form(AClass: TEngElecPartItem);
begin
  ElecPartFrame.LoadFromSensorRouteClass(AClass);
end;

procedure TElecPartF.LoadEngElecPartItemFromForm(AClass: TEngElecPartItem);
begin
  ElecPartFrame.Load2SensorRouteClass(AClass);
end;

procedure TElecPartF.SetAppPath(const APath: string);
begin
  FAppPath := APath;
end;

procedure TElecPartF.SetFileName(const AAppPath, ADrawingFN, AManualFN: string);
begin
  FAppPath := AAppPath;
  FDrawingFileName := ADrawingFN;
  FManualFileName := AManualFN;
end;

procedure TElecPartF.ShowDrawing;
begin
  if FDrawingFileName <> '' then
  begin
    ShowPdfView(FDrawingFileName, ElecPartFrame.FEngElecPartItem.EngSensor.TagDesc,0,True);//FAppPath + 'Doc\Manual\' +
  end
  else
  begin
    ShowMessage('File Name is empty!');
//    exit;
  end;
end;

procedure TElecPartF.ShowManual;
begin
  if FManualFileName <> '' then
  begin
    ShowPdfView(FManualFileName, ElecPartFrame.FEngElecPartItem.EngSensor.TagDesc,0,True);
  end
  else
  begin
    ShowMessage('File Name is empty!');
//    exit;
  end;
end;

end.
