unit FrmMakeDfcFile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitFrameFileList2, Vcl.StdCtrls;

type
  TMakeDfcFileF = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MakeDfcFileF: TMakeDfcFileF;

implementation

uses FrmFileList, DesignFormConfigClass2;

{$R *.dfm}

procedure TMakeDfcFileF.Button1Click(Sender: TObject);
var
  LStrList: TStringList;
  LDesignFormConfig: TDesignFormConfig;
  i: integer;
begin
  LStrList := TStringList.Create;
  LDesignFormConfig := TDesignFormConfig.Create(nil);
  try
    CreatFileListForm(LStrList);

    for i := 0 to LStrList.Count - 1 do
    begin
      with LDesignFormConfig.DesignFormConfigCollect.Add do
      begin
        BplFileList := LBplFileNameList.CommaText;
        DesignFormCaption := PageControl1.AdvPages[i].Caption;
        DesignFormIndex := i+;
        DesignFormFileName := LStrList.Strings[i];
      end;//with
    end;//for

  finally
    LStrList.Free;
    LDesignFormConfig.Free;
  end;
end;

end.
