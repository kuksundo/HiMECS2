unit UnitHiMECSAlarmConst;

interface

type
  PAlarmListRecord = ^TAlarmListRecord;
  TAlarmListRecord = class
    FSeqNo: integer;
    FDeviceKind: string;
    FDeviceNo: string;
    FAlarmLevel: integer;
    FAlarmPriority: integer;
    FIssueDateTime: TDateTime;
    FTagName: string;
    FTagDesc: string;
    FReleaseDateTime: TDateTime;
    FSensorCode: string;
    FAlarmDesc: string;
    FValue: string;
    FNeedAck: Boolean;
    FAcknowledgedTime: TDateTime;
    FSuppressed: Boolean;
    FInhibited: Boolean;
    FDBSaved: Boolean; //DB���� �ʿ�/���ʿ�
    FParamIndex: integer;
  end;

const
  //Alarm List Grid Column Index
  CI_ACKED = 0;
  CI_TIME_IN = 1;
  CI_TIME_OUT = 2;
  CI_ENGINE_NO = 3;
  CI_TAG_DESC = 4;
  CI_ALARM_LEVEL = 5;
  CI_ALARM_MSG = 6;
  CI_ALARM_PRIO = 7;
  //Alarm List Grid Column Index
implementation

end.
