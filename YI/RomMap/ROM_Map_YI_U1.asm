
macro YI_GameSpecificAssemblySettings()
	!ROM_YI_U1 = $0001							;\ These defines assign each ROM version with a different bit so version difference checks will work. Do not touch them!
	!ROM_YI_U2 = $0002							;|
	!ROM_YI_E1 = $0004							;|
	!ROM_YI_E2 = $0008							;|
	!ROM_YI_J1 = $0010							;|
	!ROM_YI_J2 = $0020							;|
	!ROM_YI_J3 = $0040							;/

!Define_YI_Global_EnableDebugFeatures = !FALSE

	%SetROMToAssembleForHack(YI_U1, !ROMID)
endmacro

macro YI_LoadGameSpecificMainSNESFiles()
	incsrc ../SuperFX/SuperFXPtrs_YI.asm
	incsrc ../Misc_Defines_YI.asm
	incsrc ../RAM_Map_YI.asm
	incsrc ../Routine_Macros_YI.asm
	incsrc ../SNES_Macros_YI.asm
	%LoadExtraRAMFile("ExRAM_Map_YI.asm", !GameID, YI)
endmacro

macro YI_LoadGameSpecificMainSPC700Files()
	incsrc ../SPC700/ARAM_Map_YI.asm
	incsrc ../Misc_Defines_YI.asm
	incsrc ../SPC700/SPC700_Macros_YI.asm
endmacro

macro YI_LoadGameSpecificMainExtraHardwareFiles()
	incsrc ../RAM_Map_YI.asm
	incsrc ../Misc_Defines_YI.asm
	incsrc ../SuperFX/SuperFX_Macros_YI.asm
	%LoadExtraRAMFile("ExRAM_Map_YI.asm", !GameID, YI)
endmacro

macro YI_LoadGameSpecificMSU1Files()
endmacro

macro YI_GlobalAssemblySettings()
	!Define_Global_ApplyAsarPatches = !FALSE
	!Define_Global_InsertRATSTags = !TRUE
	!Define_Global_IgnoreCodeAlignments = !FALSE
	!Define_Global_IgnoreOriginalFreespace = !FALSE
	!Define_Global_CompatibleControllers = !Controller_StandardJoypad
	!Define_Global_DisableROMMirroring = !FALSE
	!Define_Global_CartridgeHeaderVersion = $02
	!Define_Global_FixIncorrectChecksumHack = !FALSE
	!Define_Global_ROMFrameworkVer = 1
	!Define_Global_ROMFrameworkSubVer = 1
	!Define_Global_ROMFrameworkSubSubVer = 0
	!Define_Global_AsarChecksum = $0000
	!Define_Global_LicenseeName = "Nintendo"
	!Define_Global_DeveloperName = "Nintendo EAD"
	!Define_Global_ReleaseDate = "October 1995"
	!Define_Global_BaseROMMD5Hash = "cb472164c5a71ccd3739963390ec6a50"

	!Define_Global_MakerCode = "01"
	!Define_Global_GameCode = "YI  "
	!Define_Global_ReservedSpace = $00,$00,$00,$00,$00,$00
	!Define_Global_ExpansionFlashSize = !ExpansionMemorySize_0KB
	!Define_Global_ExpansionRAMSize = !ExpansionMemorySize_32KB
	!Define_Global_IsSpecialVersion = $00
	!Define_Global_InternalName = "YOSHI'S ISLAND        "
	!Define_Global_ROMLayout = !ROMLayout_SuperFXROM
	!Define_Global_ROMType = !ROMType_ROM_RAM_SRAM_Chip
	!Define_Global_CustomChip = !Chip_SuperFX2
	!Define_Global_ROMSize1 = !ROMSize_2MB
	!Define_Global_ROMSize2 = !ROMSize_0KB
	!Define_Global_SRAMSize = !SRAMSize_0KB
	!Define_Global_Region = !Region_NorthAmerica
	!Define_Global_LicenseeID = $01
	!Define_Global_VersionNumber = $00
	!Define_Global_ChecksumCompliment = !Define_Global_Checksum^$FFFF
	!Define_Global_Checksum = $132C
	!UnusedNativeModeVector1 = CODE_00814F
	!UnusedNativeModeVector2 = CODE_00814F
	!NativeModeCOPVector = CODE_00814F
	!NativeModeBRKVector = CODE_00814F
	!NativeModeAbortVector = CODE_00814F
	!NativeModeNMIVector = $0108
	!NativeModeResetVector = CODE_00814F
	!NativeModeIRQVector = $010C
	!UnusedEmulationModeVector1 = CODE_00814F
	!UnusedEmulationModeVector2 = CODE_00814F
	!EmulationModeCOPVector = CODE_00814F
	!EmulationModeBRKVector = CODE_00814F
	!EmulationModeAbortVector = CODE_00814F
	!EmulationModeNMIVector = CODE_00814F
	!EmulationModeResetVector = CODE_008000
	!EmulationModeIRQVector = CODE_00814F
endmacro

macro YI_LoadROMMap()
	%YIBank00Macros(!BANK_00, !BANK_00)
	%YIBank01Macros(!BANK_01, !BANK_01)
	%YIBank02Macros(!BANK_02, !BANK_02)
	%YIBank03Macros(!BANK_03, !BANK_03)
	%YIBank04Macros(!BANK_04, !BANK_04)
	%YIBank05Macros(!BANK_05, !BANK_05)
	%YIBank06Macros(!BANK_06, !BANK_06)
	%YIBank07Macros(!BANK_07, !BANK_07)
	%YIBank08Macros(!BANK_08, !BANK_08)
	%YIBank09Macros(!BANK_09, !BANK_09)
	%YIBank0AMacros(!BANK_0A, !BANK_0A)
	%YIBank0BMacros(!BANK_0B, !BANK_0B)
	%YIBank0CMacros(!BANK_0C, !BANK_0C)
	%YIBank0DMacros(!BANK_0D, !BANK_0D)
	%YIBank0EMacros(!BANK_0E, !BANK_0E)
	%YIBank0FMacros(!BANK_0F, !BANK_0F)
	%YIBank10Macros(!BANK_10, !BANK_10)
	%YIBank11Macros(!BANK_11, !BANK_11)
	%YIBank12Macros(!BANK_12, !BANK_12)
	%YIBank13Macros(!BANK_13, !BANK_13)
	%YIBank14Macros(!BANK_14, !BANK_14)
	%YIBank15Macros(!BANK_15, !BANK_15)
	%YIBank16Macros(!BANK_16, !BANK_16)
	%YIBank17Macros(!BANK_17, !BANK_17)
	%YIBank4CMacros(!BANK_18, !BANK_19)
	%YIBank4DMacros(!BANK_1A, !BANK_1B)
	%YIBank4EMacros(!BANK_1C, !BANK_1D)
	%YIBank4FMacros(!BANK_1E, !BANK_1F)
	%YIBank50Macros(!BANK_20, !BANK_21)
	%YIBank51Macros(!BANK_22, !BANK_23)
	%YIBank52Macros(!BANK_24, !BANK_25)
	%YIBank53Macros(!BANK_26, !BANK_27)
	%YIBank54Macros(!BANK_28, !BANK_29)
	%YIBank55Macros(!BANK_2A, !BANK_2B)
	%YIBank56Macros(!BANK_2C, !BANK_2D)
	%YIBank57Macros(!BANK_2E, !BANK_3F)
endmacro
