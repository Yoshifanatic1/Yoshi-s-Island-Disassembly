@echo off

set PATH="../../Global"
set Input1=
set ROMName=YI.sfc
set MemMap=lorom

setlocal EnableDelayedExpansion

echo To fully extract all files for supported ROMs, you'll need one of the following ROMs in each group:
echo - Uncompressed GFX: YI (USA)
echo - Compressed GFX: YI (USA)
echo - Samples: Any
echo - Music: Any
echo.

:Start
echo Place a headerless YI ROM named %ROMName% in this folder, then type the number representing what version %ROMName% is.
echo 0 = YI (USA)
echo 1 = YI (USA, Rev.1)
echo 2 = YI (PAL)
echo 3 = YI (PAL, Rev.1)
echo 4 = YI (Japan)
echo 5 = YI (Japan, Rev.1)
echo 6 = YI (Japan, Rev.2)

:Mode
set /p Input1=""
if exist %ROMName% goto :ROMExists

echo You need to place a YI ROM named %ROMName% in this folder before you can extract any assets^^!
goto :Mode

:ROMExists
if "%Input1%" equ "0" goto :USA1
if "%Input1%" equ "1" goto :USA2
if "%Input1%" equ "2" goto :PAL1
if "%Input1%" equ "3" goto :PAL2
if "%Input1%" equ "4" goto :Japan1
if "%Input1%" equ "5" goto :Japan2
if "%Input1%" equ "6" goto :Japan3

echo %Input1% is not a valid mode.
goto :Mode

:USA1
set UGFXLoc="../Graphics"
set CGFXLoc="../Graphics/Compressed"
set BitMapLoc="../Graphics/SuperFX"
set UnknownDatLoc="../UnsortedData"
set MusicLoc="../SPC700"
set TitleScreenBrrLoc="../SPC700/Samples/TitleScreen"
set AthleticBrrLoc="../SPC700/Samples/Athletic"
set EndingBrrLoc="../SPC700/Samples/Ending"
set CaveFortBossBrrLoc="../SPC700/Samples/CaveFortBoss"
set BonusCastleBossGrasslandBrrLoc="../SPC700/Samples/BonusCastleBossGrassland"
set BowserBrrLoc="../SPC700/Samples/Bowser"
set IntroMapCastleFortBrrLoc="../SPC700/Samples/IntroMapCastleFort"
set GlobalBrrLoc="../SPC700/Samples/Global"
set ROMBit=$0001
goto :BeginExtract

:USA2
echo The USA (Rev.1) ROM is not supported by the disassembly.
goto :Mode

set UGFXLoc="../Graphics"
set CGFXLoc="../Graphics/Compressed"
set BitMapLoc="../Graphics/SuperFX"
set UnknownDatLoc="../UnsortedData"
set MusicLoc="../SPC700"
set TitleScreenBrrLoc="../SPC700/Samples/TitleScreen"
set AthleticBrrLoc="../SPC700/Samples/Athletic"
set EndingBrrLoc="../SPC700/Samples/Ending"
set CaveFortBossBrrLoc="../SPC700/Samples/CaveFortBoss"
set BonusCastleBossGrasslandBrrLoc="../SPC700/Samples/BonusCastleBossGrassland"
set BowserBrrLoc="../SPC700/Samples/Bowser"
set IntroMapCastleFortBrrLoc="../SPC700/Samples/IntroMapCastleFort"
set GlobalBrrLoc="../SPC700/Samples/Global"
set ROMBit=$0002
goto :BeginExtract

:PAL1
echo The PAL ROM is not supported by the disassembly.
goto :Mode

