unit HiMECS_Comm_Intf;

interface

{$I mormot.defines.inc}
uses
  mormot.core.base,
  mormot.core.data,
  mormot.core.json,
  mormot.core.interfaces,
  mormot.orm.core;

type
  TManualInfo = packed record
    Name: RawUTF8;
    Contents: RawUTF8;
    Page: RawUTF8;
  end;

  IHiMECS_Comm_Service = interface(IInvokable)
    ['{BE725724-B87B-449B-968D-9A6AD11D3597}']
    function ServerExecute(const Acommand: RawUTF8): RawUTF8;
    function GetManualContents(const AManualInfo: TManualInfo): RawUTF8;
  end;

const
  HiMECS_COMM_DEFAULT_IP = '10.0.2.15';
  HiMECS_COMM_ROOT_NAME = 'root';
  HiMECS_COMM_PORT = '710';
  HiMECS_COMM_APPLICATION_NAME = 'RCS__RestService';

  //Remote Command
  HiMECS_CMD_REQ_MANUAL_CONTENTS = 'Request manual contents from HiMECS-Comm-Server';
  HiMECS_CMD_REQ_MANUAL_FILE = 'Request manual file from HiMECS-Comm-Server';

  //Server Response Result
  HiMECS_RESULT_NO_DATA = 'No Data';

implementation

end.
