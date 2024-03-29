; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "DNLF Support App"
#define MyAppVersion "1.5"
#define MyAppPublisher "DNLM"
#define MyAppURL "https://dnlm.org/qa/"
#define MyAppExeName "dnlf_support_app.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{23F7F3F4-8257-451F-93BC-6CC55FEE20AD}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=D:\AndroidStudios\DNLFQA_app\SupportApp\dnlf_support_app\installers
OutputBaseFilename=DNLFSetup
SetupIconFile=D:\AndroidStudios\DNLFQA_app\SupportApp\dnlf_support_app\windows\runner\resources\app_icon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "D:\AndroidStudios\DNLFQA_app\SupportApp\dnlf_support_app\build\windows\runner\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\AndroidStudios\DNLFQA_app\SupportApp\dnlf_support_app\build\windows\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\AndroidStudios\DNLFQA_app\SupportApp\dnlf_support_app\build\windows\runner\Release\dnlf_support_app.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "D:\AndroidStudios\DNLFQA_app\SupportApp\dnlf_support_app\build\windows\runner\Release\data\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