set UGFXLoc="../Graphics"
set CGFXLoc="../Graphics/Compressed"
set BitMapLoc="../Graphics/SuperFX"
set UnknownDatLoc="../UnsortedData"
set MusicLoc="../SPC700"
set TitleScreenBrrLoc="../SPC700/Samples/TitleScreen"
set AthleticBrrLoc="../SPC700/Samples/Athletic"
set EndingBrrLoc="../SPC700/Samples/Ending"
set CaveFortBossBrrLoc="../SPC700/Samples/CaveFortBoss"
set BonusCastleBossGrasslandBrrLoc="../SPC700/Samples/BonusCastleBossGrassland"
set BowserBrrLoc="../SPC700/Samples/Bowser"
set IntroMapCastleFortBrrLoc="../SPC700/Samples/IntroMapCastleFort"
set GlobalBrrLoc="../SPC700/Samples/Global"
set ROMBit=$0004
goto :BeginExtract

:PAL2
echo The PAL (Rev.1) ROM is not supported by the disassembly.
goto :Mode

set UGFXLoc="../Graphics"
set CGFXLoc="../Graphics/Compressed"
set BitMapLoc="../Graphics/SuperFX"
set UnknownDatLoc="../UnsortedData"
set MusicLoc="../SPC700"
set TitleScreenBrrLoc="../SPC700/Samples/TitleScreen"
set AthleticBrrLoc="../SPC700/Samples/Athletic"
set EndingBrrLoc="../SPC700/Samples/Ending"
set CaveFortBossBrrLoc="../SPC700/Samples/CaveFortBoss"
set BonusCastleBossGrasslandBrrLoc="../SPC700/Samples/BonusCastleBossGrassland"
set BowserBrrLoc="../SPC700/Samples/Bowser"
set IntroMapCastleFortBrrLoc="../SPC700/Samples/IntroMapCastleFort"
set GlobalBrrLoc="../SPC700/Samples/Global"
set ROMBit=$0008
goto :BeginExtract

:Japan1
echo The Japan ROM is not supported by the disassembly.
goto :Mode

set UGFXLoc="../Graphics"
set CGFXLoc="../Graphics/Compressed"
set BitMapLoc="../Graphics/SuperFX"
set UnknownDatLoc="../UnsortedData"
set MusicLoc="../SPC700"
set TitleScreenBrrLoc="../SPC700/Samples/TitleScreen"
set AthleticBrrLoc="../SPC700/Samples/Athletic"
set EndingBrrLoc="../SPC700/Samples/Ending"
set CaveFortBossBrrLoc="../SPC700/Samples/CaveFortBoss"
set BonusCastleBossGrasslandBrrLoc="../SPC700/Samples/BonusCastleBossGrassland"
set BowserBrrLoc="../SPC700/Samples/Bowser"
set IntroMapCastleFortBrrLoc="../SPC700/Samples/IntroMapCastleFort"
set GlobalBrrLoc="../SPC700/Samples/Global"
set ROMBit=$0010
goto :BeginExtract

:Japan2
echo The Japan (Rev.1) ROM is not supported by the disassembly.
goto :Mode

set UGFXLoc="../Graphics"
set CGFXLoc="../Graphics/Compressed"
set BitMapLoc="../Graphics/SuperFX"
set UnknownDatLoc="../UnsortedData"
set MusicLoc="../SPC700"
set TitleScreenBrrLoc="../SPC700/Samples/TitleScreen"
set AthleticBrrLoc="../SPC700/Samples/Athletic"
set EndingBrrLoc="../SPC700/Samples/Ending"
set CaveFortBossBrrLoc="../SPC700/Samples/CaveFortBoss"
set BonusCastleBossGrasslandBrrLoc="../SPC700/Samples/BonusCastleBossGrassland"
set BowserBrrLoc="../SPC700/Samples/Bowser"
set IntroMapCastleFortBrrLoc="../SPC700/Samples/IntroMapCastleFort"
set GlobalBrrLoc="../SPC700/Samples/Global"
set ROMBit=$0020
goto :BeginExtract

:Japan3
echo The Japan (Rev.2) ROM is not supported by the disassembly.
goto :Mode

