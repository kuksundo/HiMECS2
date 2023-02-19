unit FrmPdfViewMDIChild2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, NxEdit6, UnitFramePdfView2;//, FrmModalAndMDIForm;

type
  TPDFViewMDIChildF = class(TForm)
    PdfViewFrame1: TPdfViewFrame;
  private
    procedure WMCopyData(var Msg: TMessage); message WM_COPYDATA;
  public
//    constructor Create(AOwner: TComponent); overload; override;
//    constructor CreateModal(AOwner: TComponent);
  end;

var
  PDFViewMDIChildF: TPDFViewMDIChildF;

implementation

uses CopyData;

{$R *.dfm}

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

{ TPDFViewMDIChildF }

procedure TPDFViewMDIChildF.WMCopyData(var Msg: TMessage);
var
  LStr: string;
  LHandle: integer;
begin
  LStr := PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^.StrMsg;
  LHandle := PRecToPass(PCopyDataStruct(Msg.LParam)^.lpData)^.iHandle;

  SendCopyData2(PdfViewFrame1.Handle, LStr, LHandle);
end;

end.
