#define MyAppName "Convertix"
#define MyAppVersion "1.0"
#define MyAppPublisher "Mouad Garroud"
#define MyAppExeName "Convertix.exe"
#define MyAppAssocName "Convertix"
#define MyAppAssocExt ".exe"
#define MyAppAssocKey "Convertix_exe"

[Setup]
AppId={{77A261A3-8B0C-AM29-BEA6-3C1125AB56FC}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName}
UninstallDisplayName={#MyAppName}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
ChangesAssociations=yes
DisableProgramGroupPage=yes
OutputDir=C:\Users\Mouad Garroud\Documents\Projet\Convertix\innosetup\
OutputBaseFilename=Convertix
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\Mouad Garroud\Documents\Projet\Convertix\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Mouad Garroud\Documents\Projet\Convertix\Convertix.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Mouad Garroud\Documents\Projet\Convertix\Readme.md"; DestDir: "{app}"; Flags: ignoreversion

[Registry]
Root: HKCR; Subkey: "Software\Classes\{#MyAppAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKCR; Subkey: "Software\Classes\{#MyAppAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey
Root: HKCR; Subkey: "Software\Classes\{#MyAppAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: HKCR; Subkey: "Software\Classes\{#MyAppAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: HKCR; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: ".myp"; ValueData: ""

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#MyAppName}}"; Flags: nowait postinstall skipifsilent
