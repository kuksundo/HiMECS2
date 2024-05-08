unit FrmReverseProxySvr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  IdMappedPortTCP, IdContext, IdBaseComponent, IdComponent, IdCustomTCPServer,
  OtlComm, OtlCommon,
  UProxyWorkerThrd, UnitWorker4OmniMsgQ
  ;

type
  TReverseProxyF = class(TForm)
    IdMappedPortTCP1: TIdMappedPortTCP;
    Memo1: TMemo;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Memo2: TMemo;
    procedure IdMappedPortTCP1Execute(AContext: TIdContext);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCommandQueue   : TOmniMessageQueue;
    FResponseQueue  : TOmniMessageQueue;
    FSendMsgQueue   : TOmniMessageQueue;

    FReverseProxyWorker: TReverseProxyWorker;

    procedure StartWorker;
    procedure StopWorker;
  protected
    procedure OnWorkerResult(var Msg: TMessage); message MSG_RESULT;
  public
    procedure Log(const AMsg: string);
  end;

var
  ReverseProxyF: TReverseProxyF;

implementation

{$R *.dfm}

procedure TReverseProxyF.FormCreate(Sender: TObject);
begin
  StartWorker();
end;

procedure TReverseProxyF.FormDestroy(Sender: TObject);
begin
  StopWorker();
end;

procedure TReverseProxyF.IdMappedPortTCP1Execute(AContext: TIdContext);
begin
;
end;procedure TReverseProxyF.Log(const AMsg: string);
begin
  if Memo1.Lines.Count > 1000 then
    Memo1.Lines.Clear;

  Memo1.Lines.Add(AMsg);
end;

procedure TReverseProxyF.OnWorkerResult(var Msg: TMessage);
var
  LMsg: TOmniMessage;
begin
  if FResponseQueue.TryDequeue(LMsg) then
  begin

  end;
end;

procedure TReverseProxyF.StartWorker;
begin
  FCommandQueue := TOmniMessageQueue.Create(1000);
  FResponseQueue := TOmniMessageQueue.Create(1000, false);
  FSendMsgQueue := TOmniMessageQueue.Create(1000);

  FReverseProxyWorker := TReverseProxyWorker.Create(FCommandQueue, FResponseQueue, FSendMsgQueue);
end;

procedure TReverseProxyF.StopWorker;
begin
  if Assigned(FReverseProxyWorker) then
  begin
    FReverseProxyWorker.Terminate;
    FReverseProxyWorker.Stop;
    FReverseProxyWorker.WaitFor;
    FreeAndNil(FReverseProxyWorker);
  end;

  FCommandQueue.Free;
  FResponseQueue.Free;
  FSendMsgQueue.Free;
end;



end.
