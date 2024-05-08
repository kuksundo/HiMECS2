unit UProxyWorkerThrd;

interface

uses Windows, Winapi.Messages, System.SysUtils, System.SyncObjs, System.Classes,
  OtlComm, OtlCommon,
  mormot.core.collections, mormot.core.json,
  UnitWorker4OmniMsgQ,
  UProxyClass, UProxyType
  ;

type
  TReverseProxyWorker = class(TWorker2)
  strict private
    FReverseProxy: TReverseProxy;
    FProxyIPRec: TProxyIPRec;
  private
    procedure CustomCreate; override;
    procedure ProcessCommandProc(AMsg: TOmniMessage); override;
  protected
    procedure RespondEnqueueAndNotifyMainForm(AMsgId: word; const AValue: TOmniValue;
      const AWinMsg: integer);
  public
    constructor Create(commandQueue, responseQueue, sendQueue: TOmniMessageQueue; const ARec: TProxyIPRec);
    destructor Destroy(); override;

    procedure InitVar();
    procedure DestroyVar();

    procedure Log2MainComm(const AMsg: string);

    procedure SetMainFormHandle(AHandle: THandle);
    procedure SetProxyIpRec(const ARec: TProxyIPRec);
  end;

implementation

{ TKiwoomTraderWorker }

constructor TReverseProxyWorker.Create(commandQueue, responseQueue,
  sendQueue: TOmniMessageQueue; const ARec: TProxyIPRec);
begin
  inherited Create(commandQueue, responseQueue, sendQueue);

  SetProxyIpRec(ARec);
  InitVar();
end;

procedure TReverseProxyWorker.CustomCreate;
begin
  inherited;

end;

destructor TReverseProxyWorker.Destroy;
begin
  DestroyVar();

  inherited;
end;

procedure TReverseProxyWorker.DestroyVar;
begin
  FReverseProxy.DisConnect();

  if Assigned(FReverseProxy) then
    FReverseProxy.Free;
end;

procedure TReverseProxyWorker.InitVar;
begin
  FReverseProxy := TReverseProxy.Create(FProxyIPRec);
  FReverseProxy.LogProc := Log2MainComm;
  FReverseProxy.Connect();
end;

procedure TReverseProxyWorker.Log2MainComm(const AMsg: string);
begin
  RespondEnqueueAndNotifyMainForm(Ord(pmkLog), TOmniValue.CastFrom(AMsg), MSG_RESULT);
end;

procedure TReverseProxyWorker.ProcessCommandProc(AMsg: TOmniMessage);
begin
  case AMsg.MsgID of
    0: ;
  end;
end;

procedure TReverseProxyWorker.RespondEnqueueAndNotifyMainForm(AMsgId: word;
  const AValue: TOmniValue; const AWinMsg: integer);
begin
  if ResponseQueue.Enqueue(TOmniMessage.Create(AMsgId, AValue)) then
    SendMessage(FormHandle, AWinMsg, AMsgId, 0)
  else
    raise Exception.Create('Response queue is full!');
end;

procedure TReverseProxyWorker.SetMainFormHandle(AHandle: THandle);
begin
  FormHandle := AHandle;
end;

procedure TReverseProxyWorker.SetProxyIpRec(const ARec: TProxyIPRec);
begin
  FProxyIPRec := ARec;
end;

end.
