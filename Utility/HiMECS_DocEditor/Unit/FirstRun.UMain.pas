{
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 2008-2021, Peter Johnson (gravatar.com/delphidabbler).
 *
 * Implements classes that handle application start up, determine if it the
 * first run of the current version and perform necessary updates to per-user
 * config file and database.
}


unit FirstRun.UMain;


interface


uses
  // Project
  FirstRun.UConfigFile, FirstRun.UDatabase, FirstRun.UInstallInfo, UVersionInfo;


type
  ///  <summary>Enumeration of changes that can be made to brought forward
  ///  config files that result in data loss.</summary>
  TFirstRunCfgChanges = (
    frcHiliter,         // syntax highlighter customisation lost
    frcSourceFormat     // source code output formatting lost
  );

type
  ///  <summary>Set of first run changes to brought forward config file that can
  ///  result in data loss.</summary>
  TFirstRunCfgChangeSet = set of TFirstRunCfgChanges;

type
  ///  <summary>Class that provides information about current and previous
  ///  installations of CodeSnip along with operations to carry forward user
  ///  preferences and database and to update user config file when necessary.
  ///  </summary>
  TFirstRun = class(TObject)
  strict private
    var
      ///  <summary>Object that provides information about current and earlier
      ///  installations.</summary>
      fInstallInfo: TInstallInfo;
      ///  <summary>Object that interogates and updates user's config file.
      ///  </summary>
      fUserConfigFile: TUserConfigFileUpdater;
      ///  <summary>Object that interogates and updates common config file.
      ///  </summary>
      fCommonConfigFile: TCommonConfigFileUpdater;
      ///  <summary>Object used to copy forward older versions of user database.
      ///  </summary>
      fDatabase: TUserDatabaseUpdater;
  public
    ///  <summary>Constructs object and owned object.</summary>
    constructor Create;
    ///  <summary>Frees object and owned objects.</summary>
    destructor Destroy; override;
    ///  <summary>Checks if a user config file exists for an earlier CodeSnip
    ///  installation.</summary>
    function HaveOldUserCfgFile: Boolean;
    ///  <summary>Copies user config file from an earlier CodeSnip installation.
    ///  </summary>
    procedure BringForwardUserCfgFile;
    ///  <summary>Updates current version's user config file in place as
    ///  necessary and notifies caller of changes via Changes parameter.
    /// </summary>
    procedure UpdateUserCfgFile(out Changes: TFirstRunCfgChangeSet);
    ///  <summary>Checks if a user database exist for an earlier CodeSnip
    ///  installation.</summary>
    function HaveOldUserDB: Boolean;
    ///  <summary>Copies user database from an earlier CodeSnip installation.
    ///  </summary>
    procedure BringForwardUserDB;
    ///  <summary>Creates a new, empty, Unicode encoded per-user config file for
    ///  current installation.</summary>
    procedure CreateEmptyUserCfgFile;
    ///  <summary>Checks if the program has been updated since the last run.
    ///  </summary>
    ///  <remarks>Compares the version number stored in the brought forward
    ///  config file against the current program version number from resources.
    ///  </remarks>
    function IsProgramUpdated: Boolean;
    ///  <summary>Checks if the previous program's version number, as specified
    ///  in the user config file, is contained in the range Lo..Hi with range
    ///  endpoints determined by IntervalEndPoints.</summary>
    function IsPreviousProgramVerInRange(const Lo, Hi: TVersionNumber;
      const IntervalEndPoints: TVersionNumber.TIntervalEndPoints): Boolean;
  end;

