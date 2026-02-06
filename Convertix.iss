#define MyAppName "Convertix"
#define MyAppVersion "1.0"
#define MyAppPublisher "MouadGarroud"
#define MyAppExeName "Convertix.exe"

[Setup]
AppId={{77A261A3-8B0C-4A29-BEA6-3C1125AB56FC}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName}
UninstallDisplayName={#MyAppName}
AppPublisher={#MyAppPublisher}

DefaultDirName={autopf}\{#MyAppName}

InfoBeforeFile=C:\Users\MouadGarroud\Documents\Convertix\Readme.md
OutputDir=C:\Users\MouadGarroud\Documents\Convertix\innosetup
OutputBaseFilename=Convertix

ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible

DisableProgramGroupPage=yes
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; \
GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\MouadGarroud\Documents\Convertix\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\MouadGarroud\Documents\Convertix\Convertix.png"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\MouadGarroud\Documents\Convertix\Readme.md"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; \
Description: "{cm:LaunchProgram,{#MyAppName}}"; \
Flags: nowait postinstall skipifsilent
