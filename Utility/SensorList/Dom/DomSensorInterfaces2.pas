unit DomSensorInterfaces2;

interface

uses
  mormot.core.interfaces,
  DomSensorTypes2;

type

  ISensorManager = interface(IInvokable)
   ['{619DF574-3FCD-43F9-9809-8A056C11F69E}']
    function ChangeMothersName (): Boolean;
  end;


implementation

initialization
  TInterfaceFactory.RegisterInterfaces([
    TypeInfo(ISensorManager)
  ]);

end.
