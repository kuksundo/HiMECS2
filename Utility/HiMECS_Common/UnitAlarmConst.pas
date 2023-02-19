unit UnitAlarmConst;

interface

uses mormot.orm.base, UnitHiMECSAlarmRecord;

type
  PAlarmListClass = ^TAlarmListClass;
  TAlarmListClass = class
    FSeqNo: integer;
    FEngineNo: string;
    FAlarmType: integer;
    FAlarmPriority: integer;
    FIssueDateTime: TModTime;//�˶��߻��Ͻ�
    FTagName: string;
    FTagDesc: string;
    FReleaseDateTime: TModTime;//�˶������Ͻ�
    FSensorCode: string;
    FAlarmDesc: string;
    FValue: string;
    FNeedAck: Boolean;
    FAcknowledgedTime: TModTime;//ACK �Ͻ�
    FSuppressed: Boolean;
    FInhibited: Boolean;
    FDBSaved: Boolean; //DB���� �ʿ�/���ʿ�
    FParamIndex: integer;
  public
    procedure AssignAlarmListClass2Record(AOrm:TOrmHiMECSAlarmList);
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

{ TAlarmListClass }

procedure TAlarmListClass.AssignAlarmListClass2Record(AOrm:TOrmHiMECSAlarmList);
begin
  with AOrm do
  begin
//    FSeqNo :=
    DeviceNo := FEngineNo;
    AlarmType := FAlarmType;
    AlarmPriority := FAlarmPriority;
    IssueDateTime := FIssueDateTime;//�˶��߻��Ͻ�
    TagName := FTagName;
    TagDesc := FTagDesc;
    ReleaseDateTime := FReleaseDateTime;//�˶������Ͻ�
    SensorCode := FSensorCode;
    AlarmDesc := FAlarmDesc;
    Value := FValue;
    NeedAck := FNeedAck;
    AcknowledgedTime := FAcknowledgedTime;//ACK �Ͻ�
    Suppressed := FSuppressed;
    Inhibited := FInhibited;
//    FDBSaved: Boolean; //DB���� �ʿ�/���ʿ�
//    FParamIndex: integer;
  end;
end;

end.
