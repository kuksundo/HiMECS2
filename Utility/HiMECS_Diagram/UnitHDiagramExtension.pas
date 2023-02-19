unit UnitHDiagramExtension;

{$I cef.inc}

interface

uses
  {$IFDEF DELPHI16_UP}
  Winapi.Windows,
  {$ELSE}
  Windows,
  {$ENDIF}
  uCEFRenderProcessHandler, uCEFBrowserProcessHandler, uCEFInterfaces, uCEFProcessMessage,
  uCEFv8Context, uCEFTypes, uCEFv8Handler;

type
  THiMECSDiagramExt = class
    class procedure SaveModel2File(const data: string);
    class procedure LoadModelFromFile(const data: string);
    class procedure SaveModel2DB(const data: string);
    class procedure sendresulttobrowser(const msgtext, msgname : string);
  end;

implementation

uses
  uCEFMiscFunctions, uCEFConstants, FrmDiagram;

{ THiMECSDiagramExt }

class procedure THiMECSDiagramExt.LoadModelFromFile(const data: string);
begin

end;

class procedure THiMECSDiagramExt.SaveModel2DB(const data: string);
var
  TempMessage : ICefProcessMessage;
  TempFrame   : ICefFrame;
begin
  try
    TempMessage := TCefProcessMessageRef.New(MSGNAME_DIAGRAM_SAVE2DB);
    TempMessage.ArgumentList.SetString(0, data);

    TempFrame := TCefv8ContextRef.Current.Browser.MainFrame;

    if (TempFrame <> nil) and TempFrame.IsValid then
      TempFrame.SendProcessMessage(PID_BROWSER, TempMessage);//TChromium.OnProcessMessageReceived ·Î º¸³¿
  finally
    TempMessage := nil;
  end;
end;

class procedure THiMECSDiagramExt.SaveModel2File(const data: string);
var
  TempMessage : ICefProcessMessage;
  TempFrame   : ICefFrame;
begin
  try
    TempMessage := TCefProcessMessageRef.New(MSGNAME_DIAGRAM_SAVEAS);
    TempMessage.ArgumentList.SetString(0, data);

    // Sending a message back to the browser. It'll be received in the TChromium.OnProcessMessageReceived event.
    // TCefv8ContextRef.Current returns the v8 context for the frame that is currently executing Javascript.

    TempFrame := TCefv8ContextRef.Current.Browser.MainFrame;

    if (TempFrame <> nil) and TempFrame.IsValid then
      TempFrame.SendProcessMessage(PID_BROWSER, TempMessage);//TChromium.OnProcessMessageReceived ·Î º¸³¿
  finally
    TempMessage := nil;
  end;
end;

class procedure THiMECSDiagramExt.sendresulttobrowser(const msgtext,
  msgname: string);
var
  TempMessage : ICefProcessMessage;
  TempFrame   : ICefFrame;
begin
  try
    TempMessage := TCefProcessMessageRef.New(msgname);
    TempMessage.ArgumentList.SetString(0, msgtext);

    TempFrame := TCefv8ContextRef.Current.Browser.MainFrame;

    if (TempFrame <> nil) and TempFrame.IsValid then
      TempFrame.SendProcessMessage(PID_BROWSER, TempMessage);
  finally
    TempMessage := nil;
  end;
end;

end.
