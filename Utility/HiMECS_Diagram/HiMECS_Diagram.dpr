// ************************************************************************
// ***************************** CEF4Delphi *******************************
// ************************************************************************
//
// CEF4Delphi is based on DCEF3 which uses CEF3 to embed a chromium-based
// browser in Delphi applications.
//
// The original license of DCEF3 still applies to CEF4Delphi.
//
// For more information about CEF4Delphi visit :
//         https://www.briskbard.com/index.php?lang=en&pageid=cef
//
//        Copyright ?2018 Salvador D?z Fau. All rights reserved.
//
// ************************************************************************
// ************ vvvv Original license and comments below vvvv *************
// ************************************************************************
(*
 *                       Delphi Chromium Embedded 3
 *
 * Usage allowed under the restrictions of the Lesser GNU General Public License
 * or alternatively the restrictions of the Mozilla Public License 1.1
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
 * the specific language governing rights and limitations under the License.
 *
 * Unit owner : Henri Gourvest <hgourvest@gmail.com>
 * Web site   : http://www.progdigy.com
 * Repository : http://code.google.com/p/delphichromiumembedded/
 * Group      : http://groups.google.com/group/delphichromiumembedded
 *
 * Embarcadero Technologies, Inc is not permitted to use or redistribute
 * this source code without explicit permission.
 *
 *)

program HiMECS_Diagram;

{$I cef.inc}

uses
  Vcl.Forms,
  Windows,
  uCEFApplication,
  FrmDiagram in '..\..\..\HiMECS_Diagram\FrmDiagram.pas' {DOMVisitorFrm},
  UnitHDiagramCommandLine in 'UnitHDiagramCommandLine.pas',
  UnitHDiagramExtension in 'UnitHDiagramExtension.pas',
  mormot.core.os in '..\..\..\..\OpenSrc\lib\mORMot2-master\src\core\mormot.core.os.pas',
  mormot.core.base in '..\..\..\..\OpenSrc\lib\mORMot2-master\src\core\mormot.core.base.pas',
  UnitFileUtil in '..\..\..\..\..\..\..\project\common\UnitFileUtil.pas';

{$R *.res}

{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  // GlobalCEFApp creation and initialization moved to a different unit to fix the memory leak described in the bug #89
  // https://github.com/salvadordf/CEF4Delphi/issues/89
  CreateGlobalCEFApp;

  if GlobalCEFApp.StartMainProcess then
  begin
    ReportMemoryLeaksOnShutdown := DebugHook <> 0;

    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TDOMVisitorFrm, DOMVisitorFrm);
    Application.Run;
  end;

  // This is not really necessary to fix the bug #89 but if you free GlobalCEFApp in a different unit
  // then you can call 'FreeAndNil' without adding SysUtils to this DPR.
  DestroyGlobalCEFApp;
end.
