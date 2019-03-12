;
;   This program is is free software; you can redistribute it and/or modify
;   it under the terms of the GNU General Public License as published by
;   the Free Software Foundation; either version 2 of the License, or (at
;   your option) any later version.
;
;   This program is distributed in the hope that it will be useful,
;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;   GNU General Public License for more details.
;
;   You should have received a copy of the GNU General Public License
;   along with this program; if not, write to the Free Software
;   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
;

;
;   Setup script for the Inno Setup installer builder.  For more
;   information on the free installer builder, see www.jrsoftware.org.
;
;   This file is a part of libexpat(Expat XML parser).
;   Contains both x32 and x64 installation files.
;   
;   Copyright 2019 Leonid Kuzin(aka DgINC) <dg.inc.lcf@gmail.com> 
;   Copyright В© 1998-2017 Thai Open Source Software Center, Clark Cooper, and the Expat maintainers
;

#define ExpatName "Expat"
#define ExpatVersion "2.2.6"
#define ExpatPublisher "The Expat Developers"
#define ExpatURL "http://www.libexpat.org/"
#define ExpatCopyright "Copyright В© 1998-2017 Thai Open Source Software Center, Clark Cooper, and the Expat maintainers"

[Setup]
AppId={{0CEC18FF-673C-40E3-8227-F907C7D0FE69}
AppName={#ExpatName}
AppVersion={#ExpatVersion}
;AppVerName={#ExpatName} {#ExpatVersion}
AppPublisher={#ExpatPublisher}
AppPublisherURL={#ExpatURL}
AppSupportURL={#ExpatURL}
AppUpdatesURL={#ExpatURL}
AppCopyright={#ExpatCopyright}
DefaultDirName={pf}\{#ExpatName}
DisableDirPage=yes
DefaultGroupName={#ExpatName}
DisableProgramGroupPage=yes
OutputBaseFilename=expat-win-{#ExpatVersion}
Compression=lzma
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x86 x64
OutputManifestFile=MANIFEST.txt

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "armenian"; MessagesFile: "compiler:Languages\Armenian.islu"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "greek"; MessagesFile: "compiler:Languages\Greek.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "nepali"; MessagesFile: "compiler:Languages\Nepali.islu"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "scottishgaelic"; MessagesFile: "compiler:Languages\ScottishGaelic.isl"
Name: "serbiancyrillic"; MessagesFile: "compiler:Languages\SerbianCyrillic.isl"
Name: "serbianlatin"; MessagesFile: "compiler:Languages\SerbianLatin.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Icons]
Name: "{group}\{cm:ProgramOnTheWeb,{#ExpatName}}"; Filename: "{#ExpatURL}"
Name: "{group}\{cm:UninstallProgram,{#ExpatName}}"; Filename: "{uninstallexe}"

[Files]
Source: "MANIFEST.txt"; DestDir: "{app}"; Flags: ignoreversion; Components: Documets
Source: "..\AUTHORS"; DestDir: "{app}"; DestName: "AUTHORS.txt"; Flags: ignoreversion; Components: Documets
Source: "..\Changes"; DestDir: "{app}"; DestName: "Changes.txt"; Flags: ignoreversion; Components: Documets
Source: "..\COPYING"; DestDir: "{app}"; DestName: "COPYING.txt"; Flags: ignoreversion; Components: Documets
Source: "..\README.md"; DestDir: "{app}"; DestName: "README.txt"; Flags: ignoreversion isreadme; Components: Documets
Source: "..\build\Win32\Release\*.exe"; DestDir: "{app}\Bin"; Flags: ignoreversion solidbreak; Components: Binary; Check: not Is64BitInstallMode
Source: "..\build\Win32\Release\*.dll"; DestDir: "{app}\Bin"; Flags: ignoreversion sharedfile solidbreak; Components: Binary; Check: not Is64BitInstallMode
Source: "..\build\Win32\Release\*.lib"; DestDir: "{app}\Bin"; Flags: ignoreversion solidbreak; Components: Binary; Check: not Is64BitInstallMode
Source: "..\build\x64\Release\*.exe"; DestDir: "{app}\Bin"; Flags: ignoreversion; Components: Binary; Check: Is64BitInstallMode
Source: "..\build\x64\Release\*.dll"; DestDir: "{app}\Bin"; Flags: ignoreversion sharedfile; Components: Binary; Check: Is64BitInstallMode
Source: "..\build\x64\Release\*.lib"; DestDir: "{app}\Bin"; Flags: ignoreversion; Components: Binary; Check: Is64BitInstallMode
Source: "..\doc\*.html"; DestDir: "{app}\Documents"; Flags: ignoreversion; Components: Documets
Source: "..\doc\*.css"; DestDir: "{app}\Documents"; Flags: ignoreversion; Components: Documets
Source: "..\doc\*.png"; DestDir: "{app}\Documents"; Flags: ignoreversion; Components: Documets
Source: "..\expat.sln"; DestDir: "{app}\Source"; Flags: ignoreversion; Components: Source
Source: "README.txt"; DestDir: "{app}\Source"; Flags: ignoreversion; Components: Source
Source: "..\examples\*.c"; DestDir: "{app}\Source\examples"; Flags: ignoreversion; Components: Source
Source: "..\examples\*.vcxproj"; DestDir: "{app}\Source\examples"; Flags: ignoreversion; Components: Source
Source: "..\examples\*.vcxproj.filters"; DestDir: "{app}\Source\examples"; Flags: ignoreversion; Components: Source
Source: "..\lib\*.c"; DestDir: "{app}\Source\lib"; Flags: ignoreversion; Components: Source
Source: "..\lib\*.h"; DestDir: "{app}\Source\lib"; Flags: ignoreversion; Components: Source
Source: "..\lib\*.def"; DestDir: "{app}\Source\lib"; Flags: ignoreversion; Components: Source
Source: "..\lib\*.vcxproj"; DestDir: "{app}\Source\lib"; Flags: ignoreversion; Components: Source
Source: "..\lib\*.vcxproj.filters"; DestDir: "{app}\Source\lib"; Flags: ignoreversion; Components: Source
Source: "..\tests\*.c"; DestDir: "{app}\Source\tests"; Flags: ignoreversion; Components: Source
Source: "..\tests\*.cpp"; DestDir: "{app}\Source\tests"; Flags: ignoreversion; Components: Source
Source: "..\tests\*.h"; DestDir: "{app}\Source\tests"; Flags: ignoreversion; Components: Source
Source: "..\tests\*.sln"; DestDir: "{app}\Source\tests"; Flags: ignoreversion; Components: Source
Source: "..\tests\*.vcxproj"; DestDir: "{app}\Source\tests"; Flags: ignoreversion; Components: Source
Source: "..\tests\*.vcxproj.filters"; DestDir: "{app}\Source\tests"; Flags: ignoreversion; Components: Source
Source: "..\tests\README.txt"; DestDir: "{app}\Source\tests"; Flags: ignoreversion; Components: Source
Source: "..\tests\benchmark\*.c"; DestDir: "{app}\Source\tests\benchmark"; Flags: ignoreversion; Components: Source
Source: "..\tests\benchmark\*.sln"; DestDir: "{app}\Source\tests\benchmark"; Flags: ignoreversion; Components: Source
Source: "..\tests\benchmark\*.vcxproj"; DestDir: "{app}\Source\tests\benchmark"; Flags: ignoreversion; Components: Source
Source: "..\tests\benchmark\README.txt"; DestDir: "{app}\Source\tests\benchmark"; Flags: ignoreversion; Components: Source
Source: "..\xmlwf\*.c"; DestDir: "{app}\Source\xmlwf"; Flags: ignoreversion; Components: Source
Source: "..\xmlwf\*.h"; DestDir: "{app}\Source\xmlwf"; Flags: ignoreversion; Components: Source
Source: "..\xmlwf\*.vcxproj"; DestDir: "{app}\Source\xmlwf"; Flags: ignoreversion; Components: Source
Source: "..\xmlwf\*.vcxproj.filters"; DestDir: "{app}\Source\xmlwf"; Flags: ignoreversion; Components: Source

[Dirs]
Name: "{app}\Documents"
Name: "{app}\Bin"
Name: "{app}\Source"

[Messages]
WelcomeLabel1=Welcome to the Expat XML Parser Setup Wizard
WelcomeLabel2=This will install [name/ver] on your computer.%n%nExpat is an XML parser with a C-language API, and is primarily made available to allow developers to build applications which use XML using a portable API and fast implementation.%n%nIt is strongly recommended that you close all other applications you have running before continuing. This will help prevent any conflicts during the installation process.
english.WelcomeLabel1=Welcome to the Expat XML Parser Setup Wizard
english.WelcomeLabel2=This will install [name/ver] on your computer.%n%nExpat is an XML parser with a C-language API, and is primarily made available to allow developers to build applications which use XML using a portable API and fast implementation.%n%nIt is strongly recommended that you close all other applications you have running before continuing. This will help prevent any conflicts during the installation process.
russian.WelcomeLabel1=Добро пожаловать в мастер установки парсера Expat XML
russian.WelcomeLabel2=Будет установлен [name / ver] на ваш компьютер.%n%nExpat - это синтаксический анализатор XML с API-интерфейсом на языке C, который в основном доступен для разработчиков, позволяющих создавать приложения, использующие XML, с использованием переносимого API и быстрой реализации.%n%n Настоятельно рекомендуется закрыть все другие приложения, которые вы запускаете, прежде чем продолжить. Это поможет предотвратить любые конфликты в процессе установки.

[Types]
Name: "full"; Description: "Full installation"
Name: "compact"; Description: "Compact installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "Binary"; Description: "Binary files"; Types: full custom compact; Check: IsWin64
Name: "Documets"; Description: "Documentation files"; Types: full custom
Name: "Source"; Description: "Source files with examples"; Types: full

[Registry]
Root: "HKCU"; Subkey: "Environment"; ValueType: string; ValueName: "EXPAT_LIBRARY"; ValueData: "{app}\Bin\expat.dll"; Flags: createvalueifdoesntexist uninsdeletevalue; Components: Binary
Root: "HKCU"; Subkey: "Environment"; ValueType: string; ValueName: "EXPAT_INCLUDE_DIR"; ValueData: "{app}\Source\lib"; Flags: createvalueifdoesntexist uninsdeletevalue; Components: Source
