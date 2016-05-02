#define Name "7z SFX Builder"
#define Vers "2.1"
#define Publisher "Mirza Brunjadze"
#define Exe "7z SFX Builder.exe"

[Setup]
AppId={{0C1F1BEB-C237-4E32-914F-2A7D7D56E79B}
AppName={#Name}
AppVersion={#Vers}
AppVerName={#Name} {#Vers}
AppPublisher={#Publisher}
DefaultDirName={pf}\{#Name}
DefaultGroupName={#Name}
OutputDir=.\
OutputBaseFilename=7z.SFX.Builder.Setup-{#Vers}
Compression=lzma
SolidCompression=yes
AllowNoIcons=yes
DisableWelcomePage=yes
;ArchitecturesInstallIn64BitMode=x64
;LicenseFile=.\License.txt
UninstallDisplayIcon={app}\{#Exe}
UninstallDisplayName={#Name} v{#Vers}
VersionInfoCompany={#Publisher}
VersionInfoDescription={#Name} Setup

[Files]
Source: ..\7z SFX Builder.exe; DestDir: {app}; DestName: "{#Exe}"; Flags: ignoreversion
Source: ..\7zSD_EN.chm; DestDir: {app}; Flags: ignoreversion
Source: ..\7zSD_RU.chm; DestDir: {app}; Flags: ignoreversion
Source: ..\3rdParty\Modules\*.*; DestDir: {app}\3rdParty\Modules; Flags: recursesubdirs createallsubdirs ignoreversion
Source: ..\3rdParty\UPX\*.*; DestDir: {app}\3rdParty\UPX; Flags: recursesubdirs createallsubdirs ignoreversion
Source: ..\3rdParty\SFXSPLIT.EXE; DestDir: {app}\3rdParty; Flags: ignoreversion
Source: ..\3rdParty\TEST.SFX; DestDir: {app}\3rdParty; DestName: "TEST.SFX"; Flags: ignoreversion
Source: ..\3rdParty\Readme.txt; DestDir: {app}\3rdParty; Flags: ignoreversion
Source: ..\Lang\*.ini; DestDir: {app}\Lang; Flags: ignoreversion
Source: ..\LICENSE; DestDir: {app}; Flags: ignoreversion
Source: .\History.txt; DestDir: {app}; Flags: ignoreversion
Source: {src}\Settings.ini; DestDir: {app}; Tasks: applyini; Flags: external ignoreversion skipifsourcedoesntexist uninsneveruninstall

[Registry]
;Root: HKCU; SubKey: Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers; ValueType: string; ValueName: "{app}\{#Exe}"; ValueData: "~ RUNASADMIN"; MinVersion: 0,6.0
Root: HKCR; Subkey: *\shell\Open with 7z SFX Builder; Flags: uninsdeletekey noerror
Root: HKCR; Subkey: *\shell\Open with 7z SFX Builder; ValueType: string; ValueName: Icon; ValueData: {app}\{#Exe}; Tasks: shell; MinVersion: 0,6.0
Root: HKCR; Subkey: *\shell\Open with 7z SFX Builder\command; ValueType: string; ValueName: ; ValueData: "{app}\{#Exe} ""%1"""; Tasks: shell

[Run]
Filename: {app}\{#Exe}; Description: {cm:LaunchProgram,{#Name}}; Flags: nowait postinstall skipifsilent runascurrentuser
Filename: "{cmd}"; Parameters: "/c if exist ""{src}\Settings.reg"" regedit /s ""{src}\Settings.reg"""; Tasks: applyreg; Flags: skipifsilent runhidden

[Icons]
Name: {group}\{#Name}; Filename: {app}\{#Exe}
Name: {group}\{cm:UninstallProgram,{#Name}}; Filename: {uninstallexe}
Name: {commondesktop}\{#Name}; Filename: {app}\{#Exe}; Tasks: desktopicon
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\{#Name}; Filename: {app}\{#Exe}; Tasks: quicklaunchicon; OnlyBelowVersion: 0,6.1

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}
Name: quicklaunchicon; Description: {cm:CreateQuickLaunchIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked; OnlyBelowVersion: 0,6.1
Name: shell; Description: {cm:IntegrateWithShell}; GroupDescription: {cm:OtherOptions}
Name: applyreg; Description: {cm:ApplySettings,[installerpath]\Settings.reg}; GroupDescription: {cm:OtherOptions}; Flags: unchecked
Name: applyini; Description: {cm:ApplySettings,[installerpath]\Settings.ini}; GroupDescription: {cm:OtherOptions}; Flags: unchecked

[CustomMessages]
english.OtherOptions=Additional options:
english.IntegrateWithShell=Integrate with context menu
english.ApplySettings=Import settings from %1

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[LangOptions]
DialogFontName=Segoe UI
DialogFontSize=8
WelcomeFontName=Segoe UI
WelcomeFontSize=12
TitleFontName=Segoe UI
TitleFontSize=29
CopyrightFontName=Segoe UI
CopyrightFontSize=8
RightToLeft=no