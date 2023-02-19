unit UnitHiMECSRestServer;

interface

uses
  SysUtils, Classes,
  mormot.net.server, mormot.core.zip, mormot.core.os, mormot.core.interfaces,
  mormot.core.text, mormot.core.base, mormot.core.unicode, mormot.core.buffers,
  mormot.core.data, mormot.core.json,
  mormot.db.proxy, mormot.db.raw.sqlite3, mormot.net.http,
  mormot.rest.core, mormot.rest.server, mormot.rest.sqlite3, mormot.rest.http.server,
  mormot.soa.core, mormot.soa.server,
  mormot.orm.core,
  UnitHiMECSRestAPIInterface;

const HttpPort = '800';

type
  THiMECS_Rest_Service = class(TInjectableObjectRest, IHiMECSRestAPI)
  protected
    function GetParamFromJson(AParamJson: RawUTF8): TRestAPIResponseDoc;
    function GetFile2RawData(AFileName: RawUTF8): RawByteString;
    function GetFile2Base64(AFileName: RawUTF8): RawUTF8;
    function GetDataFromMainForm(const AMethodName, AParamJson: RawUTF8): RawUTF8;
  public
    //Implement IHiMECSRestAPI
    function ServerExecByJson(const AJson: TRestAPIParam): RawUTF8;
    function ServerExecByParam(const AMethodName, AParamJson: RawUTF8): RawUTF8;
//    function GetListByParam(const AMethodName, AParamJson: RawUTF8): RawJson;
    function GetListByParam(const AMethodName, AParamJson: RawUTF8): TRestAPIResponseDynArr;
    function GetRawData(const AMethodName, AFileName: RawUTF8): RawBlob;
    function PutRawData(const AImage: RawBlob): integer;
    function GetBlob(const AMethodName, AFileName: RawUTF8): TServiceCustomAnswer;
  end;

  THiMECSRestServer = class(TRestServerDB)
  public
    constructor Create(aModel: TOrmModel; const aDBFileName: TFileName); overload;
  end;

  THiMECSHTTPAPIServer = class
  private
    FModel: TOrmModel;
    FRestServer: THiMECSRestServer;
    FHttpServer: TRestHttpServer;
    function Process(var Call: TRestUriParams): boolean;
  public
    constructor Create(ADBFileName: TFileName='');
    destructor Destroy; override;
  end;

implementation

uses mormot.core.variants,
  MainUnit2, UnitStringUtil, UnitIndyUtil, UnitBase64Util2;

{ THiMECS_Rest_Service }

function THiMECS_Rest_Service.GetBlob(const AMethodName, AFileName: RawUTF8): TServiceCustomAnswer;
var
  LRec: TRestAPIResponseDoc;
begin
  Result.Header := BINARY_CONTENT_TYPE_HEADER;// TEXT_CONTENT_TYPE_HEADER; //BINARY_CONTENT_TYPE_HEADER
  Result.Content := GetFile2RawData(AFileName);
  Result.Status := HTTP_SUCCESS;
end;

function THiMECS_Rest_Service.GetDataFromMainForm(const AMethodName,
  AParamJson: RawUTF8): RawUTF8;
var
  LVar: variant;
  LRec:TRestAPIResponseDoc;

  procedure _GetParamFromJson;
  begin
    LVar := _JSON(AParamJson);

    LRec.MethodName := LVar.MethodName;
    LRec.Response := LVar.Response;
  end;
begin
  if AMethodName = 'GetProjectList' then
    Result := MainForm.GetProjectList2Json4Mobile
  else
  if AMethodName = 'GetDeviceList' then
  begin
    _GetParamFromJson;
    LRec.ProjName := LVar.Response;
    Result := MainForm.GetDeviceList2Json4Mobile(LRec);
  end
  else
  if AMethodName = 'GetDocList' then
  begin
    _GetParamFromJson;
    LRec.ProjName := LVar.ProjName;
    LRec.DeviceName := LVar.Response;
    Result := MainForm.GetDocList2Json4Mobile(LRec);
  end
  else
  if AMethodName = 'GetDocContent' then
  begin
    _GetParamFromJson;
    LRec.ProjName := LVar.ProjName;
    LRec.DeviceName := LVar.DeviceName;
    LRec.DocName := LVar.Response;
    Result := MainForm.GetDocContents2Json4Mobile(LRec);
  end
  else
  if AMethodName = 'GetDocPdf' then
  begin
    LRec.DocName := AParamJson;
    Result := MainForm.GetDocPdf2Json4Mobile(LRec);
  end
end;