type
  ///  <summary>Static class that manages program's first run processing.
  ///  </summary>
  ///  <remarks>
  ///  <para>Designed to be called before any program preferences are read.
  ///  </para>
  ///  <para>If current major version of program has not been run before and
  ///  user data from an earlier version is detected then a dialogue box is
  ///  displayed to give user various options to bring forward data.</para>
  ///  <para>If major version is unchanged but minor version, or user config
  ///  file version, has changed then config file may be modified.</para>
  ///  </remarks>
  TFirstRunMgr = class(TObject)
  strict private
    ///  <summary>Checks if user config file exists for current program version.
    ///  </summary>
    class function UserCfgFileExists: Boolean;
    ///  <summary>Determines if this is first time this major version of the
    ///  program has been run.</summary>
    class function IsFirstRun: Boolean;
    ///  <summary>Determines if program has been updated since last run.
    ///  </summary>
    class function IsProgramUpdated: Boolean;
  public
    ///  <summary>Runs start-up checks to detect if program has been run before
    ///  and performs any required user config and user database updates. In
    ///  some circumstances a "what's new" dialogue box may be displayed.
    ///  </summary>
    class procedure Execute;
  end;


implementation


uses
  // Delphi
  SysUtils, IOUtils, Forms,
  // Project
  FirstRun.FmWhatsNew
  {$IFNDEF PORTABLE}
  ,
  FirstRun.FmV4ConfigDlg;
  {$ELSE}
  ;
  {$ENDIF}


{ TFirstRun }

procedure TFirstRun.BringForwardUserCfgFile;
begin
  Assert(HaveOldUserCfgFile,
    ClassName + '.BringForwardUserCfgFile: Old config file does not exist');
  fUserConfigFile.CopyFile(
    fInstallInfo.PreviousUserConfigFileName,
    fInstallInfo.IsPreviousUserConfigFileANSI
  );
end;

procedure TFirstRun.BringForwardUserDB;
begin
  Assert(HaveOldUserDB,
    ClassName + '.BringForwardUserDB: Old user database does not exist');
  fDatabase.CopyDatabase(fInstallInfo.PreviousUserDatabaseDir);
end;

constructor TFirstRun.Create;
begin
  inherited Create;
  fInstallInfo := TInstallInfo.Create;
  fUserConfigFile := TUserConfigFileUpdater.Create(
    fInstallInfo.CurrentUserConfigFileName
  );
  fCommonConfigFile := TCommonConfigFileUpdater.Create(
    fInstallInfo.CurrentCommonConfigFileName
  );
  fDatabase := TUserDatabaseUpdater.Create(
    fInstallInfo.CurrentUserDatabaseDir
  );
end;

procedure TFirstRun.CreateEmptyUserCfgFile;
begin
  fUserConfigFile.CreateNewFile;
end;

destructor TFirstRun.Destroy;
begin
  fDatabase.Free;
  fCommonConfigFile.Free;
  fUserConfigFile.Free;
  fInstallInfo.Free;
  inherited;
end;

function TFirstRun.HaveOldUserCfgFile: Boolean;
begin
  Result := TFile.Exists(fInstallInfo.PreviousUserConfigFileName, False);
end;

function TFirstRun.HaveOldUserDB: Boolean;
begin
  Result := TFile.Exists(fInstallInfo.PreviousUserDatabaseFileName, False);
end;

function TFirstRun.IsPreviousProgramVerInRange(const Lo, Hi: TVersionNumber;
  const IntervalEndPoints: TVersionNumber.TIntervalEndPoints): Boolean;
var
  PrevProgVer: TVersionNumber;
begin
  PrevProgVer := fUserConfigFile.PreviousProgramVer;
  Result := PrevProgVer.IsInRange(Lo, Hi, IntervalEndPoints);
end;

function TFirstRun.IsProgramUpdated: Boolean;
begin
  Result := fUserConfigFile.IsCurrentProgramVer;
end;

