unit UnitHiMECSAlarmRecord;

interface

{$I mormot.defines.inc}

uses
  mormot.core.base,
  mormot.orm.base,
  mormot.orm.core;

type
  TOrmHiMECSAlarmList = class(TOrm)
  private
    FDeviceKind: string;
    FDeviceNo: string;
    FTagName: string;
    FTagDesc: string;
    FSensorCode: string;
    FAlarmDesc: string;
    FValue: string;
    FAlarmType: integer;
    FAlarmPriority: integer;
    FNeedAck: Boolean;
    FIssueDateTime: TModTime;
    FAcknowledgedTime: TModTime;
    FReleaseDateTime: TModTime;
    FSuppressed: Boolean;
    FInhibited: Boolean;
  published
    property DeviceKind: string read FDeviceKind write FDeviceKind;
    property DeviceNo: string read FDeviceNo write FDeviceNo;
    property TagName: string read FTagName write FTagName;
    property TagDesc: string read FTagDesc write FTagDesc;
    property SensorCode: string read FSensorCode write FSensorCode;
    property AlarmDesc: string read FAlarmDesc write FAlarmDesc;
    property Value: string read FValue write FValue;
    property AlarmType: integer read FAlarmType write FAlarmType;
    property AlarmPriority: integer read FAlarmPriority write FAlarmPriority;
    property IssueDateTime: TModTime read FIssueDateTime write FIssueDateTime;
    property AcknowledgedTime: TModTime read FAcknowledgedTime write FAcknowledgedTime;
    property ReleaseDateTime: TModTime read FReleaseDateTime write FReleaseDateTime;
    property NeedAck: Boolean read FNeedAck write FNeedAck;
    property Suppressed: Boolean read FSuppressed write FSuppressed;
    property Inhibited: Boolean read FInhibited write FInhibited;
  end;

  function CreateHiMECSAlarmListModel: TOrmModel;

implementation

function CreateHiMECSAlarmListModel: TOrmModel;
begin
  result := TOrmModel.Create([TOrmHiMECSAlarmList]);
end;

end.
