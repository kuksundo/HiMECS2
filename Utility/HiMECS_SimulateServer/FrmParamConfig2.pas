unit FrmParamConfig2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExControls, JvComCtrls,
  AdvGroupBox, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, IniPersist, UnitConfigIniClass2,
  Vcl.Mask, JvExMask, JvToolEdit;

type
  TConfigSettings = class (TINIConfigBase)
  private
    //���� Type�� ���� �޴� ������Ʈ �Ӽ� Type�� ���ƾ� ��
    //(��: Text�� String, Checked�� Bool, Value�� Integer)
//    FMQServerEnable,
    FSTOMPServerIP,
    FSTOMPServerPort,
    FSTOMPServerUserId,
    FSTOMPServerPasswd,
    FSTOMPServerTopic,
    FParamFileName,
    FInterval4PulseData: string;

    FUseSharedMM,
    FUseSTOMP,
    FLoadCondOnStart: Boolean;
  public
    //Control.hint = ���� ����Ǵ� �ʵ�� (��: Caption, Text, Value)
    //Section Name, Key Name, Default Key Value, Component Tag No
//    [IniValue('MQTT Server','MQTT Server Enable', 'False')]
//    property MQTTServerEnable : string read FMQTTServerEnable write FMQTTServerEnable;
    [IniValue('STOMP Server','STOMP Server IP','10.14.21.117',6)]
    property STOMPServerIP : string read FSTOMPServerIP write FSTOMPServerIP;
    [IniValue('STOMP Server','STOMP Server Port','61613',7)]
    property STOMPServerPort : string read FSTOMPServerPort write FSTOMPServerPort;
    [IniValue('STOMP Server','STOMP Server UserId','pjh',8)]
    property STOMPServerUserId : string read FSTOMPServerUserId write FSTOMPServerUserId;
    [IniValue('STOMP Server','STOMP Server Passwd','pjh',9)]
    property STOMPServerPasswd : string read FSTOMPServerPasswd write FSTOMPServerPasswd;
    [IniValue('STOMP Server','STOMP Server Topic','',10)]
    property STOMPServerTopic : string read FSTOMPServerTopic write FSTOMPServerTopic;
    [IniValue('File','Use Shared MM','False',11)]
    property UseSharedMM : Boolean read FUseSharedMM write FUseSharedMM;
    [IniValue('File','Use STOMP','False',12)]
    property UseSTOMP : Boolean read FUseSTOMP write FUseSTOMP;
    [IniValue('File','Param File Name','',13)]
    property ParamFileName : string read FParamFileName write FParamFileName;
    [IniValue('File','Load Condition on start', 'False',14)]
    property LoadCondOnStart : Boolean read FLoadCondOnStart write FLoadCondOnStart;
    [IniValue('File','Interval time for SendgpSM and PulseEvent', '500', 15)]
    property Interval4PulseData : string read FInterval4PulseData write FInterval4PulseData;
  end;

  TConfigF = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    FileTS: TTabSheet;
    ParaFilenameEdit: TJvFilenameEdit;
    Label6: TLabel;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    JvIPAddress1: TJvIPAddress;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label9: TLabel;
    Edit5: TEdit;
    Label10: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConfigF: TConfigF;

implementation

{$R *.dfm}

end.