function THiMECS_Rest_Service.GetFile2Base64(AFileName: RawUTF8): RawUTF8;
begin
  if FileExists(AFileName) then
  begin
    Result := StringFromFile(AFileName);
    Result := MakeRawUTF8ToBin64(Result, False);
  end
  else
    Result := '';
end;

function THiMECS_Rest_Service.GetFile2RawData(
  AFileName: RawUTF8): RawByteString;
begin
  if FileExists(AFileName) then
  begin
    Result := StringFromFile(AFileName);
  end
  else
    Result := '';
end;

function THiMECS_Rest_Service.GetListByParam(const AMethodName,
  AParamJson: RawUTF8): TRestAPIResponseDynArr;
var
  LDynArr: TDynArray;
  LUtf8: RawUTF8;
  LRec: TRestAPIResponse;
begin
  LDynArr.Init(TypeInfo(TRestAPIResponseDynArr), Result);
  LUtf8 := GetDataFromMainForm(AMethodName,AParamJson);
  LRec.MethodName := AMethodName;
  LRec.Response := LUtf8;
  LDynArr.Add(LRec);
end;

function THiMECS_Rest_Service.GetParamFromJson(AParamJson: RawUTF8): TRestAPIResponseDoc;
var
  LVar: variant;
begin
  LVar := _JSON(AParamJson);

  Result.MethodName := LVar.MethodName;
  Result.Response := LVar.Response;
end;

function THiMECS_Rest_Service.GetRawData(const AMethodName, AFileName: RawUTF8): RawBlob;
var
  LFileName, LPath: string;
begin
  LPath := RelToAbs(ExtractFilePath(AFileName), Executable.ProgramFilePath);
  Result := GetFile2RawData(LPath + ExtractFileName(LFileName));
end;

function THiMECS_Rest_Service.PutRawData(const AImage: RawBlob): integer;
begin

end;

function THiMECS_Rest_Service.ServerExecByJson(
  const AJson: TRestAPIParam): RawUTF8;
begin

end;

function THiMECS_Rest_Service.ServerExecByParam(const AMethodName,
  AParamJson: RawUTF8): RawUTF8;
begin
  Result := GetDataFromMainForm(AMethodName,AParamJson);
end;

{ THiMECSRestServer }

constructor THiMECSRestServer.Create(aModel: TOrmModel;
  const aDBFileName: TFileName);
begin
  inherited Create(AModel, ADBFileName);

//  ServicesRouting := TRestServerRoutingJsonRpc;
  ServiceDefine(THiMECS_Rest_Service, [IHiMECSRestAPI], sicClientDriven); //sicShared
end;

{ THiMECSHTTPAPIServer }

constructor THiMECSHTTPAPIServer.Create(ADBFileName: TFileName);
begin
  if ADBFileName = '' then
  begin
    ADBFileName := Executable.ProgramFilePath + 'db\' + ChangeFileExt(Executable.ProgramName, '.sqlite');
  end;

  FModel := CreateHiMECSRestAPIModel;

  FRestServer := THiMECSRestServer.Create(FModel, ADBFileName);
  FRestServer.DB.Synchronous := smOff;
  FRestServer.DB.LockingMode := lmExclusive;
  FRestServer.Server.CreateMissingTables;

  FHttpServer := TRestHttpServer.Create(HttpPort, [FRestServer], '+', HTTP_DEFAULT_MODE);
  FHttpServer.OnCustomRequest := Process;
  FHttpServer.AccessControlAllowOrigin := '*';
end;

destructor THiMECSHTTPAPIServer.Destroy;
begin
  FModel.Free;
  FRestServer.Free;
  FHttpServer.Free;

  inherited;
end;

function THiMECSHTTPAPIServer.Process(var Call: TRestUriParams): boolean;
var
  LFileName, LExt, LMethodName: string;
  LParams: TStringList;
begin
  LFileName := Call.Url;
  LParams := GetUrlParams_Id(LFileName);
  try
    LMethodName := LParams.Values['AMethodName'];

    if LMethodName = 'GetDocPdf_' then
    begin
      LFileName := ExtractFileName(LParams.Values['AParamJson']);
      LExt := UpperCase(ExtractFileExt(LFileName));

      if  LExt = '.PDF' then
      begin
        Call.OutHead := STATICFILE_CONTENT_TYPE_HEADER;
        Call.OutBody := Executable.ProgramFilePath + 'Doc\Manual\H35DF\' + LFileName;//'Doc\Manual\H35DF\' +
        Result := True;
        exit;
      end;
    end;

    Result := False;
  finally
    LParams.Free;
  end;
//  'E:\pjh\project\util\HiMECS\Application\Bin\Applications\test.pdf';
end;

end.