procedure TFirstRun.UpdateUserCfgFile(out Changes: TFirstRunCfgChangeSet);
begin
  Changes := [];

  {$IFNDEF PORTABLE}
  case fInstallInfo.InstallID of
    piOriginal:
    begin
      fUserConfigFile.UpdateFromOriginal;
      Include(Changes, frcHiliter);
      Include(Changes, frcSourceFormat);
    end;
    piV1_9, piV2:
    begin
      fUserConfigFile.DeleteHighligherPrefs;
      Include(Changes, frcHiliter);
    end;
    piV3: ; // do nothing
  end;
  {$ENDIF}

  if fUserConfigFile.FileVer < 6 then
    // User ini file versions before 6 don't have the Prefs:CodeGen section and
    // default entries for predefined warnings.
    // NOTE: This works for a new config file providing it has not been stamped:
    // we rely on this for portable version.
    fUserConfigFile.CreateDefaultCodeGenEntries;

  if fUserConfigFile.FileVer < 9 then
  begin
    fUserConfigFile.DeleteDetailsPaneIndex;
    fUserConfigFile.UpdateCodeGenEntries;
  end;

  if fUserConfigFile.FileVer < 11 then
    fUserConfigFile.RenameMainWindowSection;

  if fUserConfigFile.FileVer < 12 then
    fUserConfigFile.UpdateNamespaces;

  if fUserConfigFile.FileVer < 15 then
    fUserConfigFile.UpdateFindXRefs;


  if fUserConfigFile.FileVer < 16 then
  begin
    fUserConfigFile.DeleteNewsPrefs;
    fUserConfigFile.DeleteProxyServerSection;
    fUserConfigFile.DeleteUpdatingPrefs;
    fUserConfigFile.DeleteUpdateChecks;
    fUserConfigFile.DeleteUserInfo;
  end;

  {$IFNDEF PORTABLE}
  // No need to delete sections of common config file on portable edition
  // because the entire file is deleted below!
  if fCommonConfigFile.FileVer < 7 then
  begin
    fCommonConfigFile.DeleteRegistrationInfo;
    fCommonConfigFile.DeleteProgramKey;
  end;
  {$ENDIF}

  fUserConfigFile.Stamp;

  {$IFNDEF PORTABLE}
  // NOTE: strictly speaking we only need to stamp common config file in
  // portable version. Installer does this in normal version. However, it does
  // no harm to stamp this file twice - belt and braces!
  fCommonConfigFile.Stamp;
  {$ELSE}
  fCommonConfigFile.DeleteCfgFile;
  {$ENDIF}
end;

{ TFirstRunMgr }

class procedure TFirstRunMgr.Execute;
const
  // Version numbers specifying a range in which previous program version must
  // lie in order to display "What's New" dialogue box.
  // Range is [NeedWhatsNewLoVerIncl, NeedWhatsNewHiVerExcl)
  NeedWhatsNewLoVerIncl: TVersionNumber = (V1: 4; V2: 0; V3: 0; V4: 0);
  NeedWhatsNewHiVerExcl: TVersionNumber = (V1: 4; V2: 16; V3: 0; V4: 0);
var
  FR: TFirstRun;
  Changes: TFirstRunCfgChangeSet;
begin
  if IsFirstRun then
  begin
    FR := TFirstRun.Create;
    try
      {$IFNDEF PORTABLE}
      if FR.HaveOldUserCfgFile or FR.HaveOldUserDB then
        TV4ConfigDlg.Execute(Application, FR);
      {$ENDIF}
      if not UserCfgFileExists then
      begin
        FR.CreateEmptyUserCfgFile;
        FR.UpdateUserCfgFile(Changes);
      end;
    finally
      FR.Free;
    end;
  end
  else if IsProgramUpdated then
  begin
    FR := TFirstRun.Create;
    try
      // We display "What's New" dialogue box if previous program version number
      // is in the given range
      if FR.IsPreviousProgramVerInRange(
        NeedWhatsNewLoVerIncl,
        NeedWhatsNewHiVerExcl,
        TVersionNumber.TIntervalEndPoints.iepHalfOpenHi
      ) then
        TWhatsNewDlg.Execute(Application);
      FR.UpdateUserCfgFile(Changes);  // we ignore Changes [out] param value
    finally
      FR.Free;
    end;
  end;
end;

class function TFirstRunMgr.IsFirstRun: Boolean;
begin
  Result := not UserCfgFileExists;
end;

class function TFirstRunMgr.IsProgramUpdated: Boolean;
begin
  Result := not TUserConfigFileUpdater.IsCurrentProgramVer(
    TInstallInfo.CurrentUserConfigFileName
  );
end;

class function TFirstRunMgr.UserCfgFileExists: Boolean;
begin
  Result := TFile.Exists(TInstallInfo.CurrentUserConfigFileName, False);
end;

end.