set UGFXLoc="../Graphics"
set CGFXLoc="../Graphics/Compressed"
set BitMapLoc="../Graphics/SuperFX"
set UnknownDatLoc="../UnsortedData"
set MusicLoc="../SPC700"
set TitleScreenBrrLoc="../SPC700/Samples/TitleScreen"
set AthleticBrrLoc="../SPC700/Samples/Athletic"
set EndingBrrLoc="../SPC700/Samples/Ending"
set CaveFortBossBrrLoc="../SPC700/Samples/CaveFortBoss"
set BonusCastleBossGrasslandBrrLoc="../SPC700/Samples/BonusCastleBossGrassland"
set BowserBrrLoc="../SPC700/Samples/Bowser"
set IntroMapCastleFortBrrLoc="../SPC700/Samples/IntroMapCastleFort"
set GlobalBrrLoc="../SPC700/Samples/Global"
set ROMBit=$0040
goto :BeginExtract

:BeginExtract
set i=0
set PointerSet=0

echo Generating temporary ROM
asar --fix-checksum=off --no-title-check --define ROMVer="%ROMBit%" "AssetPointersAndFiles.asm" TEMP.sfc

CALL :GetLoopIndex
set MaxFileTypes=%Length%
set PointerSet=6

:GetNewLoopIndex
CALL :GetLoopIndex

:ExtractLoop
if %i% equ %Length% goto :NewFileType

CALL :GetGFXFileName
CALL :ExtractFile
set /a i = %i%+1
if exist TEMP1.asm del TEMP1.asm
if exist TEMP2.asm del TEMP2.asm
if exist TEMP3.txt del TEMP3.txt
goto :ExtractLoop

:NewFileType
echo Moving extracted files to appropriate locations
if %PointerSet% equ 6 goto :MoveUGFX
if %PointerSet% equ 12 goto :MoveCGFX
if %PointerSet% equ 18 goto :MoveBitMaps
if %PointerSet% equ 24 goto :MoveUnknownDat
if %PointerSet% equ 30 goto :MoveMusic
if %PointerSet% equ 36 goto :MoveTitleScreenBRR
if %PointerSet% equ 42 goto :MoveAthleticBRR
if %PointerSet% equ 48 goto :MoveEndingBRR
if %PointerSet% equ 54 goto :MoveCaveFortBossBRR
if %PointerSet% equ 60 goto :MoveBonusCastleBossGrasslandBRR
if %PointerSet% equ 66 goto :MoveBowserBRR
if %PointerSet% equ 72 goto :MoveIntroMapCastleFortBRR
if %PointerSet% equ 78 goto :MoveGlobalBRR
goto :MoveNothing

:MoveUGFX
move "*.bin" %UGFXLoc%
goto :MoveNothing

:MoveCGFX
move "*.bin" %CGFXLoc%
goto :MoveNothing

:MoveBitMaps
move "*.bin" %BitMapLoc%
goto :MoveNothing

:MoveUnknownDat
move "*.bin" %UnknownDatLoc%
goto :MoveNothing

:MoveMusic
move "*.bin" %MusicLoc%
goto :MoveNothing

:MoveTitleScreenBRR
move "*.brr" %TitleScreenBrrLoc%
goto :MoveNothing

:MoveAthleticBRR
move "*.brr" %AthleticBrrLoc%
goto :MoveNothing

:MoveEndingBRR
move "*.brr" %EndingBrrLoc%
goto :MoveNothing

:MoveCaveFortBossBRR
move "*.brr" %CaveFortBossBrrLoc%
goto :MoveNothing

:MoveBonusCastleBossGrasslandBRR
move "*.brr" %BonusCastleBossGrasslandBrrLoc%
goto :MoveNothing

:MoveBowserBRR
move "*.brr" %BowserBrrLoc%
goto :MoveNothing

:MoveIntroMapCastleFortBRR
move "*.brr" %IntroMapCastleFortBrrLoc%
goto :MoveNothing

:MoveGlobalBRR
move "*.brr" %GlobalBrrLoc%
goto :MoveNothing

:MoveNothing
set i=0
set /a PointerSet = %PointerSet%+6
if %PointerSet% neq %MaxFileTypes% goto :GetNewLoopIndex
if exist TEMP.sfc del TEMP.sfc

