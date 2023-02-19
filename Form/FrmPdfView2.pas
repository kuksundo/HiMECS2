unit FrmPdfView2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, NxEdit6,
  mormot.core.variants, mormot.core.text,
  UnitFramePdfView2;//, FrmModalAndMDIForm;

type
  TPDFViewF = class(TForm)
    PdfViewFrame1: TPdfViewFrame;
  private
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;
  public
//    constructor Create(AOwner: TComponent); overload; override;
//    constructor CreateModal(AOwner: TComponent);
  end;

  procedure ShowPdfView(AFileName, ASystemDesc: string; APageB: integer; AIsMaximize: Boolean=False);

var
  PDFViewF: TPDFViewF;

implementation

uses UnitCopyData;

{$R *.dfm}

procedure ShowPdfView(AFileName, ASystemDesc: string; APageB: integer; AIsMaximize: Boolean);
var
  LPDFViewF: TPDFViewF;
  LObj: variant;
  LArgs: string;
begin
  LPDFViewF := TPDFViewF.Create(nil);
  try
    TDocVariant.New(LObj);
    LObj.FileName := ChangeFileExt(AFileName, '.pdf');
    LObj.PageNo := APageB;
    LObj.SystemDesc_Eng := ASystemDesc;
    LArgs := VariantSaveJson(LObj);
    LPDFViewF.PdfViewFrame1.LoadPDFInfoFromObj(LObj);
//    SendCopyData2(LPDFViewF.Handle, LArgs, LPDFViewF.Handle);

    if AIsMaximize then
      LPDFViewF.WindowState := wsMaximized;

    LPDFViewF.ShowModal;
  finally
    LPDFViewF.Free;
  end;
end;

//constructor TPDFViewF.Create(AOwner: TComponent);
//begin
//  inherited;
//
//end;
//
//constructor TPDFViewF.CreateModal(AOwner: TComponent);
//begin
//  GlobalNameSpace.BeginWrite;
//  try
//    inherited CreateNew(AOwner);
//
//    if (not(csDesigning in ComponentState)) then
//    begin
//      Include(FFormState, fsCreating);
//      try
//        FormStyle := fsNormal;
//
//        if (not(InitInheritedComponent(self, TForm))) then
//          raise Exception.CreateFmt('Cannot create form %s as Normal Form', [ClassName]);
//      finally
//        Exclude(FFormState, fsCreating);
//      end;
//    end;
//  finally
//    GlobalNameSpace.EndWrite;
//  end;
//end;

{ TPDFViewF }

procedure TPDFViewF.WMCopyData(var Msg: TMessage);
var
  LStr: string;
  LHandle: integer;
begin
  LStr := PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^.StrMsg;
  LHandle := PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^.iHandle;

  SendCopyData2(PdfViewFrame1.Handle, LStr, LHandle);
end;

end.
