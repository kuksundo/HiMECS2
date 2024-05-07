unit UProxyType;

interface

uses System.Classes;

type
  TProtocolKind = (pkTCP, pkUDP);

  TIPRec = packed record
    FIp: string;
    FPort: string;
  end;

  TFowardIPRec = packed record
    FProtocol: integer;  //TProtocolKind
    FSrcIP: TIPRec;
    FDestIP: TIPRec;
  end;

  TForwardList = TList<TIPRec>; //�������� IP/Port List

implementation

end.