echo Done^^!
goto :Start

EXIT /B %ERRORLEVEL% 

:ExtractFile
echo:%MemMap% >> TEMP1.asm
echo:org $008000 >> TEMP1.asm
echo:check bankcross off >> TEMP1.asm
echo:^^!OffsetStart #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$00+(%i%*$0C)))) >> TEMP1.asm
echo:^^!OffsetEnd #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$03+(%i%*$0C)))) >> TEMP1.asm
echo:incbin %ROMName%:(^^!OffsetStart)-(^^!OffsetEnd) >> TEMP1.asm

echo Extracting %FileName%
asar --fix-checksum=off --no-title-check "TEMP1.asm" %FileName%
EXIT /B 0

:GetGFXFileName
echo:%MemMap% >> TEMP2.asm
echo:org $008000 >> TEMP2.asm
echo:^^!FileNameStart #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$06+(%i%*$0C)))) >> TEMP2.asm
echo:^^!FileNameEnd #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$09+(%i%*$0C)))) >> TEMP2.asm
echo:incbin TEMP.sfc:(^^!FileNameStart)-(^^!FileNameEnd) >> TEMP2.asm
asar --fix-checksum=off --no-title-check "TEMP2.asm" TEMP3.txt

for /f "delims=" %%x in (TEMP3.txt) do set FileName=%%x

EXIT /B 0

:GetLoopIndex
echo:%MemMap% >> TEMP4.asm
echo:org $008000 >> TEMP4.asm
echo:^^!OnesDigit = 0 >> TEMP4.asm
echo:^^!TensDigit = 0 >> TEMP4.asm
echo:^^!HundredsDigit = 0 >> TEMP4.asm
echo:^^!ThousandsDigit = 0 >> TEMP4.asm
echo:^^!TensDigitSet = 0 >> TEMP4.asm
echo:^^!HundredsDigitSet = 0 >> TEMP4.asm
echo:^^!ThousandsDigitSet = 0 >> TEMP4.asm
echo:^^!Offset #= readfile3("TEMP.sfc", snestopc($008000+%PointerSet%+$03)) >> TEMP4.asm
echo:while ^^!Offset ^> 0 >> TEMP4.asm
::echo:print hex(^^!Offset) >> TEMP4.asm
echo:^^!OnesDigit #= ^^!OnesDigit+1 >> TEMP4.asm
echo:if ^^!OnesDigit == 10 >> TEMP4.asm
echo:^^!OnesDigit #= 0 >> TEMP4.asm
echo:^^!TensDigit #= ^^!TensDigit+1 >> TEMP4.asm
echo:^^!TensDigitSet #= 1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!TensDigit == 10 >> TEMP4.asm
echo:^^!TensDigit #= 0 >> TEMP4.asm
echo:^^!HundredsDigit #= ^^!HundredsDigit+1 >> TEMP4.asm
echo:^^!HundredsDigitSet #= 1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!HundredsDigit == 10 >> TEMP4.asm
echo:^^!HundredsDigit #= 0 >> TEMP4.asm
echo:^^!ThousandsDigit #= ^^!ThousandsDigit+1 >> TEMP4.asm
echo:^^!ThousandsDigitSet #= 1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:^^!Offset #= ^^!Offset-1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!ThousandsDigitSet == 1 >> TEMP4.asm
echo:db ^^!ThousandsDigit+$30 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!HundredsDigitSet == 1 >> TEMP4.asm
echo:db ^^!HundredsDigit+$30 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!TensDigitSet == 1 >> TEMP4.asm
echo:db ^^!TensDigit+$30 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:db ^^!OnesDigit+$30 >> TEMP4.asm
asar --fix-checksum=off --no-title-check "TEMP4.asm" TEMP5.txt

for /f "delims=" %%x in (TEMP5.txt) do set Length=%%x

if exist TEMP4.asm del TEMP4.asm
if exist TEMP5.txt del TEMP5.txt

EXIT /B 0
