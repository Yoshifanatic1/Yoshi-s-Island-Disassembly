@echo off

set PATH="../Global"
set Input1=
set asarVer=asar
set GAMDID="YI"
set ROMVer=
set ROMExt=.sfc
set HackCheck=""
set HackName=""

setlocal EnableDelayedExpansion

echo Enter the ROM version you want to assemble.
echo Valid options: "YI_U1" "YI_U2" "YI_E1" "YI_E2" "YI_J1" "YI_J2" "YI_J3"
echo For custom ROM versions, use "HACK_<HackName>, where <HackName> is the rest of the custom ROM Map file's name before the extension."

:Input
set /p Input1="%Input1%"
set HackCheck=%Input1:~0,5%
if "%Input1%" equ "" goto :Exit
if "%HackCheck%" equ "HACK_" goto :Hack
if "%Input1%" equ "" goto :Exit
if "%Input1%" equ "YI_U1" goto :USA1
if "%Input1%" equ "YI_U2" goto :USA2
if "%Input1%" equ "YI_E1" goto :PAL1
if "%Input1%" equ "YI_E2" goto :PAL2
if "%Input1%" equ "YI_J1" goto :Japan1
if "%Input1%" equ "YI_J2" goto :Japan2
if "%Input1%" equ "YI_J3" goto :Japan3

echo. "%Input1%" is not a valid ROM version.
set Input1=
goto :Input

:Hack
set ROMNAME=%Input1:~5,100%
set ROMVer=(Hack)
goto :Assemble

:USA1
set ROMVer=(U)
set ROMNAME=Super Mario World 2 - Yoshi's Island
goto :Assemble

:USA2
set ROMVer=(U) (Rev.1)
set ROMNAME=Super Mario World 2 - Yoshi's Island
goto :Assemble

:PAL1
set ROMVer=(E)
set ROMNAME=Super Mario World 2 - Yoshi's Island
goto :Assemble

:PAL2
set ROMVer=(E) (Rev.1)
set ROMNAME=Super Mario World 2 - Yoshi's Island
goto :Assemble

:Japan1
set ROMVer=(J)
set ROMNAME=Super Mario - Yoshi Island
goto :Assemble

:Japan2
set ROMVer=(J) (Rev.1)
set ROMNAME=Super Mario - Yoshi Island
goto :Assemble

:Japan3
set ROMVer=(U) (Rev.2)
set ROMNAME=Super Mario - Yoshi Island

:Assemble

set output="%ROMNAME% %ROMVer%%ROMExt%"

if exist %output% del %output%
echo Assembling "%ROMNAME% %ROMVer%%ROMExt%" ... this may take a minute.
echo.

%asarVer% --fix-checksum=on --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=0 ..\Global\AssembleFile.asm %output%

echo Assembling %ROMNAME% SPC700 engine...
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/Engine.asm" ..\Global\AssembleFile.asm SPC700\Engine.bin

echo Assembling %ROMNAME% Athletic sample bank
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/AthleticSampleBank.asm" ..\Global\AssembleFile.asm SPC700\AthleticSampleBank.bin

echo Assembling %ROMNAME% Ending sample bank
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/EndingSampleBank.asm" ..\Global\AssembleFile.asm SPC700\EndingSampleBank.bin

echo Assembling %ROMNAME% Cave and Fort Boss sample bank
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/CaveFortBossSampleBank.asm" ..\Global\AssembleFile.asm SPC700\CaveFortBossSampleBank.bin

echo Assembling %ROMNAME% Bonus, Castle Boss, and Grassland sample bank
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/BonusCastleBossGrasslandSampleBank.asm" ..\Global\AssembleFile.asm SPC700\BonusCastleBossGrasslandSampleBank.bin

echo Assembling %ROMNAME% Bowser sample bank
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/BowserSampleBank.asm" ..\Global\AssembleFile.asm SPC700\BowserSampleBank.bin

echo Assembling %ROMNAME% Intro, Map, Castle and Fort sample bank
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/IntroMapCastleFortSampleBank.asm" ..\Global\AssembleFile.asm SPC700\IntroMapCastleFortSampleBank.bin

echo Assembling %ROMNAME% Global sample bank
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=4 --define PathToFile="SPC700/GlobalSampleBank.asm" ..\Global\AssembleFile.asm SPC700\GlobalSampleBank.bin

echo Assembling %ROMNAME% SuperFX Code...
%asarVer% --no-title-check --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=5 --define PathToFile="SuperFX/SuperFXCode.asm" ..\Global\AssembleFile.asm SuperFX\SuperFXCode.bin

echo Assembling ROM...
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=1 ..\Global\AssembleFile.asm %output%

if exist ..\%GAMDID%\Temp.txt del ..\%GAMDID%\Temp.txt
%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=6 ..\Global\AssembleFile.asm Temp.txt
for /f "delims=" %%x in (Temp.txt) do set Firmware=%%x
if "%Firmware%" equ "NULL" goto :NoFirmware
if exist %Firmware% goto :NoFirmware
if exist ..\Firmware\%Firmware% goto :CopyFirmware
goto :NoFirmware

:CopyFirmware
echo Copied %Firmware% to the disassembly folder
copy ..\Firmware\%Firmware% %Firmware%
:NoFirmware
if exist ..\%GAMDID%\Temp.txt del ..\%GAMDID%\Temp.txt

%asarVer% --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=2 ..\Global\AssembleFile.asm %output%

%asarVer% --fix-checksum=off --define GameID="%GAMDID%" --define ROMID="%Input1%" --define FileType=3 ..\Global\AssembleFile.asm %output%

echo Cleaning up...
if exist ..\%GAMDID%\SPC700\Engine.bin del ..\%GAMDID%\SPC700\Engine.bin
if exist ..\%GAMDID%\SuperFX\SuperFXCode.bin del ..\%GAMDID%\SuperFX\SuperFXCode.bin
if exist ..\%GAMDID%\SPC700\AthleticSampleBank.bin del ..\%GAMDID%\SPC700\AthleticSampleBank.bin
if exist ..\%GAMDID%\SPC700\EndingSampleBank.bin del ..\%GAMDID%\SPC700\EndingSampleBank.bin
if exist ..\%GAMDID%\SPC700\CaveFortBossSampleBank.bin del ..\%GAMDID%\SPC700\CaveFortBossSampleBank.bin
if exist ..\%GAMDID%\SPC700\BonusCastleBossGrasslandSampleBank.bin del ..\%GAMDID%\SPC700\BonusCastleBossGrasslandSampleBank.bin
if exist ..\%GAMDID%\SPC700\BowserSampleBank.bin del ..\%GAMDID%\SPC700\BowserSampleBank.bin
if exist ..\%GAMDID%\SPC700\IntroMapCastleFortSampleBank.bin del ..\%GAMDID%\SPC700\IntroMapCastleFortSampleBank.bin
if exist ..\%GAMDID%\SPC700\GlobalSampleBank.bin del ..\%GAMDID%\SPC700\GlobalSampleBank.bin

echo.
echo Done^^!
echo.
echo Press Enter to re-assemble the chosen ROM.
goto :Input

:Exit
exit
