unit UProxyType;

interface

uses System.Classes;

type
  TProtocolKind = (pkTCP, pkUDP);
  TProxyMsgKind = (pmkLog);

  TIPRec = packed record
    FIp: string;
    FPort: string;
  end;

  TProxyIPRec = packed record
    FProtocol: integer;  //TProtocolKind
    FSrcIP: TIPRec;
    FDestIP: TIPRec;
  end;

//  TForwardList = TList<TIPRec>; //�������� IP/Port List

implementation

end.
