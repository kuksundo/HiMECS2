unit DomSensorServices2;

interface

uses

  DomSensorTypes2,
  DomSensorInterfaces2,

  DomSensorCQRS2;

type

  TSensorManager = class(TInterfacedObject, ISensorManager)
    protected
      fSensorRepo: IDomSensorCommand;
    public                                // All IDom*Command Dependencys

      constructor Create( aIDSensorCmd: IDomSensorCommand ); reintroduce;
      // IToDoManager methods below
      function ChangeMothersName (): Boolean;
  end;

implementation

{ TToDoManager }

function TSensorManager.ChangeMothersName: Boolean;
begin

end;

constructor TSensorManager.Create(aIDSensorCmd: IDomSensorCommand);
begin
  inherited Create;

  fSensorRepo:=aIDSensorCmd;
end;

end.
