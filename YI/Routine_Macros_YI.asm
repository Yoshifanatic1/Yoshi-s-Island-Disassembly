
;#############################################################################################################
;#############################################################################################################

macro YIBank00Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

CODE_008000:
	SEI
	REP.b #$09
	XCE
	SEP.b #$30
	LDA.b #$00
	PHA
	PLB
	PHA
	PHA
	PLD
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_JoypadSerialPort1
	LDA.b #$8F
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.b #!SuperFX_BackupRAMRegister_EnableBRAMWrite
	STA.w !REGISTER_SuperFX_BackupRAMRegister
	STZ.w !REGISTER_MosaicSizeAndBGEnable
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	LDA.b #$FF
	STA.w !REGISTER_ProgrammableIOPortOutput
	STZ.w !REGISTER_HCountTimerLo
	STZ.w !REGISTER_HCountTimerHi
	STZ.w !REGISTER_VCountTimerLo
	STZ.w !REGISTER_VCountTimerHi
	STZ.w !REGISTER_DMAEnable
	STZ.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_EnableFastROM
	REP.b #$20
	LDA.w #$8000
	STA.w !REGISTER_OAMAddressLo
	LDA.w #$01FF
	TCS
	SEP.b #$20
	JSL.l CODE_0082D0
	LDX.b #$10
	JSL.l CODE_008543
	REP.b #$20
	LDX.b #$0F
CODE_008062:
	LDA.w DATA_00813F,x
	STA.w $0100,x
	DEX
	DEX
	BPL.b CODE_008062
	LDA.w #$7EC000
	STA.b $20
	LDY.b #$7EC000>>16
	STY.b $22
	LDA.w #CODE_00C000&$00FFFF
	STA.b $23
	LDY.b #(CODE_00C000&$00FFFF)>>16
	STY.b $25
	LDA.w #$4000
	JSL.l CODE_008288
	SEP.b #$20
	REP.b #$10
	LDX.w #$0046
CODE_00808C:
	STZ.w $0118,x
	DEX
	BPL.b CODE_00808C
	SEP.b #$10
	LDA.b #!SuperFX_ClockSelect_20MHz
	STA.w !REGISTER_SuperFX_ClockSelect
	LDA.b #!SuperFX_ConfigRegister_HighSpeedFlag|!SuperFX_ConfigRegister_MaskedIRQ
	STA.w !REGISTER_SuperFX_ConfigRegister
	LDA.b #$16
	STA.w $012D
	LDA.b #!SuperFX_ScreenMode_ScreenHeight_160pixels|!SuperFX_ScreenMode_ColorMode_16Colors|!SuperFX_ScreenMode_SuperFXHasWRAMAccess|!SuperFX_ScreenMode_SuperFXHasROMAccess|!SuperFX_ScreenMode_ColorMode_Unused
	STA.w $012E
	REP.b #$20
	STZ.w $012B
	STZ.w $0216
	LDX.b #FXCODE_08A97B>>16
	LDA.w #FXCODE_08A97B
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	SEP.b #$20
	LDA.l $707E7D
	BNE.b CODE_0080C9
	LDA.l $707E7C
	CMP.b #$03
	BCC.b CODE_0080F0
CODE_0080C9:
	REP.b #$20
	LDA.w #$0000
	STA.l $707E7C
	STA.l $707E70
	STA.l $707E72
	STA.l $707E74
	STA.l $707E76
	STA.l $707E78
	STA.l $707E7A
	JSL.l CODE_108000
	SEP.b #$20
CODE_0080F0:
	CLI
CODE_0080F1:
	LDA.w $011B
	BMI.b CODE_0080F1
	BRA.b CODE_008130

CODE_0080F8:
	LDA.w $0943
	AND.b #$10
	BEQ.b CODE_008107
	LDA.w $012F
	EOR.b #$01
	STA.w $012F
CODE_008107:
	LDA.w $012F
	BEQ.b CODE_008130
	LDY.b #$20
	LDA.w $0942
	AND.b #$10
	BNE.b CODE_00812D
	LDA.w $0940
	AND.b #$30
	BNE.b CODE_008121
	STZ.w $0130
	BRA.b CODE_00813A

CODE_008121:
	LDA.w $0130
	BEQ.b CODE_00812B
	DEC.w $0130
	BRA.b CODE_00813A

CODE_00812B:
	LDY.b #$04
CODE_00812D:
	STY.w $0130
CODE_008130:
	REP.b #$20
	INC.b $30
	SEP.b #$20
	JSL.l CODE_008150
CODE_00813A:
	DEC.w $011B
	BRA.b CODE_0080F1

DATA_00813F:
base $7E0100
CODE_7E0100:
	RTI
	NOP #3

CODE_7E0104:
	RTI
	NOP #3

CODE_7E0108:
	JML.l CODE_00C000

CODE_7E010C:
	JML.l CODE_00C3E8
	RTI
base off

;---------------------------------------------------------------------------

CODE_008150:
	LDA.w $0118
	ASL
	ADC.w $0118
	TAX
	PHB
	LDA.w DATA_00816A+$02,x
	PHA
	PHA
	PLB
	LDA.l DATA_00816A+$01,x
	PHA
	LDA.l DATA_00816A,x
	PHA
	RTL

DATA_00816A:
	dl CODE_10838B-$01
	dl CODE_10891E-$01
	dl CODE_0083F0-$01
	dl CODE_1083E7-$01
	dl CODE_0083CD-$01
	dl CODE_0FBDBE-$01
	dl CODE_0083CD-$01
	dl CODE_0FBEBA-$01
	dl CODE_0083F0-$01
	dl CODE_1780D6-$01
	dl CODE_1787D5-$01
	dl CODE_0083CD-$01
	dl CODE_01AF90-$01
	dl CODE_01B4E1-$01
	dl CODE_108D4C-$01
	dl CODE_01C0D9-$01
	dl CODE_01B580-$01
	dl CODE_108E86-$01
	dl CODE_0083CD-$01
	dl CODE_0FBB7A-$01
	dl CODE_0083CD-$01
	dl CODE_0FBC66-$01
	dl CODE_0083FC-$01
	dl CODE_10E1C1-$01
	dl CODE_1780D6-$01
	dl CODE_1787D5-$01
	dl CODE_0083CD-$01
	dl CODE_10E1DA-$01
	dl CODE_10E357-$01
	dl CODE_10E3CB-$01
	dl CODE_0083A8-$01
	dl CODE_0083F0-$01
	dl CODE_17A58E-$01
	dl CODE_0083CD-$01
	dl CODE_17B3CD-$01
	dl CODE_0083CD-$01
	dl CODE_17B363-$01
	dl CODE_0083CD-$01
	dl CODE_17AA1A-$01
	dl CODE_0083CD-$01
	dl CODE_17A932-$01
	dl CODE_0083F0-$01
	dl CODE_109AE8-$01
	dl CODE_0083CD-$01
	dl CODE_10A13B-$01
	dl CODE_0083CD-$01
	dl CODE_118000-$01
	dl CODE_0083CD-$01
	dl CODE_1181D9-$01
	dl CODE_01E26D-$01
	dl CODE_0083CD-$01
	dl CODE_01E52D-$01
	dl CODE_0083CD-$01
	dl CODE_01E5E9-$01
	dl CODE_01E6F0-$01
	dl CODE_0083F0-$01
	dl CODE_10DA33-$01
	dl CODE_10DCAD-$01
	dl CODE_0083CD-$01
	dl CODE_01E6A2-$01
	dl CODE_0083CD-$01
	dl CODE_01E6B9-$01
	dl CODE_01E6F0-$01
	dl CODE_10DE3F-$01
	dl CODE_10DF53-$01
	dl CODE_0083CD-$01
	dl CODE_108A9A-$01
	dl CODE_0083CD-$01
	dl CODE_1088FB-$01

;---------------------------------------------------------------------------

CODE_008239:
	STZ.w !REGISTER_IRQNMIAndJoypadEnableFlags
	STZ.w !REGISTER_HDMAEnable
	LDA.b #$8F
	STA.w !REGISTER_ScreenDisplayRegister
	RTL

;---------------------------------------------------------------------------

CODE_008245:
	LDA.b #$81
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	RTL

;---------------------------------------------------------------------------

CODE_00824B:
	REP.b #$20
	LDX.b #FXCODE_08BD16>>16
	LDA.w #FXCODE_08BD16
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	SEP.b #$20
	RTL

;---------------------------------------------------------------------------

CODE_008259:
	REP.b #$20
	LDX.b #FXCODE_08B1D8>>16
	LDA.w #FXCODE_08B1D8
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	SEP.b #$20
	RTL

;---------------------------------------------------------------------------

CODE_008267:
	REP.b #$20
	LDX.b #FXCODE_08B289>>16
	LDA.w #FXCODE_08B289
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	SEP.b #$20
	RTL

;---------------------------------------------------------------------------

DATA_008275:
	dw $FFFF

CODE_008277:
	LDA.b #$03
CODE_008279:
	STA.w $0127
	JSL.l CODE_008239
	JSL.l CODE_00824B
	JML.l CODE_00E37B&$00FFFF

;---------------------------------------------------------------------------

CODE_008288:
	STA.w DMA[$00].SizeLo
	LDA.b $20
	STA.w !REGISTER_WRAMAddressLo
	LDY.b $22
	STY.w !REGISTER_WRAMAddressBank
	LDA.w #(!REGISTER_ReadOrWriteToWRAMPort&$0000FF<<8)+$00
	STA.w DMA[$00].Parameters
	LDA.b $23
	STA.w DMA[$00].SourceLo
	LDY.b $25
	STY.w DMA[$00].SourceBank
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	RTL

;---------------------------------------------------------------------------

CODE_0082AB:
	STA.w DMA[$00].SizeLo
	STY.w !REGISTER_Mode7MatrixParameterA
	LDX.b #$00
	STX.w !REGISTER_Mode7MatrixParameterA
	INX
	STX.w !REGISTER_Mode7MatrixParameterB
	LDA.w #(!REGISTER_PPUMultiplicationProductLo&$0000FF<<8)+$80
	STA.w DMA[$00].Parameters
	LDA.b $20
	STA.w DMA[$00].SourceLo
	LDX.b $22
	STX.w DMA[$00].SourceBank
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	RTL

;---------------------------------------------------------------------------

CODE_0082D0:
	JSL.l CODE_008239
	REP.b #$20
	LDY.b #$00
	STZ.b $20
	STZ.b $22
	LDA.w #$0100
	JSL.l CODE_0082AB
	LDA.w #$7E0200
	STA.b $20
	LDX.b #$7E0200>>16
	STX.b $22
	LDA.w #$BE00
	JSL.l CODE_0082AB
	STZ.b $20
	LDX.b #$7F0000>>16
	STX.b $22
	LDA.w #$0000
	JSL.l CODE_0082AB
	LDX.b #$700000>>16
	STX.b $22
	LDA.w #$7C00
	JSL.l CODE_0082AB
	LDA.w #$FFFF
	STA.l $7E4002
	LDA.w #$4802
	STA.l $7E4800
	SEP.b #$20
	RTL

;---------------------------------------------------------------------------

CODE_00831C:
	REP.b #$20
	LDY.b #$00
	STZ.b $21
	LDA.w #$0035
	STA.b $20
	LDA.w #$00CB
	JSL.l CODE_0082AB
	LDA.w #$093C
	STA.b $20
	LDA.w #$087A
	JSL.l CODE_0082AB
	LDA.w #$6092
	STA.b $20
	LDA.w #$0166
	JSL.l CODE_0082AB
	LDA.w #$7E08
	STA.b $20
	LDA.w #$01E8
	JSL.l CODE_0082AB
	LDA.w #$2604
	STA.b $20
	LDX.b #$70
	STX.b $22
	LDA.w #$51FC
	JSL.l CODE_0082AB
	SEP.b #$20
	RTL

;---------------------------------------------------------------------------

CODE_008365:
	STY.b $03
	PLY
	STY.b $00
	REP.b #$30
	AND.w #$00FF
	ASL
	TAY
	PLA
	STA.b $01
	INY
	LDA.b [$00],y
	STA.b $00
	SEP.b #$30
	LDY.b $03
	JMP.w [$0000]

;---------------------------------------------------------------------------

CODE_008380:
	STY.b $05
	PLY
	STY.b $02
	REP.b #$30
	AND.w #$00FF
	STA.b $03
	ASL
	ADC.b $03
	TAY
	PLA
	STA.b $03
	INY
	LDA.b [$02],y
	STA.b $00
	INY
	LDA.b [$02],y
	STA.b $01
	XBA
	SEP.b #$30
	PHB
	PHA
	PLB
	LDY.b $05
	JMP.w [$0000]

;---------------------------------------------------------------------------

CODE_0083A8:
	LDX.w $0201
	LDA.w $0200
	AND.b #$0F
	CMP.w DATA_0083C6,x
	BNE.b CODE_0083E7
	TXA
	EOR.b #$01
	AND.b #$01
	STA.w $0201
	LDA.b #$20
	STA.w $0118
	BRA.b CODE_0083EE

DATA_0083C4:
	db $01,$FF

DATA_0083C6:
	db $0F,$00

CODE_0083C8:
	PHB
	LDA.b #$00
	PHA
	PLB
CODE_0083CD:
	LDX.w $0201
	LDA.w $0200
	AND.b #$0F
	CMP.w DATA_0083C6,x
	BNE.b CODE_0083E7
	TXA
	EOR.b #$01
	AND.b #$01
	STA.w $0201
	INC.w $0118
	BRA.b CODE_0083EE

CODE_0083E7:
	CLC
	ADC.w DATA_0083C4,x
	STA.w $0200
CODE_0083EE:
	PLB
	RTL

CODE_0083F0:
	DEC.w $0202
	BPL.b CODE_0083EE
	LDA.b #$02
	STA.w $0202
	BRA.b CODE_0083CD

CODE_0083FC:
	DEC.w $0202
	BPL.b CODE_0083EE
	LDA.b #$08
	STA.w $0202
	BRA.b CODE_0083CD

;---------------------------------------------------------------------------

CODE_008408:
	PHP
	SEP.b #$20
	LDA.w !REGISTER_SoftwareLatchForHVCounter
	LDA.w !REGISTER_PPUStatusFlag2
	REP.b #$20
	LDA.w !REGISTER_HCounter
	CLC
	ADC.w $7970
	STA.w $7970
	PLP
	RTL

;---------------------------------------------------------------------------

CODE_00841F:
	PHP
	REP.b #$30
	LDY.w #$0000
	LDA.w #$BBAA
CODE_008428:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008428
	SEP.b #$20
	LDA.b #$CC
	BRA.b CODE_008459

CODE_008433:
	LDA.b [$00],y
	INY
	XBA
	LDA.b #$00
	BRA.b CODE_008446

CODE_00843B:
	XBA
	LDA.b [$00],y
	INY
	XBA
CODE_008440:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008440
	INC
CODE_008446:
	REP.b #$20
	STA.w !REGISTER_APUPort0
	SEP.b #$20
	DEX
	BNE.b CODE_00843B
CODE_008450:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008450
CODE_008455:
	ADC.b #$03
	BEQ.b CODE_008455
CODE_008459:
	PHA
	REP.b #$20
	LDA.b [$00],y
	BNE.b CODE_00847C
	DEC.w $000C
	BMI.b CODE_00847C
	LDA.w $000C
	ASL
	ADC.w $000C
	TAY
	LDA.w $0003,y
	STA.b $00
	LDA.w $0004,y
	STA.b $01
	LDY.w #$0000
	LDA.b [$00],y
CODE_00847C:
	INY
	INY
	TAX
	LDA.b [$00],y
	INY
	INY
	STA.w !REGISTER_APUPort2
	SEP.b #$20
	CPX.w #$0001
	LDA.b #$00
	ROL
	STA.w !REGISTER_APUPort1
	ADC.b #$7F
	PLA
	STA.w !REGISTER_APUPort0
CODE_008497:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_008497
	BVS.b CODE_008433
	STZ.w !REGISTER_APUPort0
	STZ.w !REGISTER_APUPort1
	STZ.w !REGISTER_APUPort2
	STZ.w !REGISTER_APUPort3
	PLP
	RTS

DATA_0084AC:
	dl DATA_4E0000
	dl DATA_4E169C
	dl DATA_4E23BF
	dl DATA_4E2C39
	dl DATA_4E38D2
	dl DATA_4ED0FE
	dl DATA_4ED5D0
	dl DATA_4EE279
	dl DATA_4EEC85
	dl DATA_4F4122
	dl DATA_4F5C48
	dl DATA_4F6E5A
	dl DATA_4F82E6
	dl DATA_4FFCB2
	dl YI_SPCEngine
	dl DATA_4F33F0
	dl DATA_4EFEC1
	dl DATA_4F205D
	dl DATA_4E3E90
	dl DATA_4EBBEC

DATA_0084E8:
	db $2B,$FF,$FF,$FF,$25,$22,$2E,$FF,$25,$22,$1C,$FF,$25,$19,$13,$FF
	db $25,$16,$10,$FF,$25,$16,$0D,$FF,$25,$22,$28,$FF,$25,$16,$0A,$FF
	db $25,$19,$07,$FF,$25,$19,$1F,$FF,$25,$01,$04,$FF,$31,$34,$FF,$FF
	db $37,$3A,$FF,$FF

DATA_00851C:
	db $00,$00,$00,$01,$00,$01,$00,$01,$01,$01,$00,$00,$01,$00,$00,$00
	db $FF,$00

DATA_00852E:
	db $FF,$0C,$10,$18,$1C,$14,$1C,$20,$24,$24,$24,$28,$28,$2C,$1C,$00
	db $00,$00,$04,$08,$30

CODE_008543:
	STX.w $014E
CODE_008546:
	LDX.w $014E
	LDA.l DATA_00851C,x
	BMI.b CODE_008552
	STA.w $0B48
CODE_008552:
	INX
	CPX.w $0203
	BNE.b CODE_008559
	RTL

CODE_008559:
	STX.w $0203
	STZ.w $0205
	LDA.l DATA_00852E,x
	TAX
	STZ.b $0C
	STZ.b $0D
	STZ.b $0E
	LDY.b #$00
CODE_00856C:
	LDA.l DATA_0084E8,x
	CMP.w $0207,y
	BEQ.b CODE_00859F
	STA.w $0207,y
	CMP.b #$FF
	BEQ.b CODE_00859F
	INC.b $0C
	PHX
	PHY
	TAX
	LDY.b $0E
	LDA.l DATA_0084AC-$01,x
	STA.w $0000,y
	LDA.l DATA_0084AC,x
	STA.w $0001,y
	LDA.l DATA_0084AC+$01,x
	STA.w $0002,y
	INY
	INY
	INY
	STY.b $0E
	PLY
	PLX
CODE_00859F:
	INX
	INY
	CPY.b #$04
	BCC.b CODE_00856C
	DEC.b $0C
	BMI.b CODE_0085B3
	SEI
	LDA.b #$FF
	STA.w !REGISTER_APUPort0
	JSR.w CODE_00841F
	CLI
CODE_0085B3:
	LDX.b #$03
CODE_0085B5:
	STZ.w !REGISTER_APUPort0,x
	DEX
	BPL.b CODE_0085B5
	REP.b #$20
	STZ.w $004D
	STZ.w $004F
	STZ.w $0053
	STZ.w $0055
	STZ.w $0057
	STZ.w $0059
	SEP.b #$20
	RTL

;---------------------------------------------------------------------------

CODE_0085D2:
	LDY.w $0057
	STA.w $0059,y
	INC.w $0057
	RTL

;---------------------------------------------------------------------------

CODE_0085DC:
	RTL

;---------------------------------------------------------------------------

DATA_0085DD:
	dw CODE_008607
	dw CODE_008641
	dw CODE_008670
	dw CODE_008691

CODE_0085E5:
	LDY.b #$01
	STY.w $0C1E
	LDA.b $78,x
	SEC
	SBC.w $0039
	CMP.w #$00F0
	BMI.b CODE_0085F8
	INC.w $0039
CODE_0085F8:
	LDA.w $0039
	STA.w $0C23
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_0085DD,x)
	RTL

CODE_008607:
	TYX
	LDA.w $7220,x
	BMI.b CODE_008622
	STZ.w $7220,x
	STZ.w $7540,x
	LDA.w #$0002
	STA.w $7402,x
	LDA.w #$0020
	STA.w $7A96,x
	INC.b $76,x
	RTS

CODE_008622:
	CMP.w #$FF00
	BMI.b CODE_00862C
	LDA.w #$0005
	BRA.b CODE_00863D

CODE_00862C:
	LDA.w $7A98,x
	BNE.b CODE_008640
	LDA.w #$0002
	STA.w $7A98,x
	LDA.w $7402,x
	EOR.w #$0001
CODE_00863D:
	STA.w $7402,x
CODE_008640:
	RTS

CODE_008641:
	TYX
	LDA.w $7A96,x
	ORA.w $7A98,x
	BNE.b CODE_00866F
	INC.w $7402,x
	LDA.w $7402,x
	CMP.w #$0004
	BNE.b CODE_008669
	LDA.w #$005B
	JSL.l CODE_0085D2
	LDA.w #$0082
	STA.l $704070
	INC.w $0D0F
	INC.b $76,x
	RTS

CODE_008669:
	LDA.w #$0008
	STA.w $7A98,x
CODE_00866F:
	RTS

CODE_008670:
	TYX
	LDA.w $0D0F
	BNE.b CODE_008690
	LDA.w #$0002
	STA.w $7402,x
	LDA.w #$FC00
	STA.w $7220,x
	LDA.w #$0040
	STA.w $7540,x
	LDA.w #$0400
	STA.w $75E0,x
	INC.b $76,x
CODE_008690:
	RTS

CODE_008691:
	TYX
	LDA.w $7220,x
	CLC
	ADC.w #$0080
	CMP.w #$0100
	BCS.b CODE_0086A3
	LDA.w #$0006
	BRA.b CODE_0086B4

CODE_0086A3:
	CLC
	ADC.w #$0080
	CMP.w #$0200
	BCS.b CODE_0086B1
	LDA.w #$0005
	BRA.b CODE_0086B4

CODE_0086B1:
	LDA.w #$0002
CODE_0086B4:
	STA.w $7402,x
	LDA.w $7220,x
	BMI.b CODE_0086C2
	LDA.w #$0002
	STA.w $7400,x
CODE_0086C2:
	LDA.w $7680,x
	CMP.w #$0140
	BMI.b CODE_008690
	LDX.w $108A
	LDA.w $70E2,x
	STA.b $00
	LDA.w $7182,x
	STA.b $02
	JSL.l CODE_02E1A3
	LDX.w $108A
	JSL.l CODE_03A31E
	LDX.b $12
	PLA
	JML.l CODE_03A31E

;---------------------------------------------------------------------------

CODE_0086E9:
	LDY.w $0073
	BEQ.b CODE_0086F2
	JML.l CODE_03A31E

CODE_0086F2:
	LDA.w $70E2,x
	SEC
	SBC.w $0039
	CLC
	ADC.w $003D
	STA.w $70E2,x
	STA.w $7900,x
	LDA.w $7182,x
	CLC
	ADC.w #$0008
	SEC
	SBC.w $003B
	CLC
	ADC.w $003F
	AND.w #$FFF8
	CLC
	ADC.w #$000A
	STA.w $7182,x
	STA.w $7902,x
	INC.w $74A1,x
	INC.w $74A1,x
	RTL

;---------------------------------------------------------------------------

DATA_008726:
	dw $FFE0,$0020

CODE_00872A:
	JSL.l CODE_03AF23
	JSL.l CODE_03A2C7
	BCC.b CODE_008738
	JML.l CODE_03A32E

CODE_008738:
	LDA.w $7400,x
	DEC
	STA.b $00
	LDA.w $70E2,x
	SEC
	SBC.w $7900,x
	CLC
	ADC.w #$0020
	CMP.w #$0040
	BCC.b CODE_008767
	EOR.b $00
	BMI.b CODE_008767
CODE_008752:
	LDA.b $10
	AND.w #$001F
	CLC
	ADC.w #$0030
	STA.w $7AF6,x
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
CODE_008767:
	LDY.w $7AF6,x
	BEQ.b CODE_008752
	LDY.w $7400,x
	LDA.w DATA_008726,y
	STA.w $7220,x
	LDY.w $7A98,x
	BNE.b CODE_008789
	LDA.w #$0008
	STA.w $7A98,x
	LDA.w $7402,x
	EOR.w #$0001
	STA.w $7402,x
CODE_008789:
	RTL

;---------------------------------------------------------------------------

CODE_00878A:
	STZ.w $7400,x
	RTL

;---------------------------------------------------------------------------

CODE_00878E:
	REP.b #$10
	LDY.w $7362,x
	LDA.w $7682,x
	STA.b $00
	LDA.w $7A36,x
	AND.w #$00FF
	CLC
	ADC.b $00
	STA.w $6002,y
	LDA.w $7A37,x
	AND.w #$00FF
	CLC
	ADC.b $00
	STA.w $600A,y
	LDA.w $7A38,x
	AND.w #$00FF
	CLC
	ADC.b $00
	STA.w $6012,y
	LDA.w $7A39,x
	AND.w #$00FF
	CLC
	ADC.b $00
	STA.w $601A,y
	LDA.w $7900,x
	AND.w #$00FF
	CLC
	ADC.b $00
	STA.w $6022,y
	LDA.w $7901,x
	AND.w #$00FF
	CLC
	ADC.b $00
	STA.w $602A,y
	LDA.w $7902,x
	AND.w #$00FF
	CLC
	ADC.b $00
	STA.w $6032,y
	LDA.w $7903,x
	AND.w #$00FF
	CLC
	ADC.b $00
	STA.w $603A,y
	SEP.b #$10
	LDA.w $60FC
	AND.w #$0003
	BNE.b CODE_00880B
	LDA.w $6090
	CLC
	ADC.b $18,x
	STA.w $6090
CODE_00880B:
	LDA.w $7A36,x
	AND.w #$00FF
	STA.w $6000
	STA.b $00
	LDA.w $7A37,x
	AND.w #$00FF
	STA.w $6002
	STA.b $02
	LDA.w $7A38,x
	AND.w #$00FF
	STA.w $6004
	STA.b $04
	LDA.w $7A39,x
	AND.w #$00FF
	STA.w $6006
	STA.b $06
	LDA.w $7900,x
	AND.w #$00FF
	STA.w $6008
	STA.b $08
	LDA.w $7901,x
	AND.w #$00FF
	STA.w $600A
	STA.b $0A
	LDA.w $7902,x
	AND.w #$00FF
	STA.w $600C
	STA.b $0C
	LDA.w $7903,x
	AND.w #$00FF
	STA.w $600E
	STA.b $0E
	STZ.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDY.w $60AB
	BPL.b CODE_008870
	LDY.w $60C0
	BNE.b CODE_0088C7
CODE_008870:
	LDA.w $611C
	SEC
	SBC.w $70E2,x
	CLC
	ADC.w #$0020
	CMP.w #$0040
	BCS.b CODE_0088CF
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $70E2,x
	SEC
	SBC.w #$0018
	SEC
	SBC.w $611C
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$0046
	CLC
	ADC.b $78,x
	STA.w $603E
	LSR
	STA.w $603C
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $611E
	CLC
	ADC.w $6112
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $6122
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w $7182,x
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDX.b #FXCODE_0B860A>>16
	LDA.w #FXCODE_0B860A
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	BNE.b CODE_0088F5
CODE_0088C7:
	LDA.w $7222,x
	BEQ.b CODE_0088CF
	JMP.w CODE_00899F

CODE_0088CF:
	LDY.b #$0E
CODE_0088D1:
	LDA.w $7960,y
	BEQ.b CODE_0088EC
	CMP.w #$0008
	BPL.b CODE_0088DE
	LDA.w #$0008
CODE_0088DE:
	LSR
	LSR
	LSR
	EOR.w #$FFFF
	INC
	CLC
	ADC.w $7960,y
	STA.w $7960,y
CODE_0088EC:
	DEY
	DEY
	BPL.b CODE_0088D1
	STZ.b $18,x
	JMP.w CODE_008985

CODE_0088F5:
	LDA.w $7222,x
	BEQ.b CODE_00891A
	LDY.b #$0E
CODE_0088FC:
	LDA.w $6000,y
	SEC
	SBC.w $7960,y
	BMI.b CODE_008914
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	CLC
	ADC.w $7960,y
	STA.w $7960,y
CODE_008914:
	DEY
	DEY
	BPL.b CODE_0088FC
	BRA.b CODE_008936

CODE_00891A:
	LDY.b #$0E
CODE_00891C:
	LDA.w $6000,y
	SEC
	SBC.w $7960,y
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	CLC
	ADC.w $7960,y
	STA.w $7960,y
	DEY
	DEY
	BPL.b CODE_00891C
CODE_008936:
	LDY.b $18,x
	BNE.b CODE_00894F
	LDA.w $60AA
	LSR
	LSR
	LSR
	LSR
	STA.b $78,x
	LDY.w $60D4
	BEQ.b CODE_00894F
	LDA.w $60AA
	LSR
	STA.w $7222,x
CODE_00894F:
	LDA.w $60FC
	AND.w #$0003
	BNE.b CODE_008985
	LDA.w $6020
	AND.w #$FFFE
	TAY
	LDA.w $7960,y
	CLC
	ADC.w $7182,x
	SEC
	SBC.w #$001E
	SEC
	SBC.w $6112
	STA.w $6090
	STZ.w $60AA
	INC.w $61B4
	LDY.b #$02
	STY.b $18,x
	LDA.w $7222,x
	BEQ.b CODE_008985
	LDA.w #$0800
	STA.w $60AA
CODE_008985:
	LDA.w $7222,x
	BEQ.b CODE_008992
	LDA.b $78,x
	CLC
	ADC.w #$0004
	BRA.b CODE_00899D

CODE_008992:
	LDA.b $78,x
	SEC
	SBC.w #$0008
	BPL.b CODE_00899D
	LDA.w #$0000
CODE_00899D:
	STA.b $78,x
CODE_00899F:
	SEP.b #$20
	LDA.b $00
	STA.w $7A36,x
	LDA.b $02
	STA.w $7A37,x
	LDA.b $04
	STA.w $7A38,x
	LDA.b $06
	STA.w $7A39,x
	LDA.b $08
	STA.w $7900,x
	LDA.b $0A
	STA.w $7901,x
	LDA.b $0C
	STA.w $7902,x
	LDA.b $0E
	STA.w $7903,x
	REP.b #$20
	RTL

;---------------------------------------------------------------------------

DATA_0089CC:
	dw CODE_008CBF-$01
	dw CODE_008D04-$01
	dw CODE_008D37-$01
	dw CODE_008D75-$01
	dw CODE_008D8F-$01
	dw CODE_008DA5-$01
	dw CODE_008DB2-$01
	dw CODE_008DE7-$01
	dw CODE_008DF8-$01
	dw CODE_008E16-$01
	dw CODE_008E37-$01
	dw CODE_008E5E-$01
	dw CODE_008E7E-$01
	dw CODE_008EEF-$01
	dw CODE_008EFE-$01
	dw CODE_008F0B-$01
	dw CODE_008F3B-$01
	dw CODE_008F6A-$01
	dw CODE_008F9B-$01
	dw CODE_008FD2-$01
	dw CODE_009007-$01
	dw CODE_009028-$01
	dw CODE_009099-$01
	dw CODE_0090BA-$01
	dw CODE_0090C3-$01
	dw CODE_00AD0A-$01
	dw CODE_0090F6-$01
	dw CODE_00912D-$01
	dw CODE_009154-$01
	dw CODE_009519-$01
	dw CODE_00917B-$01
	dw CODE_0091A0-$01
	dw CODE_0091C7-$01
	dw CODE_00921A-$01
	dw CODE_009254-$01
	dw CODE_00927D-$01
	dw CODE_0092EE-$01
	dw CODE_009376-$01
	dw CODE_0093A4-$01
	dw CODE_0093DE-$01
	dw CODE_009433-$01
	dw CODE_009519-$01
	dw CODE_009548-$01
	dw CODE_00955F-$01
	dw CODE_0092AD-$01
	dw CODE_0092A5-$01
	dw CODE_00955F-$01
	dw CODE_009519-$01
	dw CODE_009519-$01
	dw CODE_009519-$01
	dw CODE_009519-$01
	dw CODE_009548-$01
	dw CODE_00A7DA-$01
	dw CODE_009531-$01
	dw CODE_00961B-$01
	dw CODE_009531-$01
	dw CODE_009646-$01
	dw CODE_0095CC-$01
	dw CODE_009531-$01
	dw CODE_00986D-$01
	dw CODE_00986D-$01
	dw CODE_009519-$01
	dw CODE_00958D-$01
	dw CODE_00986D-$01
	dw CODE_009576-$01
	dw CODE_009576-$01
	dw CODE_009519-$01
	dw CODE_009548-$01
	dw CODE_009416-$01
	dw CODE_009ADD-$01
	dw CODE_009B13-$01
	dw CODE_009531-$01
	dw CODE_009519-$01
	dw CODE_009531-$01
	dw CODE_009531-$01
	dw CODE_00955F-$01
	dw CODE_009B55-$01
	dw CODE_009519-$01
	dw CODE_009B88-$01
	dw CODE_009BBC-$01
	dw CODE_009BE3-$01
	dw CODE_009C1D-$01
	dw CODE_009E92-$01
	dw CODE_009519-$01
	dw CODE_009519-$01
	dw CODE_00951D-$01
	dw CODE_00A193-$01
	dw CODE_00A193-$01
	dw CODE_00A551-$01
	dw CODE_00A56F-$01
	dw CODE_00A59A-$01
	dw CODE_009ADD-$01
	dw CODE_00A6A9-$01
	dw CODE_00A6CE-$01
	dw CODE_00A835-$01
	dw CODE_00A6A9-$01
	dw CODE_00A726-$01
	dw CODE_009B55-$01
	dw CODE_00A759-$01
	dw CODE_00A776-$01
	dw CODE_009519-$01
	dw CODE_00A78D-$01
	dw CODE_00A7A4-$01
	dw CODE_00A7F7-$01
	dw CODE_009531-$01
	dw CODE_009519-$01
	dw CODE_00A80E-$01
	dw CODE_009519-$01
	dw CODE_008D96-$01
	dw CODE_00921A-$01
	dw CODE_009519-$01
	dw CODE_009519-$01
	dw CODE_0098AC-$01
	dw CODE_009913-$01
	dw CODE_009998-$01
	dw CODE_009A19-$01
	dw CODE_009A66-$01

CODE_008AB6:
	PHB
	PHK
	PLB
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	STA.w $0B8F
	LDX.b #$3C
CODE_008AC7:
	LDY.w $6EC0,x
	BEQ.b CODE_008ACF
	JSR.w CODE_008AD7
CODE_008ACF:
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_008AC7
	PLB
	RTL

CODE_008AD7:
	LDA.w $7320,x
	ASL
	REP.b #$10
	TAY
	LDA.w DATA_0089CC-$0374,y
	SEP.b #$10
	PHA
	RTS

;---------------------------------------------------------------------------

CODE_008AE5:
	LDA.w $0B8F
	BEQ.b CODE_008AF2
	PLA
	RTS

CODE_008AEC:
	LDA.w $0B8F
	BEQ.b CODE_008AF2
	RTS

CODE_008AF2:
	LDA.w $7782,x
	BNE.b CODE_008B0D
	PLA
CODE_008AF8:
	STZ.w $6EC0,x
	LDA.w #$00FF
	STA.w $7462,x
	LDY.w $76E2,x
	BMI.b CODE_008B0C
	LDA.w $7ECE,y
	TRB.w $7ECC
CODE_008B0C:
	RTS

CODE_008B0D:
	DEC.w $7782,x
	LDA.w $7E8E,x
	BEQ.b CODE_008B18
	DEC.w $7E8E,x
CODE_008B18:
	LDY.w $7781,x
	BEQ.b CODE_008B20
	DEC.w $7781,x
CODE_008B20:
	RTS

;---------------------------------------------------------------------------

CODE_008B21:
	PHA
	LDY.b #$3C
CODE_008B24:
	LDA.w $6EC0,y
	BEQ.b CODE_008B3D
	DEY
	DEY
	DEY
	DEY
	BPL.b CODE_008B24
	LDY.w $7E4A
	DEY
	DEY
	DEY
	DEY
	BPL.b CODE_008B3A
	LDY.b #$3C
CODE_008B3A:
	STY.w $7E4A
CODE_008B3D:
	LDA.w #$0000
	STA.w $71E0,y
	STA.w $71E2,y
	STA.w $73C0,y
	STA.w $70A0,y
	STA.w $7140,y
	STA.w $7E4C,y
	STA.w $7E4E,y
	STA.w $7E8C,y
	STA.w $7782,y
	STA.w $7E8E,y
	STA.w $73C2,y
	STA.w $7820,y
	STA.w $6EC2,y
	STA.w $76E0,y
	STA.w $7640,y
	STA.w $7642,y
	STA.w $7500,y
	STA.w $75A0,y
	STA.w $7780,y
	DEC
	STA.w $7322,y
	STA.w $76E2,y
	LDA.w #$1FFF
	STA.w $7822,y
	PLA
	STA.w $7320,y
	PHX
	ASL
	REP.b #$10
	TAX
	SEP.b #$20
	PHY
	LDA.l FXDATA_0AB59E,x
	LDY.w #$0006
CODE_008B99:
	CMP.w $6EB5,y
	BEQ.b CODE_008BA4
	DEY
	BNE.b CODE_008B99
	TYA
	BRA.b CODE_008BA9

CODE_008BA4:
	TYA
	ADC.b #$06
	ASL
	ASL
CODE_008BA9:
	REP.b #$20
	AND.w #$00FF
	PLY
	STA.w $7140,y
	LDA.l FXDATA_0AB19E+$01,x
	AND.w #$00FF
	EOR.w #$0030
	STA.w $7002,y
	LDA.l FXDATA_0AB19E,x
	AND.w #$00FF
	STA.w $7462,y
	LDA.l FXDATA_0AB39E-$01,x
	AND.w #$FF00
	BPL.b CODE_008BD5
	ORA.w #$00FF
CODE_008BD5:
	XBA
	STA.w $7502,y
	LDA.l FXDATA_0AB39E,x
	AND.w #$FF00
	BPL.b CODE_008BE5
	ORA.w #$00FF
CODE_008BE5:
	XBA
	ASL
	ASL
	ASL
	ASL
	STA.w $75A2,y
	LDA.l FXDATA_0AAB9E,x
	STA.w $6F60,y
	LDA.l FXDATA_0AAD9E,x
	STA.w $6F62,y
	LDA.l FXDATA_0AAF9E,x
	STA.w $7000,y
	LDA.w #$000E
	STA.w $6EC0,y
	LDA.w #$00FF
	STA.w $7460,y
	SEP.b #$10
	PLX
	RTL

;---------------------------------------------------------------------------

CODE_008C12:
	LDA.w $75A0,x
	SEC
	SBC.w $71E0,x
	ASL
	LDA.w $7500,x
	BCC.b CODE_008C23
	EOR.w #$FFFF
	INC
CODE_008C23:
	CLC
	ADC.w $71E0,x
	STA.w $71E0,x
	AND.w #$00FF
	XBA
	CLC
	ADC.w $70A0,x
	STA.w $70A0,x
	LDA.w $71E0,x
	AND.w #$FF00
	BPL.b CODE_008C40
	ORA.w #$00FF
CODE_008C40:
	XBA
	ADC.w #$0000
	STA.w $7280,x
	CLC
	ADC.w $70A2,x
	STA.w $70A2,x
	LDA.w $75A2,x
	SEC
	SBC.w $71E2,x
	ASL
	LDA.w $7502,x
	BCC.b CODE_008C5F
	EOR.w #$FFFF
	INC
CODE_008C5F:
	CLC
	ADC.w $71E2,x
	STA.w $71E2,x
	AND.w #$00FF
	XBA
	CLC
	ADC.w $7140,x
	STA.w $7140,x
	LDA.w $71E2,x
	AND.w #$FF00
	BPL.b CODE_008C7C
	ORA.w #$00FF
CODE_008C7C:
	XBA
	ADC.w #$0000
	STA.w $7282,x
	CLC
	ADC.w $7142,x
	STA.w $7142,x
	RTS

;---------------------------------------------------------------------------

DATA_008C8B:
	dw $0007,$0008,$0009,$000A,$0009,$0008,$0007,$0006
	dw $0005,$0004,$0003,$0002,$0001

DATA_008CA5:
	dw $0003,$0004,$0005,$0004,$0003,$0003,$0003,$0003
	dw $0003,$0003,$0003,$0003,$0003

CODE_008CBF:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_008CDF
	LDA.w $7E4C,x
	DEC
	DEC
	BPL.b CODE_008CCF
	RTS

CODE_008CCF:
	STA.w $7E4C,x
	TAY
	LDA.w DATA_008C8B,y
	STA.w $73C2,x
	LDA.w DATA_008CA5,y
	STA.w $7782,x
CODE_008CDF:
	RTS

;---------------------------------------------------------------------------

DATA_008CE0:
	dw $0000,$0002,$0001,$0001,$0000,$0000,$0001,$0000
	dw $0000,$0000,$0000,$FFFF,$0000,$0000,$FFFF,$FFFF
	dw $FFFE,$0000

CODE_008D04:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	ASL
	TAY
	LDA.w DATA_008CE0-$02,y
	CLC
	ADC.w $7142,x
	STA.w $7142,x
	RTS

;---------------------------------------------------------------------------

DATA_008D17:
	dw $0001,$0000,$0000,$0000,$0000,$0000,$FFFF,$0000
	dw $FFFF,$0000,$0000,$0000,$0000,$0000,$0001,$0000

CODE_008D37:
	JSR.w CODE_008AE5
	LDA.w $7822,x
	AND.w #$00FF
	STA.w $7782,x
	BNE.b CODE_008D48
	JMP.w CODE_008AF8

CODE_008D48:
	LDA.w #$00FF
	ORA.w $7822,x
	STA.w $7822,x
	LDA.w #$0002
	STA.w $7462,x
	INC.w $7E4C,x
	LDA.w $7E4C,x
	BIT.w #$0018
	BEQ.b CODE_008D65
	DEC.w $7142,x
CODE_008D65:
	AND.w #$000F
	ASL
	TAY
	LDA.w $70A2,x
	CLC
	ADC.w DATA_008D17,y
	STA.w $70A2,x
	RTS

;---------------------------------------------------------------------------

CODE_008D75:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_008D89
	INC.w $7782,x
	LDA.w $7002,x
	ORA.w #$0080
	STA.w $7002,x
CODE_008D89:
	RTS

;---------------------------------------------------------------------------

DATA_008D8A:
	db $40,$40,$FF,$00,$00

;---------------------------------------------------------------------------

CODE_008D8F:
	JSR.w CODE_008AE5
	INC.w $73C2,x
	RTS

;---------------------------------------------------------------------------

CODE_008D96:
	JSR.w CODE_008AEC
	LDA.b $14
	LSR
	LSR
	LSR
	AND.w #$0003
	STA.w $73C2,x
	RTS

;---------------------------------------------------------------------------

CODE_008DA5:
	JSR.w CODE_008AEC
	RTS

;---------------------------------------------------------------------------

DATA_008DA9:
	db $02,$01,$00,$FF,$00

DATA_008DAE:
	db $06,$06,$06,$03

CODE_008DB2:
	JSR.w CODE_008AE5
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w $7782,x
	BNE.b CODE_008DD7
	DEC.w $7E4C,x
	BMI.b CODE_008DE4
	DEY
	CPY.b #$03
	BNE.b CODE_008DD1
	LDA.w $7000,x
	AND.b #$FC
	STA.w $7000,x
CODE_008DD1:
	LDA.w DATA_008DAE,y
	STA.w $7782,x
CODE_008DD7:
	LDA.w DATA_008DA9,y
	STA.w $73C2,x
	BMI.b CODE_008DE1
	LDA.b #$06
CODE_008DE1:
	STA.w $7462,x
CODE_008DE4:
	REP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_008DE7:
	JSR.w CODE_008AE5
	SEP.b #$20
	LDA.w $7782,x
	LSR
	LSR
	LSR
	STA.w $73C2,x
	REP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_008DF8:
	DEC.w $7782,x
	LDA.w $7782,x
	BNE.b CODE_008E03
	JMP.w CODE_008AF8

CODE_008E03:
	CMP.w #$003F
	BCS.b CODE_008E0B
	DEC.w $7782,x
CODE_008E0B:
	SEP.b #$20
	LSR
	AND.b #$07
	STA.w $73C2,x
	REP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_008E16:
	JSR.w CODE_008AE5
	LDY.w $73C2,x
	LDA.w $7782,x
	BNE.b CODE_008E2F
	DEC.w $73C2,x
	BPL.b CODE_008E29
	JMP.w CODE_008AF8

CODE_008E29:
	LDA.w #$0002
	STA.w $7782,x
CODE_008E2F:
	RTS

;---------------------------------------------------------------------------

DATA_008E30:
	db $09,$07,$06,$03

DATA_008E34:
	db $02,$01,$00

CODE_008E37:
	JSR.w CODE_008AE5
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w $7782,x
	BNE.b CODE_008E4F
	DEC.w $7E4C,x
	BMI.b CODE_008E55
	LDA.w DATA_008E30-$01,y
	STA.w $7782,x
CODE_008E4F:
	LDA.w DATA_008E34-$01,y
	STA.w $73C2,x
CODE_008E55:
	REP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_008E58:
	db $06,$06,$06,$06,$04,$03

CODE_008E5E:
	JSR.w CODE_008AE5
	SEP.b #$20
	LDY.w $73C2,x
	LDA.w $7782,x
	BNE.b CODE_008E77
	DEY
	BMI.b CODE_008E77
	DEC.w $73C2,x
	LDA.w DATA_008E58,y
	STA.w $7782,x
CODE_008E77:
	REP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_008E7A:
	db $06,$06,$05,$05

CODE_008E7E:
	JSR.w CODE_008AE5
	SEP.b #$20
	LDY.w $73C2,x
	LDA.w $7782,x
	LSR
	BNE.b CODE_008E9A
	DEY
	DEY
	BMI.b CODE_008E9A
	TYA
	STA.w $73C2,x
	LDA.w DATA_008E7A,y
	STA.w $7782,x
CODE_008E9A:
	REP.b #$10
	LDA.w $73C2,x
	LSR
	TXY
	LDX.w $7E4C,y
	LDA.l DATA_00E954,x
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.l DATA_00E954+$01,x
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.b #$FC
	BCC.b CODE_008EB8
	LDA.b #$FE
CODE_008EB8:
	CLC
	ADC.w $7E4E,y
	STA.w $7E4E,y
	STA.w !REGISTER_Mode7MatrixParameterB
	REP.b #$20
	LDA.w !REGISTER_PPUMultiplicationProductMid
	ASL
	ASL
	ASL
	STA.w $71E0,y
	LDA.l DATA_00E9D4,x
	SEP.b #$20
	STA.w !REGISTER_Mode7MatrixParameterA
	XBA
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.w $7E4E,y
	STA.w !REGISTER_Mode7MatrixParameterB
	REP.b #$20
	LDA.w !REGISTER_PPUMultiplicationProductMid
	ASL
	ASL
	ASL
	STA.w $71E2,y
	SEP.b #$10
	TYX
	RTS

;---------------------------------------------------------------------------

CODE_008EEF:
	JSR.w CODE_008AE5
	LDA.w $71E2,x
	BMI.b CODE_008EFD
	LDA.w #$0001
	STA.w $73C2,x
CODE_008EFD:
	RTS

;---------------------------------------------------------------------------

CODE_008EFE:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	LSR
	LSR
	LSR
	STA.w $73C2,x
	RTS

;---------------------------------------------------------------------------

CODE_008F0B:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	CMP.w #$0008
	BNE.b CODE_008F19
	INC.w $73C2,x
CODE_008F19:
	AND.w #$0007
	BNE.b CODE_008F2E
	LDA.w $7970
	AND.w #$0001
	BNE.b CODE_008F27
	DEC
CODE_008F27:
	CLC
	ADC.w $70A2,x
	STA.w $70A2,x
CODE_008F2E:
	RTS

;---------------------------------------------------------------------------

DATA_008F2F:
	db $02,$02,$02,$01,$01,$01

DATA_008F35:
	db $03,$03,$03,$02,$02,$02

CODE_008F3B:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_008F5B
	SEP.b #$20
	DEC.w $7E4C,x
	BEQ.b CODE_008F59
	LDY.w $7E4C,x
	LDA.w DATA_008F35-$01,y
	STA.w $7782,x
	LDA.w DATA_008F2F-$01,y
	STA.w $73C2,x
CODE_008F59:
	REP.b #$20
CODE_008F5B:
	RTS

;---------------------------------------------------------------------------

DATA_008F5C:
	db $05,$04,$03,$01,$01,$02,$01

DATA_008F63:
	db $03,$03,$03,$03,$03,$04,$04

CODE_008F6A:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_008F8A
	DEC.w $7E4C,x
	BMI.b CODE_008F8A
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_008F5C,y
	STA.w $73C2,x
	LDA.w DATA_008F63,y
	STA.w $7782,x
	REP.b #$20
CODE_008F8A:
	RTS

;---------------------------------------------------------------------------

DATA_008F8B:
	db $08,$07,$06,$05,$04,$03,$02,$01

DATA_008F93:
	db $40,$02,$02,$02,$02,$02,$02,$02

CODE_008F9B:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_008FBB
	DEC.w $7E4C,x
	BMI.b CODE_008FBB
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_008F8B,y
	STA.w $73C2,x
	LDA.w DATA_008F93,y
	STA.w $7782,x
	REP.b #$20
CODE_008FBB:
	RTS

;---------------------------------------------------------------------------

DATA_008FBC:
	db $0B,$0A,$09,$08,$07,$06,$05,$04
	db $03,$02,$01

DATA_008FC7:
	db $04,$04,$04,$04,$04,$04,$03,$03
	db $02,$02,$01

CODE_008FD2:
	LDY.w $7E4E,x
	BEQ.b CODE_008FE4
	LDA.w $0B8F
	BEQ.b CODE_008FE4
	DEC.w $7782,x
	BPL.b CODE_008FE7
	JMP.w CODE_008AF8

CODE_008FE4:
	JSR.w CODE_008AE5
CODE_008FE7:
	LDA.w $7782,x
	BNE.b CODE_009004
	DEC.w $7E4C,x
	BMI.b CODE_009004
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_008FBC,y
	STA.w $73C2,x
	LDA.w DATA_008FC7,y
	STA.w $7782,x
	REP.b #$20
CODE_009004:
	RTS

;---------------------------------------------------------------------------

DATA_009005:
	db $01

DATA_009006:
	db $11

CODE_009007:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009027
	DEC.w $7E4C,x
	BMI.b CODE_009027
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_009005,y
	STA.w $73C2,x
	LDA.w DATA_009006,y
	STA.w $7782,x
	REP.b #$20
CODE_009027:
	RTS

;---------------------------------------------------------------------------

CODE_009028:
	JSR.w CODE_008AE5
	LDY.w $7E4C,x
	LDA.w $70E2,y
	STA.b $00
	LDA.w $7182,y
	CLC
	ADC.w #$0008
	STA.b $02
	LDA.w $7E4E,x
	STA.b $06
	LDA.w $7E8C,x
	STA.b $04
	LDA.w $70A2,x
	STA.b $08
	LDA.w $7142,x
	STA.b $0A
	JSL.l CODE_049B42
	LDA.b $04
	STA.w $7E8C,x
	BPL.b CODE_009061
	EOR.w #$FFFF
	INC
	STA.b $04
CODE_009061:
	LDA.b $06
	STA.w $7E4E,x
	BPL.b CODE_00906C
	EOR.w #$FFFF
	INC
CODE_00906C:
	CLC
	ADC.b $04
	CMP.w #$0030
	BCS.b CODE_00907A
	LDA.w #$0001
	STA.w $73C2,x
CODE_00907A:
	LDA.b $08
	STA.w $70A2,x
	LDA.b $0A
	STA.w $7142,x
	RTS

;---------------------------------------------------------------------------

DATA_009085:
	db $0A,$09,$08,$07,$06,$05,$04,$03
	db $02,$01

DATA_00908F:
	db $05,$05,$05,$04,$04,$04,$03,$03
	db $02,$02

CODE_009099:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_0090B9
	DEC.w $7E4C,x
	BMI.b CODE_0090B9
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_009085,y
	STA.w $73C2,x
	LDA.w DATA_00908F,y
	STA.w $7782,x
	REP.b #$20
CODE_0090B9:
	RTS

;---------------------------------------------------------------------------

CODE_0090BA:
	JSR.w CODE_008AEC
	RTS

;---------------------------------------------------------------------------

DATA_0090BE:
	db $06,$04,$04,$03,$03

CODE_0090C3:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_0090DF
	DEC.w $73C2,x
	BPL.b CODE_0090D3
	JMP.w CODE_008AF8

CODE_0090D3:
	LDY.w $73C2,x
	LDA.w DATA_0090BE,y
	AND.w #$00FF
	STA.w $7782,x
CODE_0090DF:
	RTS

;---------------------------------------------------------------------------

DATA_0090E0:
	db $0B,$0A,$09,$08,$07,$06,$05,$04
	db $03,$02,$01

DATA_0090EB:
	db $06,$06,$06,$06,$06,$06,$06
	db $03,$03,$03,$03

CODE_0090F6:
	LDY.w $7E4E,x
	BEQ.b CODE_009100
	JSR.w CODE_008AF2
	BRA.b CODE_009103

CODE_009100:
	JSR.w CODE_008AE5
CODE_009103:
	LDA.w $7782,x
	BNE.b CODE_009120
	DEC.w $7E4C,x
	BMI.b CODE_009120
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_0090E0,y
	STA.w $73C2,x
	LDA.w DATA_0090EB,y
	STA.w $7782,x
	REP.b #$20
CODE_009120:
	RTS

;---------------------------------------------------------------------------

DATA_009121:
	db $06,$05,$04,$03,$02,$01

DATA_009127:
	db $04,$08,$08,$08,$04,$02

CODE_00912D:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00914D
	DEC.w $7E4C,x
	BMI.b CODE_00914D
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_009121,y
	STA.w $73C2,x
	LDA.w DATA_009127,y
	STA.w $7782,x
	REP.b #$20
CODE_00914D:
	RTS

;---------------------------------------------------------------------------

DATA_00914E:
	db $03,$02,$01

DATA_009151:
	db $06,$04,$02

CODE_009154:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009174
	DEC.w $7E4C,x
	BMI.b CODE_009174
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_00914E,y
	STA.w $73C2,x
	LDA.w DATA_009151,y
	STA.w $7782,x
	REP.b #$20
CODE_009174:
	RTS

;---------------------------------------------------------------------------

DATA_009175:
	db $03,$02,$01

DATA_009178:
	db $06,$04,$02

CODE_00917B:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00919B
	DEC.w $7E4C,x
	BMI.b CODE_00919B
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_009175,y
	STA.w $73C2,x
	LDA.w DATA_009178,y
	STA.w $7782,x
	REP.b #$20
CODE_00919B:
	RTS

;---------------------------------------------------------------------------

DATA_00919C:
	db $02,$01

DATA_00919E:
	db $0C,$08

CODE_0091A0:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_0091C0
	DEC.w $7E4C,x
	BMI.b CODE_0091C0
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_00919C,y
	STA.w $73C2,x
	LDA.w DATA_00919E,y
	STA.w $7782,x
	REP.b #$20
CODE_0091C0:
	RTS

;---------------------------------------------------------------------------

DATA_0091C1:
	db $03,$02,$01

DATA_0091C4:
	db $08,$08,$04

CODE_0091C7:
	JSR.w CODE_008C12
	LDA.w $75A0,x
	CMP.w $71E0,x
	BNE.b CODE_0091D9
	EOR.w #$FFFF
	INC
	STA.w $75A0,x
CODE_0091D9:
	LDA.w $75A2,x
	CMP.w $71E2,x
	BNE.b CODE_0091E8
	EOR.w #$FFFF
	INC
	STA.w $75A2,x
CODE_0091E8:
	DEC.w $7782,x
	BNE.b CODE_009213
	DEC.w $7E4C,x
	BPL.b CODE_0091F6
	JSR.w CODE_008AF8
	RTS

CODE_0091F6:
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_0091C1,y
	STA.w $73C2,x
	LDA.w DATA_0091C4,y
	STA.w $7782,x
	REP.b #$20
	CPY.b #$02
	BMI.b CODE_009213
	LDA.w #$0080
	STA.w $71E2,x
CODE_009213:
	RTS

;---------------------------------------------------------------------------

DATA_009214:
	db $03,$02,$01

DATA_009217:
	db $08,$08,$08

CODE_00921A:
	JSR.w CODE_008C12
	JSR.w CODE_008AF2
	LDA.w $7782,x
	BNE.b CODE_00923D
	DEC.w $7E4C,x
	BMI.b CODE_00923D
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_009214,y
	STA.w $73C2,x
	LDA.w DATA_009217,y
	STA.w $7782,x
	REP.b #$20
CODE_00923D:
	RTS

;---------------------------------------------------------------------------

DATA_00923E:
	db $0B,$0A,$09,$08,$07,$06,$05,$04
	db $03,$02,$01

DATA_009249:
	db $01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$02

CODE_009254:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009274
	DEC.w $7E4C,x
	BMI.b CODE_009274
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_00923E,y
	STA.w $73C2,x
	LDA.w DATA_009249,y
	STA.w $7782,x
	REP.b #$20
CODE_009274:
	RTS

;---------------------------------------------------------------------------

DATA_009275:
	db $04,$03,$02,$01

DATA_009279:
	db $06,$06,$06,$06

CODE_00927D:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00929D
	DEC.w $7E4C,x
	BMI.b CODE_00929D
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_009275,y
	STA.w $73C2,x
	LDA.w DATA_009279,y
	STA.w $7782,x
	REP.b #$20
CODE_00929D:
	RTS

;---------------------------------------------------------------------------

DATA_00929E:
	db $03,$03,$03,$03,$03,$03,$03

CODE_0092A5:
	LDA.w $0B8F
	BEQ.b CODE_0092AD
	JSR.w CODE_008C12
CODE_0092AD:
	JSR.w CODE_008AF2
	LDA.w $7782,x
	BNE.b CODE_0092CB
	DEC.w $7E4C,x
	BMI.b CODE_0092CB
	SEP.b #$20
	LDY.w $7E4C,x
	TYA
	STA.w $73C2,x
	LDA.w DATA_00929E,y
	STA.w $7782,x
	REP.b #$20
CODE_0092CB:
	RTS

;---------------------------------------------------------------------------

DATA_0092CC:
	db $03,$02,$00,$01

DATA_0092D0:
	dw $0008,$FFFA,$FFFD,$0001,$0009

DATA_0092DA:
	dw $FFF8,$0006,$0003,$FFFF,$FFF7

DATA_0092E4:
	dw $FFFE,$0004,$FFFE,$FFFC,$FFFB

CODE_0092EE:
	LDY.w $7E4E,x
	LDA.w $7400,y
	STA.b $00
	LDA.w $7402,y
	SEC
	SBC.w #$001B
	ASL
	PHY
	TAY
	LDA.b $00
	BEQ.b CODE_009309
	LDA.w DATA_0092DA,y
	BRA.b CODE_00930C

CODE_009309:
	LDA.w DATA_0092D0,y
CODE_00930C:
	STA.b $00
	LDA.w DATA_0092E4,y
	STA.b $02
	PLY
	LDA.w $70E2,y
	CLC
	ADC.b $00
	CLC
	ADC.w $78C0,x
	CMP.w $70A2,x
	BEQ.b CODE_00932D
	BMI.b CODE_00932A
	INC.w $70A2,x
	BRA.b CODE_00932D

CODE_00932A:
	DEC.w $70A2,x
CODE_00932D:
	LDA.w $7182,y
	CLC
	ADC.b $02
	CLC
	ADC.w $78C2,x
	CMP.w $7142,x
	BEQ.b CODE_009346
	BMI.b CODE_009343
	INC.w $7142,x
	BRA.b CODE_009346

CODE_009343:
	DEC.w $7142,x
CODE_009346:
	DEC.w $7782,x
	BNE.b CODE_009370
	DEC.w $7E4C,x
	BPL.b CODE_009354
	JSR.w CODE_008AF8
	RTS

CODE_009354:
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_0092CC,y
	STA.w $73C2,x
	LDA.b #$04
	STA.w $7782,x
	REP.b #$20
	CPY.b #$02
	BMI.b CODE_009370
	LDA.w #$0080
	STA.w $71E2,x
CODE_009370:
	RTS

;---------------------------------------------------------------------------

DATA_009371:
	db $03,$02,$01,$00,$04

CODE_009376:
	LDY.w $7E4E,x
	BEQ.b CODE_009380
	JSR.w CODE_008AF2
	BRA.b CODE_009383

CODE_009380:
	JSR.w CODE_008AE5
CODE_009383:
	LDA.w $7782,x
	BNE.b CODE_00939F
	DEC.w $7E4C,x
	BMI.b CODE_00939F
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_009371,y
	STA.w $73C2,x
	LDA.b #$04
	STA.w $7782,x
	REP.b #$20
CODE_00939F:
	RTS

;---------------------------------------------------------------------------

DATA_0093A0:
	db $04,$03,$02,$01

CODE_0093A4:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_0093C3
	DEC.w $7E4C,x
	BMI.b CODE_0093C3
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_0093A0,y
	STA.w $73C2,x
	LDA.b #$04
	STA.w $7782,x
	REP.b #$20
CODE_0093C3:
	RTS

;---------------------------------------------------------------------------

DATA_0093C4:
	db $09,$08,$07,$06,$05,$04,$03,$02
	db $01,$00,$FF,$00,$FF

DATA_0093D1:
	db $03,$03,$03,$03,$03,$02,$02,$02
	db $01,$03,$01,$01,$01

CODE_0093DE:
	JSR.w CODE_008AF2
	LDA.w $7782,x
	BNE.b CODE_00940F
	DEC.w $7E4C,x
	BMI.b CODE_00940F
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_0093C4,y
	BPL.b CODE_0093FF
	LDA.w $7E4E,x
	BPL.b CODE_0093FF
	STA.w $7462,x
	BRA.b CODE_009407

CODE_0093FF:
	STA.w $73C2,x
	LDA.b #$02
	STA.w $7462,x
CODE_009407:
	LDA.w DATA_0093D1,y
	STA.w $7782,x
	REP.b #$20
CODE_00940F:
	RTS

;---------------------------------------------------------------------------

DATA_009410:
	db $02,$04,$06,$0A,$06,$04

CODE_009416:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009432
	DEC.w $73C2,x
	BPL.b CODE_009426
	JMP.w CODE_008AF8

CODE_009426:
	LDY.w $73C2,x
	LDA.w DATA_009410,y
	AND.w #$00FF
	STA.w $7782,x
CODE_009432:
	RTS

;---------------------------------------------------------------------------

CODE_009433:
	LDA.w $7322,x
	BPL.b CODE_009446
	LDA.w $61CE
	BEQ.b CODE_009443
	LDA.w #$0006
	STA.w $7462,x
CODE_009443:
	JMP.w CODE_009503

CODE_009446:
	LDA.w $61CE
	BEQ.b CODE_009474
	LDA.w $70A2,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7142,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7E8C,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7322,x
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w #$0004
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	PHX
	LDX.b #FXCODE_09F5F4>>16
	LDA.w #FXCODE_09F5F4
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PLX
CODE_009474:
	REP.b #$10
	TAY
	LDA.w $7E4E,x
	BNE.b CODE_009485
	LDA.w #$0010
	SEC
	SBC.w $7E4C,x
	BPL.b CODE_009488
CODE_009485:
	LDA.w #$0000
CODE_009488:
	STA.b $00
	LDA.w $6000,y
	SEC
	SBC.b $00
	STA.w $6000,y
	LDA.w $6002,y
	SEC
	SBC.b $00
	STA.w $6002,y
	LDA.w $6008,y
	CLC
	ADC.b $00
	STA.w $6008,y
	LDA.w $600A,y
	SEC
	SBC.b $00
	STA.w $600A,y
	LDA.w $6010,y
	SEC
	SBC.b $00
	STA.w $6010,y
	LDA.w $6012,y
	CLC
	ADC.b $00
	STA.w $6012,y
	LDA.w $6018,y
	CLC
	ADC.b $00
	STA.w $6018,y
	LDA.w $601A,y
	CLC
	ADC.b $00
	STA.w $601A,y
	BRA.b CODE_009501

CODE_0094D4:
	LDA.w #$0020
	SEC
	SBC.w $7E4C,x
	STA.b $00
	LDA.w $6002,y
	CLC
	ADC.b $00
	STA.w $6002,y
	LDA.w $6008,y
	SEC
	SBC.b $00
	STA.w $6008,y
	LDA.w $6010,y
	CLC
	ADC.b $00
	STA.w $6010,y
	LDA.w $601A,y
	SEC
	SBC.b $00
	STA.w $601A,y
CODE_009501:
	SEP.b #$10
CODE_009503:
	JSR.w CODE_008AF2
	LDA.w $7E4C,x
	CLC
	ADC.w #$0004
	CMP.w #$0020
	BCC.b CODE_009515
	LDA.w #$0020
CODE_009515:
	STA.w $7E4C,x
	RTS

;---------------------------------------------------------------------------

CODE_009519:
	JSR.w CODE_008AEC
	RTS

;---------------------------------------------------------------------------

CODE_00951D:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00952D
	INC.w $7782,x
	DEC.w $73C2,x
	BMI.b CODE_00952E
CODE_00952D:
	RTS

CODE_00952E:
	JMP.w CODE_008AF8

;---------------------------------------------------------------------------

CODE_009531:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009544
	LDA.w #$0002
	STA.w $7782,x
	DEC.w $73C2,x
	BMI.b CODE_009545
CODE_009544:
	RTS

CODE_009545:
	JMP.w CODE_008AF8

;---------------------------------------------------------------------------

CODE_009548:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00955B
	LDA.w #$0003
	STA.w $7782,x
	DEC.w $73C2,x
	BMI.b CODE_00955C
CODE_00955B:
	RTS

CODE_00955C:
	JMP.w CODE_008AF8

;---------------------------------------------------------------------------

CODE_00955F:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009572
	LDA.w #$0004
	STA.w $7782,x
	DEC.w $73C2,x
	BMI.b CODE_009573
CODE_009572:
	RTS

CODE_009573:
	JMP.w CODE_008AF8

;---------------------------------------------------------------------------

CODE_009576:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009589
	LDA.w #$0006
	STA.w $7782,x
	DEC.w $73C2,x
	BMI.b CODE_00958A
CODE_009589:
	RTS

CODE_00958A:
	JMP.w CODE_008AF8

;---------------------------------------------------------------------------

CODE_00958D:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_0095A0
	LDA.w #$0008
	STA.w $7782,x
	DEC.w $73C2,x
	BMI.b CODE_0095A1
CODE_0095A0:
	RTS

CODE_0095A1:
	JMP.w CODE_008AF8

;---------------------------------------------------------------------------

DATA_0095A4:
	dw $0020,$0022,$8020,$4002,$0000,$0002,$0020,$0022
	dw $8020,$8002

DATA_0095B8:
	dw $0000,$0000,$8000,$4000,$0000,$0000,$0000,$0000
	dw $8000,$8000

CODE_0095CC:
	LDA.w $7322,x
	BMI.b CODE_0095F3
	LDY.w $7E4E,x
	LDA.w DATA_0095A4,y
	STA.b $00
	LDA.w DATA_0095B8,y
	STA.b $02
	REP.b #$10
	LDY.w $7322,x
	LDA.w $6004,y
	ORA.b $00
	EOR.b $02
	CLC
	ADC.w $7E8C,x
	STA.w $6004,y
	SEP.b #$10
CODE_0095F3:
	JSR.w CODE_008AE5
	LDA.w $7E8E,x
	BNE.b CODE_009613
	LDA.w $78C0,x
	STA.w $7E8E,x
	LDA.w $7E4E,x
	CLC
	ADC.w #$0002
	STA.w $7E4E,x
	CMP.w #$0014
	BMI.b CODE_009613
	STZ.w $7E4E,x
CODE_009613:
	RTS

;---------------------------------------------------------------------------

DATA_009614:
	db $04,$03,$02,$01,$00,$00,$00

CODE_00961B:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00963A
	DEC.w $7E4C,x
	BMI.b CODE_00963A
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_009614,y
	STA.w $73C2,x
	LDA.b #$04
	STA.w $7782,x
	REP.b #$20
CODE_00963A:
	RTS

;---------------------------------------------------------------------------

DATA_00963B:
	db $04,$04,$04,$04,$04,$04,$04,$03
	db $03,$02,$02

CODE_009646:
	PHX
	TXA
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #DATA_009693>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_009693
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_098CB1>>16
	LDA.w #FXCODE_098CB1
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PLX
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009687
	DEC.w $73C2,x
	BPL.b CODE_009674
	JMP.w CODE_008AF8

CODE_009674:
	SEP.b #$20
	LDY.w $73C2,x
	LDA.w DATA_009688,y
	STA.w $7001,x
	LDA.w DATA_00963B,y
	STA.w $7782,x
	REP.b #$20
CODE_009687:
	RTS

DATA_009688:
	db $08,$10,$18,$28,$38,$58,$58,$58,$58,$58,$68

DATA_009693:
	db $68,$98,$5E,$98,$4F,$98,$36,$98,$13,$98,$DC,$97,$A5,$97,$6E,$97
	db $37,$97,$00,$97,$BF,$96,$AB,$96,$08,$08,$6A,$C6,$02,$F8,$08,$6A
	db $86,$02,$08,$F8,$6A,$46,$02,$F8,$F8,$6A,$06,$02,$04,$FC,$45,$06
	db $00,$00,$08,$55,$06,$00,$04,$04,$42,$C2,$02,$FC,$04,$42,$82,$02
	db $04,$FC,$42,$42,$02,$FC,$FC,$42,$02,$02,$0F,$0D,$4C,$06,$00,$00
	db $0F,$4C,$46,$00,$F7,$06,$4C,$06,$00,$12,$03,$4C,$46,$00,$09,$F9
	db $4C,$46,$00,$FE,$FB,$4C,$46,$00,$04,$06,$4C,$06,$00,$04,$FC,$54
	db $06,$00,$10,$10,$55,$06,$00,$00,$08,$45,$06,$00,$00,$08,$55,$06
	db $00,$10,$12,$4C,$06,$00,$FF,$14,$4C,$46,$00,$F6,$09,$4C,$06,$00
	db $13,$06,$4C,$46,$00,$0A,$FC,$4C,$46,$00,$FD,$FE,$4C,$46,$00,$04
	db $09,$4C,$06,$00,$04,$FC,$44,$06,$00,$F8,$10,$55,$06,$00,$00,$08
	db $54,$06,$00,$10,$10,$45,$06,$00,$11,$16,$4C,$06,$00,$FE,$18,$4C
	db $46,$00,$F5,$0D,$4C,$06,$00,$14,$0A,$4C,$46,$00,$0B,$00,$4C,$06
	db $00,$FC,$02,$4C,$46,$00,$04,$0D,$4C,$06,$00,$00,$18,$55,$06,$00
	db $00,$08,$44,$06,$00,$10,$10,$54,$06,$00,$F8,$10,$45,$06,$00,$12
	db $1A,$4C,$06,$00,$FD,$1C,$4D,$46,$00,$F5,$11,$4C,$06,$00,$15,$0E
	db $4D,$46,$00,$0C,$04,$4D,$06,$00,$FB,$06,$4D,$46,$00,$04,$11,$4C
	db $06,$00,$08,$08,$55,$06,$00,$10,$10,$44,$06,$00,$F8,$10,$54,$06
	db $00,$00,$18,$45,$06,$00,$12,$1E,$4D,$06,$00,$FD,$20,$4E,$46,$00
	db $F4,$15,$4D,$06,$00,$15,$12,$4E,$46,$00,$0C,$08,$4E,$06,$00,$FB
	db $0A,$4E,$46,$00,$04,$15,$4C,$06,$00,$10,$20,$55,$06,$00,$F8,$10
	db $44,$06,$00,$00,$18,$54,$06,$00,$08,$08,$45,$06,$00,$12,$23,$4E
	db $46,$00,$FD,$25,$4F,$46,$00,$F4,$1A,$4E,$06,$00,$15,$17,$4F,$46
	db $00,$0C,$0D,$4F,$06,$00,$FB,$0F,$4F,$46,$00,$04,$1A,$4D,$06,$00
	db $12,$27,$4F,$46,$00,$F4,$1F,$4F,$06,$00,$04,$1F,$4E,$06,$00,$FC
	db $28,$55,$06,$00,$00,$18,$44,$06,$00,$08,$08,$54,$06,$00,$10,$20
	db $45,$06,$00,$04,$24,$4F,$06,$00,$08,$30,$55,$06,$00,$FC,$28,$45
	db $06,$00,$10,$20,$54,$06,$00,$08,$08,$44,$06,$00,$08,$30,$45,$06
	db $00,$FC,$28,$54,$06,$00,$10,$20,$44,$06,$00,$08,$30,$54,$06,$00
	db $FC,$28,$44,$06,$00,$08,$30,$44,$06,$00

;---------------------------------------------------------------------------

CODE_00986D:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009883
	DEC.w $7E4E,x
	BMI.b CODE_009883
	INC.w $73C2,x
	LDA.w $7E4C,x
	STA.w $7782,x
CODE_009883:
	RTS

;---------------------------------------------------------------------------

DATA_009884:
	dw $002C,$003C,$0050,$0064,$0068

DATA_00988E:
	dw $000C,$000C,$0014,$0018,$001C

DATA_009898:
	dw $0004,$0004,$0004,$0005,$0006

DATA_0098A2:
	dw $0000,$0001,$0002,$0001,$0003

CODE_0098AC:
	PHX
	LDA.w $78C0,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $78C2,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7322,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7E8C,x
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w $70A2,x
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w $7142,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_089287>>16
	LDA.w #FXCODE_089287
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PLX
	JSR.w CODE_008AE5
	LDA.w $7E8E,x
	BNE.b CODE_00990F
	INC.w $7E4C,x
	LDA.w $7E4C,x
	ASL
	TAY
	CPY.b #$0A
	BNE.b CODE_0098F4
	LDA.w #$0000
	BRA.b CODE_00990F

CODE_0098F4:
	LDA.w DATA_009884,y
	STA.w $78C0,x
	LDA.w DATA_00988E,y
	STA.w $78C2,x
	LDA.w DATA_009898,y
	STA.w $7E8E,x
	LDA.w DATA_0098A2,y
	STA.w $73C2,x
	LDA.w #$0003
CODE_00990F:
	STA.w $7782,x
	RTS

;---------------------------------------------------------------------------

CODE_009913:
	JSR.w CODE_008AE5
	LDA.w #$0001
	STA.w $7782,x
	DEC.w $7E4C,x
	LDA.w $7E4C,x
	BPL.b CODE_009953
	LDA.w #$0001
	STA.w $7E4C,x
	INC.w $7E4E,x
	LDA.w $7E4E,x
	CMP.w #$000F
	BCC.b CODE_009953
	LDA.w #$000E
	STA.w $7E4E,x
	LDA.w $7462,x
	AND.w #$00FF
	CMP.w #$00FF
	BEQ.b CODE_009953
	PHX
	PHY
	JSR.w CODE_00995F
	PLY
	PLX
	LDA.w #$00FF
	STA.w $7462,x
CODE_009953:
	LDA.w $7E4E,x
	ASL
	TAY
	LDA.w DATA_00997A,y
	STA.w $73C2,x
	RTS

CODE_00995F:
	LDA.w #$022D
	JSL.l CODE_008B21
	LDA.w $70A2,x
	STA.w $70A2,y
	LDA.w $7142,x
	STA.w $7142,y
	PHX
	TYX
	JSL.l CODE_009A96
	PLX
	RTS

DATA_00997A:
	dw $0000,$0001,$0002,$0003,$0004,$0005,$0006,$0007
	dw $0008,$0009,$000A,$000B,$000C,$000E,$000D

;---------------------------------------------------------------------------

CODE_009998:
	JSR.w CODE_008AE5
	LDA.w #$0002
	STA.w $7782,x
	DEC.w $7E4C,x
	LDA.w $7E4C,x
	BPL.b CODE_0099B8
	LDY.w $7E4E,x
	LDA.w DATA_009A10,y
	AND.w #$00FF
	STA.w $7E4C,x
	INC.w $7E4E,x
CODE_0099B8:
	LDA.w $7E4E,x
	AND.w #$0003
	ASL
	TAY
	LDA.w DATA_009A08,y
	STA.w $73C2,x
	LDA.w $71E2,x
	BMI.b CODE_009A07
	CMP.w #$0280
	BCC.b CODE_0099D7
	LDA.w #$0000
	STA.w $7782,x
	RTS

CODE_0099D7:
	LDA.w $7E8C,x
	BNE.b CODE_009A07
	INC.w $7E8C,x
	LDA.w #$022E
	JSL.l CODE_008B21
	LDA.w $70A2,x
	CLC
	ADC.w #$FFD8
	STA.w $70A2,y
	LDA.w $7142,x
	CLC
	ADC.w #$0000
	STA.w $7142,y
	LDA.w #$0003
	STA.w $7782,y
	PHX
	TYX
	JSL.l CODE_009ABF
	PLX
CODE_009A07:
	RTS

DATA_009A08:
	dw $0000,$0001,$0002,$0001

DATA_009A10:
	db $02,$03,$03,$03,$03,$20,$03,$03
	db $03

;---------------------------------------------------------------------------

CODE_009A19:
	JSR.w CODE_008AE5
	LDA.w #$0002
	STA.w $7782,x
	PHX
	DEC.w $7E4C,x
	LDA.w $7E4C,x
	BPL.b CODE_009A49
	LDA.w $7E4E,x
	AND.w #$0001
	CLC
	ADC.w #$0000
	STA.w $7E4C,x
	INC.w $7E4E,x
	LDA.w $7E4E,x
	CMP.w #$000C
	BCC.b CODE_009A49
	LDA.w #$0004
	STA.w $7E4E,x
CODE_009A49:
	LDA.w $7E4E,x
	STA.w $73C2,x
	LDA.w $7E8E,x
	BNE.b CODE_009A61
	PHD
	LDA.w #$0000
	PHA
	PLD
	JSL.l CODE_1191B8
	REP.b #$20
	PLD
CODE_009A61:
	PLX
	STX.w $7E4A
	RTS

;---------------------------------------------------------------------------

CODE_009A66:
	JSR.w CODE_008AE5
	LDA.w #$0002
	STA.w $7782,x
	DEC.w $7E4C,x
	LDA.w $7E4C,x
	BPL.b CODE_009A8F
	LDA.w #$0003
	STA.w $7E4C,x
	INC.w $7E4E,x
	LDA.w $7E4E,x
	CMP.w #$0008
	BCC.b CODE_009A8F
	LDA.w #$0000
	STA.w $7782,x
	RTS

CODE_009A8F:
	LDA.w $7E4E,x
	STA.w $73C2,x
	RTS

;---------------------------------------------------------------------------

CODE_009A96:
	LDA.w #$0002
	STA.w $7782,x
	LDA.w #$0003
	STA.w $7E4C,x
	STZ.w $7E4E,x
	STZ.w $7502,x
	LDA.w #$0000
	STA.w $7462,x
	LDA.w #$0040
	STA.w $7E8E,x
	LDA.w #$0008
	JSL.l CODE_0085D2
	STX.w $7E4A
	RTL

;---------------------------------------------------------------------------

CODE_009ABF:
	LDA.w #$0003
	STA.w $7782,x
	STZ.w $7E4E,x
	STZ.w $7502,x
	LDA.w #$0000
	STA.w $7462,x
	LDA.w #$003F
	JSL.l CODE_0085D2
	RTL

;---------------------------------------------------------------------------

DATA_009AD9:
	dw $0040,$FFC0

CODE_009ADD:
	JSR.w CODE_008AF2
	LDA.w $7E8E,x
	BNE.b CODE_009AE8
	JMP.w CODE_008AF8

CODE_009AE8:
	CMP.w #$0040
	BPL.b CODE_009AFA
	LDY.b #$FF
	AND.w #$0001
	BEQ.b CODE_009AF6
	LDY.b #$01
CODE_009AF6:
	TYA
	STA.w $7462,x
CODE_009AFA:
	LDA.w $7E8E,x
	AND.w #$003F
	BNE.b CODE_009B12
	LDA.w $73C0,x
	EOR.w #$0002
	STA.w $73C0,x
	TAY
	LDA.w DATA_009AD9,y
	STA.w $71E0,x
CODE_009B12:
	RTS

;---------------------------------------------------------------------------

CODE_009B13:
	JSR.w CODE_008AE5
	LDY.w $7462,x
	CPY.b #$FF
	BNE.b CODE_009B25
	LDA.w #$0001
	STA.w $7462,x
	BRA.b CODE_009B52

CODE_009B25:
	LDA.w $7E8C,x
	CLC
	ADC.w $7E4E,x
	STA.w $7E8C,x
	BIT.w #$FF00
	BEQ.b CODE_009B40
	AND.w #$00FF
	STA.w $7E8C,x
	LDA.w #$00FF
	STA.w $7462,x
CODE_009B40:
	LDA.w $7E4E,x
	CLC
	ADC.w #$0004
	CMP.w #$0100
	BMI.b CODE_009B4F
	LDA.w #$0100
CODE_009B4F:
	STA.w $7E4E,x
CODE_009B52:
	RTS

;---------------------------------------------------------------------------

DATA_009B53:
	db $0C,$10

CODE_009B55:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009B71
	DEC.w $73C2,x
	BPL.b CODE_009B65
	JMP.w CODE_008AF8

CODE_009B65:
	LDY.w $73C2,x
	LDA.w DATA_009B53,y
	AND.w #$00FF
	STA.w $7782,x
CODE_009B71:
	RTS

;---------------------------------------------------------------------------

DATA_009B72:
	db $03,$03,$03,$03,$03,$03,$03,$03
	db $03,$02,$02,$02,$02,$02,$02,$02
	db $02,$02,$02,$02,$02,$02

CODE_009B88:
	JSR.w CODE_008AE5
	SEP.b #$20
	LDA.w $7782,x
	BEQ.b CODE_009BA1
	LDY.w $73C2,x
	CPY.b #$16
	BNE.b CODE_009BB4
	CMP.b #$02
	BCS.b CODE_009BB4
	LDA.b #$FF
	BRA.b CODE_009BB6

CODE_009BA1:
	DEC.w $73C2,x
	BPL.b CODE_009BAB
	REP.b #$20
	JMP.w CODE_008AF8

CODE_009BAB:
	LDY.w $73C2,x
	LDA.w DATA_009B72,y
	STA.w $7782,x
CODE_009BB4:
	LDA.b #$05
CODE_009BB6:
	STA.w $7462,x
	REP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_009BBC:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009BC7
	JMP.w CODE_008AF8

CODE_009BC7:
	LDA.w $7E8E,x
	BNE.b CODE_009BDD
	LDA.w #$0004
	STA.w $7E8E,x
	DEC.w $73C2,x
	BPL.b CODE_009BDD
	LDA.w #$0005
	STA.w $73C2,x
CODE_009BDD:
	RTS

;---------------------------------------------------------------------------

DATA_009BDE:
	db $08,$06,$04,$02,$02

CODE_009BE3:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009C10
	DEC.w $7E4C,x
	BPL.b CODE_009BF3
	JMP.w CODE_008AF8

CODE_009BF3:
	SEP.b #$20
	DEC.w $73C2,x
	LDY.w $7E4C,x
	LDA.w DATA_009BDE,y
	STA.w $7782,x
	REP.b #$20
	LDA.w #$0001
	CPY.b #$03
	BNE.b CODE_009C0D
	LDA.w #$FFFF
CODE_009C0D:
	STA.w $7462,x
CODE_009C10:
	RTS

;---------------------------------------------------------------------------

DATA_009C11:
	db $03,$03,$03,$03,$03,$03,$03,$02
	db $02,$02,$02,$02

CODE_009C1D:
	PHX
	TXA
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #DATA_009C6B>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_009C6B
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_098CB1>>16
	LDA.w #FXCODE_098CB1
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PLX
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009C5E
	DEC.w $73C2,x
	BPL.b CODE_009C4B
	JMP.w CODE_008AF8

CODE_009C4B:
	SEP.b #$20
	LDY.w $73C2,x
	LDA.w DATA_009C5F,y
	STA.w $7001,x
	LDA.w DATA_009C11,y
	STA.w $7782,x
	REP.b #$20
CODE_009C5E:
	RTS

DATA_009C5F:
	db $10,$10,$20,$38,$48,$58,$58,$50,$58,$50,$50,$48

DATA_009C6B:
	db $88,$9E,$7E,$9E,$6A,$9E,$47,$9E,$1A,$9E,$E3,$9D,$AC,$9D,$7A,$9D
	db $43,$9D,$11,$9D,$DF,$9C,$B2,$9C,$85,$9C,$03,$FE,$55,$06,$00,$09
	db $0B,$4C,$04,$00,$09,$00,$4C,$04,$00,$FF,$01,$4C,$04,$00,$05,$07
	db $4C,$04,$00,$0E,$07,$4C,$04,$00,$00,$0B,$4C,$04,$00,$FE,$06,$4C
	db $04,$00,$04,$FD,$4D,$04,$00,$03,$FE,$55,$06,$00,$0A,$0D,$4C,$04
	db $00,$0A,$FD,$4C,$04,$00,$FE,$FE,$4C,$04,$00,$05,$08,$4C,$04,$00
	db $10,$06,$4C,$04,$00,$FF,$0C,$4D,$84,$00,$FC,$07,$4C,$04,$00,$04
	db $FE,$4D,$04,$00,$0C,$02,$55,$06,$00,$03,$FE,$45,$06,$00,$0A,$0F
	db $4C,$04,$00,$09,$FB,$4D,$44,$00,$FD,$FD,$4C,$04,$00,$05,$09,$4C
	db $04,$00,$12,$06,$4D,$04,$00,$FE,$0D,$4E,$84,$00,$FA,$08,$4C,$04
	db $00,$04,$FF,$4D,$04,$00,$0C,$02,$55,$06,$00,$03,$FE,$54,$06,$00
	db $0B,$12,$4D,$44,$00,$0B,$FA,$4D,$44,$00,$FD,$FD,$4C,$04,$00,$05
	db $0B,$4C,$04,$00,$13,$06,$4D,$04,$00,$FE,$0F,$4E,$84,$00,$FA,$0A
	db $4D,$04,$00,$04,$01,$4E,$04,$00,$FC,$08,$55,$06,$00,$0C,$02,$45
	db $06,$00,$03,$FE,$44,$06,$00,$0C,$15,$4D,$44,$00,$0C,$FA,$4D,$44
	db $00,$FC,$FE,$4C,$04,$00,$05,$0D,$4C,$04,$00,$14,$07,$4D,$04,$00
	db $FD,$11,$4F,$84,$00,$F9,$0C,$4D,$04,$00,$04,$03,$4E,$04,$00,$FC
	db $08,$55,$06,$00,$0C,$02,$54,$06,$00,$0C,$19,$4E,$44,$00,$0C,$FB
	db $4E,$44,$00,$FC,$FF,$4D,$44,$00,$05,$10,$4D,$44,$00,$15,$08,$4D
	db $04,$00,$FD,$14,$4F,$84,$00,$F9,$0F,$4D,$04,$00,$04,$06,$4E,$04
	db $00,$07,$16,$55,$06,$00,$FC,$08,$55,$06,$00,$0C,$02,$44,$06,$00
	db $0D,$1D,$4E,$44,$00,$0D,$FC,$4E,$44,$00,$FB,$01,$4E,$44,$00,$05
	db $13,$4E,$44,$00,$15,$09,$4E,$04,$00,$FC,$17,$4F,$84,$00,$F8,$12
	db $4E,$04,$00,$04,$09,$4F,$04,$00,$07,$17,$55,$06,$00,$FC,$09,$55
	db $06,$00,$0C,$03,$44,$06,$00,$0D,$1F,$4F,$44,$00,$0D,$FE,$4F,$44
	db $00,$FB,$03,$4E,$44,$00,$05,$15,$4E,$44,$00,$16,$0A,$4E,$04,$00
	db $FC,$19,$4F,$84,$00,$F8,$14,$4E,$04,$00,$04,$0A,$4F,$04,$00,$03
	db $20,$44,$06,$00,$07,$16,$45,$06,$00,$FC,$08,$54,$06,$00,$0D,$22
	db $4F,$44,$00,$0E,$01,$4F,$44,$00,$FB,$05,$4F,$44,$00,$05,$19,$4E
	db $44,$00,$17,$0D,$4E,$04,$00,$F7,$17,$4F,$04,$00,$17,$10,$4F,$04
	db $00,$03,$20,$54,$06,$00,$07,$16,$54,$06,$00,$FC,$08,$44,$06,$00
	db $0E,$05,$4F,$44,$00,$F7,$1A,$4F,$04,$00,$05,$1C,$4F,$44,$00,$18
	db $12,$4F,$04,$00,$03,$20,$45,$06,$00,$07,$16,$44,$06,$00,$05,$1F
	db $4F,$44,$00,$03,$20,$54,$06,$00,$05,$22,$4F,$44,$00,$03,$20,$44
	db $06,$00,$05,$25,$4F,$44,$00

;---------------------------------------------------------------------------

CODE_009E92:
	PHX
	TXA
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #DATA_009EE0>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_009EE0
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_098CB1>>16
	LDA.w #FXCODE_098CB1
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PLX
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_009ED2
	DEC.w $73C2,x
	BPL.b CODE_009EC0
	JMP.w CODE_008AF8

CODE_009EC0:
	SEP.b #$20
	LDY.w $73C2,x
	LDA.w DATA_009ED3,y
	STA.w $7001,x
	LDA.b #$02
	STA.w $7782,x
	REP.b #$20
CODE_009ED2:
	RTS

DATA_009ED3:
	db $10,$20,$30,$40,$50,$50,$48,$50,$60,$58,$50,$60,$60

DATA_009EE0:
	db $72,$A1,$5E,$A1,$40,$A1,$18,$A1,$E6,$A0,$B4,$A0,$87,$A0,$55,$A0
	db $19,$A0,$E2,$9F,$B0,$9F,$74,$9F,$38,$9F,$FC,$9E,$07,$08,$42,$C2
	db $02,$F7,$08,$42,$82,$02,$07,$F8,$42,$42,$02,$F7,$F8,$42,$02,$02
	db $09,$01,$86,$08,$02,$FF,$08,$86,$08,$02,$F5,$FE,$86,$08,$02,$01
	db $F6,$86,$08,$02,$0C,$09,$86,$08,$02,$F5,$0A,$86,$08,$02,$0B,$F4
	db $86,$08,$02,$F6,$F3,$86,$08,$02,$05,$05,$42,$C2,$02,$FD,$05,$42
	db $82,$02,$05,$FD,$42,$42,$02,$FD,$FD,$42,$02,$02,$11,$01,$86,$08
	db $02,$FF,$10,$86,$08,$02,$ED,$FE,$86,$08,$02,$01,$F2,$86,$08,$02
	db $10,$0D,$86,$08,$02,$F1,$0E,$86,$08,$02,$0D,$EE,$86,$08,$02,$F4
	db $ED,$86,$08,$02,$08,$08,$6A,$C6,$02,$F8,$08,$6A,$86,$02,$08,$F8
	db $6A,$46,$02,$F8,$F8,$6A,$06,$02,$15,$03,$86,$08,$02,$FF,$14,$86
	db $08,$02,$E9,$FF,$86,$08,$02,$01,$F0,$86,$08,$02,$14,$0F,$86,$08
	db $02,$EF,$10,$86,$08,$02,$0F,$EC,$86,$08,$02,$F2,$EB,$86,$08,$02
	db $08,$08,$E3,$06,$02,$F8,$00,$E3,$06,$02,$19,$05,$86,$08,$02,$FF
	db $1A,$86,$08,$02,$E5,$01,$86,$08,$02,$01,$EE,$E3,$06,$02,$16,$12
	db $86,$08,$02,$ED,$13,$86,$08,$02,$11,$EA,$86,$08,$02,$F0,$E9,$86
	db $08,$02,$08,$F8,$E3,$06,$02,$08,$08,$E5,$06,$02,$F8,$00,$E5,$06
	db $02,$1D,$07,$86,$08,$02,$FF,$1E,$E3,$06,$02,$E1,$03,$86,$08,$02
	db $01,$ED,$E5,$06,$02,$18,$16,$86,$08,$02,$EB,$17,$86,$08,$02,$13
	db $E9,$86,$08,$02,$EE,$E8,$86,$08,$02,$00,$00,$E3,$06,$02,$08,$F8
	db $E5,$06,$02,$08,$08,$E5,$06,$02,$F8,$00,$E7,$06,$02,$21,$09,$86
	db $08,$02,$FF,$24,$E5,$06,$02,$DD,$05,$86,$08,$02,$01,$ED,$E7,$06
	db $02,$1A,$1A,$86,$08,$02,$E9,$1B,$86,$08,$02,$15,$E9,$86,$08,$02
	db $EC,$E8,$86,$08,$02,$00,$10,$E3,$06,$02,$00,$00,$E5,$06,$02,$08
	db $F8,$E7,$06,$02,$24,$0C,$E3,$06,$02,$FF,$2A,$E7,$06,$02,$DA,$08
	db $86,$08,$02,$1D,$20,$86,$08,$02,$E6,$21,$86,$08,$02,$18,$EA,$86
	db $08,$02,$E9,$E9,$86,$08,$02,$F0,$08,$E3,$06,$02,$00,$10,$E5,$06
	db $02,$00,$00,$E7,$06,$02,$26,$0F,$E5,$06,$02,$D8,$0B,$86,$08,$02
	db $1F,$25,$86,$08,$02,$E4,$26,$86,$08,$02,$1A,$EC,$86,$08,$02,$E7
	db $EB,$E3,$06,$02,$E8,$18,$E3,$06,$02,$08,$20,$E3,$06,$02,$F0,$08
	db $E5,$06,$02,$00,$10,$E7,$06,$02,$28,$14,$E7,$06,$02,$D6,$10,$86
	db $08,$02,$21,$2C,$86,$08,$02,$E2,$2D,$E3,$06,$02,$1C,$EF,$86,$08
	db $02,$E5,$EE,$E5,$06,$02,$18,$10,$E3,$06,$02,$E8,$18,$E5,$06,$02
	db $08,$20,$E5,$06,$02,$F0,$08,$E7,$06,$02,$00,$10,$E7,$06,$02,$D5
	db $15,$86,$08,$02,$22,$32,$86,$08,$02,$E1,$33,$E5,$06,$02,$1D,$F3
	db $E5,$06,$02,$E4,$F2,$E7,$06,$02,$00,$38,$E3,$06,$02,$18,$10,$E5
	db $06,$02,$E8,$18,$E7,$06,$02,$08,$20,$E7,$06,$02,$D3,$1B,$86,$08
	db $02,$24,$38,$E3,$06,$02,$E0,$39,$E7,$06,$02,$1F,$F9,$E5,$06,$02
	db $08,$10,$E3,$06,$02,$00,$38,$E5,$06,$02,$18,$10,$E7,$06,$02,$D3
	db $21,$E3,$06,$02,$24,$3E,$E5,$06,$02,$1F,$FF,$E7,$06,$02,$08,$10
	db $E5,$06,$02,$00,$38,$E7,$06,$02,$D2,$27,$E5,$06,$02,$25,$44,$E7
	db $06,$02,$08,$10,$E7,$06,$02,$D1,$2D,$E7,$06,$02

;---------------------------------------------------------------------------

DATA_00A17C:
	db $04,$04,$04,$04,$04,$04,$04,$04
	db $04,$04,$04,$04,$04,$04,$04,$03
	db $03,$03,$02,$02,$01,$01,$01

CODE_00A193:
	PHX
	TXA
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #DATA_00A1E9>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_00A1E9
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_098CB1>>16
	LDA.w #FXCODE_098CB1
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PLX
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A1D1
	DEC.w $73C2,x
	BPL.b CODE_00A1BE
	JMP.w CODE_008AF8

CODE_00A1BE:
	SEP.b #$20
	LDY.w $73C2,x
	LDA.w DATA_00A1D2,y
	STA.w $7001,x
	LDA.w DATA_00A17C,y
	STA.w $7782,x
	REP.b #$20
CODE_00A1D1:
	RTS

DATA_00A1D2:
	db $08,$10,$18,$20,$28,$30,$40,$38,$40,$40,$40,$40,$40,$40,$40,$40
	db $40,$40,$40,$40,$40,$40,$40

DATA_00A1E9:
	db $48,$A5,$3E,$A5,$2F,$A5,$1B,$A5,$02,$A5,$E4,$A4,$BC,$A4,$99,$A4
	db $71,$A4,$49,$A4,$21,$A4,$F9,$A3,$D1,$A3,$A9,$A3,$81,$A3,$59,$A3
	db $31,$A3,$09,$A3,$E1,$A2,$B9,$A2,$91,$A2,$69,$A2,$41,$A2,$19,$A2
	db $02,$00,$11,$00,$00,$FC,$00,$10,$00,$00,$04,$FC,$01,$00,$00,$FC
	db $FC,$00,$00,$00,$FB,$00,$11,$00,$00,$F8,$00,$10,$00,$00,$FB,$FA
	db $01,$00,$00,$F6,$FC,$00,$00,$00,$06,$03,$01,$00,$00,$FC,$05,$10
	db $40,$00,$08,$F7,$10,$00,$00,$FC,$F7,$10,$00,$00,$FB,$00,$11,$40
	db $00,$F3,$03,$10,$40,$00,$FB,$F1,$01,$40,$00,$F2,$F7,$01,$00,$00
	db $09,$03,$10,$40,$00,$FC,$08,$00,$40,$00,$0B,$F5,$10,$40,$00,$FC
	db $F4,$11,$00,$00,$FB,$01,$10,$40,$00,$F0,$03,$10,$00,$00,$FB,$ED
	db $01,$C0,$00,$EF,$F4,$01,$80,$00,$0C,$04,$01,$40,$00,$FC,$08,$01
	db $40,$00,$0D,$F3,$01,$40,$00,$FC,$F3,$10,$40,$00,$FB,$02,$00,$40
	db $00,$ED,$04,$00,$00,$00,$FB,$EB,$00,$C0,$00,$ED,$F2,$10,$80,$00
	db $0D,$05,$00,$C0,$00,$FC,$0A,$01,$C0,$00,$0E,$F2,$01,$C0,$00,$FC
	db $F3,$00,$40,$00,$FB,$03,$01,$40,$00,$EC,$05,$01,$00,$00,$FB,$E9
	db $11,$80,$00,$EC,$F1,$10,$C0,$00,$0E,$06,$11,$80,$00,$FB,$0C,$00
	db $C0,$00,$0F,$F1,$00,$C0,$00,$FC,$F3,$00,$C0,$00,$FB,$04,$01,$C0
	db $00,$EB,$06,$01,$80,$00,$FB,$E8,$10,$80,$00,$EB,$F0,$01,$C0,$00
	db $0E,$06,$01,$80,$00,$FC,$0C,$11,$80,$00,$0F,$F1,$11,$80,$00,$FC
	db $F3,$11,$80,$00,$FB,$05,$00,$C0,$00,$EB,$06,$00,$80,$00,$FB,$E8
	db $00,$80,$00,$EB,$F0,$00,$40,$00,$0D,$0A,$10,$00,$00,$FD,$0F,$10
	db $80,$00,$10,$F2,$10,$80,$00,$FE,$F6,$00,$80,$00,$FB,$06,$11,$80
	db $00,$EB,$07,$11,$80,$00,$FC,$EB,$01,$00,$00,$ED,$F4,$11,$00,$00
	db $0C,$0E,$10,$40,$00,$FE,$13,$00,$80,$00,$11,$F6,$01,$00,$00,$FE
	db $F8,$00,$00,$00,$FD,$09,$00,$80,$00,$E9,$09,$00,$C0,$00,$FC,$EE
	db $10,$00,$00,$EF,$F3,$00,$00,$00,$0B,$0E,$00,$40,$00,$FE,$16,$01
	db $00,$00,$10,$F9,$00,$00,$00,$FC,$FB,$11,$00,$00,$FD,$0C,$00,$00
	db $00,$E9,$0C,$00,$40,$00,$FA,$F2,$11,$00,$00,$EE,$F3,$01,$00,$00
	db $0A,$0F,$01,$40,$00,$FD,$19,$10,$00,$00,$0F,$FE,$11,$00,$00,$FB
	db $FB,$00,$40,$00,$FB,$0F,$11,$00,$00,$EB,$10,$11,$00,$00,$FA,$F2
	db $10,$40,$00,$EE,$F4,$01,$00,$00,$09,$10,$01,$40,$00,$FB,$1A,$00
	db $40,$00,$0E,$FD,$00,$40,$00,$FA,$FC,$01,$40,$00,$F9,$10,$00,$40
	db $00,$EC,$11,$00,$00,$00,$F9,$F3,$00,$40,$00,$ED,$F6,$00,$00,$00
	db $0B,$13,$00,$40,$00,$FA,$1D,$01,$40,$00,$0D,$FE,$01,$40,$00,$FB
	db $FE,$01,$C0,$00,$FA,$11,$01,$40,$00,$ED,$11,$01,$00,$00,$F9,$F3
	db $01,$40,$00,$EB,$FC,$10,$00,$00,$0C,$16,$10,$40,$00,$F9,$1E,$01
	db $40,$00,$0D,$FF,$01,$40,$00,$FB,$00,$00,$C0,$00,$FA,$12,$01,$C0
	db $00,$ED,$13,$01,$00,$00,$F9,$F5,$01,$40,$00,$E9,$FE,$11,$00,$00
	db $0D,$19,$11,$00,$00,$FA,$20,$00,$40,$00,$0E,$02,$00,$40,$00,$FB
	db $01,$10,$C0,$00,$FA,$15,$01,$C0,$00,$EC,$16,$00,$00,$00,$FA,$F8
	db $00,$40,$00,$E9,$FD,$10,$40,$00,$0F,$1A,$10,$00,$00,$FB,$23,$10
	db $40,$00,$0E,$05,$10,$40,$00,$FC,$03,$10,$C0,$00,$FA,$17,$01,$40
	db $00,$EC,$19,$10,$00,$00,$FB,$FB,$10,$40,$00,$E9,$FD,$00,$40,$00
	db $11,$1C,$01,$00,$00,$FD,$26,$00,$00,$00,$11,$08,$01,$00,$00,$FB
	db $09,$00,$C0,$00,$FB,$1C,$10,$00,$00,$E9,$1C,$00,$40,$00,$E9,$00
	db $01,$40,$00,$10,$1B,$00,$00,$00,$FC,$25,$10,$00,$00,$10,$09,$10
	db $00,$00,$FC,$06,$10,$C0,$00,$FB,$1A,$10,$40,$00,$EA,$1B,$10,$40
	db $00,$FB,$FD,$11,$00,$00,$E9,$FE,$01,$40,$00,$12,$1D,$01,$00,$00
	db $FE,$28,$01,$00,$00,$11,$09,$01,$00,$00,$FB,$0B,$00,$C0,$00,$FD
	db $1D,$01,$00,$00,$E9,$04,$00,$40,$00,$11,$21,$00,$00,$00,$10,$0C
	db $00,$00,$00,$FA,$0E,$01,$C0,$00,$FD,$1E,$01,$00,$00,$EA,$07,$10
	db $40,$00,$10,$0E,$10,$00,$00,$FB,$11,$01,$40,$00,$FC,$22,$10,$00
	db $00,$EA,$0A,$10,$00,$00,$0F,$13,$11,$00,$00,$FB,$25,$11,$00,$00
	db $EB,$0A,$00,$00,$00,$FA,$26,$10,$40,$00,$EB,$0B,$01,$00,$00,$F9
	db $27,$01,$40,$00

;---------------------------------------------------------------------------

DATA_00A54D:
	db $00,$F8,$00,$08

CODE_00A551:
	JSR.w CODE_008AE5
	LDY.b #$00
	LDA.w $7142,x
	CMP.w $7E4C,x
	BPL.b CODE_00A560
	INY
	INY
CODE_00A560:
	LDA.w DATA_00A54D,y
	STA.w $75A2,x
	RTS

;---------------------------------------------------------------------------

DATA_00A567:
	db $07,$07,$05,$04,$04,$04,$04,$04

CODE_00A56F:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A58B
	DEC.w $73C2,x
	BPL.b CODE_00A57F
	JMP.w CODE_008AF8

CODE_00A57F:
	LDY.w $73C2,x
	LDA.w DATA_00A567,y
	AND.w #$00FF
	STA.w $7782,x
CODE_00A58B:
	RTS

;---------------------------------------------------------------------------

DATA_00A58C:
	db $06,$06,$06,$06,$06,$05,$05,$05
	db $05,$05,$05,$04,$04,$04

CODE_00A59A:
	PHX
	TXA
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #DATA_00A5EB>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_00A5EB
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_098CB1>>16
	LDA.w #FXCODE_098CB1
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PLX
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A5DB
	DEC.w $73C2,x
	BPL.b CODE_00A5C8
	JMP.w CODE_008AF8

CODE_00A5C8:
	SEP.b #$20
	LDY.w $73C2,x
	LDA.w DATA_00A5DC,y
	STA.w $7001,x
	LDA.w DATA_00A58C,y
	STA.w $7782,x
	REP.b #$20
CODE_00A5DB:
	RTS

DATA_00A5DC:
	db $08,$08,$08,$10,$18,$20,$18,$18,$18,$18,$10,$10,$10,$08,$08

DATA_00A5EB:
	db $A4,$A6,$9F,$A6,$9A,$A6,$90,$A6,$81,$A6,$6D,$A6,$5E,$A6,$4F,$A6
	db $40,$A6,$31,$A6,$27,$A6,$1D,$A6,$13,$A6,$0E,$A6,$09,$A6,$00,$00
	db $E3,$06,$02,$00,$01,$E3,$06,$02,$00,$00,$F8,$06,$00,$00,$03,$E3
	db $06,$02,$00,$00,$F8,$46,$00,$00,$06,$E3,$06,$02,$00,$00,$F8,$06
	db $00,$00,$0A,$E5,$06,$02,$08,$09,$F8,$06,$00,$00,$01,$F7,$46,$00
	db $00,$0E,$E5,$46,$02,$08,$0A,$F8,$46,$00,$00,$03,$F7,$06,$00,$00
	db $12,$E5,$06,$02,$08,$0C,$F7,$06,$00,$00,$05,$F7,$46,$00,$00,$16
	db $E5,$46,$02,$08,$0E,$F7,$46,$00,$00,$07,$F7,$06,$00,$00,$1A,$E7
	db $06,$02,$00,$0B,$E1,$06,$00,$04,$18,$F8,$06,$00,$08,$10,$E1,$06
	db $00,$00,$1E,$E7,$46,$02,$04,$19,$F8,$46,$00,$08,$12,$E1,$06,$00
	db $00,$22,$E7,$86,$02,$04,$1B,$F8,$06,$00,$00,$26,$E7,$C6,$02,$04
	db $1D,$59,$06,$00,$04,$1F,$F7,$46,$00,$04,$21,$E1,$06,$00

;---------------------------------------------------------------------------

CODE_00A6A9:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A6B4
	JMP.w CODE_008AF8

CODE_00A6B4:
	LDA.w $7E8E,x
	BNE.b CODE_00A6CD
	SEP.b #$20
	LDA.b #$02
	STA.w $7E8E,x
	DEC.w $73C2,x
	BPL.b CODE_00A6CB
	LDA.w $7E4C,x
	STA.w $73C2,x
CODE_00A6CB:
	REP.b #$20
CODE_00A6CD:
	RTS

;---------------------------------------------------------------------------

CODE_00A6CE:
	JSR.w CODE_008AE5
	LDA.w $7820,x
	AND.w #$0001
	BEQ.b CODE_00A701
	LDA.w $73C2,x
	BNE.b CODE_00A6E4
	LDA.w #$001C
	STA.w $6F62,x
CODE_00A6E4:
	CMP.w #$0003
	BEQ.b CODE_00A6EC
	INC.w $73C2,x
CODE_00A6EC:
	LDA.w $71E2,x
	BMI.b CODE_00A701
	LSR
	CMP.w #$0020
	BCS.b CODE_00A6FA
	JMP.w CODE_008AF8

CODE_00A6FA:
	EOR.w #$FFFF
	INC
	STA.w $71E2,x
CODE_00A701:
	RTS

;---------------------------------------------------------------------------

DATA_00A702:
	db $0A,$09,$08,$07,$06,$05,$04,$03
	db $02,$01,$00,$00

DATA_00A70E:
	db $04,$04,$03,$03,$02,$02,$01,$01
	db $01,$01,$01,$01

DATA_00A71A:
	db $01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$FF,$01

CODE_00A726:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A74F
	DEC.w $7E4C,x
	BPL.b CODE_00A736
	JMP.w CODE_008AF8

CODE_00A736:
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_00A702,y
	STA.w $73C2,x
	LDA.w DATA_00A70E,y
	STA.w $7782,x
	LDA.w DATA_00A71A,y
	STA.w $7462,x
	REP.b #$20
CODE_00A74F:
	RTS

;---------------------------------------------------------------------------

DATA_00A750:
	db $03,$03,$03,$03,$03,$03,$03,$02,$02

CODE_00A759:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A775
	DEC.w $73C2,x
	BPL.b CODE_00A769
	JMP.w CODE_008AF8

CODE_00A769:
	LDY.w $73C2,x
	LDA.w DATA_00A750,y
	AND.w #$00FF
	STA.w $7782,x
CODE_00A775:
	RTS

;---------------------------------------------------------------------------

CODE_00A776:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A78C
	DEC.w $73C2,x
	BPL.b CODE_00A786
	JMP.w CODE_008AF8

CODE_00A786:
	LDA.w #$0003
	STA.w $7782,x
CODE_00A78C:
	RTS

;---------------------------------------------------------------------------

CODE_00A78D:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A7A3
	DEC.w $73C2,x
	BPL.b CODE_00A79D
	JMP.w CODE_008AF8

CODE_00A79D:
	LDA.w #$0004
	STA.w $7782,x
CODE_00A7A3:
	RTS

;---------------------------------------------------------------------------

CODE_00A7A4:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A7D0
	SEP.b #$20
	LDA.b #$01
	STA.w $7462,x
	REP.b #$20
	LDA.w #$0004
	STA.w $7782,x
	DEC.w $73C2,x
	BPL.b CODE_00A7D0
	LDA.w #$0001
	STA.w $73C2,x
	LDA.w $7142,x
	CLC
	ADC.w #$0008
	STA.w $7142,x
CODE_00A7D0:
	RTS

;---------------------------------------------------------------------------

DATA_00A7D1:
	db $03,$03,$02,$02,$02,$01,$01,$01,$02

CODE_00A7DA:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A7F6
	DEC.w $73C2,x
	BPL.b CODE_00A7EA
	JMP.w CODE_008AF8

CODE_00A7EA:
	LDY.w $73C2,x
	LDA.w DATA_00A7D1,y
	AND.w #$00FF
	STA.w $7782,x
CODE_00A7F6:
	RTS

;---------------------------------------------------------------------------

CODE_00A7F7:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A80D
	DEC.w $73C2,x
	BPL.b CODE_00A807
	JMP.w CODE_008AF8

CODE_00A807:
	LDA.w #$0002
	STA.w $7782,x
CODE_00A80D:
	RTS

;---------------------------------------------------------------------------

CODE_00A80E:
	JSR.w CODE_008AF2
	RTS

;---------------------------------------------------------------------------

DATA_00A812:
	db $2C,$28,$24,$20,$1C,$18,$FF,$14
	db $FF,$10,$FF,$0C,$FF,$08,$FF,$04
	db $FF,$00

DATA_00A824:
	db $04,$04,$04,$04,$04,$04,$02,$02
	db $02,$02,$02,$02,$02,$02,$02,$02
	db $02

CODE_00A835:
	LDY.w $7E4C,x
	LDA.w DATA_00A812-$01,y
	BMI.b CODE_00A890
	XBA
	ORA.w $7E4E,x
	AND.w #$00FF
	STA.w $73C2,x
	STX.b $00
	TXA
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #DATA_00A8AE>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_00A8AE
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_098CB1>>16
	LDA.w #FXCODE_098CB1
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $00
	LDA.w #$0004
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LDA.w $70A2,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7142,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $78C2,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7322,x
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDX.b #FXCODE_09F5F4>>16
	LDA.w #FXCODE_09F5F4
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $00
CODE_00A890:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00A8AD
	DEC.w $7E4C,x
	BPL.b CODE_00A8A0
	JMP.w CODE_008AF8

CODE_00A8A0:
	SEP.b #$20
	LDY.w $7E4C,x
	LDA.w DATA_00A824,y
	STA.w $7782,x
	REP.b #$20
CODE_00A8AD:
	RTS

DATA_00A8AE:
	dw $A90E,$AA12,$AB16,$AC1A,$A922,$AA26,$AB2A,$AC2E
	dw $A936,$AA3A,$AB3E,$AC42,$A94A,$AA4E,$AB52,$AC56
	dw $A95E,$AA62,$AB66,$AC6A,$A972,$AA76,$AB7A,$AC7E
	dw $A986,$AA8A,$AB8E,$AC92,$A99A,$AA9E,$ABA2,$ACA6
	dw $A9AE,$AAB2,$ABB6,$ACBA,$A9C2,$AAC6,$ABCA,$ACCE
	dw $A9D6,$AADA,$ABDE,$ACE2,$A9EA,$AAEE,$ABF2,$ACF6

;---------------------------------------------------------------------------

DATA_00A90E:
	db $FC,$00,$42,$C2,$02,$FC,$F0,$42,$42,$02,$EC,$00,$42,$82,$02,$EC
	db $F0,$42,$02,$02,$0C,$FC,$42,$C2,$02,$FC,$FC,$42,$82,$02,$0C,$EC
	db $42,$42,$02,$FC,$EC,$42,$02,$02,$14,$08,$42,$C2,$02,$14,$F8,$42
	db $42,$02,$04,$08,$42,$82,$02,$04,$F8,$42,$02,$02,$0C,$14,$42,$C2
	db $02,$FC,$14,$42,$82,$02,$0C,$04,$42,$42,$02,$FC,$04,$42,$02,$02
	db $FC,$10,$42,$C2,$02,$EC,$10,$42,$82,$02,$FC,$00,$42,$42,$02,$EC
	db $00,$42,$02,$02,$08,$08,$42,$C2,$02,$F8,$08,$42,$82,$02,$08,$F8
	db $42,$42,$02,$F8,$F8,$42,$02,$02,$08,$04,$E3,$06,$02,$FC,$08,$E3
	db $06,$02,$04,$FC,$E3,$06,$02,$F8,$F8,$E3,$06,$02,$08,$02,$E3,$06
	db $02,$FC,$06,$E3,$06,$02,$04,$FA,$E3,$06,$02,$F8,$F6,$E5,$06,$02
	db $08,$00,$E5,$06,$02,$FC,$04,$E3,$06,$02,$04,$F8,$E3,$06,$02,$F8
	db $F4,$E7,$06,$02,$08,$EE,$E0,$02,$00,$08,$FE,$E7,$06,$02,$FC,$02
	db $E3,$06,$02,$04,$F6,$E5,$06,$02,$08,$EC,$E0,$02,$00,$08,$E4,$E0
	db $02,$00,$FC,$00,$E5,$06,$02,$04,$F4,$E7,$06,$02,$08,$F6,$E0,$02
	db $00,$08,$EE,$E0,$02,$00,$08,$E6,$E0,$02,$00,$FC,$FE,$E7,$06,$02
	db $00,$10,$E0,$02,$00,$00,$08,$E0,$02,$00,$00,$00,$E0,$02,$00,$00
	db $F8,$E0,$02,$00,$FF,$02,$60,$C3,$02,$FF,$F2,$60,$43,$02,$EF,$02
	db $60,$83,$02,$EF,$F2,$60,$03,$02,$0B,$FF,$60,$C3,$02,$FB,$FF,$60
	db $83,$02,$0B,$EF,$60,$43,$02,$FB,$EF,$60,$03,$02,$11,$08,$60,$C3
	db $02,$11,$F8,$60,$43,$02,$01,$08,$60,$83,$02,$01,$F8,$60,$03,$02
	db $0B,$11,$60,$C3,$02,$FB,$11,$60,$83,$02,$0B,$01,$60,$43,$02,$FB
	db $01,$60,$03,$02,$FF,$0E,$60,$C3,$02,$EF,$0E,$60,$83,$02,$FF,$FE
	db $60,$43,$02,$EF,$FE,$60,$03,$02,$08,$08,$60,$C3,$02,$F8,$08,$60
	db $83,$02,$08,$F8,$60,$43,$02,$F8,$F8,$60,$03,$02,$06,$03,$63,$07
	db $02,$FD,$06,$63,$07,$02,$03,$FD,$63,$07,$02,$FA,$FA,$63,$07,$02
	db $06,$01,$63,$07,$02,$FD,$04,$63,$07,$02,$03,$FB,$63,$07,$02,$FA
	db $F8,$65,$07,$02,$06,$00,$65,$07,$02,$FD,$03,$63,$07,$02,$03,$FA
	db $63,$07,$02,$FA,$F7,$67,$07,$02,$08,$F0,$E0,$02,$00,$06,$FE,$67
	db $07,$02,$FD,$01,$63,$07,$02,$03,$F8,$65,$07,$02,$08,$E7,$E0,$02
	db $00,$08,$EF,$E0,$02,$00,$FD,$00,$65,$07,$02,$03,$F7,$67,$07,$02
	db $08,$E5,$E0,$02,$00,$08,$ED,$E0,$02,$00,$08,$F5,$E0,$02,$00,$FD
	db $FD,$67,$07,$02,$00,$10,$E0,$02,$00,$00,$08,$E0,$02,$00,$00,$00
	db $E0,$02,$00,$00,$F8,$E0,$02,$00,$02,$04,$72,$C3,$00,$02,$FC,$72
	db $43,$00,$FA,$04,$72,$83,$00,$FA,$FC,$72,$03,$00,$0A,$02,$72,$C3
	db $00,$02,$02,$72,$83,$00,$0A,$FA,$72,$43,$00,$02,$FA,$72,$03,$00
	db $0E,$08,$72,$C3,$00,$0E,$00,$72,$43,$00,$06,$08,$72,$83,$00,$06
	db $00,$72,$03,$00,$0A,$0E,$72,$C3,$00,$02,$0E,$72,$83,$00,$0A,$06
	db $72,$43,$00,$02,$06,$72,$03,$00,$02,$0C,$72,$C3,$00,$FA,$0C,$72
	db $83,$00,$02,$04,$72,$43,$00,$FA,$04,$72,$03,$00,$08,$08,$72,$C3
	db $00,$00,$08,$72,$83,$00,$08,$00,$72,$43,$00,$00,$00,$72,$03,$00
	db $00,$00,$69,$07,$00,$06,$02,$69,$07,$00,$08,$06,$69,$07,$00,$02
	db $08,$69,$07,$00,$00,$FF,$6A,$07,$00,$06,$01,$69,$07,$00,$08,$05
	db $69,$07,$00,$02,$07,$69,$07,$00,$00,$FE,$6B,$07,$00,$06,$00,$69
	db $07,$00,$08,$04,$6A,$07,$00,$02,$06,$69,$07,$00,$08,$F7,$E0,$02
	db $00,$06,$FF,$6A,$07,$00,$08,$03,$6B,$07,$00,$02,$05,$69,$07,$00
	db $08,$EE,$E0,$02,$00,$08,$F6,$E0,$02,$00,$06,$FE,$6B,$07,$00,$02
	db $04,$6A,$07,$00,$08,$E5,$E0,$02,$00,$08,$ED,$E0,$02,$00,$08,$FB
	db $E0,$02,$00,$02,$03,$6B,$07,$00,$00,$10,$E0,$02,$00,$00,$08,$E0
	db $02,$00,$00,$00,$E0,$02,$00,$00,$F8,$E0,$02,$00,$05,$06,$62,$C3
	db $00,$05,$FE,$62,$43,$00,$FD,$06,$62,$83,$00,$FD,$FE,$62,$03,$00
	db $0B,$FD,$62,$43,$00,$0B,$05,$62,$C3,$00,$03,$05,$62,$83,$00,$03
	db $FD,$62,$03,$00,$0B,$00,$62,$43,$00,$0B,$08,$62,$C3,$00,$03,$08
	db $62,$83,$00,$03,$00,$62,$03,$00,$03,$0B,$62,$83,$00,$0B,$03,$62
	db $43,$00,$0B,$0B,$62,$C3,$00,$03,$03,$62,$03,$00,$04,$0A,$62,$C3
	db $00,$04,$02,$62,$43,$00,$FC,$0A,$62,$83,$00,$FC,$02,$62,$03,$00
	db $08,$00,$62,$43,$00,$08,$08,$62,$C3,$00,$00,$08,$62,$83,$00,$00
	db $00,$62,$03,$00,$05,$03,$79,$07,$00,$06,$05,$79,$07,$00,$03,$06
	db $79,$07,$00,$02,$02,$79,$07,$00,$05,$02,$79,$07,$00,$06,$04,$79
	db $07,$00,$03,$05,$79,$07,$00,$02,$01,$7A,$07,$00,$05,$02,$79,$07
	db $00,$06,$04,$7A,$07,$00,$03,$05,$79,$07,$00,$02,$01,$7B,$07,$00
	db $08,$F9,$E0,$02,$00,$05,$01,$7A,$07,$00,$06,$03,$7B,$07,$00,$03
	db $04,$79,$07,$00,$08,$F1,$E0,$02,$00,$08,$F9,$E0,$02,$00,$05,$01
	db $7B,$07,$00,$03,$04,$7A,$07,$00,$08,$EB,$E0,$02,$00,$08,$F3,$E0
	db $02,$00,$08,$FB,$E0,$02,$00,$03,$03,$7B,$07,$00

;---------------------------------------------------------------------------

CODE_00AD0A:
	LDA.w $7322,x
	BMI.b CODE_00AD61
	REP.b #$10
	TAY
	LDA.w $7E4C,x
	STA.b $00
	LDA.w $6000,y
	SEC
	SBC.b $00
	STA.w $6000,y
	LDA.w $6002,y
	SEC
	SBC.b $00
	STA.w $6002,y
	LDA.w $6008,y
	CLC
	ADC.b $00
	STA.w $6008,y
	LDA.w $600A,y
	SEC
	SBC.b $00
	STA.w $600A,y
	LDA.w $6010,y
	SEC
	SBC.b $00
	STA.w $6010,y
	LDA.w $6012,y
	CLC
	ADC.b $00
	STA.w $6012,y
	LDA.w $6018,y
	CLC
	ADC.b $00
	STA.w $6018,y
	LDA.w $601A,y
	CLC
	ADC.b $00
	STA.w $601A,y
	SEP.b #$10
CODE_00AD61:
	JSR.w CODE_008AE5
	LDA.w $7782,x
	BNE.b CODE_00AD6C
	JMP.w CODE_008AF8

CODE_00AD6C:
	RTS

;---------------------------------------------------------------------------

DATA_00AD6D:
	db $19,$00,$F8

DATA_00AD70:
	db $00,$10,$12,$00,$92,$00,$04,$76,$00,$95,$00,$06,$72,$00,$C0,$00
	db $20,$4F,$00,$60,$F3,$00,$98,$00,$10,$F4,$00,$A0,$00,$10,$F0,$00
	db $00,$F1,$00,$08,$F2,$00,$70,$F7,$00,$D0,$00,$04,$F8,$00,$D2,$00
	db $04,$F9,$00,$D4,$00,$04,$FA,$00,$D6,$00,$04,$FB,$00,$D8,$00,$04
	db $FC,$00,$DA,$00,$04,$F5,$00,$28,$F6,$00,$2C,$FF,$F0,$00,$34,$1D
	db $00,$38,$73,$00,$DC,$00,$08,$73,$00,$FC,$00,$08,$74,$00,$BC,$00
	db $08,$B1,$00,$00,$FF,$72,$00,$C0,$00,$20,$FF,$10,$00,$C0,$00,$10
	db $11,$00,$C8,$00,$10,$FF,$27,$00,$78,$87,$00,$80,$00,$20,$88,$00
	db $90,$00,$20,$89,$00,$A0,$00,$20,$8B,$00,$B0,$00,$20,$8A,$00,$C0
	db $00,$20,$4A,$00,$50,$73,$00,$74,$74,$00,$60,$75,$00,$68,$FF,$F0
	db $00,$00,$F1,$00,$08,$7E,$00,$14,$F2,$00,$B8,$00,$08,$F3,$00,$BC
	db $00,$08,$56,$00,$10,$F4,$00,$30,$F5,$00,$C0,$00,$08,$F6,$00,$C4
	db $00,$08,$F7,$00,$C8,$00,$08,$F8,$00,$CC,$00,$08,$F9,$00,$D0,$00
	db $08,$FA,$00,$D4,$00,$08,$FB,$00,$D8,$00,$08,$FC,$00,$DC,$00,$08
	db $8F,$00,$E0,$00,$10,$8C,$00,$F0,$00,$10,$73,$00,$FC,$00,$08,$FF
	db $21,$00,$70,$22,$00,$74,$14,$00,$F8,$00,$10,$15,$00,$90,$00,$10
	db $16,$00,$98,$00,$10,$1C,$00,$28,$4E,$00,$2C,$72,$00,$C0,$00,$20
	db $13,$00,$D0,$00,$10,$F0,$00,$68,$F2,$00,$38,$F4,$00,$34,$FF,$41
	db $00,$70,$19,$00,$F8,$00,$10,$25,$00,$00,$26,$00,$08,$F0,$00,$98
	db $00,$10,$F1,$00,$A0,$00,$10,$50,$00,$28,$4E,$00,$2C,$72,$00,$C0
	db $00,$20,$24,$00,$50,$4E,$00,$D8,$00,$04,$F2,$00,$68,$F3,$00,$38
	db $FF,$F0,$00,$00,$F1,$00,$10,$F2,$00,$20,$F3,$00,$30,$F4,$00,$00
	db $72,$00,$C0,$00,$20,$4F,$00,$60,$F5,$00,$D0,$00,$04,$F6,$00,$D2
	db $00,$04,$F7,$00,$D4,$00,$04,$F8,$00,$D6,$00,$04,$F9,$00,$D8,$00
	db $04,$FA,$00,$DA,$00,$04,$FF,$1B,$00,$70,$1E,$00,$74,$1E,$00,$78
	db $72,$00,$C0,$00,$20,$4F,$00,$60,$AF,$00,$28,$AF,$00,$30,$AF,$00
	db $38,$67,$00,$D0,$00,$04,$3C,$00,$D2,$00,$04,$55,$00,$D4,$00,$04
	db $1A,$00,$D6,$00,$04,$1A,$00,$D8,$00,$04,$29,$00,$DA,$00,$04,$FF
	db $B3,$00,$D4,$00,$10,$AA,$00,$5C,$FF

DATA_00AF39:
	db $00,$01,$40,$02,$03,$41,$08,$09,$44,$0A,$0B,$45,$04,$05,$42,$06
	db $07,$43,$0C,$0D,$46,$0E,$0F,$47,$30,$31,$40,$32,$33,$41,$38,$39
	db $46,$3A,$3B,$45,$34,$35,$42,$36,$37,$47,$3C,$3D,$46,$3E,$3F,$47

DATA_00AF69:
	db $00,$01,$40,$69,$6A,$6B,$08,$09,$44,$0A,$0B,$45,$04,$05,$42,$06
	db $07,$43,$0C,$0D,$46,$0E,$0F,$47,$30,$31,$40,$32,$33,$41,$38,$39
	db $46,$3A,$3B,$45,$34,$35,$42,$36,$37,$47,$3C,$3D,$46,$3E,$3F,$47

DATA_00AF99:
	dw $1817,$A308,$0302,$0100,$0100,$7E77,$900C,$0B0A
	dw $0706,$7877,$0E79,$7A04,$7C7B,$A47D,$7E7F,$8281
	dw $7877,$0500,$0500,$8483,$8180,$8685,$A2A1,$0908
	dw $7E0D,$900E,$8685,$8685,$0909,$A6A5,$7B7A,$A8A7

DATA_00AFD9:
	dw $4E4D,$1514,$1516,$1818,$5251,$1516,$1516,$1516
	dw $1516,$1313,$4E12,$1516,$111A,$1110,$2928,$2B2A
	dw $4E4D,$6310,$1715,$4E4E,$5251,$5253,$5C5B,$5454
	dw $541B,$5251,$5251,$1718,$1414,$4E4E,$1919,$4E4D
	dw $1861,$5251,$4E62,$6319,$4E64,$6565,$1766,$5267
	dw $6262,$5857,$1919,$5857,$6268,$6268,$5857,$5859

DATA_00B039:
	dw $2120,$2B2A,$295E,$2120,$1C5E,$2931,$2C1F,$4036
	dw $2951,$5E2E,$1A37,$1F1A,$5E55,$1F5F,$291A,$4053
	dw $1A51,$291A,$2A36,$3C2B,$712D,$364A,$711C,$5931
	dw $1A6A,$1A1A,$1A1A,$7150,$312F,$2949,$5755,$715D
	dw $2F1C,$7155,$573C,$1C4A,$3F3C,$711F,$1A1A,$7125
	dw $1A1C,$1A1A,$1A2E,$1A1A,$1F1A,$5736,$1C38,$295C
	dw $3B3A,$5531,$2971,$6160,$221C,$2523,$251C,$4342
	dw $294F,$5B5A,$255C,$296A,$371F,$4239,$1A43,$3527
	dw $3D4E,$301A,$1C4E,$4651,$2971,$2322,$6045,$301A
	dw $4342,$3938,$591C,$1D60,$4E71,$301C,$1D60,$4640
	dw $304E,$1D55,$4E60,$1A51,$6336,$5C1F,$291A,$1D39
	dw $1B35,$3063,$1A71,$5F51,$3060,$632A,$1A1A,$1A1A
	dw $3E27,$3D1A,$1A1A,$2B25,$6447,$1F36,$6151,$6548
	dw $601C,$1C48,$2865,$7160,$451C,$711F,$296A,$6A4D
	dw $1F48,$291A,$6028,$4E38,$5136,$1A1A,$1A2D,$1A1A
	dw $3545,$6454,$1C1F,$5854,$3D35,$6471,$4135,$641F
	dw $1C5C,$3332,$4134,$544C,$1E64,$1F41,$291C,$1E55
	dw $6028,$5C71,$4C64,$4041,$2968,$5C2F,$1C5D,$1A1A
	dw $6527,$AA49,$1F1C,$4861,$1C71,$6A55,$3C71,$3F60
	dw $AA49,$1A53,$551C,$5931,$4342,$1F55,$1A41,$2B2A
	dw $7129,$5D1C,$1F55,$2A27,$291A,$2B4F,$5247,$5160
	dw $472B,$7138,$5160,$2940,$4E31,$591C,$1A1C,$4E1A
	dw $1A1A,$472B,$5226,$2956,$472B,$5226,$2931,$472B
	dw $291F,$5131,$472B,$1E2F,$2971,$1A29,$531A,$1F1B
	dw $4031,$1A1F,$1A1A,$3541,$7139,$291F,$472B,$4924
	dw $1F1A,$5C1F,$4E49,$475D,$3B3A,$1A1C,$291A,$1A1F
	dw $1A38,$1A1A,$472B,$5437,$2971,$3C3F,$1C66,$6047
	dw $3531,$5471,$1F55,$1F2E,$2449,$295E,$5458,$1F5E
	dw $2948,$6560,$7130,$1A1A,$295E,$2671,$4B49,$2F55
	dw $6458,$592C,$245E,$291C,$4B49,$2527,$4938,$292A
	dw $361F,$1A4E,$1A1A,$1F4D,$2855,$7160,$712E,$1A1C
	dw $1A1A,$3935,$2541,$2964,$2564,$4136,$291A,$444E
	dw $3D1A,$2948,$1E5D,$3D36,$4825,$4342,$6A44,$1A1A
	dw $4564,$1A1A,$291F,$2B2A,$6A38,$5E6C,$3155,$1A1A
	dw $1F1A,$3E35,$3D1C,$472B,$2B2A,$635E,$1A1A,$1A24
	dw $1A1A,$1A1A,$361A,$2931,$5966,$3A40,$373B,$1A36
	dw $702F,$6A61,$1F1A,$6C6B,$6A1A,$1F47,$5C57,$245D
	dw $291C,$711B,$1C29,$5D1F,$5C55,$455F,$3771,$6D6F
	dw $296E,$1A6A,$6A55,$1AA9,$1F1A,$3C62,$534E,$4471
	dw $6A68,$1A1A,$1A1A,$1E1A,$1F52,$2971,$445D,$564C
	dw $1A1A,$291C,$2A44,$4E71,$7145,$581C,$1A1A,$2555
	dw $1F71,$1C29,$375D,$2971,$1A1C,$6A45,$1A1F,$1A1A
	dw $641F,$5341,$1C3E,$7153,$1C5D,$1A1A,$1C36,$2838
	dw $2960,$472B,$2120,$711C,$2120,$1C2F,$475D,$3527
	dw $5441,$6864,$711C,$2D2C,$1A1A,$6C6A,$1A63,$1A1A
	dw $2322,$6045,$301A,$3C67,$1A55,$291A,$7154,$4C41
	dw $3764,$AEAD,$B0AF,$6A67,$4755,$4957,$291C,$2B27
	dw $1C47,$2925,$7127,$311C,$1A1A,$451C,$711F,$2946

CODE_00B339:
	PHB
	PHK
	PLB
	REP.b #$30
	LDA.w $0136
	ASL
	ADC.w $0136
	TAY
	LDA.w $0218
	CMP.w #$000A
	BNE.b CODE_00B35A
	LDA.w DATA_00AF69,y
	STA.b $10
	LDA.w DATA_00AF69+$01,y
	STA.b $11
	BRA.b CODE_00B364

CODE_00B35A:
	LDA.w DATA_00AF39,y
	STA.b $10
	LDA.w DATA_00AF39+$01,y
	STA.b $11
CODE_00B364:
	LDA.w $013A
	ASL
	TAY
	LDA.w DATA_00AF99,y
	STA.b $13
	LDA.w $013E
	ASL
	TAY
	LDA.w DATA_00AFD9,y
	STA.b $15
	LDA.w $0142
	ASL
	ADC.w $0142
	ASL
	TAY
	LDA.w DATA_00B039,y
	STA.w $6EB6
	STA.b $17
	LDA.w DATA_00B039+$02,y
	STA.w $6EB8
	STA.b $19
	LDA.w DATA_00B039+$04,y
	STA.w $6EBA
	STA.b $1B
	SEP.b #$20
	LDY.w #$0000
CODE_00B39E:
	LDA.b #$16
	STA.w $012D
	LDA.b #!SuperFX_ScreenMode_ScreenHeight_160pixels|!SuperFX_ScreenMode_ColorMode_16Colors|!SuperFX_ScreenMode_SuperFXHasWRAMAccess|!SuperFX_ScreenMode_SuperFXHasROMAccess|!SuperFX_ScreenMode_ColorMode_Unused
	STA.w $012E
CODE_00B3A8:
	LDA.w DATA_00AD6D,y
	CMP.b #$F0
	BCC.b CODE_00B3C0
	CMP.b #$FF
	BEQ.b CODE_00B3CB
	SEC
	SBC.b #$F0
	REP.b #$20
	AND.w #$00FF
	TAX
	SEP.b #$20
	LDA.b $10,x
CODE_00B3C0:
	LDX.w DATA_00AD6D+$01,y
	JSR.w CODE_00B507
	INY
	INY
	INY
	BRA.b CODE_00B3A8

CODE_00B3CB:
	SEP.b #$10
	PLB
	RTL

;---------------------------------------------------------------------------

CODE_00B3CF:
	PHB
	PHK
	PLB
	LDA.b #$68
	STA.b $10
	LDA.w $011A
	CMP.b #$80
	BEQ.b CODE_00B3E6
	LDA.w $0216
	BNE.b CODE_00B3E6
	LDA.b #$1F
	STA.b $10
CODE_00B3E6:
	REP.b #$10
	LDY.w #$004F
	JMP.w CODE_00B39E

;---------------------------------------------------------------------------

CODE_00B3EE:
	PHB
	PHK
	PLB
	JMP.w CODE_00B39E

;---------------------------------------------------------------------------

DATA_00B3F4:
	db $7C,$7D,$7F,$80,$81,$82,$83,$84,$85,$86,$87,$88,$74,$B5,$B7,$75
	db $B6,$B8,$4C,$6C,$6D

DATA_00B409:
	db $99,$9A,$9B,$9C,$9D,$9E,$9F,$A0
	db $99,$9A,$9B,$9C,$9D,$9E,$9F,$A0
	db $99,$9A,$9B,$9C,$9D,$9E,$9F,$A0
	db $99,$9A,$9B,$9C,$9D,$9E,$9F,$A0
	db $99,$9A,$9B,$9C,$9D,$9E,$9F,$A0
	db $99,$9A,$9B,$9C,$95,$96,$97,$98

CODE_00B439:
	PHB
	PHK
	PLB
	LDA.b #$74
	STA.b $12
	LDA.b #$75
	STA.b $13
	LDA.b #$4C
	STA.b $14
	LDY.w $0218
	LDA.w DATA_00B3F4,y
	STA.b $10
	LDA.w DATA_00B3F4+$01,y
	STA.b $11
	TYA
	ASL
	ASL
	TAY
	LDX.b #$00
CODE_00B45B:
	LDA.w DATA_00B409,y
	STA.b $15,x
	INY
	INX
	CPX.b #$08
	BCC.b CODE_00B45B
	REP.b #$10
	LDY.w #$00A2
	JMP.w CODE_00B39E

;---------------------------------------------------------------------------

DATA_00B46E:
	db $04,$04,$04,$79,$04,$04,$04,$77,$04,$0C,$0C,$04

DATA_00B47A:
	db $04,$04,$04,$7A,$04,$04,$04,$78,$05,$04,$04,$04

DATA_00B486:
	db $96,$96,$96,$96,$97,$98,$98,$9A,$9B,$99,$99,$96

DATA_00B492:
	db $9C,$9C,$9C,$9F,$9C,$9C,$9C,$A0,$A1,$9C,$9C,$9C

CODE_00B49E:
	PHB
	PHK
	PLB
	LDA.w DATA_00B46E,y
	STA.b $10
	LDA.w DATA_00B47A,y
	STA.b $11
	LDA.w DATA_00B486,y
	STA.b $12
	LDA.w DATA_00B492,y
	STA.b $13
	LDA.b #$4E
	STA.w $6EBA
	LDA.b #$FF
	STA.w $6EB6
	STA.w $6EB7
	STA.w $6EB8
	STA.w $6EB9
	STA.w $6EBB
	REP.b #$10
	LDY.w #$0122
	JMP.w CODE_00B39E

;---------------------------------------------------------------------------

CODE_00B4D3:
	PHB
	PHK
	PLB
	LDX.b #$18
	JSL.l CODE_00BDA2
	LDA.b #$38
	STA.w !REGISTER_BG4AddressAndSize
	LDA.b #$67
	STA.w $6EB6
	LDA.b #$3C
	STA.w $6EB7
	LDA.b #$55
	STA.w $6EB8
	LDA.b #$1A
	STA.w $6EB9
	LDA.b #$1A
	STA.w $6EBA
	LDA.b #$29
	STA.w $6EBB
	REP.b #$10
	LDY.w #$018A
	JMP.w CODE_00B39E

;---------------------------------------------------------------------------

CODE_00B507:
	STX.b $0E
CODE_00B509:
	REP.b #$20
	AND.w #$00FF
	STA.b $0C
	ASL
	ADC.b $0C
	TAX
	LDA.b $0E
	BPL.b CODE_00B54D
	LDA.w DATA_00AD70,y
	STA.b $0A
	INY
	INY
	PHY
	ASL
	ASL
	XBA
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_06FC79,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.l DATA_06FC79+$02,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	SEP.b #$10
	LDX.b #FXCODE_0A8000>>16
	LDA.w #FXCODE_0A8000
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	LDY.b $0A
	SEP.b #$20
	BRA.b CODE_00B582

CODE_00B54D:
	PHY
	LDA.l DATA_06F95E,x
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.l DATA_06F95E+$02,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$5800
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	SEP.b #$10
	LDX.b #FXCODE_08A980>>16
	LDA.w #FXCODE_08A980
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	LDA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	SEC
	SBC.w #$5800
	TAY
	SEP.b #$20
	LDA.b $0C
	CMP.b #$B1
	BCS.b CODE_00B5A7
CODE_00B582:
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDX.b $0E
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STX.w DMA[$00].Parameters
	LDX.w #$5800
	STX.w DMA[$00].SourceLo
	LDA.b #$70
	STA.w DMA[$00].SourceBank
	STY.w DMA[$00].SizeLo
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
	PLY
	RTS

CODE_00B5A7:
	LDX.w #$0000
	CMP.b #$B9
	BEQ.b CODE_00B5C4
	CMP.b #$BA
	BEQ.b CODE_00B5C4
	INX
	INX
	CMP.b #$BB
	BEQ.b CODE_00B5C4
	CMP.b #$BC
	BEQ.b CODE_00B5C4
	INX
	INX
	CMP.b #$BD
	BEQ.b CODE_00B5C4
	INX
	INX
CODE_00B5C4:
	REP.b #$20
	TYA
	STA.b $00
	ASL
	PHA
	SEP.b #$20
	PHB
	LDA.b #$7E
	PHA
	PLB
	REP.b #$20
	JSR.w (DATA_00B601,x)
	SEP.b #$20
	PLB
	PLY
	LDA.b $00
	BEQ.b CODE_00B5FF
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDX.b $0E
	STX.w !REGISTER_VRAMAddressLo
	LDX.b $02
	STX.w DMA[$00].Parameters
	LDX.w #$7BBE
	STX.w DMA[$00].SourceLo
	LDA.b #$7E
	STA.w DMA[$00].SourceBank
	STY.w DMA[$00].SizeLo
	LDA.b #$01
	STA.w !REGISTER_DMAEnable
CODE_00B5FF:
	PLY
	RTS

DATA_00B601:
	dw CODE_00B609
	dw CODE_00B6B7
	dw CODE_00B70B
	dw CODE_00B609

CODE_00B609:
	LDX.w #$0000
	LDY.w #$0000
CODE_00B60F:
	LDA.l $705800,x
	PHA
	AND.w #$000F
	STA.w $7BBE,y
	INY
	PLA
	AND.w #$00F0
	LSR
	LSR
	LSR
	LSR
	STA.w $7BBE,y
	INX
	INY
	DEC.b $00
	BNE.b CODE_00B60F
	LDA.w #$0080
	STA.b $00
	LDA.w #$1900
	STA.b $02
	RTS

DATA_00B637:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$10,$10,$10,$10,$10,$10
	db $10,$20,$20,$20,$20,$20,$20,$30,$30,$30,$30,$30,$30,$30,$30,$30
	db $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30
	db $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30

DATA_00B677:
	db $30,$30,$30,$30,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40
	db $40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40
	db $40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40
	db $40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40

CODE_00B6B7:
	LDA.w #$0000
	STA.b $04
	LDX.w #DATA_00B637
	LDA.b $0C
	CMP.w #$00BC
	BNE.b CODE_00B6C9
	LDX.w #DATA_00B677
CODE_00B6C9:
	STX.b $02
	LDX.w #$0000
	TXY
	LDA.w #$0020
	STA.b $06
CODE_00B6D4:
	LDA.l $705800,x
	AND.w #$00FF
	PHA
	AND.w #$000F
	ORA.b [$02]
	STA.w $7BBE,y
	INY
	PLA
	LSR
	LSR
	LSR
	LSR
	ORA.b [$02]
	STA.w $7BBE,y
	INY
	INX
	DEC.b $06
	BNE.b CODE_00B6FC
	LDA.w #$0020
	STA.b $06
	INC.b $02
CODE_00B6FC:
	DEC.b $00
	BNE.b CODE_00B6D4
	LDA.w #$0080
	STA.b $00
	LDA.w #$1900
	STA.b $02
	RTS

CODE_00B70B:
	PHB
	PHK
	PLB
	SEP.b #$10
	LDX.b #$00
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDX.b #$70
	STX.w DMA[$00].SourceBank
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$00
	STA.w DMA[$00].Parameters
	LDA.w #$5800
	STA.b $00
	LDX.b #$40
	LDY.b #$01
CODE_00B729:
	LDA.b $0E
	STA.w !REGISTER_VRAMAddressLo
	LDA.b $00
	STA.w DMA[$00].SourceLo
	LDA.w #$0040
	STA.w DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	LDA.b $0E
	CLC
	ADC.w #$0080
	STA.b $0E
	LDA.b $00
	CLC
	ADC.w #$0040
	STA.b $00
	DEX
	BNE.b CODE_00B729
	REP.b #$10
	PLB
	RTS

;---------------------------------------------------------------------------

CODE_00B753:
	LDX.w #$6800
CODE_00B756:
	STA.w $6000
	ASL
	ADC.w $6000
	STX.w $6000
	STX.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	TAX
	LDA.l DATA_06F95E,x
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.l DATA_06F95E+$02,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	SEP.b #$10
	LDX.b #FXCODE_08A980>>16
	LDA.w #FXCODE_08A980
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	LDA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	SEC
	SBC.w $6000
	RTL

;---------------------------------------------------------------------------

DATA_00B78A:
	dw $027C,$3B11,$01C8,$5F81,$8000,$1100,$8006,$1F01
	dw $8002,$2F41,$800A,$341C,$8004,$2F61,$8008,$2FE1
	dw $800C,$1FD1,$FFFF,$2860,$4F31,$28D8,$1F21,$2860
	dw $4FB1,$8000,$1100,$8002,$2F01,$8004,$1FF1,$FFFF
	dw $0130,$1100,$01C8,$1F81,$FFFF,$28F6,$2FE1,$FFFF
	dw $2DDC,$1100,$2DDC,$2F01,$30AC,$1F21,$328C,$1F31
	dw $2E18,$3F41,$346C,$1F81,$2ECC,$7F91,$FFFF,$8000
	dw $1100,$8002,$1F01,$8004,$1F11,$8006,$1F21,$8008
	dw $1F71,$2860,$4F31,$2860,$4F81,$3F4C,$2FC1,$3DC6
	dw $2FE1,$FFFF,$401A,$1100,$8000,$3F01,$8002,$1F71
	dw $01C8,$6F81,$8004,$4F31,$8006,$4F91,$3FFC,$1F51
	dw $3FFC,$1FB1,$8008,$1FD1,$01C8,$2FE1,$0222,$1FE1
	dw $FFFF,$2148,$1F01,$027C,$3B11,$4354,$4F41,$01C8
	dw $6F81,$8000,$1FD1,$FFFF,$586E,$8F01,$01C8,$5F81
	dw $8000,$1FD1,$8002,$2FE1,$FFFF

DATA_00B874:
	dw $067E,$06D2,$0726,$077A,$07CE,$0822,$0876,$08CA
	dw $091E,$0972,$09C6,$0A1A,$0A6E,$0AC2,$0B16,$0B6A
	dw $0BBE,$0C12,$0C66,$0CBA,$0D0E,$0D62,$0DB6,$0E0A
	dw $0E5E,$0EB2,$0F06,$0F5A,$0FAE,$1002,$1056,$10AA

DATA_00B8B4:
	dw $067E,$0BBE,$0726,$077A,$07CE,$0822,$0876,$08CA
	dw $091E,$0972,$09C6,$0A1A,$0A6E,$0AC2,$0B16,$0B6A
	dw $0BBE,$0C12,$0C66,$0CBA,$0D0E,$0D62,$0DB6,$0E0A
	dw $0E5E,$0EB2,$0F06,$0F5A,$0FAE,$1002,$1056,$10AA

DATA_00B8F4:
	dw $12A2,$11EE,$113A,$10FE,$11B2,$1176,$1266,$122A
	dw $12DE,$1356,$1392,$13CE,$140A,$1446,$1482,$14BE
	dw $1356,$10FE,$1176,$14FA,$1536,$1572,$1662,$1662
	dw $15AE,$15EA,$1626,$16DA,$169E,$1716,$1752,$178E
	dw $187E,$18BA,$18F6,$1932,$196E,$19AA,$19E6,$1A22
	dw $1A5E,$1A9A,$1AD6,$1B12,$1B4E,$1B8A,$1BC6,$1C02
	dw $1C3E,$1C7A,$1CB6,$1CF2,$1D2E,$1D6A,$1DA6,$1DE2
	dw $1E1E,$1E5A,$1E96,$1ED2,$1F0E,$1F4A,$1F86,$1FC2

DATA_00B974:
	dw $1FFE,$201C,$203A,$2058,$2076,$2094,$20B2,$20D0
	dw $2166,$210C,$212A,$2148,$20EE,$2184,$21A2,$21C0
	dw $21DE,$21FC,$221A,$2238,$2256,$2274,$2292,$22B0
	dw $22CE,$22EC,$230A,$2328,$2346,$2364,$2382,$23A0
	dw $23BE,$23DC,$23FA,$2418,$2436,$2454,$2472,$2490
	dw $24AE,$24CC,$24EA,$2508,$2526,$2544,$2562,$2580
	dw $259E,$25BC,$25DA,$25F8,$2616,$2634,$2652,$2670
	dw $268E,$26AC,$26CA,$26E8,$2706,$2724,$2742,$2760

DATA_00B9F4:
	dw $02BE,$02FA,$0336,$0372,$03AE,$03EA,$0426,$0462
	dw $049E,$04DA,$0516,$0552,$058E,$05CA,$0606,$0642

DATA_00BA14:
	dw $0040,$005E,$007C,$009A,$00B8,$00D6,$00F4,$0112

CODE_00BA24:
	PHB
	PHK
	PLB
	REP.b #$30
	LDA.w $0134
	ASL
	ADC.w #$0130
	STA.b $10
	LDA.w $0138
	ASL
	TAY
	LDA.w $0218
	CMP.w #$000A
	BNE.b CODE_00BA44
	LDA.w DATA_00B8B4,y
	BRA.b CODE_00BA47

CODE_00BA44:
	LDA.w DATA_00B874,y
CODE_00BA47:
	STA.b $12
	CLC
	ADC.w #$003C
	STA.b $1A
	LDA.w $013C
	ASL
	TAY
	LDA.w DATA_00B8F4,y
	STA.b $14
	LDA.w $0140
	ASL
	TAY
	LDA.w DATA_00B974,y
	STA.b $16
	LDA.w $0144
	ASL
	TAY
	LDA.w DATA_00B9F4,y
	STA.b $18
	LDA.w $0383
	ASL
	TAY
	LDA.w DATA_00BA14,y
	STA.b $1C
	LDX.w #$0000
CODE_00BA7A:
	LDA.w #DATA_5FA000
	STA.b $00
	LDA.w #DATA_5FA000>>8
	STA.b $01
CODE_00BA84:
	LDA.w DATA_00B78A,x
	BPL.b CODE_00BA95
	CMP.w #$FFFF
	BEQ.b CODE_00BADE
	AND.w #$7FFF
	TAY
	LDA.w $0010,y
CODE_00BA95:
	TAY
	LDA.w DATA_00B78A+$03,x
	AND.w #$000F
	STA.b $03
	LDA.w DATA_00B78A+$03,x
	AND.w #$00F0
	LSR
	LSR
	LSR
	LSR
	STA.b $05
	LDA.w DATA_00B78A+$02,x
	AND.w #$00FF
	ASL
	STA.b $07
	PHX
CODE_00BAB4:
	TAX
	LDA.b $03
	STA.b $09
CODE_00BAB9:
	LDA.b [$00],y
	STA.l $702000,x
	STA.l $702D6C,x
	INY
	INY
	INX
	INX
	DEC.b $09
	BNE.b CODE_00BAB9
	LDA.b $07
	CLC
	ADC.w #$0020
	STA.b $07
	DEC.b $05
	BNE.b CODE_00BAB4
	PLX
	INX
	INX
	INX
	INX
	BRA.b CODE_00BA84

CODE_00BADE:
	SEP.b #$30
	PLB
	RTL

;---------------------------------------------------------------------------

DATA_00BAE2:
	dw $293C,$297A

DATA_00BAE6:
	dw $2CAE,$2CCC

CODE_00BAEA:
	PHB
	PHK
	PLB
	REP.b #$20
	LDA.w DATA_00BAE2,x
	STA.b $10
	INC
	INC
	STA.b $12
	LDA.w DATA_00BAE6,x
	STA.b $14
	REP.b #$10
	LDX.w #$0026
	JMP.w CODE_00BA7A

;---------------------------------------------------------------------------

CODE_00BB05:
	PHB
	PHK
	PLB
	JMP.w CODE_00BA7A

;---------------------------------------------------------------------------

DATA_00BB0B:
	dw $3ADE,$3B5A,$3BD6,$3C52,$3CCE,$3D4A

DATA_00BB17:
	dw $3AE2,$3B00,$3B1E,$3B3C,$3B5E,$3B7C,$3B9A,$3BB8
	dw $3BDA,$3BF8,$3C16,$3C34,$3C56,$3C74,$3C92,$3CB0
	dw $3CD2,$3CF0,$3D0E,$3D2C,$3D4E,$3D6C,$3D8A,$3DA8

CODE_00BB47:
	PHB
	PHK
	PLB
	LDX.w $0218
	LDA.w DATA_00BB0B,x
	STA.b $10
	TXA
	ASL
	ASL
	TAX
	LDA.w DATA_00BB17,x
	STA.b $12
	LDA.w DATA_00BB17+$02,x
	STA.b $14
	LDA.w DATA_00BB17+$04,x
	STA.b $16
	LDA.w DATA_00BB17+$06,x
	STA.b $18
	LDX.w #$006E
	JMP.w CODE_00BA7A

;---------------------------------------------------------------------------

CODE_00BB70:
	PHB
	PHK
	PLB
	LDA.w #$7F94
	STA.w $0948
	LDA.w #$0000
	STA.l $702000
	LDA.w $0383
	ASL
	TAX
	LDA.w DATA_00BA14,x
	STA.b $10
	LDX.w #$00C2
	JMP.w CODE_00BA7A

;---------------------------------------------------------------------------

CODE_00BB90:
	PHB
	PHK
	PLB
	REP.b #$30
	LDA.w $0383
	ASL
	TAY
	LDA.w DATA_00BA14,y
	STA.b $10
	LDA.w $0144
	ASL
	TAY
	LDA.w DATA_00B9F4,y
	STA.b $12
	LDX.w #$00D8
	JMP.w CODE_00BA7A

;---------------------------------------------------------------------------

DATA_00BBAF:
	dw $0000,$0014,$0028,$003C,$0050,$0064,$0078,$008C
	dw $00A0,$00B4,$00C8,$00DC,$00F0,$0104,$0118,$012C
	dw $0140,$0154,$0168,$01A4,$017C,$0190

DATA_00BBDB:
	db $05,$07,$08,$09,$0B,$0C,$23,$24
	db $25,$2C,$2D,$2E,$2F,$30,$31

DATA_00BBEA:
	db $06,$00,$0A,$1D,$00
	db $10,$3C,$3C,$3C,$22
	db $22,$32,$00,$00,$13
	db $00,$00,$00,$00,$3F
	db $00,$00,$16,$3D,$00
	db $01,$70,$74,$78,$00
	db $06,$00,$00,$00,$13
	db $00,$00,$00,$00,$00
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$17
	db $00,$00,$00,$22,$20
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$14
	db $03,$00,$00,$22,$20
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$13
	db $04,$00,$00,$22,$B3
	db $04,$00,$16,$3D,$01
	db $22,$69,$3A,$34,$77
	db $02,$00,$00,$00,$11
	db $02,$00,$00,$22,$20
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$13
	db $14,$00,$00,$22,$72
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$15
	db $02,$00,$00,$22,$20
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$15
	db $02,$00,$00,$22,$24
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$11
	db $06,$00,$00,$22,$20
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$13
	db $00,$00,$00,$22,$20
	db $0A,$00,$16,$3D,$01
	db $07,$00,$00,$00,$00
	db $00,$00,$00,$00,$11
	db $04,$00,$00,$22,$20
	db $02,$00,$16,$3D,$01
	db $00,$69,$28,$30,$77
	db $77,$00,$00,$00,$1F
	db $00,$00,$00,$02,$20
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$11
	db $06,$00,$00,$22,$20
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$15
	db $00,$00,$00,$22,$20
	db $02,$00,$16,$3D,$01
	db $59,$3A,$69,$34,$77
	db $02,$00,$00,$00,$05
	db $12,$00,$00,$22,$45
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$13
	db $04,$00,$00,$22,$B3
	db $02,$00,$16,$3D,$01
	db $69,$69,$3A,$34,$77
	db $02,$00,$00,$00,$04
	db $13,$00,$00,$22,$24
	db $08,$02,$16,$3D,$01
	db $09,$61,$69,$74,$00
	db $77,$00,$30,$00,$15
	db $02,$0A,$02,$02,$20
	db $0C,$00,$16,$1D,$00
	db $01,$1C,$1C,$15,$22
	db $01,$32,$00,$80,$17
	db $00,$00,$00,$10,$00
	db $0E,$06,$16,$3D,$01
	db $41,$6A,$3A,$34,$77
	db $02,$00,$00,$A0,$17
	db $00,$10,$00,$20,$94
	db $08,$04,$07,$1B,$00
	db $03,$50,$5C,$00,$50
	db $00,$00,$00,$00,$13
	db $00,$00,$00,$00,$00

CODE_00BDA2:
	PHB
	PHK
	PLB
	REP.b #$10
	LDY.w DATA_00BBAF,x
	LDA.w DATA_00BBEA,y
	STA.w $011C
	LDA.w DATA_00BBEA+$01,y
	STA.w $0126
	LDA.w DATA_00BBEA+$02,y
	STA.w $012D
	LDA.w DATA_00BBEA+$03,y
	STA.w $012E
	LDA.w DATA_00BBEA+$04,y
	BEQ.b CODE_00BDE5
	REP.b #$20
	LDA.l $702000
	STA.w $0948
	STA.l $702020
	STA.l $702D8C
	LDA.w #$0000
	STA.l $702000
	STA.l $702D6C
	SEP.b #$20
CODE_00BDE5:
	LDX.w #$0000
CODE_00BDE8:
	LDA.w DATA_00BBEA+$05,y
	STA.w $095E,x
	INY
	INX
	CPX.w #$000F
	BCC.b CODE_00BDE8
	STZ.w $094A
	STZ.w !REGISTER_BG4AddressAndSize
	LDY.w #$002100
	STY.b $00
	SEP.b #$10
	LDX.b #$0E
CODE_00BE04:
	LDY.w DATA_00BBDB,x
	LDA.w $095E,x
	STA.b ($00),y
	DEX
	BPL.b CODE_00BE04
	REP.b #$20
	STZ.w $094C
	STZ.w !REGISTER_BGWindowLogicSettings
	SEP.b #$20
	LDA.b #$02
	STA.w $094B
	STA.w !REGISTER_OAMSizeAndDataAreaDesignation
	STZ.w !REGISTER_InitialScreenSettings
	PLB
	RTL

;---------------------------------------------------------------------------

CODE_00BE26:
	REP.b #$30
	PHB
	LDY.w #$702200
	LDX.w #DATA_00E552
	LDA.w #$03FF
	MVN $702200>>16,DATA_00E552>>16
	PLB
	SEP.b #$30
	RTL

;---------------------------------------------------------------------------

CODE_00BE39:
	PHP
	REP.b #$30
	LDX.w $096D
	LDA.b $02,S
	TAY
	LDA.w $0007,y
	STA.w $096F,x
	LDA.w $0001,y
	STA.w $0971,x
	LDA.w $0003,y
	STA.w $0973,x
	LDA.w $0005,y
	STA.w $0975,x
	LDA.w #$0000
	STA.w $0977,x
	TXA
	CLC
	ADC.w #$0008
	STA.w $096D
	TYA
	CLC
	ADC.w #$0008
	STA.b $02,S
	PLP
	RTL

;---------------------------------------------------------------------------

CODE_00BE71:
	PHP
	REP.b #$10
	LDX.w $096D
	STA.w $096F,x
	LDA.b $02,S
	TAY
	LDA.w $0001,y
	STA.w $0971,x
	LDA.w $0003,y
	STA.w $0973,x
	LDA.w $0005,y
	STA.w $0975,x
	LDA.w #$0000
	STA.w $0977,x
	TXA
	CLC
	ADC.w #$0008
	STA.w $096D
	TYA
	CLC
	ADC.w #$0006
	STA.b $02,S
	PLP
	RTL

;---------------------------------------------------------------------------

; Note: Routine that sets up some sort of DMA buffer.

CODE_00BEA6:
	PHB
	PEA.w $7E4800>>8
	PLB
	PLB
	PHX
	LDX.w $7E4800
	STA.w $0008,x
	TYA
	STA.w $0000,x
	LDA.w #$0180
	STA.w $0002,x
	LDA.w #!REGISTER_WriteToVRAMPortLo&$00FF
	STA.w $0004,x
	LDA.w $0000
	STA.w $0006,x
	PLA
	STA.w $0005,x
	TXA
	CLC
	ADC.w #$000C
	STA.w $000A,x
	STA.w $7E4800
	PLB
	RTL

;---------------------------------------------------------------------------

CODE_00BEDA:
	PHB
	PEA.w $7E4800>>8
	PLB
	PLB
	PHX
	LDX.w $7E4800
	STA.w $0008,x
	TYA
	STA.w $0000,x
	LDA.w #$0980
	STA.w $0002,x
	LDA.w #$0018
	STA.w $0004,x
	LDA.w #$7E4800>>8
	STA.w $0006,x
	TXA
	CLC
	ADC.w #$000C
	STA.w $0005,x
	TXA
	CLC
	ADC.w #$000D
	STA.w $000A,x
	STA.w $7E4800
	PLA
	STA.w $000C,x
	PLB
	RTL

;---------------------------------------------------------------------------

CODE_00BF16:
	PHB
	PEA.w $7E4800>>8
	PLB
	PLB
	PHX
	LDX.w $7E4800
	STA.w $0008,x
	TYA
	STA.w $0000,x
	LDA.w #$0000
	STA.w $0002,x
	LDA.w #$0018
	STA.w $0004,x
	LDA.w $0000
	STA.w $0006,x
	PLA
	STA.w $0005,x
	TXA
	CLC
	ADC.w #$000C
	STA.w $000A,x
	STA.w $7E4800
	PLB
	RTL

;---------------------------------------------------------------------------

CODE_00BF4A:
	PHB
	PEA.w $7E4800>>8
	PLB
	PLB
	PHX
	LDX.w $7E4800
	STA.w $0008,x
	TYA
	STA.w $0000,x
	LDA.w #$0800
	STA.w $0002,x
	LDA.w #$0018
	STA.w $0004,x
	LDA.w #$7E4800>>8
	STA.w $0006,x
	TXA
	CLC
	ADC.w #$000C
	STA.w $0005,x
	TXA
	CLC
	ADC.w #$000D
	STA.w $000A,x
	STA.w $7E4800
	PLA
	STA.w $000C,x
	PLB
	RTL

;---------------------------------------------------------------------------

CODE_00BF86:
	PHB
	PEA.w $7E4800>>8
	PLB
	PLB
	PHX
	LDX.w $7E4800
	STA.w $0008,x
	TYA
	STA.w $0000,x
	LDA.w #$0080
	STA.w $0002,x
	LDA.w #$0019
	STA.w $0004,x
	LDA.w $0000
	STA.w $0006,x
	PLA
	STA.w $0005,x
	TXA
	CLC
	ADC.w #$000C
	STA.w $000A,x
	STA.w $7E4800
	PLB
	RTL

;---------------------------------------------------------------------------

CODE_00BFBA:
	PHB
	PEA.w $7E4800>>8
	PLB
	PLB
	PHX
	LDX.w $7E4800
	STA.w $0008,x
	TYA
	STA.w $0000,x
	LDA.w #$0880
	STA.w $0002,x
	LDA.w #$0019
	STA.w $0004,x
	LDA.w #$7E4800>>8
	STA.w $0006,x
	TXA
	CLC
	ADC.w #$000C
	STA.w $0005,x
	TXA
	CLC
	ADC.w #$000D
	STA.w $000A,x
	STA.w $7E4800
	PLA
	STA.w $000C,x
	PLB
	RTL

	%FREE_BYTES(NULLROM, 10, $FF)

;---------------------------------------------------------------------------

base $7EC000
CODE_00C000:
	SEI
	REP.b #$38
	PHA
	PHX
	PHY
	PHD
	PHB
	LDA.w #$0000
	TCD
	SEP.b #$30
	PHA
	PLB
	LDY.w !REGISTER_NMIEnable
	LDX.w $011C
	JSR.w (DATA_00C074,x)
	LDA.b $4D
	BNE.b CODE_00C024
	LDX.w !REGISTER_APUPort0
	CPX.b $4F
	BNE.b CODE_00C02B
CODE_00C024:
	STA.w !REGISTER_APUPort0
	STA.b $4F
	STZ.b $4D
CODE_00C02B:
	LDA.b $51
	STA.w !REGISTER_APUPort1
	STZ.b $51
	LDA.w !REGISTER_APUPort3
	CMP.b $55
	BNE.b CODE_00C06C
	LDY.b $53
	BEQ.b CODE_00C045
	CMP.b $53
	BEQ.b CODE_00C04D
	STZ.b $53
	BRA.b CODE_00C067

CODE_00C045:
	LDX.b $57
	BEQ.b CODE_00C067
	CMP.b $59
	BNE.b CODE_00C051
CODE_00C04D:
	LDY.b #$00
	BRA.b CODE_00C067

CODE_00C051:
	DEX
	CPX.b #$07
	BCC.b CODE_00C058
	LDX.b #$06
CODE_00C058:
	STX.b $57
	LDY.b $59
	LDX.b #$00
CODE_00C05E:
	LDA.b $5A,x
	STA.b $59,x
	INX
	CPX.b $57
	BCC.b CODE_00C05E
CODE_00C067:
	STY.w !REGISTER_APUPort3
	STY.b $55
CODE_00C06C:
	REP.b #$30
	PLB
	PLD
	PLY
	PLX
	PLA
	RTI

DATA_00C074:
	dw CODE_00C084
	dw CODE_00C10A
	dw CODE_00C10A
	dw CODE_00C22C
	dw CODE_00C10A
	dw CODE_00C10A
	dw CODE_00C10B
	dw CODE_00C10A

CODE_00C084:
	LDY.b #$8F
	STY.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	LDA.w $011B
	BNE.b CODE_00C094
	JMP.w CODE_00C0FD

CODE_00C094:
	STZ.w $011B
	JSR.w CODE_00E3DF
	JSR.w CODE_00E3AA
	REP.b #$20
	LDA.w #!REGISTER_DMAEnable
	TCD
	LDX.b #$01
	JSR.w CODE_00D4AC
	JSR.w CODE_00D4E5
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	JSR.w CODE_00DC6B
	LDA.w #$0000
	TCD
	SEP.b #$20
	JSR.w CODE_00E507
	LDA.b $39
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b $3A
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b $3B
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b $3C
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b $3D
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3E
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3F
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b $40
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b $41
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $42
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $43
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.b $44
	STA.w !REGISTER_BG3VertScrollOffset
CODE_00C0FD:
	LDA.w $0200
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.w $094A
	STA.w !REGISTER_HDMAEnable
	RTS

CODE_00C10A:
	RTS

CODE_00C10B:
	LDY.b #$8F
	STY.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	LDA.w $096B
	STA.w !REGISTER_ColorMathInitialSettings
	LDA.w $0994
	ORA.b #$80
	STA.w !REGISTER_FixedColorData
	LDA.w $0992
	ORA.b #$40
	STA.w !REGISTER_FixedColorData
	LDA.w $0990
	ORA.b #$20
	STA.w !REGISTER_FixedColorData
	LDA.w $011B
	BNE.b CODE_00C139
	JMP.w CODE_00C1DF

CODE_00C139:
	STZ.w $011B
	JSR.w CODE_00E3DF
	JSR.w CODE_00E3AA
	REP.b #$20
	LDA.w #!REGISTER_DMAEnable
	TCD
	LDX.b #$01
	JSR.w CODE_00D4AC
	JSR.w CODE_00D510
	LDA.w #$0000
	TCD
	LDA.b $39
	STA.l $7E5B59
	LDA.b $3B
	STA.l $7E5B5B
	LDA.b $69
	STA.l $7E5B5E
	LDA.b $6B
	STA.l $7E5B60
	LDA.b $3D
	STA.l $7E5B99
	LDA.b $3F
	STA.l $7E5B9B
	LDA.b $6D
	STA.l $7E5B9E
	LDA.b $6F
	STA.l $7E5BA0
	LDA.w $1144
	STA.l $7E5740
	SEP.b #$20
	LDA.w $096C
	STA.l $7E5C9B
	JSR.w CODE_00E507
	LDA.w $0969
	STA.w !REGISTER_MainScreenWindowMask
	LDA.w $0966
	STA.w !REGISTER_ObjectAndColorWindowSettings
	LDA.b $39
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b $3A
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b $3B
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b $3C
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b $3D
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3E
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3F
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b $40
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b $41
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $42
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $43
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.b $44
	STA.w !REGISTER_BG3VertScrollOffset
CODE_00C1DF:
	LDA.w $0200
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.w $094A
	STA.w !REGISTER_HDMAEnable
	RTS

DATA_00C1EC:
	dw $4000,$6000,$4700,$6700,$5180,$7180

DATA_00C1F8:
	dw $7F56DE,$7F56DE,$7F64DE,$7F64DE,$7F79DE,$7F79DE

DATA_00C204:
	dw $0E00,$0E00,$1500,$1500,$1500,$1500

DATA_00C210:
	db $63,$62

DATA_00C212:
	db $3F,$BF

DATA_00C214:
	db $00,$50,$28,$00,$00,$00,$00,$00

DATA_00C21C:
	db $01,$00,$01,$00,$01,$00,$00,$00

DATA_00C224:
	db $FF,$FF,$FF,$00,$01,$01,$01,$00

CODE_00C22C:
	LDY.b #$8F
	STY.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	LDA.w $1139
	BEQ.b CODE_00C23B
	STA.b $51
CODE_00C23B:
	LDA.w $096C
	STA.w !REGISTER_ColorMathSelectAndEnable
	LDA.w $0994
	ORA.b #$80
	STA.w !REGISTER_FixedColorData
	LDA.w $0992
	ORA.b #$40
	STA.w !REGISTER_FixedColorData
	LDA.w $0990
	ORA.b #$20
	STA.w !REGISTER_FixedColorData
	REP.b #$20
	INC.w $0131
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDY.b #$01
	SEP.b #$20
	LDA.w $0980
	BEQ.b CODE_00C29E
	ASL
	ORA.w $0984
	ASL
	TAX
	REP.b #$20
	LDA.l DATA_00C1EC-$04,x
	STA.w !REGISTER_VRAMAddressLo
	LDA.l DATA_00C1F8-$04,x
	STA.w DMA[$00].SourceLo
	LDA.l DATA_00C204-$04,x
	STA.w DMA[$00].SizeLo
	LDX.b #$7F56DE>>16
	STX.w DMA[$00].SourceBank
	STY.w !REGISTER_DMAEnable
	SEP.b #$20
	DEC.w $0980
	BNE.b CODE_00C2A3
CODE_00C29E:
	LDA.w $011B
	BNE.b CODE_00C2A6
CODE_00C2A3:
	JMP.w CODE_00C33E

CODE_00C2A6:
	STZ.w $011B
	LDA.w $0982
	STZ.w $0982
	STA.w $0980
	JSR.w CODE_00E3DF
	REP.b #$20
	LDA.w #!REGISTER_DMAEnable
	TCD
	LDX.b #$01
	JSR.w CODE_00D4AC
	JSR.w CODE_00D510
	LDA.w #$7E5040
	STA.w !REGISTER_WRAMAddressLo
	LDY.b #$7E5040>>16
	STY.w !REGISTER_WRAMAddressBank
	LDA.w #(!REGISTER_ReadOrWriteToWRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	LDA.w #$6CAA
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #$00
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$0380
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w #$0000
	TCD
	SEP.b #$20
	LDY.w $0984
	LDA.w DATA_00C210,y
	STA.w !REGISTER_OAMSizeAndDataAreaDesignation
	LDA.w $0969
	STA.w !REGISTER_MainScreenWindowMask
	LDA.w $0966
	STA.w !REGISTER_ObjectAndColorWindowSettings
	LDA.b $39
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b $3A
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b $3B
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b $3C
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.w $020E
	STA.w !REGISTER_Mode7CenterX
	LDA.w $020F
	STA.w !REGISTER_Mode7CenterX
	LDA.w $0210
	STA.w !REGISTER_Mode7CenterY
	LDA.w $0211
	STA.w !REGISTER_Mode7CenterY
	LDA.b $3D
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3E
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3F
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b $40
	STA.w !REGISTER_BG2VertScrollOffset
CODE_00C33E:
	REP.b #$20
	LDA.b $41
	CLC
	ADC.w $099E
	STA.b $41
	LSR
	STA.w $09BD
	LSR
	LSR
	LSR
	STA.w $09A1
	ADC.w $09BD
	STA.w $09B9
	ADC.w $09A1
	STA.w $09B5
	ADC.w $09A1
	STA.w $09B1
	ADC.w $09A1
	STA.w $09AD
	ADC.w $09A1
	STA.w $09A9
	ADC.w $09A1
	STA.w $09A5
	ADC.w $09A1
	STA.w $09A1
	SEP.b #$20
	LDA.w $095F
	STA.w !REGISTER_BG1AddressAndSize
	LDA.w $0960
	STA.w !REGISTER_BG2AddressAndSize
	LDA.w $095E
	STA.l $7E5A19
	LDA.w $0967
	STA.l $7E5A99
	LDA.w $09A0
	STA.w HDMA[$01].Destination
	JSR.w CODE_00E507
	LDA.w $0200
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.w $094A
	STA.w !REGISTER_HDMAEnable
	LDA.w $098E
	BEQ.b CODE_00C3E7
	PHK
	PLB
	LDY.w $0201
	LDX.w DATA_00C212,y
	STX.w $096C
	TYA
	ASL
	ASL
	TAY
	LDX.b #$04
CODE_00C3C3:
	DEC.w $0996,x
	BPL.b CODE_00C3E2
	LDA.w DATA_00C21C,y
	STA.w $0996,x
	LDA.w $0990,x
	CLC
	ADC.w DATA_00C224,y
	BPL.b CODE_00C3D9
	LDA.b #$00
CODE_00C3D9:
	CMP.b #$1F
	BCC.b CODE_00C3DF
	LDA.b #$1F
CODE_00C3DF:
	STA.w $0990,x
CODE_00C3E2:
	INY
	DEX
	DEX
	BPL.b CODE_00C3C3
CODE_00C3E7:
	RTS

;---------------------------------------------------------------------------

CODE_00C3E8:
	SEI
	REP.b #$38
	PHA
	PHX
	PHY
	PHD
	PHB
	LDA.w #$0000
	TCD
	SEP.b #$30
	PHA
	PLB
	LDA.w !REGISTER_IRQEnable
	LDX.w $0126
	JSR.w (DATA_00C40A,x)
	REP.b #$30
	PLB
	PLD
	PLY
	PLX
	PLA
	CLI
	RTI

DATA_00C40A:
	dw CODE_00C412
	dw CODE_00C821
	dw CODE_00CA9A
	dw CODE_00D308

;---------------------------------------------------------------------------

CODE_00C412:
	LDA.w $0125
	BNE.b CODE_00C43D
CODE_00C417:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVS.b CODE_00C417
CODE_00C41C:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_00C41C
	LDA.w $094A
	STA.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_ScreenDisplayRegister
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$08
CODE_00C431:
	INC.w $0125
CODE_00C434:
	STA.w !REGISTER_VCountTimerLo
	LDA.b #$B1
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
CODE_00C43C:
	RTS

;---------------------------------------------------------------------------

CODE_00C43D:
	DEC
	BNE.b CODE_00C465
CODE_00C440:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVS.b CODE_00C440
CODE_00C445:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_00C445
	LDA.w $0200
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$D8
	LDX.w $0121
	BNE.b CODE_00C45F
	JMP.w CODE_00C431

CODE_00C45F:
	JSR.w CODE_00C431
	JMP.w (DATA_00C714,x)

CODE_00C465:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVS.b CODE_00C465
CODE_00C46A:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_00C46A
	LDY.b #$8F
	STY.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	LDX.w $011C
	JMP.w (DATA_00C47D,x)

DATA_00C47D:
	dw CODE_00C43C
	dw CODE_00C48D
	dw CODE_00C5FE
	dw CODE_00C43C
	dw CODE_00C87A
	dw CODE_00C641
	dw CODE_00C43C
	dw CODE_00C43C

;---------------------------------------------------------------------------

CODE_00C48D:
	LDA.w $011B
	BNE.b CODE_00C495
	JMP.w CODE_00C6CC

CODE_00C495:
	REP.b #$20
	LDA.b $3B
	CLC
	ADC.w $0CB0
	STA.w $011F
	LDA.b $39
CODE_00C4A2:
	STA.w $011D
	SEP.b #$20
	STA.w !REGISTER_BG1VertScrollOffset
	XBA
	STA.w !REGISTER_BG1VertScrollOffset
	STZ.w $011B
	JSR.w CODE_00E3DF
	JSR.w CODE_00E3AA
	REP.b #$20
	PHD
	LDA.w #!REGISTER_DMAEnable
	TCD
	LDX.b #$01
	JSR.w CODE_00DE0C
	JSR.w CODE_00D4AC
	JSR.w CODE_00D4E5
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	LDY.w $0B0F
	BEQ.b CODE_00C4F4
	CPY.b #$0C
	BCC.b CODE_00C4F4
	LDA.w #$4E00
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$706800
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #$706800>>16
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$0C00
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	BRA.b CODE_00C50E

CODE_00C4F4:
	JSR.w CODE_00DCAE
	JSR.w CODE_00D65D
	JSR.w CODE_00DC6B
	LDY.w $0D15
	BEQ.b CODE_00C508
	JSR.w CODE_00DC97
	STZ.w $0D15
CODE_00C508:
	JSR.w CODE_00DBA9
	JSR.w CODE_00DC1C
CODE_00C50E:
	PLD
	LDY.w $0D0D
	BNE.b CODE_00C51B
	LDY.w $0134
	CPY.b #$10
	BCC.b CODE_00C539
CODE_00C51B:
	LDA.w $0D0B
	STA.l $7E5D19
	CLC
	ADC.w #$0069
	STA.l $7E5D1C
	LDA.w $0D09
	STA.l $7E5C99
	CLC
	ADC.w #$00D2
	STA.l $7E5C9C
CODE_00C539:
	SEP.b #$20
	LDA.w $011D
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.w $011E
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.w $011F
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.w $0120
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b $3D
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3E
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3F
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b $40
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b $41
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $42
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $43
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.b $44
	STA.w !REGISTER_BG3VertScrollOffset
	JSR.w CODE_00E507
CODE_00C57E:
	REP.b #$20
	LDA.w #!REGISTER_ScreenDisplayRegister
	TCD
	LDA.w $0967
	STA.b !REGISTER_MainScreenLayers
	LDA.w $0969
	STA.b !REGISTER_MainScreenWindowMask
	LDA.w $0962
	STA.b !REGISTER_BG1And2TileDataDesignation
	LDA.w $095F
	STA.b !REGISTER_BG1AddressAndSize
	LDA.w $0964
	STA.b !REGISTER_BG1And2WindowMaskSettings
	LDA.w $096B
	STA.b !REGISTER_ColorMathInitialSettings
	LDA.w $094C
	STA.b !REGISTER_BGWindowLogicSettings
	SEP.b #$20
	LDA.w $0961
	STA.b !REGISTER_BG3AddressAndSize
	LDA.w $095E
	STA.b !REGISTER_BGModeAndTileSizeSetting
	LDA.w $095B
	STA.b !REGISTER_MosaicSizeAndBGEnable
	LDA.w $0966
	STA.b !REGISTER_ObjectAndColorWindowSettings
	REP.b #$20
	LDA.w #DMA[$00].Parameters
	TCD
	LDA.b HDMA[$01].SourceLo
	STA.b HDMA[$01].TableSourceLo
	LDA.b HDMA[$02].SourceLo
	STA.b HDMA[$02].TableSourceLo
	LDA.b HDMA[$03].SourceLo
	STA.b HDMA[$03].TableSourceLo
	LDA.b HDMA[$04].SourceLo
	STA.b HDMA[$04].TableSourceLo
	LDA.b HDMA[$05].SourceLo
	STA.b HDMA[$05].TableSourceLo
	LDA.b HDMA[$06].SourceLo
	STA.b HDMA[$06].TableSourceLo
	LDA.b HDMA[$07].SourceLo
	STA.b HDMA[$07].TableSourceLo
	SEP.b #$20
	LDA.b #$01
	STA.b HDMA[$01].LineCount
	STA.b HDMA[$02].LineCount
	STA.b HDMA[$03].LineCount
	STA.b HDMA[$04].LineCount
	STA.b HDMA[$05].LineCount
	STA.b HDMA[$06].LineCount
	STA.b HDMA[$07].LineCount
	STZ.w $0125
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$06
	JMP.w CODE_00C434

CODE_00C5FE:
	LDA.w $011B
	BNE.b CODE_00C606
	JMP.w CODE_00C6CC

CODE_00C606:
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	REP.b #$20
	LDA.w #$3600
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.w #$007EF2
	STA.w DMA[$00].SourceLo
	LDY.b #$007EF2>>16
	STY.w DMA[$00].SourceBank
	LDY.b #$80
	STY.w DMA[$00].SizeLo
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	LDA.w #$0080
	STA.b $43
	STZ.b $41
	LDA.w $7EF0
	STA.w $011F
	LDA.w $7EEE
	JMP.w CODE_00C4A2

CODE_00C641:
	LDA.w $011B
	BNE.b CODE_00C649
	JMP.w CODE_00C6CC

CODE_00C649:
	LDA.w $094E
	STA.w !REGISTER_Mode7TilemapSettings
	LDA.w $094F
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.w $0950
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.w $0951
	STA.w !REGISTER_Mode7MatrixParameterB
	LDA.w $0952
	STA.w !REGISTER_Mode7MatrixParameterB
	LDA.w $0953
	STA.w !REGISTER_Mode7MatrixParameterC
	LDA.w $0954
	STA.w !REGISTER_Mode7MatrixParameterC
	LDA.w $0955
	STA.w !REGISTER_Mode7MatrixParameterD
	LDA.w $0956
	STA.w !REGISTER_Mode7MatrixParameterD
	LDA.w $0957
	STA.w !REGISTER_Mode7CenterX
	LDA.w $0958
	STA.w !REGISTER_Mode7CenterX
	LDA.w $0959
	STA.w !REGISTER_Mode7CenterY
	LDA.w $095A
	STA.w !REGISTER_Mode7CenterY
	REP.b #$20
	LDA.w $0B83
	STA.l $7E51E5
	STA.l $7E51E8
	LDA.w $0967
	STA.l $7E51EB
	LDA.b $39
	STA.b $3D
	LDA.b $3B
	CLC
	ADC.w $0CB0
	STA.b $3F
	LDA.b $43
	LDY.w $0146
	CPY.b #$09
	BNE.b CODE_00C6C4
	CLC
	ADC.w $0CB0
CODE_00C6C4:
	STA.w $011F
	LDA.b $41
	JMP.w CODE_00C4A2

CODE_00C6CC:
	LDA.w $0121
	BEQ.b CODE_00C6F9
	REP.b #$20
	PHD
	LDA.w #!REGISTER_DMAEnable
	TCD
	LDX.b #$01
	JSR.w CODE_00DE0C
	JSR.w CODE_00D4AC
	JSR.w CODE_00D4E5
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	JSR.w CODE_00DCAE
	JSR.w CODE_00DC6B
	PLD
	SEP.b #$20
	JSR.w CODE_00E507
CODE_00C6F9:
	LDA.w $011D
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.w $011E
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.w $011F
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.w $0120
	STA.w !REGISTER_BG1VertScrollOffset
	JMP.w CODE_00C57E

DATA_00C714:
	dw CODE_00C718
	dw CODE_00C719

CODE_00C718:
	RTS

CODE_00C719:
	JSL.l CODE_00C71E&$00FFFF
	RTS

CODE_00C71E:
	JSL.l CODE_008259
	JSL.l CODE_0394D3
	JSL.l CODE_04FA67
	JSL.l CODE_04DD9E
	JSL.l CODE_0397D3
	REP.b #$20
	LDX.b #FXCODE_08B1EF>>16
	LDA.w #FXCODE_08B1EF
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0D23
	INC.w $0D25
	LDA.w $0D25
	CMP.w #$0010
	BCC.b CODE_00C775
	LDA.w $093E
	ORA.w $0942
	BEQ.b CODE_00C75D
	LDA.w $0D23
	CLC
	ADC.w #$0006
	STA.w $0D23
CODE_00C75D:
	LDA.w $0D25
	AND.w #$0003
	BEQ.b CODE_00C769
	JML.l CODE_00C7C8&$00FFFF

CODE_00C769:
	REP.b #$10
	LDX.w #$0000
	LDY.w $021A
	JML.l CODE_00C778&$00FFFF

CODE_00C775:
	SEP.b #$20
	RTL

;---------------------------------------------------------------------------

CODE_00C778:
	REP.b #$20
	PHB
	PHK
	PLB
	LDA.w $0D21
	AND.w #$003F
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	STY.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDA.w #DATA_5149BC>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_5149BC
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	SEP.b #$10
	LDA.w $0D1D
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w $0D1F
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDX.b #FXCODE_09E92F>>16
	LDA.w #FXCODE_09E92F
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	STA.w $0D21
	LDA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w $0D1F
	LDA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	STA.w $0D1D
	INC.w $0CF9
	PLB
	LDA.w #$5038
	STA.w $0D1B
CODE_00C7C8:
	REP.b #$10
	LDA.w #$AAAA
	STA.w $6C00
	STA.w $6C02
	LDA.w #$00E0
	STA.w $0D19
	SEP.b #$20
	LDX.w #$0000
CODE_00C7DE:
	REP.b #$20
	TXA
	AND.w #$00FF
	LSR
	ORA.w #$35C0
	STA.w $6A02,x
	ORA.w #$0020
	STA.w $6A22,x
	LDA.w $0B4C
	SEC
	SBC.w $0D19
	SEP.b #$20
	STA.w $6A00,x
	STA.w $6A20,x
	LDA.w $0D19
	SEC
	SBC.b #$10
	STA.w $0D19
	LDA.w $0D1B
	STA.w $6A01,x
	LDA.w $0D1C
	STA.w $6A21,x
	INX
	INX
	INX
	INX
	CPX.w #$0020
	BCC.b CODE_00C7DE
	SEP.b #$10
	RTL

CODE_00C821:
	LDA.w $0125
	BNE.b CODE_00C842
CODE_00C826:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVS.b CODE_00C826
CODE_00C82B:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_00C82B
	LDA.w $094A
	STA.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_ScreenDisplayRegister
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$0E
	BRA.b CODE_00C85C

CODE_00C842:
	DEC
	BNE.b CODE_00C862
CODE_00C845:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVS.b CODE_00C845
CODE_00C84A:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_00C84A
	LDA.w $0200
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$C6
CODE_00C85C:
	INC.w $0125
	JMP.w CODE_00C434

CODE_00C862:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVS.b CODE_00C862
CODE_00C867:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_00C867
	LDY.b #$8F
	STY.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	LDX.w $011C
	JMP.w (DATA_00C47D,x)

;---------------------------------------------------------------------------

CODE_00C87A:
	LDA.w $011B
	BNE.b CODE_00C882
	JMP.w CODE_00CA10

CODE_00C882:
	STZ.w $011B
	JSR.w CODE_00E3DF
	JSR.w CODE_00E3AA
	REP.b #$20
	PHD
	LDA.w #!REGISTER_DMAEnable
	TCD
	LDX.b #$01
	JSR.w CODE_00DE0C
	JSR.w CODE_00D4AC
	JSR.w CODE_00D4E5
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	LDA.w $0D15
	BEQ.b CODE_00C8C5
	LDA.w #$7000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$704C00
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #$704C00>>16
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$0800
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	STZ.w $0D15
CODE_00C8C5:
	LDA.w $0CF9
	BEQ.b CODE_00C8E0
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDA.w #$5000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$705800
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #$705800>>16
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	STX.b $00
	STZ.w $0CF9
CODE_00C8E0:
	LDA.w $0B85
	BNE.b CODE_00C8E8
	JMP.w CODE_00C9BA

CODE_00C8E8:
	LDA.w #$5400
	STA.w !REGISTER_VRAMAddressLo
	LDY.b #$40
	LDA.w $6128
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #DATA_53C000>>16
	STA.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $612C
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $6130
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $6134
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $6138
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $613C
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $6140
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $6144
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w #$5500
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$20
	LDA.w $6128
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $612B
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $612C
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $612F
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $6130
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $6133
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $6134
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $6137
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $6138
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $613B
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $613C
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $613F
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $6140
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $6143
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	LDA.w $6144
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $6147
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	REP.b #$20
	STZ.w $0B85
CODE_00C9BA:
	PLD
	SEP.b #$20
	JSR.w CODE_00E507
	LDA.b $39
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b $3A
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b $3B
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b $3C
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b $3D
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3E
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3F
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b $40
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b $41
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $42
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $43
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.b $44
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.b $45
	STA.w !REGISTER_BG4HorizScrollOffset
	LDA.b $46
	STA.w !REGISTER_BG4HorizScrollOffset
	LDA.b $47
	STA.w !REGISTER_BG4VertScrollOffset
	LDA.b $48
	STA.w !REGISTER_BG4VertScrollOffset
CODE_00CA10:
	LDA.w $094B
	STA.w !REGISTER_OAMSizeAndDataAreaDesignation
	LDA.w $095F
	STA.w !REGISTER_BG1AddressAndSize
	LDA.w $0960
	STA.w !REGISTER_BG2AddressAndSize
	LDA.w $096B
	STA.w !REGISTER_ColorMathInitialSettings
	LDA.w $096C
	STA.w !REGISTER_ColorMathSelectAndEnable
	LDA.w $095B
	STA.w !REGISTER_MosaicSizeAndBGEnable
	REP.b #$20
	LDA.w $1407
	STA.l $7E5B99
	STA.l $7E5B9C
	LDA.w #DMA[$00].Parameters
	TCD
	LDA.b HDMA[$01].SourceLo
	STA.b HDMA[$01].TableSourceLo
	LDA.b HDMA[$02].SourceLo
	STA.b HDMA[$02].TableSourceLo
	LDA.b HDMA[$03].SourceLo
	STA.b HDMA[$03].TableSourceLo
	LDA.b HDMA[$04].SourceLo
	STA.b HDMA[$04].TableSourceLo
	LDA.b HDMA[$05].SourceLo
	STA.b HDMA[$05].TableSourceLo
	LDA.b HDMA[$06].SourceLo
	STA.b HDMA[$06].TableSourceLo
	LDA.b HDMA[$07].SourceLo
	STA.b HDMA[$07].TableSourceLo
	SEP.b #$20
	LDA.b #$01
	STA.b HDMA[$01].LineCount
	STA.b HDMA[$02].LineCount
	STA.b HDMA[$03].LineCount
	STA.b HDMA[$04].LineCount
	STA.b HDMA[$05].LineCount
	STA.b HDMA[$06].LineCount
	STA.b HDMA[$07].LineCount
	STZ.w $0125
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$0C
	JMP.w CODE_00C434

;---------------------------------------------------------------------------

DATA_00CA80:
	dw $2000,$2000,$1000,$3000,$0000,$4000

DATA_00CA8C:
	dw $7F96DE,$7F56DE,$7F76DE,$7F76DE,$7F56DE,$7F96DE

DATA_00CA98:
	db $50,$52

CODE_00CA9A:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVS.b CODE_00CA9A
CODE_00CA9F:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_00CA9F
	LDA.b #$8F
	STA.w !REGISTER_ScreenDisplayRegister
	JSR.w CODE_00D4C3
	LDA.w $0069
	BEQ.b CODE_00CAF7
	ASL
	ORA.w $006D
	ASL
	TAX
	REP.b #$20
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.l DATA_00CA80-$04,x
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.l DATA_00CA8C-$04,x
	STA.w DMA[$00].SourceLo
	LDA.w #$2000
	STA.w DMA[$00].SizeLo
	LDY.b #$7F56DE>>16
	STY.w DMA[$00].SourceBank
	LDY.b #$01
	STY.w !REGISTER_DMAEnable
	SEP.b #$20
	DEC.w $0069
	BNE.b CODE_00CAFC
	LDX.b $6D
	LDA.l DATA_00CA98,x
	STA.w !REGISTER_BG1And2TileDataDesignation
	TXA
	EOR.b #$01
	STA.b $6D
CODE_00CAF7:
	LDA.w $011B
	BNE.b CODE_00CB14
CODE_00CAFC:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVS.b CODE_00CAFC
CODE_00CB01:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_00CB01
	LDA.w $0200
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.b #$B1
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	JMP.w CODE_00CB97

CODE_00CB14:
	STZ.w $011B
	REP.b #$20
	LDA.w #!REGISTER_DMAEnable
	TCD
	LDX.b #$06
CODE_00CB1F:
	LDA.w $0B93,x
	STA.l $7017C2,x
	LDA.w $0B9B,x
	STA.l $7017E2,x
	DEX
	DEX
	BPL.b CODE_00CB1F
	LDX.b #$01
	JSR.w CODE_00D52B
	LDA.w $0BD3
	BEQ.b CODE_00CB5B
	LDA.w $0BD5
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	LDA.w #$701C00
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #$701C00>>16
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w $0BD7
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDY.b #$01
	STY.b $00
	STZ.w $0BD3
CODE_00CB5B:
	LDA.w #$0000
	TCD
	SEP.b #$20
	JSR.w CODE_00E507
	LDA.w $0200
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.b #$B1
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	LDA.w $006B
	BEQ.b CODE_00CB97
	STZ.w $006B
	STA.w $0069
	REP.b #$20
	LDA.w #$56DE
	STA.b $20
	LDY.b #$7F
	STY.b $22
	LDA.w #$1C00
	STA.b $23
	LDY.b #$70
	STY.b $25
	LDA.w #$6000
	JSL.l CODE_008288
	SEP.b #$20
CODE_00CB97:
	REP.b #$20
	LDA.b $00
	PHA
	LDX.w $0B8F
	LDA.w $0B93
	CLC
	ADC.l DATA_00CC58,x
	BMI.b CODE_00CBB5
	STA.w $0B93
	STA.w $0B97
	STA.w $0B9D
	STA.w $0B9F
CODE_00CBB5:
	LDX.b #$00
	LDA.w #$F080
CODE_00CBBA:
	STA.w $096D,x
	STZ.w $096F,x
	STA.w $0A6D,x
	STZ.w $0A6F,x
	DEX
	DEX
	DEX
	DEX
	BNE.b CODE_00CBBA
	LDA.w $0B8D
	ASL
	TAX
	LDA.l DATA_00D2C2,x
	STA.b $00
	LDA.w #$007E
	STA.b $02
	REP.b #$10
	LDX.w #$0000
	TXY
CODE_00CBE2:
	REP.b #$20
	LDA.b [$00],y
	STA.b $0A
	INY
	INY
	SEP.b #$20
CODE_00CBEC:
	LDA.b [$00],y
	CMP.b #$FF
	BEQ.b CODE_00CC31
	PHA
	AND.b #$EF
	STA.w $096F,x
	ORA.b #$10
	STA.w $0973,x
	PLA
	AND.b #$10
	LSR
	LSR
	LSR
	ORA.b #$3D
	STA.w $0970,x
	STA.w $0974,x
	LDA.b $0A
	STA.w $096D,x
	STA.w $0971,x
	INY
	CLC
	ADC.b [$00],y
	STA.b $0A
	LDA.b $0B
	STA.w $096E,x
	CLC
	ADC.b #$08
	STA.w $0972,x
	REP.b #$20
	TXA
	CLC
	ADC.w #$0008
	TAX
	INY
	SEP.b #$20
	BRA.b CODE_00CBEC

CODE_00CC31:
	INY
	LDA.b [$00],y
	BEQ.b CODE_00CC50
	INY
	DEC
	BEQ.b CODE_00CBE2
	DEC
	BEQ.b CODE_00CC46
	LDA.b $0A
	CLC
	ADC.b #$08
	STA.b $0A
	BRA.b CODE_00CBEC

CODE_00CC46:
	LDA.b [$00],y
	CLC
	ADC.b $0B
	STA.b $0B
	INY
	BRA.b CODE_00CBEC

CODE_00CC50:
	REP.b #$20
	PLA
	STA.b $00
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

DATA_00CC58:
	dw $F7BE,$0842

DATA_00CC5C:
	dw $A857,$08DA,$08B5,$0498,$07B9,$077C,$087A,$08BB
	dw $089E,$07B9,$08BA,$085C,$00FF

DATA_00CC76:
	dw $A449,$08F5,$0878,$089A,$0878,$08BA,$087F,$0C98
	dw $08F5,$077C,$08D9,$08BC,$089A,$0878,$01FF,$B443
	dw $08F5,$089E,$08BA,$087F,$0498,$087F,$0498,$089A
	dw $109E,$08D7,$0878,$089A,$0878,$087E,$089E,$00FF

DATA_00CCB6:
	dw $A449,$08F4,$087F,$0498,$087E,$077C,$077D,$08BC
	dw $089C,$0C98,$08D1,$0498,$089D,$089E,$01FF,$B450
	dw $08D1,$0498,$087B,$077C,$089A,$0C98,$08D4,$089E
	dw $089D,$089D,$089E,$00FF

DATA_00CCEE:
	dw $A849,$08DA,$08F1,$07B9,$089E,$087E,$07B9,$0878
	dw $089C,$089C,$077C,$07B9,$08BA,$085C,$00FF

DATA_00CD0C:
	dw $A44A,$08F5,$089E,$08BA,$087F,$0498,$109E,$06D2
	dw $08BE,$0878,$08BE,$0878,$089A,$0898,$01FF,$B45A
	dw $08D6,$0878,$08BA,$0878,$07B9,$10BC,$08D7,$0498
	dw $0498,$00FF

DATA_00CD40:
	dw $A452,$08D4,$0498,$08D8,$089E,$08BA,$087F,$1098
	dw $08D4,$089E,$087B,$0878,$01FF,$B442,$08F4,$0878
	dw $08BB,$089E,$07B9,$10BC,$08F5,$0878,$089A,$0878
	dw $087F,$0878,$08BB,$0878,$00FF

DATA_00CD7A:
	dw $A449,$08D4,$0878,$08D9,$08BC,$0878,$089A,$0C98
	dw $08D6,$089E,$07B9,$0498,$08BB,$0878,$01FF,$B443
	dw $081A,$08BC,$0498,$087A,$087F,$0C98,$081A,$0878
	dw $089C,$0878,$089C,$089E,$08BB,$089E,$00FF

DATA_00CDB8:
	dw $A438,$08F4,$087F,$0498,$087E,$077C,$087F,$0498
	dw $07B9,$109E,$08D4,$0878,$08BA,$0878,$089C,$0878
	dw $08BB,$08BA,$08BC,$01FF,$B449,$08F4,$087F,$0498
	dw $087E,$077C,$089A,$0C98,$081A,$089E,$08BA,$087F
	dw $0498,$087B,$0878,$00FF

DATA_00CE00:
	dw $A440,$081A,$0878,$08BA,$08BC,$089D,$089E,$07B9
	dw $0C98,$08F5,$0878,$089A,$077C,$08BB,$0878,$089D
	dw $0498,$00FF

DATA_00CE24:
	dw $A83D,$08DA,$08B4,$089E,$08BC,$07B9,$08BA,$0F7C
	dw $08B5,$077C,$08BA,$0498,$087E,$089D,$077C,$07B9
	dw $08BA,$085C,$00FF

DATA_00CE4A:
	dw $A43E,$081A,$0878,$08BA,$08BC,$087F,$0498,$08BA
	dw $1078,$081A,$0878,$089C,$0878,$089C,$08BC,$07B9
	dw $0878,$01FF,$B45A,$08D4,$077C,$089D,$08BB,$1078
	dw $08F6,$08BA,$08BC,$0498,$00FF

DATA_00CE84:
	dw $A442,$081A,$089E,$08BA,$087F,$0498,$087F,$0498
	dw $07B9,$109E,$08D7,$089E,$089C,$089E,$08BB,$089E
	dw $01FF,$B460,$07B6,$0498,$0799,$0C98,$08D7,$089E
	dw $08BB,$089E,$00FF

DATA_00CEBA:
	dw $A83F,$08DA,$08F4,$089E,$08BC,$089D,$107B,$08B4
	dw $089E,$089C,$089F,$089E,$08BA,$077C,$07B9,$085C
	dw $00FF

DATA_00CEDC:
	dw $A45A,$08D4,$089E,$0799,$0C98,$08D4,$089E,$089D
	dw $087B,$089E,$00FF

DATA_00CEF2:
	dw $A830,$08DA,$08B4,$087F,$0878,$07B9,$0878,$087A
	dw $08BB,$077C,$0FB9,$08B5,$077C,$08BA,$0498,$087E
	dw $089D,$077C,$07B9,$08BA,$085C,$00FF

DATA_00CF1E:
	dw $A44E,$08F4,$087F,$0498,$087E,$077C,$077D,$08BC
	dw $089C,$0C98,$08D1,$0498,$089D,$089E,$01FF,$B44C
	dw $08D1,$0498,$08BA,$0878,$08BA,$087F,$0C98,$08D7
	dw $089E,$087E,$0878,$089C,$0498,$00FF

DATA_00CF5A:
	dw $A44A,$08D6,$0878,$08BA,$0878,$087F,$0498,$07B9
	dw $109E,$06D2,$0498,$089C,$08BC,$07B9,$0878,$01FF
	dw $B445,$08F5,$089E,$089C,$089E,$0878,$089A,$0C98
	dw $08D4,$08BC,$07B9,$089E,$08BC,$089C,$077C,$00FF

DATA_00CF9A:
	dw $A84B,$08DA,$08B4,$08DB,$08D0,$08DB,$08B5,$077C
	dw $08BA,$0498,$087E,$089D,$077C,$07B9,$085C,$00FF

DATA_00CFBA:
	dw $A448,$081A,$089E,$08BA,$087F,$0498,$0878,$089A
	dw $0C98,$08D4,$089E,$0498,$08D9,$08BC,$089C,$0498
	dw $00FF

DATA_00CFDC:
	dw $A838,$08DA,$08F4,$089F,$077C,$087A,$0498,$0878
	dw $0C9B,$08F5,$087F,$0878,$089D,$089A,$10BA,$08F5
	dw $089E,$085C,$00FF

DATA_00D002:
	dw $A443,$0818,$0878,$08BB,$0878,$07B9,$10BC,$081A
	dw $0878,$089C,$0878,$087E,$08BC,$087A,$087F,$0498
	dw $01FF,$B445,$081A,$089E,$08BA,$087F,$0498,$089A
	dw $0C98,$08D1,$0878,$07B9,$08BC,$087F,$0878,$089D
	dw $0878,$00FF

DATA_00D046:
	dw $A450,$081A,$089E,$0498,$087A,$087F,$0C98,$08D4
	dw $089E,$08BB,$0878,$0879,$077C,$01FF,$B44B,$081A
	dw $0878,$08BA,$08BC,$087F,$0498,$07B9,$109E,$08F4
	dw $0878,$089A,$0878,$0498,$00FF

DATA_00D080:
	dw $A44B,$08D1,$0498,$07B9,$089E,$089D,$089E,$0879
	dw $10BC,$08D4,$0878,$089A,$08BC,$0498,$01FF,$B440
	dw $08F4,$087F,$0498,$087E,$077C,$089A,$0C98,$081A
	dw $0878,$089C,$0878,$08BA,$087F,$0498,$07B9,$089E
	dw $00FF

DATA_00D0C2:
	dw $A44C,$08D4,$0498,$089C,$0498,$08D8,$089E,$08BA
	dw $087F,$0C98,$07B7,$08BC,$089A,$08BC,$0498,$01FF
	dw $B45B,$08D4,$077C,$0498,$08D9,$109E,$08D4,$0878
	dw $08BB,$089E,$00FF

DATA_00D0F8:
	dw $A449,$08F4,$089E,$0498,$087A,$087F,$0498,$07B9
	dw $109E,$08F5,$089E,$089C,$0498,$08BB,$0878,$01FF
	dw $B44F,$08D6,$0498,$0F7C,$081A,$089E,$08BA,$087F
	dw $0498,$089C,$08BC,$07B9,$0878,$00FF

DATA_00D134:
	dw $A449,$08D4,$077C,$089D,$08BA,$08BC,$089A,$0F7C
	dw $08F5,$0878,$089D,$0878,$0879,$077C,$01FF,$B445
	dw $08F5,$077C,$08BB,$08BA,$10BC,$08D1,$0878,$08BA
	dw $087F,$0498,$089C,$089E,$08BB,$089E,$00FF

DATA_00D172:
	dw $A451,$08B5,$077C,$07B9,$077C,$0F9A,$0818,$087F
	dw $0498,$089F,$089F,$049B,$077C,$01FF,$B457,$08D1
	dw $0498,$07B9,$109E,$081A,$0878,$089C,$0878,$087B
	dw $0878,$00FF

DATA_00D1A6:
	dw $A858,$08DA,$08F1,$07B9,$089E,$087B,$08BC,$087A
	dw $077C,$07B9,$085C,$00FF

DATA_00D1BE:
	dw $A443,$08F4,$087F,$0498,$087E,$077C,$07B9,$10BC
	dw $08D6,$0498,$08D8,$0878,$089C,$089E,$08BB,$089E
	dw $00FF

DATA_00D1E0:
	dw $A834,$08DA,$07B6,$08BF,$077C,$087A,$08BC,$08BB
	dw $0498,$08BD,$0F7C,$08F1,$07B9,$089E,$087B,$08BC
	dw $087A,$077C,$07B9,$085C,$00FF

DATA_00D20A:
	dw $A446,$08D1,$0498,$07B9,$089E,$08BA,$087F,$0C98
	dw $081A,$0878,$089C,$0878,$08BC,$087A,$087F,$0498
	dw $00FF

DATA_00D22C:
	dw $A41E,$07D5,$089E,$089E,$089A,$10BA,$049B,$0498
	dw $089A,$0F7C,$08BB,$087F,$077C,$10D8,$087F,$0878
	dw $08BD,$0F7C,$0878,$07B9,$07B9,$0498,$08BD,$077C
	dw $087B,$01FF,$B424,$08BE,$087F,$077C,$07B9,$0F7C
	dw $089C,$089E,$109C,$0878,$089D,$107B,$087B,$0878
	dw $107B,$049B,$0498,$08BD,$077C,$08DB,$08DB,$08DB
	dw $08DB,$00FF

DATA_00D290:
	dw $A442,$08D1,$077C,$07B9,$089E,$077C,$10BA,$0878
	dw $07B9,$0F7C,$0879,$089E,$07B9,$089D,$081F,$081F
	dw $00FF

DATA_00D2B2:
	dw $A462,$08F5,$08D1,$0FB6,$07B6,$08D7,$08B5,$00FF

DATA_00D2C2:
	dw DATA_00CC5C,DATA_00CC5C,DATA_00CC76,DATA_00CCB6,DATA_00CCEE,DATA_00CD0C,DATA_00CD40,DATA_00CD7A
	dw DATA_00CDB8,DATA_00CE00,DATA_00CE24,DATA_00CE4A,DATA_00CE84,DATA_00CEBA,DATA_00CEDC,DATA_00CEF2
	dw DATA_00CF1E,DATA_00CF5A,DATA_00CF9A,DATA_00CFBA,DATA_00CFDC,DATA_00D002,DATA_00D046,DATA_00D080
	dw DATA_00D0C2,DATA_00D0F8,DATA_00D134,DATA_00D172,DATA_00D1A6,DATA_00D1BE,DATA_00D1E0,DATA_00D20A
	dw DATA_00D22C,DATA_00D290,DATA_00D2B2

;---------------------------------------------------------------------------

CODE_00D308:
	LDA.w $0125
	BNE.b CODE_00D329
CODE_00D30D:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVS.b CODE_00D30D
CODE_00D312:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_00D312
	LDA.w $094A
	STA.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_ScreenDisplayRegister
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$08
	BRA.b CODE_00D343

CODE_00D329:
	DEC
	BNE.b CODE_00D34F
CODE_00D32C:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVS.b CODE_00D32C
CODE_00D331:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_00D331
	LDA.w $0200
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$D8
CODE_00D343:
	INC.w $0125
CODE_00D346:
	STA.w !REGISTER_VCountTimerLo
	LDA.b #$B1
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	RTS

CODE_00D34F:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVS.b CODE_00D34F
CODE_00D354:
	BIT.w !REGISTER_HVBlankFlagsAndJoypadStatus
	BVC.b CODE_00D354
	LDY.b #$8F
	STY.w !REGISTER_ScreenDisplayRegister
	STZ.w !REGISTER_HDMAEnable
	LDA.w $011B
	BNE.b CODE_00D369
	JMP.w CODE_00D46B

CODE_00D369:
	STZ.w $011B
	JSR.w CODE_00E3DF
	JSR.w CODE_00E3AA
	REP.b #$20
	PHD
	LDA.w #!REGISTER_DMAEnable
	TCD
	LDX.b #$01
	JSR.w CODE_00DE0C
	JSR.w CODE_00D4AC
	JSR.w CODE_00D4E5
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	JSR.w CODE_00DCAE
	LDY.w $0D15
	BEQ.b CODE_00D39E
	JSR.w CODE_00DC97
	STZ.w $0D15
	BRA.b CODE_00D3A1

CODE_00D39E:
	JSR.w CODE_00DC6B
CODE_00D3A1:
	LDA.w $0118
	CMP.w #$0030
	BNE.b CODE_00D3C3
	LDA.w $094A
	AND.w #$0020
	BEQ.b CODE_00D3C0
	LDA.w $10E0
	STA.l $7E5040
	EOR.w #$FFFF
	INC
	STA.l $7E5042
CODE_00D3C0:
	JSR.w CODE_00DBA9
CODE_00D3C3:
	PLD
	SEP.b #$20
	LDA.b $39
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b $3A
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b $3B
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b $3C
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b $3D
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3E
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b $3F
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b $40
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b $41
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $42
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $43
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.b $44
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.w $0967
	STA.w !REGISTER_MainScreenLayers
	LDA.w $0968
	STA.w !REGISTER_SubScreenLayers
	LDA.w $0969
	STA.w !REGISTER_MainScreenWindowMask
	LDA.w $096A
	STA.w !REGISTER_SubScreenWindowMask
	LDA.w $0962
	STA.w !REGISTER_BG1And2TileDataDesignation
	LDA.w $095F
	STA.w !REGISTER_BG1AddressAndSize
	LDA.w $095E
	STA.w !REGISTER_BGModeAndTileSizeSetting
	LDA.w $0964
	STA.w !REGISTER_BG1And2WindowMaskSettings
	LDA.w $0965
	STA.w !REGISTER_BG3And4WindowMaskSettings
	LDA.w $0966
	STA.w !REGISTER_ObjectAndColorWindowSettings
	LDA.w $096B
	STA.w !REGISTER_ColorMathInitialSettings
	LDA.w $096C
	STA.w !REGISTER_ColorMathSelectAndEnable
	LDA.w $094C
	STA.w !REGISTER_BGWindowLogicSettings
	LDA.w $094D
	STA.w !REGISTER_ColorAndObjectWindowLogicSettings
	LDA.w $0960
	STA.w !REGISTER_BG2AddressAndSize
	LDA.w $0961
	STA.w !REGISTER_BG3AddressAndSize
	LDA.w $095B
	STA.w !REGISTER_MosaicSizeAndBGEnable
	JSR.w CODE_00E507
CODE_00D46B:
	REP.b #$20
	LDA.w #DMA[$00].Parameters
	TCD
	LDA.b HDMA[$01].SourceLo
	STA.b HDMA[$01].TableSourceLo
	LDA.b HDMA[$02].SourceLo
	STA.b HDMA[$02].TableSourceLo
	LDA.b HDMA[$03].SourceLo
	STA.b HDMA[$03].TableSourceLo
	LDA.b HDMA[$04].SourceLo
	STA.b HDMA[$04].TableSourceLo
	LDA.b HDMA[$05].SourceLo
	STA.b HDMA[$05].TableSourceLo
	LDA.b HDMA[$06].SourceLo
	STA.b HDMA[$06].TableSourceLo
	LDA.b HDMA[$07].SourceLo
	STA.b HDMA[$07].TableSourceLo
	SEP.b #$20
	LDA.b #$01
	STA.b HDMA[$01].LineCount
	STA.b HDMA[$02].LineCount
	STA.b HDMA[$03].LineCount
	STA.b HDMA[$04].LineCount
	STA.b HDMA[$05].LineCount
	STA.b HDMA[$06].LineCount
	STA.b HDMA[$07].LineCount
	STZ.w $0125
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$06
	JMP.w CODE_00D346

;---------------------------------------------------------------------------

CODE_00D4AC:
	STZ.w !REGISTER_OAMAddressLo
	STZ.b DMA[$00].Parameters-!REGISTER_DMAEnable
	LDA.w #(!REGISTER_OAMDataWritePort&$0000FF)+(($006A00&$0000FF)<<8)
	STA.b DMA[$00].Destination-!REGISTER_DMAEnable
	LDA.w #$006A00>>8
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	LDA.w #$0220
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	RTS

;---------------------------------------------------------------------------

CODE_00D4C3:
	REP.b #$20
	STZ.w !REGISTER_OAMAddressLo
	STZ.w DMA[$00].Parameters
	LDA.w #(!REGISTER_OAMDataWritePort&$0000FF)+(($00096D&$0000FF)<<8)
	STA.w DMA[$00].Destination
	LDA.w #$00096D>>8
	STA.w DMA[$00].SourceHi
	LDA.w #$0220
	STA.w DMA[$00].SizeLo
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_00D4E5:
	LDA.w $0948
	AND.w #$001F
	ORA.w #$0020
	TAY
	STY.w !REGISTER_FixedColorData
	LDA.w $0948
	LSR
	LSR
	LSR
	LSR
	LSR
	AND.w #$001F
	ORA.w #$0040
	TAY
	STY.w !REGISTER_FixedColorData
	LDA.w $0949
	LSR
	LSR
	ORA.w #$0080
	TAY
	STY.w !REGISTER_FixedColorData
CODE_00D510:
	LDY.b #$00
	STY.w !REGISTER_CGRAMAddress
	LDA.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	LDA.w #$702000
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #$702000>>16
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$0200
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	RTS

;---------------------------------------------------------------------------

CODE_00D52B:
	LDA.w $0948
	AND.w #$001F
	ORA.w #$0020
	TAY
	STY.w !REGISTER_FixedColorData
	LDA.w $0948
	LSR
	LSR
	LSR
	LSR
	LSR
	AND.w #$001F
	ORA.w #$0040
	TAY
	STY.w !REGISTER_FixedColorData
	LDA.w $0949
	LSR
	LSR
	ORA.w #$0080
	TAY
	STY.w !REGISTER_FixedColorData
	LDY.b #$00
	STY.w !REGISTER_CGRAMAddress
	LDA.w #(!REGISTER_WriteToCGRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	LDA.w #$701600
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #$701600>>16
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$0200
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b $00
	RTS

;---------------------------------------------------------------------------

CODE_00D571:
	PHB
	PHD
	PHK
	PLB
	REP.b #$20
	LDA.w #!REGISTER_DMAEnable
	TCD
	LDX.b #$01
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	LDA.w #$0020
	STA.w $0000
CODE_00D58D:
	INC.w $7974
	JSR.w CODE_00D65D
	DEC.w $0000
	BNE.b CODE_00D58D
	SEP.b #$20
	PLD
	PLB
	RTL

;---------------------------------------------------------------------------

DATA_00D59D:
	dw $1400,$1400,$1440,$1440,$1480,$1480,$14C0,$14C0
	dw $1400,$1400,$1440,$1440,$1480,$1480,$14C0,$14C0
	dw $1400,$1400,$1440,$1440,$1480,$1480,$14C0,$14C0
	dw $1400,$1400,$1440,$1440,$1480,$1480,$14C0,$14C0

DATA_00D5DD:
	dw DATA_520000+$C000,DATA_520000+$C000,DATA_520000+$C400,DATA_520000+$C100,DATA_520000+$C500,DATA_520000+$C000,DATA_520000+$C400,DATA_520000+$A880
	dw DATA_520000+$C080,DATA_520000+$C080,DATA_520000+$C480,DATA_520000+$C180,DATA_520000+$C580,DATA_520000+$C080,DATA_520000+$C480,DATA_520000+$AA80
	dw DATA_520000+$C200,DATA_520000+$C200,DATA_520000+$C600,DATA_520000+$C300,DATA_520000+$C700,DATA_520000+$C200,DATA_520000+$C600,DATA_520000+$AC80
	dw DATA_520000+$C280,DATA_520000+$C280,DATA_520000+$C680,DATA_520000+$C380,DATA_520000+$C780,DATA_520000+$C280,DATA_520000+$C680,DATA_520000+$AE80

DATA_00D61D:
	dw $0000,$0000,$0008,$0000,$0008,$0000,$0010,$0000
	dw $0000,$0000,$0008,$0000,$0008,$0000,$0010,$0000
	dw $0000,$0000,$0008,$0000,$0008,$0000,$0010,$0000
	dw $0000,$0000,$0008,$0000,$0008,$0000,$0010,$0000

CODE_00D65D:
	LDA.w $61B0
	BNE.b CODE_00D665
	INC.w $0B6D
CODE_00D665:
	LDA.w $0148
	ASL
	TAX
	JSR.w (DATA_00D6C2,x)
	LDA.w $7974
	AND.w #$001E
	ASL
	TAY
	LDA.w $7E08
	AND.w DATA_00D61D,y
	BEQ.b CODE_00D67F
	INY
	INY
CODE_00D67F:
	LDA.w DATA_00D59D,y
	STA.w !REGISTER_VRAMAddressLo
CODE_00D683:
	LDA.w DATA_00D5DD,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #DATA_520000+$C000>>16
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDY.b #$80
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $0CFB
	BEQ.b CODE_00D6C1
	LDA.w #$1280
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$7060C0
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #$7060C0>>16
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDA.w #$1380
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$62C0
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	STZ.w $0CFB
CODE_00D6C1:
	RTS

DATA_00D6C2:
	dw CODE_00D6EA
	dw CODE_00D713
	dw CODE_00D765
	dw CODE_00D7B4
	dw CODE_00D6E6
	dw CODE_00D7F1
	dw CODE_00D81E
	dw CODE_00D898
	dw CODE_00D92D
	dw CODE_00D977
	dw CODE_00D99C
	dw CODE_00D9F6
	dw CODE_00DA65
	dw CODE_00DAE4
	dw CODE_00DB06
	dw CODE_00DB1C
	dw CODE_00DB54
	dw CODE_00DB86

;---------------------------------------------------------------------------

CODE_00D6E6:
	PLA
	LDX.b #$01
	RTS

;---------------------------------------------------------------------------

CODE_00D6EA:
	LDA.w $7974
	AND.w #$0007
	XBA
	LSR
	ORA.w #$1000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #DATA_520000+$B400
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDX.b #DATA_520000+$B400>>16
	STX.b $F9
	LDA.w #$0100
	STA.b $FA
	LDX.b #$01
	STX.b $00
	RTS

;---------------------------------------------------------------------------

DATA_00D70B:
	dw DATA_568000+$0800,DATA_568000+$0A00,DATA_568000+$0C00,DATA_568000+$0E00

CODE_00D713:
	LDA.w #$2F00
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0200
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDY.b #DATA_568000+$0800>>16
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w $7974
	LSR
	LSR
	AND.w #$0006
	TAY
	LDA.w DATA_00D70B,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDX.b #$01
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	RTS

;---------------------------------------------------------------------------

CODE_00D735:
	dw $1000,$1080,$1200,$1280

DATA_00D73D:
	dw $1100,$1180,$1300,$1380

DATA_00D745:
	dw DATA_520000+$D000,DATA_520000+$D800,DATA_520000+$C000,DATA_520000+$C000,DATA_520000+$D200,DATA_520000+$DA00,DATA_520000+$C000,DATA_520000+$C000
	dw DATA_520000+$D400,DATA_520000+$DC00,DATA_520000+$C000,DATA_520000+$C000,DATA_520000+$D600,DATA_520000+$DE00,DATA_520000+$C000,DATA_520000+$C000

CODE_00D765:
	LDA.w $7974
	AND.w #$001E
	TAY
	LDA.w DATA_00D745,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDX.b #DATA_520000+$C000>>16
	STX.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	TYA
	AND.w #$0006
	TAY
	LDA.w CODE_00D735,y
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDX.b #$01
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDA.w DATA_00D73D,y
	STA.w !REGISTER_VRAMAddressLo
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	RTS

;---------------------------------------------------------------------------

DATA_00D794:
	dw DATA_568000+$1000,DATA_568000+$1000,DATA_568000+$1000,DATA_568000+$1000,DATA_568000+$1200,DATA_568000+$1200,DATA_568000+$1200,DATA_568000+$1200
	dw DATA_568000+$1400,DATA_568000+$1400,DATA_568000+$1400,DATA_568000+$1400,DATA_568000+$1600,DATA_568000+$1600,DATA_568000+$1600,DATA_568000+$1600

CODE_00D7B4:
	LDA.w $7974
	AND.w #$000F
	ASL
	TAY
	LDA.w DATA_00D794,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDX.b #DATA_568000+$1000>>16
	STX.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$2F00
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0200
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDX.b #$01
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	RTS

;---------------------------------------------------------------------------

DATA_00D7D5:
	dw DATA_568000+$1800,DATA_568000+$1A00,DATA_568000+$1C00,DATA_568000+$1E00,DATA_568000+$2000,DATA_568000+$2200,DATA_568000+$2400,DATA_568000+$2600
	dw DATA_568000+$2400,DATA_568000+$2200,DATA_568000+$2000,DATA_568000+$1E00,DATA_568000+$1C00,DATA_568000+$1A00

CODE_00D7F1:
	LDA.w $0B67
	INC
	CMP.w #$0038
	BCC.b CODE_00D7FD
	LDA.w #$0000
CODE_00D7FD:
	STA.w $0B67
	LSR
	AND.w #$00FE
	TAY
CODE_00D805:
	LDA.w DATA_00D7D5,y
CODE_00D808:
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDX.b #DATA_568000+$1800>>16
	STX.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$2F00
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0200
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDX.b #$01
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	RTS

CODE_00D81E:
	LDA.w $0B6D
	CMP.w #$0006
	BCC.b CODE_00D834
	STZ.w $0B6D
	LDA.w $0B67
	INC
	INC
	AND.w #$000E
	STA.w $0B67
CODE_00D834:
	LDY.w $0B67
	LDA.w $0146
	CMP.w #$000A
	BNE.b CODE_00D805
	LDA.w DATA_00D7D5,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDX.b #DATA_568000+$1800>>16
	STX.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$7F00
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0200
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDX.b #$01
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	RTS

;---------------------------------------------------------------------------

DATA_00D858:
	dw DATA_520000+$C800,DATA_520000+$CA00,DATA_520000+$CC00,DATA_520000+$CE00,DATA_520000+$EC00,DATA_520000+$EE00,DATA_520000+$F000,DATA_520000+$F200

DATA_00D868:
	dw DATA_520000+$C900,DATA_520000+$CB00,DATA_520000+$CD00,DATA_520000+$CF00,DATA_520000+$ED00,DATA_520000+$EF00,DATA_520000+$F100,DATA_520000+$F300

DATA_00D878:
	dw DATA_520000+$EC00,DATA_520000+$EE00,DATA_520000+$F000,DATA_520000+$F200,DATA_520000+$F400,DATA_520000+$F600,DATA_520000+$F800,DATA_520000+$FA00

DATA_00D888:
	dw DATA_520000+$ED00,DATA_520000+$EF00,DATA_520000+$F100,DATA_520000+$F300,DATA_520000+$F500,DATA_520000+$F700,DATA_520000+$F900,DATA_520000+$FB00

CODE_00D898:
	LDA.w $0B6D
	CMP.w #$000B
	BCC.b CODE_00D8AD
	STZ.w $0B6D
	LDA.w $0B67
	INC
	AND.w #$0003
	STA.w $0B67
CODE_00D8AD:
	LDA.w $0B67
	ASL
	TAY
	LDX.b #DATA_520000+$C800>>16
	LDA.w $0136
	CMP.w #$000A
	BNE.b CODE_00D8C3
	TYA
	ORA.w #$0008
	TAY
	LDX.b #DATA_568000+$4800>>16
CODE_00D8C3:
	STX.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDX.b #$01
	LDA.w $7974
	AND.w #$0001
	BEQ.b CODE_00D8F6
	LDA.w DATA_00D858,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$1000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.w !REGISTER_DMAEnable
	LDA.w DATA_00D868,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$1100
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.w !REGISTER_DMAEnable
	RTS

CODE_00D8F6:
	LDA.w DATA_00D878,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$1080
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.w !REGISTER_DMAEnable
	LDA.w DATA_00D888,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$1180
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.w !REGISTER_DMAEnable
	RTS

;---------------------------------------------------------------------------

DATA_00D91D:
	dw DATA_520000+$E400,DATA_520000+$E600,DATA_520000+$E800,DATA_520000+$EA00

DATA_00D925:
	dw DATA_520000+$E500,DATA_520000+$E700,DATA_520000+$E900,DATA_520000+$EB00

CODE_00D92D:
	INC.w $0B6D
	LDA.w $0B6D
	CMP.w #$0010
	BCC.b CODE_00D945
	STZ.w $0B6D
	LDA.w $0B67
	INC
	AND.w #$0003
	STA.w $0B67
CODE_00D945:
	LDA.w $0B67
	ASL
	TAY
	LDA.w DATA_00D91D,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDX.b #$52
	STX.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$1000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	LDA.w DATA_00D925,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$1100
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.w !REGISTER_DMAEnable
	RTS

;---------------------------------------------------------------------------

CODE_00D977:
	INC.w $0B6D
	LDA.w $0B6D
	CMP.w #$0008
	BCC.b CODE_00D992
	STZ.w $0B6D
	LDA.w $0B67
	CLC
	ADC.w #$0200
	AND.w #$0600
	STA.w $0B67
CODE_00D992:
	LDA.w #$8000
	CLC
	ADC.w $0B67
	JMP.w CODE_00D808

;---------------------------------------------------------------------------

CODE_00D99C:
	LDA.w $0B6D
	CMP.w #$0008
	BCC.b CODE_00D9B4
	STZ.w $0B6D
	LDA.w $0B67
	CLC
	ADC.w #$0200
	AND.w #$0E00
	STA.w $0B67
CODE_00D9B4:
	LDA.w #$B000
	CLC
	ADC.w $0B67
	JMP.w CODE_00D808

;---------------------------------------------------------------------------

DATA_00D9BE:
	dw $B000,$B200,$B400,$B600,$B800,$BA00,$BC00,$BE00
	dw $BC00,$BA00,$B800,$B600,$B400,$B200

DATA_00D9DA:
	dw $000A,$0004,$0004,$0004,$0004,$0004,$0004,$000A
	dw $0004,$0004,$0004,$0004,$0004,$0004

CODE_00D9F6:
	LDA.w $7974
	AND.w #$0001
	BNE.b CODE_00DA02
	JSR.w CODE_00D765
	RTS

CODE_00DA02:
	LDA.w $0B67
	AND.w #$000F
	ASL
	TAY
	LDA.w $0B6D
	CMP.w DATA_00D9DA,y
	BCC.b CODE_00DA23
	STZ.w $0B6D
	INC.w $0B67
	LDA.w $0B67
	CMP.w #$000E
	BCC.b CODE_00DA23
	STZ.w $0B67
CODE_00DA23:
	LDA.w DATA_00D9BE,y
	JMP.w CODE_00D808

;---------------------------------------------------------------------------

DATA_00DA29:
	dw DATA_520000+$E000,DATA_520000+$E100,DATA_520000+$E200,DATA_520000+$E300,DATA_520000+$F400,DATA_520000+$F500,DATA_520000+$F600,DATA_520000+$F700
	dw DATA_520000+$F400,DATA_520000+$F500,DATA_520000+$E200,DATA_520000+$E300

DATA_00DA41:
	dw DATA_520000+$F800,DATA_520000+$F900,DATA_520000+$FA00,DATA_520000+$FB00,DATA_520000+$FC00,DATA_520000+$FD00,DATA_520000+$FE00,DATA_520000+$FF00
	dw DATA_520000+$FC00,DATA_520000+$FD00,DATA_520000+$FA00,DATA_520000+$FB00

DATA_00DA59:
	dw $0010,$000C,$000C,$0010,$000C,$000C

CODE_00DA65:
	LDX.w $0B67
	LDA.w $0B6D
	CMP.w DATA_00DA59,x
	BCC.b CODE_00DA83
	STZ.w $0B6D
	LDA.w $0B67
	INC
	INC
	CMP.w #$000C
	BCC.b CODE_00DA80
	LDA.w #$0000
CODE_00DA80:
	STA.w $0B67
CODE_00DA83:
	LDA.w $0B67
	ASL
	TAY
	LDX.b #DATA_520000+$E000>>16
	STX.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDX.b #$01
	LDA.w $7974
	AND.w #$0002
	BNE.b CODE_00DABD
	LDA.w DATA_00DA29,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$1000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.w !REGISTER_DMAEnable
	LDA.w DATA_00DA29+$02,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$1100
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.w !REGISTER_DMAEnable
	RTS

CODE_00DABD:
	LDA.w DATA_00DA41,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$1080
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.w !REGISTER_DMAEnable
	LDA.w DATA_00DA41+$02,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$1180
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0100
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.w !REGISTER_DMAEnable
	RTS

;---------------------------------------------------------------------------

CODE_00DAE4:
	INC.w $0B6F
	LDA.w $0B6F
	CMP.w #$0006
	BCS.b CODE_00DAF2
	JMP.w CODE_00D898

CODE_00DAF2:
	STZ.w $0B6F
	LDA.w $0B69
	INC
	INC
	AND.w #$000E
	STA.w $0B69
	LDY.w $0B69
	JMP.w CODE_00D805

CODE_00DB06:
	INC.w $0B6F
	LDA.w $7974
	AND.w #$0001
	BEQ.b CODE_00DAF2
	JMP.w CODE_00DA65

;---------------------------------------------------------------------------

DATA_00DB14:
	dw $A800,$AA00,$AC00,$AE00

CODE_00DB1C:
	LDA.w $0B71
	INC
	CMP.w #$0006
	BCC.b CODE_00DB2B
	INC.w $0B6B
	LDA.w #$0000
CODE_00DB2B:
	STA.w $0B71
	LDX.b #$01
	LDY.w $0B6B
	CMP.w #$0000
	BNE.b CODE_00DB43
	TYA
	AND.w #$0006
	TAY
	LDA.w DATA_00DB14,y
	JMP.w CODE_00D808

CODE_00DB43:
	RTS

;---------------------------------------------------------------------------

CODE_00DB44:
	dw DATA_568000+$4000,DATA_568000+$4100,DATA_568000+$4200,DATA_568000+$4300

DATA_00DB4C:
	dw DATA_568000+$4080,DATA_568000+$4180,DATA_568000+$4280,DATA_568000+$4380

CODE_00DB54:
	LDA.w $0B6D
	AND.w #$000C
	LSR
	TAY
	LDX.b #DATA_568000+$4000>>16
	STX.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w CODE_00DB44,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$2F00
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0080
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDA.w DATA_00DB4C,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$2F80
	STA.w !REGISTER_VRAMAddressLo
	STX.w !REGISTER_DMAEnable
	RTS

;---------------------------------------------------------------------------

CODE_00DB86:
	LDA.w $7974
	AND.w #$0003
	BNE.b CODE_00DB91
	JMP.w CODE_00D7B4

CODE_00DB91:
	JMP.w CODE_00DA65

;---------------------------------------------------------------------------

CODE_00DB94:
	REP.b #$20
	PHD
	LDA.w #!REGISTER_DMAEnable
	TCD
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	LDX.b #$01
	JSR.w CODE_00DBA9
	PLD
	SEP.b #$20
	RTL

CODE_00DBA9:
	LDY.b #$00
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDY.b #$81
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDY.w $0077
	BEQ.b CODE_00DBD5
	LDA.w #$6DAA
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $007B
	STA.w !REGISTER_VRAMAddressLo
	LDY.b #$40
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $007F
	STA.w !REGISTER_VRAMAddressLo
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	STZ.w $0077
CODE_00DBD5:
	LDY.b #$80
	STY.w !REGISTER_VRAMAddressIncrementValue
	LDY.w $0079
	BEQ.b CODE_00DC1B
	LDA.w #$6E2A
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $007D
	STA.w !REGISTER_VRAMAddressLo
	LDA.w $0083
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $0081
	STA.w !REGISTER_VRAMAddressLo
	LDA.w $0087
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $0085
	STA.w !REGISTER_VRAMAddressLo
	LDA.w $0083
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $0089
	STA.w !REGISTER_VRAMAddressLo
	LDA.w $0087
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	STZ.w $0079
CODE_00DC1B:
	RTS

;---------------------------------------------------------------------------

CODE_00DC1C:
	LDA.w $09ED
	BEQ.b CODE_00DC60
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDX.b #$01
	STX.b DMA[$00].Parameters-!REGISTER_DMAEnable
	LDX.b #!REGISTER_WriteToVRAMPortLo
	STX.b DMA[$00].Destination-!REGISTER_DMAEnable
	LDX.b #$4C
	STX.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDY.b #$00
	LDX.b #$01
CODE_00DC36:
	LDA.w $09EF,y
	BMI.b CODE_00DC60
	PHA
	STA.w !REGISTER_VRAMAddressLo
	LDA.w $09F1,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$0004
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	PLA
	CLC
	ADC.w #$0020
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0004
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	INY
	INY
	INY
	INY
	BRA.b CODE_00DC36

CODE_00DC60:
	LDA.w #$0000
	STA.w $09ED
	DEC
	STA.w $09EF
	RTS

;---------------------------------------------------------------------------

CODE_00DC6B:
	LDA.w $0CF9
	BEQ.b CODE_00DC96
	BPL.b CODE_00DC7D
	AND.w #$7FE0
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$6800
	BRA.b CODE_00DC86

CODE_00DC7D:
	LDA.w #$5C00
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$705800
CODE_00DC86:
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #$705800>>16
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$0800
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	STZ.w $0CF9
CODE_00DC96:
	RTS

;---------------------------------------------------------------------------

CODE_00DC97:
	LDA.w #$3000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$704E00
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #$704E00>>16
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$0800
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	RTS

;---------------------------------------------------------------------------

CODE_00DCAE:
	LDA.w #$4000
	STA.w !REGISTER_VRAMAddressLo
	LDY.b #$40
	LDA.w $6128
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $612A
	STA.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $612C
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $612E
	STA.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $6130
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $6132
	STA.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $6134
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $6136
	STA.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $6138
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $613A
	STA.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $613C
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $613E
	STA.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $6140
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $6142
	STA.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$0020
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDA.w $6145
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	LDA.w $6144
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w #$4100
	STA.w !REGISTER_VRAMAddressLo
	LDA.w $6128
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $612A
	XBA
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $612C
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $612E
	XBA
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $6130
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $6132
	XBA
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $6134
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $6136
	XBA
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $6138
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $613A
	XBA
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $613C
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $613E
	XBA
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $6140
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $6142
	XBA
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	LDA.w #$0020
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDA.w $6144
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $6146
	XBA
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $0B85
	BEQ.b CODE_00DDE7
	LDA.w #$4620
	STA.w !REGISTER_VRAMAddressLo
	LDA.w $0B87
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w #$0052
	STA.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $0B8B
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w #$4720
	STA.w !REGISTER_VRAMAddressLo
	LDA.w $0B89
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w $0B8D
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	STY.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	STZ.w $0B85
CODE_00DDE7:
	LDA.w $6114
	BEQ.b CODE_00DE0B
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDY.b #$52
	STY.b DMA[$00].SourceBank-!REGISTER_DMAEnable
	LDA.w #$4200
	STA.w !REGISTER_VRAMAddressLo
	LDY.b #$01
	STY.b DMA[$00].SizeHi-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	LDA.w #$4300
	STA.w !REGISTER_VRAMAddressLo
	STY.b DMA[$00].SizeHi-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	STZ.w $6114
CODE_00DE0B:
	RTS

;---------------------------------------------------------------------------

CODE_00DE0C:
	LDA.w #(!REGISTER_ReadOrWriteToWRAMPort&$0000FF<<8)+$00
	STA.b DMA[$00].Parameters-!REGISTER_DMAEnable
	LDY.b #$02
	LDA.w $096D,y
	BEQ.b CODE_00DE43
CODE_00DE18:
	STA.b DMA[$00].SizeLo-!REGISTER_DMAEnable
	LDA.w $096F,y
	STA.w !REGISTER_WRAMAddressLo
	LDA.w $0970,y
	STA.w !REGISTER_WRAMAddressHi
	LDA.w $0972,y
	STA.b DMA[$00].SourceLo-!REGISTER_DMAEnable
	LDA.w $0973,y
	STA.b DMA[$00].SourceHi-!REGISTER_DMAEnable
	STX.b !REGISTER_DMAEnable-!REGISTER_DMAEnable
	TYA
	CLC
	ADC.w #$0008
	TAY
	LDA.w $096D,y
	BNE.b CODE_00DE18
	STZ.w $096D
	STZ.w $096F
CODE_00DE43:
	RTS

;---------------------------------------------------------------------------

YI_BeginSuperFXProcessingRt:
;$00DE44
	STZ.w !REGISTER_SuperFX_StatusFlagsLo
	LDY.w $012D
	STY.w !REGISTER_SuperFX_ScreenBase
	LDY.w $012E
	STY.w !REGISTER_SuperFX_ScreenMode
	STX.w !REGISTER_SuperFX_ProgramBankRegister
	STA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	LDA.w #!SuperFX_StatusFlags_GoFlag
CODE_00DE5C:
	BIT.w !REGISTER_SuperFX_StatusFlagsLo
	BNE.b CODE_00DE5C
	LDY.b #!SuperFX_ScreenMode_ScreenHeight_128pixels|!SuperFX_ScreenMode_ColorMode_4Colors|!SuperFX_ScreenMode_SNESasWRAMAccess|!SuperFX_ScreenMode_SNESasROMAccess
	STY.w !REGISTER_SuperFX_ScreenMode
	RTL

;---------------------------------------------------------------------------

CODE_00DE67:
	PHB
	STZ.w !REGISTER_SuperFX_StatusFlagsLo
	LDY.w $012D
	STY.w !REGISTER_SuperFX_ScreenBase
	LDY.w $012E
	STY.w !REGISTER_SuperFX_ScreenMode
	STX.w !REGISTER_SuperFX_ProgramBankRegister
	STA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	PHK
	PLB
	JSR.w CODE_00E240
	PLB
	LDA.w #!SuperFX_StatusFlags_GoFlag
CODE_00DE86:
	BIT.w !REGISTER_SuperFX_StatusFlagsLo
	BNE.b CODE_00DE86
	LDY.b #!SuperFX_ScreenMode_ScreenHeight_128pixels|!SuperFX_ScreenMode_ColorMode_4Colors|!SuperFX_ScreenMode_SNESasWRAMAccess|!SuperFX_ScreenMode_SNESasROMAccess
	STY.w !REGISTER_SuperFX_ScreenMode
	RTL

;---------------------------------------------------------------------------

CODE_00DE91:
	STZ.w !REGISTER_SuperFX_StatusFlagsLo
	LDY.w $012D
	STY.w !REGISTER_SuperFX_ScreenBase
	LDY.w $012E
	STY.w !REGISTER_SuperFX_ScreenMode
	STX.w !REGISTER_SuperFX_ProgramBankRegister
	STA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	REP.b #$10
	LDA.w #!SuperFX_StatusFlags_GoFlag
	TAY
CODE_00DEAC:
	BIT.w !REGISTER_SuperFX_StatusFlagsLo
	BNE.b CODE_00DEAC
	LDX.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	BEQ.b CODE_00DEC6
	LDA.l $7F0000,x
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	STA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	TYA
	BRA.b CODE_00DEAC

CODE_00DEC6:
	LDY.w #!SuperFX_ScreenMode_ScreenHeight_128pixels|!SuperFX_ScreenMode_ColorMode_4Colors|!SuperFX_ScreenMode_SNESasWRAMAccess|!SuperFX_ScreenMode_SNESasROMAccess
	STY.w !REGISTER_SuperFX_ScreenMode
	SEP.b #$10
	RTL

;---------------------------------------------------------------------------

CODE_00DECF:
	STZ.w !REGISTER_SuperFX_StatusFlagsLo
	LDY.w $012D
	STY.w !REGISTER_SuperFX_ScreenBase
	LDY.w $012E
	STY.w !REGISTER_SuperFX_ScreenMode
	STX.w !REGISTER_SuperFX_ProgramBankRegister
	STA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	REP.b #$10
	LDA.w #!SuperFX_StatusFlags_GoFlag
	TAY
CODE_00DEEA:
	BIT.w !REGISTER_SuperFX_StatusFlagsLo
	BNE.b CODE_00DEEA
	LDX.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	BPL.b CODE_00DF04
	LDA.l $7F0000,x
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	STA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	TYA
	BRA.b CODE_00DEEA

CODE_00DF04:
	BEQ.b CODE_00DF1F
	STZ.w !REGISTER_SuperFX_ScreenMode
	JSR.w (DATA_00DF28-$02,x)
	SEP.b #$20
	LDA.w $012E
	STA.w !REGISTER_SuperFX_ScreenMode
	REP.b #$20
	LDA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	STA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	TYA
	BRA.b CODE_00DEEA

CODE_00DF1F:
	LDY.w #!SuperFX_ScreenMode_ScreenHeight_128pixels|!SuperFX_ScreenMode_ColorMode_4Colors|!SuperFX_ScreenMode_SNESasWRAMAccess|!SuperFX_ScreenMode_SNESasROMAccess
	STY.w !REGISTER_SuperFX_ScreenMode
	SEP.b #$10
	RTL

DATA_00DF28:
	dw CODE_00DF68
	dw CODE_00E04F
	dw CODE_00E0A9
	dw CODE_00E0CD
	dw CODE_00DFC3
	dw CODE_00E023
	dw CODE_00E017
	dw CODE_00E0D7
	dw CODE_00E0E6
	dw CODE_00E0F2
	dw CODE_00DF44
	dw CODE_00E068
	dw CODE_00E101
	dw CODE_00E126

;---------------------------------------------------------------------------

CODE_00DF44:
	PHY
	LDA.w $021A
	CMP.w #$000B
	BNE.b CODE_00DF62
	STZ.w $021A
	LDA.w #$001F
	STA.w $0118
	LDA.w #$0001
	STA.w $022D
	JSL.l CODE_01B2B7
	PLY
	RTS

CODE_00DF62:
	JSL.l CODE_02A4B5
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_00DF68:
	PHY
	SEP.b #$10
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$A400
	BNE.b CODE_00DF7A
	JSR.w CODE_00DFE2
	SEP.b #$10
	BRA.b CODE_00DF97

CODE_00DF7A:
	LDA.w $6000
	AND.w #$FFF0
	STA.w $0000
	LDA.w $6002
	AND.w #$FFF0
	STA.w $0002
	JSL.l CODE_03A520
	LDA.w #$0009
	JSL.l CODE_0085D2
CODE_00DF97:
	LDA.w #$01E4
	JSL.l CODE_008B21
	LDA.w $0000
	STA.w $70A2,y
	LDA.w $0002
	STA.w $7142,y
	LDA.w #$000C
	STA.w $73C2,y
	LDA.w #$0008
	STA.w $7782,y
	REP.b #$10
	LDA.w #$0000
	STA.w $0095
	LDA.w #$0007
	BRA.b CODE_00DFCD

CODE_00DFC3:
	LDA.w #$0000
	STA.w $0095
CODE_00DFC9:
	PHY
	LDA.w #$0001
CODE_00DFCD:
	STA.w $008F
	LDA.w $6000
	STA.w $0091
	LDA.w $6002
	STA.w $0093
	JSL.l CODE_109295
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_00DFE2:
	LDA.w #$0093
	INC.w $03B4
	LDY.w $03B4
	CPY.w #$0014
	BMI.b CODE_00DFF1
	INC
CODE_00DFF1:
	JSL.l CODE_0085D2
	LDA.w #$0002
	STA.w $0006
	SEP.b #$10
	LDA.w $6000
	AND.w #$FFF0
	STA.w $0000
	LDA.w $6002
	AND.w #$FFF0
	JSL.l CODE_03A4F5
	REP.b #$10
	RTS

CODE_00E013:
	JSR.w CODE_00DFE2
	RTL

;---------------------------------------------------------------------------

CODE_00E017:
	LDA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	STA.w $0095
	BRA.b CODE_00DFC9

;---------------------------------------------------------------------------

CODE_00E01F:
	JSR.w CODE_00E023
	RTL

CODE_00E023:
	JSR.w CODE_00DFC3
	PHY
	LDA.w $0091
	CLC
	ADC.w #$0010
	STA.w $0091
	JSL.l CODE_109295
	LDA.w $0093
	CLC
	ADC.w #$0010
	STA.w $0093
	JSL.l CODE_109295
	LDA.w $6000
	STA.w $0091
	JSL.l CODE_109295
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_00E04F:
	PHY
	LDA.w $6000
	STA.w $0091
	LDA.w $6002
	STA.w $0093
	LDA.w #$0000
	STA.w $008F
	JSL.l CODE_109295
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_00E068:
	PHY
	LDA.w $6000
	STA.w $0091
	LDA.w $6002
	STA.w $0093
	LDA.w #$0006
	STA.w $008F
	JSL.l CODE_109295
	PLY
	RTS

;---------------------------------------------------------------------------

DATA_00E081:
	dw $0000,$0000,$0000,$2A0D,$0000,$0000,$0000,$2A1C
	dw $0000,$0000,$0000,$2A2B,$0000,$0000,$0000,$2A3A
	dw $0000,$0000,$0000,$964C

CODE_00E0A9:
	PHY
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	AND.w #$00FF
	ASL
	TAX
	LDA.l DATA_00E081&$00FFFF,x
	STA.b $95
	LDA.w $6000
	STA.b $91
	LDA.w $6002
	STA.b $93
	LDA.w #$0004
	STA.b $8F
	JSL.l CODE_109295
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_00E0CD:
	PHY
	LDX.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	JSL.l CODE_03BF87
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_00E0D7:
	LDA.w $013E
	CMP.w #$000A
	BNE.b CODE_00E0E5
	PHY
	JSL.l CODE_04F1F6
	PLY
CODE_00E0E5:
	RTS

;---------------------------------------------------------------------------

CODE_00E0E6:
	LDA.w $0CCA
	BNE.b CODE_00E0F1
	PHY
	JSL.l CODE_04AC9C
	PLY
CODE_00E0F1:
	RTS

;---------------------------------------------------------------------------

CODE_00E0F2:
	PHY
	SEP.b #$10
	JSL.l CODE_03A853
	REP.b #$10
	PLY
	RTS

;---------------------------------------------------------------------------

DATA_00E0FD:
	dw $0080,$FF80

CODE_00E101:
	LDA.w $0CCA
	BNE.b CODE_00E125
	PHY
	LDA.w #$0028
	JSL.l CODE_04F6E2
	LDA.w #$FB00
	STA.w $60AA
	LDX.w $60C4
	LDA.l DATA_00E0FD&$00FFFF,x
	STA.w $60A8
	LDA.w #$0020
	STA.w $61F6
	PLY
CODE_00E125:
	RTS

;---------------------------------------------------------------------------

CODE_00E126:
	PHY
	LDA.w $6000
	STA.l $007972
	SEP.b #$10
	TAX
	LDA.w $7360,x
	CMP.w #$0115
	BEQ.b CODE_00E144
	CMP.w #$0065
	BNE.b CODE_00E14A
	JSL.l CODE_0CEA92
	BRA.b CODE_00E14E

CODE_00E144:
	JSL.l CODE_04CA27
	BRA.b CODE_00E14E

CODE_00E14A:
	JSL.l CODE_0EB499
CODE_00E14E:
	REP.b #$10
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_00E152:
	PHB
	STZ.w !REGISTER_SuperFX_StatusFlagsLo
	LDY.w $012D
	STY.w !REGISTER_SuperFX_ScreenBase
	LDY.w $012E
	STY.w !REGISTER_SuperFX_ScreenMode
	STX.w !REGISTER_SuperFX_ProgramBankRegister
	STA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	LDA.w $011A
	BEQ.b CODE_00E170
	JMP.w CODE_00E225

CODE_00E170:
	PHK
	PLB
	REP.b #$10
	LDX.b $04
	LDY.b $06
	LDA.w #$000C
	STA.b $0C
CODE_00E17D:
	CPX.w #$01FE
	BCC.b CODE_00E188
	STZ.b $0E
	LDA.b $3F
	BRA.b CODE_00E1EE

CODE_00E188:
	TYA
	LSR
	LSR
	STA.b $08
	CLC
	ADC.w #$0008
	CMP.w #$0020
	BCC.b CODE_00E199
	LDA.w #$0020
CODE_00E199:
	ASL
	STA.b $0A
	LDA.w DATA_00E9D4,x
	PHP
	BPL.b CODE_00E1A6
	EOR.w #$FFFF
	INC
CODE_00E1A6:
	CMP.w #$0100
	SEP.b #$20
	XBA
	LDA.b $0A
	BCS.b CODE_00E1C4
	STA.l !REGISTER_Multiplicand
	XBA
	STA.l !REGISTER_Multiplier
	NOP #3
	REP.b #$20
	LDA.l $004217
	BRA.b CODE_00E1C6

CODE_00E1C4:
	REP.b #$20
CODE_00E1C6:
	AND.w #$00FF
	LSR
	LSR
	LSR
	LSR
	PLP
	BPL.b CODE_00E1D4
	EOR.w #$FFFF
	INC
CODE_00E1D4:
	STA.b $0E
	CLC
	ADC.b $08
	AND.w #$00FF
	CMP.w #$0030
	LDA.b $0E
	BCC.b CODE_00E1EB
	LDA.b $08
	EOR.w #$FFFF
	ADC.w #$002F
CODE_00E1EB:
	CLC
	ADC.b $3F
CODE_00E1EE:
	STA.w $55C6,y
CODE_00E1F0:
	LDA.b $0E
	STA.w $55C4,y
	PHX
	TXA
	CMP.w #$01FE
	BCC.b CODE_00E200
	LDA.w #$01FE
CODE_00E200:
	LSR
	AND.w #$00FC
	TAX
	LDA.w $54C2,x
	STA.w $53C2,y
	PLA
	SEC
	SBC.w #$0010
	AND.w #$07FE
	TAX
	INY
	INY
	INY
	INY
	DEC.b $0C
	BEQ.b CODE_00E21F
	JMP.w CODE_00E17D

CODE_00E21F:
	STX.b $04
	STY.b $06
	SEP.b #$10
CODE_00E225:
	PLB
	LDA.w #!SuperFX_StatusFlags_GoFlag
CODE_00E229:
	BIT.w !REGISTER_SuperFX_StatusFlagsLo
	BNE.b CODE_00E229
	LDY.b #!SuperFX_ScreenMode_ScreenHeight_128pixels|!SuperFX_ScreenMode_ColorMode_4Colors|!SuperFX_ScreenMode_SNESasWRAMAccess|!SuperFX_ScreenMode_SNESasROMAccess
	STY.w !REGISTER_SuperFX_ScreenMode
	RTL

;---------------------------------------------------------------------------

DATA_00E234:
	dw $0064,$000A

DATA_00E238:
	dw $000A,$FFF6

DATA_00E23C:
	dw $012C,$0000

CODE_00E240:
	REP.b #$10
	LDA.w $0379
	CMP.w #$03E8
	BCC.b CODE_00E25E
	LDA.w #$03E7
	STA.w $0379
	LDA.w $037F
	CMP.w #$03E8
	BCC.b CODE_00E25E
	LDA.w #$03E7
	STA.w $037F
CODE_00E25E:
	STZ.w $0389
	INC.w $03A9
	LDY.w #$0000
	LDA.w $0396
	BEQ.b CODE_00E2B5
	BPL.b CODE_00E270
	INY
	INY
CODE_00E270:
	LDA.w $0B57
	BNE.b CODE_00E27D
	LDA.w $03A9
	CMP.w #$0008
	BCC.b CODE_00E2B3
CODE_00E27D:
	LDA.w #$0036
	JSR.w CODE_00E372
	STZ.w $03A9
	LDA.w $03B6
	CLC
	ADC.w DATA_00E238,y
	BMI.b CODE_00E297
	STA.w $03B6
	CMP.w DATA_00E23C,y
	BCC.b CODE_00E2A3
CODE_00E297:
	LDA.w DATA_00E23C,y
	STA.w $03B6
	STZ.w $0396
	JMP.w CODE_00E32C

CODE_00E2A3:
	LDA.w $0396
	SEC
	SBC.w DATA_00E238,y
	STA.w $0396
	TYA
	BNE.b CODE_00E2B3
	INC.w $0389
CODE_00E2B3:
	BRA.b CODE_00E32C

CODE_00E2B5:
	LDA.w $0387
	BMI.b CODE_00E2CC
	BNE.b CODE_00E32C
	LDA.w $0B57
	ORA.w $0B65
	ORA.w $0B7B
	ORA.w $0D0F
	BEQ.b CODE_00E2F5
	BRA.b CODE_00E32C

CODE_00E2CC:
	LDA.w $03B6
	CMP.w #$006D
	BCS.b CODE_00E32C
	INC.w $0394
	LDA.w $0394
	CMP.w #$000C
	BCC.b CODE_00E32C
	STZ.w $0394
	INC.w $03B6
	LDA.w $03B6
	CMP.w #$0064
	BNE.b CODE_00E32C
	LDA.w #$0032
	JSR.w CODE_00E372
	BRA.b CODE_00E32C

CODE_00E2F5:
	STZ.w $0394
	LDA.w $0C8A
	BNE.b CODE_00E36F
	LDA.w $03B6
	BEQ.b CODE_00E36F
	INC.w $0392
	LDA.w $0392
	CMP.w #$0004
	BCC.b CODE_00E32C
	STZ.w $0392
	DEC.w $03B6
	LDA.w $03B6
	CMP.w #$005A
	BCS.b CODE_00E32C
	LDA.w $03AB
	AND.w #$00FF
	BNE.b CODE_00E32C
	INC.w $03AB
	LDA.w #$0024
	JSR.w CODE_00E372
CODE_00E32C:
	LDX.w #$0000
	LDA.w $03B6
	CMP.w #$03E8
	BCC.b CODE_00E33D
	LDA.w #$03E7
	STA.w $03B6
CODE_00E33D:
	LDY.w #$0000
CODE_00E340:
	CMP.w DATA_00E234,x
	BCC.b CODE_00E34B
	SBC.w DATA_00E234,x
	INY
	BRA.b CODE_00E340

CODE_00E34B:
	STY.b $00,x
	INX
	INX
	CPX.w #$0004
	BNE.b CODE_00E33D
	STA.b $00,x
	LDA.b $00
	STA.w $03A1
	LDA.b $02
	STA.w $03A3
	LDA.b $04
	STA.w $03A5
	BNE.b CODE_00E36F
	LDA.w $0392
	BNE.b CODE_00E36F
	INC.w $0389
CODE_00E36F:
	SEP.b #$10
	RTS

;---------------------------------------------------------------------------

CODE_00E372:
	PHX
	LDX.b $57
	STA.b $59,x
	INC.b $57
	PLX
	RTS

;---------------------------------------------------------------------------

CODE_00E37B:
	PHB
	PHK
	PLB
	JSR.w CODE_00E3AA
	PLB
	RTL

DATA_00E383:
	dl $7E4002,DATA_008275,DATA_178008,DATA_01E8F2
	dl DATA_01B62D,DATA_01B976,DATA_178000,DATA_0FBC9E
	dl DATA_01B6C1,DATA_01E8FA,DATA_01E542,DATA_01E902
	dl DATA_10E1D2

CODE_00E3AA:
	REP.b #$10
	LDY.w $0127
	LDX.w DATA_00E383,y
	LDA.w DATA_00E383+$02,y
	JSR.w CODE_00E44A
	LDA.w $0127
	BNE.b CODE_00E3CA
	STA.l $7E4000
	STA.l $7E4001
	DEC
	STA.l $7E4003
CODE_00E3CA:
	STZ.w $0127
	RTS

;---------------------------------------------------------------------------

DATA_00E3CE:
	dl $7E4800,DATA_11B72A,DATA_11B744

CODE_00E3D7:
	PHB
	PHK
	PLB
	JSR.w CODE_00E3DF
	PLB
	RTL

CODE_00E3DF:
	REP.b #$10
	LDX.w $0129
	LDY.w DATA_00E3CE,x
	LDA.w DATA_00E3CE+$02,x
	PHB
	PHA
	PLB
	STA.b $00
	REP.b #$20
	LDA.w $0000,y
	STA.b $04
	CMP.w #$4802
	BEQ.b CODE_00E443
	INY
	INY
CODE_00E3FD:
	LDA.w $0000,y
	STA.l !REGISTER_VRAMAddressLo
	LDA.w $0004,y
	STA.l DMA[$00].Destination
	LDA.w $0006,y
	STA.l DMA[$00].SourceHi
	LDA.w $0008,y
	STA.l DMA[$00].SizeLo
	LDA.w $0002,y
	SEP.b #$20
	STA.l !REGISTER_VRAMAddressIncrementValue
	XBA
	STA.l DMA[$00].Parameters
	LDA.b #$01
	STA.l !REGISTER_DMAEnable
	REP.b #$20
	LDA.w $000A,y
	TAY
	CMP.b $04
	BNE.b CODE_00E3FD
	LDA.l $000129
	BNE.b CODE_00E443
	LDA.w #$4802
	STA.w $7E4800
CODE_00E443:
	PLB
	STZ.w $0129
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

CODE_00E44A:
	PHB
	PHA
	PLB
	STA.b $00
	REP.b #$20
CODE_00E451:
	LDY.w $0000,x
	BPL.b CODE_00E45A
	SEP.b #$30
	PLB
	RTS

CODE_00E45A:
	LDA.w $0002,x
	AND.w #$1FFF
	INC
	STA.b $01
	STA.b $03
	LDA.w #$0080
	BIT.w $0002,x
	BPL.b CODE_00E470
	LDA.w #$0081
CODE_00E470:
	STA.l !REGISTER_VRAMAddressIncrementValue
	STA.b $05
	TYA
	STA.l !REGISTER_VRAMAddressLo
	LDA.w $0002,x
	AND.w #$2000
	BEQ.b CODE_00E49F
	LDA.w #$0003
	STA.b $03
	LDA.w $0004,x
	STA.l DMA[$00].SourceLo
	LDA.w $0005,x
	STA.l DMA[$00].SourceHi
	LDA.l !REGISTER_ReadFromVRAMPortLo
	LDA.w #$3981
	BRA.b CODE_00E4EB

CODE_00E49F:
	LDA.b $00
	STA.l DMA[$00].SourceBank
	LDY.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	BVC.b CODE_00E4E1
	LSR.b $01
	LDA.w #$0002
	STA.b $03
	LDA.w #(!REGISTER_WriteToVRAMPortHi&$0000FF<<8)+$08
	STA.l DMA[$00].Parameters
	TXA
	CLC
	ADC.w #$0005
	STA.l DMA[$00].SourceLo
	LDA.b $01
	STA.l DMA[$00].SizeLo
	LDA.w #$0100
	STA.l !REGISTER_VCountTimerHi
	LDA.b $05
	AND.w #$007F
	STA.l !REGISTER_VRAMAddressIncrementValue
	LDA.w $0000,x
	STA.l !REGISTER_VRAMAddressLo
	LDY.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$08
CODE_00E4E1:
	TXA
	CLC
	ADC.w #$0004
	STA.l DMA[$00].SourceLo
	TYA
CODE_00E4EB:
	STA.l DMA[$00].Parameters
	LDA.b $01
	STA.l DMA[$00].SizeLo
	LDA.w #$0100
	STA.l !REGISTER_VCountTimerHi
	TXA
	CLC
	ADC.w #$0004
	ADC.b $03
	TAX
	JMP.w CODE_00E451

;---------------------------------------------------------------------------

CODE_00E507:
	LDA.w !REGISTER_HVBlankFlagsAndJoypadStatus
	LSR
	BCS.b CODE_00E507
	REP.b #$30
	LDA.w !REGISTER_Joypad1Lo
	BIT.w #$000F
	BEQ.b CODE_00E51A
	LDA.w #$0000
CODE_00E51A:
	STA.w $093C
	TAY
	EOR.w $0944
	AND.w $093C
	STA.w $093E
	STY.w $0944
	LDA.w !REGISTER_Joypad2Lo
	BIT.w #$000F
	BEQ.b CODE_00E535
	LDA.w #$0000
CODE_00E535:
	STA.w $0940
	TAY
	EOR.w $0946
	AND.w $0940
	STA.w $0942
	STY.w $0946
	LDA.w $093C
	STA.b $35
	LDA.w $093E
	STA.b $37
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

base off

DATA_00E552:
	dw $FFFF,$FFFF,$8000,$5555,$4000,$3333,$2AAA,$2492
	dw $2000,$1C71,$1999,$1745,$1555,$13B1,$1249,$1111
	dw $1000,$0F0F,$0E38,$0D79,$0CCC,$0C30,$0BA2,$0B21
	dw $0AAA,$0A3D,$09D8,$097B,$0924,$08D3,$0888,$0842
	dw $0800,$07C1,$0787,$0750,$071C,$06EB,$06BC,$0690
	dw $0666,$063E,$0618,$05F4,$05D1,$05B0,$0590,$0572
	dw $0555,$0539,$051E,$0505,$04EC,$04D4,$04BD,$04A7
	dw $0492,$047D,$0469,$0456,$0444,$0432,$0421,$0410
	dw $0400,$03F0,$03E0,$03D2,$03C3,$03B5,$03A8,$039B
	dw $038E,$0381,$0375,$0369,$035E,$0353,$0348,$033D
	dw $0333,$0329,$031F,$0315,$030C,$0303,$02FA,$02F1
	dw $02E8,$02E0,$02D8,$02D0,$02C8,$02C0,$02B9,$02B1
	dw $02AA,$02A3,$029C,$0295,$028F,$0288,$0282,$027C
	dw $0276,$0270,$026A,$0264,$025E,$0259,$0253,$024E
	dw $0249,$0243,$023E,$0239,$0234,$0230,$022B,$0226
	dw $0222,$021D,$0219,$0214,$0210,$020C,$0208,$0204
	dw $0200,$01FC,$01F8,$01F4,$01F0,$01EC,$01E9,$01E5
	dw $01E1,$01DE,$01DA,$01D7,$01D4,$01D0,$01CD,$01CA
	dw $01C7,$01C3,$01C0,$01BD,$01BA,$01B7,$01B4,$01B2
	dw $01AF,$01AC,$01A9,$01A6,$01A4,$01A1,$019E,$019C
	dw $0199,$0197,$0194,$0192,$018F,$018D,$018A,$0188
	dw $0186,$0183,$0181,$017F,$017D,$017A,$0178,$0176
	dw $0174,$0172,$0170,$016E,$016C,$016A,$0168,$0166
	dw $0164,$0162,$0160,$015E,$015C,$015A,$0158,$0157
	dw $0155,$0153,$0151,$0150,$014E,$014C,$014A,$0149
	dw $0147,$0146,$0144,$0142,$0141,$013F,$013E,$013C
	dw $013B,$0139,$0138,$0136,$0135,$0133,$0132,$0130
	dw $012F,$012E,$012C,$012B,$0129,$0128,$0127,$0125
	dw $0124,$0123,$0121,$0120,$011F,$011E,$011C,$011B
	dw $011A,$0119,$0118,$0116,$0115,$0114,$0113,$0112
	dw $0111,$010F,$010E,$010D,$010C,$010B,$010A,$0109
	dw $0108,$0107,$0106,$0105,$0104,$0103,$0102,$0101
	dw $0100,$00FF,$00FE,$00FD,$00FC,$00FB,$00FA,$00F9
	dw $00F8,$00F7,$00F6,$00F5,$00F4,$00F3,$00F2,$00F1
	dw $00F0,$00F0,$00EF,$00EE,$00ED,$00EC,$00EB,$00EA
	dw $00EA,$00E9,$00E8,$00E7,$00E6,$00E5,$00E5,$00E4
	dw $00E3,$00E2,$00E1,$00E1,$00E0,$00DF,$00DE,$00DE
	dw $00DD,$00DC,$00DB,$00DB,$00DA,$00D9,$00D9,$00D8
	dw $00D7,$00D6,$00D6,$00D5,$00D4,$00D4,$00D3,$00D2
	dw $00D2,$00D1,$00D0,$00D0,$00CF,$00CE,$00CE,$00CD
	dw $00CC,$00CC,$00CB,$00CA,$00CA,$00C9,$00C9,$00C8
	dw $00C7,$00C7,$00C6,$00C5,$00C5,$00C4,$00C4,$00C3
	dw $00C3,$00C2,$00C1,$00C1,$00C0,$00C0,$00BF,$00BF
	dw $00BE,$00BD,$00BD,$00BC,$00BC,$00BB,$00BB,$00BA
	dw $00BA,$00B9,$00B9,$00B8,$00B8,$00B7,$00B7,$00B6
	dw $00B6,$00B5,$00B5,$00B4,$00B4,$00B3,$00B3,$00B2
	dw $00B2,$00B1,$00B1,$00B0,$00B0,$00AF,$00AF,$00AE
	dw $00AE,$00AD,$00AD,$00AC,$00AC,$00AC,$00AB,$00AB
	dw $00AA,$00AA,$00A9,$00A9,$00A8,$00A8,$00A8,$00A7
	dw $00A7,$00A6,$00A6,$00A5,$00A5,$00A5,$00A4,$00A4
	dw $00A3,$00A3,$00A3,$00A2,$00A2,$00A1,$00A1,$00A1
	dw $00A0,$00A0,$009F,$009F,$009F,$009E,$009E,$009D
	dw $009D,$009D,$009C,$009C,$009C,$009B,$009B,$009A
	dw $009A,$009A,$0099,$0099,$0099,$0098,$0098,$0098
	dw $0097,$0097,$0097,$0096,$0096,$0095,$0095,$0095
	dw $0094,$0094,$0094,$0093,$0093,$0093,$0092,$0092
	dw $0092,$0091,$0091,$0091,$0090,$0090,$0090,$0090
	dw $008F,$008F,$008F,$008E,$008E,$008E,$008D,$008D
	dw $008D,$008C,$008C,$008C,$008C,$008B,$008B,$008B
	dw $008A,$008A,$008A,$0089,$0089,$0089,$0089,$0088
	dw $0088,$0088,$0087,$0087,$0087,$0087,$0086,$0086
	dw $0086,$0086,$0085,$0085,$0085,$0084,$0084,$0084
	dw $0084,$0083,$0083,$0083,$0083,$0082,$0082,$0082
	dw $0082,$0081,$0081,$0081,$0081,$0080,$0080,$0080
	dw $0080

DATA_00E954:
	dw $0100,$0100,$0100,$00FF,$00FF,$00FE,$00FD,$00FC
	dw $00FB,$00FA,$00F8,$00F7,$00F5,$00F3,$00F1,$00EF
	dw $00ED,$00EA,$00E7,$00E5,$00E2,$00DF,$00DC,$00D8
	dw $00D5,$00D1,$00CE,$00CA,$00C6,$00C2,$00BE,$00B9
	dw $00B5,$00B1,$00AC,$00A7,$00A2,$009D,$0098,$0093
	dw $008E,$0089,$0084,$007E,$0079,$0073,$006D,$0068
	dw $0062,$005C,$0056,$0050,$004A,$0044,$003E,$0038
	dw $0032,$002C,$0026,$001F,$0019,$0013,$000D,$0006

DATA_00E9D4:
	dw $0000,$FFFA,$FFF3,$FFED,$FFE7,$FFE1,$FFDA,$FFD4
	dw $FFCE,$FFC8,$FFC2,$FFBC,$FFB6,$FFB0,$FFAA,$FFA4
	dw $FF9E,$FF98,$FF93,$FF8D,$FF87,$FF82,$FF7C,$FF77
	dw $FF72,$FF6D,$FF68,$FF63,$FF5E,$FF59,$FF54,$FF4F
	dw $FF4B,$FF47,$FF42,$FF3E,$FF3A,$FF36,$FF32,$FF2F
	dw $FF2B,$FF28,$FF24,$FF21,$FF1E,$FF1B,$FF19,$FF16
	dw $FF13,$FF11,$FF0F,$FF0D,$FF0B,$FF09,$FF08,$FF06
	dw $FF05,$FF04,$FF03,$FF02,$FF01,$FF01,$FF00,$FF00
	dw $FF00,$FF00,$FF00,$FF01,$FF01,$FF02,$FF03,$FF04
	dw $FF05,$FF06,$FF08,$FF09,$FF0B,$FF0D,$FF0F,$FF11
	dw $FF13,$FF16,$FF19,$FF1B,$FF1E,$FF21,$FF24,$FF28
	dw $FF2B,$FF2F,$FF32,$FF36,$FF3A,$FF3E,$FF42,$FF47
	dw $FF4B,$FF4F,$FF54,$FF59,$FF5E,$FF63,$FF68,$FF6D
	dw $FF72,$FF77,$FF7C,$FF82,$FF87,$FF8D,$FF93,$FF98
	dw $FF9E,$FFA4,$FFAA,$FFB0,$FFB6,$FFBC,$FFC2,$FFC8
	dw $FFCE,$FFD4,$FFDA,$FFE1,$FFE7,$FFED,$FFF3,$FFFA
	dw $0000,$0006,$000D,$0013,$0019,$001F,$0026,$002C
	dw $0032,$0038,$003E,$0044,$004A,$0050,$0056,$005C
	dw $0062,$0068,$006D,$0073,$0079,$007E,$0084,$0089
	dw $008E,$0093,$0098,$009D,$00A2,$00A7,$00AC,$00B1
	dw $00B5,$00B9,$00BE,$00C2,$00C6,$00CA,$00CE,$00D1
	dw $00D5,$00D8,$00DC,$00DF,$00E2,$00E5,$00E7,$00EA
	dw $00ED,$00EF,$00F1,$00F3,$00F5,$00F7,$00F8,$00FA
	dw $00FB,$00FC,$00FD,$00FE,$00FF,$00FF,$0100,$0100
	dw $0100,$0100,$0100,$00FF,$00FF,$00FE,$00FD,$00FC
	dw $00FB,$00FA,$00F8,$00F7,$00F5,$00F3,$00F1,$00EF
	dw $00ED,$00EA,$00E7,$00E5,$00E2,$00DF,$00DC,$00D8
	dw $00D5,$00D1,$00CE,$00CA,$00C6,$00C2,$00BE,$00B9
	dw $00B5,$00B1,$00AC,$00A7,$00A2,$009D,$0098,$0093
	dw $008E,$0089,$0084,$007E,$0079,$0073,$006D,$0068
	dw $0062,$005C,$0056,$0050,$004A,$0044,$003E,$0038
	dw $0032,$002C,$0026,$001F,$0019,$0013,$000D,$0006

DATA_00EBD4:
	incbin "LevelData/DATA_00EBD4.bin"

DATA_00ECA1:
	incbin "LevelData/DATA_00ECA1.bin"

DATA_00EE40:
	incbin "LevelData/DATA_00EE40.bin"

DATA_00EFFE:
	incbin "LevelData/DATA_00EFFE.bin"

DATA_00F2C3:
	incbin "LevelData/DATA_00F2C3.bin"

DATA_00F40A:
	incbin "LevelData/DATA_00F40A.bin"

DATA_00F4EF:
	incbin "LevelData/DATA_00F4EF.bin"

DATA_00F50A:
	incbin "LevelData/DATA_00F50A.bin"

DATA_00F614:
	incbin "LevelData/DATA_00F614.bin"

DATA_00F625:
	incbin "LevelData/DATA_00F625.bin"

DATA_00F678:
	incbin "LevelData/DATA_00F678.bin"

DATA_00F6B3:
	incbin "LevelData/DATA_00F6B3.bin"

DATA_00F71E:
	incbin "LevelData/DATA_00F71E.bin"

DATA_00F750:
	incbin "LevelData/DATA_00F750.bin"

DATA_00F773:
	incbin "LevelData/DATA_00F773.bin"

DATA_00F77B:
	incbin "LevelData/DATA_00F77B.bin"

	%FREE_BYTES(NULLROM, 2041, $FF)

UNK_00FFA0:
	db $95,$07,$31,$11,$19

	%FREE_BYTES(NULLROM, 11, $FF)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro YIBank01Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

CODE_018000:
	TYX
	RTS

CODE_018002:
	LDY.b $18,x
	TYX
	JSR.w (DATA_018015,x)
	LDA.w $0039
	STA.w $7E18
	LDA.w #$0002
	STA.w $6F00,x
	RTL

DATA_018015:
	dw CODE_018025
	dw CODE_018041
	dw CODE_018103
	dw CODE_018174
	dw CODE_0181A8
	dw CODE_0181B2
	dw CODE_0181C5
	dw CODE_018236

CODE_018025:
	LDX.b $12
CODE_018027:
	STZ.w $6098
	STZ.w $0041
	STZ.w $60A0
	STZ.w $0043
	LDA.w #$1304
	STA.w $0967
	LDY.b #$24
	STY.w $096C
	JMP.w CODE_01819F

CODE_018041:
	LDX.b $12
	LDA.w $7A96,x
	BNE.b CODE_018051
	LDA.w #$0004
	STA.w $7A96,x
	DEC.w $70E2,x
CODE_018051:
	REP.b #$10
	LDY.w #$0000
	LDA.w $7680,x
	SEC
	SBC.w #$0120
	EOR.w #$FFFF
	INC
	BPL.b CODE_018066
	LDA.w #$0000
CODE_018066:
	CMP.w #$00E0
	BCC.b CODE_0180B9
	LDY.w #$0100
	SBC.w #$00E0
	CMP.w #$00E0
	BCC.b CODE_0180B9
	PHY
	LDA.w #$2000
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$2F6C
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0200
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	SEP.b #$10
	LDX.b #FXCODE_08AA7F>>16
	LDA.w #FXCODE_08AA7F
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$7FFF
	STA.l $702F8C
	LDX.b #$1C
CODE_01809D:
	STA.l $70302E,x
	STA.l $70304E,x
	DEX
	DEX
	BPL.b CODE_01809D
	LDA.w #$0000
	STA.l $70336C
	JSR.w CODE_01819F
	REP.b #$10
	PLY
	LDA.w #$00E0
CODE_0180B9:
	STY.w $60A0
	STY.w $0043
	STA.w $6098
	STA.w $0041
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.b $14
	LSR
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0070
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$000F
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	STZ.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w #$36BA
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	SEP.b #$10
	LDX.b #FXCODE_089208>>16
	LDA.w #FXCODE_089208
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	JSL.l CODE_00BE39	: db $E4,$51,$7E,$BA,$36,$70,$48,$03
	LDA.w #$0008
	TSB.w $094A
	LDX.b $12
	RTS

CODE_018103:
	LDA.b $14
	AND.w #$0007
	BNE.b CODE_018131
	LDA.l $70336C
	CMP.w #$0020
	BCS.b CODE_018134
CODE_018113:
	LDA.w #$2D6C
	STA.l $70336E
	LDA.w #$2F6C
	STA.l $703370
	LDX.b #FXCODE_08B4A9>>16
	LDA.w #FXCODE_08B4A9
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.l $702020
	STA.w $0948
CODE_018131:
	LDX.b $12
	RTS

CODE_018134:
	LDA.w #$0008
	TRB.w $094A
	LDA.w #$0002
	TRB.w $0968
	LDA.w #$0000
	STA.l $702F6E
	STA.l $702F70
	STA.l $702F72
	STA.l $70336C
	LDX.b #$1C
CODE_018155:
	LDA.l DATA_5FDABE+$02,x
	STA.l $70314E,x
	DEX
	DEX
	BPL.b CODE_018155
	LDA.l DATA_5FDABE
	STA.l $70314C
	JSR.w CODE_01819F
	LDA.w #$00D5
	JSL.l CODE_03A34C
	RTS

CODE_018174:
	LDA.b $14
	AND.w #$0007
	BNE.b CODE_018131
	LDA.l $70336C
	CMP.w #$0020
	BCC.b CODE_018113
	LDX.b $12
	JSL.l CODE_03D5E4
	STZ.w $0C14
	STZ.w $0C16
	LDA.w #$0004
	STA.w $0148
	STZ.w $014A
	STZ.w $0D2B
	STZ.w $0D3B
CODE_01819F:
	SEP.b #$10
	LDX.b $12
	INC.b $18,x
	INC.b $18,x
	RTS

CODE_0181A8:
	LDA.w #$004D
	REP.b #$10
	LDY.w #$2800
	BRA.b CODE_0181BA

CODE_0181B2:
	LDA.w #$004E
	REP.b #$10
	LDY.w #$2C00
CODE_0181BA:
	JSR.w CODE_01821D
	LDA.w #$0404
	TRB.w $0967
	BRA.b CODE_01819F

CODE_0181C5:
	JSL.l CODE_0181FB
	LDA.w #$00F1
	STA.w $004D
	LDA.w #$00DD
	JSL.l CODE_03A364
	LDA.w #$0042
	STA.w $7978,y
	LDA.w #$0074
	STA.w $7902,y
	STZ.w $105A
	INC.w $0B7B
	LDA.w #$0048
	JSL.l CODE_03A34C
	LDA.w #$0010
	STA.w $70E2,y
	JSL.l CODE_04F74A
	BRA.b CODE_01819F

CODE_0181FB:
	REP.b #$10
	LDA.w #$00F8
	LDY.w #$3400
	JSR.w CODE_01821D
	LDX.b #$0C
CODE_018208:
	LDA.l DATA_5FC13A,x
	STA.l $702D7E,x
	STA.l $702012,x
	STA.l $702F7E,x
	DEX
	DEX
	BPL.b CODE_018208
	RTL

CODE_01821D:
	PHY
	LDX.w #$6800
	JSL.l CODE_00B756
	PLY
	LDX.w #$706800>>16
	STX.w $0001
	LDX.w #$706800
	JSL.l CODE_00BEA6
	SEP.b #$10
CODE_018235:
	RTS

CODE_018236:
	LDX.b $12
	STZ.w $60C4
	LDY.w $105A
	BEQ.b CODE_018235
	STZ.w $7ECC
	LDA.w $0039
	CLC
	ADC.w #$0120
	STA.w $70E2,x
	LDA.w $6090
	STA.w $7182,x
	STZ.w $0C1E
	LDA.w $0039
	STA.w $7E18
	CLC
	ADC.w #$0100
	STA.w $1082
	STA.w $7E1A
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
	STA.w $106E
	XBA
	STA.w $74A2,x
	LDA.w #$FF80
	STA.w $7220,x
	STZ.w $1080
	STZ.w $60A0
	LDA.w #$0015
	STA.w $0967
	LDA.w #$0009
	STA.w $004D
	LDY.b #$2B
	STY.b $76,x
	PLA
	RTL

;---------------------------------------------------------------------------

DATA_018297:
	db $02,$DF,$14,$B9,$06,$00,$B4,$0E,$D8,$09,$00,$FF,$20,$DF,$07,$00
	db $90,$16,$7A,$0C,$01,$9B,$15,$BC,$07,$00,$EA,$1A,$D3,$08,$00,$F3
	db $06,$00,$00,$02,$E5,$17,$B9,$06,$00,$A4,$0C,$D9,$08,$00,$FD,$1F
	db $E2,$07,$00,$8A,$15,$79,$0C,$01,$A0,$13,$B9,$07,$00,$EC,$14,$D7
	db $08,$00,$02,$06,$00,$00,$02,$E8,$1A,$BC,$06,$01,$A2,$0C,$B0,$08
	db $00,$FC,$1E,$E1,$07,$00,$85,$14,$7B,$0D,$01,$A6,$10,$BD,$07,$02
	db $F0,$14,$B6,$06,$00,$0C,$06,$00,$00,$02,$EC,$1D,$BA,$06,$02,$A4
	db $0C,$AD,$06,$00,$FC,$1D,$DD,$07,$00,$89,$17,$7A,$0C,$01,$B0,$0E
	db $B9,$07,$01,$EF,$14,$AF,$09,$00,$02,$06,$00,$00,$00,$EC,$1D,$D5
	db $07,$01,$9F,$13,$B8,$07,$00,$FB,$1C,$E1,$07,$00,$8E,$17,$7A,$0C
	db $00,$AE,$0E,$D4,$08,$02,$DE,$12,$BB,$06,$00,$F3,$06,$00,$00,$00
	db $EF,$18,$D0,$07,$01,$A5,$11,$BC,$07,$00,$FC,$1D,$E3,$07,$00,$89
	db $17,$79,$0C,$01,$9E,$0E,$CC,$07,$02,$E1,$15,$B4,$05,$00,$02,$06
	db $00,$00,$02,$F2,$17,$BA,$06,$01,$AF,$0E,$B9,$07,$00,$FC,$1E,$DE
	db $07,$00,$84,$15,$79,$0C,$01,$9C,$0B,$BC,$07,$02,$E6,$18,$BA,$06
	db $00,$0C,$06,$00,$00,$01,$F0,$18,$A8,$08,$01,$B9,$0D,$BC,$07,$00
	db $FD,$1F,$DF,$07,$00,$8A,$15,$79,$0C,$02,$9D,$0E,$AF,$08,$02,$EA
	db $1B,$B7,$06,$00,$02,$06,$00,$00,$02,$AD,$0E,$BA,$07,$03,$63,$0F
	db $B2,$06,$00,$E2,$0F,$DF,$08,$00,$57,$1C,$78,$0C,$05,$76,$14,$A6
	db $09,$00,$C9,$0E,$D5,$07,$00,$24,$07,$00,$00,$02,$B9,$0D,$BA,$07
	db $04,$64,$0E,$AA,$08,$00,$E1,$10,$E0,$08,$00,$53,$1D,$78,$0C,$04
	db $73,$13,$A9,$08,$00,$BC,$0A,$D2,$07,$00,$27,$09,$00,$00,$02,$C5
	db $0D,$B7,$07,$04,$6D,$0F,$AB,$08,$00,$E4,$11,$E0,$09,$00,$50,$1E
	db $78,$0C,$04,$70,$11,$AA,$08,$02,$BC,$07,$BC,$07,$00,$2A,$0B,$00
	db $00,$02,$D1,$0E,$BB,$07,$05,$6D,$0F,$A5,$0A,$00,$E6,$12,$E1,$08
	db $00,$53,$1D,$7A,$0C,$03,$6F,$13,$BB,$07,$01,$B9,$04,$AA,$09,$00
	db $27,$09,$00,$00,$00,$D0,$0F,$D4,$07,$05,$70,$10,$A6,$0A,$00,$E8
	db $12,$E1,$08,$00,$57,$1C,$7A,$0C,$03,$6A,$11,$B8,$07,$02,$A8,$10
	db $B9,$07,$00,$24,$07,$00,$00,$00,$CA,$0A,$D4,$07,$04,$70,$10,$AB
	db $08,$00,$E6,$12,$DF,$08,$00,$53,$1D,$79,$0C,$04,$6C,$10,$AA,$08
	db $02,$B2,$0E,$BB,$07,$00,$27,$09,$00,$00,$02,$CE,$07,$B9,$07,$04
	db $6B,$0F,$AB,$08,$00,$E4,$11,$E1,$08,$00,$4F,$1E,$78,$0C,$04,$70
	db $11,$A8,$08,$02,$BC,$0D,$BB,$07,$00,$2A,$0B,$00,$00,$01,$DD,$05
	db $A6,$0A,$03,$6B,$0F,$B2,$06,$00,$E1,$10,$E1,$08,$00,$53,$1D,$79
	db $0C,$05,$72,$12,$A8,$09,$02,$CB,$0D,$BC,$07,$00,$27,$09,$00,$00
	db $01,$C7,$10,$A5,$0A,$05,$B8,$0A,$A6,$0A,$00,$F4,$1C,$D7,$07,$00
	db $6E,$15,$78,$0C,$03,$81,$0F,$B3,$06,$00,$E9,$1B,$D2,$07,$00,$13
	db $07,$00,$00,$02,$CE,$12,$B8,$07,$04,$A5,$0A,$AD,$08,$00,$F2,$1B
	db $D6,$07,$00,$6D,$15,$7A,$0C,$04,$87,$0C,$AC,$08,$00,$E8,$12,$D3
	db $07,$00,$14,$09,$00,$00,$02,$DD,$16,$BA,$07,$04,$98,$09,$AC,$08
	db $00,$EF,$19,$D9,$07,$00,$69,$14,$7A,$0C,$04,$92,$0B,$A9,$08,$02
	db $E0,$10,$BA,$07,$00,$13,$0B,$00,$00,$00,$E1,$19,$D0,$08,$03,$89
	db $0C,$B5,$06,$00,$ED,$17,$D7,$07,$00,$65,$14,$78,$0C,$05,$A3,$09
	db $A8,$0A,$01,$D8,$0E,$A4,$0A,$00,$13,$0D,$00,$00,$00,$ED,$1D,$D1
	db $08,$03,$92,$0F,$B5,$06,$00,$EF,$15,$D6,$07,$00,$6F,$15,$78,$0C
	db $05,$AD,$0B,$A5,$0A,$01,$C0,$10,$A7,$0A,$00,$13,$07,$00,$00,$00
	db $EC,$14,$D1,$08,$04,$89,$09,$A8,$08,$00,$ED,$17,$DA,$07,$00,$6B
	db $15,$79,$0C,$04,$9D,$0C,$AA,$08,$02,$C8,$11,$BD,$07,$00,$14,$09
	db $00,$00,$02,$E9,$10,$BA,$07,$04,$98,$09,$AB,$08,$00,$F0,$19,$D6
	db $07,$00,$68,$14,$79,$0C,$04,$93,$0B,$A9,$08,$02,$D7,$14,$BD,$07
	db $00,$13,$0B,$00,$00,$01,$DE,$10,$A4,$0A,$05,$B1,$07,$A7,$0A,$00
	db $F2,$1B,$D7,$07,$00,$66,$14,$7A,$0C,$03,$88,$0F,$B3,$06,$00,$DC
	db $17,$D1,$07,$00,$13,$0D,$00,$00,$02,$C0,$0C,$00,$00,$05,$60,$08
	db $00,$00,$00,$80,$08,$00,$00,$00,$00,$00,$00,$00,$05,$60,$08,$00
	db $00,$02,$C0,$0C,$00,$00,$00,$00,$00,$00,$00,$02,$00,$00,$00,$00
	db $05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$05,$00,$00,$05
	db $00,$00,$00,$00,$02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$F2
	db $24,$00,$00,$05,$8C,$24,$00,$00,$00,$0C,$22,$00,$00,$00,$84,$2B
	db $00,$00,$05,$86,$15,$00,$00,$02,$01,$22,$00,$00,$00,$00,$00,$00
	db $00,$02,$FC,$22,$00,$00,$05,$8B,$1E,$00,$00,$00,$04,$1B,$00,$00
	db $00,$83,$28,$00,$00,$05,$87,$24,$00,$00,$02,$01,$21,$00,$00,$00
	db $00,$00,$00,$00,$02,$06,$22,$00,$00,$05,$8A,$23,$00,$00,$00,$14
	db $22,$00,$00,$00,$82,$27,$00,$00,$05,$84,$20,$00,$00,$02,$0F,$1D
	db $00,$00,$00,$00,$00,$00,$00,$02,$BD,$1F,$B9,$04,$05,$64,$1F,$43
	db $05,$00,$CE,$20,$B4,$00,$00,$53,$28,$2A,$06,$05,$5A,$21,$50,$09
	db $01,$9A,$20,$C6,$03,$00,$00,$00,$00,$00,$02,$BD,$1F,$A8,$04,$05
	db $64,$1F,$9D,$05,$00,$CE,$20,$01,$04,$00,$53,$28,$1A,$08,$05,$5A
	db $21,$BF,$09,$01,$9A,$20,$BF,$06,$00,$00,$00,$00,$00,$02,$AF,$23
	db $9A,$04,$05,$54,$20,$37,$05,$00,$C3,$1D,$D2,$04,$00,$40,$28,$3E
	db $02,$05,$4C,$22,$4E,$07,$01,$9B,$23,$64,$07,$00,$00,$00,$00,$00
	db $02,$AF,$23,$6B,$03,$05,$54,$20,$90,$08,$00,$C3,$1D,$99,$04,$00
	db $40,$28,$F7,$04,$05,$4C,$22,$93,$08,$01,$9B,$23,$60,$0A,$00,$00
	db $00,$00,$00,$02,$75,$23,$4F,$04,$05,$0D,$1D,$17,$06,$00,$7B,$22
	db $98,$04,$00,$0A,$22,$07,$03,$05,$11,$20,$1B,$08,$02,$6B,$1C,$50
	db $0B,$00,$00,$00,$00,$00,$02,$75,$23,$A9,$04,$05,$0D,$1D,$EC,$0A
	db $00,$7B,$22,$C0,$0A,$00,$0A,$22,$EB,$08,$05,$11,$20,$F0,$08,$02
	db $6B,$1C,$AB,$0A,$00,$00,$00,$00,$00,$02,$5F,$1B,$29,$08,$05,$F6
	db $23,$F7,$04,$00,$65,$1A,$73,$07,$00,$EF,$21,$16,$07,$05,$F5,$25
	db $35,$07,$02,$4E,$1A,$3E,$04,$00,$00,$00,$00,$00,$02,$67,$1D,$3B
	db $04,$05,$16,$1D,$3C,$07,$00,$77,$1D,$5F,$04,$00,$16,$25,$5D,$04
	db $05,$12,$1E,$3C,$07,$02,$58,$1D,$74,$04,$00,$00,$00,$00,$00,$02
	db $00,$00,$00,$00,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$05,$00,$00,$00,$00,$02,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$02,$C0,$0C,$00,$00,$05,$60,$08,$00,$00,$00,$80,$08,$00
	db $00,$00,$00,$00,$00,$00,$05,$60,$08,$00,$00,$02,$C0,$0C,$00,$00
	db $00,$00,$00,$00,$00,$02,$80,$08,$00,$00,$05,$80,$08,$00,$00,$00
	db $00,$00,$00,$00,$00,$80,$08,$00,$00,$05,$80,$08,$00,$00,$02,$80
	db $08,$00,$00,$00,$00,$00,$00,$00,$02,$DF,$14,$B9,$06,$00,$B4,$0E
	db $D8,$09,$00,$F2,$20,$DF,$07,$00,$A0,$16,$7A,$0C,$01,$9B,$15,$BC
	db $07,$00,$EA,$1A,$D3,$08,$00,$E0,$08,$00,$00,$02,$E5,$17,$B9,$06
	db $00,$A4,$0C,$D9,$08,$00,$F0,$1F,$E2,$07,$00,$9A,$15,$79,$0C,$01
	db $A0,$13,$B9,$07,$00,$EC,$14,$D7,$08,$00,$EF,$08,$00,$00,$02,$E8
	db $1A,$BC,$06,$01,$A2,$0C,$B0,$08,$00,$EF,$1E,$E1,$07,$00,$95,$14
	db $7B,$0D,$01,$A6,$10,$BD,$07,$02,$F0,$14,$B6,$06,$00,$F9,$08,$00
	db $00,$02,$EC,$1D,$BA,$06,$02,$A4,$0C,$AD,$06,$00,$EF,$1D,$DD,$07
	db $00,$99,$17,$7A,$0C,$01,$B0,$0E,$B9,$07,$01,$EF,$14,$AF,$09,$00
	db $EF,$08,$00,$00,$00,$EC,$1D,$D5,$07,$01,$9F,$13,$B8,$07,$00,$EE
	db $1C,$E1,$07,$00,$9E,$17,$7A,$0C,$00,$AE,$0E,$D4,$08,$02,$DE,$12
	db $BB,$06,$00,$E0,$08,$00,$00,$00,$EF,$18,$D0,$07,$01,$A5,$11,$BC
	db $07,$00,$EF,$1D,$E3,$07,$00,$99,$17,$79,$0C,$01,$9E,$0E,$CC,$07
	db $02,$E1,$15,$B4,$05,$00,$EF,$08,$00,$00,$02,$F2,$17,$BA,$06,$01
	db $AF,$0E,$B9,$07,$00,$EF,$1E,$DE,$07,$00,$94,$15,$79,$0C,$01,$9C
	db $0B,$BC,$07,$02,$E6,$18,$BA,$06,$00,$F9,$08,$00,$00,$01,$F0,$18
	db $A8,$08,$01,$B9,$0D,$BC,$07,$00,$F0,$1F,$DF,$07,$00,$9A,$15,$79
	db $0C,$02,$9D,$0E,$AF,$08,$02,$EA,$1B,$B7,$06,$00,$EF,$08,$00,$00
	db $00,$00,$00,$00,$F6,$00,$00,$00,$00,$D5,$00,$00,$00,$00,$EC,$C0
	db $40,$C0,$20,$00,$95,$15,$95,$20,$D5,$60,$F0,$40,$E0,$00,$70,$E0
	db $00,$10,$00,$60,$D0,$40,$E8,$0C,$00,$A0,$00,$C0,$C8,$FC,$E0,$10
	db $C0,$C4,$00,$A0,$00,$B0,$B0,$F0,$C0,$10,$B0,$A8,$AC,$5C,$AC,$7C
	db $7C,$E4,$54,$C4,$64,$84,$78,$50,$70,$88,$70,$88,$80,$80,$98,$80
	db $40,$C0,$40,$A0,$80,$30,$B0,$30,$90,$70,$C0,$40,$A0,$60,$00,$00
	db $00,$00,$00,$E0,$00,$00,$00,$00,$20,$40,$C0,$40,$D0,$80,$00,$00
	db $00,$00,$80,$00,$00,$00,$10,$F6,$00,$00,$04,$10,$F6

;---------------------------------------------------------------------------

DATA_0189A4:
	dw CODE_019312
	dw CODE_019367
	dw CODE_019400
	dw CODE_019417
	dw CODE_019428
	dw CODE_019439
	dw CODE_019459
	dw CODE_019428
	dw CODE_01946A
	dw CODE_019473
	dw CODE_01946A
	dw CODE_019494
	dw CODE_019529
	dw CODE_019540
	dw CODE_019563
	dw CODE_0196AE
	dw CODE_0196EC
	dw CODE_019709
	dw CODE_01973D
	dw CODE_019772
	dw CODE_019780
	dw CODE_0197B8
	dw CODE_0197C9
	dw CODE_0197E3
	dw CODE_01981D
	dw CODE_01983D
	dw CODE_01983D
	dw CODE_019876
	dw CODE_019898
	dw CODE_0198A6
	dw CODE_0198E8
	dw CODE_019903
	dw CODE_019931
	dw CODE_01994A
	dw CODE_019991
	dw CODE_0199AE
	dw CODE_0199FB
	dw CODE_019A31
	dw CODE_019A92
	dw CODE_019B23
	dw CODE_019BA4
	dw CODE_019BF9
	dw CODE_019C51
	dw CODE_019CC9
	dw CODE_019CF7
	dw CODE_019D0F
	dw CODE_019DE7
	dw CODE_019EB6
	dw CODE_019F57
	dw CODE_019F7A
	dw CODE_019BA4
	dw CODE_019BF9
	dw CODE_019FE5
	dw CODE_01A099
	dw CODE_01A1DC
	dw CODE_01A226

CODE_018A14:
	LDY.w $1080
	BEQ.b CODE_018A24
	DEY
	BNE.b CODE_018A29
	JSR.w CODE_018D1C
	JSR.w CODE_018A50
	BRA.b CODE_018A2C

CODE_018A24:
	JSR.w CODE_018CD8
	BRA.b CODE_018A2C

CODE_018A29:
	JSR.w CODE_018CC7
CODE_018A2C:
	JSL.l CODE_03AF23
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_0189A4,x)
	LDY.w $1080
	BEQ.b CODE_018A4F
	DEY
	BNE.b CODE_018A4F
	JSR.w CODE_0191BB
	JSR.w CODE_01922A
	JSR.w CODE_018A95
	JSR.w CODE_01924D
	JSR.w CODE_0192DA
CODE_018A4F:
	RTL

;---------------------------------------------------------------------------

CODE_018A50:
	LDA.w $1060
	ASL
	LDY.w $7400,x
	BEQ.b CODE_018A60
	EOR.w #$FFFF
	INC
	AND.w #$01FE
CODE_018A60:
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $1076
	ASL
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $1078
	ASL
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_08A000>>16
	LDA.w #FXCODE_08A000
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STA.w $0951
	LDA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	STA.w $094F
	LDA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	STA.w $0953
	LDA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w $0955
	LDX.b $12
	RTS

;---------------------------------------------------------------------------

CODE_018A95:
	LDY.w $1070
	BEQ.b CODE_018AB5
	LDA.w $7974
	AND.w #$0001
	BEQ.b CODE_018AAA
	JSR.w CODE_018AC9
	JSR.w CODE_018AE1
	BRA.b CODE_018AB0

CODE_018AAA:
	JSR.w CODE_018AB6
	JSR.w CODE_018B15
CODE_018AB0:
	INC.w $0CF9
	LDX.b $12
CODE_018AB5:
	RTS

;---------------------------------------------------------------------------

CODE_018AB6:
	LDA.w #$E0E1
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDY.b #$54
	LDA.w #$0060
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $1062
	BRA.b CODE_018AF5

CODE_018AC9:
	LDA.w #$E081
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDY.b #$54
	STZ.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $1064
	BRA.b CODE_018AF5

DATA_018AD9:
	dw $E0C1,$C0C1,$C081,$C0A1

CODE_018AE1:
	LDY.w $1074
	LDA.w DATA_018AD9,y
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDY.b #$54
	LDA.w #$0040
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $1068
CODE_018AF5:
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	TYA
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w $1076
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $1078
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	STZ.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_0884A5>>16
	LDA.w #FXCODE_0884A5
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	RTS

;---------------------------------------------------------------------------

CODE_018B15:
	LDA.w #$E0A1
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w $1066
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w $1076
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $1078
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDA.w #$0020
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STZ.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_08855F>>16
	LDA.w #FXCODE_08855F
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	RTS

;---------------------------------------------------------------------------

DATA_018B46:
	db $FC,$FC,$20,$0D,$00,$0C,$0C,$1E,$0D,$00,$FC,$04,$0C,$0D,$02,$04
	db $FC,$0E,$0D,$02,$FC,$FC,$3A,$0D,$00,$0C,$0C,$1A,$0D,$00,$FC,$04
	db $08,$0D,$02,$04,$FC,$0A,$0D,$02,$F8,$F8,$C0,$0D,$02,$08,$F8,$C2
	db $0D,$02,$F8,$08,$E0,$0D,$02,$08,$08,$E2,$0D,$02,$FC,$0C,$35,$0D
	db $00,$04,$04,$26,$0D,$02,$FC,$FC,$24,$0D,$02,$FC,$FC,$24,$0D,$00
	db $04,$FC,$22,$0D,$02,$FC,$0C,$2C,$0D,$00,$04,$04,$20,$0D,$02,$04
	db $04,$20,$0D,$00,$0C,$0C,$21,$0D,$00,$FC,$04,$28,$0D,$02,$04,$FC
	db $2A,$0D,$02,$04,$FC,$2A,$0D,$00,$FC,$04,$00,$0D,$02,$0C,$0C,$12
	db $0D,$00,$04,$FC,$02,$0D,$02,$04,$FC,$02,$0D,$00,$0C,$0C,$16,$0D
	db $00,$FC,$04,$04,$0D,$02,$04,$FC,$06,$0D,$02,$04,$FC,$06,$0D,$00
	db $F8,$F8,$CC,$0D,$02,$08,$F8,$CE,$0D,$02,$F8,$08,$EC,$0D,$02,$08
	db $08,$EE,$0D,$02,$00,$00,$D5,$0D,$02,$F8,$F8,$C8,$0D,$02,$08,$F8
	db $CA,$0D,$02,$F8,$08,$E8,$0D,$02,$08,$08,$EA,$0D,$02,$FC,$0C,$35
	db $0F,$00,$04,$04,$26,$0F,$02,$FC,$FC,$24,$0F,$02,$FC,$FC,$24,$0F
	db $00,$04,$FC,$22,$0F,$02,$FC,$0C,$2C,$0F,$00,$04,$04,$20,$0F,$02
	db $04,$04,$20,$0F,$00,$0C,$0C,$21,$0F,$00,$FC,$04,$28,$0F,$02,$04
	db $FC,$2A,$0F,$02,$04,$FC,$2A,$0F,$00,$FC,$04,$00,$0F,$02,$0C,$0C
	db $12,$0F,$00,$04,$FC,$02,$0F,$02,$04,$FC,$02,$0F,$00,$0C,$0C,$16
	db $0F,$00,$FC,$04,$04,$0F,$02,$04,$FC,$06,$0F,$02,$04,$FC,$06,$0F
	db $00,$F8,$F8,$CC,$0F,$02,$08,$F8,$CE,$0F,$02,$F8,$08,$EC,$0F,$02
	db $08,$08,$EE,$0F,$02,$FC,$FC,$20,$0F,$00,$0C,$0C,$1E,$0F,$00,$FC
	db $04,$0C,$0F,$02,$04,$FC,$0E,$0F,$02,$FC,$FC,$3A,$0F,$00,$0C,$0C
	db $1A,$0F,$00,$FC,$04,$08,$0F,$02,$04,$FC,$0A,$0F,$02,$F8,$F8,$C0
	db $0F,$02,$08,$F8,$C2,$0F,$02,$F8,$08,$E0,$0F,$02,$08,$08,$E2,$0F
	db $02

;---------------------------------------------------------------------------

CODE_018CC7:
	REP.b #$10
	LDY.w $7362,x
	LDA.w $6024,y
	AND.w #$FFF0
	ORA.w #$0004
	STA.w $6024,y
CODE_018CD8:
	REP.b #$10
	LDA.w #$0006
	STA.b $00
	LDY.w $7362,x
	LDA.w $1015
	CMP.w #$0002
	BEQ.b CODE_018D03
CODE_018CEA:
	LDA.w $6004,y
	AND.w #$F1FF
	ORA.w #$0200
	STA.w $6004,y
	TYA
	CLC
	ADC.w #$0008
	TAY
	DEC.b $00
	BNE.b CODE_018CEA
	SEP.b #$10
	RTS

CODE_018D03:
	LDA.w $6004,y
	AND.w #$F1FF
	ORA.w #$0C00
	STA.w $6004,y
	TYA
	CLC
	ADC.w #$0008
	TAY
	DEC.b $00
	BNE.b CODE_018D03
	SEP.b #$10
	RTS

;---------------------------------------------------------------------------

CODE_018D1C:
	TXA
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #$0001
	STA.w $6000
	LDA.w $7402,x
	STA.w $6002
	LDY.b $78,x
	TYA
	STA.w $6004
	LDA.w $7A36,x
	STA.w $6006
	LDA.w $7A38,x
	STA.w $6008
	LDA.w $7900,x
	STA.w $600A
	LDA.w $7680,x
	CLC
	ADC.w #$0008
	STA.w $600E
	LDA.w $7682,x
	CLC
	ADC.w #$0008
	STA.w $6010
	LDA.w #$8B46
	STA.w $6012
	LDA.w #$8B82
	STA.w $6014
	LDA.w #$8BFA
	STA.w $6016
	LDA.w #$8BFF
	STA.w $6018
	LDA.w #$8C13
	STA.w $601A
	LDA.w #$8C8B
	STA.w $601C
	LDA.w #$8297
	STA.w $601E
	LDA.w $106A
	STA.w $6026
	LDA.w $106C
	STA.w $6028
	LDA.w $105C
	STA.w $602A
	LDA.w $105E
	STA.w $602C
	LDA.w #$8927
	STA.w $602E
	LDA.w $7902,x
	STA.w $6030
	LDA.w $106E
	STA.w $6032
	LDA.w $107A
	STA.w $6046
	LDA.w $1076
	STA.w $6050
	LDA.w $1078
	STA.w $6052
	LDX.b #FXCODE_08A3BA>>16
	LDA.w #FXCODE_08A3BA
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $6026
	STA.w $106A
	LDA.w $6028
	STA.w $106C
	LDA.w $6034
	STA.w $1064
	LDA.w $6036
	STA.w $1062
	LDA.w $6038
	STA.w $1066
	LDA.w $603A
	STA.w $1068
	LDA.w $603C
	STA.w $1060
	JSR.w CODE_01909B
	LDY.w $1072
	BNE.b CODE_018E25
	LDA.w $7720,x
	STA.b $00
	LDA.w $603E
	SEC
	SBC.w $7682,x
	CLC
	ADC.w #$FFFB
	STA.w $7720,x
	SEC
	SBC.b $00
	STA.b $00
	CLC
	ADC.w #$0004
	CMP.w #$0008
	BCC.b CODE_018E25
	LDA.w $7182,x
	SEC
	SBC.b $00
	STA.w $7182,x
CODE_018E25:
	LDA.w $6022
	STA.b $0A
	LDA.w $6024
	STA.b $0C
	LDA.w $7680,x
	CLC
	ADC.w #$0060
	CMP.w #$01C0
	BCC.b CODE_018E43
	LDA.w #$0160
	STA.w $0041
	BRA.b CODE_018E55

CODE_018E43:
	LDA.w #$0020
	SEC
	SBC.b $0A
	STA.w $0041
	LDA.w #$001C
	SEC
	SBC.b $0C
	STA.w $0043
CODE_018E55:
	LDA.b $0A
	SEC
	SBC.w $7680,x
	STA.w $7B56,x
	LDA.b $0C
	SEC
	SBC.w $7682,x
	STA.w $7B58,x
	LDA.w #$0011
	STA.w $0B83
	LDA.w $106E
	AND.w #$FF00
	BEQ.b CODE_018E78
	STZ.w $106E
CODE_018E78:
	LDY.b $76,x
	CPY.b #$33
	BMI.b CODE_018E8B
	LDA.w $6058
	SEC
	SBC.w $6056
	SEC
	SBC.w $6122
	BRA.b CODE_018EBE

CODE_018E8B:
	LDA.w $605A
	BIT.w #$0001
	BEQ.b CODE_018E94
CODE_018E93:
	RTS

CODE_018E94:
	CMP.w #$0008
	BNE.b CODE_018E9E
	LDA.w $6058
	BPL.b CODE_018EA1
CODE_018E9E:
	JMP.w CODE_018F72

CODE_018EA1:
	SEC
	SBC.w $6056
	SEC
	SBC.w $6122
	CMP.w #$FFF4
	BCC.b CODE_018E9E
	LDY.w $60AB
	BMI.b CODE_018E93
	LDY.w $7402,x
	CPY.b #$28
	BPL.b CODE_018F38
	CPY.b #$21
	BMI.b CODE_018F38
CODE_018EBE:
	CLC
	ADC.w #$0003
	CLC
	ADC.w $6090
	STA.w $6090
	STZ.w $60AA
	STZ.w $60C0
	INC.w $61B4
	LDY.b $76,x
	CPY.b #$29
	BEQ.b CODE_018EE0
	CPY.b #$2A
	BEQ.b CODE_018EE0
	CPY.b #$33
	BMI.b CODE_018EE7
CODE_018EE0:
	LDA.w #$0029
	STA.w $60BE
	RTS

CODE_018EE7:
	LDY.w $60D4
	BEQ.b CODE_018F37
	LDY.w $107E
	CPY.w $107C
	BNE.b CODE_018F37
	LDA.w #$0060
	STA.w $7AF6,x
	LDA.w #$0002
	STA.w $60AC
	LDA.w #$0029
	INC.w $107C
	INC.w $107C
	LDY.w $107C
	CPY.b #$06
	BNE.b CODE_018F1A
	JSL.l CODE_02A982
	INC.w $0B7B
	LDA.w #$0033
CODE_018F1A:
	STA.b $76,x
	LDA.w #$0001
	STA.w $7A36,x
	LDY.b #$24
	STY.b $78,x
	LDY.b #$0F
	STY.w $105E
	LDA.w #$0030
	STA.b $18,x
	LDA.w #$0080
	JSL.l CODE_0085D2
CODE_018F37:
	RTS

CODE_018F38:
	LDA.w #$001C
	JSL.l CODE_0085D2
	LDY.b $76,x
	CPY.b #$0A
	BMI.b CODE_018F5B
	LDA.w #$FC00
	STA.w $60AA
	LDA.w #$0006
	STA.w $60C0
	LDA.w #$8001
	STA.w $60D2
	STZ.w $60D4
	RTS

CODE_018F5B:
	JSR.w CODE_018FE3
	LDA.w $7402,x
	AND.w #$0007
	CLC
	ADC.w #$0028
	STA.b $78,x
	LDY.b #$05
	STY.b $76,x
	LDY.b #$18
	BRA.b CODE_018FBD

CODE_018F72:
	CMP.w #$0006
	BNE.b CODE_018F7C
	LDA.w $6058
	BPL.b CODE_018F7F
CODE_018F7C:
	JMP.w CODE_018FD4

CODE_018F7F:
	SEC
	SBC.w $6056
	SEC
	SBC.w $6122
	CMP.w #$FFF4
	BCC.b CODE_018F7C
	LDY.b $76,x
	CPY.b #$0A
	BMI.b CODE_018FA8
	LDA.w #$FB00
	STA.w $60AA
	LDA.w #$0006
	STA.w $60C0
	LDA.w #$8001
	STA.w $60D2
	STZ.w $60D4
	RTS

CODE_018FA8:
	LDY.w $60AB
	BMI.b CODE_018F37
	JSR.w CODE_018FE3
	LDA.w #$0039
	JSL.l CODE_0085D2
	LDY.b #$02
	STY.b $76,x
	LDY.b #$17
CODE_018FBD:
	STY.w $105E
	LDA.w #$0001
	STA.w $7A36,x
	INC.w $1070
	LDY.b #$02
	STY.w $1074
	LDA.w #$0040
	STA.b $18,x
	RTS

CODE_018FD4:
	LDY.b $76,x
	CPY.b #$1C
	BMI.b CODE_018FDE
	CPY.b #$27
	BMI.b CODE_018FE2
CODE_018FDE:
	JSL.l CODE_03A858
CODE_018FE2:
	RTS

CODE_018FE3:
	LDA.w #$FB00
	STA.w $60AA
	LDA.w #$0006
	STA.w $60C0
	LDA.w #$8001
	STA.w $60D2
	STZ.w $60D4
	LDA.b $10
	AND.w #$003E
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$FD00
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B8595>>16
	LDA.w #FXCODE_0B8595
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDY.w $7400,x
	BEQ.b CODE_01901D
	EOR.w #$FFFF
	INC
CODE_01901D:
	STA.b $00
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.b $04
	LDA.w $7CD6,x
	CLC
	ADC.w $6040
	SEC
	SBC.w #$0008
	STA.b $0A
	LDA.w $7CD8,x
	CLC
	ADC.w $6054
	SEC
	SBC.w #$0004
	STA.b $0C
	LDX.b #FXCODE_0991D5>>16
	LDA.w #FXCODE_0991D5
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R6_MultiplierLo
	CPY.b #$06
	BMI.b CODE_019077
CODE_019050:
	STZ.b $02
	JSL.l CODE_0EEBFA
	LDA.b $04
	STA.w $71E2,y
	LDA.w #$0028
	STA.w $7002,y
	LDA.w #$0005
	STA.w $7462,y
	LDA.w #$0000
	STA.w $75A2,y
	LDA.w #$0008
	STA.w $7502,y
	STA.w $7500,y
	RTS

CODE_019077:
	LDA.w #$0025
	JSL.l CODE_03A364
	BCC.b CODE_019050
	LDA.b $0A
	STA.w $70E2,y
	LDA.b $0C
	STA.w $7182,y
	LDA.b $00
	STA.w $7220,y
	LDA.b $04
	STA.w $7222,y
	LDA.w #$0040
	STA.w $7542,y
	RTS

CODE_01909B:
	LDA.w $7CD6,x
	PHA
	CLC
	ADC.w $6040
	STA.w $7CD6,x
	LDA.w $7CD8,x
	PHA
	CLC
	ADC.w $6054
	STA.w $7CD8,x
	LDA.w $7BB6,x
	PHA
	LDA.w $7BB8,x
	PHA
	LDA.w #$000C
	STA.w $7BB6,x
	STA.w $7BB8,x
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_099011>>16
	LDA.w #FXCODE_099011
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	BRA.b CODE_0190DA

CODE_0190D1:
	LDX.b #$09
	LDA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
CODE_0190DA:
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	BMI.b CODE_019123
	BEQ.b CODE_019123
	LDA.w $7D38,y
	BEQ.b CODE_0190D1
	LDA.w $7220,y
	STA.b $00
	LDA.w $7542,y
	STA.b $02
	TYX
	JSL.l CODE_03B24B
	LDY.b $76,x
	CPY.b #$0B
	BPL.b CODE_019120
	INC.w $1070
	LDY.b #$06
	STY.w $1074
	LDY.b #$17
	STY.w $105E
	LDA.w #$0020
	STA.b $18,x
	LSR
	STA.w $7A96,x
	LDY.b #$0D
	STY.b $76,x
	LDA.w #$003F
	JSL.l CODE_0085D2
	BRA.b CODE_019123

CODE_019120:
	JSR.w CODE_01913C
CODE_019123:
	PLA
	STA.w $7BB8,x
	PLA
	STA.w $7BB6,x
	PLA
	STA.w $7CD8,x
	PLA
	STA.w $7CD6,x
CODE_019133:
	RTS

;---------------------------------------------------------------------------

DATA_019134:
	db $1D,$1F

DATA_019136:
	db $08,$0A

DATA_019138:
	dw $0200,$FE00

CODE_01913C:
	LDA.b $02
	BNE.b CODE_019133
	LDA.w $7400,x
	DEC
	EOR.b $00
	BPL.b CODE_019133
	LDY.b $76,x
	CPY.b #$0F
	BMI.b CODE_019156
	CPY.b #$1C
	BMI.b CODE_0191BA
	CPY.b #$1F
	BPL.b CODE_0191BA
CODE_019156:
	INC.w $1070
	LDA.w #$FE00
	STA.w $7900,x
	STZ.w $7A38,x
	STZ.w $7A36,x
	INC.w $107A
	LDY.w $107A
	CPY.b #$03
	BMI.b CODE_01919D
	LDY.w $7400,x
	LDA.w DATA_019138,y
	STA.w $7220,x
	INC.w $106E
	INC.w $1072
	LDA.w #$0012
	STA.w $7720,x
	LDY.b #$21
	STY.b $78,x
	LDY.b #$0C
	STY.w $105E
	LDA.w #$FC00
	STA.w $7222,x
	LDA.w #$0020
	STA.b $18,x
	LDY.b #$1F
	STY.b $76,x
	RTS

CODE_01919D:
	SEP.b #$20
	LDA.w DATA_019134-$01,y
	STA.b $78,x
	LDA.w DATA_019136-$01,y
	STA.w $105E
	REP.b #$20
	LDA.w #$0020
	STA.b $18,x
	LDY.b #$04
	STY.w $1074
	LDY.b #$1C
	STY.b $76,x
CODE_0191BA:
	RTS

;---------------------------------------------------------------------------

CODE_0191BB:
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_099011>>16
	LDA.w #FXCODE_099011
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	BRA.b CODE_0191D3

CODE_0191CA:
	LDX.b #$09
	LDA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
CODE_0191D3:
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	BMI.b CODE_0191BA
	BEQ.b CODE_0191BA
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_0191CA
	LDA.w $7D38,y
	BEQ.b CODE_0191CA
	LDA.w $7542,y
	STA.b $00
	LDA.w $7220,y
	STA.b $02
	TYX
	PHY
	JSL.l CODE_03B24B
	PLY
	LDA.b $00
	BNE.b CODE_0191CA
	LDA.w $7400,x
	DEC
	EOR.b $02
	BPL.b CODE_0191CA
	LDA.w $7CD8,y
	SEC
	SBC.w $7CD8,x
	BPL.b CODE_0191CA
	LDA.w #$003F
	JSL.l CODE_0085D2
	LDY.w $107A
	CPY.b #$02
	BMI.b CODE_0191CA
	LDY.b $76,x
	CPY.b #$1C
	BMI.b CODE_0191CA
	CPY.b #$1F
	BPL.b CODE_0191CA
	JMP.w CODE_019156

;---------------------------------------------------------------------------

CODE_01922A:
	LDA.w $7A36,x
	CLC
	ADC.b $18,x
	CMP.w #$0100
	BMI.b CODE_019249
	SEP.b #$20
	LDA.b $78,x
	STA.w $7402,x
	REP.b #$20
	LDA.w $105E
	STA.w $105C
	LDA.w #$0000
	STA.b $18,x
CODE_019249:
	STA.w $7A36,x
CODE_01924C:
	RTS

;---------------------------------------------------------------------------

CODE_01924D:
	LDA.w $7AF6,x
	BEQ.b CODE_01924C
	DEC
	BEQ.b CODE_019291
	AND.w #$0004
	BNE.b CODE_019291
	LDX.b #$14
CODE_01925C:
	LDA.l DATA_5FA570,x
	STA.l $702D6E,x
	STA.l $702002,x
	STA.l $702F2E,x
	STA.l $7021C2,x
	STA.l $702F4E,x
	STA.l $7021E2,x
	DEX
	DEX
	BPL.b CODE_01925C
	LDX.b #$06
CODE_01927E:
	LDA.l DATA_5FA586,x
	STA.l $702D84,x
	STA.l $702018,x
	DEX
	DEX
	BPL.b CODE_01927E
	LDX.b $12
	RTS

;---------------------------------------------------------------------------

CODE_019291:
	LDX.b #$1C
CODE_019293:
	LDA.l DATA_5FDA80,x
	STA.l $702D6E,x
	STA.l $702002,x
	LDA.l DATA_5FDAA0,x
	STA.l $702F2E,x
	STA.l $7021C2,x
	LDA.l DATA_5FDAC0,x
	STA.l $702F4E,x
	STA.l $7021E2,x
	DEX
	DEX
	BPL.b CODE_019293
	LDA.l DATA_5FDA9E
	STA.l $702F2C
	STA.l $7021C0
	LDA.l DATA_5FDABE
	STA.l $702F4C
	STA.l $7021E0
	LDX.b $12
	RTS

;---------------------------------------------------------------------------

DATA_0192D6:
	dw $FF20,$00E0

CODE_0192DA:
	LDA.w $70E2,x
	SEC
	SBC.w $1082
	CLC
	ADC.w #$00E0
	CMP.w #$01C0
	BCC.b CODE_019311
	STA.b $00
	LDA.w $7220,x
	BNE.b CODE_0192F5
	LDA.w $7400,x
	DEC
CODE_0192F5:
	EOR.b $00
	BMI.b CODE_019311
	LDY.b #$00
	LDA.b $00
	BMI.b CODE_019301
	INY
	INY
CODE_019301:
	LDA.w $1082
	CLC
	ADC.w DATA_0192D6,y
	STA.w $70E2,x
	STZ.w $7220,x
	STZ.w $7540,x
CODE_019311:
	RTS

;---------------------------------------------------------------------------

CODE_019312:
	TYX
	LDY.b #$01
	STY.b $76,x
	LDA.w #$0040
	STA.w $7A98,x
	LDA.b $10
	AND.w #$0001
	BEQ.b CODE_019366
	LDA.w $70E2,x
	SEC
	SBC.w $1082
	CLC
	ADC.w #$00A0
	CMP.w #$0140
	BCC.b CODE_01933E
	STA.b $00
	LDA.w $7400,x
	DEC
	EOR.b $00
	BPL.b CODE_019366
CODE_01933E:
	LDA.b $78,x
	AND.w #$0007
	CLC
	ADC.w #$0028
	STA.b $78,x
	LDY.b #$18
	STY.w $105E
	LDA.w #$0001
	STA.w $7A36,x
	INC.w $1070
	LDA.w #$0020
	STA.b $18,x
	LDA.w #$0040
	STA.w $7A96,x
	LDY.b #$08
	STY.b $76,x
CODE_019366:
	RTS

;---------------------------------------------------------------------------

CODE_019367:
	TYX
	STZ.w $105C
	STZ.w $105E
	STZ.w $1070
	LDA.w #$FE00
	STA.w $7900,x
	STZ.w $7A38,x
	LDA.w $7A96,x
	BNE.b CODE_0193B6
	LDA.w #$0020
	STA.b $18,x
	LDA.w $7A36,x
	BNE.b CODE_0193B6
	LDA.w $7A98,x
	BNE.b CODE_019391
	STZ.b $76,x
	RTS

CODE_019391:
	SEP.b #$20
	LDA.b $78,x
	INC
	AND.b #$07
	STA.b $78,x
	REP.b #$20
	LDA.w $7402,x
	AND.w #$0003
	BNE.b CODE_0193B6
	LDA.w #$0008
	STA.w $7A96,x
	LDA.w #$0056
	JSL.l CODE_0085D2
	INC.w $7A36,x
	STZ.b $18,x
CODE_0193B6:
	JSR.w CODE_0193BA
	RTS

;---------------------------------------------------------------------------

CODE_0193BA:
	LDA.w $77C2,x
	AND.w #$00FF
	CMP.w $7400,x
	BEQ.b CODE_0193FF
	INC.w $1070
	INC.w $106E
	LDA.w #$FE00
	STA.w $7900,x
	STZ.w $7A38,x
	STZ.w $7A36,x
	LDY.b #$18
	STY.b $78,x
	LDY.b #$03
	STY.w $105E
	LDA.w #$0010
	STA.b $18,x
	LDY.b $76,x
	CPY.b #$01
	BNE.b CODE_0193F0
	LDY.b #$16
	STY.b $76,x
	RTS

CODE_0193F0:
	LDA.w #$FC00
	STA.w $7222,x
	INC.b $78,x
	INC.w $105E
	LDY.b #$18
	STY.b $76,x
CODE_0193FF:
	RTS

;---------------------------------------------------------------------------

CODE_019400:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019416
	STZ.w $105E
	LDA.w #$0040
	STA.b $18,x
	LDA.w #$0030
	STA.w $7A96,x
	INC.b $76,x
CODE_019416:
	RTS

;---------------------------------------------------------------------------

CODE_019417:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_019427
	STZ.w $1074
	LDA.w #$0080
	STA.b $18,x
	INC.b $76,x
CODE_019427:
	RTS

;---------------------------------------------------------------------------

CODE_019428:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019438
	LDA.w #$0040
	STA.w $7A98,x
	LDY.b #$01
	STY.b $76,x
CODE_019438:
	RTS

;---------------------------------------------------------------------------

CODE_019439:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019458
	LDA.w $7402,x
	SEC
	SBC.w #$0028
	STA.b $78,x
	STZ.w $105E
	LDA.w #$0040
	STA.b $18,x
	LDA.w #$0030
	STA.w $7A96,x
	INC.b $76,x
CODE_019458:
	RTS

;---------------------------------------------------------------------------

CODE_019459:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_019469
	STZ.w $1074
	LDA.w #$0080
	STA.b $18,x
	INC.b $76,x
CODE_019469:
	RTS

;---------------------------------------------------------------------------

CODE_01946A:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019472
	INC.b $76,x
CODE_019472:
	RTS

;---------------------------------------------------------------------------

CODE_019473:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_019493
	INC.b $76,x
CODE_01947B:
	LDA.b $78,x
	SEC
	SBC.w #$0029
	AND.w #$0007
	ORA.w #$0008
	STA.b $78,x
	LDY.b #$01
	STY.w $105E
	LDA.w #$0008
	STA.b $18,x
CODE_019493:
	RTS

;---------------------------------------------------------------------------

CODE_019494:
	TYX
	LDA.w #$0001
	STA.w $105C
	STA.w $105E
	STZ.w $106E
	LDA.w $7974
	AND.w #$0001
	BNE.b CODE_0194AC
	STZ.w $1070
CODE_0194AC:
	LDA.w #$FE00
	STA.w $7900,x
	STZ.w $7A38,x
	LDA.w $7A96,x
	BEQ.b CODE_0194BD
	JMP.w CODE_019525

CODE_0194BD:
	LDA.w #$0020
	STA.b $18,x
	LDA.w $7A36,x
	BNE.b CODE_019525
	LDA.w $7A98,x
	BNE.b CODE_0194FE
	LDY.w $77C2,x
	TYA
	CMP.w $7400,x
	BNE.b CODE_0194FE
	LDA.w $7C16,x
	CLC
	ADC.w #$0070
	CMP.w #$00E0
	BCS.b CODE_0194FE
	SEP.b #$20
	LDA.b $78,x
	INC
	AND.b #$07
	ORA.b #$10
	STA.b $78,x
	REP.b #$20
	LDY.b #$02
	STY.w $105E
	STY.w $1074
	LDA.w #$0020
	STA.b $18,x
	INC.b $76,x
	RTS

CODE_0194FE:
	SEP.b #$20
	LDA.b $78,x
	INC
	AND.b #$07
	ORA.b #$08
	STA.b $78,x
	REP.b #$20
	LDA.w $7402,x
	AND.w #$0003
	BNE.b CODE_019525
	LDA.w #$0008
	STA.w $7A96,x
	LDA.w #$0056
	JSL.l CODE_0085D2
	INC.w $7A36,x
	STZ.b $18,x
CODE_019525:
	JSR.w CODE_0193BA
	RTS

;---------------------------------------------------------------------------

CODE_019529:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_01953F
	LDA.w #$0040
	STA.w $7A96,x
	LDA.w #$00C0
	STA.w $7A98,x
	LDY.b #$0E
	STY.b $76,x
CODE_01953F:
	RTS

;---------------------------------------------------------------------------

CODE_019540:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_01953F
	INC.w $1070
	STZ.w $1074
	LDY.b #$0A
	STY.b $76,x
	JMP.w CODE_01947B

;---------------------------------------------------------------------------

DATA_019553:
	dw $0500,$0060

DATA_019557:
	dw $FD80,$0280,$FF40,$00C0,$FF00,$0100

CODE_019563:
	TYX
	LDA.w #$0002
	STA.w $105C
	STA.w $105E
	LDA.w #$FE00
	STA.w $7900,x
	LDA.w #$0040
	STA.b $18,x
	LDA.w $7A36,x
	BNE.b CODE_01953F
	SEP.b #$20
	LDA.b $78,x
	INC
	AND.b #$07
	ORA.b #$10
	STA.b $78,x
	REP.b #$20
	LDA.w $7402,x
	AND.w #$0003
	BNE.b CODE_019599
	LDA.w #$0056
	JSL.l CODE_0085D2
CODE_019599:
	LDY.b #$08
	LDA.w $7400,x
	BEQ.b CODE_0195AD
	INY
	INY
	SEC
	SBC.w #$0020
	CMP.w $7E1A
	BPL.b CODE_0195D6
	BRA.b CODE_0195BB

CODE_0195AD:
	LDY.b #$08
	LDA.w $70E2,x
	SEC
	SBC.w #$0070
	CMP.w $7E18
	BMI.b CODE_0195D6
CODE_0195BB:
	LDA.w $7A96,x
	BNE.b CODE_0195E8
	LDY.w $77C2,x
	TYA
	CMP.w $7400,x
	BEQ.b CODE_0195D9
	LDA.w $7A98,x
	BNE.b CODE_0195E8
	LDA.w $7400,x
	CLC
	ADC.w #$0004
	TAY
CODE_0195D6:
	JMP.w CODE_019669

CODE_0195D9:
	LDA.w $7C16,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	CLC
	ADC.w #$0050
	CMP.w #$00A0
	BCC.b CODE_0195E9
CODE_0195E8:
	RTS

CODE_0195E9:
	CLC
	ADC.w #$FFD0
	CMP.w #$0040
	BCC.b CODE_0195E8
	LDA.w $60A8
	BMI.b CODE_0195FB
	EOR.w #$FFFF
	INC
CODE_0195FB:
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.b #$00
	LDA.w $60A8
	EOR.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	BMI.b CODE_01960A
	INY
	INY
CODE_01960A:
	LDA.w DATA_019553,y
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	SEC
	SBC.w #$0100
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.w $7220,x
	BNE.b CODE_019646
	LDA.w $7400,x
	CLC
	ADC.w #$0004
	TAY
	BRA.b CODE_019669

CODE_019646:
	LDY.b #$00
	CLC
	ADC.w #$0400
	CMP.w #$0800
	BCC.b CODE_019657
	BMI.b CODE_019669
	INY
	INY
	BRA.b CODE_019669

CODE_019657:
	CLC
	ADC.w #$FCC0
	CMP.w #$0180
	BCS.b CODE_01966F
	LDY.b #$04
	CMP.w #$00C0
	BMI.b CODE_019669
	INY
	INY
CODE_019669:
	LDA.w DATA_019557,y
	STA.w $7220,x
CODE_01966F:
	INC.w $1070
	INC.w $106E
	INC.w $1072
	LDA.w #$000A
	STA.w $7720,x
	LDA.w #$FE00
	STA.w $7900,x
	STZ.w $7A38,x
	LDY.b #$1A
	STY.b $78,x
	LDA.w #$FB00
	STA.w $7222,x
	LDA.w #$0280
	STA.w $75E2,x
	LDA.w #$0028
	STA.w $7542,x
	LDY.b #$05
	STY.w $105E
	LDA.w #$0010
	STA.b $18,x
	INC.b $76,x
	RTS

;---------------------------------------------------------------------------

DATA_0196AA:
	dw $FF00,$0100

CODE_0196AE:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_0196EB
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_0196EB
	LDY.w $7400,x
	LDA.w DATA_0196AA,y
	STA.w $7220,x
	LDA.w #$0400
	STA.w $75E2,x
	LDA.w #$0040
	STA.w $7542,x
	LDY.b #$1B
	STY.b $78,x
	LDY.b #$06
	STY.w $105E
	LDA.w #$0020
	STA.b $18,x
	STA.w $61C6
	LDA.w #$0047
	JSL.l CODE_0085D2
	INC.b $76,x
CODE_0196EB:
	RTS

;---------------------------------------------------------------------------

CODE_0196EC:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019708
	LDY.b #$1A
	STY.b $78,x
	LDY.b #$05
	STY.w $105E
	LDA.w #$0010
	STA.b $18,x
	LDA.w #$FE00
	STA.w $7222,x
	INC.b $76,x
CODE_019708:
	RTS

;---------------------------------------------------------------------------

CODE_019709:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_01973C
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_01973C
	LDY.b #$06
	STY.w $1074
	LDA.w #$0008
	STA.w $7540,x
	LDY.b #$1C
	STY.b $78,x
	LDY.b #$07
	STY.w $105E
	LDA.w #$0020
	STA.b $18,x
	STA.w $61C6
	LDA.w #$0047
	JSL.l CODE_0085D2
	INC.b $76,x
CODE_01973C:
	RTS

;---------------------------------------------------------------------------

CODE_01973D:
	TYX
	LDY.b #$02
	STY.b $00
	LDA.w $7A36,x
	BNE.b CODE_019749
	DEC.b $00
CODE_019749:
	LDA.w $7220,x
	CLC
	ADC.w #$0008
	CMP.w #$0010
	BCS.b CODE_01975D
	STZ.w $7540,x
	STZ.w $7220,x
	DEC.b $00
CODE_01975D:
	LDY.b $00
	BNE.b CODE_019771
	LDY.b #$1A
	STY.b $78,x
	LDY.b #$05
	STY.w $105E
	LDA.w #$0008
	STA.b $18,x
	INC.b $76,x
CODE_019771:
	RTS

;---------------------------------------------------------------------------

CODE_019772:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_01977F
	LDA.w #$0008
	STA.b $16,x
	INC.b $76,x
CODE_01977F:
	RTS

;---------------------------------------------------------------------------

CODE_019780:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_0197B7
	DEC.b $16,x
	BPL.b CODE_0197A8
	LDY.b #$03
	STY.b $78,x
	STZ.w $105E
	LDA.w #$0010
	STA.b $18,x
	LDA.w $106E
	ORA.w #$FF00
	STA.w $106E
	STZ.w $1072
	STZ.w $1074
	INC.b $76,x
	RTS

CODE_0197A8:
	LDA.w $1074
	EOR.w #$0006
	STA.w $1074
	LDA.w #$0008
	STA.w $7A96,x
CODE_0197B7:
	RTS

;---------------------------------------------------------------------------

CODE_0197B8:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_0197C8
	LDA.w #$0040
	STA.w $7A98,x
	LDY.b #$01
	STY.b $76,x
CODE_0197C8:
	RTS

;---------------------------------------------------------------------------

CODE_0197C9:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_0197E2
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
	LDA.w #$FC00
	STA.w $7222,x
	STA.b $16,x
	INC.b $76,x
CODE_0197E2:
	RTS

;---------------------------------------------------------------------------

CODE_0197E3:
	TYX
	LDY.w $7223,x
	BMI.b CODE_01981C
	LDA.b $16,x
	BEQ.b CODE_0197FC
	STZ.b $16,x
	LDY.b #$02
	STY.b $78,x
	STZ.w $105E
	LDA.w #$0010
	STA.b $18,x
	RTS

CODE_0197FC:
	LDA.w $7A36,x
	BNE.b CODE_01981C
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_01981C
	LDA.w $106E
	ORA.w #$FF00
	STA.w $106E
	LDA.w #$0040
	STA.w $7A98,x
	LDY.b #$01
	STY.b $76,x
CODE_01981C:
	RTS

;---------------------------------------------------------------------------

CODE_01981D:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_01983C
	LDY.w $7223,x
	BMI.b CODE_01983C
	STZ.w $7222,x
	STZ.w $7542,x
	DEC.b $78,x
	LDY.b #$03
	STY.w $105E
	LDA.w #$0020
	STA.b $18,x
	INC.b $76,x
CODE_01983C:
	RTS

;---------------------------------------------------------------------------

CODE_01983D:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019875
	LDY.b $76,x
	CPY.b #$19
	BEQ.b CODE_01985D
	LDY.b #$0A
	STY.b $78,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0010
	STA.b $18,x
	LDA.w #$0001
	BRA.b CODE_019870

CODE_01985D:
	INC.b $78,x
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
	LDA.w #$0020
	STA.b $18,x
	LDA.w #$0004
CODE_019870:
	STA.w $105E
	INC.b $76,x
CODE_019875:
	RTS

;---------------------------------------------------------------------------

CODE_019876:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019897
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_019897
	LDA.w $106E
	ORA.w #$FF00
	STA.w $106E
	LDA.w #$0040
	STA.w $7A98,x
	LDY.b #$09
	STY.b $76,x
CODE_019897:
	RTS

;---------------------------------------------------------------------------

CODE_019898:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_0198A5
	LDA.w #$0014
	STA.b $16,x
	INC.b $76,x
CODE_0198A5:
	RTS

;---------------------------------------------------------------------------

CODE_0198A6:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_0198E7
	DEC.b $16,x
	BPL.b CODE_0198C7
	LDY.b #$06
	STY.w $1074
	LDY.b #$0A
	STY.b $78,x
	LDA.w #$0001
	STA.w $105E
	LDA.w #$0010
	STA.b $18,x
	INC.b $76,x
	RTS

CODE_0198C7:
	LDA.b $16,x
	AND.w #$0001
	ASL
	DEC
	STA.b $00
	CLC
	ADC.w $105E
	STA.w $105E
	SEP.b #$20
	LDA.b $78,x
	CLC
	ADC.b $00
	STA.b $78,x
	REP.b #$20
	LDA.w #$0020
	STA.b $18,x
CODE_0198E7:
	RTS

;---------------------------------------------------------------------------

CODE_0198E8:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_0198FE
	STZ.w $1074
	STZ.w $107A
	LDA.w #$0040
	STA.w $7A98,x
	LDY.b #$09
	STY.b $76,x
CODE_0198FE:
	RTS

;---------------------------------------------------------------------------

DATA_0198FF:
	dw $0100,$FF00

CODE_019903:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019930
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_019930
	LDY.w $7400,x
	LDA.w DATA_0198FF,y
	STA.w $7220,x
	INC.b $78,x
	INC.w $105E
	LDA.w #$0020
	STA.b $18,x
	STA.w $61C6
	LDA.w #$0047
	JSL.l CODE_0085D2
	INC.b $76,x
CODE_019930:
	RTS

;---------------------------------------------------------------------------

CODE_019931:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019949
	INC.b $78,x
	INC.w $105E
	LDA.w #$0010
	STA.b $18,x
	LDA.w #$FE00
	STA.w $7222,x
	INC.b $76,x
CODE_019949:
	RTS

;---------------------------------------------------------------------------

CODE_01994A:
	TYX
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_019990
	LDY.b #$06
	CPY.w $1074
	BEQ.b CODE_019964
	STY.w $1074
	LDA.w #$0047
	JSL.l CODE_0085D2
CODE_019964:
	LDA.w #$0008
	STA.w $7540,x
	CLC
	ADC.w $7220,x
	CMP.w #$0010
	BCS.b CODE_019990
	STZ.w $7540,x
	STZ.w $7220,x
	LDA.w $7A36,x
	BNE.b CODE_019990
	DEC.b $78,x
	DEC.w $105E
	LDA.w #$0008
	STA.b $18,x
	LDA.w #$0020
	STA.w $61C6
	INC.b $76,x
CODE_019990:
	RTS

;---------------------------------------------------------------------------

CODE_019991:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_0199AD
	LDA.w #$0014
	STA.b $16,x
	LDY.b #$04
	STY.w $1074
	DEC.b $78,x
	DEC.w $105E
	LDA.w #$0020
	STA.b $18,x
	INC.b $76,x
CODE_0199AD:
	RTS

;---------------------------------------------------------------------------

CODE_0199AE:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_0199EF
	DEC.b $16,x
	BPL.b CODE_0199CF
	LDY.b #$02
	STY.w $1074
	LDA.w #$0040
	STA.w $7A96,x
	LDY.b #$18
	STY.b $78,x
	LDY.b #$10
	STY.w $105E
	INC.b $76,x
	RTS

CODE_0199CF:
	LDA.b $16,x
	AND.w #$0001
	ASL
	DEC
	STA.b $00
	CLC
	ADC.w $105E
	STA.w $105E
	SEP.b #$20
	LDA.b $78,x
	CLC
	ADC.b $00
	STA.b $78,x
	REP.b #$20
	LDA.w #$0020
	STA.b $18,x
CODE_0199EF:
	LDA.w $7A98,x
	BNE.b CODE_0199FA
	LDA.w #$0008
	STA.w $7A98,x
CODE_0199FA:
	RTS

;---------------------------------------------------------------------------

CODE_0199FB:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_019A2C
	LDA.b $16,x
	BEQ.b CODE_019A0D
	STZ.b $16,x
	LDA.w #$0020
	STA.b $18,x
	RTS

CODE_019A0D:
	LDA.w $7A36,x
	BNE.b CODE_019A2C
	LDA.w #$000C
	STA.b $16,x
	LDA.w $1060
	SEC
	SBC.w #$0080
	LDY.w $7400,x
	BNE.b CODE_019A27
	EOR.w #$FFFF
	INC
CODE_019A27:
	STA.w $1088
	INC.b $76,x
CODE_019A2C:
	RTS

;---------------------------------------------------------------------------

DATA_019A2D:
	dw $FE00,$0200

CODE_019A31:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019A64
	DEC.b $16,x
	BPL.b CODE_019A44
	LDA.w #$0008
	STA.w $7A96,x
	INC.b $76,x
	RTS

CODE_019A44:
	LDA.b $16,x
	AND.w #$0001
	PHP
	ASL
	DEC
	CLC
	ADC.w $105E
	STA.w $105E
	LDA.w #$0030
	STA.b $18,x
	PLP
	BEQ.b CODE_019A64
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
CODE_019A64:
	LDA.w $1060
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $1088
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0080
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$0048
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	TXA
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDX.b #FXCODE_08A929>>16
	LDA.w #FXCODE_08A929
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w $1088
CODE_019A91:
	RTS

;---------------------------------------------------------------------------

CODE_019A92:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_019A91
	LDY.b $16,x
	BEQ.b CODE_019ABE
	STZ.b $16,x
	LDY.w $77C2,x
	LDA.w DATA_019A2D,y
	STA.w $7220,x
	LDA.w #$FA00
	STA.w $7222,x
	LDY.b #$03
	STY.w $105E
	LDA.w #$0008
	STA.b $18,x
	STZ.w $7A38,x
	STZ.w $7902,x
	RTS

CODE_019ABE:
	LDA.w $7A36,x
	BNE.b CODE_019B18
	STZ.w $7220,x
	STZ.w $7222,x
	STZ.w $7542,x
	LDA.w $75E0,x
	BNE.b CODE_019AE1
	LDA.w #$0020
	STA.w $7A96,x
	STA.w $75E0,x
	LDA.w #$000C
	STA.w $7720,x
	RTS

CODE_019AE1:
	LDA.w #$0060
	STA.w $7542,x
	LDA.w #$0800
	STA.w $7222,x
	STA.w $75E2,x
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_019B18
	LDA.w #$0003
	STA.b $16,x
	STZ.w $75E0,x
	LDA.w #$0020
	STA.w $61C8
	LDA.w #$0004
	STA.w $7A96,x
	STZ.w $1074
	LDA.w #$0047
	JSL.l CODE_0085D2
	INC.b $76,x
CODE_019B18:
	RTS

;---------------------------------------------------------------------------

DATA_019B19:
	dw $FE00,$0200

DATA_019B1D:
	db $03,$10

DATA_019B1F:
	dw $0000,$FC00

CODE_019B23:
	TYX
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_019BA3
	LDA.w $7A96,x
	BNE.b CODE_019BA3
	LDA.b $16,x
	AND.w #$0001
	BNE.b CODE_019B70
	STZ.w $7220,x
	LDA.w #$0020
	STA.w $61C8
	LDA.w #$0004
	STA.w $7A96,x
	LDA.w #$0047
	JSL.l CODE_0085D2
	DEC.b $16,x
	BPL.b CODE_019BA3
	LDA.w #$0080
	STA.w $7A96,x
	STZ.w $1072
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
	STZ.w $7A38,x
	STZ.w $7902,x
	INC.b $76,x
	RTS

CODE_019B70:
	DEC.b $16,x
	LDA.b $16,x
	LSR
	TAY
	SEP.b #$20
	LDA.w DATA_019B1D,y
	STA.w $105E
	REP.b #$20
	LDY.b $16,x
	LDA.w DATA_019B1F,y
	STA.w $7A38,x
	STA.w $7902,x
	LDA.w #$0008
	STA.b $18,x
	LDA.w #$F800
	STA.w $7222,x
	LDY.w $77C2,x
	LDA.w DATA_019B19,y
	STA.w $7220,x
	TYA
	STA.w $7400,x
CODE_019BA3:
	RTS

;---------------------------------------------------------------------------

CODE_019BA4:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_019BF8
	LDA.b $16,x
	BEQ.b CODE_019BBD
	STZ.b $16,x
	LDY.b #$02
	STY.b $78,x
	STZ.w $105E
	LDA.w #$0008
	STA.b $18,x
	RTS

CODE_019BBD:
	LDA.w $7A36,x
	BNE.b CODE_019BF8
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_019BF8
	LDA.w $106E
	ORA.w #$FF00
	STA.w $106E
	STZ.w $107A
	LDY.w $107C
	STY.w $107E
	LDA.w #$0040
	STA.w $7A96,x
	LDA.w #$0080
	STA.w $7A98,x
	LDY.b $76,x
	CPY.b #$28
	BEQ.b CODE_019BF4
	STZ.w $60AC
	STZ.w $0B7B
CODE_019BF4:
	LDY.b #$01
	STY.b $76,x
CODE_019BF8:
	RTS

;---------------------------------------------------------------------------

CODE_019BF9:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019C23
	LDY.b $76,x
	CPY.b #$29
	BEQ.b CODE_019C19
	LDY.b #$27
	STY.b $78,x
	LDY.b #$15
	STY.w $105E
	LDA.w #$0001
	STA.w $7A36,x
	LDA.w #$0040
	BRA.b CODE_019C1E

CODE_019C19:
	STZ.b $16,x
	LDA.w #$0020
CODE_019C1E:
	STA.w $7A96,x
	INC.b $76,x
CODE_019C23:
	LDA.w $1078
	SEC
	SBC.w #$0008
	CMP.w #$00C0
	BMI.b CODE_019C4C
	STA.w $1078
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0012
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.w $7720,x
CODE_019C4C:
	RTS

;---------------------------------------------------------------------------

DATA_019C4D:
	dw $FC00,$0400

CODE_019C51:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_019CC8
	LDA.w $1078
	CLC
	ADC.w #$0008
	CMP.w #$0101
	BMI.b CODE_019CAB
	STZ.w $60AC
	LDY.b #$00
	LDA.w $7680,x
	CMP.w #$0080
	BPL.b CODE_019C72
	INY
	INY
CODE_019C72:
	LDA.w DATA_019C4D,y
	STA.w $60A8
	STA.w $60B4
	LDA.w #$FA00
	STA.w $60AA
	LDA.w #$0006
	STA.w $60C0
	LDA.w #$8001
	STA.w $60D2
	STZ.w $61B4
	LDY.b #$02
	STY.w $1074
	STY.b $16,x
	LDA.w #$0020
	STA.w $7A96,x
	LDY.b #$18
	STY.b $78,x
	LDY.b #$10
	STY.w $105E
	LDY.b #$24
	STY.b $76,x
	RTS

CODE_019CAB:
	STA.w $1078
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0012
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.w $7720,x
CODE_019CC8:
	RTS

;---------------------------------------------------------------------------

CODE_019CC9:
	TYX
	LDA.w $7C16,x
	CMP.w #$00A0
	BPL.b CODE_019CE1
	LDA.w #$0008
	STA.w $7402,x
	STZ.w $7220,x
	INC.w $1015
	INC.b $76,x
	RTS

CODE_019CE1:
	LDA.w $7A98,x
	BNE.b CODE_019CF6
	LDA.w #$0005
	STA.w $7A98,x
	LDA.w $7402,x
	INC
	AND.w #$0007
	STA.w $7402,x
CODE_019CF6:
	RTS

;---------------------------------------------------------------------------

CODE_019CF7:
	TYX
	LDA.w $1015
	BPL.b CODE_019D02
	STZ.w $1015
	INC.b $76,x
CODE_019D02:
	RTS

;---------------------------------------------------------------------------

DATA_019D03:
	dw $0000,$1000

DATA_019D07:
	dw $7000,$7000

DATA_019D0B:
	dw $00B7,$00B8

CODE_019D0F:
	REP.b #$10
	LDA.w #$0800
	STA.b $00
	LDA.w $0C16
	BNE.b CODE_019D61
	LDA.w $0C14
	CMP.w #$0002
	BCC.b CODE_019D2D
	STZ.w $0C18
	SEP.b #$10
	LDX.b $12
	INC.b $76,x
	RTS

CODE_019D2D:
	ASL
	TAY
	LDA.w DATA_019D03,y
	STA.w $0C18
	LDA.w #$6800
	STA.w $0C1A
	LDX.w DATA_019D07,y
	LDA.w DATA_019D0B,y
	JSL.l CODE_00B756
	STA.w $0C16
	INC.w $0C14
	PHA
	SEP.b #$10
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08AA5F>>16
	LDA.w #FXCODE_08AA5F
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	PLA
	ASL
	STA.w $0C16
CODE_019D61:
	SEC
	SBC.w #$0800
	BCS.b CODE_019D6F
	ADC.w #$0800
	STA.b $00
	LDA.w #$0000
CODE_019D6F:
	STA.w $0C16
	LDX.w $0C1A
	TXA
	CLC
	ADC.b $00
	STA.w $0C1A
	LDA.w #$0070
	STA.w $0001
	LDY.w $0C18
	LDA.b $00
	JSL.l CODE_00BF86
	LDA.b $00
	CLC
	ADC.w $0C18
	STA.w $0C18
	SEP.b #$10
	LDX.b $12
	RTS

;---------------------------------------------------------------------------

DATA_019D99:
	db $00,$01,$02,$03,$04,$05,$06,$00
	db $10,$11,$12,$13,$14,$15,$16,$17
	db $20,$21,$22,$23,$24,$25,$26,$27
	db $30,$31,$32,$33,$34,$35,$36,$37
	db $40,$41,$42,$43,$44,$45,$46,$47
	db $00,$51,$52,$53,$54,$55,$56,$00
	db $00,$00,$62,$63,$64,$65,$00,$00

DATA_019DD1:
	db $00,$05 : dl $7E5040

DATA_019DD6:
	db $70,$07,$2B,$07,$01,$49,$00

DATA_019DDD:
	db $70,$11,$00,$2B,$11,$00,$01,$12
	db $00,$00

CODE_019DE7:
	REP.b #$10
	LDA.w $0C18
	CMP.w #$4000
	BCS.b CODE_019E07
	TAY
	ADC.w #$0800
	STA.w $0C18
	LDA.w #$0800
	LDX.w #$0000
	JSL.l CODE_00BF4A
	SEP.b #$10
	LDX.b $12
	RTS

CODE_019E07:
	LDA.w #$0000
	STA.b $00
	LDA.w #DATA_019D99
	STA.b $02
	LDA.w #$0001
	STA.w $0001
	LDA.w #$0007
	STA.b $04
CODE_019E1C:
	LDY.b $00
	TYA
	CLC
	ADC.w #$0080
	STA.b $00
	LDX.b $02
	TXA
	CLC
	ADC.w #$0008
	STA.b $02
	LDA.w #$0008
	JSL.l CODE_00BF16
	DEC.b $04
	BNE.b CODE_019E1C
	SEP.b #$10
	JSR.w CODE_019291
	REP.b #$10
	SEP.b #$20
	LDX.w #$0004
CODE_019E45:
	LDA.w DATA_019DD1,x
	STA.w HDMA[$07].Parameters,x
	DEX
	BPL.b CODE_019E45
	LDX.w #$0009
CODE_019E51:
	LDA.w DATA_019DD6,x
	STA.l $7E5040,x
	LDA.w DATA_019DDD,x
	STA.l $7E51E4,x
	DEX
	BPL.b CODE_019E51
	LDA.b #$C0
	TSB.w $094A
	LDA.b #$0A
	STA.w $011C
	LDA.b #$69
	STA.w $0960
	REP.b #$20
	LDA.w #$0012
	STA.w $0967
	LDA.w #$0100
	STA.w $094F
	STA.w $0955
	STZ.w $0951
	STZ.w $0953
	LDA.w #$0020
	STA.w $0957
	LDA.w #$001C
	STA.w $0959
	LDA.w #$0080
	STA.w $0043
	SEP.b #$10
	LDX.b $12
	LDA.w #$0004
	STA.b $16,x
	LDA.w #$FD00
	STA.w $7222,x
	LDA.w #$000A
	STA.w $7A98,x
	INC.b $76,x
CODE_019EB1:
	RTS

;---------------------------------------------------------------------------

DATA_019EB2:
	db $0F,$0B,$0C,$0D

CODE_019EB6:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_019EB1
	DEC.b $16,x
	BMI.b CODE_019ED2
	LDY.b $16,x
	LDA.w DATA_019EB2,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w #$0004
	STA.w $7A98,x
CODE_019ED1:
	RTS

CODE_019ED2:
	LDA.w $7860,x
	BEQ.b CODE_019ED1
	LDA.w #$6E6C
	STA.w $6FA0,x
	LDA.w #$2041
	STA.w $6FA2,x
	LDA.w #$A902
	STA.w $7040,x
	INC.w $1080
	LDA.w $70E2,x
	SEC
	SBC.w #$0002
	STA.w $70E2,x
	LDA.w $7182,x
	CLC
	ADC.w #$0004
	STA.w $7182,x
	STZ.b $18,x
	STZ.w $7A36,x
	STZ.w $7042,x
	STZ.b $16,x
	LDA.w #$0050
	STA.w $1076
	STA.w $1078
	JSR.w CODE_018AC9
	JSR.w CODE_018AB6
	JSR.w CODE_018AE1
	JSR.w CODE_018B15
	INC.w $0CF9
	LDX.b $12
	INC.w $1070
	LDA.w #$0001
	STA.w $106E
	INC.w $1072
	LDA.w #$FFFE
	STA.w $7720,x
	LDA.w #$FE00
	STA.w $7900,x
	STZ.w $7A38,x
	STZ.w $7A36,x
	LDA.w #$0025
	STA.w $7402,x
	TAY
	STY.b $78,x
	LDY.b #$12
	STY.w $105C
	STY.w $105E
	INC.b $76,x
	PLA
	RTL

;---------------------------------------------------------------------------

CODE_019F57:
	TYX
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_019F79
	LDA.w #$0010
	STA.b $16,x
	STZ.w $7A36,x
	INC.w $105E
	LDA.w #$0018
	STA.b $18,x
	LDA.w #$0087
	JSL.l CODE_0085D2
	INC.b $76,x
CODE_019F79:
	RTS

;---------------------------------------------------------------------------

CODE_019F7A:
	TYX
	LDA.w $7A36,x
	BNE.b CODE_019FB1
	LDA.b $16,x
	BPL.b CODE_019F90
	STZ.w $1072
	LDA.w #$0080
	STA.w $7A96,x
	INC.b $76,x
	RTS

CODE_019F90:
	DEC.b $16,x
	BPL.b CODE_019F9B
	INC.b $78,x
	LDA.w #$0012
	BRA.b CODE_019FA6

CODE_019F9B:
	LDA.b $16,x
	AND.w #$0001
	ASL
	DEC
	CLC
	ADC.w $105E
CODE_019FA6:
	STA.w $105E
	LDA.w #$0018
	STA.b $18,x
	STZ.w $7A36,x
CODE_019FB1:
	LDA.w $1076
	CLC
	ADC.w #$0001
	CMP.w #$0100
	BMI.b CODE_019FC0
	LDA.w #$0100
CODE_019FC0:
	STA.w $1076
	STA.w $1078
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0016
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	SEC
	SBC.w #$0008
	STA.w $7720,x
	RTS

;---------------------------------------------------------------------------

CODE_019FE5:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_01A014
	LDA.w $7A36,x
	BNE.b CODE_01A00F
	LDA.w #$000A
	STA.b $16,x
	INC.w $0B59
	INC.w $105C
	INC.b $76,x
	LDA.w $70E2,x
	STA.b $00
	LDA.w $7182,x
	STA.b $02
	LDA.w #$0340
	JSL.l CODE_02E1A6
	RTS

CODE_01A00F:
	LDA.w #$0008
	STA.b $18,x
CODE_01A014:
	RTS

;---------------------------------------------------------------------------

DATA_01A015:
	dw $0003,$FFFE,$0002,$FFFF,$0001

DATA_01A01F:
	dw $FFFD,$0002,$FFFE,$0001,$FFFF

DATA_01A029:
	dw $0004,$0008,$000E,$0014,$001C,$0020,$0028,$002C

DATA_01A039:
	dw $FFFC,$FFF8,$0000,$FFF0,$FFF4,$0008,$0002,$FFFC

DATA_01A049:
	dw $0000,$0001,$0002,$0001,$0000,$0001,$0000,$0002

DATA_01A059:
	dw $0100,$0480,$0180,$0300,$01C0,$0240,$0080,$0200
	dw $FD00,$FF00,$FE00,$F840,$FD80,$FF80,$FAC0,$FE80

DATA_01A079:
	dw $FA00,$FD80,$FC00,$FF80,$FC80,$FB00,$F780,$FE00
	dw $FB80,$FF00,$F800,$FB00,$FE80,$FD00,$FB80,$FA80

CODE_01A099:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_01A0FD
	LDA.w $7A98,x
	BNE.b CODE_01A0B7
	DEC.b $16,x
	DEC.b $16,x
	BMI.b CODE_01A0FE
	BNE.b CODE_01A0B1
	LDA.w #$0040
	BRA.b CODE_01A0B4

CODE_01A0B1:
	LDA.w #$0020
CODE_01A0B4:
	STA.w $7A98,x
CODE_01A0B7:
	LDA.b $16,x
	BNE.b CODE_01A0C7
	LDA.w $7974
	AND.w #$0001
	BNE.b CODE_01A0FD
	LDY.b #$04
	BRA.b CODE_01A0CB

CODE_01A0C7:
	AND.w #$0002
	TAY
CODE_01A0CB:
	LDA.w DATA_01A015,y
	CLC
	ADC.w $1076
	STA.w $1076
	LDA.w DATA_01A01F,y
	CLC
	ADC.w $1078
	STA.w $1078
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0016
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	SEC
	SBC.w #$0008
	STA.w $7720,x
CODE_01A0FD:
	RTS

CODE_01A0FE:
	LDA.w $70E2,x
	STA.w $1084
	LDA.w $7182,x
	STA.w $1086
	INC.w $1080
	LDA.w #$E0A1
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w #$0010
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	STZ.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STZ.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_088293>>16
	LDA.w #FXCODE_088293
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	LDA.w #$6E6C
	STA.w $6FA0,x
	LDA.w #$2040
	STA.w $6FA2,x
	LDA.w #$3101
	STA.w $7040,x
	LDA.w #$000C
	STA.w $7402,x
	LDA.w #$FB00
	STA.w $7222,x
	LDA.w #$000A
	STA.w $7542,x
	LDA.w #$0020
	STA.w $7042,x
	LDA.w #$001E
CODE_01A169:
	STA.b $00
	TAY
	LDA.w DATA_01A059,y
	STA.b $04
	LDA.w DATA_01A079,y
	STA.b $08
	TYA
	BIT.w #$0010
	BNE.b CODE_01A181
	LDA.w DATA_01A029,y
	BRA.b CODE_01A18C

CODE_01A181:
	AND.w #$000E
	TAY
	LDA.w DATA_01A029,y
	EOR.w #$FFFF
	INC
CODE_01A18C:
	STA.b $02
	LDA.w DATA_01A039,y
	STA.b $06
	LDA.w DATA_01A049,y
	STA.b $0A
	LDA.w #$0223
	JSL.l CODE_008B21
	LDA.w $1084
	CLC
	ADC.b $02
	STA.w $70A2,y
	LDA.w $1086
	CLC
	ADC.b $06
	STA.w $7142,y
	LDA.w #$0080
	STA.w $7782,y
	LDA.b $04
	STA.w $71E0,y
	LDA.b $08
	STA.w $71E2,y
	LDA.w #$0004
	STA.w $7500,y
	LDA.b $0A
	STA.w $73C2,y
	LDA.b $00
	DEC
	DEC
	BPL.b CODE_01A169
	LDA.w #$0047
	JSL.l CODE_0085D2
	INC.b $76,x
	RTS

;---------------------------------------------------------------------------

CODE_01A1DC:
	TYX
	LDY.w $7223,x
	BMI.b CODE_01A225
	LDA.w $7042,x
	BIT.w #$0080
	BNE.b CODE_01A217
	ORA.w #$0080
	STA.w $7042,x
	LDA.w #$0010
	STA.w $7542,x
	LDA.w $6094
	CLC
	ADC.w #$0080
	STA.w $70E2,x
	LDA.w $609C
	SEC
	SBC.w #$0018
	STA.w $7182,x
	LDA.w #$0400
	STA.w $7222,x
	LDA.w #$0082
	JSL.l CODE_0085D2
CODE_01A217:
	LDY.w $7683,x
	DEY
	BMI.b CODE_01A225
	LDA.w #$0060
	STA.w $7A96,x
	INC.b $76,x
CODE_01A225:
	RTS

;---------------------------------------------------------------------------

CODE_01A226:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_01A225
	SEP.b #$20
	LDA.b #$C0
	TRB.w $094A
	REP.b #$20
	LDY.b #$02
	STY.w $011C
	LDA.w #$0011
	STA.w $0967
	STZ.w $7ECC
	PLA
	JML.l CODE_03A32E

;---------------------------------------------------------------------------

CODE_01A248:
	RTL

;---------------------------------------------------------------------------

DATA_01A249:
	dw CODE_01A32D
	dw CODE_01A337
	dw CODE_01A35D
	dw CODE_01A39C
	dw CODE_01A3A9
	dw CODE_01A3E4
	dw CODE_01A494
	dw CODE_01A51F

DATA_01A259:
	dw $0005,$FFFF,$01A0,$0760,$0000,$0000,$0020,$0000
	dw $0002,$FFFF,$00C0,$01A0,$0001,$0003,$0001,$01A0
	dw $7FFF,$0004,$0001,$0006,$FFFF,$02B0,$07D0,$0005
	dw $0002,$FFFF,$00C0,$02B0,$0001,$0003,$0001,$02B0
	dw $02F0,$0000,$0002,$0000,$0001,$FFFF,$0080,$0000
	dw $0020,$0000,$0007,$FFFF,$0000,$0000,$0001,$0100
	dw $0000,$0020,$0000,$0001,$FFFF,$0020,$0004,$0001
	dw $0020,$00B0

DATA_01A2CD:
	db $06,$06,$0A,$08,$04,$0A,$0A,$06

CODE_01A2D5:
	JSL.l CODE_03AF23
	LDA.w $7A96,x
	BNE.b CODE_01A324
	STZ.w $617A
	STZ.w $617C
	LDA.b $18,x
	CMP.w $7902,x
	BNE.b CODE_01A2F5
	LDA.w #$0000
	STA.w $60AC
	JML.l CODE_03A31E

CODE_01A2F5:
	REP.b #$10
	LDY.b $18,x
	LDA.w DATA_01A259,y
	STA.b $76,x
	LDA.w DATA_01A259+$04,y
	STA.b $78,x
	LDA.w DATA_01A259+$06,y
	STA.w $7A36,x
	LDA.w DATA_01A259+$08,y
	STA.w $7A38,x
	LDA.w DATA_01A259+$02,y
	STA.w $7A96,x
	LDY.b $76,x
	LDA.w DATA_01A2CD,y
	AND.w #$00FF
	CLC
	ADC.b $18,x
	STA.b $18,x
	SEP.b #$10
CODE_01A324:
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_01A249,x)
	RTL

CODE_01A32D:
	TYX
	LDA.b $78,x
	STA.w $617A
	STA.w $617C
	RTS

CODE_01A337:
	TYX
	STY.w $0C1E
	LDA.w #$0002
	STA.w $60AC
	LDA.w $60B0
	CMP.b $78,x
	BNE.b CODE_01A34C
	STZ.w $7A96,x
	RTS

CODE_01A34C:
	BPL.b CODE_01A353
	DEC.w $0039
	BRA.b CODE_01A356

CODE_01A353:
	INC.w $0039
CODE_01A356:
	LDA.w $0039
	STA.w $0C23
	RTS

CODE_01A35D:
	TYX
	STY.w $0C1E
	LDA.w $7900,x
	CLC
	ADC.b $78,x
CODE_01A367:
	CMP.w #$0100
	BMI.b CODE_01A392
	SEC
	SBC.w #$0100
	PHA
	LDA.w $0039
	SEC
	SBC.w $7A36,x
	EOR.w $7A38,x
	BMI.b CODE_01A385
	PLA
	STZ.w $7A96,x
	STZ.w $0C1E
	RTS

CODE_01A385:
	LDA.w $0039
	CLC
	ADC.w $7A38,x
	STA.w $0039
	PLA
	BRA.b CODE_01A367

CODE_01A392:
	STA.w $7900,x
	LDA.w $0039
	STA.w $0C23
	RTS

CODE_01A39C:
	TYX
	LDA.b $78,x
	STA.w $7E18
	LDA.w $7A36,x
	STA.w $7E1A
CODE_01A3A8:
	RTS

CODE_01A3A9:
	TYX
	INC.w $105A
	PLA
	JML.l CODE_03A31E

DATA_01A3B2:
	dw $0020,$0000,$001F,$0020,$0020

DATA_01A3BC:
	dw $015C,$015A,$015B,$015C,$015C

DATA_01A3C6:
	dw $0000,$0010,$FFF0,$0010,$FFF0

DATA_01A3D0:
	dw $0000,$0000,$0010,$0000,$0010

DATA_01A3DA:
	dw $0001,$0000,$0001,$0001,$0001

CODE_01A3E4:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_01A3A8
	LDY.w $7A38,x
	LDA.w DATA_01A3B2,y
	STA.w $7A98,x
	LDA.w DATA_01A3DA,y
	PHP
	LDA.w $7A36,x
	STA.w $0093
	CLC
	ADC.w DATA_01A3D0,y
	STA.w $7A36,x
	LDA.b $78,x
	STA.w $0091
	CLC
	ADC.w DATA_01A3C6,y
	STA.b $78,x
	LDA.w DATA_01A3BC,y
	STA.w $0095
	LDA.w #$0001
	STA.w $008F
	JSL.l CODE_109295
	LDX.b $12
	LDA.w $7A36,x
	CMP.w #$07B0
	BNE.b CODE_01A433
	LDA.b $78,x
	CMP.w #$01A0
	BNE.b CODE_01A433
	STZ.w $7A96,x
CODE_01A433:
	LDA.w $7A38,x
	INC
	INC
	CMP.w #$000A
	BMI.b CODE_01A440
	LDA.w #$0000
CODE_01A440:
	STA.w $7A38,x
	PLP
	BEQ.b CODE_01A477
	LDA.w #$0047
	JSL.l CODE_0085D2
	LDA.w #$01E6
	JSL.l CODE_008B21
	LDA.w $0091
	CLC
	ADC.w #$0008
	STA.w $70A2,y
	LDA.w $0093
	CLC
	ADC.w #$0008
	STA.w $7142,y
	LDA.w #$0004
	STA.w $7782,y
	LDA.w #$0006
	STA.w $73C2,y
	STA.w $7E4C,y
CODE_01A477:
	RTS

DATA_01A478:
	db $78,$79,$79,$79,$7A,$79,$7B,$79
	db $00,$00,$3C,$79,$3D,$79,$3E,$79
	db $3F,$79,$40,$79,$42,$79,$43,$79
	db $00,$00,$3C,$79

CODE_01A494:
	TYX
	LDA.w $7AF8,x
	BNE.b CODE_01A477
	LDA.w #$0020
	STA.w $7AF8,x
	LDA.w #$0047
	JSL.l CODE_0085D2
	LDA.b $78,x
	STA.w $0091
	STA.b $04
	LDA.w $7A36,x
	STA.w $0093
	LDA.w #$0001
	STA.w $008F
	LDA.w #$0006
	SEC
	SBC.w $7A38,x
	ASL
	ASL
	CLC
	ADC.w #$0008
	STA.b $00
	STA.b $02
CODE_01A4CB:
	LDA.b $02
	SEC
	SBC.b $00
	TAY
	LDA.w DATA_01A478,y
	STA.w $0095
	JSL.l CODE_109295
	LDA.w $0091
	CLC
	ADC.w #$0010
	STA.w $0091
	LDA.b $00
	AND.w #$0002
	BEQ.b CODE_01A4FB
	LDA.b $04
	STA.w $0091
	LDA.w $0093
	CLC
	ADC.w #$0010
	STA.w $0093
CODE_01A4FB:
	DEC.b $00
	DEC.b $00
	BNE.b CODE_01A4CB
	LDX.b $12
	LDA.w $7A36,x
	SEC
	SBC.w #$0010
	STA.w $7A36,x
	DEC.w $7A38,x
	BNE.b CODE_01A51E
	STZ.w $60A8
	STZ.w $60B4
	STZ.w $7A96,x
	INC.w $105A
CODE_01A51E:
	RTS

CODE_01A51F:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_01A51E
	LDA.b $78,x
	BNE.b CODE_01A541
	LDA.w #$0003
	STA.w $7900,x
	LDA.w $0039
	AND.w #$FFE0
	STA.b $78,x
	LDA.w $003B
	CLC
	ADC.w #$00B0
	STA.w $7A36,x
CODE_01A541:
	LDA.b $78,x
	STA.w $0091
	LDA.w $7A36,x
	STA.w $0093
	LDA.w #$0001
	STA.w $008F
	LDA.w #$0000
	STA.w $0095
	JSL.l CODE_109295
	LDA.w $0093
	CLC
	ADC.w #$0010
	STA.w $0093
	JSL.l CODE_109295
	LDA.w $0091
	CLC
	ADC.w #$0010
	STA.w $0091
	JSL.l CODE_109295
	LDA.w $0093
	SEC
	SBC.w #$0010
	STA.w $0093
	JSL.l CODE_109295
	LDX.b $12
	LDA.w #$020C
	JSL.l CODE_008B21
	LDA.b $78,x
	STA.w $70A2,y
	LDA.w $7A36,x
	STA.w $7142,y
	LDA.w #$0002
	STA.w $7782,y
	LDA.w #$000D
	STA.w $73C2,y
	LDA.w #$0036
	STA.w $7002,y
	LDA.w #$0047
	JSL.l CODE_0085D2
	DEC.w $7900,x
	BNE.b CODE_01A5BC
	STZ.w $7A96,x
	RTS

CODE_01A5BC:
	LDA.w #$0010
	STA.w $7A98,x
	ASL
	CLC
	ADC.b $78,x
	STA.b $78,x
	RTS

;---------------------------------------------------------------------------

CODE_01A5C9:
	LDA.w $7900,x
	CMP.w $7902,x
	BNE.b CODE_01A5DF
	DEC.w $7900,x
	STA.b $76,x
	LDA.w #$0002
	STA.w $7A98,x
	INC.w $7402,x
CODE_01A5DF:
	RTL

;---------------------------------------------------------------------------

DATA_01A5E0:
	dw CODE_01A830
	dw CODE_01A889
	dw CODE_01A8C0
	dw CODE_01A8F2
	dw CODE_01AA1F
	dw CODE_01AA6B

CODE_01A5EC:
	JSL.l CODE_01A60B
	JSR.w CODE_01A740
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_01A5E0,x)
	LDA.w #$0620
	LDY.b $76,x
	CPY.b #$02
	BMI.b CODE_01A607
	LDA.w #$0660
CODE_01A607:
	STA.w $6FA0,x
	RTL

CODE_01A60B:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BEQ.b CODE_01A619
	PLY
	PLA
	RTL

CODE_01A619:
	LDA.w $6FA2,x
	AND.w #$FFE1
	LDY.w $7D38,x
	BNE.b CODE_01A62D
	ORA.w #$0008
	STA.w $6FA2,x
	JMP.w CODE_01A715

CODE_01A62D:
	STA.w $6FA2,x
	STZ.b $0E
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_099011>>16
	LDA.w #FXCODE_099011
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
CODE_01A63F:
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	BMI.b CODE_01A6A0
	BEQ.b CODE_01A6A0
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_01A6B9
	LDA.w $6FA2,y
	AND.w #$0800
	BEQ.b CODE_01A6A0
	LDA.w $7360,y
	CMP.w #$0109
	BEQ.b CODE_01A6A0
	CMP.w #$010A
	BEQ.b CODE_01A6A0
	CMP.w #$010B
	BEQ.b CODE_01A6A0
	PHY
	TYX
	JSL.l CODE_03B24B
	PLY
	LDA.w #$0000
	STA.w $7540,y
	LDA.w #$FE00
	STA.w $7222,y
	INC.b $0E
	LDX.b $12
	LDA.w #$0040
	STA.w $7542,y
	LDA.w $7220,x
	CMP.w #$8000
	ROR
	STA.w $7220,y
	JSL.l CODE_03B53D
	LDX.b #$09
	LDA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	BRA.b CODE_01A63F

CODE_01A6A0:
	LDY.b $0E
	BEQ.b CODE_01A6B9
CODE_01A6A4:
	TXY
	LDA.w $7360,x
	JSL.l CODE_03A377
	LDA.w #$9A6C
	STA.b $00
	LDA.w #$0003
	STA.b $02
	JMP.w [$7960]

CODE_01A6B9:
	LDA.w $7860,x
	AND.w #$000C
	BEQ.b CODE_01A6C9
	INC.w $7900,x
	INC.w $7902,x
	BRA.b CODE_01A6A4

CODE_01A6C9:
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_01A6F7
	JSL.l CODE_03A590
	LDA.b $18,x
	CMP.w #$0002
	BCC.b CODE_01A6E9
	LDA.w $7220,x
	BNE.b CODE_01A6EB
	LDA.w $7A96,x
	BEQ.b CODE_01A6A4
	PLY
	PLA
	RTL

CODE_01A6E9:
	INC.b $18,x
CODE_01A6EB:
	LDA.w #$FD80
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
CODE_01A6F7:
	LDA.w $7A98,x
	AND.w #$0003
	BNE.b CODE_01A712
	LDA.w #$0004
	STA.w $7A98,x
	LDA.w $7402,x
	INC
	AND.w #$0003
	ORA.w #$0004
	STA.w $7402,x
CODE_01A712:
	PLY
	PLA
CODE_01A714:
	RTL

CODE_01A715:
	LDA.w $6F00,x
	CMP.w #$0010
	BEQ.b CODE_01A714
	CMP.w #$0008
	BNE.b CODE_01A73D
	LDY.w $74A2,x
	BPL.b CODE_01A73D
	LDA.w $6FA2,x
	AND.w #$FCFF
	STA.w $6FA2,x
	LDA.w #$0002
	STA.w $7900,x
	STA.w $7902,x
	ASL
	STA.w $7402,x
CODE_01A73D:
	PLY
	PLA
	RTL

CODE_01A740:
	LDY.w $7402,x
	CPY.b #$04
	BPL.b CODE_01A7A0
	LDY.w $7D36,x
	BPL.b CODE_01A7A1
	LDY.b $76,x
	CPY.b #$03
	BPL.b CODE_01A7A0
	LDA.w $7C18,x
	SEC
	SBC.w $6122
	SEC
	SBC.w $7BB8,x
	CMP.w #$FFF8
	BCC.b CODE_01A79C
	LDY.w $60C0
	BEQ.b CODE_01A7A0
	LDY.w $60AB
	BMI.b CODE_01A7A0
	STZ.w $60A8
	STZ.w $60B4
	STZ.w $60AA
	STZ.w $60D4
	INC.w $61B4
	LDA.w $7182,x
	CLC
	ADC.w #$FFE8
	STA.w $6090
	INC.w $7A36,x
CODE_01A788:
	STZ.b $16,x
	STZ.w $7220,x
	STZ.w $7A98,x
	LDY.b #$03
	STY.b $76,x
	LDA.w #$005F
	JSL.l CODE_0085D2
	RTS

CODE_01A79C:
	JSL.l CODE_03A858
CODE_01A7A0:
	RTS

CODE_01A7A1:
	BEQ.b CODE_01A7A0
	LDA.w $7AF6,x
	BNE.b CODE_01A7A0
	LDA.w $7D37,y
	BEQ.b CODE_01A7A0
	LDA.w $7541,y
	CMP.w #$0040
	BMI.b CODE_01A788
	LDA.b $76,x
	CMP.w #$0001
	BEQ.b CODE_01A7DA
	CMP.w #$0003
	BEQ.b CODE_01A7DA
	LDA.w #$0001
	STA.b $76,x
	STZ.w $7402,x
	STZ.b $16,x
	LDA.w #$0003
	STA.w $7A98,x
	PHY
	LDA.w #$0013
	JSL.l CODE_0085D2
	PLY
CODE_01A7DA:
	LDA.w #$0040
	STA.w $7A96,x
	LDA.w #$FE00
	STA.w $7221,y
	LDA.w $721F,y
	CLC
	ADC.w #$0080
	CMP.w #$0100
	BCS.b CODE_01A812
	LDA.w #$0010
	STA.w $7A96,x
	ASL
	STA.w $7AF6,x
	LDA.w #$FC00
	STA.w $7221,y
	LDA.w $7400,x
	DEC
	PHP
	LDA.w #$FE00
	PLP
	BPL.b CODE_01A819
	LDA.w #$0200
	BRA.b CODE_01A819

CODE_01A812:
	LDA.w $721F,y
	EOR.w #$FFFF
	INC
CODE_01A819:
	STA.w $721F,y
	STZ.w $7220,x
	RTS

;---------------------------------------------------------------------------

DATA_01A820:
	dw $FFC0,$0040

DATA_01A824:
	db $00,$01,$02,$03,$02,$01

DATA_01A82A:
	db $08,$06,$06,$08,$06,$06

CODE_01A830:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_01A862
	LDY.w $7400,x
	LDA.w DATA_01A820,y
	STA.w $7220,x
	LDA.w $7A98,x
	BNE.b CODE_01A862
	INC.b $16,x
	LDY.b $16,x
	CPY.b #$06
	BMI.b CODE_01A850
	STZ.b $16,x
	LDY.b #$00
CODE_01A850:
	LDA.w DATA_01A824,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w DATA_01A82A,y
	AND.w #$00FF
	STA.w $7A98,x
CODE_01A862:
	RTS

;---------------------------------------------------------------------------

DATA_01A863:
	db $01,$02,$03,$02,$01,$00,$01,$02
	db $03,$02,$01,$02,$03,$02,$01,$02
	db $03,$02,$01

DATA_01A876:
	db $03,$03,$03,$03,$03,$03,$03,$03
	db $04,$04,$04,$04,$04,$06,$06,$06
	db $10,$06,$06

CODE_01A889:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_01A8B7
	INC.b $16,x
	LDY.b $16,x
	CPY.b #$14
	BMI.b CODE_01A8A5
CODE_01A897:
	STZ.w $7402,x
	STZ.b $16,x
	LDA.w #$0008
	STA.w $7A98,x
	STZ.b $76,x
	RTS

CODE_01A8A5:
	LDA.w DATA_01A863-$01,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w DATA_01A876-$01,y
	AND.w #$00FF
	STA.w $7A98,x
CODE_01A8B7:
	RTS

;---------------------------------------------------------------------------

DATA_01A8B8:
	db $02,$03,$02,$01

DATA_01A8BC:
	db $02,$10,$06,$06

CODE_01A8C0:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_01A8E0
	INC.b $16,x
	LDY.b $16,x
	CPY.b #$05
	BPL.b CODE_01A897
	LDA.w DATA_01A8B8-$01,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w DATA_01A8BC-$01,y
	AND.w #$00FF
	STA.w $7A98,x
CODE_01A8E0:
	RTS

;---------------------------------------------------------------------------

DATA_01A8E1:
	db $0C,$0B,$08,$09,$0A,$09,$08

DATA_01A8E8:
	db $04,$02,$04,$04,$04,$04,$60

DATA_01A8EF:
	db $08,$0A,$0C

CODE_01A8F2:
	TYX
	LDA.w $7A98,x
	BEQ.b CODE_01A8FB
	JMP.w CODE_01A9F2

CODE_01A8FB:
	INC.b $16,x
	LDY.b $16,x
	CPY.b #$03
	BEQ.b CODE_01A906
	JMP.w CODE_01A9C8

CODE_01A906:
	LDA.w #$01F4
	JSL.l CODE_008B21
	LDA.w #$0008
	STA.w $73C2,y
	CLC
	ADC.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	CLC
	ADC.w #$0004
	STA.w $7142,y
	LDA.w #$0002
	STA.w $7782,y
	LDA.b $10
	STA.b $06
	XBA
	STA.b $08
	LDA.w $70E2,x
	STA.b $0A
	LDA.w $7182,x
	STA.b $0C
	LDY.b #$03
CODE_01A93D:
	PHY
	LDA.w #$0112
	JSL.l CODE_03A364
	BCC.b CODE_01A9C3
	LDA.b $06
	AND.w #$003F
	SEC
	SBC.w #$001C
	STA.b $04
	CLC
	ADC.b $0A
	STA.w $70E2,y
	CLC
	ADC.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.b $08
	AND.w #$001F
	EOR.w #$FFFF
	SEC
	SBC.w #$0003
	STA.b $02
	CLC
	ADC.b $0C
	STA.w $7182,y
	CLC
	ADC.w #$0008
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	PHY
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDX.b $12
	PLY
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$0000
	BNE.b CODE_01A998
	TYX
	JSL.l CODE_03A31E
	LDX.b $12
	BRA.b CODE_01A9A5

CODE_01A998:
	LDA.b $06
	XBA
	AND.w #$001F
	CLC
	ADC.w #$0050
	STA.w $7A96,y
CODE_01A9A5:
	LDA.b $06
	EOR.w #$FFFF
	ROR
	ROR
	ROR
	ROR
	INC
	STA.b $06
	LDA.b $08
	ROR
	ROR
	ROR
	EOR.w #$FFFF
	DEC
	STA.b $08
	PLY
	DEY
	BEQ.b CODE_01A9C4
	JMP.w CODE_01A93D

CODE_01A9C3:
	PLY
CODE_01A9C4:
	LDY.b $16,x
	BRA.b CODE_01A9E0

CODE_01A9C8:
	CPY.b #$08
	BMI.b CODE_01A9E0
	LDA.w #$0009
	STA.w $7402,x
	LDA.w #$0004
	STA.w $7A98,x
	INC
	STA.b $78,x
	STZ.b $16,x
	INC.b $76,x
	RTS

CODE_01A9E0:
	LDA.w DATA_01A8E1-$01,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w DATA_01A8E8-$01,y
	AND.w #$00FF
	STA.w $7A98,x
CODE_01A9F2:
	LDA.w $7A36,x
	BEQ.b CODE_01AA1A
	LDY.b $16,x
	CPY.b #$03
	BPL.b CODE_01AA1A
	LDA.w DATA_01A8EF,y
	AND.w #$00FF
	SEC
	SBC.w #$0020
	CLC
	ADC.w $7182,x
	STA.w $6090
	STZ.w $60A8
	STZ.w $60B4
	STZ.w $60AA
	INC.w $61B4
CODE_01AA1A:
	RTS

;---------------------------------------------------------------------------

DATA_01AA1B:
	db $09,$0A,$09,$08

CODE_01AA1F:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_01AA5C
	INC.b $16,x
	LDY.b $16,x
	CPY.b #$04
	BMI.b CODE_01AA4D
	LDA.w #$0003
	JSL.l CODE_0085D2
	STZ.b $16,x
	LDY.b #$00
	DEC.b $78,x
	BNE.b CODE_01AA4D
	LDA.w #$000B
	STA.w $7402,x
	LDA.w #$0003
	STA.w $7A98,x
	STA.b $16,x
	INC.b $76,x
	RTS

CODE_01AA4D:
	LDA.w DATA_01AA1B,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w #$0004
	STA.w $7A98,x
CODE_01AA5C:
	RTS

;---------------------------------------------------------------------------

DATA_01AA5D:
	db $0C,$00,$0D,$0E,$0F,$10,$0F,$0E
	db $0D,$00,$02,$03,$02,$01

CODE_01AA6B:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_01AA9C
	INC.b $16,x
	LDY.b $16,x
	CPY.b #$0F
	BMI.b CODE_01AA8D
	STZ.w $7402,x
	STZ.b $16,x
	LDA.w #$0040
	STA.w $7A96,x
	LDA.w #$0043
	STA.w $7A98,x
	STZ.b $76,x
	RTS

CODE_01AA8D:
	LDA.w DATA_01AA5D-$01,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w #$0003
	STA.w $7A98,x
CODE_01AA9C:
	RTS

;---------------------------------------------------------------------------

CODE_01AA9D:
	RTL

;---------------------------------------------------------------------------

CODE_01AA9E:
	JSL.l CODE_03AF23
	LDY.b $76,x
	BNE.b CODE_01AAA9
	INC.b $76,x
CODE_01AAA8:
	RTL

CODE_01AAA9:
	LDA.w $7A96,x
	BNE.b CODE_01AAD5
	LDY.b $18,x
	BNE.b CODE_01AAC0
	LDA.w #$0020
	STA.w $7542,x
	LDA.w #$0008
	STA.w $7A98,x
	INC.b $18,x
CODE_01AAC0:
	LDA.w $7A98,x
	BNE.b CODE_01AAD5
	LDA.w #$0008
	STA.w $7A98,x
	LDY.w $7402,x
	CPY.b #$02
	BPL.b CODE_01AAD5
	INC.w $7402,x
CODE_01AAD5:
	LDA.w #$0006
	STA.w $74A2,x
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_01AAA8
	JML.l CODE_03A31E

;---------------------------------------------------------------------------

CODE_01AAE7:
	RTL

;---------------------------------------------------------------------------

DATA_01AAE8:
	dw CODE_01AB6A
	dw CODE_01AC06

CODE_01AAEC:
	LDA.w $7040,x
	LSR
	BCC.b CODE_01AAF6
	JSL.l CODE_03AA52
CODE_01AAF6:
	JSL.l CODE_03AF23
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_01AAE8,x)
	JSR.w CODE_01AB13
	LDY.w $7D36,x
	BPL.b CODE_01AB0E
	JSL.l CODE_03A858
CODE_01AB0E:
	RTL

;---------------------------------------------------------------------------

DATA_01AB0F:
	dw $E000,$E020

CODE_01AB13:
	LDA.w $7040,x
	LSR
	BCC.b CODE_01AB61
	TXA
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #$0C00
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.b $18,x
	LDA.w DATA_01AB0F,y
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w #$0010
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	ASL
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_08D964>>16
	LDA.w #FXCODE_08D964
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	INC.w $0CF9
CODE_01AB61:
	RTS

;---------------------------------------------------------------------------

DATA_01AB62:
	dw $FE80,$0180,$0010,$FFF8

CODE_01AB6A:
	TYX
	LDY.w $7400,x
	LDA.w DATA_01AB62,y
	STA.w $75E0,x
	LDA.w #$0020
	STA.w $7540,x
	LDY.w $7AF8,x
	BNE.b CODE_01ABC1
	LDA.w $7C16,x
	CLC
	ADC.w #$0020
	CMP.w #$0040
	BCS.b CODE_01ABC1
	LDA.w $7C18,x
	CLC
	ADC.w #$0040
	CMP.w #$0080
	BCS.b CODE_01ABC1
	JSL.l CODE_03AD74
	BCC.b CODE_01ABC1
	LDA.w #$7C60
	STA.w $6FA0,x
	LDA.w #$2175
	STA.w $7040,x
	STZ.w $7402,x
	LDA.w #$0080
	STA.w $7A36,x
	STZ.w $7220,x
	STZ.w $7540,x
	LDA.w #$0040
	STA.w $7A96,x
	INC.b $76,x
	RTS

CODE_01ABC1:
	LDY.w $7A98,x
	BNE.b CODE_01ABD5
	LDA.w #$0004
	STA.w $7A98,x
	LDA.w $7402,x
	EOR.w #$0001
	STA.w $7402,x
CODE_01ABD5:
	LDY.w $7AF6,x
	BNE.b CODE_01AC05
	LDA.w #$0004
	STA.w $7AF6,x
	LDA.w #$01D8
	JSL.l CODE_008B21
	LDA.w $7400,x
	STA.w $73C0,y
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w #$0002
	STA.w $7782,y
	INC
	STA.w $7E4C,y
	ASL
	CLC
	ADC.w $7182,x
	STA.w $7142,y
CODE_01AC05:
	RTS

;---------------------------------------------------------------------------

CODE_01AC06:
	TYX
	LDY.w $77C2,x
	TYA
	STA.w $7400,x
	LDY.w $7D36,x
	DEY
	BMI.b CODE_01AC29
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_01AC29
	LDA.w $7D38,y
	BEQ.b CODE_01AC29
	TYX
	JSL.l CODE_03B25B
	STZ.w $7A96,x
CODE_01AC29:
	LDY.w $7A96,x
	BEQ.b CODE_01AC3F
	LDA.w $7A36,x
	CLC
	ADC.w #$0010
	CMP.w #$0100
	BMI.b CODE_01AC66
	LDA.w #$0100
	BRA.b CODE_01AC66

CODE_01AC3F:
	LDA.w $7A36,x
	SEC
	SBC.w #$0010
	CMP.w #$0080
	BPL.b CODE_01AC66
	LDA.w #$0040
	STA.w $7AF8,x
	STZ.b $76,x
	LDA.w #$7E00
	STA.w $6FA0,x
	LDA.w #$0974
	STA.w $7040,x
	JSL.l CODE_03AEFD
	LDA.w #$0080
CODE_01AC66:
	STA.w $7A36,x
	LDY.w $7A98,x
	BNE.b CODE_01AC79
	LDA.w #$0004
	STA.w $7A98,x
	LSR
	EOR.b $18,x
	STA.b $18,x
CODE_01AC79:
	RTS

;---------------------------------------------------------------------------

DATA_01AC7A:
	dw $FE00,$0200,$FD00,$0300

DATA_01AC82:
	dw $0004,$0006,$0008,$000C

DATA_01AC8A:
	dw $FFD0,$0120

CODE_01AC8E:
	LDA.w $7182,x
	BIT.w #$0010
	BEQ.b CODE_01ACCF
	AND.w #$FFE0
	STA.w $7902,x
	LDA.w $70E2,x
	AND.w #$0010
	LSR
	LSR
	LSR
	TAY
	LDA.w DATA_01AC8A,y
	STA.w $7900,x
	LDA.w #$00FF
	STA.w $74A2,x
	LDA.w #$0060
	STA.w $6FA0,x
	LDA.w #$4000
	STA.w $6FA2,x
	LDA.w #$0002
	STA.w $7040,x
	INC.b $76,x
	LDY.w $0C3A
	BNE.b CODE_01ACCE
	INC.w $0C3A
CODE_01ACCE:
	RTL

CODE_01ACCF:
	LDA.w $70E2,x
	PHA
	SEC
	SBC.w $6094
	STA.b $00
	PLA
	AND.w #$0010
	DEC
	EOR.b $00
	BMI.b CODE_01ACE6
	JML.l CODE_03A31E

CODE_01ACE6:
	LDA.b $10
	AND.w #$0004
	STA.b $00
	LDA.w $70E2,x
	AND.w #$0010
	LSR
	LSR
	LSR
	STA.w $7400,x
CODE_01ACF9:
	ORA.b $00
	TAY
	LDA.w DATA_01AC7A,y
	STA.w $75E0,x
	LDA.b $00
	LSR
	STA.b $78,x
	TAY
	LDA.w DATA_01AC82,y
	STA.w $7540,x
	RTL

;---------------------------------------------------------------------------

CODE_01AD0F:
	dw $FE00,$0200

DATA_01AD13:
	dw $FE00,$0200

CODE_01AD17:
	LDY.w $7D38,x
	BEQ.b CODE_01AD30
	LDA.b $10
	AND.w #$0004
	STA.b $00
	LDA.w $7400,x
	JSL.l CODE_01ACF9
	STZ.w $7D38,x
	STZ.w $75E2,x
CODE_01AD30:
	JSL.l CODE_03AF23
	LDY.b $76,x
	BEQ.b CODE_01AD3B
	JMP.w CODE_01ADC2

CODE_01AD3B:
	LDA.w $7A96,x
	BNE.b CODE_01AD92
	LDY.w $7D36,x
	BPL.b CODE_01AD92
	LDA.w $7C18,x
	SEC
	SBC.w $6122
	SEC
	SBC.w $7BB8,x
	CMP.w #$FFF6
	BCC.b CODE_01AD64
	LDY.w $60AB
	BMI.b CODE_01AD92
	LDY.w $60C0
	BEQ.b CODE_01AD64
	JSL.l CODE_03A5B7
	RTL

CODE_01AD64:
	JSL.l CODE_03A858
	LDA.w $61B2
	BPL.b CODE_01AD92
	AND.w #$0FFF
	STA.w $61B2
	LDA.w #$0040
	STA.w $7A96,x
	ASL
	ASL
	STA.w $614A
	LDY.w $7400,x
	LDA.w DATA_01AD13,y
	CLC
	ADC.w $60A8
	STA.w $60A8
	STA.w $60B4
	JSL.l CODE_06BEC1
CODE_01AD92:
	LDA.w $7A98,x
	BNE.b CODE_01ADA7
	LDA.w #$0006
	STA.w $7A98,x
	LDA.w $7402,x
	INC
	AND.w #$0003
	STA.w $7402,x
CODE_01ADA7:
	LDY.b $78,x
	LDA.w $7680,x
	SEC
	SBC.w #$0040
	CMP.w #$0080
	BCS.b CODE_01ADBB
	TYA
	CLC
	ADC.w #$0004
	TAY
CODE_01ADBB:
	LDA.w DATA_01AC82,y
	STA.w $7540,x
	RTL

CODE_01ADC2:
	LDY.w $0C3A
	BEQ.b CODE_01ADD6
	LDA.w $7682,x
	CLC
	ADC.w #$0040
	CMP.w #$0180
	BCC.b CODE_01ADDA
	STZ.w $0C3A
CODE_01ADD6:
	JML.l CODE_03A31E

CODE_01ADDA:
	LDY.b $18,x
	BEQ.b CODE_01ADEE
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_01ADF3
	LDA.w $7360,y
	CMP.w #$00E6
	BNE.b CODE_01ADF3
CODE_01ADEE:
	LDA.w $7A96,x
	BNE.b CODE_01AE17
CODE_01ADF3:
	LDA.w #$00E6
	JSL.l CODE_03A34C
	BCC.b CODE_01AE17
	LDA.w $6094
	AND.w #$FFEF
	CLC
	ADC.w $7900,x
	STA.w $70E2,y
	LDA.w $7902,x
	STA.w $7182,y
	STY.b $18,x
	LDA.w #$0100
	STA.w $7A96,x
CODE_01AE17:
	RTL

;---------------------------------------------------------------------------

CODE_01AE18:
	RTL

;---------------------------------------------------------------------------

CODE_01AE19:
	LDY.w $7860,x
	BEQ.b CODE_01AE54
CODE_01AE1E:
	LDA.w #$0229
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w $7220,x
	STA.w $71E0,y
	BEQ.b CODE_01AE47
	CMP.w #$8000
	ROR
	EOR.w #$FFFF
	INC
	STA.w $71E0,y
CODE_01AE42:
	LDA.w #$FD80
CODE_01AE47:
	STA.w $71E2,y
	LDA.w #$FFFF
	STA.w $7782,y
	JML.l CODE_03A31E

CODE_01AE54:
	LDA.w $7A38,x
	BEQ.b CODE_01AE71
	LDY.w $7D36,x
	BPL.b CODE_01AE71
	LDA.w $61D6
	BNE.b CODE_01AE71
	JSL.l CODE_03A858
	JSL.l CODE_03B25B
	LDA.w #$0001
	STA.w $03BC
CODE_01AE71:
	JSL.l CODE_03AF23
	RTL

;---------------------------------------------------------------------------

CODE_01AE76:
	LDA.w $70E2,x
	AND.w #$0010
	LSR
	LSR
	LSR
	STA.w $7400,x
	LDA.w #$1885
	STA.w $7040,x
	RTL

;---------------------------------------------------------------------------

DATA_01AE89:
	dw CODE_01AEB9
	dw CODE_01AEDA
	dw CODE_01AEFD
	dw CODE_018000
	dw CODE_01AF10
	dw CODE_01AF49

CODE_01AE95:
	JSL.l CODE_03AF23
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_01AE89,x)
	LDY.b $76,x
	BEQ.b CODE_01AEA9
	CPY.b #$05
	BMI.b CODE_01AEB8
CODE_01AEA9:
	LDA.w $7974
	AND.w #$0003
	BNE.b CODE_01AEB8
	LDA.w #$005A
	JSL.l CODE_0085D2
CODE_01AEB8:
	RTL

CODE_01AEB9:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_01AED2
	LDA.w #$0004
	STA.w $7A98,x
	INC.w $7402,x
	LDY.w $7402,x
	CPY.b #$0C
	BNE.b CODE_01AED2
	STZ.w $7402,x
CODE_01AED2:
	RTS

DATA_01AED3:
	db $04,$03,$02,$01,$01,$01,$01

CODE_01AEDA:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_01AEFC
	INC.w $7402,x
	LDY.w $7402,x
	CPY.b #$14
	BNE.b CODE_01AEF3
	LDA.w #$0010
	STA.w $7402,x
	INC.b $76,x
	RTS

CODE_01AEF3:
	LDA.w DATA_01AED3-$0D,y
	AND.w #$00FF
	STA.w $7A98,x
CODE_01AEFC:
	RTS

CODE_01AEFD:
	TYX
	LDA.w $7402,x
	INC
	AND.w #$0003
	ORA.w #$0010
	STA.w $7402,x
	RTS

DATA_01AF0C:
	db $20,$04,$04,$04

CODE_01AF10:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_01AF3E
	DEC.b $16,x
	BNE.b CODE_01AF2A
	LDA.w #$0008
	STA.w $7A98,x
	LDY.b #$0B
	STY.b $16,x
	STZ.w $7402,x
	INC.b $76,x
	RTS

CODE_01AF2A:
	LDY.b $16,x
	LDA.w DATA_01AF0C-$01,y
	AND.w #$00FF
	STA.w $7A98,x
	LDA.w $7402,x
	EOR.w #$0007
	STA.w $7402,x
CODE_01AF3E:
	RTS

DATA_01AF3F:
	db $04,$05,$06,$07,$08,$08,$08,$08
	db $08,$08

CODE_01AF49:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_01AF6D
	DEC.b $16,x
	BNE.b CODE_01AF5F
	LDA.w #$0004
	STA.w $7A98,x
	STZ.w $7402,x
	STZ.b $76,x
	RTS

CODE_01AF5F:
	LDY.b $16,x
	LDA.w DATA_01AF3F-$01,y
	AND.w #$00FF
	STA.w $7A98,x
	INC.w $7402,x
CODE_01AF6D:
	RTS

;---------------------------------------------------------------------------

CODE_01AF6E:
	JSL.l CODE_00831C
	REP.b #$20
	LDA.w #$4000
	STA.w $61BC
	STZ.w $7E04
	SEP.b #$20
	RTL

;---------------------------------------------------------------------------

DATA_01AF80:
	db $04,$06,$08,$0A,$0C,$0E,$10,$12
	db $14,$16,$18,$1A,$1C,$1E,$20,$22

CODE_01AF90:
	JSL.l CODE_008277
	JSL.l CODE_01AF6E
	JSL.l CODE_0394B8
	LDA.w $038C
	BEQ.b CODE_01AFA4
	JMP.w CODE_01B01B

CODE_01AFA4:
	REP.b #$20
	LDY.b #$00
	STZ.b $21
	LDA.w #$0392
	STA.b $20
	LDA.w #$022E
	JSL.l CODE_0082AB
	SEP.b #$20
	REP.b #$30
	STZ.w $7E06
	LDX.w #$003E
CODE_01AFC0:
	STZ.w $03C0,x
	STZ.w $0400,x
	STZ.w $0440,x
	STZ.w $0480,x
	STZ.w $04C0,x
	STZ.w $0500,x
	STZ.w $0540,x
	STZ.w $0580,x
	DEX
	DEX
	BPL.b CODE_01AFC0
	LDA.w #$0064
	STA.w $03B6
	STZ.w $03A5
	STZ.w $03A3
	LDA.w #$0001
	STA.w $03A1
	LDA.w $021A
	ASL
	TAX
	LDA.l DATA_17F3E7,x
	TAX
	LDA.l DATA_17F471+$01,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	STA.w $608C
	LDA.l DATA_17F471+$02,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	STA.w $6090
	LDA.l DATA_17F471,x
	JMP.w CODE_01B084

CODE_01B01B:
	REP.b #$30
	STZ.w $0396
	LDA.w $038C
	DEC
	BEQ.b CODE_01B029
	JMP.w CODE_01B0AD

CODE_01B029:
	LDX.w $038E
	LDA.l $7F7E00,x
	AND.w #$00FF
	CMP.w #$00DE
	BCC.b CODE_01B05A
	SBC.w #$00DE
	ASL
	STA.w $03A7
	LDA.l $7F7E03,x
	AND.w #$00FF
	STA.w $0374
	LDA.l $7F7E01,x
	STA.w $0375
	LDA.w $03B6
	STA.w $0377
	JML.l CODE_118000

CODE_01B05A:
	LDA.l $7F7E01,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	STA.w $608C
	LDA.l $7F7E02,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	STA.w $6090
	LDA.l $7F7E03,x
	AND.w #$00FF
	STA.w $60AC
	LDA.l $7F7E00,x
CODE_01B084:
	AND.w #$00FF
	ASL
	STA.b $00
	ASL
	ADC.b $00
	TAX
	LDA.l DATA_17F7C3,x
	STA.b $32
	LDA.l DATA_17F7C3+$01,x
	STA.b $33
	LDA.l DATA_17F7C3+$03,x
	STA.l $702600
	LDA.l DATA_17F7C3+$05,x
	AND.w #$00FF
	STA.l $702602
CODE_01B0AD:
	STZ.w $0385
	SEP.b #$30
	JSL.l CODE_108B15
	REP.b #$20
	LDA.w #$07B0
	LDX.w $013E
	CPX.b #$13
	BEQ.b CODE_01B0C9
	CPX.b #$1D
	BNE.b CODE_01B0CC
	LDA.w #$0700
CODE_01B0C9:
	STA.w $61BC
CODE_01B0CC:
	SEP.b #$20
	LDA.w $021A
	CMP.b #$0B
	BNE.b CODE_01B0DA
	LDA.b #$11
	STA.w $014E
CODE_01B0DA:
	JSL.l CODE_008546
	LDA.w $0146
	CMP.b #$09
	BNE.b CODE_01B0EA
	JSR.w CODE_01B335
	BRA.b CODE_01B118

CODE_01B0EA:
	CMP.b #$0A
	BNE.b CODE_01B0F8
	JSL.l CODE_00B4D3
	JSL.l CODE_00BB90
	BRA.b CODE_01B118

CODE_01B0F8:
	JSL.l CODE_00B339
	JSL.l CODE_00D571&$00FFFF
	LDA.w $0136
	CMP.b #$03
	BNE.b CODE_01B10A
	JSR.w CODE_01B4A3
CODE_01B10A:
	JSL.l CODE_00BA24
	LDY.w $0146
	LDX.w DATA_01AF80,y
	JSL.l CODE_00BDA2
CODE_01B118:
	JSL.l CODE_01D5B3
	LDA.w $0146
	CMP.b #$09
	BEQ.b CODE_01B12D
	CMP.b #$0A
	BEQ.b CODE_01B12D
	JSR.w CODE_01E80A
	JSR.w CODE_01E9F5
CODE_01B12D:
	JSL.l CODE_00BE26
	LDA.w $038C
	BEQ.b CODE_01B139
	JMP.w CODE_01B1F3

CODE_01B139:
	LDA.b #$0F
	STA.w $0200
	LDA.b #$01
	STA.w $0201
	JSL.l CODE_108FD6
	LDX.b #$7F
CODE_01B149:
	STZ.w $6CAA,x
	DEX
	BPL.b CODE_01B149
	REP.b #$20
	LDA.w $608C
	SEC
	SBC.w #$0090
	STA.w $608C
	CLC
	ADC.w #$0018
	STA.w $6094
	LDA.w $6090
	SEC
	SBC.w #$0094
	STA.w $609C
	INC.w $60C0
	JSL.l CODE_04DC28
	REP.b #$20
	LDA.w #$0006
	STA.w $60C0
	LDA.w #$0280
	STA.w $60B4
	LDA.w #$FC00
	STA.w $60AA
	LDA.w #$0016
	STA.w $60AC
	SEP.b #$20
	JSL.l CODE_01B27B
	LDA.b #$01
	STA.w $0B54
	REP.b #$20
	LDA.w #$0002
	STA.w $0121
	LDA.w #$0120
	STA.w $0B4C
	JSL.l CODE_108F49
	LDA.b #$03
	STA.b $4D
	LDA.b #$02
	STA.w $0125
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$D8
	STA.w !REGISTER_VCountTimerLo
	LDA.b #$B1
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	JSL.l CODE_108B61
	REP.b #$20
CODE_01B1C8:
	LDA.w $0D23
	CMP.w #$00C0
	BCC.b CODE_01B1C8
	LDA.w #$7FFF
	STA.l $702104
	SEP.b #$20
	STZ.w $0121
	REP.b #$20
	LDA.b $3B
	STA.w $60A6
	LDA.b $39
	SEC
	SBC.w #$0100
	STA.w $60A4
	SEP.b #$20
	INC.w $0118
	BRA.b CODE_01B22F

CODE_01B1F3:
	DEC
	BNE.b CODE_01B1FA
	JSL.l CODE_108B61
CODE_01B1FA:
	JSL.l CODE_04DB68
	JSL.l CODE_03954E
	LDA.w $7E1A
	CMP.b #$0F
	BEQ.b CODE_01B211
	JSL.l CODE_04DCC4
	JSL.l CODE_03954E
CODE_01B211:
	JSL.l CODE_108FD6
	STZ.w $038C
	STZ.w $0121
	LDA.b #$02
	STA.w $0125
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$D8
	STA.w !REGISTER_VCountTimerLo
	LDA.b #$B1
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
CODE_01B22F:
	REP.b #$30
	JSL.l CODE_04DCF9
	SEP.b #$30
	LDA.w $095E
	AND.b #$07
	CMP.b #$02
	BNE.b CODE_01B243
	INC.w $61CA
CODE_01B243:
	JSL.l CODE_01B25E
	JML.l CODE_1083E2

;---------------------------------------------------------------------------

DATA_01B24B:
	db $01,$01,$01,$01,$01,$09,$01,$01
	db $09,$0C,$01,$02,$00,$01,$00,$00
	db $00,$02,$01

CODE_01B25E:
	PHP
	SEP.b #$30
	LDA.w $0205
	BNE.b CODE_01B273
	LDX.w $0203
	LDA.l DATA_01B24B-$01,x
	STA.w $004D
	STA.w $0205
CODE_01B273:
	STZ.w $0053
	STZ.w $0057
	PLP
	RTL

;---------------------------------------------------------------------------

CODE_01B27B:
	LDA.b #$70
	STA.b $22
	REP.b #$20
	LDA.w #$5800
	STA.b $20
	LDA.w #$0800
	LDY.b #$00
	JSL.l CODE_0082AB
	SEP.b #$20
	RTL

;---------------------------------------------------------------------------

CODE_01B292:
	REP.b #$30
	LDX.w #$020C
CODE_01B297:
	LDA.l $7E79A6,x
	STA.w $03B2,x
	DEX
	DEX
	BPL.b CODE_01B297
	STZ.w $7DF6
	LDX.w #$000C
CODE_01B2A8:
	LDA.l $7E7BB0,x
	STA.l $7E5D98,x
	DEX
	DEX
	BPL.b CODE_01B2A8
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

CODE_01B2B7:
	PHP
	REP.b #$20
	SEP.b #$10
	LDA.w $7DF6
	STA.l $7E5D98
	BEQ.b CODE_01B2D4
	TAX
CODE_01B2C6:
	LDY.w $7DF6,x
	LDA.w $7360,y
	STA.l $7E5D98,x
	DEX
	DEX
	BNE.b CODE_01B2C6
CODE_01B2D4:
	PLP
	RTL

;---------------------------------------------------------------------------

CODE_01B2D6:
	PHP
	REP.b #$20
	SEP.b #$10
	STZ.w $7DF6
	LDA.l $7E5D98
	BEQ.b CODE_01B333
	STA.b $00
	PHD
	LDA.w #$7960
	TCD
	LDX.b #$00
CODE_01B2ED:
	PHX
	LDA.l $7E5D9A,x
	CMP.w #$0029
	BEQ.b CODE_01B323
	JSL.l CODE_03A364
	BCC.b CODE_01B323
	TYX
	LDA.w $608C
	STA.w $70E2,x
	LDA.w $6090
	CLC
	ADC.w #$0010
	STA.w $7182,x
	LDA.w $7042,x
	AND.w #$00CF
	ORA.w $6126
	STA.w $7042,x
	STX.b $12
	JSL.l CODE_03BEB9
	STZ.w $0057
CODE_01B323:
	PLX
	INX
	INX
	CPX.w $0000
	BCC.b CODE_01B2ED
	PLD
	LDA.w #$0000
	STA.l $7E5D98
CODE_01B333:
	PLP
	RTL

;---------------------------------------------------------------------------

CODE_01B335:
	JSL.l CODE_00BA24
	LDA.b #$B9
	STA.b $10
	LDA.b #$BA
	STA.b $11
	LDA.b #$BB
	STA.b $12
	LDA.b #$BC
	STA.b $13
	LDA.b #$BD
	STA.b $14
	REP.b #$30
	LDX.w #$0000
CODE_01B352:
	LDA.l DATA_5FE3EA,x
	STA.l $702000,x
	STA.l $702D6C,x
	LDA.l DATA_5FE40A,x
	STA.l $702020,x
	STA.l $702D8C,x
	LDA.l DATA_5FE42A,x
	STA.l $702040,x
	STA.l $702DAC,x
	LDA.l DATA_5FE44A,x
	STA.l $702060,x
	STA.l $702DCC,x
	LDA.l DATA_5FE46A,x
	STA.l $702080,x
	STA.l $702DEC,x
	INX
	INX
	CPX.w #$0020
	BCC.b CODE_01B352
	SEP.b #$20
	LDA.b #$2D
	STA.w $6EB6
	STA.b $15
	LDA.b #$1B
	STA.w $6EB7
	STA.b $16
	LDA.b #$1C
	STA.w $6EB8
	STA.b $17
	LDA.b #$34
	STA.w $6EB9
	STA.b $18
	STA.b $19
	STA.b $1A
	LDA.b #$FF
	STA.w $6EBA
	STA.w $6EBB
	LDY.w #$0154
	JSL.l CODE_00B3EE
	SEP.b #$10
	LDY.w $0146
	LDX.w DATA_01AF80,y
	JSL.l CODE_00BDA2
	REP.b #$20
	LDA.w #$0080
	STA.w $0041
	STA.w $6098
	STA.w $0043
	STA.w $60A0
	LDA.w #$0100
	STA.w $0957
	LDA.w #$00F8
	STA.w $0959
	INC.w $0C1E
	INC.w $0C20
	JSL.l CODE_01B403
	LDA.w #$000C
	JSL.l CODE_03A34C
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_01B403:
	JSL.l CODE_01B47C
	LDA.w $60AC
	CMP.w #$0020
	BEQ.b CODE_01B47B
	LDA.w $608C
	CMP.w #$0120
	BPL.b CODE_01B41B
	CLC
	ADC.w #$0140
CODE_01B41B:
	CMP.w #$0260
	BMI.b CODE_01B424
	SEC
	SBC.w #$0140
CODE_01B424:
	STA.w $608C
	SEC
	SBC.w #$0120
	SEP.b #$20
	STA.w !REGISTER_Multiplicand
	LDY.b #$CD
	STY.w !REGISTER_Multiplier
	NOP #2
	LDA.b #$A0
	CLC
	ADC.w !REGISTER_ProductOrRemainderLo
	LDA.w !REGISTER_ProductOrRemainderHi
	ADC.b #$00
	PHA
	XBA
	STA.w !REGISTER_Multiplicand
	STY.w !REGISTER_Multiplier
	NOP #2
	PLA
	CLC
	ADC.w !REGISTER_ProductOrRemainderLo
	SEC
	SBC.b #$1A
	AND.b #$FF
	STA.w $0D05
	REP.b #$20
	LDA.w $608C
	SEC
	SBC.w #$0078
	STA.w $0C23
	STA.w $0039
	STA.w $6094
	LDA.w $60A0
	CLC
	ADC.w #$0026
	STA.w $0C27
	STA.w $003B
	STA.w $609C
CODE_01B47B:
	RTL

;---------------------------------------------------------------------------

CODE_01B47C:
	PHX
	LDA.w $0D05
	AND.w #$00FF
	ASL
	REP.b #$10
	TAX
	LDA.l DATA_00E954,x
	STA.w $094F
	STA.w $0955
	LDA.l DATA_00E9D4,x
	STA.w $0951
	EOR.w #$FFFF
	INC
	STA.w $0953
	SEP.b #$10
	PLX
	RTL

;---------------------------------------------------------------------------

CODE_01B4A3:
	REP.b #$20
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDX.b #DATA_520000+$1D80>>16
	STX.w DMA[$00].SourceBank
	LDY.b #$01
	LDA.w #$4280
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #DATA_520000+$1D80
	STA.w DMA[$00].SourceLo
	LDA.w #$0080
	STA.w DMA[$00].SizeLo
	STY.w !REGISTER_DMAEnable
	STA.w DMA[$00].SizeLo
	LDA.w #$4380
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #DATA_520000+$1F80
	STA.w DMA[$00].SourceLo
	STY.w !REGISTER_DMAEnable
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_01B4E1:
	LDA.b #$01
	STA.w $61AE
	STA.w $61B0
	JSL.l CODE_01C0CE
	REP.b #$20
	LDA.w $0B4A
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	INC
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $0B4C
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_088E48>>16
	LDA.w #FXCODE_088E48
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w $0B4C
	CLC
	ADC.w #$0008
	STA.w $0B4C
	CMP.w #$0101
	BCC.b CODE_01B548
	STZ.w $0B4C
	INC.w $0B4A
	LDA.w $0B4A
	CMP.w #$0002
	BCC.b CODE_01B548
	SEP.b #$20
	STZ.w $0969
	STZ.w $096A
	STZ.w $0964
	STZ.w $0965
	STZ.w $0966
	LDA.b #$20
	TRB.w $094A
	STZ.w $61AE
	STZ.w $61B0
	INC.w $0118
	JML.l CODE_1083E2

CODE_01B548:
	JSL.l CODE_00BE39	: db $D0,$56,$7E,$02,$3A,$70,$48,$03
	SEP.b #$20
	LDA.b #$1F
	STA.w $0969
	STA.w $096A
	LDA.b #$33
	STA.w $0964
	STA.w $0965
	STA.w $0966
	STZ.w $094C
	STZ.w !REGISTER_ColorAndObjectWindowLogicSettings
	LDA.b #$20
	TSB.w $094A
	LDA.b #$0F
	STA.w $0200
	LDA.b #$01
	STA.w $0201
	PLB
	RTL

;---------------------------------------------------------------------------

CODE_01B580:
	LDX.w $0B57
	CPX.b #$0D
	BCS.b CODE_01B58E
	JSL.l CODE_01C0CE
	LDX.w $0B57
CODE_01B58E:
	JSR.w (DATA_01B593-$01,x)
	PLB
	RTL

DATA_01B593:
	dw CODE_01E2BF
	dw CODE_01B5D7
	dw CODE_01B5D7
	dw CODE_01B5D8
	dw CODE_01E378
	dw CODE_01E442
	dw CODE_01B5E4
	dw CODE_01B6B9
	dw CODE_01B6C9
	dw CODE_01B95B
	dw CODE_01B9BA
	dw CODE_01E4A0
	dw CODE_01BA1C
	dw CODE_01BA2F
	dw CODE_01BA1C
	dw CODE_01BAD0
	dw CODE_01BA1C
	dw CODE_01BB5D
	dw CODE_01BA1C
	dw CODE_01BCBD
	dw CODE_01BA1C
	dw CODE_01BCF8
	dw CODE_01BA1C
	dw CODE_01BD50
	dw CODE_01BA1C
	dw CODE_01BDC3
	dw CODE_01BDCA
	dw CODE_01BA1C
	dw CODE_01BE00
	dw CODE_01BE63
	dw CODE_01BE9D

;---------------------------------------------------------------------------

CODE_01B5D1:
	INC.w $0B57
	INC.w $0B57
CODE_01B5D7:
	RTS

;---------------------------------------------------------------------------

CODE_01B5D8:
	LDA.w $094A
	PHA
	JSR.w CODE_01E2F0
	PLA
	TSB.w $094A
	RTS

;---------------------------------------------------------------------------

CODE_01B5E4:
	REP.b #$20
	PHB
	LDX.b #$7E5DA6>>16
	PHX
	PLB
	LDX.b #$00
	LDA.w #$017F
CODE_01B5F0:
	STA.w $7E5DA6,x
	STA.w $7E5EA6,x
	STA.w $7E5FA6,x
	STA.w $7E60A6,x
	STA.w $7E6126,x
	DEX
	DEX
	BNE.b CODE_01B5F0
	PLB
	LDX.b #$00
CODE_01B606:
	LDA.w DATA_01B659,x
	STA.l $7E5E2E,x
	LDA.w DATA_01B689,x
	STA.l $7E60EE,x
	INX
	INX
	CPX.b #$30
	BCC.b CODE_01B606
	LDA.w #$0004
	STA.w $0148
	STZ.w $014A
	SEP.b #$20
	LDA.b #$0C
	STA.w $0127
	JMP.w CODE_01B5D1

;---------------------------------------------------------------------------

DATA_01B62D:
	db $00,$68,$BF,$40,$EE,$18,$A0,$68,$7F,$44,$11,$1A,$60,$68,$29,$C0
	db $EE,$18,$61,$68,$29,$C0,$EE,$18,$7E,$68,$29,$C0,$EE,$18,$7F,$68
	db $29,$C0,$EE,$18,$00,$6B,$3F,$41,$EE,$18,$FF,$FF

;---------------------------------------------------------------------------

DATA_01B659:
	dw $0145,$0146,$8145,$C146,$4145,$4146,$0145,$0146
	dw $8145,$8146,$4145,$0146,$0145,$8146,$0145,$0146
	dw $0145,$0146,$8145,$C146,$0145,$0146,$8145,$0146

DATA_01B689:
	dw $0145,$0146,$8145,$8146,$0145,$0146,$0145,$0146
	dw $8145,$8146,$0145,$8146,$0145,$8146,$8145,$0146
	dw $4145,$0146,$8145,$0146,$0145,$8146,$0145,$0146

;---------------------------------------------------------------------------

CODE_01B6B9:
	LDA.b #$18
	STA.w $0127
	JMP.w CODE_01B5D1

DATA_01B6C1:
	db $00,$34,$FF,$47,$7F,$11,$FF,$FF

CODE_01B6C9:
	REP.b #$30
	LDX.w #$000A
	LDY.w #$0000
	STZ.b $00
CODE_01B6D3:
	LDA.w DATA_01B7D7,y
	JSR.w CODE_01B785
	CPY.w #$0016
	BCC.b CODE_01B6D3
	JSR.w CODE_01B7A1
	JSR.w CODE_01B7B3
	JSR.w CODE_01B7C5
	LDX.w #$03CE
	LDY.w #$0000
	STZ.b $00
CODE_01B6EF:
	LDA.w DATA_01B835,y
	JSR.w CODE_01B785
	CPY.w #$0015
	BCC.b CODE_01B6EF
	SEP.b #$30
	LDX.w $021A
	LDA.w $02B8,x
	REP.b #$30
	AND.w #$00FF
	STA.w $030C
	STZ.b $00
	LDA.w $030C
	CMP.w #$0064
	BCC.b CODE_01B71C
	LDA.w #$000B
	STA.b $00
	DEC
	BRA.b CODE_01B728

CODE_01B71C:
	CMP.w #$000A
	BCC.b CODE_01B728
	INC.b $00
	SBC.w #$000A
	BRA.b CODE_01B71C

CODE_01B728:
	ASL
	TAY
	LDA.w DATA_01B8AF,y
	STA.l $7E5DD4
	LDA.w DATA_01B92D,y
	STA.l $7E5E14
	LDA.b $00
	ASL
	TAY
	LDA.w DATA_01B8AF,y
	STA.l $7E5DD2
	LDA.w DATA_01B92D,y
	STA.l $7E5E12
	LDA.w #DATA_568000+$5000>>16
	STA.b $01
	LDY.w #$2800
	LDX.w #DATA_568000+$5000
	LDA.w #$0800
	JSL.l CODE_00BEA6
	LDA.w #DATA_520000+$1E00>>16
	STA.b $01
	LDY.w #$1000
	LDX.w #DATA_520000+$1E00
	LDA.w #$0100
	JSL.l CODE_00BEA6
	LDA.w #DATA_520000+$1EC0>>16
	STA.b $01
	LDY.w #$1100
	LDX.w #DATA_520000+$1EC0
	LDA.w #$0100
	JSL.l CODE_00BEA6
	SEP.b #$30
	JMP.w CODE_01B5D1

CODE_01B785:
	PHY
	AND.w #$00FF
	TAY
	LDA.w DATA_01B85F,y
	ORA.b $00
	STA.l $7E5DA6,x
	LDA.w DATA_01B8DD,y
	ORA.b $00
	STA.l $7E5DE6,x
	INX
	INX
	PLY
	INY
	RTS

CODE_01B7A1:
	LDX.w #$0108
	LDY.w #$0000
CODE_01B7A7:
	LDA.w DATA_01B7ED,y
	JSR.w CODE_01B785
	CPY.w #$0018
	BCC.b CODE_01B7A7
	RTS

CODE_01B7B3:
	LDX.w #$01C8
	LDY.w #$0000
CODE_01B7B9:
	LDA.w DATA_01B805,y
	JSR.w CODE_01B785
	CPY.w #$0018
	BCC.b CODE_01B7B9
	RTS

CODE_01B7C5:
	LDX.w #$0288
	LDY.w #$0000
CODE_01B7CB:
	LDA.w DATA_01B81D,y
	JSR.w CODE_01B785
	CPY.w #$0018
	BCC.b CODE_01B7CB
	RTS

DATA_01B7D7:
	dw $3C3A,$0E4E,$0C10,$4E0E,$0424,$221C,$3608,$3636
	dw $5436,$4E5C,$3C3A

DATA_01B7ED:
	dw $403E,$244E,$0026,$2422,$3636,$3636,$3636,$3450
	dw $5056,$6A68,$504E,$6E6C

DATA_01B805:
	dw $4846,$044E,$101C,$241A,$3636,$3636,$3636,$3450
	dw $5054,$6A68,$504E,$6E6C

DATA_01B81D:
	dw $4442,$0A4E,$1C16,$082C,$2422,$3636,$3636,$5036
	dw $5A34,$6A68,$504E,$6E6C

DATA_01B835:
	db $26,$1C,$26,$00,$16,$4E,$1E,$1C,$10,$1A,$26,$24,$36,$36,$36,$36
	db $36,$36,$50,$6C,$6E

DATA_01B84A:
	db $4E,$0E,$10,$0C,$0E,$4E,$24,$04,$1C,$22,$08,$36,$36,$36,$36,$36
	db $36,$36,$50,$6C,$6E

DATA_01B85F:
	dw $010A,$010B,$010C,$010D,$010E,$4106,$0120,$0121
	dw $0122,$0123,$0124,$C116,$0126,$0127,$0109,$0128
	dw $0129,$0128,$4102,$012C,$012D,$012E,$8136,$0101
	dw $0101,$0142,$0144,$0143,$017F,$012A,$012B,$0548
	dw $0549,$054A,$054B,$054C,$054D,$054E,$054F,$017F

DATA_01B8AF:
	dw $0109,$0100,$0102,$0102,$0103,$0104,$0105,$0106
	dw $0107,$C115,$0168,$0167,$0175,$0176,$017F,$017F
	dw $01C4,$010F,$01D6,$0164,$0174,$016E,$017F

DATA_01B8DD:
	dw $011A,$011B,$011C,$011D,$011E,$011F,$0130,$0131
	dw $0132,$0133,$0134,$C106,$0136,$0137,$0119,$0138
	dw $0139,$0140,$0112,$013C,$013D,$013E,$8126,$0111
	dw $013C,$C142,$C144,$017F,$0141,$013A,$013B,$0508
	dw $0518,$0525,$0535,$052F,$053F,$050F,$0547,$017F

DATA_01B92D:
	dw $0119,$0110,$C142,$0112,$0113,$0114,$0115,$0116
	dw $0117,$C105,$0178,$0177,$0179,$017A,$015F,$017B
	dw $01D4,$013D,$01D7,$011E,$011E,$017E,$0158

;---------------------------------------------------------------------------

CODE_01B95B:
	REP.b #$20
	STZ.w $0392
	STZ.w $0B5F
	STZ.w $0B61
	STZ.w $0B63
	STZ.w $0381
	SEP.b #$20
	LDA.b #$0F
	STA.w $0127
	JMP.w CODE_01B5D1

;---------------------------------------------------------------------------

DATA_01B976:
	db $62,$68,$01,$00,$02,$1A,$63,$68,$33,$40,$03,$1A,$7D,$68,$01,$00
	db $04,$1A,$82,$68,$25,$C0,$05,$1A,$83,$68,$01,$00,$00,$1A,$84,$68
	db $31,$40,$01,$1A,$9D,$68,$25,$C0,$15,$1A,$A3,$68,$23,$C0,$10,$1A
	db $E2,$6A,$01,$00,$12,$1A,$E3,$6A,$33,$40,$13,$1A,$FD,$6A,$01,$00
	db $14,$1A,$FF,$FF

CODE_01B9BA:
	REP.b #$30
	LDA.w #$7E5DA6>>16
	STA.b $01
	LDY.w #$34A0
	LDX.w #$7E5DA6
	LDA.w #$0480
	JSL.l CODE_00BEA6
	LDX.w #$001C
CODE_01B9D1:
	LDA.l DATA_5FC094,x
	STA.l $702002,x
	LDA.l DATA_5FB31A,x
	STA.l $7020C2,x
	LDA.l DATA_5FB33A,x
	STA.l $7020E2,x
	DEX
	DEX
	BPL.b CODE_01B9D1
	STZ.b $39
	STZ.b $3B
	STZ.b $41
	STZ.b $43
	STZ.w $0948
	LDA.w #$0000
	STA.l $702000
	STZ.w $0B5B
	STZ.w $0B5D
	SEP.b #$30
	LDA.w $095E
	AND.b #$0F
	STA.w $095E
	LDA.b #$04
	STA.w $0967
	LDA.b #$01
	STA.w $0968
	JMP.w CODE_01B5D1

CODE_01BA1C:
	JSR.w CODE_01BEE4
	DEC.w $038B
	BNE.b CODE_01BA2E
	JSR.w CODE_01B5D1
	LDA.w $0B57
	CMP.b #$29
	BCS.b CODE_01BA2E
CODE_01BA2E:
	RTS

;---------------------------------------------------------------------------

CODE_01BA2F:
	JSR.w CODE_01BEE4
	REP.b #$30
	LDA.w $03B6
	SEC
	SBC.w #$000A
	STA.w $03B6
	BPL.b CODE_01BA69
	STZ.w $03B6
	SEP.b #$30
	LDA.b #$20
	STA.w $038B
	LDA.w $03B4
	ORA.w $03B5
	BNE.b CODE_01BA66
	JSR.w CODE_01B5D1
	JSR.w CODE_01B5D1
	LDA.w $03B8
	ORA.w $03B9
	BNE.b CODE_01BA66
	JSR.w CODE_01B5D1
	JSR.w CODE_01B5D1
CODE_01BA66:
	JMP.w CODE_01B5D1

CODE_01BA69:
	STZ.b $02
	INC.w $0392
	STZ.w $0392
	LDA.w $0B5F
	INC
	CMP.w #$001E
	BCC.b CODE_01BA89
	LDA.w #$0400
	STA.b $00
	STA.b $02
	JSR.w CODE_01B7A1
	LDA.w #$001E
	BRA.b CODE_01BA95

CODE_01BA89:
	PHA
	SEP.b #$30
	LDA.b #$5A
	JSL.l CODE_0085D2
	REP.b #$30
	PLA
CODE_01BA95:
	STA.w $0B5F
	LDX.w #$0000
CODE_01BA9B:
	CMP.w #$000A
	BCC.b CODE_01BAA6
	INX
	SBC.w #$000A
	BRA.b CODE_01BA9B

CODE_01BAA6:
	STA.b $00
	LDA.w #$007E
	STA.b $06
	STA.b $09
	STA.b $12
	STA.b $15
	LDA.w #$5EC8
	STA.b $04
	CLC
	ADC.w #$000E
	STA.w $0010
	LDA.w #$5F08
	STA.b $07
	CLC
	ADC.w #$000E
	STA.b $13
	JSR.w CODE_01BBD4
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

CODE_01BAD0:
	JSR.w CODE_01BEE4
	REP.b #$30
	LDA.w $0B61
	CMP.w #$0014
	BCS.b CODE_01BAE5
	DEC.w $03B4
	LDA.w $03B4
	BPL.b CODE_01BAFD
CODE_01BAE5:
	SEP.b #$30
	LDA.b #$20
	STA.w $038B
	LDA.w $03B8
	ORA.w $03B9
	BNE.b CODE_01BAFA
	JSR.w CODE_01B5D1
	JSR.w CODE_01B5D1
CODE_01BAFA:
	JMP.w CODE_01B5D1

CODE_01BAFD:
	STZ.b $02
	LDA.w $0B61
	INC
	CMP.w #$0014
	BCC.b CODE_01BB17
	LDA.w #$0400
	STA.b $00
	STA.b $02
	JSR.w CODE_01B7B3
	LDA.w #$0014
	BRA.b CODE_01BB23

CODE_01BB17:
	PHA
	SEP.b #$30
	LDA.b #$5A
	JSL.l CODE_0085D2
	REP.b #$30
	PLA
CODE_01BB23:
	STA.w $0B61
	LDX.w #$0000
CODE_01BB29:
	CMP.w #$000A
	BCC.b CODE_01BB34
	INX
	SBC.w #$000A
	BRA.b CODE_01BB29

CODE_01BB34:
	STA.b $00
	LDA.w #$007E
	STA.b $06
	STA.b $09
	STA.b $12
	STA.b $15
	LDA.w #$5F88
	STA.b $04
	CLC
	ADC.w #$000E
	STA.b $10
	LDA.w #$5FC8
	STA.b $07
	CLC
	ADC.w #$000E
	STA.b $13
	JSR.w CODE_01BBD4
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

CODE_01BB5D:
	JSR.w CODE_01BEE4
	REP.b #$30
	DEC.w $03B8
	LDA.w $03B8
	BPL.b CODE_01BB77
	STZ.w $03B8
	SEP.b #$30
	LDA.b #$20
	STA.w $038B
	JMP.w CODE_01B5D1

CODE_01BB77:
	STZ.b $02
	LDA.w $0B63
	CLC
	ADC.w #$000A
	STA.w $0B63
	LDX.w #$0000
CODE_01BB86:
	CMP.w #$000A
	BCC.b CODE_01BB91
	INX
	SBC.w #$000A
	BRA.b CODE_01BB86

CODE_01BB91:
	CPX.w #$0005
	BCC.b CODE_01BBA2
	PHX
	LDA.w #$0400
	STA.b $00
	STA.b $02
	JSR.w CODE_01B7C5
	PLX
CODE_01BBA2:
	LDA.w #$FFFF
	STA.b $00
	LDA.w #$007E
	STA.b $06
	STA.b $09
	STA.b $12
	STA.b $15
	LDA.w #$604C
	STA.b $04
	CLC
	ADC.w #$000A
	STA.b $10
	LDA.w #$608C
	STA.b $07
	CLC
	ADC.w #$000A
	STA.b $13
	JSR.w CODE_01BBD4
	SEP.b #$30
	LDA.b #$5A
	JSL.l CODE_0085D2
	RTS

;---------------------------------------------------------------------------

CODE_01BBD4:
	PHX
	TXA
	BEQ.b CODE_01BBEC
	ASL
	TAX
	LDA.w DATA_01B8AF,x
	ORA.b $02
	STA.b [$04]
	STA.b [$10]
	LDA.w DATA_01B92D,x
	ORA.b $02
	STA.b [$07]
	STA.b [$13]
CODE_01BBEC:
	LDY.w #$0002
	LDA.b $00
	BMI.b CODE_01BC07
	ASL
	TAX
	LDA.w DATA_01B8AF,x
	ORA.b $02
	STA.b [$04],y
	STA.b [$10],y
	LDA.w DATA_01B92D,x
	ORA.b $02
	STA.b [$07],y
	STA.b [$13],y
CODE_01BC07:
	PLX
	LDA.b $00
	BPL.b CODE_01BC0E
	STZ.b $00
CODE_01BC0E:
	INC.b $00
	LDA.b $13
	CLC
	ADC.w #$0006
	STA.b $13
	JSR.w CODE_01BCAA
	STZ.b $00
	STZ.b $02
	LDX.w #$0004
	LDA.w $0B5F
	CLC
	ADC.w $0B61
	CLC
	ADC.w $0B63
	CMP.w #$0064
	BCC.b CODE_01BC35
	LDA.w #$0064
CODE_01BC35:
	STA.w $0381
	CMP.w #$0064
	BCC.b CODE_01BC45
	LDA.w #$000B
	STA.b $00
	DEC
	BRA.b CODE_01BC51

CODE_01BC45:
	CMP.w #$000A
	BCC.b CODE_01BC51
	INC.b $00
	SBC.w #$000A
	BRA.b CODE_01BC45

CODE_01BC51:
	ASL
	TAX
	LDA.w DATA_01B8AF,x
	STA.l $7E6198
	LDA.w DATA_01B92D,x
	STA.l $7E61D8
	LDA.b $00
	BEQ.b CODE_01BC75
CODE_01BC64:
	ASL
	TAY
	LDA.w DATA_01B8AF,y
	STA.l $7E6196
	LDA.w DATA_01B92D,y
	STA.l $7E61D6
CODE_01BC75:
	LDA.b $02
	ASL
	TAY
	BEQ.b CODE_01BC89
	LDA.w DATA_01B8AF,y
	STA.l $7E6194
	LDA.w DATA_01B92D,y
	STA.l $7E61D4
CODE_01BC89:
	TXA
	ORA.b $02
	TAX
	STZ.b $02
	LDA.w #$61DC
	STA.b $13
	JSR.w CODE_01BCAA
	LDA.w #$7E5DA6>>16
	STA.b $01
	LDY.w #$34A0
	LDX.w #$7E5DA6
	LDA.w #$0480
	JSL.l CODE_00BEA6
	RTS

;---------------------------------------------------------------------------

CODE_01BCAA:
	TXA
	BNE.b CODE_01BCB5
	LDA.b $00
	BEQ.b CODE_01BCBC
	DEC
	DEC
	BEQ.b CODE_01BCBC
CODE_01BCB5:
	LDA.w #$016F
	ORA.b $02
	STA.b [$13]
CODE_01BCBC:
	RTS

;---------------------------------------------------------------------------

CODE_01BCBD:
	JSR.w CODE_01BEE4
	LDA.b #$30
	STA.w $038B
	REP.b #$30
	STZ.w $03BA
	LDX.w #$0029
	LDA.w $0381
	BMI.b CODE_01BCDA
	CMP.w $030C
	BCC.b CODE_01BCDA
	LDX.w #$002D
CODE_01BCDA:
	STX.w $0B57
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

DATA_01BCE0:
	dw $6218,$621A,$621C,$61DA,$621A,$621C

DATA_01BCEC:
	dw $0555,$0556,$0557,$015F,$0565,$0566

CODE_01BCF8:
	JSR.w CODE_01BEE4
	LDA.b #$7E
	STA.b $02
	REP.b #$30
	LDA.w $03BA
	AND.w #$00FE
	TAX
	CPX.w #$000C
	BCC.b CODE_01BD15
	LDA.w #$003D
	STA.w $0B57
	BRA.b CODE_01BD25

CODE_01BD15:
	LDA.w DATA_01BCE0,x
	STA.b $00
	LDA.w DATA_01BCEC,x
	STA.b [$00]
	INC.w $03BA
	JSR.w CODE_01BC89
CODE_01BD25:
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

DATA_01BD28:
	dw $6218,$6216,$6214,$61D4,$6194,$6156,$6158,$615A
	dw $619A,$61DA

DATA_01BD3C:
	dw $0562,$0561,$0560,$0563,$0553,$0550,$0551,$0552
	dw $0554,$015F

CODE_01BD50:
	JSR.w CODE_01BEE4
	LDA.b #$7E
	STA.b $02
	LDA.b #$30
	STA.w $038B
	REP.b #$30
	LDA.w $03BA
	AND.w #$00FE
	TAX
	CPX.w #$0014
	BCC.b CODE_01BD80
	LDX.w #$0037
	LDA.w $0381
	CMP.w #$0064
	BNE.b CODE_01BD7B
	STZ.w $03BA
	LDX.w #$0031
CODE_01BD7B:
	STX.w $0B57
	BRA.b CODE_01BD90

CODE_01BD80:
	LDA.w DATA_01BD28,x
	STA.b $00
	LDA.w DATA_01BD3C,x
	STA.b [$00]
	INC.w $03BA
	JSR.w CODE_01BC89
CODE_01BD90:
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

DATA_01BD93:
	dw $6218,$6216,$6214,$61D4,$6194,$6154,$6156,$6158
	dw $615A,$619A,$61DA,$621A

DATA_01BDAB:
	dw $056B,$056A,$0569,$056D,$055D,$0559,$055A,$055B
	dw $055C,$055E,$015F,$056C

CODE_01BDC3:
	LDA.b #$95
	STA.b $53
	JSR.w CODE_01B5D1
CODE_01BDCA:
	JSR.w CODE_01BEE4
	LDA.b #$7E
	STA.b $02
	REP.b #$30
	LDA.w $03BA
	AND.w #$00FE
	TAX
	CPX.w #$0018
	BCC.b CODE_01BDED
	LDA.w #$0037
	STA.w $0B57
	LDA.w #$0030
	STA.w $038B
	BRA.b CODE_01BDFD

CODE_01BDED:
	LDA.w DATA_01BD93,x
	STA.b $00
	LDA.w DATA_01BDAB,x
	STA.b [$00]
	INC.w $03BA
	JSR.w CODE_01BC89
CODE_01BDFD:
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

CODE_01BE00:
	JSR.w CODE_01BEE4
	REP.b #$30
	LDA.w $0381
	CMP.w $030C
	BCS.b CODE_01BE15
	LDA.w #$003D
	STA.w $0B57
	BRA.b CODE_01BE60

CODE_01BE15:
	STA.w $030C
	STZ.b $00
	CMP.w #$0064
	BCC.b CODE_01BE27
	LDA.w #$000B
	STA.b $00
	DEC
	BRA.b CODE_01BE33

CODE_01BE27:
	CMP.w #$000A
	BCC.b CODE_01BE33
	INC.b $00
	SBC.w #$000A
	BRA.b CODE_01BE27

CODE_01BE33:
	ASL
	TAY
	LDA.w DATA_01B8AF,y
	STA.l $7E5DD4
	LDA.w DATA_01B92D,y
	STA.l $7E5E14
	LDA.b $00
	ASL
	TAY
	BEQ.b CODE_01BE5A
	LDA.w DATA_01B8AF,y
	STA.l $7E5DD2
	LDA.w DATA_01B92D,y
	STA.l $7E5E12
	JSR.w CODE_01BC89
CODE_01BE5A:
	INC.w $0B57
	INC.w $0B57
CODE_01BE60:
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

CODE_01BE63:
	REP.b #$30
	LDA.w #$0570
	STA.l $7E5DB0
	STA.l $7E5DD8
	LDA.w #$0572
	STA.l $7E5DF0
	STA.l $7E5E18
	LDA.w #$0571
	STA.l $7E5DB2
	STA.l $7E5DDA
	LDA.w #$0573
	STA.l $7E5DF2
	STA.l $7E5E1A
	JSR.w CODE_01BC89
	INC.w $0B57
	INC.w $0B57
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

CODE_01BE9D:
	JSR.w CODE_01BEE4
	LDA.b $36
	ORA.b $35
	AND.b #$F0
	BEQ.b CODE_01BEE3
	JSL.l CODE_01B2B7
	LDX.b #$1F
	LDA.w $0385
	BPL.b CODE_01BEB8
	JSR.w CODE_01BF38
	LDX.b #$29
CODE_01BEB8:
	STX.w $0118
	LDA.b #$F1
	STA.b $4D
	INC.w $0220
	LDX.w $021A
	LDA.w $030C
	CMP.w $02B8,x
	BEQ.b CODE_01BEE0
	BCC.b CODE_01BEE0
	PHA
	LDA.w $0222,x
	AND.b #$7F
	BEQ.b CODE_01BEDF
	LDA.w $02B8,x
	ORA.b #$80
	STA.w $0220
CODE_01BEDF:
	PLA
CODE_01BEE0:
	STA.w $02B8,x
CODE_01BEE3:
	RTS

;---------------------------------------------------------------------------

CODE_01BEE4:
	LDA.w $0B57
	CMP.b #$3D
	BCC.b CODE_01BF22
	DEC.w $0B5D
	BPL.b CODE_01BF22
	LDA.b #$05
	STA.w $0B5D
	REP.b #$30
	LDA.w $0B5B
	TAX
	LDA.w DATA_01BF23+$02,x
	AND.w #$00FF
	STA.b $01
	LDY.w #$2800
	LDA.w DATA_01BF23,x
	TAX
	LDA.w #$0800
	JSL.l CODE_00BEA6
	SEP.b #$30
	LDA.w $0B5B
	INC
	INC
	INC
	CMP.b #$09
	BCC.b CODE_01BF1F
	LDA.b #$00
CODE_01BF1F:
	STA.w $0B5B
CODE_01BF22:
	RTS

DATA_01BF23:
	dl DATA_568000+$5000
	dl DATA_568000+$5800
	dl DATA_568000+$6000

;---------------------------------------------------------------------------

DATA_01BF2C:
	db $00,$02,$04,$0A,$06,$08,$04,$02
	db $00,$08,$06,$0A

CODE_01BF38:
	JSL.l CODE_008408
	AND.b #$01
	STA.b $00
	LDA.w $0218
	CLC
	ADC.b $00
	TAX
	LDA.w DATA_01BF2C,x
	STA.w $0212
	CMP.b #$08
	BNE.b CODE_01BF5D
	LDA.w $0379
	DEC
	BNE.b CODE_01BF5D
	LDA.w DATA_01BF2C-$01,x
	STA.w $0212
CODE_01BF5D:
	RTS

;---------------------------------------------------------------------------

DATA_01BF5E:
	db $00,$40,$40,$40,$80,$40,$C0,$40,$00,$41,$40,$41,$80,$41,$C0,$41
	db $00,$44,$40,$44

DATA_01BF72:
	dw $1600,$1620,$1640,$1660,$1A00,$1A20,$1A40,$1A60
	dw $1A80,$1AA0

DATA_01BF86:
	dw $2612,$2828,$320C,$2020,$32C8,$2030,$72C8,$3020
	dw $B2C8,$3030,$F2C8,$28C8,$320C,$20C0,$32C8,$20D0
	dw $72C8,$30C0,$B2C8,$30D0,$F2C8

DATA_01BFB0:
	dw $FFF0,$0010

DATA_01BFB4:
	dw $0000,$0000,$FFEA,$0010

DATA_01BFBC:
	dw $0300,$30C4,$0008,$30D5,$0500,$B0C4,$0808,$B0D5
	dw $0000,$70D5,$0308,$70C4,$0800,$F0D5,$0508,$F0C4
	dw $0003,$30C4,$0005,$70C4,$0800,$F0C5,$0808,$B0C5
	dw $0000,$70C5,$0008,$30C5,$0803,$B0C4,$0805,$F0C4
	dw $03FF,$023F,$001F,$4010,$7C00,$7E00,$47E0,$03F4
	dw $03FF,$023F,$001F,$7D93,$7FFF,$7FFF,$7FFF,$7DF5
	dw $7FF7,$7FF9,$7DF5,$7FF9,$7FFF,$0000,$0000,$0000
	dw $0000,$0000,$0000,$7D93,$7FFF,$7FFF,$7EBA,$7E17
	dw $7FF7,$7F18,$7E76,$7FFB,$7FFD,$0000,$0000,$0000
	dw $0000,$0000,$0000,$7D93,$7FFF,$7FFF,$7E17,$7EBA
	dw $7FF7,$7E76,$7F18,$7FFD,$7FFB,$0000,$0000,$0000
	dw $0000,$0000,$0000,$7D93,$7FFF,$7FFF,$7DF5,$7FFF
	dw $7FF7,$7DF5,$7FF9,$7FFF,$7FF9,$0000,$0000,$0000
	dw $0000,$0000,$0000,$3B1D,$7759,$3B59

DATA_01C098:
	dw $0001,$0000,$FFFF,$0000,$FFFE,$0000,$FFFF,$0000

DATA_01C0A8:
	dw $FFFE,$0000,$0002,$0000,$FFFE,$0000,$FFFC,$0000

DATA_01C0B8:
	dw $0707,$1717,$2727,$3737,$4747,$5757,$6767,$7777
	dw $01FF,$02FE,$2800

CODE_01C0CE:
	PHB
	PHK
	PLB
	STZ.b $36
	STZ.b $35
	STZ.b $38
	STZ.b $37
CODE_01C0D9:
	LDA.b #$10
	STA.w $0B83
	STZ.w $0B84
	LDA.w $0D0F
	BEQ.b CODE_01C0FF
	JSL.l CODE_01DE5A
	JMP.w CODE_01C16E

DATA_01C0ED:
	dw CODE_01DAC3
	dw CODE_01DAE6
	dw CODE_01DAEB
	dw CODE_01DB0E
	dw CODE_01DB00
	dw CODE_01DB25
	dw CODE_01DB5C
	dw CODE_01DB79
	dw CODE_01DB7E

CODE_01C0FF:
	LDA.w $0B0F
	BNE.b CODE_01C137
	LDA.b $38
	AND.b #$10
	BEQ.b CODE_01C125
	LDA.w $7FEA
	ORA.w $0B65
	ORA.w $0B59
	ORA.w $0398
	ORA.w $61AE
	ORA.w $61B0
	BNE.b CODE_01C125
	LDA.w $60AC
	CMP.b #$06
	BCC.b CODE_01C128
CODE_01C125:
	JMP.w CODE_01C16E

CODE_01C128:
	LDA.w $0B10
	EOR.b #$01
	AND.b #$01
	STA.w $0B10
	LDA.b #$01
	STA.w $0B0F
CODE_01C137:
	LDA.b $38
	AND.b #$20
	BEQ.b CODE_01C16B
	BRA.b CODE_01C14B

CODE_01C13F:
	LDA.w $030E
	CMP.b #$02
	BNE.b CODE_01C14B
	INC.w $0220
	BRA.b CODE_01C155

CODE_01C14B:
	LDX.w $021A
	LDA.w $0222,x
	AND.b #$7F
	BEQ.b CODE_01C16B
CODE_01C155:
	LDA.b #$F0
	STA.b $4D
	LDA.b #$01
	STA.b $53
	CPX.b #$0B
	BNE.b CODE_01C164
	STZ.w $021A
CODE_01C164:
	LDA.b #$1E
	STA.w $0118
	PLB
	RTL

CODE_01C16B:
	JMP.w CODE_01CA9B

CODE_01C16E:
	LDA.w $0398
	BEQ.b CODE_01C18B
	LDX.w $039C
	BEQ.b CODE_01C17D
	DEC.w $039C
	BRA.b CODE_01C18B

CODE_01C17D:
	ASL
	TAX
	REP.b #$20
	JSR.w (DATA_01C0ED-$02,x)
	SEP.b #$20
	BRA.b CODE_01C18B

CODE_01C188:
	PHB
	PHK
	PLB
CODE_01C18B:
	JSL.l CODE_008259
	JSL.l CODE_04FD28
	JSL.l CODE_109058
	JSL.l CODE_108C9A
	REP.b #$20
	LDA.b $3B
	PHA
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_01C1F8
	LDA.w $61C8
	BEQ.b CODE_01C1C7
	PHA
	LDA.w $61C6
	BEQ.b CODE_01C1B9
	DEC.w $61C6
CODE_01C1B9:
	PLA
	DEC.w $61C8
	AND.w #$0007
	ASL
	TAY
	LDA.w DATA_01C0A8,y
	BRA.b CODE_01C1D7

CODE_01C1C7:
	LDA.w $61C6
	BEQ.b CODE_01C1F8
	DEC.w $61C6
	AND.w #$0007
	ASL
	TAY
	LDA.w DATA_01C098,y
CODE_01C1D7:
	STA.w $0CB0
	CLC
	ADC.b $3B
	STA.b $3B
	STA.w $609C
	LDY.w $013E
	CPY.b #$09
	BEQ.b CODE_01C1ED
	CPY.b #$0A
	BNE.b CODE_01C1F8
CODE_01C1ED:
	LDA.w $0CB0
	CLC
	ADC.b $43
	STA.b $43
	STA.w $60A0
CODE_01C1F8:
	SEP.b #$20
	LDX.w $61CA
	BEQ.b CODE_01C202
	JSR.w (DATA_01D916-$01,x)
CODE_01C202:
	JSL.l CODE_0394D3
	JSL.l CODE_04FA67
	JSL.l CODE_04DD9E
	JSL.l CODE_0397DF
	JSR.w CODE_01D6B1
	LDA.w $0146
	CMP.b #$09
	BEQ.b CODE_01C224
	LDA.w $014A
	ASL
	TAX
	JSR.w (DATA_01C454,x)
CODE_01C224:
	LDA.w $0B55
	BEQ.b CODE_01C232
	DEC.w $0B55
	AND.b #$0F
	TAX
	LDA.w DATA_01C0B8,x
CODE_01C232:
	STA.w $095B
	REP.b #$20
	PLA
	STA.b $3B
	STA.w $609C
	LDA.w $61B2
	AND.w #$A000
	STA.w $0387
	LDA.w $0C8A
	ORA.w $614E
	ORA.w $0B4C
	ORA.w $61B0
	ORA.w $0B57
	ORA.w $0B59
	ORA.w $0398
	BEQ.b CODE_01C260
	LDA.w #$0001
CODE_01C260:
	ORA.w $0387
	STA.w $0387
	BNE.b CODE_01C29D
	LDA.w $0389
	BEQ.b CODE_01C29D
	LDA.w $03B6
	CMP.w #$006E
	LDA.w #$0057
	BCS.b CODE_01C27B
	LDA.w #$0058
CODE_01C27B:
	JSL.l CODE_0085D2
	LDY.w $0372
	BMI.b CODE_01C29D
	LDY.w $021A
	BEQ.b CODE_01C28D
	CPY.b #$0B
	BNE.b CODE_01C29D
CODE_01C28D:
	LDA.w #$0080
	TSB.w $0372
	INC.w $0D0F
	LDA.w #$002C
	STA.l $704070
CODE_01C29D:
	LDX.b #FXCODE_08B1EF>>16
	LDA.w #FXCODE_08B1EF
	JSL.l $7EDE67
	LDA.w $0B7F
	BEQ.b CODE_01C2AE
	DEC.w $0B7F
CODE_01C2AE:
	LDA.w $0B4C
	ORA.w $0B57
	ORA.w $0B59
	BNE.b CODE_01C2E2
	LDA.w $03B6
	CMP.w #$006D
	BCC.b CODE_01C2F2
	LDA.w $0387
	BEQ.b CODE_01C2FA
	LDA.w $0B7F
	BNE.b CODE_01C2EF
	LDA.b $35
	ORA.w $60AC
	ORA.w $0D0F
	BNE.b CODE_01C2E2
	LDA.w $0B7D
	CMP.w #$0060
	BCS.b CODE_01C2EF
	INC.w $0B7D
	BRA.b CODE_01C2E5

CODE_01C2E2:
	STZ.w $0B7D
CODE_01C2E5:
	LDY.w $0146
	CPY.b #$0D
	BEQ.b CODE_01C2EF
	JMP.w CODE_01C450

CODE_01C2EF:
	JMP.w CODE_01C3C7

CODE_01C2F2:
	STZ.w $0B7D
	LDA.w $0387
	BNE.b CODE_01C2EF
CODE_01C2FA:
	LDX.b #$04
	LDA.w $7680
	SEC
	SBC.w #$0008
	CMP.w #$00E0
	BCS.b CODE_01C314
	LDA.w $7682
	SEC
	SBC.w #$0010
	CMP.w #$00C1
	BCC.b CODE_01C342
CODE_01C314:
	LDA.w $7682
	SEC
	SBC.w #$0064
	STA.b $04
	BPL.b CODE_01C323
	EOR.w #$FFFF
	INC
CODE_01C323:
	STA.b $06
	LDA.w $7680
	SEC
	SBC.w #$0078
	STA.b $00
	BPL.b CODE_01C334
	EOR.w #$FFFF
	INC
CODE_01C334:
	STA.b $02
	CMP.b $06
	BCC.b CODE_01C33C
	LDX.b #$00
CODE_01C33C:
	LDA.b $00,x
	BPL.b CODE_01C342
	INX
	INX
CODE_01C342:
	LDA.w $7680
	CLC
	ADC.w DATA_01BFB0,x
	CMP.w #$0002
	BPL.b CODE_01C351
	LDA.w #$0002
CODE_01C351:
	CMP.w #$00EF
	BMI.b CODE_01C359
	LDA.w #$00EE
CODE_01C359:
	STA.b $02
	LDA.w $7682
	CLC
	ADC.w DATA_01BFB4,x
	CMP.w #$000A
	BPL.b CODE_01C36A
	LDA.w #$000A
CODE_01C36A:
	CMP.w #$00C8
	BMI.b CODE_01C372
	LDA.w #$00C7
CODE_01C372:
	STA.b $03
	TXA
	ASL
	ASL
	ASL
	TAX
	LDA.w $7974
	AND.w #$0004
	LSR
	ADC.w #$0002
	XBA
	STA.b $00
	CLC
	LDA.b $02
	ADC.w DATA_01BFBC,x
	STA.w $6A14
	LDA.w DATA_01BFBC+$02,x
	ORA.b $00
	STA.w $6A16
	LDA.b $02
	ADC.w DATA_01BFBC+$04,x
	STA.w $6A18
	LDA.w DATA_01BFBC+$06,x
	ORA.b $00
	STA.w $6A1A
	LDA.b $02
	ADC.w DATA_01BFBC+$08,x
	STA.w $6A1C
	LDA.w DATA_01BFBC+$0A,x
	ORA.b $00
	STA.w $6A1E
	LDA.b $02
	ADC.w DATA_01BFBC+$0C,x
	STA.w $6A20
	LDA.w DATA_01BFBC+$0E,x
	ORA.b $00
	STA.w $6A22
CODE_01C3C7:
	LDA.w $03A1
	BEQ.b CODE_01C3EC
	ASL
	TAX
	LDA.w DATA_01BF72,x
	STA.w $6140
	XBA
	TAX
	INX
	INX
	STX.w $6143
	LDA.w $03A3
	ASL
	TAX
	LDA.w DATA_01BF72,x
	STA.w $6144
	XBA
	TAX
	INX
	INX
	BRA.b CODE_01C405

CODE_01C3EC:
	LDA.w $03A3
	ASL
	TAX
	LDA.w DATA_01BF5E,x
	STA.w $6140
	CLC
	ADC.w #$0020
	STA.w $6144
	XBA
	TAX
	INX
	INX
	STX.w $6143
CODE_01C405:
	STX.w $6147
	LDX.b #$52
	STX.w $6142
	STX.w $6146
	LDA.w #$02AA
	STA.w $6C00
	STZ.w $6C02
	LDY.w $0146
	CPY.b #$0D
	BEQ.b CODE_01C437
	LDA.w $60B0
	SEC
	SBC.w #$0058
	CMP.w #$0040
	BCC.b CODE_01C43C
	LDX.b #$00
	LDA.w $60B0
	SEC
	SBC.w #$0078
	BPL.b CODE_01C439
CODE_01C437:
	LDX.b #$01
CODE_01C439:
	STX.w $0B81
CODE_01C43C:
	LDX.w $0B81
	LDY.w DATA_01BF86,x
	LDX.b #$12
CODE_01C444:
	LDA.w DATA_01BF86+$02,y
	STA.w $6A00,x
	DEY
	DEY
	DEX
	DEX
	BPL.b CODE_01C444
CODE_01C450:
	SEP.b #$20
	PLB
	RTL

DATA_01C454:
	dw CODE_01C47E
	dw CODE_01C493
	dw CODE_01C4D9
	dw CODE_01C54D
	dw CODE_01C584
	dw CODE_01C5BE
	dw CODE_01C5F2
	dw CODE_01C62D
	dw CODE_01C682
	dw CODE_01C6BB
	dw CODE_01C702
	dw CODE_01C728
	dw CODE_01C783
	dw CODE_01C7F2
	dw CODE_01C84E
	dw CODE_01C897
	dw CODE_01C8CB
	dw CODE_01C906
	dw CODE_01C955
	dw CODE_01C968
	dw CODE_01C968

CODE_01C47E:
	RTS

;---------------------------------------------------------------------------

DATA_01C47F:
	dw DATA_5FEB4A,DATA_5FEB64,DATA_5FEB7E,DATA_5FEB98,DATA_5FEBB2,DATA_5FEBCC,DATA_5FEBE6,DATA_5FEC00

DATA_01C48F:
	db $30,$10,$50,$10

CODE_01C493:
	REP.b #$20
	DEC.w $0B75
	LDA.w $0B75
	BPL.b CODE_01C4C0
	LDA.w $0B73
	INC
	INC
	AND.w #$000E
	STA.w $0B73
	BNE.b CODE_01C4BA
	JSL.l CODE_128875
	AND.w #$0003
	TAX
	LDA.w DATA_01C48F,x
	AND.w #$00FF
	BRA.b CODE_01C4BD

CODE_01C4BA:
	LDA.w #$0004
CODE_01C4BD:
	STA.w $0B75
CODE_01C4C0:
	LDX.w $0B73
	LDA.w DATA_01C47F,x
	STA.b $00
	LDA.w #$001A
	STA.b $0E
	LDX.b #$86
	JSR.w CODE_01C9CF
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01C4D5:
	db $00,$40,$40,$40

CODE_01C4D9:
	REP.b #$10
	LDA.w $608C
	SEC
	SBC.w $7E12
	BMI.b CODE_01C4FB
	BNE.b CODE_01C4F8
	LDY.w $60A8
	BNE.b CODE_01C4F6
	LDX.w $0B73
	CPX.w #$0001
	BEQ.b CODE_01C4FE
	STZ.w $0B75
CODE_01C4F6:
	LDA.b #$01
CODE_01C4F8:
	EOR.b #$FF
	INC
CODE_01C4FB:
	SEC
	SBC.b #$06
CODE_01C4FE:
	SEP.b #$10
	CLC
	ADC.w $0B75
	STA.w $0B75
	BPL.b CODE_01C54C
	LDX.w $0B73
	INX
	CPX.b #$04
	BCC.b CODE_01C513
	LDX.b #$00
CODE_01C513:
	STX.w $0B73
	LDA.l DATA_01C4D5,x
	BNE.b CODE_01C524
	LDA.w $7970
	AND.b #$E0
	CLC
	ADC.b #$20
CODE_01C524:
	STA.w $0B75
	TXA
	ASL
	ADC.w $0B73
	ASL
	TAX
	PHB
	LDA.b #$70200A>>16
	PHA
	PLB
	REP.b #$20
	LDY.b #$00
CODE_01C537:
	LDA.l DATA_5FA190,x
	STA.w $702D76,y
	STA.w $70200A,y
	INX
	INX
	INY
	INY
	CPY.b #$06
	BCC.b CODE_01C537
	SEP.b #$20
	PLB
CODE_01C54C:
	RTS

;---------------------------------------------------------------------------

CODE_01C54D:
	LDA.w $7974
	AND.b #$18
	ASL
	ASL
	ADC.b #$1E
	TAX
	PHB
	LDA.b #$7020E0>>16
	PHA
	PLB
	REP.b #$20
	LDY.b #$1E
CODE_01C560:
	LDA.l DATA_5FCCEA,x
	STA.w $702E4C,y
	STA.w $7020E0,y
CODE_01C56A:
	DEX
	DEX
	DEY
	DEY
	BPL.b CODE_01C560
	SEP.b #$20
	PLB
	RTS

;---------------------------------------------------------------------------

DATA_01C574:
	dw DATA_5FEA5A,DATA_5FEA78,DATA_5FEA96,DATA_5FEAB4,DATA_5FEAD2,DATA_5FEAF0,DATA_5FEB0E,DATA_5FEB2C

CODE_01C584:
	LDA.w $7974
	AND.b #$1C
	LSR
	TAX
	LDA.b #DATA_5FEA5A>>16
	STA.b $02
	REP.b #$20
	LDA.w $7FE4
	CLC
	ADC.w #$0000
	STA.w $7FE4
	LDA.w DATA_01C574,x
	STA.b $00
	PHB
	LDY.b #$7020E2>>16
	PHY
	PLB
	LDY.b #$00
CODE_01C5A7:
	LDA.b [$00],y
	STA.w $702E4E,y
	STA.w $7020E2,y
	INY
	INY
	CPY.b #$1E
	BCC.b CODE_01C5A7
	SEP.b #$20
	PLB
	LDA.b #$10
	STA.w $0D43
	RTS

;---------------------------------------------------------------------------

CODE_01C5BE:
	JSR.w CODE_01C644
CODE_01C5C1:
	INC.w $0B73
	LDA.w $0B73
	AND.b #$38
	ASL
	TAX
	PHB
	LDA.b #$7020E2>>16
	PHA
	PLB
	REP.b #$20
	LDY.b #$00
CODE_01C5D4:
	LDA.l DATA_5FDA00,x
	STA.w $702E4E,y
	STA.w $7020E2,y
	INX
	INX
	INY
	INY
	CPY.b #$10
	BCC.b CODE_01C5D4
	SEP.b #$20
	PLB
	RTS

;---------------------------------------------------------------------------

DATA_01C5EA:
	dw DATA_5FA150,DATA_5FA158,DATA_5FA160,DATA_5FA168

CODE_01C5F2:
	JSR.w CODE_01C5C1
	REP.b #$20
	LDA.w $7974
	AND.w #$0038
	LSR
	LSR
	TAX
	LDA.w DATA_01C634,x
	STA.b $00
	LDX.b #$86
	LDA.w #$001A
	STA.b $0E
	JSR.w CODE_01C9CF
	SEP.b #$20
CODE_01C611:
	LDA.w $7974
	AND.b #$18
	LSR
	LSR
	TAX
	REP.b #$20
	LDA.w DATA_01C5EA,x
	STA.b $00
	LDX.b #$A6
	LDA.w #$0008
	STA.b $0E
	JSR.w CODE_01C9CF
	SEP.b #$20
	RTS

CODE_01C62D:
	JSR.w CODE_01C5C1
	JSR.w CODE_01C5F2
	RTS

DATA_01C634:
	dw DATA_5FF5CE,DATA_5FF5F4,DATA_5FF61A,DATA_5FF640,DATA_5FF666,DATA_5FF68C,DATA_5FF6B2,DATA_5FF6D8

;---------------------------------------------------------------------------

CODE_01C644:
	LDA.w $0136
	AND.b #$07
	BNE.b CODE_01C679
	REP.b #$20
	LDA.w $7974
	AND.w #$0038
	LSR
	LSR
	TAX
	LDA.w DATA_01C634,x
	STA.b $00
	LDX.b #$86
	LDA.w #$001A
	STA.b $0E
	JSR.w CODE_01C9CF
	LDA.b $00
	CLC
	ADC.w #$001A
	STA.b $00
	LDX.b #$04
	LDA.w #$000C
	STA.b $0E
	JSR.w CODE_01C9CF
	SEP.b #$20
CODE_01C679:
	RTS

;---------------------------------------------------------------------------

DATA_01C67A:
	dw DATA_5FA170,DATA_5FA178,DATA_5FA180,DATA_5FA188

CODE_01C682:
	LDA.w $7974
	AND.b #$0C
	LSR
	TAX
	REP.b #$20
	LDA.w DATA_01C67A,x
	STA.b $00
CODE_01C690:
	LDX.b #$A6
	LDA.w #$0008
	STA.b $0E
	JSR.w CODE_01C9CF
	LDA.w $0136
	CMP.w #$000B
	BNE.b CODE_01C6A8
	LDA.w #$0024
	STA.w $0051
CODE_01C6A8:
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01C6AB:
	dw DATA_5FC932+$00,DATA_5FC932+$02,DATA_5FC932+$04,DATA_5FC932+$06
	dw DATA_5FC932+$08,DATA_5FC932+$06,DATA_5FC932+$04,DATA_5FC932+$02

CODE_01C6BB:
	LDA.b #DATA_5FC932>>16
	STA.b $02
	LDA.w $0B75
	INC
	STA.w $0B75
	CMP.b #$06
	BCC.b CODE_01C6D7
	STZ.w $0B75
	LDA.w $0B73
	INC
	INC
	AND.b #$0E
	STA.w $0B73
CODE_01C6D7:
	LDX.w $0B73
	LDA.b #DATA_5FC932>>16
	STA.b $02
	REP.b #$20
	LDA.w DATA_01C6AB,x
	STA.b $00
	LDA.b [$00]
	STA.l $702D6E
	STA.l $702002
	STA.l $702D7E
	STA.l $702012
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01C6FA:
	dw $E2EC,$E2F4,$E2FC,$E304

CODE_01C702:
	LDA.w $7974
	AND.b #$18
	LSR
	LSR
	TAX
	LDA.b #$5F
	STA.b $02
	REP.b #$20
	LDA.w DATA_01C6FA,x
	STA.b $00
	JMP.w CODE_01C690

;---------------------------------------------------------------------------

DATA_01C718:
	dw DATA_5FE336,DATA_5FE330,DATA_5FE32A,DATA_5FE324,DATA_5FE31E,DATA_5FE318,DATA_5FE312,DATA_5FE30C

CODE_01C728:
	REP.b #$20
	LDA.w $0B75
	INC
	CMP.w #$0070
	BCS.b CODE_01C738
	STA.w $0B75
	BRA.b CODE_01C770

CODE_01C738:
	LDA.w $7974
	AND.w #$007F
	BNE.b CODE_01C770
	SEP.b #$20
	LDA.b #$04
	STA.w $0967
	LDA.b #$13
	STA.w $0968
	LDA.b #$24
	STA.w $096C
	REP.b #$20
	LDA.w $0B73
	INC
	CMP.w #$0008
	BCS.b CODE_01C770
	STA.w $0B73
	ASL
	TAY
	LDA.w DATA_01C718,y
	STA.b $00
	LDX.b #$02
	LDA.w #$0006
	STA.b $0E
	JSR.w CODE_01C9CF
CODE_01C770:
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01C773:
	dw DATA_5FE30C,DATA_5FE312,DATA_5FE318,DATA_5FE31E,DATA_5FE324,DATA_5FE32A,DATA_5FE330,DATA_5FE336

CODE_01C783:
	REP.b #$20
	LDA.w $0B75
	INC
	CMP.w #$01A0
	BCS.b CODE_01C793
	STA.w $0B75
	BRA.b CODE_01C7CF

CODE_01C793:
	LDA.w $7974
	AND.w #$003F
	BNE.b CODE_01C770
	LDA.w $0B73
	INC
	CMP.w #$0008
	BCS.b CODE_01C7BA
	STA.w $0B73
	ASL
	TAY
	LDA.w DATA_01C773,y
	STA.b $00
	LDX.b #$02
	LDA.w #$0006
	STA.b $0E
	JSR.w CODE_01C9CF
	BRA.b CODE_01C7CF

CODE_01C7BA:
	LDA.w $0967
	EOR.w #$0004
	STA.w $0967
	LDA.w $096C
	EOR.w #$0004
	STA.w $096C
	STZ.w $014A
CODE_01C7CF:
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01C7D2:
	dw DATA_5FEC1A,DATA_5FEC20,DATA_5FEC26,DATA_5FEC2C,DATA_5FEC2C,DATA_5FEC26,DATA_5FEC20,DATA_5FEC1A

DATA_01C7E2:
	dw DATA_5FEC32,DATA_5FEC38,DATA_5FEC3E,DATA_5FEC44,DATA_5FEC44,DATA_5FEC3E,DATA_5FEC38,DATA_5FEC32

CODE_01C7F2:
	LDA.w $0B75
	INC
	CMP.b #$0C
	BCC.b CODE_01C7FF
	INC.w $0B73
	LDA.b #$00
CODE_01C7FF:
	STA.w $0B75
	LDA.w $0B73
	AND.b #$07
	ASL
	TAY
	REP.b #$20
	LDA.w $0140
	AND.w #$0001
	BNE.b CODE_01C818
	LDA.w DATA_01C7D2,y
	BRA.b CODE_01C81B

CODE_01C818:
	LDA.w DATA_01C7E2,y
CODE_01C81B:
	STA.b $00
	LDX.b #$02
	LDA.w #$0006
	STA.b $0E
	JSR.w CODE_01C9CF
	LDA.w #$0002
	STA.w $0D43
	LDA.w #$0002
	STA.w $0D4B
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01C836:
	dw DATA_5FF76E,DATA_5FF78E,DATA_5FF7AE,DATA_5FF7CE,DATA_5FF7EE,DATA_5FF80E,DATA_5FF82E,DATA_5FF84E

DATA_01C846:
	dw $00D0,$00C8

DATA_01C84A:
	dw $001C,$0038

CODE_01C84E:
	LDA.w $0136
	CMP.b #$08
	BNE.b CODE_01C85A
	JSR.w CODE_01C702
	BRA.b CODE_01C85D

CODE_01C85A:
	JSR.w CODE_01C611
CODE_01C85D:
	REP.b #$20
	LDA.w $013C
	AND.w #$0001
	ASL
	TAY
	ASL
	ASL
	ASL
	STA.b $00
	LDA.w DATA_01C846,y
	TAX
	LDA.w DATA_01C84A,y
	AND.w $7974
	DEY
	BMI.b CODE_01C87A
	LSR
CODE_01C87A:
	LSR
	TAY
	LDA.w DATA_01C836,y
	CLC
	ADC.b $00
	STA.b $00
	LDA.w #$0010
	STA.b $0E
	JSR.w CODE_01C9CF
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01C88F:
	dw DATA_5FF46A,DATA_5FF470,DATA_5FF476,DATA_5FF47C

CODE_01C897:
	REP.b #$20
	LDA.w $7974
	AND.w #$000C
	LSR
	TAX
	LDA.w DATA_01C88F,x
	STA.b $00
	LDA.w #$0006
	STA.b $0E
	LDX.b #$0A
	JSR.w CODE_01C9CF
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01C8B3:
	dw DATA_5FF760,DATA_5FF752,DATA_5FF744,DATA_5FF736,DATA_5FF728,DATA_5FF71A,DATA_5FF70C,DATA_5FF6FE

DATA_01C8C3:
	dw $00C0,$00A0,$00E0,$00A0

CODE_01C8CB:
	REP.b #$20
	LDA.w $0B77
	CMP.w #$0080
	BCS.b CODE_01C8EA
	LSR
	LSR
	AND.w #$000E
	TAX
	LDA.w DATA_01C8B3,x
	STA.b $00
	LDA.w #$000E
	STA.b $0E
	LDX.b #$92
	JSR.w CODE_01C9CF
CODE_01C8EA:
	DEC.w $0B77
	BPL.b CODE_01C900
	JSL.l CODE_128875
	ADC.b $30
	AND.w #$0003
	ASL
	TAX
	LDA.w DATA_01C8C3,x
	STA.w $0B77
CODE_01C900:
	SEP.b #$20
	JSR.w CODE_01C5C1
	RTS

;---------------------------------------------------------------------------

CODE_01C906:
	JSR.w CODE_01C84E
	REP.b #$20
	LDA.w #DATA_5FF95E
	STA.b $00
	SEP.b #$20
CODE_01C912:
	REP.b #$20
	LDA.w $0B79
	CMP.w #$0320
	BCC.b CODE_01C946
	CMP.w #$0520
	BCS.b CODE_01C952
	SBC.w #$031F
	AND.w #$FFE0
	LSR
	LSR
	ADC.b $00
	STA.b $00
	LDA.w #$0008
	STA.b $0E
	LDX.b #$00
	JSR.w CODE_01C9CF
	LDA.w #$1304
	STA.w $0967
	LDA.w $096C
	ORA.w #$0004
	STA.w $096C
CODE_01C946:
	CLC
	SED
	LDA.w $0B79
	ADC.w #$0001
	STA.w $0B79
	CLD
CODE_01C952:
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_01C955:
	JSR.w CODE_01C702
	JSR.w CODE_01C8CB
	REP.b #$20
	LDA.w #DATA_5FF9DE
	STA.b $00
	SEP.b #$20
	JSR.w CODE_01C912
	RTS

;---------------------------------------------------------------------------

CODE_01C968:
	JSR.w CODE_01C4D9
	JSR.w CODE_01C85D
	REP.b #$20
	LDA.w $7974
	AND.w #$0038
	LSR
	LSR
	TAX
	LDA.w DATA_01C634,x
	STA.b $00
	LDX.b #$86
	LDA.w #$001A
	STA.b $0E
	JSR.w CODE_01C9CF
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_01C98B:
	REP.b #$20
	LDA.w $0B79
	CMP.w #$0320
	BCC.b CODE_01C9C0
	CMP.w #$0520
	BCS.b CODE_01C9CC
	SBC.w #$031F
	AND.w #$FFE0
	LSR
	LSR
	ADC.w #DATA_5FF9DE
	STA.b $00
	LDA.w #$0008
	STA.b $0E
	LDX.b #$00
	JSR.w CODE_01C9CF
	LDA.w #$1304
	STA.w $0967
	LDA.w $096C
	ORA.w #$0004
	STA.w $096C
CODE_01C9C0:
	CLC
	SED
	LDA.w $0B79
	ADC.w #$0001
	STA.w $0B79
	CLD
CODE_01C9CC:
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_01C9CF:
	LDA.w #$005F
	STA.b $02
	PHB
	LDY.b #$702000>>16
	PHY
	PLB
	LDY.b #$00
CODE_01C9DB:
	LDA.b [$00],y
	STA.w $702D6C,x
	STA.w $702000,x
	INX
	INX
	INY
	INY
	CPY.b $0E
	BCC.b CODE_01C9DB
	PLB
	RTS

;---------------------------------------------------------------------------

DATA_01C9ED:
	dw $142A,$30E0,$143A,$30E2,$242A,$3100,$243A,$3102
	dw $1446,$30E4,$1456,$30E6,$2446,$3104,$2456,$3106
	dw $1462,$30E8,$1472,$30EA,$2462,$3108,$2472,$310A
	dw $147E,$30EC,$148E,$30EE,$247E,$310C,$248E,$310E
	dw $149A,$3120,$14AA,$3122,$249A,$3128,$24AA,$312A

DATA_01CA3D:
	db $00,$04,$08,$0C,$10

DATA_01CA42:
	db $FC,$04,$FC,$04,$FC,$04,$FC,$04
	db $FC,$04,$FC,$01,$00

DATA_01CA4F:
	db $20,$34

DATA_01CA51:
	db $20,$34

DATA_01CA53:
	db $20,$34,$20,$34,$20,$34,$20,$34
	db $00,$04,$FF,$40,$10

DATA_01CA60:
	db $00,$01,$02,$03,$04

DATA_01CA65:
	db $10,$30,$50,$70,$10

DATA_01CA6A:
	db $50,$50,$50,$50,$70

DATA_01CA6F:
	db $01,$00,$02,$00

DATA_01CA73:
	dw CODE_01CAF7
	dw CODE_01CB2F
	dw CODE_01CB60
	dw CODE_01CB7C
	dw CODE_01CBA9
	dw CODE_01CBBF
	dw CODE_01CC0B
	dw CODE_01CC2F
	dw CODE_01CC5C
	dw CODE_01CC8E
	dw CODE_01CAEE
	dw CODE_01CC98
	dw CODE_01CC98
	dw CODE_01CC98
	dw CODE_01CC98
	dw CODE_01CC98
	dw CODE_01CC98
	dw CODE_01CC98
	dw CODE_01CCB1
	dw CODE_01CE34

CODE_01CA9B:
	REP.b #$30
	LDA.w $0B0F
	AND.w #$00FF
	ASL
	TAX
	LDA.w $0B10
	AND.w #$00FF
	ASL
	TAY
	JSR.w (DATA_01CA73-$02,x)
	SEP.b #$30
	LDA.w $0B0F
	CMP.b #$0B
	BCC.b CODE_01CAC4
	LDA.w $0CF6
	BEQ.b CODE_01CAC4
	JSR.w CODE_01DE0A
	JSR.w CODE_01CAD6
CODE_01CAC4:
	PLB
	RTL

DATA_01CAC6:
	dw $7C00,$7C1F,$001F,$03FF,$03E0,$03FF,$001F,$7C1F

CODE_01CAD6:
	REP.b #$20
	LDA.b $30
	AND.w #$0038
	LSR
	LSR
	TAX
	LDA.w DATA_01CAC6,x
	STA.l $70203C
	SEP.b #$20
	RTS

DATA_01CAEA:
	dw $CB1E,$CB13

CODE_01CAEE:
	SEP.b #$30
	LDA.w $0B10
	EOR.b #$01
	BRA.b CODE_01CAFC

CODE_01CAF7:
	SEP.b #$30
	LDA.w $0B10
CODE_01CAFC:
	PHA
	ASL
	TAX
	LDA.w $0200
	JSR.w (DATA_01CAEA,x)
	PLA
	EOR.w $0B10
	BEQ.b CODE_01CB0C
	RTS

CODE_01CB0C:
	REP.b #$20
	PLA
	JML.l CODE_01C2E2

CODE_01CB13:
	DEC
	DEC
	BPL.b CODE_01CB2B
	JSR.w CODE_01CE5D
	LDA.b #$80
	BRA.b CODE_01CB2B

CODE_01CB1E:
	AND.b #$0F
	INC
	INC
	CMP.b #$0F
	BCC.b CODE_01CB2B
	JSR.w CODE_01CE5D
	LDA.b #$0F
CODE_01CB2B:
	STA.w $0200
	RTS

CODE_01CB2F:
	SEP.b #$30
	JSL.l CODE_00824B
	REP.b #$30
	LDA.w $0B10
	BNE.b CODE_01CB54
	STZ.w $093C
	STZ.w $093E
	STZ.w $0940
	STZ.w $0942
	STZ.b $35
	STZ.b $37
	SEP.b #$30
	JSL.l CODE_01C188
	REP.b #$30
CODE_01CB54:
	JSR.w CODE_01CE5D
	RTS

DATA_01CB58:
	dw $5400,$D400

DATA_01CB5C:
	dw $1000,$1002

CODE_01CB60:
	TYX
	LDA.w DATA_01CA6F,x
	STA.b $53
	LDA.w #$7BBE
	STA.b $00
	LDY.w DATA_01CB5C,x
	LDA.w DATA_01CB58,x
	JMP.w CODE_01CBCB

DATA_01CB74:
	dw $4E00,$CE00

DATA_01CB78:
	dw $0C00,$0C02

CODE_01CB7C:
	SEP.b #$30
	LDX.b #$35
CODE_01CB80:
	STZ.w $0B12,x
	DEX
	BPL.b CODE_01CB80
	LDX.b #$04
CODE_01CB88:
	LDA.w DATA_01CA3D,x
	STA.w $0B42,x
	DEX
	BPL.b CODE_01CB88
	REP.b #$30
	TYX
	LDA.w #$7BBE
	CLC
	ADC.w DATA_01CB5C+$02
	STA.b $00
	LDY.w DATA_01CB78,x
	LDA.w DATA_01CB74,x
	BRA.b CODE_01CBCB

DATA_01CBA5:
	dw $2800,$A800

CODE_01CBA9:
	TYX
	LDA.w #$97C4
	STA.b $00
	LDY.w DATA_01CB5C,x
	LDA.w DATA_01CBA5,x
	BRA.b CODE_01CBCB

DATA_01CBB7:
	dw $3400,$B400

DATA_01CBBB:
	dw $0800,$0802

CODE_01CBBF:
	TYX
	LDA.w #$A7C6
	STA.b $00
	LDY.w DATA_01CBBB,x
	LDA.w DATA_01CBB7,x
CODE_01CBCB:
	PHB
	PEA.w $7E4800>>8
	PLB
	PLB
	LDX.w $7E4800
	STA.w $0000,x
	ASL
	LDA.w #$0080
	STA.w $0002,x
	LDA.w #$007E
	STA.w $0007,x
	TYA
	STA.w $0008,x
	LDA.w #$3981
	LDY.b $00
	BCS.b CODE_01CBF4
	LDA.w #$1801
	INY
	INY
CODE_01CBF4:
	STA.w $0003,x
	TYA
	STA.w $0005,x
	TXA
	CLC
	ADC.w #$000C
	STA.w $000A,x
	STA.w $7E4800
	PLB
	JSR.w CODE_01CE5D
	RTS

CODE_01CC0B:
	TYA
	BEQ.b CODE_01CC2B
	LDX.w #DATA_568000+$6800
	LDA.w #DATA_568000+$6800>>16
	LDY.w $0B48
	BEQ.b CODE_01CC1F
	LDX.w #DATA_520000+$B000
	LDA.w #DATA_520000+$B000>>16
CODE_01CC1F:
	STA.b $01
	LDY.w #$5400
	LDA.w #$0400
	JSL.l CODE_00BEA6
CODE_01CC2B:
	JSR.w CODE_01CE5D
	RTS

CODE_01CC2F:
	TYA
	BEQ.b CODE_01CC48
	LDA.w #$004F
	JSL.l CODE_00B753
	LDX.w #$706800>>16
	STX.b $01
	LDX.w #$706800
	LDY.w #$2C00
	JSL.l CODE_00BEA6
CODE_01CC48:
	JSR.w CODE_01CE5D
	RTS

DATA_01CC4C:
	dw $7EAFC8>>16,$00095E>>16,$7EAFC8>>16

DATA_01CC52:
	dw $7EAFC8,$00095E,$7EAFC8

DATA_01CC58:
	dw CODE_01CE83
	dw CODE_01CEB7

CODE_01CC5C:
	JSR.w CODE_01CE5D
	TYX
	JSR.w (DATA_01CC58,x)
	LDA.w DATA_01CC4C,y
	STA.b $02
	LDA.w DATA_01CC52,y
	STA.b $00
	INY
	INY
	LDA.w DATA_01CC4C,y
	STA.b $05
	LDA.w DATA_01CC52,y
	STA.b $03
	LDY.w #$0000
	TYX
	SEP.b #$20
CODE_01CC7F:
	LDA.b [$00],y
	STA.b [$03],y
	INY
	CPY.w #$000E
	BCC.b CODE_01CC7F
	RTS

DATA_01CC8A:
	dw CODE_01CF07
	dw CODE_01CF1F

CODE_01CC8E:
	JSR.w CODE_01CE5D
	PHB
	SEP.b #$10
	TYX
	JMP.w (DATA_01CC8A,x)

CODE_01CC98:
	JSR.w CODE_01CE5D
	SEP.b #$30
	LDA.w $0B0F
	SEC
	SBC.b #$0C
	ASL
	ASL
	ASL
	LDX.b #$04
CODE_01CCA8:
	STA.w $0B36,x
	DEX
	BPL.b CODE_01CCA8
	JMP.w CODE_01CD56

CODE_01CCB1:
	SEP.b #$30
	LDA.w $0357
	BEQ.b CODE_01CCBB
	JSR.w CODE_01DBD5
CODE_01CCBB:
	LDA.w $0398
	BEQ.b CODE_01CCC6
	LDA.b $37
	AND.b #$80
	BNE.b CODE_01CCCC
CODE_01CCC6:
	ORA.b $38
	AND.b #$90
	BEQ.b CODE_01CCCF
CODE_01CCCC:
	JSR.w CODE_01CE5D
CODE_01CCCF:
	LDX.b #$04
CODE_01CCD1:
	LDA.w $0B42,x
	BEQ.b CODE_01CCE1
	LDA.b $30
	AND.b #$03
	BNE.b CODE_01CD50
	DEC.w $0B42,x
	BRA.b CODE_01CD50

CODE_01CCE1:
	LDY.w $0B3C,x
	LDA.b $30
	AND.b #$03
	BNE.b CODE_01CCFC
	LDA.w $0B36,x
	CLC
	ADC.w DATA_01CA42,y
	STA.w $0B36,x
	CMP.w DATA_01CA4F,y
	BNE.b CODE_01CCFC
	INC.w $0B3C,x
CODE_01CCFC:
	CPY.b #$0B
	BCC.b CODE_01CD50
	LDA.w $0B1E,x
	CMP.w DATA_01CA53,y
	BNE.b CODE_01CD21
	CPY.b #$0B
	BEQ.b CODE_01CD30
	LDA.w $0B12,x
	BNE.b CODE_01CD30
	STZ.w $0B3C,x
	STZ.w $0B1E,x
	STZ.w $0B2A,x
	LDA.b #$20
	STA.w $0B42,x
	BRA.b CODE_01CD56

CODE_01CD21:
	LDA.b $30
	LSR
	BCS.b CODE_01CD30
	LDA.w $0B1E,x
	CLC
	ADC.w DATA_01CA51,y
	STA.w $0B1E,x
CODE_01CD30:
	LDA.w $0B1E,x
	TAY
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w $0B2A,x
	STA.w $0B2A,x
	TYA
	PHP
	LSR
	LSR
	LSR
	LSR
	PLP
	BPL.b CODE_01CD4A
	ORA.b #$F0
CODE_01CD4A:
	ADC.w $0B12,x
	STA.w $0B12,x
CODE_01CD50:
	DEX
	BMI.b CODE_01CD56
	JMP.w CODE_01CCD1

CODE_01CD56:
	REP.b #$20
	LDA.w #$6800
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$0800
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08D2F1>>16
	LDA.w #FXCODE_08D2F1
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b #$04
CODE_01CD6F:
	LDA.w DATA_01CA60,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $0B12,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w DATA_01CA65,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w DATA_01CA6A,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w $0B36,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	PHX
	LDX.b #FXCODE_08F165>>16
	LDA.w #FXCODE_08F165
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PLX
	DEX
	BPL.b CODE_01CD6F
	LDA.w #$7400
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$7100
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0080
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$0001
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDX.b #FXCODE_08D2FB>>16
	LDA.w #FXCODE_08D2FB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$7600
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$7300
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0080
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$0001
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDX.b #FXCODE_08D2FB>>16
	LDA.w #FXCODE_08D2FB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$AAAA
	STA.l $006C00
	STA.l $006C02
	STA.l $006C04
	STA.l $006C06
	SEP.b #$20
	STZ.b $00
	LDA.b #$10
	STA.b $00
	LDX.b #$00
CODE_01CE0C:
	LDA.w DATA_01C9ED,x
	CLC
	ADC.b $00
	STA.l $006A00,x
	LDA.w DATA_01C9ED+$01,x
	STA.l $006A01,x
	LDA.w DATA_01C9ED+$02,x
	STA.l $006A02,x
	LDA.w DATA_01C9ED+$03,x
	STA.l $006A03,x
	INX
	INX
	INX
	INX
	CPX.b #$50
	BCC.b CODE_01CE0C
	RTS

CODE_01CE34:
	SEP.b #$30
	LDA.w $0398
	BEQ.b CODE_01CE48
	INC.w $0B11
	LDA.w $0B11
	CMP.b #$20
	BCC.b CODE_01CE58
	STZ.w $0B11
CODE_01CE48:
	LDA.w $0B10
	EOR.b #$01
	AND.b #$01
	STA.w $0B10
	JSR.w CODE_01CE5D
	JSR.w CODE_01CE5D
CODE_01CE58:
	JMP.w CODE_01CD56

DATA_01CE5B:
	db $FF,$01

CODE_01CE5D:
	PHY
	PHP
	SEP.b #$20
	LDY.w $0B10
	LDA.w $0B0F
	CLC
	ADC.w DATA_01CE5B,y
	STA.w $0B0F
	BNE.b CODE_01CE80
	LDA.w $0398
	BEQ.b CODE_01CE80
	LDA.b #$27
	JSL.l CODE_0085D2
	LDA.b #$40
	STA.w $039C
CODE_01CE80:
	PLP
	PLY
	RTS

CODE_01CE83:
	LDA.l $7EAFD7
	STA.b $41
	LDA.l $7EAFD9
	STA.b $43
	LDA.l $7EAFDB
	STA.w $094A
	LDA.l $7EAFDD
	STA.w $0948
	SEP.b #$20
	LDA.l $7EB6DF
	STA.w $011C
	LDA.l $7EB8E0
	STA.w $095B
	LDA.l $7EB8E1
	STA.w $096C
	REP.b #$20
	RTS

CODE_01CEB7:
	LDA.b $41
	STA.l $7EAFD7
	LDA.b $43
	STA.l $7EAFD9
	LDA.w $094A
	STA.l $7EAFDB
	LDA.w $0948
	STA.l $7EAFDD
	SEP.b #$20
	LDA.w $011C
	STA.l $7EB6DF
	LDA.w $095B
	STA.l $7EB8E0
	STZ.w $095B
	LDA.w $096C
	STA.l $7EB8E1
	LDA.b #$20
	STA.w $096C
	REP.b #$20
	PHY
	LDA.w #DATA_568000+$5000>>16
	STA.b $01
	LDY.w #$2800
	LDX.w #DATA_568000+$5000
	LDA.w #$0800
	JSL.l CODE_00BEA6
	PLY
	RTS

CODE_01CF07:
	LDX.b #$00
CODE_01CF09:
	LDA.l $7EB6E0,x
	STA.l $702000,x
	LDA.l $7EB7E0,x
	STA.l $702100,x
	INX
	INX
	BNE.b CODE_01CF09
	PLB
	RTS

CODE_01CF1F:
	LDA.w #$0000
	STA.b $41
	STA.b $43
	STA.w $0948
	TAX
	STX.w $094A
	LDY.b #$702000>>16
	PHY
	PLB
CODE_01CF31:
	LDA.w $702000,x
	STA.l $7EB6E0,x
	LDA.w $702100,x
	STA.l $7EB7E0,x
	INX
	INX
	BNE.b CODE_01CF31
	LDA.w #$0000
	TAX
	TXY
CODE_01CF48:
	STA.w $702000,x
	STA.w $702100,x
	INX
	INX
	BNE.b CODE_01CF48
	TYX
CODE_01CF53:
	LDA.l DATA_5FA002,x
	STA.w $702002,x
	LDA.l DATA_5FA022,x
	STA.w $702022,x
	LDA.l DATA_5FA1C8,x
	STA.w $702102,x
	LDA.l DATA_5FA1E6,x
	STA.w $702122,x
	LDA.l DATA_5FA204,x
	STA.w $702142,x
	INX
	INX
	CPX.b #$1E
	BCC.b CODE_01CF53
	LDX.b #$7EAFDF>>16
	PHX
	PLB
	LDX.b #$00
	LDA.w #$217F
CODE_01CF85:
	STA.w $7EAFDF,x
	STA.w $7EB0DF,x
	STA.w $7EB1DF,x
	STA.w $7EB2DF,x
	STA.w $7EB3DF,x
	STA.w $7EB4DF,x
	STA.w $7EB5DF,x
	INX
	INX
	BNE.b CODE_01CF85
	LDX.b #$00
	STX.b $00
	TXY
CODE_01CFA3:
	LDA.b $00
	ASL
	TAX
	LDA.l DATA_01B689,x
	STA.w $7EB3E7,y
	LDX.b $00
	CPX.b #$15
	BCS.b CODE_01CFCA
	LDA.l DATA_01B835,x
	AND.w #$00FF
	TAX
	LDA.l DATA_01B85F,x
	STA.w $7EB42D,y
	LDA.l DATA_01B8DD,x
	STA.w $7EB46D,y
CODE_01CFCA:
	LDX.b $00
	CPX.b #$15
	BCS.b CODE_01CFE6
	LDA.l DATA_01B84A,x
	AND.w #$00FF
	TAX
	LDA.l DATA_01B85F,x
	STA.w $7EB4ED,y
	LDA.l DATA_01B8DD,x
	STA.w $7EB52D,y
CODE_01CFE6:
	INY
	INY
	INC.b $00
	LDX.b $00
	CPX.b #$18
	BCC.b CODE_01CFA3
	JSR.w CODE_01D035
	JSR.w CODE_01D0DE
	JSR.w CODE_01D17A
	JSR.w CODE_01D203
	JSR.w CODE_01D275
	JSR.w CODE_01D35B
	JSR.w CODE_01D2E0
	REP.b #$10
	LDY.w #$7EAFDF>>16
	STY.b $01
	LDY.w #$3400
	LDX.w #$7EAFDF
	LDA.w #$0700
	JSL.l CODE_00BEA6
	SEP.b #$10
	PLB
	LDX.b #$09
	STX.w $095E
	LDX.b #$34
	STX.w $0961
	LDX.b #$02
	STX.w $0963
	STX.w $011C
	LDA.w #$0014
	STA.w $0967
	RTS

;---------------------------------------------------------------------------

CODE_01D035:
	STZ.b $18
	LDY.b #$00
	STZ.b $00
	LDA.l $0003B6
	BEQ.b CODE_01D05D
CODE_01D041:
	CMP.w #$000A
	BCC.b CODE_01D04E
	SEC
	SBC.w #$000A
	INC.b $00
	BRA.b CODE_01D041

CODE_01D04E:
	LDA.b $00
	CMP.w #$001E
	BCC.b CODE_01D05D
	LDA.w #$0400
	STA.b $18
	LDA.w #$001E
CODE_01D05D:
	STA.b $00
CODE_01D05F:
	CMP.w #$000A
	BCC.b CODE_01D06A
	SBC.w #$000A
	INY
	BRA.b CODE_01D05F

CODE_01D06A:
	ASL
	TAX
	PHX
	PHY
	LDX.b #$00
	TXY
CODE_01D071:
	PHX
	LDA.l DATA_01B7ED,x
	AND.w #$00FF
	TAX
	LDA.l DATA_01B85F,x
	ORA.b $18
	STA.w $7EB1A7,y
	LDA.l DATA_01B8DD,x
	ORA.b $18
	STA.w $7EB1E7,y
	PLX
	INY
	INY
	INX
	CPX.b #$18
	BCC.b CODE_01D071
	PLY
	PLX
	LDA.b $00
	PHA
	REP.b #$10
	PHX
	PHY
	SEP.b #$10
	LDA.w #$7EB1C1
	STA.b $10
	LDA.w #$7EB1CF
	STA.b $12
	LDA.w #$7EB201
	STA.b $14
	LDA.w #$7EB20F
	STA.b $16
	JSR.w CODE_01D45E
	REP.b #$10
	PLA
	AND.w #$00FF
	TAX
	PLA
	AND.w #$00FF
	STA.b $00
	LDA.b $18
	STA.b $02
	LDA.w #$007E
	STA.b $15
	LDA.w #$B215
	STA.b $13
	PHB
	PHK
	PLB
	JSR.w CODE_01BCAA
	PLB
	SEP.b #$10
	PLA
	STA.b $00
	RTS

;---------------------------------------------------------------------------

CODE_01D0DE:
	STZ.b $18
	LDY.b #$00
	LDA.l $0003B4
	CMP.w #$0014
	BCC.b CODE_01D0F3
	LDA.w #$0400
	STA.b $18
	LDA.w #$0014
CODE_01D0F3:
	STA.b $02
CODE_01D0F5:
	CMP.w #$000A
	BCC.b CODE_01D100
	SBC.w #$000A
	INY
	BRA.b CODE_01D0F5

CODE_01D100:
	ASL
	TAX
	PHX
	PHY
	LDX.b #$00
	TXY
CODE_01D107:
	PHX
	LDA.l DATA_01B805,x
	AND.w #$00FF
	TAX
	LDA.l DATA_01B85F,x
	ORA.b $18
	STA.w $7EB267,y
	LDA.l DATA_01B8DD,x
	ORA.b $18
	STA.w $7EB2A7,y
	PLX
	INY
	INY
	INX
	CPX.b #$18
	BCC.b CODE_01D107
	PLY
	PLX
	LDA.b $00
	PHA
	LDA.b $02
	PHA
	REP.b #$10
	PHX
	PHY
	SEP.b #$10
	LDA.w #$7EB281
	STA.b $10
	LDA.w #$7EB28F
	STA.b $12
	LDA.w #$7EB2C1
	STA.b $14
	LDA.w #$7EB2CF
	STA.b $16
	JSR.w CODE_01D45E
	REP.b #$10
	PLA
	AND.w #$00FF
	TAX
	PLA
	AND.w #$00FF
	STA.b $00
	LDA.b $18
	STA.b $02
	LDA.w #$007E
	STA.b $15
	LDA.w #$B2D5
	STA.b $13
	PHB
	PHK
	PLB
	JSR.w CODE_01BCAA
	PLB
	SEP.b #$10
	PLA
	STA.b $02
	PLA
	STA.b $00
	RTS

;---------------------------------------------------------------------------

CODE_01D17A:
	STZ.b $18
	LDA.l $0003B8
	ASL
	TAX
	CPX.b #$0A
	BCC.b CODE_01D18B
	LDA.w #$0400
	STA.b $18
CODE_01D18B:
	PHX
	LDX.b #$00
	TXY
CODE_01D18F:
	PHX
	LDA.l DATA_01B81D,x
	AND.w #$00FF
	TAX
	LDA.l DATA_01B85F,x
	ORA.b $18
	STA.w $7EB327,y
	LDA.l DATA_01B8DD,x
	ORA.b $18
	STA.w $7EB367,y
	PLX
	INY
	INY
	INX
	CPX.b #$18
	BCC.b CODE_01D18F
	PLX
	LDA.b $00
	PHA
	LDA.b $02
	PHA
	REP.b #$10
	PHX
	SEP.b #$10
	LDA.l DATA_01B8AF,x
	ORA.b $18
	STA.w $7EB345
	TXY
	BEQ.b CODE_01D1CD
	STA.w $7EB34F
CODE_01D1CD:
	LDA.l DATA_01B92D,x
	ORA.b $18
	STA.w $7EB385
	TXY
	BEQ.b CODE_01D1DC
	STA.w $7EB38F
CODE_01D1DC:
	REP.b #$10
	PLA
	AND.w #$00FF
	TAX
	STX.b $00
	LDA.b $18
	STA.b $02
	LDA.w #$007E
	STA.b $15
	LDA.w #$B395
	STA.b $13
	PHB
	PHK
	PLB
	JSR.w CODE_01BCAA
	PLB
	SEP.b #$10
	PLA
	STA.b $02
	PLA
	STA.b $00
	RTS

;---------------------------------------------------------------------------

CODE_01D203:
	STZ.b $18
	LDY.b #$00
	LDA.l $0003B8
	ASL
	STA.b $0E
	ASL
	ASL
	ADC.b $0E
	CLC
	ADC.b $00
	CLC
	ADC.b $02
	STA.b $00
	CMP.w #$0064
	BCC.b CODE_01D226
	LDA.w #$000A
	TAY
	INY
	BRA.b CODE_01D231

CODE_01D226:
	CMP.w #$000A
	BCC.b CODE_01D231
	SBC.w #$000A
	INY
	BRA.b CODE_01D226

CODE_01D231:
	ASL
	TAX
	LDA.b $00
	PHA
	REP.b #$10
	PHX
	PHY
	SEP.b #$10
	LDA.w #$7EB44F
	STA.b $10
	STA.b $12
	LDA.w #$7EB48F
	STA.b $14
	STA.b $16
	JSR.w CODE_01D45E
	REP.b #$10
	PLA
	AND.w #$00FF
	TAX
	PLA
	AND.w #$00FF
	STA.b $00
	LDA.b $18
	STA.b $02
	LDA.w #$007E
	STA.b $15
	LDA.w #$B495
	STA.b $13
	PHB
	PHK
	PLB
	JSR.w CODE_01BCAA
	PLB
	SEP.b #$10
	PLA
	STA.b $00
	RTS

;---------------------------------------------------------------------------

CODE_01D275:
	LDY.b #$00
	LDA.l $00021A
	TAX
	LDA.l $0002B8,x
	AND.w #$00FF
	CMP.b $00
	BCS.b CODE_01D289
	LDA.b $00
CODE_01D289:
	CMP.w #$0064
	BCC.b CODE_01D295
	LDA.w #$000A
	TAY
	INY
	BRA.b CODE_01D2A0

CODE_01D295:
	CMP.w #$000A
	BCC.b CODE_01D2A0
	SBC.w #$000A
	INY
	BRA.b CODE_01D295

CODE_01D2A0:
	ASL
	TAX
	REP.b #$10
	PHX
	PHY
	SEP.b #$10
	LDA.w #$7EB50F
	STA.b $10
	STA.b $12
	LDA.w #$7EB54F
	STA.b $14
	STA.b $16
	STZ.b $18
	JSR.w CODE_01D45E
	REP.b #$10
	PLA
	AND.w #$00FF
	TAX
	PLA
	AND.w #$00FF
	STA.b $00
	LDA.b $18
	STA.b $02
	LDA.w #$007E
	STA.b $15
	LDA.w #$B555
	STA.b $13
	PHB
	PHK
	PLB
	JSR.w CODE_01BCAA
	PLB
	SEP.b #$10
	RTS

;---------------------------------------------------------------------------

CODE_01D2E0:
	PHB
	PHK
	PLB
	STZ.w $0CF6
	STZ.w $0CF7
	SEP.b #$20
	LDX.b #$00
	TXY
CODE_01D2EE:
	LDA.w $0357,x
	AND.b #$0F
	BEQ.b CODE_01D2F9
	STA.w $0357,y
	INY
CODE_01D2F9:
	INX
	CPX.b #$1B
	BCC.b CODE_01D2EE
	TYX
CODE_01D2FF:
	CPX.b #$1B
	BCS.b CODE_01D309
	STZ.w $0357,x
	INX
	BRA.b CODE_01D2FF

CODE_01D309:
	LDA.w $0357
	BEQ.b CODE_01D32F
	LDY.b #$00
	LDA.w $0CF4
	BNE.b CODE_01D31B
	STZ.w $0CF5
	INC.w $0CF4
CODE_01D31B:
	LDX.w $0CF5
CODE_01D31E:
	LDA.w $0357,x
	STA.w $0CF6,y
	INX
	INY
	CPY.b #$03
	BCC.b CODE_01D31E
	REP.b #$20
	JSR.w CODE_01DDB0
CODE_01D32F:
	REP.b #$20
	PLB
	RTS

;---------------------------------------------------------------------------

DATA_01D333:
	dw $1DA8,$1D80,$1D82,$1D84,$1D86,$1D88,$1DA0,$1DA2
	dw $1DA4,$1DA6

DATA_01D347:
	dw $1DB8,$1D90,$1D92,$1D94,$1D96,$1D98,$1DB0,$1DB2
	dw $1DB4,$1DB6

CODE_01D35B:
	LDX.b #$00
CODE_01D35D:
	LDA.w #$9D8B
	STA.w $7EB59F,x
	LDA.w #$1D8B
	STA.w $7EB65F,x
	LDA.w #$09AF
	STA.w $7EB5DF,x
	STA.w $7EB61F,x
	INX
	INX
	CPX.b #$40
	BCC.b CODE_01D35D
	LDA.w #$098C
	STA.w $7EB5E1
	INC
	STA.w $7EB5E3
	INC
	STA.w $7EB621
	INC
	STA.w $7EB623
	LDX.b #$00
	TXY
	LDA.l $000379
CODE_01D391:
	CMP.w #$0064
	BCC.b CODE_01D39C
	SBC.w #$0064
	INY
	BRA.b CODE_01D391

CODE_01D39C:
	CMP.w #$000A
	BCC.b CODE_01D3A7
	SBC.w #$000A
	INX
	BRA.b CODE_01D39C

CODE_01D3A7:
	CPY.b #$00
	BNE.b CODE_01D3B9
	TXY
	TAX
	LDA.w #$000A
	CPY.b #$00
	BNE.b CODE_01D3B9
	TXY
	TAX
	LDA.w #$000A
CODE_01D3B9:
	ORA.w #$0DC0
	STA.w $7EB629
	TXA
	ORA.w #$0DC0
	STA.w $7EB627
	TYA
	ORA.w #$0DC0
	STA.w $7EB625
	LDA.w #$0DD2
	STA.w $7EB5EB
	INC
	STA.w $7EB5ED
	INC
	STA.w $7EB62B
	INC
	STA.w $7EB62D
	LDX.b #$00
	LDA.l $00037B
CODE_01D3E5:
	CMP.w #$000A
	BCC.b CODE_01D3F0
	SBC.w #$000A
	INX
	BRA.b CODE_01D3E5

CODE_01D3F0:
	CPX.b #$00
	BNE.b CODE_01D3F8
	TAX
	LDA.w #$000A
CODE_01D3F8:
	ORA.w #$0DC0
	STA.w $7EB631
	TXA
	ORA.w #$0DC0
	STA.w $7EB62F
	LDA.w #$0DCB
	STA.w $7EB5F5
	INC
	STA.w $7EB5F7
	INC
	STA.w $7EB635
	INC
	STA.w $7EB637
	LDA.l $0003A1
	ASL
	TAX
	LDA.l DATA_01D333,x
	STA.w $7EB5F9
	INC
	STA.w $7EB5FB
	LDA.l DATA_01D347,x
	STA.w $7EB639
	INC
	STA.w $7EB63B
	LDA.l $0003A3
	ASL
	TAX
	LDA.l DATA_01D333,x
	STA.w $7EB5FD
	INC
	STA.w $7EB5FF
	LDA.l DATA_01D347,x
	STA.w $7EB63D
	INC
	STA.w $7EB63F
	JSR.w CODE_01D490
	SEP.b #$20
	PHB
	PHK
	PLB
	JSR.w CODE_01DCE0
	PLB
	REP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_01D45E:
	PHY
	LDY.b #$02
	LDA.l DATA_01B8AF,x
	ORA.b $18
	STA.b ($10),y
	STA.b ($12),y
	LDA.l DATA_01B92D,x
	ORA.b $18
	STA.b ($14),y
	STA.b ($16),y
	PLY
	BEQ.b CODE_01D48F
	TYA
	ASL
	TAX
	LDA.l DATA_01B8AF,x
	ORA.b $18
	STA.b ($10)
	STA.b ($12)
	LDA.l DATA_01B92D,x
	ORA.b $18
	STA.b ($14)
	STA.b ($16)
CODE_01D48F:
	RTS

;---------------------------------------------------------------------------

CODE_01D490:
	LDA.w #$1DAC
	STA.w $7EB5C7
	LDA.w #$1D9C
	STA.w $7EB607
	STA.w $7EB647
	LDA.w #$9DAC
	STA.w $7EB687
	LDA.w #$1DAD
	STA.w $7EB5C9
	STA.w $7EB5CF
	STA.w $7EB5D5
	LDA.w #$5DAD
	STA.w $7EB5CB
	STA.w $7EB5D1
	STA.w $7EB5D7
	LDA.w #$9DAD
	STA.w $7EB689
	STA.w $7EB68F
	STA.w $7EB695
	LDA.w #$DDAD
	STA.w $7EB68B
	STA.w $7EB691
	STA.w $7EB697
	LDA.w #$1DAE
	STA.w $7EB5CD
	STA.w $7EB5D3
	LDA.w #$9DAE
	STA.w $7EB68D
	STA.w $7EB693
	LDA.w #$1D9E
	STA.w $7EB60D
	STA.w $7EB613
	STA.w $7EB64D
	STA.w $7EB653
	LDA.w #$5DAC
	STA.w $7EB5D9
	LDA.w #$5D9C
	STA.w $7EB619
	STA.w $7EB659
	LDA.w #$DDAC
	STA.w $7EB699
	LDA.w #$117F
	STA.w $7EB609
	STA.w $7EB649
	STA.w $7EB60B
	STA.w $7EB64B
	STA.w $7EB60F
	STA.w $7EB64F
	STA.w $7EB611
	STA.w $7EB651
	STA.w $7EB615
	STA.w $7EB655
	STA.w $7EB617
	STA.w $7EB657
	RTS

;---------------------------------------------------------------------------

CODE_01D533:
	PHB
	PEA.w $7E4800>>8
	PLB
	PLB
	LDX.w $7E4800
	STA.w $0000,x
	ASL
	LDA.w #$0080
	STA.w $0002,x
	LDA.w #$007E
	STA.w $0007,x
	TYA
	STA.w $0008,x
	LDA.w #$3981
	LDY.w #$7BBE
	BCS.b CODE_01D55D
	LDA.w #$1801
	INY
	INY
CODE_01D55D:
	STA.w $0003,x
	TYA
	STA.w $0005,x
	TXA
	CLC
	ADC.w #$000C
	STA.w $000A,x
	STA.w $7E4800
	SEP.b #$30
	PLB
	RTS

;---------------------------------------------------------------------------

DATA_01D573:
	dw DATA_5FD64C>>16,DATA_5FD64C
	dw DATA_5FD67C>>16,DATA_5FD67C
	dw DATA_5FD6AC>>16,DATA_5FD6AC
	dw DATA_5FD6DC>>16,DATA_5FD6DC
	dw DATA_5FD70C>>16,DATA_5FD70C
	dw DATA_5FD73C>>16,DATA_5FD73C
	dw DATA_5FD76C>>16,DATA_5FD76C
	dw DATA_5FD79C>>16,DATA_5FD79C
	dw DATA_5FD7CC>>16,DATA_5FD7CC
	dw DATA_5FD7FC>>16,DATA_5FD7FC
	dw DATA_5FD82C>>16,DATA_5FD82C
	dw DATA_5FD85C>>16,DATA_5FD85C
	dw DATA_5FD88C>>16,DATA_5FD88C
	dw DATA_5FD8BC>>16,DATA_5FD8BC
	dw DATA_5FD8EC>>16,DATA_5FD8EC
	dw DATA_5FD91C>>16,DATA_5FD91C

CODE_01D5B3:
	PHB
	PHK
	PLB
	LDX.b #$04
CODE_01D5B8:
	LDA.w DATA_01D66B,x
	STA.w HDMA[$06].Parameters,x
	LDA.w DATA_01D670,x
	STA.w HDMA[$07].Parameters,x
	LDA.w DATA_01D675,x
	STA.w HDMA[$05].Parameters,x
	LDA.w DATA_01D681,x
	STA.w HDMA[$04].Parameters,x
	LDA.w DATA_01D68D,x
	STA.w HDMA[$03].Parameters,x
	LDA.w DATA_01D699,x
	STA.w HDMA[$02].Parameters,x
	LDA.w DATA_01D6A5,x
	STA.w HDMA[$01].Parameters,x
	DEX
	BPL.b CODE_01D5B8
	LDA.b #$7E5040>>16
	STA.w HDMA[$06].IndirectSourceBank
	STA.w HDMA[$07].IndirectSourceBank
	STA.w HDMA[$05].IndirectSourceBank
	STA.w HDMA[$04].IndirectSourceBank
	STA.w HDMA[$03].IndirectSourceBank
	LDA.b #$7F56DE>>16
	STA.w HDMA[$02].IndirectSourceBank
	STA.w HDMA[$01].IndirectSourceBank
	LDX.b #$06
CODE_01D600:
	LDA.w DATA_01D67A,x
	STA.l $7E5B18,x
	LDA.w DATA_01D686,x
	STA.l $7E5B98,x
	LDA.w DATA_01D692,x
	STA.l $7E5C18,x
	LDA.w DATA_01D69E,x
	STA.l $7E5C98,x
	LDA.w DATA_01D6AA,x
	STA.l $7E5D18,x
	DEX
	BPL.b CODE_01D600
	LDX.b #$00
	LDA.w $0134
	CMP.b #$10
	BCC.b CODE_01D666
	ASL
	ASL
	TAY
	REP.b #$20
	LDA.w DATA_01D573-$40,y
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w DATA_01D573-$3E,y
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_0890E7>>16
	LDA.w #FXCODE_0890E7
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$56DE
	STA.b $20
	LDY.b #$7F
	STY.b $22
	LDA.w #$5800
	STA.b $23
	LDY.b #$70
	STY.b $25
	LDA.w #$0522
	JSL.l CODE_008288
	SEP.b #$20
	LDX.b #$06
CODE_01D666:
	STX.w $094A
	PLB
	RTL

DATA_01D66B:
	db $01,!REGISTER_MainScreenLayers : dl $7E51E4

DATA_01D670:
	db $03,!REGISTER_BG3HorizScrollOffset : dl $7E552C

DATA_01D675:
	db $44,!REGISTER_Window1LeftPositionDesignation : dl $7E5B18

DATA_01D67A:
	db $E9 : dw $7E56D0
	db $E9 : dw $7E5874
	db $00

DATA_01D681:
	db $42,!REGISTER_BG3VertScrollOffset : dl $7E5B98

DATA_01D686:
	db $E9 : dw $7E5040
	db $E9 : dw $7E5112
	db $00

DATA_01D68D:
	db $42,!REGISTER_BG3HorizScrollOffset : dl $7E5C18

DATA_01D692:
	db $E9 : dw $7E51E4
	db $E9 : dw $7E52B6
	db $00

DATA_01D699:
	db $42,!REGISTER_FixedColorData : dl $7E5C98

DATA_01D69E:
	db $E9 : dw $7F5894
	db $E9 : dw $7F5966
	db $00

DATA_01D6A5:
	db $40,!REGISTER_FixedColorData : dl $7E5D18

DATA_01D6AA:
	db $E9 : dw $7F56DE
	db $E9 : dw $7F5747
	db $00

;---------------------------------------------------------------------------

CODE_01D6B1:
	LDA.w $0D2D
	BEQ.b CODE_01D6BB
	JSR.w CODE_01D7CD
	BRA.b CODE_01D6C3

CODE_01D6BB:
	LDA.w $0D3D
	BEQ.b CODE_01D6C3
	JSR.w CODE_01D86D
CODE_01D6C3:
	LDX.w $0D27
	BEQ.b CODE_01D6CD
	JSR.w CODE_01D795
	BRA.b CODE_01D6DF

CODE_01D6CD:
	LDA.w $0D2B
	BEQ.b CODE_01D6D7
	JSR.w CODE_01D81D
	BRA.b CODE_01D6DF

CODE_01D6D7:
	LDA.w $0D45
	BEQ.b CODE_01D6DF
	JSR.w CODE_01D8C6
CODE_01D6DF:
	LDX.w $0D3B
	BNE.b CODE_01D6E5
	RTS

CODE_01D6E5:
	REP.b #$20
	LDA.w $609A,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_08BE12>>16
	LDA.w #FXCODE_08BE12
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	SEC
	SBC.w #$385E
	JSL.l CODE_00BE71	: db $2C,$55,$7E,$5E,$38,$70
	LDA.w $013E
	CMP.w #$0001
	BEQ.b CODE_01D715
	SEP.b #$20
	LDA.b #$80
	BRA.b CODE_01D791

CODE_01D715:
	LDA.w #$06FF
	SEC
	SBC.b $3B
	BCS.b CODE_01D724
	SEP.b #$20
	LDA.w $0967
	BRA.b CODE_01D72D

CODE_01D724:
	CMP.w #$00D2
	SEP.b #$20
	BCC.b CODE_01D747
	LDA.b #$17
CODE_01D72D:
	STA.l $7E51E5
	EOR.b #$04
	AND.b #$04
	STA.l $7E51E6
	LDA.b #$01
	STA.l $7E51E4
	LDA.b #$00
	STA.l $7E51E7
	BRA.b CODE_01D78F

CODE_01D747:
	LDX.b #$00
	CMP.b #$80
	BCC.b CODE_01D766
	SBC.b #$7F
	PHA
	LDA.b #$7F
	STA.l $7E51E4,x
	LDA.b #$17
	STA.l $7E51E5,x
	LDA.b #$00
	STA.l $7E51E6,x
	PLA
	INX
	INX
	INX
CODE_01D766:
	STA.l $7E51E4,x
	LDA.b #$01
	STA.l $7E51E7,x
	LDA.w $0967
	STA.l $7E51E8,x
	LDA.b #$04
	STA.l $7E51E9,x
	LDA.b #$17
	STA.l $7E51E5,x
	LDA.b #$00
	STA.l $7E51E6,x
	LDA.b #$00
	STA.l $7E51EA,x
CODE_01D78F:
	LDA.b #$C0
CODE_01D791:
	TSB.w $094A
	RTS

CODE_01D795:
	REP.b #$20
	DEX
	LDA.b $3B,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0001
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w $0D28
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$3372
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDX.b #FXCODE_08DC26>>16
	LDA.w #FXCODE_08DC26
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$01A4
	JSL.l CODE_00BE71	: db $40,$50,$7E,$72,$33,$70
	SEP.b #$20
	LDA.b #$10
	TSB.w $094A
	RTS

;---------------------------------------------------------------------------

CODE_01D7CD:
	REP.b #$20
	LDA.w $0D2D
	AND.w #$0002
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $609E
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $0D39
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $0D31
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LDA.w #$0001
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$36BA
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w $61B0
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDX.b #FXCODE_08DD23>>16
	LDA.w #FXCODE_08DD23
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$01A4
	JSL.l CODE_00BE71	: db $E4,$51,$7E,$BA,$36,$70
	SEP.b #$20
	LDA.b #$08
	TSB.w $094A
	RTS

;---------------------------------------------------------------------------

CODE_01D81D:
	REP.b #$20
	LDA.w $0D2B
	AND.w #$0002
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $0D37
	STA.w $6000
	LDA.w $609E
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $0D2F
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$0001
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$3372
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w $61B0
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDX.b #FXCODE_08DC4D>>16
	LDA.w #FXCODE_08DC4D
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$01A4
	JSL.l CODE_00BE71	: db $40,$50,$7E,$72,$33,$70
	SEP.b #$20
	LDA.b #$10
	TSB.w $094A
	RTS

;---------------------------------------------------------------------------

CODE_01D86D:
	REP.b #$20
	LDA.w $0D3D
	AND.w #$0002
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $0D43
	STA.w $6000
	LDA.w $60A0
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $0D3F
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$0001
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$36BA
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w $61B0
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDX.b #FXCODE_08DC4D>>16
	LDA.w #FXCODE_08DC4D
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$01A4
	JSL.l CODE_00BE71	: db $E4,$51,$7E,$BA,$36,$70
	LDA.l $7036BA
	STA.w $6098
	STA.b $41
	SEP.b #$20
	LDA.b #$08
	TSB.w $094A
	RTS

;---------------------------------------------------------------------------

CODE_01D8C6:
	REP.b #$20
	LDA.w $0D45
	AND.w #$0002
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $60A0
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $0D4B
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $0D47
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LDA.w #$0001
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$3372
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w $61B0
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDX.b #FXCODE_08DD23>>16
	LDA.w #FXCODE_08DD23
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$01A4
	JSL.l CODE_00BE71	: db $40,$50,$7E,$72,$33,$70
	SEP.b #$20
	LDA.b #$10
	TSB.w $094A
	RTS

;---------------------------------------------------------------------------

DATA_01D916:
	dw CODE_01DA69
	dw CODE_01D92C
	dw CODE_01DA98

DATA_01D91C:
	dw $1402,$2000,$00E0,$00C3,$00A5,$0008,$0804,$1004

CODE_01D92C:
	STZ.w $0967
	LDA.b #$13
	STA.w $0968
	REP.b #$20
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_01D946
	LDA.w $7FE8
	BNE.b CODE_01D960
CODE_01D946:
	LDA.w $0D37
	ORA.w $0D39
	BNE.b CODE_01D95D
	STZ.w $0D2B
	STZ.w $0D2D
	LDA.w $094A
	AND.w #$FFE7
	STA.w $094A
CODE_01D95D:
	JMP.w CODE_01DA51

CODE_01D960:
	DEC
	BNE.b CODE_01D9BD
	LDA.w $0CFF
	BEQ.b CODE_01D974
	SEC
	SBC.w #$0100
	STA.w $0CFF
	BPL.b CODE_01D974
	STZ.w $0CFF
CODE_01D974:
	LDA.w $0D03
	AND.w #$00FF
	BEQ.b CODE_01D97F
	JMP.w CODE_01DA1C

CODE_01D97F:
	LDA.l $702F6C
	BNE.b CODE_01D9B4
	LDA.w $0CFF
	BNE.b CODE_01D99C
	LDA.w #$0022
	JSL.l CODE_0085D2
	STZ.w $7FE8
	STZ.w $0D37
	STZ.w $0D39
	BRA.b CODE_01D9B1

CODE_01D99C:
	AND.w #$0100
	BNE.b CODE_01D9B1
	DEC.w $0D37
	BPL.b CODE_01D9A9
	STZ.w $0D37
CODE_01D9A9:
	DEC.w $0D39
	BPL.b CODE_01D9B1
	STZ.w $0D39
CODE_01D9B1:
	JMP.w CODE_01DA47

CODE_01D9B4:
	LDA.w #$0000
	STA.l $702F6C
	BRA.b CODE_01DA11

CODE_01D9BD:
	DEC.w $7FE8
	LDA.w $0CFF
	CLC
	ADC.w #$0080
	CMP.w #$6000
	BCC.b CODE_01D9CF
	LDA.w #$6000
CODE_01D9CF:
	STA.w $0CFF
	AND.w #$0380
	BNE.b CODE_01D9EF
	LDA.w $0D37
	INC
	CMP.w #$0018
	BCS.b CODE_01D9E3
	STA.w $0D37
CODE_01D9E3:
	LDA.w $0D39
	INC
	CMP.w #$000C
	BCS.b CODE_01D9EF
	STA.w $0D39
CODE_01D9EF:
	LDA.w #$0003
	STA.w $0D2B
	LDA.w #$0001
	STA.w $0D2D
	LDA.w $0D03
	AND.w #$00FF
	BNE.b CODE_01DA1C
	LDA.w $7970
	AND.w #$000E
	TAX
	LDA.w DATA_01D91C,x
	STA.l $702F6C
CODE_01DA11:
	STZ.w $0D03
	LDA.l $702000
	STA.l $702D6C
CODE_01DA1C:
	LDA.w $0D03
	CLC
	ADC.w #$0008
	STA.w $0D03
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.l $702D6C
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.l $702F6C
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_08E132>>16
	LDA.w #FXCODE_08E132
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STA.l $702000
CODE_01DA47:
	LDA.w $0D01
	CLC
	ADC.w #$0020
	STA.w $0D01
CODE_01DA51:
	LDA.w $0CFF
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $0D01
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_089518>>16
	LDA.w #FXCODE_089518
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_01DA69:
	REP.b #$20
	LDA.w $61B0
	ORA.w $0398
	BNE.b CODE_01DA79
	DEC.w $0CFD
	DEC.w $0CFD
CODE_01DA79:
	LDA.w $0CFD
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LDA.b $39
	STA.w $7EEE
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.b $3B
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDX.b #FXCODE_089DCE>>16
	LDA.w #FXCODE_089DCE
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_01DA98:
	REP.b #$20
	INC.w $0CFD
	LDA.w $0CFD
	CMP.w #$0060
	BCC.b CODE_01DAAB
	LDA.w #$0000
	STA.w $0CFD
CODE_01DAAB:
	LSR
	LSR
	LSR
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LDA.w $60B0
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDX.b #FXCODE_0B96C3>>16
	LDA.w #FXCODE_0B96C3
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

CODE_01DAC3:
	LDA.w #$0064
CODE_01DAC6:
	LDY.w $039A
	BNE.b CODE_01DADD
	CLC
	ADC.w $0396
	STA.w $0396
	CLC
	ADC.w #$0078
	STA.w $0B7F
	INC.w $039A
	RTS

CODE_01DADD:
	LDA.w $0396
	BNE.b CODE_01DAE5
	STZ.w $0398
CODE_01DAE5:
	RTS

CODE_01DAE6:
	LDA.w #$00C8
	BRA.b CODE_01DAC6

;---------------------------------------------------------------------------

CODE_01DAEB:
	JSL.l CODE_0294B4
	LDA.w #$0047
	JSL.l CODE_0085D2
	LDA.w #$0020
	STA.w $61C6
	STZ.w $0398
	RTS

;---------------------------------------------------------------------------

CODE_01DB00:
	INC.w $7E06
	LDA.w #$0004
	JSL.l CODE_0085D2
	STZ.w $0398
	RTS

;---------------------------------------------------------------------------

CODE_01DB0E:
	LDY.w $039A
	BNE.b CODE_01DB24
	LDA.w #$00AB
	JSL.l CODE_03A364
	BCC.b CODE_01DB24
	TYX
	JSL.l CODE_029AC6
	INC.w $039A
CODE_01DB24:
	RTS

;---------------------------------------------------------------------------

CODE_01DB25:
	LDX.b #$5C
CODE_01DB27:
	LDA.w $6F00,x
	CMP.w #$000E
	BCC.b CODE_01DB4B
	LDA.w $6FA2,x
	AND.w #$6000
	BNE.b CODE_01DB4B
	CPX.w $61B6
	BNE.b CODE_01DB3F
	STZ.w $61B6
CODE_01DB3F:
	LDA.w #$0006
	STA.w $6F00,x
	LDA.w #$00CB
	STA.w $0B91,x
CODE_01DB4B:
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_01DB27
	LDA.w #$003B
	JSL.l CODE_0085D2
	STZ.w $0398
	RTS

;---------------------------------------------------------------------------

CODE_01DB5C:
	LDA.w #$0003
CODE_01DB5F:
	STA.w $616A
	INC.w $6162
	INC.w $6168
	LDA.w #$005A
	STA.w $6170
	LDA.w #$0014
	JSL.l CODE_0085D2
	STZ.w $0398
	RTS

CODE_01DB79:
	LDA.w #$0004
	BRA.b CODE_01DB5F

CODE_01DB7E:
	LDA.w #$0001
	BRA.b CODE_01DB5F

;---------------------------------------------------------------------------

CODE_01DB83:
	LDA.w $0CF4
	CLC
	ADC.w $0CF5
	TAX
	BEQ.b CODE_01DBB9
	STZ.w $0356,x
	TXY
	DEY
CODE_01DB92:
	CPX.b #$1B
	BCS.b CODE_01DBA7
	LDA.w $0357,x
	AND.b #$0F
	BEQ.b CODE_01DBA4
	STA.w $0357,y
	STZ.w $0357,x
	INY
CODE_01DBA4:
	INX
	BRA.b CODE_01DB92

CODE_01DBA7:
	LDA.w $0CF5
	BEQ.b CODE_01DBB1
	DEC.w $0CF5
	BRA.b CODE_01DBB9

CODE_01DBB1:
	DEC.w $0CF4
	BNE.b CODE_01DBB9
	INC.w $0CF4
CODE_01DBB9:
	RTS

;---------------------------------------------------------------------------

DATA_01DBBA:
	dw CODE_01DC8B,CODE_01DC8B,CODE_01DCA0,CODE_01DCA1,CODE_01DC97,CODE_01DCA0,CODE_01DCB2,CODE_01DCB2
	dw CODE_01DCB2

DATA_01DBCC:
	db $01,$FF,$FF

DATA_01DBCF:
	db $03,$FF,$FF

DATA_01DBD2:
	db $1B,$FF,$FF

CODE_01DBD5:
	LDA.b $38
	AND.b #$03
	BEQ.b CODE_01DC4B
	TAX
	LDA.w $0CF4
	BNE.b CODE_01DBE4
	JMP.w CODE_01DC8A

CODE_01DBE4:
	DEC
	STA.b $00
	CLC
	ADC.w DATA_01DBCC-$01,x
	CMP.w DATA_01DBCF-$01,x
	BEQ.b CODE_01DBFA
	INC
	STA.w $0CF4
	LDA.b #$5C
	STA.b $53
	BRA.b CODE_01DC1C

CODE_01DBFA:
	LDA.b $00
	CLC
	ADC.w $0CF5
	CLC
	ADC.w DATA_01DBCC-$01,x
	CMP.w DATA_01DBD2-$01,x
	BNE.b CODE_01DC0E
	LDA.w $0CF5
	BRA.b CODE_01DC1C

CODE_01DC0E:
	LDA.b #$5C
	STA.b $53
	LDA.w $0CF5
	CLC
	ADC.w DATA_01DBCC-$01,x
	STA.w $0CF5
CODE_01DC1C:
	LDA.w $0CF4
	CLC
	ADC.w $0CF5
	TAX
	CPX.b #$1B
	BCS.b CODE_01DC42
	DEX
	LDA.w $0357,x
	BNE.b CODE_01DC42
	DEC.w $0CF5
	BPL.b CODE_01DC40
	STZ.w $0CF5
	DEC.w $0CF4
	BPL.b CODE_01DC40
	STZ.w $0CF4
	BRA.b CODE_01DC42

CODE_01DC40:
	STZ.b $53
CODE_01DC42:
	JSR.w CODE_01DCC6
	JSR.w CODE_01DD8B
	JSR.w CODE_01DCE0
CODE_01DC4B:
	LDA.w $0398
	BNE.b CODE_01DC8A
	LDA.b $37
	AND.b #$80
	BEQ.b CODE_01DC8A
	LDA.w $0B48
	BNE.b CODE_01DC74
	LDA.w $0CF5
	CLC
	ADC.w $0CF4
	TAX
	LDA.w $0356,x
	STA.w $0398
	BEQ.b CODE_01DC74
	ASL
	TAX
	REP.b #$20
	JSR.w (DATA_01DBBA-$02,x)
	SEP.b #$20
CODE_01DC74:
	LDA.w $0398
	BEQ.b CODE_01DC86
	LDA.b #$43
	STA.b $53
	STZ.w $039A
	STZ.w $039B
	JMP.w CODE_01DB83

CODE_01DC86:
	LDA.b #$90
	STA.b $53
CODE_01DC8A:
	RTS

CODE_01DC8B:
	LDA.w $03B6
	CMP.w #$012C
	BCC.b CODE_01DC96
	STZ.w $0398
CODE_01DC96:
	RTS

CODE_01DC97:
	LDA.w $7E06
	BEQ.b CODE_01DC9F
	STZ.w $0398
CODE_01DC9F:
	RTS

CODE_01DCA0:
	RTS

CODE_01DCA1:
	LDA.w $60AE
	BNE.b CODE_01DCAE
	LDA.w $7DF6
	CMP.w #$000C
	BCC.b CODE_01DCB1
CODE_01DCAE:
	STZ.w $0398
CODE_01DCB1:
	RTS

CODE_01DCB2:
	LDA.w $60AE
	ORA.w $6162
	ORA.w $6168
	BEQ.b CODE_01DCC1
	STZ.w $0398
	RTS

CODE_01DCC1:
	JSL.l CODE_04F74A
	RTS

CODE_01DCC6:
	LDX.b #$00
	LDY.w $0CF5
CODE_01DCCB:
	LDA.w $0357,y
	STA.w $0CF6,x
	INY
	INX
	CPX.b #$03
	BCC.b CODE_01DCCB
	RTS

;---------------------------------------------------------------------------

DATA_01DCD8:
	dw $09AF,$499D

DATA_01DCDC:
	dw $09AF,$099D

CODE_01DCE0:
	LDX.b #$00
	LDA.w $0CF5
	BEQ.b CODE_01DCE9
	INX
	INX
CODE_01DCE9:
	REP.b #$20
	LDA.w DATA_01DCD8,x
	STA.l $7EB605
	ORA.w #$8000
	STA.l $7EB645
	SEP.b #$20
	LDX.b #$00
	LDA.w $0CF5
	CLC
	ADC.b #$03
	CMP.b #$1B
	BCS.b CODE_01DD0F
	TAY
	LDA.w $0357,y
	BEQ.b CODE_01DD0F
	INX
	INX
CODE_01DD0F:
	REP.b #$20
	LDA.w DATA_01DCDC,x
	STA.l $7EB61B
	ORA.w #$8000
	STA.l $7EB65B
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01DD22:
	dw $1DBB,$1DBC,$1DBC,$1DBE,$1DD1,$417F,$417F,$1DBF
	dw $1DD1,$417F,$417F,$1DBF,$9DBB,$9DBC,$9DBC,$9DBE

DATA_01DD42:
	dw $5DBE,$1DBC,$1DBC,$1DBE,$5DBF,$417F,$417F,$1DBF
	dw $5DBF,$417F,$417F,$1DBF,$DDBE,$9DBC,$9DBC,$9DBE

DATA_01DD62:
	dw $5DBE,$1DBC,$1DBC,$5DBB,$5DBF,$417F,$417F,$5DD1
	dw $5DBF,$417F,$417F,$5DD1,$DDBE,$9DBC,$9DBC,$DDBB

DATA_01DD82:
	dw DATA_01DD22,DATA_01DD42,DATA_01DD62

DATA_01DD88:
	db $00,$06,$0C

CODE_01DD8B:
	REP.b #$20
	PHB
	LDX.b #$7E
	PHX
	PLB
	JSR.w CODE_01D490
	PLB
	JSR.w CODE_01DDB0
	REP.b #$10
	LDY.w #$7EB59F>>16
	STY.b $01
	LDY.w #$36E0
	LDX.w #$7EB59F
	LDA.w #$0100
	JSL.l CODE_00BEA6
	SEP.b #$30
	RTS

CODE_01DDB0:
	LDA.w $0CF4
	AND.w #$00FF
	TAY
	ASL
	TAX
	LDA.w DATA_01DD88-$01,y
	TAY
	LDA.w DATA_01DD82-$02,x
	STA.b $00
	CLC
	ADC.w #$0008
	STA.b $02
	CLC
	ADC.w #$0008
	STA.b $04
	CLC
	ADC.w #$0008
	STA.b $06
	TYX
	LDY.b #$00
CODE_01DDD7:
	LDA.b ($00),y
	STA.l $7EB5C7,x
	LDA.b ($02),y
	STA.l $7EB607,x
	LDA.b ($04),y
	STA.l $7EB647,x
	LDA.b ($06),y
	STA.l $7EB687,x
	INX
	INX
	INY
	INY
	CPY.b #$08
	BCC.b CODE_01DDD7
	RTS

;---------------------------------------------------------------------------

DATA_01DDF8:
	dw $3540,$3542,$3144,$3146,$3148,$314A,$314C,$314E
	dw $334C

CODE_01DE0A:
	REP.b #$20
	LDA.w #$BFA8
	STA.b $00
	LDX.b #$00
	TXY
CODE_01DE14:
	LDA.w $0CF6,y
	AND.w #$00FF
	BEQ.b CODE_01DE3C
	PHY
	ASL
	TAY
	LDA.w DATA_01DDF8-$02,y
	STA.l $006A82,x
	PLY
	LDA.b $00
	STA.l $006A80,x
	CLC
	ADC.w #$0018
	STA.b $00
	INX
	INX
	INX
	INX
	INY
	CPY.b #$03
	BCC.b CODE_01DE14
CODE_01DE3C:
	LDA.w #$AAAA
	STA.l $006C08
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01DE46:
	db $00,$02,$02,$0B,$0B,$0B,$02

DATA_01DE4D:
	db $00,$22,$22,$88,$88,$88,$22

CODE_01DE54:
	LDA.b #$01
	STA.b $10
	BRA.b CODE_01DE5C

CODE_01DE5A:
	STZ.b $10
CODE_01DE5C:
	PHB
	PHK
	PLB
	LDX.w $0D0F
	LDA.b $10
	BNE.b CODE_01DE80
	TXA
	LSR
	TAY
	LDA.w DATA_01DE46,y
	STA.w $0965
	LDA.w DATA_01DE4D,y
	STA.w $0964
	STA.w $0966
	LDA.b #$01
	STA.w $61AE
	STA.w $61B0
CODE_01DE80:
	JSR.w (DATA_01DE85-$01,x)
	PLB
	RTL

DATA_01DE85:
	dw CODE_01DE93
	dw CODE_01DEA9
	dw CODE_01DED0
	dw CODE_01DEA9
	dw CODE_01DEE0
	dw CODE_01DEB9
	dw CODE_01DEB9

CODE_01DE93:
	LDA.b #$50
	JSL.l CODE_0085D2
	STZ.w $0D19
	STZ.w $0D1A
	STZ.w $0D1B
CODE_01DEA2:
	INC.w $0D0F
	INC.w $0D0F
	RTS

CODE_01DEA9:
	LDY.b #$00
	CPX.b #$03
	BNE.b CODE_01DEB3
	LDA.b $10
	BNE.b CODE_01DEC3
CODE_01DEB3:
	LDX.w $0D11
	JMP.w (DATA_01DEF5,x)

CODE_01DEB9:
	LDY.b #$02
	CPX.b #$0D
	BNE.b CODE_01DEB3
	LDA.b $10
	BEQ.b CODE_01DEB3
CODE_01DEC3:
	REP.b #$20
	LDA.w $0D19
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	SEP.b #$20
	JMP.w CODE_01DF18

CODE_01DED0:
	REP.b #$20
	LDA.w #$0000
	STA.l $70406E
	SEP.b #$20
	JSR.w CODE_01E180
	BRA.b CODE_01DEA2

CODE_01DEE0:
	JSR.w CODE_01E180
	LDA.l $70406E
	CMP.b #$02
	BCC.b CODE_01DEF4
	LDA.b #$56
	JSL.l CODE_0085D2
	JSR.w CODE_01DEA2
CODE_01DEF4:
	RTS

DATA_01DEF5:
	dw CODE_01DEFF

DATA_01DEF7:
	dw $0100,$0000

DATA_01DEFB:
	dw $0010,$FFF0

CODE_01DEFF:
	REP.b #$20
	LDA.w $0D19
	CLC
	ADC.w DATA_01DEFB,y
	STA.w $0D19
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	CMP.w DATA_01DEF7,y
	SEP.b #$20
	BEQ.b CODE_01DF18
	JMP.w CODE_01E048

CODE_01DF18:
	JSR.w CODE_01DEA2
	LDA.w $0D0F
	CMP.b #$0F
	BNE.b CODE_01DF45
	STZ.w $0D0F
	LDA.b $10
	BNE.b CODE_01DF44
	STZ.w $0964
	STZ.w $0965
	STZ.w $0966
	STZ.w $61B0
	LDA.w $038C
	BEQ.b CODE_01DF41
	BIT.b $35
	BVS.b CODE_01DF44
	STZ.w $038C
CODE_01DF41:
	STZ.w $61AE
CODE_01DF44:
	RTS

CODE_01DF45:
	CMP.b #$0D
	BNE.b CODE_01DF8E
	REP.b #$30
	LDA.w #$0100
	STA.w $0D19
	LDY.w #$0180
	LDA.w $0D17
	CLC
	ADC.w #$00C0
	CMP.w #$3800
	BEQ.b CODE_01DF6A
	BCC.b CODE_01DF6A
	LDA.w #$3800
	SBC.w $0D17
	ASL
	TAY
CODE_01DF6A:
	LDA.w $0D17
	JSR.w CODE_01D533
	REP.b #$30
	LDA.w $0D17
	CLC
	ADC.w #$00C0
	SEC
	SBC.w #$3800
	BEQ.b CODE_01DF89
	BMI.b CODE_01DF89
	ASL
	TAY
	LDA.w #$3400
	JSR.w CODE_01D533
CODE_01DF89:
	SEP.b #$30
CODE_01DF8B:
	JMP.w CODE_01E048

CODE_01DF8E:
	CMP.b #$05
	BNE.b CODE_01DF8B
	REP.b #$30
	STZ.w $0D19
	LDY.w #$0182
	LDA.b $43
	CLC
	ADC.w #$0018
	AND.w #$01F0
	ASL
	ORA.w #$3400
	STA.w $0D17
	CLC
	ADC.w #$00C0
	CMP.w #$3800
	BEQ.b CODE_01DFBF
	BCC.b CODE_01DFBF
	LDA.w #$3800
	SBC.w $0D17
	ASL
	INC
	INC
	TAY
CODE_01DFBF:
	LDA.w $0D17
	ORA.w #$8000
	JSR.w CODE_01D533
	REP.b #$30
	LDA.w $0D17
	CLC
	ADC.w #$00C0
	SEC
	SBC.w #$3800
	BEQ.b CODE_01DFE3
	BMI.b CODE_01DFE3
	ASL
	INC
	INC
	TAY
	LDA.w #$B400
	JSR.w CODE_01D533
CODE_01DFE3:
	SEP.b #$30
	PHB
	LDA.b #$7E
	PHA
	PLB
	REP.b #$30
	LDA.b $41
	CLC
	ADC.w #$0038
	AND.w #$01F0
	LSR
	LSR
	LSR
	LSR
	STA.b $02
	EOR.w #$001F
	INC
	CMP.w #$000A
	BCC.b CODE_01E007
	LDA.w #$000A
CODE_01E007:
	STA.b $04
	STZ.b $08
	LDA.w #$2A00
	STA.b $06
	LDA.l $000D17
	CLC
	ADC.b $02
	STA.b $02
	JSR.w CODE_01E0BF
	INC.b $08
	LDA.b $04
	CMP.w #$000A
	BCS.b CODE_01E03F
	DEC
	ASL
	CLC
	ADC.w #$2A00
	STA.b $06
	LDA.w #$000A
	SEC
	SBC.b $04
	STA.b $04
	LDA.b $02
	AND.w #$FFE0
	STA.b $02
	JSR.w CODE_01E0BF
CODE_01E03F:
	LDA.w #$FFFF
	STA.w $4002,x
	SEP.b #$30
	PLB
CODE_01E048:
	REP.b #$20
	STZ.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STZ.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	STZ.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.b $41
	AND.w #$000F
	CMP.w #$0008
	BCS.b CODE_01E060
	ORA.w #$0010
CODE_01E060:
	EOR.w #$FFFF
	INC
	CLC
	ADC.w #$0090
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.b $43
	AND.w #$000F
	CMP.w #$0008
	BCS.b CODE_01E078
	ORA.w #$0010
CODE_01E078:
	EOR.w #$FFFF
	INC
	CLC
	ADC.w #$0047
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #FXCODE_088002
	LDX.b $10
	BEQ.b CODE_01E08D
	LDA.w #FXCODE_088040
CODE_01E08D:
	LDX.b #FXCODE_088002>>16
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	SEP.b #$20
	LDA.b $10
	BNE.b CODE_01E0BE
	JSL.l CODE_00BE39	: db $D0,$56,$7E,$02,$3A,$70,$48,$03
	LDA.w $0967
	STA.w $0969
	LDA.w $0968
	STA.w $096A
	LDA.b #$30
	STA.w $094C
	STZ.w !REGISTER_ColorAndObjectWindowLogicSettings
	LDA.b #$20
	TSB.w $094A
CODE_01E0BE:
	RTS

CODE_01E0BF:
	LDA.w #$0006
	STA.b $00
	LDX.w $4000
	LDA.b $02
CODE_01E0C9:
	STA.w $4002,x
	PHA
	LDA.b $04
	ASL
	DEC
	STA.w $4004,x
	LDA.b $00
	DEC
	BEQ.b CODE_01E0EB
	CMP.w #$0005
	BCS.b CODE_01E0EB
	JSR.w CODE_01E107
	LDA.b $06
	CLC
	ADC.w #$0020
	STA.b $06
	BRA.b CODE_01E0EE

CODE_01E0EB:
	JSR.w CODE_01E136
CODE_01E0EE:
	TXA
	CLC
	ADC.w #$0004
	TAX
	PLA
	CLC
	ADC.w #$0020
	AND.w #$F7FF
	ORA.w #$0400
	DEC.b $00
	BNE.b CODE_01E0C9
	STX.w $4000
	RTS

CODE_01E107:
	LDY.b $04
	LDA.b $08
	BNE.b CODE_01E118
	LDA.w #$2DC3
	STA.w $4006,x
	INX
	INX
	DEY
	BEQ.b CODE_01E135
CODE_01E118:
	LDA.b $06
CODE_01E11A:
	STA.w $4006,x
	INC
	INC
	INX
	INX
	DEY
	BNE.b CODE_01E11A
	LDA.b $08
	BNE.b CODE_01E12F
	LDA.b $04
	CMP.w #$000A
	BCC.b CODE_01E135
CODE_01E12F:
	LDA.w #$6DC3
	STA.w $4004,x
CODE_01E135:
	RTS

CODE_01E136:
	LDY.b $04
	LDA.b $08
	BNE.b CODE_01E151
	LDA.b $00
	DEC
	BNE.b CODE_01E146
	LDA.w #$ADC0
CODE_01E144:
	BRA.b CODE_01E149

CODE_01E146:
	LDA.w #$2DC0
CODE_01E149:
	STA.w $4006,x
	INX
	INX
	DEY
	BEQ.b CODE_01E17F
CODE_01E151:
	LDA.b $00
	DEC
	BNE.b CODE_01E15B
	LDA.w #$ADC1
	BRA.b CODE_01E15E

CODE_01E15B:
	LDA.w #$2DC1
CODE_01E15E:
	STA.w $4006,x
	INX
	INX
	DEY
	BNE.b CODE_01E15E
	LDA.b $08
	BNE.b CODE_01E171
	LDA.b $04
	CMP.w #$000A
	BCC.b CODE_01E17F
CODE_01E171:
	LDA.w #$6DC0
	LDY.b $00
	DEY
	BNE.b CODE_01E17C
	LDA.w #$EDC0
CODE_01E17C:
	STA.w $4004,x
CODE_01E17F:
	RTS

;---------------------------------------------------------------------------

CODE_01E180:
	LDA.w $012D
	PHA
	LDA.w $012E
	PHA
	LDA.b #$13
	STA.w $012D
	LDA.b #!SuperFX_ScreenMode_ScreenHeight_128pixels|!SuperFX_ScreenMode_ColorMode_16Colors|!SuperFX_ScreenMode_SuperFXHasWRAMAccess|!SuperFX_ScreenMode_SuperFXHasROMAccess|!SuperFX_ScreenMode_ColorMode_Unused
	STA.w $012E
	REP.b #$30
	LDA.l $704070
	ASL
	TAX
	LDA.l DATA_5110DB,x
	STA.l $704096
	LDA.w #DATA_5110DB>>16
	STA.l $704098
	LDA.w $0379
	STA.l $70409A
	SEP.b #$10
	LDA.w #$0000
	STA.l $704074
	STA.l $704076
	LDA.w $0071
	BNE.b CODE_01E1D6
	LDA.w $093C
	AND.w #$0F80
	STA.l $704074
	LDA.w $093E
	AND.w #$0F80
	STA.l $704076
CODE_01E1D6:
	LDX.b #FXCODE_09B03E>>16
	LDA.w #FXCODE_09B03E
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	SEP.b #$20
	PLA
	STA.w $012E
	PLA
	STA.w $012D
	LDA.w $607A
	BEQ.b CODE_01E1F2
	JSL.l CODE_0085D2
CODE_01E1F2:
	INC.w $0D15
	JSR.w CODE_01E1F9
	RTS

CODE_01E1F9:
	PHB
	LDA.b #$7E4000>>16
	PHA
	PLB
	REP.b #$30
	LDX.w $7E4000
	LDA.b $43
	CLC
	ADC.w #$0068
	AND.w #$01F0
	ASL
	ORA.w #$3400
	STA.b $00
	LDA.b $41
	CLC
	ADC.w #$00B8
	AND.w #$01F0
	LSR
	LSR
	LSR
	LSR
	ADC.b $00
	STA.w $7E4002,x
	LDA.w #$0001
	STA.w $7E4004,x
	LDA.l $704073
	AND.w #$00FF
	CMP.w #$000F
	BEQ.b CODE_01E250
	CMP.w #$0051
	BEQ.b CODE_01E250
	CMP.w #$00FF
	BEQ.b CODE_01E250
	LDA.l $70406E
	CMP.w #$0002
	BCS.b CODE_01E250
	LDA.b $30
	AND.w #$0010
	BEQ.b CODE_01E255
CODE_01E250:
	LDA.w #$ADC1
	BRA.b CODE_01E258

CODE_01E255:
	LDA.w #$2DC5
CODE_01E258:
	STA.w $7E4006,x
	LDA.w #$FFFF
	STA.w $7E4008,x
	TXA
	CLC
	ADC.w #$0006
	STA.w $7E4000
	SEP.b #$30
	PLB
	RTS

;---------------------------------------------------------------------------

CODE_01E26D:
	LDX.w $0B57
	JSR.w (DATA_01E291,x)
	LDA.w $0B57
	CMP.b #$16
	BCC.b CODE_01E284
	LDA.b #$19
	STA.w $0B57
	LDA.b #$10
	STA.w $0118
CODE_01E284:
	LDA.w $0B57
	CMP.b #$08
	BCS.b CODE_01E28F
	JSL.l CODE_01C0CE
CODE_01E28F:
	PLB
	RTL

DATA_01E291:
	dw CODE_01E2A7
	dw CODE_01E2F0
	dw CODE_01E378
	dw CODE_01E442
	dw CODE_01B5E4
	dw CODE_01B6B9
	dw CODE_01B6C9
	dw CODE_01B95B
	dw CODE_01B9BA
	dw CODE_01E2F0
	dw CODE_01E4A0

CODE_01E2A7:
	REP.b #$30
	LDA.w $0146
	CMP.w #$0009
	BEQ.b CODE_01E2C1
	LDA.l $702000
	STA.w $0948
	LDA.w #$0000
	STA.l $702000
CODE_01E2BF:
	REP.b #$30
CODE_01E2C1:
	LDX.w #$0000
	LDA.w #$FF00
CODE_01E2C7:
	STA.l $703A02,x
	INX
	INX
	INX
	INX
	CPX.w #$0348
	BCC.b CODE_01E2C7
	SEP.b #$30
	INC.w $0B57
	INC.w $0B57
	STZ.w $0D1F
	RTS

DATA_01E2E0:
	dw $1F1F,$0104

DATA_01E2E4:
	dw $0000,$018C

DATA_01E2E8:
	dw $0350,$018C

DATA_01E2EC:
	dw $FF00,$9F60

CODE_01E2F0:
	INC.w $0D1F
	LDA.w $0D1F
	CMP.b #$0A
	BCC.b CODE_01E338
	INC.w $0B57
	INC.w $0B57
	REP.b #$20
	STZ.w $0D1F
	LDX.w $0B4E
	LDA.w DATA_01E2E0,x
	STA.w $0969
	LDA.w DATA_01E2E4,x
	STA.w $0D23
	LDA.w DATA_01E2E8,x
	STA.w $0D25
	LDA.w DATA_01E2EC,x
	STA.w $0D21
	SEP.b #$20
	LDA.b #$33
	STA.w $0964
	STA.w $0965
	STA.w $0966
	LDA.b #$22
	STA.w $096B
	LDA.b #$20
	STA.w $094A
	RTS

CODE_01E338:
	DEC
	BNE.b CODE_01E348
	JSL.l CODE_00BE39	: db $D0,$56,$7E,$02,$3A,$70,$D2,$00
	RTS

CODE_01E348:
	DEC
	BNE.b CODE_01E358
	JSL.l CODE_00BE39	: db $A2,$57,$7E,$D4,$3A,$70,$D2,$00
	RTS

CODE_01E358:
	DEC
	BNE.b CODE_01E368
	JSL.l CODE_00BE39	: db $74,$58,$7E,$A6,$3B,$70,$D2,$00
	RTS

CODE_01E368:
	DEC
	BNE.b CODE_01E377
	JSL.l CODE_00BE39	: db $46,$59,$7E,$78,$3C,$70,$D2,$00
CODE_01E377:
	RTS

CODE_01E378:
	JSR.w CODE_01E3AF
	REP.b #$20
	LDA.w $0D25
	SEC
	SBC.w $0D23
	CMP.w #$0008
	BCS.b CODE_01E3A4
	INC.w $0B4E
	INC.w $0B4E
	INC.w $0B57
	INC.w $0B57
	JSL.l CODE_0394B8
	JSL.l CODE_008259
	SEP.b #$20
	LDA.b #$20
	STA.w $094A
CODE_01E3A4:
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01E3A7:
	dw $0008,$FFF8

DATA_01E3AB:
	dw $0002,$FFFE

CODE_01E3AF:
	REP.b #$30
	LDA.w $0B4E
	AND.w #$0002
	TAY
	LDX.w #$0000
	LDA.w #$00FF
CODE_01E3BE:
	CPX.w $0D23
	BCS.b CODE_01E3CD
	STA.l $703A02,x
	INX
	INX
	INX
	INX
	BRA.b CODE_01E3BE

CODE_01E3CD:
	LDA.w $0D21
CODE_01E3D0:
	CPX.w $0D25
	BCS.b CODE_01E3DF
	STA.l $703A02,x
	INX
	INX
	INX
	INX
	BRA.b CODE_01E3D0

CODE_01E3DF:
	LDA.w #$00FF
CODE_01E3E2:
	CPX.w #$0348
	BCS.b CODE_01E3F1
	STA.l $703A02,x
	INX
	INX
	INX
	INX
	BRA.b CODE_01E3E2

CODE_01E3F1:
	LDA.w #$FF00
CODE_01E3F4:
	CPX.w #$0348
	BCS.b CODE_01E403
	STA.l $703A02,x
	INX
	INX
	INX
	INX
	BRA.b CODE_01E3F4

CODE_01E403:
	LDA.w $0D23
	CLC
	ADC.w DATA_01E3A7,y
	STA.w $0D23
	LDA.w $0D25
	SEC
	SBC.w DATA_01E3A7,y
	STA.w $0D25
	SEP.b #$30
	LDA.w $0D21
	CLC
	ADC.w DATA_01E3AB,y
	STA.w $0D21
	LDA.w $0D22
	SEC
	SBC.w DATA_01E3AB,y
	STA.w $0D22
	JSL.l CODE_00BE39	: db $D0,$56,$7E,$02,$3A,$70,$48,$03
	LDA.w $094A
	ORA.b #$20
	STA.w $094A
	RTS

CODE_01E442:
	REP.b #$30
	LDX.w #$0000
	LDA.w #$00FF
CODE_01E44A:
	STA.l $703A02,x
	INX
	INX
	INX
	INX
	CPX.w #$0348
	BCC.b CODE_01E44A
	SEP.b #$30
	JSL.l CODE_00BE39	: db $D0,$56,$7E,$02,$3A,$70,$48,$03
	LDA.b #$09
	STA.w $095E
	LDA.b #$69
	STA.w $095F
	LDA.b #$34
	STA.w $0961
	LDA.b #$02
	STA.w $011C
	LDA.b #$20
	STA.w $096C
	REP.b #$20
	STZ.w $0D2D
	STZ.w $0D2B
	STZ.w $61CA
	LDA.w #$0277
	STA.w $0962
	STZ.b $39
	STZ.b $3B
	STZ.b $41
	STZ.b $43
	SEP.b #$20
	INC.w $0B57
	INC.w $0B57
	RTS

;---------------------------------------------------------------------------

CODE_01E4A0:
	JSR.w CODE_01E3AF
	REP.b #$20
	LDA.w $0D23
	BPL.b CODE_01E4D1
	INC.w $0B57
	INC.w $0B57
	STZ.w $0392
	STZ.w $0B5F
	STZ.w $0B61
	STZ.w $0B63
	STZ.w $0381
	STZ.w $0969
	STZ.w $0964
	STZ.w $0965
	SEP.b #$20
	LDA.b #$30
	STA.w $038B
	REP.b #$20
CODE_01E4D1:
	SEP.b #$20
	LDA.b #$20
	STA.w $094A
	RTS

;---------------------------------------------------------------------------

DATA_01E4D9:
	dw $03C0,$0440,$04C0,$0540

DATA_01E4E1:
	dw $8000,$4000,$2000,$1000,$0800,$0400,$0200,$0100
	dw $0080,$0040,$0020,$0010,$0008,$0004,$0002,$0001

CODE_01E501:
	PHX
	TXA
	AND.w #$001E
	TAX
	LDA.l DATA_01E4E1,x
	STA.b $02
	LDA.w $0150
	ASL
	TAX
	LDA.l DATA_01E4D9,x
	STA.b $00
	PLX
	LDA.b $1B
	XBA
	AND.w #$00FF
	TAY
	LDA.w $6CAA,y
	AND.w #$003F
	ASL
	TAY
	LDA.b ($00),y
	AND.b $02
	RTL

;---------------------------------------------------------------------------

CODE_01E52D:
	JSL.l CODE_008277
	JSL.l CODE_00831C
	LDA.b #$2E
	STA.l $704070
	JSR.w CODE_01E59A
	JML.l CODE_1083E2

;---------------------------------------------------------------------------

DATA_01E542:
	dw $3400,$47FF,$2A6E,$3485,$000F,$2A00,$2A02,$2A04
	dw $2A06,$2A08,$2A0A,$2A0C,$2A0E,$34A5,$000F,$2A20
	dw $2A22,$2A24,$2A26,$2A28,$2A2A,$2A2C,$2A2E,$34C5
	dw $000F,$2A40,$2A42,$2A44,$2A46,$2A48,$2A4A,$2A4C
	dw $2A4E,$34E5,$000F,$2A60,$2A62,$2A64,$2A66,$2A68
	dw $2A6A,$2A6C,$2A6E,$FFFF

;---------------------------------------------------------------------------

CODE_01E59A:
	JSL.l CODE_0394B8
	JSL.l CODE_008259
	LDX.w DATA_01AF80
	JSL.l CODE_00BDA2
	LDX.b #$702000>>16
	PHX
	PLB
	REP.b #$20
	LDX.b #$7E
CODE_01E5B1:
	STZ.w $702000,x
	STZ.w $702080,x
	STZ.w $702100,x
	STZ.w $702180,x
	DEX
	DEX
	BPL.b CODE_01E5B1
	LDA.w #$7FFF
	STA.w $702016
	SEP.b #$20
	PHK
	PLB
	LDA.b #$1E
	STA.w $0127
	JSL.l CODE_00E37B&$00FFFF
	JSR.w CODE_01E689
	LDA.b #$02
	STA.w $0125
	LDA.b #$50
	STA.w !REGISTER_HCountTimerLo
	LDA.b #$D8
	LDA.b #$B1
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	RTS

;---------------------------------------------------------------------------

CODE_01E5E9:
	LDA.b #$2E
	STA.l $704070
	JSR.w CODE_01E689
	LDA.w $0037
	AND.b #$80
	ORA.w $0038
	AND.b #$90
	BNE.b CODE_01E601
	JMP.w CODE_01E687

CODE_01E601:
	LDA.w $0037
	AND.b #$80
	BNE.b CODE_01E612
	LDA.l $704094
	TAX
	LDA.w DATA_01E6B7,x
	STA.b $53
CODE_01E612:
	LDA.b #$10
	STA.b $8F
	INC.w $0118
	STZ.w $038C
	TXA
	BNE.b CODE_01E687
	LDA.b #$01
	STA.w $038C
	JSR.w CODE_01B292
	REP.b #$20
	STZ.w $7E06
	STZ.w $03A1
	STZ.w $03A3
	STZ.w $03A5
	LDA.w $03B6
CODE_01E638:
	CMP.w #$0064
	BCC.b CODE_01E645
	SBC.w #$0064
	INC.w $03A1
	BRA.b CODE_01E638

CODE_01E645:
	CMP.w #$000A
	BCC.b CODE_01E652
	SBC.w #$000A
	INC.w $03A3
	BRA.b CODE_01E645

CODE_01E652:
	STA.w $03A5
	PHB
	LDY.b #DATA_17F551>>16
	PHY
	PLB
	REP.b #$30
	STZ.w $038E
	LDA.w $021A
	ASL
	TAY
	LDA.w $03BE
	ASL
	ASL
	ADC.w DATA_17F551,y
	TAY
	LDA.w DATA_17F5DB+$01,y
	STA.l $7F7E01
	SEP.b #$20
	LDA.w DATA_17F5DB,y
	STA.l $7F7E00
	LDA.w DATA_17F5DB+$03,y
	STA.l $7F7E03
	SEP.b #$10
	PLB
CODE_01E687:
	PLB
	RTL

CODE_01E689:
	JSR.w CODE_01E180
	LDA.l $704094
	TAX
	REP.b #$30
	LDA.w #$0000
	STA.l $7E4000
	DEC
	STA.l $7E4002
	SEP.b #$30
	RTS

CODE_01E6A2:
	JSL.l CODE_008277
	JSL.l CODE_00831C
	LDA.b #$21
	STA.l $704070
	JSR.w CODE_01E59A
	JML.l CODE_1083E2

DATA_01E6B7:
	db $43,$2E

;---------------------------------------------------------------------------

CODE_01E6B9:
	LDA.b #$21
	STA.l $704070
	JSR.w CODE_01E689
	LDA.w $0037
	AND.b #$80
	ORA.w $0038
	AND.b #$90
	BEQ.b CODE_01E6EC
	LDA.w $0037
	AND.b #$80
	BNE.b CODE_01E6DF
	LDA.l $704094
	TAX
	LDA.w DATA_01E6B7,x
	STA.b $53
CODE_01E6DF:
	INC.w $0118
	LDA.b #$10
	STA.b $8F
	TXA
	BNE.b CODE_01E6EC
	STZ.w $038C
CODE_01E6EC:
	PLB
	RTL

;---------------------------------------------------------------------------

DATA_01E6EE:
	db $0B,$1F

CODE_01E6F0:
	DEC.b $8F
	BNE.b CODE_01E70F
	LDA.l $704094
	TAX
	LDA.w DATA_01E6EE,x
	STA.w $0118
	DEX
	BMI.b CODE_01E70C
	LDA.w $021A
	CMP.b #$0B
	BNE.b CODE_01E70C
	STZ.w $021A
CODE_01E70C:
	STZ.w $0203
CODE_01E70F:
	PLB
	RTL

;---------------------------------------------------------------------------

DATA_01E711:
	dw $0000,$0002,$0004,$0006,$0008,$000A,$003D,$003F
	dw $0041,$0043,$0045,$0047,$0049,$004B,$004D,$004F
	dw $0087,$0089,$008B,$008D,$0099,$009B,$009D,$009F
	dw $009F,$00A1,$00A3,$00A5,$00A7,$00AB,$00AD,$00AF

DATA_01E751:
	db $00,$BE,$00,$BF,$00,$C0,$00,$C1,$00,$C2,$04,$C3,$01,$00,$61,$E7
	db $00,$B0,$00,$F7,$02,$00,$A0,$00,$07,$03,$00,$90,$00,$17,$03,$00
	db $80,$00,$27,$03,$00,$70,$00,$37,$03,$00,$60,$00,$47,$03,$00,$50
	db $00,$57,$03,$00,$40,$00,$67,$03,$00,$C0,$00,$00,$08,$00,$C4,$00
	db $C5,$00,$C6,$00,$CD,$00,$C7,$00,$C8,$00,$C9,$00,$CA,$00,$CB,$04
	db $CC,$01,$00,$A6,$E7,$00,$28,$00,$97,$01,$00,$16,$00,$B7,$01,$00
	db $28,$00,$D7,$01,$00,$16,$00,$F7,$01,$00,$28,$00,$17,$02,$00,$16
	db $00,$37,$02,$00,$28,$00,$57,$02,$00,$28,$00,$77,$02,$00,$40,$00
	db $B7,$02,$00,$80,$00,$00,$04,$00,$CD,$00,$CC,$00,$CE,$00,$CF,$01
	db $02,$C7,$02,$04,$57,$03,$02,$00,$04,$00,$D0,$00,$D1,$00,$D7,$00
	db $D2,$00,$D3,$00,$D4,$00,$D5,$04,$D6,$00,$00,$00,$D9,$00,$DA,$00
	db $DB,$00,$76,$00,$6E,$00,$66,$00,$5E

CODE_01E80A:
	LDA.w $0146
	CMP.b #$0A
	BNE.b CODE_01E814
	JMP.w CODE_01E88F

CODE_01E814:
	STZ.w $0D2B
	STZ.w $0D2D
	STZ.w $0D37
	STZ.w $0D39
	REP.b #$30
	LDA.w $013A
	ASL
	TAX
	LDY.w DATA_01E711,x
	LDA.w DATA_01E751,y
	AND.w #$00FF
	TAX
	JMP.w (DATA_01E834,x)

DATA_01E834:
	dw CODE_01E84F
	dw $0000
	dw CODE_01E83A

CODE_01E83A:
	SEP.b #$20
	LDA.b #!REGISTER_BG2HorizScrollOffset
	STA.w HDMA[$04].Destination
	LDA.w DATA_01E751+$02,y
	STA.w $0D2B
	REP.b #$20
	LDA.w DATA_01E751+$04,y
	STA.w $0D2F
CODE_01E84F:
	LDA.w DATA_01E751+$01,y
	AND.w #$00FF
	LDX.w #$5800
	JSL.l CODE_00B756
	STA.w DMA[$00].SizeLo
	SEP.b #$10
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$3800
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.w #$705800
	STA.w DMA[$00].SourceLo
	LDX.b #$705800>>16
	STX.w DMA[$00].SourceBank
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.w $0146
	CMP.b #$03
	BNE.b CODE_01E88E
	JSR.w CODE_01E8D1
CODE_01E88E:
	RTS

CODE_01E88F:
	REP.b #$30
	LDA.w #$00F2
	AND.w #$00FF
	LDX.w #$5800
	JSL.l CODE_00B756
	STA.w DMA[$00].SizeLo
	SEP.b #$10
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$3800
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.w #$705800
	STA.w DMA[$00].SourceLo
	LDX.b #$705800>>16
	STX.w DMA[$00].SourceBank
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	RTS

DATA_01E8C7:
	dw $8000,$0000,$0208

DATA_01E8CD:
	dw $0001,$FF08

CODE_01E8D1:
	LDA.b #!REGISTER_BG2HorizScrollOffset
	STA.w HDMA[$04].Destination
	LDA.b #!REGISTER_BG2VertScrollOffset
	STA.w HDMA[$03].Destination
	STZ.w $0D2B
	STZ.w $0D2D
	REP.b #$20
	LDA.w #DATA_01E8C7
	STA.w $0D2F
	LDA.w #DATA_01E8CD
	STA.w $0D31
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01E8F2:
	db $00,$34,$FF,$47,$CE,$01,$FF,$FF

DATA_01E8FA:
	db $00,$34,$FF,$47,$11,$01,$FF,$FF

DATA_01E902:
	db $00,$34,$FF,$47,$CE

DATA_01E907:
	db $01,$FF,$FF,$DC,$00,$01,$DD,$00,$FF,$E5,$00,$00,$E5,$00,$00,$DE
	db $00,$FF,$DF,$00,$FF,$E0,$00,$FF,$E4,$00,$FF,$00,$00,$00,$00,$00
	db $00,$E1,$00,$FF,$E6,$00,$00,$E7,$00,$00,$E8,$00,$1B,$E9,$00,$26
	db $EA,$00,$00,$EB,$00,$FF,$EC,$00,$00,$ED,$00,$80,$EE,$00,$31,$EF
	db $00,$00,$F0,$00,$00,$F1,$00,$00,$F2,$00,$00,$F3,$00,$00,$F4,$00
	db $00,$F5,$00,$00,$F6,$00,$00,$ED,$00,$3C,$F7,$00,$81,$F8,$00,$00
	db $F9,$00,$82,$FB,$00,$00,$FC,$00,$83,$FD,$00,$84,$FE,$00,$85,$FF
	db $00,$00,$00,$01,$00,$01,$01,$00,$02,$01,$00,$03,$01,$00,$04,$01
	db $86,$05,$01,$00,$06,$01,$87,$06,$01,$00,$07,$01,$00,$08,$01,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00

DATA_01E9AE:
	db $00,$02,$10,$00,$04,$10,$00,$04,$10,$00,$04,$10,$00,$04,$10,$00
	db $04,$10,$00,$04,$10,$00,$04,$12,$10,$00,$00,$06,$8A,$00,$04,$0A
	db $00,$04,$16,$0A,$06,$00,$06,$8A,$00,$04,$09,$00,$04,$17,$09,$06
	db $00,$06,$90,$00,$04,$06,$0D,$04,$0C,$13,$06,$00,$06,$F5,$00,$04
	db $81,$01,$04,$89,$02,$04,$00

CODE_01E9F5:
	LDY.b #$09
	LDA.w $013E
	BEQ.b CODE_01EA39
	ASL
	ADC.w $013E
	TAY
	REP.b #$20
	LDA.w DATA_01E907,y
	BEQ.b CODE_01EA40
	REP.b #$10
	LDX.w #$5800
	PHY
	JSL.l CODE_00B756
	PLY
	LDX.w $013E
	CPX.w #$0016
	BNE.b CODE_01EA43
	LDX.w #$5DA6
	STX.b $20
	LDX.w #$007E
	STX.b $22
	LDX.w #$5800
	STX.b $23
	LDX.w #$0070
	STX.b $25
	SEP.b #$10
	JSL.l CODE_008288
	SEP.b #$20
	LDY.b #$1B
CODE_01EA39:
	STY.w $0127
	JSL.l CODE_00E37B&$00FFFF
CODE_01EA40:
	SEP.b #$20
	RTS

CODE_01EA43:
	SEP.b #$10
	STA.w DMA[$00].SizeLo
	STA.b $00
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #$3400
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDA.w #$705800
	STA.w DMA[$00].SourceLo
	LDX.b #$705800>>16
	STX.w DMA[$00].SourceBank
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	LDA.w $0146
	CMP.w #$000A
	BNE.b CODE_01EA87
	LDA.b $00
	STA.w DMA[$00].SizeLo
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$5800
	STA.w DMA[$00].SourceLo
	STX.w !REGISTER_DMAEnable
CODE_01EA87:
	SEP.b #$20
	LDX.w DATA_01E907+$02,y
	BEQ.b CODE_01EA40
	CPX.b #$FF
	BEQ.b CODE_01EAA0
	TXA
	BPL.b CODE_01EAA9
	ASL
	CMP.b #$10
	BCS.b CODE_01EAA0
	TAX
	JSR.w (DATA_01EB29,x)
	BRA.b CODE_01EA40

CODE_01EAA0:
	LDA.b #$04
	TRB.w $0967
	TRB.w $0968
	RTS

CODE_01EAA9:
	LDA.l DATA_01E9AE,x
	STA.w $0D3B
	PHB
	LDA.b #$70
	PHA
	PLB
	REP.b #$10
	LDY.w #$0000
	STZ.b $08
CODE_01EABC:
	LDA.l DATA_01E9AE+$01,x
	BEQ.b CODE_01EB25
	STA.b $01
	REP.b #$20
	AND.w #$007F
	ASL
	ASL
	ASL
	ASL
	STA.b $02
	LDA.l DATA_01E9AE+$02,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	STA.b $04
	LDA.l DATA_01E9AE+$03,x
	AND.w #$00FF
	STA.b $06
CODE_01EAE5:
	LDA.b $04
	SEC
	SBC.b $08
	STA.w $3D4C,y
	LDA.w #$0010
	BIT.b $00
	BMI.b CODE_01EAFE
	LDA.b $04
	CLC
	ADC.w #$0010
	STA.b $04
	LDA.b $02
CODE_01EAFE:
	STA.w $3D4A,y
	LDA.b $08
	CLC
	ADC.w #$0010
	STA.b $08
	LDA.b $06
	STA.w $3D4E,y
	TYA
	CLC
	ADC.w #$0006
	TAY
	LDA.b $02
	SEC
	SBC.w #$0010
	STA.b $02
	BNE.b CODE_01EAE5
	SEP.b #$20
	INX
	INX
	INX
	BRA.b CODE_01EABC

CODE_01EB25:
	PLB
	SEP.b #$10
	RTS

;---------------------------------------------------------------------------

DATA_01EB29:
	dw $EB3D,$EC86,$EC7F,$ED77,$ED14,$ED8C,$EC86,$EC78

DATA_01EB39:
	dw $3740

DATA_01EB3B:
	dw $0680

CODE_01EB3D:
	PHX
	LDY.b #$21
	STY.w $0127
	JSL.l CODE_00E37B&$00FFFF
	PLA
	REP.b #$20
	AND.w #$00FF
	ASL
	TAX
	LDA.w DATA_01EB39,x
	STA.w !REGISTER_VRAMAddressLo
	LDA.w #$0800
	SEC
	SBC.w DATA_01EB3B,x
	STA.w DMA[$00].SizeLo
	LDX.b #$80
	STX.w !REGISTER_VRAMAddressIncrementValue
	LDA.w #(!REGISTER_WriteToVRAMPortLo&$0000FF<<8)+$01
	STA.w DMA[$00].Parameters
	LDX.b #$705800>>16
	STX.w DMA[$00].SourceBank
	LDA.w #$705800
	STA.w DMA[$00].SourceLo
	LDX.b #$01
	STX.w !REGISTER_DMAEnable
	SEP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_01EB7D:
	db $00,$20,$00,$07,$00,$00,$30,$00,$27,$00,$00,$20,$00,$37,$00,$00
	db $2E,$00,$57,$00,$00,$20,$00,$67,$00,$00,$2C,$00,$87,$00,$00,$20
	db $00,$97,$00,$00,$2A,$00,$B7,$00,$00,$10,$00,$37,$01,$00,$28,$00
	db $57,$01,$00,$20,$00,$67,$01,$00,$40,$00,$00,$08

DATA_01EBB9:
	db $00,$1A,$00,$17,$06,$00,$2E,$00,$57,$06,$00,$19,$00,$77,$06,$00
	db $2C,$00,$C7,$06,$00,$18,$00,$D7,$06,$00,$2A,$00,$07,$07,$00,$17
	db $00,$17,$07,$00,$28,$00,$57,$07,$00,$16,$00,$67,$07,$00,$C0,$00
	db $B7,$07,$00,$40,$01,$00,$08

DATA_01EBF0:
	db $00,$16,$00,$77,$07,$82,$00,$90,$00,$00,$08,$A0

DATA_01EBFC:
	db $00,$2A,$00,$27,$00,$00,$1A,$00,$57,$00,$00,$28,$00,$87,$00,$00
	db $18,$00,$B7,$00,$00,$26,$00,$E7,$00,$00,$16,$00,$07,$01,$00,$12
	db $00,$27,$01,$82,$00,$10,$00,$67,$01,$10,$80,$00,$20,$00,$87,$01
	db $00,$30,$00,$00,$08

DATA_01EC31:
	db $00,$00,$00,$17,$00,$00,$20,$00,$37,$00,$00,$00,$00,$47,$00,$00
	db $00,$00,$67,$00,$00,$1C,$00,$97,$00,$00,$1A,$00,$C7,$00,$00,$00
	db $00,$C7,$00,$00,$18,$00,$E7,$00,$00,$00,$00,$67,$01,$00,$40,$00
	db $00,$08

DATA_01EC63:
	db $82,$00,$00,$01,$00,$08,$08

DATA_01EC6A:
	dw DATA_01EB7D,DATA_01EBB9,DATA_01EBF0,DATA_01EBFC,$0000,DATA_01EC31,DATA_01EC63

CODE_01EC78:
	LDA.b #$04
	STA.w $0D43
	BRA.b CODE_01EC86

CODE_01EC7F:
	PHX
	LDX.b #$00
	JSR.w CODE_01ECAE
	PLX
CODE_01EC86:
	LDA.b #$01
	STA.w $0D3D
	REP.b #$20
	LDA.w DATA_01EC6A-$02,x
	STA.w $0D3F
	SEP.b #$30
	RTS

;---------------------------------------------------------------------------

DATA_01EC96:
	db $11,$06,$B7,$07,$15,$02,$00,$08

DATA_01EC9E:
	db $22,$20,$87,$07,$22,$62,$00,$08

DATA_01ECA6:
	db $08,$08

DATA_01ECA8:
	dw DATA_01EC96,DATA_01EC9E

DATA_01ECAC:
	db !REGISTER_MainScreenLayers,!REGISTER_ColorMathInitialSettings

CODE_01ECAE:
	LDA.w DATA_01ECA6,x
	INC
	STA.w $0D27
	REP.b #$20
	TXA
	AND.w #$00FF
	TAY
	ASL
	TAX
	LDA.w DATA_01ECA8,x
	STA.w $0D28
	SEP.b #$20
	LDA.b #$41
	STA.w HDMA[$04].Parameters
	LDA.w DATA_01ECAC,y
	STA.w HDMA[$04].Destination
	RTS

;---------------------------------------------------------------------------

DATA_01ECD2:
	db $00,$29,$07,$01,$65,$07,$00,$00,$08,$FF

DATA_01ECDC:
	db $0C,$00,$0C,$00,$E0,$00,$19,$00,$1F,$12,$40,$00,$1F,$12,$19,$00
	db $40,$00,$0C,$00,$0C,$00,$50,$00,$FF,$FF

DATA_01ECF6:
	db $2C,$5E,$2C,$5E,$E0,$00,$EE,$6E,$F8,$6E,$40,$00,$F8,$6E,$EE,$6E
	db $40,$00,$2C,$5E,$2C,$5E,$50,$00,$FF,$FF

DATA_01ED10:
	dw DATA_01ECDC,DATA_01ECF6

CODE_01ED14:
	JSR.w CODE_01EC86
	LDY.b #$00
	LDA.w $0140
	AND.b #$01
	BEQ.b CODE_01ED22
	LDY.b #$02
CODE_01ED22:
	REP.b #$20
	LDA.w #$0001
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w DATA_01ED10,y
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDX.b #FXCODE_08EBB5>>16
	LDA.w #FXCODE_08EBB5
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$56DE
	STA.b $20
	LDY.b #$7F
	STY.b $22
	LDA.w #$5800
	STA.b $23
	LDY.b #$70
	STY.b $25
	LDA.w #$0522
	JSL.l CODE_008288
	LDA.w #DATA_01ECD2
	STA.w $0D47
	STZ.w $0D4B
	STZ.w $0D2B
	STZ.w $0D2D
	SEP.b #$20
	LDA.b #!REGISTER_BG3VertScrollOffset
	STA.w HDMA[$04].Destination
	INC.w $0D0D
	LDA.w $094A
	ORA.b #$06
	STA.w $094A
	INC.w $0D45
	RTS

;---------------------------------------------------------------------------

CODE_01ED77:
	LDA.b #$17
	STA.w $0967
	LDA.b #$04
	STA.w $0968
	LDX.b #$01
	JSR.w CODE_01ECAE
	LDX.b #$06
	JSR.w CODE_01EC86
	RTS

;---------------------------------------------------------------------------

CODE_01ED8C:
	LDA.b #$A0
	STA.w $096B
	LDA.b #$64
	STA.w $096C
	RTS

;---------------------------------------------------------------------------

DATA_01ED97:
	db $9B,$ED,$A5,$ED,$FF,$20,$BD,$B2,$B6,$AE,$D0,$BE,$B9,$FD,$FF,$20
	db $C2,$B8,$BE,$D0,$B5,$B8,$BC,$BD,$FD

	%FREE_BYTES(NULLROM, 4688, $FF)

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro YIBank02Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_028000:
	db $00,$01,$03,$02,$04,$05,$06,$07,$00,$00,$00,$00,$00,$01,$03,$02
	db $04,$05,$06,$07,$00,$00,$00,$00,$00,$01,$03,$02,$04,$05,$06,$07
	db $00,$00,$00,$00,$00,$01,$03,$02,$04,$05,$06,$07,$00,$00,$00,$00
	db $00,$01,$03,$02,$04,$05,$06,$07,$00,$00,$00,$00,$00,$01,$03,$02
	db $04,$05,$06,$00,$00,$00,$00,$00

;---------------------------------------------------------------------------

CODE_028048:
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.b $16,x
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$0010
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$001F
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$8040
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDX.b #FXCODE_088295>>16
	LDA.w #FXCODE_088295
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	RTL

;---------------------------------------------------------------------------

CODE_02808C:
	LDA.w #$01D4
	JSL.l CODE_008B21
	LDA.w #$000B
	STA.w $7E4C,y
	LDA.w #$0006
	STA.w $7782,y
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	RTL

;---------------------------------------------------------------------------

CODE_0280AC:
	JSL.l CODE_02808C
	LDA.w #$0001
	STA.w $7E4E,y
	RTL

;---------------------------------------------------------------------------

DATA_0280B7:
	dw $0022,$0046,$006A

DATA_0280BD:
	db $02,$04,$06,$02,$04,$06,$00,$00,$00,$02,$04,$06,$02,$04,$06,$00
	db $00,$00,$0F,$10,$11,$0D,$07,$05,$0C,$0A,$0A,$0F,$10,$11,$0D,$07
	db $05,$0C,$0A,$0A,$0C,$10,$16,$0D,$07,$05,$0C,$0A,$0A,$0C,$10,$16
	db $0D,$07,$05,$0C,$0A,$0A,$0C,$10,$16,$0D,$07,$05,$0C,$0A,$0A,$0C
	db $10,$16,$0D,$07,$05,$0C,$0A,$0A,$01,$03,$05,$01,$03,$05,$00,$00
	db $00,$01,$03,$05,$01,$03,$05,$00,$00,$00,$07,$0C,$11,$03,$05,$08
	db $05,$09,$0D,$07,$0C,$11,$03,$05,$08,$05,$09,$0D

DATA_028129:
	dw $0028,$FFD8

CODE_02812D:
	LDA.w $0136
	CMP.w #$000A
	BNE.b CODE_02813E
	LDA.w $7042,x
	ORA.w #$0004
	STA.w $7042,x
CODE_02813E:
	JSR.w CODE_028183
	STZ.w $013E
	PHB
	PHK
	PLB
	LDY.w $0073
	LDA.w $70E2,x
	CLC
	ADC.w DATA_028129,y
	STA.w $70E2,x
	ORA.w #$0008
	STA.w $7E42
	LDA.w #$0104
	STA.w $0CB8
	STZ.w $7E40
	STZ.w $0CB4
	LDA.w $7042,x
	AND.w #$000E
	TAX
	LDY.w DATA_0280B7,x
	LDX.b #$22
CODE_028172:
	LDA.w DATA_0280BD,y
	STA.l $70404A,x
	DEY
	DEY
	DEX
	DEX
	BPL.b CODE_028172
	LDX.b $12
	PLB
	RTL

;---------------------------------------------------------------------------

CODE_028183:
	LDA.w $0CB2
	BEQ.b CODE_02818D
	PLA
	JML.l CODE_03A31E

CODE_02818D:
	INC.w $0CB2
	RTS

;---------------------------------------------------------------------------

DATA_028191:
	db $97,$81,$B1,$81,$CB,$81,$04,$10,$8E,$60,$00,$8E,$60,$00,$00,$60
	db $10,$00,$60,$04,$00,$00,$01,$42,$01,$02,$80,$02,$03,$C2,$03,$00
	db $04,$08,$E0,$50,$F8,$E0,$50,$F8,$20,$50,$08,$20,$50,$04,$60,$00
	db $01,$A2,$01,$02,$E0,$02,$03,$22,$03,$00,$08,$00,$C8,$60,$D9,$D9
	db $60,$C8,$00,$60,$D9,$27,$60,$00,$38,$60,$27,$27,$60,$38,$00,$60
	db $27,$D9,$60,$08,$E0,$00,$01,$C2,$01,$02,$A1,$02,$03,$83,$03,$04
	db $60,$04,$05,$42,$05,$06,$21,$06,$07,$03,$07

DATA_0281FC:
	dw $FC00,$04FF

DATA_028200:
	dw $0000,$00F0

DATA_028204:
	db $08,$C0,$FF,$00,$00

CODE_028209:
	JSL.l CODE_02841A
	LDA.w $7C16,x
	CLC
	ADC.w #$0070
	CMP.w #$00E1
	LDA.w #$0215
	BCS.b CODE_02822A
	LDA.w #$0710
	LDY.w $7E40
	DEY
	CPY.b #$BF
	BCS.b CODE_02822A
	LDA.w #$0714
CODE_02822A:
	STA.w $0967
	JSL.l CODE_03AF23
	LDA.w $7A96,x
	BNE.b CODE_02825F
	LDY.w $0CB4
	BNE.b CODE_028262
	LDA.w $7C16,x
	CLC
	ADC.w #$0030
	CMP.w #$0061
	BCS.b CODE_02825F
	LDA.w $7C18,x
	CLC
	ADC.w #$0030
	CMP.w #$0061
	BCS.b CODE_02825F
	LDA.w $60AC
	CMP.w #$0000
	BNE.b CODE_02825F
	INC.w $0CB4
	INY
CODE_02825F:
	JMP.w CODE_028417

CODE_028262:
	LDA.w $7A36,x
	CLC
	ADC.w DATA_0281FC,y
	CMP.w DATA_028200,y
	BNE.b CODE_028271
	LDA.w DATA_028200,y
CODE_028271:
	STA.w $7A36,x
	LDA.w $7A38,x
	AND.w #$00FF
	CLC
	ADC.w $7A36,x
	STA.w $7A38,x
	AND.w #$FF00
	BPL.b CODE_028289
	ORA.w #$00FF
CODE_028289:
	XBA
	CLC
	ADC.w $7E40
	STA.w $7E40
	SEC
	SBC.w DATA_028204,y
	EOR.w DATA_028200,y
	BMI.b CODE_0282D5
	LDA.w #$0040
	CPY.b #$01
	BEQ.b CODE_0282AD
	LDX.w $60AC
	CPX.b #$12
	BNE.b CODE_0282AB
	LDA.w #$0100
CODE_0282AB:
	LDX.b $12
CODE_0282AD:
	STA.w $7A96,x
	LDA.w DATA_028204,y
	STA.w $7E40
	STZ.w $7A36,x
	STZ.w $7A38,x
	LDA.w #$0000
	DEY
	BNE.b CODE_0282D2
	LDA.w #$0047
	JSL.l CODE_0085D2
	LDA.w #$0060
	STA.w $61C6
	LDA.w #$0003
CODE_0282D2:
	STA.w $0CB4
CODE_0282D5:
	TXY
	REP.b #$10
	LDA.w $7E40
	BIT.w #$0040
	PHP
	BEQ.b CODE_0282E5
	EOR.w #$003F
	INC
CODE_0282E5:
	EOR.w #$00FF
	INC
	AND.w #$003F
	ASL
	TAX
	LDA.l FXDATA_0BBA12,x
	LSR
	PLP
	BNE.b CODE_0282FA
	EOR.w #$FFFF
	INC
CODE_0282FA:
	SEP.b #$20
	STA.w !REGISTER_Mode7MatrixParameterA
	XBA
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.b #$60
	STA.w !REGISTER_Mode7MatrixParameterB
	LDA.w !REGISTER_PPUMultiplicationProductLo
	ASL
	REP.b #$20
	LDA.w !REGISTER_PPUMultiplicationProductMid
	ROL
	STA.w $0CBA
	LDA.w $60AC
	CMP.w #$0012
	BNE.b CODE_028322
	STY.w $61B6
	BRA.b CODE_028365

CODE_028322:
	LDA.w $0CB4
	DEC
	BNE.b CODE_028365
	LDA.w $0CB8
	SEC
	SBC.w #$0060
	ASL
	TAX
	LDA.l $702200,x
	STA.b $08
	SEP.b #$20
	STA.w !REGISTER_Mode7MatrixParameterA
	XBA
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.b #$30
	STA.w !REGISTER_Mode7MatrixParameterB
	REP.b #$20
	LDA.w !REGISTER_PPUMultiplicationProductMid
	STA.b $06
	LDA.w $608C
	SEC
	SBC.w $70E2,y
	STA.b $02
	BPL.b CODE_02835B
	EOR.w #$FFFF
	INC
CODE_02835B:
	CLC
	ADC.w #$0008
	STA.b $04
	CMP.b $06
	BCC.b CODE_028368
CODE_028365:
	JMP.w CODE_028415

CODE_028368:
	LDA.w $7E40
	AND.w #$00FF
	ASL
	TAX
	LDA.l DATA_00E9D4,x
	SEP.b #$20
	STA.w !REGISTER_Mode7MatrixParameterA
	XBA
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.b #$70
	STA.w !REGISTER_Mode7MatrixParameterB
	LDA.w !REGISTER_PPUMultiplicationProductMid
	CMP.b #$60
	REP.b #$20
	BCC.b CODE_028365
	LDA.w #$000B
	LDX.w $60C2
	BEQ.b CODE_028396
	LDA.w #$0005
CODE_028396:
	CLC
	ADC.w $7682,y
	SEC
	SBC.w $60B2
	BMI.b CODE_028415
	SEC
	SBC.w $0CBA
	BMI.b CODE_028415
	CMP.w #$0030
	BCS.b CODE_028415
	LDX.w $60C0
	BEQ.b CODE_0283D3
	LDX.w $60AA
	BPL.b CODE_0283B8
	STZ.w $60AA
CODE_0283B8:
	CLC
	ADC.w $6090
	STA.w $6090
	CLC
	ADC.w #$0010
	SEC
	SBC.w $7182,y
	BMI.b CODE_028415
	EOR.w #$FFFF
	SEC
	ADC.w $6090
	STA.w $6090
CODE_0283D3:
	LDA.w #$0012
	STA.w $60AC
	STZ.w $60B4
	STZ.w $60A8
	STZ.w $60AA
	JSL.l CODE_04F74A
	JSL.l CODE_03BFF7
	INC.w $0D94
	LDA.b $08
	ASL
	TAX
	LDA.l $702200,x
	SEP.b #$20
	STA.w !REGISTER_Mode7MatrixParameterA
	XBA
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.b $04
	STA.w !REGISTER_Mode7MatrixParameterB
	REP.b #$20
	LDA.w !REGISTER_PPUMultiplicationProductMid
	LDX.b $02
	BPL.b CODE_028410
	EOR.w #$FFFF
	INC
CODE_028410:
	STA.w $7E46
	REP.b #$20
CODE_028415:
	SEP.b #$10
CODE_028417:
	LDX.b $12
	RTL

CODE_02841A:
	LDY.b #$00
CODE_02841C:
	PHY
	PHB
	PHK
	PLB
	LDA.w DATA_028191,y
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w #$0078
	SEC
	SBC.w $7680,x
	STA.w $0041
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7682,x
	CLC
	ADC.w #$000F
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	CLC
	ADC.w $003B
	STA.w $0CB6
	LDA.w $0CB8
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7E40
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0002
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08BE9F>>16
	LDA.w #FXCODE_08BE9F
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	JSL.l CODE_00BE39	: db $40,$50,$7E,$72,$33,$70,$A4,$01
	LDA.w $094A
	AND.w #$00E7
	ORA.w #$0010
	STA.w $094A
	PLB
	LDX.b $12
	PLY
	CPY.b #$04
	BEQ.b CODE_02848B
	JSL.l CODE_03A2DE
	BCC.b CODE_02848B
	STZ.w $0CB2
CODE_02848B:
	RTL

;---------------------------------------------------------------------------

CODE_02848C:
	LDA.w #$0035
	JSL.l CODE_03A364
	BCS.b CODE_028499
	JML.l CODE_03A31E

CODE_028499:
	LDA.w #$0006
	STA.w $7978,y
	STA.w $7860,y
	TYA
	STA.b $18,x
	JSR.w CODE_0284E1
	LDY.b #$2D
	JSL.l CODE_0CE5D6
	LDA.w #$0047
	TXY
	JSL.l CODE_03A34E
	BCC.b CODE_0284CC
	LDA.w $70E2,x
	CLC
	ADC.w #$0040
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
	TXA
	STA.w $7978,y
CODE_0284CC:
	LDX.b #$3C
CODE_0284CE:
	LDA.l DATA_5FE67E,x
	STA.l $702E2E,x
	STA.l $7020C2,x
	DEX
	DEX
	BPL.b CODE_0284CE
	LDX.b $12
	RTL

;---------------------------------------------------------------------------

CODE_0284E1:
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
	RTS

;---------------------------------------------------------------------------

DATA_0284EE:
	dw $0100,$FF00

DATA_0284F2:
	dw $006C,$FFA0

CODE_0284F6:
	JSL.l CODE_03AF23
	LDY.b $18,x
	JSR.w CODE_0284E1
	LDA.w $7220,x
	STA.w $7220,y
	LDA.w $7220,x
	STA.w $7902,x
	STZ.w $7220,x
	LDA.w $61B4
	BNE.b CODE_02854F
	LDY.w $7D36,x
	BPL.b CODE_02854F
	LDA.w $60B4
	PHA
	JSL.l CODE_03D130
	PLA
	BCS.b CODE_02854F
	CMP.w $60B4
	BEQ.b CODE_02854F
	PHA
	CLC
	ADC.w #$0100
	CMP.w #$0201
	LDY.b #$00
	PLA
	BCC.b CODE_028542
	BPL.b CODE_028539
	LDY.b #$02
CODE_028539:
	LDA.w DATA_0284F2,y
	STA.w $7220,x
	LDA.w DATA_0284EE,y
CODE_028542:
	STA.w $60B4
	INC.w $61C2
	INC.w $60DC
	JSL.l CODE_0D90A1
CODE_02854F:
	LDY.b $18,x
	LDA.w $7978,y
	CMP.w #$0006
	BNE.b CODE_028592
	LDA.w $60AC
	CMP.w #$0002
	BNE.b CODE_0285DB
	LDA.w $1015
	BNE.b CODE_028579
	LDA.w $60C0
	BEQ.b CODE_028571
	LDA.w #$0040
	STA.w $7A96,x
CODE_028571:
	LDA.w $7A96,x
	BNE.b CODE_0285DB
	INC.w $1015
CODE_028579:
	BPL.b CODE_0285DB
	STZ.w $1015
	LDA.w #$0000
	STA.w $7978,y
	LDA.w #$0180
	STA.w $7A98,y
	LDA.w #$0100
	STA.w $7AF6,y
	BRA.b CODE_0285DB

CODE_028592:
	CMP.w #$0004
	BNE.b CODE_0285DB
	LDA.w $7542,x
	CMP.w #$0040
	BCS.b CODE_0285A2
	INC.w $7542,x
CODE_0285A2:
	LDA.w $7682,x
	CMP.w #$0300
	BCC.b CODE_0285DB
	LDA.w #$0005
	STA.w $7978,y
	LDA.w #$0040
	STA.w $7AF8,y
	LDA.w #$00FF
	STA.w $74A2,y
	LDA.w #$0047
	JSL.l CODE_0085D2
	LDA.w #$0060
	STA.w $61C6
	LDA.w $70E2,x
	STA.b $00
	LDA.w $7182,x
	STA.b $02
	JSL.l CODE_02E1A3
	JML.l CODE_03A32E

CODE_0285DB:
	LDA.w $7860,x
	AND.w #$0001
	STA.w $7860,y
	BEQ.b CODE_0285E9
	STZ.w $7222,x
CODE_0285E9:
	RTL

;---------------------------------------------------------------------------

CODE_0285EA:
	RTL

CODE_0285EB:
	JSR.w CODE_02893E
	JSL.l CODE_03AF23
	LDA.b $18,x
	ASL
	TXY
	TAX
	JSR.w (DATA_028661,x)
	TXA
	STA.w $6012
	LDA.w $60B0
	STA.w $6014
	LDA.w $60B2
	STA.w $6016
	LDA.w $60C2
	STA.w $6018
	LDX.b #FXCODE_0A8390>>16
	LDA.w #FXCODE_0A8390
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $601A
	BEQ.b CODE_028639
	LDA.w #$0013
	JSL.l CODE_0085D2
	LDA.w $60B4
	CLC
	ADC.w #$FF80
	CMP.w #$FC00
	BPL.b CODE_028636
	LDA.w #$FC00
CODE_028636:
	STA.w $60B4
CODE_028639:
	LDA.w $6014
	BEQ.b CODE_028650
	LDA.w $7220
	CLC
	ADC.w #$FF80
	CMP.w #$FE00
	BPL.b CODE_02864D
	LDA.w #$FE00
CODE_02864D:
	STA.w $7220
CODE_028650:
	LDY.w $7D36,x
	DEY
	BMI.b CODE_028660
	LDA.w $7D38,y
	BEQ.b CODE_028660
	TYX
	JSL.l CODE_03B25B
CODE_028660:
	RTL

DATA_028661:
	dw CODE_028687
	dw CODE_02879B
	dw CODE_028827
	dw CODE_028874
	dw CODE_0288AA
	dw CODE_0288FF
	dw CODE_02866F

CODE_02866F:
	TYX
	RTS

DATA_028671:
	db $00,$01,$02,$03,$04,$05,$06,$07
	db $08,$09,$08

DATA_02867C:
	db $01,$01,$01,$02,$02,$03,$04,$08
	db $04,$08,$04

CODE_028687:
	TYX
	LDY.w $7041,x
	CPY.b #$20
	BCC.b CODE_02870B
	LDA.w $7AF8,x
	BNE.b CODE_0286B5
	LDY.b $78,x
	INY
	CPY.b #$0C
	BCC.b CODE_0286A0
	STZ.w $60AC
	LDY.b #$08
CODE_0286A0:
	TYA
	STA.b $78,x
	LDA.w DATA_028671-$01,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w DATA_02867C-$01,y
	AND.w #$00FF
	STA.w $7AF8,x
CODE_0286B5:
	LDA.w $7A98,x
	BNE.b CODE_0286CC
	LDA.w #$0001
	STA.b $18,x
	LDA.w #$000F
	STA.b $78,x
	LDA.w #$0003
	STA.w $7A38,x
	BRA.b CODE_02870B

CODE_0286CC:
	LDA.w $7AF6,x
	BNE.b CODE_0286F9
	LDA.b $76,x
	CMP.w #$0007
	BCC.b CODE_0286F9
	LDA.w $7C16,x
	CMP.w #$0030
	BCS.b CODE_0286F9
	LDA.w $7C18,x
	CMP.w #$0030
	BCS.b CODE_0286F9
	LDA.w #$0002
	STA.b $18,x
	LDA.w #$000A
	STA.b $76,x
	STZ.w $7AF8,x
	STZ.b $16,x
	BRA.b CODE_02870B

CODE_0286F9:
	LDA.w $7A36,x
	CMP.w #$0800
	BCC.b CODE_02870B
	LDA.w #$0003
	STA.b $18,x
	STZ.b $78,x
	STZ.w $7AF8,x
CODE_02870B:
	LDA.w $7860,x
	BNE.b CODE_028739
	LDA.w #$0082
	JSL.l CODE_0085D2
	LDA.w #$0004
	STA.b $18,x
	LDA.w #$000E
	STA.b $76,x
	STZ.b $16,x
	LDA.w $7182,x
	STA.b $78,x
	LDA.w #$0013
	STA.w $7402,x
	LDA.w #$0004
	STA.w $7AF8,x
	JSL.l CODE_02A982
	RTS

CODE_028739:
	LDA.b $16,x
	CLC
	ADC.w #$0008
	CMP.w #$0101
	BCC.b CODE_028768
	LDA.b $76,x
	INC
	CMP.w #$0009
	BCC.b CODE_028763
	LDY.w $7041,x
	CPY.b #$20
	BCS.b CODE_028760
	LDA.w $7040,x
	CLC
	ADC.w #$6000
	STA.w $7040,x
	STZ.w $60AC
CODE_028760:
	LDA.w #$0007
CODE_028763:
	STA.b $76,x
	LDA.w #$0000
CODE_028768:
	STA.b $16,x
	LDA.w $7220,x
	DEC
	BPL.b CODE_028775
CODE_02876F:
	STZ.w $7A36,x
	BRA.b CODE_02877C

CODE_028775:
	CLC
	ADC.w $7A36,x
	STA.w $7A36,x
CODE_02877C:
	RTS

DATA_02877D:
	db $06,$05,$04,$03,$02,$01,$0A,$0B
	db $0A,$02,$03,$04,$05,$06,$07

DATA_02878C:
	db $01,$01,$01,$01,$01,$01,$02,$10
	db $02,$01,$01,$01,$01,$01,$10

CODE_02879B:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_0287B7
	LDY.b $78,x
	BNE.b CODE_0287BB
	DEC.w $7A38,x
	BNE.b CODE_0287B9
	LDA.w #$01C0
	STA.w $7A98,x
	STZ.b $18,x
	LDA.w #$0008
	STA.b $78,x
CODE_0287B7:
	BRA.b CODE_028824

CODE_0287B9:
	LDY.b #$0F
CODE_0287BB:
	DEY
	TYA
	STA.b $78,x
	LDA.w DATA_02878C,y
	AND.w #$00FF
	STA.w $7A98,x
	LDA.w DATA_02877D,y
	AND.w #$00FF
	STA.w $7402,x
	CMP.w #$000B
	BNE.b CODE_028824
	LDA.w #$0038
	JSL.l CODE_03A364
	BCC.b CODE_028824
	PHY
	LDA.w #$0004
	JSL.l CODE_0085D2
	PLY
	LDA.w $70E2,x
	CLC
	ADC.w $6000
	SEC
	SBC.w #$0008
	STA.w $70E2,y
	LDA.w $7182,x
	CLC
	ADC.w $6002
	CLC
	ADC.w #$0006
	STA.w $7182,y
	LDA.w #$FE80
	STA.w $7220,y
	LDA.w #$0010
	STA.w $7540,y
	LDA.w #$0120
	STA.w $7A96,y
	LDA.w #$0002
	STA.w $7A98,y
	LDA.w #$0020
	STA.w $7AF6,y
	LDX.b $12
CODE_028824:
	JMP.w CODE_02870B

CODE_028827:
	TYX
	LDA.b $76,x
	ASL
	TAY
	LDA.b $16,x
	CLC
	ADC.w DATA_028A41,y
	CMP.w #$0101
	BCC.b CODE_02885B
	LDA.b $76,x
	INC
	CMP.w #$000D
	BCC.b CODE_02884A
	STZ.b $18,x
	LDA.w #$0080
	STA.w $7AF6,x
	LDA.w #$0007
CODE_02884A:
	STA.b $76,x
	CMP.w #$000B
	BNE.b CODE_028858
	LDA.w #$0083
	JSL.l CODE_0085D2
CODE_028858:
	LDA.w #$0000
CODE_02885B:
	STA.b $16,x
	RTS

DATA_02885E:
	db $07,$06,$05,$0C,$0D,$0E,$0F,$10
	db $11,$10,$0F

DATA_028869:
	db $10,$01,$01,$01,$01,$01,$10,$02
	db $20,$02,$10

CODE_028874:
	TYX
	LDA.w $7AF8,x
	BNE.b CODE_0288A5
	LDY.b $78,x
	INY
	CPY.b #$0C
	BCC.b CODE_028890
	STZ.b $18,x
	STZ.w $7A36,x
	LDA.w #$0008
	STA.b $78,x
	STZ.w $7AF6,x
	BRA.b CODE_0288A5

CODE_028890:
	TYA
	STA.b $78,x
	LDA.w DATA_02885E-$01,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w DATA_028869-$01,y
	AND.w #$00FF
	STA.w $7AF8,x
CODE_0288A5:
	JMP.w CODE_02870B

DATA_0288A8:
	db $02,$FF

CODE_0288AA:
	TYX
	LDA.w $7182,x
	SEC
	SBC.b $78,x
	CMP.w #$007E
	BCS.b CODE_0288E7
	XBA
	STA.w !REGISTER_DividendLo
	LDY.b #$7E
	STY.w !REGISTER_Divisor
	LDA.w $7AF8,x
	BNE.b CODE_0288DB
	LDY.w $7402,x
	CPY.b #$14
	BEQ.b CODE_0288CC
	INY
CODE_0288CC:
	TYA
	STA.w $7402,x
	LDA.w DATA_0288A8-$13,y
	AND.w #$00FF
	STA.w $7AF8,x
	BRA.b CODE_0288E1

CODE_0288DB:
	NOP #6
CODE_0288E1:
	LDA.w !REGISTER_QuotientLo
	STA.b $16,x
	RTS

CODE_0288E7:
	LDA.b $76,x
	CMP.w #$000E
	BNE.b CODE_0288F2
	INC.b $76,x
	STZ.b $16,x
CODE_0288F2:
	LDA.b $16,x
	CMP.w #$0100
	BCS.b CODE_0288FE
	ADC.w #$0010
	STA.b $16,x
CODE_0288FE:
	RTS

CODE_0288FF:
	TYX
	LDA.w $7AF8,x
	BEQ.b CODE_028906
	RTS

CODE_028906:
	LDA.w $0039
	CLC
	ADC.w #$0078
	STA.b $00
	LDA.w $003B
	CLC
	ADC.w #$00C0
	STA.b $02
	JSL.l CODE_0D8ED7
	JSL.l CODE_03A32E
	PLA
	RTL

;---------------------------------------------------------------------------

CODE_028922:
	STZ.w $60B4
CODE_028925:
	LDA.w #$0002
	STA.w $60AC
	STZ.w $617A
	STZ.w $617C
	STZ.w $61D6
	STZ.w $60DE
	STZ.w $60EA
	STZ.w $60E0
	RTL

;---------------------------------------------------------------------------

CODE_02893E:
	LDY.w $74A2,x
	BPL.b CODE_028944
	RTS

CODE_028944:
	LDA.w $7978,x
	CMP.w #$0006
	BNE.b CODE_028958
	LDA.w #$0008
	STA.b $00
	STZ.b $02
	JSR.w CODE_0289CB
	PLA
	RTL

CODE_028958:
	LDA.b $76,x
	ASL
	TAY
	LDA.w DATA_028A33,y
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w DATA_028A33+$02,y
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0002
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0042
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STZ.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$449E
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.b $16,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $7680,x
	CLC
	ADC.w #$0002
	STA.w $6040
	LDA.w $7682,x
	SEC
	SBC.w #$0008
	STA.w $6042
	LDX.b #FXCODE_08E93B>>16
	LDA.w #FXCODE_08E93B
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	JSL.l CODE_00BE39	: db $40,$50,$7E,$72,$33,$70,$48,$03
	LDX.b $12
	LDA.w #$0002
	STA.w $0968
	LDA.w #$0065
	STA.w $096C
	LDA.w #$0018
	TSB.w $094A
	LDA.l $7045A2
	STA.b $00
	LDA.l $7045A4
	STA.b $02
CODE_0289CB:
	REP.b #$10
	LDY.w $7362,x
	LDX.w #$0003
CODE_0289D3:
	LDA.w $6000,y
	CLC
	ADC.b $00
	STA.w $6000,y
	LDA.w $6002,y
	CLC
	ADC.b $02
	STA.w $6002,y
	TYA
	CLC
	ADC.w #$0008
	TAY
	DEX
	BNE.b CODE_0289D3
	LDX.b $12
	LDA.w $7040,x
	CMP.w #$2000
	BCC.b CODE_028A2E
	LDA.l $70459E
	SEC
	SBC.w #$0010
	STA.w $6000
	LDA.l $7045A0
	SEC
	SBC.w #$0004
	STA.w $6002
	LDX.w #$000C
CODE_028A11:
	LDA.w $6000,y
	CLC
	ADC.w $6000
	STA.w $6000,y
	LDA.w $6002,y
	CLC
	ADC.w $6002
	STA.w $6002,y
	TYA
	CLC
	ADC.w #$0008
	TAY
	DEX
	BNE.b CODE_028A11
CODE_028A2E:
	SEP.b #$10
	LDX.b $12
	RTS

DATA_028A33:
	dw $8A5D,$8AE1,$8B65,$8BE9,$8C6D,$8CF1,$8D75

DATA_028A41:
	dw $8DF9,$8E7D,$8DF9,$8DF9,$8F01,$8F85,$8DF9
	dw $8DF9,$9009,$8BE9

DATA_028A55:
	db $08,$00,$10,$00,$08,$00,$08,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00,$01,$00
	db $01,$00,$01,$00,$02,$00,$02,$00,$02,$00,$02,$00,$03,$00,$03,$00
	db $03,$00,$03,$00,$04,$00,$04,$00,$04,$00,$04,$00,$06,$00,$06,$00
	db $06,$00,$06,$00,$08,$00,$08,$00,$08,$00,$08,$00,$0A,$00,$0A,$00
	db $0A,$00,$0A,$00,$0B,$00,$0B,$00,$0B,$00,$0B,$00,$0C,$00,$0C,$00
	db $0C,$00,$0C,$00,$0D,$00,$0D,$00,$0D,$00,$0D,$00,$0D,$00,$0D,$00
	db $0D,$00,$0D,$00,$0E,$00,$0E,$00,$0E,$00,$0E,$00,$0E,$00,$0E,$00
	db $0E,$00,$0E,$00,$0E,$00,$0F,$00,$0F,$00,$08,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$01,$00,$01,$00,$01,$00
	db $01,$00,$01,$00,$01,$00,$01,$00,$02,$FF,$02,$FF,$02,$FF,$02,$FF
	db $03,$FF,$03,$FF,$03,$FF,$03,$FF,$04,$FE,$04,$FE,$04,$FE,$04,$FE
	db $06,$FE,$06,$FE,$06,$FE,$06,$FE,$08,$FE,$08,$FE,$08,$FE,$08,$FE
	db $0A,$FE,$0A,$FE,$0A,$FE,$0A,$FE,$0B,$FE,$0B,$FE,$0B,$FE,$0B,$FE
	db $0C,$FF,$0C,$FF,$0C,$FF,$0C,$FF,$0D,$FF,$0D,$FF,$0D,$FF,$0D,$FF
	db $0D,$FF,$0D,$FF,$0D,$FF,$0D,$FF,$0E,$00,$0E,$00,$0E,$00,$0E,$00
	db $0E,$00,$0E,$00,$0E,$00,$0E,$00,$0E,$00,$0F,$00,$0F,$00,$08,$00
	db $00,$00,$00,$00,$00,$00,$02,$FF,$02,$FF,$02,$FF,$03,$FD,$03,$FD
	db $03,$FD,$03,$FD,$04,$FB,$04,$FB,$04,$FB,$04,$FB,$05,$F8,$05,$F8
	db $05,$F8,$05,$F8,$05,$F5,$05,$F5,$05,$F5,$05,$F5,$06,$F2,$06,$F2
	db $06,$F2,$06,$F2,$08,$F1,$08,$F1,$08,$F1,$08,$F1,$0B,$F1,$0B,$F1
	db $0B,$F1,$0B,$F1,$0F,$F1,$0F,$F1,$0F,$F1,$0F,$F1,$10,$F2,$10,$F2
	db $10,$F2,$10,$F2,$12,$F3,$12,$F3,$12,$F3,$12,$F3,$13,$F6,$13,$F6
	db $13,$F6,$13,$F6,$12,$F9,$12,$F9,$12,$F9,$12,$F9,$12,$FB,$12,$FB
	db $12,$FB,$12,$FB,$0F,$FE,$0F,$FE,$0F,$FE,$0F,$FE,$0F,$FE,$0F,$00
	db $0F,$00,$0B,$F5,$00,$00,$00,$FF,$FF,$FE,$FF,$FD,$FE,$FC,$FE,$FB
	db $FE,$FA,$FE,$F9,$FF,$F8,$FF,$F6,$00,$F5,$00,$F3,$00,$F1,$00,$F0
	db $FF,$EF,$FE,$EE,$FD,$ED,$FC,$EB,$FB,$EA,$FB,$E9,$FA,$E8,$FA,$E7
	db $FA,$E5,$FB,$E4,$FC,$E3,$FD,$E2,$FF,$E1,$00,$E1,$02,$E1,$03,$E1
	db $05,$E1,$07,$E1,$09,$E1,$0A,$E1,$0C,$E2,$0D,$E3,$0F,$E3,$10,$E3
	db $11,$E4,$12,$E4,$14,$E5,$15,$E6,$16,$E7,$16,$E8,$17,$E9,$17,$EB
	db $17,$ED,$16,$EF,$15,$F0,$13,$F1,$11,$F2,$10,$F3,$0F,$F4,$0E,$F5
	db $0D,$F6,$0C,$F7,$0C,$F9,$0C,$FA,$0C,$FB,$0C,$FC,$0C,$FD,$0D,$FE
	db $0E,$FF,$0F,$00,$0F,$00,$05,$E5,$00,$00,$01,$FE,$02,$FD,$02,$FC
	db $03,$FB,$03,$FA,$03,$F7,$02,$F6,$01,$F4,$00,$F3,$FF,$F2,$FE,$F1
	db $FC,$EF,$FB,$ED,$FA,$EB,$FA,$E9,$F8,$E7,$F5,$E6,$F2,$E4,$F1,$E2
	db $F0,$E0,$F0,$DE,$F0,$DB,$F2,$D9,$F4,$D7,$F7,$D5,$F9,$D4,$FB,$D2
	db $FD,$D1,$FF,$D1,$01,$D1,$03,$D1,$05,$D1,$07,$D2,$09,$D3,$0A,$D4
	db $0C,$D5,$0E,$D5,$10,$D6,$12,$D7,$13,$D9,$14,$DA,$14,$DC,$14,$DE
	db $15,$E0,$16,$E1,$18,$E3,$19,$E5,$1A,$E7,$1A,$E9,$1B,$EB,$1B,$ED
	db $1A,$EF,$18,$F1,$16,$F3,$15,$F5,$16,$F7,$17,$F9,$17,$FB,$16,$FD
	db $14,$FE,$12,$FF,$10,$FF,$0F,$00,$0F,$00,$01,$D5,$00,$00,$FF,$FF
	db $FD,$FF,$FB,$FD,$FA,$FB,$F9,$F9,$F8,$F7,$F8,$F5,$F8,$F3,$F9,$F1
	db $F9,$EF,$F9,$EC,$F9,$E9,$F7,$E7,$F5,$E6,$F3,$E4,$F2,$E1,$F3,$DD
	db $F2,$D9,$EF,$D6,$EE,$D3,$ED,$CE,$EE,$CA,$EF,$C6,$F1,$C3,$F4,$C0
	db $F6,$BE,$F8,$BB,$FC,$BA,$00,$B9,$04,$B9,$07,$B9,$0B,$BA,$0E,$BA
	db $10,$BB,$12,$BC,$14,$BD,$16,$BF,$18,$C1,$18,$C3,$17,$C6,$18,$C8
	db $1C,$CA,$1F,$CC,$20,$D0,$21,$D2,$22,$D6,$20,$DB,$1D,$DE,$1A,$E2
	db $18,$E5,$16,$E7,$14,$E9,$13,$EB,$11,$ED,$10,$EF,$0F,$F1,$0E,$F4
	db $0D,$F6,$0D,$F9,$0E,$FB,$0E,$FD,$0F,$FF,$0F,$00,$0F,$00,$04,$BD
	db $00,$00,$FF,$FE,$FF,$FB,$FE,$F8,$FE,$F5,$FC,$F2,$FA,$EF,$F9,$EC
	db $F8,$E9,$F8,$E6,$F9,$E3,$F8,$E0,$F7,$DC,$F5,$D7,$F4,$D4,$F1,$D3
	db $EE,$D0,$ED,$CC,$ED,$C8,$EE,$C3,$EA,$C0,$E9,$BA,$E9,$B5,$EA,$B0
	db $EC,$AB,$EF,$A7,$F3,$A3,$FA,$9E,$00,$9C,$05,$9A,$0F,$99,$15,$9A
	db $1A,$9C,$1E,$9E,$21,$A0,$23,$A3,$25,$A5,$26,$A8,$26,$AC,$27,$B0
	db $26,$B5,$24,$BA,$20,$BD,$1C,$C0,$18,$C5,$16,$CA,$15,$D0,$17,$D5
	db $1A,$D9,$1C,$DD,$1C,$E0,$1C,$E3,$1C,$E6,$1C,$E9,$1B,$EB,$1A,$ED
	db $19,$F0,$18,$F3,$17,$F6,$15,$F9,$13,$FB,$12,$FD,$10,$FF,$0F,$00
	db $0F,$00,$0F,$9D,$00,$00,$00,$FD,$FF,$FA,$FF,$F7,$FF,$F4,$00,$F1
	db $FF,$EE,$FE,$EB,$FE,$E8,$FB,$E5,$FA,$E1,$F7,$DD,$F2,$D7,$EE,$D1
	db $EC,$CC,$EA,$C7,$EB,$C0,$EB,$BA,$E9,$B5,$E8,$B0,$E6,$AA,$E6,$A4
	db $E7,$9E,$EA,$98,$EC,$92,$EE,$8C,$F2,$88,$F6,$85,$FA,$83,$FF,$82
	db $05,$82,$0A,$83,$0F,$84,$13,$86,$17,$88,$19,$8A,$1C,$8D,$1F,$90
	db $21,$93,$23,$96,$24,$9C,$25,$A1,$24,$A7,$22,$AC,$1E,$B0,$1C,$B8
	db $1D,$BE,$20,$C4,$23,$CA,$24,$D0,$23,$D6,$23,$DA,$21,$DE,$1F,$E2
	db $1C,$E5,$19,$E9,$17,$EC,$16,$F0,$15,$F4,$14,$F7,$12,$F9,$0F,$FC
	db $0C,$FE,$0B,$00,$FE,$98,$05,$86,$00,$00,$01,$FD,$00,$FA,$FF,$F7
	db $FC,$F4,$FA,$F1,$F8,$EE,$F6,$EB,$F5,$E8,$F5,$E4,$F4,$DF,$F4,$DA
	db $F3,$D5,$F3,$D0,$F2,$CB,$F1,$C6,$ED,$C0,$EA,$BA,$E8,$B6,$E6,$B0
	db $E7,$AA,$E8,$A4,$E8,$9D,$EB,$97,$EE,$91,$F1,$8C,$F6,$88,$FA,$85
	db $FE,$83,$01,$82,$06,$82,$0B,$82,$0F,$83,$13,$84,$17,$86,$1B,$88
	db $1E,$8A,$21,$8D,$23,$91,$24,$96,$24,$9C,$24,$A1,$22,$A7,$22,$AB
	db $24,$B1,$24,$B8,$21,$BF,$1E,$C5,$1E,$CC,$1F,$D0,$20,$D6,$21,$DB
	db $22,$DF,$22,$E3,$22,$E6,$22,$EA,$20,$ED,$1E,$F0,$1B,$F4,$17,$F7
	db $14,$F9,$10,$FC,$0D,$FE,$0B,$00,$F9,$9C,$06,$86,$00,$00,$00,$FE
	db $01,$FB,$02,$F9,$03,$F7,$05,$F4,$06,$F1,$06,$EE,$05,$EA,$04,$E6
	db $03,$E2,$02,$DF,$01,$DB,$FF,$D7,$FD,$D3,$FB,$CF,$FA,$CC,$F9,$C8
	db $F8,$C4,$F8,$BD,$F8,$B6,$F9,$B0,$FB,$AB,$FD,$A7,$00,$A3,$03,$A0
	db $07,$9E,$0A,$9D,$0E,$9C,$12,$9B,$16,$9B,$1A,$9B,$1E,$9C,$22,$9D
	db $26,$9E,$2A,$A0,$2E,$A2,$32,$A4,$35,$A6,$38,$A9,$3C,$AD,$40,$B2
	db $44,$B7,$47,$BB,$4A,$C1,$4D,$C7,$4F,$CE,$51,$D3,$52,$D7,$53,$DC
	db $53,$E0,$53,$E4,$52,$E8,$50,$EC,$4D,$F1,$4A,$F4,$47,$F7,$43,$F9
	db $3E,$FB,$37,$FD,$30,$FF,$27,$00,$1A,$00,$0F,$00,$37,$E0,$16,$9F
	db $00,$00,$E8,$00,$CF,$00,$B8,$00,$AA,$00,$9E,$FF,$97,$FE,$92,$F9
	db $90,$F3,$90,$ED,$91,$E9,$95,$E4,$9A,$E0,$A2,$DE,$A9,$DD,$B1,$DC
	db $B8,$DB,$BE,$D8,$C2,$D5,$C6,$D1,$C9,$CE,$CC,$CA,$CF,$C6,$D2,$C2
	db $D6,$BE,$D9,$BA,$DC,$B7,$E0,$B4,$E4,$B2,$E9,$B0,$ED,$B0,$F1,$B0
	db $F6,$B1,$FA,$B2,$FE,$B4,$02,$B6,$05,$B8,$07,$BA,$09,$BD,$0B,$C2
	db $0C,$C6,$0C,$CB,$0B,$CF,$0A,$D3,$07,$D7,$04,$DA,$01,$DC,$FE,$DF
	db $FB,$E2,$F7,$E5,$F4,$E6,$F1,$E8,$EE,$ED,$EF,$F1,$F2,$F4,$F5,$F5
	db $FA,$F7,$00,$F8,$04,$F8,$08,$F9,$0B,$FA,$0D,$FB,$0F,$FE,$0F,$00
	db $9F,$F0,$ED,$B4,$00,$00,$00,$FA,$00,$F4,$00,$EE,$00,$E8,$00,$E2
	db $00,$DC,$FF,$D6,$FF,$D0,$FC,$CA,$FC,$C2,$F9,$BA,$F5,$AE,$F2,$A2
	db $F0,$98,$EF,$8E,$F0,$80,$F0,$74,$EE,$6A,$ED,$60,$EC,$54,$EC,$48
	db $EC,$3C,$EF,$30,$F0,$24,$F2,$18,$F5,$10,$F8,$0A,$FC,$06,$00,$04
	db $04,$04,$08,$06,$0C,$08,$0F,$0C,$12,$10,$14,$14,$16,$1A,$18,$20
	db $1A,$26,$1C,$2C,$1C,$38,$1D,$42,$1C,$4E,$1B,$58,$18,$60,$16,$70
	db $17,$7C,$19,$88,$1C,$94,$1C,$A0,$1C,$AC,$1C,$B4,$1A,$BC,$18,$C4
	db $16,$CA,$14,$D2,$12,$D8,$11,$E0,$10,$E8,$10,$EE,$0E,$F2,$0C,$F8
	db $09,$FC,$08,$00,$FF,$30,$04,$08

;---------------------------------------------------------------------------

CODE_02908D:
	RTL

;---------------------------------------------------------------------------

DATA_02908E:
	dw $0010,$0018

DATA_029092:
	dw $0008,$0016

DATA_029096:
	dw $0000,$0001,$0002,$0003,$0004,$0005,$0004,$0005
	dw $0003,$0002,$0001,$0000

DATA_0290AE:
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0040,$0040
	dw $0000,$0000,$0000,$0000

DATA_0290C6:
	dw $0002,$0002,$0002,$0002,$0008,$0008,$0008,$0008
	dw $0006,$0006,$0006,$0006

DATA_0290DE:
	dw $FF80,$0080,$FF00,$0100

CODE_0290E6:
	JSL.l CODE_03AF23
	INC.b $16,x
	LDA.w $7A96,x
	BNE.b CODE_02910A
	LDA.w #$0008
	STA.w $7540,x
	STZ.w $75E0,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$FF80
	STA.w $75E2,x
	LDY.b #$02
	BRA.b CODE_029161

CODE_02910A:
	LDY.w $7D36,x
	BPL.b CODE_029113
	JSL.l CODE_03A858
CODE_029113:
	LDA.w $75E0,x
	BNE.b CODE_029127
	LDA.w $7220,x
	BNE.b CODE_02915F
	STZ.w $7540,x
	LDA.w $7AF6,x
	BNE.b CODE_02915F
	BRA.b CODE_029133

CODE_029127:
	LDA.b $16,x
	BIT.w #$001F
	BNE.b CODE_02915F
	AND.w #$0040
	BNE.b CODE_02914A
CODE_029133:
	LDY.b #$00
	LDA.w $7C16,x
	BPL.b CODE_02913C
	LDY.b #$02
CODE_02913C:
	LDA.w DATA_0290DE,y
	STA.w $75E0,x
	LDA.w #$0002
	STA.w $7540,x
	BRA.b CODE_02915F

CODE_02914A:
	LDY.b #$00
	LDA.w $7C18,x
	BPL.b CODE_029153
	LDY.b #$02
CODE_029153:
	LDA.w DATA_0290DE,y
	STA.w $75E2,x
	LDA.w #$0002
	STA.w $7542,x
CODE_02915F:
	LDY.b #$00
CODE_029161:
	LDA.w $7A98,x
	BNE.b CODE_029195
	LDA.b $18,x
	INC
	INC
	CMP.w DATA_02908E,y
	BNE.b CODE_02917A
	CPY.b #$00
	BEQ.b CODE_029177
	JML.l CODE_03A31E

CODE_029177:
	LDA.w DATA_029092,y
CODE_02917A:
	STA.b $18,x
	TAY
	LDA.w DATA_029096,y
	STA.w $7402,x
	LDA.w $7042,x
	AND.w #$00BF
	ORA.w DATA_0290AE,y
	STA.w $7042,x
	LDA.w DATA_0290C6,y
	STA.w $7A98,x
CODE_029195:
	RTL

;---------------------------------------------------------------------------

DATA_029196:
	db $40,!REGISTER_CGRAMAddress : dl $7E5C18

DATA_02919B:
	db $E9 : dw $7E528C
	db $E9 : dw $7E528C
	db $00

DATA_0291A2:
	db $02,!REGISTER_WriteToCGRAMPort : dl $7E51FC

DATA_0291A7:
	db $02,!REGISTER_WriteToCGRAMPort : dl $7E5244

DATA_0291AC:
	db $02,!REGISTER_BG3HorizScrollOffset : dl $7E51E4

DATA_0291B1:
	db $0B,$15,$1B,$12,$1A,$1F,$18,$1D,$1F,$03,$05,$08,$03,$0A,$11,$08
	db $0F,$17

CODE_0291C3:
	SEP.b #$20
	LDX.b #$04
CODE_0291C7:
	LDA.w DATA_029196,x
	STA.w HDMA[$01].Parameters,x
	LDA.w DATA_0291A2,x
	STA.w HDMA[$02].Parameters,x
	LDA.w DATA_0291AC,x
	STA.w HDMA[$03].Parameters,x
	LDA.w DATA_0291A7,x
	STA.w HDMA[$06].Parameters,x
	DEX
	BPL.b CODE_0291C7
	LDA.b #$7E528C>>16
	STA.w HDMA[$01].IndirectSourceBank
	STA.w HDMA[$02].IndirectSourceBank
	STA.w HDMA[$03].IndirectSourceBank
	STA.w HDMA[$06].IndirectSourceBank
	LDX.b #$06
CODE_0291F2:
	LDA.w DATA_02919B,x
	STA.l $7E5C18,x
	DEX
	BPL.b CODE_0291F2
	LDX.b #$6F
	LDA.b #$09
CODE_029200:
	STA.l $7E528C,x
	DEX
	BPL.b CODE_029200
	REP.b #$20
	LDX.b #$10
CODE_02920B:
	LDA.w DATA_0291B1,x
	STA.l $70404A,x
	DEX
	DEX
	BPL.b CODE_02920B
	LDA.w #$0000
	STA.l $702016
	STA.l $702D82
	LDX.b $12
	LDA.w $70E2,x
	ORA.w #$0008
	STA.w $70E2,x
	DEC.w $7182,x
	LDA.w #$0040
	STA.b $16,x
	RTL

;---------------------------------------------------------------------------

CODE_029235:
	JSR.w CODE_029316
	LDY.w $7E3E
	BEQ.b CODE_02924A
	LDA.w $7E46
	STA.b $00
	DEY
	CPY.b $12
	BEQ.b CODE_029298
	JMP.w CODE_029306

CODE_02924A:
	LDA.w $608C
	SEC
	SBC.w $70E2,x
	STA.b $00
	CLC
	ADC.w #$007F
	CMP.w #$00FF
	BCC.b CODE_02925F
	JMP.w CODE_029306

CODE_02925F:
	REP.b #$10
	LDA.b $16,x
	ASL
	TAX
	LDA.l DATA_00E954,x
	STA.b $02
	BPL.b CODE_029271
	EOR.w #$FFFF
	INC
CODE_029271:
	ASL
	TAX
	LDA.l $702200,x
	LSR
	SEP.b #$30
	STA.w !REGISTER_Mode7MatrixParameterA
	XBA
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.b $00
	STA.w !REGISTER_Mode7MatrixParameterB
	REP.b #$20
	LDA.w !REGISTER_PPUMultiplicationProductMid
	ASL
	LDY.b $03
	BPL.b CODE_029294
	EOR.w #$FFFF
	INC
CODE_029294:
	STA.b $00
	LDX.b $12
CODE_029298:
	STZ.w $7E3E
	LDA.w $60AA
	BMI.b CODE_029306
	LDA.b $00
	CLC
	ADC.w #$0070
	CMP.w #$00E1
	BCS.b CODE_029306
	LDA.w $7182,x
	SEC
	SBC.w $6090
	SEC
	SBC.w #$0020
	CMP.w #$FFF6
	BCC.b CODE_029306
	ADC.w $6090
	STA.w $6090
	STZ.w $60AA
	TXA
	INC
	STA.w $7E3E
	INC.w $61B4
	LDA.b $00
	STA.w $7E46
	LDA.b $16,x
	STA.w $7E40
	LDA.w $70E2,x
	STA.w $7E42
	LDA.b $16,x
	ASL
	REP.b #$10
	TAX
	LDA.l DATA_00E9D4,x
	ASL
	ASL
	ASL
	SEP.b #$30
	STA.w !REGISTER_Mode7MatrixParameterA
	XBA
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.w $7E46
	STA.w !REGISTER_Mode7MatrixParameterB
	REP.b #$20
	LDA.w !REGISTER_PPUMultiplicationProductMid
	EOR.w #$FFFF
	INC
	STA.w $61BA
	LDX.b $12
CODE_029306:
	JSL.l CODE_03AF23
	LDA.b $16,x
	CLC
CODE_02930D:
	ADC.w #$FFFF
	AND.w #$00FF
	STA.b $16,x
CODE_029315:
	RTL

CODE_029316:
	LDA.b $16,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$00D4
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$0020
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7682,x
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w #$0030
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LDA.w #$0078
	SEC
	SBC.w $7680,x
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $0CC2
	BEQ.b CODE_02934E
	LDX.b #FXCODE_08C470>>16
	LDA.w #FXCODE_08C470
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	JMP.w CODE_02937E

CODE_02934E:
	INC.w $0CC2
	LDX.b #FXCODE_08C450>>16
	LDA.w #FXCODE_08C450
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	JSL.l CODE_00BE39	: db $E4,$51,$7E,$16,$35,$70,$A8,$00
	JSL.l CODE_00BE39	: db $40,$50,$7E,$72,$33,$70,$A4,$01
	LDA.w #$0004
	TSB.w $0968
	LDA.w #$005E
	TSB.w $094A
CODE_02937E:
	LDX.b $12
	RTS

;---------------------------------------------------------------------------

CODE_029381:
	RTL

;---------------------------------------------------------------------------

CODE_029382:
	RTL

;---------------------------------------------------------------------------

CODE_029383:
	JSL.l CODE_03D406
	LDA.w #$0020
	STA.w $7A36,x
	RTL

;---------------------------------------------------------------------------

CODE_02938E:
	LDA.w $7362,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.b $76,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.b $78,x
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	SEP.b #$10
	LDX.b #FXCODE_08D3F9>>16
	LDA.w #FXCODE_08D3F9
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	INC.b $76,x
	LDA.w $0030
	AND.w #$0003
	BNE.b CODE_0293CF
	LDA.b $78,x
	INC
	CMP.w #$0006
	BCC.b CODE_0293CD
	LDA.w #$0000
CODE_0293CD:
	STA.b $78,x
CODE_0293CF:
	LDY.b $18,x
	BEQ.b CODE_0293D6
	JMP.w CODE_029461

CODE_0293D6:
	JSL.l CODE_03AF23
	LDA.w $7C16,x
	CLC
	ADC.w #$0020
	CMP.w #$0041
	BCS.b CODE_0293F2
	LDA.w $7C18,x
	CLC
	ADC.w #$0038
	CMP.w #$0089
	BCC.b CODE_0293FC
CODE_0293F2:
	LDA.w $77C2,x
	AND.w #$00FF
	STA.w $7400,x
CODE_0293FB:
	RTL

CODE_0293FC:
	LDA.w $7C18,x
	CLC
	ADC.w #$0028
	CMP.w #$0046
	BCS.b CODE_0293FB
	LDA.w $77C2,x
	AND.w #$00FF
	CMP.w $7400,x
	BEQ.b CODE_0293FB
	LDA.w $0372
	AND.w #$0020
	BNE.b CODE_029434
	LDA.w $021A
	DEC
	BNE.b CODE_029434
	LDA.w $0372
	ORA.w #$0020
	STA.w $0372
	LDA.w #$0027
	STA.l $704070
	INC.w $0D0F
CODE_029434:
	INC.w $0B65
	INC.b $18,x
	LDA.w #$0001
	STA.w $61AE
	STA.w $61B0
	LDA.w #$0008
	STA.w $7A98,x
	LDA.w $0396
	CLC
	ADC.w #$0064
	STA.w $0396
	LDA.w #$00DC
	STA.w $0B7F
	RTL

;---------------------------------------------------------------------------

DATA_029459:
	dw $0013,$0021,$002F,$003D

CODE_029461:
	LDA.w $0D0F
	BNE.b CODE_02946E
	LDA.w $7A98,x
	BEQ.b CODE_02946F
	DEC.w $7A98,x
CODE_02946E:
	RTL

CODE_02946F:
	LDA.w $0396
	BNE.b CODE_02946E
	LDA.w $7A36,x
	CMP.w #$0020
	BNE.b CODE_029485
	PHA
	LDA.w #$0027
	JSL.l CODE_0085D2
	PLA
CODE_029485:
	CLC
	ADC.w #$0002
	CMP.w #$0060
	BCS.b CODE_02949D
	STA.w $7A36,x
	LSR
	LSR
	LSR
	LSR
	ASL
	TAY
	LDA.w DATA_029459-$04,y
	STA.b $78,x
	RTL

CODE_02949D:
	STZ.w $0B65
	STZ.w $61AE
	STZ.w $61B0
	JSL.l CODE_03D3EB
	JSL.l CODE_029507
	LDX.b $12
	JSL.l CODE_03A32E
CODE_0294B4:
	LDA.w #$01A2
CODE_0294B7:
	STA.b $0E
	LDY.b #$5C
CODE_0294BB:
	LDA.w $6F00,y
	CMP.w #$000E
	BCS.b CODE_0294CD
	CMP.w #$0008
	BNE.b CODE_0294FF
	LDA.w $6162
	BNE.b CODE_0294FF
CODE_0294CD:
	LDA.w $6FA2,y
	AND.w #$6000
	BEQ.b CODE_0294EC
	LDA.w $7360,y
	CMP.w #$00CD
	BEQ.b CODE_0294EC
	CMP.w #$00CE
	BEQ.b CODE_0294EC
	CMP.w #$0026
	BNE.b CODE_0294FF
	LDA.w $7D38,y
	BNE.b CODE_0294FF
CODE_0294EC:
	CPY.w $61B6
	BNE.b CODE_0294F4
	STZ.w $61B6
CODE_0294F4:
	LDA.w #$0006
	STA.w $6F00,y
	LDA.b $0E
	STA.w $0B91,y
CODE_0294FF:
	DEY
	DEY
	DEY
	DEY
	BPL.b CODE_0294BB
	RTL

;---------------------------------------------------------------------------

CODE_029506:
	RTL

;---------------------------------------------------------------------------

CODE_029507:
	INC.w $03AC
	REP.b #$10
	LDX.w #$020C
CODE_02950F:
	LDA.w $03B2,x
	STA.l $7E79A6,x
	DEX
	DEX
	BPL.b CODE_02950F
	SEP.b #$10
	LDA.w $7DF6
	STA.l $7E7BB0
	BEQ.b CODE_029534
	TAX
CODE_029526:
	LDY.w $7DF6,x
	LDA.w $7360,y
	STA.l $7E7BB0,x
	DEX
	DEX
	BNE.b CODE_029526
CODE_029534:
	LDX.b $12
	RTL

;---------------------------------------------------------------------------

DATA_029537:
	dw $0000,$A000,$0000,$0000,$0000,$0000,$0000,$A010
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$A020
	dw $A060,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $A050,$0000,$0000,$0000,$0000,$0000,$A040,$A030

;---------------------------------------------------------------------------

DATA_0295B7:
	dw $FFF0,$0010

CODE_0295BB:
	JSR.w CODE_0297F3
	LDA.w $0020
	STA.w $7A38,x
	LDA.w $0022
	STA.w $7900,x
	LDA.w $0024
	STA.w $7902,x
	JSR.w CODE_02984B
CODE_0295D3:
	JSL.l CODE_03AF23
	LDA.b $76,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.b $18,x
	BEQ.b CODE_029627
	LDY.b #$00
	LDA.b $76,x
	BPL.b CODE_0295E8
	LDY.b #$02
CODE_0295E8:
	CLC
	ADC.w DATA_0295B7,y
	STA.b $76,x
	BEQ.b CODE_0295F8
	EOR.w DATA_0295B7,y
	BPL.b CODE_0295F8
	JMP.w CODE_0297A3

CODE_0295F8:
	LDY.b #$00
	LDA.w $7A38,x
	JSR.w CODE_029818
	LDY.b #$02
	LDA.w $7900,x
	JSR.w CODE_029818
	LDY.b #$04
	LDA.w $7902,x
	JSR.w CODE_029818
	STZ.w $61BE
	JML.l CODE_03A31E

;---------------------------------------------------------------------------

DATA_029617:
	dw $0008,$0004,$0000,$0000,$0000,$0000

DATA_029623:
	dw $FFD0,$0030

CODE_029627:
	LDA.b $76,x
	BPL.b CODE_02969E
	LDA.w $60C2
	ASL
	TAY
	LDA.w $7182,x
	SEC
	SBC.w $6090
	CLC
	ADC.w DATA_029617,y
	BMI.b CODE_0296AF
	CMP.w #$0008
	BMI.b CODE_02964B
	LDA.w $7182,x
	STA.w $6090
	LDA.w #$0008
CODE_02964B:
	XBA
	LSR
	LSR
	LSR
	EOR.w #$FFFF
	STA.b $76,x
	LDA.w $60AA
	CLC
	ADC.w #$0030
	CMP.w #$0010
	BMI.b CODE_029663
	LDA.w #$0010
CODE_029663:
	STA.w $60AA
	LDA.w #$0002
	STA.w $61DC
	LDA.w $61F0
	CMP.w #$0002
	BCS.b CODE_029681
	LDA.w #$0006
	STA.w $61F0
	LDA.w #$009B
	JSL.l CODE_0085D2
CODE_029681:
	LDY.b #$00
	LDA.w $60B4
	BEQ.b CODE_02969B
	BPL.b CODE_02968C
	INY
	INY
CODE_02968C:
	CLC
	ADC.w DATA_029623,y
	STA.w $60B4
	EOR.w DATA_029623,y
	BMI.b CODE_02969B
	STZ.w $60B4
CODE_02969B:
	JMP.w CODE_029744

CODE_02969E:
	LDA.w $6090
	CLC
	ADC.w $6112
	CLC
	ADC.w #$0020
	SEC
	SBC.w $7182,x
	BPL.b CODE_0296B4
CODE_0296AF:
	INC.b $18,x
	JMP.w CODE_0297A3

CODE_0296B4:
	CMP.w #$000A
	BMI.b CODE_0296CA
	LDA.w $7182,x
	SEC
	SBC.w #$0016
	SEC
	SBC.w $6112
	STA.w $6090
	LDA.w #$000A
CODE_0296CA:
	STA.b $00
	LDA.w $60C0
	BEQ.b CODE_0296E8
	LDA.w $60AA
	BPL.b CODE_0296E8
	LDA.w #$0013
	JSL.l CODE_0085D2
	LDA.b $00
	ASL
	ASL
	ASL
	ASL
	ADC.w $60AA
	BRA.b CODE_029739

CODE_0296E8:
	INC.w $61B4
	LDY.b $00
	CPY.b #$02
	BCS.b CODE_0296FB
	INC.b $00
	INC.w $6090
	LDA.w #$0000
	BRA.b CODE_029739

CODE_0296FB:
	LDA.w #$0000
	CPY.b #$05
	BCC.b CODE_029705
	LDA.w #$0000
CODE_029705:
	STA.w $60FA
	LDA.w $60F8
	BNE.b CODE_029714
	LDA.w #$009B
	JSL.l CODE_0085D2
CODE_029714:
	LDA.w $60A8
	BPL.b CODE_02971D
	EOR.w #$FFFF
	INC
CODE_02971D:
	LSR
	EOR.w #$FFFF
	INC
	STA.b $02
	LDA.w #$0008
	SEC
	SBC.b $00
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.b $02
	CMP.w #$FF00
	BPL.b CODE_029739
	LDA.w #$FF00
CODE_029739:
	STA.w $60AA
	LDA.b $00
	XBA
	LSR
	LSR
	LSR
	STA.b $76,x
CODE_029744:
	LDA.w $70E2,x
	AND.w #$FFF0
	STA.b $00
	LDA.w $608C
	SEC
	SBC.w #$0008
	STA.w $70E2,x
	AND.w #$FFF0
	SEC
	SBC.b $00
	BEQ.b CODE_0297A3
	BMI.b CODE_029775
	LDA.w $7A38,x
	PHA
	LDA.w $7900,x
	STA.w $7A38,x
	LDA.w $7902,x
	STA.w $7900,x
	PLA
	LDY.b #$00
	BRA.b CODE_029788

CODE_029775:
	LDA.w $7902,x
	PHA
	LDA.w $7900,x
	STA.w $7902,x
	LDA.w $7A38,x
	STA.w $7900,x
	PLA
	LDY.b #$04
CODE_029788:
	PHY
	JSR.w CODE_029818
	JSR.w CODE_0297F3
	PLY
	BNE.b CODE_02979A
	LDA.w $0024
	STA.w $7902,x
	BRA.b CODE_0297A0

CODE_02979A:
	LDA.w $0020
	STA.w $7A38,x
CODE_0297A0:
	JSR.w CODE_02984B
CODE_0297A3:
	LDA.w #$0020
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0030
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $70E2,x
	AND.w #$000F
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDY.b $78,x
	CPY.b #$02
	BNE.b CODE_0297C5
	CMP.w #$000D
	BCS.b CODE_0297D0
	BRA.b CODE_0297CE

CODE_0297C5:
	CPY.b #$40
	BNE.b CODE_0297D0
	CMP.w #$0004
	BCC.b CODE_0297D0
CODE_0297CE:
	INC.b $18,x
CODE_0297D0:
	LDA.w DATA_029537,y
	LDY.b $77,x
	BPL.b CODE_0297DB
	CLC
	ADC.w #$0800
CODE_0297DB:
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDX.b #FXCODE_088CDB>>16
	LDA.w #FXCODE_088CDB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CFB
	LDX.b $12
	RTL

;---------------------------------------------------------------------------

CODE_0297F3:
	LDA.w #$0002
	STA.w $008F
	LDA.w $70E2,x
	STA.w $0091
	LDA.w $7182,x
	STA.w $0093
	LDA.w #$6200
	STA.w $0095
	JSL.l CODE_109295
	LDX.b $12
	RTS

;---------------------------------------------------------------------------

DATA_029812:
	dw $0000,$0010,$0020

CODE_029818:
	CMP.w #$6106
	BEQ.b CODE_02983C
	STA.w $0095
	LDA.w #$0001
	STA.w $008F
	LDA.w $6EBC
	CLC
	ADC.w DATA_029812,y
	STA.w $0091
	LDA.w $7182,x
	STA.w $0093
	JSL.l CODE_109295
	LDX.b $12
CODE_02983C:
	RTS

;---------------------------------------------------------------------------

DATA_02983D:
	dw $0001,$0003,$0002,$0001,$0003,$0002,$0000

CODE_02984B:
	LDA.w $7A38,x
	AND.w #$00FF
	ASL
	TAY
	LDA.w DATA_02983D,y
	ASL
	ASL
	STA.b $78,x
	LDA.w $7900,x
	AND.w #$00FF
	ASL
	TAY
	LDA.w DATA_02983D,y
	ORA.b $78,x
	ASL
	ASL
	STA.b $78,x
	LDA.w $7902,x
	AND.w #$00FF
	ASL
	TAY
	LDA.w DATA_02983D,y
	ORA.b $78,x
	ASL
	STA.b $78,x
	RTS

;---------------------------------------------------------------------------

DATA_02987C:
	dw $FF80,$0080

CODE_029880:
	LDA.w $60AE
	CMP.w #$0010
	BEQ.b CODE_02989E
CODE_029888:
	LDA.w #$0002
	STA.w $6F00,x
	LDA.w #$00FF
	STA.w $74A2,x
	RTL

CODE_029895:
	LDY.w $7400,x
	LDA.w DATA_02987C,y
	STA.w $7220,x
CODE_02989E:
	JSL.l CODE_03AE60
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$60F0
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0055
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDX.b #FXCODE_088619>>16
	LDA.w #FXCODE_088619
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	LDY.w $74A2,x
	BPL.b CODE_0298F3
	LDA.w #$0005
	STA.w $74A2,x
CODE_0298E8:
	LDA.w #$0030
	JSL.l CODE_0085D2
	JSL.l CODE_04849E
CODE_0298F3:
	RTL

;---------------------------------------------------------------------------

CODE_0298F4:
	LDA.b $18,x
	ASL
	TXY
	TAX
	JMP.w (DATA_0298FC,x)

DATA_0298FC:
	dw CODE_029900
	dw CODE_02999F

CODE_029900:
	TYX
	JSL.l CODE_03AA2E
	JSL.l CODE_03AF23
	LDA.w $7542,x
	BNE.b CODE_02991D
	LDA.w $60AE
	CMP.w #$0010
	BEQ.b CODE_02991D
	JSL.l CODE_0298E8
	JMP.w CODE_029888

CODE_02991D:
	JSL.l CODE_029BCA
	LDY.w $7D36,x
	BPL.b CODE_02998C
	LDA.w $7680,x
	CLC
	ADC.w #$0020
	CMP.w #$0120
	BCS.b CODE_02998C
	LDA.w $7682,x
	CLC
	ADC.w #$0020
	CMP.w #$0100
	BCS.b CODE_02998C
	LDA.w $60AE
	BEQ.b CODE_029951
	LDA.w #$0027
	JSL.l CODE_0085D2
	JSL.l CODE_03A31E
	JMP.w CODE_029A50

CODE_029951:
	LDA.w $61B2
	BPL.b CODE_02998C
	LDA.w $6150
	BEQ.b CODE_02996D
	LDA.w $6162
	BEQ.b CODE_02996D
	LDA.w $616A
	CMP.w #$0001
	BEQ.b CODE_02998C
	CMP.w #$0004
	BEQ.b CODE_02998C
CODE_02996D:
	INC.w $7978,x
	LDA.w #$00FF
	STA.w $74A2,x
	LDA.w $7040,x
	AND.w #$FFF3
	STA.w $7040,x
	LDA.w #$0020
	STA.w $7A96,x
	STA.w $61AE
	STA.w $61B0
	RTL

CODE_02998C:
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_02999A
	LDA.w #$FD00
	STA.w $7222,x
CODE_02999A:
	RTL

DATA_02999B:
	dw $0100,$FF00

CODE_02999F:
	TYX
	LDA.w $7A96,x
	BEQ.b CODE_0299C6
	DEC.w $7A96,x
	CMP.w #$0010
	BNE.b CODE_0299C5
	LDA.w #$0005
	JSL.l CODE_0085D2
	LDA.w $7CD6
	STA.b $00
	LDA.w $7CD8
	STA.b $02
	LDA.w #$01E7
	JSL.l CODE_03B577
CODE_0299C5:
	RTL

CODE_0299C6:
	LDA.w #$2000
	STA.w $61B2
	LDA.w #$FFFF
	STA.w $7E48
	JSL.l CODE_04F74A
	LDA.w #$0010
	STA.w $60AE
	LDA.w #$0010
	TSB.w $7E08
	LDA.w #$0116
	STA.w $60BE
	LDA.w #$0008
	STA.w $60C0
	LDA.w #$FC00
	STA.w $60AA
	LDA.w $60C4
	EOR.w #$0002
	STA.w $60C4
	STA.w $7400
	TAY
	LDA.w DATA_02999B,y
	STA.w $60B4
	STZ.w $60D2
	STZ.w $61DC
	REP.b #$10
	JSL.l CODE_04EF27
	SEP.b #$10
	JSL.l CODE_03A31E
	PHX
	LDA.w #$0029
	LDY.b #$00
	TYX
	STX.b $12
	JSL.l CODE_03A377
	LDA.w #$0010
	STA.w $6F00
	LDA.w $7182
	SEC
	SBC.w #$0008
	STA.w $7182
	JSL.l CODE_03BEB9
	PLX
	LDA.w #$B600
	STA.w $6114
	STZ.w $61AE
	STZ.w $61B0
	LDA.w #$0002
	STA.w $004D
	STZ.w $0205
CODE_029A50:
	LDA.w #$0200
	STA.w $7E04
	RTL

;---------------------------------------------------------------------------

CODE_029A57:
	RTL

;---------------------------------------------------------------------------

CODE_029A58:
	JSL.l CODE_03B69D
	LDA.w $7542,x
	BNE.b CODE_029A6E
	LDA.w #$003A
	JSL.l CODE_0085D2
	LDA.w #$0040
	STA.w $7542,x
CODE_029A6E:
	LDA.w $7182,x
	SEC
	SBC.w $6090
	CMP.w #$0010
	BMI.b CODE_029AC5
	LDA.w #$0025
	JSL.l CODE_03A364
	BCS.b CODE_029A9B
	LDA.w #$0025
	TXY
	JSL.l CODE_03A377
	LDA.w $6090
	CLC
	ADC.w #$0010
	STA.w $7182,x
	JSL.l CODE_03BEB9
	BRA.b CODE_029AC2

CODE_029A9B:
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $6090
	CLC
	ADC.w #$0010
	STA.w $7182,y
	PHX
	TYX
	STX.b $12
	JSL.l CODE_03BEB9
	PLX
	STX.b $12
	LDA.w $7DF6
	CMP.w #$000C
	BCC.b CODE_029AC6
	JSL.l CODE_03A31E
CODE_029AC2:
	STZ.w $0398
CODE_029AC5:
	RTL

CODE_029AC6:
	LDA.w $608C
	STA.w $70E2,x
	LDA.w $6090
	SEC
	SBC.w #$0020
	STA.w $7182,x
	LDA.w #$FD00
	STA.w $7222,x
	STZ.w $7542,x
	JML.l CODE_0280AC

;---------------------------------------------------------------------------

DATA_029AE3:
	dw $000F,$0003,$000F,$0405,$000F,$0A07,$010F,$0E0B
	dw $020F,$0203,$020F,$0605,$020F,$0C07,$040F,$0805
	dw $050F,$0E01,$060F,$0E06,$0B0F,$080A,$0C0F,$0E00
	dw $100F,$0009,$100F,$040B,$100F,$0A0D,$110F,$0E06
	dw $120F,$0209,$120F,$060B,$120F,$0C0D,$170F,$0802
	dw $190F,$0809,$1D0F,$0E05
	db $FF

CODE_029B3C:
	RTL

DATA_029B3D:
	dw $7FFF,$7FFF,$7FFF,$7FFF

CODE_029B45:
	LDA.b $18,x
	BNE.b CODE_029B85
	LDA.w $0039
	LSR
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #DATA_029AE3
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	STZ.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w $6092
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #DATA_029AE3>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w $7180,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDX.b #FXCODE_089183>>16
	LDA.w #FXCODE_089183
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_029B85:
	JSL.l CODE_03AF23
	LDA.w $0B59
	LSR
	BEQ.b CODE_029BC9
	LDA.w #DATA_029B3D
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDA.w #DATA_029B3D>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.b $76,x
	CLC
	ADC.w #$0008
	CMP.w #$0100
	BCC.b CODE_029BAD
	JSL.l CODE_03A31E
	LDA.w #$0100
CODE_029BAD:
	STA.b $76,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$00FC
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$0004
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08E167>>16
	LDA.w #FXCODE_08E167
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_029BC9:
	RTL

CODE_029BCA:
	LDA.w $7A96,x
	BEQ.b CODE_029BD0
	RTL

CODE_029BD0:
	LDA.w #$0005
	STA.w $7A96,x
	LDA.w #$0808
CODE_029BD9:
	PHA
	AND.w #$00FF
	STA.b $00
	JSL.l CODE_008408
	LDA.b $0F
	AND.w #$FF00
	ORA.b $00
	STA.w !REGISTER_Multiplicand
	PLA
	AND.w #$FF00
	STA.b $02
	LDA.b $11
	LSR
	LDA.w !REGISTER_ProductOrRemainderHi
	AND.w #$00FF
	BCC.b CODE_029C01
	EOR.w #$FFFF
CODE_029C01:
	ADC.w $70E2,x
	STA.b $00
	JSL.l CODE_008408
	LDA.b $10
	AND.w #$00FF
	ORA.b $02
	STA.w !REGISTER_Multiplicand
	NOP #2
	LDA.b $11
	LSR
	LDA.w !REGISTER_ProductOrRemainderHi
	AND.w #$00FF
	BCC.b CODE_029C24
	EOR.w #$FFFF
CODE_029C24:
	ADC.w $7182,x
	STA.b $02
	LDA.w #$01DD
	JSL.l CODE_008B21
	LDA.b $00
	STA.w $70A2,y
	LDA.b $02
	STA.w $7142,y
	LDA.w #$0004
	STA.w $7E4C,y
	LDA.w #$0006
	STA.w $7782,y
	RTL

;---------------------------------------------------------------------------

CODE_029C47:
	JSL.l CODE_03AE60
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0010
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$80C1
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDX.b #FXCODE_088293>>16
	LDA.w #FXCODE_088293
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	RTL

;---------------------------------------------------------------------------

CODE_029C87:
	JML.l CODE_03AA52

;---------------------------------------------------------------------------

CODE_029C8B:
	LDA.w $70E2,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7182,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_0ACD1E>>16
	LDA.w #FXCODE_0ACD1E
	JSL.l $7EDE91
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	BNE.b CODE_029CAE
	STZ.w $61C0
	JML.l CODE_03A31E

CODE_029CAE:
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w $70E2,x
	LDA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	INC
	STA.w $7182,x
	LDA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	STA.b $76,x
	LSR
	STA.w $7BB6,x
	LDA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	STA.b $78,x
	LSR
	INC
	STA.w $7BB8,x
	LDA.w #$0008
	STA.w $7B56,x
	STA.w $7B58,x
	LDA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	ASL
	ASL
	ASL
	XBA
	ORA.w $7040,x
	STA.w $7040,x
	LDA.w #$0070
	STA.w $7A96,x
	RTL

;---------------------------------------------------------------------------

CODE_029CEB:
	JSR.w CODE_029DF6
	LDA.b $18,x
	BNE.b CODE_029D54
	LDA.b $76,x
	SEC
	SBC.w #$0010
	LSR
	EOR.w #$FFFF
	SEC
	ADC.w $70E2,x
	CLC
	ADC.w $7A36,x
	STA.w $0091
	LDA.b $78,x
	SEC
	SBC.w #$0010
	LSR
	EOR.w #$FFFF
	SEC
	ADC.w $7182,x
	CLC
	ADC.w $7A38,x
	STA.w $0093
	LDA.w #$0001
	STA.w $008F
	LDA.w #$0000
	STA.w $0095
	JSL.l CODE_109295
	LDX.b $12
	LDA.w $7A36,x
	CLC
	ADC.w #$0010
	CMP.w $79D6,x
	BCC.b CODE_029D51
	LDA.w $7A38,x
	CLC
	ADC.w #$0010
	CMP.w $79D8,x
	BCC.b CODE_029D4B
	INC.b $18,x
	STZ.w $61C0
CODE_029D4B:
	STA.w $7A38,x
	LDA.w #$0000
CODE_029D51:
	STA.w $7A36,x
CODE_029D54:
	JSL.l CODE_03AF23
	LDA.b $18,x
	BEQ.b CODE_029DC6
	LDA.w $7E2A
	BEQ.b CODE_029D6D
	TXA
	LSR
	LSR
	TAY
	LDA.w $0C98,y
	AND.w #$00FF
	BNE.b CODE_029D9B
CODE_029D6D:
	LDA.b $76,x
	LSR
	ADC.w #$0018
	ADC.w $7680,x
	BMI.b CODE_029D97
	SEC
	SBC.b $76,x
	BCC.b CODE_029D9B
	CMP.w #$0120
	BCS.b CODE_029D97
	LDA.b $78,x
	LSR
	ADC.w #$0018
	ADC.w $7682,x
	BMI.b CODE_029D97
	SEC
	SBC.b $78,x
	BCC.b CODE_029D9B
	CMP.w #$0100
	BCC.b CODE_029D9B
CODE_029D97:
	JML.l CODE_03A31E

CODE_029D9B:
	LDA.w $7A96,x
	DEC
	CMP.w #$0050
	BCS.b CODE_029DC6
	CMP.w #$0040
	BNE.b CODE_029DAF
	LDA.w #$0004
	STA.w $7542,x
CODE_029DAF:
	LDA.b $14
	LSR
	BCC.b CODE_029DC6
	LDA.w $70E2,x
	EOR.w #$0001
	PHA
	SEC
	SBC.w $70E2,x
	STA.w $72C0,x
	PLA
	STA.w $70E2,x
CODE_029DC6:
	JML.l CODE_03D05D

;---------------------------------------------------------------------------

DATA_029DCA:
	dw $7900,$7901,$7902,$7909,$790A,$790B,$7903,$7904
	dw $7905,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $7906,$7907,$7908,$0000,$0000,$0000

CODE_029DF6:
	LDA.w $7362,x
	BMI.b CODE_029E34
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7680,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7682,x
	DEC
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.b $76,x
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.b $78,x
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w $7180,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	XBA
	ORA.w $7042,x
	XBA
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	STA.w $7902,x
	LDX.b #FXCODE_099126>>16
	LDA.w #FXCODE_099126
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_029E34:
	RTS

;---------------------------------------------------------------------------

DATA_029E35:
	dw $0000,$0000,$0000,$0008

DATA_029E3D:
	dw $FFD8,$FFF0,$FFC0,$FFF0

DATA_029E45:
	dw $0030,$0030,$0030,$0060

DATA_029E4D:
	dw $0060,$0030,$0090,$0030

CODE_029E55:
	LDA.w $7360,x
	SEC
	SBC.w #$0137
	ASL
	TAY
	LDA.w $70E2,x
	CLC
	ADC.w DATA_029E35,y
	STA.w $70E2,x
	LDA.w $7182,x
	CLC
	ADC.w DATA_029E3D,y
	STA.w $7182,x
	LDA.w DATA_029E45,y
	STA.b $76,x
	LSR
	STA.w $7BB6,x
	LDA.w DATA_029E4D,y
	STA.b $78,x
	LSR
	INC
	STA.w $7BB8,x
	LDA.w #$0008
	STA.w $7B56,x
	STA.w $7B58,x
	RTL

;---------------------------------------------------------------------------

CODE_029E8F:
	JSR.w CODE_029DF6
	LDA.b $18,x
	BEQ.b CODE_029E99
	JMP.w CODE_029F33

CODE_029E99:
	JSL.l CODE_03AF23
	LDA.w $7CD7,x
	AND.w #$000F
	STA.b $00
	LDA.b $78,x
	LSR
	STA.b $02
	LDA.w $7CD8,x
	SEC
	SBC.b $02
	CMP.w #$0800
	BCS.b CODE_029EC4
	AND.w #$0700
	LSR
	LSR
	LSR
	LSR
	ORA.b $00
	TAY
	LDA.w $6CA9,y
	BPL.b CODE_029EC8
CODE_029EC4:
	JML.l CODE_03A32E

CODE_029EC8:
	LDA.b $76,x
	LSR
	PHA
	EOR.w #$FFFF
	SEC
	ADC.w $7CD6,x
	CLC
	ADC.w #$0008
	STA.b $00
	LDA.b $02
	CLC
	ADC.w $7CD8,x
	STA.b $02
	PLA
	LSR
	LSR
	LSR
	STA.b $04
CODE_029EE7:
	LDA.b $00
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.b $02
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	AND.w #$0003
	BNE.b CODE_029F13
	LDA.b $00
	CLC
	ADC.w #$0010
	STA.b $00
	DEC.b $04
	BNE.b CODE_029EE7
	LDX.b $12
	JMP.w CODE_029FD0

CODE_029F13:
	LDA.w #$0048
	JSL.l CODE_0085D2
	LDX.b $12
	INC.b $18,x
	LDA.w $7182,x
	AND.w #$FFF8
	STA.w $7182,x
	STZ.w $7222,x
	LDA.w #$0020
	STA.w $61C6
	JMP.w CODE_029FD0

CODE_029F33:
	LDA.w $79D6,x
	LSR
	STA.w !REGISTER_Multiplicand
	LDA.w $7A38,x
	LSR
	LSR
	LSR
	LSR
	STA.w !REGISTER_Multiplier
	LDA.b $76,x
	LSR
	EOR.w #$FFFF
	SEC
	ADC.w $7CD6,x
	CLC
	ADC.w $7A36,x
	STA.w $0091
	LDA.b $78,x
	LSR
	EOR.w #$FFFF
	SEC
	ADC.w $7CD8,x
	CLC
	ADC.w $7A38,x
	STA.w $0093
	LDA.w #$0001
	STA.w $008F
	LDA.w $7A36,x
	LSR
	ADC.w !REGISTER_ProductOrRemainderLo
	CLC
	ADC.w $7362,x
	REP.b #$10
	TAY
	LDA.w $6004,y
	SEP.b #$10
	SEC
	SBC.w $7902,x
	BPL.b CODE_029F96
	AND.w #$7FFF
	CMP.w #$0020
	BCC.b CODE_029F90
	SBC.w #$0010
CODE_029F90:
	CLC
	ADC.w #$0014
	BRA.b CODE_029F9E

CODE_029F96:
	CMP.w #$0020
	BCC.b CODE_029F9E
	SBC.w #$0010
CODE_029F9E:
	TAY
	LDA.w DATA_029DCA,y
	STA.w $0095
	JSL.l CODE_109295
	LDX.b $12
	LDA.w $7A36,x
	CLC
	ADC.w #$0010
	CMP.w $79D6,x
	BCC.b CODE_029FCD
	LDA.w $7A38,x
	CLC
	ADC.w #$0010
	CMP.w $79D8,x
	BCC.b CODE_029FC7
	JML.l CODE_03A32E

CODE_029FC7:
	STA.w $7A38,x
	LDA.w #$0000
CODE_029FCD:
	STA.w $7A36,x
CODE_029FD0:
	JSL.l CODE_03D05D
	LDY.w $7D36,x
	DEY
	BMI.b CODE_029FE3
	BEQ.b CODE_029FE3
	TYX
	JSL.l CODE_039F91
	LDX.b $12
CODE_029FE3:
	RTL

;---------------------------------------------------------------------------

CODE_029FE4:
	LDA.w $7900,x
	ORA.w $7902,x
	BNE.b CODE_02A006
	JSL.l CODE_03D3F8
	BEQ.b CODE_029FF6
	JML.l CODE_03A32E

CODE_029FF6:
	JSL.l CODE_02A007
	LDA.w $70E2,x
	STA.w $7900,x
	LDA.w $7182,x
	STA.w $7902,x
CODE_02A006:
	RTL

CODE_02A007:
	LDA.w $70E2,x
	AND.w #$FFF0
	ORA.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7182,x
	AND.w #$FFF0
	ORA.w #$0008
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	AND.w #$F800
	CMP.w #$B800
	BNE.b CODE_02A049
	LDA.w #$0002
	STA.w $6F00,x
	LDA.w $6000
	STA.w $70E2,x
	LDA.w $6002
	STA.w $7182,x
	PLA
	PLY
CODE_02A049:
	RTL

;---------------------------------------------------------------------------

CODE_02A04A:
	LDA.w $7D38,x
	BEQ.b CODE_02A059
	LDA.b $18,x
	CMP.w #$0002
	BCC.b CODE_02A059
	STZ.w $7D38,x
CODE_02A059:
	JSL.l CODE_03B9DD
	LDA.b $78,x
	BEQ.b CODE_02A064
	JMP.w CODE_02A099

CODE_02A064:
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_02A070
	JSL.l CODE_03A58B
CODE_02A070:
	LDY.w $7D36,x
	BPL.b CODE_02A08C
	LDA.w $60AE
	BNE.b CODE_02A08C
	JSL.l CODE_03C640
	JSL.l CODE_03BEB9
	DEC.w $0057
	LDA.w #$001E
	JML.l CODE_0085D2

CODE_02A08C:
	LDA.w $7182,x
	CMP.w #$0800
	BMI.b CODE_02A098
	JML.l CODE_03A31E

CODE_02A098:
	RTL

CODE_02A099:
	JSL.l CODE_03BB1D
	RTL

;---------------------------------------------------------------------------

CODE_02A09E:
	JSL.l CODE_03AEBE
	JSL.l CODE_02A153
	LDA.w $70E2,x
	ORA.w #$0008
	STA.w $70E2,x
	LDA.w #$001C
	STA.w $7BB6,x
	LDA.w #$0039
	STA.w $7BB8,x
	RTL

;---------------------------------------------------------------------------

CODE_02A0BC:
	JSL.l CODE_03D3F8
	BEQ.b CODE_02A0D4
	LDA.w #$0001
	STA.w $7360,x
	LDA.w $7182,x
	CLC
	ADC.w #$0010
	STA.w $7182,x
	BRA.b CODE_02A0E7

CODE_02A0D4:
	JSL.l CODE_03D3F8
	BNE.b CODE_02A0DF
	INC.w $7A36,x
	BRA.b CODE_02A134

CODE_02A0DF:
	LDA.w #$0093
	STA.w $7360,x
	BRA.b CODE_02A134

CODE_02A0E7:
	LDA.w #$0003
	STA.b $18,x
	LDA.w $0118
	CMP.w #$000D
	BNE.b CODE_02A125
	LDA.w $608C
	CMP.w $70E2,x
	BNE.b CODE_02A125
	LDA.w $6090
	ADC.w #$000F
	CMP.w $7182,x
	BNE.b CODE_02A125
	LDA.w #$7005
	STA.w $7040,x
	LDA.w #$0002
	STA.b $18,x
	INC.w $7402,x
	LDA.w #$0020
	STA.b $76,x
	LDA.w #$0004
	STA.b $78,x
	LDA.w #$0040
	STA.w $7A96,x
CODE_02A125:
	LDA.w $7722,x
	BPL.b CODE_02A13E
	LDA.w $7182,x
	SEC
	SBC.w #$0010
	STA.w $7182,x
CODE_02A134:
	JSL.l CODE_03AE60
	JSL.l CODE_02A153
	BRA.b CODE_02A142

CODE_02A13E:
	JSL.l CODE_02A1FD
CODE_02A142:
	JSL.l CODE_02A007
	LDA.w #$000C
	STA.w $7BB6,x
	LDA.w #$0019
	STA.w $7BB8,x
	RTL

;---------------------------------------------------------------------------

CODE_02A153:
	LDA.w $7360,x
	CMP.w #$004E
	BEQ.b CODE_02A190
	CMP.w #$0131
	BEQ.b CODE_02A190
	CMP.w #$0093
	BEQ.b CODE_02A185
	CMP.w #$00CA
	BEQ.b CODE_02A1C2
	CMP.w #$0012
	BNE.b CODE_02A17A
	LDA.w #$60C0
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$0055
	BRA.b CODE_02A199

CODE_02A17A:
	LDA.w #$0021
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$0055
	BRA.b CODE_02A199

CODE_02A185:
	LDA.w #$00F1
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$0054
	BRA.b CODE_02A199

CODE_02A190:
	LDA.w #$6000
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$0055
CODE_02A199:
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDA.b $76,x
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w $6000
	LDA.l DATA_03A9EE,x
	STA.w $6002
	LDX.b #FXCODE_08D317>>16
	LDA.w #FXCODE_08D317
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	RTL

CODE_02A1C2:
	LDA.w #$60C0
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$0055
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDA.b $76,x
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w $6000
	LDA.l DATA_03A9EE,x
	STA.w $6002
	LDX.b #FXCODE_08D317>>16
	LDA.w #FXCODE_08D317
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b #FXCODE_09F897>>16
	LDA.w #FXCODE_09F897
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	RTL

;---------------------------------------------------------------------------

CODE_02A1FD:
	REP.b #$10
	LDY.w $7362,x
	LDA.w $7360,x
	CMP.w #$00CA
	BEQ.b CODE_02A247
CODE_02A20A:
	LDA.w $7722,x
	TAX
	LDA.w $6004,y
	AND.w #$FE00
	ORA.l DATA_03AA0E,x
	STA.w $6004,y
	LDA.w $600C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E,x
	STA.w $600C,y
	LDA.w $6014,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$04,x
	STA.w $6014,y
	LDA.w $601C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$04,x
	STA.w $601C,y
	SEP.b #$10
	LDX.b $12
	RTL

;---------------------------------------------------------------------------

CODE_02A247:
	LDA.w $7722,x
	TAX
	LDA.w $6004,y
	AND.w #$FE00
	ORA.l DATA_03AA0E,x
	STA.w $6004,y
	LDA.w $600C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$02,x
	STA.w $600C,y
	LDA.w $6014,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$04,x
	STA.w $6014,y
	LDA.w $601C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$06,x
	STA.w $601C,y
	LDA.w $6024,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$08,x
	STA.w $6024,y
	LDA.w $602C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$0A,x
	STA.w $602C,y
	LDA.w $6034,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$0C,x
	STA.w $6034,y
	LDA.w $603C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$0E,x
	STA.w $603C,y
	LDA.w $6044,y
	AND.w #$FE00
	ORA.l DATA_03AA0E,x
	STA.w $6044,y
	LDA.w $604C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$02,x
	STA.w $604C,y
	LDA.w $6054,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$04,x
	STA.w $6054,y
	LDA.w $605C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$06,x
	STA.w $605C,y
	LDA.w $6064,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$08,x
	STA.w $6064,y
	LDA.w $606C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$0A,x
	STA.w $606C,y
	LDA.w $6074,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$0C,x
	STA.w $6074,y
	LDA.w $607C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$0E,x
	STA.w $607C,y
	SEP.b #$10
CODE_02A31D:
	LDX.b $12
	RTL

;---------------------------------------------------------------------------

DATA_02A320:
	dw $0001,$FFFF,$0008,$FFF8

DATA_02A328:
	dw $0040,$0020,$0040,$0000

CODE_02A330:
	JSL.l CODE_02A1FD
	LDY.b $18,x
	BEQ.b CODE_02A33B
	JMP.w CODE_02A3F0

CODE_02A33B:
	JSL.l CODE_03AF23
	LDA.w $60C0
	BNE.b CODE_02A34C
	LDA.w $7182,x
	CMP.w $6090
	BEQ.b CODE_02A34D
CODE_02A34C:
	RTL

CODE_02A34D:
	LDA.w $7C16,x
	CLC
	ADC.w $7BB6,x
	CMP.w $7BB8,x
	BCS.b CODE_02A34C
	LDA.w $0038
	AND.w #$0008
	BEQ.b CODE_02A34C
	LDA.w $61B2
	BPL.b CODE_02A34C
	LDA.w $6150
	BNE.b CODE_02A34C
	LDA.w $7A36,x
	BEQ.b CODE_02A3A7
	LDY.w $7DF6
	BEQ.b CODE_02A34C
	LDA.w $7DF6,y
	TAY
	LDA.w $7360,y
	CMP.w #$0027
	BEQ.b CODE_02A388
	LDA.w #$0038
	JML.l CODE_0085D2

CODE_02A388:
	TYX
	JSL.l CODE_03BF87
	JSL.l CODE_03A31E
	LDA.w #$0064
	JSL.l CODE_0085D2
	LDX.b $12
	JSL.l CODE_03D3EB
	JSL.l CODE_02A4F4
	LDA.w #$0040
	BRA.b CODE_02A3AA

CODE_02A3A7:
	LDA.w #$0002
CODE_02A3AA:
	STA.w $7A96,x
	INC.b $18,x
	LDA.w $7360,x
	CMP.w #$00CA
	BEQ.b CODE_02A3BD
	LDA.w #$7005
	STA.w $7040,x
CODE_02A3BD:
	LDA.w #$000A
	STA.w $60AC
	STZ.w $0C8C
	STZ.w $6104
	INC.w $0C8E
	LDA.w $7360,x
	CMP.w #$004E
	BNE.b CODE_02A3D7
	DEC.w $6104
CODE_02A3D7:
	LDA.w #$0001
	STA.w $61AE
	STA.w $61B0
	STZ.w $60F8
	LDA.w #$0006
	STA.w $61D2
	LDA.w #$0008
	STA.w $6116
CODE_02A3EF:
	RTL

CODE_02A3F0:
	LDA.w $0D0F
	BNE.b CODE_02A3EF
	CPY.b #$03
	BEQ.b CODE_02A3EF
	LDA.w $7A96,x
	BEQ.b CODE_02A40F
	DEC.w $7A96,x
	BNE.b CODE_02A40E
	CPY.b #$02
	BEQ.b CODE_02A40E
	LDA.w #$0040
	JSL.l CODE_0085D2
CODE_02A40E:
	RTL

CODE_02A40F:
	JSL.l CODE_02A153
	LDY.b $78,x
	CPY.b #$02
	BCC.b CODE_02A43B
	LDA.b $18,x
	LSR
	BNE.b CODE_02A43B
	STZ.w $61AE
	LDA.w $7C16,x
	BEQ.b CODE_02A436
	ASL
	LDA.w #$FFFF
	BCS.b CODE_02A42F
	LDA.w #$0001
CODE_02A42F:
	CLC
	ADC.w $608C
	STA.w $608C
CODE_02A436:
	LDA.w $7402,x
	BEQ.b CODE_02A43E
CODE_02A43B:
	LDA.w #$0007
CODE_02A43E:
	PHY
	LDY.w $0C8C
	BEQ.b CODE_02A447
	EOR.w #$0007
CODE_02A447:
	STA.w $74A2,x
	PLY
	LDA.b $76,x
	CLC
	ADC.w DATA_02A320,y
	STA.b $76,x
	SEC
	SBC.w DATA_02A328,y
	EOR.w DATA_02A320,y
	BMI.b CODE_02A4B4
	TYA
	LSR
	LSR
	BCS.b CODE_02A47B
	LDA.b $76,x
	SEC
	SBC.w #$003F
	EOR.w #$FFFF
	SEC
	ADC.w #$0040
	STA.b $76,x
	LDA.w $7402,x
	EOR.w #$0001
	STA.w $7402,x
	BRA.b CODE_02A480

CODE_02A47B:
	LDA.w DATA_02A328,y
	STA.b $76,x
CODE_02A480:
	INY
	INY
	CPY.b #$08
	BCC.b CODE_02A4F0
	LDA.w #$0041
	JSL.l CODE_0085D2
	LDA.b $18,x
	LSR
	BNE.b CODE_02A4E7
	LDA.w $60AE
	BEQ.b CODE_02A4A2
	STZ.w $0C8E
	STZ.w $61B0
	STZ.w $0C8C
	BRA.b CODE_02A4E7

CODE_02A4A2:
	LDA.w $6104
	BEQ.b CODE_02A4B5
	STA.w $61AE
	INC.w $0C8C
	LDA.w #$0001
	STA.b $18,x
	STZ.b $78,x
CODE_02A4B4:
	RTL

CODE_02A4B5:
	LDA.w $608D
	AND.w #$000F
	ASL
	ASL
	STA.w $0000
	LDA.w $6090
	AND.w #$0F00
	LSR
	LSR
	ORA.w $0000
CODE_02A4CB:
	STA.w $038E
	LDA.w #$0022
	STA.w $0053
	LDA.w #$0001
	STA.w $038C
	LDA.w #$000B
	STA.w $0118
	JSL.l CODE_01B2B7
	LDX.b $12
	RTL

CODE_02A4E7:
	INC.b $18,x
	LDA.w #$2005
	STA.w $7040,x
	RTL

CODE_02A4F0:
	TYA
	STA.b $78,x
	RTL

;---------------------------------------------------------------------------

CODE_02A4F4:
	LDA.w #$01CD
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w #$000B
	STA.w $7E4C,y
	STA.w $7E4E,y
	LDA.w #$0004
	STA.w $7782,y
	RTL

;---------------------------------------------------------------------------

CODE_02A517:
	RTL

;---------------------------------------------------------------------------

CODE_02A518:
	JSL.l CODE_03AF23
	LDY.w $7D36,x
	BPL.b CODE_02A52B
	LDA.w $60AE
	BNE.b CODE_02A4B5
	LDA.w $61B2
	BMI.b CODE_02A4B5
CODE_02A52B:
	RTL

;---------------------------------------------------------------------------

CODE_02A52C:
	JSL.l CODE_03AEBE
	STZ.w $7400,x
	LDA.w #$4010
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0099
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDX.b #FXCODE_088619>>16
	LDA.w #FXCODE_088619
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w #$60E0
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0055
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	CLC
	ADC.w #$0010
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDX.b #FXCODE_088619>>16
	LDA.w #FXCODE_088619
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w #$3040
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	CLC
	ADC.w #$0010
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0099
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDX.b #FXCODE_088619>>16
	LDA.w #FXCODE_088619
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	LDA.w #$6000
	STA.w $7A38,x
	RTL

;---------------------------------------------------------------------------

DATA_02A5ED:
	dw $0001,$0002,$0004,$0008,$0010,$0020,$0040,$0080
	dw $0100,$0200

DATA_02A601:
	dw $0000,$0200,$0280,$02A0,$02A8,$02AA

DATA_02A60D:
	db $51,$52,$53,$54,$55,$56,$55,$54,$53,$52

CODE_02A617:
	LDA.w $0D0F
	BNE.b CODE_02A663
	LDA.w $0B57
	CMP.w #$0003
	BNE.b CODE_02A63F
	INC.w $0B57
	INC.w $0B57
	REP.b #$10
	LDA.w #$0020
	JSL.l CODE_00B753
	SEP.b #$10
	LDA.w #$D800
	STA.w $0CF9
	LDX.b $12
	BRA.b CODE_02A663

CODE_02A63F:
	LDY.b $79,x
	TYA
	EOR.w #$FFFF
	SEC
	ADC.w #$000A
	STA.w $0B91,x
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	CMP.w $7976,x
	BEQ.b CODE_02A65D
	STA.w $7976,x
	LDA.w #$0002
	STA.w $7AF8,x
CODE_02A65D:
	LDA.w $7AF8,x
	STA.w $0B93,x
CODE_02A663:
	LDA.w $0B91,x
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LDA.w $0B93,x
	STA.w $600C
	LDA.w $7362,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7680,x
	CLC
	ADC.w #$0018
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7682,x
	SEC
	SBC.w #$0040
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$3000
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $7902,x
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $03B8
	ASL
	TAY
	LDA.w DATA_02A601,y
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w $7722,x
	TAX
	LDA.l DATA_03AA0E,x
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDX.b #FXCODE_08E1BE>>16
	LDA.w #FXCODE_08E1BE
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $0D0F
	BEQ.b CODE_02A6BE
	JMP.w CODE_02A761

CODE_02A6BE:
	LDA.w $6002
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $6004
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	CLC
	ADC.w #$0020
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $600A
	BMI.b CODE_02A6FF
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0010
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDX.b #FXCODE_088293>>16
	LDA.w #FXCODE_088293
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	BRA.b CODE_02A71C

CODE_02A6FF:
	LDA.l DATA_03A9EE,x
	CLC
	ADC.w #$0010
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDX.b #FXCODE_088619>>16
	LDA.w #FXCODE_088619
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
CODE_02A71C:
	LDX.b $12
	LDA.w $6008
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	CLC
	ADC.w #$0010
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	CLC
	ADC.w #$0010
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $6006
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDX.b #FXCODE_088619>>16
	LDA.w #FXCODE_088619
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
CODE_02A761:
	JSL.l CODE_03AF23
	LDA.w $0B57
	BNE.b CODE_02A786
	LDA.w $7680,x
	CLC
	ADC.w #$0060
	CMP.w #$01C0
	BCS.b CODE_02A782
	LDA.w $7682,x
	CLC
	ADC.w #$0060
	CMP.w #$01D0
	BCC.b CODE_02A786
CODE_02A782:
	JML.l CODE_03A31E

CODE_02A786:
	LDA.b $18,x
	ASL
	TXY
	TAX
	JSR.w (DATA_02A8E0,x)
	LDY.w $7A39,x
	TYA
	STA.b $02
	LDA.b $78,x
	STA.b $00
	CLC
	ADC.b $02
	CMP.w #$0A00
	BCC.b CODE_02A7A3
	SBC.w #$0A00
CODE_02A7A3:
	STA.b $78,x
	ORA.w #$00FF
	SEC
	SBC.b $00
	AND.w #$FF00
	BEQ.b CODE_02A7BE
	LDA.w $0B57
	BEQ.b CODE_02A7BE
	LDY.b $79,x
	LDA.w DATA_02A60D,y
	JSL.l CODE_0085D2
CODE_02A7BE:
	LDY.w $7900,x
	BNE.b CODE_02A7C4
CODE_02A7C3:
	RTL

CODE_02A7C4:
	CPY.b #$0B
	BCS.b CODE_02A7C3
	LDA.w $7A38,x
	BEQ.b CODE_02A83F
	SEC
	SBC.w #$0046
	BCC.b CODE_02A7ED
	CMP.w #$0300
	BCS.b CODE_02A7F0
	LDY.w $021A
	CPY.b #$08
	BNE.b CODE_02A7F0
	REP.b #$10
	LDY.w $6000
	SEP.b #$10
	BEQ.b CODE_02A7ED
	LDA.w #$0300
	BRA.b CODE_02A7F0

CODE_02A7ED:
	LDA.w #$0000
CODE_02A7F0:
	STA.w $7A38,x
	CMP.w #$0000
	BNE.b CODE_02A7C3
	LDY.w $7A36,x
	LDA.w #$0040
	STA.w $7541,y
	LDA.w $79D5,y
	STA.w $721F,y
	LDA.w $79D7,y
	STA.w $7221,y
	LDA.w #$0060
	STA.w $7A98,x
	LDY.b #$2E
	LDA.w $6000
	BEQ.b CODE_02A838
	DEC.w $0385
	LDA.w #$0024
	STA.w $60AC
	LDA.w #$0002
	STA.w $617E
	LDA.w #$0030
	STA.w $6180
	LDA.w #$000F
	JSL.l CODE_03A34C
	LDY.b #$08
CODE_02A838:
	TYA
	JSL.l CODE_0085D2
	BRA.b CODE_02A7C3

CODE_02A83F:
	LDA.w $7A98,x
	BEQ.b CODE_02A845
	RTL

CODE_02A845:
	LDA.w $0385
	BMI.b CODE_02A853
	PHY
	LDA.w #$0009
	JSL.l CODE_0085D2
	PLY
CODE_02A853:
	LDA.w #$0004
	STA.w $7A98,x
	TYA
	CLC
	ADC.b $79,x
	AND.w #$00FF
	CMP.w #$000A
	BCC.b CODE_02A868
	SBC.w #$000A
CODE_02A868:
	ASL
	TAY
	LDA.w $7902,x
	ORA.w DATA_02A5ED,y
	STA.w $7902,x
	TYA
	ASL
	REP.b #$10
	TAY
	LDA.w $600E,y
	CLC
	ADC.w $6094
	STA.w $0000
	LDA.w $6010,y
	CLC
	ADC.w $609C
	STA.w $0002
	SEP.b #$10
	INC.w $7900,x
	LDY.w $7900,x
	CPY.b #$0B
	BCC.b CODE_02A8C0
	LDA.w $6000
	BEQ.b CODE_02A8BD
	LDA.w #$01CD
	JSL.l CODE_008B21
	LDA.w $0000
	STA.w $70A2,y
	LDA.w $0002
	STA.w $7142,y
	LDA.w #$000B
	STA.w $7E4C,y
	LDA.w #$0004
	STA.w $7782,y
	RTL

CODE_02A8BD:
	INC.w $0385
CODE_02A8C0:
	LDA.w #$01E4
	JSL.l CODE_008B21
	LDA.w $0000
	STA.w $70A2,y
	LDA.w $0002
	STA.w $7142,y
	LDA.w #$000C
	STA.w $73C2,y
	LDA.w #$0008
	STA.w $7782,y
	RTL

DATA_02A8E0:
	dw CODE_02A8E8
	dw CODE_02AA86
	dw CODE_02AB65
	dw CODE_02ABAA

CODE_02A8E8:
	TYX
	LDA.w $70E2,x
	SEC
	SBC.w #$0080
	CMP.w $0039
	BMI.b CODE_02A8F8
	LDA.w #$0EE0
CODE_02A8F8:
	CLC
	ADC.w #$0020
	STA.w $7E1A
	LDA.w $608C
	SEC
	SBC.w $70E2,x
	SEC
	SBC.w #$0018
	PHA
	EOR.b $76,x
	ASL
	PLA
	STA.b $76,x
	BCC.b CODE_02A915
	BPL.b CODE_02A916
CODE_02A915:
	RTS

CODE_02A916:
	LDA.w $61B2
	BPL.b CODE_02A915
	LDA.w $6090
	SEC
	SBC.w $7182,x
	CLC
	ADC.w #$0070
	CMP.w #$0050
	BCS.b CODE_02A915
	LDA.w #$0005
	STA.w $004D
	LDA.w #$003B
	JSL.l CODE_0085D2
	INC.w $7900,x
	INC.w $0118
	INC.w $0B57
	INC.b $18,x
	LDA.w #$0014
	STA.w $60AC
	LDA.w #$0006
	STA.w $60DE
	STZ.w $60EC
	STZ.w $60C4
	STZ.w $60EA
	STZ.w $60E0
	STZ.w $60D4
	STZ.w $60D8
	STZ.w $0C1C
	STZ.w $0C20
	LDA.w #$0001
	STA.w $0C1E
	LDA.w $0039
	STA.w $0C23
	LDA.w $70E2,x
	SEC
	SBC.w #$0010
	STA.w $7E1A
	JSL.l CODE_02A98E
CODE_02A981:
	RTS

CODE_02A982:
	LDA.w #$00F0
	STA.w $004D
	INC.w $0B59
	INC.w $0B7B
CODE_02A98E:
	JSL.l CODE_04F74D
	LDX.w $7DF6
CODE_02A995:
	DEX
	DEX
	BMI.b CODE_02A9AE
	STX.b $0E
	LDY.w $7DF8,x
	LDA.w $7360,y
	SEC
	SBC.w #$0022
	ASL
	TAX
	JSR.w (DATA_02A9B7,x)
	LDX.b $0E
	BRA.b CODE_02A995

CODE_02A9AE:
	LDX.b $12
	LDA.w #$FFFF
	JML.l CODE_0294B7

DATA_02A9B7:
	dw CODE_02A9CB
	dw CODE_02A981
	dw CODE_02A981
	dw CODE_02A981
	dw CODE_02AA36
	dw CODE_02AA20
	dw CODE_02AA2A
	dw CODE_02A981
	dw CODE_02AA36
	dw CODE_02AA36

CODE_02A9CB:
	TYX
	LDA.w $70E2,x
	STA.w $0000
	LDA.w $7182,x
	STA.w $0002
	LDA.w $7042,x
	STA.w $0004
	PHX
	JSL.l CODE_04F88E
	PLX
	LDA.w #$0006
CODE_02A9E7:
	PHA
	JSL.l CODE_03BF87
	LDA.w #$0115
	TXY
	JSL.l CODE_03A377
	PLA
	EOR.w $7042,x
	STA.w $7042,x
	LDA.w #$0030
	STA.w $7A96,x
	STA.w $7A98,x
	STA.w $7AF6,x
	STA.w $79D8,x
	LDA.w #$FE80
	STA.w $7222,x
	LDA.w #$0008
	STA.w $7542,x
	LDA.w $6FA2,x
	AND.w #$FFE0
	STA.w $6FA2,x
	RTS

CODE_02AA20:
	TYX
CODE_02AA21:
	JSL.l CODE_02A4F4
	LDA.w #$0000
	BRA.b CODE_02A9E7

CODE_02AA2A:
	TYX
	JSL.l CODE_03BF87
	LDA.w #$FB00
	STA.w $7222,x
	RTS

CODE_02AA36:
	TYX
	LDA.w $7182,x
	STA.b $00
	LDA.w #$0003
	STA.b $02
CODE_02AA41:
	LDA.w #$0115
	JSL.l CODE_03A364
	BCC.b CODE_02AA21
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.b $00
	SEC
	SBC.w #$0010
	STA.w $7182,y
	STA.b $00
	LDA.w #$0030
	STA.w $7A96,y
	STA.w $7A98,y
	STA.w $7AF6,y
	STA.w $79D8,y
	LDA.w #$FE80
	STA.w $7222,y
	LDA.w #$0008
	STA.w $7542,y
	LDA.w $6FA2,y
	AND.w #$FFE0
	STA.w $6FA2,y
	DEC.b $02
	BNE.b CODE_02AA41
	JMP.w CODE_02AA21

CODE_02AA86:
	TYX
	LDA.w $60DE
	BNE.b CODE_02AB09
	LDA.w #$0002
	STA.w $60AC
	STZ.w $617A
	STZ.w $617C
	INC.b $18,x
	LDA.w #$0054
	STA.w $7A96,x
	LDY.b #$04
	LDA.w #$008C
	JSL.l CODE_03A34E
	TYA
	INC
	STA.w $7A36,x
	LDA.w $608C
	STA.w $70E2,y
	LDA.w $6090
	CLC
	ADC.w #$0008
	STA.w $7182,y
	LDA.w #$0002
	STA.w $7400,y
	LDA.w $60A8
	STA.w $79D6,y
	LDA.w $60AA
	STA.w $79D8,y
	LDA.w $0383
	ASL
	TAX
	JSR.w CODE_02AC4F
	LDA.w $70E2,x
	CLC
	ADC.w #$0144
	STA.w $608C
	LDA.w $7182,x
	SEC
	SBC.w #$0010
	STA.w $6090
	STZ.w $60B4
	STZ.w $60C0
	STZ.w $6162
	STZ.w $6168
	LDX.w $021A
	LDA.l DATA_028000+$01,x
	AND.w #$00FF
	STA.w $0383
	LDX.b $12
	BRA.b CODE_02AB56

CODE_02AB09:
	CMP.w #$0002
	BNE.b CODE_02AB56
	LDA.w #$004A
	JSL.l CODE_0085D2
	LDA.w #$0010
	STA.w $6F00
	LDY.b #$00
	STY.w $7862
	LDA.w $61B2
	AND.w #$0FFF
	STA.w $61B2
	STZ.b $76
	LDA.w $6090
	SEC
	SBC.w $7182,x
	ASL
	ADC.w #$0200
	STA.w $7220
	LDA.w #$FD40
	STA.w $7222
	LDA.w #$0010
	STA.w $7542
	LDA.w #$0010
	STA.w $7AF8
	STZ.b $16
	STZ.w $7902
	LDA.w #$FFFF
	STA.w $7E48
CODE_02AB56:
	LDA.w $0C23
	CMP.w $7E1A
	BCS.b CODE_02AB64
	ADC.w #$0002
	STA.w $0C23
CODE_02AB64:
	RTS

CODE_02AB65:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02AB78
	INC.b $18,x
	LDA.w #$0180
	STA.w $7A96,x
	STZ.w $617A
	BRA.b CODE_02AB91

CODE_02AB78:
	CMP.w #$0050
	BNE.b CODE_02AB86
	LDA.w #$000E
	JSL.l CODE_03A34C
	BRA.b CODE_02AB91

CODE_02AB86:
	CMP.w #$0040
	BCS.b CODE_02AB91
	LDA.w #$0200
	STA.w $617A
CODE_02AB91:
	LDA.w $7AF6,x
	BNE.b CODE_02ABA7
	LDA.w #$0008
	STA.w $7AF6,x
	LDA.w #$0808
	LDX.b #$00
	JSL.l CODE_029BD9
	LDX.b $12
CODE_02ABA7:
	JMP.w CODE_02AB56

CODE_02ABAA:
	TYX
	LDA.w $61B2
	BMI.b CODE_02ABF8
	LDA.b $14
	AND.w #$0003
	BNE.b CODE_02ABEA
	LDA.w #$01DF
	JSL.l CODE_008B21
	LDA.w $608C
	CLC
	ADC.w #$0006
	STA.w $70A2,y
	LDA.w $6090
	CLC
	ADC.w #$0018
	STA.w $7142,y
	LDA.w #$0080
	STA.w $71E0,y
	LDA.w #$FFF0
	STA.w $71E2,y
	LDA.w #$0003
	STA.w $7E4C,y
	LDA.w #$0004
	STA.w $7782,y
CODE_02ABEA:
	LDA.w #$004C
	STA.w $60BE
	LDA.w #$0180
	STA.w $7A96,x
	BRA.b CODE_02AB91

CODE_02ABF8:
	LDA.w $7A96,x
	LSR
	BNE.b CODE_02AC4E
	BCC.b CODE_02AC07
	LDA.w #$0006
	STA.l $00004D
CODE_02AC07:
	STZ.w $60C4
	LDA.w #$0100
	STA.w $617A
	STZ.w $0C1E
	LDA.w #$0030
	STA.w $7E20
	LDA.w $70E2,x
	CLC
	ADC.w #$0060
	STA.w $7E1A
	LDA.w $60B4
	CMP.w #$0180
	BMI.b CODE_02AC31
	LDA.w #$0180
	STA.w $60B4
CODE_02AC31:
	LDA.w $60B0
	CMP.w #$00F0
	BMI.b CODE_02AC4E
	INC.w $0B57
	INC.w $0B57
	LDY.w $7A36,x
	DEY
	TYX
	JSL.l CODE_03A31E
	LDX.b $12
	JSL.l CODE_03A31E
CODE_02AC4E:
	RTS

CODE_02AC4F:
	REP.b #$10
	PHB
	PEA.w $702000>>8
	PLB
	PLB
	LDA.l DATA_04FB23,x
	TAX
	LDY.w #$001C
CODE_02AC5F:
	LDA.l DATA_5FA000,x
	STA.w $7021E2,y
	STA.w $702F4E,y
	DEX
	DEX
	DEY
	DEY
	BPL.b CODE_02AC5F
	PLB
	SEP.b #$10
	LDX.b $12
	RTS

;---------------------------------------------------------------------------

CODE_02AC75:
	JSL.l CODE_03AD74
	BCS.b CODE_02AC9D
CODE_02AC7B:
	LDA.w #$0002
	STA.w $6F00,x
	RTL

DATA_02AC82:
	dw $6080,$60A0

CODE_02AC86:
	LDA.w $0383
	ASL
	STA.w $6116
	JSL.l CODE_04FB41
	JSL.l CODE_03AA52
	JSL.l CODE_03AF23
	JSL.l CODE_03A590
CODE_02AC9D:
	LDY.b #$00
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_02ACBD
	STZ.w $7220,x
	LDY.b #$02
	LDA.w $7A96,x
	BNE.b CODE_02ACBD
	LDA.w #$FD80
	STA.w $7222,x
	LDA.w #$0018
	STA.w $7A96,x
CODE_02ACBD:
	TYA
	STA.b $18,x
	LDA.w DATA_02AC82,y
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0055
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0010
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDX.b #FXCODE_088293>>16
	LDA.w #FXCODE_088293
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	RTL

;---------------------------------------------------------------------------

CODE_02ACFC:
	LDA.w $7182,x
	STA.b $18,x
	LDA.w #$FD80
	STA.w $7222,x
	RTL

;---------------------------------------------------------------------------

DATA_02AD08:
	db $88,$00

CODE_02AD0A:
	JSL.l CODE_03AF23
	JSL.l CODE_03D127
	LDA.b $76,x
	BNE.b CODE_02AD57
	LDA.w $7222,x
	BMI.b CODE_02AD57
	INC.b $76,x
	LDA.w $03B6
	CMP.w #$012C
	BCS.b CODE_02AD48
	LDA.b $10
	AND.w #$0007
	BNE.b CODE_02AD48
	LDA.w #$01A2
	JSL.l CODE_03A34C
	BCC.b CODE_02AD8B
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
	LDA.w #$FD00
	STA.w $7222,y
	RTL

CODE_02AD48:
	LDA.w #$0004
	JSL.l CODE_03A4E9
	LDA.w #$0009
	JSL.l CODE_0085D2
	RTL

CODE_02AD57:
	LDA.w $7182,x
	SEC
	SBC.b $18,x
	BMI.b CODE_02AD8B
	INC.b $76,x
	LDA.w $70E2,x
	STA.w $0091
	LDA.b $18,x
	STA.w $0093
	STA.w $7182,x
	STZ.w $7222,x
	STZ.w $7542,x
	LDA.w #$0001
	STA.w $008F
	LDA.w #$8A00
	STA.w $0095
	JSL.l CODE_109295
	LDX.b $12
	JML.l CODE_03A31E

CODE_02AD8B:
	RTL

;---------------------------------------------------------------------------

DATA_02AD8C:
	dw $FFF7,$0008

CODE_02AD90:
	LDA.w #$0002
	JSR.w CODE_02AE77
	LDA.b $10
	AND.w #$0002
	TAY
	JSR.w CODE_02ADC1
	BCS.b CODE_02ADAB
	TYA
	EOR.w #$0002
	TAY
	JSR.w CODE_02ADC1
	BCC.b CODE_02ADBC
CODE_02ADAB:
	TYA
	STA.w $7400,x
	LDA.w $70E2,x
	CLC
	ADC.w DATA_02AD8C,y
	STA.w $70E2,x
	JSR.w CODE_02B348
CODE_02ADBC:
	RTL

;---------------------------------------------------------------------------

DATA_02ADBD:
	dw $FFFF,$0010

CODE_02ADC1:
	LDA.w $7182,x
CODE_02ADC4:
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w $70E2,x
	CLC
	ADC.w DATA_02ADBD,y
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	PHY
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	PLY
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	AND.w #$0002
	BNE.b CODE_02ADF5
	LDA.w !REGISTER_SuperFX_R6_MultiplierHi
	AND.w #$00FF
	SEC
	SBC.w #$0099
	LSR
	BEQ.b CODE_02ADF5
	CLC
	RTS

CODE_02ADF5:
	SEC
	RTS

;---------------------------------------------------------------------------

CODE_02ADF7:
	LDA.w #$0004
	JSR.w CODE_02AE77
CODE_02ADFD:
	JSR.w CODE_02AEA0
	BCS.b CODE_02AE06
	JML.l CODE_03A31E

CODE_02AE06:
	RTL

CODE_02AE07:
	LDA.w #$000A
	JSR.w CODE_02AE77
	LDA.w $6FA2,x
	AND.w #$FFE0
	STA.w $6FA2,x
	LDA.w $7042,x
	ORA.w #$0030
	STA.w $7042,x
	LDA.w $7400,x
	EOR.w #$0002
	JSL.l CODE_02AE3F
	BRA.b CODE_02ADFD

CODE_02AE2B:
	LDA.w #$0006
	JSR.w CODE_02AE77
	LDA.w $6FA2,x
	AND.w #$FFE0
	STA.w $6FA2,x
	LDA.b $10
	AND.w #$0002
CODE_02AE3F:
	TAY
	JSR.w CODE_02ADC1
	BCS.b CODE_02AE61
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$3D3B
	BEQ.b CODE_02AE61
	CMP.w #$3D3C
	BEQ.b CODE_02AE61
	CMP.w #$3D49
	BEQ.b CODE_02AE61
	CMP.w #$3D4A
	BEQ.b CODE_02AE61
	TYA
	EOR.w #$0002
	TAY
CODE_02AE61:
	TYA
	STA.w $7400,x
	LDA.w $70E2,x
	CLC
	ADC.w DATA_02AD8C,y
	STA.w $70E2,x
	RTL

;---------------------------------------------------------------------------

CODE_02AE70:
	LDA.w #$0008
	JSR.w CODE_02AE77
	RTL

CODE_02AE77:
	LDY.w $7900,x
	BEQ.b CODE_02AE9C
	PLA
CODE_02AE7D:
	LDA.w $7042,x
	ORA.w #$0008
	STA.w $7042,x
	SEP.b #$20
	LDA.b #$FF
	STA.w $74A0,x
	REP.b #$20
	LDA.w #$0010
	STA.w $7A38,x
	LDA.w #$000C
	JSR.w CODE_02B6B2
	RTL

CODE_02AE9C:
	STA.w $7900,x
	RTS

;---------------------------------------------------------------------------

CODE_02AEA0:
	LDA.w #$0007
	JSL.l CODE_03A364
CODE_02AEA7:
	BCC.b CODE_02AF10
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
	LDA.w $74A2,x
	AND.w #$0080
	ORA.w #$0005
	STA.w $74A2,y
	LDA.w $7040,y
	AND.w #$FFF3
	STA.w $7040,y
	LDA.w $7400,x
	STA.w $7400,y
	LDA.w $7042,x
	STA.w $7042,y
	TYA
	INC
	STA.b $78,x
	LDA.w $7040,x
	AND.w #$FFF3
	STA.w $7040,x
	LDA.w $7360,y
	CMP.w #$0007
	BEQ.b CODE_02AEFA
	TXA
	STA.w $7978,y
	LDA.w #$0400
	STA.w $75E2,y
	STA.w $7A38,y
	BRA.b CODE_02AF0F

CODE_02AEFA:
	TXA
	STA.w $7978,y
	LDA.w #$0001
	STA.w $7402,y
	TYX
	LDY.b #$64
	JSL.l CODE_03C878
	LDX.b $12
	REP.b #$20
CODE_02AF0F:
	SEC
CODE_02AF10:
	RTS

;---------------------------------------------------------------------------

CODE_02AF11:
	SEP.b #$20
	LDA.w $6FA2,x
	AND.b #$10
	STA.w $77C0,x
	REP.b #$20
	LDA.w $7D96,x
	BNE.b CODE_02AF3B
	LDA.w $6F00,x
	CMP.w #$0010
	BEQ.b CODE_02AF4A
	CMP.w #$000E
	BEQ.b CODE_02AF3B
	LDA.w $7042,x
	AND.w #$00CF
	ORA.w #$0020
	STA.w $7042,x
CODE_02AF3B:
	JSR.w CODE_02B657
	LDA.w $6FA2,x
	AND.w #$FFE0
	ORA.w #$0018
	STA.w $6FA2,x
CODE_02AF4A:
	LDA.w #$C200
	LDY.w $7D38,x
	BEQ.b CODE_02AF68
	LDY.w $7862,x
	DEY
	BMI.b CODE_02AF5F
	STZ.w $7D38,x
	JSL.l CODE_02AE7D
CODE_02AF5F:
	LDA.w #$0011
	STA.w $7402,x
	LDA.w #$C600
CODE_02AF68:
	LDY.w $7A98,x
	BEQ.b CODE_02AF70
	LDA.w #$C000
CODE_02AF70:
	STA.w $6FA0,x
	JSL.l CODE_03AF23
	INC.b $16,x
	JSR.w CODE_02B276
	LDY.b $76,x
	BEQ.b CODE_02AFC8
	LDA.w #$FFC0
	LDY.w $7862,x
	DEY
	BPL.b CODE_02AF94
	LDA.w $7860,x
	AND.w #$0001
	BNE.b CODE_02AFB4
	LDA.w #$0100
CODE_02AF94:
	STA.w $75E2,x
	LDA.w $7222,x
	CMP.w #$FFC0
	BCC.b CODE_02AFA5
	LDA.w #$0004
	STA.w $7542,x
CODE_02AFA5:
	LDA.w #$0000
	STA.w $7402,x
	TXY
	LDX.w $7900,y
	JSR.w (DATA_02B024-$02,x)
	BRA.b CODE_02AFEA

CODE_02AFB4:
	STZ.b $76,x
	STZ.w $75E0,x
	STZ.w $7540,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
CODE_02AFC8:
	TXY
	LDX.w $7900,y
	JSR.w (DATA_02B018-$02,x)
	LDY.w $7862,x
	DEY
	BMI.b CODE_02AFEA
	LDA.w $7860,x
	AND.w #$0001
	BNE.b CODE_02AFEA
	INC.b $76,x
	LDA.w #$0100
	CMP.w $7222,x
	BPL.b CODE_02AFEA
	STA.w $7222,x
CODE_02AFEA:
	JSR.w CODE_02B8C7
	LDY.w $77C0,x
	BEQ.b CODE_02B00B
	LDA.w $7860,x
	AND.w #$0001
	STA.w $7A36,x
	LDA.w $7222,x
	BMI.b CODE_02B017
	LDA.w $7042,x
	AND.w #$00CF
	ORA.w #$0020
	BRA.b CODE_02B014

CODE_02B00B:
	STZ.w $7A36,x
	LDA.w $7042,x
	ORA.w #$0030
CODE_02B014:
	STA.w $7042,x
CODE_02B017:
	RTL

DATA_02B018:
	dw CODE_02B16B
	dw CODE_02B476
	dw CODE_02B996
	dw CODE_02BA81
	dw CODE_02BC66
	dw CODE_02B05A

DATA_02B024:
	dw CODE_02BE02
	dw CODE_02BE80
	dw CODE_02BE87
	dw CODE_02BE89
	dw CODE_02BE87
	dw CODE_02BEC9

;---------------------------------------------------------------------------

DATA_02B030:
	db $02,$01,$02,$01,$00,$16,$15,$14,$15,$14,$13,$14,$13,$12,$11

DATA_02B03F:
	db $08,$08,$08,$08,$20,$06,$10,$04,$04,$40,$04,$04,$04,$04,$04
	db $FE,$FF,$FE,$FF,$FD,$FF,$03,$00,$02,$00,$02,$00

CODE_02B05A:
	TYX
	LDY.w $7A38,x
	BEQ.b CODE_02B098
	JSR.w CODE_02B2BF
	LDA.w $7AF8,x
	BNE.b CODE_02B082
	DEC.w $7A38,x
	BEQ.b CODE_02B082
	LDY.w $7A38,x
	LDA.w DATA_02B030-$01,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w DATA_02B03F-$01,y
	AND.w #$00FF
	STA.w $7AF8,x
CODE_02B082:
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_02B093
	LDA.w $7220,x
	BEQ.b CODE_02B097
	JSL.l CODE_03A590
CODE_02B093:
	JSL.l CODE_02AE7D
CODE_02B097:
	RTS

CODE_02B098:
	JSR.w CODE_02B6E4
	LDY.b $18,x
	BNE.b CODE_02B0D7
	JSR.w CODE_02B342
	LDA.w $7860,x
	AND.w #$0001
	BNE.b CODE_02B0AD
	JMP.w CODE_02B426

CODE_02B0AD:
	LDA.w $7C16,x
	CLC
	ADC.w #$0020
	CMP.w #$0041
	BCC.b CODE_02B0C8
	LDA.w $77C2,x
	EOR.w #$0002
	AND.w #$00FF
	STA.w $7400,x
	JMP.w CODE_02B3D9

CODE_02B0C8:
	LDA.w $77C2,x
	AND.w #$00FF
	STA.w $7400,x
	LDA.w #$FB00
	JMP.w CODE_02B423

CODE_02B0D7:
	DEY
	BNE.b CODE_02B10F
	JSR.w CODE_02B316
	BCC.b CODE_02B0E4
	INC.b $18,x
	STZ.b $16,x
	RTS

CODE_02B0E4:
	LDA.w $7AF8,x
	BNE.b CODE_02B10A
	LDA.w #$0004
	STA.w $7AF8,x
	LDA.w $7402,x
	INC
	CMP.w #$001A
	BCC.b CODE_02B0FB
	LDA.w #$0017
CODE_02B0FB:
	STA.w $7402,x
	ASL
	TAY
	LDA.w $7182,x
	CLC
	ADC.w $02B020,y
	STA.w $7182,x
CODE_02B10A:
	RTS

DATA_02B10B:
	dw $0008,$0004

CODE_02B10F:
	JSR.w CODE_02B259
	BCS.b CODE_02B156
	LDA.b $00
	CMP.w #$0020
	BCS.b CODE_02B156
	LDA.w #$0010
	STA.w $7A96,x
	LDY.w $7400,x
	LDA.w $7860,x
	AND.w DATA_02B10B,y
	BNE.b CODE_02B131
	LDA.b $10
	LSR
	BCC.b CODE_02B138
CODE_02B131:
	TYA
	EOR.w #$0002
	STA.w $7400,x
CODE_02B138:
	STZ.b $18,x
	STZ.w $7A38,x
CODE_02B13D:
	LDA.w $6FA2,x
	AND.w #$FFE0
	ORA.w #$0018
	STA.w $6FA2,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
	RTS

CODE_02B156:
	JSR.w CODE_02B316
	LDA.b $16,x
	AND.w #$0010
	BEQ.b CODE_02B163
	LDA.w #$0001
CODE_02B163:
	CLC
	ADC.w #$001A
	STA.w $7402,x
	RTS

;---------------------------------------------------------------------------

CODE_02B16B:
	TYX
	LDY.b $18,x
	BEQ.b CODE_02B173
	JMP.w CODE_02B213

CODE_02B173:
	JSR.w CODE_02B342
	LDA.w $7860,x
	AND.w #$0001
	BNE.b CODE_02B189
	LDA.w $7A38,x
	BNE.b CODE_02B186
	JMP.w CODE_02B426

CODE_02B186:
	JMP.w CODE_02B42F

CODE_02B189:
	LDY.w $7D36,x
	DEY
	BMI.b CODE_02B1DC
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_02B1DC
	LDA.w $7360,y
	CMP.w #$0007
	BNE.b CODE_02B1DC
	LDA.w $7978,y
	ORA.w $79D6,y
	BNE.b CODE_02B1DC
	TXA
	STA.w $7978,y
	LDA.w #$0000
	STA.w $7542,y
	LDA.w $6FA2,y
	AND.w #$FFE0
	STA.w $6FA2,y
	LDA.w $7040,y
	AND.w #$FFF3
	STA.w $7040,y
	TYA
	INC
	STA.b $78,x
	LDA.w $7040,x
	AND.w #$FFF3
	STA.w $7040,x
	LDA.w #$0004
	STA.w $7900,x
	STZ.w $7A38,x
	STZ.w $7AF8,x
CODE_02B1DC:
	JSR.w CODE_02B259
	BCS.b CODE_02B203
	JSR.w CODE_02B6E4
	LDA.b $00
	CMP.w #$0020
	BCS.b CODE_02B1F1
	STZ.w $7A38,x
	JMP.w CODE_02B0C8

CODE_02B1F1:
	LDA.w $77C2,x
	EOR.w #$0002
CODE_02B1F7:
	AND.w #$00FF
	STA.w $7400,x
	STZ.w $7A38,x
	JMP.w CODE_02B3D9

CODE_02B203:
	LDA.w $77C2,x
	JSR.w CODE_02B1F7
	STZ.w $7220,x
	LDA.w #$0001
	STA.w $7A38,x
	RTS

CODE_02B213:
	DEY
	BNE.b CODE_02B239
	JSR.w CODE_02B316
	LDA.w #$0003
	BCS.b CODE_02B22E
	LDA.w $60C0
	BEQ.b CODE_02B22B
	LDA.w $7C18,x
	CMP.w #$FFC0
	BPL.b CODE_02B233
CODE_02B22B:
	LDA.w #$0002
CODE_02B22E:
	STA.b $18,x
	STZ.b $16,x
	RTS

CODE_02B233:
	JSR.w CODE_02B6E4
	JMP.w CODE_02B0E4

CODE_02B239:
	DEY
	BNE.b CODE_02B256
	JSR.w CODE_02B259
	BCS.b CODE_02B253
	LDA.w $60C0
	BNE.b CODE_02B24E
	LDA.w $7C18,x
	CMP.w #$FFC0
	BMI.b CODE_02B253
CODE_02B24E:
	DEC.b $18,x
	JMP.w CODE_02B35F

CODE_02B253:
	JMP.w CODE_02B156

CODE_02B256:
	JMP.w CODE_02B10F

CODE_02B259:
	LDA.w $7C16,x
	BPL.b CODE_02B262
	EOR.w #$FFFF
	INC
CODE_02B262:
	STA.b $00
	LDA.w $7C18,x
	BPL.b CODE_02B26D
	EOR.w #$FFFF
	INC
CODE_02B26D:
	STA.b $02
	CLC
	ADC.b $00
	CMP.w #$0080
CODE_02B275:
	RTS

;---------------------------------------------------------------------------

CODE_02B276:
	LDY.w $7D36,x
	BPL.b CODE_02B275
	LDA.w $7A98,x
	BNE.b CODE_02B275
	JSL.l CODE_03D35D
	CPY.b #$06
	BNE.b CODE_02B275
	LDA.w $60AA
	BMI.b CODE_02B275
	LDA.w #$0020
	STA.w $7A98,x
	LDA.w #$FC00
	STA.w $60AA
	LDA.w #$8001
	STA.w $60D2
	STZ.w $7220,x
	LDA.w $7222,x
	BPL.b CODE_02B2AA
	STZ.w $7222,x
CODE_02B2AA:
	JSL.l CODE_03A0E5
CODE_02B2AE:
	JSR.w CODE_02B13D
	JSR.w CODE_02B657
	JSL.l CODE_02AE7D
	STZ.b $76,x
	RTS

CODE_02B2BB:
	JSR.w CODE_02B2AE
	RTL

;---------------------------------------------------------------------------

CODE_02B2BF:
	LDY.w $7D36,x
	BPL.b CODE_02B2D1
	LDA.w $7A98,x
	BNE.b CODE_02B2D1
	JSL.l CODE_03D35D
	CPY.b #$04
	BCC.b CODE_02B2D2
CODE_02B2D1:
	RTS

CODE_02B2D2:
	LDA.w #$FFF0
	CPY.b #$00
	BEQ.b CODE_02B2DC
	LDA.w #$0010
CODE_02B2DC:
	SEC
	SBC.w $7C16,x
	PHA
	CLC
	ADC.w $60A8
	STA.w $7220,x
	PLA
	BMI.b CODE_02B2EF
	EOR.w #$FFFF
	INC
CODE_02B2EF:
	CLC
	ADC.w #$FC00
	STA.w $7222,x
	LDA.w $60A8
	CMP.w #$8000
	ROR
	STA.w $60A8
	JSR.w CODE_02B2AA
	LDA.w #$000E
	STA.w $6F00,x
	LDA.w $7042,x
	ORA.w #$0030
	STA.w $7042,x
	PLA
	RTS

;---------------------------------------------------------------------------

CODE_02B314:
	TAX
	RTS

;---------------------------------------------------------------------------

CODE_02B316:
	JSR.w CODE_02B37F
	BCS.b CODE_02B325
	LDA.w #$FC00
	STA.w $7222,x
	PLA
	JMP.w CODE_02B138

CODE_02B325:
	LDA.w $7860,x
	AND.w #$0002
	BNE.b CODE_02B341
	LDA.w $7902,x
	REP.b #$10
	TAX
	LDA.l $70001F,x
	SEP.b #$10
	TAY
	LDX.b $12
	CPY.b #$9B
	BEQ.b CODE_02B341
	CLC
CODE_02B341:
	RTS

;---------------------------------------------------------------------------

CODE_02B342:
	JSR.w CODE_02B37A
	BCC.b CODE_02B36B
	PLA
CODE_02B348:
	INC.b $18,x
	LDA.w $6FA2,x
	AND.w #$FFE0
	ORA.w #$0006
	STA.w $6FA2,x
	STZ.w $7220,x
	STZ.w $7222,x
	STZ.w $7542,x
CODE_02B35F:
	LDA.w #$0019
	STA.w $7402,x
	LDA.w #$0006
	STA.w $7AF8,x
CODE_02B36B:
	RTS

;---------------------------------------------------------------------------

DATA_02B36C:
	dw $0008,$0004

DATA_02B370:
	dw $0007,$0008

DATA_02B374:
	dw $0001,$FFFF,$0001

CODE_02B37A:
	LDA.w $7A96,x
	BNE.b CODE_02B3BB
CODE_02B37F:
	LDY.w $7400,x
CODE_02B382:
	LDA.w $7860,x
	AND.w DATA_02B36C,y
	BNE.b CODE_02B3C7
	LDA.w $7902,x
	CPY.b #$00
	BEQ.b CODE_02B395
	CLC
	ADC.w #$0008
CODE_02B395:
	REP.b #$10
	TAX
	LDA.l $70000F,x
	AND.w #$00FF
	SEP.b #$10
	LDX.b $12
	SEC
	SBC.w #$0099
	LSR
	BNE.b CODE_02B3BB
	LDA.w $70E2,x
	AND.w #$000F
	SEC
	SBC.w DATA_02B370,y
	BEQ.b CODE_02B3C7
	EOR.w DATA_02B374,y
	BMI.b CODE_02B3BD
CODE_02B3BB:
	CLC
	RTS

CODE_02B3BD:
	LDA.w $70E2,x
	CLC
	ADC.w DATA_02B374,y
	STA.w $70E2,x
CODE_02B3C7:
	SEC
	RTS

;---------------------------------------------------------------------------

DATA_02B3C9:
	dw $FFE0,$0020

DATA_02B3CD:
	dw $FE00,$0200

CODE_02B3D1:
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_02B42F
CODE_02B3D9:
	LDA.w $7AF8,x
	BEQ.b CODE_02B3E8
CODE_02B3DE:
	STZ.w $7220,x
	LDA.w #$0003
CODE_02B3E3:
	STA.w $7402,x
	RTS

CODE_02B3E8:
	LDY.w $7400,x
	LDA.w $7CD6,x
	CLC
	ADC.w DATA_02B3C9,y
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7182,x
	SEC
	SBC.w #$0030
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	AND.w #$0002
	BNE.b CODE_02B420
	LDA.w #$FD00
	LDY.w !REGISTER_SuperFX_R6_MultiplierHi
	CPY.b #$99
	BCC.b CODE_02B423
	CPY.b #$9B
	BCS.b CODE_02B423
CODE_02B420:
	LDA.w #$FA00
CODE_02B423:
	STA.w $7222,x
CODE_02B426:
	LDY.w $7400,x
	LDA.w DATA_02B3CD,y
	STA.w $7220,x
CODE_02B42F:
	LDA.w #$0005
	STA.w $7AF8,x
	LDA.w #$0004
	STA.w $7402,x
	RTS

;---------------------------------------------------------------------------

DATA_02B43C:
	db $24,$23,$24,$23,$24,$23,$24,$23,$1E,$22,$1E,$22,$1E,$22,$1E,$22
	db $1E,$21,$20

DATA_02B44F:
	db $03,$03,$03,$03,$03,$03,$03,$03,$10,$04,$04,$04,$04,$04,$04,$04
	db $04,$08,$10

DATA_02B462:
	dw $FE80,$0180

DATA_02B466:
	dw $FFF8,$0008

DATA_02B46A:
	dw $FE00,$0200

DATA_02B46E:
	dw $0010,$0020,$0008,$0018

CODE_02B476:
	TYX
	JSR.w CODE_02B7D1
	LDY.b $18,x
	CPY.b #$03
	BCC.b CODE_02B483
	JMP.w CODE_02BB6B

CODE_02B483:
	JSR.w CODE_02B728
	LDY.b $18,x
	BEQ.b CODE_02B48D
	JMP.w CODE_02B55C

CODE_02B48D:
	LDY.w $7A38,x
	BNE.b CODE_02B495
	JMP.w CODE_02B52E

CODE_02B495:
	LDA.w $7AF8,x
	BNE.b CODE_02B4AD
	DEY
	TYA
	STA.w $7A38,x
	BNE.b CODE_02B4AE
	LDA.w #$0080
	STA.w $7AF8,x
	LDA.w #$001E
	STA.w $7402,x
CODE_02B4AD:
	RTS

CODE_02B4AE:
	LDA.w DATA_02B44F-$01,y
	AND.w #$00FF
	STA.w $7AF8,x
	LDA.w DATA_02B43C-$01,y
	AND.w #$00FF
	STA.w $7402,x
	CMP.w #$0022
	BNE.b CODE_02B4CE
	PHA
	LDA.w #$0014
	JSL.l CODE_0085D2
	PLA
CODE_02B4CE:
	CMP.w #$0023
	BNE.b CODE_02B52D
	LDA.w $77C2,x
	EOR.w #$0002
	AND.w #$00FF
	STA.w $7400,x
	LDA.w #$0107
	JSL.l CODE_03A364
	BCC.b CODE_02B52D
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,y
	TAX
	LDA.w $6EBC
	CLC
	ADC.w DATA_02B466,x
	STA.w $70E2,y
	LDA.w $6EBE
	SEC
	SBC.w #$0003
	STA.w $7182,y
	LDA.w DATA_02B46A,x
	STA.w $7220,y
	LDA.w #$0001
	STA.w $7D38,y
	STA.w $7A38,y
	LDA.w $6FA0,y
	AND.w #$F9FF
	STA.w $6FA0,y
	LDA.w #$FFFF
	STA.w $7862,y
	LDA.w #$0045
	JSL.l CODE_0085D2
	LDX.b $12
CODE_02B52D:
	RTS

CODE_02B52E:
	JSR.w CODE_02B259
	BCS.b CODE_02B53C
	INC.b $18,x
	LDA.w #$0020
	STA.w $7AF6,x
	RTS

CODE_02B53C:
	STZ.w $7220,x
	LDA.w $7AF8,x
	BNE.b CODE_02B559
	LDA.w $7680,x
	CMP.w #$00F0
	BCS.b CODE_02B559
	LDA.b $02
	CMP.w #$0020
	BCS.b CODE_02B559
	LDA.w #$0014
	STA.w $7A38,x
CODE_02B559:
	JMP.w CODE_02B62F

CODE_02B55C:
	DEY
	BNE.b CODE_02B5A9
	JSR.w CODE_02B259
	BCC.b CODE_02B569
	LDA.w $7AF6,x
	BEQ.b CODE_02B5B9
CODE_02B569:
	LDA.b $00
	CMP.w #$0020
	BCS.b CODE_02B573
	JMP.w CODE_02B60D

CODE_02B573:
	LDA.w $77C2,x
	EOR.w #$0002
	AND.w #$00FF
	STA.w $7400,x
	TAY
	LDA.w DATA_02B462,y
	STA.w $7220,x
	LDA.w $7860,x
	AND.w DATA_02B36C,y
	BEQ.b CODE_02B591
	STZ.w $7220,x
CODE_02B591:
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_02B5A6
	LDA.b $16,x
	AND.w #$0002
	LSR
	ADC.w #$001C
	STA.w $7402,x
	RTS

CODE_02B5A6:
	JMP.w CODE_02BB55

CODE_02B5A9:
	JSR.w CODE_02B259
	BCS.b CODE_02B5B9
	LDA.w $77C2,x
	AND.w #$00FF
	CMP.w $7400,x
	BEQ.b CODE_02B5CB
CODE_02B5B9:
	STZ.b $18,x
	STZ.w $7220,x
	LDA.w #$001E
	STA.w $7402,x
	LDA.w #$0020
	STA.w $7AF6,x
CODE_02B5CA:
	RTS

CODE_02B5CB:
	STZ.w $7220,x
	LDA.w $60A8
	BPL.b CODE_02B5D7
	EOR.w #$FFFF
	INC
CODE_02B5D7:
	LSR
	LSR
	LSR
	CLC
	ADC.w #$0018
	CMP.b $00
	BCS.b CODE_02B5E5
	JMP.w CODE_02B620

CODE_02B5E5:
	LDY.b $78,x
	BEQ.b CODE_02B5CA
	LDA.w $77C2,x
	EOR.w #$0002
	TAY
	JSR.w CODE_02B382
	BCC.b CODE_02B60D
	INC.b $18,x
CODE_02B5F7:
	LDA.w $6FA2,x
	AND.w #$FFE0
	ORA.w #$0006
	STA.w $6FA2,x
	STZ.w $7220,x
	STZ.w $7222,x
	STZ.w $7542,x
	RTS

CODE_02B60D:
	STZ.w $7978,x
	LDA.w #$FB00
	JSR.w CODE_02BB43
	LDY.w $7400,x
	LDA.w DATA_02B3CD,y
	STA.w $7220,x
	RTS

CODE_02B620:
	LDA.w #$0007
	LDY.b $00
	CPY.b #$40
	BCC.b CODE_02B62C
	LDA.w #$000F
CODE_02B62C:
	JSR.w CODE_02B6E7
CODE_02B62F:
	LDA.w $7AF8,x
	BNE.b CODE_02B656
	LDA.b $10
	AND.w #$0006
	TAY
	LDA.w DATA_02B46E,y
	LDY.b $00
	CPY.b #$40
	BCS.b CODE_02B644
	LSR
CODE_02B644:
	STA.w $7AF8,x
	LDA.w $7402,x
	INC
	CMP.w #$0020
	BCC.b CODE_02B653
	LDA.w #$001E
CODE_02B653:
	STA.w $7402,x
CODE_02B656:
	RTS

;---------------------------------------------------------------------------

CODE_02B657:
	LDY.b $78,x
	BEQ.b CODE_02B656
	DEY
	BNE.b CODE_02B679
	JSL.l CODE_06C0BB
	LDA.w $70E2,x
	STA.w $70E2
	LDA.w $7182,x
	STA.w $7182
	STZ.w $7220
	LDA.w #$FE80
	STA.w $7222
	BRA.b CODE_02B6AA

CODE_02B679:
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	CLC
	ADC.w #$000A
	STA.w $7182,y
	PHX
	TYX
	STZ.b $18,x
	JSL.l CODE_048066
	TXY
	PLX
	LDA.w $70E2,x
	CMP.w $70E2,y
	LDA.w #$0100
	BCC.b CODE_02B6A1
	LDA.w #$FF00
CODE_02B6A1:
	STA.w $7220,y
	LDA.w #$FC00
	STA.w $7222,y
CODE_02B6AA:
	STZ.b $78,x
CODE_02B6AC:
	STZ.w $7A38,x
	LDA.w #$0002
CODE_02B6B2:
	STA.w $7900,x
	STZ.b $18,x
	STZ.w $7AF8,x
	LDA.w $6FA2,x
	AND.w #$FFE0
	ORA.w #$0018
	STA.w $6FA2,x
	LDA.w $7040,x
	ORA.w #$0004
	STA.w $7040,x
	LDA.w #$0004
	STA.w $74A2,x
	LDA.w #$0040
	STA.w $7542,x
	RTS

;---------------------------------------------------------------------------

DATA_02B6DC:
	dw $0004,$FFFC

DATA_02B6E0:
	dw $0080,$FF80

CODE_02B6E4:
	LDA.w #$000F
CODE_02B6E7:
	AND.b $16,x
	BNE.b CODE_02B723
	LDY.w $7400,x
	LDA.w DATA_02B6E0,y
	PHA
	LDA.w DATA_02B6DC,y
	PHA
	LDA.w #$01D7
	JSL.l CODE_008B21
	PLA
	CLC
	ADC.w $70E2,x
	STA.w $70A2,y
	PLA
	CLC
	ADC.w $7220,x
	STA.w $71E0,y
	LDA.w $7182,x
	SEC
	SBC.w #$0009
	STA.w $7142,y
	LDA.w $7400,x
	STA.w $73C0,y
	LDA.w #$0010
	STA.w $7782,y
CODE_02B723:
	RTS

;---------------------------------------------------------------------------

DATA_02B724:
	dw $0008,$0004

CODE_02B728:
	JSR.w CODE_02B37A
	BCC.b CODE_02B74F
	LDA.w #$0003
	STA.b $18,x
	LDA.w #$0020
	STA.w $7AF6,x
	LDA.w #$0018
	STA.w $7402,x
	LDY.w $7400,x
	LDA.w $70E2,x
	CLC
	ADC.w DATA_02B374+$02,y
	STA.w $70E2,x
	PLA
	JMP.w CODE_02B5F7

CODE_02B74F:
	LDA.w $7860,x
	BIT.w #$0001
	BEQ.b CODE_02B760
	LDY.w $7400,x
	AND.w DATA_02B724,y
	BNE.b CODE_02B77B
	RTS

CODE_02B760:
	LDA.w $7A36,x
	BNE.b CODE_02B767
	PLA
	RTS

CODE_02B767:
	LDA.l $70276E,x
	STA.w $70E2,x
	LDA.l $702770,x
	STA.w $7182,x
	STZ.w $7AF6,x
	STZ.w $7220,x
CODE_02B77B:
	JSR.w CODE_02B259
	BCS.b CODE_02B79D
	LDA.w $77C2,x
	AND.w #$00FF
	CMP.w $7400,x
	BEQ.b CODE_02B79D
	STA.w $7400,x
	LDA.w #$0002
	STA.b $18,x
	LDA.w #$001E
	STA.w $7402,x
	STZ.w $7AF8,x
	RTS

CODE_02B79D:
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
	RTS

;---------------------------------------------------------------------------

CODE_02B7A7:
	LDY.b #$08
	LDA.w $70E2,x
	SEC
	SBC.w #$0010
	BMI.b CODE_02B7BA
	SEC
	SBC.w #$0FD0
	BMI.b CODE_02B7C4
	LDY.b #$04
CODE_02B7BA:
	EOR.w #$FFFF
	SEC
	ADC.w $70E2,x
	STA.w $70E2,x
CODE_02B7C4:
	LDA.w $7680,x
	CLC
	ADC.w #$0020
	CMP.w #$0130
	BCS.b CODE_02B821
	RTS

;---------------------------------------------------------------------------

CODE_02B7D1:
	LDY.b $78,x
	BNE.b CODE_02B7D8
	JMP.w CODE_02B867

CODE_02B7D8:
	LDA.w $6EFF,y
	CMP.w #$0010
	BNE.b CODE_02B85C
	DEY
	BNE.b CODE_02B83B
	LDA.w $7680,x
	CLC
	ADC.w #$0040
	CMP.w #$0170
	BCS.b CODE_02B821
	LDA.w $7682,x
	CLC
	ADC.w #$0040
	CMP.w #$0120
	BCC.b CODE_02B83B
	LDA.w $70E3,x
	AND.w #$000F
	STA.b $00
	LDA.w $7182,x
	CLC
	ADC.w #$0030
	CMP.w #$0800
	BCS.b CODE_02B81E
	AND.w #$0700
	LSR
	LSR
	LSR
	LSR
	ORA.b $00
	TAY
	LDA.w $6CA9,y
	BPL.b CODE_02B821
CODE_02B81E:
	JMP.w CODE_02B657

CODE_02B821:
	LDA.w $70E2,x
	SEC
	SBC.w $72C0,x
	STA.w $70E2,x
	LDA.w $7182,x
	SEC
	SBC.w $72C2,x
	STA.w $7182,x
	JSR.w CODE_02B8C7
	PLA
	PLA
	RTL

CODE_02B83B:
	PHY
	JSL.l CODE_03A2F8
	PLY
	BCS.b CODE_02B852
	LDA.w $7542,y
	CMP.w #$0040
	BPL.b CODE_02B85C
	LDA.w $7400,x
	STA.w $7400,y
	RTS

CODE_02B852:
	TYX
	JSL.l CODE_03A31E
	LDX.b $12
	PLA
	PLA
	RTL

CODE_02B85C:
	STZ.b $78,x
	LDA.w $7040,x
	ORA.w #$0004
	STA.w $7040,x
CODE_02B867:
	PLA
	JMP.w CODE_02B6AC

;---------------------------------------------------------------------------

DATA_02B86B:
	dw $0000,$0000,$0000,$0000,$0000,$FFF6,$FFF6,$FFF4
	dw $FFF4,$FFF4,$FFF3,$FFF4,$FFF8,$FFF8,$0000,$0000
	dw $FFF6,$FFF5,$FFF6,$FFFA,$FFFA,$FFF6,$FFF6

DATA_02B899:
	dw $FFEE,$FFEF,$FFF0,$FFF0,$FFF0,$FFFB,$FFFA,$FFFC
	dw $FFFC,$FFFC,$FFFD,$FFFC,$0000,$0000,$FFF0,$FFE5
	dw $FFFC,$FFFD,$FFFC,$0000,$0000,$FFFC,$FFFC

CODE_02B8C7:
	LDY.b $78,x
	BEQ.b CODE_02B90F
	LDA.w $7900,x
	CMP.w #$0006
	BEQ.b CODE_02B90F
	LDA.w $7402,x
	CMP.w #$0017
	BCS.b CODE_02B8E1
	LDA.w #$001E
	STA.w $7402,x
CODE_02B8E1:
	ASL
	TAY
	LDA.w $7400,x
	LSR
	LSR
	LDA.w DATA_02B86B-$2E,y				; Todo: I'm not sure where these tables are supposed to point to.
	BCC.b CODE_02B8F1
	EOR.w #$FFFF
	INC
CODE_02B8F1:
	PHA
	LDA.w DATA_02B899-$2E,y
	LDY.b $78,x
	CLC
	ADC.w $7182,x
	STA.w $7181,y
	PLA
	CLC
	ADC.w $70E2,x
	STA.w $70E1,y
	SEP.b #$20
	LDA.b #$FF
	STA.w $7861,y
	REP.b #$20
CODE_02B90F:
	RTS

;---------------------------------------------------------------------------

DATA_02B910:
	db $05,$06,$05,$06,$05,$06,$05,$06,$05,$06,$06,$07,$07,$08,$09,$0A
	db $09,$08,$09,$0B,$0A,$0B,$0C,$0D,$0E,$0F,$10,$1A,$1B,$1A,$1B,$1A
	db $1B,$1A,$1B

DATA_02B933:
	db $08,$08,$08,$08,$08,$08,$08,$08,$10,$02,$02,$02,$02,$02,$02

DATA_02B942:
	dw $0204,$2004,$0820,$0101,$0101,$2004,$1010,$1010
	dw $1010,$1010,$0000,$0000,$0000,$0000,$0000,$0000

DATA_02B962:
	dw $0000,$0000,$0000,$0000,$0005,$0000,$0005,$000C
	dw $000F,$000F,$FFFB,$FFF5,$FFF0,$FFEC,$FFE9,$FFE7
	dw $FFE6,$FFE7,$FFE9,$FFE7,$FFEA,$FFE6,$FFEA,$FFEF
	dw $FFFF,$000B

CODE_02B996:
	TYX
	LDY.w $7A38,x
	CPY.b #$0A
	BCC.b CODE_02B9A5
	CPY.b #$1A
	BCS.b CODE_02B9A5
	JSR.w CODE_02B7D1
CODE_02B9A5:
	LDA.w $7AF8,x
	BEQ.b CODE_02B9AD
	JMP.w CODE_02BA4B

CODE_02B9AD:
	LDY.w $7A38,x
	INY
	CPY.b #$0A
	BCS.b CODE_02B9B8
	JMP.w CODE_02BA21

CODE_02B9B8:
	BNE.b CODE_02B9D8
	PHY
	LDA.w $7182,x
	AND.w #$0010
	BNE.b CODE_02B9C8
	LDA.w #$0060
	BRA.b CODE_02B9CB

CODE_02B9C8:
	LDA.w #$00F9
CODE_02B9CB:
	JSL.l CODE_03A34C
	JSR.w CODE_02AEA7
	PLY
	BCS.b CODE_02B9D8
	JMP.w CODE_02BA4B

CODE_02B9D8:
	CPY.b #$15
	BCC.b CODE_02BA21
	BNE.b CODE_02B9F4
	LDA.w $7680,x
	CMP.w #$00F0
	BCS.b CODE_02B9F2
	LDA.w $7682,x
	SEC
	SBC.w #$0008
	CMP.w #$00B0
	BCC.b CODE_02B9F4
CODE_02B9F2:
	LDY.b #$12
CODE_02B9F4:
	CPY.b #$1A
	BNE.b CODE_02BA21
	PHY
	LDA.w #$0075
	JSL.l CODE_0085D2
	LDY.b $78,x
	DEY
	TYX
	STZ.b $18,x
	LDA.w $7182,x
	CLC
	ADC.w #$0002
	STA.w $7182,x
	LDA.w #$0400
	STA.w $7222,x
	STA.b $76,x
	JSL.l CODE_048072
	LDX.b $12
	STZ.b $78,x
	PLY
CODE_02BA21:
	CPY.b #$0D
	BNE.b CODE_02BA2F
	PHY
	LDY.b $78,x
	LDA.w #$0002
	STA.w $74A1,y
	PLY
CODE_02BA2F:
	LDA.w DATA_02B910-$01,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w DATA_02B933-$01,y
	AND.w #$00FF
	STA.w $7AF8,x
	CPY.b #$24
	BCC.b CODE_02BA47
	LDY.b #$00
CODE_02BA47:
	TYA
	STA.w $7A38,x
CODE_02BA4B:
	LDY.w $7A38,x
	CPY.b #$0A
	BCC.b CODE_02BA7C
	CPY.b #$1A
	BCS.b CODE_02BA7C
	TYA
	ASL
	TAY
	LDA.w $7400,x
	LSR
	LSR
	LDA.w DATA_02B942,y
	BCC.b CODE_02BA67
	EOR.w #$FFFF
	INC
CODE_02BA67:
	PHA
	LDA.w DATA_02B962,y
	LDY.b $78,x
	CLC
	ADC.w $7182,x
	STA.w $7181,y
	PLA
	CLC
	ADC.w $70E2,x
	STA.w $70E1,y
CODE_02BA7C:
	RTS

;---------------------------------------------------------------------------

DATA_02BA7D:
	dw $FE80,$0180

CODE_02BA81:
	TYX
	LDY.b $78,x
	BEQ.b CODE_02BA89
	JMP.w CODE_02BAE9

CODE_02BA89:
	LDA.w #$0004
	STA.w $74A2,x
	JSR.w CODE_02BBCE
	LDA.w $7860,x
	ORA.w $7A36,x
	AND.w #$0001
	BEQ.b CODE_02BAD0
	LDA.w $7AF8,x
	BEQ.b CODE_02BAA5
	JMP.w CODE_02B3DE

CODE_02BAA5:
	LDA.w $7970
	AND.w #$0001
	BEQ.b CODE_02BAB1
	TYA
	STA.w $7400,x
CODE_02BAB1:
	LDA.w #$FD00
	STA.w $7222,x
	LDA.b $10
	AND.w #$0008
	BNE.b CODE_02BAD0
	LDA.w $7C16,x
	CLC
	ADC.w #$0060
	CMP.w #$00C1
	BCS.b CODE_02BAD0
	LDA.w #$FC00
	STA.w $7222,x
CODE_02BAD0:
	JSR.w CODE_02B42F
	LDY.w $7400,x
	LDA.w $7860,x
	AND.w DATA_02B36C,y
	BEQ.b CODE_02BAE2
	STZ.w $7220,x
	RTS

CODE_02BAE2:
	LDA.w DATA_02BA7D,y
	STA.w $7220,x
	RTS

CODE_02BAE9:
	LDA.w #$0003
	STA.w $74A2,x
	JSR.w CODE_02B7D1
	JSR.w CODE_02B7A7
	LDY.b $18,x
	CPY.b #$03
	BCC.b CODE_02BAFE
	JMP.w CODE_02BB65

CODE_02BAFE:
	JSR.w CODE_02B728
	LDY.b $18,x
	BNE.b CODE_02BB18
	JSR.w CODE_02B259
	BCC.b CODE_02BB15
	LDA.w $7AF6,x
	BNE.b CODE_02BB15
	INC.b $18,x
	STZ.w $7AF8,x
	RTS

CODE_02BB15:
	JMP.w CODE_02B573

CODE_02BB18:
	DEY
	BNE.b CODE_02BB62
	STZ.w $7220,x
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_02BB55
	JSR.w CODE_02B259
	BCS.b CODE_02BB34
	DEC.b $18,x
	LDA.w #$0020
	STA.w $7AF6,x
	RTS

CODE_02BB34:
	LDA.w $7AF8,x
	BEQ.b CODE_02BB40
	LDA.w #$0025
	STA.w $7402,x
	RTS

CODE_02BB40:
	LDA.w #$FC00
CODE_02BB43:
	STA.w $7222,x
	LDA.w $77C2,x
	AND.w #$00FF
	STA.w $7400,x
	STZ.w $7860,x
	STZ.w $7A36,x
CODE_02BB55:
	LDA.w #$0010
	STA.w $7AF8,x
	LDA.w #$0026
	STA.w $7402,x
	RTS

CODE_02BB62:
	JMP.w CODE_02B5A9

;---------------------------------------------------------------------------

CODE_02BB65:
	LDA.w #$0004
	STA.w $74A2,x
CODE_02BB6B:
	CPY.b #$03
	BNE.b CODE_02BBAE
	JSR.w CODE_02B37F
	BCS.b CODE_02BB8F
	JSR.w CODE_02B13D
CODE_02BB77:
	LDA.w #$0002
	STA.b $18,x
	LDA.w #$FC00
	JSR.w CODE_02BB43
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
	TAY
	JMP.w CODE_02BAE2

CODE_02BB8F:
	JSR.w CODE_02B325
	BCS.b CODE_02BBA6
	LDA.w $7AF6,x
	BNE.b CODE_02BBAB
	LDA.w $60C0
	BNE.b CODE_02BBA6
	LDA.w $7C18,x
	CMP.w #$FFC0
	BPL.b CODE_02BBAB
CODE_02BBA6:
	INC.b $18,x
	STZ.b $16,x
	RTS

CODE_02BBAB:
	JMP.w CODE_02B0E4

CODE_02BBAE:
	LDA.w $60C0
	BNE.b CODE_02BBBD
	LDA.w $7C18,x
	CMP.w #$FFC0
	BMI.b CODE_02BBBD
	DEC.b $18,x
CODE_02BBBD:
	JSR.w CODE_02B10F
	LDA.b $18,x
	BNE.b CODE_02BBCD
	JSR.w CODE_02BB55
	LDY.w $7400,x
	JMP.w CODE_02BAE2

CODE_02BBCD:
	RTS

;---------------------------------------------------------------------------

CODE_02BBCE:
	LDA.w $61CC
	BNE.b CODE_02BBDB
	LDA.w $61B2
	AND.w #$6000
	BEQ.b CODE_02BBE0
CODE_02BBDB:
	LDY.w $7400,x
	SEC
	RTS

CODE_02BBE0:
	LDY.b #$02
	LDA.w $7CD6
	SEC
	SBC.w $7CD6,x
	BPL.b CODE_02BBF1
	LDY.b #$00
	EOR.w #$FFFF
	INC
CODE_02BBF1:
	CMP.w #$0008
	BCS.b CODE_02BC21
	LDA.w $7CD8
	SEC
	SBC.w $7CD8,x
	CLC
	ADC.w #$0008
	CMP.w #$0011
	BCS.b CODE_02BC21
CODE_02BC06:
	LDA.w #$0001
	STA.b $78,x
	LDA.w $7040,x
	AND.w #$FFF3
	STA.w $7040,x
	LDA.w $7902,x
	PHA
	JSL.l CODE_06BE72
	PLA
	STA.w $7902,x
	CLC
CODE_02BC21:
	RTS

CODE_02BC22:
	JSR.w CODE_02BC06
	RTL

;---------------------------------------------------------------------------

DATA_02BC26:
	db $2B,$2A,$2B,$2A,$2B,$2A,$2B,$2A,$2C,$29,$2C,$29,$2C,$29,$2C,$29
	db $2C,$28,$27

DATA_02BC39:
	db $03,$03,$03,$03,$03,$03,$03,$03,$10,$04,$04,$04,$04,$04,$04,$04
	db $04,$08,$10

DATA_02BC4C:
	dw $FFF4,$000C

DATA_02BC50:
	dw $FFFF,$FFFF,$FFFE,$FFFE,$FFFD,$0002,$0002,$0001
	dw $0001

DATA_02BC62:
	dw $FFF0,$0010

CODE_02BC66:
	TYX
	JSR.w CODE_02B7D1
	LDY.b $18,x
	BEQ.b CODE_02BC71
	JMP.w CODE_02BD79

CODE_02BC71:
	LDY.w $7A38,x
	BNE.b CODE_02BC79
	JMP.w CODE_02BD01

CODE_02BC79:
	LDA.w $7AF8,x
	BEQ.b CODE_02BC7F
	RTS

CODE_02BC7F:
	DEY
	TYA
	STA.w $7A38,x
	BNE.b CODE_02BC8D
	LDA.w #$0040
	STA.w $7AF8,x
	RTS

CODE_02BC8D:
	LDA.w DATA_02BC39-$01,y
	AND.w #$00FF
	STA.w $7AF8,x
	LDA.w DATA_02BC26-$01,y
	AND.w #$00FF
	STA.w $7402,x
	CMP.w #$0019
	BNE.b CODE_02BCAD
	PHA
	LDA.w #$0014
	JSL.l CODE_0085D2
	PLA
CODE_02BCAD:
	CMP.w #$002A
	BNE.b CODE_02BD00
	LDA.w #$0107
	JSL.l CODE_03A364
	BCC.b CODE_02BD00
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,y
	TAX
	LDA.w $6EBC
	CLC
	ADC.w DATA_02BC4C,x
	STA.w $70E2,y
	LDA.w $6EBE
	SEC
	SBC.w #$0001
	STA.w $7182,y
	LDA.w DATA_02B46A,x
	STA.w $7220,y
	LDA.w #$0001
	STA.w $7D38,y
	STA.w $7A38,y
	LDA.w $6FA0,y
	AND.w #$F9FF
	STA.w $6FA0,y
	LDA.w #$FFFF
	STA.w $7862,y
	LDA.w #$0045
	JSL.l CODE_0085D2
	LDX.b $12
CODE_02BD00:
	RTS

CODE_02BD01:
	LDA.w $7AF8,x
	BEQ.b CODE_02BD1F
	LDY.b #$2C
	CMP.w #$0020
	BCS.b CODE_02BD1A
	LDA.w $77C2,x
	AND.w #$00FF
	CMP.w $7400,x
	BEQ.b CODE_02BD1A
	LDY.b #$2D
CODE_02BD1A:
	TYA
	STA.w $7402,x
	RTS

CODE_02BD1F:
	LDA.w $77C2,x
	AND.w #$00FF
	CMP.w $7400,x
	BNE.b CODE_02BD3F
	LDY.w $7400,x
	LDA.w $7860,x
	AND.w DATA_02B36C,y
	BNE.b CODE_02BD72
	INC.b $18,x
	LDA.w #$0009
	STA.w $7A38,x
	BRA.b CODE_02BD6B

CODE_02BD3F:
	JSR.w CODE_02B259
	BCS.b CODE_02BD72
	LDA.w $7C18,x
	CLC
	ADC.w #$0008
	CMP.w #$0011
	BCC.b CODE_02BD72
	LDY.w $77C3,x
	LDA.w $7182,x
	CLC
	ADC.w DATA_02BC62,y
	LDY.w $7400,x
	JSR.w CODE_02ADC4
	BCC.b CODE_02BD72
	LDA.w $77C3,x
	CLC
	ADC.w #$0002
	STA.b $18,x
CODE_02BD6B:
	LDA.w #$0019
	STA.w $7402,x
	RTS

CODE_02BD72:
	LDA.w #$0014
	STA.w $7A38,x
	RTS

CODE_02BD79:
	DEY
	BNE.b CODE_02BDAB
	DEC.w $7A38,x
	BNE.b CODE_02BD85
CODE_02BD81:
	STZ.b $18,x
	BRA.b CODE_02BD72

CODE_02BD85:
	LDA.w $7A38,x
	ASL
	TAY
	CPY.b #$08
	BNE.b CODE_02BD97
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
CODE_02BD97:
	LDA.w DATA_02BC50,y
	LDY.w $7400,x
	BNE.b CODE_02BDA3
	EOR.w #$FFFF
	INC
CODE_02BDA3:
	CLC
	ADC.w $70E2,x
	STA.w $70E2,x
	RTS

CODE_02BDAB:
	DEY
	BNE.b CODE_02BDB3
	JSR.w CODE_02B0E4
	BRA.b CODE_02BDD9

CODE_02BDB3:
	LDA.w $7AF8,x
	BNE.b CODE_02BDD9
	LDA.w #$0004
	STA.w $7AF8,x
	LDA.w $7402,x
	DEC
	CMP.w #$0017
	BCS.b CODE_02BDCA
	LDA.w #$0019
CODE_02BDCA:
	STA.w $7402,x
	ASL
	TAY
	LDA.w $7182,x
	CLC
	ADC.w $02B026,y
	STA.w $7182,x
CODE_02BDD9:
	LDY.w $7400,x
	JSR.w CODE_02ADC1
	BCS.b CODE_02BDEA
	LDA.w $6EBE
	STA.w $7182,x
CODE_02BDE7:
	JMP.w CODE_02BD81

CODE_02BDEA:
	JSR.w CODE_02B259
	BCS.b CODE_02BDE7
	LDA.w $77C3,x
	AND.w #$00FF
	CLC
	ADC.w #$0002
	CMP.b $18,x
	BNE.b CODE_02BDE7
	RTS

;---------------------------------------------------------------------------

DATA_02BDFE:
	dw $FF80,$0080

CODE_02BE02:
	TYX
CODE_02BE03:
	JSR.w CODE_02B259
	BCS.b CODE_02BE69
CODE_02BE08:
	JSR.w CODE_02B6E4
	SEP.b #$20
	LDA.b #$FF
	STA.w $7862,x
	REP.b #$20
	LDY.w $7400,x
	LDA.w $7860,x
	AND.w DATA_02B36C,y
	BEQ.b CODE_02BE40
CODE_02BE1F:
	STZ.b $76,x
	STZ.w $75E0,x
	STZ.w $7540,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
	LDY.b $78,x
	BNE.b CODE_02BE3D
	LDA.w #$FC00
	JMP.w CODE_02B423

CODE_02BE3D:
	JMP.w CODE_02BB77

CODE_02BE40:
	LDA.w $77C2,x
	AND.w #$00FF
	EOR.w #$0002
	STA.w $7400,x
	TAY
CODE_02BE4D:
	LDA.w DATA_02BDFE,y
	STA.w $75E0,x
CODE_02BE53:
	LDA.w $7220,x
	CLC
	ADC.w #$0080
	CMP.w #$0101
	LDA.w #$0004
	BCC.b CODE_02BE65
	LDA.w #$0020
CODE_02BE65:
	STA.w $7540,x
	RTS

CODE_02BE69:
	SEP.b #$20
	LDA.b #$FF
	STA.w $7862,x
	REP.b #$20
	LDA.w $77C2,x
	AND.w #$00FF
	STA.w $7400,x
	STZ.w $75E0,x
	BRA.b CODE_02BE53

CODE_02BE80:
	TYX
	JSR.w CODE_02B7D1
	JMP.w CODE_02BE03

;---------------------------------------------------------------------------

CODE_02BE87:
	TYX
	RTS

;---------------------------------------------------------------------------

CODE_02BE89:
	TYX
	LDY.b $78,x
	BNE.b CODE_02BEB2
	LDA.w #$0004
	STA.w $74A2,x
	SEP.b #$20
	LDA.b #$FF
	STA.w $7862,x
	REP.b #$20
	JSR.w CODE_02BBCE
	TYA
	STA.w $7400,x
	LDA.w $7860,x
	AND.w DATA_02B36C,y
	BEQ.b CODE_02BEAF
	JMP.w CODE_02BE1F

CODE_02BEAF:
	JMP.w CODE_02BE4D

CODE_02BEB2:
	LDA.w #$0003
	STA.w $74A2,x
	JSR.w CODE_02B7D1
	JSR.w CODE_02B7A7
	JSR.w CODE_02B259
	BCS.b CODE_02BEC6
	JMP.w CODE_02BE08

CODE_02BEC6:
	JMP.w CODE_02BE69

;---------------------------------------------------------------------------

CODE_02BEC9:
	TYX
	LDY.w $7A38,x
	BEQ.b CODE_02BEFD
	CPY.b #$04
	BCS.b CODE_02BED9
	LDA.w #$0080
	STA.w $75E2,x
CODE_02BED9:
	LDA.w $7AF8,x
	BNE.b CODE_02BEE7
	DEC.w $7A38,x
	LDA.w #$0010
	STA.w $7AF8,x
CODE_02BEE7:
	JSR.w CODE_02B6E4
	LDA.b $16,x
	AND.w #$0008
	BEQ.b CODE_02BEF7
	LDA.w #$0020
	STA.w $7402,x
CODE_02BEF7:
	STZ.w $75E0,x
	JMP.w CODE_02BE53

CODE_02BEFD:
	JMP.w CODE_02BE08

CODE_02BF00:
	LDA.w $70E2,x
	AND.w #$0010
	STA.b $78,x
	RTL

;---------------------------------------------------------------------------

DATA_02BF09:
	dw $7D8F,$7D8F,$7D8F,$7D8F,$7D8F,$7D8F,$7D8F,$7D8F
	dw $001F,$001E,$001D,$001C,$001B,$001C,$001D,$001E
	dw $7FFF

DATA_02BF2B:
	dw $6CAA,$6CAA,$6CAA,$6CAA,$6CAA,$6CAA,$6CAA,$6CAA
	dw $0015,$0016,$0017,$0018,$0019,$0018,$0017,$0016
	dw $7FFF

DATA_02BF4D:
	dw $7F2F,$7F2F,$7F2F,$7F2F,$7F2F,$7F2F,$7F2F,$7F2F
	dw $01DF,$01DF,$01DF,$01DF,$01DF,$01DF,$01DF,$01DF
	dw $7FFF

DATA_02BF6F:
	dw $0000,$0001,$0002,$0002,$0001,$0000,$0000,$0001
	dw $0002,$0002,$0001

DATA_02BF85:
	dw $000A,$0016

DATA_02BF89:
	dw $FFC0,$0040

DATA_01BF8D:
	dw $0001,$FFFF

CODE_02BF91:
	JSR.w CODE_02C1F4
	JSL.l CODE_03AF23
	LDY.b #$02
	LDA.w $7680,x
	CLC
	ADC.w #$0050
	BMI.b CODE_02BFAB
	SEC
	SBC.w #$01A0
	BMI.b CODE_02BFB9
	LDY.b #$00
CODE_02BFAB:
	EOR.w #$FFFF
	INC
	STA.b $02
	STZ.w $7220,x
	STZ.w $7540,x
	BRA.b CODE_02BFC4

CODE_02BFB9:
	STZ.b $02
	LDY.b #$00
	LDA.w $7220,x
	BMI.b CODE_02BFC4
	LDY.b #$02
CODE_02BFC4:
	STY.b $00
	LDA.w $7CD6,x
	CLC
	ADC.w DATA_02BF89,y
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7CD8,x
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	BEQ.b CODE_02BFF0
	STZ.w $7220,x
	LDY.b $00
	LDA.w DATA_01BF8D,y
	STA.b $02
CODE_02BFF0:
	LDA.w $70E2,x
	CLC
	ADC.b $02
	STA.w $70E2,x
	TXY
	LDA.b $18,x
	ASL
	TAX
	JSR.w (DATA_02C0A0,x)
	STZ.w $7A38,x
	LDA.w $7AF8,x
	BEQ.b CODE_02C015
	AND.w #$FFFE
	TAY
	LDA.w DATA_02BF6F,y
	STA.w $7402,x
	BRA.b CODE_02C028

CODE_02C015:
	LDA.b $10
	AND.w #$003F
	BNE.b CODE_02C028
	LDA.b $14
	AND.w #$0002
	TAY
	LDA.w DATA_02BF85,y
	STA.w $7AF8,x
CODE_02C028:
	TXA
	STA.w $6012
	LDA.w $60B0
	STA.w $6014
	LDA.w $60B2
	STA.w $6016
	LDA.w $60C2
	STA.w $6018
	LDX.b #FXCODE_0A8390>>16
	LDA.w #FXCODE_0A8390
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $601A
	BEQ.b CODE_02C055
	INC.w $7A38,x
	JSL.l CODE_03A858
CODE_02C055:
	LDY.w $7D36,x
	DEY
	BMI.b CODE_02C06B
	LDA.w $7D38,y
	BEQ.b CODE_02C06B
	LDA.w #$FFFF
	STA.w $7A38,x
	TYX
	JSL.l CODE_03B25B
CODE_02C06B:
	LDY.b #$20
	LDA.w $7AF6,x
	AND.w #$0004
	BNE.b CODE_02C07E
	LDA.b $14
	LSR
	AND.w #$000E
	ORA.b $78,x
	TAY
CODE_02C07E:
	LDA.w DATA_02BF09,y
	STA.l $702002
	STA.l $702D6E
	LDA.w DATA_02BF2B,y
	STA.l $702004
	STA.l $702D70
	LDA.w DATA_02BF4D,y
	STA.l $702006
	STA.l $702D72
	RTL

DATA_02C0A0:
	dw CODE_02C0A8
	dw CODE_02C141

DATA_02C0A4:
	dw $FE00,$0200

CODE_02C0A8:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_02C0C3
	LDY.w $77C2,x
	LDA.w DATA_02C0A4,y
	STA.w $75E0,x
	LDA.w #$0020
	STA.w $7540,x
	LDA.w #$0040
	STA.w $7A98,x
CODE_02C0C3:
	LDA.b $76,x
	BNE.b CODE_02C0DC
	LDA.w $7976,x
	CLC
	ADC.w #$0004
	CMP.w #$0101
	BCC.b CODE_02C0D8
	INC.b $76,x
	LDA.w #$0000
CODE_02C0D8:
	STA.w $7976,x
	RTS

CODE_02C0DC:
	LDY.b $00
	TYA
	CMP.w $7400,x
	BEQ.b CODE_02C0F5
	LDA.b $16,x
	CLC
	ADC.w #$0008
	CMP.w #$0101
	BCC.b CODE_02C102
	TYA
	STA.w $7400,x
	BRA.b CODE_02C0FF

CODE_02C0F5:
	LDA.b $16,x
	BEQ.b CODE_02C105
	SEC
	SBC.w #$0004
	BPL.b CODE_02C102
CODE_02C0FF:
	LDA.w #$0000
CODE_02C102:
	STA.b $16,x
	RTS

CODE_02C105:
	LDA.w $7A96,x
	BNE.b CODE_02C13C
	LDY.w $77C2,x
	TYA
	CMP.w $7400,x
	BNE.b CODE_02C13C
	LDA.w $7C16,x
	CLC
	ADC.w #$0090
	CMP.w #$0121
	BCS.b CODE_02C13C
	LDA.w #$0048
	JSL.l CODE_0085D2
	INC.b $18,x
	STZ.w $7A36,x
	LDA.w #$0003
	STA.b $76,x
	STZ.w $7220,x
	STZ.w $7540,x
	LDA.w #$0080
	STA.w $7A98,x
CODE_02C13C:
	RTS

DATA_02C13D:
	dw $FF00,$0100

CODE_02C141:
	TYX
	LDY.b $76,x
	CPY.b #$04
	BCC.b CODE_02C16C
	LDA.w $7A36,x
	BNE.b CODE_02C16C
	LDA.w $7A38,x
	BEQ.b CODE_02C16C
	STA.w $7A36,x
	BPL.b CODE_02C166
	PHY
	LDA.w #$007A
	JSL.l CODE_0085D2
	PLY
	LDA.w #$0040
	STA.w $7AF6,x
CODE_02C166:
	STZ.w $7220,x
	STZ.w $7540,x
CODE_02C16C:
	CPY.b #$07
	BCS.b CODE_02C178
	LDA.w $7A36,x
	BPL.b CODE_02C178
	LDA.w #$0020
CODE_02C178:
	CLC
	ADC.w #$0008
	CLC
	ADC.b $16,x
	CMP.w #$0101
	BCC.b CODE_02C1E9
	INY
	CPY.b #$09
	BCS.b CODE_02C1C7
	CPY.b #$05
	BCC.b CODE_02C1E3
	LDA.w $7A36,x
	BNE.b CODE_02C1BF
	LDA.w $7A98,x
	BNE.b CODE_02C1B7
	LDA.w $77C2,x
	AND.w #$00FF
	CMP.w $7400,x
	BNE.b CODE_02C1BF
	PHY
	TAY
	LDA.w DATA_02C13D,y
	STA.w $75E0,x
	LDA.w #$0010
	STA.w $7540,x
	LDA.w #$0040
	STA.w $7A98,x
	PLY
CODE_02C1B7:
	CPY.b #$07
	BNE.b CODE_02C1E3
	LDY.b #$05
	BRA.b CODE_02C1E3

CODE_02C1BF:
	CPY.b #$05
	BNE.b CODE_02C1E3
	LDY.b #$07
	BRA.b CODE_02C1E3

CODE_02C1C7:
	STZ.b $18,x
	LDA.w #$0020
	LDY.w $7A36,x
	BEQ.b CODE_02C1DE
	LDA.w #$00A0
	LDY.w $0218
	CPY.b #$06
	BCS.b CODE_02C1DE
	LDA.w #$0100
CODE_02C1DE:
	STA.w $7A96,x
	LDY.b #$01
CODE_02C1E3:
	TYA
	STA.b $76,x
	LDA.w #$0000
CODE_02C1E9:
	STA.b $16,x
	RTS

DATA_02C1EC:
	dw $0048,$00B0

DATA_02C1F0:
	dw $0040,$00B8

CODE_02C1F4:
	LDA.b $76,x
	ASL
	ASL
	ORA.w $7400,x
	TAY
	LDA.w DATA_02C2DC,y
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w DATA_02C2E0,y
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0002
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$003E
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STZ.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$449E
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.b $16,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $7680,x
	CLC
	ADC.w #$0008
	STA.w $6040
	LDA.w $7682,x
	SEC
	SBC.w #$0008
	STA.w $6042
	LDX.b #FXCODE_08E93B>>16
	LDA.w #FXCODE_08E93B
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	JSL.l CODE_00BE39	: db $40,$50,$7E,$72,$33,$70,$48,$03
	LDX.b $12
	LDA.w #$0004
	TSB.w $0967
	LDA.w #$0008
	TRB.w $095E
	LDA.w #$0018
	TSB.w $094A
	LDY.w $7400,x
	LDX.b #$7C
	LDA.l $70449E,x
	STA.b $00
	LDA.l $7044A0,x
	STA.b $02
	LDX.w DATA_02C1EC,y
	LDA.l $70449E,x
	STA.b $04
	LDA.l $7044A0,x
	STA.b $06
	LDX.w DATA_02C1F0,y
	LDA.l $70449E,x
	STA.b $08
	LDA.l $7044A0,x
	STA.b $0A
	LDX.b $12
	REP.b #$10
	LDY.w $7362,x
	LDX.w #$000A
CODE_02C298:
	LDA.w $6000,y
	CLC
	ADC.b $00
	STA.w $6000,y
	LDA.w $6002,y
	CLC
	ADC.b $02
	STA.w $6002,y
	TYA
	CLC
	ADC.w #$0008
	TAY
	DEX
	BNE.b CODE_02C298
	LDA.w $6000,y
	CLC
	ADC.b $04
	STA.w $6000,y
	LDA.w $6002,y
	CLC
	ADC.b $06
	STA.w $6002,y
	LDA.w $6008,y
	CLC
	ADC.b $08
	STA.w $6008,y
	LDA.w $600A,y
	CLC
	ADC.b $0A
	STA.w $600A,y
	SEP.b #$10
	LDX.b $12
	RTS

DATA_02C2DC:
	dw DATA_02C304,DATA_02C304

DATA_02C2E0:
	dw DATA_02C380,DATA_02C570,DATA_02C570,DATA_02C380,DATA_02C380,DATA_02C570,DATA_02C3FC,DATA_02C5EC
	dw DATA_02C4F4,DATA_02C6E4,DATA_02C478,DATA_02C668,DATA_02C4F4,DATA_02C6E4,DATA_02C3FC,DATA_02C5EC
	dw DATA_02C380,DATA_02C570

DATA_02C304:
	dw $0000,$00C0,$00C6,$00C9,$00CB,$00CD,$00CE,$00E8
	dw $0002,$000B,$0013,$0016,$0018,$0015,$0012,$000C
	dw $0001,$00EF,$00DC,$00D7,$00D3,$00CF,$00CF,$00D0
	dw $00D0,$00D1,$00D3,$00D8,$00DF,$00E7,$00F1,$00F1
	dw $00FC,$0008,$0013,$001D,$0024,$0028,$0029,$002A
	dw $002B,$002D,$002E,$002E,$002E,$002E,$002E,$002E
	dw $002E,$002E,$002E,$002E,$002E,$002E,$002E,$002E
	dw $002E,$0030,$0034,$0037,$003B,$003F

DATA_02C380:
	dw $0000,$00C0,$FFC6,$FEC9,$FDCB,$FBCD,$FACE,$FAE8
	dw $FA02,$FA0B,$FA13,$FA16,$FA18,$FA15,$FA12,$FA0C
	dw $FA01,$FAEF,$FADC,$FAD7,$FAD3,$FACF,$F9CF,$F8D0
	dw $F8D0,$F7D1,$F6D3,$F4D8,$F2DF,$F1E7,$F1F1,$F1F1
	dw $F1FC,$F108,$F213,$F41D,$F624,$F728,$F829,$F82A
	dw $F92B,$FA2D,$FA2E,$FA2E,$FA2E,$FA2E,$FA2E,$FA2E
	dw $FA2E,$FA2E,$FA2E,$FA2E,$FA2E,$FA2E,$FA2E,$FA2E
	dw $FA2E,$FB30,$FD34,$FE37,$003B,$003F

DATA_02C3FC:
	dw $0000,$00C0,$FCC6,$F8C9,$F3CB,$ECCD,$E7CE,$E7E8
	dw $E702,$E70B,$E713,$E716,$E718,$E715,$E712,$E70C
	dw $E701,$E7EF,$E7DC,$E7D7,$E7D3,$E6CF,$E2CF,$E0D0
	dw $DED0,$DBD1,$D6D3,$CED8,$C7DF,$C3E7,$C1F1,$C1F1
	dw $C1FC,$C308,$C713,$CE1D,$D624,$DB28,$DE29,$E02A
	dw $E22B,$E62D,$E72E,$E72E,$E72E,$E72E,$E72E,$E72E
	dw $E72E,$E72E,$E72E,$E72E,$E72E,$E72E,$E72E,$E72E
	dw $E72E,$EC30,$F334,$F837,$FD3B,$003F

DATA_02C478:
	dw $0000,$00C0,$FAC5,$F5C8,$E9CB,$DCCD,$C8D0,$C6E8
	dw $C202,$BF0B,$BC13,$B916,$B518,$B015,$AD12,$A90C
	dw $A501,$A1EF,$9EDC,$9DD7,$9DD3,$9BD0,$97D0,$95D2
	dw $93D6,$92DA,$8DDD,$89E1,$86E5,$84EA,$82F1,$82F1
	dw $82FC,$8301,$8508,$890F,$8E15,$9219,$931A,$951B
	dw $971C,$9B1E,$9D1F,$9D1F,$9E20,$A121,$A523,$A924
	dw $AC25,$B027,$B528,$B929,$BC2A,$C02A,$C22B,$C62C
	dw $C82C,$DC31,$E934,$F538,$FA3B,$003F

DATA_02C4F4:
	dw $0000,$00C0,$FCC3,$F9C5,$F1C8,$E8CA,$DCCA,$DAE8
	dw $D701,$D00F,$CB14,$C117,$BA18,$B417,$AF15,$A911
	dw $A40B,$9BFA,$97E6,$96DE,$95D8,$92D4,$8DD3,$8BD5
	dw $8AD7,$8AE1,$88E4,$86E7,$84EC,$83F0,$82F5,$8200
	dw $8206,$840C,$8610,$8916,$8D1B,$9220,$9321,$9523
	dw $9724,$9B26,$9D27,$9E27,$9F27,$A128,$A529,$A92A
	dw $AC2B,$B02C,$B32D,$BA2D,$C12E,$CB2F,$D02F,$D730
	dw $DA31,$E834,$F137,$F93B,$FC3D,$003F

DATA_02C570:
	dw $0000,$00C1,$00C5,$FEC9,$FDCC,$FBD0,$FAD2,$FAD2
	dw $FAD2,$FAD2,$FAD2,$FAD2,$FAD2,$FAD2,$FAD2,$FAD2
	dw $FAD2,$FAD2,$FAD2,$FAD2,$FAD2,$FAD3,$F9D5,$F8D6
	dw $F8D7,$F7D8,$F6DC,$F4E3,$F2ED,$F1F8,$F104,$F10F
	dw $F10F,$F119,$F221,$F428,$F62D,$F72F,$F830,$F830
	dw $F931,$FA31,$FA2D,$FA29,$FA24,$FA11,$FAFF,$FAF4
	dw $FAEE,$FAEB,$FAE8,$FAEA,$FAED,$FAF5,$FAFE,$FA18
	dw $FA32,$FB33,$FD35,$FE37,$FF3A,$0040

DATA_02C5EC:
	dw $0000,$00C1,$FDC5,$F8C9,$F3CC,$ECD0,$E7D2,$E7D2
	dw $E7D2,$E7D2,$E7D2,$E7D2,$E7D2,$E7D2,$E7D2,$E7D2
	dw $E7D2,$E7D2,$E7D2,$E7D2,$E7D2,$E6D3,$E2D5,$E0D6
	dw $DED7,$DBD8,$D6DC,$CEE3,$C7ED,$C3F8,$C104,$C10F
	dw $C10F,$C319,$C721,$CE28,$D62D,$DB2F,$DE30,$E030
	dw $E231,$E631,$E72D,$E729,$E724,$E711,$E7FF,$E7F4
	dw $E7EE,$E7EB,$E7E8,$E7EA,$E7ED,$E7F5,$E7FE,$E718
	dw $E732,$EC33,$F335,$F837,$FC3A,$0040

DATA_02C668:
	dw $0000,$00C1,$FAC5,$F5C8,$E9CC,$DCCF,$C8D4,$C6D4
	dw $C2D5,$C0D6,$BCD6,$B9D7,$B5D8,$B0D9,$ACDB,$A9DC
	dw $A5DD,$A1DF,$9EE0,$9DE1,$9DE1,$9BE2,$97E4,$95E5
	dw $93E6,$92E7,$8EEB,$89F1,$85F8,$83FF,$8204,$820F
	dw $820F,$8416,$861B,$891F,$8D23,$9226,$932A,$952E
	dw $9730,$9B30,$9D2D,$9D29,$9E24,$A111,$A5FF,$A9F4
	dw $ADEE,$B0EB,$B5E8,$B9EA,$BCED,$BFF5,$C2FE,$C618
	dw $C830,$DC33,$E935,$F538,$FA3B,$0040

DATA_02C6E4:
	dw $0000,$00C1,$FCC3,$F9C5,$F1C9,$E8CC,$DACF,$D7D0
	dw $D0D1,$CBD1,$C1D2,$BAD3,$B3D3,$B0D4,$ACD5,$A9D6
	dw $A5D7,$A1D8,$9FD9,$9ED9,$9DD9,$9BDA,$97DC,$95DD
	dw $93DF,$92E0,$8DE5,$89EA,$86F0,$84F4,$82FA,$8200
	dw $820B,$8310,$8414,$8619,$881C,$8A1F,$8A29,$8B2B
	dw $8D2D,$922C,$9528,$9622,$971A,$9B06,$A4F5,$A9EF
	dw $AFEB,$B4E9,$BAE8,$C1E9,$CBEC,$D0F1,$D7FF,$DA18
	dw $DC36,$E836,$F138,$F93B,$FC3D,$0040

;---------------------------------------------------------------------------

DATA_02C760:
	db $43,!REGISTER_BG2HorizScrollOffset : dl $7E5D18

DATA_02C765:
	db $D9 : db $88,$53
	db $D9 : db $EC,$54
	db $00

DATA_02C76C:
	dw DATA_02C774,DATA_02C794

DATA_02C770:
	dw DATA_02C7B4,DATA_02C7D4

DATA_02C774:
	dw $0050,$1E48,$3939,$481E,$5000,$48E3,$39C8,$1EB9
	dw $00B1,$E3B9,$C8C8,$B9E3,$B100,$B91E,$C839,$E348

DATA_02C794:
	dw $004E,$1F4A,$3737,$4A1F,$4E00,$4AE2,$37CA,$1FB7
	dw $00B3,$E2B7,$CACA,$B7E2,$B300,$B71F,$CA37,$E24A

DATA_02C7B4:
	dw $0040,$1534,$2D2D,$3415,$4000,$34EC,$2DD4,$15CD
	dw $00C1,$ECCD,$D4D4,$CDEC,$C100,$CD15,$D42D,$EC34

DATA_02C7D4:
	dw $0038,$183B,$2828,$3B18,$3800,$3BE9,$28D9,$18C6
	dw $00C9,$E9C6,$D9D9,$C6E9,$C900,$C618,$D928,$E93B

CODE_02C7F4:
	LDA.w $70E2,x
	AND.w #$0010
	BNE.b CODE_02C7FF
	JMP.w CODE_02C8A1

CODE_02C7FF:
	AND.w $7182,x
	BEQ.b CODE_02C873
	INC.w $0B59
	LDA.w #$0017
	JSL.l CODE_03A364
	BCS.b CODE_02C814
	JML.l CODE_03A31E

CODE_02C814:
	LDA.w #$000E
	STA.w $6F00,y
	LDA.w $70E2,x
	SEC
	SBC.w #$0058
	STA.w $70E2,y
	SEC
	SBC.w #$0010
	STA.w $608C
	LDA.w $7182,x
	SEC
	SBC.w #$0028
	STA.w $7182,y
	SEC
	SBC.w #$0008
	STA.w $6090
	LDA.w $6FA2,y
	AND.w #$FFE0
	ORA.w #$2000
	STA.w $6FA2,y
	LDA.w #$0000
	STA.w $7542,y
	LDA.w #$0080
	STA.w $7A96,y
	LDA.w #$0060
	STA.w $105C
	JSR.w CODE_02C92C
	LDX.b #$1C
CODE_02C85F:
	LDA.l $7021A2,x
	STA.l $7021C2,x
	STA.l $702F2E,x
	DEX
	DEX
	BPL.b CODE_02C85F
	LDX.b $12
	BRA.b CODE_02C89D

CODE_02C873:
	LDA.w #$0017
	JSL.l CODE_03A364
	BCC.b CODE_02C89D
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
	LDA.w #$000D
	STA.w $79D6,y
	LDA.w $6FA2,y
	ORA.w #$2000
	STA.w $6FA2,y
	LDY.b #$36
	JSL.l CODE_0CE5D6
CODE_02C89D:
	JML.l CODE_03A31E

CODE_02C8A1:
	JSL.l CODE_03AD74
	BCS.b CODE_02C8AA
	JMP.w CODE_02A31D+$01				; Glitch: This jumps to the middle of an instruction!

CODE_02C8AA:
	JSR.w CODE_02C92C
	LDA.w #$0010
	STA.l $7049C6
	DEC
	ASL
	TAX
CODE_02C8B7:
	LDA.w DATA_02C774,x
	STA.l $7049C7,x
	DEX
	DEX
	BPL.b CODE_02C8B7
	LDX.b #$3C
CODE_02C8C4:
	LDA.l DATA_5FE802,x
	STA.l $702E2E,x
	STA.l $7020C2,x
	DEX
	DEX
	BPL.b CODE_02C8C4
	LDY.b #!REGISTER_BG1HorizScrollOffset
	STY.w HDMA[$03].Destination
	LDY.b #!REGISTER_BG1VertScrollOffset
	STY.w HDMA[$04].Destination
	SEP.b #$20
	LDX.b #$04
CODE_02C8E2:
	LDA.w DATA_02C760,x
	STA.w HDMA[$07].Parameters,x
	DEX
	BPL.b CODE_02C8E2
	LDA.b #$7E
	STA.w HDMA[$07].IndirectSourceBank
	LDX.b #$06
CODE_02C8F2:
	LDA.w DATA_02C765,x
	STA.l $7E5D18,x
	DEX
	BPL.b CODE_02C8F2
	REP.b #$20
	LDX.b $12
	LDA.w $7182,x
	CLC
	ADC.w #$0008
	STA.w $7182,x
	LDA.w #$0180
	STA.w $7AF8,x
	LDA.w #$0100
	STA.w $7AF6,x
	STA.w $7A36,x
	INC.w $0C1E
	STZ.w $0C23
	INC.w $0C20
	LDA.w #$070C
	STA.w $0C27
	JML.l CODE_0CDB4D

CODE_02C92C:
	LDY.w $7DF6
	BEQ.b CODE_02C943
CODE_02C931:
	PHY
	LDX.w $7DF6,y
	JSL.l CODE_03A32E
	PLY
	DEY
	DEY
	BNE.b CODE_02C931
	STZ.w $7DF6
	LDX.b $12
CODE_02C943:
	RTS

;---------------------------------------------------------------------------

DATA_02C944:
	dw $FFFF,$0001

DATA_02C948:
	dw $FFC0,$0040

DATA_02C94C:
	dw $FE00,$0200

CODE_02C950:
	JSR.w CODE_02CDFA
	JSL.l CODE_03AF23
	LDA.w $0CB0
	STA.w $0043
	STA.w $60A0
	TXY
	LDA.b $18,x
	ASL
	TAX
	JSR.w (DATA_02CAF0,x)
	LDA.w #$FC00
	LDY.b $79,x
	BPL.b CODE_02C972
	LDA.w #$0400
CODE_02C972:
	LDY.b #$00
	CLC
	ADC.b $76,x
	BPL.b CODE_02C97B
	LDY.b #$02
CODE_02C97B:
	LDA.b $78,x
	PHA
	SEC
	SBC.w DATA_02C94C,y
	EOR.w DATA_02C948,y
	ASL
	PLA
	BCC.b CODE_02C98F
	CLC
	ADC.w DATA_02C948,y
	STA.b $78,x
CODE_02C98F:
	CLC
	ADC.b $76,x
	STA.b $76,x
	CLC
	ADC.w #$3000
	CMP.w #$6001
	BCC.b CODE_02C9AB
	LDA.b $76,x
	EOR.b $78,x
	BMI.b CODE_02C9AB
	LDA.b $78,x
	EOR.w #$FFFF
	INC
	STA.b $78,x
CODE_02C9AB:
	TXA
	STA.w $6012
	LDA.w $60B0
	STA.w $6014
	LDA.w $60B2
	STA.w $6016
	LDA.w $60C2
	STA.w $6018
	LDX.b #FXCODE_0A8AD0>>16
	LDA.w #FXCODE_0A8AD0
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $601A
	AND.w #$001E
	BEQ.b CODE_02CA03
	ASL
	AND.w $601A
	AND.w #$0014
	BEQ.b CODE_02C9E2
	CMP.w #$0014
	BEQ.b CODE_02CA00
CODE_02C9E2:
	EOR.w #$0014
	LDY.b #$00
	AND.w $601A
	BEQ.b CODE_02C9EE
	LDY.b #$02
CODE_02C9EE:
	LDA.w $608C
	CLC
	ADC.w DATA_02C944,y
	STA.w $608C
	LDA.w $60B4
	EOR.w DATA_02C944,y
	BPL.b CODE_02CA03
CODE_02CA00:
	STZ.w $60B4
CODE_02CA03:
	LDA.w $601A
	AND.w #$0001
	BEQ.b CODE_02CA67
	LDA.w $6090
	CMP.w $6EBE
	BMI.b CODE_02CA67
	LDA.w $60C0
	BEQ.b CODE_02CA1D
	LDA.w $60AA
	BMI.b CODE_02CA67
CODE_02CA1D:
	LDA.w $608C
	CLC
	ADC.w #$0008
	SEC
	SBC.w $6EBC
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $6090
	CLC
	ADC.w #$0020
	SEC
	SBC.w $6EBE
	CMP.w #$0080
	BCC.b CODE_02CA3E
	LDA.w #$007F
CODE_02CA3E:
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0060
	STA.w $6004
	LDX.b #FXCODE_0A8DC8>>16
	LDA.w #FXCODE_0A8DC8
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $60AC
	CMP.w #$0006
	BEQ.b CODE_02CA67
	INC.w $61B4
	LDA.w $6090
	CLC
	ADC.w $601C
	STA.w $6090
CODE_02CA67:
	LDY.w $7D36,x
	DEY
	BPL.b CODE_02CA70
	JMP.w CODE_02CAEF

CODE_02CA70:
	LDA.w $6EBC
	SEC
	SBC.w $7CD6,y
	STA.b $0C
	ASL
	CLC
	ADC.b $0C
	STA.b $0C
	CLC
	ADC.w $7220,y
	STA.w $7220,y
	EOR.b $0C
	STA.b $00
	LDA.w $6EBE
	SEC
	SBC.w $7CD8,y
	STA.b $0E
	ASL
	CLC
	ADC.b $0E
	STA.b $0E
	CLC
	ADC.w $7222,y
	STA.w $7222,y
	EOR.b $0E
	ORA.b $00
	BPL.b CODE_02CAC4
	LDA.w $7542,y
	CMP.w #$0040
	BCC.b CODE_02CACA
	PHB
	TYX
	JSL.l CODE_03B078
	TXY
	PLB
	LDA.b $0C
	ASL
	STA.w $7220,x
	LDA.b $0E
	ASL
	STA.w $7222,x
	BRA.b CODE_02CACA

CODE_02CAC4:
	LDA.w #$0040
	STA.w $7542,y
CODE_02CACA:
	LDA.w $7CD6,y
	SEC
	SBC.w $6EBC
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7CD8,y
	SEC
	SBC.w $6EBE
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0078
	STA.w $6004
	LDX.b #FXCODE_0A8DC8>>16
	LDA.w #FXCODE_0A8DC8
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_02CAEF:
	RTL

DATA_02CAF0:
	dw CODE_02CAF6
	dw CODE_02CD2A
	dw CODE_02CDF4

CODE_02CAF6:
	TYX
	LDA.w $7AF6,x
	BNE.b CODE_02CB47
	LDA.b $10
	AND.w #$003C
	CLC
	ADC.w #$00C4
	CMP.w #$00D8
	BCC.b CODE_02CB0F
	CMP.w #$00F4
	BCC.b CODE_02CB47
CODE_02CB0F:
	PHA
	LDA.w $7A39,x
	AND.w #$00FF
	STA.b $00
	LSR
	LSR
	ADC.b $00
	LSR
	LSR
	EOR.w #$FFFF
	ADC.w #$0070
	STA.w $7AF6,x
	LDA.w #$013B
	JSL.l CODE_03A364
	PLA
	BCC.b CODE_02CB47
	STA.w $79D6,y
	TXA
	STA.w $7978,y
	PHY
	JSR.w CODE_02D0D9
	PLY
	LDA.b $00
	STA.w $70E2,y
	LDA.b $02
	STA.w $7182,y
CODE_02CB47:
	LDA.w $7AF8,x
	BNE.b CODE_02CBB0
	LDA.w #$0100
	STA.w $7AF8,x
	LDA.w #$002A
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$002C
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDX.b #FXCODE_0991DB>>16
	LDA.w #FXCODE_0991DB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$0002
	BCS.b CODE_02CBB0
	LDA.w #$0043
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0045
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDX.b #FXCODE_0991DB>>16
	LDA.w #FXCODE_0991DB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	BNE.b CODE_02CBB0
	LDA.b $10
	AND.w #$0001
	CLC
	ADC.w #$0043
	JSL.l CODE_03A34C
	BCC.b CODE_02CBB0
	LDA.w $70E2,x
	SEC
	SBC.w #$0008
	STA.w $70E2,y
	LDA.w $7182,x
	SEC
	SBC.w #$0074
	STA.w $7182,y
CODE_02CBB0:
	LDA.w $7A96,x
	BEQ.b CODE_02CBF1
	LDA.w $7A98,x
	AND.w #$000F
	CMP.w #$0001
	BNE.b CODE_02CBC7
	LDA.w #$003F
	JSL.l CODE_0085D2
CODE_02CBC7:
	LDA.w $7A98,x
	AND.w #$0004
	BEQ.b CODE_02CBE6
	LDX.b #$3C
	LDA.w #$7FFF
CODE_02CBD4:
	STA.l $7020C2,x
	DEX
	DEX
	BPL.b CODE_02CBD4
	LDX.b $12
	LDY.b #$05
	STY.w $096C
CODE_02CBE3:
	JMP.w CODE_02CCD3

CODE_02CBE6:
	LDY.b #$45
	STY.w $096C
	LDA.w $7A38,x
	JMP.w CODE_02CC88

CODE_02CBF1:
	LDY.w $7D36,x
	DEY
	BMI.b CODE_02CBE3
	LDA.w $7D38,y
	BEQ.b CODE_02CBE3
	LDA.w $7C76,x
	EOR.w #$FFFF
	INC
	AND.w #$00FF
	XBA
	CMP.w #$FFFF
	BNE.b CODE_02CC0F
	INC
	BRA.b CODE_02CC13

CODE_02CC0F:
	CMP.w #$8000
	ROR
CODE_02CC13:
	STA.b $00
	EOR.w $7220,y
	ASL
	LDA.w $7220,y
	BCC.b CODE_02CC21
	LDA.w #$0000
CODE_02CC21:
	CLC
	ADC.b $00
	STA.b $00
	LDA.w $7222,y
	EOR.w $7C76,x
	ASL
	LDA.w $7222,y
	BCS.b CODE_02CC36
	EOR.w #$FFFF
	INC
CODE_02CC36:
	CLC
	ADC.b $00
	STA.b $78,x
	BPL.b CODE_02CC41
	EOR.w #$FFFF
	INC
CODE_02CC41:
	PHA
	ASL
	ASL
	ASL
	AND.w #$FF00
	XBA
	CMP.w #$0020
	BCS.b CODE_02CC51
	LDA.w #$0020
CODE_02CC51:
	STA.w $7A96,x
	LDA.w #$0020
	STA.w $7A98,x
	STA.w $61C8
	TYX
	JSL.l CODE_03B25B
	PLA
	ASL
	CLC
	ADC.w $7A38,x
	STA.w $7A38,x
	BCC.b CODE_02CC88
	INC.b $18,x
	LDA.w #$0140
	STA.w $7A96,x
	STZ.w $7A38,x
	LDA.w #$0800
	STA.w $61C8
	JSL.l CODE_028925
	JSL.l CODE_02A982
	BRA.b CODE_02CCD3

CODE_02CC88:
	AND.w #$FF00
	XBA
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #DATA_5FD94C
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDA.w #DATA_5FD94C>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0001
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$0007
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08E167>>16
	LDA.w #FXCODE_08E167
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #DATA_5FE8B0
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDA.w #DATA_5FE8B0>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0061
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$001F
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08E167>>16
	LDA.w #FXCODE_08E167
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_02CCD3:
	LDA.w #DATA_02C774>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.b $14
	AND.w #$0008
	TAY
	BEQ.b CODE_02CCF4
	LDY.b #$02
	LDA.w $7A96,x
	BEQ.b CODE_02CCF4
	LDA.b $14
	AND.w #$0010
	LSR
	LSR
	LSR
	ADC.w #$0004
	TAY
CODE_02CCF4:
	LDA.w DATA_02C76C,y
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_0A8D8B>>16
	LDA.w #FXCODE_0A8D8B
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	RTS

DATA_02CD06:
	dw $0002,$0000,$FFFE,$0000,$0002,$0000,$FFFE,$0000

DATA_02CD16:
	dw $FFFF,$0001

DATA_02CD1A:
	dw $48EC,$492A,$4968,$49A6

DATA_02CD22:
	dw $3958,$3966,$3974,$3982

CODE_02CD2A:
	TYX
	LDY.b #$00
	LDA.w $70E2,x
	SEC
	SBC.w #$0008
	CMP.w $608C
	BEQ.b CODE_02CD47
	BMI.b CODE_02CD3D
	LDY.b #$02
CODE_02CD3D:
	LDA.w $608C
	CLC
	ADC.w DATA_02CD16,y
	STA.w $608C
CODE_02CD47:
	PHB
	LDA.b $14
	AND.w #$000C
	LSR
	TAY
	REP.b #$10
	LDX.w DATA_02CD22,y
	PHX
	LDX.w DATA_02CD1A,y
	PEA.w $702002>>8
	PLB
	PLB
	LDY.w #$003C
CODE_02CD60:
	LDA.l DATA_5FA000,x
	STA.w $7020C2,y
	DEX
	DEX
	DEY
	DEY
	BPL.b CODE_02CD60
	PLX
	LDY.w #$000C
CODE_02CD71:
	LDA.l DATA_5FA000,x
	STA.w $702002,y
	DEX
	DEX
	DEY
	DEY
	BPL.b CODE_02CD71
	PLB
	SEP.b #$10
	LDA.w #DATA_02C7B4>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.b $14
	AND.w #$0008
	TAY
	BEQ.b CODE_02CD91
	LDY.b #$02
CODE_02CD91:
	LDA.w DATA_02C770,y
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_0A8D8B>>16
	LDA.w #FXCODE_0A8D8B
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $7A96,x
	BNE.b CODE_02CDB1
	LDA.w #$003B
	JSL.l CODE_0085D2
	INC.b $18,x
	RTS

CODE_02CDB1:
	CMP.w #$0028
	BNE.b CODE_02CDDB
	LDA.w #$8006
CODE_02CDB9:
	STA.w $6106
	LDA.w #$0006
	STA.w $60AC
	STZ.w $6108
	STZ.w $610A
	STZ.w $61F6
	LDA.w #$0001
	STA.w $610C
	STZ.w $60A8
	STZ.w $60AA
	STZ.w $60DE
	RTS

CODE_02CDDB:
	BCS.b CODE_02CDE1
	LSR.w $6108
	RTS

CODE_02CDE1:
	AND.w #$003F
	BNE.b CODE_02CDF3
	LDA.b $10
	AND.w #$0001
	CLC
	ADC.w #$0047
	JSL.l CODE_0085D2
CODE_02CDF3:
	RTS

CODE_02CDF4:
	TYX
	RTS

DATA_02CDF6:
	dw $0004,$0006

CODE_02CDFA:
	LDA.w $7680,x
	STA.w $6040
	LDA.w $7682,x
	STA.w $6042
	LDX.b #FXCODE_08E4BD>>16
	LDA.w #FXCODE_08E4BD
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w #$36BA
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.b $14
	LDY.w $7A96,x
	BEQ.b CODE_02CE23
	ASL
	ASL
	ASL
	LDY.b #$02
CODE_02CE23:
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LDA.w DATA_02CDF6,y
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	ASL
	ASL
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0004
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w $0041
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.b $14
	EOR.w #$FFFF
	LSR
	LSR
	LSR
	CLC
	ADC.w $003B
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDX.b #FXCODE_0A8F10>>16
	LDA.w #FXCODE_0A8F10
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	JSL.l CODE_00BE39	: db $40,$50,$7E,$72,$33,$70,$90,$06
	LDX.b #FXCODE_0A8C48>>16
	LDA.w #FXCODE_0A8C48
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$0098
	TSB.w $094A
	LDX.b $12
	JSL.l CODE_03AA52
	REP.b #$10
	LDY.w $7362,x
	LDA.l $704582
	SEC
	SBC.w #$0005
	STA.b $00
	CLC
	ADC.w $6020,y
	STA.w $6020,y
	LDA.l $704584
	STA.b $02
	CLC
	ADC.w $6022,y
	STA.w $6022,y
	LDA.w $6028,y
	CLC
	ADC.b $00
	STA.w $6028,y
	LDA.w $602A,y
	CLC
	ADC.b $02
	STA.w $602A,y
	LDX.b $12
	LDA.b $77,x
	AND.w #$00FF
	ASL
	TAX
	LDA.l DATA_00E9D4,x
	ASL
	ASL
	ASL
	ASL
	AND.w #$FF00
	BPL.b CODE_02CECA
	ORA.w #$00FF
CODE_02CECA:
	XBA
	EOR.w #$FFFF
	SEC
	ADC.b $00
	STA.b $00
	LDA.l DATA_00E954,x
	ASL
	ASL
	ASL
	ASL
	AND.w #$FF00
	BPL.b CODE_02CEE3
	ORA.w #$00FF
CODE_02CEE3:
	XBA
	CLC
	ADC.b $02
	STA.b $02
	LDX.w #$0004
CODE_02CEEC:
	LDA.w $6000,y
	CLC
	ADC.b $00
	STA.w $6000,y
	LDA.w $6002,y
	CLC
	ADC.b $02
	STA.w $6002,y
	TYA
	CLC
	ADC.w #$0008
	TAY
	DEX
	BNE.b CODE_02CEEC
	SEP.b #$10
	LDX.b $12
	LDA.b $00
	CLC
	ADC.w #$0008
	STA.w $7B56,x
	LDA.b $02
	CLC
	ADC.w #$0004
	STA.w $7B58,x
	LDA.b $76,x
	CMP.w $7A36,x
	BEQ.b CODE_02CF6D
	STA.w $7A36,x
	LDY.b #$00
	AND.w #$FF00
	BMI.b CODE_02CF33
	EOR.w #$FF00
	LDY.b #$02
CODE_02CF33:
	XBA
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	TYA
	STA.w $7400,x
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$6041
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0056
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDX.b #FXCODE_088205>>16
	LDA.w #FXCODE_088205
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
CODE_02CF6D:
	RTS

;---------------------------------------------------------------------------

DATA_02CF6E:
	dw $FFA0,$0060

CODE_02CF72:
	LDA.w $7902,x
	BNE.b CODE_02CF8F
	LDA.w $6FA0,x
	AND.w #$F9FF
	STA.w $6FA0,x
	LDA.w $6FA2,x
	AND.w #$FFE0
	STA.w $6FA2,x
	LDA.w #$0100
	STA.w $75E2,x
CODE_02CF8F:
	LDA.b $10
	AND.w #$0002
	STA.w $7400,x
	TAY
	LDA.w DATA_02CF6E,y
	STA.w $75E0,x
	RTL

;---------------------------------------------------------------------------

DATA_02CF9F:
	db $00,$01,$02,$03,$04,$03,$02

CODE_02CFA6:
	LDA.w $6F00,x
	CMP.w #$0008
	BNE.b CODE_02CFC9
	STA.w $7902,x
	LDA.w #$0400
	STA.w $75E2,x
	LDA.w $6FA0,x
	ORA.w #$0600
	STA.w $6FA0,x
	LDA.w $6FA2,x
	ORA.w #$0017
	STA.w $6FA2,x
CODE_02CFC9:
	JSL.l CODE_03AF23
	LDA.w $7902,x
	BNE.b CODE_02CFED
	INC.b $76,x
	LDA.b $76,x
	CMP.w #$0028
	BCC.b CODE_02D03C
	INC.w $7902,x
	LDA.w #$0300
	STA.w $75E2,x
	LDA.w $6FA2,x
	ORA.w #$0017
	STA.w $6FA2,x
CODE_02CFED:
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_02D02D
	LDA.w #$0400
	STA.w $75E2,x
	LDA.w $6FA0,x
	ORA.w #$0600
	STA.w $6FA0,x
	LDA.w $7220,x
	ASL
	ADC.w $7220,x
	BPL.b CODE_02D011
	EOR.w #$FFFF
	INC
CODE_02D011:
	LSR
	LSR
	ADC.b $16,x
	CMP.w #$0700
	BCC.b CODE_02D01D
	SBC.w #$0700
CODE_02D01D:
	STA.b $16,x
	XBA
	TAY
	LDA.w DATA_02CF9F,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w #$0020
CODE_02D02D:
	STA.w $7540,x
	LDA.w $75E2,x
	CMP.w #$0400
	BNE.b CODE_02D03C
	JSL.l CODE_03A5B7
CODE_02D03C:
	RTL

;---------------------------------------------------------------------------

CODE_02D03D:
	RTL

;---------------------------------------------------------------------------

CODE_02D03E:
	RTL

;---------------------------------------------------------------------------

CODE_02D03F:
	RTL

;---------------------------------------------------------------------------

CODE_02D040:
	JSL.l CODE_03AF23
	LDA.w $75E2,x
	BEQ.b CODE_02D04C
	JMP.w CODE_02D09D

CODE_02D04C:
	TXY
	JSR.w CODE_02D0D9
	LDA.b $00
	SEC
	SBC.w $70E2,x
	CLC
	ADC.w #$0008
	CMP.w #$0011
	BCS.b CODE_02D087
	LDA.b $02
	SEC
	SBC.w $7182,x
	CLC
	ADC.w #$0008
	CMP.w #$0011
	BCS.b CODE_02D087
	LDA.b $02
	STA.w $7182,x
	LDA.b $00
	STA.w $70E2,x
	LDA.w #$0006
	STA.w $74A2,x
	INC.b $78,x
	LDA.b $78,x
	CMP.w #$0010
	BCC.b CODE_02D09C
CODE_02D087:
	LDA.w #$0100
	STA.w $7222,x
	STA.w $75E2,x
	LDA.w $6FA2,x
	ORA.w #$0001
	STA.w $6FA2,x
	INC.w $7402,x
CODE_02D09C:
	RTL

CODE_02D09D:
	LDY.w $7D36,x
	BEQ.b CODE_02D0A8
	JSL.l CODE_03A858
	BRA.b CODE_02D0AE

CODE_02D0A8:
	LDA.w $7860,x
	LSR
	BCC.b CODE_02D0D8
CODE_02D0AE:
	LDA.w #$0045
	JSL.l CODE_0085D2
	LDA.w #$0221
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w #$0007
	STA.w $73C2,y
	LDA.w #$0002
	STA.w $7782,y
	JML.l CODE_03A31E

CODE_02D0D8:
	RTL

;---------------------------------------------------------------------------

CODE_02D0D9:
	REP.b #$10
	LDX.b $76,y
	LDA.l $70449E,x
	SEC
	SBC.w #$0008
	LDX.b $18,y
	CLC
	ADC.w $70E2,x
	STA.b $00
	LDA.w $79D8,y
	LSR
	LDX.b $76,y
	CLC
	ADC.l $7044A0,x
	SEC
	SBC.w #$000C
	LDX.b $18,y
	CLC
	ADC.w $7182,x
	STA.b $02
	SEP.b #$10
	LDX.b $12
	RTS

;---------------------------------------------------------------------------

DATA_02D109:
	dw $3898,$3898,$28A3,$18A7,$08AA,$F8AC,$E8AD,$D8B0
	dw $C8B2,$B8B8,$A0C8,$95E6,$A41C,$0C40,$3870,$3870

DATA_02D129:
	dw $3800,$38F8,$3898,$3898,$28A3,$18A9,$D8B0,$C8B2
	dw $B8B8,$A0C8,$95E6,$A41C,$0C40,$3870,$3870,$3808

CODE_02D149:
	JSL.l CODE_03AEEB
	LDY.b #$3C
	JSL.l CODE_0CE5D6
	LDA.w #$0010
	STA.l $7049C6
	DEC
	ASL
	TAX
CODE_02D15D:
	LDA.w DATA_02D109,x
	STA.l $7049C7,x
	DEX
	DEX
	BPL.b CODE_02D15D
	LDX.b #$3C
CODE_02D16A:
	LDA.l DATA_5FE54E,x
	STA.l $702E2E,x
	STA.l $7020C2,x
	DEX
	DEX
	BPL.b CODE_02D16A
	LDX.b $12
	STZ.w $7B56,x
	STZ.w $7B58,x
	LDA.w #$000B
	STA.w $7402,x
	RTL

;---------------------------------------------------------------------------

DATA_02D189:
	dw $FF60,$FF5C,$FF58,$FF54

DATA_02D191:
	dw $FF00,$0100

CODE_02D195:
	JSR.w CODE_02D7D6
	JSL.l CODE_03AF23
	TXY
	LDA.b $18,x
	ASL
	TAX
	JSR.w (DATA_02D2F4,x)
	TXA
	STA.w $6012
	LDA.w $60B0
	STA.w $6014
	LDA.w $60B2
	STA.w $6016
	LDA.w $60C2
	STA.w $6018
	LDX.b #FXCODE_0A8390>>16
	LDA.w #FXCODE_0A8390
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $601A
	BEQ.b CODE_02D1DF
	DEC.w $608C
	LDA.w $093A
	CLC
	ADC.w #$0100
	STA.w $093A
	LDA.w $60B4
	BMI.b CODE_02D1DF
	STZ.w $60B4
CODE_02D1DF:
	LDA.w $6014
	BEQ.b CODE_02D1F6
	LDA.w $7220
	CLC
	ADC.w #$FF80
	CMP.w #$FF00
	BPL.b CODE_02D1F3
	LDA.w #$FF00
CODE_02D1F3:
	STA.w $7220
CODE_02D1F6:
	LDA.b $18,x
	CMP.w #$0003
	BCS.b CODE_02D210
	LDY.w $7D36,x
	DEY
	BMI.b CODE_02D210
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_02D210
	LDA.w $7D38,y
	BNE.b CODE_02D213
CODE_02D210:
	JMP.w CODE_02D2F3

CODE_02D213:
	LDA.w $7A38,x
	ASL
	TAX
	LDA.w DATA_02D189,x
	LDX.b $12
	CLC
	ADC.w $70E2,x
	SEC
	SBC.w $7CD6,y
	ASL
	CLC
	ADC.w $7220,y
	STA.w $7220,y
	BPL.b CODE_02D235
	LDA.w #$0040
	STA.w $7542,y
CODE_02D235:
	LDX.b #$00
	LDA.w $7222,y
	BEQ.b CODE_02D252
	BPL.b CODE_02D240
	LDX.b #$02
CODE_02D240:
	CLC
	ADC.w DATA_02D191,x
	STA.w $7222,y
	EOR.w DATA_02D191,x
	BMI.b CODE_02D252
	LDA.w #$0000
	STA.w $7222,y
CODE_02D252:
	LDX.b $12
	LDA.w $7CD6,y
	SEC
	SBC.w $70E2,x
	CLC
	ADC.w #$0004
	STA.b $00
	LDA.l $7049CA
	AND.w #$00FF
	CLC
	ADC.w $7182,x
	SEC
	SBC.w $7CD8,y
	BPL.b CODE_02D275
	LDA.w #$0000
CODE_02D275:
	TAY
	AND.w #$00F0
	LSR
	LSR
	LSR
	TAX
	BEQ.b CODE_02D2B5
	PHX
	TYA
	AND.w #$000F
	ASL
	EOR.w #$FFFF
	SEC
	ADC.b $00
	STA.b $02
CODE_02D28D:
	LDA.l $7049C8,x
	AND.w #$FF00
	BPL.b CODE_02D299
	ORA.w #$00FF
CODE_02D299:
	XBA
	CMP.b $02
	BPL.b CODE_02D2A8
	SEP.b #$20
	LDA.b $02
	STA.l $7049C9,x
	REP.b #$20
CODE_02D2A8:
	LDA.b $02
	SEC
	SBC.w #$0020
	STA.b $02
	DEX
	DEX
	BNE.b CODE_02D28D
	PLX
CODE_02D2B5:
	INX
	INX
	TYA
	EOR.w #$000F
	INC
	AND.w #$000F
	ASL
	EOR.w #$FFFF
	SEC
	ADC.b $00
	STA.b $02
CODE_02D2C8:
	LDA.l $7049C8,x
	AND.w #$FF00
	BPL.b CODE_02D2D4
	ORA.w #$00FF
CODE_02D2D4:
	XBA
	CMP.b $02
	BPL.b CODE_02D2E3
	SEP.b #$20
	LDA.b $02
	STA.l $7049C9,x
	REP.b #$20
CODE_02D2E3:
	LDA.b $02
	SEC
	SBC.w #$0020
	STA.b $02
	INX
	INX
	CPX.b #$12
	BCC.b CODE_02D2C8
	LDX.b $12
CODE_02D2F3:
	RTL

DATA_02D2F4:
	dw CODE_02D30C
	dw CODE_02D439
	dw CODE_02D4D7
	dw CODE_02D614
	dw CODE_02D6CE

DATA_02D2FE:
	db $0B,$0C,$0D,$0C

DATA_02D302:
	db $0D,$0C,$0B,$0C,$0D

DATA_02D307:
	db $20,$04,$04,$01,$01

CODE_02D30C:
	TYX
	LDA.w $6FA2,x
	AND.w #$001F
	BNE.b CODE_02D38B
	LDA.w $60AC
	CMP.w #$0002
	BEQ.b CODE_02D35A
	LDA.w $7C16,x
	CMP.w #$0070
	BPL.b CODE_02D346
	LDA.w #$00F1
	STA.w $004D
	LDA.w #$0080
	STA.w $7A96,x
	LDA.w #$0048
	JSL.l CODE_03A34C
	BCC.b CODE_02D346
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
CODE_02D346:
	LDA.b $14
	AND.w #$0018
	LSR
	LSR
	LSR
	TAY
	LDA.w DATA_02D2FE,y
	AND.w #$00FF
	STA.w $7402,x
	PLA
	RTL

CODE_02D35A:
	LDA.w $7A96,x
	BEQ.b CODE_02D368
	LSR
	BNE.b CODE_02D346
	LDA.w #$0009
	STA.w $004D
CODE_02D368:
	LDA.b $14
	AND.w #$0003
	BNE.b CODE_02D389
	INC.w $7402,x
	LDA.w $7402,x
	CMP.w #$0010
	BCC.b CODE_02D389
	LDA.w $6FA2,x
	ORA.w #$0001
	STA.w $6FA2,x
	LDA.w #$0040
	STA.w $7542,x
CODE_02D389:
	PLA
	RTL

CODE_02D38B:
	LDA.w $7860,x
	LSR
	BCC.b CODE_02D389
	LDA.w $7542,x
	BEQ.b CODE_02D3B1
	LDA.w #$0060
	JSL.l CODE_0085D2
	STZ.w $7542,x
	LDA.w $7042,x
	ORA.w #$0080
	STA.w $7042,x
	LDA.w #$0005
	STA.b $76,x
	STZ.w $7A96,x
CODE_02D3B1:
	LDA.w $7A96,x
	BNE.b CODE_02D433
	LDA.b $76,x
	BNE.b CODE_02D41D
	LDA.w $1015
	BNE.b CODE_02D3C2
	INC.w $1015
CODE_02D3C2:
	BPL.b CODE_02D433
	STZ.w $1015
	LDA.w #$0087
	JSL.l CODE_0085D2
	INC.b $18,x
	STZ.w $7402,x
	LDA.w $7182,x
	CLC
	ADC.w #$000F
	STA.w $7902,x
	LDA.w #$FE80
	STA.w $75E0,x
	LDA.w $7042,x
	AND.w #$FF3F
	STA.w $7042,x
	LDA.w $6FA2,x
	AND.w #$FFE0
	STA.w $6FA2,x
	LDA.w $7040,x
	CLC
	ADC.w #$E000
	STA.w $7040,x
	STZ.w $7222,x
	SEP.b #$20
	STZ.w $7180,x
	REP.b #$20
	LDA.w #$0018
	STA.b $76,x
	JSR.w CODE_02D44C
	LDA.w $70E2,x
	CLC
	ADC.w #$000A
	STA.w $70E2,x
	PLA
	RTL

CODE_02D41D:
	DEC.b $76,x
	LDY.b $76,x
	LDA.w DATA_02D302,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w DATA_02D307,y
	AND.w #$00FF
	STA.w $7A96,x
CODE_02D433:
	PLA
	RTL

DATA_02D435:
	db $80,$64,$48,$2C

CODE_02D439:
	TYX
	LDA.b $76,x
	CMP.w #$0100
	BCS.b CODE_02D47A
	ADC.w #$0001
	CMP.w #$0100
	BCC.b CODE_02D44C
	LDA.w #$0100
CODE_02D44C:
	STA.b $76,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #DATA_02D109>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_02D109
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_0A8F57>>16
	LDA.w #FXCODE_0A8F57
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.l $7049C8
	AND.w #$00FF
	EOR.w #$FFFF
	SEC
	ADC.w $7902,x
	STA.w $7182,x
	RTS

CODE_02D47A:
	INC.b $18,x
	STZ.w $60AC
CODE_02D47F:
	STZ.b $78,x
	STZ.w $7540,x
	STZ.w $7220,x
	LDY.w $7A38,x
	LDA.w DATA_02D435,y
	AND.w #$00FF
	STA.w $7A96,x
	LDX.b #$1E
	LDA.w #$0000
CODE_02D498:
	STA.l $704C96,x
	DEX
	DEX
	BPL.b CODE_02D498
	LDX.b $12
	RTS

DATA_02D4A3:
	dw $0020,$0000

DATA_02D4A7:
	dw $0004,$FFFE

DATA_02D4AB:
	dw $0040,$0000

DATA_02D4AF:
	dw $0006,$000A,$000E,$0012

DATA_02D4B7:
	dw $0200,$01C0,$0180,$0140

DATA_02D4BF:
	dw $00C0,$00D0,$00E0,$00F0

DATA_02D4C7:
	dw $0060,$0068,$0070,$0078

DATA_02D4CF:
	dw $0040,$0030,$0020,$0010

CODE_02D4D7:
	TYX
	LDA.w $7A96,x
	BEQ.b CODE_02D4E9
	LSR
	BNE.b CODE_02D536
	LDA.w #$003E
	JSL.l CODE_0085D2
	BRA.b CODE_02D536

CODE_02D4E9:
	LDY.w $7900,x
	LDA.w $70E2,x
	CMP.w #$00C5
	BMI.b CODE_02D4FC
	LDA.w DATA_02D4A3,y
	STA.w $7540,x
	BNE.b CODE_02D502
CODE_02D4FC:
	STZ.w $7540,x
	STZ.w $7220,x
CODE_02D502:
	LDA.b $78,x
	CLC
	ADC.w DATA_02D4A7,y
	STA.b $78,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w DATA_02D4AB,y
	BNE.b CODE_02D51B
	TYA
	EOR.w #$0002
	STA.w $7900,x
	BEQ.b CODE_02D528
CODE_02D51B:
	LDX.b #FXCODE_0A8FE2>>16
	LDA.w #FXCODE_0A8FE2
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	BRA.b CODE_02D536

CODE_02D528:
	LDX.b #FXCODE_0A8FE2>>16
	LDA.w #FXCODE_0A8FE2
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	JSR.w CODE_02D47F
CODE_02D536:
	LDA.w $7A98,x
	BNE.b CODE_02D542
	LDA.b $14
	AND.w #$0007
	BNE.b CODE_02D54D
CODE_02D542:
	LDX.b #FXCODE_0A8FBB>>16
	LDA.w #FXCODE_0A8FBB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_02D54D:
	LDA.w $7A38,x
	ASL
	TAY
	LDA.b $16,x
	SEC
	SBC.w DATA_02D4AF,y
	BPL.b CODE_02D566
	PHY
	LDA.w #$0014
	JSL.l CODE_0085D2
	PLY
	LDA.w DATA_02D4B7,y
CODE_02D566:
	STA.b $16,x
	CMP.w DATA_02D4BF,y
	BCC.b CODE_02D570
	LDA.w DATA_02D4BF,y
CODE_02D570:
	CMP.w DATA_02D4C7,y
	BCS.b CODE_02D57A
	LDA.w DATA_02D4BF,y
	SBC.b $16,x
CODE_02D57A:
	CLC
	ADC.w DATA_02D4CF,y
	JSR.w CODE_02D69A
	LDA.w $7A98,x
	BEQ.b CODE_02D58E
	CMP.w #$0040
	BCC.b CODE_02D5ED
	JMP.w CODE_02D5EE

CODE_02D58E:
	LDY.w $7D36,x
	DEY
	BMI.b CODE_02D5ED
	LDA.w $7680,x
	CLC
	ADC.w #$0080
	CMP.w #$0201
	BCS.b CODE_02D5ED
	LDA.w $7D38,y
	BEQ.b CODE_02D5ED
	TYX
	JSL.l CODE_03B25B
	LDA.w #$0078
	JSL.l CODE_0085D2
	INC.w $7A38,x
	LDA.w $7A38,x
	CMP.w #$0004
	BCC.b CODE_02D5E7
	INC.b $18,x
	STZ.w $7540,x
	STZ.w $7220,x
	LDA.w #$0100
	STA.b $78,x
	LDA.w #$0080
	STA.w $7A96,x
	JSL.l CODE_02A982
	LDA.l $7049C6
	DEC
	ASL
	TAX
CODE_02D5DA:
	LDA.w DATA_02D109,x
	STA.l $704C76,x
	DEX
	DEX
	BPL.b CODE_02D5DA
	LDX.b $12
CODE_02D5E7:
	LDA.w #$0060
	STA.w $7A98,x
CODE_02D5ED:
	RTS

CODE_02D5EE:
	AND.w #$0004
	BEQ.b CODE_02D603
	LDX.b #$3C
	LDA.w #$7FFF
CODE_02D5F8:
	STA.l $7020C2,x
	DEX
	DEX
	BPL.b CODE_02D5F8
	LDX.b $12
	RTS

CODE_02D603:
	LDX.b #$3C
CODE_02D605:
	LDA.l $702E2E,x
	STA.l $7020C2,x
	DEX
	DEX
	BPL.b CODE_02D605
	LDX.b $12
	RTS

CODE_02D614:
	TYX
	LDA.w #$0001
	STA.w $61AE
	LDA.w $7A96,x
	BEQ.b CODE_02D640
	LSR
	BNE.b CODE_02D62A
	LDA.w #$0015
	JSL.l CODE_0085D2
CODE_02D62A:
	LDA.w $7A96,x
	JSR.w CODE_02D5EE
	LDX.b #FXCODE_0A8FBB>>16
	LDA.w #FXCODE_0A8FBB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.b $78,x
	JMP.w CODE_02D69A

CODE_02D640:
	LDA.b $78,x
	SEC
	SBC.w #$0004
	CMP.w #$0010
	BCS.b CODE_02D698
	LDA.w #$003B
	JSL.l CODE_0085D2
	INC.b $18,x
	LDA.w #$FFFF
	STA.w $7A38,x
	LDA.w $7040,x
	SEC
	SBC.w #$2000
	STA.w $7040,x
	LDA.w #$0040
	STA.w $7A96,x
	LDA.w #$01C0
	JSL.l CODE_008B21
	LDA.w $70E2,x
	CLC
	ADC.w $6000
	SEC
	SBC.w #$0008
	STA.w $70A2,y
	LDA.w $7182,x
	SEC
	SBC.w #$0008
	STA.w $7142,y
	LDA.w #$0004
	STA.w $7E4C,y
	LDA.w #$0006
	STA.w $7782,y
	LDA.w #$0010
CODE_02D698:
	STA.b $78,x
CODE_02D69A:
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w $7722,x
	TYX
	LDA.w #$0040
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STZ.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0010
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$60C1
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0056
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDX.b #FXCODE_088293>>16
	LDA.w #FXCODE_088293
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	RTS

CODE_02D6CE:
	TYX
	LDA.w $7A96,x
	BEQ.b CODE_02D709
	LDA.w $7A96,x
	LSR
	BNE.b CODE_02D708
	LDA.w #$0082
	JSL.l CODE_0085D2
	LDA.w #$1000
	STA.b $78,x
	STZ.w $75E0,x
	LDA.w #$0100
	STA.b $76,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #DATA_02D129>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_02D129
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_0A8F57>>16
	LDA.w #FXCODE_0A8F57
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_02D708:
	RTS

CODE_02D709:
	LDA.b $78,x
	BEQ.b CODE_02D756
	CMP.w #$0100
	LDA.w #$FFF8
	BCC.b CODE_02D720
	LDA.w $75E0,x
	CMP.w #$FFD0
	BMI.b CODE_02D720
	DEC.w $75E0,x
CODE_02D720:
	CLC
	ADC.b $78,x
	BPL.b CODE_02D728
	LDA.w #$0000
CODE_02D728:
	STA.b $78,x
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LSR
	LSR
	LSR
	LSR
	STA.b $76,x
	CMP.w #$0020
	BCS.b CODE_02D73E
	LDA.w #$00FF
	STA.w $74A2,x
CODE_02D73E:
	LDA.w #DATA_02D129>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_02D129
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_0A90FF>>16
	LDA.w #FXCODE_0A90FF
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	RTS

CODE_02D756:
	LDA.w $7682,x
	CMP.w #$00E0
	BPL.b CODE_02D765
	LDA.w #$0200
	STA.w $7222,x
	RTS

CODE_02D765:
	LDA.w $70E2,x
	STA.b $00
	LDA.w $7182,x
	STA.b $02
	JSL.l CODE_02E19C
	JSL.l CODE_03A32E
	STZ.w $0968
	LDA.w #$0018
	TRB.w $094A
	PLA
	RTL

;---------------------------------------------------------------------------

DATA_02D782:
	dw $0008,$0008,$0008,$0008,$0010,$0006,$0010

DATA_02D790:
	dw $0008,$000F,$000F,$0008,$001F,$001C,$0010

DATA_02D79E:
	dw $6081,$7081,$6091,$7091,$60A1,$60E1,$60C1

DATA_02D7AC:
	dw $0000,$0000,$0010,$0010,$0020,$0060,$0040

DATA_02D7BA:
	dw $0000,$0010,$0000,$0010,$0000,$0000,$0000

DATA_02D7C8:
	dw FXCODE_088619,FXCODE_088619,FXCODE_088619,FXCODE_088619,FXCODE_088293,FXCODE_088293,FXCODE_088293

CODE_02D7D6:
	LDA.b $18,x
	BNE.b CODE_02D7DD
	JMP.w CODE_02D863

CODE_02D7DD:
	LDA.w $7680,x
	STA.w $6040
	LDA.w $7682,x
	STA.w $6042
	LDX.b #FXCODE_08E4BD>>16
	LDA.w #FXCODE_08E4BD
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	JSL.l CODE_00BE39	: db $40,$50,$7E,$72,$33,$70,$48,$03
	LDA.w #$0215
	STA.w $0967
	LDY.b #$75
	STY.w $096C
	LDA.w #$0018
	TSB.w $094A
	LDX.b $12
	LDA.w $7362,x
	BPL.b CODE_02D817
	RTS

CODE_02D817:
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w $7680,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7682,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.l $7049DE
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l $7049C8
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.l $7049C8
	SEC
	SBC.l $7049CA
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $7A38,x
	STA.w $6000
	LDA.b $76,x
	STA.w $6002
	LDX.b #FXCODE_0A9039>>16
	LDA.w #FXCODE_0A9039
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $6000
	CLC
	ADC.w #$0010
	STA.w $7B56,x
CODE_02D863:
	LDA.b $76,x
	CMP.w $7A36,x
	BEQ.b CODE_02D8C7
	STA.w $7A36,x
	CMP.w #$0020
	BCS.b CODE_02D875
	LDA.w #$0020
CODE_02D875:
	STA.b $00
	LDY.b #$0C
	LDA.w $7A38,x
	BPL.b CODE_02D880
	DEY
	DEY
CODE_02D880:
	LDA.w $0030
	LSR
	BCC.b CODE_02D888
	DEY
	DEY
CODE_02D888:
	LDA.w DATA_02D782,y
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w DATA_02D790,y
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.b $00
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w DATA_02D79E,y
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0056
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w DATA_02D7BA,y
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w DATA_02D7AC,y
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDX.b #FXCODE_088619>>16
	LDA.w DATA_02D7C8,y
	PHY
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PLY
	DEY
	DEY
	DEY
	DEY
	BPL.b CODE_02D888
	INC.w $0CF9
	LDX.b $12
CODE_02D8C7:
	RTS

;---------------------------------------------------------------------------

CODE_02D8C8:
	LDA.w $70E2,x
	ORA.w #$0008
	STA.w $70E2,x
	LDA.w #$0001
	STA.w $7BB6,x
	STA.w $7BB8,x
	STZ.w $7B58,x
	RTL

;---------------------------------------------------------------------------

CODE_02D8DE:
	LDY.b #$02
	JSL.l CODE_02D985
	BCS.b CODE_02D8E7
	RTL

CODE_02D8E7:
	JSL.l CODE_03AF23
	JSR.w CODE_02D908
	BCC.b CODE_02D907
	LDA.w $0036
	AND.w #$0004
	BEQ.b CODE_02D907
	LDA.w #$0006
	STA.w $61B0
	JSR.w CODE_02CDB9
	LDA.w $608C
	STA.w $610E
CODE_02D907:
	RTL

CODE_02D908:
	LDY.w $7D36,x
	BPL.b CODE_02D91C
	LDA.w $61B2
	BPL.b CODE_02D91C
	LDA.w $60C0
	ORA.w $6150
	BNE.b CODE_02D91C
	SEC
	RTS

CODE_02D91C:
	CLC
	RTS

;---------------------------------------------------------------------------

DATA_02D91E:
	dw $0008,$FFF8

CODE_02D922:
	INC.b $18,x
	INC.b $18,x
CODE_02D926:
	LDY.b $18,x
	LDA.w $70E2,x
	CLC
	ADC.w DATA_02D91E,y
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7182,x
	SEC
	SBC.w #$0008
	STA.w $7182,x
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDX.b $12
	LDA.b $18,x
	LDY.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	BEQ.b CODE_02D954
	EOR.w #$0002
CODE_02D954:
	STA.w $7400,x
	RTL

;---------------------------------------------------------------------------

DATA_02D958:
	dw $0001,$0002

CODE_02D95C:
	JSL.l CODE_03AF23
	JSR.w CODE_02D908
	BCC.b CODE_02D984
	LDA.w $77C2,x
	AND.w #$00FF
	CMP.w $7400,x
	BNE.b CODE_02D984
	TAY
	LDA.w $0036
	AND.w DATA_02D958,y
	BEQ.b CODE_02D984
	TYA
	CLC
	ADC.w #$8002
	STA.w $61B0
	JSR.w CODE_02CDB9
CODE_02D984:
	RTL

;---------------------------------------------------------------------------

CODE_02D985:
	LDA.w $7E08
	AND.w #$0008
	BEQ.b CODE_02D9B6
	LDA.w $0030
	AND.w #$0018
	BEQ.b CODE_02D9B4
CODE_02D995:
	TYA
	PHA
	LDA.w #$0224
	JSL.l CODE_008B21
	PLA
	STA.w $73C2,y
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w #$0001
	STA.w $7782,y
CODE_02D9B4:
	SEC
	RTL

CODE_02D9B6:
	CLC
	RTL

;---------------------------------------------------------------------------

CODE_02D9B8:
	LDA.w $61B2
	BPL.b CODE_02D9C3
	JSL.l CODE_03AD74
	BCS.b CODE_02D9C6
CODE_02D9C3:
	JMP.w CODE_02AC7B

CODE_02D9C6:
	JSL.l CODE_04F74A
	LDA.w #$001A
	STA.w $60AC
	STZ.w $61AE
	STZ.w $60C4
	LDA.w $608C
	STA.w $70E2,x
	LDA.w $6090
	SEC
	SBC.w #$0028
	STA.w $7182,x
	LDA.w #$0002
	STA.w $74A2,x
	LDA.w #$0020
	STA.b $76,x
	JSR.w CODE_02DB37
	JSL.l CODE_02A4F4
	LDA.w $0039
	STA.w $0C23
	LDA.w $003B
	STA.w $0C27
	LDA.w #$0001
	STA.w $0C1E
	STA.w $0C20
	RTL

;---------------------------------------------------------------------------

CODE_02DA0E:
	JSL.l CODE_03AA52
	TXY
	LDA.b $18,x
	ASL
	TAX
	JSR.w (DATA_02DA1B,x)
	RTL

DATA_02DA1B:
	dw CODE_02DAC9
	dw CODE_02DB02
	dw CODE_02DB7E
	dw CODE_02DDAD
	dw CODE_02DEDD

DATA_02DA25:
	dw $0004,$0004,$0004,$0024,$0014,$0014,$0004,$0005
	dw $00C0,$0020,$0040,$0004,$0034,$0004,$0004,$0004
	dw $0001

DATA_02DA47:
	dw $0125,$0126,$0127,$0128,$0129,$012A,$012B,$012C
	dw $012C,$012C,$012C,$012D,$012E,$012F,$0130,$0000
	dw $0000

DATA_02DA69:
	dw $002B,$002C,$002D,$002E,$002F,$0030,$0031,$0031
	dw $0031,$0031,$0031,$0032,$0032,$0033,$0034,$000D
	dw $000D

CODE_02DA8B:
	JSL.l CODE_06C9D7
	LDA.w $7A98,x
	BNE.b CODE_02DAB9
	LDA.b $78,x
	INC.b $78,x
	ASL
	TAY
	CPY.b #$18
	BNE.b CODE_02DAA7
	PHY
	LDA.w #$0043
	JSL.l CODE_0085D2
	PLY
CODE_02DAA7:
	LDA.w DATA_02DA25,y
	STA.w $7A98,x
	LDA.w DATA_02DA47,y
	STA.w $60BE
	LDA.w DATA_02DA69,y
	STA.w $7402
CODE_02DAB9:
	RTS

CODE_02DABA:
	LDA.b $14
	AND.w #$0007
	BNE.b CODE_02DAC8
	LDA.w #$1010
	JSL.l CODE_029BD9
CODE_02DAC8:
	RTL

CODE_02DAC9:
	TYX
	LDY.w $0146
	CPY.b #$09
	BNE.b CODE_02DADF
	LDA.w $0C27
	CMP.w #$0080
	BMI.b CODE_02DADF
	DEC.w $0C27
	DEC.w $60A0
CODE_02DADF:
	LDY.b $78,x
	CPY.b #$04
	BCS.b CODE_02DAE8
	JSR.w CODE_02DA8B
CODE_02DAE8:
	LDA.b $76,x
	CLC
	ADC.w #$0002
	CMP.w #$0100
	BCC.b CODE_02DAFE
	INC.b $18,x
	LDA.w #$0001
	STA.w $7542,x
	LDA.w #$0100
CODE_02DAFE:
	STA.b $76,x
	BRA.b CODE_02DB37

CODE_02DB02:
	TYX
	JSL.l CODE_02DABA
	LDY.b $78,x
	CPY.b #$05
	BCS.b CODE_02DB10
	JSR.w CODE_02DA8B
CODE_02DB10:
	LDA.w $7C18,x
	SEC
	SBC.w #$FFE4
	BMI.b CODE_02DB37
	INC.b $18,x
	EOR.w #$FFFF
	SEC
	ADC.w $7182,x
	STA.w $7182,x
	STZ.w $7222,x
	STZ.w $7542,x
	LDA.w #$0100
	STA.w $7A36,x
	LDA.w #$00E0
	STA.w $7A38,x
CODE_02DB37:
	LDA.b $14
	ASL
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.b $76,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$C0E0
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDX.b #FXCODE_088205>>16
	LDA.w #FXCODE_088205
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	RTS

DATA_02DB72:
	dw $0010

DATA_02DB74:
	dw $FFF0,$0010

DATA_02DB78:
	dw $0120

DATA_02DB7A:
	dw $FFE0,$00F0

CODE_02DB7E:
	TYX
	JSL.l CODE_02DABA
	JSR.w CODE_02DA8B
	LDY.b $78,x
	CPY.b #$08
	BNE.b CODE_02DB92
	DEC.w $70E2,x
	DEC.w $7182,x
CODE_02DB92:
	LDY.b $78,x
	CPY.b #$0A
	BCC.b CODE_02DC03
	INC.b $18,x
	LDA.w #$0006
	STA.w $004D
	LDA.w #$00FF
	STA.w $74A2,x
	STZ.b $76,x
	LDY.b #$02
	STY.w $011C
	STZ.w $0148
	STZ.w $014A
	LDY.b #$0F
	STY.w $014C
	STZ.w $0146
	LDA.w #$1014
	STA.w $0967
	LDY.b #$69
	STY.w $095E
	LDY.b #$02
	STY.w $0963
	LDY.b #$34
	STY.w $0961
	STZ.w $0948
	LDA.w #$0064
	JSL.l CODE_0085D2
	JSL.l CODE_02A4F4
	REP.b #$10
	LDA.w #$00B0
	JSL.l CODE_00B753
	SEP.b #$10
	LDA.w #$B400
	STA.w $0CF9
	LDX.b #$24
CODE_02DBF1:
	LDA.l DATA_5FFA5E,x
	STA.l $702002,x
	STA.l $702D6E,x
	DEX
	DEX
	BPL.b CODE_02DBF1
	LDX.b $12
CODE_02DC03:
	LDA.w $7902,x
	BEQ.b CODE_02DC0B
	JMP.w CODE_02DCDE

CODE_02DC0B:
	LDA.w $7900,x
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	TAY
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7A38,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7A36,x
	SEC
	SBC.w DATA_02DB78,y
	EOR.w DATA_02DB72,y
	STA.b $00
	BMI.b CODE_02DC3B
	LDA.w $7A38,x
	SEC
	SBC.w #$002C
	STA.w $7A38,x
	TYA
	EOR.w #$0002
	TAY
CODE_02DC3B:
	LDA.w $7A38,x
	SEC
	SBC.w DATA_02DB7A,y
	EOR.w DATA_02DB74,y
	STA.b $02
	BMI.b CODE_02DC58
	LDA.w $7A36,x
	SEC
	SBC.w #$002C
	STA.w $7A36,x
	TYA
	EOR.w #$0002
	TAY
CODE_02DC58:
	TYA
	STA.w $7900,x
	LDA.w $7A36,x
	CLC
	ADC.w DATA_02DB72,y
	STA.w $7A36,x
CODE_02DC64:
	LDA.w $7A38,x
	CLC
	ADC.w DATA_02DB74,y
	STA.w $7A38,x
	LDA.b $00
	EOR.b $02
	BMI.b CODE_02DC7D
	LDA.b $00
	BMI.b CODE_02DC7D
	INC.w $7902,x
CODE_02DC7D:
	LDX.b #FXCODE_09A82C>>16
	LDA.w #FXCODE_09A82C
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	JSL.l CODE_00BE39	: db $D0,$56,$7E,$02,$3A,$70,$48,$03
	LDA.w #$AAAA
	STA.w $0964
	LDA.w $0967
	STA.w $0969
	STZ.w $094C
	LDY.b #$A0
	STY.w $0966
	LDY.b #$22
	STY.w $096B
	LDA.w #$0020
	TSB.w $094A
	LDA.l $702000
	BEQ.b CODE_02DCC6
	STA.w $0948
	LDA.w #$0000
	STA.l $702000
	LDX.b #$20
	STX.w $096C
CODE_02DCC6:
	LDX.b $12
	LDA.w $7902,x
	BEQ.b CODE_02DD4B
	REP.b #$10
	LDA.w #$0056
	JSL.l CODE_00B753
	SEP.b #$10
	LDA.w #$A800
	STA.w $0CF9
CODE_02DCDE:
	LDA.w $608C
	SEC
	SBC.w #$0078
	STA.b $00
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $6090
	SEC
	SBC.w #$0080
	STA.b $02
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $0C23
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $0C27
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0200
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_09907C>>16
	LDA.w #FXCODE_09907C
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w $0C2A
	LDA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	STA.w $0C2C
	REP.b #$10
	JSL.l CODE_03D9C6
	SEP.b #$10
	LDA.b $00
	SEC
	SBC.w $0C23
	BEQ.b CODE_02DD37
	EOR.w $0C2A
	BPL.b CODE_02DD37
	LDA.b $00
	STA.w $0C23
CODE_02DD37:
	LDA.b $02
	SEC
	SBC.w $0C27
	BEQ.b CODE_02DD49
	EOR.w $0C2C
	BPL.b CODE_02DD49
	LDA.b $02
	STA.w $0C27
CODE_02DD49:
	LDX.b $12
CODE_02DD4B:
	RTS

DATA_02DD4C:
	db $60,$06,$0A,$0D,$0F,$11,$12,$13,$15,$16,$17,$18,$19,$19,$1A,$1B
	db $1C,$1C,$1D,$1D,$1E,$1E,$1E,$1F,$1F,$1F,$1F,$20,$20,$20,$20,$20
	db $20,$20,$20,$20,$20,$20,$20,$1F,$1F,$1F,$1F,$1E,$1E,$1E,$1D,$1D
	db $1C,$1C,$1B,$1A,$19,$19,$18,$17,$16,$15,$13,$12,$11,$11,$11,$11
	db $12,$12,$12,$13,$13,$13,$14,$14,$14,$15,$15,$15,$16,$16,$16,$17
	db $17,$17,$18,$18,$18,$19,$19,$19,$1A,$1A,$1A,$1B,$1B,$1B,$1C,$1C
	db $1C

CODE_02DDAD:
	TYX
	JSR.w CODE_02DA8B
	LDY.b $78,x
	CPY.b #$0B
	BCS.b CODE_02DDB8
	RTS

CODE_02DDB8:
	LDA.b $76,x
	BNE.b CODE_02DDC5
	LDA.w #$0027
	JSL.l CODE_0085D2
	LDA.b $76,x
CODE_02DDC5:
	CMP.w #$0100
	BCC.b CODE_02DDDF
	LDY.b $78,x
	CPY.b #$10
	BCC.b CODE_02DDE4
	INC.b $18,x
	LDA.w #$0022
	STA.w $60AC
	STZ.w $60C0
	STZ.w $60C6
	RTS

CODE_02DDDF:
	ADC.w #$0010
	STA.b $76,x
CODE_02DDE4:
	LDA.w #$0030
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.b $76,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$FFD8
	CLC
	ADC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.w $60A0
	STA.w $0043
	STZ.w $6098
	STZ.w $0041
	LDA.w #$0260
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	AND.w #$FFF0
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PHB
	LDY.b #$702002>>16
	PHY
	PLB
	REP.b #$10
	LDA.l !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	TAX
	LDY.w #$0000
CODE_02DE32:
	LDA.l DATA_5FFA5E,x
	STA.w $702002,y
	STA.w $702D6E,y
	INX
	INX
	INY
	INY
	CPY.w #$0026
	BCC.b CODE_02DE32
	SEP.b #$10
	PLB
	LDA.w #DATA_02DD4C>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_02DD4C
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	STZ.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LDA.w #$005F
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$0080
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$0096
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_08F05F>>16
	LDA.w #FXCODE_08F05F
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	JSL.l CODE_00BE39	: db $D0,$56,$7E,$02,$3A,$70,$48,$03
	LDA.w #$FFFF
	STA.w $0964
	LDA.w $0967
	STA.w $0969
	LDA.w #$0155
	STA.w $094C
	LDA.w #$0000
	STA.l $702000
	LDA.w #$7FFF
	STA.w $0948
	LDY.b #$A0
	LDA.w $60B0
	CMP.w #$0079
	BMI.b CODE_02DEA9
	LDY.b #$A8
CODE_02DEA9:
	STY.w $0966
	LDY.b #$22
	STY.w $096B
	LDY.b #$34
	STY.w $096C
	LDA.w #$0020
	STA.w $094A
	LDX.b $12
	RTS

DATA_02DEBF:
	dw $7FFF,$7FFF,$7FFF,$7FFF,$7FFF,$7FFF,$7FFF,$7FFF
	dw $7FFF,$7FFF,$7FFF,$7FFF,$7FFF,$7FFF,$7FFF

CODE_02DEDD:
	LDA.w $60B0
	SEC
	SBC.w #$0078
	BPL.b CODE_02DEE9
	LDA.w #$0000
CODE_02DEE9:
	ASL
	ASL
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$00D1
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$000F
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #DATA_02DEBF
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDA.w #DATA_02DEBF>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_08E167>>16
	LDA.w #FXCODE_08E167
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $60B2
	CMP.w #$0088
	BMI.b CODE_02DF52
	LDA.b $76,x
	CMP.w #$0100
	BNE.b CODE_02DF29
	LDA.w #$0050
	JSL.l CODE_0085D2
	LDA.b $76,x
CODE_02DF29:
	SEC
	SBC.w #$0010
	STA.b $76,x
	BNE.b CODE_02DF52
	LDX.b #FXCODE_08B3D9>>16
	LDA.w #FXCODE_08B3D9
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w #$0031
	STA.w $0118
	LDA.w #$0004
	STA.w $0967
	STA.w $0969
	STZ.w $0948
	JSL.l CODE_03A31E
CODE_02DF52:
	JMP.w CODE_02DDE4

;---------------------------------------------------------------------------

CODE_02DF55:
	LDA.w #$0002
	STA.b $16,x
CODE_02DF5A:
	LDA.w #$0074
	JSL.l CODE_0085D2
	LDA.w #$0800
	STA.w $7A38,x
	RTL

;---------------------------------------------------------------------------

DATA_02DF68:
	dw $0000,$7F00,$23EC,$22DF

DATA_02DF70:
	dw $0002,$0004,$0004,$0004,$0004

CODE_02DF7A:
	LDA.w $7402
	CMP.w #$0032
	BNE.b CODE_02DF86
	JSL.l CODE_06C9D7
CODE_02DF86:
	LDA.w $7976,x
	BPL.b CODE_02DF8E
	JMP.w CODE_02E04E

CODE_02DF8E:
	LDA.w #$0017
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$A48C
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w $7680,x
	BPL.b CODE_02DFA2
	LDA.w #$0000
CODE_02DFA2:
	CMP.w #$0100
	BCC.b CODE_02DFAA
	LDA.w #$00FF
CODE_02DFAA:
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	CLC
	ADC.w $0039
	STA.w $70E2,x
	LDA.w $7682,x
	BPL.b CODE_02DFBC
	LDA.w #$0000
CODE_02DFBC:
	CMP.w #$00D2
	BCC.b CODE_02DFC4
	LDA.w #$00D1
CODE_02DFC4:
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	CLC
	ADC.w $003B
	STA.w $7182,x
	LDA.b $19,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08B2B6>>16
	LDA.w #FXCODE_08B2B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	JSL.l CODE_00BE39	: db $D0,$56,$7E,$02,$3A,$70,$48,$03
	LDX.b $12
	LDA.b $76,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.b $78,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7900,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_08E132>>16
	LDA.w #FXCODE_08E132
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.l $702000
	BNE.b CODE_02E02A
	LDY.w $0968
	BEQ.b CODE_02E02A
	SEP.b #$20
	LDA.w $0967
	ORA.w $0968
	STA.w $0967
	STZ.w $0968
	REP.b #$20
	LDA.w $0948
	STA.l $702000
CODE_02E02A:
	LDA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STA.w $0948
	LDA.w $0967
	STA.w $0969
	STZ.w $0964
	LDY.b #$20
	STY.w $0966
	LDY.b #$10
	STY.w $096B
	LDY.b #$37
	STY.w $096C
	LDA.w #$0020
	TSB.w $094A
CODE_02E04E:
	JSL.l CODE_03AF23
	LDA.w $7A96,x
	CMP.w #$0140
	BNE.b CODE_02E06C
	LDA.w #$0005
	STA.l $00004D
	LDA.w $7900,x
	BEQ.b CODE_02E08D
	JSL.l CODE_02E195
	BRA.b CODE_02E08D

CODE_02E06C:
	CMP.w #$00C0
	BNE.b CODE_02E08D
	LDA.w $7900,x
	BNE.b CODE_02E08D
	LDA.w #$0043
	JSL.l CODE_0085D2
	JSL.l CODE_04F74A
	LDA.w #$012E
	STA.w $60BE
	LDA.w #$0032
	STA.w $7402
CODE_02E08D:
	LDA.w $7976,x
	BPL.b CODE_02E0C8
	LDA.w $7A96,x
	BMI.b CODE_02E0C4
	BEQ.b CODE_02E09A
	RTL

CODE_02E09A:
	LDA.w $7900,x
	BNE.b CODE_02E0C4
	LDA.w #$0006
	STA.l $00004D
	LDA.w #$0031
	STA.w $0118
	STZ.w $0969
	LDY.b #$00
	STY.w $0966
	LDY.b #$22
	STY.w $096B
	LDY.b #$20
	STY.w $096C
	LDA.w #$0020
	TRB.w $094A
CODE_02E0C4:
	JML.l CODE_03A31E

CODE_02E0C8:
	LDA.w $7A38,x
	SEC
	SBC.w #$0040
	CMP.w #$0100
	BCS.b CODE_02E0D7
	LDA.w #$0100
CODE_02E0D7:
	STA.w $7A38,x
	CLC
	ADC.b $18,x
	STA.b $18,x
	LDA.b $76,x
	CMP.w #$0100
	BCC.b CODE_02E114
	LDA.b $16,x
	BNE.b CODE_02E0ED
	DEC.b $16,x
	RTL

CODE_02E0ED:
	DEC.b $16,x
	DEC.b $16,x
	BNE.b CODE_02E0FE
	LDY.w $61CE
	BEQ.b CODE_02E0FE
	LDA.w #$7FFF
	STA.w $7900,x
CODE_02E0FE:
	STZ.b $18,x
	STZ.b $76,x
	LDA.w $7A36,x
	LDY.w $61CE
	BEQ.b CODE_02E10F
	LDY.b $16,x
	LDA.w DATA_02DF68,y
CODE_02E10F:
	STA.b $78,x
	JMP.w CODE_02DF5A

CODE_02E114:
	LDY.b $16,x
	CLC
	ADC.w DATA_02DF70,y
	CMP.w #$0100
	BCC.b CODE_02E122
	LDA.w #$0100
CODE_02E122:
	STA.b $76,x
	CPY.b #$00
	BEQ.b CODE_02E12D
	CMP.w #$00C0
	BCS.b CODE_02E190
CODE_02E12D:
	LDA.b $14
	AND.w #$0001
	BNE.b CODE_02E190
	LDA.b $10
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.b $19,x
	AND.w #$00FF
	LSR
	NOP #2
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0500
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDX.b #FXCODE_0A91E0>>16
	LDA.w #FXCODE_0A91E0
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w #$01DD
	JSL.l CODE_008B21
	LDA.w $70E2,x
	SEC
	SBC.w #$0008
	CLC
	ADC.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w $70A2,y
	LDA.w $7182,x
	SEC
	SBC.w #$0008
	CLC
	ADC.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	STA.w $7142,y
	LDA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STA.w $71E0,y
	LDA.w !REGISTER_SuperFX_R4_LMULTResultLo
	STA.w $71E2,y
	LDA.w #$0004
	STA.w $7E4C,y
	LDA.w #$0006
	STA.w $7782,y
CODE_02E190:
	RTL

;---------------------------------------------------------------------------

CODE_02E191:
	JSL.l CODE_03A32E
CODE_02E195:
	LDA.w #$0014
	JML.l CODE_03A34C

;---------------------------------------------------------------------------

CODE_02E19C:
	LDA.w #$0200
	LDX.b #$00
	BRA.b CODE_02E1A8

CODE_02E1A3:
	LDA.w #$0200
CODE_02E1A6:
	LDX.b #$01
CODE_02E1A8:
	PHA
	LDA.w #$0013
	JSL.l CODE_03A34C
	PLA
	BCC.b CODE_02E1DF
	STA.w $7A96,y
	LDA.b $00
	CLC
	ADC.w #$0008
	STA.w $70E2,y
	LDA.b $02
	CLC
	ADC.w #$0008
	STA.w $7182,y
	TXA
	STA.w $7900,y
	ORA.w $0218
	ASL
	TAX
	LDA.l DATA_0CDACA,x
	STA.w $79D8,y
	LDA.l DATA_0CDAE2,x
	STA.w $7A36,y
CODE_02E1DF:
	LDX.b $12
CODE_02E1E1:
	LDA.w #$0001
	STA.w $61AE
	JML.l CODE_028922

;---------------------------------------------------------------------------

CODE_02E1EB:
	JSL.l CODE_03AE60
	STZ.w $7400,x
	SEP.b #$20
	LDA.b #$FF
	STA.w $7863,x
	REP.b #$20
	RTL

;---------------------------------------------------------------------------

DATA_02E1FC:
	dw $0002,$FFFE,$01E0,$01E0,$01E0,$01E0,$01E0,$01E0
	dw $01E0,$01E0,$01E0,$01E0,$01E4,$01E8,$01EC,$01F0
	dw $01F4,$01F8,$01FC,$01FE,$0000,$0000,$0000,$0000
	dw $0002,$0004,$0008,$000C,$0010,$0014,$0018,$001C
	dw $0020,$0020,$0020,$0020,$0020,$0020,$0020,$0020
	dw $0020,$0020

DATA_02E250:
	dw $0004,$0000,$0006,$FFFF

DATA_02E258:
	dw $0080,$0030,$0018,$0010,$000C,$0008,$0008,$0008
	dw $0008

CODE_02E26A:
	JSL.l CODE_03AA52
	JSL.l CODE_03AF23
	REP.b #$10
	LDA.w $7902,x
	TAX
	LDA.l $70000C,x
	AND.w #$0008
	STA.b $04
	LDA.l $700014,x
	AND.w #$0008
	STA.b $08
	SEP.b #$10
	LDX.b $12
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_02E299
	JMP.w CODE_02E2D1

CODE_02E299:
	LDA.w $7862,x
	AND.w #$00FF
	STA.b $06
	BNE.b CODE_02E2A6
	JMP.w CODE_02E3BE

CODE_02E2A6:
	LDA.w $7AF6,x
	BNE.b CODE_02E2D1
	LDY.b #$0E
	LDA.w $7222,x
	CMP.w #$00E0
	BPL.b CODE_02E2CB
	LDA.w $7220,x
	BPL.b CODE_02E2BE
	EOR.w #$FFFF
	INC
CODE_02E2BE:
	CMP.w #$0040
	BCC.b CODE_02E2D1
	ASL
	ASL
	ASL
	XBA
	AND.w #$000E
	TAY
CODE_02E2CB:
	LDA.w DATA_02E258,y
	STA.w $7AF6,x
CODE_02E2D1:
	LDA.w $7222,x
	SEC
	SBC.w #$0020
	CMP.w #$FF80
	BPL.b CODE_02E2E0
	LDA.w #$FF80
CODE_02E2E0:
	STA.w $7222,x
	REP.b #$10
	LDA.w $7902,x
	TAX
	LDA.l $700002,x
	SEC
	SBC.l $700012,x
	STA.b $02
	LDA.l $700002,x
	SEC
	SBC.l $70000A,x
	PHP
	BPL.b CODE_02E304
	EOR.w #$FFFF
	INC
CODE_02E304:
	ASL
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.l FXDATA_0BB810,x
	PLP
	BPL.b CODE_02E315
	EOR.w #$FFFF
	INC
CODE_02E315:
	STA.b $00
	LDA.b $02
	PHP
	BPL.b CODE_02E320
	EOR.w #$FFFF
	INC
CODE_02E320:
	ASL
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.l FXDATA_0BB810,x
	PLP
	BMI.b CODE_02E331
	EOR.w #$FFFF
	INC
CODE_02E331:
	CLC
	ADC.b $00
	LSR
	AND.w #$01FE
	STA.b $00
	LDX.b $12
	LDY.b $78,x
	BEQ.b CODE_02E34E
	TYA
	CLC
	ADC.w #$0008
	CMP.w #$0010
	BCS.b CODE_02E34D
	LDY.w #$0000
CODE_02E34D:
	TYA
CODE_02E34E:
	SEP.b #$10
	STA.b $02
	SEC
	SBC.w $7A36,x
	LDY.b #$00
	AND.w #$0100
	BEQ.b CODE_02E35F
	LDY.b #$02
CODE_02E35F:
	LDA.w $7A36,x
	CLC
	ADC.w DATA_02E1FC,y
	AND.w #$01FE
	STA.w $7A36,x
	SEC
	SBC.b $02
	EOR.w DATA_02E1FC,y
	BMI.b CODE_02E379
	LDA.b $02
	STA.w $7A36,x
CODE_02E379:
	LDA.b $78,x
	BEQ.b CODE_02E39F
	CLC
	ADC.w #$0030
	LSR
	LSR
	LSR
	LSR
	AND.w #$0006
	TAY
	LDA.w $7964,y
	BEQ.b CODE_02E394
	LDY.b #$00
	LDA.b $02
	BRA.b CODE_02E398

CODE_02E394:
	LDA.b $00
	ASL
	ASL
CODE_02E398:
	SEC
	SBC.w #$0010
	AND.w #$01FE
CODE_02E39F:
	LDY.b #$04
	REP.b #$10
	TAX
	LDA.l DATA_00E9D4,x
	ASL
	SEP.b #$10
	LDX.b $12
	CMP.w $7220,x
	BPL.b CODE_02E3B4
	INY
	INY
CODE_02E3B4:
	LDA.w $7220,x
	CLC
	ADC.w DATA_02E250,y
	STA.w $7220,x
CODE_02E3BE:
	LDY.b $78,x
	BEQ.b CODE_02E3D8
	LDA.w $72C0,x
	CLC
	ADC.w $608C
	STA.w $608C
	LDA.w $7C16,x
	SEC
	SBC.w $72C0,x
	STA.w $7C16,x
	STZ.b $78,x
CODE_02E3D8:
	LDA.w $60AA
	BMI.b CODE_02E440
	LDA.w $7C16,x
	CLC
	ADC.w #$0014
	CMP.w #$0028
	BCS.b CODE_02E440
	TXY
	REP.b #$10
	LDX.w $7A36,y
	LDA.l FXDATA_0BBA12,x
	SEP.b #$20
	STA.w !REGISTER_Mode7MatrixParameterA
	XBA
	STA.w !REGISTER_Mode7MatrixParameterA
	TYX
	LDA.w $7C16,x
	STA.w !REGISTER_Mode7MatrixParameterB
	REP.b #$20
	SEP.b #$10
	LDA.w !REGISTER_PPUMultiplicationProductMid
	CLC
	ADC.w $7182,x
	SEC
	SBC.w $6090
	SEC
	SBC.w #$0020
	CMP.w #$FFF8
	BCC.b CODE_02E440
	INC
	ADC.w $6090
	STA.w $6090
	LDA.w #$0100
	STA.w $60AA
	INC.w $61B4
	STZ.w $60FA
	LDA.w #$0010
	STA.w $0CCA
	LDA.w $7C16,x
	BNE.b CODE_02E43A
	INC
CODE_02E43A:
	ASL
	AND.w #$01FE
	STA.b $78,x
CODE_02E440:
	LDA.w $7722,x
	LSR
	LSR
	LSR
	SEC
	SBC.w $0030
	AND.w #$0003
	BEQ.b CODE_02E452
	JMP.w CODE_02E48D

CODE_02E452:
	LDA.w $7A36,x
	LSR
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$4060
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	SEP.b #$10
	LDX.b #FXCODE_088205>>16
	LDA.w #FXCODE_088205
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
CODE_02E48D:
	RTL

;---------------------------------------------------------------------------

CODE_02E48E:
	TYX
	RTS

;---------------------------------------------------------------------------

DATA_02E490:
	dw $FFE0,$0020

CODE_02E494:
	STX.w $1072
	INC.b $18,x
	LDA.w #$01FF
	STA.w $7A36,x
	STA.w $7900,x
	LDA.w #$001C
	STA.w $1068
	LDA.w #$0006
	STA.b $78,x
	DEC.w $106E
	LDY.b #$01
	STY.b $76,x
	LDA.w #$0003
	STA.w $1082
	LDA.w #$0388
	STA.w $70E2,x
	LDA.w $7182,x
	STA.w $1074
	CLC
	ADC.w #$0060
	STA.w $7182,x
	LDA.w #$0070
	STA.w $7A38,x
	LDA.w #$FFC0
	STA.w $1070
	LDA.w #$0066
	TXY
	JSL.l CODE_03A366
	LDA.w #$0388
	STA.w $70E2,y
	LDA.w #$0780
	STA.w $7182,y
	LDA.w #$BC00
	STA.w $6FA0,y
	LDA.w $6FA2,y
	ORA.w #$2000
	STA.w $6FA2,y
	LDA.w #$2C01
	STA.w $7040,y
	LDA.w #$0001
	STA.w $7402,y
	SEP.b #$20
	LDA.b #$2C
	STA.w $7042,y
	STY.w $108A
	STZ.w $0136
	LDA.b #$08
	STA.w $79D6,y
	LDA.b #$FF
	STA.w $7863,y
	REP.b #$20
	STZ.w $105A
	LDX.b #$1E
CODE_02E526:
	LDA.l $702E8C,x
	STA.l $7021C0,x
	DEX
	DEX
	BPL.b CODE_02E526
	RTL

DATA_02E533:
	dw CODE_02E905,CODE_02EA2C,CODE_02EB2D,CODE_02EB54,CODE_02EC46,CODE_02EE2C,CODE_02EB54,CODE_02EC41
	dw CODE_02ECAB,CODE_02ECD3,CODE_02ED71,CODE_02EB54,CODE_02ED84,CODE_02EE7A,CODE_02EF86,CODE_02EDB5
	dw CODE_02EDE1,CODE_02EB54,CODE_02EC46,CODE_02EE2C,CODE_02EB54,CODE_02EE7A,CODE_02EF86,CODE_02F02D
	dw CODE_02F074,CODE_02EB54,CODE_02F09C,CODE_02F10E,CODE_02EC46,CODE_02EE2C,CODE_02F156,CODE_02EE7A
	dw CODE_02EC46,CODE_02EE2C,CODE_02F1DF,CODE_02F205,CODE_02F273,CODE_02F310

CODE_02E57F:
	JSR.w CODE_02E5E4
	JSL.l CODE_03AF23
	LDY.b $18,x
	BMI.b CODE_02E5AB
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_02E533,x)
	LDY.w $74A2,x
	BMI.b CODE_02E5C1
	LDY.w $1084
	BNE.b CODE_02E5C1
	JSR.w CODE_02E68E
	LDY.b $76,x
	CPY.b #$20
	BPL.b CODE_02E5AB
	JSR.w CODE_02E761
	JSR.w CODE_02E8A5
CODE_02E5AB:
	JSR.w CODE_02E6C3
	LDA.w $7AF8,x
	BEQ.b CODE_02E5C1
	AND.w #$0003
	BNE.b CODE_02E5C1
	LDA.w $7042,x
	EOR.w #$0002
	STA.w $7042,x
CODE_02E5C1:
	LDA.w $7220,x
	BPL.b CODE_02E5CA
	EOR.w #$FFFF
	INC
CODE_02E5CA:
	CLC
	ADC.w $1088
	CMP.w #$2000
	BMI.b CODE_02E5E0
	SEC
	SBC.w #$2000
	PHA
	LDA.w #$005F
	JSL.l CODE_0085D2
	PLA
CODE_02E5E0:
	STA.w $1088
	RTL

CODE_02E5E4:
	LDY.w $74A2,x
	BMI.b CODE_02E65D
	JSL.l CODE_03AB1C
	LDA.w $1068
	STA.w $6000
	LDA.w $7A38,x
	STA.w $6002
	LDA.w $106A
	STA.w $6004
	LDA.w $106C
	STA.w $6006
	LDA.w $1070
	STA.w $6008
	LDA.w $7A36,x
	LSR
	STA.w $600A
	LDA.w $7900,x
	LSR
	STA.w $600C
	LDA.w $1084
	STA.w $601E
	LDA.w $7680,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7682,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7400,x
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	TXA
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #DATA_02FC39>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDY.b $78,x
	TYA
	ASL
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w #DATA_02FC39
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDX.b #FXCODE_08A062>>16
	LDA.w #FXCODE_08A062
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.b $0C
	LDA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	STA.b $0E
CODE_02E65D:
	RTS

DATA_02E65E:
	dw $0009,$0008,$0007,$0008,$000C,$000C,$0010,$000F
	dw $000E,$0010,$000F,$000E

DATA_02E676:
	dw $FFDA,$FFD1,$FFD7,$FFD8,$FFD7,$FFD6,$FFDA,$FFD9
	dw $FFD7,$FFDA,$FFD9,$FFD7

CODE_02E68E:
	LDA.b $78,x
	AND.w #$00FF
	ASL
	TAY
	LDA.w DATA_02E676,y
	CLC
	ADC.w $106C
	CMP.w #$8000
	ROR
	STA.w $106C
	LDA.w DATA_02E65E,y
	LDY.w $7400,x
	BEQ.b CODE_02E6AF
	EOR.w #$FFFF
	INC
CODE_02E6AF:
	CLC
	ADC.w $106A
	CMP.w #$8000
	ROR
	STA.w $106A
	RTS

DATA_02E6BB:
	dw $60E1,$20A1,$60C1,$20C1

CODE_02E6C3:
	LDY.b $79,x
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w DATA_02E6BB,y
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDY.b $18,x
	BMI.b CODE_02E71E
	LDA.w $7900,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDA.w $7A38,x
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	STZ.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STZ.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_088A81>>16
	LDA.w #FXCODE_088A81
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	STA.w $105C
	LDA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	STA.w $105E
	LDA.w $6000
	STA.w $1060
	LDA.w $6002
	STA.w $1062
	LDA.w $6004
	STA.w $1064
	LDA.w $6006
	STA.w $1066
	BRA.b CODE_02E759

CODE_02E71E:
	LDA.w $105C
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w $105E
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDA.w $1060
	STA.w $6000
	LDA.w $1062
	STA.w $6002
	LDA.w $1064
	STA.w $6004
	LDA.w $1066
	STA.w $6006
	LDA.w #$0040
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	STZ.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_088AF5>>16
	LDA.w #FXCODE_088AF5
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	INC.w $0CF9
CODE_02E759:
	LDA.b $18,x
	EOR.w #$00FF
	STA.b $18,x
CODE_02E760:
	RTS

CODE_02E761:
	LDA.w $7362,x
	BMI.b CODE_02E760
	LDY.w $7D36,x
	DEY
	BMI.b CODE_02E779
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_02E779
	LDA.w $7D38,y
	BNE.b CODE_02E77C
CODE_02E779:
	JMP.w CODE_02E82B

CODE_02E77C:
	LDA.w $7AF8,x
	BEQ.b CODE_02E784
CODE_02E781:
	JMP.w CODE_02E81A

CODE_02E784:
	LDA.w $7CD6,y
	SEC
	SBC.w $7CD6,x
	EOR.w $106E
	BMI.b CODE_02E781
	LDY.b $76,x
	CPY.b #$0E
	BMI.b CODE_02E7A2
	CPY.b #$11
	BMI.b CODE_02E781
	CPY.b #$16
	BMI.b CODE_02E7A2
	CPY.b #$19
	BMI.b CODE_02E781
CODE_02E7A2:
	LDA.w #$0409
	STA.b $78,x
	STZ.w $7220,x
	STZ.w $7540,x
	STZ.w $7222,x
	LDA.w #$FFFF
	STA.w $7AF8,x
	LDA.w $1082
	DEC
	ASL
	TAY
	LDA.w DATA_02E8FD,y
	STA.w $1086
	STZ.w $0CE8
	DEC.w $1082
	BNE.b CODE_02E7D9
	JSL.l CODE_02A982
	LDA.w #$0080
	PHA
	LDA.w #$000F
	LDY.b #$20
	BRA.b CODE_02E7E2

CODE_02E7D9:
	LDA.w #$0078
	PHA
	LDA.w #$000E
	LDY.b #$1C
CODE_02E7E2:
	STA.b $00
	STY.b $02
	PLA
	JSL.l CODE_0085D2
	LDX.b #$00
	LDY.w $1076
CODE_02E7F0:
	LDA.w $79D6,y
	STA.w $107C,x
	LDA.b $00
	STA.w $79D6,y
	CPY.w $1076
	BNE.b CODE_02E807
	INX
	INX
	LDY.w $1078
	BRA.b CODE_02E7F0

CODE_02E807:
	LDX.w $7972
	LDY.b $02
	STY.b $76,x
	STZ.w $7A96,x
	LDA.w #$01FF
	STA.w $7A36,x
	STA.w $7900,x
CODE_02E81A:
	LDY.w $7D36,x
	TYX
	DEX
	JSL.l CODE_03B24B
	LDA.w #$000B
	JSL.l CODE_0085D2
	RTS

CODE_02E82B:
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_098F33>>16
	LDA.w #FXCODE_098F33
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	BMI.b CODE_02E84C
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_02E84C
	LDA.w $7D38,y
	BNE.b CODE_02E84D
CODE_02E84C:
	RTS

CODE_02E84D:
	LDA.w $7182,x
	CLC
	ADC.w #$0008
	SEC
	SBC.w $7CD8,y
	STA.b $0A
	LDA.w $70E2,x
	CLC
	ADC.w #$0008
	SEC
	SBC.w $7CD6,y
	STA.b $08
	CLC
	ADC.b $0C
	CLC
	ADC.w #$0018
	CMP.w #$0030
	BCS.b CODE_02E88E
	LDA.b $0A
	CLC
	ADC.b $0E
	CLC
	ADC.w #$0018
	CMP.w #$0030
	BCS.b CODE_02E88E
CODE_02E881:
	TYX
	JSL.l CODE_03B24B
	LDA.w #$000B
	JSL.l CODE_0085D2
	RTS

CODE_02E88E:
	LDA.b $08
	CLC
	ADC.w #$0008
	CMP.w #$0010
	BCS.b CODE_02E8A4
	LDA.b $0A
	SEC
	SBC.w #$FFF8
	CMP.w #$0050
	BCC.b CODE_02E881
CODE_02E8A4:
	RTS

CODE_02E8A5:
	LDY.b $76,x
	CPY.b #$1C
	BPL.b CODE_02E8FA
	LDA.w $7182,x
	CLC
	ADC.w #$0008
	SEC
	SBC.w $611E
	STA.b $0A
	LDA.w $70E2,x
	CLC
	ADC.w #$0008
	SEC
	SBC.w $611C
	STA.b $08
	CLC
	ADC.b $0C
	CLC
	ADC.w #$0018
	CMP.w #$0030
	BCS.b CODE_02E8E4
	LDA.b $0A
	CLC
	ADC.b $0E
	CLC
	ADC.w #$0018
	CMP.w #$0030
	BCS.b CODE_02E8E4
CODE_02E8DF:
	JSL.l CODE_03A858
	RTS

CODE_02E8E4:
	LDA.b $08
	CLC
	ADC.w #$0008
	CMP.w #$0010
	BCS.b CODE_02E8FA
	LDA.b $0A
	SEC
	SBC.w #$FFF8
	CMP.w #$0050
	BCC.b CODE_02E8DF
CODE_02E8FA:
	RTS

DATA_02E8FB:
	dw $0080

DATA_02E8FD:
	dw $FF80

DATA_02E8FF:
	dw $6D65,$D8ED,$62D9

CODE_02E905:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02E8FA
	LDA.w $7A98,x
	BEQ.b CODE_02E913
	JMP.w CODE_02E9C9

CODE_02E913:
	LDY.b $78,x
	BNE.b CODE_02E91F
	LDY.w $7902,x
	BEQ.b CODE_02E922
	DEC.w $7902,x
CODE_02E91F:
	JMP.w CODE_02E9C6

CODE_02E922:
	LDY.w $1076
	LDA.w $79D6,y
	LDY.w $1078
	ORA.w $79D6,y
	BNE.b CODE_02E91F
	LDA.w $1086
	INC
	BNE.b CODE_02E941
	LDA.w $1082
	ASL
	TAY
	LDA.w DATA_02E8FD,y
	STA.w $1086
CODE_02E941:
	LDA.w $1086
	SEC
	ROR
	BCC.b CODE_02E985
	LDY.b #$0D
	SEC
	ROR
	BCS.b CODE_02E950
	LDY.b #$15
CODE_02E950:
	STY.b $76,x
	STA.w $1086
	LDY.w $7400,x
	LDA.w DATA_02E8FB,y
	STA.w $7220,x
	LDA.w #$0006
	STA.b $78,x
	LDA.w #$0040
	STA.w $7222,x
CODE_02E969:
	LDY.w $1076
	LDA.w #$FFFF
	STA.w $7976,y
	LDA.w #$0002
	STA.w $79D6,y
	LDY.w $1078
	STA.w $79D6,y
	LDA.w #$FFFF
	STA.w $7976,y
	RTS

CODE_02E985:
	SEC
	ROR
	BCS.b CODE_02E9B4
	STA.w $1086
	LDA.w #$04C0
	STA.w $0CE8
	STZ.b $78,x
	LDY.b #$0C
	STY.b $76,x
	LDY.w $1076
	LDA.w #$0040
	STA.w $7A96,y
	LDA.w #$0004
	STA.w $79D6,y
	LDY.w $1078
	STA.w $79D6,y
	LDA.w #$00C0
	STA.w $7A96,y
	RTS

CODE_02E9B4:
	STA.w $1086
	LDY.b #$00
	STY.b $79,x
	LDA.w #$0010
	STA.w $7A96,x
	LDY.b #$07
	STY.b $76,x
	RTS

CODE_02E9C6:
	JSR.w CODE_02E9E1
CODE_02E9C9:
	JSR.w CODE_02EA00
	LDY.w $77C2,x
	TYA
	CMP.w $7400,x
	BEQ.b CODE_02E9DC
	STZ.w $107A
	LDY.b #$1A
	STY.b $76,x
CODE_02E9DC:
	RTS

DATA_02E9DD:
	db $00,$01,$02,$01

CODE_02E9E1:
	LDA.w $7A98,x
	BNE.b CODE_02E9FB
	LDA.b $17,x
	INC
	AND.w #$FF03
	STA.b $17,x
	TAY
	LDA.w DATA_02E9DD,y
	TAY
	STY.b $78,x
	LDA.w #$0008
	STA.w $7A98,x
CODE_02E9FB:
	RTS

DATA_02E9FC:
	dw $0200,$0204

CODE_02EA00:
	LDA.w $7AF6,x
	BNE.b CODE_02EA2B
	LDA.b $16,x
	INC
	AND.w #$FF03
	STA.b $16,x
	TAY
	LDA.w DATA_02E9FC,y
	TAY
	STY.b $79,x
	CPY.b #$04
	BNE.b CODE_02EA1F
	LDA.w #$007B
	JSL.l CODE_0085D2
CODE_02EA1F:
	LDA.b $10
	AND.w #$0006
	CLC
	ADC.w #$0004
	STA.w $7AF6,x
CODE_02EA2B:
	RTS

CODE_02EA2C:
	TYX
	LDY.w $105A
	CPY.b #$02
	BPL.b CODE_02EA95
	LDY.w $108A
	LDA.w $79D6,y
	CMP.w #$0010
	BNE.b CODE_02EA82
	LDA.w #$0002
	STA.w $60AC
	LDA.w $70E2,y
	STA.b $00
	LDA.w #$0053
	JSL.l CODE_03A364
	LDA.w $6094
	CLC
	ADC.w #$0140
	STA.w $70E2,y
	LDA.w $609C
	CLC
	ADC.w #$0040
	STA.w $7182,y
	LDA.w #$FC00
	STA.w $7220,y
	LDA.w #$0010
	STA.w $7540,y
	LDA.b $00
	STA.w $79D8,y
	JSL.l CODE_02A982
	STZ.w $7ECC
	PLA
	JML.l CODE_03A32E

CODE_02EA82:
	STZ.w $0C1E
	LDA.w #$02B0
	CMP.w $0039
	BPL.b CODE_02EA94
	INC
	STA.w $0C23
	INC.w $0C1E
CODE_02EA94:
	RTS

CODE_02EA95:
	JSL.l CODE_03D5E4
	STZ.w $7722,x
	JSR.w CODE_02EABD
	STZ.w $7400,x
	LDA.w #$00C0
	STA.w $7A96,x
	LDA.w #$0002
	STA.b $76,x
	LDA.w #$62D9
	STA.w $1086
	LDA.w #$0001
	STA.w $7902,x
	STA.w $74A2,x
	RTS

CODE_02EABD:
	LDA.w #$0002
	STA.b $00
	LDA.w #DATA_02E490
	STA.b $02
	LDA.w #$1076
	STA.b $04
CODE_02EACC:
	LDA.w #$0172
	JSL.l CODE_03A364
	LDA.b ($02)
	CLC
	ADC.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
	LDA.w #$0000
	STA.w $7402,y
	STA.w $7220,y
	LDA.w #$FF80
	STA.w $7222,y
	LDA.w #$0001
	STA.w $79D6,y
	TYA
	STA.b ($04)
	JSR.w CODE_02EB0A
	INC.b $02
	INC.b $02
	INC.b $04
	INC.b $04
	DEC.b $00
	BNE.b CODE_02EACC
	RTS

CODE_02EB0A:
	LDA.w #$0002
	JSL.l CODE_03A364
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	CLC
	ADC.w #$FFB0
	STA.w $7182,y
	LDA.w #$0005
	STA.w $79D6,y
	LDA.b ($04)
	STA.w $7978,y
	RTS

CODE_02EB2D:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02EB4B
	LDA.w #$FFC0
	STA.w $7222,x
	LDA.w $1074
	CMP.w $7182,x
	BMI.b CODE_02EB4B
	STA.w $7182,x
	STZ.w $7222,x
	STZ.b $78,x
	INC.b $76,x
CODE_02EB4B:
	RTS

DATA_02EB4C:
	dw $FFFC,$0004

DATA_02EB50:
	dw $FFFF,$0001

CODE_02EB54:
	TYX
	LDA.w $7A96,x
	BEQ.b CODE_02EB5D
	JMP.w CODE_02EC28

CODE_02EB5D:
	LDA.w $7AF6,x
	BNE.b CODE_02EB73
	SEP.b #$20
	LDA.b $79,x
	LSR
	AND.b #$FE
	STA.b $79,x
	REP.b #$20
	LDA.w #$0004
	STA.w $7AF6,x
CODE_02EB73:
	LDY.b #$04
	STY.b $00
	LDY.b #$00
	LDA.w $1070
	SEC
	SBC.w #$FFBC
	CMP.w #$0008
	BCS.b CODE_02EB8C
	DEC.b $00
	LDA.w #$FFC0
	BRA.b CODE_02EB97

CODE_02EB8C:
	BPL.b CODE_02EB90
	INY
	INY
CODE_02EB90:
	LDA.w $1070
	CLC
	ADC.w DATA_02EB4C,y
CODE_02EB97:
	STA.w $1070
	LDY.b #$00
	LDA.w $1068
	SEC
	SBC.w #$0023
	CMP.w #$0002
	BCS.b CODE_02EBAF
	DEC.b $00
	LDA.w #$0024
	BRA.b CODE_02EBBA

CODE_02EBAF:
	BPL.b CODE_02EBB3
	INY
	INY
CODE_02EBB3:
	LDA.w $1068
	CLC
	ADC.w DATA_02EB50,y
CODE_02EBBA:
	STA.w $1068
	LDY.b #$00
	LDA.w $7A38,x
	CLC
	ADC.w #$0004
	CMP.w #$0008
	BCS.b CODE_02EBD2
	DEC.b $00
	LDA.w #$0000
	BRA.b CODE_02EBE3

CODE_02EBD2:
	CMP.w #$00FC
	BMI.b CODE_02EBD9
	INY
	INY
CODE_02EBD9:
	LDA.w $7A38,x
	CLC
	ADC.w DATA_02EB4C,y
	AND.w #$01FE
CODE_02EBE3:
	STA.w $7A38,x
	LDA.w #$FFC0
	STA.w $7222,x
	LDA.w $1074
	CMP.w $7182,x
	BMI.b CODE_02EBFC
	STA.w $7182,x
	STZ.w $7222,x
	DEC.b $00
CODE_02EBFC:
	LDY.b $00
	BNE.b CODE_02EC28
	LDY.b $76,x
	CPY.b #$11
	BEQ.b CODE_02EC25
	CPY.b #$03
	BEQ.b CODE_02EC1F
	CPY.b #$06
	BNE.b CODE_02EC14
	STZ.w $0C1E
	STZ.w $60AC
CODE_02EC14:
	STZ.b $16,x
	LDA.w #$0003
	STA.w $7902,x
	STZ.b $76,x
	RTS

CODE_02EC1F:
	LDA.w #$0040
	STA.w $7A96,x
CODE_02EC25:
	INC.b $76,x
	RTS

CODE_02EC28:
	LDY.b $76,x
	CPY.b #$19
	BNE.b CODE_02EC40
	LDA.w $7220,x
	CLC
	ADC.w #$0040
	CMP.w #$0080
	BCS.b CODE_02EC40
	STZ.w $7220,x
	STZ.w $7540,x
CODE_02EC40:
	RTS

CODE_02EC41:
	LDA.w #$01A0
	BRA.b CODE_02EC49

CODE_02EC46:
	LDA.w #$01C0
CODE_02EC49:
	STA.b $02
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02ECAA
	LDY.b #$02
	STY.b $00
	LDA.w $1070
	CLC
	ADC.w #$0008
	CMP.w #$FFE0
	BMI.b CODE_02EC66
	DEC.b $00
	LDA.w #$FFE0
CODE_02EC66:
	STA.w $1070
	LDA.w $1068
	CLC
	ADC.w #$0026
	INC
	LSR
	STA.w $1068
	LDA.w $7A38,x
	SEC
	SBC.w #$0010
	AND.w #$01FE
	CMP.b $02
	BPL.b CODE_02EC87
	DEC.b $00
	LDA.b $02
CODE_02EC87:
	STA.w $7A38,x
	LDY.b $00
	BNE.b CODE_02ECAA
	STZ.b $16,x
	LDA.w #$0004
	LDY.b $76,x
	CPY.b #$20
	BNE.b CODE_02EC9E
	LDA.w #$0001
	BRA.b CODE_02ECA5

CODE_02EC9E:
	CPY.b #$04
	BNE.b CODE_02ECA5
	LDA.w #$000C
CODE_02ECA5:
	STA.w $7902,x
	INC.b $76,x
CODE_02ECAA:
	RTS

CODE_02ECAB:
	TYX
	LDA.w $7900,x
	SEC
	SBC.w #$0010
	CMP.w #$0180
	BPL.b CODE_02ECC3
	LDA.w #$0008
	STA.w $7A96,x
	INC.b $76,x
	LDA.w #$017F
CODE_02ECC3:
	STA.w $7900,x
CODE_02ECC6:
	RTS

DATA_02ECC7:
	dw $FF38,$FE78,$FDC8

DATA_02ECCD:
	dw $FC14,$FC4C,$FCAC

CODE_02ECD3:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02ECC6
	LDA.w $7900,x
	CLC
	ADC.w #$0010
	CMP.w #$01FF
	BMI.b CODE_02ED5B
	LDA.w $70E2,x
	CLC
	ADC.b $0C
	STA.b $00
	LDA.w $7182,x
	CLC
	ADC.b $0E
	STA.b $02
	LDA.w #$0083
	JSL.l CODE_0085D2
	LDA.w #$0006
	STA.b $0A
CODE_02ED01:
	LDY.b $0A
	LDA.w DATA_02ECCD-$02,y
	STA.b $08
	LDA.w DATA_02ECC7-$02,y
	LDY.w $7400,x
	BEQ.b CODE_02ED14
	EOR.w #$FFFF
	INC
CODE_02ED14:
	STA.b $06
	LDA.w #$0165
	JSL.l CODE_03A364
	BCC.b CODE_02ED50
	LDA.b $00
	STA.w $70E2,y
	LDA.b $02
	STA.w $7182,y
	LDA.b $06
	STA.w $7220,y
	LDA.b $08
	STA.w $7222,y
	LDA.w #$0001
	STA.w $7A36,y
	ASL
	ASL
	STA.w $7976,y
	STA.w $7540,y
	LDA.w $7040,y
	AND.w #$FFF3
	STA.w $7040,y
	DEC.b $0A
	DEC.b $0A
	BNE.b CODE_02ED01
CODE_02ED50:
	LDA.w #$0010
	STA.w $7A96,x
	INC.b $76,x
	LDA.w #$01FF
CODE_02ED5B:
	STA.w $7900,x
	LDY.b #$00
	CMP.w #$01B0
	BMI.b CODE_02ED6E
	LDY.b #$02
	CMP.w #$01E0
	BMI.b CODE_02ED6E
	LDY.b #$04
CODE_02ED6E:
	STY.b $79,x
	RTS

CODE_02ED71:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02ED83
	LDY.b #$00
	STY.b $79,x
	LDA.w #$0100
	STA.w $7A96,x
	INC.b $76,x
CODE_02ED83:
	RTS

CODE_02ED84:
	TYX
	LDY.w $1076
	LDA.w $79D6,y
	LDY.w $1078
	ORA.w $79D6,y
	BNE.b CODE_02ED9C
	LDA.w #$0003
	STA.w $7902,x
	STZ.b $76,x
	RTS

CODE_02ED9C:
	JSR.w CODE_02E9E1
	JSR.w CODE_02EA00
	LDY.w $77C2,x
	TYA
	CMP.w $7400,x
	BEQ.b CODE_02EDB4
	LDY.b #$0C
	STY.w $107A
	LDY.b #$1A
	STY.b $76,x
CODE_02EDB4:
	RTS

CODE_02EDB5:
	TYX
	LDA.w $7220,x
	CLC
	ADC.w #$0018
	CMP.w #$0030
	BCS.b CODE_02EDD1
	STZ.w $7540,x
	STZ.w $7220,x
	LDA.w #$0040
	STA.w $7A96,x
	INC.b $76,x
	RTS

CODE_02EDD1:
	JSR.w CODE_02EFD3
	RTS

DATA_02EDD5:
	dw $0100,$FF00,$0200,$FE00

DATA_02EDDD:
	dw $03B0,$02E0

CODE_02EDE1:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02EE23
	LDY.w $7400,x
	TYA
	DEC
	EOR.w $7C16,x
	BMI.b CODE_02EDF7
	TYA
	CLC
	ADC.w #$0004
	TAY
CODE_02EDF7:
	LDA.w DATA_02EDD5,y
	STA.w $75E0,x
	LDA.w #$0008
	STA.w $7540,x
	LDY.w $7400,x
	LDA.w $70E2,x
	SEC
	SBC.w DATA_02EDDD,y
	STA.b $02
	TYA
	DEC
	EOR.b $02
	BPL.b CODE_02EE23
	LDA.w DATA_02EDDD,y
	STA.w $70E2,x
	STZ.w $7220,x
	STZ.w $7540,x
	INC.b $76,x
CODE_02EE23:
	RTS

DATA_02EE24:
	dw $0009,$020A,$040B,$020A

CODE_02EE2C:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_02EE75
	LDA.w #$0004
	STA.w $7A98,x
	LDA.b $16,x
	INC
	INC
	AND.w #$0006
	STA.b $16,x
	TAY
	LDA.w DATA_02EE24,y
	STA.b $78,x
	CPY.b #$04
	BNE.b CODE_02EE75
	LDA.w #$007B
	JSL.l CODE_0085D2
	DEC.w $7902,x
	BNE.b CODE_02EE75
	INC.b $76,x
	LDY.b $76,x
	CPY.b #$14
	BEQ.b CODE_02EE75
	LDA.w #$0080
	CPY.b #$06
	BEQ.b CODE_02EE72
	CPY.b #$22
	BNE.b CODE_02EE6F
	LDA.w #$001B
	STA.b $16,x
CODE_02EE6F:
	LDA.w #$0040
CODE_02EE72:
	STA.w $7A96,x
CODE_02EE75:
	RTS

DATA_02EE76:
	dw $03B0,$02E0

CODE_02EE7A:
	TYX
	LDY.b #$05
	STY.b $00
	LDA.w $1070
	SEC
	SBC.w #$0004
	CMP.w #$FF81
	BPL.b CODE_02EE90
	DEC.b $00
	LDA.w #$FF80
CODE_02EE90:
	STA.w $1070
	LDA.w $1068
	DEC
	CMP.w #$001D
	BPL.b CODE_02EEA1
	DEC.b $00
	LDA.w #$001C
CODE_02EEA1:
	STA.w $1068
	LDA.w $7A38,x
	CLC
	ADC.w #$0004
	CMP.w #$0070
	BMI.b CODE_02EEB5
	DEC.b $00
	LDA.w #$0070
CODE_02EEB5:
	STA.w $7A38,x
	LDY.w $7400,x
	LDA.w $7220,x
	BEQ.b CODE_02EECF
	LDA.w $70E2,x
	SEC
	SBC.w DATA_02EE76,y
	STA.b $02
	TYA
	DEC
	EOR.b $02
	BPL.b CODE_02EEDA
CODE_02EECF:
	DEC.b $00
	LDA.w DATA_02EE76,y
	STA.w $70E2,x
	STZ.w $7220,x
CODE_02EEDA:
	LDA.w $1074
	CLC
	ADC.w #$0010
	CMP.w $7182,x
	BPL.b CODE_02EEEF
	INC
	STA.w $7182,x
	STZ.w $7222,x
	DEC.b $00
CODE_02EEEF:
	LDY.b $00
	BNE.b CODE_02EF06
	LDY.b $76,x
	CPY.b #$1F
	BEQ.b CODE_02EF07
	INC.b $76,x
CODE_02EEFB:
	STZ.b $16,x
	STZ.w $7902,x
	LDA.w #$0020
	STA.w $7A96,x
CODE_02EF06:
	RTS

CODE_02EF07:
	LDA.w $7042,x
	AND.w #$FFF0
	ORA.w #$000C
	STA.w $7042,x
	STZ.w $7AF8,x
	LDY.w $1076
	LDA.w $79D6,y
	LDY.w $1078
	ORA.w $79D6,y
	BNE.b CODE_02EF06
	LDY.b #$16
	STY.b $76,x
	JSR.w CODE_02EEFB
	JMP.w CODE_02E969

DATA_02EF2E:
	dw $FD00,$0300

DATA_02EF32:
	dw $0706,$0708

DATA_02EF36:
	dw $02E8,$03A4,$EF42,$EF52,$EF62,$EF72,$0010,$0040
	dw $0080,$00B0,$FFF0,$FFE0,$FFE8,$FFD0,$0010,$0040
	dw $0080,$00B0,$FFF0,$FFE0,$FFE8,$FFD0,$0010,$0040
	dw $0080,$00B0,$FFF0,$FFE0,$FFE8,$FFD0,$0010,$0040
	dw $0080,$00B0,$FFF0,$FFE0,$FFE8,$FFD0

DATA_02EF82:
	dw $0100,$FF00

CODE_02EF86:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02EFB5
	LDY.w $7400,x
	LDA.w DATA_02EF2E,y
	STA.w $75E0,x
	LDA.w #$0010
	STA.w $7540,x
	LDA.w $7A98,x
	BNE.b CODE_02EFB5
	LDA.b $16,x
	INC
	AND.w #$0003
	STA.b $16,x
	TAY
	LDA.w DATA_02EF32,y
	TAY
	STY.b $78,x
	LDA.w #$0008
	STA.w $7A98,x
CODE_02EFB5:
	LDY.b $76,x
	CPY.b #$16
	BEQ.b CODE_02EFD3
	LDA.w $70E2,x
	SEC
	SBC.w #$0320
	CMP.w #$0060
	BCS.b CODE_02EFD3
	STZ.w $75E0,x
	LDA.w #$0018
	STA.w $7540,x
	INC.b $76,x
	RTS

CODE_02EFD3:
	LDY.w $7400,x
	LDA.w $70E2,x
	SEC
	SBC.w DATA_02EF36,y
	STA.b $02
	TYA
	DEC
	EOR.b $02
	BMI.b CODE_02F014
	LDA.w DATA_02EF36,y
	STA.w $70E2,x
	LDY.b #$06
	STY.b $78,x
	LDA.w $7220,x
	CLC
	ADC.w #$0100
	CMP.w #$0200
	BCS.b CODE_02F015
	LDA.w #$0040
	STA.w $7A96,x
	LDY.w $7400,x
	LDA.w DATA_02EF82,y
	STA.w $7220,x
	LDA.w #$0008
	STA.w $7540,x
	LDY.b #$19
	STY.b $76,x
CODE_02F014:
	RTS

CODE_02F015:
	STZ.w $7540,x
	STZ.w $7220,x
	LDA.w #$0047
	JSL.l CODE_0085D2
	LDA.w #$0020
	STA.w $61C8
	LDY.b #$17
	STY.b $76,x
	RTS

CODE_02F02D:
	TYX
	LDA.w $7A36,x
	SEC
	SBC.w #$0060
	CMP.w #$0140
	BPL.b CODE_02F03F
	INC.b $76,x
	LDA.w #$0140
CODE_02F03F:
	STA.w $7A36,x
	LSR
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0018
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w #$0018
	SEC
	SBC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDY.w $7400,x
	BNE.b CODE_02F067
	EOR.w #$FFFF
	INC
CODE_02F067:
	ASL
	CLC
	ADC.w DATA_02EF36,y
	STA.w $70E2,x
	RTS

DATA_02F070:
	dw $0200,$FE00

CODE_02F074:
	TYX
	LDA.w $7A36,x
	CLC
	ADC.w #$0040
	CMP.w #$01FF
	BMI.b CODE_02F03F
	LDY.w $7400,x
	LDA.w DATA_02F070,y
	STA.w $7220,x
	LDA.w #$0010
	STA.w $7540,x
	ASL
	ASL
	STA.w $7A96,x
	INC.b $76,x
	LDA.w #$01FF
	BRA.b CODE_02F03F

CODE_02F09C:
	TYX
	LDA.b $78,x
	BNE.b CODE_02F0AF
	STZ.b $16,x
	LDA.w #$0003
	STA.w $7A98,x
	INC
	STA.b $78,x
	INC.b $76,x
	RTS

CODE_02F0AF:
	LDY.b $78,x
	BEQ.b CODE_02F0C6
	LDA.w $7A98,x
	BNE.b CODE_02F0C6
	LDA.b $78,x
	INC
	AND.w #$FF03
	STA.b $78,x
	LDA.w #$0004
	STA.w $7A98,x
CODE_02F0C6:
	LDY.b $79,x
	BEQ.b CODE_02F0EF
	LDA.w $7AF6,x
	BNE.b CODE_02F0EF
	LDA.b $16,x
	INC
	AND.w #$0003
	STA.b $16,x
	TAY
	LDA.w DATA_02E9FC,y
	TAY
	STY.b $79,x
	CPY.b #$04
	BNE.b CODE_02F0E9
	LDA.w #$007B
	JSL.l CODE_0085D2
CODE_02F0E9:
	LDA.w #$0004
	STA.w $7AF6,x
CODE_02F0EF:
	RTS

DATA_02F0F0:
	dw $0604,$0605,$0605,$0604,$0003

DATA_02F0FA:
	dw $FFB0,$FFA8,$FFA8,$FFB0,$FFC0

DATA_02F104:
	dw $0024,$0020,$0020,$0024,$0024

CODE_02F10E:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_02F155
	INC.b $16,x
	INC.b $16,x
	LDY.b $16,x
	CPY.b #$0C
	BMI.b CODE_02F131
	LDA.w $106E
	EOR.w #$FFFF
	STA.w $106E
	STZ.b $78,x
	STZ.b $16,x
	LDY.w $107A
	STY.b $76,x
	RTS

CODE_02F131:
	LDA.w DATA_02F0F0-$02,y
	STA.b $78,x
	LDA.w DATA_02F0FA-$02,y
	STA.w $1070
	LDA.w DATA_02F104-$02,y
	STA.w $1068
	CPY.b #$06
	BNE.b CODE_02F14F
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
CODE_02F14F:
	LDA.w #$0004
	STA.w $7A98,x
CODE_02F155:
	RTS

CODE_02F156:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02F155
	LDY.b $79,x
	TYA
	LSR
	AND.w #$00FE
	STA.b $00
	LDA.b $79,x
	AND.w #$FF00
	ORA.b $00
	STA.b $79,x
	LDY.b #$02
	STY.b $00
	LDA.w $7A38,x
	CMP.w #$0010
	BPL.b CODE_02F17E
	DEC.b $00
	BRA.b CODE_02F188

CODE_02F17E:
	CLC
	ADC.w #$0004
	AND.w #$01FE
	STA.w $7A38,x
CODE_02F188:
	LDY.b #$00
	LDA.w $1070
	SEC
	SBC.w #$FFBC
	CMP.w #$0008
	BCS.b CODE_02F19D
	DEC.b $00
	LDA.w #$FFC0
	BRA.b CODE_02F1A8

CODE_02F19D:
	BPL.b CODE_02F1A1
	INY
	INY
CODE_02F1A1:
	LDA.w $1070
	CLC
	ADC.w DATA_02EB4C,y
CODE_02F1A8:
	STA.w $1070
	LDY.b $00
	BNE.b CODE_02F1DE
	LDX.b #$00
	LDY.w $1076
CODE_02F1B4:
	LDA.w $107C,x
	STA.w $79D6,y
	INX
	INX
	CPY.w $1076
	BNE.b CODE_02F1C6
	LDY.w $1078
	BRA.b CODE_02F1B4

CODE_02F1C6:
	LDX.b $12
	LDY.w $7400,x
	LDA.w DATA_02E8FB,y
	STA.w $7220,x
	LDA.w #$0006
	STA.b $78,x
	LDA.w #$0040
	STA.w $7222,x
	INC.b $76,x
CODE_02F1DE:
	RTS

CODE_02F1DF:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02F204
	LDA.b $0C
	CLC
	ADC.w $70E2,x
	STA.b $00
	LDA.b $0E
	CLC
	ADC.w $7182,x
	STA.b $02
	LDA.w #$0340
	JSL.l CODE_02E1A6
	LDA.w #$0080
	STA.w $7A96,x
	INC.b $76,x
CODE_02F204:
	RTS

CODE_02F205:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02F26D
	LDA.w $7AF8,x
	BEQ.b CODE_02F216
	LDA.w #$0001
	STA.w $7AF8,x
CODE_02F216:
	LDA.w $7042,x
	AND.w #$FFF0
	ORA.w #$000C
	STA.w $7042,x
	LDA.w $1070
	BEQ.b CODE_02F235
	LDA.w $7AF6,x
	BNE.b CODE_02F235
	INC.w $1070
	LDA.w #$0004
	STA.w $7AF6,x
CODE_02F235:
	LDA.w $7A36,x
	SEC
	SBC.w #$0008
	STA.w $7A36,x
	STA.w $7900,x
	CMP.w #$00C0
	BPL.b CODE_02F24F
	LDA.w #$0030
	STA.w $7A96,x
	INC.b $76,x
CODE_02F24F:
	LDA.w #$0180
	SEC
	SBC.w $7A36,x
	BMI.b CODE_02F26D
	AND.w #$01E0
	ASL
	ASL
	ASL
	XBA
	STA.w $1080
	CMP.b $16,x
	BEQ.b CODE_02F26D
	STA.b $16,x
	JSR.w CODE_02F357
	LDX.b $12
CODE_02F26D:
	RTS

DATA_02F26E:
	db $10,$18,$00,$08,$20

CODE_02F273:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02F2CD
	LDY.w $1084
	BNE.b CODE_02F2C1
	LDA.w $70E2,x
	CLC
	ADC.b $0C
	CLC
	ADC.w #$0008
	STA.b $00
	LDA.w $7182,x
	CLC
	ADC.b $0E
	CLC
	ADC.w #$0008
	STA.b $02
	LDA.w #$01E6
	JSL.l CODE_008B21
	LDA.b $00
	STA.w $70A2,y
	LDA.b $02
	STA.w $7142,y
	LDA.w #$0004
	STA.w $7782,y
	ASL
	DEC
	STA.w $73C2,y
	STA.w $7E4C,y
	LDY.b #$10
	STY.w $1084
	LDA.w #$0020
	STA.w $7A96,x
	RTS

CODE_02F2C1:
	CPY.b #$15
	BMI.b CODE_02F2CE
	LDA.w #$0040
	STA.w $7A96,x
	INC.b $76,x
CODE_02F2CD:
	RTS

CODE_02F2CE:
	INC.w $1084
	LDA.w $1084
	SEC
	SBC.w #$0010
	TAY
	REP.b #$10
	LDA.w DATA_02F26E-$01,y
	AND.w #$00FF
	CLC
	ADC.w $7362,x
	CLC
	ADC.w #$0080
	TAY
	LDA.w $6000,y
	CLC
	ADC.w $6094
	CLC
	ADC.w #$0008
	STA.b $00
	LDA.w $6002,y
	CLC
	ADC.w $609C
	CLC
	ADC.w #$0008
	STA.b $02
	SEP.b #$10
	JSR.w CODE_02F31E
	LDA.w #$0008
	STA.w $7A96,x
CODE_02F30F:
	RTS

CODE_02F310:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02F30F
	STZ.w $7ECC
	PLA
	JML.l CODE_03A32E

CODE_02F31E:
	LDA.w #$0222
	JSL.l CODE_008B21
	LDA.b $00
	AND.w #$FFF0
	STA.w $70A2,y
	LDA.b $02
	AND.w #$FFF0
	STA.w $7142,y
	LDA.w #$000F
	STA.w $73C2,y
	LDA.w #$0004
	STA.w $7782,y
	LDA.w #$000A
	JSL.l CODE_0085D2
	RTS

;---------------------------------------------------------------------------

DATA_02F349:
	dw DATA_5FE48A,DATA_5FE4A6,DATA_5FE4C2,DATA_5FE4DE,DATA_5FE4FA,DATA_5FE516,DATA_5FE532

CODE_02F357:
	PHD
	LDA.w #$0000
	TCD
	LDA.w $1080
	ASL
	TAX
	LDA.w DATA_02F349,x
	STA.b $00
	PHB
	LDX.b #$7021C4>>16
	PHX
	PLB
	LDX.b #DATA_5FE48A>>16
	STX.b $02
	LDY.b #$00
CODE_02F371:
	LDA.b [$00],y
	STA.w $7021C4,y
	INY
	INY
	CPY.b #$1C
	BCC.b CODE_02F371
	PLB
	PLD
	RTS

;---------------------------------------------------------------------------

CODE_02F37F:
	RTL

;---------------------------------------------------------------------------

DATA_02F380:
	dw CODE_02F4AD,CODE_02F4E4,CODE_02F56B,CODE_02F633,CODE_02F655,CODE_02F6D2,CODE_02F71A,CODE_02F78E
	dw CODE_02F7D0,CODE_02F4E4,CODE_02F655,CODE_02F800,CODE_02F4AD,CODE_02F655,CODE_02E48E,CODE_02F848
	dw CODE_02F8AA,CODE_02E48E

CODE_02F3A4:
	JSR.w CODE_02F3E1
	LDY.w $1072
	LDA.w $7042,y
	STA.w $7042,x
	JSL.l CODE_03AF23
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_02F380,x)
	JSR.w CODE_02F438
	LDY.b $76,x
	CPY.b #$0E
	BNE.b CODE_02F3DA
	LDA.w $70E2,x
	SEC
	SBC.w $72C0,x
	STA.w $70E2,x
	LDA.w $7182,x
	SEC
	SBC.w $72C2,x
	STA.w $7182,x
	RTL

CODE_02F3DA:
	JSR.w CODE_02F497
	JSR.w CODE_02F4C1
	RTL

CODE_02F3E1:
	TXA
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #DATA_02FD7D>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #DATA_02FD7D
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDY.w $7041,x
	TYA
	LSR
	LSR
	LSR
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.b $78,x
	STA.w $601E
	LDA.w $7680,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7682,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7400,x
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDX.b #FXCODE_08A201>>16
	LDA.w #FXCODE_08A201
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	RTS

DATA_02F41E:
	db $00,$01,$03,$05,$07,$09,$0A,$0B,$0C,$0D,$0E,$0F,$11,$12,$14,$15
	db $17,$18,$19,$19,$1B,$1B,$1B,$1B,$1A,$19

CODE_02F438:
	LDY.b $76,x
	CPY.b #$0E
	BPL.b CODE_02F47C
	LDA.w $7362,x
	BMI.b CODE_02F47C
	LDA.w $6120
	CLC
	ADC.w #$0006
	ASL
	STA.b $00
	LSR
	CLC
	ADC.w $7C16,x
	CMP.b $00
	BCS.b CODE_02F47C
	LDY.w $7402,x
	LDA.w DATA_02F41E,y
	AND.w #$00FF
	STA.b $00
	CLC
	ADC.w #$0006
	CLC
	ADC.w $6122
	ASL
	STA.b $02
	LSR
	CLC
	ADC.w $7C18,x
	SEC
	SBC.b $00
	CMP.b $02
	BCS.b CODE_02F47C
	JSL.l CODE_03A858
CODE_02F47C:
	RTS

DATA_02F47D:
	db $18,$18,$10,$10,$20,$20,$18,$18,$20,$28,$28,$20,$20,$20,$28,$28
	db $28,$28,$28,$28,$28,$28,$28,$28,$28,$28

CODE_02F497:
	LDY.w $7402,x
	LDA.w DATA_02F47D,y
	TAY
	TYA
	STA.b $00
	LDA.w $7041,x
	AND.w #$FF07
	ORA.b $00
	STA.w $7041,x
	RTS

CODE_02F4AD:
	TYX
	LDA.w $1074
	CMP.w $7182,x
	BMI.b CODE_02F4BE
	STA.w $7182,x
	STZ.w $7222,x
	STZ.b $76,x
CODE_02F4BE:
	JMP.w CODE_02F52F

CODE_02F4C1:
	LDA.w $70E2,x
	CMP.w #$03B0
	BMI.b CODE_02F4CE
	LDA.w #$03AF
	BRA.b CODE_02F4D6

CODE_02F4CE:
	CMP.w #$02D0
	BPL.b CODE_02F4E3
	LDA.w #$02D0
CODE_02F4D6:
	STA.w $70E2,x
	LDA.w $7220,x
	EOR.w #$FFFF
	INC
	STA.w $7220,x
CODE_02F4E3:
	RTS

CODE_02F4E4:
	TYX
	LDA.w $1074
	CMP.w $7182,x
	BMI.b CODE_02F4F3
	STA.w $7182,x
	STZ.w $7222,x
CODE_02F4F3:
	JSR.w CODE_02F52F
	LDY.b $76,x
	CPY.b #$01
	BNE.b CODE_02F507
	LDY.w $1072
	LDA.w $79D6,y
	BNE.b CODE_02F506
	STZ.b $76,x
CODE_02F506:
	RTS

CODE_02F507:
	LDY.w $7402,x
	CPY.b #$12
	BNE.b CODE_02F51E
	LDA.w $7A98,x
	BNE.b CODE_02F51E
	INC.b $76,x
	LDA.w $0CE8
	BEQ.b CODE_02F51E
	LDY.b #$0D
	STY.b $76,x
CODE_02F51E:
	RTS

DATA_02F51F:
	db $12,$13,$14,$15,$16,$17,$18,$19,$19,$18,$17,$16,$15,$14,$13,$12

CODE_02F52F:
	LDA.w $7AF6,x
	BNE.b CODE_02F55E
	LDA.b $16,x
	INC
	AND.w #$000F
	STA.b $16,x
	TAY
	LDA.w DATA_02F51F,y
	TAY
	TYA
	STA.w $7402,x
	LDY.b $76,x
	CPY.b #$09
	BEQ.b CODE_02F54F
	CPY.b #$0E
	BMI.b CODE_02F556
CODE_02F54F:
	LDA.w #$0002
	STA.w $7AF6,x
	RTS

CODE_02F556:
	LDA.b $10
	AND.w #$0005
	STA.w $7AF6,x
CODE_02F55E:
	RTS

DATA_02F55F:
	dw $0020,$FFE0

DATA_02F563:
	dw $0001,$FFFF

DATA_02F567:
	dw $03B0,$02D0

CODE_02F56B:
	TYX
	LDA.w $7AF6,x
	BNE.b CODE_02F59B
	LDY.b #$00
	LDA.w $7402,x
	CLC
	ADC.b $16,x
	CMP.w #$0001
	BMI.b CODE_02F585
	INY
	INY
	CMP.w #$0004
	BMI.b CODE_02F58C
CODE_02F585:
	PHA
	LDA.w DATA_02F563,y
	STA.b $16,x
	PLA
CODE_02F58C:
	STA.w $7402,x
	LDA.b $10
	AND.w #$0003
	CLC
	ADC.w #$0004
	STA.w $7AF6,x
CODE_02F59B:
	LDY.b #$00
	CPX.w $1076
	BNE.b CODE_02F5A4
	INY
	INY
CODE_02F5A4:
	TYA
	DEC
	STA.b $06
	LDA.w DATA_02F567,y
	STA.b $04
	LDA.w DATA_02F55F,y
	LDY.w $1072
	CLC
	ADC.w $70E2,y
	STA.b $02
	SEC
	SBC.w $70E2,x
	STA.b $00
	ASL
	ASL
	ASL
	ASL
	PHP
	CMP.w #$0300
	BMI.b CODE_02F5CC
	LDA.w #$0300
CODE_02F5CC:
	CMP.w #$FD00
	BPL.b CODE_02F5D4
	LDA.w #$FD00
CODE_02F5D4:
	STA.w $75E0,x
	PLP
	BPL.b CODE_02F5DE
	EOR.w #$FFFF
	INC
CODE_02F5DE:
	LSR
	LSR
	LSR
	LSR
	STA.w $7540,x
	LDY.w $1072
	LDA.w $79D6,y
	CMP.w #$000D
	BMI.b CODE_02F5FF
	CMP.w #$0012
	BMI.b CODE_02F632
	CMP.w #$0015
	BMI.b CODE_02F5FF
	CMP.w #$001A
	BMI.b CODE_02F632
CODE_02F5FF:
	LDA.b $02
	SEC
	SBC.b $04
	EOR.b $06
	BPL.b CODE_02F60C
	LDA.b $04
	BRA.b CODE_02F627

CODE_02F60C:
	LDA.b $00
	CLC
	ADC.w #$0004
	CMP.w #$0008
	BCS.b CODE_02F632
	LDA.w $70E2,y
	LDY.b #$00
	CPX.w $1076
	BNE.b CODE_02F623
	INY
	INY
CODE_02F623:
	CLC
	ADC.w DATA_02F55F,y
CODE_02F627:
	STA.w $70E2,x
	STZ.w $7220,x
	STZ.w $7540,x
	INC.b $76,x
CODE_02F632:
	RTS

CODE_02F633:
	TYX
	LDA.w $7AF6,x
	BNE.b CODE_02F654
	LDA.w $7402,x
	INC
	CMP.w #$0012
	BMI.b CODE_02F647
	STZ.b $76,x
	LDA.w #$0012
CODE_02F647:
	STA.w $7402,x
	LDA.b $10
	AND.w #$0001
	INC
	INC
	STA.w $7AF6,x
CODE_02F654:
	RTS

CODE_02F655:
	TYX
	LDA.w $0CE8
	BNE.b CODE_02F661
	LDY.b #$0A
	STY.b $76,x
	BRA.b CODE_02F666

CODE_02F661:
	LDA.w $7A96,x
	BNE.b CODE_02F6CF
CODE_02F666:
	LDY.w $7402,x
	CPY.b #$13
	BPL.b CODE_02F6CF
	LDA.w $7AF6,x
	BNE.b CODE_02F6CF
	LDA.w $7402,x
	DEC
	BPL.b CODE_02F694
	LDA.w $1074
	CLC
	ADC.w #$0010
	STA.w $7182,x
	LDA.w #$0040
	STA.w $7A96,x
	INC.b $76,x
	STZ.w $7222,x
	STZ.b $16,x
	LDA.w #$0000
	BRA.b CODE_02F6C5

CODE_02F694:
	LDY.b $76,x
	CPY.b #$0D
	BNE.b CODE_02F6B8
	CMP.w #$0005
	BPL.b CODE_02F6C5
	STA.w $7402,x
	LDA.b $10
	AND.w #$003F
	CLC
	ADC.w #$0080
	STA.w $7A96,x
	LDA.w #$0001
	STA.b $16,x
	LDY.b #$06
	STY.b $76,x
	RTS

CODE_02F6B8:
	CMP.w #$0006
	BPL.b CODE_02F6C5
	PHA
	LDA.w #$0040
	STA.w $7222,x
	PLA
CODE_02F6C5:
	STA.w $7402,x
	LDA.w #$0002
	STA.w $7AF6,x
	RTS

CODE_02F6CF:
	JMP.w CODE_02F52F

CODE_02F6D2:
	TYX
	LDA.w $0CE8
	BNE.b CODE_02F6DD
	LDY.b #$0A
	STY.b $76,x
	RTS

CODE_02F6DD:
	LDA.w $7A96,x
	BNE.b CODE_02F711
	LDY.b $16,x
	BNE.b CODE_02F6EE
	INC.b $16,x
	LDA.w $608C
	STA.w $70E2,x
CODE_02F6EE:
	LDA.w $7AF6,x
	BNE.b CODE_02F711
	INC.w $7402,x
	LDY.w $7402,x
	CPY.b #$03
	BMI.b CODE_02F70B
	LDA.b $10
	AND.w #$001F
	CLC
	ADC.w #$0040
	STA.w $7A96,x
	INC.b $76,x
CODE_02F70B:
	LDA.w #$0003
	STA.w $7AF6,x
CODE_02F711:
	RTS

DATA_02F712:
	dw $0004,$FFFC

DATA_02F716:
	dw $FFC0,$0040

CODE_02F71A:
	TYX
	LDA.w $0CE8
	BNE.b CODE_02F72B
	STZ.w $7540,x
	STZ.w $7220,x
	LDY.b #$0A
	STY.b $76,x
	RTS

CODE_02F72B:
	LDA.w $7A96,x
	BNE.b CODE_02F745
	LDA.w $7C16,x
	CLC
	ADC.w #$0008
	CMP.w #$0010
	BCS.b CODE_02F745
	STZ.w $7220,x
	STZ.w $7540,x
	INC.b $76,x
	RTS

CODE_02F745:
	LDY.b #$00
	CPX.w $1076
	BEQ.b CODE_02F74E
	INY
	INY
CODE_02F74E:
	LDA.w DATA_02F712,y
	LDY.b #$00
	CLC
	ADC.w $7C16,x
	BPL.b CODE_02F75B
	INY
	INY
CODE_02F75B:
	LDA.w DATA_02F716,y
	STA.w $75E0,x
	LDA.w #$0010
	STA.w $7540,x
	LDA.w $7AF6,x
	BNE.b CODE_02F78D
	LDA.w $7402,x
	CLC
	ADC.b $16,x
	STA.w $7402,x
	CMP.w #$0003
	BEQ.b CODE_02F77F
	CMP.w #$0005
	BMI.b CODE_02F787
CODE_02F77F:
	LDA.b $16,x
	EOR.w #$FFFF
	INC
	STA.b $16,x
CODE_02F787:
	LDA.w #$0008
	STA.w $7AF6,x
CODE_02F78D:
	RTS

CODE_02F78E:
	TYX
	LDA.w $0CE8
	BNE.b CODE_02F799
	LDY.b #$0A
	STY.b $76,x
	RTS

CODE_02F799:
	LDY.w $7402,x
	BNE.b CODE_02F7CC
	LDA.w #$0020
	STA.w $7A96,x
	STZ.b $16,x
	INC.b $76,x
CODE_02F7A8:
	LDA.w #$01BA
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $1074
	STA.w $7142,y
	LDA.w #$001A
	STA.w $7E4C,y
	LDA.w #$0003
	STA.w $7782,y
	JSL.l CODE_0085D2
	RTS

CODE_02F7CC:
	DEC.w $7402,x
	RTS

CODE_02F7D0:
	TYX
	LDA.w $0CE8
	BNE.b CODE_02F7DB
	LDY.b #$0A
	STY.b $76,x
	RTS

CODE_02F7DB:
	LDA.w $7A96,x
	BNE.b CODE_02F7FB
	LDY.b $16,x
	BNE.b CODE_02F7E9
	INC.b $16,x
	JSR.w CODE_02F7A8
CODE_02F7E9:
	INC.w $7402,x
	LDY.w $7402,x
	CPY.b #$12
	BMI.b CODE_02F7FB
	LDA.w #$0040
	STA.w $7A98,x
	INC.b $76,x
CODE_02F7FB:
	RTS

DATA_02F7FC:
	dw $0020,$FFE0

CODE_02F800:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02F843
	LDY.b $16,x
	BNE.b CODE_02F826
	LDA.w #$FFC0
	STA.w $7222,x
	INC.b $16,x
	CPX.w $1076
	BNE.b CODE_02F819
	INY
	INY
CODE_02F819:
	LDA.w DATA_02F7FC,y
	LDY.w $1072
	CLC
	ADC.w $70E2,y
	STA.w $70E2,x
CODE_02F826:
	LDA.w $7AF6,x
	BNE.b CODE_02F843
	INC.w $7402,x
	LDY.w $7402,x
	CPY.b #$12
	BMI.b CODE_02F83D
	LDA.w #$FF80
	STA.w $7222,x
	INC.b $76,x
CODE_02F83D:
	LDA.w #$0004
	STA.w $7AF6,x
CODE_02F843:
	RTS

DATA_02F844:
	dw $0040,$FFC0

CODE_02F848:
	TYX
	STZ.w $7220,x
	STZ.w $7540,x
	STZ.w $7222,x
	STZ.w $7542,x
	LDA.w $7AF6,x
	BNE.b CODE_02F8A4
	LDY.w $7402,x
	CPY.b #$12
	BEQ.b CODE_02F872
	BPL.b CODE_02F868
	INC.w $7402,x
	BRA.b CODE_02F86B

CODE_02F868:
	DEC.w $7402,x
CODE_02F86B:
	LDA.w #$0004
	STA.w $7AF6,x
	RTS

CODE_02F872:
	LDY.b #$00
	LDA.w $1074
	CMP.w $7182,x
	BEQ.b CODE_02F887
	BPL.b CODE_02F880
	INY
	INY
CODE_02F880:
	LDA.w DATA_02F844,y
	STA.w $7222,x
	RTS

CODE_02F887:
	LDY.w $1072
	LDA.w $79D6,y
	CMP.w #$0025
	BNE.b CODE_02F8A4
	LDA.w #$0010
	STA.w $7A38,x
CODE_02F898:
	DEC
	AND.b $10
	CLC
	ADC.w #$0018
	STA.w $7A96,x
	INC.b $76,x
CODE_02F8A4:
	RTS

DATA_02F8A5:
	db $20,$00,$18,$10,$08

CODE_02F8AA:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02F8FC
	LDY.b $78,x
	CPY.b #$05
	BNE.b CODE_02F8B9
	INC.b $76,x
	RTS

CODE_02F8B9:
	INC.b $78,x
	LDY.b $78,x
	REP.b #$10
	LDA.w DATA_02F8A5-$01,y
	AND.w #$00FF
	CLC
	ADC.w $7362,x
	TAY
	LDA.w $6000,y
	CLC
	ADC.w $6094
	CLC
	ADC.w #$0008
	STA.b $00
	LDA.w $6002,y
	CLC
	ADC.w $609C
	CLC
	ADC.w #$0008
	STA.b $02
	SEP.b #$10
	JSR.w CODE_02F31E
	LDA.b $10
	AND.w #$0007
	CLC
	ADC.w $7A38,x
	STA.w $7A96,x
	LDA.w $7A38,x
	LSR
	STA.w $7A38,x
CODE_02F8FC:
	RTS

;---------------------------------------------------------------------------

CODE_02F8FD:
	RTL

;---------------------------------------------------------------------------

DATA_02F8FE:
	dw CODE_02FA5E,CODE_02FB78,CODE_02FBB8,CODE_02FBE3,CODE_02E48E,CODE_02FA5E,CODE_02FB78

DATA_02F90C:
	dw $0000,$0040,$FFC0

CODE_02F912:
	LDY.w $1072
	LDA.w $7042,y
	STA.w $7042,x
	JSR.w CODE_02F9CC
	JSL.l CODE_03AF23
	LDY.w $1072
	LDA.w $79D6,y
	CMP.w #$001C
	BMI.b CODE_02F986
	CMP.w #$001F
	BNE.b CODE_02F942
	LDY.w $1076
	LDA.w $79D6,y
	LDY.w $1078
	ORA.w $79D6,y
	BEQ.b CODE_02F974
	BRA.b CODE_02F986

CODE_02F942:
	CMP.w #$0020
	BMI.b CODE_02F974
	LDY.b $76,x
	CPY.b #$02
	BPL.b CODE_02F98F
	LDY.b #$02
	STY.b $76,x
	LDY.b #$00
	LDA.w $1074
	CMP.w $7182,x
	BEQ.b CODE_02F963
	PHP
	INY
	INY
	PLP
	BPL.b CODE_02F963
	INY
	INY
CODE_02F963:
	LDA.w DATA_02F90C,y
	STA.w $7222,x
	STZ.w $7542,x
	LDA.w #$0004
	STA.w $7A36,x
	BRA.b CODE_02F98F

CODE_02F974:
	LDA.w $7542,x
	BEQ.b CODE_02F97B
	STA.b $78,x
CODE_02F97B:
	STZ.w $7220,x
	STZ.w $7222,x
	STZ.w $7542,x
	BRA.b CODE_02F9C7

CODE_02F986:
	LDA.b $78,x
	BEQ.b CODE_02F98F
	STA.w $7542,x
	STZ.b $78,x
CODE_02F98F:
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_02F8FE,x)
	JSR.w CODE_02F9F3
	JSR.w CODE_02FA09
	JSR.w CODE_02FA19
	LDY.w $1072
	LDA.w $79D6,y
	CMP.w #$000E
	BEQ.b CODE_02F9B5
	CMP.w #$0016
	BMI.b CODE_02F9C7
	CMP.w #$0019
	BPL.b CODE_02F9C7
CODE_02F9B5:
	LDA.w #$0100
	STA.w $75E2,x
	LDA.b $10
	AND.w #$000F
	CLC
	ADC.w #$0010
	STA.w $7542,x
CODE_02F9C7:
	RTL

DATA_02F9C8:
	dw $0818,$1000

CODE_02F9CC:
	LDA.w $7A38,x
	BEQ.b CODE_02F9F2
	STA.b $02
	REP.b #$10
	LDA.w $7362,x
	STA.b $00
CODE_02F9DA:
	LDY.b $02
	LDA.w DATA_02F9C8-$01,y
	AND.w #$00FF
	CLC
	ADC.b $00
	TAY
	LDA.w #$8000
	STA.w $6000,y
	DEC.b $02
	BNE.b CODE_02F9DA
	SEP.b #$10
CODE_02F9F2:
	RTS

CODE_02F9F3:
	LDA.w $7A98,x
	BNE.b CODE_02FA08
	LDA.w $7402,x
	INC
	AND.w #$0003
	STA.w $7402,x
	LDA.w $7A36,x
	STA.w $7A98,x
CODE_02FA08:
	RTS

CODE_02FA09:
	LDY.b $76,x
	CPY.b #$02
	BPL.b CODE_02FA18
	LDY.w $7D36,x
	BPL.b CODE_02FA18
	JSL.l CODE_03A858
CODE_02FA18:
	RTS

CODE_02FA19:
	LDY.b $76,x
	CPY.b #$05
	BPL.b CODE_02FA41
	LDA.w $70E2,x
	CMP.w #$03A0
	BMI.b CODE_02FA2C
	LDA.w #$039F
	BRA.b CODE_02FA34

CODE_02FA2C:
	CMP.w #$02F0
	BPL.b CODE_02FA41
	LDA.w #$02F0
CODE_02FA34:
	STA.w $70E2,x
	LDA.w $7220,x
	EOR.w #$FFFF
	INC
CODE_02FA3E:
	STA.w $7220,x
CODE_02FA41:
	RTS

DATA_02FA42:
	dw CODE_02FA70,CODE_02FA70,CODE_02FAC7,CODE_02FAC7,CODE_02FAC7,CODE_02FAC7,CODE_02FAC7,CODE_02FAC7
	dw CODE_02FAC7,CODE_02FAC7,CODE_02FAC7,CODE_02FAC7,CODE_02FAC7,CODE_02FAC7

CODE_02FA5E:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02FA6F
	LDY.b $18,x
	LDA.w $79D6,y
	ASL
	TXY
	TAX
	JSR.w (DATA_02FA42,x)
CODE_02FA6F:
	RTS

CODE_02FA70:
	CPX.b #$02
	BMI.b CODE_02FA78
	CPX.b #$0A
	BMI.b CODE_02FA7B
CODE_02FA78:
	TYX
	STZ.b $76,x
CODE_02FA7B:
	TYX
	STZ.w $7400,x
	LDY.w $1072
	LDA.b $10
	PHA
	AND.w #$007F
	SEC
	SBC.w #$0040
	BPL.b CODE_02FA94
	INC.w $7400,x
	INC.w $7400,x
CODE_02FA94:
	CLC
	ADC.w $70E2,y
	STA.w $70E2,x
	PLA
	PHA
	XBA
	AND.w #$001F
	CLC
	ADC.w #$FF70
	STA.w $7222,x
	LDA.w #$0080
	STA.w $75E2,x
	LDA.w #$0002
	STA.w $7542,x
	PLA
	XBA
	AND.w #$0003
	CLC
	ADC.w #$0004
	STA.w $7A36,x
	INC.b $76,x
	RTS

DATA_02FAC3:
	dw $0010,$0030

CODE_02FAC7:
	TYX
	STZ.w $7400,x
	LDA.b $10
	AND.w #$003F
	CLC
	ADC.w #$0040
	LDY.b $18,x
	LDA.w $7220,y
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	CMP.w #$0400
	BMI.b CODE_02FAF2
	LDA.w #$0400
CODE_02FAF2:
	CMP.w #$FC00
	BPL.b CODE_02FAFA
	LDA.w #$FC00
CODE_02FAFA:
	STA.w $7220,x
	BMI.b CODE_02FB05
	LDA.w #$0002
	STA.w $7400,x
CODE_02FB05:
	LDX.b #$00
	LDA.w $70E2,y
	LDY.w $1072
	SEC
	SBC.w $70E2,y
	BPL.b CODE_02FB15
	INX
	INX
CODE_02FB15:
	LDA.b $10
	PHA
	AND.w #$003F
	SEC
	SBC.w DATA_02FAC3,x
	LDX.b $12
	LDY.b $18,x
	CLC
	ADC.w $70E2,y
	STA.w $70E2,x
	LDY.w $1072
	LDA.w $79D6,y
	CMP.w #$000E
	BEQ.b CODE_02FB3F
	CMP.w #$0016
	BMI.b CODE_02FB53
	CMP.w #$0019
	BPL.b CODE_02FB53
CODE_02FB3F:
	PLA
	LDA.w #$FE80
	STA.w $7222,x
	LDA.w #$0003
	STA.w $7A36,x
	LSR
	STA.w $7540,x
	INC.b $76,x
	RTS

CODE_02FB53:
	PLA
	PHA
	XBA
	AND.w #$003F
	CLC
	ADC.w #$FF20
	STA.w $7222,x
	LDA.w #$0100
	STA.w $75E2,x
	LDA.w #$0004
	STA.w $7542,x
	PLA
	AND.w #$0003
	INC
	INC
	STA.w $7A36,x
	INC.b $76,x
	RTS

CODE_02FB78:
	TYX
	LDY.w $7223,x
	BMI.b CODE_02FBB7
	LDA.w $1074
	CLC
	ADC.w #$0018
	CMP.w $7182,x
	BPL.b CODE_02FBB7
	STA.w $7182,x
	LDA.w $7542,x
	CMP.w #$0010
	BPL.b CODE_02FBA9
	LDA.b $10
	AND.w #$007F
	CLC
	ADC.w #$0020
	CMP.w #$0060
	BMI.b CODE_02FBA6
	LDA.w #$0060
CODE_02FBA6:
	STA.w $7A96,x
CODE_02FBA9:
	STZ.w $7222,x
	STZ.w $7542,x
	STZ.w $7220,x
	STZ.w $7540,x
	STZ.b $76,x
CODE_02FBB7:
	RTS

CODE_02FBB8:
	TYX
	LDA.w $1074
	CMP.w $7182,x
	BNE.b CODE_02FBB7
	STZ.w $7222,x
	LDY.w $7402,x
	BNE.b CODE_02FBB7
	LDA.w #$FFFF
	STA.w $7A98,x
	LDY.w $1072
	LDA.w $79D6,y
	CMP.w #$0025
	BMI.b CODE_02FBB7
	LDA.w #$0010
	STA.w $7900,x
	JMP.w CODE_02F898

CODE_02FBE3:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_02FC38
	LDY.w $7A38,x
	CPY.b #$04
	BNE.b CODE_02FBF3
	INC.b $76,x
	RTS

CODE_02FBF3:
	INC.w $7A38,x
	LDY.w $7A38,x
	REP.b #$10
	LDA.w DATA_02F9C8-$01,y
	AND.w #$00FF
	CLC
	ADC.w $7362,x
	TAY
	LDA.w $6000,y
	CLC
	ADC.w $6094
	CLC
	ADC.w #$0008
	STA.b $00
	LDA.w $6002,y
	CLC
	ADC.w $609C
	CLC
	ADC.w #$0008
	STA.b $02
	SEP.b #$10
	JSR.w CODE_02F31E
	LDA.b $10
	AND.w #$0007
	CLC
	ADC.w $7900,x
	STA.w $7A96,x
	LDA.w $7900,x
	LSR
	STA.w $7900,x
CODE_02FC38:
	RTS

DATA_02FC39:
	dw DATA_02FC51,DATA_02FC6A,DATA_02FC83,DATA_02FC9C,DATA_02FCB5,DATA_02FCCE,DATA_02FCE7,DATA_02FD00
	dw DATA_02FD19,DATA_02FD32,DATA_02FD4B,DATA_02FD64

DATA_02FC51:
	db $F6,$FC,$20,$00,$02,$00,$04,$08,$C0,$02,$00,$F4,$08,$40,$02,$09
	db $EA,$08,$80,$02,$09,$DA,$08,$00,$02

DATA_02FC6A:
	db $F7,$FB,$0E,$00,$02,$01,$F4,$28,$C0,$02,$08,$D9,$28,$80,$02,$08
	db $E9,$28,$00,$02,$01,$04,$28,$40,$02

DATA_02FC83:
	db $F8,$FA,$2C,$00,$02,$02,$F4,$22,$40,$02,$07,$D7,$22,$00,$02,$07
	db $E7,$22,$80,$02,$02,$04,$22,$C0,$02

DATA_02FC9C:
	db $F8,$FB,$20,$00,$02,$01,$F4,$28,$C0,$02,$08,$D9,$28,$80,$02,$08
	db $E9,$28,$00,$02,$01,$04,$28,$40,$02

DATA_02FCB5:
	db $FC,$FA,$2E,$00,$02,$02,$F4,$22,$40,$02,$07,$D7,$22,$00,$02,$07
	db $E7,$22,$80,$02,$02,$04,$22,$C0,$02

DATA_02FCCE:
	db $01,$FA,$2E,$00,$02,$04,$F4,$24,$40,$02,$05,$D6,$24,$00,$02,$05
	db $E6,$24,$80,$02,$04,$04,$24,$C0,$02

DATA_02FCE7:
	db $F5,$FC,$20,$00,$02,$FF,$04,$08,$C0,$02,$FF,$F4,$08,$40,$02,$08
	db $EA,$08,$80,$02,$08,$DA,$08,$00,$02

DATA_02FD00:
	db $F6,$FB,$0E,$00,$02,$00,$F4,$28,$C0,$02,$07,$D9,$28,$80,$02,$07
	db $E9,$28,$00,$02,$00,$04,$28,$40,$02

DATA_02FD19:
	db $F7,$FA,$2C,$00,$02,$01,$F4,$22,$40,$02,$06,$D7,$22,$00,$02,$06
	db $E7,$22,$80,$02,$01,$04,$22,$C0,$02

DATA_02FD32:
	db $F5,$FC,$20,$00,$02,$FF,$04,$08,$C0,$02,$FF,$F4,$08,$40,$02,$08
	db $EA,$08,$80,$02,$08,$DA,$08,$00,$02

DATA_02FD4B:
	db $F6,$FB,$0E,$00,$02,$00,$F4,$28,$C0,$02,$07,$D9,$28,$80,$02,$07
	db $E9,$28,$00,$02,$00,$04,$28,$40,$02

DATA_02FD64:
	db $F7,$FA,$2C,$00,$02,$01,$F4,$22,$40,$02,$06,$D7,$22,$00,$02,$06
	db $E7,$22,$80,$02,$01,$04,$22,$C0,$02

DATA_02FD7D:
	dw DATA_02FDB1,DATA_02FDC0,DATA_02FDCF,DATA_02FDD9,DATA_02FDE3,DATA_02FDF7,DATA_02FE0B,DATA_02FE1A
	dw DATA_02FE29,DATA_02FE3D,DATA_02FE56,DATA_02FE6F,DATA_02FE83,DATA_02FE97,DATA_02FEAB,DATA_02FEC4
	dw DATA_02FEDD,DATA_02FEF6,DATA_02FF0F,DATA_02FF28,DATA_02FF41,DATA_02FF5A,DATA_02FF73,DATA_02FF8C
	dw DATA_02FFA5,DATA_02FFBE

DATA_02FDB1:
	db $01,$00,$26,$00,$02,$00,$0C,$3B,$40,$00,$08,$0C,$3A,$40,$00

DATA_02FDC0:
	db $00,$FE,$26,$00,$02,$00,$0C,$0D,$C0,$00,$08,$0C,$0C,$C0,$00

DATA_02FDCF:
	db $00,$FB,$26,$00,$02,$00,$04,$0A,$C0,$02

DATA_02FDD9:
	db $FF,$F6,$26,$00,$02,$00,$04,$2A,$40,$02

DATA_02FDE3:
	db $FF,$F2,$26,$00,$02,$00,$FC,$1D,$40,$00,$08,$FC,$1C,$40,$00,$00
	db $04,$0C,$C0,$02

DATA_02FDF7:
	db $FF,$EE,$26,$00,$02,$08,$FC,$2A,$C0,$00,$00,$FC,$2B,$C0,$00,$00
	db $04,$0A,$C0,$02

DATA_02FE0B:
	db $00,$EC,$26,$00,$02,$00,$04,$08,$C0,$02,$00,$F4,$08,$40,$02

DATA_02FE1A:
	db $02,$E9,$26,$00,$02,$00,$04,$2A,$40,$02,$00,$F4,$0A,$40,$02

DATA_02FE29:
	db $05,$E7,$26,$00,$02,$00,$F4,$0C,$40,$02,$0F,$F3,$0B,$80,$00,$00
	db $04,$0C,$C0,$02

DATA_02FE3D:
	db $06,$E5,$26,$00,$02,$11,$F2,$0B,$80,$00,$09,$F2,$0A,$80,$00,$00
	db $04,$0A,$C0,$02,$00,$F4,$2A,$C0,$02

DATA_02FE56:
	db $08,$E3,$26,$00,$02,$00,$04,$08,$C0,$02,$00,$F4,$08,$40,$02,$11
	db $F2,$09,$80,$00,$09,$F2,$08,$80,$00

DATA_02FE6F:
	db $00,$F4,$0A,$40,$02,$09,$E1,$26,$00,$02,$09,$EA,$2A,$00,$02,$00
	db $04,$2A,$40,$02

DATA_02FE83:
	db $0A,$DE,$26,$00,$02,$09,$EA,$0C,$80,$02,$00,$04,$0C,$C0,$02,$00
	db $F4,$0C,$40,$02

DATA_02FE97:
	db $0A,$DB,$26,$00,$02,$09,$EA,$0A,$80,$02,$00,$04,$0A,$C0,$02,$00
	db $F4,$2A,$C0,$02

DATA_02FEAB:
	db $0A,$D8,$26,$00,$02,$09,$EA,$08,$80,$02,$09,$E2,$18,$00,$02,$00
	db $04,$08,$C0,$02,$00,$F4,$08,$40,$02

DATA_02FEC4:
	db $09,$D5,$26,$00,$02,$09,$EA,$2A,$00,$02,$09,$E2,$1A,$00,$02,$00
	db $04,$2A,$40,$02,$00,$F4,$0A,$40,$02

DATA_02FEDD:
	db $09,$EA,$0C,$80,$02,$08,$D2,$26,$00,$02,$00,$04,$0C,$C0,$02,$00
	db $F4,$0C,$40,$02,$09,$DA,$0C,$00,$02

DATA_02FEF6:
	db $09,$EA,$0A,$80,$02,$06,$CF,$26,$00,$02,$00,$04,$0A,$C0,$02,$00
	db $F4,$2A,$C0,$02,$09,$DA,$2A,$80,$02

DATA_02FF0F:
	db $00,$F4,$08,$40,$02,$04,$CD,$26,$00,$02,$09,$DA,$08,$00,$02,$09
	db $EA,$08,$80,$02,$00,$04,$08,$C0,$02

DATA_02FF28:
	db $04,$CC,$26,$00,$02,$01,$04,$28,$40,$02,$01,$F4,$28,$C0,$02,$08
	db $D9,$28,$80,$02,$08,$E9,$28,$00,$02

DATA_02FF41:
	db $04,$CA,$26,$00,$02,$02,$04,$22,$C0,$02,$02,$F4,$22,$40,$02,$07
	db $D7,$22,$00,$02,$07,$E7,$22,$80,$02

DATA_02FF5A:
	db $04,$C9,$26,$00,$02,$04,$04,$24,$C0,$02,$04,$F4,$24,$40,$02,$05
	db $D6,$24,$00,$02,$05,$E6,$24,$80,$02

DATA_02FF73:
	db $04,$C9,$26,$40,$02,$04,$04,$24,$80,$02,$04,$F4,$24,$00,$02,$03
	db $D6,$24,$40,$02,$03,$E6,$24,$C0,$02

DATA_02FF8C:
	db $04,$CA,$26,$40,$02,$06,$04,$22,$80,$02,$06,$F4,$22,$00,$02,$01
	db $D7,$22,$40,$02,$01,$E7,$22,$C0,$02

DATA_02FFA5:
	db $04,$CC,$26,$40,$02,$07,$04,$28,$00,$02,$07,$F4,$28,$80,$02,$00
	db $D9,$28,$C0,$02,$00,$E9,$28,$40,$02

DATA_02FFBE:
	db $FF,$EA,$08,$C0,$02,$04,$CD,$26,$40,$02,$08,$04,$08,$80,$02,$08
	db $F4,$08,$00,$02,$FF,$DA,$08,$40,$02

%FREE_BYTES(NULLROM, 41, $FF)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro YIBank03Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_038000:
	dl CODE_02E1EB
	dl CODE_02A0E7
	dl CODE_02F8FD
	dl CODE_0D8E60
	dl CODE_02ACFC
	dl CODE_048002
	dl CODE_048428
	dl CODE_048002
	dl CODE_0DFB93
	dl CODE_048002
	dl CODE_03F2FE
	dl CODE_0E8002
	dl CODE_0FAD1F
	dl CODE_02A52C
	dl CODE_0F8000
	dl CODE_0F8135
	dl CODE_06E02B
	dl CODE_11C8F0
	dl CODE_02A125
	dl CODE_02DF55
	dl CODE_02D9B8
	dl CODE_048140
	dl CODE_04B354
	dl CODE_0EDFDE
	dl CODE_04832C
	dl CODE_0484C0
	dl CODE_04868A
	dl CODE_0488BC
	dl CODE_05CB0B
	dl CODE_048655
	dl CODE_0489C0
	dl CODE_0F86EB
	dl CODE_0EC987
	dl CODE_05C46B
	dl CODE_03B742
	dl CODE_03B746
	dl CODE_03B746
	dl CODE_03B759
	dl CODE_0DF8EA
	dl CODE_029FE4
	dl CODE_0EA77F
	dl CODE_03B759
	dl CODE_03B759
	dl CODE_03B759
	dl CODE_0496CC
	dl CODE_0681EF
	dl CODE_0692E5
	dl CODE_0CA07E
	dl CODE_0CA21C
	dl CODE_049BAA
	dl CODE_0CA087
	dl CODE_0CA918
	dl CODE_02848C
	dl CODE_0285EA
	dl CODE_02812D
	dl CODE_049E15
	dl CODE_02908D
	dl CODE_0291C3
	dl CODE_0DB8CA
	dl CODE_0DB8CA
	dl CODE_0F9C0B
	dl CODE_04B11C
	dl CODE_00878A
	dl CODE_068000
	dl CODE_0F8D2F
	dl CODE_0F864B
	dl CODE_02D8C8
	dl CODE_02CF72
	dl CODE_02CF72
	dl CODE_02C7F4
	dl CODE_069760
	dl CODE_0CE5E9
	dl CODE_0CDB06
	dl CODE_04CA61
	dl CODE_04CA61
	dl CODE_04CA61
	dl CODE_0EAAC5
	dl CODE_029381
	dl CODE_02A0BC
	dl CODE_029383
	dl CODE_04A197
	dl CODE_04A31F
	dl CODE_05B421
	dl CODE_0085DC
	dl CODE_059F9F
	dl CODE_04C2B8
	dl CODE_04C2B8
	dl CODE_06F08F
	dl CODE_0EDAFC
	dl CODE_029880
	dl CODE_0FABD7
	dl CODE_0ED847
	dl CODE_0EDAFC
	dl CODE_05FFC4
	dl CODE_04A4B1
	dl CODE_04A4B1
	dl CODE_0E8002
	dl CODE_06BCC8
	dl CODE_0C8364
	dl CODE_05E31D
	dl CODE_04C2A7
	dl CODE_0CEA06
	dl CODE_059F9F
	dl CODE_0F8EAE
	dl CODE_0580C4
	dl CODE_0580C4
	dl CODE_0580C4
	dl CODE_05FE1F
	dl CODE_0582B5
	dl CODE_0DB2EF
	dl CODE_0DB2E9
	dl CODE_0582F7
	dl CODE_058627
	dl CODE_0CD4F5
	dl CODE_0CF18C
	dl CODE_0CEFC4
	dl CODE_04CCB1
	dl CODE_04CE5E
	dl CODE_0DAF50
	dl CODE_0DAF4C
	dl CODE_05D1D7
	dl CODE_05D1D7
	dl CODE_05D1D7
	dl CODE_05D661
	dl CODE_05D8DA
	dl CODE_05D664
	dl CODE_0295BB
	dl CODE_04ACB9
	dl CODE_058CC6
	dl CODE_058E1B
	dl CODE_05917D
	dl CODE_04DB19
	dl CODE_02A517
	dl CODE_01AAE7
	dl CODE_05FFC4
	dl CODE_0F90BF
	dl CODE_029895
	dl CODE_04A6AE
	dl CODE_04A725
	dl CODE_03E8D0
	dl CODE_02AC75
	dl CODE_03ECCB
	dl CODE_0DEAD3
	dl CODE_05974C
	dl CODE_06D1A1
	dl CODE_04D5E9
	dl CODE_05F97A
	dl CODE_02A125
	dl CODE_059B30
	dl CODE_059D95
	dl CODE_059D95
	dl CODE_05F5AD
	dl CODE_05B6DE
	dl CODE_0EB1B2
	dl CODE_0E81C0
	dl CODE_04D1C3
	dl CODE_04D2A5
	dl CODE_0EB5DC
	dl CODE_0EBE94
	dl CODE_05A87C
	dl CODE_0CC8E3
	dl CODE_049CE0
	dl CODE_0EB1B2
	dl CODE_0EC967
	dl CODE_0EC967
	dl CODE_02BF00
	dl CODE_0E8395
	dl CODE_0E83A5
	dl CODE_0E8436
	dl CODE_0E8DFE
	dl CODE_0086E9
	dl CODE_029A57
	dl CODE_0DFBC1
	dl CODE_05DA98
	dl CODE_018002
	dl CODE_03C183
	dl CODE_03C183
	dl CODE_03C183
	dl CODE_03C183
	dl CODE_039A6B
	dl CODE_03C183
	dl CODE_03C07F
	dl CODE_03C179
	dl CODE_03C179
	dl CODE_03C179
	dl CODE_03C1C0
	dl CODE_03C1C0
	dl CODE_03C1C0
	dl CODE_03C1C0
	dl CODE_03C179
	dl CODE_03C1A2
	dl CODE_03C179
	dl CODE_03C179
	dl CODE_03C179
	dl CODE_03C1C0
	dl CODE_03C1C0
	dl CODE_03C1C0
	dl CODE_03C1C0
	dl CODE_03C1C0
	dl CODE_03C1C0
	dl CODE_03C1C0
	dl CODE_03C1C0
	dl CODE_02A09E
	dl CODE_03C1C4
	dl CODE_03C179
	dl CODE_07F1CB
	dl CODE_0DFAC2
	dl CODE_0DF637
	dl CODE_02D926
	dl CODE_02D8C8
	dl CODE_06AA29
	dl CODE_0F9328
	dl CODE_0F98BC
	dl CODE_029B3C
	dl CODE_06E517
	dl CODE_02D149
	dl CODE_029C47
	dl CODE_0EF83C
	dl CODE_0DBB52
	dl CODE_06E944
	dl CODE_0EC8D7
	dl CODE_01A248
	dl CODE_029C8B
	dl CODE_0CCE4D
	dl CODE_0CD064
	dl CODE_0CD122
	dl CODE_0E8E91
	dl CODE_0E8E91
	dl CODE_05E0F8
	dl CODE_0EB1B2
	dl CODE_01AC8E
	dl CODE_05ABB2
	dl CODE_0E93E2
	dl CODE_0E936E
	dl CODE_06B9DA
	dl CODE_06BB7A
	dl CODE_05BE69
	dl CODE_05BE69
	dl CODE_05B99F
	dl CODE_05B9EE
	dl CODE_05BE02
	dl CODE_078000
	dl CODE_078540
	dl CODE_0CFB8F
	dl CODE_0780C3
	dl CODE_0788A7
	dl CODE_0EA472
	dl CODE_0EA131
	dl CODE_0EAAC5
	dl CODE_0EB1B2
	dl CODE_0EB36A
	dl CODE_079025
	dl CODE_07902F
	dl CODE_07CE9D
	dl CODE_07D8D4
	dl CODE_079628
	dl CODE_04C89A
	dl CODE_0D8002
	dl CODE_0D8002
	dl CODE_04DAE9
	dl CODE_0CB636
	dl CODE_0D834D
	dl CODE_0D8352
	dl CODE_01AE18
	dl CODE_04CFDD
	dl CODE_0DC171
	dl CODE_0DC171
	dl CODE_0DC171
	dl CODE_0D89FF
	dl CODE_01AE76
	dl CODE_0D8E60
	dl CODE_05DC74
	dl CODE_0EB54E
	dl CODE_01A5C9
	dl CODE_01AA9D
	dl CODE_0793FA
	dl CODE_079591
	dl CODE_04C968
	dl CODE_04AF9E
	dl CODE_04CB46
	dl CODE_04CB46
	dl CODE_05EA0A
	dl CODE_079FD0
	dl CODE_07A67A
	dl CODE_0DBD3B
	dl CODE_0EB1B2
	dl CODE_05F07F
	dl CODE_05F07F
	dl CODE_05F3F0
	dl CODE_04CC24
	dl CODE_05C46B
	dl CODE_05C46B
	dl CODE_0490F1
	dl CODE_03E3B7
	dl CODE_0D9439
	dl CODE_0D9770
	dl CODE_0DF037
	dl CODE_03F59E
	dl CODE_0489B3
	dl CODE_07ADD7
	dl CODE_0CF38B
	dl CODE_0CFA4B
	dl CODE_06B933
	dl CODE_07AB51
	dl CODE_07AC5F
	dl CODE_02A0D4
	dl CODE_0693E6
	dl CODE_0489C0
	dl CODE_0DC50C
	dl CODE_0D983D
	dl CODE_0D983D
	dl CODE_029E55
	dl CODE_029E55
	dl CODE_029E55
	dl CODE_029E55
	dl CODE_02D03F
	dl CODE_0D9A1A
	dl CODE_07B052
	dl CODE_07B1B6
	dl CODE_07B28E
	dl CODE_07B28E
	dl CODE_05F6DE
	dl CODE_05F6DE
	dl CODE_07BE90
	dl CODE_0D9D2E
	dl CODE_07B6A3
	dl CODE_07B6AC
	dl CODE_02D922
	dl CODE_0582B5
	dl CODE_07B9A4
	dl CODE_07B9A9
	dl CODE_07B9AE
	dl CODE_07B9B3
	dl CODE_07B9B8
	dl CODE_07B9BD
	dl CODE_07B9C2
	dl CODE_07B9C7
	dl CODE_07B9EE
	dl CODE_07BB20
	dl CODE_0E942D
	dl CODE_0DA097
	dl CODE_0E9A9B
	dl CODE_0EB839
	dl CODE_07C2D6
	dl CODE_0E9AA1
	dl CODE_07C6A6
	dl CODE_07C6CB
	dl CODE_07C968
	dl CODE_0DA513
	dl CODE_0DA513
	dl CODE_04C244
	dl CODE_0DA560
	dl CODE_0DA560
	dl CODE_0F927C
	dl CODE_0DA8C7
	dl CODE_0F9111
	dl CODE_0F8B5B
	dl CODE_0F8B36
	dl CODE_07EB4C
	dl CODE_07D956
	dl CODE_07D956
	dl CODE_07DD52
	dl CODE_07DD52
	dl CODE_07DD78
	dl CODE_07DD78
	dl CODE_07E487
	dl CODE_07E4D1
	dl CODE_07E520
	dl CODE_07E7B5
	dl CODE_02E494
	dl CODE_02F37F
	dl CODE_07F19B
	dl CODE_07F196
	dl CODE_07F191
	dl CODE_07F18C
	dl CODE_07F139
	dl CODE_07F125
	dl CODE_07F11D
	dl CODE_07F118
	dl CODE_07F187
	dl CODE_07F182
	dl CODE_07F17D
	dl CODE_07F1FB
	dl CODE_07FB24
	dl CODE_0DBA11
	dl CODE_0F8370
	dl CODE_0F89F9
	dl CODE_0F8A93
	dl CODE_0C9306
	dl CODE_04A872
	dl CODE_04A872
	dl CODE_04A872
	dl CODE_04A872
	dl CODE_04A88A
	dl CODE_04A88A
	dl CODE_04A88A
	dl CODE_04A88A
	dl CODE_04A88A
	dl CODE_04A88A
	dl CODE_04AA24
	dl CODE_0C800C
	dl CODE_0F8F53
	dl CODE_049481
	dl CODE_06D9C0
	dl CODE_0C905A
	dl CODE_0C863E
	dl CODE_0C8671
	dl CODE_0F899D
	dl CODE_0F8972
	dl CODE_0C88E6
	dl CODE_0C8B61
	dl CODE_0C970A
	dl CODE_0C99B5
	dl CODE_0C9B6C
	dl CODE_0C9CF3
	dl CODE_0C9D6C
	dl CODE_0CA00F
	dl CODE_0CA00F
	dl CODE_0CB530
	dl CODE_0CB304
	dl CODE_07FDBF
	dl CODE_02AD90
	dl CODE_02ADF7
	dl CODE_02AE2B
	dl CODE_02AE70
	dl CODE_02AE07
	dl CODE_0CB914
	dl CODE_0CBE98
	dl CODE_0F917C
	dl CODE_0CC369
	dl CODE_0CC796
	dl CODE_0CE961
	dl CODE_0CEB10
	dl CODE_11B088
	dl CODE_11B23B
	dl CODE_11B317
	dl CODE_11A08D
	dl CODE_11A77A
	dl CODE_11A0E6
	dl CODE_11BA69
	dl CODE_11C44B
	dl CODE_11C640

DATA_03852E:
	dl CODE_02E26A
	dl CODE_02A330
	dl CODE_02F912
	dl CODE_0D8EBE
	dl CODE_02AD0A
	dl CODE_048031
	dl CODE_048429
	dl CODE_048031
	dl CODE_0DFB94
	dl CODE_048031
	dl CODE_03F331
	dl CODE_0E8019
	dl CODE_0FAD27
	dl CODE_02A617
	dl CODE_0F8019
	dl CODE_0F8174
	dl CODE_06E047
	dl CODE_11C9A0
	dl CODE_02A330
	dl CODE_02DF7A
	dl CODE_02DA0E
	dl CODE_04816B
	dl CODE_04B4EA
	dl CODE_0EE023
	dl CODE_04833D
	dl CODE_04850D
	dl CODE_048707
	dl CODE_0488DC
	dl CODE_05CB64
	dl CODE_048707
	dl CODE_048A58
	dl CODE_0F8797
	dl CODE_0EC9AD
	dl CODE_05C8B6
	dl CODE_03B86E
	dl CODE_03B872
	dl CODE_03B872
	dl CODE_03B872
	dl CODE_0DF8FB
	dl CODE_02A04A
	dl CODE_0EA792
	dl CODE_03B7B4
	dl CODE_03B872
	dl CODE_03B872
	dl CODE_0496FA
	dl CODE_0683CA
	dl CODE_0692E6
	dl CODE_0CA082
	dl CODE_0CA2C7
	dl CODE_049C0A
	dl CODE_0CA0B4
	dl CODE_0CA98E
	dl CODE_0284F6
	dl CODE_0285EB
	dl CODE_028209
	dl CODE_049E30
	dl CODE_0290E6
	dl CODE_029235
	dl CODE_0DB918
	dl CODE_0DB918
	dl CODE_0F9C58
	dl CODE_04B15B
	dl CODE_00878E
	dl CODE_0683CA
	dl CODE_0F8DB1
	dl CODE_0F865F
	dl CODE_02D8E7
	dl CODE_02CFA6
	dl CODE_02CFA6
	dl CODE_02C950
	dl CODE_0699DC
	dl CODE_0CE658
	dl CODE_0CDB6C
	dl CODE_04CA62
	dl CODE_04CAFE
	dl CODE_04CAFE
	dl CODE_0EAAF0
	dl CODE_029382
	dl CODE_02A330
	dl CODE_02938E
	dl CODE_04A1B4
	dl CODE_04A342
	dl CODE_05B4CC
	dl CODE_0085E5
	dl CODE_059FE6
	dl CODE_04C2F6
	dl CODE_04C2F6
	dl CODE_06F0C2
	dl CODE_0EDB40
	dl CODE_0298F4
	dl CODE_0FABE5
	dl CODE_0ED8B9
	dl CODE_0EDB40
	dl CODE_05FFC4
	dl CODE_04A4D5
	dl CODE_04A4D5
	dl CODE_0E8023
	dl CODE_06BCEC
	dl CODE_0C8369
	dl CODE_05E346
	dl CODE_04C2F6
	dl CODE_0CEA40
	dl CODE_059FE6
	dl CODE_0F8EEB
	dl CODE_0580DD
	dl CODE_0580E1
	dl CODE_0580E1
	dl CODE_05FE6E
	dl CODE_058325
	dl CODE_0DB316
	dl CODE_0DB316
	dl CODE_058320
	dl CODE_058648
	dl CODE_0CD545
	dl CODE_0CF1D5
	dl CODE_0CF005
	dl CODE_04CCD3
	dl CODE_04CE70
	dl CODE_0DAF7E
	dl CODE_0DAF7E
	dl CODE_05D246
	dl CODE_05D246
	dl CODE_05D246
	dl CODE_05D665
	dl CODE_05D8E6
	dl CODE_05D6ED
	dl CODE_0295D3
	dl CODE_04ACD3
	dl CODE_058CDA
	dl CODE_058CDA
	dl CODE_0591DA
	dl CODE_04DB2B
	dl CODE_02A518
	dl CODE_01AAEC
	dl CODE_05FFC4
	dl CODE_0F90C0
	dl CODE_0298F4
	dl CODE_04A6F8
	dl CODE_04A752
	dl CODE_03E925
	dl CODE_02AC86
	dl CODE_03ED20
	dl CODE_0DEB70
	dl CODE_059775
	dl CODE_06D1C7
	dl CODE_04D5FC
	dl CODE_05F981
	dl CODE_02A330
	dl CODE_059B4E
	dl CODE_059DBC
	dl CODE_059DBC
	dl CODE_05F5D2
	dl CODE_05B75A
	dl CODE_0EB1B3
	dl CODE_0E81D1
	dl CODE_04D20C
	dl CODE_04D2B1
	dl CODE_0EB601
	dl CODE_0EBED5
	dl CODE_05A8B3
	dl CODE_0CC91D
	dl CODE_049CE5
	dl CODE_0EB1BE
	dl CODE_0EC9AD
	dl CODE_0EC9AD
	dl CODE_02BF91
	dl CODE_0E8456
	dl CODE_0E8BE4
	dl CODE_0E8456
	dl CODE_0E8E08
	dl CODE_00872A
	dl CODE_029A58
	dl CODE_0DFBC2
	dl CODE_05DAC3
	dl CODE_018A14
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_039F4E
	dl CODE_03C2BF
	dl CODE_03C08C
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_02A330
	dl CODE_03C2BF
	dl CODE_03C2BF
	dl CODE_07F2F1
	dl CODE_0DFB1D
	dl CODE_0DF6FE
	dl CODE_02D95C
	dl CODE_02D8DE
	dl CODE_06AA8B
	dl CODE_0F933F
	dl CODE_0F98BD
	dl CODE_029B45
	dl CODE_06E530
	dl CODE_02D195
	dl CODE_029C87
	dl CODE_0EF86F
	dl CODE_0DBB80
	dl CODE_06E961
	dl CODE_0EC8F2
	dl CODE_01A2D5
	dl CODE_029CEB
	dl CODE_0CCE83
	dl CODE_0CD093
	dl CODE_0CD154
	dl CODE_0E8F79
	dl CODE_0E8F79
	dl CODE_05E13D
	dl CODE_0EB1B3
	dl CODE_01AD17
	dl CODE_05ACAE
	dl CODE_0E951E
	dl CODE_0E951E
	dl CODE_06BA33
	dl CODE_06BBD3
	dl CODE_05BEB2
	dl CODE_05BEB2
	dl CODE_05B9C8
	dl CODE_05B9FC
	dl CODE_05BE03
	dl CODE_078020
	dl CODE_07858F
	dl CODE_0CFC37
	dl CODE_0780F3
	dl CODE_0788D3
	dl CODE_0EA4F5
	dl CODE_0EA140
	dl CODE_0EAAF0
	dl CODE_0EB1B3
	dl CODE_0EB3AC
	dl CODE_079090
	dl CODE_079090
	dl CODE_07CEB0
	dl CODE_07D8F3
	dl CODE_079635
	dl CODE_04C89B
	dl CODE_0D8031
	dl CODE_0D8031
	dl CODE_04DAF6
	dl CODE_0CB6AC
	dl CODE_0D84AB
	dl CODE_0D84AB
	dl CODE_01AE19
	dl CODE_04CFF9
	dl CODE_0DC1A5
	dl CODE_0DC1A5
	dl CODE_0DC1A5
	dl CODE_0D8AF1
	dl CODE_01AE95
	dl CODE_0D8EBE
	dl CODE_05DCBE
	dl CODE_0EB55F
	dl CODE_01A5EC
	dl CODE_01AA9E
	dl CODE_079410
	dl CODE_07959B
	dl CODE_04C97B
	dl CODE_04AFC0
	dl CODE_04CB7C
	dl CODE_04CB7C
	dl CODE_05EA2B
	dl CODE_079FDC
	dl CODE_07A702
	dl CODE_0DBD50
	dl CODE_0EB1B3
	dl CODE_05F09F
	dl CODE_05F09F
	dl CODE_05F436
	dl CODE_04CC45
	dl CODE_05C4AD
	dl CODE_05C4AD
	dl CODE_049147
	dl CODE_03E409
	dl CODE_0D94F5
	dl CODE_0D9771
	dl CODE_0DF038
	dl CODE_03F5B7
	dl CODE_048A58
	dl CODE_07AE68
	dl CODE_0CF42B
	dl CODE_0CFA6E
	dl CODE_06B950
	dl CODE_07AB9C
	dl CODE_07ACD2
	dl CODE_02A330
	dl CODE_069401
	dl CODE_048A58
	dl CODE_0DC55B
	dl CODE_0D9879
	dl CODE_0D9879
	dl CODE_029E8F
	dl CODE_029E8F
	dl CODE_029E8F
	dl CODE_029E8F
	dl CODE_02D040
	dl CODE_0D9A25
	dl CODE_07B059
	dl CODE_07B1FC
	dl CODE_07B2F3
	dl CODE_07B310
	dl CODE_05F74E
	dl CODE_05F74E
	dl CODE_07BEFC
	dl CODE_0D9D49
	dl CODE_07B6DC
	dl CODE_07B6DC
	dl CODE_02D95C
	dl CODE_058325
	dl CODE_07BA31
	dl CODE_07BA31
	dl CODE_07BA31
	dl CODE_07BA31
	dl CODE_07BA31
	dl CODE_07BA31
	dl CODE_07BA31
	dl CODE_07BA31
	dl CODE_07BA3D
	dl CODE_07BB61
	dl CODE_0E951E
	dl CODE_0DA0FE
	dl CODE_0E9B38
	dl CODE_0EB92E
	dl CODE_07C344
	dl CODE_0E9B38
	dl CODE_07C6EC
	dl CODE_07C700
	dl CODE_07C9C8
	dl CODE_0DA527
	dl CODE_0DA527
	dl CODE_04C2F6
	dl CODE_0DA5BA
	dl CODE_0DA5BA
	dl CODE_0F92A1
	dl CODE_0DA8F1
	dl CODE_0F9116
	dl CODE_0F8BA9
	dl CODE_0F8B8D
	dl CODE_07EBAE
	dl CODE_07D964
	dl CODE_07D964
	dl CODE_07DDA1
	dl CODE_07DDA1
	dl CODE_07DDD9
	dl CODE_07DDD9
	dl CODE_07E55A
	dl CODE_07E5D9
	dl CODE_07E64F
	dl CODE_07E7D6
	dl CODE_02E57F
	dl CODE_02F3A4
	dl CODE_07F2B2
	dl CODE_07F2B2
	dl CODE_07F2B2
	dl CODE_07F2B2
	dl CODE_07F2D1
	dl CODE_07F333
	dl CODE_07F333
	dl CODE_07F333
	dl CODE_07F2F1
	dl CODE_07F2F1
	dl CODE_07F310
	dl CODE_07F391
	dl CODE_07FB3D
	dl CODE_0DBA26
	dl CODE_0F839E
	dl CODE_0F8A17
	dl CODE_0F8AE9
	dl CODE_0C930E
	dl CODE_04A8B8
	dl CODE_04A8B8
	dl CODE_04A8B8
	dl CODE_04A8B8
	dl CODE_04A8B8
	dl CODE_04A8B8
	dl CODE_04A8B8
	dl CODE_04A8B8
	dl CODE_04A8B8
	dl CODE_04A8B8
	dl CODE_04AA32
	dl CODE_0C8016
	dl CODE_0F8F64
	dl CODE_049490
	dl CODE_06D9CD
	dl CODE_0C9080
	dl CODE_0C86BD
	dl CODE_0C87D1
	dl CODE_0F89E4
	dl CODE_0F89E4
	dl CODE_0C890B
	dl CODE_0C8BAF
	dl CODE_0C971D
	dl CODE_0C9A13
	dl CODE_0C9B8A
	dl CODE_0C9CFD
	dl CODE_0C9DF4
	dl CODE_0CA03C
	dl CODE_0CA03C
	dl CODE_0CB537
	dl CODE_0CB36A
	dl CODE_07FDE4
	dl CODE_02AF11
	dl CODE_02AF11
	dl CODE_02AF11
	dl CODE_02AF11
	dl CODE_02AF11
	dl CODE_0CBA2C
	dl CODE_0CBED6
	dl CODE_0F918C
	dl CODE_0CC39B
	dl CODE_0CC797
	dl CODE_0CE98B
	dl CODE_0CEBBA
	dl CODE_11B125
	dl CODE_11B24D
	dl CODE_11B32A
	dl CODE_11A111
	dl CODE_11A790
	dl CODE_11A175
	dl CODE_11BB10
	dl CODE_11C460
	dl CODE_11C679

DATA_038A5C:
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_0EF7CE
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_049087
	dl CODE_039A6B
	dl CODE_0ED83D
	dl CODE_039A6B
	dl CODE_039F9B
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_0ED83D
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_0C858D
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_05D8B6
	dl CODE_05D8B6
	dl CODE_05D8D6
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039FED
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_0ED83D
	dl CODE_0ED83D
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_0F933F
	dl CODE_0F98BD
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_0EFF20
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_06BB3E
	dl CODE_06BC9A
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_07882D
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_07D857
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_07AAEC
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_0CF848
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_049087
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_07B8B9
	dl CODE_07B8B9
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_07C689
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_07F03E
	dl CODE_07E3C8
	dl CODE_07E3C8
	dl CODE_07E3BD
	dl CODE_07E3BD
	dl CODE_07E3DF
	dl CODE_07E3F9
	dl CODE_07E730
	dl CODE_07E74D
	dl CODE_07E74D
	dl CODE_07EB45
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_0F8636
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_0C8FE3
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_0C9C48
	dl CODE_039A6B
	dl CODE_0C9FDE
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_0CC2A4
	dl CODE_039A6B
	dl CODE_0CC795
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039F9F
	dl CODE_039A6B
	dl CODE_039A6B

DATA_038F8A:
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_04A0AB
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_06CF1A
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_049094
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_0DE9F9
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B
	dl CODE_039A6B

;---------------------------------------------------------------------------

CODE_0394B8:
	REP.b #$30
	LDX.w #$009C
	LDA.w #$00FF
CODE_0394C0:
	STZ.w $6EC0,x
	STA.w $7462,x
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_0394C0
	SEP.b #$30
	RTL

;---------------------------------------------------------------------------

CODE_0394CF:
	REP.b #$20
	BRA.b CODE_0394F3

CODE_0394D3:
	LDA.w $7E2A
	BNE.b CODE_039505
	REP.b #$20
	LDA.w $021A
	CMP.w #$000B
	BEQ.b CODE_0394F6
	CMP.w #$0032
	BEQ.b CODE_0394EC
	CMP.w #$0038
	BNE.b CODE_0394F3
CODE_0394EC:
	LDY.w $60AE
	CPY.b #$0E
	BEQ.b CODE_0394F6
CODE_0394F3:
	LDA.w #$0000
CODE_0394F6:
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDX.b #FXCODE_098925>>16
	LDA.w #FXCODE_098925
	JSL.l $7EDECF
	SEP.b #$20
	RTL

CODE_039505:
	SEP.b #$20
	LDX.b #$17
	LDY.b #$5C
CODE_03950B:
	LDA.w $0C98,x
	BEQ.b CODE_03951A
	LDA.w $7040,y
	STA.b $00,x
	AND.b #$F3
	STA.w $7040,y
CODE_03951A:
	DEY
	DEY
	DEY
	DEY
	DEX
	BPL.b CODE_03950B
	REP.b #$20
	LDA.w $021A
	SEC
	SBC.w #$000B
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDX.b #FXCODE_098925>>16
	LDA.w #FXCODE_098925
	JSL.l $7EDECF
	SEP.b #$20
	LDX.b #$17
	LDY.b #$5C
CODE_03953C:
	LDA.w $0C98,x
	BEQ.b CODE_039546
	LDA.b $00,x
	STA.w $7040,y
CODE_039546:
	DEY
	DEY
	DEY
	DEY
	DEX
	BPL.b CODE_03953C
	RTL

;---------------------------------------------------------------------------

CODE_03954E:
	PHB
	PHK
	PLB
	PHD
	REP.b #$20
	LDA.w #$7960
	TCD
	LDY.b #$3C
	STY.w $7E4A
	LDA.w $0039
	STA.b $0E
	SEC
	SBC.w #$0160
	STA.w $0039
	STZ.w $0073
CODE_03956C:
	LDA.w $0039
	CLC
	ADC.w #$0010
	STA.w $0039
	JSR.w CODE_039596
	LDA.w $0039
	CMP.b $0E
	BNE.b CODE_03956C
	LDA.w #$4000
	STA.w $60A4
	STA.w $60A6
	SEP.b #$20
	PLD
	PLB
	RTL

DATA_03958E:
	dw $0120,$FFD0

DATA_039592:
	dw $0110,$FFE0

CODE_039596:
	LDX.w $0073
	LDA.w $0039
	CLC
	ADC.w DATA_03958E,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $003B
	SEC
	SBC.w #$0020
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.w $0075
	LDA.w $003B
	CLC
	ADC.w DATA_039592,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $0039
	SEC
	SBC.w #$0030
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDX.b #FXCODE_098000>>16
	LDA.w #FXCODE_098000
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	LDX.w #$0000
CODE_0395D2:
	LDA.l $7027CE,x
	BPL.b CODE_0395DB
	SEP.b #$10
	RTS

CODE_0395DB:
	SEC
	SBC.w #$01BA
	BCC.b CODE_0395E9
	JSR.w CODE_03979E
	BCC.b CODE_039640
	JMP.w CODE_03977F

CODE_0395E9:
	LDA.w $7E2A
	BEQ.b CODE_03962F
	TXY
	LDA.l $7027CE,x
	ASL
	TAX
	LDA.l FXDATA_0A971E,x
	TYX
	AND.w #$6000
	BNE.b CODE_03962F
	LDA.w $7E2A
	INC
	BEQ.b CODE_039640
	LDA.l $7027D0,x
	ASL
	ASL
	ASL
	ASL
	SEC
	SBC.w $608C
	CLC
	ADC.w #$0060
	CMP.w #$00C1
	BCS.b CODE_03962F
	LDA.l $7027D2,x
	ASL
	ASL
	ASL
	ASL
	SEC
	SBC.w $6090
	CLC
	ADC.w #$0060
	CMP.w #$00C1
	BCC.b CODE_039640
CODE_03962F:
	LDY.w #$005C
CODE_039632:
	LDA.w $6F00,y
	BEQ.b CODE_039654
	DEY
	DEY
	DEY
	DEY
	CPY.w #$0018
	BCS.b CODE_039632
CODE_039640:
	TXY
	SEP.b #$30
	LDA.l $7027D4,x
	TAX
	LDA.b #$00
	STA.l $7028CA,x
	REP.b #$30
	TYX
	JMP.w CODE_03977F

CODE_039654:
	LDA.l $7027D0,x
	ASL
	ASL
	ASL
	ASL
	STA.w $70E2,y
	LDA.l $7027D2,x
	ASL
	ASL
	ASL
	ASL
	STA.w $7182,y
	LDA.w #$0000
	STA.w $7D96,y
	STA.w $7220,y
	STA.w $7222,y
	STA.w $7976,y
	STA.w $70E0,y
	STA.w $7D36,y
	STA.w $7978,y
	STA.w $79D6,y
	STA.w $79D8,y
	STA.w $7A36,y
	STA.w $7A38,y
	STA.w $7900,y
	STA.w $7902,y
	STA.w $7A96,y
	STA.w $7A98,y
	STA.w $7AF6,y
	STA.w $7AF8,y
	STA.w $7402,y
	STA.w $7860,y
	STA.w $6F02,y
	STA.w $7D38,y
	STA.w $7720,y
	STA.w $7680,y
	STA.w $7682,y
	STA.w $7540,y
	STA.w $75E0,y
	STA.w $77C0,y
	DEC
	STA.w $7362,y
	STA.w $7722,y
	LDA.w #$1FFF
	STA.w $7862,y
	LDA.l $7027CE,x
	STA.w $7360,y
	PHX
	ASL
	TAX
	SEP.b #$20
	PHY
	LDA.l FXDATA_0AA716,x
	LDY.w #$0006
CODE_0396DF:
	CMP.w $6EB5,y
	BEQ.b CODE_0396EA
	DEY
	BNE.b CODE_0396DF
	TYA
	BRA.b CODE_0396EF

CODE_0396EA:
	TYA
	ADC.b #$06
	ASL
	ASL
CODE_0396EF:
	REP.b #$20
	AND.w #$00FF
	PLY
	STA.w $7180,y
	LDA.l FXDATA_0A9F1A+$01,x
	AND.w #$00FF
	EOR.w #$0020
	STA.w $7042,y
	LDA.l FXDATA_0A9F1A,x
	AND.w #$00FF
	STA.w $74A2,y
	LDA.l FXDATA_0AA318-$01,x
	AND.w #$FF00
	BPL.b CODE_03971B
	ORA.w #$00FF
CODE_03971B:
	XBA
	STA.w $7542,y
	LDA.l FXDATA_0AA318,x
	AND.w #$FF00
	BPL.b CODE_03972B
	ORA.w #$00FF
CODE_03972B:
	XBA
	ASL
	ASL
	ASL
	ASL
	STA.w $75E2,y
	LDA.l FXDATA_0A9B1C,x
	STA.w $7040,y
	LDA.l FXDATA_0A971E,x
	STA.w $6FA2,y
	LDA.l FXDATA_0A9320,x
	STA.w $6FA0,y
	AND.w #$001F
	ASL
	ASL
	ASL
	TAX
	LDA.l FXDATA_0A9220,x
	STA.w $7B56,y
	LDA.l FXDATA_0A9220+$02,x
	STA.w $7B58,y
	LDA.l FXDATA_0A9220+$04,x
	STA.w $7BB6,y
	LDA.l FXDATA_0A9220+$06,x
	STA.w $7BB8,y
	PLX
	LDA.w $0073
	STA.w $7400,y
	LDA.w #$0002
	STA.w $6F00,y
	LDA.l $7027D4,x
	STA.w $74A0,y
CODE_03977F:
	TXA
	CLC
	ADC.w #$0008
	TAX
	JMP.w CODE_0395D2

;---------------------------------------------------------------------------

CODE_039788:
	PHB
	PHK
	PLB
	SEC
	SBC.w #$01BA
	REP.b #$10
	JSR.w CODE_03979E
	SEP.b #$10
	LDA.w #$00FF
	STA.w $0C0C,y
	PLB
	RTL

CODE_03979E:
	PHX
	LDY.w #$0006
CODE_0397A2:
	LDX.w $0C04,y
	BEQ.b CODE_0397AE
	DEY
	DEY
	BPL.b CODE_0397A2
	PLX
	CLC
	RTS

CODE_0397AE:
	INC
	STA.w $0C04,y
	ASL
	PLX
	PHX
	PHA
	LDA.l $7027D4,x
	STA.w $0C0C,y
	LDA.l $7027D0,x
	STA.w $7960
	LDA.l $7027D2,x
	STA.w $7962
	PLA
	TAX
	JSR.w (DATA_03D46F-$02,x)
	PLX
	SEC
	RTS

;---------------------------------------------------------------------------

CODE_0397D3:
	PHB
	PHK
	PLB
	PHD
	REP.b #$20
	LDA.w #$7960
	TCD
	BRA.b CODE_0397EC

CODE_0397DF:
	PHB
	PHK
	PLB
	PHD
	REP.b #$20
	LDA.w #$7960
	TCD
	JSR.w CODE_039596
CODE_0397EC:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_039802
	INC.b $14
	LDX.b #FXCODE_09884C>>16
	LDA.w #FXCODE_09884C
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
CODE_039802:
	STZ.w $607A
	LDA.w #$29CC
	STA.l $7029CA
	LDX.b #FXCODE_0ACFED>>16
	LDA.w #FXCODE_0ACFED
	JSL.l $7EDECF
	LDA.w #$0008
	STA.w $6120
	CLC
	ADC.w $608C
	STA.w $611C
	LDA.w #$000C
	LDX.w $60AE
	CPX.b #$08
	BNE.b CODE_03984D
	LDY.w $6180
	BEQ.b CODE_039855
	LDA.w #$0004
	STA.w $6120
	STA.w $6122
	LDA.w #$00FF
	LDY.w $60C4
	BEQ.b CODE_039843
	LSR
CODE_039843:
	EOR.w $617E
	INC
	TAY
	LDA.w #$0015
	BRA.b CODE_039874

;---------------------------------------------------------------------------

CODE_03984D:
	LDY.w $60C2
	BEQ.b CODE_039855
	LDA.w #$0006
CODE_039855:
	STA.w $6122
	CPX.b #$10
	BNE.b CODE_039886
	LDY.w $6180
	BEQ.b CODE_039886
	INC.w $6122
	LDA.w $617E
	LDY.w $60C4
	BNE.b CODE_039870
	EOR.w #$00FF
	INC
CODE_039870:
	TAY
	LDA.w #$0021
CODE_039874:
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	TYA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_09F83A>>16
	LDA.w #FXCODE_09F83A
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	BRA.b CODE_039895

CODE_039886:
	SEC
	SBC.w #$0020
	EOR.w #$FFFF
	INC
	CLC
	ADC.w $6090
	STA.w $611E
CODE_039895:
	LDX.b #FXCODE_098084>>16
	LDA.w #FXCODE_098084
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w $607A
	BEQ.b CODE_0398A7
	JSL.l CODE_0085D2
CODE_0398A7:
	JSL.l CODE_008AB6
	LDA.w $7E2A
	DEC
	BMI.b CODE_0398B7
	LDA.w #$FFF8
	STA.w $7E2A
CODE_0398B7:
	STZ.w $0CC2
	STZ.w $61BA
	LDA.w #$FFFF
	STA.w $0D96
	LDX.b #$5C
CODE_0398C5:
	LDA.w $6F00,x
	BEQ.b CODE_0398DF
	STX.b $12
	PHB
	LDY.w !REGISTER_SoftwareLatchForHVCounter
	LDY.w !REGISTER_PPUStatusFlag2
	LDA.w !REGISTER_HCounter
	ADC.b $10
	STA.b $10
	JSL.l CODE_039A12
	PLB
CODE_0398DF:
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_0398C5
	LDY.w $0C50
	BEQ.b CODE_0398F7
	LDY.w $0C54
	CPY.b #$30
	BMI.b CODE_0398F4
	STZ.w $0C54
CODE_0398F4:
	INC.w $0C54
CODE_0398F7:
	REP.b #$10
	LDY.w #$0006
CODE_0398FC:
	LDA.w $0C04,y
	BEQ.b CODE_039906
	ASL
	TAX
	JSR.w (DATA_03D4E3,x)
CODE_039906:
	DEY
	DEY
	BPL.b CODE_0398FC
	SEP.b #$10
	LDA.w $7E2A
	BPL.b CODE_039953
	LDA.w $0D0F
	BNE.b CODE_039938
	INC.w $7E2A
	BPL.b CODE_039956
	LDA.w $60B0
	CMP.w #$0038
	BMI.b CODE_039938
	CMP.w #$00B8
	BPL.b CODE_039938
	LDA.w $60B2
	CMP.w #$0040
	BMI.b CODE_039938
	CMP.w #$0080
	BPL.b CODE_039938
	JMP.w CODE_0399BF

CODE_039938:
	LDA.w #$0001
	STA.w $61AE
	STA.w $61B0
	STA.w $0C1E
	STA.w $0C20
	LDA.w $0039
	STA.w $0C23
	LDA.w $003B
	STA.w $0C27
CODE_039953:
	JMP.w CODE_0399CE

CODE_039956:
	DEC.w $7E2A
	LDA.w $0C94
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $0C96
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $0C23
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $0C27
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0600
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_09907C>>16
	LDA.w #FXCODE_09907C
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w $0C2A
	LDA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	STA.w $0C2C
	REP.b #$10
	JSR.w CODE_03D997
	SEP.b #$10
	LDA.w $0C94
	SEC
	SBC.w $0C23
	BEQ.b CODE_0399A7
	EOR.w $0C2A
	BPL.b CODE_0399CE
	LDA.w $0C94
	STA.w $0C23
CODE_0399A7:
	LDA.w $0C96
	SEC
	SBC.w $0C27
	BEQ.b CODE_0399BB
	EOR.w $0C2C
	BPL.b CODE_0399CE
	LDA.w $0C96
	STA.w $0C27
CODE_0399BB:
	JSL.l CODE_04DCF9
CODE_0399BF:
	STZ.w $7E2A
	STZ.w $61AE
	STZ.w $61B0
	STZ.w $0C1E
	STZ.w $0C20
CODE_0399CE:
	SEP.b #$20
	PLD
	PLB
	RTL

;---------------------------------------------------------------------------

DATA_0399D3:
	LDA.w $7E35
	AND.w #$FF00
	CLC
	ADC.w $7E32
	STA.w $7E32
	LDA.w $7E36
	AND.w #$FF00
	BPL.b CODE_0399EB
	ORA.w #$00FF
CODE_0399EB:
	XBA
	ADC.w $7E2E
	STA.w $7E2E
	LDA.w $7E37
	AND.w #$FF00
	CLC
	ADC.w $7E34
	STA.w $7E34
	LDA.w $7E38
	AND.w #$FF00
	BPL.b CODE_039A0A
	ORA.w #$00FF
CODE_039A0A:
	XBA
	ADC.w $7E30
	STA.w $7E30
	RTS

;---------------------------------------------------------------------------

CODE_039A12:
	LDA.w $70E2,x
	STA.w $6EBC
	LDA.w $7182,x
	STA.w $6EBE
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_039A49
	LDA.w $7A96,x
	BEQ.b CODE_039A31
	DEC.w $7A96,x
CODE_039A31:
	LDA.w $7A98,x
	BEQ.b CODE_039A39
	DEC.w $7A98,x
CODE_039A39:
	LDA.w $7AF6,x
	BEQ.b CODE_039A41
	DEC.w $7AF6,x
CODE_039A41:
	LDA.w $7AF8,x
	BEQ.b CODE_039A49
	DEC.w $7AF8,x
CODE_039A49:
	LDY.w $77C1,x
	BEQ.b CODE_039A51
	DEC.w $77C1,x
CODE_039A51:
	LDY.w $6F00,x
	LDA.w DATA_039A59-$02,y
	PHA
	RTS

DATA_039A59:
	dw CODE_039A6E-$01
	dw CODE_039A6E-$01
	dw CODE_03A247-$01
	dw CODE_039AC8-$01
	dw CODE_03A11D-$01
	dw CODE_039F8D-$01
	dw CODE_03A085-$01
	dw CODE_039A90-$01
	dw CODE_03A00B-$01

;---------------------------------------------------------------------------

CODE_039A6B:
	RTL

CODE_039A6C:
	PHK
	PLB
CODE_039A6E:
	LDA.w #$0010
	STA.w $6F00,x
	LDA.w $7360,x
	ASL
	ADC.w $7360,x
	REP.b #$10
	TAY
	LDA.w DATA_038000,y
	STA.b $00
	LDA.w DATA_038000+$02,y
	STA.b $02
	SEP.b #$10
	TAY
	PHY
	PLB
	JMP.w [$7960]

;---------------------------------------------------------------------------

CODE_039A90:
	LDA.w $7360,x
	ASL
	ADC.w $7360,x
	REP.b #$10
	PHX
	TAX
	LDA.l DATA_03852E,x
	STA.b $00
	LDA.l DATA_03852E+$02,x
	STA.b $02
	PLX
	SEP.b #$10
	TAY
	PHY
	PLB
	JMP.w [$7960]

;---------------------------------------------------------------------------

DATA_039AB0:
	dw $FF00,$0100

DATA_039AB4:
	dw $FFFE,$0002

DATA_039AB8:
	dw $000C,$FFF4,$0000,$0000

DATA_039AC0:
	dw $FFFC,$FFFC,$FFFA,$FFFA

CODE_039AC8:
	JSL.l CODE_039A90
	LDA.w $7040,x
	AND.w #$FFF3
	STA.w $7040,x
	PHK
	PLB
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BEQ.b CODE_039AE3
	RTL

CODE_039AE3:
	LDY.b #$00
	LDA.w $6164
	BEQ.b CODE_039AFD
	BPL.b CODE_039AEE
	LDY.b #$02
CODE_039AEE:
	CLC
	ADC.w DATA_039AB4,y
	STA.w $6164
	EOR.w DATA_039AB4,y
	BMI.b CODE_039AFD
	STZ.w $6164
CODE_039AFD:
	LDY.b #$00
	LDA.w $6166
	BEQ.b CODE_039B17
	BPL.b CODE_039B08
	LDY.b #$02
CODE_039B08:
	CLC
	ADC.w DATA_039AB4,y
	STA.w $6166
	EOR.w DATA_039AB4,y
	BMI.b CODE_039B17
	STZ.w $6166
CODE_039B17:
	LDA.w $615A
	CLC
	ADC.w $6164
	SEC
	SBC.w #$0008
	STA.w $70E2,x
	LDA.w $615C
	CLC
	ADC.w $6166
	SEC
	SBC.w #$0008
	STA.w $7182,x
	LDA.w $6152
	ORA.w $6154
	BEQ.b CODE_039B3C
CODE_039B3B:
	RTL

CODE_039B3C:
	SEP.b #$20
	LDA.b #$FF
	STA.w $74A2,x
	LDA.w $6168
	BNE.b CODE_039B4B
	JMP.w CODE_039DA7

CODE_039B4B:
	REP.b #$20
	LDA.w $6162
	BNE.b CODE_039B55
	JMP.w CODE_039BBC

CODE_039B55:
	LDA.w $7360,x
	CMP.w #$0022
	BCC.b CODE_039B66
	CMP.w #$002C
	BCS.b CODE_039B66
	JML.l CODE_03BF87

CODE_039B66:
	LDY.b #$01
	CMP.w #$0009
	BEQ.b CODE_039B98
	CMP.w #$00EC
	BEQ.b CODE_039B81
	CMP.w #$00ED
	BEQ.b CODE_039B81
	CMP.w #$0080
	BEQ.b CODE_039B81
	CMP.w #$0081
	BNE.b CODE_039B86
CODE_039B81:
	STZ.w $7402,x
	BRA.b CODE_039B98

CODE_039B86:
	INY
	CMP.w #$0019
	BEQ.b CODE_039B98
	INY
	CMP.w #$0007
	BEQ.b CODE_039B98
	INY
	CMP.w #$0005
	BNE.b CODE_039B3B
CODE_039B98:
	STY.w $616A
	LDA.w #$001E
	LDY.w $7402,x
	BEQ.b CODE_039BA6
	LDA.w #$000A
CODE_039BA6:
	STA.w $6170
	STZ.w $616C
	LDA.w #$0010
	STA.w $616E
	STA.w $61AE
	STA.w $61B0
	JML.l CODE_03A32E

CODE_039BBC:
	LDA.w $61E0
	CMP.w #$0003
	BCC.b CODE_039BC7
	JMP.w CODE_039DA6

CODE_039BC7:
	LDA.w $6150
	DEC
	ASL
	ORA.w $60C4
	TAY
	LDA.w $70E2,x
	CLC
	ADC.w DATA_039AB8,y
	STA.w $70E2,x
	CLC
	ADC.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7182,x
	CLC
	ADC.w DATA_039AC0,y
	STA.w $7182,x
	CLC
	ADC.w #$0008
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	PHY
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	PLY
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	AND.w #$0006
	BEQ.b CODE_039C11
	LDA.w $6168
	STA.w $6162
	STZ.w $6150
	RTL

CODE_039C11:
	STZ.w $6150
	STZ.w $6168
	LDA.w $7360,x
	CMP.w #$001E
	BEQ.b CODE_039C2E
	CMP.w #$0133
	BEQ.b CODE_039C2E
	CMP.w #$012A
	BEQ.b CODE_039C2E
	CMP.w #$0074
	BNE.b CODE_039C58
CODE_039C2E:
	CPY.b #$04
	BCS.b CODE_039C45
	LDA.w $60C4
	EOR.w #$0002
	STA.w $7400,x
	STZ.w $7220,x
	JSL.l CODE_048B73
	JMP.w CODE_039D2E

CODE_039C45:
	LDA.w #$0E81
	STA.w $6FA2,x
	LDA.w $7042,x
	ORA.w #$0020
	STA.w $7042,x
	STZ.b $76,x
	BRA.b CODE_039CCD

CODE_039C58:
	CMP.w #$0017
	BNE.b CODE_039C64
	JSL.l CODE_0EE0DE
	JMP.w CODE_039D2E

CODE_039C64:
	CMP.w #$0092
	BNE.b CODE_039C7D
	STZ.w $7D38,x
	LDA.w #$0010
	STA.w $7AF6,x
	LDA.w #$0002
	STA.w $7402,x
	STA.b $76,x
	JMP.w CODE_039D2E

CODE_039C7D:
	CPY.b #$04
	BCS.b CODE_039CCD
	CMP.w #$019A
	BNE.b CODE_039CB0
	PHY
	JSL.l CODE_039D28
	PLY
	STY.b $00
	JSL.l CODE_03AF0D
	JSL.l CODE_03AD24
	LDY.b #$00
	STY.b $78,x
	LDY.b $00
	PHB
	LDA.w #$000C
	XBA
	PHA
	PLB
	PLB
	PHY
	JSL.l CODE_0C8E07
	PLY
	JSL.l CODE_0C8D6A
	PLB
	RTL

CODE_039CB0:
	CMP.w #$00F3
	BNE.b CODE_039CCD
	PHY
	JSL.l CODE_039D28
	PLY
	PHB
	LDY.b #$0C
	PHY
	PLB
	JSL.l CODE_0CFEDD
	PLB
	SEP.b #$20
	STZ.w $7901,x
	REP.b #$20
	RTL

CODE_039CCD:
	REP.b #$10
	LDA.w $7360,x
	ASL
	TAX
	LDA.l FXDATA_0AAB14,x
	SEP.b #$10
	LDX.b $12
	CMP.w #$0000
	BEQ.b CODE_039D09
	PHP
	JSL.l CODE_03AF0D
	PLP
	BMI.b CODE_039CFA
	JSL.l CODE_03AD24
	BCC.b CODE_039D09
	LDA.w #$0100
	ORA.w $7402,x
	STA.w $7402,x
	BRA.b CODE_039D09

CODE_039CFA:
	JSL.l CODE_03AD74
	BCC.b CODE_039D09
	LDA.w #$0200
	ORA.w $7402,x
	STA.w $7402,x
CODE_039D09:
	STZ.b $18,x
	STZ.b $16,x
	LDA.w #$0400
	STA.w $75E2,x
	LDA.w #$0040
	STA.w $7542,x
	STZ.w $7540,x
	LDA.w $6FA2,x
	AND.w #$F83F
	ORA.w #$0040
	STA.w $6FA2,x
CODE_039D28:
	LDA.w #$0020
	STA.w $7D38,x
CODE_039D2E:
	LDX.b $12
	LDA.w $60E4
	EOR.w $60A8
	ASL
	LDA.w $60E4
	BCS.b CODE_039D3F
	ADC.w $60A8
CODE_039D3F:
	STA.w $7220,x
	LDA.w $60E6
	SEC
	SBC.w #$0300
	BPL.b CODE_039D4E
	LDA.w #$0000
CODE_039D4E:
	SEC
	SBC.w #$0200
	ADC.w $60E6
	STA.w $7222,x
	LDA.w $60C4
	EOR.w #$0002
	STA.w $7400,x
	LDA.w #$0004
	JSL.l CODE_0085D2
CODE_039D68:
	LDA.w #$0010
	STA.w $6F00,x
	LDA.w #$00FF
	ORA.w $7862,x
	STA.w $7862,x
	TXY
	REP.b #$10
	LDA.w $7360,y
	ASL
	TAX
	LDA.l FXDATA_0A9F1A,x
	AND.w #$00FF
	STA.w $74A2,y
	LDA.w $7360,y
	CMP.w #$0108
	BNE.b CODE_039D96
	LDA.w $7900,y
	BNE.b CODE_039D9A
CODE_039D96:
	LDA.l FXDATA_0A9B1C,x
CODE_039D9A:
	AND.w #$000C
	ORA.w $7040,y
	STA.w $7040,y
	SEP.b #$10
	TYX
CODE_039DA6:
	RTL

CODE_039DA7:
	REP.b #$20
	LDA.w $0B57
	ORA.w $0B59
	BEQ.b CODE_039DB5
	JML.l CODE_03A32E

CODE_039DB5:
	PHB
	PHK
	PLB
	LDA.w $6150
	BEQ.b CODE_039DC5
	CMP.w #$0043
	BCS.b CODE_039DC5
	JMP.w CODE_039ECE

CODE_039DC5:
	LDA.w $6FA2,x
	BPL.b CODE_039DCD
	JMP.w CODE_039E4E

CODE_039DCD:
	JSL.l CODE_04D1B6
	LDA.w #$003B
	JSL.l CODE_03B212
	JSL.l CODE_03AF0D
	LDA.w $7360,x
	CMP.w #$008B
	BNE.b CODE_039E01
	JSL.l CODE_03A32E
	LDA.w #$0087
	TXY
	JSL.l CODE_03A366
	LDY.w $60C4
	LDA.w DATA_039AB0,y
	STA.w $7220,x
	LDA.w #$FE00
	STA.w $7222,x
	BRA.b CODE_039E36

CODE_039E01:
	CMP.w #$0129
	BNE.b CODE_039E09
	JMP.w CODE_039ED4

CODE_039E09:
	CMP.w #$012B
	BEQ.b CODE_039E1C
	JSL.l CODE_05AD01
	LDA.w #$0025
	LDY.w $0146
	CPY.b #$0D
	BNE.b CODE_039E1F
CODE_039E1C:
	LDA.w #$002B
CODE_039E1F:
	STZ.w $6F00,x
	TXY
	JSL.l CODE_03A366
	LDA.w #$0010
	STA.w $6F00,x
	JSL.l CODE_03BEB9
	LDA.w #$FFA2
	STA.b $76,x
CODE_039E36:
	LDA.w $608C
	STA.w $70E2,x
	LDA.w $6090
	CLC
	ADC.w #$0010
	STA.w $7182,x
	LDA.w $60C4
	STA.w $7400,x
	PLB
	RTL

CODE_039E4E:
	LDA.w $7360,x
	CMP.w #$01A2
	BNE.b CODE_039E85
	LDA.w #$0009
	JSL.l CODE_0085D2
	LDA.w $70E2,x
	STA.w $0000
	LDA.w $7182,x
	STA.w $0002
	LDA.w #$0003
	STA.w $0004
	JSL.l CODE_03A4C3
	LDA.w $0396
	CLC
	ADC.w #$000A
	STA.w $0396
	LDA.w #$0082
	STA.w $0B7F
	BRA.b CODE_039EC6

CODE_039E85:
	CMP.w #$0115
	BNE.b CODE_039EB7
	LDA.w $7042,x
	BIT.w #$0002
	BEQ.b CODE_039EA6
	LDA.w #$0093
	INC.w $03B4
	LDY.w $03B4
	CPY.b #$14
	BMI.b CODE_039EA0
	INC
CODE_039EA0:
	JSL.l CODE_0085D2
	BRA.b CODE_039EAD

CODE_039EA6:
	LDA.w #$0009
	JSL.l CODE_0085D2
CODE_039EAD:
	JSL.l CODE_03A520
	JSL.l CODE_0CF957
	BRA.b CODE_039ECA

CODE_039EB7:
	CMP.w #$01B2
	BNE.b CODE_039EC6
	LDA.w #$0009
	JSL.l CODE_0085D2
	INC.w $03BA
CODE_039EC6:
	JSL.l CODE_03B288
CODE_039ECA:
	JSL.l CODE_03A32E
CODE_039ECE:
	PLB
	RTL

;---------------------------------------------------------------------------

DATA_039ED0:
	dw $FFF8,$0018

CODE_039ED4:
	LDA.w #$0021
	JSL.l CODE_0085D2
	LDA.w #$0400
	STA.w $7FE8
	LDA.w #$0003
	STA.w $61CA
	LDA.w #$0010
	STA.w $0B55
	JSL.l CODE_03A31E
	LDA.w #$00B3
	TXY
	JSL.l CODE_03A366
	LDA.w #$0040
	STA.w $7A96,x
	LDA.w #$0001
	STA.w $7D38,x
	LDY.w $60C4
	LDA.w $608C
	CLC
	ADC.w DATA_039ED0,y
	STA.w $7CD6,x
	SEC
	SBC.w #$0008
	STA.w $70E2,x
	LDA.w $6090
	CLC
	ADC.w #$0010
	STA.w $7CD8,x
	SEC
	SBC.w #$0008
	STA.w $7182,x
	PLB
CODE_039F2B:
	LDA.w #$01E6
	JSL.l CODE_008B21
	LDA.w $7CD6,x
	STA.w $70A2,y
	LDA.w $7CD8,x
	STA.w $7142,y
	LDA.w #$0004
	STA.w $7782,y
	LDA.w #$0006
	STA.w $73C2,y
	STA.w $7E4C,y
	RTL

;---------------------------------------------------------------------------

CODE_039F4E:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BEQ.b CODE_039F5A
	RTL

CODE_039F5A:
	LDA.w $7A96,x
	BNE.b CODE_039F62
	JMP.w CODE_03A31E

CODE_039F62:
	LDY.w $7D36,x
	DEY
	BMI.b CODE_039F8C
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_039F8C
	LDA.w $7D96,y
	BEQ.b CODE_039F7D
	TYX
	JSL.l CODE_03B595
	LDX.b $12
	RTL

CODE_039F7D:
	LDA.w $6FA0,y
	AND.w #$0020
	BNE.b CODE_039F8C
	TYX
	JSL.l CODE_03B25B
	LDX.b $12
CODE_039F8C:
	RTL

;---------------------------------------------------------------------------

CODE_039F8D:
	JSL.l CODE_039A90
CODE_039F91:
	JSL.l CODE_03A31E
	TXY
	JML.l CODE_03B4D6

;---------------------------------------------------------------------------

CODE_039F9A:
	RTL

;---------------------------------------------------------------------------

CODE_039F9B:
	JSL.l CODE_03B75E
CODE_039F9F:
	JSL.l CODE_039A90
	LDA.w $7040,x
	AND.w #$FFF3
	ORA.w #$0004
	STA.w $7040,x
	LDA.w $7042,x
	ORA.w #$0080
	AND.w #$00CF
	ORA.w #$0020
	LDY.w $7862,x
	DEY
	BPL.b CODE_039FC4
	ORA.w #$0030
CODE_039FC4:
	STA.w $7042,x
	STZ.w $74A2,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
	LDA.w $6FA0,x
	AND.w #$F9FF
	STA.w $6FA0,x
	LDA.w $6FA2,x
	AND.w #$FFE0
	STA.w $6FA2,x
	RTL

;---------------------------------------------------------------------------

DATA_039FE9:
	dw $FF80,$0080

CODE_039FED:
	LDA.w $7682,x
	CMP.w #$00F0
	BMI.b CODE_039FF9
	JML.l CODE_03A31E

CODE_039FF9:
	LDY.b #$00
	LDA.w $70E2,x
	CMP.b $18,x
	BPL.b CODE_03A004
	LDY.b #$02
CODE_03A004:
	LDA.w DATA_039FE9,y
	STA.w $75E0,x
	RTL

;---------------------------------------------------------------------------

CODE_03A00B:
	JSL.l CODE_039A90
	LDA.w #$0060
	STA.w $6FA0,x
	LDA.w $6FA2,x
	AND.w #$FFE0
	STA.w $6FA2,x
	LDA.w $7040,x
	AND.w #$FFF3
	ORA.w #$0004
	STA.w $7040,x
	LDA.w $7042,x
	AND.w #$00CF
	ORA.w #$0020
	LDY.w $7862,x
	DEY
	BPL.b CODE_03A03C
	ORA.w #$0030
CODE_03A03C:
	STA.w $7042,x
	STZ.w $74A2,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
	LDA.w $7A96,x
	BNE.b CODE_03A084
	LDA.w #$0008
	STA.w $7A96,x
	LDA.w #$01DF
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w #$0005
	STA.w $7E4C,y
	LDA.w #$0005
	STA.w $73C2,y
	LDA.w #$0004
	STA.w $7782,y
	LDA.w #$FE80
	STA.w $71E2,y
CODE_03A084:
	RTL

;---------------------------------------------------------------------------

CODE_03A085:
	LDA.w $7360,x
	ASL
	ADC.w $7360,x
	REP.b #$10
	TAY
	LDA.w DATA_038A5C,y
	STA.b $00
	LDA.w DATA_038A5C+$02,y
	STA.b $02
	SEP.b #$10
	TAY
	PHY
	PLB
	JMP.w [$7960]

;---------------------------------------------------------------------------

CODE_03A0A1:
	LDA.w $0CCE
	BNE.b CODE_03A0E4
	LDA.w #$0010
	STA.w $0CCE
	LDA.w #$000C
	JSL.l CODE_0085D2
	LDA.w #$01BE
	JSL.l CODE_008B21
	LDA.w $7C76,x
	CMP.w #$8000
	ROR
	CLC
	ADC.w $7CD6,x
	SEC
	SBC.w #$0008
	STA.w $70A2,y
	LDA.w $7C78,x
	CMP.w #$8000
	ROR
	CLC
	ADC.w $7CD8,x
	SEC
	SBC.w #$0008
CODE_03A0DB:
	STA.w $7142,y
	LDA.w #$0005
	STA.w $7782,y
CODE_03A0E4:
	RTL

;---------------------------------------------------------------------------

CODE_03A0E5:
	LDY.b #$0C
CODE_03A0E7:
	LDA.w $0CCE
	BNE.b CODE_03A0E4
	TYA
	JSL.l CODE_0085D2
	LDA.w #$0010
	STA.w $0CCE
	LDA.w #$01BE
	JSL.l CODE_008B21
	LDA.w $7C16,x
	CMP.w #$8000
	ROR
	CLC
	ADC.w $608C
	STA.w $70A2,y
	LDA.w $7C18,x
	CMP.w #$8000
	ROR
	CLC
	ADC.w $6122
	CLC
	ADC.w $6090
	BRA.b CODE_03A0DB

;---------------------------------------------------------------------------

CODE_03A11D:
	JSL.l CODE_039A90
	PHK
	PLB
	STZ.w $7220,x
	STZ.w $7222,x
	LDA.w $7AF8,x
	BEQ.b CODE_03A147
	LDA.w #$0010
	SEC
	SBC.w $7AF8,x
	LSR
	INC
	CMP.w #$0004
	BCC.b CODE_03A13F
	LDA.w #$0003
CODE_03A13F:
	CMP.w $60C2
	BCC.b CODE_03A147
	STA.w $60C2
CODE_03A147:
	REP.b #$10
	LDY.w $60BE
	LDA.w DATA_03F8E1,y
	AND.w #$FF00
	BPL.b CODE_03A157
	ORA.w #$00FF
CODE_03A157:
	XBA
	CLC
	ADC.w $6090
	STA.w $7182,x
	LDA.w DATA_03F6DE,y
	LDY.w $611A
	DEY
	BMI.b CODE_03A173
	LDY.w #$0004
	AND.w #$0040
	BEQ.b CODE_03A173
	LDY.w #$0002
CODE_03A173:
	SEP.b #$20
	TYA
	STA.w $74A2,x
	REP.b #$20
	LDY.w $60BE
	LDA.w DATA_03F6DE-$01,y
	AND.w #$BF00
	BPL.b CODE_03A189
	ORA.w #$40FF
CODE_03A189:
	XBA
	LDY.w $60C4
	BNE.b CODE_03A193
	EOR.w #$FFFF
	INC
CODE_03A193:
	CLC
	ADC.w $608C
	STA.w $70E2,x
	LDA.w $60C4
	STA.w $7400,x
	SEP.b #$10
	LDA.w $7360,x
	ASL
	ADC.w $7360,x
	REP.b #$10
	TAY
	LDA.w DATA_038F8A,y
	STA.b $00
	LDA.w DATA_038F8A+$02,y
	STA.b $02
	SEP.b #$10
	TAY
	PHY
	PLB
	JMP.w [$7960]

;---------------------------------------------------------------------------

CODE_03A1BE:
	LDY.w $7D36,x
	BPL.b CODE_03A1CB
	JSL.l CODE_03D35D
	TYX
	JSR.w (DATA_03A1CC,x)
CODE_03A1CB:
	RTL

DATA_03A1CC:
	dw CODE_03A1D4
	dw CODE_03A1D4
	dw CODE_03A209
	dw CODE_03A22E

CODE_03A1D4:
	LDX.b $12
CODE_03A1D6:
	STZ.w $7540,x
	LDA.w $60A8
	CMP.w #$8000
	ROR
	STA.w $60A8
	LDA.w $60A8
	CMP.w #$8000
	ROR
	STA.w $7220,x
	BMI.b CODE_03A1F3
	EOR.w #$FFFF
	INC
CODE_03A1F3:
	CLC
	ADC.w #$FCC0
	STA.w $7222,x
CODE_03A1FA:
	LDA.w $7D96,x
	BNE.b CODE_03A204
	JSL.l CODE_03B51F
	RTS

CODE_03A204:
	JSL.l CODE_03B595
	RTS

CODE_03A209:
	LDX.b $12
	STZ.w $7540,x
	LDA.w $7C16,x
	ASL
	ASL
	ASL
	ASL
	ASL
	STA.w $7220,x
	LDA.w $60AA
	BPL.b CODE_03A221
	STZ.w $60AA
CODE_03A221:
	CMP.w #$FC00
	BMI.b CODE_03A229
	LDA.w #$FC00
CODE_03A229:
	STA.w $7222,x
	BRA.b CODE_03A1FA

CODE_03A22E:
	LDX.b $12
	STZ.w $7540,x
	STZ.w $7220,x
	STZ.w $7222,x
	LDA.w #$FC00
	STA.w $60AA
	LDA.w #$8001
	STA.w $60D2
	BRA.b CODE_03A1FA

;---------------------------------------------------------------------------

CODE_03A247:
	JSL.l CODE_02808C
	JSL.l CODE_039A90
	PHK
	PLB
	LDA.w #$003B
	JSL.l CODE_0085D2
	SEP.b #$20
	LDA.w $74A0,x
	PHA
	LDA.b #$FF
	STA.w $74A0,x
	REP.b #$20
	JSL.l CODE_03A31E
	LDA.w $0B91,x
	BPL.b CODE_03A27D
	LDA.w #$0004
	JSL.l CODE_03A4E9
	PLY
	LDA.w #$0009
	JML.l CODE_0085D2

CODE_03A27D:
	TXY
	JSL.l CODE_03A34E
	SEP.b #$20
	PLA
	STA.w $74A0,x
	REP.b #$20
	LDA.w $7360,x
	CMP.w #$0115
	BNE.b CODE_03A298
	LDA.w #$FD00
	STA.w $7222,x
CODE_03A298:
	RTL

;---------------------------------------------------------------------------

CODE_03A299:
	LDA.w $7680,x
	CLC
	ADC.w #$0100
	CMP.w #$0300
	BCS.b CODE_03A2AF
	LDA.w $7682,x
	CLC
	ADC.w #$0100
	CMP.w #$02E0
CODE_03A2AF:
	RTL

;---------------------------------------------------------------------------

CODE_03A2B0:
	LDA.w $7680,x
	CLC
	ADC.w #$0080
	CMP.w #$0200
	BCS.b CODE_03A2C6
	LDA.w $7682,x
	CLC
	ADC.w #$0080
	CMP.w #$01E0
CODE_03A2C6:
	RTL

;---------------------------------------------------------------------------

CODE_03A2C7:
	LDA.w $7680,x
	CLC
	ADC.w #$0040
	CMP.w #$0180
	BCS.b CODE_03A2DD
	LDA.w $7682,x
	CLC
	ADC.w #$0040
	CMP.w #$0160
CODE_03A2DD:
	RTL

;---------------------------------------------------------------------------

CODE_03A2DE:
	LDA.w $7680,x
	CLC
	ADC.w #$0080
	CMP.w #$0200
	BCS.b CODE_03A310
	LDA.w $7682,x
	CLC
	ADC.w #$0080
	CMP.w #$01E0
	BCS.b CODE_03A310
	BRA.b CODE_03A34B

CODE_03A2F8:
	LDA.w $7680,x
	CLC
	ADC.w #$0040
	CMP.w #$0180
	BCS.b CODE_03A310
	LDA.w $7682,x
	CLC
	ADC.w #$0040
	CMP.w #$0160
	BCC.b CODE_03A34B
CODE_03A310:
	LDA.w $7E2A
	BEQ.b CODE_03A31E
	TXA
	LSR
	LSR
	TAY
	LDA.w $0C98,y
	BNE.b CODE_03A34B
CODE_03A31E:
	SEP.b #$20
	PHX
	LDA.w $74A0,x
	TAX
	LDA.b #$00
	STA.l $7028CA,x
	PLX
	REP.b #$20
CODE_03A32E:
	STZ.w $6F00,x
CODE_03A331:
	LDA.w #$00FF
	STA.w $74A2,x
	LDY.w $7722,x
	BMI.b CODE_03A342
	LDA.w $7ECE,y
	TRB.w $7ECC
CODE_03A342:
	CPX.w $61B6
	BNE.b CODE_03A34A
	STZ.w $61B6
CODE_03A34A:
	SEC
CODE_03A34B:
	RTL

;---------------------------------------------------------------------------

CODE_03A34C:
	LDY.b #$5C
CODE_03A34E:
	PHA
CODE_03A34F:
	LDA.w $6F00,y
	BEQ.b CODE_03A35F
	DEY
	DEY
	DEY
	DEY
	CPY.b #$18
	BCS.b CODE_03A34F
	PLA
	CLC
	RTL

CODE_03A35F:
	LDA.w #$0002
	BRA.b CODE_03A37D

CODE_03A364:
	LDY.b #$5C
CODE_03A366:
	PHA
CODE_03A367:
	LDA.w $6F00,y
	BEQ.b CODE_03A37A
	DEY
	DEY
	DEY
	DEY
	CPY.b #$18
	BCS.b CODE_03A367
	PLA
	CLC
	RTL

CODE_03A377:
	PHA
	BRA.b CODE_03A395

CODE_03A37A:
	LDA.w #$0010
CODE_03A37D:
	STA.w $6F00,y
	LDA.w #$00FF
	STA.w $74A0,y
	LDA.w #$0000
	STA.w $7400,y
	STA.w $7D96,y
	STA.w $7900,y
	STA.w $7902,y
CODE_03A395:
	LDA.w #$0000
	STA.w $7220,y
	STA.w $7222,y
	STA.w $7976,y
	STA.w $70E0,y
	STA.w $7D36,y
	STA.w $7978,y
	STA.w $79D6,y
	STA.w $79D8,y
	STA.w $7A36,y
	STA.w $7A38,y
	STA.w $7A96,y
	STA.w $7A98,y
	STA.w $7AF6,y
	STA.w $7AF8,y
	STA.w $7402,y
	STA.w $7860,y
	STA.w $6F02,y
	STA.w $7D38,y
	STA.w $7720,y
	STA.w $7680,y
	STA.w $7682,y
	STA.w $7540,y
	STA.w $75E0,y
	STA.w $77C0,y
	DEC
	STA.w $7362,y
	STA.w $7722,y
	LDA.w #$1FFF
	STA.w $7862,y
	PLA
	STA.w $7360,y
	PHX
	ASL
	REP.b #$10
	TAX
	SEP.b #$20
	PHY
	LDA.l FXDATA_0AA716,x
	LDY.w #$0006
CODE_03A400:
	CMP.w $6EB5,y
	BEQ.b CODE_03A40B
	DEY
	BNE.b CODE_03A400
	TYA
	BRA.b CODE_03A410

CODE_03A40B:
	TYA
	ADC.b #$06
	ASL
	ASL
CODE_03A410:
	REP.b #$20
	AND.w #$00FF
	PLY
	STA.w $7180,y
	LDA.l FXDATA_0A9F1A+$01,x
	AND.w #$00FF
	EOR.w #$0020
	STA.w $7042,y
	LDA.l FXDATA_0A9F1A,x
	AND.w #$00FF
	STA.w $74A2,y
	LDA.l FXDATA_0AA318-$01,x
	AND.w #$FF00
	BPL.b CODE_03A43C
	ORA.w #$00FF
CODE_03A43C:
	XBA
	STA.w $7542,y
	LDA.l FXDATA_0AA318,x
	AND.w #$FF00
	BPL.b CODE_03A44C
	ORA.w #$00FF
CODE_03A44C:
	XBA
	ASL
	ASL
	ASL
	ASL
	STA.w $75E2,y
	LDA.l FXDATA_0A9B1C,x
	STA.w $7040,y
	LDA.l FXDATA_0A971E,x
	STA.w $6FA2,y
	LDA.l FXDATA_0A9320,x
	STA.w $6FA0,y
	AND.w #$001F
	ASL
	ASL
	ASL
	TAX
	LDA.l FXDATA_0A9220,x
	STA.w $7B56,y
	LDA.l FXDATA_0A9220+$02,x
	STA.w $7B58,y
	LDA.l FXDATA_0A9220+$04,x
	STA.w $7BB6,y
	LDA.l FXDATA_0A9220+$06,x
	STA.w $7BB8,y
	SEP.b #$10
	PLX
	SEC
	RTL

;---------------------------------------------------------------------------

CODE_03A491:
	LDA.w #$0003
	BRA.b CODE_03A4A5

CODE_03A496:
	LDA.w $70E2,x
	STA.w $0000
	LDA.w $7182,x
	STA.w $0002
CODE_03A4A2:
	LDA.w #$0001
CODE_03A4A5:
	STA.w $0004
	CLC
	ADC.w $0379
	STA.w $0379
	LDA.w $0004
	CLC
	ADC.w $037F
	STA.w $037F
	LDA.w #$0008
	JSL.l CODE_0085D2
	LSR.w $0004
CODE_03A4C3:
	LDA.w #$01BF
	JSL.l CODE_008B21
	LDA.w $0000
	STA.w $70A2,y
	LDA.w $0002
	STA.w $7142,y
	LDA.w $0004
	STA.w $73C2,y
	LDA.w #$0040
	STA.w $7782,y
	LDA.w #$FF00
	STA.w $71E2,y
	RTL

;---------------------------------------------------------------------------

CODE_03A4E9:
	STA.w $0006
	LDA.w $70E2,x
	STA.w $0000
	LDA.w $7182,x
CODE_03A4F5:
	STA.w $0002
	LDA.w #$0226
	JSL.l CODE_008B21
	LDA.w $0000
	STA.w $70A2,y
	LDA.w $0002
	STA.w $7142,y
	LDA.w $7002,y
	ORA.w $0006
	STA.w $7002,y
	LDA.w #$0040
	STA.w $7782,y
	LDA.w #$FE80
	STA.w $71E2,y
CODE_03A520:
	INC.w $037B
	LDA.w $037B
	CMP.w #$0064
	BCC.b CODE_03A538
	JSL.l CODE_03A4A2
	LDA.w #$FE40
	STA.w $71E2,y
	STZ.w $037B
CODE_03A538:
	RTL

;---------------------------------------------------------------------------

CODE_03A539:
	LDA.w $70E2,y
	LDY.b #$00
	SEC
	SBC.w $70E2,x
	STA.b $08
	BPL.b CODE_03A54C
	EOR.w #$FFFF
	INC
	LDY.b #$02
CODE_03A54C:
	STA.b $06
	TYA
	RTL

;---------------------------------------------------------------------------

CODE_03A550:
	LDY.b #$00
	LDA.w $7182,y
	SEC
	SBC.w $7182,x
	STA.b $0E
	BPL.b CODE_03A563
	EOR.w #$FFFF
	INC
	LDY.b #$02
CODE_03A563:
	STA.b $0C
	TYA
	RTL

;---------------------------------------------------------------------------

CODE_03A567:
	PHY
	JSL.l CODE_03A550
	STY.b $0A
	PLY
	JSL.l CODE_03A539
	STY.b $04
	LDA.b $06
	CMP.b $0C
	BCS.b CODE_03A581
	LDY.b $0A
	INY
	INY
	INY
	INY
CODE_03A581:
	TYA
	RTL

;---------------------------------------------------------------------------

DATA_03A583:
	dw $FF40,$00C0,$FFA0,$0060

CODE_03A58B:
	TXY
	LDX.b #$04
	BRA.b CODE_03A593

CODE_03A590:
	TXY
	LDX.b #$00
CODE_03A593:
	LDA.w $7220,y
	BEQ.b CODE_03A5B0
	BPL.b CODE_03A59C
	INX
	INX
CODE_03A59C:
	CLC
	ADC.l DATA_03A583,x
	STA.w $7220,y
	EOR.l DATA_03A583,x
	BMI.b CODE_03A5B0
	LDA.w #$0000
	STA.w $7220,y
CODE_03A5B0:
	TYX
	RTL

;---------------------------------------------------------------------------

CODE_03A5B2:
	JSL.l CODE_03A5B7
	RTL

CODE_03A5B7:
	LDY.w $7D36,x
	BEQ.b CODE_03A5F0
	BPL.b CODE_03A62E
CODE_03A5BE:
	LDA.w $7D96,x
	BEQ.b CODE_03A5C9
	PLA
	PLY
	JML.l CODE_03B595

CODE_03A5C9:
	LDA.w $7C18,x
	SEC
	SBC.w $6122
	SEC
	SBC.w $7BB8,x
	CMP.w #$FFF6
	BCC.b CODE_03A5F9
	TXY
	LDX.b #$0C
	LDA.w $60AA
	BMI.b CODE_03A5EA
	LDA.w $6FA1,y
	AND.w #$0038
	LSR
	LSR
	TAX
CODE_03A5EA:
	JSR.w (DATA_03A655,x)
	PLA
	PLY
	RTL

CODE_03A5F0:
	CPX.w $61B6
	BNE.b CODE_03A5F8
	STZ.w $61B6
CODE_03A5F8:
	RTL

CODE_03A5F9:
	LDA.w $6FA0,x
	AND.w #$3800
	CMP.w #$2800
	BEQ.b CODE_03A61D
	LDA.w $60D8
	BNE.b CODE_03A61D
	LDA.w $60A8
	BPL.b CODE_03A612
	EOR.w #$FFFF
	INC
CODE_03A612:
	CMP.w #$0400
	BCC.b CODE_03A61D
	PLA
	PLY
	JSR.w CODE_03A1D6
	RTL

CODE_03A61D:
	LDA.w $6FA0,x
	AND.w #$C000
	ASL
	ROL
	ROL
	ASL
	TAX
	JSR.w (DATA_03A665,x)
	PLA
	PLY
	RTL

CODE_03A62E:
	CPX.w $61B6
	BNE.b CODE_03A636
	STZ.w $61B6
CODE_03A636:
	RTL

CODE_03A637:
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
	LDA.w $7220,x
	EOR.w #$FFFF
	INC
	STA.w $7220,x
	RTL

CODE_03A64B:
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
	RTL

DATA_03A655:
	dw CODE_03A66D
	dw CODE_03A6B5
	dw CODE_03A6B5
	dw CODE_03A6B5
	dw CODE_03A6D6
	dw CODE_03A7A4
	dw CODE_03A6F5
	dw CODE_03A789

DATA_03A665:
	dw CODE_03A7AB
	dw CODE_03A7A4
	dw CODE_03A806
	dw CODE_03A80B

CODE_03A66D:
	LDA.w $60C0
	BNE.b CODE_03A675
	JMP.w CODE_03A7A4

CODE_03A675:
	LDX.b $12
	LDA.w $7C16,x
	ASL
	ASL
	ASL
	ASL
	STA.w $7220,x
	STZ.w $7540,x
	STZ.w $7222,x
	LDA.w #$0400
	STA.w $75E2,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$FC00
	STA.w $60AA
	LDA.w #$8001
	STA.w $60D2
	LDA.w #$000E
	STA.w $6F00,x
	JSL.l CODE_03B288
	LDY.w $0146
	CPY.b #$09
	BEQ.b CODE_03A6B4
	JSL.l CODE_03B523
CODE_03A6B4:
	RTS

CODE_03A6B5:
	LDX.b $12
	LDY.b #$3A
	JSL.l CODE_03A0E7
	LDA.w #$000E
	STA.w $6F00,x
	STZ.w $7220,x
	STZ.w $7222,x
	LDA.w #$FC00
	STA.w $60AA
	LDA.w #$8001
	STA.w $60D2
	RTS

CODE_03A6D6:
	LDA.w #$FC00
	STA.w $60AA
	LDA.w #$8001
	STA.w $60D2
	LDX.b $12
	JSL.l CODE_03B4D6
	JSL.l CODE_03B288
	JSL.l CODE_03A31E
	RTS

DATA_03A6F1:
	dw $0180,$0060

CODE_03A6F5:
	LDX.b $12
	LDA.w $60D4
	BEQ.b CODE_03A707
	LDA.w $6FA2,x
	AND.w #$6000
	BNE.b CODE_03A707
	JMP.w CODE_03A789

CODE_03A707:
	LDA.w $0D94
	BEQ.b CODE_03A716
	CPX.w $61B6
	BNE.b CODE_03A787
	STZ.w $61B6
	BRA.b CODE_03A787

CODE_03A716:
	LDA.w $6FA0,x
	AND.w #$3800
	CMP.w #$3000
	BNE.b CODE_03A731
	CPX.w $61B6
	BEQ.b CODE_03A72E
	LDA.w $61B6
	AND.w #$00FF
	BNE.b CODE_03A787
CODE_03A72E:
	STX.w $61B6
CODE_03A731:
	LDA.w $60FC
	AND.w #$0018
	BNE.b CODE_03A759
	LDA.w $7C18,x
	SEC
	SBC.w $6122
	SEC
	SBC.w $7BB8,x
	SEC
	ADC.w $6090
	STA.w $6090
	LDA.w $7182,x
	SEC
	SBC.w $6EBE
	SEC
	ADC.w $6090
	STA.w $6090
CODE_03A759:
	LDA.w $60AA
	BMI.b CODE_03A787
	LDA.w $7222,x
	BPL.b CODE_03A766
	LDA.w #$0000
CODE_03A766:
	STA.w $60AA
	LDY.b #$00
	LDA.w $72C0,x
	BMI.b CODE_03A772
	LDY.b #$02
CODE_03A772:
	LDA.w $60FC
	AND.w DATA_03A6F1,y
	BNE.b CODE_03A784
	LDA.w $72C0,x
	CLC
	ADC.w $608C
	STA.w $608C
CODE_03A784:
	INC.w $61B4
CODE_03A787:
	PLA
	RTL

CODE_03A789:
	LDX.b $12
	JSL.l CODE_03B51F
	LDA.w #$FC00
	STA.w $60AA
	LDA.w #$8001
	STA.w $60D2
CODE_03A79B:
	RTS

CODE_03A79C:
	JSR.w CODE_03A789
	RTL

DATA_03A7A0:
	dw $0100,$FF00

CODE_03A7A4:
	LDX.b $12
	JSL.l CODE_03A858
	RTS

CODE_03A7AB:
	LDX.b $12
	LDA.w $60A8
	ORA.w $7220,x
	BEQ.b CODE_03A79B
	REP.b #$10
	LDA.w $60A8
	EOR.w $7220,x
	ASL
	LDA.w $60A8
	PHA
	LDA.w $7220,x
	TAY
	EOR.w $7C16,x
	BMI.b CODE_03A7D2
	BCS.b CODE_03A7E1
	STZ.w $60A8
	BRA.b CODE_03A7E1

CODE_03A7D2:
	BCS.b CODE_03A7DE
	TYA
	SEC
	SBC.w $60A8
	EOR.w $60A8
	BMI.b CODE_03A7E1
CODE_03A7DE:
	STY.w $60A8
CODE_03A7E1:
	PLA
	TAY
	EOR.w $7C16,x
	BPL.b CODE_03A7EF
	BCS.b CODE_03A7FF
	STZ.w $7220,x
	BRA.b CODE_03A7FF

CODE_03A7EF:
	BCS.b CODE_03A7FB
	TYA
	SEC
	SBC.w $7220,x
	EOR.w $7220,x
	BMI.b CODE_03A7FF
CODE_03A7FB:
	TYA
	STA.w $7220,x
CODE_03A7FF:
	SEP.b #$10
	JSL.l CODE_03A0E5
	RTS

CODE_03A806:
	LDX.b $12
	JMP.w CODE_03A1D6

CODE_03A80B:
	LDX.b $12
	PLA
	RTL

;---------------------------------------------------------------------------

DATA_03A80F:
	dw $0100,$FF00

CODE_03A813:
	LDX.b $12
	LDA.w $61D6
	BNE.b CODE_03A850
	LDA.w $6FA2,x
	AND.w #$6000
	BNE.b CODE_03A84A
	INC.w $7D38,x
	STZ.b $18,x
	LDA.w #$0400
	STA.w $75E2,x
	LDA.w #$0040
	STA.w $7542,x
	STZ.w $7540,x
	STZ.w $7860,x
	TXY
	LDX.w $77C2,y
	LDA.l DATA_03A7A0,x
	STA.w $7220,y
	LDA.w #$FE00
	STA.w $7222,y
CODE_03A84A:
	LDX.b $12
	JSL.l CODE_03A858
CODE_03A850:
	PLA
	PLY
	RTL

;---------------------------------------------------------------------------

CODE_03A853:
	STZ.w $7972
	BRA.b CODE_03A865

CODE_03A858:
	LDA.w $7E04
	BEQ.b CODE_03A865
	LDY.w $7972
	BEQ.b CODE_03A899
	JMP.w CODE_03B25B

CODE_03A865:
	LDA.w $61D6
	ORA.w $61AE
	ORA.w $10DA
	BNE.b CODE_03A899
	LDA.w $60AC
	CMP.w #$0003
	BCS.b CODE_03A899
	LDA.w $60B2
	CLC
	ADC.w #$0010
	CMP.w #$00E9
	BCS.b CODE_03A899
	LDA.w #$0017
	JSL.l CODE_0085D2
	STA.w $607A
	STZ.w $60D4
	LDX.w $60AE
	JSR.w (DATA_03A89A,x)
	LDX.b $12
CODE_03A899:
	RTL

DATA_03A89A:
	dw CODE_03A8CF
	dw CODE_03A8FC
	dw CODE_03A936
	dw CODE_03A8AE
	dw CODE_03A8C1
	dw CODE_03A94A
	dw CODE_03A940
	dw CODE_03A94B
	dw CODE_03A901
	dw CODE_03A8D3

CODE_03A8AE:
	LDA.w #$0068
	STA.w $61D6
	STZ.w $60A8
	STZ.w $60B4
	LDA.w #$1000
	STA.w $6180
	RTS

CODE_03A8C1:
	LDA.w #$0090
	STA.w $61D6
	STZ.w $618E
	RTS

DATA_03A8CB:
	dw $FE00,$0200

CODE_03A8CF:
	JSL.l CODE_04F74A
CODE_03A8D3:
	LDA.w $61B2
	BMI.b CODE_03A8F7
	LDA.w $0390
	BMI.b CODE_03A8F7
	LDA.w $60A8
	CLC
	ADC.w #$02C0
	CMP.w #$0581
	LDA.w #$0180
	BCC.b CODE_03A8EF
	LDA.w #$0240
CODE_03A8EF:
	STA.w $614A
	LDA.w #$0080
	BRA.b CODE_03A904

CODE_03A8F7:
	LDA.w #$00A0
	BRA.b CODE_03A904

CODE_03A8FC:
	LDA.w #$0040
	BRA.b CODE_03A904

CODE_03A901:
	LDA.w #$0068
CODE_03A904:
	STA.w $61D6
	LDY.w $7972
	BEQ.b CODE_03A917
	LDX.w $77C2,y
	LDA.l DATA_03A8CB,x
	TYX
	STA.w $60B4
CODE_03A917:
	LDY.w $60AE
	CPY.b #$02
	BEQ.b CODE_03A923
	LDA.w $60C0
	BNE.b CODE_03A92F
CODE_03A923:
	LDA.w #$0008
	STA.w $60C0
	LDA.w #$FC00
	STA.w $60AA
CODE_03A92F:
	LDA.w #$0008
	STA.w $0CCC
	RTS

CODE_03A936:
	LDA.w #$0090
	STA.w $61D6
	STZ.w $6194
	RTS

CODE_03A940:
	LDA.w #$00D0
	STA.w $61D6
	STZ.w $6180
	RTS

CODE_03A94A:
	RTS

CODE_03A94B:
	LDA.w $6180
	BNE.b CODE_03A965
	LDA.w #$0080
	STA.w $6180
	LDA.w #$0080
	STA.w $61F6
	LDA.w #$FE00
	STA.w $60AA
	STZ.w $617E
CODE_03A965:
	RTS

;---------------------------------------------------------------------------

DATA_03A966:
	dw $0000,$8040,$8000,$00C0,$8080,$0040,$0080,$80C0

CODE_03A977:
	PHX
	LDY.b #$00
	LDA.b $00
	BPL.b CODE_03A983
	LDY.b #$04
	EOR.w #$FFFF
	INC
CODE_03A983:
	STA.b $04
	TAX
	LDA.b $02
	BPL.b CODE_03A990
	INY
	INY
	EOR.w #$FFFF
	INC
CODE_03A990:
	CMP.b $04
	BCC.b CODE_03A998
	INY
	TAX
	LDA.b $04
CODE_03A998:
	XBA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	TYA
	ASL
	TAX
	NOP #4
	REP.b #$10
	LDA.w !REGISTER_QuotientLo
	ASL
	TAY
	CPY.w #$0202
	BCC.b CODE_03A9B5
	LDY.w #$0200
CODE_03A9B5:
	LDA.l DATA_03A966,x
	ASL
	STA.b $04
	TYX
	LDA.l FXDATA_0BB810,x
	BCC.b CODE_03A9C7
	EOR.w #$FFFF
	INC
CODE_03A9C7:
	CLC
	ADC.b $04
	SEP.b #$10
	PLX
	RTL

;---------------------------------------------------------------------------

DATA_03A9CE:
	dw $0000,$0010,$0000,$0010,$0020,$0030,$0020,$0030
	dw $0040,$0050,$0040,$0050,$0060,$0070,$0060,$0070

DATA_03A9EE:
	dw $0000,$0000,$0010,$0010,$0000,$0000,$0010,$0010
	dw $0000,$0000,$0010,$0010,$0000,$0000,$0010,$0010

;---------------------------------------------------------------------------

DATA_03AA0E:
	dw $01C0,$01C2,$01E0,$01E2,$01C4,$01C6,$01E4,$01E6
	dw $01C8,$01CA,$01E8,$01EA,$01CC,$01CE,$01EC,$01EE

CODE_03AA2E:
	LDY.w $74A2,x
	CPY.b #$FF
	BEQ.b CODE_03AA51
	REP.b #$10
	LDY.w $7362,x
	BMI.b CODE_03AA4F
CODE_03AA3C:
	PHX
	LDA.w $7722,x
	TAX
	LDA.w $6004,y
	AND.w #$FE00
	ORA.l DATA_03AA0E,x
	STA.w $6004,y
	PLX
CODE_03AA4F:
	SEP.b #$10
CODE_03AA51:
	RTL

;---------------------------------------------------------------------------

CODE_03AA52:
	LDY.w $74A2,x
	CPY.b #$FF
	BEQ.b CODE_03AA9C
	REP.b #$10
	LDY.w $7362,x
	BMI.b CODE_03AA9A
CODE_03AA60:
	PHX
	LDA.w $7722,x
	TAX
	LDA.w $6004,y
	AND.w #$FE00
	ORA.l DATA_03AA0E,x
	STA.w $6004,y
	LDA.w $600C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$02,x
	STA.w $600C,y
	LDA.w $6014,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$04,x
	STA.w $6014,y
	LDA.w $601C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$06,x
	STA.w $601C,y
	PLX
CODE_03AA9A:
	SEP.b #$10
CODE_03AA9C:
	RTL

;---------------------------------------------------------------------------

CODE_03AA9D:
	LDY.w $74A2,x
	CPY.b #$FF
	BEQ.b CODE_03AB1B
	REP.b #$10
	LDY.w $7362,x
	BMI.b CODE_03AB19
CODE_03AAAB:
	PHX
	LDA.w $7722,x
	TAX
	LDA.w $6004,y
	AND.w #$FE00
	ORA.l DATA_03AA0E,x
	STA.w $6004,y
	LDA.w $600C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$02,x
	STA.w $600C,y
	LDA.w $6014,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$04,x
	STA.w $6014,y
	LDA.w $601C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$06,x
	STA.w $601C,y
	LDA.w $6024,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$08,x
	STA.w $6024,y
	LDA.w $602C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$0A,x
	STA.w $602C,y
	LDA.w $6034,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$0C,x
	STA.w $6034,y
	LDA.w $603C,y
	AND.w #$FE00
	ORA.l DATA_03AA0E+$0E,x
	STA.w $603C,y
	PLX
CODE_03AB19:
	SEP.b #$10
CODE_03AB1B:
	RTL

;---------------------------------------------------------------------------

CODE_03AB1C:
	LDY.w $74A2,x
	CPY.b #$FF
	BEQ.b CODE_03AB1B
	REP.b #$10
	LDY.w $7362,x
	BPL.b CODE_03AB2D
	JMP.w CODE_03ABF7

CODE_03AB2D:
	PHX
	PHB
	PHK
	PLB
	LDA.w $7722,x
	TAX
	LDA.w $6004,y
	AND.w #$FE00
	ORA.w DATA_03AA0E,x
	STA.w $6004,y
	LDA.w $600C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$02,x
	STA.w $600C,y
	LDA.w $6014,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$04,x
	STA.w $6014,y
	LDA.w $601C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$06,x
	STA.w $601C,y
	LDA.w $6024,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$08,x
	STA.w $6024,y
	LDA.w $602C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$0A,x
	STA.w $602C,y
	LDA.w $6034,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$0C,x
	STA.w $6034,y
	LDA.w $603C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$0E,x
	STA.w $603C,y
	LDA.w $6044,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$10,x
	STA.w $6044,y
	LDA.w $604C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$12,x
	STA.w $604C,y
	LDA.w $6054,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$14,x
	STA.w $6054,y
	LDA.w $605C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$16,x
	STA.w $605C,y
	LDA.w $6064,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$18,x
	STA.w $6064,y
	LDA.w $606C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$1A,x
	STA.w $606C,y
	LDA.w $6074,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$1C,x
	STA.w $6074,y
	LDA.w $607C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$1E,x
	STA.w $607C,y
	PLB
	PLX
CODE_03ABF7:
	SEP.b #$10
CODE_03ABF9:
	RTL

;---------------------------------------------------------------------------

CODE_03ABFA:
	LDY.w $74A2,x
	CPY.b #$FF
	BEQ.b CODE_03ABF9
	REP.b #$10
	LDY.w $7362,x
	BPL.b CODE_03AC0B
	JMP.w CODE_03ACED

CODE_03AC0B:
	PHX
	PHB
	PHK
	PLB
	LDA.w $7722,x
	TAX
	LDA.w $6004,y
	AND.w #$FE00
	ORA.w DATA_03AA0E,x
	STA.w $6004,y
	LDA.w $600C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$02,x
	STA.w $600C,y
	LDA.w $6014,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$04,x
	STA.w $6014,y
	LDA.w $601C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$06,x
	STA.w $601C,y
	LDA.w $6024,y
	AND.w #$FE00
	EOR.w #$4000
	ORA.w DATA_03AA0E+$02,x
	STA.w $6024,y
	LDA.w $602C,y
	AND.w #$FE00
	EOR.w #$4000
	ORA.w DATA_03AA0E,x
	STA.w $602C,y
	LDA.w $6034,y
	AND.w #$FE00
	EOR.w #$4000
	ORA.w DATA_03AA0E+$06,x
	STA.w $6034,y
	LDA.w $603C,y
	AND.w #$FE00
	EOR.w #$4000
	ORA.w DATA_03AA0E+$04,x
	STA.w $603C,y
	LDA.w $6044,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$08,x
	STA.w $6044,y
	LDA.w $604C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$0A,x
	STA.w $604C,y
	LDA.w $6054,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$0C,x
	STA.w $6054,y
	LDA.w $605C,y
	AND.w #$FE00
	ORA.w DATA_03AA0E+$0E,x
	STA.w $605C,y
	LDA.w $6064,y
	AND.w #$FE00
	EOR.w #$4000
	ORA.w DATA_03AA0E+$0A,x
	STA.w $6064,y
	LDA.w $606C,y
	AND.w #$FE00
	EOR.w #$4000
	ORA.w DATA_03AA0E+$08,x
	STA.w $606C,y
	LDA.w $6074,y
	AND.w #$FE00
	EOR.w #$4000
	ORA.w DATA_03AA0E+$0E,x
	STA.w $6074,y
	LDA.w $607C,y
	AND.w #$FE00
	EOR.w #$4000
	ORA.w DATA_03AA0E+$0C,x
	STA.w $607C,y
	PLB
	PLX
CODE_03ACED:
	SEP.b #$10
	RTL

;---------------------------------------------------------------------------

DATA_03ACF0:
	dw $FF00,$0FF0,$00FF

DATA_03ACF6:
	dw $F000,$0F00,$00F0,$000F

DATA_03ACFE:
	dw $FA00,$0FA0,$00FA

DATA_03AD04:
	dw $8000,$4000,$2000,$1000,$0800,$0400,$0200,$0100
	dw $0080,$0040,$0020,$0010,$0008,$0004,$0002,$0001

CODE_03AD24:
	PHX
	PHB
	PHK
	PLB
	SEC
	ROR.w $0000
	LDX.b #$06
CODE_03AD2E:
	LDA.w $7ECC
	AND.w DATA_03ACF6,x
	BNE.b CODE_03AD3B
	STX.w $0001
	BRA.b CODE_03AD40

CODE_03AD3B:
	CMP.w DATA_03ACF6,x
	BNE.b CODE_03AD49
CODE_03AD40:
	DEX
	DEX
	BPL.b CODE_03AD2E
	LDX.w $0001
	BMI.b CODE_03AD5C
CODE_03AD49:
	TXA
	ASL
	ASL
	TAX
	LDA.w $7ECC
	LDY.b #$04
CODE_03AD52:
	BIT.w DATA_03AD04,x
	BEQ.b CODE_03AD60
	INX
	INX
	DEY
	BNE.b CODE_03AD52
CODE_03AD5C:
	PLB
	PLX
	CLC
	RTL

CODE_03AD60:
	LDA.w DATA_03AD04,x
	STA.w $7ECE,x
	TSB.w $7ECC
	TXA
	AND.w #$00FF
	PLB
	PLX
	STA.w $7722,x
	SEC
	RTL

CODE_03AD74:
	PHX
	PHB
	PHK
	PLB
	LDA.w $7ECC
	LDX.b #$06
CODE_03AD7D:
	BIT.w DATA_03ACF6,x
	BEQ.b CODE_03AD8A
	DEX
	DEX
	BPL.b CODE_03AD7D
	PLB
	PLX
	CLC
	RTL

CODE_03AD8A:
	TXA
	ASL
	ASL
	TAY
	LDA.w DATA_03ACF6,x
	STA.w $7ECE,y
	TSB.w $7ECC
	TYA
	AND.w #$00FF
	PLB
	PLX
	STA.w $7722,x
	SEC
	RTL

CODE_03ADA2:
	PHX
	PHB
	PHK
	PLB
	LDA.w $7ECC
	LDX.b #$04
CODE_03ADAB:
	BIT.w DATA_03ACFE,x
	BEQ.b CODE_03ADB8
	DEX
	DEX
	BPL.b CODE_03ADAB
	PLB
	PLX
	CLC
	RTL

CODE_03ADB8:
	TXA
	ASL
	ASL
	TAY
	LDA.w DATA_03ACFE,x
	STA.w $7ECE,y
	TSB.w $7ECC
	TYA
	AND.w #$00FF
	PLB
	PLX
	STA.w $7722,x
	SEC
	RTL

CODE_03ADD0:
	PHX
	PHB
	PHK
	PLB
	LDA.w $7ECC
	LDX.b #$04
CODE_03ADD9:
	BIT.w DATA_03ACF0,x
	BEQ.b CODE_03ADE6
	DEX
	DEX
	BPL.b CODE_03ADD9
	PLB
	PLX
CODE_03ADE4:
	CLC
	RTL

CODE_03ADE6:
	TXA
	ASL
	ASL
	TAY
	LDA.w DATA_03ACF0,x
	STA.w $7ECE,y
	TSB.w $7ECC
	TYA
	AND.w #$00FF
	PLB
	PLX
	STA.w $7722,x
	SEC
	RTL

CODE_03ADFE:
	LDA.w $7ECC
	BNE.b CODE_03ADE4
	LDA.w #$FFFF
	STA.w $7ECE
	STA.w $7ECC
	STZ.w $7722,x
	SEC
	RTL

CODE_03AE11:
	PHX
	PHB
	PHK
	PLB
	SEC
	ROR.w $0000
	LDX.b #$06
CODE_03AE1B:
	LDA.w $7ECC
	AND.w DATA_03ACF6,x
	BNE.b CODE_03AE28
	STX.w $0001
	BRA.b CODE_03AE2D

CODE_03AE28:
	CMP.w DATA_03ACF6,x
	BNE.b CODE_03AE36
CODE_03AE2D:
	DEX
	DEX
	BPL.b CODE_03AE1B
	LDX.w $0001
	BMI.b CODE_03AE49
CODE_03AE36:
	TXA
	ASL
	ASL
	TAX
	LDA.w $7ECC
	LDY.b #$04
CODE_03AE3F:
	BIT.w DATA_03AD04,x
	BEQ.b CODE_03AE4D
	INX
	INX
	DEY
	BNE.b CODE_03AE3F
CODE_03AE49:
	PLB
	PLX
	BRA.b CODE_03AEA1

CODE_03AE4D:
	LDA.w DATA_03AD04,x
	STA.w $7ECE,x
	TSB.w $7ECC
	TXA
	AND.w #$00FF
	PLB
	PLX
	STA.w $7722,x
	RTL

CODE_03AE60:
	PHX
	PHB
	PHK
	PLB
	LDA.w $7ECC
	LDX.b #$06
CODE_03AE69:
	BIT.w DATA_03ACF6,x
	BEQ.b CODE_03AE76
	DEX
	DEX
	BPL.b CODE_03AE69
	PLB
	PLX
	BRA.b CODE_03AEA1

CODE_03AE76:
	TXA
	ASL
	ASL
	TAY
	LDA.w DATA_03ACF6,x
	STA.w $7ECE,y
	TSB.w $7ECC
	TYA
	AND.w #$00FF
	PLB
	PLX
	STA.w $7722,x
	RTL

CODE_03AE8D:
	PHX
	PHB
	PHK
	PLB
	LDA.w $7ECC
	LDX.b #$04
CODE_03AE96:
	BIT.w DATA_03ACFE,x
	BEQ.b CODE_03AEA7
	DEX
	DEX
	BPL.b CODE_03AE96
	PLB
	PLX
CODE_03AEA1:
	PLA
	PLY
	JML.l CODE_03A31E

CODE_03AEA7:
	TXA
	ASL
	ASL
	TAY
	LDA.w DATA_03ACFE,x
	STA.w $7ECE,y
	TSB.w $7ECC
	TYA
	AND.w #$00FF
	PLB
	PLX
	STA.w $7722,x
	RTL

CODE_03AEBE:
	PHX
	PHB
	PHK
	PLB
	LDA.w $7ECC
	LDX.b #$04
CODE_03AEC7:
	BIT.w DATA_03ACF0,x
	BEQ.b CODE_03AED4
	DEX
	DEX
	BPL.b CODE_03AEC7
	PLB
	PLX
	BRA.b CODE_03AEA1

CODE_03AED4:
	TXA
	ASL
	ASL
	TAY
	LDA.w DATA_03ACF0,x
	STA.w $7ECE,y
	TSB.w $7ECC
	TYA
	AND.w #$00FF
	PLB
	PLX
	STA.w $7722,x
	RTL

CODE_03AEEB:
	LDA.w $7ECC
	BNE.b CODE_03AEA1
	LDA.w #$FFFF
	STA.w $7ECE
	STA.w $7ECC
	STZ.w $7722,x
	RTL

;---------------------------------------------------------------------------

CODE_03AEFD:
	LDY.w $7722,x
	LDA.w $7ECE,y
	TRB.w $7ECC
	LDA.w #$FFFF
	STA.w $7722,x
	RTL

;---------------------------------------------------------------------------

CODE_03AF0D:
	LDY.w $7722,x
	BMI.b CODE_03AF1E
	LDA.w $7ECE,y
	TRB.w $7ECC
	LDA.w #$FFFF
	STA.w $7722,x
CODE_03AF1E:
	RTL

;---------------------------------------------------------------------------

DATA_03AF1F:
	dw FXCODE_08867E,FXCODE_088205

CODE_03AF23:
	LDA.w $7D38,x
	BEQ.b CODE_03AF42
	LDY.w $7722,x
	BMI.b CODE_03AF42
	LDA.w $7403,x
	AND.w #$00FF
	BEQ.b CODE_03AF42
	DEC
	BNE.b CODE_03AF3E
	JSL.l CODE_03AA2E
	BRA.b CODE_03AF42

CODE_03AF3E:
	JSL.l CODE_03AA52
CODE_03AF42:
	LDY.w $6F00,x
	CPY.b #$10
	BNE.b CODE_03AF54
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BEQ.b CODE_03AF57
CODE_03AF54:
	PLA
	PLY
	RTL

CODE_03AF57:
	LDA.w $7D96,x
	BEQ.b CODE_03AFB0
	CMP.w #$0020
	BCS.b CODE_03AF76
	LSR
	BNE.b CODE_03AF6B
	LDA.w #$0077
	JSL.l CODE_0085D2
CODE_03AF6B:
	AND.w #$0001
	ASL
	DEC
	ADC.w $70E2,x
	STA.w $70E2,x
CODE_03AF76:
	LDA.w $7042,x
	AND.w #$00F1
	ORA.w #$0006
	STA.w $7042,x
	LDA.w $7A98,x
	BNE.b CODE_03AF91
	LDA.w #$000C
	STA.w $7A98,x
	JSL.l CODE_03B5C3
CODE_03AF91:
	LDA.w $7D38,x
	BNE.b CODE_03AFB6
	DEC.w $7D96,x
	BNE.b CODE_03AFA9
	JSL.l CODE_04849E
	JSL.l CODE_03B078
	LDA.w #$FD00
	STA.w $7222,x
CODE_03AFA9:
	JSL.l CODE_03A1BE
	PLA
	PLY
	RTL

CODE_03AFB0:
	LDA.w $7D38,x
	BNE.b CODE_03AFB6
	RTL

CODE_03AFB6:
	DEC
	BEQ.b CODE_03AFBC
	DEC.w $7D38,x
CODE_03AFBC:
	LDY.w $7722,x
	BMI.b CODE_03AFF0
	LDA.w $7403,x
	AND.w #$00FF
	BEQ.b CODE_03AFF0
	LDA.b $16,x
	CLC
	ADC.w #$0010
	AND.w #$00FF
	STA.b $16,x
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	JSL.l CODE_03B631
	LDA.l DATA_03AF1F,x
	LDX.b #FXCODE_088205>>16
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
CODE_03AFF0:
	LDA.w $7860,x
	AND.w #$000C
	BEQ.b CODE_03B02B
	LDA.w $7542,x
	CMP.w #$0040
	BCS.b CODE_03B005
	JSR.w CODE_03B11B
	BRA.b CODE_03B02B

CODE_03B005:
	LDA.w $7220,x
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	STA.w $7220,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w $7D96,x
	BEQ.b CODE_03B024
	PLA
	PLY
	JML.l CODE_03B595

CODE_03B024:
	LDA.w #$001F
	JSL.l CODE_03B212
CODE_03B02B:
	LDA.w $7860,x
	BIT.w #$0001
	BNE.b CODE_03B04D
	AND.w #$0002
	BEQ.b CODE_03B058
	LDA.w $7542,x
	CMP.w #$0040
	BCC.b CODE_03B055
	STZ.w $7222,x
	LDA.w #$001F
	JSL.l CODE_03B212
	JMP.w CODE_03B0C1

CODE_03B04D:
	LDA.w $7542,x
	CMP.w #$0040
	BCS.b CODE_03B05B
CODE_03B055:
	JSR.w CODE_03B11B
CODE_03B058:
	JMP.w CODE_03B0C1

CODE_03B05B:
	LDA.w #$001F
	JSL.l CODE_03B212
	JSL.l CODE_03A58B
	LDA.b $18,x
	CMP.w #$0003
	BCC.b CODE_03B0AC
	LDA.w $6FA2,x
	AND.w #$6000
	BNE.b CODE_03B078
	STZ.w $7220,x
CODE_03B078:
	JSL.l CODE_03AF0D
	TXY
	LDA.w $7360,x
	JSL.l CODE_03A377
	LDA.w $77C2,x
	AND.w #$00FF
	STA.w $7400,x
	JSL.l CODE_039A6C
	LDA.w $7D96,x
	BEQ.b CODE_03B0A5
	STZ.w $7220,x
	LDA.w $7042,x
	AND.w #$00F1
	ORA.w #$0006
	STA.w $7042,x
CODE_03B0A5:
	RTL

;---------------------------------------------------------------------------

DATA_03B0A6:
	dw $FD80,$FDC0,$FE00

CODE_03B0AC:
	INC.b $18,x
	LDA.b $18,x
	ASL
	TXY
	TAX
	LDA.l DATA_03B0A6-$02,x
	TYX
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
CODE_03B0C1:
	LDY.w $7D36,x
	DEY
	BMI.b CODE_03B118
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_03B118
	LDA.w $7D96,y
	BEQ.b CODE_03B0DF
	PHY
	TYX
	JSL.l CODE_03B595
	PLY
	LDX.b $12
	BRA.b CODE_03B0EE

CODE_03B0DF:
	LDA.w $6FA0,y
	AND.w #$0020
	BNE.b CODE_03B118
	TYX
	JSL.l CODE_03B24B
	BCS.b CODE_03B118
CODE_03B0EE:
	LDA.w $7542,x
	CMP.w #$0040
	BCS.b CODE_03B10B
	LDA.w $7360,x
	CMP.w #$0022
	BCC.b CODE_03B10B
	CMP.w #$002C
	BCS.b CODE_03B10B
	LDA.w #$0004
	STA.w $7542,x
	BRA.b CODE_03B118

CODE_03B10B:
	LDA.w $7D96,x
	BEQ.b CODE_03B114
	JML.l CODE_03B595

CODE_03B114:
	JSL.l CODE_03B24B
CODE_03B118:
	PLA
	PLY
	RTL

CODE_03B11B:
	CMP.w #$0002
	BCS.b CODE_03B123
	LDA.w #$FFCE
CODE_03B123:
	ADC.w #$0099
	CMP.w #$009F
	BCC.b CODE_03B12E
	LDA.w #$009E
CODE_03B12E:
	JSL.l CODE_03B212
	RTS

CODE_03B133:
	LDY.w $7D36,x
	BPL.b CODE_03B140
	JSL.l CODE_03D35D
	TYX
	JSR.w (DATA_03B141,x)
CODE_03B140:
	RTL

DATA_03B141:
	dw CODE_03B149
	dw CODE_03B149
	dw CODE_03B18B
	dw CODE_03B1C4

CODE_03B149:
	LDX.b $12
	LDA.w $7C16,x
	EOR.w $7220,x
	BPL.b CODE_03B18A
	LDA.w #$001C
	JSL.l CODE_0085D2
	LDA.w #$FE00
	LDY.w $77C2,x
	BEQ.b CODE_03B165
	LDA.w #$0200
CODE_03B165:
	STA.w $60B4
	STA.w $60A8
	EOR.w #$FFFF
	INC
	STA.w $7220,x
	LDA.w #$FD00
	STA.w $60AA
	LDA.w #$0008
	STA.w $60C0
	LDA.w #$FD00
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
CODE_03B18A:
	RTS

CODE_03B18B:
	LDX.b $12
	LDA.w $7C18,x
	EOR.w $7222,x
	BPL.b CODE_03B1C3
	LDA.w #$001C
	JSL.l CODE_0085D2
	LDA.w $7222,x
	BPL.b CODE_03B1A4
	LDA.w #$0000
CODE_03B1A4:
	BIT.w $60AA
	BMI.b CODE_03B1AE
	CMP.w $60AA
	BMI.b CODE_03B1B1
CODE_03B1AE:
	STA.w $60AA
CODE_03B1B1:
	LDA.w #$0005
	STA.w $60C2
	LDA.w #$FC00
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
CODE_03B1C3:
	RTS

CODE_03B1C4:
	LDX.b $12
	LDA.w $7C18,x
	EOR.w $7222,x
	BPL.b CODE_03B20A
	LDA.w #$001C
	JSL.l CODE_0085D2
	LDA.w $60AA
	BPL.b CODE_03B1DD
	LDA.w #$0000
CODE_03B1DD:
	BIT.w $7222,x
	BMI.b CODE_03B1E7
	CMP.w $7222,x
	BMI.b CODE_03B1F0
CODE_03B1E7:
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
CODE_03B1F0:
	LDA.w $60FC
	AND.w #$0018
	BNE.b CODE_03B1FE
	LDA.w #$FC00
	STA.w $60AA
CODE_03B1FE:
	LDA.w #$0008
	STA.w $60C0
	LDA.w #$8001
	STA.w $60D2
CODE_03B20A:
	RTS

CODE_03B20B:
	STZ.w $60D4
	JSR.w CODE_03B1F0
	RTL

;---------------------------------------------------------------------------

CODE_03B212:
	JSL.l CODE_0085D2
	LDA.w #$0040
	STA.w $61F2
	LDA.w $70E2,x
	STA.w $6EB2
	LDA.w $7182,x
	STA.w $6EB4
	RTL

;---------------------------------------------------------------------------

DATA_03B229:
	dw $0001,$0003,$0005

CODE_03B22F:
	LDY.w $7D36,x
	BEQ.b CODE_03B248
	BPL.b CODE_03B23B
	JSL.l CODE_03A5BE
	RTL

CODE_03B23B:
	LDA.w $6EFF,y
	CMP.w #$0010
	BNE.b CODE_03B248
	LDA.w $7D37,y
	BNE.b CODE_03B249
CODE_03B248:
	RTL

CODE_03B249:
	DEY
	TYX
CODE_03B24B:
	JSL.l CODE_04906C
	BEQ.b CODE_03B257
	JSL.l CODE_0EBE8D
	BNE.b CODE_03B25B
CODE_03B257:
	LDX.b $12
	SEC
	RTL

CODE_03B25B:
	LDA.w $7360,x
	CMP.w #$0028
	BNE.b CODE_03B266
CODE_03B263:
	JMP.w CODE_03B34C

CODE_03B266:
	CMP.w #$002B
	BNE.b CODE_03B273
	LDA.w $75E2,x
	CMP.w #$0401
	BCS.b CODE_03B263
CODE_03B273:
	LDA.w #$000C
	STA.w $6F00,x
	STZ.w $7222,x
	LDA.w #$0400
	STA.w $75E2,x
	STZ.w $7220,x
	STZ.w $7540,x
CODE_03B288:
	LDA.w $7360,x
	CMP.w #$0022
	BCC.b CODE_03B2D0
	CMP.w #$002C
	BCS.b CODE_03B2D0
	CMP.w #$0026
	BCC.b CODE_03B2BF
	CMP.w #$0027
	BEQ.b CODE_03B2AF
	LDA.w $7542,x
	CMP.w #$0040
	BCC.b CODE_03B313
	LDA.w $7360,x
	CMP.w #$0029
	BCS.b CODE_03B313
CODE_03B2AF:
	LDA.w #$0001
	STA.b $18,x
	LDA.w #$0040
	STA.w $7542,x
	STZ.w $7D38,x
	BRA.b CODE_03B30B

CODE_03B2BF:
	JSR.w CODE_03B3C2
	LDA.w #$0040
	STA.w $7542,x
CODE_03B2C8:
	LDA.w #$0010
	STA.w $6F00,x
	BRA.b CODE_03B31C

CODE_03B2D0:
	CMP.w #$0107
	BNE.b CODE_03B2DC
	JSL.l CODE_01AE1E
	JMP.w CODE_03B3BE

CODE_03B2DC:
	LDA.w #$0040
	STA.w $7542,x
	LDA.w $7360,x
	CMP.w #$01A5
	BCC.b CODE_03B34E
	CMP.w #$01AA
	BCS.b CODE_03B34E
	LDA.w $7A98,x
	BNE.b CODE_03B34C
	LDY.b $12
	PHY
	STX.b $12
	JSL.l CODE_02B2BB
	PLY
	STY.b $12
	LDA.w $7360,y
	CMP.w #$0199
	BNE.b CODE_03B30B
	JMP.w CODE_03B3AD

CODE_03B30B:
	LDA.w #$0010
	STA.w $6F00,x
	BRA.b CODE_03B31C

CODE_03B313:
	LDA.w #$000E
	STA.w $6F00,x
	STZ.w $7D38,x
CODE_03B31C:
	LDY.b $12
	LDA.w $7C76,y
	BNE.b CODE_03B328
	CPX.w $7972
	BRA.b CODE_03B331

CODE_03B328:
	CPX.b $12
	BEQ.b CODE_03B330
	EOR.w #$FFFF
	INC
CODE_03B330:
	ASL
CODE_03B331:
	LDA.w #$FF00
	BCC.b CODE_03B339
	LDA.w #$0100
CODE_03B339:
	STA.w $7220,x
	LDA.w #$FE00
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
	JSL.l CODE_03A0A1
CODE_03B34C:
	BRA.b CODE_03B3B6

CODE_03B34E:
	CMP.w #$0115
	BNE.b CODE_03B380
CODE_03B353:
	LDA.w $7042,x
	BIT.w #$0002
	BEQ.b CODE_03B373
CODE_03B35B:
	JSL.l CODE_03A4E9
	LDA.w #$0093
	INC.w $03B4
	LDY.w $03B4
	CPY.b #$14
	BMI.b CODE_03B36D
	INC
CODE_03B36D:
	JSL.l CODE_0085D2
	BRA.b CODE_03B3BE

CODE_03B373:
	JSL.l CODE_03A520
	LDA.w #$0009
	JSL.l CODE_0085D2
	BRA.b CODE_03B3BE

CODE_03B380:
	CMP.w #$0100
	BNE.b CODE_03B39C
	LDA.w $70E2,x
	STA.w $0000
	LDA.w $7182,x
	SEC
	SBC.w #$0004
	STA.w $0002
	LDA.b $18,x
	INC
	JSL.l CODE_03A4A5
CODE_03B39C:
	LDY.b $12
	LDA.w $7360,y
	CMP.w #$0107
	BNE.b CODE_03B3AD
	TXY
	JSR.w CODE_03B42F
	JMP.w CODE_03B2C8

CODE_03B3AD:
	SEP.b #$20
	LDA.b #$FF
	STA.w $74A0,x
	REP.b #$20
CODE_03B3B6:
	CPX.w $61B6
	BNE.b CODE_03B3BE
	STZ.w $61B6
CODE_03B3BE:
	LDX.b $12
	CLC
	RTL

CODE_03B3C2:
	LDA.w $70E2,x
	STA.w $0000
	LDA.w $7182,x
	STA.w $0002
	LDA.w $7042,x
	STA.w $0004
	PHX
	JSL.l CODE_04F88E
	PLX
	TXY
	LDA.w $7360,x
	SEC
	SBC.w #$0022
	ASL
	TAX
	JSR.w (DATA_03B3E9,x)
	TYX
	RTS

DATA_03B3E9:
	dw CODE_03B3FA
	dw CODE_03B42A
	dw CODE_03B41D
	dw CODE_03B3F1

CODE_03B3F1:
	TYX
	PLA
	PLA
	JSL.l CODE_03A31E
	BRA.b CODE_03B3BE

CODE_03B3FA:
	LDA.w #$0115
	JSL.l CODE_03A377
	LDA.w $7042,y
	EOR.w #$0006
	STA.w $7042,y
CODE_03B40A:
	LDA.w #$0100
	STA.w $7A96,y
	LDA.w #$0140
	STA.w $7A98,y
	LDA.w #$0010
	STA.w $7AF6,y
	RTS

CODE_03B41D:
	LDA.w #$0115
	JSL.l CODE_03A377
	BRA.b CODE_03B40A

CODE_03B426:
	JSR.w CODE_03B42F
	RTL

CODE_03B42A:
	LDA.w #$0001
	BRA.b CODE_03B432

CODE_03B42F:
	LDA.w #$0000
CODE_03B432:
	STA.b $08
	LDA.w $03B6
	CMP.w #$012C
	LDA.w #$01A2
	BCC.b CODE_03B442
	LDA.w #$0115
CODE_03B442:
	JSL.l CODE_03A377
	LDA.w #$0000
	STA.w $7D96,y
	LDA.w $03B6
	CMP.w #$012C
	BCC.b CODE_03B459
	JSR.w CODE_03B40A
	BRA.b CODE_03B468

CODE_03B459:
	LDA.w #$0180
	STA.w $7A96,y
	SEP.b #$20
	LDA.b #$FF
	STA.w $74A0,y
	REP.b #$20
CODE_03B468:
	LDA.b $08
	BEQ.b CODE_03B479
	PHY
	LDA.w $03B6
	CLC
	ADC.w #$000A
	JSL.l CODE_03C793
	PLY
CODE_03B479:
	RTS

;---------------------------------------------------------------------------

CODE_03B47A:
	LDY.w $03BA
	CPY.b #$1E
	BCS.b CODE_03B49D
CODE_03B481:
	PHX
	STA.b $04
	ASL
	TAX
	LDA.w $03BA
	CLC
	ADC.l DATA_03B229-$06,x
	CMP.w #$001E
	BCC.b CODE_03B496
	LDA.w #$001E
CODE_03B496:
	STA.w $03BA
	PLX
	JMP.w CODE_03A4C3

CODE_03B49D:
	LDA.w #$0115
	TXY
	JSL.l CODE_03A364
	BCC.b CODE_03B4D5
	LDA.b $00
	STA.w $70E2,y
	LDA.b $02
	STA.w $7182,y
	LDA.w #$0030
	STA.w $7A96,y
	STA.w $7A98,y
	STA.w $7AF6,y
	STA.w $79D8,y
	LDA.w #$FE80
	STA.w $7222,y
	LDA.w #$0008
	STA.w $7542,y
	LDA.w $6FA2,y
	AND.w #$FFE0
	STA.w $6FA2,y
CODE_03B4D5:
	RTL

;---------------------------------------------------------------------------

CODE_03B4D6:
	PHY
	LDA.w #$003B
	JSL.l CODE_03B212
	PLY
CODE_03B4DF:
	LDA.w $70E2,y
	STA.b $00
	LDA.w $7182,y
	STA.b $02
	LDA.w #$0208
	JSL.l CODE_008B21
	LDA.b $00
	STA.w $70A2,y
	LDA.b $02
	STA.w $7142,y
	LDA.w #$0003
	STA.w $7782,y
	LDA.w #$0016
	STA.w $73C2,y
	RTL

;---------------------------------------------------------------------------

CODE_03B507:
	JSL.l CODE_03B25B
CODE_03B50B:
	LDA.w $70E2,x
	CLC
	ADC.w #$0008
	STA.b $00
	LDA.w $7182,x
	CLC
	ADC.w #$0008
	STA.b $02
	BRA.b CODE_03B56B

CODE_03B51F:
	JSL.l CODE_03B25B
CODE_03B523:
	LDA.w $70E2,x
	CLC
	ADC.w $608C
	CMP.w #$8000
	ROR
	CLC
	ADC.w #$0008
	STA.b $00
	LDA.w $7182,x
	CLC
	ADC.w $6090
	BRA.b CODE_03B555

CODE_03B53D:
	LDA.w $70E2,x
	CLC
	ADC.w $70E2,y
	CMP.w #$8000
	ROR
	CLC
	ADC.w #$0008
	STA.b $00
	LDA.w $7182,x
	CLC
	ADC.w $7182,y
CODE_03B555:
	CMP.w #$8000
	ROR
	CLC
	ADC.w #$0002
	STA.b $02
	LDA.w $0CCE
	BEQ.b CODE_03B565
	RTL

CODE_03B565:
	LDA.w #$0010
	STA.w $0CCE
CODE_03B56B:
	LDA.w #$01E6
CODE_03B56E:
	PHA
	LDA.w #$001C
	JSL.l CODE_03B212
	PLA
CODE_03B577:
	JSL.l CODE_008B21
	LDA.b $00
	STA.w $70A2,y
	LDA.b $02
	STA.w $7142,y
	LDA.w #$0004
	STA.w $7782,y
	LDA.w #$0007
	STA.w $73C2,y
	STA.w $7E4C,y
	RTL

;---------------------------------------------------------------------------

CODE_03B595:
	LDA.w #$00A1
	JSL.l CODE_0085D2
	LDA.w #$01F2
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w #$000B
	STA.w $73C2,y
	LDA.w #$0004
	STA.w $7782,y
	JSL.l CODE_03B288
	JML.l CODE_03A31E

;---------------------------------------------------------------------------

CODE_03B5C3:
	JSL.l CODE_008408
	LDA.w $796F
	AND.w #$FF00
	ORA.w $7BB8,x
	STA.w !REGISTER_Multiplicand
	LDA.w $7971
	LSR
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderHi
	AND.w #$00FF
	BCC.b CODE_03B5E4
	EOR.w #$FFFF
CODE_03B5E4:
	ADC.w $70E2,x
	STA.b $00
	JSL.l CODE_008408
	LDA.w $796F
	AND.w #$FF00
	ORA.w $7BB6,x
	STA.w !REGISTER_Multiplicand
	LDA.w $7971
	LSR
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderHi
	AND.w #$00FF
	BCC.b CODE_03B60A
	EOR.w #$FFFF
CODE_03B60A:
	ADC.w $7182,x
	STA.b $02
	LDA.w #$01F0
	JSL.l CODE_008B21
	LDA.b $00
	STA.w $70A2,y
	LDA.b $02
	SEC
	SBC.w #$0004
	STA.w $7142,y
	LDA.w #$0006
	STA.w $7E4C,y
	LDA.w #$0004
	STA.w $7782,y
	RTL

;---------------------------------------------------------------------------

CODE_03B631:
	REP.b #$10
	TYX
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDX.b $12
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w $7403,x
	AND.w #$00FF
	DEC
	ASL
	TAY
	LDA.w $7360,x
	ASL
	TAX
	LDA.l FXDATA_0AAB14,x
	TAX
	AND.w #$0400
	BEQ.b CODE_03B665
	LDA.w #$8000
CODE_03B665:
	STA.b $00
	TXA
	BIT.w #$0200
	BEQ.b CODE_03B66F
	INC.b $00
CODE_03B66F:
	BIT.w #$0100
	BEQ.b CODE_03B67A
	LDA.w #$4000
	TSB.b $00
	TXA
CODE_03B67A:
	AND.w #$0080
	TSB.b $00
	TXA
	AND.w #$0070
	XBA
	LSR
	TSB.b $00
	TXA
	AND.w #$000F
	ASL
	ASL
	ASL
	ORA.b $00
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	SEP.b #$10
	TYX
	RTL

;---------------------------------------------------------------------------

CODE_03B697:
	LDA.w $7860,x
	LSR
	BCS.b CODE_03B6D9
CODE_03B69D:
	LDA.w $75E2,x
	SEC
	SBC.w $7222,x
	ASL
	LDA.w $7542,x
	BCC.b CODE_03B6AE
	EOR.w #$FFFF
	INC
CODE_03B6AE:
	CLC
	ADC.w $7222,x
	STA.w $7222,x
	AND.w #$00FF
	XBA
	CLC
	ADC.w $7180,x
	STA.w $7180,x
	LDA.w $7222,x
	AND.w #$FF00
	BPL.b CODE_03B6CB
	ORA.w #$00FF
CODE_03B6CB:
	XBA
	ADC.w #$0000
	STA.w $72C2,x
	CLC
	ADC.w $7182,x
	STA.w $7182,x
CODE_03B6D9:
	LDA.w $75E0,x
	SEC
	SBC.w $7220,x
	ASL
	LDA.w $7540,x
	BCC.b CODE_03B6EA
	EOR.w #$FFFF
	INC
CODE_03B6EA:
	CLC
	ADC.w $7220,x
	STA.w $7220,x
	AND.w #$00FF
	XBA
	CLC
	ADC.w $70E0,x
	STA.w $70E0,x
	LDA.w $7220,x
	AND.w #$FF00
	BPL.b CODE_03B707
	ORA.w #$00FF
CODE_03B707:
	XBA
	ADC.w #$0000
	STA.w $72C0,x
	CLC
	ADC.w $70E2,x
	STA.w $70E2,x
	RTL

;---------------------------------------------------------------------------

CODE_03B716:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BEQ.b CODE_03B741
	LDA.w $7A96,x
	BEQ.b CODE_03B729
	DEC.w $7A96,x
CODE_03B729:
	LDA.w $7A98,x
	BEQ.b CODE_03B731
	DEC.w $7A98,x
CODE_03B731:
	LDA.w $7AF6,x
	BEQ.b CODE_03B739
	DEC.w $7AF6,x
CODE_03B739:
	LDA.w $7AF8,x
	BEQ.b CODE_03B741
	DEC.w $7AF8,x
CODE_03B741:
	RTL

;---------------------------------------------------------------------------

CODE_03B742:
	JSL.l CODE_03B75E
CODE_03B746:
	LDA.w $7902,x
	BNE.b CODE_03B759
	JSL.l CODE_03D3F8
	BEQ.b CODE_03B755
	JML.l CODE_03A32E

CODE_03B755:
	JSL.l CODE_0ED844
CODE_03B759:
	RTL

;---------------------------------------------------------------------------

DATA_03B75A:
	db $00,$02,$04,$08

CODE_03B75E:
	TXY
	LDA.w $0030
	AND.w #$0003
	TAX
	LDA.w $7042,y
	AND.w #$00F1
	ORA.l DATA_03B75A,x
	AND.w #$00FF
	STA.w $7042,y
	TYX
	RTL

;---------------------------------------------------------------------------

DATA_03B778:
	dw $0002,$0018,$002C,$0040,$0054,$0068,$007C

DATA_03B786:
	dw $0002,$FFFE

DATA_03B78A:
	dw $0000,$0000,$FFFF,$FFFE,$FFFE,$FFFD,$FFFD,$FFFD
	dw $FFFD,$FFFE,$FFFE,$FFFF,$FFFF,$0000,$0000,$0000
	dw $0001,$0000,$0002,$0003,$0003

CODE_03B7B4:
	LDA.w $7AF8,x
	BNE.b CODE_03B7BC
	JMP.w CODE_03B83C

CODE_03B7BC:
	DEC.w $7AF8,x
	BEQ.b CODE_03B7CD
	CMP.w #$0002
	BNE.b CODE_03B83B
	LDA.w #$00FF
	STA.w $74A2,x
	RTL

CODE_03B7CD:
	LDX.b #FXCODE_0BC6B7>>16
	LDA.w #FXCODE_0BC6B7
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$0010
	TRB.w $7E08
	STZ.w $60AE
	JSL.l CODE_04EF27
	LDA.w $6090
	CLC
	ADC.w #$0004
	STA.w $6090
	LDA.w #$0008
	STA.w $60BE
	STA.w $60C0
	LDA.w #$FC00
	STA.w $60AA
	STZ.w $60B4
	STZ.w $60D2
	LDX.b $12
	JSL.l CODE_03BF87
	JSL.l CODE_03A32E
	LDA.w #$0061
	TXY
	JSL.l CODE_03A377
	LDA.w #$0002
	STA.w $6F00,x
	LDA.w $6090
	STA.w $7182
	LDA.w $608C
	STA.w $70E2
	LDA.w #$BC00
	STA.w $6114
	STZ.w $61AE
	STZ.w $61B0
	STZ.w $004D
	JSL.l CODE_01B25E
	LDX.b $12
CODE_03B83B:
	RTL

CODE_03B83C:
	JSL.l CODE_03B9DD
	LDA.w $7E04
	DEC
	BNE.b CODE_03B876
	LDA.w $611C
	CLC
	ADC.w $7CD6
	LSR
	STA.b $00
	LDA.w $611E
	CLC
	ADC.w $7CD8
	LSR
	STA.b $02
	LDA.w #$01E7
	JSL.l CODE_03B56E
	LDA.w #$0012
	STA.w $7AF8,x
	STA.w $61AE
	STA.w $61B0
	RTL

;---------------------------------------------------------------------------

CODE_03B86E:
	JSL.l CODE_03B75E
CODE_03B872:
	JSL.l CODE_03B9DD
CODE_03B876:
	LDA.b $78,x
	BEQ.b CODE_03B87D
	JMP.w CODE_03B96D

CODE_03B87D:
	LDA.w $7A36,x
	BPL.b CODE_03B883
CODE_03B882:
	RTL

CODE_03B883:
	LSR
	BEQ.b CODE_03B88E
	LDA.w $7222,x
	BMI.b CODE_03B882
	JMP.w CODE_03B95E

CODE_03B88E:
	INC.b $16,x
	STZ.w $7402,x
	LDA.b $18,x
	BNE.b CODE_03B8FE
	LDY.w $7860,x
	BNE.b CODE_03B8DA
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
CODE_03B8A8:
	INC.b $18,x
	LDA.w $7042,x
	ORA.w #$0020
	STA.w $7042,x
	LDA.w $6FA0,x
	AND.w #$FFBF
	ORA.w #$0200
	STA.w $6FA0,x
	LDY.b #$01
	LDA.w $7360,x
	CMP.w #$0029
	BCC.b CODE_03B8CB
	LDY.b #$1A
CODE_03B8CB:
	TYA
	STA.b $00
	LDA.w $6FA2,x
	AND.w #$FFC0
	ORA.b $00
	STA.w $6FA2,x
	RTL

CODE_03B8DA:
	LDA.w $7042,x
	AND.w #$00CF
	STA.w $7042,x
	RTL

;---------------------------------------------------------------------------

DATA_03B8E4:
	db $01,$00,$01,$00,$02,$00,$02,$00,$04,$00,$04,$00,$08,$00,$08,$00

DATA_03B8F4:
	db $01,$01,$00,$00,$04,$04,$02,$02,$04,$04

CODE_03B8FE:
	LDA.w $7AF6,x
	BEQ.b CODE_03B92A
	LSR
	BNE.b CODE_03B90F
	TXY
	JSL.l CODE_03B4D6
	JML.l CODE_03A31E

CODE_03B90F:
	CMP.w #$0040
	BCS.b CODE_03B92A
	LSR
	LSR
	AND.w #$000E
	TAY
	LDA.w DATA_03B8E4,y
	LDY.b #$05
	AND.w $7AF6,x
	BEQ.b CODE_03B926
	LDY.b #$FF
CODE_03B926:
	TYA
	STA.w $74A2,x
CODE_03B92A:
	LDA.w $7860,x
	LSR
	BCS.b CODE_03B940
	LDA.w #$000A
	STA.w $7A98,x
	LDA.w $7222,x
	BPL.b CODE_03B95E
	INC.w $7402,x
	BRA.b CODE_03B96C

CODE_03B940:
	JSL.l CODE_03A590
	LDY.w $7A98,x
	BEQ.b CODE_03B954
	LDA.w DATA_03B8F4,y
	AND.w #$00FF
	STA.w $7402,x
	BRA.b CODE_03B95E

CODE_03B954:
	LDA.b $16,x
	AND.w #$0010
	BEQ.b CODE_03B95E
	INC.w $7402,x
CODE_03B95E:
	LDY.w $7D36,x
	BPL.b CODE_03B96C
	LDA.w $60AE
	BNE.b CODE_03B96C
	JSL.l CODE_03BEB9
CODE_03B96C:
	RTL

CODE_03B96D:
	JSL.l CODE_03BB1D
	STZ.w $7402,x
	LDA.w $0812,y
	AND.w #$FF00
	BEQ.b CODE_03B983
	BPL.b CODE_03B9BC
	INC.w $7402,x
	BRA.b CODE_03B9BC

CODE_03B983:
	LDA.w $6EBC
	SEC
	SBC.w $70E2,x
	STA.b $00
	ORA.w $60A8
	BEQ.b CODE_03B9AC
	LDA.b $16,x
	AND.w #$000F
	ASL
	TAY
	LDA.w DATA_03B78A,y
	BEQ.b CODE_03B9A0
	INC.w $7402,x
CODE_03B9A0:
	LDA.b $00
	BEQ.b CODE_03B9C3
	BPL.b CODE_03B9C6
	EOR.w #$FFFF
	INC
	BNE.b CODE_03B9C6
CODE_03B9AC:
	LDA.b $16,x
	CLC
	ADC.w #$0010
	STA.b $16,x
	AND.w #$0100
	BEQ.b CODE_03B9BC
	INC.w $7402,x
CODE_03B9BC:
	LDA.b $16,x
	AND.w #$000F
	BEQ.b CODE_03B9C6
CODE_03B9C3:
	LDA.w #$0001
CODE_03B9C6:
	SEP.b #$10
	CLC
	ADC.b $16,x
	STA.b $16,x
	AND.w #$000F
	ASL
	TAY
	LDA.w $7182,x
	CLC
	ADC.w DATA_03B78A,y
	STA.w $7182,x
	RTL

;---------------------------------------------------------------------------

CODE_03B9DD:
	LDY.w $6F00,x
	CPY.b #$08
	BNE.b CODE_03BA43
	LDA.w $6152
	CLC
	ADC.w $6154
	CLC
	ADC.w #$0010
	CMP.w #$0021
	BCS.b CODE_03BA43
	STZ.w $6168
	LDA.w #$0010
	STA.w $6F00,x
	STZ.w $7D38,x
	STZ.w $7860,x
	STZ.w $7A96,x
	LDA.w $7360,x
	CMP.w #$0027
	BEQ.b CODE_03BA17
	LDA.w $7040,x
	ORA.w #$0004
	STA.w $7040,x
CODE_03BA17:
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$FBC0
	STA.w $7222,x
	LDA.w $7C16,x
	PHP
	BPL.b CODE_03BA2D
	EOR.w #$FFFF
	INC
CODE_03BA2D:
	CLC
	ADC.w #$0100
	PLP
	BMI.b CODE_03BA38
	EOR.w #$FFFF
	INC
CODE_03BA38:
	CLC
	ADC.w $60A8
	STA.w $7220,x
	PLA
	PLA
	PLA
	RTL

CODE_03BA43:
	LDA.w $7D38,x
	BNE.b CODE_03BA57
	LDA.b $78,x
	DEC
	BMI.b CODE_03BA53
	LDA.w $61AE
	BNE.b CODE_03BA53
	RTL

CODE_03BA53:
	JML.l CODE_03AF23

CODE_03BA57:
	LDY.b #$34
	LDA.w $7360,x
	CMP.w #$0029
	BCC.b CODE_03BA84
	LDA.w $7860,x
	LSR
	BCC.b CODE_03BA82
	LDA.w #$0060
	STA.w $61C6
	JSL.l CODE_0294B4
	JSL.l CODE_03B273
	STZ.w $7220,x
	LDA.w #$0047
	JSL.l CODE_0085D2
	PLA
	PLY
	RTL

CODE_03BA82:
	LDY.b #$3A
CODE_03BA84:
	TYA
	STA.b $00
	LDA.w $6FA2,x
	AND.w #$FFC0
	ORA.b $00
	STA.w $6FA2,x
	LDA.w $6FA0,x
	ORA.w #$0600
	STA.w $6FA0,x
	LDY.w $7542,x
	CPY.b #$40
	BCS.b CODE_03BA53
	LDA.w $7A36,x
	DEC
	BNE.b CODE_03BAAC
	JSL.l CODE_03B133
CODE_03BAAC:
	LDY.w $77C0,x
	BNE.b CODE_03BADF
	LDA.w $7A96,x
	BNE.b CODE_03BAD0
	LDA.w $60B0
	CMP.w #$FFF8
	BMI.b CODE_03BAD6
	CMP.w #$00F8
	BPL.b CODE_03BAD6
	LDA.w $60B2
	CMP.w #$0000
	BMI.b CODE_03BAD6
	CMP.w #$00C0
	BPL.b CODE_03BAD6
CODE_03BAD0:
	JSL.l CODE_03CD07
	BRA.b CODE_03BADF

CODE_03BAD6:
	SEP.b #$20
	LDA.b #$01
	STA.w $77C0,x
	REP.b #$20
CODE_03BADF:
	LDA.b $14
	AND.w #$0001
	ORA.w $61B0
	BNE.b CODE_03BB19
	LDA.w #$01DF
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w $7042,x
	AND.w #$0030
	ORA.w #$0006
	STA.w $7002,y
	LDA.w #$0006
	STA.w $7462,y
	DEC
	STA.w $7E4C,y
	STA.w $73C2,y
	DEC
	STA.w $7782,y
CODE_03BB19:
	JML.l CODE_03AF23

;---------------------------------------------------------------------------

CODE_03BB1D:
	STZ.w $7220,x
	STZ.w $7222,x
	LDY.b $78,x
	BMI.b CODE_03BB2A
	JMP.w CODE_03BDA1

CODE_03BB2A:
	PLA
	PLY
	STZ.w $7402,x
	LDA.w $0B57
	BNE.b CODE_03BB39
	LDY.w $60DE
	BNE.b CODE_03BB6B
CODE_03BB39:
	STZ.b $78,x
	INC.b $18,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w $7360,x
	CMP.w #$0028
	BNE.b CODE_03BB62
	LDA.w #$FFFF
	STA.b $18,x
	LDA.w $0B57
	BNE.b CODE_03BB5C
	LDA.b $10
	AND.w #$0003
	BNE.b CODE_03BB62
CODE_03BB5C:
	LDA.w #$0030
	STA.w $7AF6,x
CODE_03BB62:
	LDA.w $7FE8
	BPL.b CODE_03BB6A
	STZ.w $7FE8
CODE_03BB6A:
	RTL

CODE_03BB6B:
	CPY.b #$06
	BCS.b CODE_03BB89
	LDY.b #$00
	LDA.w $60E4
	SEC
	SBC.w $70E2,x
	BEQ.b CODE_03BB82
	BPL.b CODE_03BB7E
	LDY.b #$02
CODE_03BB7E:
	TYA
	STA.w $60C4
CODE_03BB82:
	LDY.w $60DE
	CPY.b #$02
	BEQ.b CODE_03BB8C
CODE_03BB89:
	JMP.w CODE_03BD2E

CODE_03BB8C:
	STZ.w $7A36,x
	STZ.b $78,x
	LDA.w #$0020
	STA.w $7D38,x
	LDA.w $60C4
	EOR.w #$0002
	STA.w $7400,x
	LDY.b #$34
	LDA.w $7360,x
	CMP.w #$0029
	BCC.b CODE_03BBB4
	LDY.b #$3A
	LDA.w $7FE8
	BPL.b CODE_03BBB4
	STZ.w $7FE8
CODE_03BBB4:
	TYA
	STA.b $00
	LDA.w $6FA2,x
	AND.w #$FFC0
	ORA.b $00
	STA.w $6FA2,x
	STZ.b $18,x
	STZ.b $16,x
	LDA.w $7360,x
	CMP.w #$0029
	BCC.b CODE_03BBE4
	LDY.w $0146
	CPY.b #$0D
	BEQ.b CODE_03BBE4
	LDA.w #$0060
	STA.w $7542,x
	LDA.w #$0600
	STA.w $75E2,x
	JMP.w CODE_03BCD9

CODE_03BBE4:
	STZ.w $7542,x
	LDA.w $7360,x
	CMP.w #$0028
	BNE.b CODE_03BC53
	LDA.w $70E2,x
	SEC
	SBC.w $60E4
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7182,x
	SEC
	SBC.w $60E6
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_0BBCF8>>16
	LDA.w #FXCODE_0BBCF8
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDY.w $7400,x
	BNE.b CODE_03BC1A
	EOR.w #$00FF
	INC
CODE_03BC1A:
	SEC
	SBC.w #$0018
	AND.w #$01FE
	PHA
	LDY.w $7400,x
	BEQ.b CODE_03BC2A
	ORA.w #$8000
CODE_03BC2A:
	STA.w $7900,x
	REP.b #$10
	PLX
	LDA.l DATA_00E9D4,x
	ASL
	ASL
	ASL
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.l DATA_00E954,x
	ASL
	ASL
	ASL
	SEP.b #$10
	LDX.b $12
	LDY.w $7400,x
	BNE.b CODE_03BC4E
	EOR.w #$FFFF
	INC
CODE_03BC4E:
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	BRA.b CODE_03BCBB

CODE_03BC53:
	CMP.w #$0026
	BNE.b CODE_03BC92
	LDA.w $70E2,x
	STA.w $7902,x
	LDA.w #$000C
	STA.w $7542,x
	LDA.w #$0005
	STA.w $74A2,x
	LDA.w #$0060
	STA.w $6FA0,x
	LDA.w #$2000
	STA.w $6FA2,x
	LDA.w $7040,x
	AND.w #$FFF3
	STA.w $7040,x
	LDA.w $60E4
	SEC
	SBC.w $70E2,x
	BPL.b CODE_03BC92
	EOR.w #$FFFF
	SEC
	ADC.w $70E2,x
	STA.w $60E4
CODE_03BC92:
	LDA.w $60E4
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $60E6
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $70E2,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7182,x
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$07F0
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_09907C>>16
	LDA.w #FXCODE_09907C
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_03BCBB:
	LDA.w #$0020
	JSL.l CODE_0085D2
	SEP.b #$20
	LDA.b #$01
	STA.w $77C0,x
	REP.b #$20
	STZ.w $7A96,x
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w $7220,x
	LDA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	BRA.b CODE_03BD27

CODE_03BCD9:
	LDA.w $60E4
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $60E6
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $70E2,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7182,x
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0400
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_09907C>>16
	LDA.w #FXCODE_09907C
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	EOR.w $60A8
	ASL
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	BCS.b CODE_03BD11
	ADC.w $60A8
CODE_03BD11:
	STA.w $7220,x
	LDA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	SEC
	SBC.w #$0300
	BPL.b CODE_03BD20
	LDA.w #$0000
CODE_03BD20:
	SEC
	SBC.w #$0100
	ADC.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
CODE_03BD27:
	STA.w $7222,x
	STZ.w $60E0
	RTL

CODE_03BD2E:
	CPY.b #$06
	BNE.b CODE_03BD40
	LDA.w $7360,x
	CMP.w #$0029
	BCC.b CODE_03BD40
	LDA.w #$FFFF
	STA.w $7FE8
CODE_03BD40:
	PHB
	PHK
	PLB
	REP.b #$10
	LDY.w $60BE
	LDA.w DATA_03FCE9,y
	AND.w #$FF00
	BPL.b CODE_03BD53
	ORA.w #$00FF
CODE_03BD53:
	XBA
	CLC
	ADC.w $6090
	STA.w $7182,x
	LDA.w #$0002
	STA.w $74A2,x
	LDA.w DATA_03FAE5,y
	AND.w #$BF00
	BPL.b CODE_03BD6C
	ORA.w #$40FF
CODE_03BD6C:
	XBA
	LDY.w $60C4
	BNE.b CODE_03BD76
	EOR.w #$FFFF
	INC
CODE_03BD76:
	CLC
	ADC.w $608C
	STA.w $70E2,x
	SEP.b #$10
	PLB
	RTL

;---------------------------------------------------------------------------

DATA_03BD81:
	dw $0010,$000D,$000B,$0009,$0008,$0007,$0007,$0006
	dw $0006,$0006,$0007,$0007,$0008,$0009,$000B,$000D

CODE_03BDA1:
	PHB
	PHK
	PLB
	LDA.w $61B8
	BEQ.b CODE_03BDAB
	LDY.b #$00
CODE_03BDAB:
	LDA.w DATA_03B778,y
	STA.b $00
	LDY.b #$00
	CMP.b $76,x
	BEQ.b CODE_03BE1D
	BPL.b CODE_03BDBA
	INY
	INY
CODE_03BDBA:
	LDA.b $76,x
	CLC
	ADC.w DATA_03B786,y
	CMP.w #$0004
	BPL.b CODE_03BDF9
	STA.b $76,x
	DEC
	DEC
	EOR.w #$FFFF
	INC
	CMP.w #$0040
	BCS.b CODE_03BDD5
	JMP.w CODE_03BE48

CODE_03BDD5:
	TAY
	LDA.w DATA_03BD81-$40,y
	CLC
	ADC.w $6090
	STA.w $7182,x
	LDA.w #$0060
	CLC
	ADC.b $76,x
	LSR
	LDY.w $7400,x
	BNE.b CODE_03BDF0
	EOR.w #$FFFF
	INC
CODE_03BDF0:
	CLC
	ADC.w $608C
	STA.w $70E2,x
	PLB
	RTL

CODE_03BDF9:
	CPY.b #$00
	BNE.b CODE_03BE1B
	STA.b $00
	LDA.w $05C0
	SBC.b $00
	BPL.b CODE_03BE0A
	CLC
	ADC.w #$0128
CODE_03BE0A:
	REP.b #$10
	TAY
	LDA.w $0813,y
	AND.w #$00FF
	BNE.b CODE_03BE1D
	LDA.b $00
	STA.b $76,x
	BRA.b CODE_03BE2C

CODE_03BE1B:
	STA.b $76,x
CODE_03BE1D:
	LDA.w $05C0
	SEC
	SBC.b $76,x
	BPL.b CODE_03BE29
	CLC
	ADC.w #$0128
CODE_03BE29:
	REP.b #$10
	TAY
CODE_03BE2C:
	PLB
	LDA.w $05C2,y
	STA.w $70E2,x
	LDA.w $06EA,y
	STA.w $7182,x
	LDA.w $7042,x
	AND.w #$00CF
	ORA.w $0812,y
	STA.w $7042,x
	SEP.b #$10
	RTL

CODE_03BE48:
	ASL
	ASL
	STA.b $02
	LDA.w #$0100
	SEC
	SBC.b $02
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$0100
	BCC.b CODE_03BE5E
	LDA.b $00
	STA.b $76,x
CODE_03BE5E:
	LDA.w $05C0
	SEC
	SBC.b $00
	BPL.b CODE_03BE6A
	CLC
	ADC.w #$0128
CODE_03BE6A:
	REP.b #$10
	TAY
	LDA.w $05C2,y
	SEC
	SBC.w $70E2,x
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w $06EA,y
	SEC
	SBC.w $7182,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	SEP.b #$10
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $70E2,x
	CLC
	ADC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.w $70E2,x
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $7182,x
	CLC
	ADC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.w $7182,x
	PLB
	RTL

;---------------------------------------------------------------------------

DATA_03BEB5:
	dw $0100,$FF00

CODE_03BEB9:
	JSL.l CODE_0CF957
	LDA.w #$0003
	JSL.l CODE_0085D2
	LDA.w $7DF6
	INC
	INC
	CMP.w #$000E
	BCC.b CODE_03BF15
	PHB
	PHK
	PLB
	LDX.w $7DF8
	LDA.w #$000E
	STA.w $6F00,x
	STZ.b $78,x
	STZ.b $18,x
	STZ.b $76,x
	STZ.w $7A36,x
	STZ.w $7A38,x
	STZ.w $7D38,x
	LDY.w $77C2,x
	LDA.w DATA_03BEB5,y
	STA.w $7220,x
	LDA.w #$FC00
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
	PLB
	LDY.b #$02
CODE_03BF01:
	LDA.w $7DF8,y
	STA.w $7DF6,y
	TAX
	TYA
	STA.b $78,x
	INY
	INY
	CPY.w $7DF6
	BCC.b CODE_03BF01
	LDX.b $12
	TYA
CODE_03BF15:
	STA.w $7DF6
	REP.b #$10
	TAY
	CPY.w #$0004
	BCC.b CODE_03BF40
CODE_03BF20:
	LDX.w $7DF4,y
	LDA.w $7360,x
	CMP.w #$0027
	BEQ.b CODE_03BF30
	CMP.w #$0029
	BNE.b CODE_03BF3E
CODE_03BF30:
	TYA
	STA.b $78,x
	TXA
	STA.w $7DF6,y
	DEY
	DEY
	CPY.w #$0004
	BCS.b CODE_03BF20
CODE_03BF3E:
	LDX.b $12
CODE_03BF40:
	TYA
	SEP.b #$10
	STA.b $78,x
	LDA.w #$0002
	STA.b $76,x
	LDA.b $12
	STA.w $7DF6,y
	LDA.w $7040,x
	AND.w #$FFF3
	STA.w $7040,x
	LDA.w $6FA0,x
	AND.w #$F9FF
	ORA.w #$0040
	LDY.w $0146
	CPY.b #$0D
	BNE.b CODE_03BF6B
	ORA.w #$0200
CODE_03BF6B:
	STA.w $6FA0,x
	LDA.w $6FA2,x
	AND.w #$FFC0
	STA.w $6FA2,x
	LDA.w #$0005
	STA.w $74A2,x
	STZ.w $7AF6,x
	STZ.w $7542,x
	STZ.w $7D38,x
	RTL

;---------------------------------------------------------------------------

CODE_03BF87:
	LDY.w $79D8,x
	BEQ.b CODE_03BFF6
	BMI.b CODE_03BFF6
CODE_03BF8E:
	PHP
	SEP.b #$10
	STZ.w $79D8,x
	STZ.w $7978,x
	STZ.w $79D6,x
	STZ.w $7A36,x
	STZ.w $7A38,x
	LDA.w $7360,x
	CMP.w #$0028
	BEQ.b CODE_03BFB4
	LDA.w $6FA0,x
	AND.w #$FFBF
	ORA.w #$0200
	STA.w $6FA0,x
CODE_03BFB4:
	PHY
	LDY.b #$01
	LDA.w $7360,x
	CMP.w #$0029
	BCC.b CODE_03BFC1
	LDY.b #$1A
CODE_03BFC1:
	TYA
	STA.b $00
	LDA.w $6FA2,x
	AND.w #$FFC0
	ORA.b $00
	STA.w $6FA2,x
	LDA.w $7040,x
	ORA.w #$0004
	STA.w $7040,x
	PLY
	PHX
CODE_03BFDA:
	CPY.w $7DF6
	BCS.b CODE_03BFEE
	LDA.w $7DF8,y
	STA.w $7DF6,y
	TAX
	TYA
	STA.w $79D8,x
	INY
	INY
	BRA.b CODE_03BFDA

CODE_03BFEE:
	DEC.w $7DF6
	DEC.w $7DF6
	PLX
	PLP
CODE_03BFF6:
	RTL

;---------------------------------------------------------------------------

CODE_03BFF7:
	PHX
CODE_03BFF8:
	LDY.w $7DF6
	BEQ.b CODE_03C03E
	LDX.w $7DF8
	LDA.w $7360,x
	CMP.w #$0027
	BEQ.b CODE_03C03E
	CMP.w #$0029
	BEQ.b CODE_03C03E
	LDY.w $79D8,x
	JSL.l CODE_03BF8E
	LDA.w $70E2,x
	SEC
	SBC.w $608C
	ASL
	ASL
	ASL
	STA.w $7220,x
	LDA.w #$FC00
	STA.w $7222,x
	STZ.w $79D8,x
	STZ.w $7978,x
	STZ.w $79D6,x
	STZ.w $7A36,x
	STZ.w $7A38,x
	LDA.w #$0200
	STA.w $7AF6,x
	BRA.b CODE_03BFF8

CODE_03C03E:
	PLX
	RTL

;---------------------------------------------------------------------------

CODE_03C040:
	JSL.l CODE_03A31E
	JSL.l CODE_03BF87
	LDA.w $70E2,x
	STA.w $7960
	LDA.w $7182,x
	STA.w $7962
	LDA.w $7042,x
	AND.w #$000E
	STA.w $7964
	LDA.w #$01BE
	JSL.l CODE_008B21
	LDA.w $7960
	CLC
	ADC.w #$0008
	STA.w $70A2,y
	LDA.w $7962
	CLC
	ADC.w #$0008
	STA.w $7142,y
	LDA.w #$0005
	STA.w $7782,y
	RTL

;---------------------------------------------------------------------------

CODE_03C07F:
	JSL.l CODE_03D406
	RTL

;---------------------------------------------------------------------------

DATA_03C084:
	dw $00BE,$00C1,$00CC,$00C1

CODE_03C08C:
	LDA.w $7E06
	BNE.b CODE_03C0CC
	LDY.w $7D36,x
	BMI.b CODE_03C0CC
	DEY
	BMI.b CODE_03C0FC
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_03C0FC
	LDA.w $7D38,y
	BNE.b CODE_03C0B3
	LDA.w $7360,y
	CMP.w #$0018
	BEQ.b CODE_03C0B3
	CMP.w #$0006
	BNE.b CODE_03C0FC
CODE_03C0B3:
	LDA.w $7680,x
	CLC
	ADC.w #$0008
	CMP.w #$0101
	BCS.b CODE_03C0FC
	LDA.w $7682,x
	CMP.w #$00CC
	BCS.b CODE_03C0FC
	TYX
	JSL.l CODE_03B25B
CODE_03C0CC:
	LDA.w #$0027
	JSL.l CODE_0085D2
	LDA.w $70E2,x
	AND.w #$0010
	LSR
	STA.b $00
	LDA.w $7182,x
	AND.w #$0010
	ORA.b $00
	LSR
	LSR
	TAY
	LDA.w DATA_03C084,y
	TXY
	JSL.l CODE_03A377
	LDA.w #$0002
	STA.w $6F00,x
	INC.w $77C0,x
	JSL.l CODE_03B50B
CODE_03C0FC:
	RTL

;---------------------------------------------------------------------------

DATA_03C0FD:
	db $FF,$00,$FF,$00,$FF,$00,$FF,$00,$00,$00,$FF,$00,$00,$00,$08,$08
	db $08,$08,$08,$08,$FF,$FF,$FF,$FF,$FF,$FF,$08,$08,$FF,$FF,$FF,$FF
	db $FF,$FF,$08,$08,$FF,$FF,$FF,$FF,$FF,$FF,$08,$08,$08,$08,$08,$08
	db $FF,$FF,$FF,$FF,$08,$08,$00,$00,$FF,$FF,$FF

DATA_03C138:
	db $00,$04,$04,$04,$04,$04,$04,$04,$04,$00,$00,$04,$04,$00,$00,$04
	db $04,$04,$04,$04,$04,$04,$04,$08,$08,$08,$08,$04,$04,$04,$04,$04
	db $04,$08,$08,$04,$04,$FF,$FF,$08,$08,$04,$04,$04,$04,$04,$04,$04
	db $04,$08,$08,$08,$08,$04,$04,$00,$00,$04,$04,$04,$04

DATA_03C175:
	dw $FF80,$0080

CODE_03C179:
	JSL.l CODE_03D406
	JSL.l CODE_03C236
	BRA.b CODE_03C1C0

CODE_03C183:
	JSL.l CODE_03C236
	LDA.w $7182,x
	AND.w #$0010
	BEQ.b CODE_03C1C4
	LDA.w $70E2,x
	AND.w #$0010
	BNE.b CODE_03C1B2
	INC.w $7A38,x
	LDA.w #$00FF
	STA.w $74A2,x
	BRA.b CODE_03C1C4

CODE_03C1A2:
	JSL.l CODE_03D406
	JSL.l CODE_03C236
	LDA.w $70E2,x
	AND.w #$0010
	BEQ.b CODE_03C1C4
CODE_03C1B2:
	LDY.w $7400,x
	LDA.w DATA_03C175,y
	STA.w $75E0,x
	STA.w $7220,x
	BRA.b CODE_03C1C4

CODE_03C1C0:
	JSL.l CODE_03C236
CODE_03C1C4:
	LDA.w $7360,x
	SEC
	SBC.w #$00AF
	ASL
	STA.b $00
	LDA.w $70E2,x
	STA.w $7900,x
	AND.w #$0010
	LSR
	LSR
	LSR
	LSR
	ORA.b $00
	TAY
	LDA.w DATA_03C0FD-$01,y
	BMI.b CODE_03C207
	XBA
	AND.w #$00FF
	BNE.b CODE_03C1FB
	JSR.w CODE_03C271
	LDA.w $7182,x
	STA.w $7902,x
	LDA.w #$0003
	STA.b $18,x
	JML.l CODE_03C476

CODE_03C1FB:
	CLC
	ADC.w $70E2,x
	STA.b $78,x
	LDA.w #$0002
	STA.w $7540,x
CODE_03C207:
	LDA.w $7182,x
	STA.w $7902,x
	AND.w #$0010
	LSR
	LSR
	LSR
	LSR
	ORA.b $00
	TAY
	LDA.w DATA_03C138,y
	BMI.b CODE_03C22C
	XBA
	AND.w #$00FF
	CLC
	ADC.w $7182,x
	STA.b $76,x
	LDA.w #$0002
	STA.w $7542,x
CODE_03C22C:
	STZ.w $7400,x
	LDA.w #$0002
	STA.w $7402,x
	RTL

;---------------------------------------------------------------------------

CODE_03C236:
	LDA.w $70E2,x
	AND.w #$FFF0
	ORA.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7182,x
	AND.w #$FFF0
	ORA.w #$0008
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	AND.w #$0002
	BEQ.b CODE_03C26A
	LDY.b #$02
	JSL.l CODE_02D985
	PLY
	BRA.b CODE_03C2A5

CODE_03C26A:
	LDA.w #$0002
	STA.w $74A2,x
	RTL

CODE_03C271:
	LDY.w $0BF1
	BEQ.b CODE_03C285
	SEP.b #$20
	LDA.w $74A0,x
CODE_03C27B:
	CMP.w $0BF1,y
	BEQ.b CODE_03C29E
	DEY
	BNE.b CODE_03C27B
	REP.b #$20
CODE_03C285:
	LDY.b $18,x
	BEQ.b CODE_03C29D
	LDA.w $7A96,x
	BNE.b CODE_03C29A
	JSL.l CODE_02808C
	LDA.w #$0040
	STA.w $7A96,x
	BRA.b CODE_03C2A5

CODE_03C29A:
	DEC
	BNE.b CODE_03C2A5
CODE_03C29D:
	RTS

CODE_03C29E:
	REP.b #$20
	LDA.w #$0001
	STA.b $18,x
CODE_03C2A5:
	LDA.w #$0002
	STA.w $6F00,x
	LDA.w #$00FF
	STA.w $74A2,x
	PLA
	RTL

;---------------------------------------------------------------------------

DATA_03C2B3:
	dw $FF00,$0100

DATA_03C2B7:
	dw $FFFF,$0001

DATA_03C2BB:
	dw $0002,$0005

CODE_03C2BF:
	LDA.b $18,x
	BEQ.b CODE_03C2C6
	JMP.w CODE_03C3DF

CODE_03C2C6:
	STZ.w $7400,x
	LDA.w $7A38,x
	BEQ.b CODE_03C2DE
	LDY.b #$02
	JSL.l CODE_02D985
	LDY.b #$FF
	BCC.b CODE_03C2DA
	LDY.b #$02
CODE_03C2DA:
	TYA
	STA.w $74A2,x
CODE_03C2DE:
	LDY.w $77C0,x
	BEQ.b CODE_03C2F3
	LDY.b #$02
	LDA.w $0030
	AND.w #$0001
	BEQ.b CODE_03C2EF
	LDY.b #$FF
CODE_03C2EF:
	TYA
	STA.w $74A2,x
CODE_03C2F3:
	JSL.l CODE_03AF23
	LDA.b $76,x
	BEQ.b CODE_03C30A
	LDY.b #$00
	CMP.w $7182,x
	BMI.b CODE_03C304
	LDY.b #$02
CODE_03C304:
	LDA.w DATA_03C2B3,y
	STA.w $75E2,x
CODE_03C30A:
	LDA.b $78,x
	BEQ.b CODE_03C31F
	LDY.b #$00
	LDA.b $78,x
	CMP.w $70E2,x
	BMI.b CODE_03C319
	LDY.b #$02
CODE_03C319:
	LDA.w DATA_03C2B3,y
	STA.w $75E0,x
CODE_03C31F:
	JSR.w CODE_03C4F1
	LDA.w $7A38,x
	BNE.b CODE_03C32D
	LDY.w $7D36,x
	DEY
	BPL.b CODE_03C32E
CODE_03C32D:
	RTL

CODE_03C32E:
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_03C32D
	LDA.w $7D38,y
	BNE.b CODE_03C348
	LDA.w $7360,y
	CMP.w #$0018
	BEQ.b CODE_03C348
	CMP.w #$0006
	BNE.b CODE_03C32D
CODE_03C348:
	LDA.w $7680,x
	CLC
	ADC.w #$0018
	CMP.w #$0121
	BCS.b CODE_03C32D
	LDA.w $7682,x
	CLC
	ADC.w #$0010
	CMP.w #$00F1
	BCC.b CODE_03C363
	JMP.w CODE_03C3DE

CODE_03C363:
	TYX
	LDA.w #$0032
	JSL.l CODE_03B212
	JSL.l CODE_03B25B
	LDA.w #$0002
	STA.w $74A2,x
	JSL.l CODE_03CC6B
	STZ.w $7E36
	STZ.w $7E38
	LDA.w $7360,x
	SEC
	SBC.w #$00BA
	LSR
	BEQ.b CODE_03C398
	STZ.w $7222,x
	STZ.w $7542,x
	STZ.w $75E2,x
	JSL.l CODE_03C48B
	BRA.b CODE_03C3CF

CODE_03C398:
	LDA.w $7040,x
	SEC
	SBC.w #$2001
	STA.w $7040,x
	LDA.w $6FA2,x
	ORA.w #$0001
	STA.w $6FA2,x
	LDA.w $7900,x
	AND.w #$0010
	EOR.w #$0010
	BNE.b CODE_03C3B9
	LDA.w #$FFF0
CODE_03C3B9:
	STA.b $76,x
CODE_03C3BB:
	LDA.w #$FC00
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
	INC.b $18,x
CODE_03C3CF:
	LDA.w #$0002
	STA.w $74A2,x
	STZ.w $7220,x
	STZ.w $75E0,x
	STZ.w $7540,x
CODE_03C3DE:
	RTL

CODE_03C3DF:
	DEC
	BNE.b CODE_03C42D
	JSL.l CODE_03AF23
	JSL.l CODE_03CC6B
	JSR.w CODE_03C4F1
	LDA.w $7860,x
	AND.w #$0001
	ORA.w $7862,x
	AND.w #$00FF
	BNE.b CODE_03C41E
	LDA.w $7CD6,x
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7182,x
	CLC
	ADC.w #$0010
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w $1DAE
	BNE.b CODE_03C42C
CODE_03C41E:
	LDA.w $7040,x
	CLC
	ADC.w #$2001
	STA.w $7040,x
	JSL.l CODE_03C48B
CODE_03C42C:
	RTL

CODE_03C42D:
	DEC
	BNE.b CODE_03C481
	JSL.l CODE_03AA52
	JSL.l CODE_03AF23
	JSL.l CODE_03CC6B
	JSL.l CODE_03C4AE
	STZ.w $7220,x
	STZ.w $7222,x
	LDA.w $7A38,x
	CLC
	ADC.w #$0018
	STA.w $7A38,x
	CMP.w #$0370
	BCC.b CODE_03C480
	JSL.l CODE_03AEFD
CODE_03C459:
	LDA.w #$003B
	JSL.l CODE_0085D2
	INC.b $18,x
	LDA.w #$0003
	STA.w $7402,x
	LDA.w $7040,x
	CLC
	ADC.w #$0800
	STA.w $7040,x
	JSL.l CODE_04849E
CODE_03C476:
	REP.b #$10
	LDA.w $7360,x
	ASL
	TAX
	JMP.w (DATA_03C51A-$015E,x)

CODE_03C480:
	RTL

CODE_03C481:
	REP.b #$10
	LDA.w $7360,x
	ASL
	TAX
	JMP.w (DATA_03C8ED-$015E,x)

CODE_03C48B:
	LDA.w #$0002
	STA.b $18,x
	JSL.l CODE_03AD74
	BCS.b CODE_03C49B
	PLA
	PLY
	JMP.w CODE_03C459

CODE_03C49B:
	STZ.w $7402,x
	LDA.w $7040,x
	SEC
	SBC.w #$0800
	STA.w $7040,x
	LDA.w #$0100
	STA.w $7A38,x
CODE_03C4AE:
	LDA.w $7A38,x
	CMP.w #$01F0
	BCC.b CODE_03C4B9
	LDA.w #$01F0
CODE_03C4B9:
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$70E0
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0055
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDX.b #FXCODE_0882F8>>16
	LDA.w #FXCODE_0882F8
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	RTL

CODE_03C4F1:
	LDA.w $7A96,x
	BNE.b CODE_03C519
	LDY.w $7A36,x
	LDA.w $7402,x
	CMP.w DATA_03C2BB,y
	BNE.b CODE_03C50C
	TYA
	EOR.w #$0002
	STA.w $7A36,x
	TAY
	LDA.w $7402,x
CODE_03C50C:
	CLC
	ADC.w DATA_03C2B7,y
	STA.w $7402,x
	LDA.w #$0004
	STA.w $7A96,x
CODE_03C519:
	RTS

DATA_03C51A:
	dw CODE_03C562
	dw CODE_03C562
	dw CODE_03C562
	dw CODE_03C562
	dw $0000
	dw CODE_03C562
	dw $0000
	dw CODE_03C60B
	dw CODE_03C654
	dw CODE_03C681
	dw CODE_03C6A3
	dw CODE_03C6B6
	dw CODE_03C6B6
	dw CODE_03C6E3
	dw CODE_03C70B
	dw CODE_03C725
	dw CODE_03C735
	dw CODE_03C76C
	dw CODE_03C7F5
	dw CODE_03C7FB
	dw CODE_03C5E5
	dw CODE_03C81E
	dw CODE_03C81E
	dw CODE_03C81E
	dw CODE_03C83E
	dw CODE_03C83E
	dw $0000
	dw $0000
	dw CODE_03C8A4
	dw CODE_03C8C9

DATA_03C556:
	dw $6061,$6071,$7061,$7071,$0000,$70F0

CODE_03C562:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03AD24
	BCS.b CODE_03C570
	JML.l CODE_03A31E

CODE_03C570:
	LDA.w $7402,x
	STA.b $78,x
	BEQ.b CODE_03C57D
	LDA.w #$0100
	STA.w $7222,x
CODE_03C57D:
	LDA.w #$0007
	STA.w $7402,x
	STZ.w $7A36,x
	LDA.w $6FA2,x
	ORA.w #$0001
	STA.w $6FA2,x
	LDA.w #$0002
	STA.w $7542,x
	LDA.w #$FFC0
	STA.w $75E2,x
	LDA.w #$0020
	STA.w $7A96,x
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w $7360,x
	SEC
	SBC.w #$00AF
	ASL
	TAY
	LDA.w DATA_03C556,y
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0055
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDX.b #FXCODE_088619>>16
	LDA.w #FXCODE_088619
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	RTL

CODE_03C5E5:
	LDX.b $12
	LDA.w $7680,x
	SEC
	SBC.w #$0080
	ASL
	LDA.w #$0000
	BCS.b CODE_03C5F7
	LDA.w #$0040
CODE_03C5F7:
	PHA
	CLC
	ADC.w $70E2,x
	STA.w $70E2,x
	PLA
	SEC
	SBC.w #$0020
	STA.b $78,x
	LDA.w #$0090
	BRA.b CODE_03C616

CODE_03C60B:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03C640
	LDA.w #$0040
CODE_03C616:
	SEP.b #$10
	STA.w $7A96,x
	LDA.w $7182,x
	AND.w #$FFF0
	STA.w $7182,x
CODE_03C624:
	LDA.w $6FA2,x
	AND.w #$FFE0
	STA.w $6FA2,x
	STZ.w $7040,x
	LDA.w #$00FF
	STA.w $74A2,x
	STZ.w $7542,x
	STZ.w $7220,x
	STZ.w $7222,x
	RTL

CODE_03C640:
	LDA.w $7900,x
	STA.b $04
	LDA.w $7902,x
	JML.l CODE_03D3F3

DATA_03C64C:
	dw $FF80,$0080,$0110,$FFE0

CODE_03C654:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03A331
	LDA.w #$0100
	TXY
	JSL.l CODE_03A377
	LDA.w $7900,x
	STA.w $79D8,x
	LDA.w $7902,x
	STA.w $7A36,x
	LDA.w #$0002
	LDY.w $03A3
	CPY.b #$03
	BEQ.b CODE_03C67D
	LDA.w #$0000
CODE_03C67D:
	STA.w $7978,x
	RTL

CODE_03C681:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03A331
	LDY.b #$71
	JSL.l CODE_03C878
	LDA.w #$0110
	BCC.b CODE_03C697
	LDA.w #$00FA
CODE_03C697:
	TXY
	JSL.l CODE_03A377
	LDA.w #$0002
	STA.w $6F00,x
	RTL

CODE_03C6A3:
	SEP.b #$10
	LDX.b $12
	LDA.w #$0047
	JSL.l CODE_0085D2
	JSL.l CODE_0294B4
	JML.l CODE_03A32E

CODE_03C6B6:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03C624
	LDA.w $7CD6,x
	STA.w $70E2,x
	LDA.w $7860,x
	LSR
	LDA.w $7182,x
	BCS.b CODE_03C6D0
	SBC.w #$0004
CODE_03C6D0:
	AND.w #$FFF0
	SEC
	SBC.w #$0010
	STA.w $7182,x
	LDA.w #$0060
	STA.w $7A96,x
	STZ.b $78,x
	RTL

CODE_03C6E3:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03A331
	LDA.w #$0020
	TXY
	JSL.l CODE_03A377
	LDA.w #$0002
	STA.w $6F00,x
	LDA.w #$000C
	STA.b $76,x
	LDA.w #$FD00
	STA.w $7222,x
	LDA.w #$0017
	STA.w $7402,x
	RTL

CODE_03C70B:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03C640
	LDA.w #$0040
	STA.w $7A96,x
	LDA.w $7182,x
	AND.w #$FFF0
	STA.w $7182,x
	JMP.w CODE_03C624

CODE_03C725:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03C640
	JSL.l CODE_03A496
	JML.l CODE_03A32E

CODE_03C735:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03A331
	LDA.w #$0027
	TXY
	JSL.l CODE_03A377
	LDA.w #$FD00
	STA.w $7222,x
	RTL

DATA_03C74C:
	dw $0040,$FF00,$0080,$FF80,$00C0,$FF40,$0020,$FFE0

DATA_03C75C:
	dw $FE00,$FC00,$FC80,$FE80,$FD00,$FD80,$FF00,$FF80

CODE_03C76C:
	LDA.w #$0003
CODE_03C76F:
	STA.b $08
	LDA.w #$0030
	JSL.l CODE_0085D2
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03C640
	LDA.w $70E2,x
	STA.w $0000
	LDA.w $7182,x
	STA.w $0002
	JSL.l CODE_03A32E
	LDA.w $03B6
CODE_03C793:
	STA.b $04
	CMP.w #$012C
	LDA.w #$01A2
	BCC.b CODE_03C7A0
	LDA.w #$0115
CODE_03C7A0:
	JSL.l CODE_03A364
	BCC.b CODE_03C7F2
	LDA.w $0000
	STA.w $70E2,y
	LDA.w $0002
	STA.w $7182,y
	LDA.b $04
	CMP.w #$012C
	BCC.b CODE_03C7BE
	JSR.w CODE_03B40A
	BRA.b CODE_03C7C4

CODE_03C7BE:
	LDA.w #$0180
	STA.w $7A96,y
CODE_03C7C4:
	JSL.l CODE_008408
CODE_03C7C7:
	LDA.w $7970
	AND.w #$000E
	TAX
	LDA.l DATA_03C74C,x
	STA.w $7220,y
	LDA.w $7970
	LSR
	LSR
	LSR
	LSR
	AND.w #$000E
	TAX
	LDA.l DATA_03C75C,x
	STA.w $7222,y
	LDA.b $04
	CLC
	ADC.w #$000A
	DEC.b $08
	BNE.b CODE_03C793
CODE_03C7F2:
	LDX.b $12
	RTL

CODE_03C7F5:
	LDA.w #$0005
	JMP.w CODE_03C76F

CODE_03C7FB:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03A331
	LDA.w #$0093
	TXY
	JSL.l CODE_03A377
	LDA.w #$0002
	STA.w $6F00,x
	LDA.w #$0040
	STA.w $7542,x
	RTL

DATA_03C818:
	dw $0007,$0009,$0005

CODE_03C81E:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03A331
	LDA.w $7360,x
	SEC
	SBC.w #$00C4
	ASL
	TAY
	LDA.w DATA_03C818,y
	TXY
	JSL.l CODE_03A377
	STZ.w $7902,x
	JML.l CODE_048060

CODE_03C83E:
	SEP.b #$10
	LDX.b $12
	STZ.w $7402,x
	LDA.w $7040,x
	SEC
	SBC.w #$2001
	STA.w $7040,x
	LDA.w $6FA2,x
	ORA.w #$0001
	STA.w $6FA2,x
	LDA.w $7042,x
	ORA.w #$0002
	STA.w $7042,x
	LDA.w #$FFFC
	STA.w $7720,x
	LDY.b #$5C
	JSL.l CODE_03C878
	JSL.l CODE_03C3BB
	LDA.w #$0007
	STA.w $74A2,x
	RTL

CODE_03C878:
	SEP.b #$20
	TYA
	LDY.b #$06
CODE_03C87D:
	CMP.w $6EB5,y
	BEQ.b CODE_03C889
	DEY
	BNE.b CODE_03C87D
	SEC
	TYA
	BRA.b CODE_03C88E

CODE_03C889:
	TYA
	ADC.b #$06
	ASL
	ASL
CODE_03C88E:
	STA.w $7180,x
	REP.b #$20
	RTL

DATA_03C894:
	dw $0000,$0002,$0000,$0004,$0000,$0002,$0000,$0000

CODE_03C8A4:
	SEP.b #$10
	LDA.w $7970
	AND.w #$0007
	ASL
	TAY
	LDX.w DATA_03C894,y
	LDY.b $12
	JSR.w (DATA_03C8B8,x)
	TYX
	RTL

DATA_03C8B8:
	dw CODE_03B41D
	dw CODE_03B42F
	dw CODE_03C8BE

CODE_03C8BE:
	TYX
	JSL.l CODE_03A496
	JSL.l CODE_03A32E
	TXY
	RTS

CODE_03C8C9:
	SEP.b #$10
	LDX.b $12
	JSL.l CODE_03C640
	JSL.l CODE_03A331
	LDA.w #$009D
	TXY
	JSL.l CODE_03A377
	LDA.w #$0002
	STA.w $6F00,x
	SEP.b #$20
	LDA.b #$FF
	STA.w $74A0,x
	REP.b #$20
	RTL

DATA_03C8ED:
	dw CODE_03C92D
	dw CODE_03C92D
	dw CODE_03C92D
	dw CODE_03C92D
	dw $0000
	dw CODE_03C92D
	dw $0000
	dw CODE_03CAF8
	dw CODE_03CB66
	dw CODE_03CB66
	dw CODE_03CB66
	dw CODE_03CB6B
	dw CODE_03CD4F
	dw CODE_03CB66
	dw CODE_03CDF2
	dw CODE_03CB66
	dw CODE_03CB66
	dw CODE_03CB66
	dw CODE_03CB66
	dw CODE_03CB66
	dw CODE_03CE91
	dw CODE_03CB66
	dw CODE_03CB66
	dw CODE_03CB66
	dw CODE_03CF58
	dw CODE_03CF58
	dw $0000
	dw $0000
	dw CODE_03CB66
	dw CODE_03CB66

DATA_03C929:
	db $07,$06,$08,$06

CODE_03C92D:
	LDX.b $12
	LDA.b $18,x
	CMP.w #$0003
	BEQ.b CODE_03C93B
	SEP.b #$10
	JMP.w CODE_03CA65

CODE_03C93B:
	LDA.w $7362,x
	CLC
	ADC.w #$0020
	TAY
	JSL.l CODE_03AA3C
	LDA.w $0D0F
	BEQ.b CODE_03C94D
	RTL

CODE_03C94D:
	JSL.l CODE_03AF23
	LDA.w $7222,x
	CMP.w #$0100
	BPL.b CODE_03C966
	LDA.w $7A36,x
	CLC
	ADC.w #$0020
	AND.w #$03FF
	STA.w $7A36,x
CODE_03C966:
	LDY.w $7A37,x
	LDA.w DATA_03C929,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_03C97D
	STZ.w $7222,x
CODE_03C97D:
	LDA.w $7222,x
	SEC
	SBC.w $75E2,x
	BEQ.b CODE_03C98B
	EOR.w $75E2,x
	BMI.b CODE_03C995
CODE_03C98B:
	LDA.w $75E2,x
	EOR.w #$FFFF
	INC
	STA.w $75E2,x
CODE_03C995:
	LDA.b $14
	AND.w #$000F
	BNE.b CODE_03C9A3
	LDA.w #$0808
	JSL.l CODE_029BD9
CODE_03C9A3:
	LDA.w $7A96,x
	BNE.b CODE_03C9EC
	LDY.w $7D36,x
	BPL.b CODE_03C9EC
	LDA.w $7360,x
	SEC
	SBC.w #$00AE
	ASL
	STA.w $0C88
	LDA.w $0C8A
	BEQ.b CODE_03C9D0
	CMP.w $0C88
	BNE.b CODE_03C9F1
	LDA.w #$0500
	STA.w $61F4
	TXY
	JSL.l CODE_03B4D6
	JMP.w CODE_03CA8B

CODE_03C9D0:
	LDA.w $61B2
	BPL.b CODE_03C9EC
	LDA.w $6150
	BEQ.b CODE_03C9ED
	LDA.w $6162
	BEQ.b CODE_03C9ED
	LDA.w $616A
	CMP.w #$0001
	BEQ.b CODE_03C9EC
	CMP.w #$0004
	BNE.b CODE_03C9ED
CODE_03C9EC:
	RTL

CODE_03C9ED:
	JSL.l CODE_04F74A
CODE_03C9F1:
	LDA.w #$0036
	JSL.l CODE_0085D2
	LDA.w #$0010
	STA.w $60AC
	STZ.w $614E
	LDA.w #$0000
	STA.l $70336C
	LDA.w #$2D6C
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$2F6C
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$65E9
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08BC98>>16
	LDA.w #FXCODE_08BC98
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	LDA.w #$7FFF
	STA.l $703070
	LDX.w #$001C
CODE_03CA35:
	LDA.l DATA_5FCB2C,x
	STA.l $70310E,x
	DEX
	DEX
	BPL.b CODE_03CA35
	SEP.b #$10
	LDX.b $12
	LDA.w $0C8A
	BEQ.b CODE_03CA53
	LDA.w #$0003
	STA.w $614E
	JMP.w CODE_03CA8B

CODE_03CA53:
	INC.b $18,x
	LDA.w #$00FF
	STA.w $74A2,x
	LDA.w #$0030
	STA.w $7A96,x
	STZ.w $614E
	RTL

CODE_03CA65:
	LDA.w $0D0F
	BNE.b CODE_03CA72
	LDY.w $614E
	BNE.b CODE_03CA73
	INC.w $614E
CODE_03CA72:
	RTL

CODE_03CA73:
	DEC.w $7A96,x
	BPL.b CODE_03CA8A
	INC.w $614E
	LDA.w #$0164
	STA.w $60BE
	LDA.w #$B800
	STA.w $6114
	JMP.w CODE_03CA8B

CODE_03CA8A:
	RTL

CODE_03CA8B:
	LDA.b $78,x
	BNE.b CODE_03CAC4
	SEP.b #$20
	INC.w $0BF1
	LDY.w $0BF1
	LDA.w $74A0,x
	STA.w $0BF1,y
	REP.b #$20
	JSL.l CODE_03AF0D
	LDA.w $7360,x
	TXY
	JSL.l CODE_03A377
	LDA.w #$0002
	STA.w $6F00,x
	LDA.w $7900,x
	STA.w $70E2,x
	LDA.w $7902,x
	STA.w $7182,x
	LDA.w #$00FF
	STA.w $74A2,x
	RTL

CODE_03CAC4:
	JML.l CODE_03A32E

DATA_03CAC8:
	dw $0004,$000C,$000D,$000E,$000F,$0010,$0011,$0012

DATA_03CAD8:
	dw $FFF0,$0020,$0010,$0000,$FFF0,$FFE0,$FFF0,$0000

DATA_03CAE8:
	dw $FFE0,$0000,$0010,$0020,$0010,$0000,$FFF0,$FFE0

CODE_03CAF8:
	SEP.b #$10
	LDX.b $12
	LDA.w $0D0F
	BNE.b CODE_03CB09
	LDA.w $7A96,x
	BEQ.b CODE_03CB0A
	DEC.w $7A96,x
CODE_03CB09:
	RTL

CODE_03CB0A:
	LDA.w #$0001
	STA.w $61AE
	STA.w $61B0
	LDA.w #$0004
	STA.w $7A96,x
	LDY.b $18,x
	LDA.w DATA_03CAC8-$03,y
	PHY
	JSL.l CODE_0085D2
	PLY
	LDA.w $70E2,x
	CLC
	ADC.w DATA_03CAD8-$03,y
	STA.w $70E2,x
	STA.w $0091
	LDA.w $7182,x
	CLC
	ADC.w DATA_03CAE8-$03,y
	STA.w $7182,x
	STA.w $0093
	INY
	INY
	STY.b $18,x
	CPY.b #$13
	BCC.b CODE_03CB50
	STZ.w $61AE
	STZ.w $61B0
	JSL.l CODE_03A32E
CODE_03CB50:
	LDA.w #$0005
	STA.w $008F
	LDA.w #$6000
	STA.w $0095
	JSL.l CODE_109295
	LDX.b $12
	JML.l CODE_0280AC

CODE_03CB66:
	SEP.b #$10
	LDX.b $12
CODE_03CB6A:
	RTL

CODE_03CB6B:
	SEP.b #$10
	LDX.b $12
	LDA.w $0D0F
	BNE.b CODE_03CB6A
	LDA.b $18,x
	CMP.w #$0003
	BEQ.b CODE_03CB7E
	JMP.w CODE_03CD5F

CODE_03CB7E:
	LDA.w $7A96,x
	BEQ.b CODE_03CB92
	DEC.w $7A96,x
	CMP.w #$0010
	BCC.b CODE_03CB8F
	JML.l CODE_03CC6B

CODE_03CB8F:
	JMP.w CODE_03CC3C

CODE_03CB92:
	LDA.w $70E2,x
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7182,x
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDX.b $12
	JSR.w CODE_03CD3F
	BCS.b CODE_03CBCD
	LDA.w $70E2,x
	CLC
	ADC.b $76,x
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7182,x
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDX.b $12
	JSR.w CODE_03CD3F
	BCC.b CODE_03CBD7
CODE_03CBCD:
	INC.b $18,x
	LDA.w #$0030
	STA.w $7A96,x
	BRA.b CODE_03CC3C

CODE_03CBD7:
	JSR.w CODE_03CD23
	LDA.w $70E2,x
	STA.w $0091
	LDA.w $7182,x
	STA.w $0093
	LDA.w #$0001
	STA.w $008F
	LDA.w #$3D59
	LDY.b $77,x
	BPL.b CODE_03CBF6
	LDA.w #$3D5A
CODE_03CBF6:
	STA.w $0095
	JSL.l CODE_109295
	LDX.b $12
	LDA.w $0091
	CLC
	ADC.b $76,x
	STA.w $0091
	LDA.w #$6600
	LDY.b $77,x
	BPL.b CODE_03CC12
	LDA.w #$6700
CODE_03CC12:
	STA.w $0095
	JSL.l CODE_109295
	LDX.b $12
	LDA.w $70E2,x
	CLC
	ADC.b $76,x
	STA.w $70E2,x
	LDA.w $7182,x
	SEC
	SBC.w #$0010
	STA.w $7182,x
	JSL.l CODE_0280AC
	LDA.w $7142,y
	CLC
	ADC.w #$0010
	STA.w $7142,y
CODE_03CC3C:
	LDA.w $7680,x
	SEC
	SBC.w #$0080
	ASL
	LDA.w #$FF00
	BCS.b CODE_03CC4C
	LDA.w #$0100
CODE_03CC4C:
	STA.w $7E36
	LDA.w $7682,x
	SEC
	SBC.w #$0060
	ASL
	LDA.w #$FF00
	BCS.b CODE_03CC5F
	LDA.w #$0100
CODE_03CC5F:
	STA.w $7E38
CODE_03CC62:
	LDA.w #$0001
	STA.w $61AE
	STA.w $61B0
CODE_03CC6B:
	LDA.w $7E2A
	BNE.b CODE_03CCBA
	LDA.w $0C1E
	ORA.w $0C20
	BEQ.b CODE_03CC79
	RTL

CODE_03CC79:
	LDA.w $7680,x
	SEC
	SBC.w #$0010
	CMP.w #$00D1
	BCS.b CODE_03CC91
	LDA.w $7682,x
	SEC
	SBC.w #$0010
	CMP.w #$00B1
	BCC.b CODE_03CD06
CODE_03CC91:
	LDA.w $0039
	STA.w $0C94
	LDA.w $003B
	STA.w $0C96
	SEP.b #$20
	LDY.b #$17
	LDX.b #$5C
CODE_03CCA3:
	LDA.w $6F00,x
	CPX.b $12
	BNE.b CODE_03CCAC
	LDA.b #$00
CODE_03CCAC:
	STA.w $0C98,y
	DEX
	DEX
	DEX
	DEX
	DEY
	BPL.b CODE_03CCA3
	LDX.b $12
	REP.b #$20
CODE_03CCBA:
	LDA.w #$0001
	STA.w $7E2A
	STX.w $1E2C
	LDA.w $70E2,x
	STA.w $7E2E
	LDA.w $7182,x
	STA.w $7E30
	LDA.w $0039
	STA.w $0C23
	LDA.w $003B
	STA.w $0C27
	LDA.w $60B0
	CMP.w #$0008
	BMI.b CODE_03CCF5
	CMP.w #$00E8
	BPL.b CODE_03CCF5
	LDA.w $60B2
	CMP.w #$0010
	BMI.b CODE_03CCF5
	CMP.w #$00B0
	BMI.b CODE_03CD06
CODE_03CCF5:
	LDA.w #$0001
	STA.w $61AE
	LDA.w #$0002
	CMP.w $61D6
	BCC.b CODE_03CD06
	STA.w $61D6
CODE_03CD06:
	RTL

CODE_03CD07:
	LDA.w $7E2A
	BEQ.b CODE_03CD12
	CPX.w $1E2C
	BEQ.b CODE_03CD12
	RTL

CODE_03CD12:
	JSL.l CODE_03CC6B
	LDA.w $7220,x
	STA.w $7E36
	LDA.w $7222,x
	STA.w $7E38
	RTL

CODE_03CD23:
	LDA.w #$0008
	STA.w $7A96,x
	LDA.b $78,x
	INC
	CMP.w #$0006
	BCC.b CODE_03CD34
	LDA.w #$0001
CODE_03CD34:
	STA.b $78,x
	CLC
	ADC.w #$004A
	JSL.l CODE_0085D2
	RTS

CODE_03CD3F:
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$0000
	CLC
	BEQ.b CODE_03CD4E
	SBC.w #$96D0
	CMP.w #$0009
CODE_03CD4E:
	RTS

CODE_03CD4F:
	SEP.b #$10
	LDX.b $12
	LDA.w $0D0F
	BNE.b CODE_03CD71
	LDA.b $18,x
	CMP.w #$0003
	BEQ.b CODE_03CD80
CODE_03CD5F:
	LDA.w $7A96,x
	BEQ.b CODE_03CD72
	DEC.w $7A96,x
	JSL.l CODE_03CC62
	STZ.w $7E36
	STZ.w $7E38
CODE_03CD71:
	RTL

CODE_03CD72:
	LDA.w $7E2A
	BNE.b CODE_03CD7D
	STZ.w $61AE
	STZ.w $61B0
CODE_03CD7D:
	JMP.w CODE_03A32E

CODE_03CD80:
	LDA.w $7A96,x
	BEQ.b CODE_03CD91
	DEC.w $7A96,x
	CMP.w #$0010
	BCC.b CODE_03CDEF
	JML.l CODE_03CC6B

CODE_03CD91:
	LDA.w $70E2,x
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7182,x
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDX.b $12
	JSR.w CODE_03CD3F
	BCC.b CODE_03CDB7
	INC.b $18,x
	LDA.w #$0030
	STA.w $7A96,x
	BRA.b CODE_03CDEF

CODE_03CDB7:
	JSR.w CODE_03CD23
	LDA.w $70E2,x
	STA.w $0091
	LDA.w $7182,x
	STA.w $0093
	LDA.w #$0001
	STA.w $008F
	LDA.w #$1512
	STA.w $0095
	JSL.l CODE_109295
	LDX.b $12
	JSL.l CODE_0280AC
	LDA.w $7142,y
	SEC
	SBC.w #$0004
	STA.w $7142,y
	LDA.w $70E2,x
	CLC
	ADC.b $76,x
	STA.w $70E2,x
CODE_03CDEF:
	JMP.w CODE_03CC3C

CODE_03CDF2:
	SEP.b #$10
	LDX.b $12
	LDA.w $0D0F
	BNE.b CODE_03CE03
	LDA.w $7A96,x
	BEQ.b CODE_03CE04
	DEC.w $7A96,x
CODE_03CE03:
	RTL

CODE_03CE04:
	LDA.w #$0004
	JSL.l CODE_0085D2
	LDA.w $70E2,x
	STA.w $0091
	LDA.w $7182,x
	STA.w $0093
	JSL.l CODE_03A32E
	LDA.w #$0005
	STA.w $008F
	LDA.w #$6000
	STA.w $0095
	JSL.l CODE_109295
	LDX.b $12
	JML.l CODE_0280AC

;---------------------------------------------------------------------------

DATA_03CE31:
	dw $0000,$0000,$0000,$0000,$0000,$1D24,$1D06,$1D08
	dw $1D06,$1D26,$1D28,$1D0A,$1D02,$1D0C,$1D2A,$1D12
	dw $1C5C,$1C5E,$1C5C,$1D14,$1D16,$1CD0,$1CB6,$1CD2
	dw $1D18,$0000,$1CD4,$1CBA,$1CD6,$0000,$1D12,$1C5C
	dw $1C5E,$1C5C,$1D14,$1D16,$1CD0,$1CB6,$1CD2,$1D18
	dw $1C5C,$1CFE,$1CBA

DATA_03CE87:
	dw $1D00,$1C5C,$1E00,$1E00,$3C00

CODE_03CE91:
	SEP.b #$10
	LDX.b $12
	LDA.w $0D0F
	BEQ.b CODE_03CE9B
	RTL

CODE_03CE9B:
	LDA.w $7A96,x
	BEQ.b CODE_03CEAF
	DEC.w $7A96,x
	CMP.w #$0040
	BCC.b CODE_03CEAC
	JML.l CODE_03CC6B

CODE_03CEAC:
	JMP.w CODE_03CC3C

CODE_03CEAF:
	LDA.w #$0001
	STA.w $61AE
	STA.w $61B0
	LDA.w #$0010
	STA.w $7A96,x
	LDA.w #$0010
	STA.w $61C6
	LDA.w $70E2,x
	SEC
	SBC.b $78,x
	STA.b $04
	LDA.w $7182,x
	SEC
	SBC.w #$0010
	STA.w $0093
	LDY.b $18,x
	INY
	CPY.b #$0A
	BCC.b CODE_03CEE7
	STZ.w $61AE
	STZ.w $61B0
	JML.l CODE_03A32E

CODE_03CEE7:
	STY.b $18,x
	LDA.w DATA_03CE87,y
	TAY
	BNE.b CODE_03CEF9
	LDA.w $7182,x
	CLC
	ADC.w #$0010
	STA.w $7182,x
CODE_03CEF9:
	PHY
	LDA.w #$0047
	JSL.l CODE_0085D2
	PLY
	REP.b #$10
	LDA.w #$0003
	STA.b $00
CODE_03CF09:
	LDA.b $04
	STA.w $0091
	LDA.w #$0005
	STA.b $02
CODE_03CF13:
	LDA.w DATA_03CE31,y
	BEQ.b CODE_03CF1C
	TAX
	LDA.w $0000,x
CODE_03CF1C:
	STA.w $0095
	LDA.w #$0001
	STA.w $008F
	PHY
	JSL.l CODE_109295
	PLY
	LDA.w $0091
	CLC
	ADC.w #$0010
	STA.w $0091
	INY
	INY
	DEC.b $02
	BNE.b CODE_03CF13
	LDA.w $0093
	CLC
	ADC.w #$0010
	STA.w $0093
	DEC.b $00
	BNE.b CODE_03CF09
	SEP.b #$10
	LDX.b $12
	JMP.w CODE_03CC3C

;---------------------------------------------------------------------------

DATA_03CF50:
	dw $8802,$E802

DATA_03CF54:
	dw $0060,$00C0

CODE_03CF58:
	SEP.b #$10
	LDX.b $12
	LDA.b $18,x
	CMP.w #$0004
	BEQ.b CODE_03CF66
	JMP.w CODE_03CFDF

CODE_03CF66:
	LDA.w $0D0F
	BNE.b CODE_03CF81
	JSL.l CODE_03AF23
	JSL.l CODE_03CC6B
	LDA.w $7860,x
	AND.w #$0001
	BNE.b CODE_03CF82
	LDA.w #$0020
	STA.w $7A96,x
CODE_03CF81:
	RTL

CODE_03CF82:
	LDY.w $7A96,x
	BEQ.b CODE_03CFAB
	CPY.b #$10
	BCS.b CODE_03CFAA
	TYA
	AND.w #$0001
	EOR.w $70E2,x
	STA.w $70E2,x
	CPY.b #$04
	BNE.b CODE_03CFAA
	LDA.w $7CD6,x
	STA.b $00
	LDA.w $7CD8,x
	STA.b $02
	LDA.w #$01E7
	JSL.l CODE_03B56E
CODE_03CFAA:
	RTL

CODE_03CFAB:
	INC.b $18,x
	LDA.w #$0001
	STA.w $61AE
	STA.w $61B0
	LDA.w $7360,x
	SEC
	SBC.w #$00C7
	ASL
	TAY
	LDA.w $7040,x
	CLC
	ADC.w DATA_03CF50,y
	AND.w #$FFF3
	STA.w $7040,x
	LDA.w DATA_03CF54,y
	STA.b $16,x
	STZ.b $76,x
	STZ.b $78,x
	STZ.w $7A36,x
	STZ.w $7A38,x
	STZ.w $7720,x
	RTL

CODE_03CFDF:
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_0998B6>>16
	LDA.w #FXCODE_0998B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $0D0F
	BNE.b CODE_03D02A
	LDA.b $18,x
	CMP.w #$0005
	BNE.b CODE_03D040
	LDA.w $7182,x
	PHA
	SEC
	SBC.b $76,x
	STA.w $7182,x
	SEC
	SBC.w $003B
	STA.w $7682,x
	JSL.l CODE_03CC3C
	PLA
	STA.w $7182,x
	LDA.b $76,x
	CMP.b $16,x
	BCS.b CODE_03D02B
	INC.b $76,x
	SBC.w #$0015
	AND.w #$001F
	BNE.b CODE_03D02A
	LDA.w #$0005
	JSL.l CODE_0085D2
CODE_03D02A:
	RTL

CODE_03D02B:
	LDA.w $7A38,x
	CMP.w #$000F
	BCS.b CODE_03D037
	INC.w $7A38,x
	RTL

CODE_03D037:
	INC.b $18,x
	STZ.w $61AE
	STZ.w $61B0
	RTL

CODE_03D040:
	JSL.l CODE_03AF23
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_099B23>>16
	LDA.w #FXCODE_099B23
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w $6000
	BEQ.b CODE_03D05A
	JSL.l CODE_0085D2
CODE_03D05A:
	LDX.b $12
	RTL

;---------------------------------------------------------------------------

CODE_03D05D:
	STZ.b $0E
	LDY.w $7D36,x
	BMI.b CODE_03D066
	CLC
	RTL

CODE_03D066:
	LDA.w $6122
	CLC
	ADC.w $7BB8,x
	STA.b $00
	CLC
	ADC.w $7C18,x
	STA.b $08
	LDA.w $7C18,x
	SEC
	SBC.b $00
	STA.b $0A
	LDY.b #$00
	CLC
	ADC.b $08
	BMI.b CODE_03D086
	LDY.b #$02
CODE_03D086:
	STY.b $0C
	LDA.w $6120
	CLC
	ADC.w $7BB6,x
	STA.b $00
	CLC
	ADC.w $7C16,x
	STA.b $02
	LDA.w $7C16,x
	SEC
	SBC.b $00
	STA.b $04
	LDY.b #$00
	CLC
	ADC.b $02
	BMI.b CODE_03D0A8
	LDY.b #$02
CODE_03D0A8:
	STY.b $06
	LDA.w $7962,y
	BPL.b CODE_03D0B3
	EOR.w #$FFFF
	INC
CODE_03D0B3:
	STA.b $00
	LDY.b $0C
	LDA.w $7968,y
	BPL.b CODE_03D0C0
	EOR.w #$FFFF
	INC
CODE_03D0C0:
	CMP.b $00
	BCC.b CODE_03D0DD
	LDA.w $7968,y
	BMI.b CODE_03D0DA
	LDA.b $00
	CMP.w #$000A
	BCC.b CODE_03D0DA
	REP.b #$10
	JSL.l CODE_04AC9C
	SEP.b #$10
	BRA.b CODE_03D111

CODE_03D0DA:
	JMP.w CODE_03D208

CODE_03D0DD:
	LDA.w $7968,y
	BPL.b CODE_03D0E5
	JMP.w CODE_03D1C4

CODE_03D0E5:
	LDA.w $60C2
	BEQ.b CODE_03D0F4
	LDA.w $7968,y
	CLC
	ADC.w #$000C
	STA.w $7968,y
CODE_03D0F4:
	LDA.w $7968,y
	CMP.w #$000A
	BCC.b CODE_03D111
	CMP.w #$0012
	BCC.b CODE_03D10B
	REP.b #$10
	JSL.l CODE_04AC9C
	SEP.b #$10
	BRA.b CODE_03D111

CODE_03D10B:
	LDA.w #$0005
	STA.w $60C2
CODE_03D111:
	LDA.w $60C0
	BEQ.b CODE_03D120
	LDA.w $6090
	CLC
	ADC.w $72C2,x
	STA.w $6090
CODE_03D120:
	JMP.w CODE_03D1FB

;---------------------------------------------------------------------------

DATA_03D123:
	dw $0001,$FFFF

CODE_03D127:
	STZ.b $0E
CODE_03D129:
	LDY.w $7D36,x
	BMI.b CODE_03D130
	CLC
	RTL

CODE_03D130:
	LDA.w $6122
	CLC
	ADC.w $7BB8,x
	STA.b $00
	CLC
	ADC.w $7C18,x
	STA.b $08
	LDA.w $7C18,x
	SEC
	SBC.b $00
	STA.b $0A
	LDY.b #$00
	CLC
	ADC.b $08
	BMI.b CODE_03D150
	LDY.b #$02
CODE_03D150:
	STY.b $0C
	LDA.w $6120
	CLC
	ADC.w $7BB6,x
	STA.b $00
	CLC
	ADC.w $7C16,x
	STA.b $02
	LDA.w $7C16,x
	SEC
	SBC.b $00
	STA.b $04
	LDY.b #$00
	CLC
	ADC.b $02
	BMI.b CODE_03D172
	LDY.b #$02
CODE_03D172:
	STY.b $06
	LDA.w $7962,y
	BPL.b CODE_03D17D
	EOR.w #$FFFF
	INC
CODE_03D17D:
	STA.b $00
	LDY.b $0C
	LDA.w $7968,y
	BPL.b CODE_03D18A
	EOR.w #$FFFF
	INC
CODE_03D18A:
	CMP.b $00
	BCC.b CODE_03D191
	JMP.w CODE_03D208

CODE_03D191:
	LDA.w $7968,y
	BMI.b CODE_03D1C4
	LDA.w $60C2
	BEQ.b CODE_03D1A5
	LDA.w $7968,y
	CLC
	ADC.w #$000C
	STA.w $7968,y
CODE_03D1A5:
	LDA.w $7968,y
	CMP.w #$000A
	BCC.b CODE_03D1B3
	LDA.w #$0005
	STA.w $60C2
CODE_03D1B3:
	BRA.b CODE_03D1FB

CODE_03D1B5:
	LDA.w $7968,y
	CLC
	ADC.w $6090
	STA.w $6090
	STZ.w $60D2
	BRA.b CODE_03D1FB

CODE_03D1C4:
	CMP.w #$FFF5
	BMI.b CODE_03D208
	SEC
	ADC.w $6090
	STA.w $6090
	LDA.w $7182,x
	SEC
	SBC.w $6EBE
	SEC
	ADC.w $6090
	STA.w $6090
	LDY.w $60AB
	BMI.b CODE_03D22B
	LDA.w $70E2,x
	SEC
	SBC.w $6EBC
	CLC
	ADC.w $608C
	STA.w $608C
	INC.w $61B4
	INC.b $0E
	LDA.w $60AA
	STA.b $0C
CODE_03D1FB:
	SEC
	LDA.w $7222,x
	BPL.b CODE_03D204
	LDA.w #$0000
CODE_03D204:
	STA.w $60AA
	RTL

;---------------------------------------------------------------------------

CODE_03D208:
	LDX.b $06
	LDA.b $00
	LSR
	BEQ.b CODE_03D21A
	LDA.w $608C
	CLC
	ADC.l DATA_03D123,x
	STA.w $608C
CODE_03D21A:
	LDA.w $60B4
	EOR.l DATA_03D123,x
	BPL.b CODE_03D229
	STZ.w $60A8
	STZ.w $60B4
CODE_03D229:
	LDX.b $12
CODE_03D22B:
	CLC
	RTL

;---------------------------------------------------------------------------

CODE_03D22D:
	LDY.w $7D36,x
	BMI.b CODE_03D233
CODE_03D232:
	RTL

CODE_03D233:
	LDA.w $6090
	STA.b $00
	LDA.w $7CD8,x
	SEC
	SBC.w $611E
	SEC
	SBC.w $6122
	SEC
	SBC.w $7BB8,x
	CMP.w #$FFF6
	BCC.b CODE_03D232
	SEC
	ADC.w $6090
	STA.w $6090
	LDA.w $7182,x
	SEC
	SBC.w $6EBE
	SEC
	ADC.w $6090
	STA.w $6090
	SEC
	SBC.b $00
	CLC
	ADC.w $611E
	STA.w $611E
	LDY.w $60AB
	BMI.b CODE_03D232
	LDA.w $70E2,x
	SEC
	SBC.w $6EBC
	CLC
	ADC.w $608C
	STA.w $608C
	INC.w $61B4
	LDA.w $7222,x
	BPL.b CODE_03D289
	LDA.w #$0000
CODE_03D289:
	STA.w $60AA
	RTL

;---------------------------------------------------------------------------

DATA_03D28D:
	dw $0001,$FFFF

CODE_03D291:
	STZ.b $0E
	LDA.w $61B2
	AND.w #$C000
	ORA.w $61CC
	BNE.b CODE_03D2D6
	LDA.w $7BB6,x
	CLC
	ADC.w $7BB6
	STA.b $00
	ASL
	STA.b $02
	LDA.w $7CD6,x
	SEC
	SBC.w $7CD6
	STA.b $04
	CLC
	ADC.b $00
	CMP.b $02
	BCS.b CODE_03D2D6
	LDA.w $7BB8,x
	CLC
	ADC.w $7BB8
	STA.b $06
	ASL
	STA.b $08
	LDA.w $7CD8,x
	SEC
	SBC.w $7CD8
	STA.b $0A
	CLC
	ADC.b $06
	CMP.b $08
	BCC.b CODE_03D2D8
CODE_03D2D6:
	CLC
	RTL

CODE_03D2D8:
	LDA.b $0A
	CLC
	ADC.b $06
	STA.b $08
	LDA.b $0A
	SEC
	SBC.b $06
	STA.b $0A
	LDY.b #$00
	CLC
	ADC.b $08
	BMI.b CODE_03D2EF
	LDY.b #$02
CODE_03D2EF:
	STY.b $0C
	LDA.b $04
	CLC
	ADC.b $00
	STA.b $02
	LDA.b $04
	SEC
	SBC.b $00
	STA.b $04
	LDY.b #$00
	CLC
	ADC.b $02
	BMI.b CODE_03D308
	LDY.b #$02
CODE_03D308:
	STY.b $06
	LDA.w $7962,y
	BPL.b CODE_03D313
	EOR.w #$FFFF
	INC
CODE_03D313:
	STA.b $00
	LDY.b $0C
	LDA.w $7968,y
	BPL.b CODE_03D320
	EOR.w #$FFFF
	INC
CODE_03D320:
	CMP.b $00
	BCS.b CODE_03D339
	CMP.w #$0009
	BCS.b CODE_03D339
	LDA.w $7968,y
	PHP
	LDA.w #$0001
	PLP
	BMI.b CODE_03D334
	ASL
CODE_03D334:
	TSB.w $7860
	SEC
	RTL

CODE_03D339:
	LDX.b $06
	LDA.w $70E2
	CLC
	ADC.l DATA_03D28D,x
	STA.w $70E2
	LDA.w $7220
	EOR.l DATA_03D28D,x
	BPL.b CODE_03D359
	LDA.w $7220
	EOR.w #$FFFF
	INC
	STA.w $7220
CODE_03D359:
	LDX.b $12
	CLC
	RTL

;---------------------------------------------------------------------------

CODE_03D35D:
	LDA.w $6122
	CLC
	ADC.w $7BB8,x
	STA.b $00
	CLC
	ADC.w $7C18,x
	STA.b $08
	LDA.w $7C18,x
	SEC
	SBC.b $00
	STA.b $0A
	LDY.b #$04
	CLC
	ADC.b $08
	BMI.b CODE_03D37D
	LDY.b #$06
CODE_03D37D:
	STY.b $0C
	LDA.w $6120
	CLC
	ADC.w $7BB6,x
	STA.b $00
	CLC
	ADC.w $7C16,x
	STA.b $02
	LDA.w $7C16,x
	SEC
	SBC.b $00
	STA.b $04
	LDY.b #$00
	CLC
	ADC.b $02
	BMI.b CODE_03D39F
	LDY.b #$02
CODE_03D39F:
	STY.b $06
	LDA.w $7962,y
	BPL.b CODE_03D3AA
	EOR.w #$FFFF
	INC
CODE_03D3AA:
	STA.b $00
	LDY.b $0C
	LDA.w $7964,y
	BPL.b CODE_03D3B7
	EOR.w #$FFFF
	INC
CODE_03D3B7:
	CMP.b $00
	BCS.b CODE_03D3C0
	CMP.w #$0008
	BCC.b CODE_03D3C2
CODE_03D3C0:
	LDY.b $06
CODE_03D3C2:
	RTL

;---------------------------------------------------------------------------

DATA_03D3C3:
	dw $03C0,$0440,$04C0,$0540

DATA_03D3CB:
	dw $8000,$4000,$2000,$1000,$0800,$0400,$0200,$0100
	dw $0080,$0040,$0020,$0010,$0008,$0004,$0002,$0001

CODE_03D3EB:
	LDA.w $70E2,x
	STA.b $04
	LDA.w $7182,x
CODE_03D3F3:
	STA.b $06
	SEC
	BRA.b CODE_03D415

CODE_03D3F8:
	LDA.w $70E2,x
	STA.b $04
	LDA.w $7182,x
CODE_03D400:
	STA.b $06
	LDY.b #$02
	BRA.b CODE_03D412

CODE_03D406:
	LDA.w $70E2,x
	STA.b $04
	LDA.w $7182,x
CODE_03D40E:
	STA.b $06
	LDY.b #$00
CODE_03D412:
	STY.b $0E
	CLC
CODE_03D415:
	PHP
	REP.b #$10
	PHX
	LDA.b $04
	AND.w #$00F0
	LSR
	LSR
	LSR
	TAX
	LDA.l DATA_03D3CB,x
	STA.b $0C
	PLX
	PHX
	LDA.w $0150
	ASL
	TAY
	LDA.b $06
	AND.w #$0700
	LSR
	LSR
	LSR
	LSR
	STA.b $00
	LDA.b $05
	AND.w #$000F
	ORA.b $00
	TAX
	LDA.w $6CAA,x
	AND.w #$003F
	ASL
	TYX
	CLC
	ADC.l DATA_03D3C3,x
	STA.b $02
	LDA.b ($02)
	PLX
	SEP.b #$10
	PLP
	BCS.b CODE_03D46A
	AND.b $0C
	BEQ.b CODE_03D469
	LDY.b $0E
	BNE.b CODE_03D469
	JSL.l CODE_03A32E
	PLY
	PLA
	LDY.b #$02
CODE_03D469:
	RTL

CODE_03D46A:
	ORA.b $0C
	STA.b ($02)
	RTL

;---------------------------------------------------------------------------

DATA_03D46F:
	dw CODE_03D55B,CODE_03D55B,CODE_03D55B,CODE_03D55B,CODE_03D55B,CODE_03D55B,CODE_03D55B,CODE_03D55B
	dw CODE_03D55B,CODE_03D55B,CODE_03D55B,CODE_03D55B,CODE_03D55B,CODE_03D55B,CODE_03D55B,CODE_03D55B
	dw CODE_03D83D,CODE_03D83D,CODE_03D83D,CODE_03D83D,CODE_03D83D,CODE_03D83D,CODE_03D83D,CODE_03D83D
	dw CODE_03D83D,CODE_03D83D,CODE_03D83D,CODE_03E3B1,CODE_03E2B5,CODE_03D9CA,CODE_03DA58,CODE_03DA5E
	dw CODE_03DA64,CODE_03DA6A,CODE_03DA70,CODE_03DB85,CODE_03DA70,CODE_03DB85,CODE_03DB8B,CODE_03DC2E
	dw CODE_03DC38,CODE_03DDA3,CODE_03DDB8,CODE_03DDBE,CODE_03DE5A,CODE_03DE60,CODE_03DF0C,CODE_03DF12
	dw CODE_03DFF0,CODE_03DFF6,CODE_03E0AD,CODE_03E0B3,CODE_03E124,CODE_03E142,CODE_03E1E2,CODE_03E2A1
	dw CODE_03E2A7,CODE_03E2C6

DATA_03D4E3:
	dw CODE_03E2CC,CODE_03D615,CODE_03D615,CODE_03D615,CODE_03D615,CODE_03D615,CODE_03D615,CODE_03D615
	dw CODE_03D615,CODE_03D615,CODE_03D615,CODE_03D615,CODE_03D615,CODE_03D615,CODE_03D615,CODE_03D615
	dw CODE_03D615,CODE_03D8D7,CODE_03D8D7,CODE_03D8D7,CODE_03D8D7,CODE_03D8D7,CODE_03D8D7,CODE_03D8D7
	dw CODE_03D8D7,CODE_03D8D7,CODE_03D8D7,CODE_03D8D7,CODE_03A79B,CODE_03A79B,CODE_03D9E6,CODE_03A79B
	dw CODE_03A79B,CODE_03A79B,CODE_03A79B,CODE_03DA80,CODE_03A79B,CODE_03DAEB,CODE_03A79B,CODE_03DBB7
	dw CODE_03A79B,CODE_03DCEC,CODE_03A79B,CODE_03A79B,CODE_03DDDA,CODE_03A79B,CODE_03DE94,CODE_03A79B
	dw CODE_03DF2E,CODE_03A79B,CODE_03E002,CODE_03A79B,CODE_03E0BF,CODE_03A79B,CODE_03E190,CODE_03E1FB
	dw CODE_03A79B,CODE_03A79B,CODE_03A79B,CODE_03E30E

CODE_03D55B:
	LDA.w $7960
	LSR
	BCS.b CODE_03D57E
	LDA.w $0C04,y
	SEC
	SBC.w #$0001
	CMP.w $0136
	BNE.b CODE_03D570
	JMP.w CODE_03D62C

CODE_03D570:
	STA.w $0136
	JSL.l CODE_03D5E4
	STZ.w $0C14
	STZ.w $0C16
	RTS

CODE_03D57E:
	LDA.w $0C04,y
	SEC
	SBC.w #$0001
	CMP.w $0138
	BEQ.b CODE_03D5E1
	STA.w $0138
	ASL
	TAX
	LDA.l DATA_00B874,x
	TAX
	PHY
	PHB
	PEA.w $702038>>8
	PLB
	PLB
	LDY.w #$001C
CODE_03D59E:
	LDA.l DATA_5FA01C,x
	STA.w $702082,y
	STA.w $702DEE,y
	LDA.l DATA_5FA03A,x
	STA.w $7020A2,y
	STA.w $702E0E,y
	DEX
	DEX
	DEY
	DEY
	BPL.b CODE_03D59E
	LDY.w #$0006
CODE_03D5BB:
	LDA.l DATA_5FA060,x
	STA.w $702038,y
	STA.w $702DA4,y
	LDA.l DATA_5FA068,x
	STA.w $702058,y
	STA.w $702DC4,y
	LDA.l DATA_5FA070,x
	STA.w $702078,y
	STA.w $702DE4,y
	DEX
	DEX
	DEY
	DEY
	BPL.b CODE_03D5BB
	PLB
	PLY
CODE_03D5E1:
	JMP.w CODE_03D62C

CODE_03D5E4:
	PHX
	PHY
	PHP
	REP.b #$20
	SEP.b #$10
	LDX.b #$5C
CODE_03D5ED:
	LDA.w $6F00,x
	BEQ.b CODE_03D5FF
	JSL.l CODE_03AF0D
	LDA.w $7402,x
	AND.w #$00FF
	STA.w $7402,x
CODE_03D5FF:
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_03D5ED
	LDA.w #$FFFF
	STA.w $7ECC
	PLP
	PLY
	PLX
	RTL

DATA_03D60F:
	dw $0000,$0800,$7000

CODE_03D615:
	PHY
	LDA.w #$0800
	STA.b $00
	LDA.w $0C16
	BNE.b CODE_03D66A
	LDA.w $0C14
	CMP.w #$0003
	BNE.b CODE_03D640
	PLY
	STZ.w $7ECC
CODE_03D62C:
	SEP.b #$30
	LDX.w $0C0C,y
	LDA.b #$00
	STA.l $7028CA,x
	REP.b #$30
CODE_03D639:
	LDA.w #$0000
	STA.w $0C04,y
	RTS

CODE_03D640:
	ASL
	TAX
	LDA.w DATA_03D60F,x
	STA.w $0C18
	LDA.w #$6800
	STA.w $0C1A
	LDA.w $0136
	ASL
	ADC.w $0136
	ADC.w $0C14
	TAX
	LDA.l DATA_00AF39,x
	AND.w #$00FF
	JSL.l CODE_00B753
	STA.w $0C16
	INC.w $0C14
CODE_03D66A:
	SEC
	SBC.w #$0800
	BCS.b CODE_03D678
CODE_03D670:
	ADC.w #$0800
	STA.b $00
	LDA.w #$0000
CODE_03D678:
	STA.w $0C16
	LDX.w $0C1A
	TXA
	CLC
	ADC.b $00
	STA.w $0C1A
	LDA.w #$0070
	STA.w $0001
	LDY.w $0C18
	LDA.b $00
	JSL.l CODE_00BEA6
	LDA.b $00
	LSR
	CLC
	ADC.w $0C18
	STA.w $0C18
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_03D6A0:
	PHB
	PHK
	PLB
	LDA.w $0C1C
	ASL
	TAX
	JSR.w (DATA_03D4E3,x)
	PLB
	RTL

DATA_03D6AD:
	dw $0000,$000D,$0028,$008C,$00AF,$003E,$0090,$00BC
	dw $00F0,$00F7,$012E,$0138

DATA_03D6C5:
	dw $0020,$3004,$0400,$0040,$8004,$0400,$6EFF,$0660
	dw $6A63,$5B08,$086C,$6C3C,$1E06,$056C,$6916,$1005
	dw $0565,$600C,$0905,$0557,$4D0A,$1005,$0545,$361A
	dw $2105,$052D,$2B30,$4008,$062E,$2F50,$FF05,$300B
	dw $1308,$0836,$371B,$2308,$0839,$3B2A,$4108,$083D
	dw $3E4B,$6008,$084A,$5264,$6608,$085D,$616E,$7108
	dw $0867,$6D6E,$6408,$0870,$7054,$4B06,$0470,$6846
	dw $4104,$045E,$5341,$4304,$044D,$4B48,$5106,$084C
	dw $5161,$7008,$0855,$5882,$8B06,$0459,$59A0,$FF08
	dw $5C11,$1810,$185C,$5D1F,$2320,$1D5F,$6230,$5014
	dw $1269,$6A71,$8F12,$1264,$5FAA,$E012,$155F,$10FF
	dw $0570,$7040,$7007,$0970,$70A0,$FF0B,$501A,$2005
	dw $054E,$502C,$3905,$054E,$4A42,$4D05,$0549,$4858
	dw $6305,$054B,$4E6E,$7E05,$054A,$478A,$9505,$0544
	dw $43A2,$AE05,$0541,$3FB9,$C005,$053E,$3EE0,$FF05
	dw $2002,$0202,$0319,$CBFE,$065A,$5DC0,$B008,$085F
	dw $5DAA,$A608,$085F,$6C98,$8808,$086E,$6780,$7906
	dw $0860,$606B,$4B08,$085A,$5D40,$3008,$085F,$5D2A
	dw $2608,$085F,$6C18,$0808,$086E,$6700,$FE08,$6F20
	dw $8008,$086F,$6FD8,$FF08,$700C,$1408,$086E,$701E
	dw $2A08,$086A,$6A2E,$3B08,$0870,$7053,$710A,$0A70
	dw $708F,$9808,$0467,$5B8F,$9006,$032E,$2C94,$9D08
	dw $082C,$2CA6,$AD08,$0A2F,$36B6,$CA08,$0836,$3AD4
	dw $E204,$0843,$3FF0,$FF08

CODE_03D83D:
	LDA.w $0C1C
	BEQ.b CODE_03D845
	JMP.w CODE_03D639

CODE_03D845:
	LDA.w $0C04,y
	STA.w $0C1C
	STA.w $0C1E
	CMP.w #$001B
	BEQ.b CODE_03D85B
	CMP.w #$0011
	BEQ.b CODE_03D85B
	STA.w $0C20
CODE_03D85B:
	SEC
	SBC.w #$0011
	ASL
	TAX
	LDA.w DATA_03D6AD,x
	STA.w $0C2E
	JSR.w CODE_03D639
	LDA.w $6093
	AND.w #$FF00
	STA.w $0C22
	LDA.w $6095
	AND.w #$00FF
	STA.w $0C24
	LDA.w $609B
	AND.w #$FF00
	STA.w $0C26
	LDA.w $609D
	AND.w #$00FF
	STA.w $0C28
	STZ.w $0C2A
	STZ.w $0C2C
	LDX.w $0C2E
CODE_03D897:
	LDA.w DATA_03D6C5,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	STA.w $0C30
	SEC
	SBC.w $0C23
	STA.w $0C36
	LDA.w DATA_03D6C5+$01,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w #$001C
	STA.w $0C32
	SEC
	SBC.w $0C27
	STA.w $0C38
	LDA.w DATA_03D6C5+$01,x
	AND.w #$FF00
	BPL.b CODE_03D8CE
	ORA.w #$00FF
CODE_03D8CE:
	XBA
	ASL
	ASL
	ASL
	ASL
	STA.w $0C34
	RTS

;---------------------------------------------------------------------------

CODE_03D8D7:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03D93D
	JSR.w CODE_03D942
	LDA.w $0C23
	SEC
	SBC.w $0C30
	BEQ.b CODE_03D8F9
	EOR.w $0C36
	BMI.b CODE_03D8F9
	LDA.w $0C30
	STA.w $0C23
CODE_03D8F9:
	STA.w $0000
	LDA.w $0C27
	SEC
	SBC.w $0C32
	BEQ.b CODE_03D910
	EOR.w $0C38
	BMI.b CODE_03D910
	LDA.w $0C32
	STA.w $0C27
CODE_03D910:
	ORA.w $0000
	BMI.b CODE_03D93D
	LDX.w $0C2E
	LDA.w DATA_03D6C5+$03,x
	AND.w #$00FF
	CMP.w #$00FE
	BCS.b CODE_03D92C
	INX
	INX
	INX
	STX.w $0C2E
	JMP.w CODE_03D897

CODE_03D92C:
	BNE.b CODE_03D934
	STZ.w $0C1E
	STZ.w $0C20
CODE_03D934:
	STZ.w $0C1C
	STZ.w $0C2A
	STZ.w $0C2C
CODE_03D93D:
	RTS

;---------------------------------------------------------------------------

DATA_03D93E:
	dw $FFFF,$0001

CODE_03D942:
	LDA.w $0C30
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $0C32
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $0C23
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $0C27
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w $0C34
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	SEP.b #$10
	LDX.b #FXCODE_09907C>>16
	LDA.w #FXCODE_09907C
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b #$00
	LDA.w $0C2A
	CMP.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	BEQ.b CODE_03D980
	BPL.b CODE_03D979
	LDX.b #$02
CODE_03D979:
	CLC
	ADC.w DATA_03D93E,x
	STA.w $0C2A
CODE_03D980:
	LDX.b #$00
	LDA.w $0C2C
	CMP.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	BEQ.b CODE_03D995
	BPL.b CODE_03D98E
	LDX.b #$02
CODE_03D98E:
	CLC
	ADC.w DATA_03D93E,x
	STA.w $0C2C
CODE_03D995:
	REP.b #$10
CODE_03D997:
	LDX.w #$0000
	LDA.w $0C2A
	BPL.b CODE_03D9A0
	DEX
CODE_03D9A0:
	CLC
	ADC.w $0C22
	STA.w $0C22
	TXA
	ADC.w $0C24
	STA.w $0C24
	LDX.w #$0000
	LDA.w $0C2C
	BPL.b CODE_03D9B7
	DEX
CODE_03D9B7:
	CLC
	ADC.w $0C26
	STA.w $0C26
	TXA
	ADC.w $0C28
	STA.w $0C28
	RTS

;---------------------------------------------------------------------------

CODE_03D9C6:
	JSR.w CODE_03D997
	RTL

;---------------------------------------------------------------------------

CODE_03D9CA:
	LDA.w $0C3A
	BEQ.b CODE_03D9D2
	JMP.w CODE_03D62C

CODE_03D9D2:
	INC.w $0C3A
	RTS

;---------------------------------------------------------------------------

DATA_03D9D6:
	dw $0110,$FFE0

DATA_03D9DA:
	dw $FE00,$0200,$FD00,$0300

DATA_03D9E2:
	dw $0004,$0006

CODE_03D9E6:
	LDA.w $0C3A
	BNE.b CODE_03D9EE
	JMP.w CODE_03D62C

CODE_03D9EE:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03DA57
	LDA.w $0CD2
	BNE.b CODE_03DA57
	LDA.w #$0030
	STA.w $0CD2
	SEP.b #$10
	PHY
	LDA.w #$00E6
	JSL.l CODE_03A364
	BCC.b CODE_03DA54
	LDA.b $10
	AND.w #$001E
	ASL
	ASL
	ASL
	CLC
	ADC.w $003B
	SEC
	SBC.w #$001B
	STA.w $7182,y
	LDA.b $10
	AND.w #$0001
	ASL
	STA.w $7400,y
	STA.b $00
	TAX
	LDA.w $0039
	CLC
	ADC.w DATA_03D9D6,x
	STA.w $70E2,y
	LDA.b $10
	AND.w #$0002
	STA.w $79D8,y
	TAX
	LDA.w DATA_03D9E2,x
	STA.w $7540,y
	TXA
	ASL
	CLC
	ADC.b $00
	TAX
	LDA.w DATA_03D9DA,x
	STA.w $75E0,y
CODE_03DA54:
	PLY
	REP.b #$10
CODE_03DA57:
	RTS

;---------------------------------------------------------------------------

CODE_03DA58:
	STZ.w $0C3A
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03DA5E:
	STZ.w $0C3C
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03DA64:
	STZ.w $0C3E
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03DA6A:
	STZ.w $0C46
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03DA70:
	LDA.w $0C48
	BEQ.b CODE_03DA78
	JMP.w CODE_03D62C

CODE_03DA78:
	INC.w $0C48
	RTS

;---------------------------------------------------------------------------

DATA_03DA7C:
	dw $0110,$FFE0

CODE_03DA80:
	LDA.w $0C48
	BNE.b CODE_03DA88
	JMP.w CODE_03D62C

CODE_03DA88:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03DAEA
	LDA.w $0CD4
	BNE.b CODE_03DAEA
	LDA.w $0C4A
	CMP.w #$0003
	BCS.b CODE_03DAEA
	LDA.w #$0030
	STA.w $0CD4
	SEP.b #$10
	PHY
	LDA.w #$013E
	JSL.l CODE_03A364
	BCC.b CODE_03DAE7
	INC.w $0C4A
	LDA.b $10
	AND.w #$000E
	ASL
	ASL
	ASL
	CLC
	ADC.w $003B
	CLC
	ADC.w #$0030
	STA.w $7182,y
	LDA.w $0073
	STA.w $7400,y
	TAX
	LDA.w $0039
	CLC
	ADC.w DATA_03DA7C,x
	STA.w $70E2,y
	PHB
	LDX.b #$07
	PHX
	PLB
	TYX
	JSL.l CODE_07B1B6
	PLB
	INC.w $7A36,x
CODE_03DAE7:
	PLY
	REP.b #$10
CODE_03DAEA:
	RTS

;---------------------------------------------------------------------------

CODE_03DAEB:
	LDA.w $0C48
	BNE.b CODE_03DAF3
	JMP.w CODE_03D62C

CODE_03DAF3:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03DAEA
	LDA.w $0CD4
	BNE.b CODE_03DAEA
	LDA.w #$0003
	STA.b $00
	LDA.w $021A
	CMP.w #$000F
	BNE.b CODE_03DB30
	SEP.b #$10
	LDX.b #FXCODE_0991D5>>16
	LDA.w #FXCODE_0991D5
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	REP.b #$10
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$0003
	BCC.b CODE_03DB30
	DEC.b $00
	CMP.w #$0005
	BCC.b CODE_03DB30
	DEC.b $00
CODE_03DB30:
	LDA.w $0C4A
	CMP.b $00
	BCS.b CODE_03DB84
	LDA.w #$0030
	STA.w $0CD4
	SEP.b #$10
	PHY
	LDA.w #$013E
	JSL.l CODE_03A364
	BCC.b CODE_03DB81
	INC.w $0C4A
	LDA.b $10
	AND.w #$000E
	ASL
	ASL
	ASL
	CLC
	ADC.w $003B
	CLC
	ADC.w #$0030
	STA.w $7182,y
	LDA.b $10
	AND.w #$0001
	ASL
	STA.w $7400,y
	TAX
	LDA.w $0039
	CLC
	ADC.w DATA_03DA7C,x
	STA.w $70E2,y
	PHB
	LDX.b #$07
	PHX
	PLB
	TYX
	JSL.l CODE_07B1B6
	PLB
	INC.w $7A36,x
CODE_03DB81:
	PLY
	REP.b #$10
CODE_03DB84:
	RTS

;---------------------------------------------------------------------------

CODE_03DB85:
	STZ.w $0C48
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03DB8B:
	LDA.w $0C4C
	BEQ.b CODE_03DB93
	JMP.w CODE_03D62C

CODE_03DB93:
	INC.w $0C4C
	RTS

;---------------------------------------------------------------------------

DATA_03DB97:
	dw $0020,$0030,$0050,$0060,$0090,$0090,$00C0,$00D0

DATA_03DBA7:
	dw $0030,$0060,$0020,$0050,$0040,$0070,$0060,$0030

CODE_03DBB7:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03DC2D
	LDA.w $0CD6
	BNE.b CODE_03DC2D
	LDA.w $0C4E
	CMP.w #$0001
	BCS.b CODE_03DC2D
	PHY
	SEP.b #$10
	LDA.b $10
	AND.w #$0007
	ASL
	TAY
	LDA.w $0039
	AND.w #$FF00
	CLC
	ADC.w DATA_03DB97,y
	CMP.w $0039
	BPL.b CODE_03DBEC
	CLC
	ADC.w #$0100
CODE_03DBEC:
	STA.b $00
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $003B
	AND.w #$FF00
	CLC
	ADC.w DATA_03DBA7,y
	CMP.w $003B
	BPL.b CODE_03DC04
	CLC
	ADC.w #$0100
CODE_03DC04:
	STA.b $02
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$0010
	BNE.b CODE_03DC2A
	LDA.w #$0157
	JSL.l CODE_03A364
	BCC.b CODE_03DC2A
	INC.w $0C4E
	JSL.l CODE_07C30B
CODE_03DC2A:
	REP.b #$10
	PLY
CODE_03DC2D:
	RTS

;---------------------------------------------------------------------------

CODE_03DC2E:
	STZ.w $0C4C
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

DATA_03DC34:
	dw $0901,$1911

CODE_03DC38:
	LDA.b $00
	AND.w #$0001
	STA.b $00
	LDA.b $02
	AND.w #$0001
	ASL
	ORA.b $00
	TAX
	LDA.w DATA_03DC34,x
	AND.w #$00FF
	STA.b $00
	CMP.w $0C50
	BNE.b CODE_03DC58
CODE_03DC55:
	JMP.w CODE_03D62C

CODE_03DC58:
	STA.w $0C50
	LDA.w $0C52
	BNE.b CODE_03DC55
	STZ.w $0C54
	STZ.w $0C5C
	INC.w $0C52
	RTS

;---------------------------------------------------------------------------

DATA_03DC6A:
	db $04,$06,$0E,$08,$0A,$08,$0C,$06,$0C,$0E,$10,$00,$0E,$0C,$10,$02
	db $0A,$04,$0C,$06,$0A,$04,$0E,$08,$0E,$08,$10,$00,$0E,$08,$04,$00

DATA_03DC8A:
	db $0A,$08,$0C,$06,$04,$06,$0E,$08,$0E,$0C,$10,$02,$0C,$0E,$10,$00
	db $0A,$04,$0E,$08,$0A,$04,$0C,$06,$0E,$08,$04,$00,$0E,$08,$10,$00

DATA_03DCAA:
	db $00,$F0,$F0,$00,$00,$10,$10,$00,$00,$00,$00,$E0,$E0,$E0,$E0,$00
	db $00,$00,$00,$F0,$F0,$F0,$F0,$00,$00,$10,$10,$F0,$F0,$00,$00,$E0

DATA_03DCCA:
	db $00,$10,$10,$00,$00,$F0,$F0,$00,$00,$00,$00,$20,$20,$20,$20,$00
	db $00,$00,$00,$10,$10,$10,$10,$00,$00,$10,$10,$F0,$F0,$00,$00,$E0

DATA_03DCEA:
	db $68,$69

CODE_03DCEC:
	LDA.w $0C54
	DEC
	BNE.b CODE_03DD00
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BEQ.b CODE_03DD04
	STA.w $0C56
CODE_03DD00:
	STZ.w $0C66
	RTS

CODE_03DD04:
	LDA.w $0C56
	BEQ.b CODE_03DD0D
	STZ.w $0C56
	RTS

CODE_03DD0D:
	LDA.w $0C5C
	INC
	AND.w #$0007
	STA.w $0C5C
	LDA.w $0C50
	CLC
	ADC.w $0C5C
	TAX
	LDA.w DATA_03DC6A-$01,x
	AND.w #$00FF
	STA.w $0C58
	LDA.w DATA_03DC8A-$01,x
	AND.w #$00FF
	STA.w $0C5A
	PHY
	LDY.w $0C66
	BEQ.b CODE_03DD4E
	LDY.w #$0000
	CMP.w #$000A
	BEQ.b CODE_03DD45
	CMP.w #$0003
	BMI.b CODE_03DD45
	INY
CODE_03DD45:
	LDA.w DATA_03DCEA,y
	TAY
	TYA
	JSL.l CODE_0085D2
CODE_03DD4E:
	PLY
	LDA.w DATA_03DCAA-$01,x
	AND.w #$00FF
	CMP.w #$0080
	BMI.b CODE_03DD5D
	ORA.w #$FF00
CODE_03DD5D:
	STA.w $0C5E
	LDA.w DATA_03DCCA-$01,x
	AND.w #$00FF
	CMP.w #$0080
	BMI.b CODE_03DD6E
	ORA.w #$FF00
CODE_03DD6E:
	STA.w $0C60
	TXA
	DEC
	AND.w #$0007
	TAX
	LDA.w DATA_03DCAA-$01,x
	AND.w #$00FF
	CMP.w #$0080
	BMI.b CODE_03DD85
	ORA.w #$FF00
CODE_03DD85:
	STA.w $0C62
	LDA.w DATA_03DCCA-$01,x
	AND.w #$00FF
	CMP.w #$0080
	BMI.b CODE_03DD96
	ORA.w #$FF00
CODE_03DD96:
	STA.w $0C64
	LDX.w #$0002
	STX.w $0CD8
	STZ.w $0C66
	RTS

;---------------------------------------------------------------------------

CODE_03DDA3:
	STZ.w $0C50
	STZ.w $0C52
	STZ.w $0CD8
	STZ.w $0C58
	STZ.w $0C5A
	STZ.w $0C66
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03DDB8:
	STZ.w $0C68
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03DDBE:
	LDA.w $0C6A
	BEQ.b CODE_03DDC6
	JMP.w CODE_03D62C

CODE_03DDC6:
	INC.w $0C6A
	RTS

;---------------------------------------------------------------------------

DATA_03DDCA:
	dw $0120,$0130,$FFD0,$FFC0

DATA_03DDD2:
	dw $0020,$0060,$00A0,$00E0

CODE_03DDDA:
	LDA.w $0C6A
	BNE.b CODE_03DDE2
	JMP.w CODE_03D62C

CODE_03DDE2:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03DE59
	LDA.w $0CDA
	BNE.b CODE_03DE59
	LDA.w $0C6C
	CMP.w #$0004
	BCS.b CODE_03DE59
	LDA.w #$0030
	STA.w $0CDA
	SEP.b #$10
	PHY
	LDA.w #$0152
	JSL.l CODE_03A364
	BCC.b CODE_03DE56
	INC.w $0C6C
	LDA.w $0073
	STA.w $7400,y
	ASL
	STA.b $00
	LDA.b $10
	AND.w #$0001
	ASL
	ORA.b $00
	TAX
	LDA.w $0039
	CLC
	ADC.w DATA_03DDCA,x
	STA.w $70E2,y
	LDA.b $10
	AND.w #$0003
	ASL
	TAX
	LDA.w $003B
	CLC
	ADC.w DATA_03DDD2,x
	STA.w $7182,y
	PHB
	LDX.b #$07
	PHX
	PLB
	TYX
	JSL.l CODE_07BB20
	PLB
	LDA.w $7040,x
	AND.w #$FFF3
	STA.w $7040,x
	LDA.w #$0001
	STA.w $7A36,x
CODE_03DE56:
	PLY
	REP.b #$10
CODE_03DE59:
	RTS

;---------------------------------------------------------------------------

CODE_03DE5A:
	STZ.w $0C6A
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03DE60:
	LDA.w $0C6E
	BEQ.b CODE_03DE68
	JMP.w CODE_03D62C

CODE_03DE68:
	INC.w $0C6E
	RTS

;---------------------------------------------------------------------------

DATA_03DE6C:
	dw $0000,$0010,$0020,$0030,$0040,$0050,$0060,$0070
	dw $0080,$0090,$00A0,$00B0,$00C0,$00D0,$00E0,$00F0

DATA_03DE8C:
	dw $FFF0,$FFE0,$FFD0,$FFC0

CODE_03DE94:
	LDA.w $0C6E
	BNE.b CODE_03DE9C
	JMP.w CODE_03D62C

CODE_03DE9C:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03DF0B
	LDA.w $0CDC
	BNE.b CODE_03DF0B
	SEP.b #$10
	PHY
	LDA.w #$0165
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0166
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDX.b #FXCODE_0991DB>>16
	LDA.w #FXCODE_0991DB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$0004
	BCS.b CODE_03DF08
	LDA.w #$0020
	STA.w $0CDC
	LDA.w #$0165
	JSL.l CODE_03A364
	BCC.b CODE_03DF08
	LDA.b $10
	AND.w #$000F
	ASL
	TAX
	LDA.w $0039
	CLC
	ADC.w DATA_03DE6C,x
	STA.w $70E2,y
	LDA.b $10
	AND.w #$0003
	ASL
	TAX
	LDA.w $003B
	CLC
	ADC.w DATA_03DE8C,x
	STA.w $7182,y
	PHB
	LDX.b #$0F
	PHX
	PLB
	TYX
	JSL.l CODE_0F8B36
	PLB
CODE_03DF08:
	PLY
	REP.b #$10
CODE_03DF0B:
	RTS

;---------------------------------------------------------------------------

CODE_03DF0C:
	STZ.w $0C6E
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03DF12:
	LDA.w $0C70
	BEQ.b CODE_03DF1A
	JMP.w CODE_03D62C

CODE_03DF1A:
	INC.w $0C70
	RTS

;---------------------------------------------------------------------------

DATA_03DF1E:
	dw $0110,$0120,$FFE0,$FFD0

DATA_03DF26:
	dw $0010,$0020,$0030,$0040

CODE_03DF2E:
	JSL.l CODE_008408
	LDA.w $0C70
	BNE.b CODE_03DF3A
	JMP.w CODE_03D62C

CODE_03DF3A:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03DF4A
	LDA.w $0CDE
	BEQ.b CODE_03DF4B
CODE_03DF4A:
	RTS

CODE_03DF4B:
	SEP.b #$10
	PHY
	LDA.w #$0174
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0175
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDX.b #FXCODE_0991DB>>16
	LDA.w #FXCODE_0991DB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	PHA
	LDA.w #$017F
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0180
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDX.b #FXCODE_0991DB>>16
	LDA.w #FXCODE_0991DB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PLA
	CLC
	ADC.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$0004
	BCS.b CODE_03DFEC
	LDA.b $10
	AND.w #$0004
	LSR
	STA.b $00
	LDA.w $0073
	STA.w $7400,x
	ASL
	ORA.b $00
	TAY
	LDA.w $0039
	CLC
	ADC.w DATA_03DF1E,y
	STA.b $00
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.b $10
	AND.w #$0003
	ASL
	TAY
	LDA.w $003B
	CLC
	ADC.w DATA_03DF26,y
	STA.b $02
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	BIT.w #$0002
	BNE.b CODE_03DFEC
	LDA.w #$00C0
	STA.w $0CDE
	LDA.w #$0174
	JSL.l CODE_03A364
	BCC.b CODE_03DFEC
	TYX
	LDA.b $00
	STA.w $70E2,x
	LDA.b $02
	STA.w $7182,x
	PHB
	LDY.b #$07
	PHY
	PLB
	JSL.l CODE_07F196
	PLB
CODE_03DFEC:
	PLY
	REP.b #$10
	RTS

;---------------------------------------------------------------------------

CODE_03DFF0:
	STZ.w $0C70
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03DFF6:
	LDA.w $0C72
	BEQ.b CODE_03DFFE
	JMP.w CODE_03D62C

CODE_03DFFE:
	INC.w $0C72
	RTS

;---------------------------------------------------------------------------

CODE_03E002:
	JSL.l CODE_008408
	LDA.w $0C72
	BNE.b CODE_03E00E
	JMP.w CODE_03D62C

CODE_03E00E:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03E01E
	LDA.w $0CE0
	BEQ.b CODE_03E01F
CODE_03E01E:
	RTS

CODE_03E01F:
	SEP.b #$10
	PHY
	LDA.w #$0175
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0176
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDX.b #FXCODE_0991DB>>16
	LDA.w #FXCODE_0991DB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	PHA
	LDA.w #$017F
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0180
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDX.b #FXCODE_0991DB>>16
	LDA.w #FXCODE_0991DB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	PLA
	CLC
	ADC.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$0004
	BCS.b CODE_03E0A9
	LDA.b $10
	AND.w #$0004
	LSR
	STA.b $00
	LDA.w $0073
	STA.w $7400,x
	ASL
	ORA.b $00
	TAY
	LDA.w $0039
	CLC
	ADC.w DATA_03DF1E,y
	STA.b $00
	LDA.b $10
	AND.w #$0003
	ASL
	TAY
	LDA.w $003B
	CLC
	ADC.w DATA_03DF26,y
	STA.b $02
	LDA.w #$00C0
	STA.w $0CE0
	LDA.w #$0175
	JSL.l CODE_03A364
	BCC.b CODE_03E0A9
	TYX
	LDA.b $00
	STA.w $70E2,x
	LDA.b $02
	STA.w $7182,x
	PHB
	LDY.b #$07
	PHY
	PLB
	JSL.l CODE_07F191
	PLB
CODE_03E0A9:
	PLY
	REP.b #$10
	RTS

;---------------------------------------------------------------------------

CODE_03E0AD:
	STZ.w $0C72
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03E0B3:
	LDA.w $0C74
	BEQ.b CODE_03E0BB
	JMP.w CODE_03D62C

CODE_03E0BB:
	INC.w $0C74
	RTS

;---------------------------------------------------------------------------

CODE_03E0BF:
	LDA.w $0C74
	BNE.b CODE_03E0C7
	JMP.w CODE_03D62C

CODE_03E0C7:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03E123
	LDA.w $0CE2
	BNE.b CODE_03E123
	LDA.w #$0060
	STA.w $0CE2
	LDA.w $0FED
	CMP.w #$000C
	BPL.b CODE_03E123
	SEP.b #$10
	PHY
	LDA.w #$0052
	JSL.l CODE_03A34C
	BCC.b CODE_03E120
	LDA.w $003B
	CLC
	ADC.w #$0110
	STA.w $7182,y
	LDA.w $60A8
	BNE.b CODE_03E108
	LDA.w $60C4
	DEC
	EOR.w #$FFFF
	INC
CODE_03E108:
	BPL.b CODE_03E10F
	LDA.w #$FFA0
	BRA.b CODE_03E112

CODE_03E10F:
	LDA.w #$0060
CODE_03E112:
	STA.b $00
	LDA.w $608C
	CLC
	ADC.b $00
	AND.w #$FFE0
	STA.w $70E2,y
CODE_03E120:
	PLY
	REP.b #$10
CODE_03E123:
	RTS

;---------------------------------------------------------------------------

CODE_03E124:
	STZ.w $0C74
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

DATA_03E12A:
	dw $0620,$06A0,$0630,$05B0

DATA_03E132:
	dw $0140,$01B0,$0230,$01B0

DATA_03E13A:
	dw $0188,$0188,$0187,$0188

CODE_03E142:
	LDA.w $0C76
	BEQ.b CODE_03E14A
	JMP.w CODE_03D62C

CODE_03E14A:
	INC.w $0C76
	PHY
	SEP.b #$10
	LDY.b #$00
CODE_03E152:
	STY.b $00
	LDA.w DATA_03E12A,y
	STA.b $02
	LDA.w DATA_03E132,y
	STA.b $04
	LDA.w DATA_03E13A,y
	JSL.l CODE_03A34C
	BCC.b CODE_03E18C
	LDA.b $02
	STA.w $70E2,y
	LDA.b $04
	STA.w $7182,y
	LDA.w $7040,y
	AND.w #$FFF3
	STA.w $7040,y
	INC.w $0FF7
	INC.w $0FF7
	TYA
	LDY.b $00
	STA.w $0FEF,y
	INY
	INY
	CPY.b #$08
	BMI.b CODE_03E152
CODE_03E18C:
	REP.b #$10
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_03E190:
	PHY
	SEP.b #$10
	LDY.w $0FF7
CODE_03E196:
	STY.b $00
	LDA.w $0FED,y
	TAY
	LDA.w $7680,y
	CLC
	ADC.w #$0100
	CMP.w #$0300
	BCS.b CODE_03E1B4
	LDA.w $7682,y
	CLC
	ADC.w #$0100
	CMP.w #$0300
	BCC.b CODE_03E1DE
CODE_03E1B4:
	LDY.b $00
	DEY
	DEY
	BNE.b CODE_03E196
	LDY.w $0FF7
CODE_03E1BD:
	STY.b $00
	LDX.w $0FED,y
	JSL.l CODE_03A31E
	LDY.b $00
	LDA.w #$0000
	STA.w $0FED,y
	DEY
	DEY
	BNE.b CODE_03E1BD
	STZ.w $0C76
	STZ.w $0FF7
	REP.b #$10
	PLY
	JMP.w CODE_03D62C

CODE_03E1DE:
	REP.b #$10
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_03E1E2:
	LDA.w $0C78
	BEQ.b CODE_03E1EA
	JMP.w CODE_03D62C

CODE_03E1EA:
	INC.w $0C78
	LDA.b $02
	ASL
	ASL
	ASL
	ASL
	STA.w $0C7A
	RTS

;---------------------------------------------------------------------------

DATA_03E1F7:
	dw $0020,$FFE0

CODE_03E1FB:
	LDA.w $0C78
	BNE.b CODE_03E203
	JMP.w CODE_03D62C

CODE_03E203:
	PHY
	SEP.b #$10
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03E216
	LDA.w $0CE4
	BEQ.b CODE_03E219
CODE_03E216:
	JMP.w CODE_03E29D

CODE_03E219:
	LDX.b #FXCODE_0991D5>>16
	LDA.w #FXCODE_0991D5
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$0008
	SEC
	SBC.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$0005
	BMI.b CODE_03E231
	LDA.w #$0005
CODE_03E231:
	STA.b $00
	LDA.w #$0132
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	INC
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDX.b #FXCODE_0991DB>>16
	LDA.w #FXCODE_0991DB
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDY.w !REGISTER_SuperFX_R6_MultiplierLo
	CPY.b $00
	BPL.b CODE_03E29D
	LDA.w #$0132
	JSL.l CODE_03A34C
	BCC.b CODE_03E29D
	PHY
	LDY.b #$00
	LDA.b $10
	AND.w #$007F
	SEC
	SBC.w #$0040
	STA.b $00
	BPL.b CODE_03E268
	INY
	INY
CODE_03E268:
	CLC
	ADC.w DATA_03E1F7,y
	CLC
	ADC.w $608C
	PLY
	STA.w $70E2,y
	LDA.w $0C7A
	CLC
	ADC.w #$0010
	STA.w $7182,y
	LDA.w #$0007
	STA.w $7402,y
	INC
	STA.w $7A98,y
	LDA.w #$0000
	STA.w $7900,y
	STA.w $7902,y
	LDA.w #$0002
	STA.w $74A2,y
	LDA.w #$0060
	STA.w $0CE4
CODE_03E29D:
	REP.b #$10
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_03E2A1:
	STZ.w $0C78
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03E2A7:
	LDA.w $7FE8
	BEQ.b CODE_03E2B2
	LDA.w #$0001
	STA.w $7FE8
CODE_03E2B2:
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03E2B5:
	LDA.w $7960
	ASL
	ASL
	ASL
	ASL
	SEC
	SBC.w #$0100
	STA.w $7E1A
	JMP.w CODE_03D639

;---------------------------------------------------------------------------

CODE_03E2C6:
	STZ.w $0C7C
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03E2CC:
	LDA.w $0C3E
	BEQ.b CODE_03E2D4
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03E2D4:
	INC.w $0C3E
	LDA.w $0039
	STA.w $0C44
	RTS

;---------------------------------------------------------------------------

DATA_03E2DE:
	dw $0120,$FFE0,$0130,$FFD0,$0140,$FFC0,$0150,$FFB0

DATA_03E2EE:
	dw $0000,$0020,$0040,$0060,$0080,$00A0,$00C0,$00E0

DATA_03E2FE:
	dw $0001,$0002,$0004,$0008,$0010,$0020,$0040,$0080

CODE_03E30E:
	LDA.w $0C3E
	BNE.b CODE_03E316
	JMP.w CODE_03D62C

CODE_03E316:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BEQ.b CODE_03E322
CODE_03E321:
	RTS

CODE_03E322:
	LDA.w $0C40
	CMP.w #$0008
	BCS.b CODE_03E321
	LDA.w $0C44
	SEC
	SBC.w $0039
	CLC
	ADC.w #$0020
	CMP.w #$0040
	BCS.b CODE_03E33F
	LDA.w $0CEA
	BNE.b CODE_03E3B0
CODE_03E33F:
	LDA.b $10
	AND.w #$0007
	ASL
	TAX
	LDA.w $003B
	AND.w #$FFE0
	CLC
	ADC.w DATA_03E2EE,x
	STA.b $02
	LSR
	LSR
	LSR
	LSR
	AND.w #$000E
	TAX
	LDA.w $0C42
	AND.w DATA_03E2FE,x
	BNE.b CODE_03E3B0
	LDA.w DATA_03E2FE,x
	STA.b $00
	JSL.l CODE_008408
	SEP.b #$10
	PHY
	LDA.w #$0129
	JSL.l CODE_03A34C
	BCC.b CODE_03E3AD
	LDA.w #$0080
	STA.w $0CEA
	LDA.b $00
	TSB.w $0C42
	INC.w $0C40
	LDA.w $0073
	STA.w $7400,y
	LDA.b $10
	AND.w #$0003
	ASL
	ASL
	ORA.w $7400,y
	TAX
	LDA.w $0039
	STA.w $0C44
	CLC
	ADC.w DATA_03E2DE,x
	STA.w $70E2,y
	LDA.b $02
	STA.w $7182,y
	LDA.b $00
	STA.w $79D8,y
CODE_03E3AD:
	PLY
	REP.b #$10
CODE_03E3B0:
	RTS

;---------------------------------------------------------------------------

CODE_03E3B1:
	STZ.w $0C7E
	JMP.w CODE_03D62C

;---------------------------------------------------------------------------

CODE_03E3B7:
	LDY.w $7900,x
	BNE.b CODE_03E3CD
	SEP.b #$20
	LDA.w $70E2,x
	AND.b #$10
	LSR
	LSR
	LSR
	INC
	STA.w $7900,x
	TAY
	REP.b #$20
CODE_03E3CD:
	DEY
	TYX
	JMP.w (DATA_03E3D2,x)

DATA_03E3D2:
	dw CODE_03E3D6
	dw CODE_03E3F7

CODE_03E3D6:
	LDX.b $12
	JSL.l CODE_03AE60
	SEP.b #$20
	LDA.b #$3C
	STA.w $7180,x
	LDA.b #$FF
	STA.w $74A2,x
	REP.b #$20
	LDA.w #$0001
	STA.w $7402,x
	LDA.w #$0040
	STA.w $7A96,x
	RTL

CODE_03E3F7:
	LDX.b $12
	LDA.w $6FA0,x
	ORA.w #$6800
	STA.w $6FA0,x
	LDA.w #$0001
	STA.w $7402,x
	RTL

;---------------------------------------------------------------------------

CODE_03E409:
	LDY.w $7900,x
	DEY
	TYX
	JMP.w (DATA_03E411,x)

DATA_03E411:
	dw CODE_03E415
	dw CODE_03E78F

CODE_03E415:
	LDX.b $12
	LDA.w $7402,x
	BNE.b CODE_03E423
	JSL.l CODE_03AA52
	JSR.w CODE_03E70C
CODE_03E423:
	JSL.l CODE_03AF23
	LDY.b $16,x
	TYX
	JMP.w (DATA_03E42D,x)

DATA_03E42D:
	dw CODE_03E43F
	dw CODE_03E479
	dw CODE_03E4F4
	dw CODE_03E53E
	dw CODE_03E571
	dw CODE_03E58B
	dw CODE_03E67B
	dw CODE_03E6AE
	dw CODE_03E6F6

CODE_03E43F:
	LDX.b $12
	LDA.w $7A96,x
	BNE.b CODE_03E478
	LDA.w $0039
	CLC
	ADC.w #$0130
	STA.w $70E2,x
	LDA.w $003B
	CLC
	ADC.w #$0040
	STA.w $7182,x
	STA.w $7A36,x
	SEP.b #$20
	LDA.b #$01
	STA.w $74A2,x
	REP.b #$20
	LDA.w #$FE00
	STA.w $7220,x
	LDA.w #$0004
	STA.w $7A98,x
	LDY.b $16,x
	INY
	INY
	STY.b $16,x
CODE_03E478:
	RTL

CODE_03E479:
	LDX.b $12
	JSL.l CODE_0CE4E9
	LDA.w $7680,x
	CMP.w #$00F4
	BMI.b CODE_03E49C
	LDA.w $7A98,x
	BNE.b CODE_03E49B
	LDA.w $7402,x
	EOR.w #$0003
	STA.w $7402,x
	LDA.w #$0004
	STA.w $7A98,x
CODE_03E49B:
	RTL

CODE_03E49C:
	LDA.w #$0006
	STA.w $7402,x
	LDA.w #$0020
	STA.w $7540,x
	LDA.w $7220,x
	BMI.b CODE_03E49B
	STZ.w $7220,x
	STZ.w $7540,x
	SEP.b #$20
	LDY.b #$13
	STY.b $17,x
	LDA.w DATA_03E4CC,y
	STA.w $7402,x
	LDA.w DATA_03E4E0,y
	STA.w $7A98,x
	INC.b $16,x
	INC.b $16,x
	REP.b #$20
	RTL

DATA_03E4CC:
	db $05,$05,$04,$03,$04,$05,$04,$03,$04,$05,$04,$03,$04,$05,$04,$03
	db $04,$05,$04,$03

DATA_03E4E0:
	db $02,$06,$02,$06,$02,$06,$02,$06,$02,$06,$02,$06,$02,$06,$02,$06
	db $02,$06,$02,$06

CODE_03E4F4:
	LDX.b $12
	JSL.l CODE_0CE4E9
	LDA.w $7A98,x
	BNE.b CODE_03E526
	LDY.b $17,x
	DEY
	BMI.b CODE_03E527
	STY.b $17,x
	SEP.b #$20
	LDA.w DATA_03E4CC,y
	STA.w $7402,x
	LDA.w DATA_03E4E0,y
	STA.w $7A98,x
	REP.b #$20
	TYA
	AND.w #$0007
	CMP.w #$0007
	BNE.b CODE_03E526
	LDA.w #$005B
	JSL.l CODE_0085D2
CODE_03E526:
	RTL

CODE_03E527:
	LDA.w #$0004
	STA.w $7402,x
	LDA.w #$0115
	STA.l $704070
	INC.w $0D0F
	LDY.b $16,x
	INY
	INY
	STY.b $16,x
	RTL

CODE_03E53E:
	LDX.b $12
	LDA.w #$0001
	STA.w $7402,x
	LDA.w #$F800
	STA.w $75E0,x
	LDA.w #$0040
	STA.w $7540,x
	LDA.w #$0800
	STA.w $75E2,x
	LDA.w #$0010
	STA.w $7542,x
	LDA.w #$FF00
	STA.w $7222,x
	LDA.w #$0009
	STA.w $004D
	LDY.b $16,x
	INY
	INY
	STY.b $16,x
	RTL

CODE_03E571:
	LDX.b $12
	LDA.w $7680,x
	CMP.w #$0080
	BMI.b CODE_03E57E
	JMP.w CODE_03E640

CODE_03E57E:
	LDA.w #$0800
	STA.w $75E0,x
	LDY.b $16,x
	INY
	INY
	STY.b $16,x
	RTL

CODE_03E58B:
	LDX.b $12
	LDA.w $7680,x
	CMP.w #$0140
	BCC.b CODE_03E5F1
	LDX.b #$1C
CODE_03E597:
	LDA.l DATA_5FF556,x
	STA.l $702F2E,x
	STA.l $7021C2,x
	DEX
	DEX
	BPL.b CODE_03E597
	LDX.b $12
	SEP.b #$20
	LDY.w $105E
	LDA.b #$FF
	STA.w $74A2,y
	REP.b #$20
	STZ.w $7402,x
	STZ.w $7400,x
	LDA.w $7042,x
	AND.w #$FFF1
	ORA.w #$000C
	STA.w $7042,x
	LDA.w $7040,x
	AND.w #$07FF
	ORA.w #$2000
	STA.w $7040,x
	LDA.w #$0100
	STA.b $76,x
	STZ.w $7220,x
	STZ.w $7222,x
	STZ.w $7540,x
	STZ.w $7542,x
	LDA.w #$0020
	STA.w $7A98,x
	LDY.b $16,x
	INY
	INY
	STY.b $16,x
	RTL

CODE_03E5F1:
	LDY.b #$00
	LDA.w $7220,x
	BMI.b CODE_03E5FA
	INY
	INY
CODE_03E5FA:
	TYA
	STA.w $7400,x
	LDA.w $7222,x
	BMI.b CODE_03E611
	LDA.w $7682,x
	CMP.w #$0060
	BCC.b CODE_03E611
	LDA.w #$F800
	STA.w $75E2,x
CODE_03E611:
	LDA.w $7220,x
	CLC
	ADC.w #$0080
	CMP.w #$0100
	BCS.b CODE_03E622
	LDA.w #$0007
	BRA.b CODE_03E63C

CODE_03E622:
	CLC
	ADC.w #$0100
	CMP.w #$0300
	BCS.b CODE_03E630
	LDA.w #$0006
	BRA.b CODE_03E63C

CODE_03E630:
	CLC
	ADC.w #$0100
	CMP.w #$0500
	BCS.b CODE_03E640
	LDA.w #$0003
CODE_03E63C:
	STA.w $7402,x
	RTL

CODE_03E640:
	LDA.b $14
	LSR
	LSR
	AND.w #$0001
	INC
	STA.w $7402,x
	LDA.w $7400,x
	BEQ.b CODE_03E67A
	LDY.w $105E
	LDA.w $70E2,x
	CMP.w $70E2,y
	BCC.b CODE_03E67A
	LDA.w #$002F
	STA.w $7402,y
	LDA.w #$0000
	STA.w $7542,y
	STA.w $7222,y
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	CLC
	ADC.w #$0010
	STA.w $7182,y
CODE_03E67A:
	RTL

CODE_03E67B:
	LDX.b $12
	LDA.w $7A98,x
	BNE.b CODE_03E6AD
	LDA.b $76,x
	ASL
	ASL
	EOR.w #$FFFF
	INC
	STA.w $7220,x
	LDA.w #$FFF0
	STA.w $7222,x
	LDA.w $0039
	CLC
	ADC.w #$0110
	STA.w $70E2,x
	LDA.w $003B
	CLC
	ADC.w #$0038
	STA.w $7182,x
	LDY.b $16,x
	INY
	INY
	STY.b $16,x
CODE_03E6AD:
	RTL

CODE_03E6AE:
	LDX.b $12
	LDA.w $7680,x
	CMP.w #$00E0
	BPL.b CODE_03E6E5
	LDA.b $76,x
	SEC
	SBC.w #$0003
	BMI.b CODE_03E6D0
	STA.b $76,x
	ASL
	ASL
	EOR.w #$FFFF
	INC
	STA.w $7220,x
	JSR.w CODE_03E762
	BRA.b CODE_03E6E5

CODE_03E6D0:
	LDA.w $7680,x
	CMP.w #$0020
	BPL.b CODE_03E6E5
	STZ.w $7220,x
	STZ.w $7222,x
	LDY.b $16,x
	INY
	INY
	STY.b $16,x
	RTL

CODE_03E6E5:
	LDA.w $7220,x
	BEQ.b CODE_03E6EF
	CMP.w #$FFF0
	BCC.b CODE_03E6F5
CODE_03E6EF:
	LDA.w #$FFF0
	STA.w $7220,x
CODE_03E6F5:
	RTL

CODE_03E6F6:
	LDX.b $12
	LDY.w $105E
	LDA.w $79D6,y
	INC
	STA.w $79D6,y
	LDA.w #$0040
	STA.w $7A96,y
	JML.l CODE_03A31E

CODE_03E70C:
	LDY.w $74A2,x
	CMP.w #$00FF
	BEQ.b CODE_03E761
	LDA.w $0D0F
	BNE.b CODE_03E761
	LDA.w $7722,x
	BMI.b CODE_03E761
	REP.b #$10
	LDA.w #$0000
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.b $76,x
	CMP.w #$0018
	BPL.b CODE_03E730
	LDA.w #$0018
CODE_03E730:
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$A080
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	SEP.b #$10
	LDX.b #FXCODE_088205>>16
	LDA.w #FXCODE_088205
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
CODE_03E761:
	RTS

CODE_03E762:
	LDA.w #$5574
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDA.w #$0000
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0100
	SEC
	SBC.b $76,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$00E1
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$000F
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08E167>>16
	LDA.w #FXCODE_08E167
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	RTS

CODE_03E78F:
	LDX.b $12
	JSL.l CODE_03AF23
	LDY.b $16,x
	TYX
	JMP.w (DATA_03E79B,x)

DATA_03E79B:
	dw CODE_03E7A7
	dw CODE_03E7F8
	dw CODE_03E827
	dw CODE_03E88E

DATA_03E7A3:
	dw $0120,$FFD0

CODE_03E7A7:
	LDX.b $12
	LDA.w $7A96,x
	BNE.b CODE_03E7F7
	STZ.w $7400,x
	LDA.w $0039
	CLC
	ADC.w DATA_03E7A3
	STA.w $70E2,x
	LDA.w $003B
	CLC
	ADC.w #$0030
	STA.w $7182,x
	LDA.w #$FE00
	STA.w $7220,x
	LDA.w $021A
	CMP.w #$0038
	BEQ.b CODE_03E7DE
	LDA.w $7042,x
	EOR.w #$0020
	STA.w $7042,x
	BRA.b CODE_03E7E7

CODE_03E7DE:
	LDA.w $7042,x
	EOR.w #$0020
	STA.w $7042,x
CODE_03E7E7:
	SEP.b #$20
	STZ.w $74A2,x
	LDA.b #$40
	STA.w $70E0,x
	INC.b $16,x
	INC.b $16,x
	REP.b #$20
CODE_03E7F7:
	RTL

CODE_03E7F8:
	LDX.b $12
	LDA.b $14
	LSR
	LSR
	AND.w #$0001
	CLC
	ADC.w #$0008
	STA.w $7402,x
	LDA.w $7680,x
	CMP.w #$FFD0
	BPL.b CODE_03E826
	STZ.w $7220,x
	LDA.w #$003C
	STA.w $7A96,x
	SEP.b #$20
	LDA.b #$FF
	STA.w $74A2,x
	INC.b $16,x
	INC.b $16,x
	REP.b #$20
CODE_03E826:
	RTL

CODE_03E827:
	LDX.b $12
	LDA.w $7A96,x
	BNE.b CODE_03E881
	LDA.w #$0002
	STA.w $7400,x
	LDA.w $0039
	CLC
	ADC.w DATA_03E7A3+$02
	STA.w $70E2,x
	LDA.w $6090
	CLC
	ADC.w #$0010
	STA.w $7182,x
	LDA.w #$0480
	STA.w $7220,x
	LDA.w $021A
	CMP.w #$0038
	BEQ.b CODE_03E861
	LDA.w $7042,x
	EOR.w #$0020
	STA.w $7042,x
	BRA.b CODE_03E86A

CODE_03E861:
	LDA.w $7042,x
	EOR.w #$0020
	STA.w $7042,x
CODE_03E86A:
	SEP.b #$20
	LDA.b #$02
	STA.w $74A2,x
	STZ.w $70E0,x
	INC.b $16,x
	INC.b $16,x
	REP.b #$20
	LDA.w #$009A
	JML.l CODE_0085D2

CODE_03E881:
	CMP.w #$0020
	BNE.b CODE_03E88D
	LDA.w #$005B
	JML.l CODE_0085D2

CODE_03E88D:
	RTL

CODE_03E88E:
	LDX.b $12
	JSL.l CODE_03A5B7
	LDA.b $14
	LSR
	LSR
	AND.w #$0001
	INC
	STA.w $7402,x
	LDA.w $7680,x
	CMP.w #$0120
	BMI.b CODE_03E8BB
	LDA.w #$003C
	STA.w $7A96,x
	STZ.w $7220,x
	SEP.b #$20
	LDA.b #$FF
	STA.w $74A2,x
	STZ.b $16,x
	REP.b #$20
CODE_03E8BB:
	RTL

;---------------------------------------------------------------------------

DATA_03E8BC:
	dw CODE_03E954
	dw CODE_03E993
	dw CODE_03E9A2
	dw CODE_03EA62
	dw CODE_03EB50
	dw CODE_03E9CC
	dw CODE_03E9E4
	dw CODE_03E9F5

DATA_03E8CC:
	dw $0000,$0002

CODE_03E8D0:
	JSL.l CODE_03D3F8
	BEQ.b CODE_03E8DA
	JML.l CODE_03A31E

CODE_03E8DA:
	LDA.w $70E2,x
	STA.w $7A36,x
	LDA.w $7182,x
	STA.w $7A38,x
	JSL.l CODE_03AE60
	LDY.w $7900,x
	BNE.b CODE_03E90A
	SEP.b #$20
	LDA.b #$20
	STA.w $7901,x
	LDA.b #$02
	STA.w $7902,x
	LDA.w $70E2,x
	AND.b #$10
	LSR
	LSR
	LSR
	INC
	STA.w $7900,x
	TAY
	REP.b #$20
CODE_03E90A:
	DEY
	BEQ.b CODE_03E915
	LDY.b #$0A
	STY.b $18,x
	LDY.w $7900,x
	DEY
CODE_03E915:
	LDA.w $7042,x
	ORA.w DATA_03E8CC,y
	STA.w $7042,x
	JSR.w CODE_03EC0B
	RTL

;---------------------------------------------------------------------------

CODE_03E922:
	LDX.b $12
	RTS

;---------------------------------------------------------------------------

CODE_03E925:
	JSL.l CODE_03AA52
	JSR.w CODE_03EC0B
	LDA.w $6F00,x
	CMP.w #$0008
	BNE.b CODE_03E940
	LDA.w $7A36,x
	STA.b $04
	LDA.w $7A38,x
	JSL.l CODE_03D3F3
CODE_03E940:
	JSL.l CODE_03AF23
	LDY.b $18,x
	CMP.w #$0008
	BEQ.b CODE_03E94E
	JSR.w CODE_03EB95
CODE_03E94E:
	LDY.b $18,x
	TYX
	JMP.w (DATA_03E8BC,x)

CODE_03E954:
	LDX.b $12
	JSR.w CODE_03EC91
	LDA.w $7860,x
	AND.w #$0001
	BNE.b CODE_03E98E
	LDA.w $70E2,x
	SEC
	SBC.w $608C
	CLC
	ADC.w #$0060
	CMP.w #$00C0
	BCS.b CODE_03E98D
	LDA.w $7182,x
	SEC
	SBC.w $6090
	CLC
	ADC.w #$0060
	CMP.w #$00C0
	BCS.b CODE_03E98D
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
CODE_03E98D:
	RTL

CODE_03E98E:
	LDY.b #$02
	STY.b $18,x
	RTL

CODE_03E993:
	LDX.b $12
	JSR.w CODE_03EC91
	JSR.w CODE_03EA3B
	BCS.b CODE_03E9A1
	LDY.b #$04
	STY.b $18,x
CODE_03E9A1:
	RTL

CODE_03E9A2:
	LDX.b $12
	SEP.b #$20
	LDA.w $7901,x
	CLC
	ADC.b #$02
	BCS.b CODE_03E9B4
	STA.w $7901,x
	REP.b #$20
	RTL

CODE_03E9B4:
	LDA.b #$FF
	STA.w $7901,x
	LDA.b #$06
	STA.b $18,x
	LDA.b #$08
	STA.w $7A96,x
	REP.b #$20
	LDA.w #$0050
	JSL.l CODE_0085D2
	RTL

CODE_03E9CC:
	LDX.b $12
	JSR.w CODE_03EC91
	JSR.w CODE_03EA3B
	BCS.b CODE_03E9E3
	LDA.w #$0010
	STA.w $7540,x
	STA.w $7542,x
	LDY.b #$0C
	STY.b $18,x
CODE_03E9E3:
	RTL

CODE_03E9E4:
	LDX.b $12
	JSR.w CODE_03EC91
	LDY.w $7901,x
	CPY.b #$80
	BNE.b CODE_03E9F4
	LDY.b #$0E
	STY.b $18,x
CODE_03E9F4:
	RTL

CODE_03E9F5:
	LDX.b $12
	JSR.w CODE_03E9FD
	JMP.w CODE_03E9A2

CODE_03E9FD:
	LDA.w $611C
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $611E
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7CD6,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7CD8,x
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0080
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_09907C>>16
	LDA.w #FXCODE_09907C
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	EOR.w #$FFFF
	INC
	STA.w $75E0,x
	LDA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	EOR.w #$FFFF
	INC
	STA.w $75E2,x
	RTS

CODE_03EA3B:
	LDA.w $70E2,x
	SEC
	SBC.w $608C
	CLC
	ADC.w #$0060
	CMP.w #$00C0
	BCS.b CODE_03EA59
	LDA.w $7182,x
	SEC
	SBC.w $6090
	CLC
	ADC.w #$0060
	CMP.w #$00C0
CODE_03EA59:
	RTS

;---------------------------------------------------------------------------

DATA_03EA5A:
	dw $0000,$0002,$0004,$0008

CODE_03EA62:
	LDX.b $12
	LDA.w $7A96,x
	BEQ.b CODE_03EA89
	BIT.w #$000F
	BNE.b CODE_03EA77
	PHA
	LDA.w #$0050
	JSL.l CODE_0085D2
	PLA
CODE_03EA77:
	AND.w #$000C
	LSR
	TAY
	LDA.w $7042,x
	AND.w #$FFF1
	ORA.w DATA_03EA5A,y
	STA.w $7042,x
	RTL

CODE_03EA89:
	LDA.w #$01EE
	JSL.l CODE_008B21
	LDA.w $7CD6,x
	STA.w $70A2,y
	LDA.w $7CD8,x
	STA.w $7142,y
	LDA.w #$0002
	STA.w $7782,y
	LDA.w #$0008
	STA.w $73C2,y
	LDA.w #$003B
	JSL.l CODE_0085D2
	SEP.b #$20
	LDA.b #$FF
	STA.w $74A0,x
	REP.b #$20
	LDA.w $7CD6,x
	SEC
	SBC.w $611C
	CLC
	ADC.w #$0028
	CMP.w #$0050
	BCS.b CODE_03EADC
	LDA.w $7CD8,x
	SEC
	SBC.w $611E
	CLC
	ADC.w #$0028
	CMP.w #$0050
	BCS.b CODE_03EADC
	JSL.l CODE_03A858
CODE_03EADC:
	LDA.w $7A36,x
	STA.b $04
	LDA.w $7A38,x
	JSL.l CODE_03D3F3
	JSL.l CODE_03A31E
	LDY.w $7900,x
	DEY
	LDA.w DATA_03E8CC,y
	INC
	STA.b $00
	LDA.w #$008D
	JSL.l CODE_03A364
	BCC.b CODE_03EB4B
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
	LDA.w #$FC00
	STA.w $75E2,y
	LDA.w #$0040
	STA.w $7542,y
	LDA.w #$0000
	STA.w $7220,y
	STA.w $79D6,y
	LDA.w $7040,y
	AND.w #$07FF
	ORA.w #$2800
	STA.w $7040,y
	LDA.b $00
	STA.w $7902,y
	DEC
	ORA.w $7042,y
	STA.w $7042,y
	SEP.b #$20
	LDA.b #$05
	STA.w $74A2,y
	LDA.b #$02
	STA.w $7900,y
	LDA.b #$02
	STA.w $7AF8,y
	REP.b #$20
CODE_03EB4B:
	RTL

;---------------------------------------------------------------------------

DATA_03EB4C:
	dw $0800,$F800

CODE_03EB50:
	LDX.b $12
	LDA.w $7220,x
	EOR.b $76,x
	BMI.b CODE_03EB6B
	LDY.w $7D36,x
	BMI.b CODE_03EB8A
	DEY
	BMI.b CODE_03EB6E
	BEQ.b CODE_03EB6E
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_03EB6E
CODE_03EB6B:
	JMP.w CODE_03EA89

CODE_03EB6E:
	SEP.b #$20
	LDA.b #$00
	LDY.w $7221,x
	BMI.b CODE_03EB79
	INC
	INC
CODE_03EB79:
	EOR.w $7400,x
	TAY
	REP.b #$20
	LDA.w $7976,x
	CLC
	ADC.w DATA_03EB4C,y
	STA.w $7976,x
	RTL

CODE_03EB8A:
	JSL.l CODE_03A858
	JMP.w CODE_03EA89

;---------------------------------------------------------------------------

DATA_03EB91:
	dw $FE00,$0200

CODE_03EB95:
	LDY.w $7D36,x
	BPL.b CODE_03EB9B
	RTS

CODE_03EB9B:
	DEY
	BMI.b CODE_03EBE6
	BEQ.b CODE_03EBE6
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_03EBE6
	LDA.w $7D38,y
	BEQ.b CODE_03EBE6
	LDA.w $70E2,y
	STA.b $00
	TYX
	JSL.l CODE_03B24B
	LDX.b $12
	LDA.w #$0067
	JSL.l CODE_0085D2
	LDY.b #$00
	LDA.w $70E2,x
	SEC
	SBC.b $00
	BMI.b CODE_03EBCC
	INY
	INY
CODE_03EBCC:
	LDA.w DATA_03EB91,y
	STA.w $7220,x
	STA.b $76,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
	LDY.b #$08
	STY.b $18,x
	PLA
	RTL

CODE_03EBE6:
	RTS

;---------------------------------------------------------------------------

DATA_03EBE7:
	db $0F,$00,$0F,$00,$0E,$00,$0D,$00,$0C,$00,$0B,$00,$0A,$00,$09,$00
	db $08,$00,$07,$00,$06,$00,$05,$00,$04,$00,$03,$00,$02,$00,$01,$00
	db $00,$00,$00,$00

CODE_03EC0B:
	LDY.w $74A2,x
	BPL.b CODE_03EC11
	RTS

CODE_03EC11:
	LDY.w $7901,x
	TYA
	INC
	LSR
	LSR
	LSR
	AND.w #$00FE
	TAY
	LDA.w DATA_03EBE7,y
	STA.b $00
	REP.b #$10
	LDY.w $7362,x
	LDA.w $6002,y
	CLC
	ADC.b $00
	STA.w $6002,y
	LDA.w $600A,y
	CLC
	ADC.b $00
	STA.w $600A,y
	LDA.w $6012,y
	CLC
	ADC.b $00
	STA.w $6012,y
	LDA.w $601A,y
	CLC
	ADC.b $00
	STA.w $601A,y
	SEP.b #$10
	LDA.w $0D0F
	BNE.b CODE_03EC90
	LDY.b $17,x
	TYA
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDY.w $7901,x
	TYA
	INC
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	REP.b #$10
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$C041
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	SEP.b #$10
	LDX.b #FXCODE_088205>>16
	LDA.w #FXCODE_088205
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
CODE_03EC90:
	RTS

;---------------------------------------------------------------------------

CODE_03EC91:
	SEP.b #$20
	LDA.w $7901,x
	CMP.b #$80
	BCC.b CODE_03ECA1
	LDA.b #$80
	STA.w $7901,x
	BRA.b CODE_03ECA8

CODE_03ECA1:
	CLC
	ADC.w $7902,x
	STA.w $7901,x
CODE_03ECA8:
	REP.b #$20
	RTS

;---------------------------------------------------------------------------

DATA_03ECAB:
	dw $3000,$3000,$4800,$4800

DATA_03ECB3:
	dw CODE_03EF92
	dw CODE_03EF11
	dw CODE_03EF0A
	dw CODE_03EF0A

DATA_03ECBB:
	dw $0003,$000C,$0003,$0003

DATA_03ECC3:
	dw DATA_03F258,DATA_03F87B,DATA_03F1A4,DATA_03F1A4

CODE_03ECCB:
	JSL.l CODE_03D3F8
	BEQ.b CODE_03ECD5
	JML.l CODE_03A31E

CODE_03ECD5:
	LDY.w $7901,x
	BNE.b CODE_03ECF6
	SEP.b #$20
	LDA.w $70E2,x
	AND.b #$10
	LSR
	LSR
	LSR
	STA.b $00
	LDA.w $7182,x
	AND.b #$10
	LSR
	LSR
	ORA.b $00
	INC
	STA.w $7901,x
	TAY
	REP.b #$20
CODE_03ECF6:
	DEY
	LDA.w $7040,x
	ORA.w DATA_03ECAB,y
	STA.w $7040,x
	LDA.w #$001E
	STA.w $7A96,x
	LDA.w $70E2,x
	STA.w $7A36,x
	LDA.w $7182,x
	STA.w $7A38,x
	LDA.w #$0003
	STA.w $7902,x
	DEC
	ORA.w $7042,x
	STA.w $7042,x
	RTL

CODE_03ED20:
	LDY.w $7900,x
	TYX
	JMP.w (DATA_03ED27,x)

DATA_03ED27:
	dw CODE_03ED2B
	dw CODE_03F0D1

CODE_03ED2B:
	LDX.b $12
	JSR.w CODE_03F183
	JSR.w CODE_03EECA
	JSL.l CODE_03AF23
	JSL.l CODE_03A5B7
	JSR.w CODE_03F07F
	LDA.b $14
	AND.w #$0003
	STA.w $7402,x
	LDY.b $18,x
	TYX
	JMP.w (DATA_03ED4C,x)

DATA_03ED4C:
	dw CODE_03ED5A
	dw CODE_03ED95
	dw CODE_03EE0B
	dw CODE_03EE56
	dw CODE_03EEB3

DATA_03ED56:
	dw $0120,$FFD0

CODE_03ED5A:
	LDX.b $12
	LDA.w $7A96,x
	BNE.b CODE_03ED94
	SEP.b #$20
	INC.b $18,x
	INC.b $18,x
	LDA.b #$05
	STA.w $74A2,x
	REP.b #$20
	LDA.w $0073
	STA.w $7400,x
	TAY
	LDA.w $0039
	CLC
	ADC.w DATA_03ED56,y
	STA.w $70E2,x
	LDA.w $003B
	CLC
	ADC.w #$FFC0
	STA.w $7182,x
	LDA.w #$0020
	STA.w $7540,x
	STA.w $7542,x
	BRA.b CODE_03EDAB

CODE_03ED94:
	RTL

CODE_03ED95:
	LDX.b $12
	LDY.b #$00
	LDA.w $7220,x
	BMI.b CODE_03EDA0
	INY
	INY
CODE_03EDA0:
	TYA
	CMP.w $7400,x
	BEQ.b CODE_03EDAB
	LDA.w $7222,x
	BMI.b CODE_03EDE1
CODE_03EDAB:
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7A38,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $70E2,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7182,x
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0200
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_09907C>>16
	LDA.w #FXCODE_09907C
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w $75E0,x
	LDA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	STA.w $75E2,x
	RTL

CODE_03EDE1:
	STZ.w $7540,x
	STZ.w $7542,x
	STZ.w $7220,x
	STZ.w $7222,x
	LDA.w $7182,x
	STA.b $78,x
	LDA.w #$0078
	STA.w $7A96,x
	LDA.w $7A36,x
	STA.b $04
	LDA.w $7A38,x
	JSL.l CODE_03D3F3
	LDY.b $18,x
	INY
	INY
	STY.b $18,x
	RTL

CODE_03EE0B:
	LDX.b $12
	LDA.w $7A96,x
	BEQ.b CODE_03EE45
	TXY
	REP.b #$10
	LDX.b $76,y
	LDA.l DATA_00E9D4,x
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	CLC
	ADC.w $79D8,y
	STA.w $7182,y
	TXA
	CLC
	ADC.w #$0002
	AND.w #$01FE
	STA.w $79D6,y
	SEP.b #$10
	TYX
	RTL

CODE_03EE45:
	LDA.w #$0000
	STA.b $76,x
	LDY.w $7400,x
	STY.b $19,x
	LDY.b $18,x
	INY
	INY
	STY.b $18,x
	RTL

CODE_03EE56:
	LDX.b $12
	LDA.w $79D6,x
	CMP.w #$0250
	BCS.b CODE_03EEA2
	TXY
	REP.b #$10
	AND.w #$01FE
	TAX
	LDA.l DATA_00E9D4,x
	ASL
	STA.w $7222,y
	LDA.l DATA_00E954,x
	ASL
	PHA
	LDA.w $7979,y
	AND.w #$00FF
	BNE.b CODE_03EE83
	PLA
	EOR.w #$FFFF
	INC
	PHA
CODE_03EE83:
	PLA
	STA.w $7220,y
	LDA.w $79D6,y
	CLC
	ADC.w #$0008
	STA.w $79D6,y
	SEP.b #$10
	LDX.b #$00
	LDA.w $7220,y
	BMI.b CODE_03EE9C
	INX
	INX
CODE_03EE9C:
	TXA
	STA.w $7400,y
	TYX
	RTL

CODE_03EEA2:
	LDA.w #$0010
	STA.w $7A96,x
	LDY.b #$00
	STY.b $19,x
	LDY.b $18,x
	INY
	INY
	STY.b $18,x
	RTL

CODE_03EEB3:
	LDX.b $12
	LDA.w $7A96,x
	BNE.b CODE_03EEC9
	LDY.b $19,x
	BNE.b CODE_03EEC9
	LDA.w #$006E
	JSL.l CODE_0085D2
	LDY.b #$01
	STY.b $19,x
CODE_03EEC9:
	RTL

CODE_03EECA:
	LDA.w $6F00,x
	CMP.w #$0008
	BNE.b CODE_03EEE8
	JSR.w CODE_03EEF6
	LDA.w #$001E
	TXY
	JSL.l CODE_03A377
	LDA.w $7902,x
	DEC
	ORA.w $7042,x
	STA.w $7042,x
	RTS

CODE_03EEE8:
	CMP.w #$0010
	BEQ.b CODE_03EEF5
	CMP.w #$000E
	BEQ.b CODE_03EEF5
	JSR.w CODE_03EEF6
CODE_03EEF5:
	RTS

CODE_03EEF6:
	LDA.w $7A36,x
	STA.b $04
	LDA.w $7A38,x
	JSL.l CODE_03D3F3
	LDY.w $7901,x
	DEY
	TYX
	JMP.w (DATA_03ECB3,x)

CODE_03EF0A:
	LDX.b $12
	JSL.l CODE_03A496
	RTS

CODE_03EF11:
	LDX.b $12
	LDA.w $7A38,x
	ASL
	ASL
	ASL
	ASL
	AND.w #$FF00
	ORA.w #$8000
	STA.b $00
	LDA.w $7A36,x
	LSR
	LSR
	LSR
	LSR
	AND.w #$00FF
	ORA.b $00
	STA.b $0E
	LDA.w #$0009
	JSL.l CODE_0085D2
	LDA.w #$0115
	JSL.l CODE_03A34C
	BCC.b CODE_03EF62
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	CLC
	ADC.w #$0010
	STA.w $7182,y
	LDA.w $7042,x
	AND.w #$FFF1
	ORA.w #$0002
	STA.w $7042,y
	LDA.b $0E
	STA.w $7902,y
	RTS

CODE_03EF62:
	JSL.l CODE_0CFF61
	LDA.w #$0115
	TXY
	JSL.l CODE_03A377
	LDA.w $7182,x
	CLC
	ADC.w #$0010
	STA.w $7182,x
	LDA.w $7042,x
	AND.w #$FFF1
	ORA.w #$0002
	STA.w $7042,x
	LDA.b $0E
	STA.w $7902,x
	LDA.w #$0002
	STA.w $6F00,x
	PLA
	PLA
	RTL

CODE_03EF92:
	LDX.b $12
	LDA.w #$0030
	JSL.l CODE_0085D2
	LDA.w $03B6
	BEQ.b CODE_03EFB3
	STA.w !REGISTER_DividendLo
	LDY.b #$0A
	STY.w !REGISTER_Divisor
	NOP #8
	LDA.w !REGISTER_QuotientLo
CODE_03EFB3:
	STA.b $00
	LDA.w #$001D
	SEC
	SBC.b $00
	STA.b $00
	LDA.w #$0004
	STA.b $02
CODE_03EFC2:
	LDA.b $00
	BPL.b CODE_03EFDA
	LDA.w #$0100
	STA.b $04
	LDA.w #$0140
	STA.b $06
	LDA.w #$0010
	STA.b $08
	LDA.w #$0115
	BRA.b CODE_03EFE6

CODE_03EFDA:
	LDA.w #$0180
	STA.b $04
	STZ.b $06
	STZ.b $08
	LDA.w #$01A2
CODE_03EFE6:
	STA.b $0A
	JSL.l CODE_03A364
	BCC.b CODE_03F038
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	CLC
	ADC.w #$0010
	STA.w $7182,y
	JSL.l CODE_008408
	LDA.b $10
	AND.w #$000E
	TAX
	LDA.l DATA_03C74C,x
	STA.w $7220,y
	LDA.b $10
	LSR
	LSR
	LSR
	LSR
	AND.w #$000E
	TAX
	LDA.l DATA_03C75C,x
	STA.w $7222,y
	LDX.b $12
	LDA.b $04
	STA.w $7A96,y
	LDA.b $06
	STA.w $7A98,y
	LDA.b $08
	STA.w $7AF6,y
	DEC.b $00
	DEC.b $02
	BPL.b CODE_03EFC2
	RTS

CODE_03F038:
	JSL.l CODE_0CFF61
	LDA.b $0A
	TXY
	JSL.l CODE_03A377
	LDA.w $7182,x
	CLC
	ADC.w #$0010
	STA.w $7182,y
	LDA.b $10
	AND.w #$000E
	TAX
	LDA.l DATA_03C74C,x
	STA.w $7220,y
	LDA.b $10
	LSR
	LSR
	LSR
	LSR
	AND.w #$000E
	TAX
	LDA.l DATA_03C75C,x
	STA.w $7222,y
	LDX.b $12
	LDA.b $04
	STA.w $7A96,y
	LDA.b $06
	STA.w $7A98,y
	LDA.b $08
	STA.w $7AF6,y
	PLA
	PLA
	RTL

CODE_03F07F:
	LDY.w $7D36,x
	DEY
	BMI.b CODE_03F0D0
	BEQ.b CODE_03F0D0
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_03F0D0
	LDA.w $7D38,y
	BEQ.b CODE_03F0D0
	TYX
	JSL.l CODE_03B24B
	LDX.b $12
	JSR.w CODE_03EEF6
	SEP.b #$20
	LDA.b #$FF
	STA.w $74A0,x
	LDA.b #$02
	STA.w $7900,x
	LDA.b #$02
	STA.w $7AF8,x
	REP.b #$20
	LDA.w #$FE00
	STA.w $75E2,x
	LDA.w #$0040
	STA.w $7542,x
	STZ.w $7220,x
	STZ.b $76,x
	LDA.w $7040,x
	AND.w #$07FF
	ORA.w #$2800
	STA.w $7040,x
	PLA
	RTL

CODE_03F0D0:
	RTS

CODE_03F0D1:
	LDX.b $12
	LDY.w $74A2,x
	BMI.b CODE_03F0EF
	LDA.w #$000C
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$F8F3
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_09AEC1>>16
	LDA.w #FXCODE_09AEC1
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_03F0EF:
	JSR.w CODE_03F142
	JSL.l CODE_03AF23
	LDA.w $7AF8,x
	CMP.w #$0001
	BNE.b CODE_03F105
	LDA.w #$006E
	JSL.l CODE_0085D2
CODE_03F105:
	JSL.l CODE_03A5B7
	JSR.w CODE_03F15D
	LDA.b $14
	AND.w #$0003
	STA.w $7402,x
	TXY
	REP.b #$10
	LDX.b $76,y
	LDA.l DATA_00E954,x
	CMP.w #$8000
	ROR
	STA.w $7220,y
	LDA.w $79D6,y
	CLC
	ADC.w #$0002
	AND.w #$01FE
	STA.w $79D6,y
	SEP.b #$10
	TYX
	LDY.b #$00
	LDA.w $7220,x
	BMI.b CODE_03F13D
	INY
	INY
CODE_03F13D:
	TYA
	STA.w $7400,x
	RTL

CODE_03F142:
	LDA.w $6F00,x
	CMP.w #$0008
	BNE.b CODE_03F15C
	LDA.w #$001E
	TXY
	JSL.l CODE_03A377
	LDA.w $7902,x
	DEC
	ORA.w $7042,x
	STA.w $7042,x
CODE_03F15C:
	RTS

CODE_03F15D:
	LDY.w $7D36,x
	DEY
	BMI.b CODE_03F182
	BEQ.b CODE_03F182
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_03F182
	LDA.w $7D38,y
	BEQ.b CODE_03F182
	TYX
	JSL.l CODE_03B24B
	LDX.b $12
	JSL.l CODE_0CFF61
	PLA
	JML.l CODE_03A32E

CODE_03F182:
	RTS

CODE_03F183:
	LDY.w $74A2,x
	BMI.b CODE_03F1A3
	LDY.w $7901,x
	DEY
	LDA.w DATA_03ECBB,y
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w DATA_03ECC3,y
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_09AEC1>>16
	LDA.w #FXCODE_09AEC1
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_03F1A3:
	RTS

DATA_03F1A4:
	dw $0002,$8800,$0000,$0E01,$402F,$0600,$2F0E,$0040
	dw $FA08,$402C,$0000,$2CFA,$0000,$16FE,$0249,$0800
	dw $6F16,$0002,$1600,$026E,$0002,$E311,$0206,$0000
	dw $0088,$0100,$2F0E,$0040,$0E06,$402F,$0800,$2DFA
	dw $0040,$FA00,$002D,$FE00,$4916,$0002,$1608,$026F
	dw $0000,$6E16,$0202,$1100,$06E3,$0002,$8800,$0000
	dw $0E01,$402F,$0600,$2F0E,$0040,$FA08,$403C,$0000
	dw $3CFA,$0000,$16FE,$0249,$0800,$6F16,$0002,$1600
	dw $026E,$0002,$E311,$0206,$0000,$0088,$0100,$2F0E
	dw $0040,$0E06,$402F,$0800,$3DFA,$0040,$FA00,$003D
	dw $FE00,$4916,$0002,$1608,$026F,$0000,$6E16,$0202
	dw $1100,$06E3

DATA_03F258:
	dw $0002,$8800,$0000,$0E01,$402F,$0600,$2F0E,$0040
	dw $FA08,$402C,$0000,$2CFA,$0200,$1000,$00EA,$0002
	dw $8800,$0000,$0E01,$402F,$0600,$2F0E,$0040,$FA08
	dw $402D,$0000,$2DFA,$0200,$1000,$00EA,$0002,$8800
	dw $0000,$0E01,$402F,$0600,$2F0E,$0040,$FA08,$403C
	dw $0000,$3CFA,$0200,$1000,$00EA,$0002,$8800,$0000
	dw $0E01,$402F,$0600,$2F0E,$0040,$FA08,$403D,$0000
	dw $3DFA,$0200,$1000,$00EA

;---------------------------------------------------------------------------

DATA_03F2D0:
	db $08,$06,$07,$08,$09,$0C,$0A,$09,$09,$0A,$08,$08,$0B,$0D

DATA_03F2DE:
	dw $FFE8,$FFE6,$FFE7,$FFE8,$FFE9,$FFEC,$FFEA,$FFE9
	dw $FFE9,$FFEA,$FFE8,$FFE8,$FFEB,$FFED

DATA_03F2FA:
	dw $FF80,$0080

CODE_03F2FE:
	LDA.w #$0007
	STA.b $18,x
	SEP.b #$20
	TAY
	LDA.w DATA_03F396,y
	STA.w $7A96,x
	LDA.w DATA_03F38E,y
	STA.w $7402,x
	TAY
	LDA.w DATA_03F2D0,y
	STA.w $7B58,x
	REP.b #$20
	LDA.w #$0004
	STA.w $7BB8,x
	LDA.w #$0004
	STA.w $7BB6,x
	LDY.w $7400,x
	LDA.w DATA_03F2FA,y
	STA.w $7220,x
	RTL

;---------------------------------------------------------------------------

CODE_03F331:
	JSL.l CODE_03AF23
	LDA.b $16,x
	TAX
	JSR.w (DATA_03F388,x)
	LDA.b $76,x
	STA.w $7902,x
	STZ.b $76,x
	JSL.l CODE_03A5B7
	LDY.w $7D36,x
	BPL.b CODE_03F35E
	LDA.w $60C0
	BNE.b CODE_03F35D
	LDA.w $60AA
	BMI.b CODE_03F35D
	LDA.w $7902,x
	BNE.b CODE_03F35B
	INC
CODE_03F35B:
	STA.b $76,x
CODE_03F35D:
	RTL

CODE_03F35E:
	DEY
	BMI.b CODE_03F35D
	BEQ.b CODE_03F35D
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_03F35D
	LDA.w $7D38,y
	BEQ.b CODE_03F35D
	LDA.w $7542,y
	CMP.w #$0040
	BCS.b CODE_03F380
	JSL.l CODE_0CFF61
	JML.l CODE_03B24B

CODE_03F380:
	PHX
	TYX
	JSL.l CODE_03B24B
	PLX
	RTL

DATA_03F388:
	dw CODE_03F39E
	dw CODE_03F422
	dw CODE_03F4A9

DATA_03F38E:
	db $07,$06,$05,$04,$03,$02,$01,$00

DATA_03F396:
	db $04,$04,$03,$02,$02,$03,$04,$04

CODE_03F39E:
	LDX.b $12
	JSR.w CODE_03F531
	LDA.b $10
	AND.w #$003F
	BEQ.b CODE_03F3E3
	LDA.w $7A96,x
	BNE.b CODE_03F3E2
	DEC.b $18,x
	BPL.b CODE_03F3B8
	LDA.w #$0007
	STA.b $18,x
CODE_03F3B8:
	SEP.b #$20
	LDY.b $18,x
	LDA.w DATA_03F396,y
	STA.w $7A96,x
	LDA.w DATA_03F38E,y
	STA.w $7402,x
	TAY
	LDA.w DATA_03F2D0,y
	STA.w $7B58,x
	REP.b #$20
	LDA.b $76,x
	BEQ.b CODE_03F3E2
	TYA
	ASL
	TAY
	LDA.w $7182,x
	CLC
	ADC.w DATA_03F2DE,y
	STA.w $6090
CODE_03F3E2:
	RTS

CODE_03F3E3:
	STZ.w $7220,x
	LDA.w #$0005
	STA.b $18,x
	SEP.b #$20
	TAY
	LDA.w DATA_03F49B,y
	STA.w $7A96,x
	LDA.w DATA_03F495,y
	STA.w $7402,x
	TAY
	LDA.w DATA_03F2D0,y
	STA.w $7B58,x
	REP.b #$20
	LDA.b $76,x
	BEQ.b CODE_03F414
	TYA
	ASL
	TAY
	LDA.w $7182,x
	CLC
	ADC.w DATA_03F2DE,y
	STA.w $6090
CODE_03F414:
	LDA.w #$0004
	STA.b $16,x
	RTS

DATA_03F41A:
	db $08,$0C,$0D,$0C

DATA_03F41E:
	db $10,$02,$04,$02

CODE_03F422:
	LDX.b $12
	LDA.w $7A96,x
	BNE.b CODE_03F457
	DEC.b $18,x
	BMI.b CODE_03F458
	SEP.b #$20
	LDY.b $18,x
	LDA.w DATA_03F41E,y
	STA.w $7A96,x
	LDA.w DATA_03F41A,y
	STA.w $7402,x
	TAY
	LDA.w DATA_03F2D0,y
	STA.w $7B58,x
	REP.b #$20
	LDA.b $76,x
	BEQ.b CODE_03F457
	TYA
	ASL
	TAY
	LDA.w $7182,x
	CLC
	ADC.w DATA_03F2DE,y
	STA.w $6090
CODE_03F457:
	RTS

CODE_03F458:
	LDY.w $7400,x
	LDA.w DATA_03F2FA,y
	STA.w $7220,x
	LDA.w #$0007
	STA.b $18,x
	SEP.b #$20
	TAY
	LDA.w DATA_03F396,y
	STA.w $7A96,x
	LDA.w DATA_03F38E,y
	STA.w $7402,x
	TAY
	LDA.w DATA_03F2D0,y
	STA.w $7B58,x
	REP.b #$20
	LDA.b $76,x
	BEQ.b CODE_03F48F
	TYA
	ASL
	TAY
	LDA.w $7182,x
	CLC
	ADC.w DATA_03F2DE,y
	STA.w $6090
CODE_03F48F:
	LDA.w #$0000
	STA.b $16,x
CODE_03F494:
	RTS

DATA_03F495:
	db $08,$09,$0B,$0A,$09,$08

DATA_03F49B:
	db $10,$04,$04,$02,$10,$20

DATA_03F4A1:
	dw $FFF0,$0010

DATA_03F4A5:
	dw $FE00,$0200

CODE_03F4A9:
	LDX.b $12
	LDA.w $7A96,x
	BNE.b CODE_03F494
	DEC.b $18,x
	BMI.b CODE_03F458
	SEP.b #$20
	LDY.b $18,x
	LDA.w DATA_03F49B,y
	STA.w $7A96,x
	LDA.w DATA_03F495,y
	STA.w $7402,x
	TAY
	LDA.w DATA_03F2D0,y
	STA.w $7B58,x
	REP.b #$20
	LDA.b $76,x
	BEQ.b CODE_03F4DE
	TYA
	ASL
	TAY
	LDA.w $7182,x
	CLC
	ADC.w DATA_03F2DE,y
	STA.w $6090
CODE_03F4DE:
	LDA.b $18,x
	CMP.w #$0003
	BNE.b CODE_03F530
	LDY.w $7400,x
	LDA.w $70E2,x
	CLC
	ADC.w DATA_03F4A1,y
	STA.b $00
	LDA.w DATA_03F4A5,y
	STA.b $02
	LDA.w #$000B
	JSL.l CODE_03A364
	BCC.b CODE_03F529
	LDA.w $7960
	STA.w $70E2,y
	LDA.w $7182,x
	SEC
	SBC.w #$0010
	STA.w $7182,y
	LDA.b $02
	STA.w $7220,y
	LDA.w #$FE00
	STA.w $7222,y
	LDA.w #$0001
	STA.w $7D38,y
	LDA.w #$0047
	JSL.l CODE_0085D2
	BRA.b CODE_03F530

CODE_03F529:
	LDA.w #$0042
	JSL.l CODE_0085D2
CODE_03F530:
	RTS

CODE_03F531:
	LDA.b $76,x
	CMP.w #$0001
	BNE.b CODE_03F571
	STZ.w $7220,x
	LDA.w #$0003
	STA.b $18,x
	SEP.b #$20
	TAY
	LDA.w DATA_03F41E,y
	STA.w $7A96,x
	LDA.w DATA_03F41A,y
	STA.w $7402,x
	TAY
	LDA.w DATA_03F2D0,y
	STA.w $7B58,x
	REP.b #$20
	LDA.b $76,x
	BEQ.b CODE_03F569
	TYA
	ASL
	TAY
	LDA.w $7182,x
	CLC
	ADC.w DATA_03F2DE,y
	STA.w $6090
CODE_03F569:
	INC.b $76,x
	LDA.w #$0002
	STA.b $16,x
	PLA
CODE_03F571:
	RTS

;---------------------------------------------------------------------------

DATA_03F572:
	dw $FF40,$00C0,$0020,$FFE0

DATA_03F57A:
	dw $FFC0,$0040,$0120,$FFE0,$0130,$FFD0,$0140,$FFC0
	dw $0150,$FFB0,$0020,$0060,$00A0,$00E0,$0000,$0040
	dw $0080,$00C0

CODE_03F59E:
	LDA.w #$FF40
	STA.w $75E2,x
	LDY.w $7400,x
	LDA.w $7182,x
	CLC
	ADC.w #$0020
	STA.b $18,x
	LDA.w DATA_03F57A,y
	STA.w $7220,x
	RTL

;---------------------------------------------------------------------------

CODE_03F5B7:
	LDA.w $6F00,x
	CMP.w #$0010
	BEQ.b CODE_03F5CF
CODE_03F5BF:
	LDA.b $78,x
	BEQ.b CODE_03F5D4
	DEC.w $0C40
	LDA.b $78,x
	TRB.w $0C42
	STZ.b $78,x
	BRA.b CODE_03F604

CODE_03F5CF:
	LDY.w $7D96,x
	BNE.b CODE_03F5BF
CODE_03F5D4:
	LDA.w $7D38,x
	BEQ.b CODE_03F616
	STZ.w $7D38,x
	LDA.w #$0040
	STA.w $7542,x
	STA.w $7540,x
	LDA.w #$0100
	STA.w $75E2,x
	LDA.w #$0100
	LDY.w $7221,x
	BPL.b CODE_03F5F6
	LDA.w #$FF00
CODE_03F5F6:
	STA.w $75E0,x
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_03F616
CODE_03F604:
	LDA.w $6FA0,x
	ORA.w #$0060
	STA.w $6FA0,x
	LDA.w $7040,x
	ORA.w #$0004
	STA.w $7040,x
CODE_03F616:
	JSL.l CODE_03AF23
	LDA.b $78,x
	BEQ.b CODE_03F677
	JSR.w CODE_03F6B8
	LDA.b $76,x
	BEQ.b CODE_03F632
	LDA.w $7A96,x
	BNE.b CODE_03F62F
	STZ.b $76,x
	JMP.w CODE_03F6D2

CODE_03F62F:
	JSR.w CODE_03F6B1
CODE_03F632:
	JSR.w CODE_03F678
	LDY.b #$00
	LDA.b $18,x
	CMP.w $7182,x
	BMI.b CODE_03F640
	LDY.b #$02
CODE_03F640:
	LDA.w DATA_03F572,y
	STA.w $75E2,x
	LDY.b #$00
	LDA.w $7222,x
	EOR.w $75E2,x
	BMI.b CODE_03F668
	LDA.w $7222,x
	CLC
	ADC.w #$0060
	CMP.w #$00C0
	BCC.b CODE_03F676
	LDA.w $7222,x
	CLC
	ADC.w #$00A0
	CMP.w #$0140
	BCC.b CODE_03F66F
CODE_03F668:
	INY
	LDA.w $7222,x
	BMI.b CODE_03F66F
	INY
CODE_03F66F:
	TYA
	AND.w #$00FF
	STA.w $7402,x
CODE_03F676:
	RTL

CODE_03F677:
	RTL

CODE_03F678:
	LDY.w $7D36,x
	BPL.b CODE_03F698
	LDA.w #$0021
	JSL.l CODE_0085D2
	LDA.w #$0400
	STA.w $7FE8
	LDA.w #$0003
	STA.w $61CA
	LDA.w #$0010
	STA.w $0B55
	BRA.b CODE_03F6B1

CODE_03F698:
	DEY
	BMI.b CODE_03F6B7
	BEQ.b CODE_03F6B7
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_03F6B7
	LDA.w $7D38,y
	BEQ.b CODE_03F6B7
	LDA.w #$003A
	JSL.l CODE_0085D2
CODE_03F6B1:
	JSL.l CODE_039F2B
	BRA.b CODE_03F6D1

CODE_03F6B7:
	RTS

CODE_03F6B8:
	LDA.w $7680,x
	CLC
	ADC.w #$0080
	CMP.w #$0200
	BCS.b CODE_03F6D1
	LDA.w $7682,x
	CLC
	ADC.w #$0040
	CMP.w #$0140
	BCS.b CODE_03F6D1
	RTS

CODE_03F6D1:
	PLA
CODE_03F6D2:
	DEC.w $0C40
	LDA.b $78,x
	TRB.w $0C42
	JML.l CODE_03A31E

;---------------------------------------------------------------------------

DATA_03F6DE:
	db $06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06
	db $06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$BC,$BC,$BC,$09,$09,$09
	db $09,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$06,$03,$BE,$00,$00
	db $03,$01,$07,$00,$00,$01,$00,$00,$BE,$BE,$BE,$01,$01,$01,$02,$02
	db $05,$05,$06,$05,$05,$04,$05,$05,$46,$06,$06,$05,$06,$06,$BC,$BB
	db $BB,$BD,$BD,$BD,$BD,$05,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06
	db $05,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$05,$05,$05,$07,$46,$44,$40
	db $FF,$FF,$40,$40,$40,$40,$40,$40,$06,$06,$07,$06,$08,$08,$08,$08
	db $04,$04,$05,$05,$06,$06,$04,$06,$06,$06,$06,$06,$04,$42,$FD,$FD
	db $FD,$FD,$FD,$FD,$06,$05,$04,$03,$02,$01,$BF,$BD,$BC,$BC,$BC,$BC
	db $BB,$BB,$06,$07,$08,$0A,$0C,$0D,$10,$10,$10,$10,$10,$10,$10,$BC
	db $BB,$BA,$BA,$B9,$B8,$B6,$B4,$B2,$B3,$B5,$B4,$B5,$B5,$BD,$BD,$BD
	db $BF,$00,$00,$01,$02,$02,$02,$02,$02,$02,$00,$00,$00,$00,$00,$00
	db $00,$06,$06,$05,$05,$06,$06,$07,$08,$08,$08,$07,$07,$07,$07,$07
	db $07,$06,$05,$05,$05,$06,$07,$07,$08,$06,$05,$05,$05,$06,$07,$07
	db $08,$03,$03,$03,$02,$01,$02,$02,$03,$04,$04,$03,$04,$02,$01,$04
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$06,$06,$06,$06,$06,$06,$06,$06,$05,$05,$05
	db $06,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$06,$06,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;---------------------------------------------------------------------------

DATA_03F87B:
	db $00,$00,$00,$00,$02,$01,$06,$01,$42,$05,$05,$06,$06,$00,$00,$06
	db $06,$00,$02,$46,$46,$46,$46,$46,$06,$46,$06,$06,$06,$06,$46,$02
	db $06,$06,$46,$46,$46,$06,$06,$02,$02,$02,$06,$06,$BC,$BC,$BC,$49
	db $49,$49,$49,$04,$04,$04,$04,$04,$04,$44,$44,$44,$44,$FC,$FD,$FE
	db $FD,$FB,$FB,$FD,$03,$44,$04,$FC,$FC,$FC,$F7,$F7,$F7,$01,$01,$01
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$06,$06,$05,$02,$02
	db $FC,$FB,$FB,$FD,$FD,$BD

DATA_03F8E1:
	db $FD,$05,$05,$06,$06,$05,$05,$04,$04,$04,$05,$06,$05,$04,$04,$04
	db $04,$03,$06,$08,$04,$04,$04,$04,$04,$03,$04,$00,$FF,$FE,$02,$02
	db $02,$02,$F8,$F8,$F8,$F8,$FB,$FE,$00,$06,$06,$06,$06,$06,$01,$00
	db $FE,$03,$FF,$06,$01,$00,$02,$01,$00,$FF,$FF,$FF,$06,$06,$07,$07
	db $06,$04,$04,$04,$04,$04,$03,$04,$03,$08,$04,$04,$04,$04,$04,$03
	db $03,$04,$05,$05,$05,$04,$04,$04,$04,$04,$04,$04,$04,$05,$04,$04
	db $04,$04,$04,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$FE,$01,$01,$04,$04
	db $07,$07,$05,$06,$07,$05,$06,$07,$00,$04,$04,$04,$04,$04,$04,$05
	db $05,$02,$02,$02,$02,$05,$05,$04,$04,$04,$04,$04,$04,$01,$FD,$FE
	db $FE,$FE,$FE,$FE,$FE,$03,$03,$03,$02,$02,$02,$02,$01,$00,$02,$02
	db $02,$02,$01,$01,$00,$00,$00,$01,$02,$03,$04,$03,$03,$04,$05,$04
	db $05,$06,$06,$07,$07,$06,$04,$04,$04,$03,$02,$03,$05,$04,$04,$03
	db $02,$02,$02,$03,$04,$05,$05,$05,$07,$06,$05,$00,$00,$00,$00,$00
	db $00,$00,$01,$01,$00,$00,$01,$01,$02,$02,$02,$02,$00,$00,$01,$01
	db $01,$01,$05,$05,$04,$04,$04,$04,$06,$06,$05,$05,$04,$04,$05,$05
	db $06,$07,$0A,$09,$0A,$0A,$0B,$0B,$0A,$0A,$0A,$0A,$0A,$06,$0B,$0C
	db $08,$05,$05,$05,$05,$04,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$05,$05,$05,$05,$05,$05,$05,$05,$03,$04
	db $02,$07,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$05,$05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$01,$FB,$03,$FB,$FE,$04,$04,$04,$04,$00,$00,$06,$08,$00
	db $05,$05,$06,$06,$05,$05,$04,$04,$04,$05,$06,$05,$04,$05,$04,$04
	db $03,$06,$08,$04,$04,$05,$05,$05,$03,$04,$04,$03,$02,$02,$02,$02
	db $01,$F8,$F8,$F8,$F8,$FB,$FE,$00,$05,$07,$09,$04,$00,$03,$03,$04
	db $06,$04,$04,$02,$02,$04,$03,$02,$02,$02,$01,$06,$06,$07,$07,$06
	db $05,$05,$05,$05,$05,$03,$05,$03,$08,$04,$04,$04,$05,$05,$03,$03
	db $04,$05,$05,$04

DATA_03FAE5:
	db $05,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0D,$0B
	db $07,$0A,$03,$BA,$AC,$00,$0D,$0D,$0D,$0D,$0D,$0D,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$00,$00,$00,$00,$00,$07
	db $06,$06,$07,$08,$07,$07,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$40
	db $40,$40,$40,$40,$40,$40,$40,$40,$40,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$40
	db $40,$40,$40,$40,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $0A,$09,$08,$07,$06,$05,$04,$02,$00,$01,$03,$03,$03,$03,$0B,$0C
	db $0D,$0E,$0F,$10,$11,$12,$12,$12,$12,$12,$12,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$40,$40,$40,$40,$40,$00,$40,$00,$00,$00,$00,$40,$00,$00,$00
	db $40,$40,$40,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$40,$40
	db $40,$00,$00,$00,$00,$00,$00,$40,$40,$40,$40,$40,$40,$4D,$4B,$49
	db $4A,$4A,$07,$48,$08,$49,$4B,$4A,$49,$49,$4A,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$47,$46
	db $46,$47,$48,$07

DATA_03FCE9:
	db $47,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0F,$0D
	db $0A,$04,$00,$00,$00,$00,$0A,$09,$08,$04,$04,$04,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$09
	db $09,$0A,$0B,$0A,$0A,$09,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $0B,$0B,$0C,$0C,$0C,$0B,$0A,$0A,$0A,$08,$07,$08,$09,$08,$0A,$09
	db $08,$08,$08,$09,$0A,$0A,$0A,$0B,$0C,$0B,$0A,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0F,$0D,$0A
	db $03,$F9,$EB,$E2,$D8,$09,$09,$08,$FE,$FF,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$09,$09
	db $0A,$0B,$0A,$0C,$0B

	%FREE_BYTES(NULLROM, 274, $FF)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro YIBank04Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

CODE_048000:
	TYX
	RTS

;---------------------------------------------------------------------------

CODE_048002:
	JSL.l CODE_02A007
	STZ.w $7902,x
	LDA.w $70E2,x
	CLC
	ADC.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7182,x
	CLC
	ADC.w #$0010
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	AND.w #$0003
	BNE.b CODE_048066
	RTL

;---------------------------------------------------------------------------

CODE_048031:
	JSL.l CODE_03AF23
	LDA.w $7360,x
	CMP.w #$0005
	BNE.b CODE_048041
	JSL.l CODE_048131
CODE_048041:
	LDA.w $7542,x
	BNE.b CODE_04809D
	LDY.w $7D36,x
	DEY
	BMI.b CODE_04809C
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_04809C
	LDA.w $7D38,y
	BEQ.b CODE_04809C
	TYX
	JSL.l CODE_03B25B
	LDX.b $12
CODE_048060:
	LDA.w #$FD00
	STA.w $7222,x
CODE_048066:
	LDA.w $6FA0,x
	AND.w #$F9FF
	ORA.w #$0220
	STA.w $6FA0,x
CODE_048072:
	LDA.w $6FA2,x
	ORA.w #$0001
	STA.w $6FA2,x
	LDA.w $7040,x
	ORA.w #$0004
	STA.w $7040,x
	LDA.w #$0005
	STA.w $74A2,x
	LDA.w $7042,x
	AND.w #$00CF
	ORA.w #$0020
	STA.w $7042,x
	LDA.w #$0040
	STA.w $7542,x
CODE_04809C:
	RTL

CODE_04809D:
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_0480BF
	JSL.l CODE_03A590
	LDA.w $7222,x
	BMI.b CODE_0480BC
	CMP.w #$0200
	BCC.b CODE_0480BC
	LSR
	EOR.w #$FFFF
	STA.w $7222,x
	BRA.b CODE_0480BF

CODE_0480BC:
	STZ.w $7222,x
CODE_0480BF:
	LDY.b $18,x
	BEQ.b CODE_0480FC
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_0480EB
	LDA.w $70E2,y
	SEC
	SBC.w $70E2,x
	CLC
	ADC.w #$0010
	CMP.w #$0020
	BCS.b CODE_0480EB
	LDA.w $7182,y
	SEC
	SBC.w $7182,x
	CLC
	ADC.w #$001C
	CMP.w #$0038
	BCC.b CODE_0480FC
CODE_0480EB:
	LDA.w #$0000
	STA.w $79D8,y
	STA.w $7902,y
	STZ.b $18,x
	STZ.w $7902,x
	JMP.w CODE_048066

CODE_0480FC:
	LDA.b $76,x
	BEQ.b CODE_048130
	LDY.w $7D36,x
	BPL.b CODE_048115
	JSL.l CODE_03A858
	LDA.w $7C16,x
	ASL
	ASL
	ASL
	ASL
	STA.w $7220,x
	BRA.b CODE_048124

CODE_048115:
	LDA.w $7860,x
	AND.w #$0001
CODE_04811A:
	BEQ.b CODE_048130
	LDA.w #$001F
	JSL.l CODE_0085D2
CODE_048124:
	LDA.w #$000E
	STA.w $6F00,x
	LDA.w #$FE00
	STA.w $7222,x
CODE_048130:
	RTL

CODE_048131:
	LDA.w $7A96,x
	BNE.b CODE_0480FC
	LDA.w #$000C
	STA.w $7A96,x
	JML.l CODE_03B5C3

;---------------------------------------------------------------------------

CODE_048140:
	JSL.l CODE_03AD24
	BCS.b CODE_048149
	JMP.w CODE_0481C0

CODE_048149:
	SEP.b #$20
	LDA.b #$7F
	STA.w $7863,x
	REP.b #$20
	RTL

;---------------------------------------------------------------------------

DATA_048153:
	dw $0000,$8040,$8000,$00C0,$8080,$0040,$0080,$80C0

DATA_048163:
	dw $0200,$FE00

DATA_048167:
	dw $0800,$F800

CODE_04816B:
	JSL.l CODE_03AA2E
	JSL.l CODE_03AF23
	INC.b $16,x
	JSL.l CODE_03A2F8
	BCS.b CODE_0481C4
	LDY.w $7D36,x
	DEY
	BMI.b CODE_04819C
	LDA.w $6FA2,y
	AND.w #$6000
	BNE.b CODE_04819C
CODE_048189:
	SEP.b #$20
	LDA.w $74A0,y
	STA.w $74A0,x
	REP.b #$20
	TYX
	JSL.l CODE_03B507
	LDX.b $12
	BRA.b CODE_0481A1

CODE_04819C:
	LDA.w $7860,x
	BEQ.b CODE_0481C8
CODE_0481A1:
	LDA.w #$01C4
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w #$0003
	STA.w $7E4C,y
	LDA.w #$0002
	STA.w $7782,y
CODE_0481C0:
	JSL.l CODE_03A31E
CODE_0481C4:
	STZ.w $61C4
	RTL

CODE_0481C8:
	LDA.b $18,x
	LDY.w $7400,x
	BNE.b CODE_0481D3
	EOR.w #$00FF
	INC
CODE_0481D3:
	AND.w #$01FE
	STA.b $00
	LDY.w $7862,x
	BNE.b CODE_0481E3
	LDA.w #$0080
	JMP.w CODE_04827F

CODE_0481E3:
	LDA.b $16,x
	AND.w #$0007
	BEQ.b CODE_0481ED
	JMP.w CODE_048290

CODE_0481ED:
	TXA
	STA.w $6000
	LDX.b #FXCODE_098D5E>>16
	LDA.w #FXCODE_098D5E
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDY.w $6000
	BPL.b CODE_04820C
	LDX.b $12
	LDY.b #$00
	LDA.b $76,x
	BMI.b CODE_048209
	LDY.b #$02
CODE_048209:
	JMP.w CODE_04828C

CODE_04820C:
	LDY.b #$00
	LDA.w $6002
	BPL.b CODE_048219
	LDY.b #$04
	EOR.w #$FFFF
	INC
CODE_048219:
	CMP #$0100
	BCS.b CODE_04828E
	STA.b $02
	TAX
	LDA.w $6004
	BPL.b CODE_04822C
	INY
	INY
	EOR.w #$FFFF
	INC
CODE_04822C:
	CMP.w #$0100
	BCS.b CODE_04828E
	CMP.b $02
	BCC.b CODE_048239
	INY
	TAX
	LDA.b $02
CODE_048239:
	CPX.b #$10
	BCS.b CODE_04824D
	LDY.w $6000
	LDA.w $6FA0,y
	AND.w #$0200
	BEQ.b CODE_04824D
	LDX.b $12
	JMP.w CODE_048189

CODE_04824D:
	XBA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	TYA
	ASL
	TAY
	NOP #4
	REP.b #$10
	LDA.w !REGISTER_QuotientLo
	ASL
	TAX
	CPX.w #$0202
	BCC.b CODE_04826A
	LDX.w #$0200
CODE_04826A:
	LDA.w DATA_048153,y
	ASL
	STA.b $02
	LDA.l FXDATA_0BB810,x
	BCC.b CODE_04827A
	EOR.w #$FFFF
	INC
CODE_04827A:
	CLC
	ADC.b $02
	SEP.b #$10
CODE_04827F:
	SBC.b $00
	LDY.b #$00
	AND.w #$0100
	BEQ.b CODE_04828A
	LDY.b #$02
CODE_04828A:
	LDX.b $12
CODE_04828C:
	STY.b $78,x
CODE_04828E:
	LDX.b $12
CODE_048290:
	LDY.b $78,x
	LDA.b $76,x
	CMP.w DATA_048167,y
	BEQ.b CODE_04829F
	CLC
	ADC.w DATA_048163,y
	STA.b $76,x
CODE_04829F:
	AND.w #$FF00
	BPL.b CODE_0482A7
	ORA.w #$00FF
CODE_0482A7:
	XBA
	CLC
	ADC.b $00
	AND.w #$01FE
	STA.b $00
	SEC
	SBC.w #$0081
	LDY.b #$02
	CMP.w #$00FF
	LDA.b $00
	BCS.b CODE_0482C6
	EOR.w #$00FF
	INC
	AND.w #$01FE
	LDY.b #$00
CODE_0482C6:
	STA.b $18,x
	PHA
	REP.b #$10
	TYA
	STA.w $7400,x
	TXY
	LDX.b $00
	LDA.l DATA_00E954,x
	ASL
	ASL
	STA.w $7220,y
	LDA.l DATA_00E9D4,x
	EOR.w #$FFFF
	INC
	ASL
	ASL
	STA.w $7222,y
	PLA
	LSR
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDX.w $7722,y
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w #$30A0
	LDA.b $14
	AND.w #$0002
	BEQ.b CODE_048311
	LDY.w #$30B0
CODE_048311:
	TYA
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	SEP.b #$10
	LDX.b #FXCODE_08867E>>16
	LDA.w #FXCODE_08867E
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	INC.w $0CF9
	LDX.b $12
	RTL

;---------------------------------------------------------------------------

CODE_04832C:
	RTL

;---------------------------------------------------------------------------

DATA_04832D:
	dw $0008,$FFF8,$0008,$FFF8

DATA_048335:
	dw $0008,$0008,$FFF8,$FFF8

CODE_04833D:
	JSL.l CODE_03AF23
	REP.b #$10
	LDA.w $7902,x
	TAX
	LDA.l $700007,x
	AND.w #$00FF
	CMP.w #$0089
	BNE.b CODE_04839D
	LDA.l $700006,x
	AND.w #$00FF
	ASL
	TAY
	LDA.l $700000,x
	AND.w #$FFF0
	CLC
	ADC.w DATA_04832D,y
	STA.w $6000
	LDA.l $700002,x
	AND.w #$FFF0
	CLC
	ADC.w DATA_048335,y
	STA.w $6002
	JSL.l CODE_00E01F&$00FFFF
	SEP.b #$10
	LDA.w #$0213
	JSL.l CODE_008B21
	LDA.w $6000
	STA.w $70A2,y
	LDA.w $6002
	STA.w $7142,y
	LDA.w #$0008
	STA.w $73C2,y
	LDA.w #$0004
	STA.w $7782,y
CODE_04839D:
	SEP.b #$10
	LDX.b $12
	LDA.w $7A96,x
	AND.w #$0003
	BNE.b CODE_0483B8
	INC.w $7402,x
	LDA.w $7402,x
	CMP.w #$0004
	BCC.b CODE_0483B8
	JML.l CODE_03A31E

CODE_0483B8:
	LDA.w $7A38,x
	BNE.b CODE_048413
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_099011>>16
	LDA.w #FXCODE_099011
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
CODE_0483CA:
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	BMI.b CODE_048412
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_0483E1
	LDA.w $7040,y
	AND.w #$0010
	BNE.b CODE_0483EC
CODE_0483E1:
	LDX.b #$09
	LDA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	JSL.l $7EDE47
	BRA.b CODE_0483CA

CODE_0483EC:
	LDA.w #$0012
	STA.w $6F00,y
	LDA.w $7FEE
	BNE.b CODE_048400
	LDA.w $6FA2,y
	AND.w #$FFE0
	STA.w $6FA2,y
CODE_048400:
	LDA.w #$0000
	STA.w $7A96,y
	STA.w $7220,y
	STA.w $7540,y
	LDA.w #$FC00
	STA.w $7222,y
CODE_048412:
	RTL

CODE_048413:
	LDY.w $7D36,x
	BPL.b CODE_048427
	LDA.w $61D6
	BNE.b CODE_048427
	JSL.l CODE_03A858
	LDA.w #$0002
	STA.w $03BC
CODE_048427:
	RTL

;---------------------------------------------------------------------------

CODE_048428:
	RTL

;---------------------------------------------------------------------------

CODE_048429:
	JSL.l CODE_03AF23
	LDA.w $7A96,x
	BNE.b CODE_048441
	LDA.w #$0006
	STA.w $7A96,x
	DEC.w $7402,x
	BPL.b CODE_048441
	JML.l CODE_03A31E

CODE_048441:
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_099011>>16
	LDA.w #FXCODE_099011
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
CODE_04844E:
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	BMI.b CODE_0484BF
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_04846A
	LDA.w $7D96,y
	BNE.b CODE_04846A
	LDA.w $7040,y
	AND.w #$0040
	BNE.b CODE_048475
CODE_04846A:
	LDX.b #$09
	LDA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	JSL.l $7EDE47
	BRA.b CODE_04844E

CODE_048475:
	TYX
	LDA.w #$00A0
	JSL.l CODE_0085D2
	LDA.w #$0200
	STA.w $7D96,x
	STZ.w $7A98,x
	STZ.w $7220,x
	STZ.w $7540,x
	LDA.w #$FD00
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
CODE_04849E:
	LDA.w #$01CD
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w #$000B
	STA.w $7E4C,y
	LDA.w #$0004
	STA.w $7782,y
	LDX.b $12
CODE_0484BF:
	RTL

;---------------------------------------------------------------------------

CODE_0484C0:
	RTL

;---------------------------------------------------------------------------

DATA_0484C1:
	dw $0003,$0003,$0002,$0002,$0002,$0002,$0002,$0002
	dw $0002,$0002,$0002,$0002,$0002,$0002,$0002,$0002
	dw $0002,$0002,$0002,$0002,$0001,$0000

DATA_0484ED:
	dw $FFF0,$0010,$FFE8,$0018,$FFE0,$0020,$FFD8,$0028

DATA_0484FD:
	dw $0001,$0002,$0000,$0002

DATA_048505:
	dw $FE00,$0200,$FE00,$0200

CODE_04850D:
	JSL.l CODE_03AF23
	LDA.w $7A96,x
	BNE.b CODE_048579
	LDA.w $7A98,x
	BEQ.b CODE_048528
	LSR
	BEQ.b CODE_048524
	JSL.l CODE_0485E5
	BRA.b CODE_04852C

CODE_048524:
	INC
	STA.w $7402,x
CODE_048528:
	JSL.l CODE_0485C9
CODE_04852C:
	LDA.w $7970
	AND.w #$0003
	ASL
	LDY.w $7221,x
	BPL.b CODE_048539
	INC
CODE_048539:
	ASL
	TAY
	LDA.w $7220,x
	CLC
	ADC.w DATA_0484ED,y
	STA.w $7220,x
	EOR.w DATA_0484ED,y
	BMI.b CODE_04855D
	LDA.w $7970
	AND.w #$0006
	CLC
	ADC.w #$0004
	STA.w $7976,x
	LDA.w #$0030
	STA.w $7A96,x
CODE_04855D:
	LDA.w $7222,x
	CMP.w #$FF80
	BPL.b CODE_048578
	LDA.w $7970
	AND.w #$0003
	ASL
	ASL
	TAY
	LDA.w $7222,x
	CLC
	ADC.w DATA_0484ED+$02,y
	STA.w $7222,x
CODE_048578:
	RTL

CODE_048579:
	STZ.w $7220,x
	CMP.w #$0001
	BNE.b CODE_048585
	JML.l CODE_03A31E

CODE_048585:
	BIT.w #$0003
	BNE.b CODE_0485C9
	LSR
	LSR
	ASL
	TAY
	LDA.w DATA_0484C1,y
	STA.w $7402,x
	DEC
	BEQ.b CODE_0485B3
	DEC
	BNE.b CODE_0485B9
	LDA.w $7976,x
	BMI.b CODE_0485B9
	DEC.w $7976,x
	INC.b $18,x
	LDA.b $18,x
	AND.w #$0003
	ASL
	TAY
	LDA.w DATA_0484FD,y
	STA.w $7402,x
	BRA.b CODE_0485B9

CODE_0485B3:
	DEC.w $7182,x
	DEC.w $7182,x
CODE_0485B9:
	LDA.w $7970
	AND.w #$0001
	BNE.b CODE_0485C2
	DEC
CODE_0485C2:
	CLC
	ADC.w $70E2,x
	STA.w $70E2,x
CODE_0485C9:
	LDY.w $7D36,x
	BPL.b CODE_0485E5
	LDY.w $77C2,x
	LDA.w DATA_048505,y
	STA.w $60B4
	LDA.w #$FA00
	STA.w $60AA
	LDA.w #$0008
	STA.w $60C0
	BRA.b CODE_04862A

CODE_0485E5:
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_099011>>16
	LDA.w #FXCODE_099011
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	BMI.b CODE_048654
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_048654
	LDA.w $7040,y
	AND.w #$0020
	BEQ.b CODE_048654
	LDA.w $7C16,y
	ASL
	LDA.w #$FE00
	BCS.b CODE_048615
	LDA.w #$0200
CODE_048615:
	STA.w $7220,y
	LDA.w #$FC00
	STA.w $7222,y
	LDA.w #$0020
	STA.w $7D38,y
	LDA.w #$0000
	STA.w $7978,y
CODE_04862A:
	LDA.w #$003B
	JSL.l CODE_0085D2
	LDA.w #$01D0
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w #$000A
	STA.w $7E4C,y
	LDA.w #$0002
	STA.w $7782,y
	JML.l CODE_03A31E

CODE_048654:
	RTL

;---------------------------------------------------------------------------

CODE_048655:
	LDA.w #$001C
	JSL.l CODE_03A34C
	BCC.b CODE_04868A
	INY
	TYA
	STA.w $7A38,x
	SEP.b #$20
	TXA
	STA.w $79D6,y
	REP.b #$20
	LDA.w $703F,y
	AND.w #$FFF3
	STA.w $703F,y
CODE_048674:
	LDA.w $70E2,x
	STA.w $70E1,y
	LDA.w $7182,x
	CLC
	ADC.w #$000D
	STA.w $7181,y
	LDA.w $7220,x
	STA.w $721F,y
CODE_04868A:
	RTL

;---------------------------------------------------------------------------

DATA_04868B:
	dw $0007,$0005

DATA_04868F:
	dw $0006,$0004

DATA_048693:
	dw $0080,$FF80

DATA_048697:
	dw $FFFC,$0004,$FFF0,$0000,$000F,$FFFF,$FFF8,$0000
	dw $0008,$000F,$0008,$FFFF,$001F,$FFFF,$000F,$FFF0

DATA_0486B7:
	dw $FFE0,$0000,$0000,$0000,$0002,$0002,$FFFE,$FFFE
	dw $0001,$0001,$0001,$FFFF,$FFFF,$FFFF,$FFFC,$FFFC
	dw $FFFC,$0004

DATA_0486DB:
	dw $0004,$0004,$0000,$0000,$00B5,$00B5,$00B5,$00B5
	dw $00E4,$00E4,$00E4,$00E4,$00E4,$00E4,$0072,$0072
	dw $0072,$0072,$0072,$0072,$0100,$0100

CODE_048707:
	JSL.l CODE_03A2DE
	BCC.b CODE_04871B
	LDY.w $7A38,x
	BEQ.b CODE_04871A
	DEY
	TYX
	JSL.l CODE_03A31E
	LDX.b $12
CODE_04871A:
	RTL

CODE_04871B:
	JSL.l CODE_03AF23
	REP.b #$10
	LDA.w $7902,x
	TAX
	LDA.l $700006,x
	SEP.b #$10
	LDX.b $12
	SEC
	SBC.w #$0092
	CMP.w #$0002
	BCS.b CODE_04877B
	ASL
	TAY
	LDA.w $7220,x
	SEC
	SBC.w DATA_048693,y
	EOR.w DATA_048693,y
	BMI.b CODE_04874A
	LDA.w DATA_048693,y
	STA.w $7220,x
CODE_04874A:
	LDA.w DATA_048697,y
	LDY.b #$00
	CLC
	ADC.w $7220,x
	STA.w $7220,x
	BMI.b CODE_04875A
	LDY.b #$02
CODE_04875A:
	CLC
	ADC.w #$0010
	CMP.w #$0020
	STZ.w $7402,x
	BCS.b CODE_048769
	INC.w $7402,x
CODE_048769:
	TYA
	STA.w $7400,x
	LDA.w $7182,x
	AND.w #$FFF0
	ORA.w #$0008
	STA.w $7182,x
	BRA.b CODE_0487E7

CODE_04877B:
	CMP.w #$0004
	BCC.b CODE_0487E7
	CMP.w #$0016
	BCS.b CODE_0487E7
	ASL
	TAY
	REP.b #$10
	LDA.w $7902,x
	TAX
	LDA.l $700000,x
	AND.w #$000F
	STA.b $00
	SEP.b #$10
	LDX.w DATA_0486B7,y
	STX.w !REGISTER_Mode7MatrixParameterA
	LDX.w DATA_0486B7+$01,y
	STX.w !REGISTER_Mode7MatrixParameterA
	TAX
	STX.w !REGISTER_Mode7MatrixParameterB
	LDX.b $12
	LDA.w $7182,x
	CLC
	ADC.w #$0008
	AND.w #$000F
	STA.b $02
	LDA.w !REGISTER_PPUMultiplicationProductLo
	CMP.w #$8000
	ROR
	CLC
	ADC.w DATA_048693,y
	CLC
	SBC.b $02
	BPL.b CODE_0487E7
	LSR.b $00
	LSR.b $00
	LSR.b $00
	ADC.w $7182,x
	STA.w $7182,x
	LDA.w #$0200
	STA.w $7222,x
	LDA.w DATA_0486DB,y
	LDY.w $7400,x
	BNE.b CODE_0487E4
	EOR.w #$FFFF
	INC
CODE_0487E4:
	STA.w $7220,x
CODE_0487E7:
	LDY.w $7400,x
	LDA.w DATA_04868B,y
	STA.w $74A2,x
	LDA.w $7A38,x
	BEQ.b CODE_048815
	LDA.w DATA_04868F,y
	LDY.w $7A38,x
	STA.w $74A1,y
	LDA.w $7400,x
	STA.w $73FF,y
	LDA.w $7222,x
	BEQ.b CODE_04880F
	ASL
	ROL
	AND.w #$0001
	INC
CODE_04880F:
	STA.w $79D7,y
	JMP.w CODE_048674

CODE_048815:
	LDA.b $78,x
	BEQ.b CODE_048862
	LDA.w $60C0
	BEQ.b CODE_048844
	LDA.w $60B4
	BNE.b CODE_048836
	LDA.w $7220,x
	EOR.b $78,x
	BMI.b CODE_048836
	LDA.w $72C0,x
	CLC
	ADC.w $608C
	STA.w $608C
	BRA.b CODE_048867

CODE_048836:
	STZ.b $78,x
	LDA.w $60B4
	CLC
	ADC.w $7220,x
	STA.w $60B4
	BRA.b CODE_0488B3

CODE_048844:
	STZ.b $78,x
	LDA.w DATA_04868F,y
	STA.w $611A
	LDA.w $7C16,x
	SEC
	SBC.w $72C0,x
	STA.w $7C16,x
	LDA.w $72C0,x
	CLC
	ADC.w $608C
	STA.w $608C
	BRA.b CODE_048867

CODE_048862:
	LDA.w $60C0
	BEQ.b CODE_0488B3
CODE_048867:
	LDA.w $60AA
	BMI.b CODE_0488B3
	LDY.w $0D94
	BNE.b CODE_0488B3
	LDA.w $7C16,x
	CLC
	ADC.w #$0014
	CMP.w #$0028
	BCS.b CODE_0488B3
	LDA.w $7182,x
	SEC
	SBC.w $6090
	CMP.w #$FFF5
	BCC.b CODE_0488B3
	STA.b $00
	LDY.w $61B6
	BEQ.b CODE_048895
	CPX.w $61B6
	BNE.b CODE_0488B3
CODE_048895:
	STX.w $61B6
	LDA.b $00
	INC
	ADC.w $6090
	STA.w $6090
	LDA.w #$0400
	STA.w $60AA
	INC.w $61B4
	STZ.w $60FA
	LDA.w $7220,x
	STA.b $78,x
	RTL

CODE_0488B3:
	CPX.w $61B6
	BNE.b CODE_0488BB
	STZ.w $61B6
CODE_0488BB:
	RTL

;---------------------------------------------------------------------------

CODE_0488BC:
	SEP.b #$20
	LDA.b #$FF
	STA.w $7863,x
	REP.b #$20
	LDA.w #$0008
	LDY.w $0136
	CPY.b #$03
	BEQ.b CODE_0488D3
	CPY.b #$0D
	BNE.b CODE_0488D6
CODE_0488D3:
	LDA.w #$FFF6
CODE_0488D6:
	STA.w $7720,x
	STA.b $16,x
	RTL

;---------------------------------------------------------------------------

CODE_0488DC:
	JSL.l CODE_03AF23
	LDY.w $7862,x
	BEQ.b CODE_0488FA
	LDA.w $7222,x
	BPL.b CODE_04890F
	STZ.b $18,x
	SEC
	SBC.w #$0008
	CMP.w #$FF80
	BCS.b CODE_048930
	LDA.w #$FF80
	BRA.b CODE_048930

CODE_0488FA:
	LDA.w $7222,x
	BMI.b CODE_04891C
	STZ.b $18,x
	CLC
	ADC.w #$0008
	CMP.w #$0080
	BCC.b CODE_048930
	LDA.w #$0080
	BRA.b CODE_048930

CODE_04890F:
	LSR
	LSR
	LSR
	EOR.w #$FFFF
	INC
	CLC
	ADC.w #$FFFC
	BRA.b CODE_048927

CODE_04891C:
	EOR.w #$FFFF
	INC
	LSR
	LSR
	LSR
	CLC
	ADC.w #$0004
CODE_048927:
	CLC
	ADC.b $18,x
	STA.b $18,x
	CLC
	ADC.w $7222,x
CODE_048930:
	STA.w $7222,x
	STZ.b $78,x
	LDA.w $60AA
	BMI.b CODE_04899B
	LDA.w $6120
	CLC
	ADC.w #$0005
	ASL
	STA.b $00
	LSR
	CLC
	ADC.w $7C16,x
	CMP.b $00
	BCS.b CODE_04899B
	LDA.w $7C18,x
	SEC
	SBC.w $6122
	SEC
	SBC.w #$0010
	CMP.w #$FFF6
	BCC.b CODE_04899B
	INC
	SEC
	ADC.w $6090
	STA.w $6090
	LDA.w $7720,x
	SEC
	SBC.b $16,x
	BNE.b CODE_048981
	LDA.w #$FFF8
	CLC
	ADC.b $16,x
	STA.w $7720,x
	LDA.w $60AA
	LSR
	CLC
	ADC.w $7222,x
	STA.w $7222,x
CODE_048981:
	LDA.w #$0100
	STA.w $60AA
	INC.w $61B4
	STZ.w $60FA
	LDA.w $7C16,x
	BNE.b CODE_048993
	INC
CODE_048993:
	ASL
	AND.w #$01FE
	STA.b $78,x
	BRA.b CODE_0489B2

CODE_04899B:
	LDA.w $7720,x
	SEC
	SBC.b $16,x
	BEQ.b CODE_0489B2
	LDA.b $16,x
	STA.w $7720,x
	LDA.w $7222,x
	SEC
	SBC.w #$0100
	STA.w $7222,x
CODE_0489B2:
	RTL

CODE_0489B3:
	LDY.b #$05
	STY.b $76,x
	RTL

;---------------------------------------------------------------------------

DATA_0489B8:
	dw $0001,$0003,$0005,$0009

CODE_0489C0:
	STZ.w $7900,x
	LDA.w $7902,x
	BNE.b CODE_0489F8
	JSL.l CODE_0EB8AE
	BNE.b CODE_0489F8
	LDA.w #$0060
	STA.w $6FA0,x
	LDA.w #$4000
	STA.w $6FA2,x
	LDA.w #$0005
	STA.w $7040,x
	LDA.w #$00FF
	STA.w $74A2,x
	STZ.w $7542,x
	LDA.w $70E2,x
	CLC
	ADC.w #$0008
	STA.w $70E2,x
	LDY.b #$08
	STY.b $76,x
	RTL

CODE_0489F8:
	JSL.l CODE_048A18
	JSL.l CODE_02A007
CODE_048A00:
	LDA.w #$0018
	STA.w $7A96,x
	LDA.w #$0004
	STA.b $16,x
	LDA.w $7360,x
	CMP.w #$001E
	BEQ.b CODE_048A17
	LDY.b #$02
	STY.b $78,x
CODE_048A17:
	RTL

CODE_048A18:
	LDA.w $7902,x
	BIT.w #$0001
	BNE.b CODE_048A3C
	LDA.w $70E2,x
	AND.w #$0010
	LSR
	LSR
	LSR
	STA.b $00
	LDA.w $7182,x
	AND.w #$0010
	LSR
	LSR
	ORA.b $00
	TAY
	LDA.w DATA_0489B8,y
	STA.w $7902,x
CODE_048A3C:
	AND.w #$00FE
	ORA.w #$0020
	STA.w $7042,x
	RTL

;---------------------------------------------------------------------------

DATA_048A46:
	dw CODE_048DA0
	dw CODE_048E14
	dw CODE_048EB5
	dw CODE_048F0F
	dw CODE_048F22
	dw CODE_048000
	dw CODE_048F57
	dw CODE_048F90
	dw CODE_048FD0

CODE_048A58:
	LDY.b $76,x
	CPY.b #$08
	BEQ.b CODE_048A8A
	JSR.w CODE_048ACB
	LDY.b $76,x
	CPY.b #$02
	BNE.b CODE_048A8A
	LDA.w $6F00,x
	SEC
	SBC.w #$0010
	ORA.w $7D96,x
	BNE.b CODE_048A8A
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_048AAB
	LDA.w $7860,x
	AND.w #$000C
	BEQ.b CODE_048A8E
	JML.l CODE_03B273

CODE_048A8A:
	JSL.l CODE_03AF23
CODE_048A8E:
	LDY.b $76,x
	TYA
	ASL
	TXY
	TAX
	JSR.w (DATA_048A46,x)
	LDY.b $76,x
	CPY.b #$08
	BEQ.b CODE_048AAB
	LDA.w $7AF6,x
	BNE.b CODE_048AA8
	JSR.w CODE_048B8D
	JSR.w CODE_048BDF
CODE_048AA8:
	JSR.w CODE_048AAC
CODE_048AAB:
	RTL

CODE_048AAC:
	LDA.w $6FA0,x
	AND.w #$FFBF
	LDY.b $76,x
	CPY.b #$04
	BEQ.b CODE_048AC3
	LDY.w $7A36,x
	BEQ.b CODE_048AC3
	DEC.w $7A36,x
	ORA.w #$0040
CODE_048AC3:
	STA.w $6FA0,x
	RTS

DATA_048AC7:
	dw $001B,$001C

CODE_048ACB:
	LDA.w $7722,x
	BMI.b CODE_048B0D
	LDA.w $6F00,x
	CMP.w #$0008
	BNE.b CODE_048ADD
	LDY.w $74A2,x
	BMI.b CODE_048B0A
CODE_048ADD:
	LDY.w $7403,x
	BNE.b CODE_048B0A
	LDA.w $7362,x
	BMI.b CODE_048B0A
	JSL.l CODE_03AA2E
	REP.b #$10
	LDY.w $7362,x
	LDA.w #$8000
	STA.w $6008,y
	STA.w $6010,y
	LDA.w $7040,x
	AND.w #$2000
	BEQ.b CODE_048B0A
	LDA.w #$8000
	STA.w $6018,y
	STA.w $6020,y
CODE_048B0A:
	SEP.b #$10
	RTS

CODE_048B0D:
	LDA.w $6F00,x
	CMP.w #$0010
	BNE.b CODE_048B72
	LDA.w $7D96,x
	BNE.b CODE_048B0A
	LDY.b $76,x
	CPY.b #$04
	BEQ.b CODE_048B24
CODE_048B20:
	LDY.b $78,x
	BNE.b CODE_048B3E
CODE_048B24:
	REP.b #$10
	LDY.w $7362,x
	LDA.w $6004,y
	AND.w #$F1FF
	STA.w $6004,y
	LDA.w $600C,y
	AND.w #$F1FF
	STA.w $600C,y
	SEP.b #$10
	RTS

CODE_048B3E:
	LDY.b $79,x
	LDA.w $7AF8,x
	BNE.b CODE_048B58
	LDA.b $10
	AND.w #$0003
	INC
	INC
	STA.w $7AF8,x
	INY
	INY
	TYA
	AND.w #$0002
	TAY
	STY.b $79,x
CODE_048B58:
	LDA.w DATA_048AC7,y
	STA.b $02
	REP.b #$10
	LDY.w $7362,x
	LDA.w $6004,y
	ORA.b $02
	AND.w #$F1FF
	ORA.w #$0200
	STA.w $6004,y
	SEP.b #$10
CODE_048B72:
	RTS

CODE_048B73:
	LDA.w #$0020
	STA.w $7A36,x
	LDA.w $7722,x
	BMI.b CODE_048B82
	JSL.l CODE_03AEFD
CODE_048B82:
	JSR.w CODE_048C80
	PHB
	PHK
	PLB
	JSR.w CODE_048EBB
	PLB
	RTL

CODE_048B8D:
	LDY.w $7D36,x
	BMI.b CODE_048B9B
	CPX.w $61B6
	BNE.b CODE_048B9A
	STZ.w $61B6
CODE_048B9A:
	RTS

CODE_048B9B:
	LDY.b $76,x
	LDA.w $7360,x
	CMP.w #$0074
	BNE.b CODE_048BAB
	CPY.b #$03
	BNE.b CODE_048BBB
	BRA.b CODE_048BAF

CODE_048BAB:
	CPY.b #$02
	BNE.b CODE_048BB4
CODE_048BAF:
	PLA
	JML.l CODE_03B273

CODE_048BB4:
	CPY.b #$05
	BNE.b CODE_048BBB
	JSR.w CODE_048D13
CODE_048BBB:
	LDA.w $7C18,x
	SEC
	SBC.w $6122
	SEC
	SBC.w $7BB8,x
	CMP.w #$FFF8
	BCS.b CODE_048BD0
	PLA
	JSL.l CODE_03A813
CODE_048BD0:
	PLA
	STA.b $00
	JSL.l CODE_03A5B7
	LDA.b $00
	PHA
	RTS

CODE_048BDB:
	JSR.w CODE_048BDF
	RTL

CODE_048BDF:
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_099011>>16
	LDA.w #FXCODE_099011
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
CODE_048BEC:
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	BMI.b CODE_048BF5
	BNE.b CODE_048C01
CODE_048BF5:
	RTS

CODE_048BF6:
	LDX.b #$09
	LDA.w !REGISTER_SuperFX_R15_ProgramCounterLo
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	BRA.b CODE_048BEC

CODE_048C01:
	LDA.w $7360,x
	CMP.w #$0074
	BNE.b CODE_048C16
	LDA.b $76,x
	AND.w #$00FF
	CMP.w #$0003
	BNE.b CODE_048C23
	JMP.w CODE_048CED

CODE_048C16:
	LDA.b $76,x
	AND.w #$00FF
	CMP.w #$0002
	BNE.b CODE_048C23
	JMP.w CODE_048CED

CODE_048C23:
	LDA.w $6FA0,y
	AND.w #$0200
	BEQ.b CODE_048BF6
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_048BF6
	LDA.w $7D38,y
	BEQ.b CODE_048BF6
	LDA.w $7360,y
	CMP.w #$0156
	BEQ.b CODE_048BF6
	CMP.w #$001E
	BEQ.b CODE_048C54
	CMP.w #$012A
	BEQ.b CODE_048C54
	CMP.w #$0133
	BEQ.b CODE_048C54
	CMP.w #$0074
	BNE.b CODE_048C5E
CODE_048C54:
	TYX
	JSL.l CODE_03B273
	PLA
	JML.l CODE_03B273

CODE_048C5E:
	LDA.w $7220,y
	PHP
	LDA.w #$0200
	PLP
	BPL.b CODE_048C6B
	LDA.w #$FE00
CODE_048C6B:
	STA.w $7220,x
	TYX
	JSL.l CODE_03B24B
	LDA.w #$FF00
	STA.w $7222,x
	LDA.w #$0067
	JSL.l CODE_0085D2
CODE_048C80:
	LDA.w #$0001
	STA.w $7D38,x
	LDA.w #$FFF0
	STA.w $7900,x
	LDA.w $7220,x
	BEQ.b CODE_048CA0
	LDA.w $7400,x
	DEC
	EOR.w $7220,x
	BPL.b CODE_048CA0
	LDA.w #$0010
	STA.w $7900,x
CODE_048CA0:
	STZ.w $75E0,x
	STZ.w $7540,x
	LDY.b #$02
	LDA.w $7360,x
	CMP.w #$0074
	BNE.b CODE_048CB2
	LDY.b #$03
CODE_048CB2:
	STY.b $76,x
	LDA.w #$0040
	STA.w $7542,x
	LSR
	ORA.w $7042,x
	STA.w $7042,x
	LDA.w #$0005
	STA.w $7402,x
	LDA.w $7360,x
	CMP.w #$001E
	BNE.b CODE_048CD1
	STZ.b $78,x
CODE_048CD1:
	LDA.w #$0841
	STA.w $6FA2,x
	STZ.w $7A38,x
	JSL.l CODE_03AD24
	BCS.b CODE_048CEC
	LDA.w $7042,x
	ORA.w #$0080
	STA.w $7042,x
	STZ.w $7402,x
CODE_048CEC:
	RTS

CODE_048CED:
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_048CFD
	LDA.w $6FA2,y
	AND.w #$6000
	BEQ.b CODE_048D00
CODE_048CFD:
	JMP.w CODE_048BF6

CODE_048D00:
	LDA.w $6FA0,y
	AND.w #$0020
	BNE.b CODE_048CFD
	LDA.w $7360,y
	CMP.w #$0156
	BEQ.b CODE_048CFD
	JMP.w CODE_048C54

CODE_048D13:
	LDA.w $61B2
	BPL.b CODE_048D5C
	LDA.w $7E48
	BEQ.b CODE_048D1F
	BPL.b CODE_048D5C
CODE_048D1F:
	JSL.l CODE_06BEBA
	LDA.w #$0020
	JSL.l CODE_03A364
	BCC.b CODE_048D40
	LDA.w $70E2,x
	STA.w $70E2,y
	STA.b $04
	LDA.w $7182,x
	STA.w $7182,y
	STA.b $06
	JSL.l CODE_048D5F
CODE_048D40:
	LDA.w #$000A
	STA.w $6F00,x
	TXA
	STA.w $7E48
	LDA.w #$8000
	STA.w $0390
	LDA.w #$FFFF
	STA.w $0CD0
	LDA.w #$0020
	STA.w $0CC8
CODE_048D5C:
	PLA
	PLA
	RTL

CODE_048D5F:
	LDA.w $77C2,x
	AND.w #$00FF
	STA.w $7400
	EOR.w #$0002
	STA.w $7400,y
	LDA.w #$0000
	STA.w $7402,y
	STA.w $7978,y
	SEP.b #$20
	LDA.b #$0E
	STA.w $79D6,y
	REP.b #$20
	STY.b $18
	LDA.b $04
	STA.w $70E2
	LDA.b $06
	SEC
	SBC.w #$000E
	STA.w $7182
	TYX
	JSL.l CODE_06BE72
	LDX.b $12
	RTL

DATA_048D98:
	dw $FEF4,$010C

DATA_048D9C:
	dw $FFA7,$0059

CODE_048DA0:
	TYX
	LDA.w $7860,x
	LSR
	BCC.b CODE_048DAA
	STZ.w $7220,x
CODE_048DAA:
	LDA.w $7A96,x
	BNE.b CODE_048DC2
	DEC.b $16,x
	BEQ.b CODE_048DC3
	LDA.w #$0018
	STA.w $7A96,x
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
CODE_048DC2:
	RTS

CODE_048DC3:
	LDA.b $10
	AND.w #$0003
	BNE.b CODE_048DD1
	LDY.w $77C2,x
	TYA
	STA.w $7400,x
CODE_048DD1:
	LDY.w $7400,x
	LDA.w DATA_048D9C,y
	STA.w $75E0,x
	LDA.b $10
	AND.w #$001F
	CLC
	ADC.w #$0020
	CPY.b #$00
	BNE.b CODE_048DEB
	EOR.w #$FFFF
	INC
CODE_048DEB:
	CLC
	ADC.w $70E2,x
	STA.w $7A38,x
	LDA.w #$0005
	STA.w $7540,x
	INC.b $76,x
	RTS

DATA_048DFB:
	dw $0004,$0008

DATA_048DFF:
	db $02,$02,$03,$03,$03,$03,$02,$01,$01,$02,$02,$02,$02,$01

DATA_048E0D:
	db $00,$03,$00,$02,$04,$01,$02

CODE_048E14:
	TYX
	LDA.w $7860,x
	BIT.w #$000C
	BNE.b CODE_048E90
	AND.w #$0001
	STA.b $00
	LDY.w $6F02,x
	TYA
	ORA.b $00
	BEQ.b CODE_048E90
	LDA.w $70E2,x
	SEC
	SBC.w $7A38,x
	CLC
	ADC.w #$0008
	CMP.w #$0010
	BCC.b CODE_048E90
	LDA.w $7A98,x
	BNE.b CODE_048E8F
	LDA.w $7360,x
	CMP.w #$0124
	BNE.b CODE_048E63
	LDY.b #$00
	LDA.w $7540,x
	CMP.w #$0005
	BNE.b CODE_048E53
	INY
	INY
CODE_048E53:
	LDA.w DATA_048DFB,y
	STA.w $7A98,x
	LDA.w $7402,x
	EOR.w #$0001
	STA.w $7402,x
	RTS

CODE_048E63:
	INC.b $77,x
	LDY.b $77,x
	CPY.b #$07
	BMI.b CODE_048E6F
	LDY.b #$00
	STY.b $77,x
CODE_048E6F:
	LDA.w DATA_048E0D,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w $7540,x
	CMP.w #$0005
	BEQ.b CODE_048E86
	TYA
	CLC
	ADC.w #$0007
	TAY
CODE_048E86:
	LDA.w DATA_048DFF,y
	AND.w #$00FF
	STA.w $7A98,x
CODE_048E8F:
	RTS

CODE_048E90:
	LDA.w #$0018
	STA.w $7A96,x
	LDA.b $10
	AND.w #$0001
	CLC
	ADC.w #$0003
	STA.b $16,x
	LDY.b #$00
	STY.b $77,x
	STZ.w $7402,x
	STZ.w $7220,x
	STZ.w $7540,x
	STZ.b $76,x
	RTS

DATA_048EB1:
	dw $6020,$2040

CODE_048EB5:
	TYX
	LDA.w $7722,x
	BMI.b CODE_048F0E
CODE_048EBB:
	LDA.w $7A38,x
	SEC
	SBC.w $7900,x
	AND.w #$00FF
	STA.w $7A38,x
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w $7360,x
	CMP.w #$0074
	BNE.b CODE_048EDA
	LDA.w #$20B0
	LDY.b #$54
	BRA.b CODE_048EE1

CODE_048EDA:
	LDY.b $78,x
	LDA.w DATA_048EB1,y
	LDY.b #$54
CODE_048EE1:
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	TYA
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_08867E>>16
	LDA.w #FXCODE_08867E
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	INC.w $0CF9
CODE_048F0E:
	RTS

CODE_048F0F:
	TYX
	LDA.w $7860,x
	AND.w #$001F
	BEQ.b CODE_048F21
	LDA.w #$0040
	STA.w $7542,x
	JSR.w CODE_048E90
CODE_048F21:
	RTS

CODE_048F22:
	TYX
	PLA
	STA.b $00
	JSL.l CODE_04C833
	LDA.b $00
	PHA
	LDA.w $7A96,x
	ORA.w $7542,x
	BNE.b CODE_048F56
	LDY.b $16,x
	BNE.b CODE_048F48
	LDA.b $10
	AND.w #$0018
	CLC
	ADC.w #$0020
	STA.w $7A96,x
	INC.b $16,x
	RTS

CODE_048F48:
	LDA.w #$FE00
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
	STZ.b $16,x
CODE_048F56:
	RTS

CODE_048F57:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_048F8B
	LDA.w $7222,x
	BEQ.b CODE_048F76
	LDA.b $18,x
	CMP.w $7182,x
	BMI.b CODE_048F8B
	STA.w $7182,x
	STZ.w $7222,x
	LDA.w #$0020
	STA.w $7A98,x
	RTS

CODE_048F76:
	LDA.w #$FC00
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
	LDA.w #$0077
	JSL.l CODE_0085D2
	INC.b $76,x
CODE_048F8B:
	RTS

DATA_048F8C:
	dw $FF00,$0100

CODE_048F90:
	TYX
	LDY.w $7223,x
	BMI.b CODE_048FA2
	LDA.w $7860,x
	LSR
	BCC.b CODE_048FCF
	STZ.w $7220,x
	STZ.b $76,x
	RTS

CODE_048FA2:
	LDA.w $7220,x
	BNE.b CODE_048FCF
	LDA.w $70E2,x
	CLC
	ADC.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7182,x
	CLC
	ADC.w #$000F
	JSL.l CODE_0EB8B7
	BEQ.b CODE_048FCF
	STZ.b $18,x
	LDA.w #$0E81
	STA.w $6FA2,x
	LDY.w $7400,x
	LDA.w DATA_048F8C,y
	STA.w $7220,x
CODE_048FCF:
	RTS

CODE_048FD0:
	TYX
	LDA.w $7A96,x
	ORA.w $61AE
	ORA.w $60AC
	BNE.b CODE_048FCF
	LDA.w $7C16,x
	CLC
	ADC.w #$001C
	CMP.w #$0038
	BCS.b CODE_048FF4
	LDA.w $7C18,x
	CLC
	ADC.w #$0021
	CMP.w #$0042
	BCC.b CODE_049063
CODE_048FF4:
	LDX.b #FXCODE_099204>>16
	LDA.w #FXCODE_099204
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$0007
	BPL.b CODE_049063
	LDX.b $12
	LDA.w $7360,x
	JSL.l CODE_03A364
	BCC.b CODE_04906B
	LDA.w $70E2,x
	STA.w $70E2,y
	CLC
	ADC.w #$0008
	STA.w $7CD6,y
	LDA.w $7182,x
	STA.w $7182,y
	SEC
	SBC.w #$0006
	STA.w $7978,y
	CLC
	ADC.w #$000E
	STA.w $7CD8,y
	SEP.b #$20
	LDA.w $77C2,x
	STA.w $7400,y
	REP.b #$20
	LDA.w #$FF00
	STA.w $7222,y
	LDA.w #$0000
	STA.w $7542,y
	LDA.w #$0E80
	STA.w $6FA2,y
	TYX
	LDY.b #$06
	STY.b $76,x
	JSL.l CODE_048A18
	JSL.l CODE_048A00
	LDA.w #$0076
	JSL.l CODE_0085D2
CODE_049063:
	LDX.b $12
	LDA.w #$00C0
	STA.w $7A96,x
CODE_04906B:
	RTS

;---------------------------------------------------------------------------

CODE_04906C:
	LDA.w $7360,x
	CMP.w #$001E
	BEQ.b CODE_049086
	CMP.w #$0133
	BEQ.b CODE_049086
	CMP.w #$012A
	BEQ.b CODE_049086
	CMP.w #$009B
	BEQ.b CODE_049086
	CMP.w #$0074
CODE_049086:
	RTL

;---------------------------------------------------------------------------

CODE_049087:
	JSR.w CODE_048B20
	LDA.w #$0001
	STA.w $7402,x
	JML.l CODE_039F9F

;---------------------------------------------------------------------------

CODE_049094:
	JSR.w CODE_04909B
	JSR.w CODE_0490AF
	RTL

CODE_04909B:
	LDA.w $61D6
	CMP.w #$0087
	BNE.b CODE_0490F0
	LDA.w #$FFFF
	STA.w $7E48
	BRA.b CODE_0490B4

DATA_0490AB:
	dw $0100,$FF00

CODE_0490AF:
	LDA.w $61B2
	BPL.b CODE_0490F0
CODE_0490B4:
	LDA.w #$0010
	STA.w $6F00,x
	LDA.w #$0040
	STA.w $7AF6,x
	LDA.w #$0018
	STA.w $7A96,x
	LDA.w #$0004
	STA.b $16,x
	STZ.b $76,x
	LDA.w #$001E
	STA.w $7360,x
	LDA.w #$0001
	STA.w $7902,x
	STA.w $7D38,x
	ASL
	EOR.w $60C4
	TAY
	LDA.w DATA_0490AB,y
	STA.w $7220,x
	LDA.w #$FE00
	STA.w $7222,x
	STZ.w $0390
CODE_0490F0:
	RTS

;---------------------------------------------------------------------------

CODE_0490F1:
	LDA.w #$0018
	STA.w $7A96,x
	LDA.w #$0004
	STA.b $16,x
	LDA.w $7900,x
	BPL.b CODE_049129
	JSL.l CODE_03AD74
	BCC.b CODE_049132
	LDA.w $7900,x
	EOR.w #$FFFF
	INC
	STA.w $7A36,x
	LDA.w #$2079
	STA.w $7040,x
	LDA.w #$0002
	STA.w $7402,x
	LDY.b #$06
	STY.b $76,x
	JSR.w CODE_04942A
	LDA.w $6020
	BRA.b CODE_049132

CODE_049129:
	LDA.w #$01FF
	STA.w $7A36,x
	LDA.w #$001E
CODE_049132:
	STA.w $7900,x
	JML.l CODE_048A18

;---------------------------------------------------------------------------

DATA_049139:
	dw CODE_048DA0
	dw CODE_048E14
	dw CODE_0491A0
	dw CODE_04924A
	dw CODE_049276
	dw CODE_0492C4
	dw CODE_049243

CODE_049147:
	LDA.w $7722,x
	BMI.b CODE_049150
	JSL.l CODE_03AA52
CODE_049150:
	LDA.w $6F00,x
	CMP.w #$0008
	BNE.b CODE_04916C
	LDY.w $74A2,x
	BPL.b CODE_04916C
	LDA.w $7722,x
	BMI.b CODE_04916C
	LDA.w $7A36,x
	EOR.w #$FFFF
	INC
	STA.w $7900,x
CODE_04916C:
	JSL.l CODE_03AF23
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_049139,x)
	STZ.b $02
	JSR.w CODE_049351
	BCC.b CODE_049194
	JSL.l CODE_03AD74
	BCC.b CODE_049194
	LDA.w #$2079
	STA.w $7040,x
	LDA.w #$0002
	STA.w $7402,x
	STA.b $76,x
	RTL

CODE_049194:
	JML.l CODE_0DC14C

DATA_049198:
	dw $FC00,$0400

DATA_04919C:
	dw $FFF8,$0008

CODE_0491A0:
	TYX
	PLA
	LDA.w $7A36,x
	SEC
	SBC.w #$0020
	CMP.w #$0020
	BPL.b CODE_0491B1
	LDA.w #$0020
CODE_0491B1:
	STA.w $7A36,x
	LDA.w $0036
	AND.w $6084
	BEQ.b CODE_0491C9
	LDA.w $60A8
	STA.b $78,x
	LDY.b #$05
	STY.b $76,x
	JSR.w CODE_049401
	RTL

CODE_0491C9:
	JSR.w CODE_049306
	BCS.b CODE_0491D0
	INC.b $76,x
CODE_0491D0:
	LDA.w $7A36,x
	CMP.w #$0020
	BEQ.b CODE_049242
	LDA.w $7A98,x
	BNE.b CODE_049242
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0005
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDY.w $7400,x
	LDA.w DATA_049198,y
	STA.b $00
	LDA.w DATA_04919C,y
	STA.b $02
	LDA.w #$0107
	JSL.l CODE_03A364
	BCC.b CODE_049242
	LDA.w $70E2,x
	CLC
	ADC.b $02
	STA.w $70E2,y
	LDA.w $7182,x
	CLC
	ADC.w #$0010
	SEC
	SBC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.w $7182,y
	LDA.b $00
	STA.w $7220,y
	LDA.w #$0001
	STA.w $7D38,y
	STA.w $7A38,y
	LDA.w #$FFFF
	STA.w $7862,y
	LDA.w #$0004
	STA.w $7A98,x
	LDA.w #$0045
	JSL.l CODE_0085D2
CODE_049242:
	RTL

CODE_049243:
	TYX
	PLA
	LDA.w #$0020
	BRA.b CODE_04924F

CODE_04924A:
	TYX
	PLA
	LDA.w #$0080
CODE_04924F:
	CLC
	ADC.w $7A36,x
	CMP.w #$01FF
	BMI.b CODE_049269
	LDA.w #$FE9A
	STA.w $7222,x
	LDY.b #$04
	STY.b $76,x
	LDA.w #$01FF
	STA.w $7A36,x
	RTL

CODE_049269:
	STA.w $7A36,x
	JSR.w CODE_049306
	BCC.b CODE_049275
	LDY.b #$02
	STY.b $76,x
CODE_049275:
	RTL

CODE_049276:
	TYX
	PLA
	LDA.w $7A36,x
	SEC
	SBC.w #$0010
	CMP.w #$01FF
	BPL.b CODE_0492B7
	STZ.w $7402,x
	LDA.w #$01FF
	STA.w $7A36,x
	LDA.w #$001E
	STA.w $7900,x
	JSL.l CODE_03AEFD
	LDA.w #$1079
	STA.w $7040,x
	LDA.w #$0018
	STA.w $7A96,x
	LDA.b $10
	AND.w #$0001
	CLC
	ADC.w #$0003
	STA.b $16,x
	STZ.w $7220,x
	STZ.w $7540,x
	STZ.b $76,x
	RTL

CODE_0492B7:
	STA.w $7A36,x
	JSR.w CODE_049306
	BCC.b CODE_0492C3
	LDY.b #$02
	STY.b $76,x
CODE_0492C3:
	RTL

CODE_0492C4:
	TYX
	PLA
	LDA.w $7A36,x
	CLC
	ADC.w #$0060
	CMP.w #$01FF
	BMI.b CODE_0492FB
	LDA.w #$01FF
	STA.w $7A36,x
	LDA.b $78,x
	STA.w $60A8
	LDA.w #$F800
	STA.w $60AA
	LDA.w #$0006
	STA.w $60C0
	LDA.w #$8001
	STA.w $60D2
	INC.w $7E0A
	LDA.w #$FD34
	STA.w $7222,x
	DEC.b $76,x
	RTL

CODE_0492FB:
	STA.w $7A36,x
	JSR.w CODE_049401
	RTL

;---------------------------------------------------------------------------

DATA_049302:
	dw $0166,$FE9A

CODE_049306:
	JSR.w CODE_04942A
	LDA.w $7AF6,x
	BNE.b CODE_04932C
	LDA.w $6020
	PHA
	SEC
	SBC.w $7900,x
	SEC
	SBC.w $72C2,x
	STA.b $02
	PLA
	STA.w $7900,x
	LDA.w $7C16,x
	CLC
	ADC.w #$000E
	CMP.w #$001C
	BCC.b CODE_04932F
CODE_04932C:
	JMP.w CODE_0493F7

CODE_04932F:
	SEC
	SBC.w #$0004
	CMP.w #$0014
	BCC.b CODE_049365
	BPL.b CODE_04933F
	LDA.w #$0080
	BRA.b CODE_049342

CODE_04933F:
	LDA.w #$FF80
CODE_049342:
	STA.w $60A8
	STA.w $60B4
	EOR.w #$FFFF
	INC
	STA.w $7220,x
	BRA.b CODE_049365

CODE_049351:
	LDA.w $7AF6,x
	BNE.b CODE_04932C
	LDA.w $7C16,x
	CLC
	ADC.w #$000E
	CMP.w #$001C
	BCC.b CODE_049365
	JMP.w CODE_0493F7

CODE_049365:
	LDA.w $7900,x
	SEC
	SBC.w #$0008
	STA.b $00
	LDA.w $7182,x
	SEC
	SBC.w #$0008
	SEC
	SBC.w $6090
	CLC
	ADC.b $02
	DEC
	CMP.w $7900,x
	BPL.b CODE_0493F7
	CMP.b $00
	BMI.b CODE_0493C1
	LDY.w $60AB
	BMI.b CODE_0493F7
	LDY.w $0D94
	BNE.b CODE_0493F7
	CPX.w $61B6
	BEQ.b CODE_04939D
	LDY.w $61B6
	BNE.b CODE_0493F7
	STX.w $61B6
CODE_04939D:
	STZ.w $7220,x
	STZ.w $7540,x
	LDA.w $7182,x
	SEC
	SBC.w #$0008
	SEC
	SBC.w $7900,x
	STA.w $6090
	LDY.b #$00
	STY.w $608E
	STZ.w $60AA
	STZ.w $60D4
	INC.w $61B4
	SEC
	RTS

CODE_0493C1:
	DEC
	CMP.w #$FFEC
	BCC.b CODE_0493F7
	LDY.b #$00
	LDA.w $7220,x
	BMI.b CODE_0493D0
	INY
	INY
CODE_0493D0:
	LDA.w DATA_049302,y
	STA.w $7220,x
	EOR.w #$FFFF
	INC
	CMP.w #$8000
	ROR
	STA.w $60A8
	STA.w $60B4
	STZ.w $75E0,x
	LDA.w #$0008
	STA.w $7540,x
	JSL.l CODE_03A858
	LDA.w #$0020
	STA.w $7AF6,x
CODE_0493F7:
	CPX.w $61B6
	BNE.b CODE_0493FF
	STZ.w $61B6
CODE_0493FF:
	CLC
	RTS

;---------------------------------------------------------------------------

CODE_049401:
	JSR.w CODE_04942A
	STZ.w $7220,x
	STZ.w $7540,x
	LDA.w $7182,x
	SEC
	SBC.w #$0008
	SEC
	SBC.w $6020
	STA.w $6090
	LDY.b #$00
	STY.w $608E
	STZ.w $60A8
	STZ.w $60B4
	STZ.w $60AA
	INC.w $61B4
	RTS

;---------------------------------------------------------------------------

CODE_04942A:
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	SEC
	SBC.w #$0100
	BMI.b CODE_049439
	LSR
	LSR
	LSR
CODE_049439:
	EOR.w #$FFFF
	INC
	CLC
	ADC.w #$0100
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0F00
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0008
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	ASL
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w #$7020
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_08D76B>>16
	LDA.w #FXCODE_08D76B
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	INC.w $0CF9
	RTS

;---------------------------------------------------------------------------

CODE_049481:
	JSL.l CODE_048A18
	LDA.w #$0020
	STA.w $7042,x
	RTL

;---------------------------------------------------------------------------

DATA_04948C:
	dw CODE_04951E
	dw CODE_04958F

CODE_049490:
	JSR.w CODE_0494EB
	LDA.w $6F00,x
	CMP.w #$0008
	BNE.b CODE_0494D2
	JSR.w CODE_0496A6
	LDA.w $7902,x
	PHA
	LDA.w $74A0,x
	PHA
	STZ.w $6F00,x
	TXY
	LDA.w #$001E
	JSL.l CODE_03A366
	PLA
	SEP.b #$20
	STA.w $74A0,x
	REP.b #$20
	PLA
	STA.w $7902,x
	AND.w #$00FE
	ORA.w #$0020
	STA.w $7042,x
	LDA.w #$0020
	STA.w $7AF6,x
	LDA.w #$0008
	STA.w $6F00,x
CODE_0494D2:
	JSL.l CODE_03AF23
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_04948C,x)
	JSR.w CODE_0495DD
	RTL

DATA_0494E2:
	db $10,$10,$10,$10,$08,$20,$20,$FF,$FF

CODE_0494EB:
	LDY.w $7402,x
	LDA.w DATA_0494E2,y
	TAY
	BMI.b CODE_04950A
	REP.b #$10
	TYA
	CLC
	ADC.w $7362,x
	TAY
	LDA.w $6005,y
	AND.w #$FFF1
	ORA.w $7902,x
	STA.w $6005,y
	SEP.b #$10
CODE_04950A:
	RTS

DATA_04950B:
	dw $FFA7,$0059,$FEF4,$010C

DATA_049513:
	dw $0005,$000B

DATA_049517:
	db $05,$06,$07,$08,$07,$06,$05

CODE_04951E:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_049553
	LDA.w #$0004
	STA.w $7A98,x
	INC.b $18,x
	LDY.b $18,x
	LDA.w DATA_049517,y
	AND.w #$00FF
	STA.w $7402,x
	CPY.b #$03
	BNE.b CODE_049554
	LDA.w #$0040
	STA.w $7A98,x
	LDY.w $77C2,x
	LDA.b $10
	BIT.w #$0001
	BNE.b CODE_04954F
	AND.w #$0002
	TAY
CODE_04954F:
	TYA
	STA.w $7400,x
CODE_049553:
	RTS

CODE_049554:
	CPY.b #$07
	BNE.b CODE_049587
	LDY.w $7400,x
	LDA.w DATA_04950B,y
	STA.w $75E0,x
	TYA
	LSR
	AND.w #$FFFE
	TAY
	LDA.w DATA_049513,y
	STA.w $7540,x
	LDA.b $10
	AND.w #$003F
	CLC
	ADC.w #$0040
	STA.w $7A96,x
	LDA.w #$0003
	STA.w $7402,x
	INC
	STA.w $7A98,x
	STZ.b $18,x
	INC.b $76,x
CODE_049587:
	RTS

DATA_049588:
	db $03,$04,$03,$02,$00,$01,$02

CODE_04958F:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_0495DC
	LDA.w #$0004
	LDY.w $7540,x
	CPY.b #$05
	BEQ.b CODE_0495A0
	LSR
CODE_0495A0:
	STA.w $7A98,x
	INC.b $18,x
	LDY.b $18,x
	CPY.b #$07
	BMI.b CODE_0495AF
	STZ.b $18,x
	LDY.b #$00
CODE_0495AF:
	LDA.w $7402,x
	CMP.w #$0003
	BNE.b CODE_0495D3
	LDA.w $7A96,x
	BNE.b CODE_0495D3
	LDA.w #$0005
	STA.w $7402,x
	LDA.w #$0004
	STA.w $7A98,x
	STZ.b $18,x
	STZ.w $7540,x
	STZ.w $7220,x
	STZ.b $76,x
	RTS

CODE_0495D3:
	LDA.w DATA_049588,y
	AND.w #$00FF
	STA.w $7402,x
CODE_0495DC:
	RTS

CODE_0495DD:
	LDY.w $7D36,x
	BPL.b CODE_04963F
	LDA.w $7C18,x
	SEC
	SBC.w $6122
	SEC
	SBC.w $7BB8,x
	CMP.w #$FFF8
	BCC.b CODE_04963A
	LDY.w $60AB
	BMI.b CODE_0495DC
	LDY.w $60C0
	BEQ.b CODE_0495DC
	LDA.w #$FC00
	STA.w $60AA
	LDA.w #$0006
	STA.w $60C0
	LDA.w #$8001
	STA.w $60D2
	JSR.w CODE_0496A6
	LDA.w $7902,x
	PHA
	LDA.w $74A0,x
	PHA
	STZ.w $6F00,x
	TXY
	LDA.w #$001E
	JSL.l CODE_03A34E
	PLA
	SEP.b #$20
	STA.w $74A0,x
	REP.b #$20
	PLA
	STA.w $7902,x
	AND.w #$FFFE
	ORA.w #$0020
	STA.w $7042,x
	RTS

CODE_04963A:
	JSL.l CODE_03A858
	RTS

CODE_04963F:
	DEY
	BMI.b CODE_0496A5
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_0496A5
	LDA.w $7D38,y
	BEQ.b CODE_0496A5
	LDA.w $7220,y
	PHP
	LDA.w #$FE00
	PLP
	BMI.b CODE_04965C
	LDA.w #$0200
CODE_04965C:
	STA.b $0E
	TYX
	JSL.l CODE_03B24B
	BCC.b CODE_04966C
	LDA.w #$4E00
	STA.w $6FA0,x
	RTS

CODE_04966C:
	JSR.w CODE_0496A6
	LDA.w $7902,x
	PHA
	LDA.w $74A0,x
	PHA
	STZ.w $6F00,x
	TXY
	LDA.w #$001E
	JSL.l CODE_03A366
	PLA
	SEP.b #$20
	STA.w $74A0,x
	REP.b #$20
	PLA
	STA.w $7902,x
	AND.w #$FFFE
	ORA.w #$0020
	STA.w $7042,x
	LDA.b $0E
	STA.w $7220,x
	INC.w $7D38,x
	LDA.w #$0020
	STA.w $7AF6,x
CODE_0496A5:
	RTS

CODE_0496A6:
	LDA.w #$0210
	JSL.l CODE_008B21
	LDA.w $7CD6,x
	STA.w $70A2,y
	LDA.w $7CD8,x
	STA.w $7142,y
	LDA.w #$0001
	STA.w $7782,y
	LDA.w #$0017
	STA.w $73C2,y
	LDA.w #$0022
	STA.w $7002,y
	RTS

;---------------------------------------------------------------------------

CODE_0496CC:
	LDA.w $7182,x
	STA.w $7A36,x
	SEC
	SBC.w #$0020
	STA.w $7182,x
	LDA.w #$0010
	STA.w $7900,x
	LDA.w $70E2,x
	STA.w $7902,x
	RTL

;---------------------------------------------------------------------------

DATA_0496E6:
	dw CODE_04978A
	dw CODE_0497AD
	dw CODE_0497C6
	dw CODE_049896
	dw CODE_049991
	dw CODE_0499F2
	dw CODE_049A11
	dw CODE_049A21
	dw CODE_049A45
	dw CODE_049A61

CODE_0496FA:
	JSL.l CODE_03AF23
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_0496E6,x)
	JSR.w CODE_04970A
	RTL

CODE_04970A:
	LDY.w $74A2,x
	BMI.b CODE_049755
	LDY.b $76,x
	CPY.b #$04
	BMI.b CODE_049719
	CPY.b #$07
	BMI.b CODE_049755
CODE_049719:
	LDY.w $7D36,x
	BEQ.b CODE_049755
	BPL.b CODE_049756
	LDA.w $7C18,x
	SEC
	SBC.w $6122
	SEC
	SBC.w $7BB8,x
	CMP.w #$FFF8
	BCC.b CODE_049751
	LDY.w $60AB
	BMI.b CODE_049755
	LDY.w $60C0
	BEQ.b CODE_049755
	LDA.w #$FA00
	STA.w $60AA
	LDA.w #$0006
	STA.w $60C0
	LDA.w #$8001
	STA.w $60D2
	STZ.w $60D4
	BRA.b CODE_049770

CODE_049751:
	JSL.l CODE_03A858
CODE_049755:
	RTS

CODE_049756:
	LDA.w $6EFF,y
	CMP.w #$0010
	BNE.b CODE_049789
	LDA.w $7D37,y
	BEQ.b CODE_049789
	DEY
	TYX
	JSL.l CODE_03B25B
	LDY.w $7402,x
	CPY.b #$02
	BEQ.b CODE_049789
CODE_049770:
	STZ.w $7220,x
	STZ.w $7222,x
	STZ.w $7542,x
	LDA.w #$0040
	STA.w $7A96,x
	LDA.w #$0002
	STA.w $7402,x
	LDY.b #$07
	STY.b $76,x
CODE_049789:
	RTS

CODE_04978A:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_0497A5
	LDA.w $7C16,x
	CLC
	ADC.w #$0080
	CMP.w #$0100
	BCS.b CODE_0497A5
	LDA.w #$0400
	STA.w $7222,x
	INC.b $76,x
CODE_0497A4:
	RTS

CODE_0497A5:
	JSL.l CODE_03A2F8
	BCC.b CODE_0497A4
	PLA
	RTL

CODE_0497AD:
	TYX
	JSR.w CODE_049943
	BPL.b CODE_0497BD
	LDA.w #$0040
	STA.w $7A96,x
	STZ.b $16,x
	INC.b $76,x
CODE_0497BD:
	RTS

DATA_0497BE:
	dw $0020,$FFE0

DATA_0497C2:
	dw $FF00,$0100

CODE_0497C6:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_0497BD
	LDY.b #$00
	LDA.w $60A8
	BMI.b CODE_0497E0
	BNE.b CODE_0497DE
	LDA.w $60C4
	EOR.w #$0002
	TAY
	BRA.b CODE_0497E0

CODE_0497DE:
	INY
	INY
CODE_0497E0:
	LDA.w $608C
	CLC
	ADC.w DATA_0497BE,y
	STA.w $70E2,x
	LDA.w $7900,x
	LSR
	CLC
	ADC.w $70E2,x
	SEC
	SBC.w $7902,x
	STA.b $02
	CMP.w $7900,x
	BCC.b CODE_049831
	BMI.b CODE_049808
	LDA.w $7902,x
	CLC
	ADC.w $7900,x
	BRA.b CODE_04980F

CODE_049808:
	LDA.w $7902,x
	SEC
	SBC.w $7900,x
CODE_04980F:
	STA.w $70E2,x
	LDY.w $77C2,x
	LDA.b $00
	CLC
	ADC.w #$0100
	STA.b $00
	LDA.b $02
	CLC
	ADC.w #$0080
	CMP.b $00
	BCC.b CODE_049831
	STZ.w $7402,x
	LDA.w #$0008
	STA.b $76,x
	BRA.b CODE_04987D

CODE_049831:
	LDA.w $7C18,x
	CMP.w #$0040
	BMI.b CODE_049858
	INC.b $16,x
	LDA.w $7976,x
	CMP.w #$0080
	BMI.b CODE_04988D
	STZ.w $7402,x
	LDA.w #$0060
	STA.w $7A96,x
	LDY.b #$09
	STY.b $76,x
	LDY.w $77C2,x
	LDA.w #$FF00
	BRA.b CODE_049880

CODE_049858:
	LDA.w DATA_0497C2,y
	STA.w $7220,x
	LDA.w #$0020
	STA.w $7542,x
	LDA.w #$0340
	STA.w $75E2,x
	LDA.w #$0001
	STA.w $7402,x
	STZ.b $18,x
	PHY
	LDA.w #$0083
	JSL.l CODE_0085D2
	PLY
	INC.b $76,x
CODE_04987D:
	LDA.w #$FCC0
CODE_049880:
	STA.w $7222,x
	TYA
	STA.w $7400,x
	LDA.w #$0002
	STA.w $74A2,x
CODE_04988D:
	RTS

DATA_04988E:
	dw $0020,$FFE0

DATA_049892:
	dw $0180,$FE80

CODE_049896:
	TYX
	LDY.w $7223,x
	BMI.b CODE_0498A5
	LDA.w #$0002
	STA.w $7402,x
	JMP.w CODE_049931

CODE_0498A5:
	JSR.w CODE_049AA4
	LDA.w $7400,x
	DEC
	EOR.w $7C16,x
	BPL.b CODE_0498F0
	LDA.w $7C16,x
	CLC
	ADC.w #$0010
	CMP.w #$0020
	BCS.b CODE_0498F0
	LDA.w $7C18,x
	CLC
	ADC.w #$0030
	CMP.w #$0040
	BCS.b CODE_0498F0
	JSL.l CODE_04F74A
	LDA.w #$001A
	STA.w $60AC
	LDA.w #$006B
	STA.w $60BE
	STA.w $0B48
	LDA.w $7C16,x
	STA.b $78,x
	LDA.w $7182,x
	SEC
	SBC.w $6090
	STA.w $7A38,x
	INC.b $18,x
	INC.b $76,x
	RTS

CODE_0498F0:
	LDA.w $7400,x
	TAY
	DEC
	EOR.w $7C16,x
	BPL.b CODE_049931
	LDA.w $7C16,x
	CLC
	ADC.w #$0012
	CMP.w #$0024
	BCS.b CODE_049931
	LDA.w $7C18,x
	CLC
	ADC.w #$0018
	CMP.w #$0030
	BCS.b CODE_049931
	LDA.w DATA_04988E,y
	CLC
	ADC.w $60A8
	STA.w $60A8
	STA.w $60B4
	CLC
	ADC.w #$0180
	CMP.w #$0300
	BCC.b CODE_049931
	LDA.w DATA_049892,y
	STA.w $60A8
	STA.w $60B4
CODE_049931:
	JSR.w CODE_049943
	BPL.b CODE_049942
	LDA.w #$00A0
	STA.w $7A96,x
	STZ.b $16,x
	LDY.b #$02
	STY.b $76,x
CODE_049942:
	RTS

CODE_049943:
	LDA.w $7A36,x
	CMP.w $7182,x
	BPL.b CODE_049990
	STA.w $7182,x
	LDA.w #$01CE
	JSL.l CODE_008B21
	LDA.w #$0001
	STA.w $7E4C,y
	LDA.w #$FE00
	STA.w $71E2,y
	LDA.w #$0012
	STA.w $7782,y
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	SEC
	SBC.w #$0010
	STA.w $7142,y
	STZ.w $7220,x
	STZ.w $7222,x
	STZ.w $7542,x
	STZ.w $75E2,x
	LDA.w #$005F
	JSL.l CODE_0085D2
	LDA.w #$FFFF
	STA.w $74A2,x
CODE_049990:
	RTS

CODE_049991:
	TYX
	LDA.w $70E2,x
	STA.b $00
	LDA.w $7182,x
	STA.b $02
	LDA.b $78,x
	STA.b $04
	LDA.w $7A38,x
	STA.b $06
	JSL.l CODE_049B42
	STA.b $0C
	LDA.b $04
	STA.b $78,x
	LDA.b $06
	STA.w $7A38,x
	LDA.b $08
	STA.w $608C
	LDA.b $0A
	STA.w $6090
	LDA.b $0C
	BNE.b CODE_0499D2
	STZ.w $7402,x
	LDA.w $7182,x
	CLC
	ADC.w #$0020
	STA.w $6090
	INC.b $76,x
	RTS

CODE_0499D2:
	JSR.w CODE_049943
	BPL.b CODE_0499F1
	LDA.w $70E2,x
	STA.w $608C
	LDA.w $7182,x
	CLC
	ADC.w #$0020
	STA.w $6090
	LDA.w #$0020
	STA.w $7A98,x
	LDY.b #$06
	STY.b $76,x
CODE_0499F1:
	RTS

CODE_0499F2:
	TYX
	LDA.w $70E2,x
	STA.w $608C
	LDA.w $7182,x
	CLC
	ADC.w #$0020
	STA.w $6090
	JSR.w CODE_049943
	BPL.b CODE_049A10
	LDA.w #$0020
	STA.w $7A98,x
	INC.b $76,x
CODE_049A10:
	RTS

CODE_049A11:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_049A10
	REP.b #$10
	JSL.l CODE_04AC9C
	SEP.b #$10
	PLA
	RTL

CODE_049A21:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_049A44
	LDA.w #$0020
	STA.w $7542,x
	LDA.w #$0340
	STA.w $75E2,x
	JSR.w CODE_049943
	BPL.b CODE_049A44
	LDA.w #$00A0
	STA.w $7A96,x
	STZ.b $16,x
	LDY.b #$02
	STY.b $76,x
CODE_049A44:
	RTS

CODE_049A45:
	TYX
	LDA.w $7A36,x
	SEC
	SBC.w #$0020
	CMP.w $7182,x
	BMI.b CODE_049A60
	STA.w $7182,x
	STZ.w $7222,x
	LDA.w #$0040
	STA.w $7A96,x
	STZ.b $76,x
CODE_049A60:
	RTS

CODE_049A61:
	TYX
	LDA.w $7A36,x
	SEC
	SBC.w #$0008
	CMP.w $7182,x
	BMI.b CODE_049A83
	STA.w $7182,x
	STZ.w $7222,x
	LDA.w $7A96,x
	BNE.b CODE_049A83
	LDA.w #$0400
	STA.w $7222,x
	LDY.b #$01
	STY.b $76,x
CODE_049A83:
	RTS

;---------------------------------------------------------------------------

DATA_049A84:
	dw $0028,$0030,$0038,$003F,$FFD8,$FFD0,$FFC8,$FFC1

DATA_049A94:
	dw $002C,$0028,$0034,$0000,$0008,$0010,$0018,$0020

CODE_049AA4:
	LDA.b $10
	AND.w #$0003
	STA.b $00
	LDA.w $7400,x
	ASL
	CLC
	ADC.b $00
	ASL
	TAY
	LDA.w DATA_049A84,y
	STA.b $00
	LDA.b $11
	AND.w #$000E
	TAY
	LDA.w DATA_049A94,y
	STA.b $02
	LDA.w #$01CF
	JSL.l CODE_008B21
	LDA.w #$0010
	STA.w $7782,y
	LDA.w $70E2,x
	SEC
	SBC.b $00
	STA.w $70A2,y
	LDA.w $7182,x
	SEC
	SBC.b $02
	STA.w $7142,y
	TXA
	STA.w $7E4C,y
	LDA.b $00
	STA.w $7E8C,y
	LDA.b $02
	STA.w $7E4E,y
	RTS

;---------------------------------------------------------------------------

DATA_049AF2:
	db $00,$00,$01,$02,$03,$04,$05,$05,$06,$07,$08,$09,$0A,$0B,$0B,$0C
	db $0D,$0E,$0F,$10,$11,$12,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B
	db $1B,$1C,$1D,$1E,$1F,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A
	db $2B,$2C,$2D,$2D,$2E,$2F,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39
	db $3A,$3B,$3C,$3D,$3E,$3F,$40,$41,$42,$43,$44,$45,$46,$47,$48,$49

CODE_049B42:
	PHB
	PHK
	PLB
	LDA.b $00
	SEC
	SBC.b $04
	STA.b $08
	LDA.b $02
	SEC
	SBC.b $06
	STA.b $0A
	LDA.b $04
	BEQ.b CODE_049B91
	BMI.b CODE_049B62
	TAY
	LDA.w DATA_049AF2,y
	AND.w #$00FF
	BRA.b CODE_049B71

CODE_049B62:
	EOR.w #$FFFF
	INC
	TAY
	LDA.w DATA_049AF2,y
	AND.w #$00FF
	EOR.w #$FFFF
	INC
CODE_049B71:
	STA.b $04
	LDA.b $06
CODE_049B75:
	BMI.b CODE_049B80
	TAY
	LDA.w DATA_049AF2,y
	AND.w #$00FF
	BRA.b CODE_049B9B

CODE_049B80:
	EOR.w #$FFFF
	INC
	TAY
	LDA.w DATA_049AF2,y
	AND.w #$00FF
	EOR.w #$FFFF
	INC
	BRA.b CODE_049B9B

CODE_049B91:
	LDA.b $06
	BNE.b CODE_049B75
	ORA.b $04
	BNE.b CODE_049B9D
	PLB
	RTL

CODE_049B9B:
	STA.b $06
CODE_049B9D:
	LDA.w #$0001
	PLB
	RTL

;---------------------------------------------------------------------------

DATA_049BA2:
	dw $FFC0,$0040

DATA_049BA6:
	dw $FF80,$0080

CODE_049BAA:
	LDA.w $7900,x
	CMP.w $7902,x
	BNE.b CODE_049BCA
	CMP.w #$FFFF
	BNE.b CODE_049BCA
CODE_049BB7:
	LDY.w $7400,x
	LDA.w DATA_049BA6,y
	STA.w $7220,x
	LDA.w #$0040
	STA.w $7542,x
	INC.b $76,x
	BRA.b CODE_049BFB

CODE_049BCA:
	LDA.w $70E2,x
	AND.w #$0010
	BNE.b CODE_049BB7
	LDA.w #$00A1
	JSL.l CODE_03A364
	BCC.b CODE_049BB7
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
	SEC
	SBC.w #$000A
	STA.w $7182,x
	LDA.w #$0000
	STA.w $7900,y
	STA.w $7902,y
	TXA
	STA.w $7A38,y
CODE_049BFB:
	STZ.w $7900,x
	STZ.w $7902,x
	RTL

;---------------------------------------------------------------------------

DATA_049C02:
	db $47,$09,$07,$00

DATA_049C06:
	dw CODE_048000
	dw CODE_049C40

CODE_049C0A:
	LDY.b #$00
	LDA.w $7D38,x
	ORA.w $7D96,x
	BEQ.b CODE_049C1F
	LDA.w #$FFFF
	STA.w $7900,x
	STA.w $7902,x
	INY
	INY
CODE_049C1F:
	LDA.w DATA_049C02,y
	STA.w $6FA2,x
	JSL.l CODE_03AF23
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_049C06,x)
	LDY.w $7D36,x
	DEY
	BPL.b CODE_049C3C
	JSL.l CODE_03A5B7
	RTL

CODE_049C3C:
	JML.l CODE_0DC14C

CODE_049C40:
	TYX
	LDY.w $7D36,x
	DEY
	BMI.b CODE_049C87
	LDA.w $7360,y
	CMP.w #$00A1
	BNE.b CODE_049C87
	LDA.w $7A38,y
	BNE.b CODE_049C87
	LDA.w $7D38,y
	BNE.b CODE_049C87
	LDA.w $70E2,x
	SEC
	SBC.w $70E2,y
	STA.w $7900,y
	LDA.w $7182,x
	SEC
	SBC.w $7182,y
	CLC
	ADC.w #$000A
	STA.w $7902,y
	LDA.w #$0000
	STA.w $7D38,y
	TXA
	STA.w $7A38,y
	STZ.w $7220,x
	STZ.w $7222,x
	STZ.w $7542,x
	STZ.b $76,x
	RTS

CODE_049C87:
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_098E44>>16
	LDA.w #FXCODE_098E44
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	BMI.b CODE_049CB2
	STZ.w $7400,x
	LDA.w $70E2,y
	CMP.w $70E2,x
	BMI.b CODE_049CAC
	LDA.w #$0002
	STA.w $7400,x
CODE_049CAC:
	LDA.w #$0087
	STA.w $6FA2,x
CODE_049CB2:
	LDY.w $7400,x
	LDA.w DATA_049BA6,y
	STA.w $7220,x
	LDA.w $7220,x
	BPL.b CODE_049CC4
	EOR.w #$FFFF
	INC
CODE_049CC4:
	CLC
	ADC.w $7A36,x
	CMP.w #$0200
	BMI.b CODE_049CDC
	PHA
	LDA.w $7402,x
	EOR.w #$0001
	STA.w $7402,x
	PLA
	SEC
	SBC.w #$0200
CODE_049CDC:
	STA.w $7A36,x
	RTS

;---------------------------------------------------------------------------

CODE_049CE0:
	RTL

;---------------------------------------------------------------------------

DATA_049CE1:
	dw $FA00,$FB80

CODE_049CE5:
	STZ.w $7400,x
	LDA.w $6F00,x
	CMP.w #$0008
	BNE.b CODE_049CFC
	LDY.w $7A38,x
	BEQ.b CODE_049CFC
	STZ.w $7A38,x
	JSR.w CODE_049DFC
	RTL

CODE_049CFC:
	JSL.l CODE_03AF23
	JSL.l CODE_03A2C7
	BCC.b CODE_049D12
	LDY.w $7A38,x
	BEQ.b CODE_049D0E
	JSR.w CODE_049DFC
CODE_049D0E:
	JML.l CODE_03A32E

CODE_049D12:
	LDY.w $7A38,x
	BNE.b CODE_049D26
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_049D25
	STZ.w $7402,x
	STZ.w $7220,x
CODE_049D25:
	RTL

CODE_049D26:
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_049D36
	LDA.w $7360,y
	CMP.w #$0031
	BEQ.b CODE_049D3A
CODE_049D36:
	STZ.w $7A38,x
	RTL

CODE_049D3A:
	LDA.w $7D96,y
	BEQ.b CODE_049D49
	STZ.w $7A38,x
	LDA.w #$0001
	STA.w $79D6,y
	RTL

CODE_049D49:
	LDA.w $7900,x
	ORA.w $7902,x
	STA.b $02
	LDA.w #$000C
	STA.b $00
	LDA.w #$0001
	STA.w $7402,x
	LDA.w $7222,x
	BMI.b CODE_049DB1
	LDA.w #$000A
	STA.b $00
	STZ.w $7402,x
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_049DB1
	LDA.w $7AF8,x
	BEQ.b CODE_049D7B
	DEC
	BEQ.b CODE_049D86
	BRA.b CODE_049DB1

CODE_049D7B:
	STZ.w $7220,x
	LDA.w #$0010
	STA.w $7AF8,x
	BRA.b CODE_049DB1

CODE_049D86:
	PHY
	LDY.b $02
	BNE.b CODE_049DB0
	LDY.w $77C2,x
	LDA.w DATA_049BA2,y
	STA.w $7220,x
	LDY.b #$00
	LDA.b $10
	AND.w #$0003
	BEQ.b CODE_049DA8
	INC.b $76,x
	LDA.b $76,x
	CMP.w #$0003
	BEQ.b CODE_049DA8
	INY
	INY
CODE_049DA8:
	STZ.b $76,x
	LDA.w DATA_049CE1,y
	STA.w $7222,x
CODE_049DB0:
	PLY
CODE_049DB1:
	LDA.w $70E2,x
	CLC
	ADC.w $7900,x
	STA.w $70E2,y
	LDA.w $7182,x
	SEC
	SBC.b $00
	CLC
	ADC.w $7902,x
	STA.w $7182,y
	LDA.w $7402,x
	STA.w $7402,y
	PHY
	LDY.b #$00
	LDA.w $7220,x
	BMI.b CODE_049DD8
	INY
	INY
CODE_049DD8:
	TYA
	PLY
	STA.w $7400,y
	LDA.w $7900,x
	BEQ.b CODE_049DEC
	BPL.b CODE_049DE9
	INC.w $7900,x
	BRA.b CODE_049DEC

CODE_049DE9:
	DEC.w $7900,x
CODE_049DEC:
	LDA.w $7902,x
	BEQ.b CODE_049DFB
	BPL.b CODE_049DF8
	INC.w $7902,x
	BRA.b CODE_049DFB

CODE_049DF8:
	DEC.w $7902,x
CODE_049DFB:
	RTL

CODE_049DFC:
	LDA.w #$0001
	STA.w $79D6,y
	LDA.w #$0040
	STA.w $7542,y
	LDA.w $7400,y
	PHY
	TAY
	LDA.w DATA_049BA6,y
	PLY
	STA.w $7220,y
	RTS

;---------------------------------------------------------------------------

CODE_049E15:
	LDA.w #$0008
	STA.w $7900,x
	LDA.w #$0100
	STA.w $7A38,x
	RTL

;---------------------------------------------------------------------------

DATA_049E22:
	dw CODE_049E7E
	dw CODE_049EAF
	dw CODE_049F6E
	dw CODE_049F9B
	dw CODE_049FCA
	dw CODE_049FF9
	dw CODE_04A03C

CODE_049E30:
	JSL.l CODE_03AF23
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_049E22,x)
	LDA.b $76,x
	CMP.w #$0002
	BEQ.b CODE_049E4C
	LDA.w $77C2,x
	AND.w #$00FF
	STA.w $7400,x
CODE_049E4C:
	LDA.w $7860,x
	BIT.w #$0002
	BEQ.b CODE_049E61
	LDA.w $7182,x
	SEC
	SBC.w $72C2,x
	STA.w $7182,x
	STZ.w $7222,x
CODE_049E61:
	LDA.b $16,x
	CMP.w #$0006
	BNE.b CODE_049E78
	STZ.b $16,x
	INC.w $7402,x
	LDA.w $7402,x
	CMP.w #$0003
	BNE.b CODE_049E78
	STZ.w $7402,x
CODE_049E78:
	INC.b $16,x
	JML.l CODE_0DC14C

CODE_049E7E:
	TYX
	STZ.w $75E0,x
	STZ.w $7540,x
	LDA.w $7C16,x
	CLC
	ADC.w #$0040
	CMP.w #$0080
	BCS.b CODE_049EAE
	LDA.w #$0004
	STA.w $7540,x
	LDA.b $10
	AND.w #$003F
	CLC
	ADC.w #$0060
	LDY.w $7C17,x
	BMI.b CODE_049EA9
	EOR.w #$FFFF
	INC
CODE_049EA9:
	STA.w $75E0,x
	INC.b $76,x
CODE_049EAE:
	RTS

CODE_049EAF:
	TYX
	JSR.w CODE_04A085
	LDA.b $10
	AND.w #$003F
	LDY.w $7C19,x
	BMI.b CODE_049EC1
	EOR.w #$FFFF
	INC
CODE_049EC1:
	CLC
	ADC.w $7A38,x
	STA.w $7222,x
	LDA.b $11
	AND.w #$001F
	CLC
	ADC.w #$0060
	LDY.w $7C16,x
	BMI.b CODE_049EDA
	EOR.w #$FFFF
	INC
CODE_049EDA:
	STA.w $75E0,x
	LDA.w $7C16,x
	CLC
	ADC.w #$0060
	CMP.w #$00C0
	BCC.b CODE_049EF4
	STZ.w $75E0,x
	LDA.w #$0040
	STA.w $75E2,x
	STZ.b $76,x
CODE_049EF4:
	LDY.w $7D36,x
	BPL.b CODE_049F6D
	LDA.w $7E48
	AND.w #$00FF
	ORA.w $0CD0
	ORA.w $61D6
	BNE.b CODE_049F6D
	LDA.w $61B2
	BPL.b CODE_049F25
	AND.w #$0FFF
	STA.w $61B2
	STZ.b $18
	LDA.w #$0006
	STA.b $16
	LDA.w #$0010
	STA.w $6F00
	LDA.w #$0040
	STA.w $7AF8
CODE_049F25:
	LDA.w #$000A
	STA.w $6F00,x
	TXA
	STA.w $7E48
	LDA.w #$2881
	STA.w $6FA2,x
	LDA.w #$0904
	STA.w $7040,x
	LDA.w #$0020
	STA.w $0CC8
	STZ.w $7540,x
	STZ.w $75E0,x
	LDA.w #$0260
	STA.w $7AF6,x
	LDA.w #$003E
	STA.w $7A96,x
	LDA.w #$0008
	STA.w $7A98,x
	LDA.w #$0010
	STA.w $7AF8,x
	LDA.w #$FFFF
	STA.w $0CD0
	LDA.w #$8000
	STA.w $0390
	STZ.b $76,x
CODE_049F6D:
	RTS

CODE_049F6E:
	TYX
	JSR.w CODE_04A085
	LDA.w $7A38,x
	BPL.b CODE_049F7B
	EOR.w #$FFFF
	INC
CODE_049F7B:
	LSR
	STA.w $7222,x
	LDA.w $7220,x
	CLC
	ADC.w #$0040
	CMP.w #$0080
	BCC.b CODE_049F95
	LDA.w $75E0,x
	EOR.w #$FFFF
	INC
	STA.w $75E0,x
CODE_049F95:
	LDA.w $7A96,x
	BNE.b CODE_049FA1
	RTS

CODE_049F9B:
	TYX
	LDA.w $7A96,x
	BEQ.b CODE_049FBA
CODE_049FA1:
	LDA.w $7A98,x
	BNE.b CODE_049FB9
	LDA.w #$0008
	STA.w $7A98,x
	LDA.w $6116
	EOR.w #$0002
	STA.w $6116
	JSL.l CODE_04FB41
CODE_049FB9:
	RTS

CODE_049FBA:
	LDY.w $6F00,x
	CPY.b #$10
	BEQ.b CODE_049FC7
	LDA.w #$FFFF
	STA.w $61EC
CODE_049FC7:
	INC.b $76,x
	RTS

CODE_049FCA:
	TYX
	LDA.w $7AF6,x
	BNE.b CODE_049FE8
	LDA.b $10
	AND.w #$003F
	CLC
	ADC.w #$0060
	LDY.w $7C16,x
	BMI.b CODE_049FE2
	EOR.w #$FFFF
	INC
CODE_049FE2:
	STA.w $75E0,x
	STZ.b $76,x
	RTS

CODE_049FE8:
	JSR.w CODE_04A085
	LDA.w $7A38,x
	BMI.b CODE_049FF4
	EOR.w #$FFFF
	INC
CODE_049FF4:
	ASL
	STA.w $7222,x
	RTS

CODE_049FF9:
	TYX
	LDA.w #$0004
	STA.w $7540,x
	LDA.w #$0080
	STA.w $75E0,x
	TXA
	AND.w #$000F
	LSR
	LSR
	LSR
	BEQ.b CODE_04A015
	LDA.w #$FF80
	STA.w $75E0,x
CODE_04A015:
	LDA.w #$0040
	STA.w $75E2,x
	LDA.w #$0008
	STA.w $7900,x
	LDA.b $10
	AND.w #$003F
	CLC
	ADC.w #$0060
	STA.w $7A38,x
	LDA.w #$0004
	STA.w $7542,x
	LDA.w #$0080
	STA.w $7A96,x
	INC.b $76,x
	RTS

CODE_04A03C:
	TYX
	JSR.w CODE_04A085
	LDA.w $7A38,x
	BPL.b CODE_04A049
	EOR.w #$FFFF
	INC
CODE_04A049:
	STA.b $02
	EOR.w #$FFFF
	INC
	STA.w $7222,x
	TXA
	AND.w #$000F
	LSR
	LSR
	LSR
	BCS.b CODE_04A066
	LDA.b $02
	LSR
	LSR
	EOR.w #$FFFF
	INC
	STA.w $7222,x
CODE_04A066:
	LDA.w $7A96,x
	BNE.b CODE_04A084
	LDA.b $10
	AND.w #$003F
	CLC
	ADC.w #$0060
	LDA.w $7C16,x
	BMI.b CODE_04A07D
	EOR.w #$FFFF
	INC
CODE_04A07D:
	STA.w $75E0,x
	LDY.b #$01
	STY.b $76,x
CODE_04A084:
	RTS

CODE_04A085:
	LDA.w $7A38,x
	PHA
	CLC
	ADC.w #$0100
	CMP.w #$0200
	BCC.b CODE_04A09C
	LDA.w $7900,x
	EOR.w #$FFFF
	INC
	STA.w $7900,x
CODE_04A09C:
	PLA
	CLC
	ADC.w $7900,x
	STA.w $7A38,x
	RTS

;---------------------------------------------------------------------------

DATA_04A0A5:
	dw CODE_049F9B
	dw CODE_04A0B8
	dw CODE_04A128

CODE_04A0AB:
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_04A0A5,x)
	RTL

DATA_04A0B4:
	dw $0040,$FFC0

CODE_04A0B8:
	TYX
	LDY.w $61B3
	BMI.b CODE_04A0C3
	LDA.w $7AF6,x
	BNE.b CODE_04A0D1
CODE_04A0C3:
	LDY.w $77C2,x
	LDA.w DATA_04A0B4,y
	STA.w $75E0,x
	LDA.w #$0079
	BRA.b CODE_04A106

CODE_04A0D1:
	LDA.w $60FC
	BIT.w #$0018
	BEQ.b CODE_04A0ED
	CPX.w $0D96
	BNE.b CODE_04A0ED
	LDA.w #$0030
	STA.w $7A96,x
	LDA.w #$0004
	STA.w $7A98,x
	INC.b $76,x
CODE_04A0EC:
	RTS

CODE_04A0ED:
	LDA.w $61D6
	BEQ.b CODE_04A0EC
	CPX.w $0D96
	BEQ.b CODE_04A0EC
	LDA.w $6FA0,x
	EOR.w #$0E40
	STA.w $6FA0,x
	STZ.w $6FA2,x
	LDA.w #$FFFF
CODE_04A106:
	STA.w $7AF6,x
	LDA.w #$0004
	STA.w $7540,x
	LDA.w #$003E
	STA.w $7A96,x
	STA.w $0CD0
	STA.w $61EC
	LDA.w #$0008
	STA.w $7A98,x
	LDA.w #$0003
	STA.b $76,x
	BRA.b CODE_04A17C

CODE_04A128:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_04A196
	LDA.w #$0004
	STA.w $7A98,x
	LDA.w $7042,x
	EOR.w #$000E
	STA.w $7042,x
	LDA.w $7A96,x
	BNE.b CODE_04A196
	LDA.w $6FA0,x
	EOR.w #$0E40
	STA.w $6FA0,x
	STZ.w $6FA2,x
	LDA.w $7042,x
	ORA.w #$0080
	STA.w $7042,x
	LDA.w #$0080
	STA.w $75E0,x
	LDA.w #$0008
	STA.w $7900,x
	LDA.w #$0002
	STA.w $7540,x
	LDA.w #$0038
	STA.w $7A96,x
	INC
	STA.w $0CD0
	STA.w $61EC
	LDA.w #$0004
	STA.w $7A98,x
CODE_04A17C:
	STZ.b $16,x
	LDA.w #$0010
	STA.w $6F00,x
	LDA.w #$FFFF
	STA.w $7E48
	LDA.w #$0881
	STA.w $6FA2,x
	LDA.w #$0954
	STA.w $7040,x
CODE_04A196:
	RTS

;---------------------------------------------------------------------------

CODE_04A197:
	JSL.l CODE_02813E
	LDA.w $70E2,x
	SEC
	SBC.w #$0008
	STA.w $70E2,x
	LDA.w #$0140
	STA.w $7A36,x
	RTL

;---------------------------------------------------------------------------

DATA_04A1AC:
	dw $FFFC,$0004

DATA_04A1B0:
	dw $FEC0,$0140

CODE_04A1B4:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BEQ.b CODE_04A1C2
	JMP.w CODE_04A250

CODE_04A1C2:
	JSR.w CODE_04A300
	BCC.b CODE_04A1CB
	STZ.w $0CB2
	RTL

CODE_04A1CB:
	LDA.b $78,x
	CMP.w #$2000
	BPL.b CODE_04A1EB
	LDY.b #$20
	LDA.w #$0030
	JSR.w CODE_04A280
	BCS.b CODE_04A1EB
	LDA.w #$0008
	STA.w $7A38,x
	CLC
	ADC.w $7A36,x
	STA.w $7A36,x
	BRA.b CODE_04A248

CODE_04A1EB:
	LDY.w $7A38,x
	BEQ.b CODE_04A21B
	LDA.b $78,x
	BMI.b CODE_04A205
	LDA.w $7A36,x
	CMP.w #$0140
	BMI.b CODE_04A205
	SEC
	SBC.w #$0010
	STA.w $7A36,x
	BPL.b CODE_04A248
CODE_04A205:
	STZ.w $7A38,x
	LDA.w #$0040
	JSL.l CODE_0085D2
	LDY.b #$00
	LDA.b $78,x
	BPL.b CODE_04A217
	INY
	INY
CODE_04A217:
	STY.b $16,x
	BRA.b CODE_04A248

CODE_04A21B:
	LDY.b $16,x
	LDA.w $7A36,x
	CLC
	ADC.w DATA_04A1AC,y
	STA.w $7A36,x
	SEC
	SBC.w DATA_04A1B0,y
	EOR.w DATA_04A1B0,y
	BMI.b CODE_04A248
	LDA.w DATA_04A1B0,y
	STA.w $7A36,x
	EOR.b $78,x
	BMI.b CODE_04A248
	LDA.w #$0040
	JSL.l CODE_0085D2
	LDA.b $16,x
	EOR.w #$0002
	STA.b $16,x
CODE_04A248:
	LDA.b $78,x
	CLC
	ADC.w $7A36,x
	STA.b $78,x
CODE_04A250:
	LDA.w #$0104
	STA.w $0CB8
	LDY.b $79,x
	TYA
	STA.b $00
	LDA.w #$00C0
	SEC
	SBC.b $00
	STA.w $7E40
	LDA.w $7682,x
	PHA
	SEC
	SBC.w #$0008
	STA.w $7682,x
	LDY.b #$02
	JSL.l CODE_02841C
	PLA
	STA.w $7682,x
	LDA.w #$0710
	STA.w $0967
	RTL

CODE_04A280:
	STA.b $04
	ASL
	STA.b $06
	TYA
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w $79D9,x
	TYA
	ASL
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_0B8595>>16
	LDA.w #FXCODE_0B8595
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	EOR.w #$FFFF
	SEC
	ADC.w $7CD8,x
	SEC
	SBC.w #$0008
	STA.b $02
	SEC
	SBC.w $611E
	SEC
	SBC.w $6112
	SEC
	SBC.w $6122
	DEC
	CMP.w #$FFF4
	BCC.b CODE_04A2E4
	STA.b $00
	LDA.w $60AA
	BMI.b CODE_04A2E4
	LDA.w $7C16,x
	CLC
	ADC.b $04
	CMP.b $06
	BCS.b CODE_04A2E4
	LDA.b $00
	CLC
	ADC.w $6090
	CLC
	ADC.w #$0003
	STA.w $6090
	INC.w $61B4
	STZ.w $60AA
	CLC
	RTS

CODE_04A2E4:
	SEC
	RTS

;---------------------------------------------------------------------------

CODE_04A2E6:
	LDA.w $7680,x
	CLC
	ADC.w #$0068
	CMP.w #$01D0
	BCS.b CODE_04A318
	LDA.w $7682,x
	CLC
	ADC.w #$00A0
	CMP.w #$0220
	BCC.b CODE_04A31E
	BRA.b CODE_04A318

CODE_04A300:
	LDA.w $7680,x
	CLC
	ADC.w #$0068
	CMP.w #$01D0
	BCS.b CODE_04A318
	LDA.w $7682,x
	CLC
	ADC.w #$0080
	CMP.w #$01E0
	BCC.b CODE_04A31E
CODE_04A318:
	PHP
	JSL.l CODE_03A31E
	PLP
CODE_04A31E:
	RTS

;---------------------------------------------------------------------------

CODE_04A31F:
	LDA.w $0073
	STA.b $00
	JSL.l CODE_02813E
	LDA.b $00
	STA.w $0073
	LDA.w $70E2,x
	SEC
	SBC.w #$0008
	STA.w $70E2,x
	LDA.w $0967
	STA.w $7900,x
	RTL

;---------------------------------------------------------------------------

DATA_04A33E:
	dw $FFA0,$0060

CODE_04A342:
	LDA.w #$0104
	STA.w $0CB8
	LDA.b $79,x
	AND.w #$00FF
	STA.b $00
	LDA.w #$0010
	SEC
	SBC.b $00
	STA.w $7E40
	LDY.b #$04
	JSL.l CODE_02841C
	LDA.w #$0710
	STA.w $0967
	LDA.w $60AC
	CMP.w #$0006
	BNE.b CODE_04A372
	LDA.w #$0215
	STA.w $0967
CODE_04A372:
	JSL.l CODE_03AF23
	JSR.w CODE_04A2E6
	BCC.b CODE_04A3A0
	LDX.b #FXCODE_08D46A>>16
	LDA.w #FXCODE_08D46A
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	JSL.l CODE_00BE39	: db $40,$50,$7E,$72,$33,$70,$A4,$01
	SEP.b #$10
	LDX.b $12
	STZ.w $0CB2
	LDA.w $7900,x
	STA.w $0967
	RTL

CODE_04A3A0:
	LDA.b $19,x
	AND.w #$00FF
	CMP.w #$0020
	BCC.b CODE_04A3AD
	JMP.w CODE_04A45D

CODE_04A3AD:
	LDY.w $60C0
	BEQ.b CODE_04A3BA
	LDY.w $60AB
	BPL.b CODE_04A3BA
	JMP.w CODE_04A45D

CODE_04A3BA:
	LDA.w $7182,x
	SEC
	SBC.w $6090
	SEC
	SBC.w $6112
	BMI.b CODE_04A3CC
	CMP.w #$0038
	BCC.b CODE_04A3CF
CODE_04A3CC:
	JMP.w CODE_04A45D

CODE_04A3CF:
	LDA.w $7C16,x
	CLC
	ADC.w #$0030
	CMP.w #$0060
	BCS.b CODE_04A3CC
	LDA.w $7A38,x
	BNE.b CODE_04A406
	LDA.w #$0038
	SEC
	SBC.w $7182,x
	CLC
	ADC.w $6090
	STA.b $02
	SEP.b #$20
	LDA.b #$92
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.b #$00
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.b $02
	STA.w !REGISTER_Mode7MatrixParameterB
	REP.b #$20
	LDA.w !REGISTER_PPUMultiplicationProductMid
	XBA
	STA.b $18,x
CODE_04A406:
	SEP.b #$20
	LDA.b #$C0
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.b #$01
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.b $19,x
	STA.w !REGISTER_Mode7MatrixParameterB
	REP.b #$20
	LDA.w !REGISTER_PPUMultiplicationProductMid
	CLC
	ADC.w $7182,x
	SEC
	SBC.w #$0037
	SEC
	SBC.w $6112
	STA.w $6090
	INC.w $61B4
	LDY.w $7A38,x
	BNE.b CODE_04A43B
	LDA.w $7A36,x
	BPL.b CODE_04A43B
	STZ.w $7A36,x
CODE_04A43B:
	LDA.w #$0001
	STA.w $7A38,x
	STZ.w $60AA
	LDA.w $7A36,x
	CLC
	ADC.w #$0008
	CMP.w #$0400
	BCS.b CODE_04A453
	STA.w $7A36,x
CODE_04A453:
	LDA.b $18,x
	CLC
	ADC.w $7A36,x
	STA.b $18,x
	BRA.b CODE_04A4A8

CODE_04A45D:
	LDA.w $7A38,x
	BEQ.b CODE_04A478
	STZ.w $7A38,x
	LDA.b $19,x
	AND.w #$00FF
	CMP.w #$0020
	BCC.b CODE_04A478
	LDA.w #$0400
	STA.w $60AA
	STZ.w $7902,x
CODE_04A478:
	STZ.b $18,x
	LDA.w $7902,x
	TAY
	DEC
	STA.b $00
	LDA.w #$0002
	CPY.b #$00
	BNE.b CODE_04A48C
	EOR.w #$FFFF
	INC
CODE_04A48C:
	CLC
	ADC.w $7A36,x
	STA.w $7A36,x
	SEC
	SBC.w DATA_04A33E,y
	EOR.b $00
	BMI.b CODE_04A4A8
	TYA
	EOR.w #$0002
	STA.w $7902,x
	LDA.w DATA_04A33E,y
	STA.w $7A36,x
CODE_04A4A8:
	LDA.b $78,x
	CLC
	ADC.w $7A36,x
	STA.b $78,x
	RTL

;---------------------------------------------------------------------------

CODE_04A4B1:
	INC.w $0DF9
	RTL

;---------------------------------------------------------------------------

DATA_04A4B5:
	dw DATA_04A4B7

DATA_04A4B7:
	db $04,$08,$E8,$30,$F8,$E8,$30,$F8,$18,$30,$08,$18,$30,$04,$60,$00
	db $01,$A2,$01,$02,$E0,$02,$03,$22,$03,$00

DATA_04A4D1:
	dw CODE_04A5FB
	dw CODE_04A65C

CODE_04A4D5:
	LDA.w $0030
	CMP.w $0DF7
	BEQ.b CODE_04A4F1
	STA.w $0DF7
	LDA.w $0DF9
	STA.w $0DFB
	LDX.b #FXCODE_08D46A>>16
	LDA.w #FXCODE_08D46A
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_04A4F1:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BEQ.b CODE_04A4FF
	JMP.w CODE_04A586

CODE_04A4FF:
	LDX.b $12
	JSR.w CODE_04A300
	BCC.b CODE_04A579
	DEC.w $0DF9
	DEC.w $0DFB
	BNE.b CODE_04A578
CODE_04A50E:
	REP.b #$10
	JSL.l CODE_00BE39	: db $40,$50,$7E,$72,$33,$70,$48,$03
	SEP.b #$30
	LDA.b #$10
	STA.w $0967
	LDA.b #$07
	STA.w $0968
	LDA.b #$02
	STA.w $096B
	LDA.b #$20
	STA.w $096C
	LDA.b #$18
	STA.w $094A
	REP.b #$20
	LDA.w #$14E9
	STA.l $702002
	STA.l $702D6E
	LDA.w #$14E9
	STA.l $702010
	STA.l $702D7C
	LDA.w #$3216
	STA.l $702004
	STA.l $702D70
	LDA.w #$3216
	STA.l $702012
	STA.l $702D7E
	LDA.w #$0000
	STA.l $702006
	STA.l $702D72
	STA.l $702014
	STA.l $702D80
CODE_04A578:
	RTL

CODE_04A579:
	TXY
	LDA.w $7360,x
	SEC
	SBC.w #$005E
	ASL
	TAX
	JSR.w (DATA_04A4D1,x)
CODE_04A586:
	LDA.w #$0104
	STA.w $0CB8
	LDA.b $79,x
	AND.w #$00FF
	STA.b $00
	LDA.w #$00C0
	SEC
	SBC.b $00
	STA.w $7E40
	LDA.w $7682,x
	PHA
	SEC
	SBC.w #$0010
	STA.w $7682,x
	LDY.b #$00
	LDA.w DATA_04A4B5,y
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w #$0078
	SEC
	SBC.w $7680,x
	STA.w $0041
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7682,x
	CLC
	ADC.w #$000F
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	CLC
	ADC.w $003B
	STA.w $0CB6
	LDA.w $0CB8
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7E40
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0004
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08D486>>16
	LDA.w #FXCODE_08D486
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	DEC.w $0DFB
	BNE.b CODE_04A5F4
	JSL.l CODE_04A50E
CODE_04A5F4:
	LDX.b $12
	PLA
	STA.w $7682,x
	RTL

CODE_04A5FB:
	TYX
	LDA.w $7A38,x
	BEQ.b CODE_04A612
CODE_04A601:
	LDA.b $78,x
	CLC
	ADC.w $7A36,x
	BPL.b CODE_04A60F
	STZ.w $7A38,x
	LDA.w #$0000
CODE_04A60F:
	STA.b $78,x
	RTS

CODE_04A612:
	LDA.b $79,x
	AND.w #$00FF
	CMP.w #$0020
	BCC.b CODE_04A621
	INC.w $7A38,x
	BRA.b CODE_04A601

CODE_04A621:
	LDY.b #$20
	LDA.w #$0018
	JSR.w CODE_04A280
	BCS.b CODE_04A64B
	LDA.b $78,x
	CLC
	ADC.w $7A36,x
	CMP.w #$4000
	BCC.b CODE_04A639
	LDA.w #$4000
CODE_04A639:
	STA.b $78,x
	LDA.w $7A36,x
	CLC
	ADC.w #$0003
	CMP.w #$0200
	BCS.b CODE_04A65B
	STA.w $7A36,x
	RTS

CODE_04A64B:
	STZ.w $7A36,x
	LDA.b $78,x
	SEC
	SBC.w #$0100
	BPL.b CODE_04A659
	LDA.w #$0000
CODE_04A659:
	STA.b $78,x
CODE_04A65B:
	RTS

CODE_04A65C:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_04A69E
	INC.w $7A38,x
	LDA.w $7A36,x
	CLC
	ADC.w #$0010
	CLC
	ADC.w $7A38,x
	CMP.w #$0400
	BCS.b CODE_04A678
	STA.w $7A36,x
CODE_04A678:
	LDA.b $78,x
	CLC
	ADC.w $7A36,x
	BPL.b CODE_04A69C
	STZ.w $7A38,x
	STZ.w $7A36,x
	LDA.w $70E2,x
	AND.w #$0010
	BNE.b CODE_04A693
	LDA.w #$0060
	BRA.b CODE_04A696

CODE_04A693:
	LDA.w #$0080
CODE_04A696:
	STA.w $7A96,x
	LDA.w #$0000
CODE_04A69C:
	STA.b $78,x
CODE_04A69E:
	LDA.b $78,x
	CMP.w #$1500
	BCS.b CODE_04A6AD
	LDY.b #$20
	LDA.w #$0018
	JSR.w CODE_04A280
CODE_04A6AD:
	RTS

;---------------------------------------------------------------------------

CODE_04A6AE:
	LDA.w $7182,x
	AND.w #$0010
	BEQ.b CODE_04A6BB
	LDA.w #$FF90
	BRA.b CODE_04A6BE

CODE_04A6BB:
	LDA.w #$0070
CODE_04A6BE:
	STA.w $75E0,x
	LDA.w #$0005
	STA.w $7540,x
	LDA.w $70E2,x
	CLC
	ADC.w #$0028
	STA.w $7900,x
	SEC
	SBC.w #$0050
	STA.w $7902,x
CODE_04A6D8:
	LDA.w $0136
	CMP.w #$0003
	BEQ.b CODE_04A6E5
	CMP.w #$000D
	BNE.b CODE_04A6EB
CODE_04A6E5:
	INC.w $7B58,x
	INC.w $7B58,x
CODE_04A6EB:
	LDA.w #$0014
	STA.w $7BB6,x
	LDA.w #$0008
	STA.w $7BB8,x
	RTL

;---------------------------------------------------------------------------

CODE_04A6F8:
	JSL.l CODE_03AF23
	LDA.w $70E2,x
	CMP.w $7902,x
	BMI.b CODE_04A709
	CMP.w $7900,x
	BMI.b CODE_04A722
CODE_04A709:
	LDA.b $18,x
	STA.w $70E2,x
	CLC
	ADC.w #$0008
	STA.w $7CD6,x
	STZ.w $7220,x
	LDA.w $75E0,x
	EOR.w #$FFFF
	INC
	STA.w $75E0,x
CODE_04A722:
	JMP.w CODE_04A77C

CODE_04A725:
	LDA.w $70E2,x
	AND.w #$0010
	BEQ.b CODE_04A732
	LDA.w #$FF90
	BRA.b CODE_04A735

CODE_04A732:
	LDA.w #$0070
CODE_04A735:
	STA.w $75E2,x
	LDA.w #$0005
	STA.w $7542,x
	LDA.w $7182,x
	CLC
	ADC.w #$0020
	STA.w $7900,x
	SEC
	SBC.w #$0040
	STA.w $7902,x
	JMP.w CODE_04A6D8

CODE_04A752:
	JSL.l CODE_03AF23
	LDA.w $7182,x
	CMP.w $7902,x
	BMI.b CODE_04A763
	CMP.w $7900,x
	BMI.b CODE_04A77C
CODE_04A763:
	LDA.b $78,x
	STA.w $7182,x
	CLC
	ADC.w #$0008
	STA.w $7CD8,x
	STZ.w $7222,x
	LDA.w $75E2,x
	EOR.w #$FFFF
	INC
	STA.w $75E2,x
CODE_04A77C:
	LDA.w $70E2,x
	SEC
	SBC.b $18,x
	STA.w $72C0,x
	LDA.w $7182,x
	SEC
	SBC.b $78,x
	STA.w $72C2,x
CODE_04A78E:
	LDY.w $0B59
	BNE.b CODE_04A7F3
	LDY.w $60AB
	BMI.b CODE_04A7F3
	LDY.w $0D94
	BNE.b CODE_04A7F3
	CPX.w $61B6
	BNE.b CODE_04A7EE
	LDA.w $60FC
	AND.w #$01E0
	BEQ.b CODE_04A7B3
	AND.w #$0180
	DEC
	EOR.w $7220,x
	BMI.b CODE_04A7C7
CODE_04A7B3:
	LDA.w $608C
	CLC
	ADC.w $72C0,x
	STA.w $608C
	LDA.w $611C
	CLC
	ADC.w $72C0,x
	STA.w $611C
CODE_04A7C7:
	LDA.w $60FC
	AND.w #$001F
	BEQ.b CODE_04A7D8
	AND.w #$0018
	DEC
	EOR.w $7222,x
	BMI.b CODE_04A7EE
CODE_04A7D8:
	LDA.w $6090
	CLC
	ADC.w $72C2,x
	STA.w $6090
	LDA.w $611E
	CLC
	ADC.w $72C2,x
	STA.w $611E
	BRA.b CODE_04A7F6

CODE_04A7EE:
	LDY.w $60C0
	BNE.b CODE_04A7F6
CODE_04A7F3:
	JMP.w CODE_04A853

CODE_04A7F6:
	LDA.w $7BB6,x
	CLC
	ADC.w $6120
	ASL
	STA.b $00
	LSR
	CLC
	ADC.w $7CD6,x
	SEC
	SBC.w $611C
	CMP.b $00
	BCS.b CODE_04A853
	LDA.w $7BB8,x
	CLC
	ADC.w $6122
	ASL
	STA.b $00
	LSR
	CLC
	ADC.w $7CD8,x
	SEC
	SBC.w $611E
	CMP.b $00
	BCS.b CODE_04A853
	SEC
	SBC.b $00
	STA.b $02
	CMP.w #$FFF6
	BCC.b CODE_04A853
	CPX.w $61B6
	BEQ.b CODE_04A83B
	LDY.w $61B6
	BNE.b CODE_04A85B
	STX.w $61B6
CODE_04A83B:
	LDA.w $6090
	CLC
	ADC.b $02
	CLC
	ADC.w #$0002
	STA.w $6090
	STZ.w $60D2
	STZ.w $60AA
	INC.w $61B4
	BRA.b CODE_04A85B

CODE_04A853:
	CPX.w $61B6
	BNE.b CODE_04A85B
	STZ.w $61B6
CODE_04A85B:
	LDA.w $70E2,x
	STA.b $18,x
	LDA.w $7182,x
	STA.b $78,x
	RTL

;---------------------------------------------------------------------------

DATA_04A866:
	dw $AA00,$0000,$5400,$0001,$0000,$0004

CODE_04A872:
	LDA.w $7360,x
	SEC
	SBC.w #$0185
	AND.w #$0002
	ASL
	TAY
	LDA.w DATA_04A866,y
	STA.w $7A36,x
	LDA.w DATA_04A866+$02,y
	STA.w $7A38,x
CODE_04A88A:
	LDA.w #$0080
	STA.w $7900,x
	LDA.w #$0185
	AND.w #$0001
	STA.b $00
	LDA.w $7360,x
	SEC
	SBC.w #$0185
	AND.w #$0001
	CMP.b $00
	BNE.b CODE_04A8AB
	LDA.w #$8000
	STA.b $16,x
CODE_04A8AB:
	LDA.w #$0014
	STA.w $7BB6,x
	LDA.w #$0008
	STA.w $7BB8,x
	RTL

;---------------------------------------------------------------------------

CODE_04A8B8:
	JSL.l CODE_03AF23
	LDA.w $70E2,x
	STA.b $00
	LDA.w $7182,x
	STA.b $02
	JSL.l CODE_04A9FD
	LDY.w $7900,x
	BMI.b CODE_04A8FF
	LDA.w $70E2,x
	SEC
	SBC.b $00
	CLC
	ADC.w $72C0,x
	STA.w $72C0,x
	LDA.w $7182,x
	SEC
	SBC.b $02
	CLC
	ADC.w $72C2,x
	STA.w $72C2,x
	LDA.w $70E2,x
	CLC
	ADC.w $7B56,x
	STA.w $7CD6,x
	LDA.w $7182,x
	CLC
	ADC.w $7B58,x
	STA.w $7CD8,x
	BRA.b CODE_04A92A

CODE_04A8FF:
	LDA.w $7222,x
	BPL.b CODE_04A92A
	CMP.w #$8000
	ROR
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7220,x
	CMP.w #$8000
	ROR
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_0BBCF8>>16
	LDA.w #FXCODE_0BBCF8
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.w $75E0,x
	LSR
	XBA
	STA.b $16,x
CODE_04A92A:
	LDY.w $61B6
	STY.b $0E
	JSL.l CODE_04A78E
	LDA.w $7A38,x
	ORA.w $7A36,x
	BNE.b CODE_04A959
	CPX.w $61B6
	BNE.b CODE_04A958
	LDA.w $7360,x
	SEC
	SBC.w #$0189
	AND.w #$0006
	ASL
	TAY
	LDA.w DATA_04A866,y
	STA.w $7A36,x
	LDA.w DATA_04A866+$02,y
	STA.w $7A38,x
CODE_04A958:
	RTL

CODE_04A959:
	CPX.b $0E
	BNE.b CODE_04A958
	CPX.w $61B6
	BEQ.b CODE_04A958
	LDA.w $61D6
	BNE.b CODE_04A958
	LDY.w $0D94
	BNE.b CODE_04A958
	LDY.w $7900,x
	BMI.b CODE_04A9A8
	LDA.b $16,x
	AND.w #$FF00
	XBA
	ASL
	EOR.w #$0100
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7A37,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B8595>>16
	LDA.w #FXCODE_0B8595
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	CLC
	ADC.w $60A8
	STA.w $60A8
	STA.w $60B4
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	CLC
	ADC.w $60AA
	STA.w $60AA
	BRA.b CODE_04A9CD

CODE_04A9A8:
	LDA.w $7220,x
	ORA.w $7222,x
	BEQ.b CODE_04A9FC
	LDA.w $7220,x
	CLC
	ADC.w $60A8
	STA.w $60A8
	STA.w $60B4
	LDA.w $7222,x
	BMI.b CODE_04A9C6
	CMP.w #$8000
	ROR
CODE_04A9C6:
	CLC
	ADC.w $60AA
	STA.w $60AA
CODE_04A9CD:
	LDA.w $60A8
	CMP.w #$0800
	BMI.b CODE_04A9D8
	LDA.w #$0800
CODE_04A9D8:
	CMP.w #$F800
	BPL.b CODE_04A9E0
	LDA.w #$F800
CODE_04A9E0:
	STA.w $60A8
	STA.w $60B4
	LDA.w $60AA
	CMP.w #$0800
	BMI.b CODE_04A9F1
	LDA.w #$0800
CODE_04A9F1:
	CMP.w #$F800
	BPL.b CODE_04A9F9
	LDA.w #$F800
CODE_04A9F9:
	STA.w $60AA
CODE_04A9FC:
	RTL

;---------------------------------------------------------------------------

CODE_04A9FD:
	LDA.b $16,x
	STA.w $6046
	TXA
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #$FFFF
	STA.w $6040
	LDA.w $75E0,x
	STA.w $601E
	LDX.b #FXCODE_0B89E9>>16
	LDA.w #FXCODE_0B89E9
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $601E
	STA.w $75E0,x
	RTL

;---------------------------------------------------------------------------

CODE_04AA24:
	JSL.l CODE_03AE60
	LDA.w #$0080
	STA.w $7900,x
	STZ.w $7400,x
	RTL

;---------------------------------------------------------------------------

CODE_04AA32:
	JSL.l CODE_03AA52
	JSL.l CODE_03AF23
	STZ.b $0E
	LDA.w $70E2,x
	STA.b $00
	LDA.w $7182,x
	STA.b $02
	JSR.w CODE_04AAA2
	LDY.w $7900,x
	BMI.b CODE_04AA6A
	LDA.w $70E2,x
	SEC
	SBC.b $00
	CLC
	ADC.w $72C0,x
	STA.w $72C0,x
	LDA.w $7182,x
	SEC
	SBC.b $02
	CLC
	ADC.w $72C2,x
	STA.w $72C2,x
	BRA.b CODE_04AA95

CODE_04AA6A:
	LDA.w $7222,x
	BPL.b CODE_04AA95
	CMP.w #$8000
	ROR
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7220,x
	CMP.w #$8000
	ROR
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_0BBCF8>>16
	LDA.w #FXCODE_0BBCF8
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.w $75E0,x
	LSR
	XBA
	STA.b $16,x
CODE_04AA95:
	JSR.w CODE_04AABE
	JSR.w CODE_04ABC6
	JSR.w CODE_04ABED
	JSR.w CODE_04AC61
	RTL

CODE_04AAA2:
	TXA
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w $75E0,x
	STA.w $601E
	LDX.b #FXCODE_0B89E9>>16
	LDA.w #FXCODE_0B89E9
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $601E
	STA.w $75E0,x
	RTS

CODE_04AABE:
	LDY.w $7D36,x
	BMI.b CODE_04AB06
CODE_04AAC3:
	CPX.w $61B6
	BNE.b CODE_04AB05
	STZ.w $61B6
	LDY.w $0D94
	BNE.b CODE_04AB05
	LDA.b $16,x
	AND.w #$FF00
	XBA
	ASL
	EOR.w #$0100
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7A37,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B8595>>16
	LDA.w #FXCODE_0B8595
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	CLC
	ADC.w $60A8
	STA.w $60A8
	STA.w $60B4
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	CLC
	ADC.w $60AA
	STA.w $60AA
CODE_04AB05:
	RTS

CODE_04AB06:
	LDY.w $60AB
	BMI.b CODE_04AAC3
	LDY.w $0D94
	BNE.b CODE_04AAC3
	LDA.w $7C18,x
	SEC
	SBC.w $6122
	SEC
	SBC.w $7BB8,x
	CMP.w #$FFF8
	BCC.b CODE_04AAC3
	CPX.w $61B6
	BEQ.b CODE_04AB35
	LDY.w $61B6
	BNE.b CODE_04AB05
	STX.w $61B6
	LDA.w $608B
	AND.w #$FF00
	STA.b $76,x
CODE_04AB35:
	LDA.w $7182,x
	SEC
	SBC.w #$0022
	STA.w $6090
	STZ.w $60AA
	INC.w $61B4
	LDA.w #$0120
	JSL.l CODE_04AB6F
	LDA.b $16,x
	CLC
	ADC.w #$4000
	PHP
	LDA.w $7C16,x
	XBA
	AND.w #$FF00
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	PLP
	BPL.b CODE_04AB69
	EOR.w #$FFFF
	INC
CODE_04AB69:
	CLC
	ADC.b $0E
	STA.b $0E
	RTS

;---------------------------------------------------------------------------

CODE_04AB6F:
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $72BF,x
	AND.w #$FF00
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $608B
	AND.w #$FF00
	STA.b $00
	LDY.b $76,x
	TYA
	ORA.b $00
	STA.b $76,x
	LDA.w $608D
	AND.w #$00FF
	STA.b $00
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	BPL.b CODE_04ABAE
	CLC
	ADC.b $76,x
	STA.b $76,x
	LDA.b $00
	SBC.w #$0000
	BRA.b CODE_04ABB8

CODE_04ABAE:
	CLC
	ADC.b $76,x
	STA.b $76,x
	LDA.b $00
	ADC.w #$0000
CODE_04ABB8:
	XBA
	STA.b $00
	LDA.b $77,x
	AND.w #$00FF
	ORA.b $00
	STA.w $608C
	RTL

;---------------------------------------------------------------------------

CODE_04ABC6:
	LDA.b $16,x
	AND.w #$FF00
	XBA
	ASL
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$FC00
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B8595>>16
	LDA.w #FXCODE_0B8595
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	BPL.b CODE_04ABE7
	ASL
CODE_04ABE7:
	CLC
	ADC.b $0E
	STA.b $0E
	RTS

;---------------------------------------------------------------------------

CODE_04ABED:
	LDA.b $0E
	SEC
	SBC.w #$0080
	BPL.b CODE_04AC24
	CLC
	ADC.w $7A36,x
	STA.w $7A36,x
	LDA.w $7A38,x
	SBC.w #$0000
	STA.w $7A38,x
	BPL.b CODE_04AC48
	STZ.w $7A38,x
	STZ.w $7A36,x
	LDA.b $16,x
	CLC
	ADC.w #$8000
	STA.b $16,x
	LDA.w $75E0,x
	CLC
	ADC.w #$0100
	AND.w #$01FE
	STA.w $75E0,x
	BRA.b CODE_04AC48

CODE_04AC24:
	CLC
	ADC.w $7A36,x
	STA.w $7A36,x
	LDA.w $7A38,x
	ADC.w #$0000
	STA.w $7A38,x
	LDA.w $7A37,x
	CMP.w #$0200
	BMI.b CODE_04AC48
	LDA.w #$0002
	STA.w $7A38,x
	LDA.w #$0000
	STZ.w $7A36,x
CODE_04AC48:
	LDA.b $16,x
	CLC
	ADC.w #$4000
	PHP
	LDA.w $7A37,x
	ASL
	ASL
	PLP
	BPL.b CODE_04AC5B
	EOR.w #$FFFF
	INC
CODE_04AC5B:
	CLC
	ADC.b $78,x
	STA.b $78,x
	RTS

;---------------------------------------------------------------------------

CODE_04AC61:
	LDA.w #$0001
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0055
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.b $79,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_088205>>16
	LDA.w #FXCODE_088205
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	INC.w $0CF9
	RTS

;---------------------------------------------------------------------------

CODE_04AC9C:
	LDA.w #$000E
	JSL.l CODE_04F6E2
	STZ.w $60C6
	LDA.w #$003A
	STA.w $60F8
	LDA.w #$0022
	STA.w $61D2
	STZ.w $61F4
	STZ.w $61AE
	RTL

;---------------------------------------------------------------------------

CODE_04ACB9:
	JSL.l CODE_03AE60
	JSL.l CODE_04AE9D
	STZ.w $7400,x
	LDA.w #$2000
	STA.w $7900,x
	RTL

;---------------------------------------------------------------------------

DATA_04ACCB:
	dw $0020,$FFE0

DATA_04ACCF:
	dw $FF00,$0100

CODE_04ACD3:
	LDY.b #$00
	JSR.w CODE_04AEDF
	LDY.b #$00
	LDA.w $7A39,x
	AND.w #$00FF
	CLC
	ADC.w #$0020
	AND.w #$00FF
	CMP.w #$0040
	BCC.b CODE_04AD09
	CMP.w #$0080
	BMI.b CODE_04ACF3
	INY
	INY
CODE_04ACF3:
	LDA.w DATA_04ACCF,y
	STA.w $75E0,x
	LDA.w #$0020
	STA.w $7540,x
	ASL
	STA.w $7542,x
	LDA.w #$0400
	STA.w $75E2,x
CODE_04AD09:
	LDA.w $7A39,x
	AND.w #$00FF
	ASL
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$1A00
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B855B>>16
	LDA.w #FXCODE_0B855B
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	PHX
	LDA.w $7722,x
	LSR
	CLC
	ADC.w #$01C0
	STA.b $00
	LDA.w $7042,x
	XBA
	AND.w #$FF00
	ORA.b $00
	STA.b $00
	LDA.w $70E2,x
	CLC
	ADC.w #$0008
	SEC
	SBC.w $6094
	SEC
	SBC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.b $02
	LDA.w $7182,x
	CLC
	ADC.w #$0008
	SEC
	SBC.w $609C
	SEC
	SBC.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.b $04
	LDA.w #$0003
	STA.b $06
	REP.b #$10
	LDY.w $7362,x
CODE_04AD66:
	LDA.b $02
	SEC
	SBC.w #$0010
	STA.w $6000,y
	STA.w $6010,y
	LDA.b $02
	STA.w $6008,y
	STA.w $6018,y
	CLC
	ADC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.b $02
	LDA.b $04
	SEC
	SBC.w #$0010
	STA.w $6002,y
	STA.w $600A,y
	LDA.b $04
	STA.w $6012,y
	STA.w $601A,y
	CLC
	ADC.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.b $04
	LDA.b $00
	STA.w $6004,y
	INC
	INC
	STA.w $600C,y
	CLC
	ADC.w #$001E
	STA.w $6014,y
	INC
	INC
	STA.w $601C,y
	TYA
	CLC
	ADC.w #$0020
	TAY
	DEC.b $06
	BNE.b CODE_04AD66
	SEP.b #$10
	PLX
	JSL.l CODE_03AF23
	LDA.w $60AA
	BPL.b CODE_04ADC9
	JMP.w CODE_04AE51

CODE_04ADC9:
	LDA.w $7A39,x
	AND.w #$00FF
	CLC
	ADC.w #$0028
	AND.w #$00FF
	CMP.w #$0050
	BCC.b CODE_04ADDE
	JMP.w CODE_04AE56

CODE_04ADDE:
	LDA.w #$FA00
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDY.b $18,x
	BEQ.b CODE_04AE00
	LDA.w $7E12
	SEC
	SBC.w $608C
	BPL.b CODE_04ADF5
	EOR.w #$FFFF
	INC
CODE_04ADF5:
	CLC
	ADC.w $6090
	CLC
	ADC.w #$0004
	STA.w $6090
CODE_04AE00:
	LDY.b #$00
	LDA.w $611C
	SEC
	SBC.w $7CD6,x
	BMI.b CODE_04AE0D
	INY
	INY
CODE_04AE0D:
	JSR.w CODE_04AF4D
	LDA.w $603E
	BEQ.b CODE_04AE51
	LDA.w $7CD8,x
	CLC
	ADC.w $603C
	SEC
	SBC.w $6112
	SEC
	SBC.w #$0020
	STA.w $6090
	LDA.w $60AA
	ASL
	ASL
	ASL
	STZ.w $60AA
	INC.w $61B4
	LDY.b $18,x
	BNE.b CODE_04AE3B
	INC.b $18,x
	BRA.b CODE_04AE49

CODE_04AE3B:
	LDA.b $04
	BPL.b CODE_04AE43
	EOR.w #$FFFF
	INC
CODE_04AE43:
	ASL
	ASL
	CLC
	ADC.w #$0200
CODE_04AE49:
	STA.b $00
	LDY.b $02
	CPY.b #$01
	BRA.b CODE_04AE62

CODE_04AE51:
	LDY.w $7A39,x
	BRA.b CODE_04AE59

CODE_04AE56:
	LDY.w $7902,x
CODE_04AE59:
	STZ.b $18,x
	LDA.w #$0200
	STA.b $00
	CPY.b #$00
CODE_04AE62:
	BPL.b CODE_04AE80
	LDA.w $7900,x
	CLC
	ADC.b $00
	STA.w $7900,x
	LDA.w $7902,x
	ADC.w #$0000
	STA.w $7902,x
	LDA.w #$0100
	CMP.w $7901,x
	BPL.b CODE_04AE9D
	BRA.b CODE_04AE9A

CODE_04AE80:
	LDA.w $7900,x
	SEC
	SBC.b $00
	STA.w $7900,x
	LDA.w $7902,x
	SBC.w #$0000
	STA.w $7902,x
	LDA.w #$FF00
	CMP.w $7901,x
	BMI.b CODE_04AE9D
CODE_04AE9A:
	STA.w $7901,x
CODE_04AE9D:
	LDA.w #$4060
	LDY.b #$54
CODE_04AEA2:
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	TYA
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDY.w $7A39,x
	TYA
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_088205>>16
	LDA.w #FXCODE_088205
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	INC.w $0CF9
	RTL

;---------------------------------------------------------------------------

DATA_04AED7:
	dw $C000,$4001,$E000,$2001

CODE_04AEDF:
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_04AF3C
	LDA.w $7A38,x
	STA.b $00
	CLC
	ADC.w $7901,x
	BPL.b CODE_04AEFF
	CMP.w DATA_04AED7,y
	BPL.b CODE_04AF39
	LDA.w DATA_04AED7,y
	BRA.b CODE_04AF07

CODE_04AEFF:
	CMP.w DATA_04AED7+$02,y
	BMI.b CODE_04AF39
	LDA.w DATA_04AED7+$02,y
CODE_04AF07:
	PHA
	LDA.w $7360,x
	CMP.w #$003D
	BNE.b CODE_04AF38
	LDA.w $7901,x
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	EOR.w #$FFFF
	INC
	STA.w $7901,x
	SEP.b #$20
	LDA.w $7903,x
	CMP.b #$80
	ROR
	CMP.b #$80
	ROR
	EOR.b #$FF
	INC
	STA.w $7903,x
	STZ.w $7900,x
	REP.b #$20
CODE_04AF38:
	PLA
CODE_04AF39:
	STA.w $7A38,x
CODE_04AF3C:
	RTS

;---------------------------------------------------------------------------

DATA_04AF3D:
	dw $D900,$2700,$F000,$1000,$8C00,$7400

DATA_04AF49:
	dw $0000,$8000

CODE_04AF4D:
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	STA.b $04
	LDA.w DATA_04AF3D,y
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	TYA
	AND.w #$0002
	TAY
	LDA.w DATA_04AF49,y
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	STY.b $02
	LDA.w $6090
	CLC
	ADC.w $6112
	CLC
	ADC.w #$0020
	SEC
	SBC.w $7CD8,x
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.b $18,x
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDY.w $7A39,x
	TYA
	ASL
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	PHX
	REP.b #$10
	TAX
	LDA.l FXDATA_0BBA12,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	SEP.b #$10
	PLX
	LDX.b #FXCODE_0B8500>>16
	LDA.w #FXCODE_0B8500
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	RTS

;---------------------------------------------------------------------------

CODE_04AF9E:
	LDA.w $70E2,x
	CLC
	ADC.w #$0008
	STA.w $70E2,x
	LDA.w $7182,x
	CLC
	ADC.w #$0008
	STA.w $7182,x
	LDA.w #$0080
	STA.w $7222,x
	STZ.w $7400,x
	RTL

;---------------------------------------------------------------------------

DATA_04AFBC:
	dw $FE00,$0200

CODE_04AFC0:
	LDY.w $7722,x
	BMI.b CODE_04AFC9
	JSL.l CODE_03AA52
CODE_04AFC9:
	JSL.l CODE_03AF23
	LDY.b #$04
	JSR.w CODE_04AEDF
	LDY.b $18,x
	BNE.b CODE_04AFEB
	CLC
	ADC.w #$0200
	CMP.w #$0400
	BCS.b CODE_04AFEB
	STZ.w $7A38,x
	LDY.w $7722,x
	BMI.b CODE_04AFEB
	JSL.l CODE_03AEFD
CODE_04AFEB:
	LDY.w $60AB
	BPL.b CODE_04AFF3
	JMP.w CODE_04B09F

CODE_04AFF3:
	LDA.w #$F800
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDY.b $18,x
	BEQ.b CODE_04B015
	LDA.w $7E12
	SEC
	SBC.w $608C
	BPL.b CODE_04B00A
	EOR.w #$FFFF
	INC
CODE_04B00A:
	CLC
	ADC.w $6090
	CLC
	ADC.w #$0004
	STA.w $6090
CODE_04B015:
	LDY.b #$04
	LDA.w $611C
	SEC
	SBC.w $7CD6,x
	BMI.b CODE_04B022
	INY
	INY
CODE_04B022:
	JSR.w CODE_04AF4D
	LDA.w $603E
	BEQ.b CODE_04B09F
	LDA.w $7CD8,x
	CLC
	ADC.w $603C
	SEC
	SBC.w #$0020
	SEC
	SBC.w $6112
	STA.w $6090
	LDA.w $60AA
	ASL
	ASL
	ASL
	PHA
	STZ.w $60AA
	LDY.w $7A39,x
	TYA
	ASL
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	CLC
	ADC.w #$0020
	AND.w #$01FE
	CMP.w #$0040
	BCC.b CODE_04B078
	LDA.w #$0008
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B8595>>16
	LDA.w #FXCODE_0B8595
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	CLC
	ADC.w $60A8
	STA.w $60A8
	STA.w $60B4
CODE_04B078:
	INC.w $61B4
	LDY.w $7722,x
	BPL.b CODE_04B084
	JSL.l CODE_03AD74
CODE_04B084:
	LDY.b $18,x
	BNE.b CODE_04B093
	LDA.w #$FFFA
	STA.w $7720,x
	INC.b $18,x
	PLA
	BRA.b CODE_04B097

CODE_04B093:
	PLA
	LDA.w #$1000
CODE_04B097:
	STA.b $00
	LDY.b $02
	CPY.b #$01
	BRA.b CODE_04B0BE

CODE_04B09F:
	STZ.b $18,x
	STZ.w $7720,x
	LDY.b #$00
	LDA.w $7A38,x
	BNE.b CODE_04B0B3
	STA.w $7900,x
	STA.w $7902,x
	BRA.b CODE_04B0F6

CODE_04B0B3:
	BPL.b CODE_04B0B7
	INY
	INY
CODE_04B0B7:
	LDA.w DATA_04AFBC,y
	BRA.b CODE_04B0F3

CODE_04B0BC:
	CPY.b #$00
CODE_04B0BE:
	BPL.b CODE_04B0DC
	LDA.w $7900,x
	CLC
	ADC.b $00
	STA.w $7900,x
	LDA.w $7902,x
	ADC.w #$0000
	STA.w $7902,x
	LDA.w #$0100
	CMP.w $7901,x
	BPL.b CODE_04B0F6
	BRA.b CODE_04B0F3

CODE_04B0DC:
	LDA.w $7900,x
	SEC
	SBC.b $00
	STA.w $7900,x
	LDA.w $7902,x
	SBC.w #$0000
	STA.w $7902,x
	LDA.w #$FF00
	BMI.b CODE_04B0F6
CODE_04B0F3:
	STA.w $7901,x
CODE_04B0F6:
	LDA.w $7722,x
	BMI.b CODE_04B104
	LDA.w #$2060
	LDY.b #$55
	JSL.l CODE_04AEA2
CODE_04B104:
	LDA.w #$0040
	LDY.w $7862,x
	BEQ.b CODE_04B10F
	LDA.w #$FFC0
CODE_04B10F:
	STA.w $75E2,x
	SEP.b #$20
	LDA.b #$FF
	STA.w $7862,x
	REP.b #$20
	RTL

;---------------------------------------------------------------------------

CODE_04B11C:
	LDA.w $0CB2
	BEQ.b CODE_04B125
	JML.l CODE_03A31E

CODE_04B125:
	INC.w $0CB2
	LDA.w #$0078
	LDY.w $0073
	BEQ.b CODE_04B133
	LDA.w #$FF88
CODE_04B133:
	CLC
	ADC.w $70E2,x
	STA.w $70E2,x
	LDX.b #$04
CODE_04B13C:
	LDA.l DATA_5FE33E,x
	STA.l $702002,x
	STA.l $702D6E,x
	DEX
	DEX
	BPL.b CODE_04B13C
	LDX.b $12
	LDA.w $0967
	STA.w $7A36,x
	LDA.w #$1000
	STA.w $7900,x
	RTL

;---------------------------------------------------------------------------

CODE_04B15B:
	JSR.w CODE_04B2B3
	JSL.l CODE_03AF23
	JSR.w CODE_04B169
	JSR.w CODE_04B191
	RTL

CODE_04B169:
	LDY.b #$04
	JSR.w CODE_04AEDF
	SEC
	SBC.b $00
	BPL.b CODE_04B177
	EOR.w #$FFFF
	INC
CODE_04B177:
	CLC
	ADC.w $75E0,x
	CMP.w #$1000
	BMI.b CODE_04B18D
	PHA
	LDA.w #$001F
	JSL.l CODE_0085D2
	PLA
	SEC
	SBC.w #$1000
CODE_04B18D:
	STA.w $75E0,x
	RTS

CODE_04B191:
	LDY.w $60AB
	BPL.b CODE_04B19E
	LDY.w $60C0
	BEQ.b CODE_04B19E
	JMP.w CODE_04B238

CODE_04B19E:
	LDA.w #$F800
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDY.b $18,x
	BEQ.b CODE_04B1C8
	LDA.w $60FC
	AND.w #$0007
	BNE.b CODE_04B1C8
	LDA.w $7E12
	SEC
	SBC.w $608C
	BPL.b CODE_04B1BD
	EOR.w #$FFFF
	INC
CODE_04B1BD:
	CLC
	ADC.w $6090
	CLC
	ADC.w #$0004
	STA.w $6090
CODE_04B1C8:
	LDY.b #$08
	LDA.w $611C
	SEC
	SBC.w $7CD6,x
	BMI.b CODE_04B1D5
	INY
	INY
CODE_04B1D5:
	JSR.w CODE_04AF4D
	LDA.w $603E
	BEQ.b CODE_04B238
	LDA.w $60FC
	AND.w #$0007
	BNE.b CODE_04B238
	LDA.w $7CD8,x
	CLC
	ADC.w $603C
	SEC
	SBC.w $6112
	SEC
	SBC.w #$0020
	STA.w $6090
	LDA.w $60AA
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0180
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STZ.w $60AA
	INC.w $61B4
	LDY.b $18,x
	BNE.b CODE_04B21F
	INC.b $18,x
	BRA.b CODE_04B22C

CODE_04B21F:
	LDA.b $04
	BPL.b CODE_04B227
	EOR.w #$FFFF
	INC
CODE_04B227:
	ASL
	CLC
	ADC.w #$0100
CODE_04B22C:
	STA.b $00
	LDY.b $02
	CPY.b #$01
	BRA.b CODE_04B277

DATA_04B234:
	dw $0020,$0010

CODE_04B238:
	STZ.b $18,x
	LDY.b #$00
	LDA.w $7A38,x
	EOR.w $7901,x
	BPL.b CODE_04B246
	INY
	INY
CODE_04B246:
	LDA.w $7A38,x
	BPL.b CODE_04B24F
	EOR.w #$FFFF
	INC
CODE_04B24F:
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	CMP.w #$0400
	BPL.b CODE_04B25C
	LDA.w #$0020
	BRA.b CODE_04B270

CODE_04B25C:
	LDA.w DATA_04B234,y
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
CODE_04B270:
	STA.b $00
	LDY.w $7A39,x
	CPY.b #$00
CODE_04B277:
	BPL.b CODE_04B295
	LDA.w $7900,x
	CLC
	ADC.b $00
	STA.w $7900,x
	LDA.w $7902,x
	ADC.w #$0000
	STA.w $7902,x
	LDA.w #$0100
	CMP.w $7901,x
	BPL.b CODE_04B2B2
	BRA.b CODE_04B2AF

CODE_04B295:
	LDA.w $7900,x
	SEC
	SBC.b $00
	STA.w $7900,x
	LDA.w $7902,x
	SBC.w #$0000
	STA.w $7902,x
	LDA.w #$FF00
	CMP.w $7901,x
	BMI.b CODE_04B2B2
CODE_04B2AF:
	STA.w $7901,x
CODE_04B2B2:
	RTS

CODE_04B2B3:
	JSL.l CODE_03A299
	BCC.b CODE_04B2CF
	LDY.b $78,x
CODE_04B2BB:
	BNE.b CODE_04B2CF
	PLA
	LDY.b $16,x
	BEQ.b CODE_04B2C9
	STZ.w $0CB2
	JML.l CODE_03A31E

CODE_04B2C9:
	INC.b $16,x
	JSR.w CODE_04B601
	RTL

CODE_04B2CF:
	LDA.w #$0004
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #DATA_04B32F
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $7A39,x
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7680,x
	CLC
	ADC.w #$0008
	STA.w $6040
	LDA.w $7682,x
	CLC
	ADC.w #$0010
	STA.w $6042
	LDX.b #FXCODE_08E447>>16
	LDA.w #FXCODE_08E447
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	JSL.l CODE_00BE39	: db $40,$50,$7E,$72,$33,$70,$48,$03
	SEP.b #$30
	LDA.b #$11
	STA.w $0967
	LDA.b #$06
	STA.w $0968
	LDA.b #$20
	STA.w $096C
	LDA.b #$08
	TSB.w $095E
	LDA.b #$18
	TSB.w $094A
	REP.b #$20
	LDX.b $12
	RTS

DATA_04B32F:
	db $10,$74,$F0,$75,$F1,$76,$F3,$77,$F6,$77,$FA,$76,$FD,$75,$FF,$74
	db $00,$8C,$00,$8B,$FF,$8A,$FD,$89,$FA,$89,$F6,$8A,$F3,$8B,$F1,$8C
	db $F0

;---------------------------------------------------------------------------

DATA_04B350:
	dw CODE_04B363
	dw CODE_04B467

CODE_04B354:
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_04B350,x)
	LDA.w #$0002
	STA.w $6F00,x
	RTL

CODE_04B363:
	TYX
	LDA.w #$0000
	STA.l $70336C
	STZ.w $1060
	SEP.b #$20
	LDA.b #$61
	STA.w $095E
	LDA.b #$22
	STA.w $096B
	REP.b #$20
	LDY.w $013A
	CPY.b #$16
	BEQ.b CODE_04B386
	JMP.w CODE_04B42D

CODE_04B386:
	INC.w $1060
	LDA.w #$0001
	STA.w $1064
	LDA.w $608C
	CMP.w #$0C38
	BMI.b CODE_04B3B2
	LDA.w #$00F1
	STA.w $004D
	JSL.l CODE_03AD74
	BCC.b CODE_04B3B2
	LDY.w $7722,x
	STY.b $77,x
	JSL.l CODE_03AD74
	BCS.b CODE_04B3B3
	JSL.l CODE_03AEFD
CODE_04B3B2:
	RTS

CODE_04B3B3:
	STZ.w $60A8
	STZ.w $60B4
	JSL.l CODE_04F74A
	LDA.w #$0048
	JSL.l CODE_03A34C
	LDA.w #$0000
	STA.w $70E2,y
	LDA.w $6094
	SEC
	SBC.w #$0060
	STA.w $70E2,x
	LDA.w $6090
	SEC
	SBC.w #$0020
	STA.w $7182,x
	LDA.w #$0003
	STA.w $74A2,x
	LDA.w #$0004
	STA.w $7542,x
	LDA.w #$0080
	STA.w $7220,x
	LDA.w #$0002
	STA.w $7400,x
	LDY.b #$04
	STY.b $76,x
	LDX.b #$20
CODE_04B3FC:
	LDA.l $702E8C,x
	STA.l $7021C0,x
	DEX
	DEX
	BPL.b CODE_04B3FC
	LDX.b #$C0
	LDA.w #$0000
CODE_04B40D:
	STA.l $702F6A,x
	DEX
	DEX
	BNE.b CODE_04B40D
	LDX.b #$20
CODE_04B417:
	LDA.l $7020BE,x
	STA.l $70302A,x
	LDA.l $7020DE,x
	STA.l $70304A,x
	DEX
	DEX
	BNE.b CODE_04B417
	BRA.b CODE_04B44A

CODE_04B42D:
	INC.b $76,x
	LDX.b #$20
CODE_04B431:
	LDA.l $701FFE,x
	STA.l $702F6A,x
	DEX
	DEX
	BNE.b CODE_04B431
	LDX.b #$E0
	LDA.w #$0000
CODE_04B442:
	STA.l $702F8A,x
	DEX
	DEX
	BNE.b CODE_04B442
CODE_04B44A:
	LDX.b #$00
CODE_04B44C:
	LDA.l $7020FE,x
	STA.l $70306A,x
	DEX
	DEX
	BNE.b CODE_04B44C
	LDX.b $12
	LDY.w $1060
	BEQ.b CODE_04B48A
	LDA.w #$0080
	STA.w $7A98,x
	PLA
	RTL

CODE_04B467:
	TYX
	LDA.l $70336C
	CMP.w #$0011
	BPL.b CODE_04B48B
	LDA.w #$2D6C
	STA.l $70336E
	LDA.w #$2F6C
	STA.l $703370
	LDX.b #FXCODE_08B4A9>>16
	LDA.w #FXCODE_08B4A9
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_04B48A:
	RTS

CODE_04B48B:
	JSL.l CODE_03AD74
	BCC.b CODE_04B4A0
	LDY.w $7722,x
	STY.b $77,x
	JSL.l CODE_03AD74
	BCS.b CODE_04B4A1
	JSL.l CODE_03AEFD
CODE_04B4A0:
	RTS

CODE_04B4A1:
	LDA.l DATA_5FDFF4
	STA.l $702D76
	LDA.l DATA_5FDFF6
	STA.l $702D78
	LDY.w $7400,x
	STY.b $18,x
	LDX.b #$00
CODE_04B4B8:
	LDA.l $701FFE,x
	STA.l $702F6A,x
	LDA.l $702D6A,x
	STA.l $701FFE,x
	DEX
	DEX
	BNE.b CODE_04B4B8
	LDX.b $12
	LDY.b #$00
	STY.b $76,x
	LDA.w #$0009
	STA.w $004D
	PLA
	RTL

;---------------------------------------------------------------------------

DATA_04B4DA:
	dw CODE_04BA6D
	dw CODE_04BAA2
	dw CODE_04BAC4
	dw CODE_04BB6B
	dw CODE_04BB8F
	dw CODE_04BC08
	dw CODE_04BC43
	dw CODE_04BD41

CODE_04B4EA:
	LDY.b $76,x
	CPY.b #$03
	BEQ.b CODE_04B4F8
	LDA.w $7040,x
	AND.w #$0001
	BEQ.b CODE_04B4FE
CODE_04B4F8:
	JSL.l CODE_03AF23
	BRA.b CODE_04B50B

CODE_04B4FE:
	JSR.w CODE_04B541
	JSR.w CODE_04B5A2
	JSL.l CODE_03AF23
	JSR.w CODE_04B712
CODE_04B50B:
	LDY.b $76,x
	TYA
	ASL
	TXY
	TAX
	JSR.w (DATA_04B4DA,x)
	LDY.b $76,x
	CPY.b #$02
	BPL.b CODE_04B52C
	JSR.w CODE_04B905
	JSR.w CODE_04B9C5
	JSR.w CODE_04B645
	JSR.w CODE_04B6D4
	JSR.w CODE_04B808
	JSR.w CODE_04B8E4
CODE_04B52C:
	LDY.w $1066
	BEQ.b CODE_04B540
	LDA.w $7A36,x
	CMP.b $16,x
	BNE.b CODE_04B540
	LDY.w $7D36,x
	BMI.b CODE_04B540
	STZ.w $1066
CODE_04B540:
	RTL

CODE_04B541:
	LDY.w $74A2,x
	BMI.b CODE_04B54B
	LDA.w $7362,x
	BPL.b CODE_04B54C
CODE_04B54B:
	RTS

CODE_04B54C:
	JSL.l CODE_03AA52
	REP.b #$10
	LDA.w $7362,x
	CLC
	ADC.w #$0020
	TAY
	LDA.w $7722,x
	PHA
	LDA.b $77,x
	AND.w #$00FF
	STA.w $7722,x
	JSL.l CODE_03AA60
	PLA
	STA.w $7722,x
	LDA.w $7680,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7682,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $105C
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$FFF0
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $7400,x
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	TXA
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDX.b #FXCODE_08A248>>16
	LDA.w #FXCODE_08A248
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_04B5A1:
	RTS

CODE_04B5A2:
	LDA.w #$0004
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDY.b $18,x
	LDA.w DATA_04BD83,y
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7680,x
	CLC
	ADC.w #$0008
	STA.w $6000
	LDA.w $7682,x
	STA.w $6002
	STZ.w $6004
	STZ.w $6006
	STZ.w $600E
	LDA.w #$3516
	STA.w $600A
	LDA.w #$3372
	STA.w $600C
CODE_04B5DD:
	LDX.b #FXCODE_08E315>>16
	LDA.w #FXCODE_08E315
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	JSL.l CODE_00BE39	: db $40,$50,$7E,$72,$33,$70,$48,$03
	SEP.b #$30
	LDA.b #$18
	TSB.w $094A
	REP.b #$20
	LDX.b $12
	RTS

CODE_04B601:
	LDX.b #FXCODE_08D46A>>16
	LDA.w #FXCODE_08D46A
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	JSL.l CODE_00BE39	: db $40,$50,$7E,$72,$33,$70,$48,$03
	SEP.b #$10
	REP.b #$20
	LDX.b $12
	LDA.w $7360,x
	CMP.w #$003D
	BNE.b CODE_04B62B
	LDA.w $7A36,x
	BRA.b CODE_04B638

CODE_04B62B:
	LDY.w $1060
	BNE.b CODE_04B635
	LDA.w #$0314
	BRA.b CODE_04B638

CODE_04B635:
	LDA.w #$0512
CODE_04B638:
	STA.w $0967
	SEP.b #$20
	LDA.b #$18
	TSB.w $094A
	REP.b #$20
	RTS

CODE_04B645:
	LDA.w $7A36,x
	CMP.b $16,x
	BMI.b CODE_04B69A
	LDY.w $77C2,x
	TYA
	STA.b $00
	LDY.b $18,x
	CPY.b #$04
	BMI.b CODE_04B69B
	CPY.b #$08
	BEQ.b CODE_04B69A
	LDY.w $7D36,x
	BMI.b CODE_04B69A
	LDA.b $00
	CMP.w $7400,x
	BEQ.b CODE_04B66F
	LDY.b #$01
	STY.b $79,x
	STY.b $76,x
	RTS

CODE_04B66F:
	LDA.w $60C4
	CMP.w $7400,x
	BNE.b CODE_04B67B
	CMP.b $00
	BEQ.b CODE_04B694
CODE_04B67B:
	LDA.w $7AF8,x
	BNE.b CODE_04B69A
	LDY.b $76,x
	CPY.b #$01
	BEQ.b CODE_04B694
	LDY.b $18,x
	TYA
	AND.w #$0002
	TAY
	STY.b $18,x
	LDY.b #$F8
	STY.b $19,x
	RTS

CODE_04B694:
	LDA.w #$0020
	STA.w $7AF8,x
CODE_04B69A:
	RTS

CODE_04B69B:
	LDA.w $7400,x
	DEC
	EOR.w $7C16,x
	BPL.b CODE_04B6B9
	LDY.w $1066
	BNE.b CODE_04B6B9
	LDY.b #$F8
	STY.b $19,x
	LDA.w $60C4
	CMP.w $7400,x
	BNE.b CODE_04B6D3
	CMP.b $00
	BNE.b CODE_04B6D3
CODE_04B6B9:
	LDY.b $18,x
	TYA
	CLC
	ADC.w #$0004
	TAY
	STY.b $18,x
	STZ.w $7220,x
	STZ.w $7222,x
	STZ.w $7540,x
	STZ.w $7542,x
	LDY.b #$08
	STY.b $19,x
CODE_04B6D3:
	RTS

CODE_04B6D4:
	LDY.b $79,x
	BEQ.b CODE_04B711
	LDA.w $7AF6,x
	BNE.b CODE_04B711
	LDA.w #$0002
	STA.w $7AF6,x
	TYA
	CPY.b #$00
	BPL.b CODE_04B6EB
	ORA.w #$FF00
CODE_04B6EB:
	CLC
	ADC.w $105C
	CMP.w #$FFF4
	BNE.b CODE_04B705
	STA.w $105C
	LDA.w $7400,x
	EOR.w #$0002
	STA.w $7400,x
	LDY.b #$FF
	STY.b $79,x
	RTS

CODE_04B705:
	CMP.w #$FFEC
	BNE.b CODE_04B70E
	LDY.b #$00
	STY.b $79,x
CODE_04B70E:
	STA.w $105C
CODE_04B711:
	RTS

CODE_04B712:
	LDA.b $16,x
	LDY.b $76,x
	CPY.b #$07
	BEQ.b CODE_04B745
	CPY.b #$04
	BPL.b CODE_04B72E
	CPY.b #$02
	BEQ.b CODE_04B748
	LDA.w $7A36,x
	CMP.b $16,x
	BPL.b CODE_04B72E
	LDA.w #$0002
	BRA.b CODE_04B742

CODE_04B72E:
	LDA.b $18,x
	BIT.w #$0008
	BEQ.b CODE_04B738
	LDA.w #$0004
CODE_04B738:
	AND.w #$0004
	LSR
	LSR
	CMP.w $7402,x
	BEQ.b CODE_04B7AD
CODE_04B742:
	STA.w $7402,x
CODE_04B745:
	LDA.w $7A36,x
CODE_04B748:
	SEC
	SBC.w #$01C0
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$FF90
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w #$0100
	SEC
	SBC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.b $04
	LDY.b $76,x
	CPY.b #$02
	BNE.b CODE_04B772
	LDA.w #$0100
CODE_04B772:
	STA.b $02
	LDA.w $7722,x
	STA.b $06
	LDY.b $77,x
	TYA
	STA.b $08
	LDY.w $7402,x
	DEY
	BEQ.b CODE_04B7A0
	BMI.b CODE_04B793
	LDY.b #$06
	JSR.w CODE_04B7CC
	LDA.b $08
CODE_04B78C:
	STA.b $06
	LDY.b #$08
	BRA.b CODE_04B7A2

CODE_04B793:
	LDY.b #$00
	JSR.w CODE_04B7CC
	LDA.b $08
	STA.b $06
	LDY.b #$02
	BRA.b CODE_04B7A2

CODE_04B7A0:
	LDY.b #$04
CODE_04B7A2:
	JSR.w CODE_04B7CC
	LDX.b $12
	INC.w $0CF9
	JSR.w CODE_04B541
CODE_04B7AD:
	RTS

DATA_04B7AE:
	dw $4041,$6041,$4061,$2001,$6061


DATA_04B7B8:
	dw $0055,$0055,$0055,$0055,$0056

DATA_04B7C2:
	dw $0020,$0000,$0010,$0020,$0000

CODE_04B7CC:
	LDA.w DATA_04B7AE,y
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w DATA_04B7B8,y
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.b $02
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDA.b $04
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0010
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w DATA_04B7C2,y
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDX.b $06
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_088295>>16
	LDA.w #FXCODE_088295
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	RTS

CODE_04B808:
	LDY.b $78,x
	BNE.b CODE_04B81E
	LDA.b $16,x
	CMP.w $7A36,x
	BNE.b CODE_04B81E
	LDY.b $19,x
	DEY
	BPL.b CODE_04B81E
	JSR.w CODE_04B81F
	JSR.w CODE_04B82E
CODE_04B81E:
	RTS

CODE_04B81F:
	LDY.w $7D36,x
	BPL.b CODE_04B82D
	LDY.w $1066
	BNE.b CODE_04B82D
	JSL.l CODE_03A858
CODE_04B82D:
	RTS

CODE_04B82E:
	TXA
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_098F33>>16
	LDA.w #FXCODE_098F33
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDY.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	BMI.b CODE_04B82D
	LDA.w $7BB6,x
	CLC
	ADC.w $7BB6,y
	ASL
	STA.b $00
	LSR
	CLC
	ADC.w $7CD6,y
	SEC
	SBC.w $7CD6,x
	CMP.b $00
	BCS.b CODE_04B82D
	LDA.w $7BB8,x
	CLC
	ADC.w $7BB8,y
	ASL
	STA.b $00
	LSR
	CLC
	ADC.w $7CD8,y
	SEC
	SBC.w $7CD8,x
	CMP.b $00
	BCS.b CODE_04B82D
	LDA.w $7360,y
	CMP.w #$0022
	BCC.b CODE_04B82D
	CMP.w #$002C
	BCS.b CODE_04B82D
	PHY
	TYX
	JSL.l CODE_03B25B
	PLY
	LDA.w $7A36,x
	CMP.b $16,x
	BNE.b CODE_04B8E3
	LDA.w $7978,y
	CMP.w #$0002
	BPL.b CODE_04B8E3
	STZ.w $7220,x
	STZ.w $7222,x
	STZ.w $7540,x
	STZ.w $7542,x
	INC.w $1066
	LDA.w #$0078
	JSL.l CODE_0085D2
	LDA.b $16,x
	CLC
	ADC.w #$0018
	STA.w $105E
	CLC
	ADC.w #$0030
	CMP.w #$01C1
	BMI.b CODE_04B8DF
	STA.b $16,x
	LDY.b #$08
	STY.b $19,x
	JSL.l CODE_02A982
	STZ.w $0C48
	LDA.w #$0000
	STA.l $70336C
	LDA.w #$0002
	STA.w $7402,x
	INC.w $0B7B
	LDY.b #$02
	STY.b $76,x
	JMP.w CODE_04BB4E

CODE_04B8DF:
	STA.b $16,x
	INC.b $78,x
CODE_04B8E3:
	RTS

CODE_04B8E4:
	LDA.w #$0030
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.w $7BB6,x
	STA.w $7BB8,x
	RTS

CODE_04B905:
	LDY.b #$60
	LDA.b $78,x
	AND.w #$00FF
	BEQ.b CODE_04B917
	LDY.b #$64
	LDA.w $1060
	BEQ.b CODE_04B917
	LDY.b #$62
CODE_04B917:
	STY.w $096C
	LDY.b $19,x
	BEQ.b CODE_04B941
	TYA
	CPY.b #$00
	BPL.b CODE_04B926
	ORA.w #$FF00
CODE_04B926:
	STA.b $00
	LDY.b $78,x
	TYA
	CLC
	ADC.b $00
	BMI.b CODE_04B939
	CMP.w #$0100
	BMI.b CODE_04B942
	LDY.b #$FF
	BRA.b CODE_04B93B

CODE_04B939:
	LDY.b #$00
CODE_04B93B:
	STY.b $78,x
	LDY.b #$00
	STY.b $19,x
CODE_04B941:
	RTS

CODE_04B942:
	TAY
	STY.b $78,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w $1060
	BNE.b CODE_04B970
	LDA.w #DATA_5FDFF8
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDA.w #DATA_5FDFF8>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0005
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$0002
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08E167>>16
	LDA.w #FXCODE_08E167
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	BRA.b CODE_04B9B2

CODE_04B970:
	LDA.w #DATA_5FE878
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDA.w #DATA_5FE878>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0061
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$000E
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08E167>>16
	LDA.w #FXCODE_08E167
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #DATA_5FE894
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDA.w #DATA_5FE894>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0071
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$000E
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08E167>>16
	LDA.w #FXCODE_08E167
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
CODE_04B9B2:
	LDX.b $12
	RTS

DATA_04B9B5:
	dw $7F26,$7FFF,$6F35,$0000,$7F26,$477F,$323F,$7FFF

CODE_04B9C5:
	LDY.w $1064
	BNE.b CODE_04B9F8
	LDA.w $7A36,x
	CMP.b $16,x
	BPL.b CODE_04B9F8
	LDY.w $0CE8
	BEQ.b CODE_04B9DD
	LDA.w $1060
	BNE.b CODE_04BA0B
	BRA.b CODE_04BA19

CODE_04B9DD:
	CMP.w $105E
	BMI.b CODE_04B9F9
	LDA.w #$0020
	STA.w $0CE8
	LDA.w $105E
	CLC
	ADC.w #$0018
	CMP.b $16,x
	BMI.b CODE_04B9F5
	LDA.b $16,x
CODE_04B9F5:
	STA.w $105E
CODE_04B9F8:
	RTS

CODE_04B9F9:
	CLC
	ADC.w #$0008
	STA.w $7A36,x
	CMP.b $16,x
	BMI.b CODE_04BA0B
	LDY.w $1060
	BEQ.b CODE_04BA19
	BRA.b CODE_04BA3B

CODE_04BA0B:
	LDA.w $7974
	LDY.w $1060
	BNE.b CODE_04BA36
	AND.w #$0002
	ASL
	ASL
	TAY
CODE_04BA19:
	LDA.w DATA_04B9B5,y
	STA.l $702008
	LDA.w DATA_04B9B5+$02,y
	STA.l $70200A
	LDA.w DATA_04B9B5+$04,y
	STA.l $70200C
	LDA.w DATA_04B9B5+$06,y
	STA.l $70200E
	RTS

CODE_04BA36:
	AND.w #$0002
	BNE.b CODE_04BA54
CODE_04BA3B:
	LDX.b #$1C
CODE_04BA3D:
	LDA.l DATA_5FE83E,x
	STA.l $7020C0,x
	LDA.l DATA_5FE85A,x
	STA.l $7020E0,x
	DEX
	DEX
	BNE.b CODE_04BA3D
	LDX.b $12
	RTS

CODE_04BA54:
	LDX.b #$1C
CODE_04BA56:
	LDA.l DATA_5FA56E,x
	STA.l $7020C0,x
	STA.l $7020E0,x
	DEX
	DEX
	BNE.b CODE_04BA56
	LDX.b $12
	RTS

DATA_04BA69:
	dw $FF80,$0080

CODE_04BA6D:
	TYX
	LDY.b $18,x
	CPY.b #$03
	BPL.b CODE_04BAA1
	LDA.w $7A96,x
	BNE.b CODE_04BAA1
	LDA.w #$0020
	STA.w $7A96,x
	LDA.w $7A36,x
	CMP.b $16,x
	BNE.b CODE_04BAA1
	LDY.w $77C2,x
	LDA.w DATA_04BA69,y
	STA.w $75E0,x
	LDY.w $77C3,x
	LDA.w DATA_04BA69,y
	STA.w $75E2,x
	LDA.w #$0002
	STA.w $7540,x
	STA.w $7542,x
CODE_04BAA1:
	RTS

CODE_04BAA2:
	TYX
	LDA.w $105C
	SEC
	SBC.w #$FFF1
	CMP.w #$0006
	BCS.b CODE_04BAB3
	LDY.b #$08
	BRA.b CODE_04BABB

CODE_04BAB3:
	LDA.w $7400,x
	CLC
	ADC.w #$0004
	TAY
CODE_04BABB:
	STY.b $18,x
	LDY.b $79,x
	BNE.b CODE_04BAC3
	STY.b $76,x
CODE_04BAC3:
	RTS

CODE_04BAC4:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_04BAF4
	LDA.w $7A36,x
	CMP.b $16,x
	BPL.b CODE_04BB1A
	CMP.w $105E
	BNE.b CODE_04BAE5
	CLC
	ADC.w #$0018
	STA.w $105E
	LDA.w #$0020
	STA.w $7A96,x
	BRA.b CODE_04BAF4

CODE_04BAE5:
	CLC
	ADC.w #$0008
	CMP.w #$0200
	BMI.b CODE_04BAF1
	LDA.w #$01FF
CODE_04BAF1:
	STA.w $7A36,x
CODE_04BAF4:
	JSR.w CODE_04BA0B
	LDA.l $70336C
	CMP.w #$0020
	BPL.b CODE_04BB19
	LDA.w #$2F6C
	STA.l $70336E
	LDA.w #$2D6C
	STA.l $703370
	LDX.b #FXCODE_08B4A9>>16
	LDA.w #FXCODE_08B4A9
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
CODE_04BB19:
	RTS

CODE_04BB1A:
	LDA.w #$012E
	JSL.l CODE_03A34C
	BCC.b CODE_04BB4D
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
	LDA.w #$0002
	STA.w $79D6,y
	LDA.w #$0081
	JSL.l CODE_0085D2
	JSR.w CODE_04B601
	LDA.w #$0040
	STA.w $7A96,x
	LDA.w #$0050
	STA.w $61C6
	INC.b $76,x
CODE_04BB4D:
	RTS

CODE_04BB4E:
	LDX.b #$00
CODE_04BB50:
	LDA.l $702F6A,x
	STA.l $701FFE,x
	DEX
	DEX
	BNE.b CODE_04BB50
	LDX.b $12
	LDA.w #$0000
	STA.l $70336C
	LDY.b #$20
	STY.w $096C
	RTS

CODE_04BB6B:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_04BB4D
	LDA.w $70E2,x
	STA.b $00
	LDA.w $7182,x
	STA.b $02
	JSL.l CODE_02E19C
	LDA.w #$0100
	STA.w $7A96,x
	PLA
	JML.l CODE_03A32E

CODE_04BB8A:
	RTS

DATA_04BB8B:
	dw $FF80,$0080

CODE_04BB8F:
	TYX
	STZ.w $60C4
	LDA.w $7A98,x
	BNE.b CODE_04BBA1
	LDA.w #$0009
	STA.w $004D
	DEC.w $7A98,x
CODE_04BBA1:
	LDA.w $7C16,x
	SEC
	SBC.w #$FFA0
	BNE.b CODE_04BBB6
	INC.w $7540,x
	INC.w $1015
	STZ.w $7A98,x
	INC.b $76,x
	RTS

CODE_04BBB6:
	STA.w $0C1E
	LDA.w $0039
	CMP.w #$0BC0
	BEQ.b CODE_04BBDB
	SEC
	SBC.w #$0BC0
	STA.b $00
	LDA.w $7974
	AND.w #$0001
	PHP
	LDA.w $0039
	PLP
	BNE.b CODE_04BBDB
	DEC
	LDY.b $01
	BPL.b CODE_04BBDB
	INC
	INC
CODE_04BBDB:
	STA.w $0C23
	LDA.w $7C18,x
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	EOR.w #$FFFF
	SEC
	ADC.w $7222,x
	STA.w $7222,x
CODE_04BBF3:
	LDA.w $7A96,x
	BNE.b CODE_04BC07
	LDA.w #$0020
	STA.w $7A96,x
	LDY.w $77C3,x
	LDA.w DATA_04BB8B,y
	STA.w $75E2,x
CODE_04BC07:
	RTS

CODE_04BC08:
	TYX
	LDA.w $7220,x
	BPL.b CODE_04BC14
	STZ.w $7220,x
	STZ.w $7540,x
CODE_04BC14:
	LDA.w $1015
	BMI.b CODE_04BC3A
	CMP.w #$0002
	BMI.b CODE_04BBF3
	STZ.w $75E2,x
	LDA.w #$0002
	STA.w $7542,x
	LDA.w $7222,x
	CLC
	ADC.w #$0002
	CMP.w #$0004
	BCS.b CODE_04BC42
	STZ.w $7222,x
	STZ.w $7542,x
	RTS

CODE_04BC3A:
	LDA.w #$0030
	STA.w $7A96,x
	INC.b $76,x
CODE_04BC42:
	RTS

CODE_04BC43:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_04BC42
	LDA.l $70336C
	CMP.w #$0011
	BPL.b CODE_04BC6C
	LDA.w #$2D6C
	STA.l $70336E
	LDA.w #$2F6C
	STA.l $703370
	LDX.b #FXCODE_08B4A9>>16
	LDA.w #FXCODE_08B4A9
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	RTS

CODE_04BC6C:
	LDX.b #$1C
CODE_04BC6E:
	LDA.l DATA_5FE83E,x
	STA.l $702E2C,x
	STA.l $7020C0,x
	LDA.l DATA_5FE85A,x
	STA.l $702E4C,x
	STA.l $7020E0,x
	DEX
	DEX
	BNE.b CODE_04BC6E
	LDY.b #!REGISTER_BG2HorizScrollOffset
	STY.w HDMA[$03].Destination
	INY
	STY.w HDMA[$04].Destination
	LDA.w #$0512
	STA.w $0967
	LDY.b #$60
	STY.w $096C
	LDX.b #$00
CODE_04BCA0:
	LDA.l $701FFE,x
	STA.l $702F6A,x
	LDA.l $702D6A,x
	STA.l $701FFE,x
	DEX
	DEX
	BNE.b CODE_04BCA0
	LDX.b $12
	LDA.w #$4002
	STA.w $7040,x
	LDA.w #$0007
	STA.w $74A2,x
	SEP.b #$20
	LDA.b #$22
	STA.w $7042,x
	STZ.w $7180,x
	REP.b #$20
	LDA.w #$0050
	STA.b $16,x
	LDA.w #$0040
	STA.w $7A36,x
	SEC
	SBC.w #$01C0
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$FF90
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w #$0100
	SEC
	SBC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	STA.b $02
	STA.b $04
	LDA.w $7722,x
	STA.b $06
	LDY.b $77,x
	TYA
	STA.b $08
	LDY.b #$00
	JSR.w CODE_04B7CC
	LDA.b $08
	STA.b $06
	LDY.b #$02
	JSR.w CODE_04B7CC
	LDX.b $12
	INC.w $0CF9
	LDA.w #$FFEC
	STA.w $105C
	LDA.w $7182,x
	SEC
	SBC.w #$0004
	STA.w $7182,x
	LDA.w #$0002
	STA.b $18,x
	LDY.b #$00
	STY.b $78,x
	JSR.w CODE_04B601
	LDA.w #$0040
	STA.w $7A96,x
	STZ.w $1015
	INC.b $76,x
	RTS

CODE_04BD41:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_04BD82
	LDA.w $7A36,x
	CLC
	ADC.w #$0002
	STA.w $7A36,x
	CMP.b $16,x
	BMI.b CODE_04BD82
	LDA.w #$0020
	STA.w $7A96,x
	LDA.b $16,x
	CLC
	ADC.w #$0010
	CMP.w #$0090
	BNE.b CODE_04BD80
	STZ.w $60AC
	LDY.b #$00
	STY.b $76,x
	STZ.w $7A96,x
	STZ.w $0C1E
	STZ.w $1064
	LDA.w #$01DE
	JSL.l CODE_039788
	LDA.w #$0080
CODE_04BD80:
	STA.b $16,x
CODE_04BD82:
	RTS

DATA_04BD83:
	dw DATA_04BD8D,DATA_04BF6F,DATA_04C060,DATA_04C151,DATA_04BE7E

DATA_04BD8D:
	db $78,$06,$10,$06,$1A,$06,$22,$06,$28,$06,$2E,$06,$32,$06,$36,$06
	db $3A,$06,$3C,$06,$40,$06,$42,$06,$46,$06,$48,$06,$4A,$06,$4E,$06
	db $50,$06,$52,$06,$54,$06,$56,$06,$58,$06,$5A,$06,$5A,$06,$5C,$06
	db $5E,$02,$76,$02,$7A,$02,$7C,$01,$7D,$01,$7D,$01,$7D,$01,$7D,$01
	db $7D,$01,$7D,$02,$7C,$02,$7C,$01,$7B,$02,$7A,$02,$7A,$02,$78,$02
	db $77,$02,$76,$03,$76,$03,$75,$04,$74,$04,$73,$05,$73,$06,$72,$06
	db $72,$06,$72,$06,$72,$06,$74,$06,$74,$06,$74,$06,$74,$06,$74,$06
	db $74,$06,$74,$06,$74,$06,$74,$05,$75,$05,$75,$05,$75,$05,$75,$05
	db $75,$05,$76,$05,$76,$05,$76,$05,$76,$04,$77,$04,$77,$04,$76,$03
	db $77,$03,$77,$03,$78,$03,$78,$02,$78,$01,$79,$01,$79,$01,$7A,$00
	db $7A,$FF,$7B,$FF,$7C,$FE,$7C,$FE,$7C,$FE,$7C,$FD,$7B,$FE,$7A,$FD
	db $79,$FD,$77,$FE,$76,$FD,$75,$FD,$73,$FE,$72,$FD,$71,$FD,$6F,$FD
	db $6D,$FE,$6C,$FE,$6A,$FE,$68,$FE,$66,$FE,$64,$FE,$62,$FE,$60,$FE
	db $5E,$FE,$5B,$FE,$59,$FE,$56,$FE,$53,$FE,$51,$FE,$4D,$FF,$4A,$FF
	db $46,$FF,$42,$FF,$3E,$FF,$3A,$FF,$35,$FF,$2F,$FF,$27,$FF,$1F,$FF
	db $13

DATA_04BE7E:
	db $78,$00,$10,$00,$1A,$00,$22,$00,$28,$00,$2E,$00,$32,$00,$36,$00
	db $3A,$00,$3C,$00,$40,$00,$42,$00,$46,$00,$48,$00,$4A,$00,$4E,$00
	db $50,$00,$52,$00,$54,$00,$56,$00,$58,$00,$58,$00,$5A,$00,$5C,$00
	db $5E,$00,$5E,$00,$60,$00,$62,$00,$62,$00,$64,$00,$66,$00,$66,$00
	db $68,$00,$68,$00,$6A,$00,$6A,$00,$6C,$00,$6C,$00,$6C,$00,$6E,$00
	db $6E,$00,$6E,$00,$70,$00,$70,$00,$70,$00,$70,$00,$72,$00,$72,$00
	db $72,$00,$72,$00,$72,$00,$74,$00,$74,$00,$74,$00,$74,$00,$74,$00
	db $74,$00,$74,$00,$74,$00,$74,$00,$74,$00,$74,$00,$74,$00,$74,$00
	db $74,$00,$74,$00,$74,$00,$74,$00,$74,$00,$74,$00,$74,$00,$72,$00
	db $72,$00,$72,$00,$72,$00,$72,$00,$70,$00,$70,$00,$70,$00,$70,$00
	db $6E,$00,$6E,$00,$6E,$00,$6C,$00,$6C,$00,$6C,$00,$6A,$00,$6A,$00
	db $68,$00,$68,$00,$66,$00,$66,$00,$64,$00,$62,$00,$62,$00,$60,$00
	db $5E,$00,$5E,$00,$5C,$00,$5A,$00,$58,$00,$58,$00,$56,$00,$54,$00
	db $52,$00,$50,$00,$4E,$00,$4A,$00,$48,$00,$46,$00,$42,$00,$40,$00
	db $3C,$00,$3A,$00,$36,$00,$32,$00,$2E,$00,$28,$00,$22,$00,$1A,$00
	db $10

DATA_04BF6F:
	db $78,$FA,$10,$FA,$1A,$FA,$22,$FA,$28,$FA,$2E,$FA,$32,$FA,$36,$FA
	db $3A,$FA,$3C,$FA,$40,$FA,$42,$FA,$46,$FA,$48,$FA,$4A,$FA,$4E,$FA
	db $50,$FA,$52,$FA,$54,$FA,$56,$FA,$58,$FA,$5A,$FA,$5A,$FA,$5C,$FA
	db $5E,$FE,$76,$FE,$7A,$FE,$7C,$FE,$7D,$FE,$7D,$FE,$7D,$FE,$7D,$FE
	db $7D,$FE,$7D,$FE,$7C,$FE,$7C,$FE,$7B,$FE,$7A,$FE,$7A,$FE,$78,$FD
	db $77,$FE,$76,$FD,$76,$FC,$75,$FC,$74,$FB,$73,$FA,$73,$FA,$72,$FA
	db $72,$FA,$72,$FA,$72,$FA,$74,$FA,$74,$FA,$74,$FA,$74,$FA,$74,$FA
	db $74,$FA,$74,$FA,$74,$FA,$74,$FA,$75,$FA,$75,$FA,$75,$FA,$75,$FA
	db $75,$FB,$76,$FB,$76,$FB,$76,$FB,$76,$FB,$77,$FB,$77,$FC,$76,$FC
	db $77,$FC,$77,$FD,$78,$FD,$78,$FE,$78,$FE,$79,$FE,$79,$FF,$7A,$00
	db $7A,$00,$7B,$01,$7C,$02,$7C,$02,$7C,$02,$7C,$02,$7B,$02,$7A,$02
	db $79,$02,$77,$02,$76,$02,$75,$02,$73,$02,$72,$02,$71,$02,$6F,$02
	db $6D,$02,$6C,$02,$6A,$02,$68,$02,$66,$02,$64,$02,$62,$02,$60,$02
	db $5E,$01,$5B,$01,$59,$02,$56,$01,$53,$01,$51,$01,$4D,$01,$4A,$01
	db $46,$01,$42,$01,$3E,$01,$3A,$00,$35,$00,$2F,$00,$27,$00,$1F,$00
	db $13

DATA_04C060:
	db $78,$06,$10,$06,$1A,$06,$22,$06,$28,$06,$2E,$06,$32,$06,$36,$06
	db $3A,$06,$3C,$06,$40,$06,$42,$06,$46,$06,$48,$06,$4A,$06,$4E,$06
	db $50,$06,$52,$06,$54,$06,$56,$06,$58,$06,$58,$06,$5A,$06,$5C,$06
	db $5E,$06,$5E,$06,$60,$06,$62,$06,$62,$06,$64,$06,$66,$06,$66,$06
	db $68,$06,$68,$06,$6A,$06,$6A,$06,$6C,$06,$6C,$06,$6C,$06,$6E,$06
	db $6E,$06,$6E,$06,$70,$06,$70,$06,$70,$06,$70,$06,$72,$06,$72,$06
	db $72,$06,$72,$06,$72,$06,$74,$06,$74,$06,$74,$06,$74,$06,$74,$06
	db $74,$06,$74,$06,$74,$06,$74,$05,$75,$05,$75,$05,$75,$05,$75,$05
	db $75,$05,$76,$05,$76,$05,$76,$05,$76,$04,$77,$04,$77,$04,$76,$03
	db $77,$03,$77,$03,$78,$03,$78,$02,$78,$01,$79,$01,$79,$01,$7A,$00
	db $7A,$FF,$7B,$FF,$7C,$FE,$7C,$FE,$7C,$FE,$7C,$FD,$7B,$FE,$7A,$FD
	db $79,$FD,$77,$FE,$76,$FD,$75,$FD,$73,$FE,$72,$FD,$71,$FD,$6F,$FD
	db $6D,$FE,$6C,$FE,$6A,$FE,$68,$FE,$66,$FE,$64,$FE,$62,$FE,$60,$FE
	db $5E,$FE,$5B,$FE,$59,$FE,$56,$FE,$53,$FE,$51,$FE,$4D,$FF,$4A,$FF
	db $46,$FF,$42,$FF,$3E,$FF,$3A,$FF,$35,$FF,$2F,$FF,$27,$FF,$1F,$FF
	db $13

DATA_04C151:
	db $78,$FA,$10,$FA,$1A,$FA,$22,$FA,$28,$FA,$2E,$FA,$32,$FA,$36,$FA
	db $3A,$FA,$3C,$FA,$40,$FA,$42,$FA,$46,$FA,$48,$FA,$4A,$FA,$4E,$FA
	db $50,$FA,$52,$FA,$54,$FA,$56,$FA,$58,$FA,$58,$FA,$5A,$FA,$5C,$FA
	db $5E,$FA,$5E,$FA,$60,$FA,$62,$FA,$62,$FA,$64,$FA,$66,$FA,$66,$FA
	db $68,$FA,$68,$FA,$6A,$FA,$6A,$FA,$6C,$FA,$6C,$FA,$6C,$FA,$6E,$FA
	db $6E,$FA,$6E,$FA,$70,$FA,$70,$FA,$70,$FA,$70,$FA,$72,$FA,$72,$FA
	db $72,$FA,$72,$FA,$72,$FA,$74,$FA,$74,$FA,$74,$FA,$74,$FA,$74,$FA
	db $74,$FA,$74,$FA,$74,$FA,$74,$FA,$75,$FA,$75,$FA,$75,$FA,$75,$FA
	db $75,$FB,$76,$FB,$76,$FB,$76,$FB,$76,$FB,$77,$FB,$77,$FC,$76,$FC
	db $77,$FC,$77,$FD,$78,$FD,$78,$FE,$78,$FE,$79,$FE,$79,$FF,$7A,$00
	db $7A,$00,$7B,$01,$7C,$02,$7C,$02,$7C,$02,$7C,$02,$7B,$02,$7A,$02
	db $79,$02,$77,$02,$76,$02,$75,$02,$73,$02,$72,$02,$71,$02,$6F,$02
	db $6D,$02,$6C,$02,$6A,$02,$68,$02,$66,$02,$64,$02,$62,$02,$60,$02
	db $5E,$01,$5B,$01,$59,$02,$56,$01,$53,$01,$51,$01,$4D,$01,$4A,$01
	db $46,$01,$42,$01,$3E,$01,$3A,$00,$35,$00,$2F,$00,$27,$00,$1F,$00
	db $13

;---------------------------------------------------------------------------

DATA_04C242:
	db $80,$7F

CODE_04C244:
	LDA.w $7974
	STA.w $0FF9
	LDY.b #$F0
	STY.b $79,x
	LDY.b #$00
	JSR.w CODE_04C433
	LDA.w #$0004
	STA.b $00
CODE_04C258:
	LDA.b $00
	ASL
	TAY
	LDA.w $0FF9,y
	STA.b $04
	LDA.w $1001,y
	STA.b $06
	LDA.w #$001E
	JSL.l CODE_03A364
	BCC.b CODE_04C2A7
	LDA.b $04
	STA.w $7A36,y
	SEC
	SBC.w #$0008
	STA.w $70E2,y
	LDA.b $06
	STA.w $7A38,y
	SEC
	SBC.w #$0010
	STA.w $7182,y
	LDA.b $00
	ASL
	STA.w $79D8,y
	TXA
	STA.w $7978,y
	LDA.w $0FF9
	STA.w $7900,y
	LDA.w #$0001
	STA.w $7902,y
	LDA.w #$0004
	STA.w $79D6,y
	DEC.b $00
	BNE.b CODE_04C258
CODE_04C2A7:
	LDA.w $70E2,x
	AND.w #$0010
	LSR
	LSR
	LSR
	LSR
	TAY
	LDA.w DATA_04C242,y
	TAY
	STY.b $19,x
CODE_04C2B8:
	STZ.w $7400,x
	SEP.b #$20
	LDA.b #$FF
	STA.w $7863,x
	REP.b #$20
	LDA.w #$8000
	STA.w $75E0,x
	XBA
	STA.w $7900,x
	LDY.b #$F0
	STY.b $79,x
	STZ.w $7BB6,x
	STZ.w $7BB8,x
	LDA.w $7182,x
	SEC
	SBC.w #$0008
	STA.w $7182,x
	LDA.w $0136
	CMP.w #$0003
	BEQ.b CODE_04C2EF
	CMP.w #$000D
	BNE.b CODE_04C2F5
CODE_04C2EF:
	INC.w $7B58,x
	INC.w $7B58,x
CODE_04C2F5:
	RTL

;---------------------------------------------------------------------------

CODE_04C2F6:
	STZ.b $04
	LDA.w $7360,x
	CMP.w #$0056
	BEQ.b CODE_04C30D
	CMP.w #$0064
	BNE.b CODE_04C311
	LDA.w $7182,x
	AND.w #$0010
	BNE.b CODE_04C311
CODE_04C30D:
	INC.b $04
	INC.b $04
CODE_04C311:
	JSR.w CODE_04C332
	JSL.l CODE_03AF23
	LDA.w $7362,x
	BMI.b CODE_04C331
	LDY.w $74A2,x
	BMI.b CODE_04C331
	JSR.w CODE_04C530
	JSR.w CODE_04C776
	JSR.w CODE_04C574
	JSR.w CODE_04C66A
	JSR.w CODE_04C7F4
CODE_04C331:
	RTL

CODE_04C332:
	LDA.w $7362,x
	BMI.b CODE_04C33C
	LDY.w $74A2,x
	BPL.b CODE_04C33D
CODE_04C33C:
	RTS

CODE_04C33D:
	LDY.b $04
	JSR.w CODE_04C433
	LDA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	STA.b $0C
	LDA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.b $0E
	LDA.w $7680,x
	CLC
	ADC.w #$0008
	STA.b $08
	LDA.w $7682,x
	STA.b $0A
	REP.b #$10
	LDY.w $7362,x
	LDA.b $08
	CLC
	ADC.w !REGISTER_SuperFX_R8_MERGEYPosLo
	SEC
	SBC.b $00
	STA.w $6000,y
	CLC
	ADC.b $02
	STA.w $6008,y
	LDA.b $08
	CLC
	ADC.w !REGISTER_SuperFX_R7_MERGEXPosLo
	SEC
	SBC.b $00
	STA.w $6010,y
	CLC
	ADC.b $02
	STA.w $6018,y
	LDA.b $08
	SEC
	SBC.w !REGISTER_SuperFX_R8_MERGEYPosLo
	SEC
	SBC.b $00
	STA.w $6020,y
	CLC
	ADC.b $02
	STA.w $6028,y
	LDA.b $08
	SEC
	SBC.w !REGISTER_SuperFX_R7_MERGEXPosLo
	SEC
	SBC.b $00
	STA.w $6030,y
	CLC
	ADC.b $02
	STA.w $6038,y
	LDA.b $0A
	SEC
	SBC.w !REGISTER_SuperFX_R7_MERGEXPosLo
	STA.w $6002,y
	STA.w $600A,y
	LDA.b $0A
	CLC
	ADC.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w $6012,y
	STA.w $601A,y
	LDA.b $0A
	CLC
	ADC.w !REGISTER_SuperFX_R7_MERGEXPosLo
	STA.w $6022,y
	STA.w $602A,y
	LDA.b $0A
	SEC
	SBC.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w $6032,y
	STA.w $603A,y
	JSR.w CODE_04C4C7
	LDA.b $04
	BEQ.b CODE_04C40B
	LDA.w $6004,y
	AND.w #$F1FF
	ORA.w #$0800
	STA.w $6004,y
	STA.w $6014,y
	STA.w $6024,y
	STA.w $6034,y
	LDA.w $600C,y
	AND.w #$F1FF
	ORA.w #$0800
	STA.w $600C,y
	STA.w $601C,y
	STA.w $602C,y
	STA.w $603C,y
	SEP.b #$10
	RTS

CODE_04C40B:
	LDA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	CLC
	ADC.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	CLC
	ADC.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	TYA
	CLC
	ADC.w #$0020
	TAY
	JSR.w CODE_04C4C7
	SEP.b #$10
	RTS

;---------------------------------------------------------------------------

DATA_04C42B:
	db $10,$10,$0C,$08

DATA_03C42F:
	dw $0028,$0018

CODE_04C433:
	LDA.w DATA_04C42B,y
	AND.w #$00FF
	STA.b $00
	LDA.w DATA_04C42B+$01,y
	AND.w #$00FF
	STA.b $02
	LDA.w DATA_03C42F,y
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0003
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	CPY.b #$00
	BEQ.b CODE_04C456
	DEC.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
CODE_04C456:
	LDY.b $79,x
	TYA
	ASL
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDX.b #FXCODE_0B85D0>>16
	LDA.w #FXCODE_0B85D0
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w $7360,x
	CMP.w #$015E
	BNE.b CODE_04C4C6
	LDA.w $70E2,x
	CLC
	ADC.w #$0008
	STA.b $06
	LDA.w $7182,x
	STA.b $08
	LDA.b $06
	CLC
	ADC.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w $0FFB
	LDA.b $06
	CLC
	ADC.w !REGISTER_SuperFX_R7_MERGEXPosLo
	STA.w $0FFD
	LDA.b $06
	SEC
	SBC.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w $0FFF
	LDA.b $06
	SEC
	SBC.w !REGISTER_SuperFX_R7_MERGEXPosLo
	STA.w $1001
	LDA.b $08
	SEC
	SBC.w !REGISTER_SuperFX_R7_MERGEXPosLo
	STA.w $1003
	LDA.b $08
	CLC
	ADC.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w $1005
	LDA.b $08
	CLC
	ADC.w !REGISTER_SuperFX_R7_MERGEXPosLo
	STA.w $1007
	LDA.b $08
	SEC
	SBC.w !REGISTER_SuperFX_R8_MERGEYPosLo
	STA.w $1009
CODE_04C4C6:
	RTS

;---------------------------------------------------------------------------

CODE_04C4C7:
	LDA.b $08
	CLC
	ADC.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	SEC
	SBC.w #$0004
	STA.w $6048,y
	LDA.b $08
	CLC
	ADC.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	SEC
	SBC.w #$0004
	STA.w $6050,y
	LDA.b $08
	SEC
	SBC.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	SEC
	SBC.w #$0004
	STA.w $6058,y
	LDA.b $08
	SEC
	SBC.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	SEC
	SBC.w #$0004
	STA.w $6060,y
	LDA.b $0A
	SEC
	SBC.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	CLC
	ADC.w #$0004
	STA.w $604A,y
	LDA.b $0A
	CLC
	ADC.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	CLC
	ADC.w #$0004
	STA.w $6052,y
	LDA.b $0A
	CLC
	ADC.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	CLC
	ADC.w #$0004
	STA.w $605A,y
	LDA.b $0A
	SEC
	SBC.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	CLC
	ADC.w #$0004
	STA.w $6062,y
	RTS

CODE_04C530:
	LDA.w $75E0,x
	CMP.w #$8000
	BNE.b CODE_04C56B
	STZ.w $75E0,x
	LDA.w $7360,x
	CMP.w #$0064
	BEQ.b CODE_04C562
	CMP.w #$015E
	BEQ.b CODE_04C562
	REP.b #$10
	LDA.w $7902,x
	TAX
	LDA.l $700006,x
	SEP.b #$10
	LDX.b $12
	AND.w #$FF00
	CMP.w #$8700
	BNE.b CODE_04C562
	INC.b $77,x
	BRA.b CODE_04C56B

CODE_04C562:
	LDA.w $6FA2,x
	AND.w #$FFE0
	STA.w $6FA2,x
CODE_04C56B:
	RTS

DATA_04C56C:
	dw $0010,$000C

DATA_04C570:
	dw $6B6A,$6B6C

CODE_04C574:
	LDY.b $77,x
	BNE.b CODE_04C5B9
	LDY.b $04
	LDA.w DATA_04C56C,y
	STA.w $6028
	LDA.w $7CD6,x
	STA.w $602A
	LDA.w $7CD8,x
	STA.w $602C
	LDA.b $78,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.b $19,x
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.b $0C
	STA.w $603C
	LDA.b $0E
	STA.w $603E
	LDX.b #FXCODE_0AE864>>16
	LDA.w #FXCODE_0AE864
	JSL.l $7EDE91
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w $7860,x
	BEQ.b CODE_04C60D
	LDY.b #$00
	STY.b $19,x
	BRA.b CODE_04C60D

CODE_04C5B9:
	LDA.b $16,x
	SEC
	SBC.w #$4000
	EOR.b $18,x
	BMI.b CODE_04C5E5
	LDA.b $16,x
	CLC
	ADC.w #$8000
	STA.b $16,x
	LDA.w $75E0,x
	LDY.w $7900,x
	CPY.b #$02
	BPL.b CODE_04C5DE
	CLC
	ADC.w #$0100
	AND.w #$01FE
	BRA.b CODE_04C5E2

CODE_04C5DE:
	EOR.w #$FFFF
	INC
CODE_04C5E2:
	STA.w $75E0,x
CODE_04C5E5:
	LDA.w $70E2,x
	STA.b $00
	LDA.w $7182,x
	STA.b $02
	JSL.l CODE_04A9FD
	LDA.w $70E2,x
	SEC
	SBC.b $00
	CLC
	ADC.w $72C0,x
	STA.w $72C0,x
	LDA.w $7182,x
	SEC
	SBC.b $02
	CLC
	ADC.w $72C2,x
	STA.w $72C2,x
CODE_04C60D:
	LDY.b $19,x
	TYA
	CPY.b #$00
	BPL.b CODE_04C617
	ORA.w #$FF00
CODE_04C617:
	STA.b $00
	ASL
	CLC
	ADC.b $78,x
	STA.b $78,x
	LDA.w $7360,x
	CMP.w #$0064
	BEQ.b CODE_04C65B
	CMP.w #$015E
	BEQ.b CODE_04C65B
	LDA.b $00
	BPL.b CODE_04C634
	EOR.w #$FFFF
	INC
CODE_04C634:
	CLC
	ADC.w $7BB6,x
	CMP.w #$0600
	BMI.b CODE_04C657
	PHA
	LDA.w $7BB8,x
	INC
	AND.w #$0003
	STA.w $7BB8,x
	TAY
	LDA.w DATA_04C570,y
	TAY
	TYA
	JSL.l CODE_0085D2
	PLA
	SEC
	SBC.w #$0600
CODE_04C657:
	STA.w $7BB6,x
	RTS

CODE_04C65B:
	LDY.b $19,x
	BEQ.b CODE_04C665
	LDA.w #$00E0
	STA.w $0051
CODE_04C665:
	RTS

DATA_04C666:
	dw $0014,$0010

CODE_04C66A:
	LDY.b $04
	LDA.w DATA_04C666,y
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	ASL
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.b $0C
	EOR.w #$FFFF
	INC
	STA.b $08
	LDA.b $0E
	EOR.w #$FFFF
	INC
	STA.b $0A
	STZ.b $06
	LDA.b $0C
	STA.b $00
	LDA.b $0E
	JSR.w CODE_04C6B3
	INC.b $06
	LDA.b $0E
	STA.b $00
	LDA.b $08
	JSR.w CODE_04C6B3
	INC.b $06
	LDA.b $08
	STA.b $00
	LDA.b $0A
	JSR.w CODE_04C6B3
	INC.b $06
	LDA.b $0A
	STA.b $00
	LDA.b $0C
	JSR.w CODE_04C6B3
	RTS

CODE_04C6B3:
	STA.b $02
	CPX.w $61B6
	BEQ.b CODE_04C6F9
	LDY.w $60AB
	BMI.b CODE_04C6F8
	LDA.w $7C16,x
	CLC
	ADC.b $00
	CLC
	ADC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	CMP.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	BCS.b CODE_04C6F8
	LDA.w $7C18,x
	CLC
	ADC.b $02
	SEC
	SBC.w $6122
	SEC
	SBC.w #$0008
	CMP.w #$FFF6
	BCC.b CODE_04C6F8
	LDY.w $61B6
	BNE.b CODE_04C6F8
	STX.w $61B6
	SEC
	ADC.w $6090
	INC
	STA.w $6090
	LDY.b $06
	STY.b $18,x
	JMP.w CODE_04C766

CODE_04C6F8:
	RTS

CODE_04C6F9:
	LDY.b $18,x
	CPY.b $06
	BNE.b CODE_04C6F8
	LDY.w $60AB
	BMI.b CODE_04C758
	LDY.w $0D94
	BNE.b CODE_04C758
	LDY.b $76,x
	TYA
	CPY.b #$00
	BPL.b CODE_04C713
	ORA.w #$FF00
CODE_04C713:
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.b $00
	SEC
	SBC.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	CLC
	ADC.w $72C0,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	CLC
	ADC.w $608C
	STA.w $608C
	LDA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	CLC
	ADC.w $7C16,x
	STA.w $7C16,x
	LDA.w $7C18,x
	CLC
	ADC.b $02
	SEC
	SBC.w $6122
	SEC
	SBC.w #$0008
	SEC
	ADC.w $6090
	STA.w $6090
	LDA.w $7C16,x
	CLC
	ADC.b $00
	CLC
	ADC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	CMP.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	BCC.b CODE_04C766
CODE_04C758:
	CPX.w $61B6
	BNE.b CODE_04C760
	STZ.w $61B6
CODE_04C760:
	LDY.b #$00
	STY.b $18,x
	PLA
	RTS

CODE_04C766:
	INC.w $61B4
	LDY.b $00
	STY.b $76,x
	STZ.w $60AA
	PLA
CODE_04C771:
	RTS

DATA_04C772:
	db $00,$40,$80,$C0

CODE_04C776:
	LDA.w $7360,x
	CMP.w #$0064
	BEQ.b CODE_04C771
	CMP.w #$015E
	BEQ.b CODE_04C771
	CPX.w $61B6
	BNE.b CODE_04C7D1
	LDY.b $18,x
	LDA.w DATA_04C772,y
	AND.w #$00FF
	CLC
	ADC.b $79,x
	AND.w #$00FF
	ASL
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$FFF0
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B8595>>16
	LDA.w #FXCODE_0B8595
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	INC
	CMP.w #$0002
	BCC.b CODE_04C7D1
	LDY.b $19,x
	TYA
	CPY.b #$00
	BPL.b CODE_04C7BE
	ORA.w #$FF00
CODE_04C7BE:
	CLC
	ADC.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	TAY
	CLC
	ADC.w #$0080
	CMP.w #$0100
	BCC.b CODE_04C7CE
	LDY.b $19,x
CODE_04C7CE:
	STY.b $19,x
	RTS

CODE_04C7D1:
	LDY.b $19,x
	TYA
	CPY.b #$00
	BPL.b CODE_04C7E1
	ORA.w #$FF00
	CLC
	ADC.w #$0002
	BRA.b CODE_04C7E5

CODE_04C7E1:
	SEC
	SBC.w #$0002
CODE_04C7E5:
	TAY
	CLC
	ADC.w #$0002
	CMP.w #$0004
	BCS.b CODE_04C7F1
	LDY.b #$00
CODE_04C7F1:
	STY.b $19,x
	RTS

CODE_04C7F4:
	SEP.b #$20
	LDA.b $19,x
	PHP
	BPL.b CODE_04C7FE
	EOR.b #$FF
	INC
CODE_04C7FE:
	TAY
	REP.b #$20
	TYA
	STA.w $7A37,x
	SEP.b #$20
	STZ.w $7A39,x
	PLP
	BPL.b CODE_04C810
	DEC.w $7A39,x
CODE_04C810:
	REP.b #$20
	LDY.b $77,x
	BNE.b CODE_04C832
	LDA.w $7360,x
	CMP.w #$0064
	BEQ.b CODE_04C832
	CMP.w #$015E
	BEQ.b CODE_04C832
	LDA.w $7A37,x
	LDY.w $7A39,x
	BNE.b CODE_04C82F
	EOR.w #$FFFF
	INC
CODE_04C82F:
	STA.w $7220,x
CODE_04C832:
	RTS

;---------------------------------------------------------------------------

CODE_04C833:
	LDY.b $18,x
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_04C84D
	LDA.w $7360,y
	CMP.w #$015E
	BNE.b CODE_04C84D
	LDA.w $0FF9
	CMP.w $7900,x
	BEQ.b CODE_04C853
CODE_04C84D:
	PLY
	PLA
	JML.l CODE_03A31E

CODE_04C853:
	LDY.b $78,x
	LDA.w $0FF9,y
	SEC
	SBC.w $7A36,x
	CLC
	ADC.w $70E2,x
	STA.w $70E2,x
	LDA.w $1001,y
	SEC
	SBC.w $7A38,x
	CLC
	ADC.w $7182,x
	STA.w $7182,x
	LDA.w $1001,y
	SEC
	SBC.w #$0010
	CMP.w $7182,x
	BPL.b CODE_04C886
	STA.w $7182,x
	STZ.w $7222,x
	STZ.w $7542,x
CODE_04C886:
	LDA.w $0FF9,y
	STA.w $7A36,x
	LDA.w $1001,y
	STA.w $7A38,x
	LDY.w $77C2,x
	TYA
	STA.w $7400,x
	RTL

;---------------------------------------------------------------------------

CODE_04C89A:
	RTL

;---------------------------------------------------------------------------

CODE_04C89B:
	STZ.w $7400,x
	LDY.b $18,x
	BEQ.b CODE_04C8B8
	LDA.w $7362,x
	BMI.b CODE_04C8B8
	REP.b #$10
	TAY
	LDA.w $6024,y
	AND.w #$FF00
	ORA.w #$004A
	STA.w $6024,y
	SEP.b #$10
CODE_04C8B8:
	JSL.l CODE_03AF23
	LDY.b $76,x
	BNE.b CODE_04C8C3
	INC.b $76,x
	RTL

CODE_04C8C3:
	LDY.w $7D36,x
	BMI.b CODE_04C8DD
	BEQ.b CODE_04C92D
	LDA.w $6EFF,y
	CMP.w #$0010
	BNE.b CODE_04C92D
	LDA.w $7D37,y
	BEQ.b CODE_04C92D
	DEY
	TYX
	JSL.l CODE_03B25B
CODE_04C8DD:
	LDA.w $7CD6,x
	SEC
	SBC.w #$0008
	STA.w $0000
	LDA.w $7CD8,x
	SEC
	SBC.w #$0008
	STA.w $0002
	LDY.b $18,x
	BNE.b CODE_04C8FB
	JSL.l CODE_03A4A2
	BRA.b CODE_04C8FF

CODE_04C8FB:
	JSL.l CODE_03A491
CODE_04C8FF:
	LDA.w #$01E4
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w #$000C
	STA.w $73C2,y
	LDA.w #$0008
	STA.w $7782,y
	LDA.b $78,x
	STA.b $04
	LDA.w $7A36,x
	JSL.l CODE_03D3F3
	JML.l CODE_03A32E

CODE_04C92D:
	LDA.w $75E2,x
	SEC
	SBC.w $7222,x
	CLC
	ADC.w #$0002
	CMP.w #$0004
	BCS.b CODE_04C947
	LDA.w $75E2,x
	EOR.w #$FFFF
	INC
	STA.w $75E2,x
CODE_04C947:
	LDA.w $7A98,x
	BNE.b CODE_04C95C
	LDA.w #$0008
	STA.w $7A98,x
	LDA.w $7402,x
	INC
	AND.w #$0003
	STA.w $7402,x
CODE_04C95C:
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_04C967
	STZ.w $7222,x
CODE_04C967:
	RTL

;---------------------------------------------------------------------------

CODE_04C968:
	LDA.w #$0100
	STA.w $7A96,x
	LDA.w #$0140
	STA.w $7A98,x
	LDA.w #$0010
	STA.w $7AF6,x
	RTL

;---------------------------------------------------------------------------

CODE_04C97B:
	JSL.l CODE_03AF23
	LDA.w $7974
	LSR
	LSR
	LSR
	AND.w #$0003
	STA.w $7402,x
	LDY.b $76,x
	BEQ.b CODE_04C9BF
	LDA.w $7860,x
	LSR
	BCC.b CODE_04C9BE
	JSL.l CODE_04C968
	LDA.b $10
	AND.w #$01FF
	CLC
	ADC.w #$FF80
	STA.w $7220,x
	LDA.b $10
	XBA
	AND.w #$01FF
	EOR.w #$FFFF
	INC
	CLC
	ADC.w #$FE00
	STA.w $7222,x
	LDA.w #$0002
	STA.w $74A2,x
	STZ.b $76,x
CODE_04C9BE:
	RTL

CODE_04C9BF:
	LDA.w $7860,x
	LSR
	BCC.b CODE_04C9DB
	LDA.w $7220,x
	CMP.w #$8000
	ROR
	STA.w $7220,x
	LDA.w #$FD80
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
CODE_04C9DB:
	LDA.w $7AF6,x
	BNE.b CODE_04CA09
	LDY.w $7D36,x
	BEQ.b CODE_04CA09
	BMI.b CODE_04CA01
	LDA.w $6EFF,y
	CMP.w #$0010
	BNE.b CODE_04CA09
	LDA.w $7D37,y
	BEQ.b CODE_04CA09
	LDA.w $735F,y
	CMP.w #$0022
	BMI.b CODE_04CA09
	CMP.w #$002C
	BPL.b CODE_04CA09
CODE_04CA01:
	JSL.l CODE_04CA3A
	JML.l CODE_03A32E

CODE_04CA09:
	LDA.w $7A96,x
	BNE.b CODE_04CA26
	LDA.w $7A98,x
	BNE.b CODE_04CA1B
	LDY.b $78,x
	BNE.b CODE_04CA01
	JML.l CODE_03A31E

CODE_04CA1B:
	LDA.w $7974
	AND.w #$0001
	ASL
	DEC
	STA.w $74A2,x
CODE_04CA26:
	RTL

;---------------------------------------------------------------------------

CODE_04CA27:
	PHB
	PHK
	PLB
	PHD
	LDA.w #$7960
	TCD
	JSL.l CODE_04CA3A
	JSL.l CODE_03A32E
	PLD
	PLB
	RTL

CODE_04CA3A:
	LDA.w #$01E4
	JSL.l CODE_008B21
	LDA.w $70E2,x
	STA.w $70A2,y
	LDA.w $7182,x
	STA.w $7142,y
	LDA.w #$000C
	STA.w $73C2,y
	LDA.w #$0008
	STA.w $7782,y
	JSL.l CODE_03B353
	JML.l CODE_0CF957

;---------------------------------------------------------------------------

CODE_04CA61:
	RTL

;---------------------------------------------------------------------------

CODE_04CA62:
	JSL.l CODE_03AF23
	LDA.w $7860,x
	BIT.w #$0001
	BEQ.b CODE_04CA73
	AND.w #$000C
	BEQ.b CODE_04CA77
CODE_04CA73:
	JML.l CODE_03A31E

CODE_04CA77:
	LDA.w $7A96,x
	BNE.b CODE_04CABC
	LDA.w #$004B
	JSL.l CODE_03A364
	BCC.b CODE_04CABC
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
	LDA.w #$0001
	STA.w $7402,y
	INC
	STA.w $7BB8,y
	INC
	STA.w $7A98,y
	LDA.w #$0008
	STA.w $7978,y
	LDA.w #$000B
	STA.w $79D8,y
	INC
	STA.w $7B58,y
	LDA.w #$0039
	JSL.l CODE_0085D2
	LDA.w #$0006
	STA.w $7A96,x
CODE_04CABC:
	LDA.w $70E2,x
	SEC
	SBC.w $7902,x
	CLC
	ADC.w #$0080
	CMP.w #$0100
	BCS.b CODE_04CA73
	RTL

;---------------------------------------------------------------------------

DATA_04CACD:
	db $0B,$0A,$09,$08,$07,$06,$05,$04,$03,$02,$01,$12,$11,$09,$10

DATA_04CADC:
	db $0F,$0E,$0D,$0C,$04,$08,$0C,$10,$08,$04,$02,$00,$00,$00,$00

DATA_04CAEB:
	db $04,$06,$0A,$04,$0C,$08,$04,$00,$08,$0C,$0E,$00,$00,$00,$00,$0C
	db $0A,$06,$0C

CODE_04CAFE:
	JSL.l CODE_03AF23
	LDA.w $7A98,x
	BNE.b CODE_04CB36
	DEC.b $18,x
	BPL.b CODE_04CB0F
	JML.l CODE_03A31E

CODE_04CB0F:
	LDA.b $18,x
	CLC
	ADC.b $78,x
	TAY
	LDA.w DATA_04CACD,y
	AND.w #$00FF
	STA.w $7402,x
	LDA.w #$0003
	STA.w $7A98,x
	LDA.w DATA_04CADC,y
	AND.w #$00FF
	STA.w $7BB8,x
	LDA.w DATA_04CAEB,y
	AND.w #$00FF
	STA.w $7B58,x
CODE_04CB36:
	LDY.b $18,x
	CPY.b #$04
	BMI.b CODE_04CB45
	LDY.w $7D36,x
	BPL.b CODE_04CB45
	JSL.l CODE_03A858
CODE_04CB45:
	RTL

;---------------------------------------------------------------------------

CODE_04CB46:
	LDY.b #$08
	LDA.w $7360,x
	CMP.w #$0117
	BEQ.b CODE_04CB52
	LDY.b #$10
CODE_04CB52:
	TYA
	STA.w $7BB6,x
	STA.w $7BB8,x
	RTL

;---------------------------------------------------------------------------

DATA_04CB5A:
	dw $0001,$0004

DATA_04CB5E:
	dw $7502,$7500,$7501,$3DAA,$3DAB

DATA_04CB68:
	dw $0000,$0000,$0010,$FFF0,$0010

DATA_04CB72:
	dw $0000,$0000,$0000,$0010,$0000

CODE_04CB7C:
	STZ.w $7400,x
	JSL.l CODE_03AF23
	LDY.b $76,x
	BEQ.b CODE_04CB8B
	JML.l CODE_03A31E

CODE_04CB8B:
	LDA.w $7A96,x
	DEC
	CMP.w #$0050
	BCS.b CODE_04CBB6
	CMP.w #$0040
	BNE.b CODE_04CB9F
	LDA.w #$0004
	STA.w $7542,x
CODE_04CB9F:
	LDA.b $14
	LSR
	BCC.b CODE_04CBB6
	LDA.w $70E2,x
	EOR.w #$0001
	PHA
	SEC
	SBC.w $70E2,x
	STA.w $72C0,x
	PLA
	STA.w $70E2,x
CODE_04CBB6:
	LDA.w $61B4
	PHA
	JSL.l CODE_03D22D
	PLA
	SEC
	SBC.w $61B4
	ORA.w $7542,x
	BNE.b CODE_04CBF9
	LDA.w $7362,x
	BMI.b CODE_04CBF9
	LDA.w $70E2,x
	STA.b $04
	LDA.w $7182,x
	STA.b $06
	LDA.w $7360,x
	SEC
	SBC.w #$0117
	ASL
	TAY
	LDA.w DATA_04CB5A,y
	STA.b $00
CODE_04CBE5:
	LDA.w DATA_04CB5E,y
	STA.b $02
	PHY
	JSR.w CODE_04CBFA
	LDX.b $12
	PLY
	INY
	INY
	DEC.b $00
	BNE.b CODE_04CBE5
	INC.b $76,x
CODE_04CBF9:
	RTL

;---------------------------------------------------------------------------

CODE_04CBFA:
	LDA.w DATA_04CB68,y
	CLC
	ADC.b $04
	STA.b $04
	LDA.w DATA_04CB72,y
	CLC
	ADC.b $06
	STA.b $06
	LDA.b $04
	STA.w $0091
	LDA.b $06
	STA.w $0093
	LDA.w #$0001
	STA.w $008F
	LDA.b $02
	STA.w $0095
	JSL.l CODE_109295
	RTS

;---------------------------------------------------------------------------

CODE_04CC24:
	RTL

;---------------------------------------------------------------------------

DATA_04CC25:
	dw $0000,$0000,$0000,$0000,$7600,$7601,$7775,$7776
	dw $7602,$7603,$7777,$7778,$7604,$7605,$7779,$777A

CODE_04CC45:
	JSL.l CODE_03AF23
	LDY.b $76,x
	BNE.b CODE_04CC50
	INC.b $76,x
	RTL

CODE_04CC50:
	LDA.w $61B4
	PHA
	JSL.l CODE_03D22D
	PLA
	CMP.w $61B4
	BNE.b CODE_04CCAC
	LDA.w #$003B
	JSL.l CODE_0085D2
	LDA.b $18,x
	BNE.b CODE_04CC7C
	LDA.w $7CD6,x
	STA.b $00
	LDA.w $7CD8,x
	STA.b $02
	LDA.w #$01E6
	JSL.l CODE_03B56E
	LDA.b $18,x
CODE_04CC7C:
	ASL
	ASL
	ASL
	TAY
	LDA.w $70E2,x
	STA.b $04
	LDA.w $7182,x
	STA.b $06
	LDA.w #$0004
	STA.b $00
CODE_04CC8F:
	LDA.w DATA_04CC25,y
	STA.b $02
	PHY
	TYA
	AND.w #$0007
	TAY
	INY
	INY
	JSR.w CODE_04CBFA
	LDX.b $12
	PLY
	INY
	INY
	DEC.b $00
	BNE.b CODE_04CC8F
	JSL.l CODE_03A31E
CODE_04CCAC:
	RTL

;---------------------------------------------------------------------------

DATA_04CCAD:
	dw $FFBD,$0046

CODE_04CCB1:
	INC.b $78,x
	LDY.b #$00
	LDA.w $608C
	SEC
	SBC.w $70E2,x
	BMI.b CODE_04CCC0
	INY
	INY
CODE_04CCC0:
	TYA
	STA.w $7400,x
	LDA.w DATA_04CCAD,y
	STA.w $75E0,x
	RTL

;---------------------------------------------------------------------------

DATA_04CCCB:
	dw CODE_04CD26
	dw CODE_04CE25
	dw CODE_04CE46
	dw CODE_048EB5

CODE_04CCD3:
	LDY.w $7722,x
	BMI.b CODE_04CCDC
	JSL.l CODE_03AA2E
CODE_04CCDC:
	LDY.b $76,x
	CPY.b #$03
	BNE.b CODE_04CD01
	LDA.w $6F00,x
	CMP.w #$0010
	BNE.b CODE_04CD01
	LDA.w $61B0
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_04CD22
	LDA.w $7860,x
	AND.w #$000C
	BEQ.b CODE_04CD05
	JML.l CODE_03B273

CODE_04CD01:
	JSL.l CODE_03AF23
CODE_04CD05:
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_04CCCB,x)
	LDY.b #$00
	LDA.w $75E0,x
	BEQ.b CODE_04CD1C
	BMI.b CODE_04CD18
	INY
	INY
CODE_04CD18:
	TYA
	STA.w $7400,x
CODE_04CD1C:
	JSR.w CODE_048B8D
	JSR.w CODE_048BDF
CODE_04CD22:
	RTL

DATA_04CD23:
	db $0C,$20,$18

CODE_04CD26:
	TYX
	STZ.w $7540,x
	LDY.w $7402,x
	CPY.b #$03
	BMI.b CODE_04CD45
	LDA.w $7A96,x
	BEQ.b CODE_04CD37
	RTS

CODE_04CD37:
	INC.w $7402,x
	LDY.w $7402,x
	CPY.b #$05
	BMI.b CODE_04CDB9
	INC.b $76,x
	BRA.b CODE_04CDB9

CODE_04CD45:
	LDA.w $7A98,x
	BEQ.b CODE_04CD4D
	JMP.w CODE_04CDCC

CODE_04CD4D:
	LDA.w $75E0,x
	EOR.w $7C16,x
	BPL.b CODE_04CDCC
	LDA.w $7C16,x
	CLC
	ADC.w #$0060
	CMP.w #$00C0
	BCS.b CODE_04CDCC
	LDA.w $7C18,x
	CLC
	ADC.w #$0030
	CMP.w #$0060
	BCS.b CODE_04CDCC
	LDA.w #$0075
	JSL.l CODE_03A34C
	BCC.b CODE_04CDCC
	PHX
	TYX
	JSL.l CODE_03AD74
	BCC.b CODE_04CDB4
	TXY
	PLX
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	STA.w $7182,y
	LDA.w #$01C0
	STA.w $7A38,y
	LDA.w #$0080
	STA.w $7A36,y
	SEP.b #$20
	LDA.w $7400,x
	STA.w $7400,y
	REP.b #$20
	TXA
	STA.w $7978,y
	LDA.w #$0002
	STA.w $6F00,y
	LDA.w #$0003
	STA.w $7402,x
	BRA.b CODE_04CDB9

CODE_04CDB4:
	JSL.l CODE_03A31E
	PLX
CODE_04CDB9:
	LDY.w $7402,x
	LDA.w DATA_04CD23-$03,y
	AND.w #$00FF
	STA.w $7A96,x
	STZ.w $7220,x
	STZ.w $7540,x
	RTS

CODE_04CDCC:
	LDA.w #$000B
	STA.w $7540,x
	LDA.w $7860,x
	BIT.w #$000C
	BNE.b CODE_04CDE9
	AND.w #$0001
	STA.b $00
	LDA.w $6F02,x
	AND.w #$00FF
	ORA.b $00
	BNE.b CODE_04CDEF
CODE_04CDE9:
	LDA.w #$0020
	STA.w $7A98,x
CODE_04CDEF:
	LDA.w $7220,x
	BPL.b CODE_04CDF8
	EOR.w #$FFFF
	INC
CODE_04CDF8:
	CLC
	ADC.b $18,x
	CMP.w #$0200
	BCC.b CODE_04CE1E
	PHA
	LDA.w $7402,x
	CLC
	ADC.b $78,x
	CMP.w #$0003
	BCC.b CODE_04CE16
	LDA.b $78,x
	EOR.w #$FFFF
	INC
	STA.b $78,x
	BRA.b CODE_04CE19

CODE_04CE16:
	STA.w $7402,x
CODE_04CE19:
	PLA
	SEC
	SBC.w #$0200
CODE_04CE1E:
	STA.b $18,x
	RTS

DATA_04CE21:
	dw $0059,$FFA7

CODE_04CE25:
	TYX
	LDA.w $7A96,x
	BNE.b CODE_04CE45
	LDA.w #$0002
	STA.w $7402,x
	LDA.w #$FE9A
	STA.w $7222,x
	STZ.w $7860,x
	LDY.w $7400,x
	LDA.w DATA_04CE21,y
	STA.w $7220,x
	INC.b $76,x
CODE_04CE45:
	RTS

CODE_04CE46:
	TYX
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_04CE5D
	STZ.w $7220,x
	LDA.w #$0060
	STA.w $7A98,x
	STZ.w $7402,x
	STZ.b $76,x
CODE_04CE5D:
	RTS

;---------------------------------------------------------------------------

CODE_04CE5E:
	JSR.w CODE_04CF1A
	RTL

DATA_04CE62:
	dw $0010,$FFF0

DATA_04CE66:
	dw CODE_04CF72
	dw CODE_04CF88
	dw CODE_04CFA2
	dw CODE_04CFCA
	dw CODE_048000

CODE_04CE70:
	LDY.w $74A2,x
	BMI.b CODE_04CE79
	JSL.l CODE_03AA52
CODE_04CE79:
	JSL.l CODE_03AF23
	LDY.b $18,x
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_04CE8C
	LDA.w $7D38,y
	BEQ.b CODE_04CEA2
CODE_04CE8C:
	LDY.b $76,x
	CPY.b #$03
	BPL.b CODE_04CEA2
	LDA.w #$02CC
	STA.w $75E2,x
	LDA.w #$002C
	STA.w $7542,x
	LDY.b #$04
	STY.b $76,x
CODE_04CEA2:
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_04CE66,x)
	LDA.w $7722,x
	LSR
	LSR
	LSR
	SEC
	SBC.w $0030
	AND.w #$0003
	BEQ.b CODE_04CEBA
	RTL

CODE_04CEBA:
	LDA.w #$0002
	STA.w $74A2,x
	JSR.w CODE_04CF1A
	LDY.b $76,x
	CPY.b #$03
	BPL.b CODE_04CEDF
	LDY.b $18,x
	LDA.w $70E2,y
	SEC
	SBC.w $6022
	STA.w $70E2,x
	LDA.w $7182,y
	SEC
	SBC.w $6020
	STA.w $7182,x
CODE_04CEDF:
	LDA.w $70E2,x
	CLC
	ADC.w #$0008
	SEC
	SBC.w $611C
	CLC
	ADC.w $6024
	CMP.w $6026
	BCS.b CODE_04CF19
	LDA.w $7182,x
	CLC
	ADC.w #$0008
	SEC
	SBC.w $611E
	CLC
	ADC.w $6028
	CMP.w $602A
	BCS.b CODE_04CF19
	LDA.w $61D6
	BNE.b CODE_04CF19
	LDA.w $7220,x
	STA.w $60A8
	STA.w $60B4
	JSL.l CODE_03A858
CODE_04CF19:
	RTL

CODE_04CF1A:
	LDA.w #$6000
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDA.w $7A38,x
	LSR
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0A00
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0600
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w $6120
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $6122
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7400,x
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_08D69F>>16
	LDA.w #FXCODE_08D69F
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	INC.w $0CF9
	RTS

CODE_04CF72:
	TYX
	LDA.w $7A36,x
	CLC
	ADC.w #$0009
	CMP.w #$01FF
	BMI.b CODE_04CF84
	INC.b $76,x
	LDA.w #$01FF
CODE_04CF84:
	STA.w $7A36,x
	RTS

CODE_04CF88:
	TYX
	LDA.w $7A38,x
	SEC
	SBC.w #$0008
	AND.w #$01FE
	CMP.w #$0160
	BCS.b CODE_04CF9A
	INC.b $76,x
CODE_04CF9A:
	STA.w $7A38,x
	RTS

DATA_04CF9E:
	dw $FDE7,$0219

CODE_04CFA2:
	TYX
	LDA.w $7A38,x
	CLC
	ADC.w #$0008
	AND.w #$01FE
	CMP.w #$0180
	BCC.b CODE_04CFC6
	LDY.b #$00
	LDA.w $7400,x
	BEQ.b CODE_04CFBB
	INY
	INY
CODE_04CFBB:
	LDA.w DATA_04CF9E,y
	STA.w $7220,x
	INC.b $76,x
	LDA.w #$0160
CODE_04CFC6:
	STA.w $7A38,x
	RTS

CODE_04CFCA:
	TYX
	LDA.w $7A38,x
	CLC
	ADC.w #$0008
	AND.w #$01FE
	STA.w $7A38,x
	RTS

;---------------------------------------------------------------------------

DATA_04CFD9:
	dw $FFC0,$0040

CODE_04CFDD:
	LDA.w $7900,x
	BEQ.b CODE_04CFE5
	STA.w $7040,x
CODE_04CFE5:
	LDY.w $7400,x
	LDA.w DATA_04CFD9,y
	STA.w $7220,x
	INC.b $16,x
	RTL

;---------------------------------------------------------------------------

DATA_04CFF1:
	dw $0941,$0841

DATA_04CFF5:
	dw CODE_04D0D4
	dw CODE_04D104

CODE_04CFF9:
	LDY.b #$00
	LDA.w $7D38,x
	BEQ.b CODE_04D002
	INY
	INY
CODE_04D002:
	LDA.w DATA_04CFF1,y
	STA.w $6FA2,x
	LDA.w $6F00,x
	CMP.w #$0010
	BEQ.b CODE_04D022
	LDA.w $60AC
	CMP.w #$0002
	BNE.b CODE_04D022
	CMP.b $18,x
	BNE.b CODE_04D022
	LDA.w #$0000
	STA.w $60AC
CODE_04D022:
	LDA.w $6F00,x
	CMP.w #$0010
	BEQ.b CODE_04D037
	CMP.w #$0008
	BEQ.b CODE_04D037
	LDY.b $78,x
	BNE.b CODE_04D037
	JSL.l CODE_04D1A0
CODE_04D037:
	JSL.l CODE_03AF23
	LDY.b $76,x
	BEQ.b CODE_04D042
	JMP.w CODE_04D0CB

CODE_04D042:
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_04D053
	LDY.w $7400,x
	LDA.w DATA_04CFD9,y
	STA.w $7220,x
CODE_04D053:
	LDY.w $7D36,x
	BPL.b CODE_04D0C5
	LDA.w $7C18,x
	SEC
	SBC.w $6122
	SEC
	SBC.w $7BB8,x
	CMP.w #$FFF8
	BCC.b CODE_04D0BF
	LDY.w $60AB
	BMI.b CODE_04D0CB
	LDY.w $60C0
	BEQ.b CODE_04D0BF
	LDA.w $7860,x
	AND.w #$0001
	BEQ.b CODE_04D0CB
	LDA.w #$0020
	CMP.w $61D6
	BMI.b CODE_04D085
	STA.w $61D6
CODE_04D085:
	LDA.w $6086
	AND.w $0035
	STA.w $617A
	STZ.w $60D4
	LDA.w #$0002
	STA.w $60AC
	STA.b $18,x
	LDA.w #$7C60
	STA.w $6FA0,x
	STZ.w $7220,x
	STZ.w $60A8
	STZ.w $60B4
	STZ.w $60AA
	LDA.w #$1175
	STA.w $7040,x
	LDA.w #$000A
	STA.w $7402,x
	DEC
	STA.w $7A98,x
	INC.b $76,x
	BRA.b CODE_04D0CB

CODE_04D0BF:
	JSL.l CODE_03A813
	BRA.b CODE_04D0CB

CODE_04D0C5:
	JSL.l CODE_0DC0F0
	BCS.b CODE_04D0D3
CODE_04D0CB:
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_04CFF5,x)
CODE_04D0D3:
	RTL

CODE_04D0D4:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_04D0FF
	LDA.w #$0006
	STA.w $7A98,x
	LDA.b $16,x
	CLC
	ADC.w $7402,x
	BPL.b CODE_04D0EF
	LDA.w #$0001
	STA.b $16,x
	BRA.b CODE_04D0FC

CODE_04D0EF:
	CMP.w #$0005
	BNE.b CODE_04D0FC
	LDA.w #$FFFF
	STA.b $16,x
	LDA.w #$0003
CODE_04D0FC:
	STA.w $7402,x
CODE_04D0FF:
	RTS

DATA_04D100:
	dw $0018,$0014

CODE_04D104:
	TYX
	LDA.w $7A98,x
	BNE.b CODE_04D17E
	LDY.w $7402,x
	CPY.b #$0B
	BNE.b CODE_04D175
	LDA.w #$01EE
	JSL.l CODE_008B21
	LDA.w $7CD6,x
	STA.w $70A2,y
	LDA.w $7CD8,x
	STA.w $7142,y
	LDA.w #$0002
	STA.w $7782,y
	LDA.w #$0008
	STA.w $73C2,y
	LDA.w #$003B
	JSL.l CODE_0085D2
	LDA.w #$0000
	STA.w $60AC
	STZ.w $617A
	STZ.w $617C
	JSL.l CODE_04D1A0
	LDA.w $7CD6,x
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7CD8,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0040
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #$0200
	STA.w $6000
	LDA.w #$FE00
	STA.w $6002
	LDX.b #FXCODE_099253>>16
	LDA.w #FXCODE_099253
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	JSL.l CODE_03A32E
	RTS

CODE_04D175:
	INC.w $7402,x
	LDA.w #$0004
	STA.w $7A98,x
CODE_04D17E:
	LDA.w $60FC
	AND.w #$0007
	BNE.b CODE_04D19F
	LDA.w $7402,x
	ASL
	TAY
	LDA.w $7182,x
	SEC
	SBC.w DATA_04D100-$14,y
	SEC
	SBC.w $6112
	STA.w $6090
	STZ.w $60AA
	INC.w $61B4
CODE_04D19F:
	RTS

;---------------------------------------------------------------------------

CODE_04D1A0:
	INC.b $78,x
CODE_04D1A2:
	INC.w $1013
	BNE.b CODE_04D1B5
	LDA.w $70E2,x
	STA.b $00
	LDA.w $7182,x
	STA.b $02
	JSL.l CODE_02E19C
CODE_04D1B5:
	RTL

;---------------------------------------------------------------------------

CODE_04D1B6:
	LDA.w $7360,x
	CMP.w #$0108
	BNE.b CODE_04D1C2
	JSL.l CODE_04D1A0
CODE_04D1C2:
	RTL

;---------------------------------------------------------------------------

CODE_04D1C3:
	LDA.w #$009C
	JSL.l CODE_03A34C
	BCC.b CODE_04D1D5
	STY.b $18,x
	TYX
	JSL.l CODE_03AD74
	BCS.b CODE_04D1DB
CODE_04D1D5:
	LDX.b $12
	JML.l CODE_03A31E

CODE_04D1DB:
	LDX.b $12
	LDY.b $18,x
	LDA.w $70E2,x
	STA.w $70E2,y
	LDA.w $7182,x
	SEC
	SBC.w #$0010
	STA.w $7182,y
	LDA.w #$0100
	STA.w $7A36,y
	TXA
	STA.w $7978,y
	LDA.w #$FFC0
	STA.w $7222,y
	LDA.w #$0005
	STA.w $7902,y
	LDA.w $7400,x
	STA.w $7400,y
	RTL

;---------------------------------------------------------------------------

CODE_04D20C:
	JSL.l CODE_03A2C7
	BCC.b CODE_04D223
	LDY.b $18,x
	TYX
	JSL.l CODE_03A2DE
	BCC.b CODE_04D221
	LDX.b $12
	JML.l CODE_03A31E

CODE_04D221:
	LDX.b $12
CODE_04D223:
	LDA.w $7D96,x
	BNE.b CODE_04D230
	LDA.w $6F00,x
	CMP.w #$0008
	BNE.b CODE_04D233
CODE_04D230:
	JSR.w CODE_04D27E
CODE_04D233:
	JSL.l CODE_03AF23
	STZ.w $7402,x
	LDY.b $18,x
	LDA.w $7A38,y
	SEC
	SBC.w #$0010
	AND.w #$01FE
	CMP.w #$0080
	BMI.b CODE_04D25E
	INC.w $7402,x
	CMP.w #$0100
	BMI.b CODE_04D25E
	INC.w $7402,x
	CMP.w #$0180
	BMI.b CODE_04D25E
	INC.w $7402,x
CODE_04D25E:
	LDY.w $7D36,x
	DEY
	BMI.b CODE_04D279
	LDA.w $6F00,y
	CMP.w #$0010
	BNE.b CODE_04D27D
	LDA.w $7D38,y
	BEQ.b CODE_04D27D
	JSR.w CODE_04D27E
	JSL.l CODE_048BDB
	RTL

CODE_04D279:
	JSL.l CODE_03A5B7
CODE_04D27D:
	RTL

CODE_04D27E:
	PHY
	LDA.w $7D96,x
	PHA
	LDA.w $7220,x
	PHA
	LDA.w $7042,x
	PHA
	TXY
	LDA.w #$001E
	JSL.l CODE_03A377
	PLA
	STA.w $7042,x
	INC
	STA.w $7902,x
	PLA
	STA.w $7220,x
	PLA
	STA.w $7D96,x
	PLY
	RTS

;---------------------------------------------------------------------------

CODE_04D2A5:
	JSR.w CODE_04D4E7
	RTL

DATA_04D2A9:
	dw CODE_04D53B
	dw CODE_04D57E

DATA_04D2AD:
	dw $0006,$0001

CODE_04D2B1:
	LDY.b $18,x
	BEQ.b CODE_04D330
	LDA.w $7360,y
	CMP.w #$009B
	BNE.b CODE_04D2CA
	LDA.w $7D96,y
	BNE.b CODE_04D2CA
	LDA.w $6F00,y
	CMP.w #$0010
	BEQ.b CODE_04D31D
CODE_04D2CA:
	LDA.w #$0100
	SEC
	SBC.w $7A38,x
	BPL.b CODE_04D2D7
	EOR.w #$FFFF
	INC
CODE_04D2D7:
	ASL
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w #$0200
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B86B6>>16
	LDA.w #FXCODE_0B86B6
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDY.w $7A39,x
	BNE.b CODE_04D2F8
	EOR.w #$FFFF
	INC
CODE_04D2F8:
	LDY.w $7400,x
	BEQ.b CODE_04D301
	EOR.w #$FFFF
	INC
CODE_04D301:
	STA.w $7220,x
	LDA.w #$FF00
	STA.w $7222,x
	LDA.w #$0040
	STA.w $7542,x
	STZ.b $18,x
	LDA.w $7040,x
	ORA.w #$0008
	STA.w $7040,x
	BRA.b CODE_04D330

CODE_04D31D:
	LDA.w $70E2,y
	SEC
	SBC.w $70E2,x
	STA.b $16,x
	LDA.w $7182,y
	SEC
	SBC.w $7182,x
	STA.w $75E0,x
CODE_04D330:
	JSR.w CODE_04D3DA
	JSL.l CODE_03AF23
	LDY.b $18,x
	BEQ.b CODE_04D387
	LDA.w $7182,x
	CLC
	ADC.w #$0010
	CMP.w $7182,y
	BPL.b CODE_04D34A
	STZ.w $7222,x
CODE_04D34A:
	LDY.b #$10
	LDA.w $7900,x
	CMP.w #$6000
	BNE.b CODE_04D356
	LDY.b #$08
CODE_04D356:
	TYA
	CLC
	ADC.w $7A38,x
	AND.w #$01FE
	STA.w $7A38,x
	TXY
	LDA.b $76,x
	ASL
	TAX
	JSR.w (DATA_04D2A9,x)
	LDA.w $7A38,x
	STA.b $78,x
	LDY.b #$00
	LDA.w $7A38,x
	SEC
	SBC.w #$0080
	AND.w #$01FE
	CMP.w #$0100
	BMI.b CODE_04D381
	LDY.b #$02
CODE_04D381:
	LDA.w DATA_04D2AD,y
	STA.w $74A2,x
CODE_04D387:
	JSR.w CODE_04D4E7
	LDA.w $7CD6,x
	SEC
	SBC.w $611C
	CLC
	ADC.w $6024
	CMP.w $6026
	BCS.b CODE_04D3D1
	LDA.w $7CD8,x
	SEC
	SBC.w $611E
	CLC
	ADC.w $6028
	CMP.w $602A
	BCS.b CODE_04D3D1
	LDA.w $61D6
	BNE.b CODE_04D3D1
	LDA.w $7220,x
	STA.w $60A8
	STA.w $60B4
	LDA.w #$FF00
	STA.w $60AA
	LDA.w #$0006
	STA.w $60C0
	LDA.w #$8001
	STA.w $60D2
	STZ.w $60D4
	JSL.l CODE_03A858
CODE_04D3D1:
	RTL

DATA_04D3D2:
	dw $FFF8,$0008

DATA_04D3D6:
	dw $0010,$FFF0

CODE_04D3DA:
	LDY.b $18,x
	BNE.b CODE_04D3EF
	LDA.b $16,x
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	STA.b $00
	LDA.w $75E0,x
	BRA.b CODE_04D407

CODE_04D3EF:
	LDA.w $70E2,y
	SEC
	SBC.w $70E2,x
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	STA.b $00
	LDA.w $7182,y
	SEC
	SBC.w $7182,x
CODE_04D407:
	CLC
	ADC.w #$0004
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	STA.b $02
	LDA.w $7680,x
	CLC
	ADC.w #$0008
	STA.b $04
	LDA.w $7682,x
	CLC
	ADC.w #$0004
	STA.b $06
	LDA.w #$0003
	STA.b $0C
	LDA.w #$0008
	STA.b $0E
	REP.b #$10
	LDY.w $7362,x
	LDA.w $7A38,x
	SEC
	SBC.w #$0080
	AND.w #$01FE
	CMP.w #$0100
	BMI.b CODE_04D44C
	TYA
	CLC
	ADC.w #$0020
	BRA.b CODE_04D45B

CODE_04D44C:
	LDA.w #$FFF8
	STA.b $0E
	TYA
	CLC
	ADC.w #$0018
	TAY
	SEC
	SBC.w #$0008
CODE_04D45B:
	PHY
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	JSL.l CODE_03AA60
	REP.b #$10
	LDY.w $7400,x
	LDA.w DATA_04D3D2,y
	STA.b $08
	LDA.w DATA_04D3D6,y
	STA.b $0A
	PLY
	LDA.w $7680,x
	CLC
	ADC.b $08
	STA.w $6000,y
	STA.w $6010,y
	CLC
	ADC.b $0A
	STA.w $6008,y
	STA.w $6018,y
	LDA.w $7682,x
	SEC
	SBC.w #$0008
	STA.w $6002,y
	STA.w $600A,y
	CLC
	ADC.w #$0010
	STA.w $6012,y
	STA.w $601A,y
	LDA.w #$0002
	STA.w $6006,y
	STA.w $600E,y
	STA.w $6016,y
	STA.w $601E,y
	STZ.b $08
	STZ.b $0A
	LDY.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
CODE_04D4B5:
	LDA.b $08
	CLC
	ADC.b $00
	STA.b $08
	CLC
	ADC.b $04
	STA.w $6000,y
	LDA.b $0A
	CLC
	ADC.b $02
	STA.b $0A
	CLC
	ADC.b $06
	STA.w $6002,y
	LDA.w #$20BD
	STA.w $6004,y
	LDA.w #$0000
	STA.w $6006,y
	TYA
	CLC
	ADC.b $0E
	TAY
	DEC.b $0C
	BNE.b CODE_04D4B5
	SEP.b #$10
	RTS

CODE_04D4E7:
	LDA.w #$6000
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	STZ.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w $7A36,x
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0A00
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0600
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w $6120
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $6122
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $7400,x
	STA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	LDY.w $7722,x
	TYX
	LDA.l DATA_03A9CE,x
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.l DATA_03A9EE,x
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDX.b #FXCODE_08D69F>>16
	LDA.w #FXCODE_08D69F
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	INC.w $0CF9
	RTS

CODE_04D53B:
	TYX
	LDA.w $7900,x
	CLC
	ADC.w #$0060
	CMP.w #$2001
	BPL.b CODE_04D54B
	STA.w $7900,x
CODE_04D54B:
	JSR.w CODE_04D5AD
	LDA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	ASL
	XBA
	AND.w #$00FF
	CMP.w #$0080
	BMI.b CODE_04D560
	ORA.w #$FF00
	BRA.b CODE_04D562

CODE_04D560:
	ASL
	ASL
CODE_04D562:
	CLC
	ADC.w #$0100
	STA.w $7A36,x
	LDA.w $7A38,x
	CMP.b $78,x
	BPL.b CODE_04D57D
	DEC.w $7902,x
	BNE.b CODE_04D57D
	LDA.w #$6000
	STA.w $7900,x
	INC.b $76,x
CODE_04D57D:
	RTS

CODE_04D57E:
	TYX
	LDA.w $7A38,x
	CMP.w #$0100
	BNE.b CODE_04D595
	LDA.w #$1FE0
	STA.w $7900,x
	LDA.w #$0005
	STA.w $7902,x
	DEC.b $76,x
CODE_04D595:
	JSR.w CODE_04D5AD
	LDY.w $7A38,x
	BPL.b CODE_04D5AC
	LDA.w $7A36,x
	SEC
	SBC.w #$0010
	CMP.w #$00C0
	BMI.b CODE_04D5AC
	STA.w $7A36,x
CODE_04D5AC:
	RTS

CODE_04D5AD:
	LDA.w $7A38,x
	LDY.w $7400,x
	BEQ.b CODE_04D5BC
	EOR.w #$FFFF
	INC
	AND.w #$01FE
CODE_04D5BC:
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7900,x
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_0B8595>>16
	LDA.w #FXCODE_0B8595
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b $12
	LDY.b $18,x
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	XBA
	AND.w #$00FF
	CMP.w #$0080
	BMI.b CODE_04D5E1
	ORA.w #$FF00
CODE_04D5E1:
	CLC
	ADC.w $70E2,y
	STA.w $70E2,x
	RTS

;---------------------------------------------------------------------------

CODE_04D5E9:
	RTL

;---------------------------------------------------------------------------

DATA_04D5EA:
	dw CODE_04D86C
	dw CODE_04D97E
	dw CODE_04D9DC
	dw CODE_04DA0E
	dw CODE_04DA7C

DATA_04D5F4:
	dw $FFC0,$0040,$FF00,$0100

CODE_04D5FC:
	JSR.w CODE_04D7EA
	JSL.l CODE_03AF23
	LDA.w $0146
	CMP.w #$0009
	BNE.b CODE_04D64C
	LDA.w $70E2,x
	SEC
	SBC.w $609A
	CLC
	ADC.w $6094
	STA.w $70E2,x
	CLC
	ADC.w #$0008
	STA.w $7CD6,x
	LDA.w $7182,x
	SEC
	SBC.w $60A2
	CLC
	ADC.w $609C
	STA.w $7182,x
	CLC
	ADC.w #$0008
	STA.w $7CD8,x
	LDY.b $76
	CPY.b #$03
	BNE.b CODE_04D64C
	LDA.w $0DBC
	CLC
	ADC.w $6094
	STA.w $70E2
	CLC
	ADC.w #$0008
	STA.w $7CD6
CODE_04D64C:
	LDA.w $70E2,x
	STA.w $6000
	LDA.w $7182,x
	STA.w $6002
	LDA.w $7CD6,x
	STA.w $6004
	LDA.w $7CD8,x
	STA.w $6006
	LDY.w $0E2D
	BNE.b CODE_04D6C0
	LDA.w $61B2
	BMI.b CODE_04D691
	LDA.w $0B59
	ORA.w $0B57
	BNE.b CODE_04D67E
	LDA.w $03B6
	CMP.w #$000A
	BMI.b CODE_04D689
CODE_04D67E:
	LDA.w $61CC
	BEQ.b CODE_04D691
	JSL.l CODE_06C09A
	BRA.b CODE_04D691

CODE_04D689:
	LDA.w $6F00
	CMP.w #$0010
	BEQ.b CODE_04D6C0
CODE_04D691:
	INC.w $0E2D
	STZ.w $61CC
	LDX.b #$0C
CODE_04D699:
	LDA.w #$0004
	STA.w $0EC9,x
	TXA
	LSR
	TAY
	LDA.w DATA_04D5F4,y
	STA.w $0E69,x
	LDA.w #$0200
	STA.w $0E6B,x
	LDA.w #$F800
	STA.w $0E8B,x
	LDA.w #$0010
	STA.w $0E7B,x
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_04D699
CODE_04D6C0:
	LDX.b #$0C
CODE_04D6C2:
	LDA.w $0E9B,x
	BEQ.b CODE_04D6CA
	JMP.w CODE_04D7A8

CODE_04D6CA:
	LDA.w $0E69,x
	CMP.w $0E89,x
	BMI.b CODE_04D6D8
	SEC
	SBC.w $0E79,x
	BRA.b CODE_04D6DC

CODE_04D6D8:
	CLC
	ADC.w $0E79,x
CODE_04D6DC:
	STA.w $0E69,x
	BPL.b CODE_04D6F0
	CLC
	ADC.w $0E37,x
	STA.w $0E37,x
	LDA.w $0E39,x
	SBC.w #$0000
	BRA.b CODE_04D6FD

CODE_04D6F0:
	CLC
	ADC.w $0E37,x
	STA.w $0E37,x
	LDA.w $0E39,x
	ADC.w #$0000
CODE_04D6FD:
	STA.w $0E39,x
	LDA.w $6000
	CLC
	ADC.w $0E38,x
	STA.w $6020
	LDA.w $6004
	CLC
	ADC.w $0E38,x
	STA.w $6024
	LDA.w $0E6B,x
	CMP.w $0E8B,x
	BMI.b CODE_04D722
	SEC
	SBC.w $0E7B,x
	BRA.b CODE_04D726

CODE_04D722:
	CLC
	ADC.w $0E7B,x
CODE_04D726:
	STA.w $0E6B,x
	BPL.b CODE_04D73A
	CLC
	ADC.w $0E49,x
	STA.w $0E49,x
	LDA.w $0E4B,x
	SBC.w #$0000
	BRA.b CODE_04D747

CODE_04D73A:
	CLC
	ADC.w $0E49,x
	STA.w $0E49,x
	LDA.w $0E4B,x
	ADC.w #$0000
CODE_04D747:
	STA.w $0E4B,x
	LDA.w $6002
	CLC
	ADC.w $0E4A,x
	STA.w $6022
	LDA.w $6006
	CLC
	ADC.w $0E4A,x
	STA.w $6026
	LDA.w $0EAB,x
	BEQ.b CODE_04D766
	DEC.w $0EAB,x
CODE_04D766:
	LDA.w $0EB9,x
	BEQ.b CODE_04D76E
	DEC.w $0EB9,x
CODE_04D76E:
	LDA.w $0EBB,x
	BEQ.b CODE_04D776
	DEC.w $0EBB,x
CODE_04D776:
	TXY
	LDA.w $0EC9,x
	ASL
	TAX
	JSR.w (DATA_04D5EA,x)
	LDA.w $0EB9,x
	BNE.b CODE_04D794
	LDA.w #$0006
	STA.w $0EB9,x
	LDA.w $0EA9,x
	INC
	AND.w #$0003
	STA.w $0EA9,x
CODE_04D794:
	LDA.w $6020
	SEC
	SBC.w $6000
	STA.w $0E38,x
	LDA.w $6022
	SEC
	SBC.w $6002
	STA.w $0E4A,x
CODE_04D7A8:
	DEX
	DEX
	DEX
	DEX
	BMI.b CODE_04D7B1
	JMP.w CODE_04D6C2

CODE_04D7B1:
	LDX.b $12
	LDA.w $0146
	CMP.w #$0009
	BNE.b CODE_04D7E5
	LDA.w $70E2,x
	SEC
	SBC.w $6094
	CLC
	ADC.w $609A
	STA.w $70E2,x
	CLC
	ADC.w #$0008
	STA.w $7CD6,x
	LDA.w $7182,x
	SEC
	SBC.w $609C
	CLC
	ADC.w $60A2
	STA.w $7182,x
	CLC
	ADC.w #$0008
	STA.w $7CD8,x
CODE_04D7E5:
	RTL

DATA_04D7E6:
	db $2C,$2D,$3C,$3D

CODE_04D7EA:
	REP.b #$10
	LDY.w $7362,x
	LDX.w #$000C
CODE_04D7F2:
	LDA.w $0E9B,x
	BEQ.b CODE_04D805
	LDA.w #$8000
	STA.w $6000,y
	STA.w $6008,y
	STA.w $6010,y
	BRA.b CODE_04D857

CODE_04D805:
	LDA.w $6000,y
	CLC
	ADC.w $0E38,x
	STA.w $6000,y
	STA.w $6008,y
	CLC
	ADC.w #$0008
	STA.w $6010,y
	LDA.w $6002,y
	CLC
	ADC.w $0E4A,x
	STA.w $6002,y
	SEC
	SBC.w #$0008
	STA.w $600A,y
	STA.w $6012,y
	LDA.w $0E99,x
	XBA
	LSR
	LSR
	LSR
	XBA
	STA.b $00
	PHY
	LDY.w $0EA9,x
	LDA.w DATA_04D7E6,y
	AND.w #$00FF
	PLY
	CLC
	ADC.w $600C,y
	STA.w $600C,y
	EOR.w #$4000
	STA.w $6014,y
	LDA.w $6004,y
	EOR.b $00
	STA.w $6004,y
CODE_04D857:
	TYA
	CLC
	ADC.w #$0018
	TAY
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_04D7F2
	SEP.b #$10
	LDX.b $12
	RTS

DATA_04D868:
	dw $0300,$FD00

CODE_04D86C:
	TYX
	LDA.w #$0002
	STA.w $0E99,x
	LDA.w $7CD6
	SEC
	SBC.w $6024
	PHP
	BPL.b CODE_04D881
	EOR.w #$FFFF
	INC
CODE_04D881:
	LSR
	CMP.w #$0018
	BMI.b CODE_04D88A
	LDA.w #$0018
CODE_04D88A:
	CLC
	ADC.w #$0018
	STA.w $0E79,x
	ASL
	ASL
	ASL
	ASL
	PLP
	BPL.b CODE_04D89F
	EOR.w #$FFFF
	INC
	STZ.w $0E99,x
CODE_04D89F:
	STA.w $0E89,x
	LDA.w $7CD8
	SEC
	SBC.w $6026
	PHP
	BPL.b CODE_04D8B0
	EOR.w #$FFFF
	INC
CODE_04D8B0:
	LSR
	CMP.w #$0018
	BMI.b CODE_04D8B9
	LDA.w #$0018
CODE_04D8B9:
	CLC
	ADC.w #$0018
	STA.w $0E7B,x
	ASL
	ASL
	ASL
	ASL
	PLP
	BPL.b CODE_04D8CB
	EOR.w #$FFFF
	INC
CODE_04D8CB:
	STA.w $0E8B,x
	LDA.w $7CD6
	SEC
	SBC.w $6024
	CLC
	ADC.w #$000C
	CMP.w #$0018
	BCC.b CODE_04D8DF
CODE_04D8DE:
	RTS

CODE_04D8DF:
	LDA.w $7CD8
	SEC
	SBC.w $6026
	CLC
	ADC.w #$000C
	CMP.w #$0018
	BCS.b CODE_04D8DE
	LDA.w $61CC
	PHP
	AND.w #$0002
	STA.w $0E99,x
	PLP
	BNE.b CODE_04D938
	LDA.w $0146
	CMP.w #$0009
	BNE.b CODE_04D91D
	LDA.w $7680
	STA.w $0DBC
	STZ.w $7222
	STZ.w $75E2
	JSL.l CODE_06BFA4
	LDY.b #$07
	STY.w $0DB4
	LDY.b #$03
	BRA.b CODE_04D936

CODE_04D91D:
	JSL.l CODE_06C114
	JSL.l CODE_06BF73
	STZ.w $7220
	STZ.w $7222
	STZ.w $7542
	LDA.w #$6040
	STA.w $6FA2
	LDY.b #$02
CODE_04D936:
	STY.b $76
CODE_04D938:
	LDY.w $61CC
	CPY.b #$06
	BNE.b CODE_04D954
	LDA.w $7680
	AND.w #$FF00
	STA.b $00
	LDA.w $7682
	AND.w #$FF00
	ORA.b $00
	BEQ.b CODE_04D954
	JMP.w CODE_04DA48

CODE_04D954:
	TYA
	STA.w $0E59,x
	INC.w $61CC
	INC.w $61CC
	STZ.w $0E69,x
	STZ.w $0E79,x
	STZ.w $0E6B,x
	STZ.w $0E7B,x
	INC.w $0EC9,x
	RTS

DATA_04D96E:
	dw $FFF6,$000A,$FFFA,$0006

DATA_04D976:
	dw $0008,$0009,$0010,$000F

CODE_04D97E:
	TYX
	LDY.b #$02
	STY.b $00
	TXA
	LSR
	TAY
	LDA.w $70E2
	CLC
	ADC.w DATA_04D96E,y
	STA.b $02
	LDA.w $6020
	SEC
	SBC.b $02
	STA.b $04
	INC
	CMP.w #$0002
	BCS.b CODE_04D9A1
	STZ.b $04
	DEC.b $00
CODE_04D9A1:
	LDA.b $04
	CMP.w #$8000
	ROR
	CLC
	ADC.b $02
	STA.w $6020
	LDA.w $7182
	CLC
	ADC.w DATA_04D976,y
	STA.b $02
	LDA.w $6022
	SEC
	SBC.b $02
	STA.b $04
	INC
	CMP.w #$0002
	BCS.b CODE_04D9C8
	STZ.b $04
	DEC.b $00
CODE_04D9C8:
	LDA.b $04
	CMP.w #$8000
	ROR
	CLC
	ADC.b $02
	STA.w $6022
	LDY.b $00
	BNE.b CODE_04D9DB
	INC.w $0EC9,x
CODE_04D9DB:
	RTS

CODE_04D9DC:
	TYX
	LDY.w $61CC
	CPY.b #$08
	BMI.b CODE_04DA0D
	LDY.w $0E2F
	CPY.b #$04
	BPL.b CODE_04DA02
	LDY.w $0E5B,x
	BNE.b CODE_04DA0D
	INC.w $0E5B,x
	INC.w $0E2F
	LDY.w $0E59,x
	BNE.b CODE_04DA0D
	LDA.w #$003D
	STA.w $0053
	RTS

CODE_04DA02:
	INC.w $0EC9,x
	TXA
	LSR
	AND.w #$0002
	STA.w $0E99,x
CODE_04DA0D:
	RTS

CODE_04DA0E:
	TYX
	TXA
	LSR
	TAY
	AND.w #$0002
	STA.w $0E99,x
	CPY.b #$06
	BNE.b CODE_04DA5F
	LDA.w #$0040
	STA.w $0E7B,x
	LDA.w #$F800
	STA.w $0E8B,x
	LDA.w $6020
	SEC
	SBC.w #$0006
	STA.w $70E2
	LDA.w $6022
	SEC
	SBC.w #$000F
	STA.w $7182
	LDA.w $6022
	SEC
	SBC.w $609C
	CMP.w #$FFF0
	BPL.b CODE_04DA7B
CODE_04DA48:
	LDA.w $60AC
	CMP.w #$000E
	BEQ.b CODE_04DA5E
	REP.b #$10
	JSL.l CODE_04F6F1
	LDA.w #$0012
	STA.w $0118
	SEP.b #$10
CODE_04DA5E:
	RTS

CODE_04DA5F:
	LDA.w $6F00
	CMP.w #$0010
	BNE.b CODE_04DA7B
	LDA.w $70E2
	CLC
	ADC.w DATA_04D96E,y
	STA.w $6020
	LDA.w $7182
	CLC
	ADC.w DATA_04D976,y
	STA.w $6022
CODE_04DA7B:
	RTS

CODE_04DA7C:
	TYX
	LDY.w $0E6C,x
	BPL.b CODE_04DA88
	LDA.w #$0040
	STA.w $0E7B,x
CODE_04DA88:
	LDA.w $0146
	CMP.w #$0009
	BEQ.b CODE_04DAA0
	LDA.w $6020
	SEC
	SBC.w $6094
	CLC
	ADC.w #$0040
	CMP.w #$0180
	BCS.b CODE_04DAB0
CODE_04DAA0:
	LDA.w $6022
	SEC
	SBC.w $609C
	CLC
	ADC.w #$0040
	CMP.w #$0160
	BCC.b CODE_04DAC8
CODE_04DAB0:
	INC.w $0E9B,x
	DEC.w $0E31
	BNE.b CODE_04DAE8
	STZ.w $0E33
	STZ.w $0E2D
	STZ.w $0CE6
	LDX.b $12
	PLA
	JML.l CODE_03A31E

CODE_04DAC8:
	LDA.w $61B2
	BMI.b CODE_04DAE8
	LDY.w $0E31
	CPY.b #$04
	BNE.b CODE_04DAE8
	LDA.w $03B6
	CMP.w #$000A
	BPL.b CODE_04DAE8
	STZ.w $0EC9,x
	STZ.w $0E2F
	STZ.w $0E2D
	STZ.w $0E5B,x
CODE_04DAE8:
	RTS

;---------------------------------------------------------------------------

CODE_04DAE9:
	LDA.w $70E2,x
	AND.w #$0010
	LSR
	LSR
	LSR
	STA.w $7400,x
	RTL

;---------------------------------------------------------------------------

CODE_04DAF6:
	JSL.l CODE_03AF23
	LDA.w $7A98,x
	BNE.b CODE_04DB14
	LDA.w #$0008
	STA.w $7A98,x
	LDA.w $7402,x
	INC
	CMP.w #$0005
	BMI.b CODE_04DB11
	LDA.w #$0000
CODE_04DB11:
	STA.w $7402,x
CODE_04DB14:
	RTL

;---------------------------------------------------------------------------

DATA_04DB15:
	dw $0020,$0040

CODE_04DB19:
	SEP.b #$20
	LDA.b #$02
	STA.w $74A1,x
	REP.b #$20
	RTL

;---------------------------------------------------------------------------

DATA_04DB23:
	dw $0030,$0040,$0050,$0060

CODE_04DB2B:
	JSL.l CODE_03AF23
	LDA.w $7680,x
	CMP.w #$0130
	BMI.b CODE_04DB47
	LDA.b $10
	AND.w #$0006
	TAY
	LDA.w $003D
	SEC
	SBC.w DATA_04DB23,y
	STA.w $70E2,x
CODE_04DB47:
	RTL

;---------------------------------------------------------------------------

DATA_04DB48:
	dw $003B,$003C,$003D,$003E,$003F

DATA_04DB52:
	dw $0000,$000C,$0006,$0006,$0006,$0006,$0006,$0006
	dw $0006,$0006,$0020

CODE_04DB68:
	REP.b #$30
	PHB
	PHK
	PLB
	LDA.w $60AC
	ASL
	TAY
	LDX.w #$0020
	LDA.w DATA_04DB52,y
	STA.w $60AC
	STA.w $61B0
	CMP.w #$000C
	BNE.b CODE_04DBA5
	LDA.w #$000E
	STA.w $60AE
	LDA.w $608C
	SEC
	SBC.w #$0010
	STA.w $608C
	STZ.w $60B4
	STZ.w $60A8
	STZ.w $60AA
	STZ.w $60D4
	JSL.l CODE_04EF27
	BRA.b CODE_04DBEC

CODE_04DBA5:
	CMP.w #$0006
	BNE.b CODE_04DBEC
	PHA
	TYA
	CLC
	ADC.w #$FFFE
	CMP.w #$000A
	BCS.b CODE_04DBC0
	LDX.w #$0112
	STX.w $60BE
	LDX.w #$0010
	BRA.b CODE_04DBC9

CODE_04DBC0:
	SBC.w #$0008
	ORA.w #$8000
	LDX.w #$0020
CODE_04DBC9:
	ORA.w #$4000
	STA.w $6106
	AND.w #$00FF
	CMP.w #$0006
	BCC.b CODE_04DBE2
	TAY
	LDA.w $608C
	ORA.w #$0008
	STA.w $608C
	TYA
CODE_04DBE2:
	AND.w #$0002
	EOR.w #$0002
	STA.w $60C4
	PLA
CODE_04DBEC:
	STX.w $6126
	SEP.b #$10
	CMP.w #$0020
	BNE.b CODE_04DC0B
	LDX.b #$1C
CODE_04DBF8:
	LDA.l DATA_5FE5AA,x
	STA.l $7021A2,x
	STA.l $702F0E,x
	DEX
	DEX
	BPL.b CODE_04DBF8
	STZ.w $617E
CODE_04DC0B:
	LDA.w #$0001
	STA.w $60CC
	PLB
	LDA.w $608C
	SEC
	SBC.w #$0078
	STA.w $6094
	LDA.w $6090
	SEC
	SBC.w #$0064
	STA.w $609C
	BRA.b CODE_04DC2E

CODE_04DC28:
	LDA.w #$0020
	STA.w $6126
CODE_04DC2E:
	LDA.w #$0061
	LDY.b #$00
	JSL.l CODE_03A366
	LDA.w #$000A
	STA.w $6F00,y
	LDA.w #$000D
	STA.w $7402,y
	LDA.w #$0001
	STA.w $7902,y
	LDA.w #$8000
	STA.w $61B2
	LDA.w $608C
	STA.w $70E2,y
	LDA.w $6090
	STA.w $7182,y
	LDA.w $7042,y
	AND.w #$00CF
	ORA.w $6126
	STA.w $7042,y
	JSL.l CODE_01B2D6
	REP.b #$10
	LDX.w #$0126
CODE_04DC70:
	LDA.w $608C
	STA.w $05C2,x
	LDA.w $6090
	CLC
	ADC.w #$0010
	STA.w $06EA,x
	LDA.w $6126
	STA.w $0812,x
	DEX
	DEX
	BPL.b CODE_04DC70
	SEP.b #$10
	LDA.w $608A
	STA.w $7E10
	LDA.w $608C
	STA.w $7E12
	LDA.w $608E
	STA.w $7E14
	LDA.w $6090
	STA.w $7E16
	STZ.w $7E18
	LDA.w #$0F00
	STA.w $7E1A
	STZ.w $7E1C
	LDA.w #$070C
	STA.w $7E1E
	LDA.w #$006C
	STA.w $7E20
	LDA.w #$0058
	STA.w $7E22
	SEP.b #$20
CODE_04DCC4:
	JSL.l CODE_04FD28
	LDY.w $013E
	CPY.b #$1A
	BNE.b CODE_04DCE5
	REP.b #$20
	LDA.w #$0000
	SEC
	SBC.b $41
	STA.w $0C90
	LDA.w #$0100
	SEC
	SBC.b $43
	STA.w $0C92
	SEP.b #$20
CODE_04DCE5:
	PHB
	PHK
	PLB
	LDA.w $60AC
	CMP.b #$0C
	BEQ.b CODE_04DCF7
	JSR.w CODE_04FA33
	BNE.b CODE_04DCF7
	INC.w $0C8E
CODE_04DCF7:
	PLB
	RTL

;---------------------------------------------------------------------------

CODE_04DCF9:
	LDA.w $608C
	SEC
	SBC.w $0039
	SEC
	SBC.w #$000C
	CMP.w #$0030
	BPL.b CODE_04DD0C
	LDA.w #$0030
CODE_04DD0C:
	CMP.w #$00A8
	BMI.b CODE_04DD14
	LDA.w #$00A8
CODE_04DD14:
	STA.w $7E20
	LDA.w $6090
	SEC
	SBC.w $003B
	CMP.w #$0040
	BPL.b CODE_04DD26
	LDA.w #$0040
CODE_04DD26:
	CMP.w #$00A0
	BMI.b CODE_04DD2E
	LDA.w #$00A0
CODE_04DD2E:
	STA.w $7E22
	RTL

;---------------------------------------------------------------------------

DATA_04DD32:
	dw $0080,$0080

DATA_04DD36:
	dw $4000,$4000

DATA_04DD3A:
	dw $8000,$8000

DATA_04DD3E:
	dw $000C,$000C,$0004,$0004,$0010,$0010,$000C,$000C
	dw $000D,$000D,$0008,$0008,$0007,$0007,$0007,$0007

DATA_04DD5E:
	dw $000C,$FFF4,$0008,$FFF8,$0004,$FFFC,$0004,$FFFC
	dw $000B,$FFF5,$0008,$FFF8

DATA_04DD76:
	dw $0008,$0008,$0008,$0008,$0006,$000A

DATA_04DD82:
	dw $0004,$0004,$0004,$0004,$0002,$0002,$0004,$FFFC
	dw $0004,$FFFC,$0008,$FFF8,$0800,$0000

CODE_04DD9E:
	PHB
	PHK
	PLB
	REP.b #$30
	LDX.w $6082
	LDA.w DATA_04DD36,x
	STA.w $6088
	LDA.w DATA_04DD32,x
	STA.w $6086
	LDA.w DATA_04DD3A,x
	STA.w $6084
	JSR.w CODE_04F04F
	LDA.w $616E
	BEQ.b CODE_04DDCC
	LSR
	BNE.b CODE_04DDC9
	STZ.w $61AE
	STZ.w $61B0
CODE_04DDC9:
	DEC.w $616E
CODE_04DDCC:
	LDA.w $61AE
	BMI.b CODE_04DDD9
	ORA.w $0B55
	ORA.w $0398
	BNE.b CODE_04DDE8
CODE_04DDD9:
	JSR.w CODE_04DE5F
	JSR.w CODE_04DF4A
	JSR.w CODE_04DE7E
	STZ.w $61B4
	STZ.w $61C2
CODE_04DDE8:
	LDA.w $60AE
	BNE.b CODE_04DE48
	LDA.w $6150
	INC
	AND.w #$0006
	TAX
	BEQ.b CODE_04DDFD
	LDY.w $60C6
	BEQ.b CODE_04DDFD
	INX
CODE_04DDFD:
	TXA
	ASL
	ASL
	ORA.w $60C4
	TAY
	TXA
	ASL
	ORA.w $60C4
	TAX
	LDA.w DATA_04DD5E,y
	CLC
	ADC.w $6152
	STA.w $0C80
	CLC
	ADC.w $608C
	CLC
	ADC.w DATA_04DD76,x
	STA.w $615A
	LDA.w $60B0
	CLC
	ADC.w $0C80
	STA.w $6156
	LDA.w DATA_04DD3E,y
	CLC
	ADC.w $6154
	STA.w $0C82
	CLC
	ADC.w $6090
	CLC
	ADC.w DATA_04DD82,x
	STA.w $615C
	LDA.w $60B0
	CLC
	ADC.w $0C80
	STA.w $6156
CODE_04DE48:
	LDY.w $61CE
	BEQ.b CODE_04DE5B
	LDA.w $60BE
	CMP.w #$0055
	BCS.b CODE_04DE5B
	ADC.w #$01AF
	STA.w $60BE
CODE_04DE5B:
	SEP.b #$30
	PLB
	RTL

CODE_04DE5F:
	LDX.w #$0028
CODE_04DE62:
	LDA.w $0CC6,x
	BEQ.b CODE_04DE6A
	DEC.w $0CC6,x
CODE_04DE6A:
	DEX
	DEX
	BPL.b CODE_04DE62
	LDX.w #$0026
CODE_04DE71:
	LDA.w $61D0,x
	BEQ.b CODE_04DE79
	DEC.w $61D0,x
CODE_04DE79:
	DEX
	DEX
	BPL.b CODE_04DE71
	RTS

CODE_04DE7E:
	LDA.w $61B4
	LDY.w $0146
	CPY.w #$000D
	BNE.b CODE_04DE8C
	LDA.w #$0000
CODE_04DE8C:
	STA.w $61B8
	ORA.w $60C0
	STA.b $6B
	STZ.b $69
	LDX.w $7DF6
	BEQ.b CODE_04DEE3
CODE_04DE9B:
	LDY.w $7DF6,x
	LDA.w $05C0
	SEC
	SBC.w $79D6,y
	BPL.b CODE_04DEAB
	CLC
	ADC.w #$0128
CODE_04DEAB:
	TAY
	LDA.w $0813,y
	AND.w #$00FF
	TSB.b $69
	DEX
	DEX
	BNE.b CODE_04DE9B
	LDA.b $69
	ORA.b $6B
	ORA.w $0C8A
	ORA.w $0B57
	BNE.b CODE_04DEE3
	LDA.w $60B4
	CLC
	ADC.w $7E3A
	BPL.b CODE_04DED1
	EOR.w #$FFFF
	INC
CODE_04DED1:
	CLC
	ADC.w $093A
	STA.w $093A
	CMP.w #$0160
	BCC.b CODE_04DF49
	SBC.w #$0160
	STA.w $093A
CODE_04DEE3:
	LDY.w $05C0
	LDA.w $0C8A
	BNE.b CODE_04DEF5
	LDA.w $0B57
	BEQ.b CODE_04DF19
	LDA.w $61B2
	BMI.b CODE_04DF19
CODE_04DEF5:
	LDA.w $70E2
	STA.w $05C2,y
	LDA.w $7182
	SEC
	SBC.w #$FFF3
	STA.w $06EA,y
	LDA.w $7222
	AND.w #$FF00
	ORA.w #$0100
	ORA.w $7042
	AND.w #$FF30
	LDY.w $05C0
	BRA.b CODE_04DF39

CODE_04DF19:
	LDA.w $608C
	STA.w $05C2,y
	LDA.w $6090
	CLC
	ADC.w #$0010
	STA.w $06EA,y
	LDA.b $6B
	BEQ.b CODE_04DF36
	LDA.w $60AA
	AND.w #$FF00
	ORA.w #$0100
CODE_04DF36:
	ORA.w $6126
CODE_04DF39:
	STA.w $0812,y
	INY
	INY
	CPY.w #$0128
	BCC.b CODE_04DF46
	LDY.w #$0000
CODE_04DF46:
	STY.w $05C0
CODE_04DF49:
	RTS

CODE_04DF4A:
	LDX.w $60AC
	JMP.w (DATA_04DF50,x)

DATA_04DF50:
	dw CODE_04F64C
	dw CODE_04E782
	dw CODE_04E10B
	dw CODE_04E48F
	dw CODE_04E696
	dw CODE_04F8F1
	dw CODE_04E413
	dw CODE_04F800
	dw CODE_04EDBD
	dw CODE_04E905
	dw CODE_04F84A
	dw CODE_04E8AC
	dw CODE_04E79D
	dw CODE_04F849
	dw CODE_04F846
	dw CODE_04E3C6
	dw CODE_04E296
	dw CODE_04E0BC
	dw CODE_04E21F
	dw CODE_04E03A
	dw CODE_04DF7C
	dw CODE_04E770

CODE_04DF7C:
	SEP.b #$10
	JSL.l CODE_04F74A
	LDA.w $61F6
	BEQ.b CODE_04DF8E
	REP.b #$10
	DEC.w $61F6
	BRA.b CODE_04DFFE

CODE_04DF8E:
	LDA.w $0030
	AND.w #$0001
	BNE.b CODE_04DFC5
	LDA.w #$01DF
	JSL.l CODE_008B21
	LDA.w $608C
	STA.w $70A2,y
	LDA.w $6090
	CLC
	ADC.w #$000C
	STA.w $7142,y
	LDA.w #$0005
	STA.w $7E4C,y
	STA.w $7E4E,y
	STA.w $73C2,y
	LDA.w #$0004
	STA.w $7782,y
	LDA.w #$0006
	STA.w $7462,y
CODE_04DFC5:
	LDX.b #FXCODE_0BC70A>>16
	LDA.w #FXCODE_0BC70A
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	LDA.w $60B2
	CMP.w #$0120
	BMI.b CODE_04DFE0
	JSL.l CODE_04F6CE
	INC.w $61AE
	RTS

CODE_04DFE0:
	LDX.w #$01AE
	LDA.w $60AA
	CLC
	ADC.w #$0028
	CMP.w #$0400
	BMI.b CODE_04DFF2
	LDA.w #$0400
CODE_04DFF2:
	STA.w $60AA
	TAY
	BMI.b CODE_04E001
	LDA.w #$0030
	STA.w $6126
CODE_04DFFE:
	LDX.w #$006B
CODE_04E001:
	STX.w $60BE
	RTS

DATA_04E005:
	db $02,$08,$03,$2C,$02,$16,$03,$12,$02,$1C,$03,$1C,$02,$26,$00,$FF
	db $02,$10,$00,$40,$01,$06,$00,$14,$01,$06,$00,$40,$01,$06,$00,$14
	db $01,$06,$00,$40,$01,$06,$00,$14,$01,$06,$00,$40,$01,$06,$00,$14
	db $01,$06,$00,$7F,$FF

CODE_04E03A:
	SEP.b #$10
	LDA.w $61F6
	BNE.b CODE_04E07B
CODE_04E041:
	LDA.w $617E
	ASL
	TAX
	CPX.b #$08
	BCC.b CODE_04E04D
	STA.w $1078
CODE_04E04D:
	LDY.w DATA_04E005,x
	BPL.b CODE_04E05F
	TYA
	ORA.w #$FF00
	CLC
	ADC.w $617E
	STA.w $617E
	BRA.b CODE_04E041

CODE_04E05F:
	TYA
	LSR
	XBA
	BCC.b CODE_04E067
	ORA.w $6084
CODE_04E067:
	STA.w $617A
	STA.w $617C
	LDA.w DATA_04E005+$01,x
	AND.w #$00FF
	STA.w $61F6
	INC.w $617E
	BRA.b CODE_04E07E

CODE_04E07B:
	STZ.w $617C
CODE_04E07E:
	REP.b #$10
	LDA.w $617A
	STA.w $6070
	LDA.w $617C
	STA.w $6072
	JSR.w CODE_04F6A2
	LDA.w $60C0
	BEQ.b CODE_04E0BB
	LDX.w $617E
	CPX.w #$0008
	BCC.b CODE_04E0AD
	CMP.w #$00DA
	BCS.b CODE_04E0AA
	LDA.w #$00DA
	STA.w $60C0
	STA.w $6182
CODE_04E0AA:
	JSR.w CODE_04E271
CODE_04E0AD:
	LDA.w #$07A0
	CMP.w $6090
	BPL.b CODE_04E0BB
	STA.w $6090
	STZ.w $60C0
CODE_04E0BB:
	RTS

CODE_04E0BC:
	INC.w $61B4
	SEP.b #$10
	LDX.b #FXCODE_0BC703>>16
	LDA.w #FXCODE_0BC703
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$0100
	STA.w $6070
	LDA.w $60B0
	CMP.w #$0080
	BPL.b CODE_04E0E6
	STZ.w $6072
	LDA.b $3B
	CLC
	ADC.w #$0080
	STA.w $6090
	BRA.b CODE_04E0FC

CODE_04E0E6:
	LDA.w $60C0
	BNE.b CODE_04E0F1
	LDA.w $6084
	STA.w $6072
CODE_04E0F1:
	LDA.w $60AA
	BPL.b CODE_04E0FC
	LDA.w $6084
	TSB.w $6070
CODE_04E0FC:
	INC.w $60CC
	LDX.b #FXCODE_0BC6EF>>16
	LDA.w #FXCODE_0BC6EF
	JSL.l $7EDECF
	REP.b #$10
	RTS

CODE_04E10B:
	LDA.w $61B2
	BMI.b CODE_04E13F
	LDA.w $60C0
	ORA.w $61D4
	BNE.b CODE_04E152
	LDA.w $617E
	CMP.w #$0002
	BCS.b CODE_04E125
	INC.w $617E
	BRA.b CODE_04E19A

CODE_04E125:
	LDA.w #$0080
	STA.w $61F6
	LDA.w $60B4
	CMP.w #$FF00
	BPL.b CODE_04E139
	LDA.w #$FF00
	STA.w $60B4
CODE_04E139:
	LDA.w #$0200
	JMP.w CODE_04E216

CODE_04E13F:
	LDA.w $0D27
	CMP.w #$0008
	BCS.b CODE_04E158
	LDA.w $61F6
	BEQ.b CODE_04E152
	LSR
	BNE.b CODE_04E152
	INC.w $0D27
CODE_04E152:
	LDA.w #$0000
	JMP.w CODE_04E216

CODE_04E158:
	STZ.w $0C1E
	LDA.w $60B0
	CMP.w #$00A0
	BPL.b CODE_04E1A8
	LDA.w $617E
	ORA.w $60C0
	ORA.w $61D4
	BEQ.b CODE_04E176
	LDA.w $608C
	CMP.w #$01D0
	BPL.b CODE_04E179
CODE_04E176:
	JMP.w CODE_04E205

CODE_04E179:
	LDA.w $60B4
	BEQ.b CODE_04E184
	LDA.w #$0040
	STA.w $61F6
CODE_04E184:
	LDA.w #$0002
	STA.w $60C4
	LDA.w $61F6
	BNE.b CODE_04E152
	LDA.w $60C0
	ORA.w $61D4
	BNE.b CODE_04E152
	DEC.w $617E
CODE_04E19A:
	LDA.w #$FA00
CODE_04E19D:
	STA.w $60AA
	LDA.w #$0006
	STA.w $60C0
	BRA.b CODE_04E152

CODE_04E1A8:
	CMP.w #$0120
	BMI.b CODE_04E1BA
	LDA.w #$000B
	STA.w $0118
	LDA.w #$000B
	STA.w $021A
	RTS

CODE_04E1BA:
	LDA.w $617E
	CMP.w #$FFFE
	BNE.b CODE_04E179
	LDA.w $60C0
	ORA.w $61D4
	BEQ.b CODE_04E1E3
	LDA.w $60B0
	CMP.w #$00C0
	BMI.b CODE_04E1DA
	LDA.w $6084
	ORA.w #$0100
	BRA.b CODE_04E216

CODE_04E1DA:
	LDA.w #$0040
CODE_04E1DD:
	STA.w $61F6
CODE_04E1E0:
	JMP.w CODE_04E152

CODE_04E1E3:
	LDA.w $60B0
	CMP.w #$00C0
	BMI.b CODE_04E1F0
	LDA.w #$FB00
	BRA.b CODE_04E19D

CODE_04E1F0:
	LDA.w $61F6
	BEQ.b CODE_04E213
	LSR
	BNE.b CODE_04E1E0
	LDA.w $60C4
	BEQ.b CODE_04E1E0
	STZ.w $60C4
	LDA.w #$0060
	BRA.b CODE_04E1DD

CODE_04E205:
	LDA.w $60B4
	CMP.w #$0100
	BMI.b CODE_04E213
	LDA.w #$0100
	STA.w $60B4
CODE_04E213:
	LDA.w #$0100
CODE_04E216:
	STA.w $6070
	STZ.w $6072
	JMP.w CODE_04F6A2

CODE_04E21F:
	LDA.w $6084
	STA.w $6070
	STZ.w $6072
	STZ.w $60D2
	LDA.w #$0001
	STA.w $61E6
	JSR.w CODE_04F6A2
	LDA.w $6180
	BEQ.b CODE_04E248
	DEC.w $6180
	CMP.w #$0040
	BCS.b CODE_04E247
	LDA.w #$004C
	STA.w $60BE
CODE_04E247:
	RTS

CODE_04E248:
	LDA.w $60C0
	BNE.b CODE_04E271
	LDA.w $61D4
	BNE.b CODE_04E295
	DEC.w $617E
	BPL.b CODE_04E25E
	LDA.w #$0002
	STA.w $60AC
	RTS

CODE_04E25E:
	LDA.w #$FD00
	STA.w $60AA
	LDA.w #$00DA
	STA.w $60C0
	STA.w $6182
	STZ.w $60D2
	RTS

CODE_04E271:
	LDA.w $60AA
	CMP.w #$FF00
	BMI.b CODE_04E28F
	LDA.w $61D4
	BNE.b CODE_04E28F
	LDA.w #$0004
	STA.w $61D4
	LDA.w $6182
	CMP.w #$00DD
	BCS.b CODE_04E28F
	INC.w $6182
CODE_04E28F:
	LDA.w $6182
	STA.w $60BE
CODE_04E295:
	RTS

CODE_04E296:
	SEP.b #$10
	LDX.b #FXCODE_0BC70A>>16
	LDA.w #FXCODE_0BC70A
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w $617E
	BNE.b CODE_04E2B9
	LDA.w #$0089
	JSL.l CODE_0085D2
	LDA.w #$FA00
	STA.w $6180
	LDA.w #$0800
	STA.w $617E
CODE_04E2B9:
	SEC
	SBC.w #$0008
	CMP.w #$0100
	BCS.b CODE_04E2C5
	LDA.w #$0100
CODE_04E2C5:
	STA.w $617E
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$0001
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDX.b #FXCODE_0A91C9>>16
	LDA.w #FXCODE_0A91C9
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R7_MERGEXPosLo
	STA.b $00
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w $6180
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_08B2B2>>16
	LDA.w #FXCODE_08B2B2
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w $2FFF
	AND.w #$FF00
	STA.b $02
	LDA.w !REGISTER_SuperFX_R4_LMULTResultHi
	AND.w #$00FF
	ORA.b $02
	STA.w $60A8
	LDA.w #$FC00
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_08B2B2>>16
	LDA.w #FXCODE_08B2B2
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w $2FFF
	AND.w #$FF00
	STA.b $02
	LDA.w !REGISTER_SuperFX_R4_LMULTResultHi
	AND.w #$00FF
	ORA.b $02
	STA.w $60AA
	LDA.w $6180
	CLC
	ADC.w #$0008
	STA.w $6180
	LDA.w #$0020
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	STZ.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7974
	ASL
	ASL
	ASL
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w #$0040
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDX.b #FXCODE_088205>>16
	LDA.w #FXCODE_088205
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$0164
	STA.w $60BE
	LDA.w $0383
	ASL
	TAX
	LDA.l DATA_00BA14,x
	CLC
	ADC.w #DATA_5FA000
	STA.w !REGISTER_SuperFX_R14_GETGamePakROMAddressPtrLo
	LDA.w #DATA_5FA000>>16
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.b $00
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDA.w #$00D1
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$000F
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDX.b #FXCODE_08E167>>16
	LDA.w #FXCODE_08E167
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDY.b #$0A
	LDX.b #$40
	LDA.w $60B2
	CMP.w #$FF80
	BPL.b CODE_04E3BD
	LDA.w $0383
	ASL
	STA.w $6116
	JSL.l CODE_04FB41
	LDA.w #$0002
	STA.w $60AC
	LDA.w #$0140
	STA.w $608C
	LDA.w #$0000
	STA.w $6090
	LDY.b #$2A
	LDX.b #$00
CODE_04E3BD:
	STY.w $7042
	STX.w $70E0
	REP.b #$10
	RTS

CODE_04E3C6:
	SEP.b #$10
	LDX.b #FXCODE_0BC70A>>16
	LDA.w #FXCODE_0BC70A
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b #FXCODE_0BC6F7>>16
	LDA.w #FXCODE_0BC6F7
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	LDA.w $60FC
	AND.w #$0180
	BEQ.b CODE_04E3EC
	LDA.w #$0800
	LDY.w #$FC00
	BRA.b CODE_04E3FA

CODE_04E3EC:
	LDA.w $60FC
	AND.w #$0060
	BEQ.b CODE_04E400
	LDA.w #$FC00
	LDY.w #$F800
CODE_04E3FA:
	STA.w $60A8
	STY.w $60AA
CODE_04E400:
	LDA.w $60B2
	CMP.w #$FFC0
	BPL.b CODE_04E40C
	JSL.l CODE_02A4B5
CODE_04E40C:
	LDA.w #$006B
	STA.w $60BE
	RTS

CODE_04E413:
	LDA.w $60B0
	CMP.w #$0020
	BMI.b CODE_04E41E
	STZ.w $60AC
CODE_04E41E:
	LDA.w #$0300
	STA.w $60B4
	LDA.w #$0100
	STA.w $6070
	STZ.w $6072
	JSR.w CODE_04F6A2
	LDA.w #$000F
	TRB.w $6090
	RTS

DATA_04E437:
	dw $0080,$FF80

DATA_04E43B:
	dw $0008,$0006

DATA_04E43F:
	dw $0100,$F400,$0100

DATA_04E445:
	dw $FF00,$0011,$0012,$0011,$010C,$010D,$010E,$010F
	dw $0101,$0102,$0103,$0104,$0105,$0106,$0107,$0108

DATA_04E465:
	dw $0109,$010A

DATA_04E469:
	dw $010B,$0000

DATA_04E46D:
	dw $000E,$0007,$000B,$0006,$0004

DATA_04E477:
	dw $0001,$FFFF

DATA_04E47B:
	dw $FFFE,$0002,$FFE1,$001F,$0000

DATA_04E485:
	dw $0000,$0000,$0000,$FFE1,$001F

CODE_04E48F:
	LDA.w $60A8
	ORA.w $60AA
	ORA.w $60C0
	BNE.b CODE_04E4B1
	LDA.w #$0031
	LDY.w $0146
	CPY.w #$000D
	BNE.b CODE_04E4AD
	LDY.w $6106
	BMI.b CODE_04E4B1
	LDA.w #$0014
CODE_04E4AD:
	JSL.l CODE_0085D2
CODE_04E4B1:
	INC.w $61B4
	SEP.b #$10
	LDY.w $6106
	CPY.b #$06
	BCS.b CODE_04E4C0
	JMP.w CODE_04E589

CODE_04E4C0:
	STZ.w $60B4
	STZ.w $60A8
	BIT.w $6106
	BVC.b CODE_04E511
	LDA.w $608C
	AND.w #$000F
	CMP.w #$0008
	BEQ.b CODE_04E4E6
	LDX.b #$00
	BCC.b CODE_04E4DC
	LDX.b #$02
CODE_04E4DC:
	LDA.w $608C
	CLC
	ADC.w DATA_04E477,x
	STA.w $608C
CODE_04E4E6:
	LDA.w $6106
	AND.w #$A000
	CMP.w #$8000
	BNE.b CODE_04E4FC
	LDA.w DATA_04E437-$02,y
	STA.w $60C0
	LDA.w DATA_04E43B-$02,y
	BRA.b CODE_04E505

CODE_04E4FC:
	LDA.w #$0112
	STA.w $60C0
	LDA.w DATA_04E43F-$02,y
CODE_04E505:
	STA.w $60AA
	BPL.b CODE_04E50E
	EOR.w #$FFFF
	INC
CODE_04E50E:
	JMP.w CODE_04E5A2

CODE_04E511:
	LDX.w $60C4
	LDA.w $610E
	CLC
	ADC.w DATA_04E47B,x
	LDX.b #$00
	CMP.w $608C
	BEQ.b CODE_04E530
	BPL.b CODE_04E526
	LDX.b #$02
CODE_04E526:
	LDA.w $608C
	CLC
	ADC.w DATA_04E477,x
	STA.w $608C
CODE_04E530:
	LDA.w $61F6
	BNE.b CODE_04E546
	LDA.w $610A
	CMP.w DATA_04E469,y
	BEQ.b CODE_04E546
	INC.w $610A
	LDA.w DATA_04E46D,y
	STA.w $61F6
CODE_04E546:
	LDA.w $610A
	ASL
	ADC.w DATA_04E465,y
	TAX
	LDA.w DATA_04E445,x
	STA.w $60C0
	STZ.w $60C2
	LDA.w $0030
	AND.w #$0001
	BNE.b CODE_04E56B
	LDA.w $610C
	ASL
	BCC.b CODE_04E568
	LDA.w #$FFFF
CODE_04E568:
	STA.w $610C
CODE_04E56B:
	LDA.w $610C
	XBA
	AND.w #$00FF
	CPY.b #$06
	BEQ.b CODE_04E57A
	EOR.w #$FFFF
	INC
CODE_04E57A:
	CLC
	ADC.w $60AA
	STA.w $60AA
	BPL.b CODE_04E5A2
	EOR.w #$FFFF
	INC
	BRA.b CODE_04E5A2

CODE_04E589:
	STZ.w $60AA
	LDX.b #$00
	LDA.w DATA_04E437-$02,y
	STA.w $60B4
	STA.w $60A8
	BPL.b CODE_04E59F
	LDX.b #$02
	EOR.w #$FFFF
	INC
CODE_04E59F:
	STX.w $60C4
CODE_04E5A2:
	CLC
	ADC.w $6108
	STA.w $6108
	CMP.w #$1F00
	BCS.b CODE_04E5B1
	JMP.w CODE_04E644

CODE_04E5B1:
	BIT.w $6106
	BVC.b CODE_04E5D9
	LDA.w $60AA
	CMP.w #$FF00
	BPL.b CODE_04E5C6
	LDA.w #$002A
	STA.w $60AC
	BRA.b CODE_04E5D7

CODE_04E5C6:
	STZ.w $60AC
	STZ.w $61B0
	LDA.w $60C0
	BEQ.b CODE_04E5D7
	LDA.w #$0008
	STA.w $60C0
CODE_04E5D7:
	BRA.b CODE_04E64C

CODE_04E5D9:
	LDA.w $6106
	AND.w #$2000
	BEQ.b CODE_04E620
	LDA.w #$0008
	STA.w $60AC
	LDA.w $608C
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $6090
	CLC
	ADC.w #$0038
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDA.w #$0000
	LDY.w !REGISTER_SuperFX_R6_MultiplierHi
	CPY.b #$3D
	BEQ.b CODE_04E60D
	LDA.w #$0002
CODE_04E60D:
	STA.w $6106
	LDA.w $6090
	CLC
	ADC.w #$0008
	AND.w #$FFF0
	DEC
	STA.w $6090
	BRA.b CODE_04E65E

CODE_04E620:
	LDY.w $6106
	LDA.w $608C
	CLC
	ADC.w DATA_04E47B+$02,y
	XBA
	AND.w #$000F
	ASL
	ASL
	STA.b $00
	LDA.w $6090
	CLC
	ADC.w DATA_04E485,y
	AND.w #$0F00
	LSR
	LSR
	ORA.b $00
	JSL.l CODE_02A4CB
CODE_04E644:
	LDA.w #$0010
	BIT.w $6106
	BPL.b CODE_04E64F
CODE_04E64C:
	LDA.w #$0020
CODE_04E64F:
	STA.w $6126
	JSR.w CODE_04E661
	LDX.b #FXCODE_0BC6DA>>16
	LDA.w #FXCODE_0BC6DA
	JSL.l $7EDECF
CODE_04E65E:
	REP.b #$10
	RTS

CODE_04E661:
	LDA.w $7042
	AND.w #$00CF
	ORA.w $6126
	STA.w $7042
	LDX.w $7DF6
	BEQ.b CODE_04E685
CODE_04E672:
	LDY.w $7DF6,x
	LDA.w $7042,y
	AND.w #$00CF
	ORA.w $6126
	STA.w $7042,y
	DEX
	DEX
	BNE.b CODE_04E672
CODE_04E685:
	RTS

DATA_04E686:
	dw $007C,$008C

DATA_04E68A:
	dw $0004,$FFFC

DATA_04E68E:
	dw $FFF1,$0000

DATA_04E692:
	dw $3D35,$3D2F

CODE_04E696:
	STZ.w $60C0
	INC.w $61B4
	SEP.b #$10
	LDY.w $6106
	LDA.w $6090
	CLC
	ADC.w DATA_04E68A,y
	STA.w $6090
	CLC
	ADC.w DATA_04E68E,y
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDA.w $608C
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDY.w $6106
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w DATA_04E692,y
	BNE.b CODE_04E748
	LDA.w $608C
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w $6090
	CLC
	ADC.w #$0008
	STA.w !REGISTER_SuperFX_R0_DefaultSourceOrDestinationLo
	LDX.b #FXCODE_0ACE2F>>16
	LDA.w #FXCODE_0ACE2F
	JSL.l $7EDE91
	LDA.w !REGISTER_SuperFX_R6_MultiplierLo
	CMP.w #$7D24
	BNE.b CODE_04E729
	LDX.w $7DF6
	BEQ.b CODE_04E6FD
	LDY.w $7DF6,x
	LDA.w $7360,y
	CMP.w #$0027
	BEQ.b CODE_04E708
CODE_04E6FD:
	LDA.w $6106
	EOR.w #$0002
	STA.w $6106
	BRA.b CODE_04E748

CODE_04E708:
	LDA.w $608C
	STA.b $91
	LDA.w $6090
	CLC
	ADC.w #$0008
	STA.b $93
	LDA.w #$0001
	STA.w $008F
	LDA.w #$7D22
	STA.w $0095
	JSL.l CODE_109295
	INC.w $61AE
CODE_04E729:
	LDA.w #$0006
	STA.w $60AC
	LDA.w #$E008
	STA.w $6106
	STZ.w $6108
	LDA.w $6090
	CLC
	ADC.w #$0008
	AND.w #$FFF0
	DEC
	STA.w $6090
	BRA.b CODE_04E74B

CODE_04E748:
	STZ.w $611A
CODE_04E74B:
	JSR.w CODE_04E751
	REP.b #$10
	RTS

CODE_04E751:
	LDX.w $611A
	DEX
	TXY
	BMI.b CODE_04E75C
	LDX.b #$04
	LDY.b #$05
CODE_04E75C:
	STX.w $74A2
	TYA
	LDX.w $7DF6
	BEQ.b CODE_04E76F
CODE_04E765:
	LDY.w $7DF6,x
	STA.w $74A2,y
	DEX
	DEX
	BNE.b CODE_04E765
CODE_04E76F:
	RTS

CODE_04E770:
	STZ.w $617A
	STZ.w $617C
	LDA.w $60C0
	BNE.b CODE_04E782
	STZ.w $60AC
	STZ.w $61B0
	RTS

CODE_04E782:
	LDA.w $617A
	STA.w $6070
	LDA.w $617C
	STA.w $6072
	JMP.w CODE_04F6A2

DATA_04E791:
	dw $60A0,$2060,$00A0,$2000,$00C0,$0000

CODE_04E79D:
	STZ.w $61B6
	LDA.w #$0001
	STA.w $61B0
	LDA.w $61F4
	BEQ.b CODE_04E7BD
	LSR
	BNE.b CODE_04E7BA
	LDA.w $0C88
	BEQ.b CODE_04E7BA
	LDA.w #$007D
	JSL.l CODE_0085D2
CODE_04E7BA:
	JMP.w CODE_04E8AB

CODE_04E7BD:
	STZ.w $60AE
	SEP.b #$10
	LDA.w #$0186
	STA.w $60BE
	LDA.w #$0020
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	STZ.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $0C84
	CLC
	ADC.w #$0010
	AND.w #$00FF
	STA.w $0C84
	STA.w !REGISTER_SuperFX_R5_GeneralPurpose2Lo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDY.w $0C8A
	LDA.w DATA_04E791-$02,y
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	LDX.b #FXCODE_088205>>16
	LDA.w #FXCODE_088205
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w $70E2
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w $7182
	SEC
	SBC.w #$0010
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $608C
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $6090
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	LDA.w #$0800
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	LDX.b #FXCODE_09907C>>16
	LDA.w #FXCODE_09907C
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	STA.w $60A8
	LDA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	STA.w $60AA
	LDX.b #FXCODE_0BC70A>>16
	LDA.w #FXCODE_0BC70A
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	REP.b #$10
	LDA.w $70E2
	SEC
	SBC.w $608C
	BEQ.b CODE_04E855
	EOR.w $60A8
	BPL.b CODE_04E8AB
	LDA.w $70E2
	STA.w $608C
CODE_04E855:
	LDA.w $7182
	SEC
	SBC.w #$0010
	STA.b $00
	SEC
	SBC.w $6090
	BEQ.b CODE_04E86E
	EOR.w $60AA
	BPL.b CODE_04E8AB
	LDA.b $00
	STA.w $6090
CODE_04E86E:
	STZ.w $60AC
	JSL.l CODE_04EF27
	STZ.w $0C8A
	STZ.w $6150
	STZ.w $60C6
	LDA.w #$0003
	STA.w $60C2
	STZ.w $60B4
	STZ.w $60A8
	STZ.w $60AA
	STZ.w $61B0
	STZ.w $6112
	LDA.w #$BC00
	STA.w $6114
	SEP.b #$30
	LDX.w $0BF1
	BEQ.b CODE_04E8A9
CODE_04E8A0:
	STZ.w $0BF1,x
	DEX
	BNE.b CODE_04E8A0
	STZ.w $0BF1
CODE_04E8A9:
	REP.b #$30
CODE_04E8AB:
	RTS

CODE_04E8AC:
	LDA.w $6084
	STA.w $6070
	STZ.w $6072
	STZ.w $60D2
	LDA.w #$0001
	STA.w $61E6
	SEP.b #$10
	LDX.b #FXCODE_0BC703>>16
	LDA.w #FXCODE_0BC703
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w $60AA
	BMI.b CODE_04E8EA
	LDA.b $3B
	CLC
	ADC.w #$0094
	CMP.w $6090
	BCS.b CODE_04E8EA
	STA.w $6090
	LDA.w $60C0
	BEQ.b CODE_04E8EA
	STZ.w $60C0
	LDA.w #$0005
	STA.w $61D4
CODE_04E8EA:
	INC.w $60CC
	LDX.b #FXCODE_0BC6EF>>16
	LDA.w #FXCODE_0BC6EF
	JSL.l $7EDECF
	REP.b #$10
	RTS

DATA_04E8F9:
	dw $0003,$FFFD,$0010,$FFF0,$0100,$FF00

CODE_04E905:
	LDY.w $7E40
	BEQ.b CODE_04E90D
	JMP.w CODE_04E9D0

CODE_04E90D:
	SEP.b #$10
	LDY.w $0CBC
	BNE.b CODE_04E944
	LDA.w #$007D
	JSL.l CODE_0085D2
	LDY.w $60C4
	LDA.w $608C
	CLC
	ADC.w DATA_04E8F9,y
	STA.w $608C
	LDA.w $6090
	SEC
	SBC.w #$0008
	STA.w $6090
	STZ.w $0CBB
	INC.w $0CBC
	STZ.w $0CBE
	LDA.w #$007F
	STA.w $0CC0
	JMP.w CODE_04E9C0

CODE_04E944:
	CPY.b #$38
	BCC.b CODE_04E96C
	LDA.w $60AA
	CLC
	ADC.w #$0008
	CMP.w #$0080
	BMI.b CODE_04E957
	LDA.w #$0080
CODE_04E957:
	STA.w $60AA
	LDX.b #FXCODE_0BC711>>16
	LDA.w #FXCODE_0BC711
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDX.b #FXCODE_0BC6F7>>16
	LDA.w #FXCODE_0BC6F7
	JSL.l $7EDECF
CODE_04E96C:
	LDA.w $0CBC
	CMP.w #$0079
	BNE.b CODE_04E982
	LDA.w #$0000
	STA.w $60AC
	STZ.w $61B6
	STA.w $0D94
	BRA.b CODE_04E998

CODE_04E982:
	LDA.w $0CBE
	CMP.w #$0180
	BEQ.b CODE_04E991
	CLC
	ADC.w #$0010
	STA.w $0CBE
CODE_04E991:
	CLC
	ADC.w $0CBB
	STA.w $0CBB
CODE_04E998:
	LDA.w $0CBC
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w #$40E0
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDA.w #$6060
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w $0CC0
	XBA
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDX.b #FXCODE_08C136>>16
	LDA.w #FXCODE_08C136
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
CODE_04E9C0:
	LDA.w #$0196
	LDY.w $0CBC
	CPY.b #$68
	BCS.b CODE_04E9CD
	LDA.w #$0197
CODE_04E9CD:
	JMP.w CODE_04EA92

CODE_04E9D0:
	STZ.w $0CBC
	LDA.w $0CBA
	BPL.b CODE_04E9DD
	LDA.w #$0080
	BRA.b CODE_04EA3A

CODE_04E9DD:
	LDY.w $0CB4
	DEY
	BNE.b CODE_04EA37
	CLC
	ADC.w #$0004
	XBA
	STA.w !REGISTER_DividendLo
	LDA.w #$001C
	STA.w !REGISTER_Divisor
	NOP #7
	REP.b #$20
	LDA.w !REGISTER_QuotientLo
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDA.w #$0100
	STA.w !REGISTER_SuperFX_R6_MultiplierLo
	STZ.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w #$0020
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w #$0010
	STA.w !REGISTER_SuperFX_R8_MERGEYPosLo
	LDA.w #$001F
	STA.w !REGISTER_SuperFX_R9_GeneralPurpose3Lo
	LDA.w #$40E0
	STA.w !REGISTER_SuperFX_R12_LOOPCounterLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R13_LOOPAddressLo
	SEP.b #$10
	LDX.b #FXCODE_088295>>16
	LDA.w #FXCODE_088295
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w #$0164
	BRA.b CODE_04EA92

CODE_04EA37:
	LDA.w #$40E0
CODE_04EA3A:
	STA.w !REGISTER_SuperFX_R11_LINKDestinationLo
	LDA.w #$0054
	STA.w !REGISTER_SuperFX_R10_GeneralPurpose4Lo
	LDA.w $7E46
	LDY.w $60C4
	BNE.b CODE_04EA4F
	EOR.w #$FFFF
	INC
CODE_04EA4F:
	STA.w !REGISTER_SuperFX_R1_PLOTXCoordinateLo
	LDA.w #$FFA0
	STA.w !REGISTER_SuperFX_R2_PLOTYCoordinateLo
	LDA.w $0CB8
	STA.w !REGISTER_SuperFX_R3_GeneralPurposeLo
	LDA.w $7E40
	AND.w #$00FF
	STA.w !REGISTER_SuperFX_R4_LMULTResultLo
	SEP.b #$10
	LDX.b #FXCODE_08C045>>16
	LDA.w #FXCODE_08C045
	JSL.l !RAM_YI_Global_BeginSuperFXProcessingRt
	LDA.w $6000
	LDY.w $60C4
	BNE.b CODE_04EA7E
	EOR.w #$FFFF
	INC
CODE_04EA7E:
	CLC
	ADC.w $7E42
	STA.w $608C
	LDA.w $0CB6
	CLC
	ADC.w $6002
	STA.w $6090
	LDA.w #$0195
CODE_04EA92:
	STA.w $60BE
	REP.b #$10
	RTS

DATA_04EA98:
	db $E0,$5F,$20,$0B,$0F,$0F,$13,$0B,$0F,$0F,$14,$0B,$0F,$0F,$14,$0B
	db $0F,$0F,$13,$0A,$0F,$0F,$12,$09,$12,$16,$18,$08,$13,$15,$19,$02
	db $04,$08,$19,$01,$0E,$0E,$19,$00,$0E,$0E,$19,$00,$0E,$0E,$18,$00
	db $0E,$0E,$18,$00,$0E,$0E,$19,$00,$0F,$0F,$1B,$01,$10,$10,$1C,$01
	db $10,$10,$1E,$02,$10,$10,$1E,$04,$11,$11,$1E,$04,$11,$11,$1E,$04
	db $11,$11,$1E,$03,$10,$10,$1E,$02,$10,$10,$1E,$02,$10,$10,$1E,$02
	db $0F,$0F,$1E,$02,$0F,$0F,$1E,$03,$13,$19,$1E,$03,$12,$1A,$1F,$04
	db $11,$1B,$1F,$05,$11,$1C,$1E,$09,$10,$10,$11,$0A,$10,$10,$10,$0B
	db $0C,$0E,$0F

DATA_04EB1B:
	db $C0,$77,$15,$03,$10,$10,$1E,$02,$10,$10,$1E,$02,$10,$10,$1F,$01
	db $0F,$0F,$1F,$01,$0F,$0F,$1F,$00,$0F,$0F,$1E,$00,$0F,$0F,$1E,$00
	db $0F,$0F,$1F,$01,$0F,$0F,$1F,$01,$0F,$0F,$1F,$02,$0F,$0F,$1E,$03
	db $0F,$0F,$1E,$05,$0F,$0F,$1D,$08,$0F,$0F,$1C,$08,$0F,$0F,$1B,$08
	db $0F,$0F,$19,$09,$0E,$0E,$16,$09,$0E,$0E,$14,$0A,$0E,$0E,$13,$0B
	db $0E,$0E,$12,$0C,$0D,$0F,$11

DATA_04EB72:
	db $E0,$7F,$16,$00,$07,$09,$1D,$00,$14,$14,$1E,$00,$14,$14,$1F,$00
	db $14,$14,$14,$13,$13,$15,$16,$13,$13,$13,$13

