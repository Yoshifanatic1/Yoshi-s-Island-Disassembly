
%SPCDataBlockStart(3D00)
DATA_3D00:
	db $00,$FF,$E0,$B8,$06,$1C,$01,$FF,$E0,$B8,$02,$1E,$02,$FF,$E0,$B8
	db $03,$C5,$03,$FF,$F6,$B8,$03,$FF,$04,$FF,$E0,$B8,$08,$02,$05,$FF
	db $E0,$B8,$04,$7E,$06,$FF,$EC,$B8,$0A,$02,$07,$FF,$E0,$B8,$07,$A8
	db $08,$FF,$E0,$B8,$07,$A8,$09,$FF,$EF,$B8,$03,$C0,$0A,$FF,$E0,$B8
	db $01,$AB
%SPCDataBlockEnd(3D00)

%SPCDataBlockStart(3FE8)
DATA_3FE8:
	db $33,$66,$7F,$99,$B2,$CC,$E5,$FC,$19,$33,$4C,$66,$72,$7F,$8C,$99
	db $A5,$B2,$BF,$CC,$D8,$E5,$F2,$FC
%SPCDataBlockEnd(3FE8)

%SPCDataBlockStart(0400)
SPC700_Engine:
	CLRP
	MOV X, #$CF
	MOV SP, X
	MOV A, #$00
	MOV X, A
CODE_0407:
	MOV (X+), A
	CMP X, #$E0
	BNE CODE_0407
	MOV X, #$00
CODE_040E:
	MOV $0200+x, A
	INC X
	BNE CODE_040E
CODE_0414:
	MOV $0300+x, A
	INC X
	BNE CODE_0414
	INC A
	CALL CODE_0A96
	SET5 $48
	MOV A, #$60
	MOV Y, #$0C
	CALL CODE_05FA
	MOV Y, #$1C
	CALL CODE_05FA
	MOV A, #$3C
	MOV Y, #$5D
	CALL CODE_05FA
	MOV A, #$F0
	MOV $00F1, A
	MOV A, #$10
	MOV $00FA, A
	MOV $53, A
	MOV A, #$01
	MOV $00F1, A
CODE_0444:
	MOV Y, #$0A
CODE_0446:
	CMP Y, #$05
	BEQ CODE_0451
	BCS CODE_0454
	CMP $4C, $4D
	BNE CODE_0462
CODE_0451:
	BBS7 $4C, CODE_0462
CODE_0454:
	MOV A, DATA_0E1D+y
	MOV $00F2, A
	MOV A, DATA_0E27+y
	MOV X, A
	MOV A, (X)
	MOV $00F3, A
CODE_0462:
	DBNZ Y, CODE_0446
	MOV $45, Y
	MOV $46, Y
	MOV A, $18
	EOR A, $19
	LSR A
	LSR A
	NOTC
	ROR $18
	ROR $19
CODE_0473:
	MOV Y, $00FD
	BEQ CODE_0473
	PUSH Y
	MOV A, #$38
	MUL YA
	CLRC
	ADC A, $43
	MOV $43, A
	BCC CODE_04A6
	CALL CODE_1EDC
	MOV X, #$01
	CALL CODE_04DA
	MOV X, #$02
	CALL CODE_04DA
	CALL CODE_2137
	CALL CODE_2066
	CMP $4C, $4D
	BEQ CODE_04A6
	INC $03C7
	MOV A, $03C7
	LSR A
	BCS CODE_04A6
	INC $4C
CODE_04A6:
	MOV A, $53
	POP Y
	MUL YA
	CLRC
	ADC A, $51
	MOV $51, A
	BCC CODE_04C1
	MOV A, $03F8
	BNE CODE_04BE
	CALL CODE_0754
	MOV X, #$00
	CALL CODE_04EB
CODE_04BE:
	JMP CODE_0444

CODE_04C1:
	MOV A, $04
	BEQ CODE_04D7
	MOV X, #$00
	MOV $47, #$01
CODE_04CA:
	MOV A, $31+x
	BEQ CODE_04D1
	CALL CODE_0D46
CODE_04D1:
	INC X
	INC X
	ASL $47
	BNE CODE_04CA
CODE_04D7:
	JMP CODE_0444

;---------------------------------------------------------------------------

CODE_04DA:
	MOV A, $04+x
	MOV $00F4+x, A
CODE_04DF:
	MOV A, $00F4+x
	CMP A, $00F4+x
	BNE CODE_04DF
	MOV Y, A
	MOV $00+x, Y
CODE_04EA:
	RET

;---------------------------------------------------------------------------

CODE_04EB:
	MOV A, $04+x
	MOV $00F4+x, A
CODE_04F0:
	MOV A, $00F4+x
	CMP A, $00F4+x
	BNE CODE_04F0
	MOV Y, A
	MOV A, $08+x
	MOV $08+x, Y
	CBNE $08+x, CODE_0502
	MOV Y, #$00
CODE_0502:
	MOV $00+x, Y
	RET

;---------------------------------------------------------------------------

CODE_0505:
	CMP Y, #$CA
	BCC CODE_050E
	CALL CODE_08B1
	MOV Y, #$A4
CODE_050E:
	CMP Y, #$C8
	BCS CODE_04EA
	MOV A, $1A
	AND A, $47
	BNE CODE_04EA
	MOV A, Y
	AND A, #$7F
	CLRC
	ADC A, $50
	CLRC
	ADC A, $02F0+x
	MOV $0361+x, A
	MOV A, $0381+x
	MOV $0360+x, A
	MOV A, $02B1+x
	LSR A
	MOV A, #$00
	ROR A
	MOV $02A0+x, A
	MOV A, #$00
	MOV $B0+x, A
	MOV $0100+x, A
	MOV $02D0+x, A
	MOV $C0+x, A
	OR $5E, $47
	OR $45, $47
	MOV A, $0280+x
	MOV $A0+x, A
	BEQ CODE_056C
	MOV A, $0281+x
	MOV $A1+x, A
	MOV A, $0290+x
	BNE CODE_0562
	MOV A, $0361+x
	SETC
	SBC A, $0291+x
	MOV $0361+x, A
CODE_0562:
	MOV A, $0291+x
	CLRC
	ADC A, $0361+x
	CALL CODE_0B1D
CODE_056C:
	CALL CODE_0B35
CODE_056F:
	MOV Y, #$00
	MOV A, $11
	SETC
	SBC A, #$34
	BCS CODE_0581
	MOV A, $11
	SETC
	SBC A, #$13
	BCS CODE_0585
	DEC Y
	ASL A
CODE_0581:
	ADDW YA, $10
	MOVW $10, YA
CODE_0585:
	PUSH X
	MOV A, $11
	ASL A
	MOV Y, #$00
	MOV X, #$18
	DIV YA, X
	MOV X, A
	MOV A, DATA_0E32+$01+y
	MOV $15, A
	MOV A, DATA_0E32+y
	MOV $14, A
	MOV A, DATA_0E32+$03+y
	PUSH A
	MOV A, DATA_0E32+$02+y
	POP Y
	SUBW YA, $14
	MOV Y, $10
	MUL YA
	MOV A, Y
	MOV Y, #$00
	ADDW YA, $14
	MOV $15, Y
	ASL A
	ROL $15
	MOV $14, A
	BRA CODE_05B8

CODE_05B4:
	LSR $15
	ROR A
	INC X
CODE_05B8:
	CMP X, #$06
	BNE CODE_05B4
	MOV $14, A
	POP X
	MOV A, $0220+x
	MOV Y, $15
	MUL YA
	MOVW $16, YA
	MOV A, $0220+x
	MOV Y, $14
	MUL YA
	PUSH Y
	MOV A, $0221+x
	MOV Y, $14
	MUL YA
	ADDW YA, $16
	MOVW $16, YA
	MOV A, $0221+x
	MOV Y, $15
	MUL YA
	MOV Y, A
	POP A
	ADDW YA, $16
	MOVW $16, YA
	MOV A, X
	XCN A
	LSR A
	OR A, #$02
	MOV Y, A
	MOV A, $16
	CALL CODE_05F2
	INC Y
	MOV A, $17
CODE_05F2:
	PUSH A
	MOV A, $47
	AND A, $1A
	POP A
	BNE CODE_0600
CODE_05FA:
	MOV $00F2, Y
	MOV $00F3, A
CODE_0600:
	RET

;---------------------------------------------------------------------------

CODE_0601:
	MOV A, #$00
	MOV Y, #$2C
	CALL CODE_05FA
	MOV Y, #$3C
	CALL CODE_05FA
	MOV A, #$FF
	MOV Y, #$5C
	CALL CODE_05FA
	CALL CODE_0E57
	MOV A, #$00
	MOV $03CA, A
	MOV $04, A
	MOV $0005, A
	MOV $0006, A
	MOV $0007, A
	MOV $1A, A
	MOV Y, #$10
CODE_062B:
	MOV $039F+y, A
	DBNZ Y, CODE_062B
	RET

CODE_0631:
	CMP $04, #$11
	BEQ CODE_0649
	MOV X, #$40
	MOV $5A, X
	MOV $03CA, X
	MOV A, #$00
	MOV $5B, A
	SETC
	SBC A, $59
	CALL CODE_0B40
	MOVW $5C, YA
CODE_0649:
	JMP CODE_075B

CODE_064C:
	MOV A, $03F1
	BNE CODE_066F
	MOV A, $59
	MOV $03F1, A
	MOV A, #$70
	MOV $59, A
	JMP CODE_075B

CODE_065D:
	MOV A, $03F1
	BEQ CODE_066F
	MOV A, $03F1
	MOV $59, A
	MOV A, #$00
	MOV $03F1, A
	JMP CODE_075B

CODE_066F:
	RET

CODE_0670:
	CMP A, #$FF
	BEQ CODE_0601
	CMP A, #$F1
	BEQ CODE_0631
	CMP A, #$F2
	BEQ CODE_064C
	CMP A, #$F3
	BEQ CODE_065D
	CMP A, #$F4
	BEQ CODE_06A7
	CMP A, #$F5
	BEQ CODE_06A0
	CMP A, #$F6
	BEQ CODE_0695
	CMP A, #$F0
	BEQ CODE_06C3
	CMP A, #$14
	BCC CODE_06E5
	RET

CODE_0695:
	MOV A, $03CF
	MOV $53, A
	MOV $54, #$00
	JMP CODE_075B

CODE_06A0:
	MOV $54, #$EF
	MOV A, #$44
	BNE CODE_06AC
CODE_06A7:
	MOV $54, #$8F
	MOV A, #$16
CODE_06AC:
	MOV $55, A
	SETC
	SBC A, $53
	MOV X, $54
	CALL CODE_0B40
	MOVW $56, YA
	JMP CODE_075B

;---------------------------------------------------------------------------

CODE_06BB:
	DEC $03CA
	BEQ CODE_06C3
	JMP CODE_0767

CODE_06C3:
	MOV A, $1A
	EOR A, #$FF
	TSET $0046, A
	MOV $04, #$00
	MOV $47, #$00
	MOV $59, #$C0
	MOV $53, #$20
	RET

;---------------------------------------------------------------------------

CODE_06D7:
	MOV Y, #$00
	MOV A, ($40)+y
	INCW $40
	PUSH A
	MOV A, ($40)+y
	INCW $40
	MOV Y, A
	POP A
	RET

;---------------------------------------------------------------------------

CODE_06E5:
	CLRC
	MOV X, #$00
	MOV $03CA, X
	MOV $03F1, X
	MOV $04, A
	ASL A
	MOV X, A
	MOV A, $FF8F+x
	MOV Y, A
	BNE CODE_06FB
	MOV $04, A
	RET

CODE_06FB:
	MOV A, $FF8E+x
	MOVW $40, YA
	MOV $0C, #$02
	MOV A, $1A
	EOR A, #$FF
	TSET $0046, A
	RET

;---------------------------------------------------------------------------

CODE_070B:
	MOV X, #$0E
	MOV $47, #$80
CODE_0710:
	MOV A, $47
	AND A, $1A
	AND A, #$C0
	BNE CODE_073B
	MOV A, #$FF
	MOV $0301+x, A
	MOV A, #$0A
	CALL CODE_090A
	MOV $0211+x, A
	MOV $0381+x, A
	MOV $02F0+x, A
	MOV $0280+x, A
	MOV $03E1+x, A
	MOV $03E0+x, A
	MOV $03D0+x, A
	MOV $B1+x, A
	MOV $C1+x, A
CODE_073B:
	DEC X
	DEC X
	LSR $47
	BNE CODE_0710
	MOV $5A, A
	MOV $68, A
	MOV $54, A
	MOV $50, A
	MOV $42, A
	MOV $5F, A
	MOV $59, #$C0
	MOV $53, #$20
CODE_0753:
	RET

;---------------------------------------------------------------------------

CODE_0754:
	MOV A, $00
	BEQ CODE_075B
	JMP CODE_0670

CODE_075B:
	MOV A, $04
	BEQ CODE_0753
	MOV A, $03CA
	BEQ CODE_0767
	JMP CODE_06BB

CODE_0767:
	MOV A, $0C
	BEQ CODE_07C4
	DBNZ $0C, CODE_070B
CODE_076E:
	CALL CODE_06D7
	BNE CODE_078A
	MOV Y, A
	BNE CODE_0779
	JMP CODE_06C3

CODE_0779:
	DEC $42
	BPL CODE_077F
	MOV $42, A
CODE_077F:
	CALL CODE_06D7
	MOV X, $42
	BEQ CODE_076E
	MOVW $40, YA
	BRA CODE_076E

CODE_078A:
	MOVW $16, YA
	MOV Y, #$0F
CODE_078E:
	MOV A, ($16)+y
	MOV $0030+y, A
	DEC Y
	BPL CODE_078E
	MOV X, #$00
	MOV $47, #$01
CODE_079B:
	MOV A, $31+x
	BEQ CODE_07A9
	MOV A, $0211+x
	BNE CODE_07A9
	MOV A, #$00
	CALL CODE_08B1
CODE_07A9:
	MOV A, #$00
	MOV $80+x, A
	PUSH A
	MOV A, $47
	AND A, $1A
	AND A, #$C0
	POP A
	BNE CODE_07BB
	MOV $91+x, A
	MOV $90+x, A
CODE_07BB:
	INC A
	MOV $70+x, A
	INC X
	INC X
	ASL $47
	BNE CODE_079B
CODE_07C4:
	MOV X, #$00
	MOV $5E, X
	MOV $47, #$01
CODE_07CB:
	MOV $44, X
	MOV A, $31+x
	BEQ CODE_083F
	DEC $70+x
	BNE CODE_0839
CODE_07D5:
	CALL CODE_08A7
	BNE CODE_07F1
	MOV A, $80+x
	BEQ CODE_076E
	CALL CODE_0A2B
	DEC $80+x
	BNE CODE_07D5
	MOV A, $0230+x
	MOV $30+x, A
	MOV A, $0231+x
	MOV $31+x, A
	BRA CODE_07D5

CODE_07F1:
	BMI CODE_0813
	MOV $0200+x, A
	CALL CODE_08A7
	BMI CODE_0813
	PUSH A
	XCN A
	AND A, #$07
	MOV Y, A
	MOV A, $3FE8+y
	MOV $0201+x, A
	POP A
	AND A, #$0F
	MOV Y, A
	MOV A, $3FF0+y
	MOV $0210+x, A
	CALL CODE_08A7
CODE_0813:
	CMP A, #$E0
	BCC CODE_081C
	CALL CODE_0895
	BRA CODE_07D5

CODE_081C:
	PUSH A
	MOV A, $47
	AND A, $1A
	POP A
	BNE CODE_0827
	CALL CODE_0505
CODE_0827:
	MOV A, $0200+x
	MOV $70+x, A
	MOV Y, A
	MOV A, $0201+x
	MUL YA
	MOV A, Y
	BNE CODE_0835
	INC A
CODE_0835:
	MOV $71+x, A
	BRA CODE_083C

CODE_0839:
	CALL CODE_0C67
CODE_083C:
	CALL CODE_0AEC
CODE_083F:
	INC X
	INC X
	ASL $47
	BEQ CODE_0848
	JMP CODE_07CB

CODE_0848:
	MOV A, $54
	BEQ CODE_0857
	MOVW YA, $56
	ADDW YA, $52
	DBNZ $54, CODE_0855
	MOVW YA, $54
CODE_0855:
	MOVW $52, YA
CODE_0857:
	MOV A, $68
	BEQ CODE_0870
	MOVW YA, $64
	ADDW YA, $60
	MOVW $60, YA
	MOVW YA, $66
	ADDW YA, $62
	DBNZ $68, CODE_086E
	MOVW YA, $68
	MOVW $60, YA
	MOV Y, $6A
CODE_086E:
	MOVW $62, YA
CODE_0870:
	MOV A, $5A
	BEQ CODE_0882
	MOVW YA, $5C
	ADDW YA, $58
	DBNZ $5A, CODE_087D
	MOVW YA, $5A
CODE_087D:
	MOVW $58, YA
	MOV $5E, #$FF
CODE_0882:
	MOV X, #$00
	MOV $47, #$01
CODE_0887:
	MOV A, $31+x
	BEQ CODE_088E
	CALL CODE_0BAD
CODE_088E:
	INC X
	INC X
	ASL $47
	BNE CODE_0887
	RET

;---------------------------------------------------------------------------

CODE_0895:
	ASL A
	MOV Y, A
	MOV A, $0A9D+y
	PUSH A
	MOV A, $0A9C+y
	PUSH A
	MOV A, Y
	LSR A
	MOV Y, A
	MOV A, $0B32+y
	BEQ CODE_08AF
CODE_08A7:
	MOV A, ($30+x)
CODE_08A9:
	INC $30+x
	BNE CODE_08AF
	INC $31+x
CODE_08AF:
	MOV Y, A
	RET

;---------------------------------------------------------------------------

CODE_08B1:
	MOV $0211+x, A
	MOV Y, A
	BPL CODE_08BD
	SETC
	SBC A, #$CA
	CLRC
	ADC A, $5F
CODE_08BD:
	MOV Y, #$06
	MUL YA
	MOVW $14, YA
	CLRC
	ADC $14, #$00
	ADC $15, #$3D
	MOV A, $1A
	AND A, $47
	BNE CODE_0909
	PUSH X
	MOV A, X
	XCN A
	LSR A
	OR A, #$04
	MOV X, A
	MOV Y, #$00
	MOV A, ($14)+y
	BPL CODE_08EA
	AND A, #$1F
	AND $48, #$20
	TSET $0048, A
	OR $49, $47
	MOV A, Y
	BRA CODE_08F1

CODE_08EA:
	MOV A, $47
	TCLR $0049, A
CODE_08EF:
	MOV A, ($14)+y
CODE_08F1:
	MOV $00F2, X
	MOV $00F3, A
	INC X
	INC Y
	CMP Y, #$04
	BNE CODE_08EF
	POP X
	MOV A, ($14)+y
	MOV $0221+x, A
	INC Y
	MOV A, ($14)+y
	MOV $0220+x, A
CODE_0909:
	RET

;---------------------------------------------------------------------------

CODE_090A:
	MOV $0351+x, A
	AND A, #$1F
	MOV $0331+x, A
	MOV A, #$00
	MOV $0330+x, A
	RET

;---------------------------------------------------------------------------

CODE_0918:
	MOV $91+x, A
	PUSH A
	CALL CODE_08A7
	MOV $0350+x, A
	SETC
	SBC A, $0331+x
	POP X
	CALL CODE_0B40
	MOV $0340+x, A
	MOV A, Y
	MOV $0341+x, A
	RET

;---------------------------------------------------------------------------

CODE_0931:
	MOV $02B0+x, A
	CALL CODE_08A7
	MOV $02A1+x, A
	CALL CODE_08A7
	MOV $B1+x, A
	MOV $02C1+x, A
	MOV A, #$00
	MOV $02B1+x, A
	RET

;---------------------------------------------------------------------------

CODE_0948:
	MOV $02B1+x, A
	PUSH A
	MOV Y, #$00
	MOV A, $B1+x
	POP X
	DIV YA, X
	MOV X, $44
	MOV $02C0+x, A
	RET

;---------------------------------------------------------------------------

CODE_0958:
	MOV A, $03CA
	BNE CODE_0966
	MOV A, $03F1
	BNE CODE_0966
	MOV A, #$00
	MOVW $58, YA
CODE_0966:
	RET

;---------------------------------------------------------------------------

CODE_0967:
	MOV $5A, A
	CALL CODE_08A7
	MOV $5B, A
	SETC
	SBC A, $59
	MOV X, $5A
	CALL CODE_0B40
	MOVW $5C, YA
	RET

;---------------------------------------------------------------------------

CODE_0979:
	MOV A, #$00
	MOVW $52, YA
	MOV $03CF, Y
	RET

;---------------------------------------------------------------------------

CODE_0981:
	MOV $54, A
	CALL CODE_08A7
	MOV $55, A
	SETC
	SBC A, $53
	MOV X, $54
	CALL CODE_0B40
	MOVW $56, YA
	RET

;---------------------------------------------------------------------------

CODE_0993:
	MOV $50, A
	RET

;---------------------------------------------------------------------------

CODE_0996:
	MOV $03D0+x, A
	MOV A, $03A0+x
	BNE CODE_09A4
	MOV A, $03D0+x
	MOV $02F0+x, A
CODE_09A4:
	RET

;---------------------------------------------------------------------------

CODE_09A5:
	MOV $02E0+x, A
	CALL CODE_08A7
	MOV $02D1+x, A
	CALL CODE_08A7
	MOV $C1+x, A
	RET

;---------------------------------------------------------------------------

CODE_09B4:
	MOV A, #$01
	BRA CODE_09BA

CODE_09B8:
	MOV A, #$00
CODE_09BA:
	MOV $0290+x, A
	MOV A, Y
	MOV $0281+x, A
	CALL CODE_08A7
	MOV $03E1+x, A
	PUSH A
	MOV A, $47
	AND A, $1A
	POP A
	BEQ CODE_09D1
	MOV A, #$00
CODE_09D1:
	MOV $0280+x, A
	CALL CODE_08A7
	MOV $0291+x, A
	RET

;---------------------------------------------------------------------------

CODE_09DB:
	MOV $0280+x, A
	MOV $03E1+x, A
	RET

;---------------------------------------------------------------------------

CODE_09E2:
	MOV $0301+x, A
	MOV A, #$00
	MOV $0300+x, A
	RET

;---------------------------------------------------------------------------

CODE_09EB:
	MOV $90+x, A
	PUSH A
	CALL CODE_08A7
	MOV $0320+x, A
	SETC
	SBC A, $0301+x
	POP X
	CALL CODE_0B40
	MOV $0310+x, A
	MOV A, Y
	MOV $0311+x, A
	RET

;---------------------------------------------------------------------------

CODE_0A04:
	MOV $03E0+x, A
	MOV A, $03A0+x
	BNE CODE_0A12
	MOV A, $03E0+x
	MOV $0381+x, A
CODE_0A12:
	RET

;---------------------------------------------------------------------------

CODE_0A13:
	MOV $0240+x, A
	CALL CODE_08A7
	MOV $0241+x, A
	CALL CODE_08A7
	MOV $80+x, A
	MOV A, $30+x
	MOV $0230+x, A
	MOV A, $31+x
	MOV $0231+x, A
CODE_0A2B:
	MOV A, $0240+x
	MOV $30+x, A
	MOV A, $0241+x
	MOV $31+x, A
	RET

;---------------------------------------------------------------------------

CODE_0A36:
	MOV $03C3, A
	MOV $4A, A
	CALL CODE_08A7
	MOV A, #$00
	MOVW $60, YA
	CALL CODE_08A7
	MOV A, #$00
	MOVW $62, YA
	CLR5 $48
	RET

;---------------------------------------------------------------------------

CODE_0A4C:
	MOV $68, A
	CALL CODE_08A7
	MOV $69, A
	SETC
	SBC A, $61
	MOV X, $68
	CALL CODE_0B40
	MOVW $64, YA
	CALL CODE_08A7
	MOV $6A, A
	SETC
	SBC A, $63
	MOV X, $68
	CALL CODE_0B40
	MOVW $66, YA
	RET

;---------------------------------------------------------------------------

CODE_0A6D:
	MOVW $60, YA
	MOVW $62, YA
	SET5 $48
	RET

;---------------------------------------------------------------------------

CODE_0A74:
	CALL CODE_0A96
	CALL CODE_08A7
	MOV $4E, A
	CALL CODE_08A7
	MOV Y, #$08
	MUL YA
	MOV X, A
	MOV Y, #$0F
CODE_0A85:
	MOV A, DATA_0DFE+x
	CALL CODE_05FA
	INC X
	MOV A, Y
	CLRC
	ADC A, #$10
	MOV Y, A
	BPL CODE_0A85
	MOV X, $44
	RET

;---------------------------------------------------------------------------

CODE_0A96:
	MOV $4D, A
	MOV Y, #$7D
	MOV $00F2, Y
	MOV A, $00F3
	CMP A, $4D
	BEQ CODE_0ACF
	AND A, #$0F
	EOR A, #$FF
	BBC7 $4C, CODE_0AAE
	CLRC
	ADC A, $4C
CODE_0AAE:
	MOV $4C, A
	MOV Y, #$04
CODE_0AB2:
	MOV A, DATA_0E1D+y
	MOV $00F2, A
	MOV A, #$00
	MOV $00F3, A
	DBNZ Y, CODE_0AB2
	MOV A, $48
	OR A, #$20
	MOV Y, #$6C
	CALL CODE_05FA
	MOV A, $4D
	MOV Y, #$7D
	CALL CODE_05FA
CODE_0ACF:
	ASL A
	ASL A
	ASL A
	EOR A, #$FF
	SETC
	ADC A, #$3C
	MOV Y, #$6D
	JMP CODE_05FA

;---------------------------------------------------------------------------

CODE_0ADC:
	MOV $5F, A
	RET

;---------------------------------------------------------------------------

CODE_0ADF:
	PUSH A
	MOV A, $47
	AND A, $1A
	POP A
	BEQ CODE_0B0D
	MOV $10, #$02
	BRA CODE_0AFF

CODE_0AEC:
	MOV A, $A0+x
	BNE CODE_0B34
	MOV A, ($30+x)
	CMP A, #$F9
	BNE CODE_0B34
	MOV A, $47
	AND A, $1A
	BEQ CODE_0B07
	MOV $10, #$04
CODE_0AFF:
	CALL CODE_08A9
	DBNZ $10, CODE_0AFF
	BRA CODE_0B34

CODE_0B07:
	CALL CODE_08A9
	CALL CODE_08A7
CODE_0B0D:
	MOV $A1+x, A
	CALL CODE_08A7
	MOV $A0+x, A
	CALL CODE_08A7
	CLRC
	ADC A, $50
	ADC A, $02F0+x
CODE_0B1D:
	AND A, #$7F
	MOV $0380+x, A
	SETC
	SBC A, $0361+x
	MOV Y, $A0+x
	PUSH Y
	POP X
	CALL CODE_0B40
	MOV $0370+x, A
	MOV A, Y
	MOV $0371+x, A
CODE_0B34:
	RET

;---------------------------------------------------------------------------

CODE_0B35:
	MOV A, $0361+x
	MOV $11, A
	MOV A, $0360+x
	MOV $10, A
	RET

;---------------------------------------------------------------------------

CODE_0B40:
	NOTC
	ROR $12
	BPL CODE_0B48
	EOR A, #$FF
	INC A
CODE_0B48:
	MOV Y, #$00
	DIV YA, X
	PUSH A
	MOV A, #$00
	DIV YA, X
	POP Y
	MOV X, $44
CODE_0B52:
	BBC7 $12, CODE_0B5B
	MOVW $14, YA
	MOVW YA, $0E
	SUBW YA, $14
CODE_0B5B:
	RET

;---------------------------------------------------------------------------

DATA_0B5C:
	dw $08B1
	dw $090A
	dw $0918
	dw $0931
	dw $093D
	dw $0958
	dw $0967
	dw $0979
	dw $0981
	dw $0993
	dw $0996
	dw $09A5
	dw $09B1
	dw $09E2
	dw $09EB
	dw $0A13
	dw $0948
	dw $09B4
	dw $09B8
	dw $09DB
	dw $0A04
	dw $0A36
	dw $0A6D
	dw $0A74
	dw $0A4C
	dw $0ADF
	dw $0ADC

DATA_0B92:
	db $01,$01,$02,$03,$00,$01,$02,$01,$02,$01,$01,$03,$00,$01,$02,$03
	db $01,$03,$03,$00,$01,$03,$00,$03,$03,$03,$01

;---------------------------------------------------------------------------

CODE_0BAD:
	MOV A, $90+x
	BEQ CODE_0BBA
	MOV A, #$00
	MOV Y, #$03
	DEC $90+x
	CALL CODE_0C43
CODE_0BBA:
	MOV Y, $C1+x
	BEQ CODE_0BE1
	MOV A, $02E0+x
	CBNE $C0+x, CODE_0BDF
	OR $5E, $47
	MOV A, $02D0+x
	BPL CODE_0BD3
	INC Y
	BNE CODE_0BD3
	MOV A, #$80
	BRA CODE_0BD7

CODE_0BD3:
	CLRC
	ADC A, $02D1+x
CODE_0BD7:
	MOV $02D0+x, A
	CALL CODE_0DCC
	BRA CODE_0BE6

CODE_0BDF:
	INC $C0+x
CODE_0BE1:
	MOV A, #$FF
	CALL CODE_0DD7
CODE_0BE6:
	MOV A, $91+x
	BEQ CODE_0BF3
	MOV A, #$30
	MOV Y, #$03
	DEC $91+x
	CALL CODE_0C43
CODE_0BF3:
	MOV A, $47
	AND A, $5E
	BEQ CODE_0C42
	MOV A, $0331+x
	MOV Y, A
	MOV A, $0330+x
	MOVW $10, YA
CODE_0C02:
	MOV A, X
	XCN A
	LSR A
	MOV $12, A
CODE_0C07:
	MOV Y, $11
	MOV A, DATA_0DE9+$01+y
	SETC
	SBC A, DATA_0DE9+y
	MOV Y, $10
	MUL YA
	MOV A, Y
	MOV Y, $11
	CLRC
	ADC A, DATA_0DE9+y
	MOV Y, A
	MOV $0250+x, A
	MOV A, $0321+x
	MUL YA
	MOV A, $0351+x
	ASL A
	BBC0 $12, CODE_0C2A
	ASL A
CODE_0C2A:
	MOV A, Y
	BCC CODE_0C30
	EOR A, #$FF
	INC A
CODE_0C30:
	MOV Y, $12
	CALL CODE_05F2
	MOV Y, #$14
	MOV A, #$00
	SUBW YA, $10
	MOVW $10, YA
	INC $12
	BBC1 $12, CODE_0C07
CODE_0C42:
	RET

;---------------------------------------------------------------------------

CODE_0C43:
	OR $5E, $47
CODE_0C46:
	MOVW $14, YA
	MOVW $16, YA
	PUSH X
	POP Y
	CLRC
	BNE CODE_0C59
	ADC $16, #$1F
	MOV A, #$00
	MOV ($14)+y, A
	INC Y
	BRA CODE_0C62

CODE_0C59:
	ADC $16, #$10
	CALL CODE_0C60
	INC Y
CODE_0C60:
	MOV A, ($14)+y
CODE_0C62:
	ADC A, ($16)+y
	MOV ($14)+y, A
	RET

;---------------------------------------------------------------------------

CODE_0C67:
	MOV A, $71+x
	BEQ CODE_0CD0
	DEC $71+x
	BEQ CODE_0C74
	MOV A, #$02
	CBNE $70+x, CODE_0CD0
CODE_0C74:
	MOV A, $80+x
	MOV $17, A
	MOV A, $30+x
	MOV Y, $31+x
CODE_0C7C:
	MOVW $14, YA
	MOV Y, #$00
CODE_0C80:
	MOV A, ($14)+y
	BEQ CODE_0CA2
	BMI CODE_0C8D
CODE_0C86:
	INC Y
	BMI CODE_0CC9
	MOV A, ($14)+y
	BPL CODE_0C86
CODE_0C8D:
	CMP A, #$C8
	BEQ CODE_0CD0
	CMP A, #$EF
	BEQ CODE_0CBE
	CMP A, #$E0
	BCC CODE_0CC9
	PUSH Y
	MOV Y, A
	POP A
	ADC A, $0AB2+y
	MOV Y, A
	BRA CODE_0C80

CODE_0CA2:
	MOV A, $17
	BEQ CODE_0CC9
	DEC $17
	BNE CODE_0CB4
	MOV A, $0231+x
	PUSH A
	MOV A, $0230+x
	POP Y
	BRA CODE_0C7C

CODE_0CB4:
	MOV A, $0241+x
	PUSH A
	MOV A, $0240+x
	POP Y
	BRA CODE_0C7C

CODE_0CBE:
	INC Y
	MOV A, ($14)+y
	PUSH A
	INC Y
	MOV A, ($14)+y
	MOV Y, A
	POP A
	BRA CODE_0C7C

CODE_0CC9:
	MOV A, $47
	MOV Y, #$5C
	CALL CODE_05F2
CODE_0CD0:
	CLR7 $13
	MOV A, $A0+x
	BEQ CODE_0CEF
	MOV A, $A1+x
	BEQ CODE_0CDE
	DEC $A1+x
	BRA CODE_0CEF

CODE_0CDE:
	MOV A, $1A
	AND A, $47
	BNE CODE_0CEF
	SET7 $13
	MOV A, #$60
	MOV Y, #$03
	DEC $A0+x
	CALL CODE_0C46
CODE_0CEF:
	CALL CODE_0B35
	MOV A, $B1+x
	BEQ CODE_0D42
	MOV A, $02B0+x
	CBNE $B0+x, CODE_0D40
	MOV A, $0100+x
	CMP A, $02B1+x
	BNE CODE_0D09
	MOV A, $02C1+x
	BRA CODE_0D16

CODE_0D09:
	SETP
	INC $00+x
	CLRP
	MOV Y, A
	BEQ CODE_0D12
	MOV A, $B1+x
CODE_0D12:
	CLRC
	ADC A, $02C0+x
CODE_0D16:
	MOV $B1+x, A
	MOV A, $02A0+x
	CLRC
	ADC A, $02A1+x
	MOV $02A0+x, A
CODE_0D22:
	MOV $12, A
	ASL A
	ASL A
	BCC CODE_0D2A
	EOR A, #$FF
CODE_0D2A:
	MOV Y, A
	MOV A, $B1+x
	CMP A, #$F1
	BCC CODE_0D36
	AND A, #$0F
	MUL YA
	BRA CODE_0D3A

CODE_0D36:
	MUL YA
	MOV A, Y
	MOV Y, #$00
CODE_0D3A:
	CALL CODE_0DB7
CODE_0D3D:
	JMP CODE_056F

CODE_0D40:
	INC $B0+x
CODE_0D42:
	BBS7 $13, CODE_0D3D
	RET

;---------------------------------------------------------------------------

CODE_0D46:
	CLR7 $13
	MOV A, $C1+x
	BEQ CODE_0D55
	MOV A, $02E0+x
	CBNE $C0+x, CODE_0D55
	CALL CODE_0DBF
CODE_0D55:
	MOV A, $0331+x
	MOV Y, A
	MOV A, $0330+x
	MOVW $10, YA
	MOV A, $91+x
	BEQ CODE_0D6C
	MOV A, $0341+x
	MOV Y, A
	MOV A, $0340+x
	CALL CODE_0DA1
CODE_0D6C:
	BBC7 $13, CODE_0D72
	CALL CODE_0C02
CODE_0D72:
	CLR7 $13
	CALL CODE_0B35
	MOV A, $A0+x
	BEQ CODE_0D89
	MOV A, $A1+x
	BNE CODE_0D89
	MOV A, $0371+x
	MOV Y, A
	MOV A, $0370+x
	CALL CODE_0DA1
CODE_0D89:
	MOV A, $B1+x
	BEQ CODE_0D42
	MOV A, $02B0+x
	CBNE $B0+x, CODE_0D42
	MOV Y, $51
	MOV A, $02A1+x
	MUL YA
	MOV A, Y
	CLRC
	ADC A, $02A0+x
	JMP CODE_0D22

CODE_0DA1:
	SET7 $13
	MOV $12, Y
	CALL CODE_0B52
	PUSH Y
	MOV Y, $51
	MUL YA
	MOV $14, Y
	MOV $15, #$00
	MOV Y, $51
	POP A
	MUL YA
	ADDW YA, $14
CODE_0DB7:
	CALL CODE_0B52
	ADDW YA, $10
	MOVW $10, YA
	RET

;---------------------------------------------------------------------------

CODE_0DBF:
	SET7 $13
	MOV Y, $51
	MOV A, $02D1+x
	MUL YA
	MOV A, Y
	CLRC
	ADC A, $02D0+x
CODE_0DCC:
	ASL A
	BCC CODE_0DD1
	EOR A, #$FF
CODE_0DD1:
	MOV Y, $C1+x
	MUL YA
	MOV A, Y
	EOR A, #$FF
CODE_0DD7:
	MOV Y, $59
	MUL YA
	MOV A, $0210+x
	MUL YA
	MOV A, $0301+x
	MUL YA
	MOV A, Y
	MUL YA
	MOV A, Y
	MOV $0321+x, A
	RET

;---------------------------------------------------------------------------

DATA_0DE9:
	db $00,$01,$03,$07,$0D,$15,$1E,$29,$34,$42,$51,$5E,$67,$6E,$73,$77
	db $7A,$7C,$7D,$7E,$7F

DATA_0DFE:
	db $7F,$00,$00,$00,$00,$00,$00,$00,$58,$BF,$DB,$F0,$FE,$07,$0C,$0C
	db $0C,$21,$2B,$2B,$13,$FE,$F3,$F9,$34,$33,$00,$D9,$E5,$01,$FC

DATA_0E1D:
	db $EB,$2C,$3C,$0D,$4D,$6C,$4C,$5C,$3D,$2D

DATA_0E27:
	db $5C,$61,$63,$4E,$4A,$48,$45,$0E,$49,$4B,$46

DATA_0E32:
	dw $085F,$08DE,$0965,$09F4,$0A8C,$0B2C,$0BD6,$0C8B
	dw $0D4A,$0E14,$0EEA,$0FCD,$10BE

DATA_0E4C:
	db "*Ver S1.20*"

CODE_0E57:
	MOV A, #$AA
	MOV $00F4, A
	MOV A, #$BB
	MOV $00F5, A
CODE_0E61:
	MOV A, $00F4
	CMP A, #$CC
	BNE CODE_0E61
	BRA CODE_0E8A

CODE_0E6A:
	MOV Y, $00F4
	BNE CODE_0E6A
CODE_0E6F:
	CMP Y, $00F4
	BNE CODE_0E83
	MOV A, $00F5
	MOV $00F4, Y
	MOV ($14)+y, A
	INC Y
	BNE CODE_0E6F
	INC $15
	BRA CODE_0E6F

CODE_0E83:
	BPL CODE_0E6F
	CMP Y, $00F4
	BPL CODE_0E6F
CODE_0E8A:
	MOV A, $00F6
	MOV Y, $00F7
	MOVW $14, YA
	MOV Y, $00F4
	MOV A, $00F5
	MOV $00F4, Y
	BNE CODE_0E6A
	MOV X, #$31
	MOV $00F1, X
	RET
%SPCDataBlockEnd(0400)

%SPCDataBlockStart(3EBB)
DATA_3EBB:
	db $B3,$B3,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$B4
	db $00,$00,$00,$00,$00,$00,$B0,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$B5,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $BD,$00,$00,$B6,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$BC,$B7,$00,$00,$00,$00,$00,$C6,$00,$00,$B8
	db $00,$00,$00,$BB,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $48,$7D,$00,$00,$00,$00,$00,$00,$00,$C1,$00,$00,$00,$00,$B1,$00
	db $C2,$C3,$00,$00,$C4,$00,$C7,$00,$C9,$C6,$00,$BE,$BF,$C0,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$B1,$B2,$00,$00,$00,$00,$B9,$BA,$00,$30,$00,$00,$00,$00,$00
	db $00,$00,$00,$C5,$00,$00,$C8,$00,$CA,$00,$00,$00,$00,$00,$00
%SPCDataBlockEnd(3EBB)

%SPCDataBlockStart(0EB0)
DATA_0EB0:
	db $6F,$6F,$68,$58,$6D,$68,$58,$4D,$4C,$58,$58,$58,$58,$58,$58,$58
	db $58,$58,$59,$48,$68,$58,$6E,$58,$58,$58,$51,$58,$68,$68,$57,$6E
	db $2F,$2F,$2F,$2F,$58,$51,$4E,$2F,$2F,$2F,$2F,$2F,$2F,$2F,$2F,$5E
	db $6E,$58,$58,$58,$58,$59,$68,$68,$57,$58,$58,$68,$5E,$68,$58,$68
	db $58,$58,$68,$3F,$68,$68,$48,$48,$68,$3E,$68,$68,$68,$68,$68,$68
	db $68,$68,$68,$68,$68,$68,$4F,$4F,$45,$45,$55,$55,$55,$55,$55,$55
	db $55,$55,$55,$59,$55,$59,$58,$57,$57,$58,$58,$58,$58,$48,$41,$6E
	db $3F,$6E,$6D,$6E,$58,$58,$58,$5E,$5E,$5E,$5D,$5E,$5E,$3F,$3F,$3F
	db $3F,$3F,$5F,$5E,$5E,$5E,$5E,$5E,$5E,$5E,$5D,$5D,$5D,$5E,$6E,$6E
	db $5E,$5E,$3E,$3F,$4E,$58,$6E,$45,$5E,$58,$6E,$58,$58,$58,$4E,$48
	db $58,$58,$15,$03,$00,$15,$43,$36,$35,$0E,$49,$35,$36,$2D,$4E,$3F
	db $3F,$4F,$5F,$46,$35,$6D,$46,$5E,$4E,$3E,$4E,$39,$4D,$46,$46,$3F
	db $49,$68,$68,$5E,$6E,$46,$5E,$4E,$67,$4C,$45,$39,$4D

DATA_0F7D:
	db $46,$46,$84,$1D,$84,$1D,$64,$11,$98,$11,$26,$12,$BD,$11,$EE,$11
	db $09,$12,$15,$12,$94,$14,$C3,$12,$D0,$12,$D7,$12,$DE,$12,$E5,$12
	db $EC,$12,$F3,$12,$FA,$12,$3D,$13,$64,$13,$7A,$13,$D4,$13,$DE,$13
	db $ED,$13,$11,$14,$2A,$14,$3A,$14,$81,$14,$D4,$14,$DE,$14,$18,$15
	db $E8,$15,$1D,$11,$63,$13,$74,$16,$63,$13,$3A,$11,$46,$14,$84,$1B
	db $53,$1A,$59,$1A,$5F,$1A,$65,$1A,$6B,$1A,$71,$1A,$77,$1A,$7D,$1A
	db $BD,$1B,$EB,$1B,$A1,$12,$BF,$14,$BF,$13,$A4,$13,$B6,$12,$7D,$15
	db $6E,$18,$83,$18,$89,$18,$A1,$18,$AD,$18,$C3,$18,$43,$1A,$49,$1A
	db $22,$15,$39,$15,$63,$13,$59,$15,$DA,$16,$7A,$16,$29,$16,$65,$16
	db $35,$18,$68,$18,$6D,$15,$49,$12,$53,$12,$5D,$12,$67,$12,$71,$12
	db $7B,$12,$01,$13,$0B,$13,$15,$13,$1F,$13,$29,$13,$33,$13,$18,$18
	db $21,$18,$A7,$18,$F7,$17,$37,$1A,$B7,$1A,$C7,$1A,$E8,$1A,$83,$1A
	db $89,$1A,$8F,$1A,$95,$1A,$AF,$1A,$F1,$14,$03,$1B,$13,$1B,$4B,$1B
	db $80,$16,$AA,$16,$D6,$1B,$DD,$1B,$E4,$1B,$A0,$15,$D2,$16,$00,$00
	db $B4,$1C,$B4,$1C,$B4,$1C,$74,$11,$0B,$16,$B3,$18,$59,$19,$61,$19
	db $13,$19,$53,$19,$78,$19,$28,$1A,$19,$1A,$CD,$18,$52,$14,$64,$14

DATA_107D:
	db $2C,$19,$5C,$16,$FC,$15,$05,$1A,$FF,$14,$8F,$18,$95,$18,$9F,$19
	db $9B,$18,$CC,$15,$AE,$17,$7A,$17,$93,$17,$65,$17,$D0,$17,$84,$1D
	db $40,$1D,$38,$17,$EA,$16,$4C,$1D,$54,$1D,$84,$1C,$61,$1D,$36,$1C
	db $04,$18,$65,$16,$87,$15,$03,$19,$5A,$1B,$69,$1B,$78,$1B,$78,$1D
	db $CD,$11,$D9,$11,$FB,$19,$00,$00,$00,$00,$63,$13,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$49,$15,$00,$00,$00,$00,$00,$00,$00,$00
	db $9F,$1B,$8C,$1D,$63,$13,$63,$13,$F2,$15,$9E,$12,$E0,$16,$48,$1B
	db $DC,$1C,$07,$1D,$2A,$1D,$1A,$16,$2F,$1B,$49,$15,$57,$1B,$66,$1B
	db $75,$1B,$BD,$17,$4D,$17,$0F,$17,$94,$1C,$A4,$1C,$B6,$15,$50,$1C
	db $6A,$1C,$35,$18,$29,$16,$1A,$16,$2F,$1B,$49,$15,$57,$1B,$66,$1B
	db $E0,$0B,$18,$64,$F9,$AD,$00,$18,$AB,$15,$59,$F1,$00,$12,$B5,$18
	db $64,$F9,$B0,$00,$18,$AF,$15,$59,$F1,$00,$12,$B5,$00,$E0,$14,$0C
	db $50,$F9,$A1,$00,$0C,$A3,$09,$59,$F1,$00,$06,$9F,$0C,$46,$F9,$9C
	db $00,$0C,$9F,$09,$59,$F1,$00,$06,$9A,$0C,$3C,$F9,$98,$00,$0C,$9A
	db $09,$59,$F1,$00,$06,$97,$00,$E0,$01,$0C,$6F,$F9,$A1,$00,$0C,$9F
	db $15,$77,$F1,$00,$12,$C1,$00,$E0,$01,$0C,$64,$F9,$A9,$00,$0A,$B9
	db $0C,$F9,$AD,$00,$0A,$BC,$06,$F9,$AF,$00,$04,$BE,$06,$46,$F9,$AF
	db $00,$04,$BE,$06,$28,$F9,$AF,$00,$04,$BE,$00,$E0,$01,$03,$59,$A4
	db $A6,$A7,$A8,$A9,$AA,$AB,$AC,$03,$4D,$A9,$AA,$AB,$AC,$03,$46,$A9
	db $AA,$AB,$AC,$03,$3F,$A9,$AA,$AB,$AC,$03,$38,$A9,$AA,$AB,$AC,$00
	db $E0,$02,$06,$38,$B4,$B7,$12,$00,$C8,$06,$38,$B4,$B7,$B6,$BA,$00
	db $E0,$17,$09,$78,$B0,$08,$B3,$07,$B6,$06,$BA,$00,$E0,$17,$04,$78
	db $B0,$B5,$B2,$B8,$B3,$B6,$AF,$AE,$B4,$B1,$06,$00,$B1,$06,$78,$B1
	db $00,$E0,$02,$09,$1C,$1C,$B0,$08,$19,$1F,$AE,$07,$1F,$19,$AC,$06
	db $15,$23,$AA,$05,$23,$15,$A8,$04,$0E,$2A,$A6,$00,$E0,$02,$0C,$59
	db $B4,$B7,$C0,$BC,$BE,$24,$C3,$00,$E0,$02,$08,$50,$5A,$BB,$12,$C0
	db $12,$14,$0A,$C0,$10,$08,$0F,$C0,$00,$E0,$02,$03,$46,$98,$9C,$9F
	db $A4,$9F,$A4,$A8,$AB,$B0,$AB,$A0,$A4,$A7,$AC,$A7,$AC,$B0,$B3,$B8
	db $B3,$A2,$A6,$A9,$AE,$A9,$AE,$B2,$B5,$BA,$B5,$00,$E0,$02,$06,$64
	db $00,$A8,$B0,$A8,$B0,$00,$E0,$02,$06,$50,$28,$A9,$B2,$A9,$B2,$00
	db $E0,$02,$06,$3C,$3C,$AB,$B4,$AB,$B4,$00,$E0,$02,$06,$28,$50,$AD
	db $B5,$AD,$B5,$00,$E0,$02,$06,$00,$64,$AF,$B7,$AF,$B7,$00,$E0,$02
	db $06,$64,$00,$B7,$06,$50,$1E,$B9,$06,$46,$28,$BB,$06,$3C,$32,$BC
	db $06,$32,$3C,$BE,$06,$28,$46,$C0,$06,$1E,$50,$C1,$06,$00,$64,$C3
	db $00,$0C,$00,$A4,$E0,$02,$08,$32,$B0,$B6,$08,$28,$BA,$0C,$1E,$BC
	db $18,$14,$08,$BC,$30,$08,$00,$BC,$00,$E0,$02,$08,$50,$B7,$BE,$0C
	db $3C,$C3,$18,$1E,$C3,$00,$E0,$04,$06,$59,$AE,$B5,$08,$14,$B5,$08
	db $0A,$B5,$00,$E0,$04,$06,$59,$B0,$B7,$00,$E0,$04,$06,$59,$B2,$B9
	db $00,$E0,$04,$06,$59,$B4,$BB,$00,$E0,$04,$06,$59,$B6,$BD,$00,$E0
	db $04,$06,$59,$B8,$BF,$00,$E0,$04,$06,$59,$BA,$C1,$00,$E0,$04,$06
	db $59,$BC,$C3,$00,$E0,$01,$18,$50,$F9,$C7,$00,$15,$BB,$00,$E0,$01
	db $18,$46,$F9,$C3,$00,$15,$B7,$00,$E0,$01,$18,$3C,$F9,$BF,$00,$15
	db $B3,$00,$E0,$01,$18,$3C,$F9,$BB,$00,$15,$AF,$00,$E0,$01,$18,$46
	db $F9,$B7,$00,$15,$AB,$00,$E0,$01,$18,$50,$F9,$B3,$00,$15,$A7,$00
	db $E0,$05,$08,$54,$F9,$9F,$00,$08,$A3,$12,$F1,$00,$12,$AB,$06,$3F
	db $F1,$00,$06,$A8,$11,$31,$F1,$00,$11,$AB,$08,$23,$F1,$00,$08,$A8
	db $0F,$15,$F1,$00,$0C,$AB,$00,$E0,$05,$0F,$54,$F9,$8C,$00,$0C,$90
	db $0C,$00,$8C,$E0,$01,$1B,$59,$F9,$96,$00,$18,$93,$00,$E0,$05,$0C
	db $2A,$0E,$F9,$A1,$00,$0C,$98,$06,$F1,$00,$06,$A3,$0C,$0E,$31,$F9
	db $A4,$00,$0C,$9B,$06,$F1,$00,$06,$A6,$0C,$3F,$15,$F9,$A7,$00,$0C
	db $9E,$09,$F1,$00,$06,$A8,$00,$E0,$03,$0C,$54,$F9,$9C,$00,$0C,$9F
	db $12,$F1,$00,$12,$A4,$06,$3F,$F1,$00,$06,$9C,$11,$31,$F1,$00,$0F
	db $98,$00,$E0,$00,$08,$54,$F9,$9C,$00,$08,$9F,$12,$F1,$00,$12,$A8
	db $0C,$3F,$F1,$00,$09,$A4,$00,$E0,$06,$1B,$46,$F9,$90,$00,$18,$9F
	db $00,$E0,$06,$06,$74,$F9,$98,$00,$06,$AD,$0F,$F1,$00,$0C,$A4,$00
	db $E0,$06,$03,$54,$B5,$B4,$B5,$B4,$03,$46,$B5,$B4,$03,$38,$B5,$B4
	db $03,$2A,$B5,$B4,$04,$0A,$15,$B5,$B4,$05,$05,$0A,$B5,$B4,$06,$08
	db $05,$B5,$B4,$00,$E0,$06,$0C,$38,$0E,$F9,$A4,$00,$0C,$B7,$18,$1C
	db $1C,$F1,$00,$18,$B0,$34,$0E,$38,$F1,$00,$30,$A4,$00,$E0,$06,$0F
	db $64,$F9,$98,$00,$0C,$93,$0F,$F9,$9C,$00,$0C,$9E,$00,$E0,$13,$06
	db $1E,$B5,$06,$00,$B5,$06,$14,$B5,$00,$E0,$09,$06,$5A,$C1,$06,$00
	db $B5,$06,$5A,$C0,$00,$E0,$17,$0A,$7F,$78,$BB,$BB,$0A,$BA,$B6,$14
	db $B9,$0A,$AE,$AE,$AE,$AE,$00,$E0,$17,$06,$7F,$78,$BB,$06,$BB,$06
	db $BB,$06,$BB,$06,$BB,$06,$BB,$06,$BB,$06,$BB,$06,$BB,$06,$BB,$06
	db $BB,$18,$BB,$00,$E0,$16,$09,$4F,$F9,$A4,$00,$06,$AB,$E0,$08,$1B
	db $72,$F9,$B7,$00,$0C,$A4,$00,$E0,$13,$04,$3E,$3E,$BB,$C0,$04,$45
	db $37,$AB,$A6,$04,$37,$45,$98,$9A,$04,$4C,$30,$9C,$91,$04,$30,$4C
	db $95,$97,$04,$53,$29,$90,$8C,$04,$29,$53,$8B,$82,$04,$5A,$22,$85
	db $87,$00,$E0,$0C,$06,$78,$A9,$E0,$08,$0C,$7A,$BB,$E0,$12,$0C,$7A
	db $BB,$E0,$17,$0C,$7A,$A3,$00,$E0,$08,$0F,$54,$F9,$A4,$00,$0C,$9F
	db $00,$E0,$10,$06,$64,$B0,$E0,$02,$06,$B7,$06,$50,$C3,$06,$28,$C3
	db $06,$14,$C3,$00,$E0,$0C,$09,$78,$B0,$0B,$78,$B7,$E0,$02,$0C,$28
	db $C0,$00,$E0,$13,$09,$78,$F9,$9F,$00,$06,$93,$09,$78,$F9,$9F,$00
	db $06,$93,$E0,$17,$04,$78,$95,$30,$78,$AD,$00,$E0,$08,$07,$6E,$F9
	db $9C,$00,$04,$B4,$00,$E0,$1A,$03,$78,$A1,$A1,$A1,$A1,$A1,$A1,$05
	db $A1,$A1,$A1,$07,$A1,$A1,$A1,$09,$A1,$A1,$A1,$00,$E0,$0C,$06,$78
	db $A8,$06,$00,$9A,$1B,$78,$F9,$AF,$00,$18,$A8,$00,$E0,$0C,$06,$78
	db $9C,$06,$00,$8E,$1B,$78,$F9,$A3,$00,$18,$9C,$00,$E0,$0A,$0F,$64
	db $F9,$9A,$00,$0C,$AB,$0F,$00,$8C,$1B,$64,$F9,$A4,$00,$18,$A1,$00
	db $E0,$0A,$0C,$32,$F9,$9F,$00,$0C,$A4,$1B,$32,$F1,$00,$18,$95,$00
	db $E0,$0E,$12,$78,$F9,$A4,$00,$0F,$B4,$00,$E0,$13,$30,$64,$3C,$F9
	db $C7,$00,$30,$C3,$30,$50,$50,$F1,$00,$30,$BE,$30,$3C,$64,$F1,$00
	db $2E,$BB,$00,$E0,$20,$30,$50,$F9,$BB,$00,$30,$B7,$30,$64,$F1,$00
	db $30,$B2,$30,$78,$F1,$00,$2E,$AB,$00,$E0,$20,$30,$50,$F9,$B5,$00
	db $30,$B2,$30,$64,$F1,$00,$30,$AD,$30,$78,$F1,$00,$2E,$A6,$00,$E0
	db $1F,$60,$50,$F9,$C7,$00,$60,$C3,$60,$64,$F1,$00,$60,$BE,$60,$64
	db $F1,$00,$60,$B7,$60,$78,$F1,$00,$5E,$B0,$00,$E0,$0D,$60,$78,$F9
	db $A6,$00,$5D,$B4,$00,$E0,$0D,$60,$5A,$F9,$BB,$00,$5D,$C7,$00,$E0
	db $1F,$60,$78,$F9,$C7,$00,$60,$BB,$60,$F1,$00,$5D,$AF,$00,$E0,$1F
	db $24,$78,$F9,$9A,$00,$24,$B2,$60,$F1,$00,$5D,$AB,$00,$E0,$1F,$24
	db $78,$F9,$A9,$00,$24,$C1,$60,$F1,$00,$5D,$B0,$00,$E0,$1C,$0C,$00
	db $54,$9C,$08,$1C,$0E,$9C,$0C,$46,$38,$9C,$12,$38,$54,$9D,$0C,$0E
	db $1C,$9A,$12,$2A,$1C,$98,$18,$1C,$0E,$97,$08,$0E,$1C,$9C,$0C,$1C
	db $0E,$98,$06,$2A,$15,$9A,$08,$0E,$1C,$9C,$30,$1C,$1C,$9A,$00,$E0
	db $14,$12,$78,$F9,$90,$00,$10,$9A,$E0,$0C,$60,$64,$F9,$9C,$00,$60
	db $98,$60,$F1,$00,$5E,$95,$00,$E0,$1C,$30,$78,$98,$00,$E0,$0C,$0C
	db $32,$BE,$00,$E0,$14,$0C,$64,$F9,$9A,$00,$0A,$9C,$0C,$00,$A4,$0C
	db $64,$F9,$9D,$00,$0A,$9F,$0C,$F9,$9A,$00,$0A,$9C,$0C,$00,$A4,$0C
	db $64,$F9,$9D,$00,$0A,$9F,$0C,$F9,$9A,$00,$0A,$9C,$00,$E0,$14,$0C
	db $64,$F9,$95,$00,$0A,$98,$0C,$00,$A4,$0C,$64,$F9,$95,$00,$0A,$98
	db $0C,$00,$A4,$12,$64,$F9,$91,$00,$10,$94,$0C,$00,$A4,$0C,$64,$F9
	db $95,$00,$0A,$98,$00,$E0,$14,$0A,$64,$A9,$A9,$A9,$00,$E0,$14,$48
	db $64,$A5,$00,$E0,$14,$0C,$00,$A5,$48,$0A,$28,$A5,$00,$E0,$14,$06
	db $78,$F9,$89,$00,$06,$93,$12,$F1,$00,$10,$8B,$0C,$F9,$85,$00,$0C
	db $90,$18,$F1,$00,$16,$89,$0C,$F9,$82,$00,$0C,$8C,$30,$F1,$00,$2E
	db $87,$00,$E0,$14,$12,$00,$A4,$06,$28,$50,$F9,$89,$00,$06,$93,$12
	db $F1,$00,$10,$8B,$0C,$F9,$85,$00,$0C,$90,$18,$F1,$00,$16,$89,$0C
	db $F9,$82,$00,$0C,$8C,$30,$F1,$00,$2E,$87,$00,$E0,$14,$30,$6E,$3C
	db $F9,$82,$00,$30,$8C,$48,$F1,$00,$48,$8E,$5A,$F1,$00,$58,$8B,$00
	db $E0,$14,$12,$00,$8B,$30,$3C,$50,$F9,$82,$00,$30,$8C,$48,$F1,$00
	db $48,$8E,$5A,$F1,$00,$58,$8B,$00,$E0,$14,$18,$3C,$F9,$89,$00,$24
	db $8E,$24,$64,$F1,$00,$24,$9A,$30,$F1,$00,$2E,$95,$00,$E0,$14,$06
	db $64,$F9,$91,$00,$06,$AD,$06,$F1,$00,$04,$A9,$06,$00,$A4,$12,$64
	db $F9,$A9,$00,$10,$A1,$00,$E0,$14,$06,$64,$F9,$91,$00,$06,$A9,$06
	db $F1,$00,$04,$A6,$06,$64,$F9,$91,$00,$06,$A4,$06,$F1,$00,$04,$A1
	db $00,$E0,$14,$0C,$64,$F9,$91,$00,$0C,$A9,$18,$F1,$00,$16,$9D,$00
	db $E0,$14,$0C,$00,$AA,$0C,$0A,$28,$F9,$91,$00,$0C,$A9,$18,$F1,$00
	db $16,$9D,$00,$E0,$14,$0C,$64,$F9,$95,$00,$0C,$AD,$18,$F1,$00,$16
	db $A1,$0C,$64,$F9,$91,$00,$0C,$A9,$18,$F1,$00,$16,$9D,$0C,$64,$F9
	db $8E,$00,$0C,$A6,$18,$F1,$00,$16,$9A,$00,$E0,$14,$06,$32,$BD,$04
	db $00,$BD,$06,$32,$BE,$BE,$00,$E0,$14,$06,$78,$F9,$9D,$00,$03,$85
	db $04,$00,$A4,$0C,$78,$F9,$A1,$00,$09,$89,$00,$E0,$05,$06,$64,$BE
	db $0C,$50,$BE,$00,$E0,$05,$06,$64,$C7,$06,$50,$C7,$C7,$C7,$08,$00
	db $A4,$06,$64,$C7,$C7,$C7,$C7,$00,$E0,$0C,$0C,$46,$B0,$06,$30,$AF
	db $06,$18,$AD,$0C,$2A,$A9,$12,$38,$A6,$18,$3F,$A5,$0C,$46,$A6,$12
	db $54,$A3,$18,$59,$A1,$0C,$54,$A0,$24,$1C,$9F,$18,$0E,$9E,$06,$1D
	db $A1,$0C,$18,$A0,$12,$1C,$9F,$30,$0E,$9E,$00,$E0,$03,$30,$50,$A4
	db $00,$E0,$1E,$08,$54,$F9,$B9,$00,$08,$B2,$06,$F1,$00,$06,$B4,$0C
	db $3F,$F1,$00,$09,$BC,$00,$E0,$10,$30,$50,$A4,$00,$E0,$11,$30,$50
	db $A4,$00,$E0,$12,$30,$78,$98,$00,$E0,$12,$30,$78,$9C,$00,$E0,$12
	db $30,$78,$9F,$00,$E0,$12,$30,$50,$A4,$00,$E0,$13,$48,$78,$91,$00
	db $E0,$14,$0C,$78,$9F,$00,$E0,$14,$06,$50,$BB,$06,$00,$BB,$0C,$50
	db $F9,$BB,$00,$0A,$BE,$00,$E0,$15,$0C,$50,$A4,$A4,$A4,$A4,$A4,$00
	db $E0,$0B,$0C,$00,$A4,$12,$50,$F9,$A9,$00,$12,$B0,$18,$F1,$00,$16
	db $A1,$12,$3C,$F9,$A4,$00,$12,$AD,$18,$F1,$00,$16,$9D,$12,$28,$F9
	db $9D,$00,$12,$A4,$18,$F1,$00,$16,$95,$12,$1E,$F9,$98,$00,$12,$A1
	db $18,$F1,$00,$16,$91,$00,$E0,$14,$06,$78,$F9,$A8,$00,$04,$9A,$06
	db $F9,$AB,$00,$04,$9D,$00,$E0,$14,$12,$78,$F9,$90,$00,$10,$9A,$06
	db $00,$A4,$12,$78,$F9,$90,$00,$12,$93,$18,$F1,$00,$16,$87,$00,$E0
	db $14,$12,$64,$F9,$90,$00,$12,$93,$18,$F1,$00,$16,$87,$12,$64,$F9
	db $8C,$00,$12,$90,$18,$F1,$00,$16,$84,$12,$64,$F9,$89,$00,$12,$8C
	db $30,$F1,$00,$2E,$80,$00,$E0,$15,$30,$64,$95,$00,$E0,$15,$08,$64
	db $A1,$A2,$A3,$00,$E0,$15,$08,$64,$A1,$A2,$A3,$08,$50,$A6,$08,$3C
	db $A6,$08,$28,$A6,$08,$14,$A6,$08,$0A,$A6,$00,$E0,$15,$12,$64,$F9
	db $90,$00,$12,$93,$18,$F1,$00,$16,$87,$0C,$64,$F9,$8C,$00,$0C,$91
	db $12,$F1,$00,$10,$85,$0C,$64,$F9,$89,$00,$0C,$8E,$12,$F1,$00,$10
	db $82,$00,$E0,$1F,$14,$78,$F9,$A4,$00,$14,$A8,$1A,$F1,$00,$18,$9C
	db $13,$F9,$A6,$00,$13,$A9,$19,$F1,$00,$17,$9D,$12,$F9,$A8,$00,$12
	db $AB,$18,$F1,$00,$16,$9F,$11,$F9,$A9,$00,$11,$AD,$17,$F1,$00,$15
	db $A1,$10,$F9,$AB,$00,$10,$AF,$16,$F1,$00,$14,$A3,$15,$F9,$AD,$00
	db $15,$B0,$0F,$F1,$00,$0D,$A4,$0E,$F9,$AF,$00,$0E,$B2,$14,$F1,$00
	db $12,$A6,$0D,$F9,$B0,$00,$0D,$B4,$13,$F1,$00,$11,$A8,$00,$E0,$13
	db $12,$5A,$F9,$90,$00,$10,$87,$00,$E0,$13,$0C,$78,$F9,$84,$00,$0C
	db $AB,$0C,$F1,$00,$0C,$93,$18,$F1,$00,$16,$87,$00,$E0,$16,$0C,$78
	db $F9,$8C,$00,$0C,$90,$24,$F1,$00,$22,$87,$00,$E0,$13,$08,$78,$F9
	db $8C,$00,$08,$A8,$12,$F1,$00,$10,$87,$00,$E0,$14,$06,$50,$AB,$AB
	db $A9,$B0,$0C,$A6,$9F,$00,$E0,$16,$30,$50,$98,$00,$E0,$14,$18,$50
	db $F9,$8C,$00,$16,$91,$00,$E0,$17,$30,$78,$98,$00,$E0,$17,$30,$78
	db $A1,$00,$E0,$17,$30,$78,$9D,$00,$E0,$17,$30,$78,$A6,$00,$E0,$17
	db $30,$78,$AB,$00,$E0,$17,$30,$78,$91,$00,$E0,$17,$30,$78,$97,$00
	db $E0,$17,$30,$78,$95,$00,$E0,$1B,$24,$78,$98,$00,$E0,$1B,$18,$78
	db $9D,$00,$E0,$1B,$18,$78,$A9,$00,$E0,$1B,$18,$78,$F9,$8C,$00,$16
	db $89,$00,$E0,$1B,$0C,$78,$F9,$98,$00,$0A,$89,$0C,$F9,$98,$00,$0A
	db $89,$00,$E0,$06,$06,$78,$B2,$B2,$B2,$00,$E0,$01,$06,$3C,$F9,$B9
	db $00,$06,$BC,$06,$F9,$B9,$00,$04,$BC,$00,$E0,$12,$08,$78,$B0,$B1
	db $B2,$B3,$08,$64,$B2,$B3,$B4,$B5,$08,$50,$B4,$B5,$B6,$B7,$08,$3C
	db $B6,$B7,$B8,$B9,$08,$28,$B8,$B9,$BA,$BB,$00,$E0,$03,$06,$78,$98
	db $99,$9A,$9B,$06,$64,$9A,$9B,$9C,$9D,$06,$78,$98,$99,$9A,$9B,$06
	db $64,$9A,$9B,$9C,$9D,$00,$E0,$03,$04,$78,$98,$99,$9A,$04,$00,$9A
	db $04,$64,$9C,$9D,$9E,$00,$E0,$17,$06,$78,$AF,$E0,$0C,$08,$AF,$A3
	db $E0,$17,$06,$A9,$E0,$12,$06,$BB,$06,$5A,$BB,$06,$46,$BB,$06,$28
	db $BB,$00,$E0,$0C,$0C,$78,$9D,$E0,$17,$04,$78,$A9,$BB,$B7,$BE,$AF
	db $04,$5A,$B2,$04,$46,$98,$04,$28,$A8,$00,$00,$06,$00,$A4,$E0,$12
	db $08,$78,$AB,$12,$B8,$10,$14,$28,$B8,$00,$06,$00,$A4,$E0,$12,$08
	db $78,$AF,$12,$BC,$10,$14,$28,$BC,$00,$06,$00,$A4,$E0,$12,$08,$78
	db $B2,$12,$BF,$10,$14,$28,$BF,$00,$06,$00,$A4,$E0,$12,$08,$78,$B5
	db $12,$C2,$10,$14,$28,$C2,$00,$E0,$1D,$06,$5A,$B0,$B1,$B2,$B3,$06
	db $64,$B4,$B6,$B7,$BA,$06,$78,$BC,$BD,$BE,$BF,$06,$64,$C0,$24,$28
	db $C0,$00,$E0,$1D,$04,$00,$A4,$06,$5A,$A9,$AA,$AB,$AC,$06,$64,$AD
	db $AE,$B0,$B1,$06,$78,$B2,$B3,$B4,$B6,$06,$64,$B7,$24,$28,$B7,$00
	db $E0,$1D,$06,$78,$BC,$BF,$BC,$BF,$BC,$BF,$BC,$BF,$06,$64,$BC,$BF
	db $BC,$BF,$12,$3C,$BF,$24,$28,$BF,$00,$E0,$02,$0C,$50,$B0,$B7,$00
	db $E0,$02,$0C,$50,$B4,$B7,$00,$E0,$02,$0C,$50,$BC,$B7,$00,$E0,$05
	db $03,$00,$4C,$AD,$AB,$03,$18,$37,$A8,$A4,$03,$1F,$29,$A3,$9F,$03
	db $26,$00,$9D,$9A,$03,$4C,$00,$AD,$AB,$03,$37,$22,$A8,$A4,$03,$33
	db $29,$A3,$9F,$03,$00,$30,$9D,$9A,$03,$00,$4C,$AD,$AB,$03,$22,$37
	db $A8,$A4,$03,$33,$29,$A3,$9F,$03,$30,$00,$9D,$9A,$00,$12,$64,$F9
	db $90,$00,$12,$93,$18,$F1,$00,$16,$87,$E0,$19,$24,$64,$B2,$12,$B2
	db $B2,$B2,$18,$B7,$B5,$B5,$B9,$60,$F9,$BB,$00,$60,$BB,$30,$F1,$00
	db $2E,$BB,$00,$E0,$19,$24,$64,$A3,$12,$A3,$A3,$A3,$18,$A6,$A4,$A4
	db $A9,$60,$F9,$AB,$00,$60,$AB,$30,$F1,$00,$2E,$AB,$00,$E0,$19,$24
	db $64,$AB,$12,$AB,$AB,$AB,$18,$AF,$AD,$AD,$B0,$60,$F9,$B2,$00,$60
	db $B2,$30,$F1,$00,$2E,$B2,$00,$E0,$19,$18,$64,$B7,$0C,$B7,$B7,$B7
	db $10,$B7,$B4,$B5,$60,$B7,$00,$E0,$19,$18,$64,$B4,$0C,$B4,$B4,$B4
	db $10,$B4,$B0,$B2,$60,$B4,$00,$E0,$19,$18,$64,$B0,$0C,$B0,$B0,$B0
	db $10,$B0,$AB,$AE,$60,$B0,$00,$E0,$0F,$1C,$00,$4B,$A4,$1C,$1E,$2D
	db $A8,$1C,$3C,$0F,$AC,$1C,$00,$4B,$A8,$1C,$1E,$2D,$AC,$1C,$3C,$0F
	db $B0,$E0,$19,$24,$64,$B3,$12,$B5,$24,$B7,$12,$BA,$60,$BC,$00,$E0
	db $0F,$0E,$00,$A4,$1C,$0F,$3C,$A6,$1C,$2D,$1E,$AA,$1C,$4B,$00,$AE
	db $1C,$0F,$3C,$AA,$1C,$2D,$1E,$AE,$0E,$4B,$00,$B2,$E0,$19,$24,$5A
	db $A4,$12,$A6,$24,$A8,$12,$A9,$60,$AB,$00,$E0,$0F,$1C,$00,$A4,$1C
	db $2D,$1E,$A2,$38,$0F,$3C,$A0,$1C,$2D,$1E,$A6,$1C,$0F,$3C,$A4,$E0
	db $19,$24,$5A,$AC,$12,$AE,$24,$B0,$12,$B2,$60,$B4,$00,$E0,$0F,$70
	db $00,$A4,$38,$00,$AC,$E0,$19,$24,$46,$9B,$12,$9D,$24,$9F,$12,$A2
	db $60,$A4,$00,$E0,$05,$08,$6E,$95,$06,$00,$95,$18,$6E,$95,$00,$E0
	db $05,$08,$78,$B5,$B9,$BC,$00,$E0,$05,$08,$78,$B5,$B9,$BC,$C1,$BC
	db $B9,$18,$B5,$00,$E0,$10,$08,$78,$B5,$B5,$C1,$08,$64,$B5,$B5,$C1
	db $08,$50,$B5,$B5,$C1,$08,$46,$B5,$B5,$C1,$00,$E0,$18,$06,$78,$9D
	db $06,$00,$A9,$06,$78,$9C,$00,$E0,$02,$10,$3C,$B4,$30,$B4,$00,$E0
	db $02,$08,$00,$B0,$10,$3C,$B0,$30,$B0,$00,$03,$FE,$F5,$B8,$03,$02
	db $10,$FE,$0A,$B8,$03,$00,$03,$FE,$11,$B8,$04,$00,$0B,$FE,$E0,$B8
	db $01,$E0,$10,$FE,$11,$B8,$03,$00,$06,$FE,$6A,$B8,$03,$00,$0E,$FE
	db $6A,$B8,$06,$00,$18,$FE,$6A,$B8,$05,$00,$11,$FE,$6A,$B8,$02,$00
	db $11,$FE,$00,$7F,$05,$00,$0F,$0E,$6A,$70,$03,$00,$0A,$FE,$E0,$70
	db $03,$74,$0D,$0E,$16,$7F,$01,$80,$0A,$B7,$10,$70,$01,$00,$0F,$F7
	db $6A,$70,$03,$00,$13,$FE,$94,$B8,$04,$F0,$14,$FF,$E0,$B8,$02,$70
	db $15,$FF,$E0,$B8,$02,$80,$16,$FF,$E0,$B8,$02,$30,$00,$FF,$E0,$B8
	db $02,$D6,$01,$FE,$E0,$B8,$03,$E0,$05,$FF,$E0,$B8,$03,$C0,$0C,$FF
	db $E0,$B8,$03,$D0,$07,$FF,$E0,$B8,$05,$40,$19,$F9,$E0,$B8,$03,$00
	db $0A,$BD,$40,$B8,$03,$74,$02,$FE,$E0,$B8,$04,$00,$17,$FE,$E0,$B8
	db $03,$00,$0D,$FE,$F3,$7F,$03,$00,$0E,$FE,$F5,$B8,$06,$00,$10,$CA
	db $D7,$B8,$04,$00,$0A,$BA,$4A,$70,$01,$00,$0A,$B8,$E0,$70,$02,$00

;---------------------------------------------------------------------------

CODE_1E5D:
	MOV A, #$80
	MOV Y, #$5C
	CALL CODE_05FA
	MOV A, $03C3
	AND A, #$80
	BEQ CODE_1E72
	SET7 $4A
	MOV Y, #$4D
	CALL CODE_05FA
CODE_1E72:
	MOV $05, #$00
	CLR7 $1A
	MOV X, #$0E
	MOV A, $021F
	CALL CODE_08B1
	MOV A, #$00
	MOV $03C9, A
	MOV $D1, A
	MOV $AE, A
	MOV $9E, A
	MOV A, $03EE
	MOV $038F, A
	MOV A, $03EF
	MOV $028E, A
	RET

CODE_1E97:
	MOV X, #$40
	MOV $9E, X
	MOV $03C9, X
	MOV A, #$00
	MOV $032E, A
	MOV X, $9E
	SETC
	SBC A, $030F
	CALL CODE_0B40
	MOV $031E, A
	MOV A, Y
	MOV $031F, A
CODE_1EB3:
	MOV A, $9E
	BEQ CODE_1E5D
	CMP A, #$01
	BEQ CODE_1E5D
	MOV A, #$00
	MOV Y, #$03
	MOV X, #$0E
	DEC $9E
	CALL CODE_0C46
	MOV A, $030F
	MOV $032F, A
	MOV A, #$0A
	MOV $035F, A
	MOV $11, A
	MOV $10, #$00
	MOV X, #$0E
	CALL CODE_0C02
	RET

;---------------------------------------------------------------------------

CODE_1EDC:
	MOV A, $03F8
	BEQ CODE_1EE4
	MOV $01, #$00
CODE_1EE4:
	MOV Y, $09
	CMP Y, $01
	BEQ CODE_1F01
	MOV A, $01
	MOV $05, A
	MOV $09, A
	BEQ CODE_1E97
	MOV A, Y
	BEQ CODE_1F15
	EOR A, $01
	AND A, #$E0
	BNE CODE_1F15
	MOV A, $D1
	BNE CODE_1F2C
	BRA CODE_1F44

CODE_1F01:
	MOV A, $01
	BNE CODE_1F0C
	MOV X, $03C9
	BEQ CODE_1F14
	BRA CODE_1EB3

CODE_1F0C:
	MOV A, $D1
	BNE CODE_1F2C
	MOV A, $05
	BNE CODE_1F5E
CODE_1F14:
	RET

CODE_1F15:
	MOV $D1, #$02
	MOV A, #$80
	MOV Y, #$5C
	CALL CODE_05FA
	SET7 $1A
	MOV A, #$00
	MOV $028E, A
	MOV $AE, A
	MOV $038F, A
CODE_1F2B:
	RET

CODE_1F2C:
	DBNZ $D1, CODE_1F2B
	CALL CODE_1FB8
	MOV A, #$80
	CALL CODE_3E79
	CLR7 $4A
	MOV A, $4A
	MOV Y, #$4D
	CALL CODE_05FA
	MOV A, #$01
	BNE CODE_1F46
CODE_1F44:
	MOV A, #$30
CODE_1F46:
	MOV $AE, A
	MOV $AF, #$00
	MOV A, $05
	AND A, #$0F
	MOV X, A
	MOV A, $2014+x
	MOV $03CD, A
	MOV X, #$0E
	MOV $44, X
	CALL CODE_0B1D
	RET

CODE_1F5E:
	CLR7 $13
	MOV A, $AE
	BEQ CODE_1F8A
	MOV X, #$0E
	CALL CODE_3E5F
	MOV A, #$FF
	MOV $032F, A
	MOV $030F, A
	MOV A, #$0A
	MOV $035F, A
	MOV $033F, A
	MOV X, #$0E
	MOV A, $0331+x
	MOV Y, A
	MOV A, $0330+x
	MOVW $10, YA
	MOV A, #$0E
	CALL CODE_0C02
	RET

CODE_1F8A:
	MOV A, $05
	BPL CODE_1FA2
	MOV A, #$20
	MOV $AE, A
	MOV $AF, #$00
	INC $D4
	BBS0 $D4, CODE_1F9E
	MOV A, #$9F
	BNE CODE_1FB0
CODE_1F9E:
	MOV A, #$A3
	BNE CODE_1FB0
CODE_1FA2:
	MOV A, #$70
	MOV $AE, A
	MOV $AF, #$00
	MOV A, $18
	AND A, #$03
	OR A, $03CD
CODE_1FB0:
	MOV X, #$0E
	MOV $44, X
	CALL CODE_0B1D
	RET

;---------------------------------------------------------------------------

CODE_1FB8:
	MOV A, $05
	AND A, #$E0
	CLRC
	ROL A
	ROL A
	ROL A
	ROL A
	MOV X, A
	MOV Y, #$06
	MUL YA
	MOV X, A
	MOV Y, #$74
	MOV $12, #$04
CODE_1FCB:
	MOV A, DATA_1FE4+x
	CALL CODE_05FA
	INC X
	INC Y
	DBNZ $12, CODE_1FCB
	MOV A, DATA_1FE4+x
	MOV $022F, A
	INC X
	MOV A, $1FE4+x
	MOV $022E, A
	RET

DATA_1FE4:
	db $09,$00,$00,$E8,$03,$00,$17,$00,$00,$E8,$00,$70,$00,$00,$00,$E8
	db $08,$C0,$09,$00,$00,$E5,$01,$00,$00,$00,$00,$E8,$02,$C0,$17,$00
	db $00,$E8,$0C,$C0,$0A,$00,$00,$E8,$01,$40,$09,$00,$00,$20,$06,$C0
	db $A4,$A6,$A7,$A8,$A6,$A7,$A8,$A9,$B0,$B0,$B0,$B0,$98,$98,$98,$98

;---------------------------------------------------------------------------

CODE_2024:
	MOV X, $03
	MOV $11, X
	MOV A, DATA_0EB0-$01+x
	MOV $10, A
	XCN A
	AND A, #$0F
	ASL A
	MOV Y, A
	MOV A, $03A0+y
	BEQ CODE_2045
	MOV X, A
	MOV A, DATA_0EB0-$01+x
	SETC
	CMP A, $10
	BEQ CODE_2045
	BCC CODE_2045
	JMP CODE_3EBA

CODE_2045:
	MOV A, $11
	MOV $03A0+y, A
	MOV $10, Y
	MOV A, #$01
	LSR $10
	BEQ CODE_2056
CODE_2052:
	ASL A
	DBNZ $10, CODE_2052
CODE_2056:
	MOV $03C1, A
	MOV $03C0, Y
	MOV A, $03C1
	OR A, $1A
	MOV $1A, A
	JMP CODE_20D8

;---------------------------------------------------------------------------

CODE_2066:
	MOV A, $00F7
	CMP A, $00F7
	BNE CODE_2066
	MOV $00F7, A
	MOV Y, A
	MOV A, $0B
	MOV $0B, Y
	CBNE $0B, CODE_207B
	MOV Y, #$00
CODE_207B:
	MOV $03, Y
	MOV A, $03
	BEQ CODE_2085
	CMP A, #$C0
	BCC CODE_20D5
CODE_2085:
	RET

CODE_2086:
	MOV A, #$00
	MOV $02B0, A
	MOV A, #$01
	MOV $02A1, A
	MOV A, #$FF
	MOV $B1, A
	MOV $02C1, A
	MOV A, #$F4
	MOV $0000, A
	RET

CODE_209D:
	MOV A, #$00
	MOV $02B0, A
	MOV A, #$00
	MOV $02A1, A
	MOV A, #$00
	MOV $B1, A
	MOV $02C1, A
	MOV A, #$F6
	MOV $0000, A
	RET

CODE_20B4:
	MOV A, $03F8
	BEQ CODE_20D1
	MOV A, #$00
	MOV $03F8, A
	CALL CODE_3E96
	BRA CODE_20D1

CODE_20C3:
	MOV A, $1A
	AND A, #$80
	EOR A, #$FF
	MOV $03F8, A
	MOV Y, #$5C
	CALL CODE_05FA
CODE_20D1:
	MOV A, $03
	BRA CODE_20E8

CODE_20D5:
	JMP CODE_2024

CODE_20D8:
	CALL CODE_3EA6
	MOV X, $03C0
	MOV A, $03
	CMP A, #$01
	BEQ CODE_20B4
	CMP A, #$02
	BEQ CODE_20C3
CODE_20E8:
	MOV $03A0+x, A
	CMP A, #$70
	BCC CODE_20FA
	CMP A, #$72
	BCS CODE_20FA
	MOV A, #$F2
	MOV $0000, A
	BRA CODE_2108

CODE_20FA:
	CMP A, #$21
	BNE CODE_2101
	CALL CODE_2086
CODE_2101:
	CMP A, #$22
	BNE CODE_2108
	CALL CODE_209D
CODE_2108:
	MOV A, #$03
	MOV $03A1+x, A
	MOV A, #$00
	MOV $0280+x, A
	MOV $A0+x, A
	MOV $0381+x, A
	MOV $02F0+x, A
	MOV A, $03C1
	OR A, $0007
	MOV $0007, A
	MOV A, $03C1
	MOV Y, #$5C
	CALL CODE_05FA
	MOV A, $03A0+x
	MOV X, A
	MOV A, $3EBA+x
	MOV $03, A
	BNE CODE_20D5
	RET

;---------------------------------------------------------------------------

CODE_2137:
	MOV A, $0007
	MOV $03CE, A
	BEQ CODE_216B
	MOV X, #$0C
	MOV A, #$40
	MOV $03C1, A
	ASL $03CE
CODE_2149:
	ASL $03CE
	BCC CODE_2164
	MOV $03C0, X
	MOV A, X
	XCN A
	LSR A
	MOV $03C2, A
	MOV A, $03A1+x
	BNE CODE_216C
	MOV A, $03A0+x
	BEQ CODE_2164
	JMP CODE_221B

CODE_2164:
	LSR $03C1
	DEC X
	DEC X
	BPL CODE_2149
CODE_216B:
	RET

CODE_216C:
	MOV $03C0, X
	MOV A, $03A1+x
	DEC A
	MOV $03A1+x, A
	BEQ CODE_217B
	JMP CODE_2164

CODE_217B:
	MOV A, $03A0+x
	ASL A
	MOV Y, A
	BCS CODE_2195
	MOV A, DATA_0F7D+$01+y
	MOV $0391+x, A
	MOV $2D, A
	MOV A, DATA_0F7D+y
	MOV $0390+x, A
	MOV $2C, A
	JMP CODE_2238

CODE_2195:
	MOV A, DATA_107D+$01+y
	MOV $0391+x, A
	MOV $2D, A
	MOV A, DATA_107D+y
	MOV $0390+x, A
	MOV $2C, A
	JMP CODE_2238

CODE_21A8:
	MOV X, $03C0
	MOV A, $03A0+x
	CMP A, #$70
	BCC CODE_21BB
	CMP A, #$72
	BCS CODE_21BB
	MOV A, #$F3
	MOV $0000, A
CODE_21BB:
	MOV A, #$00
	MOV $03A0+x, A
	MOV $A0+x, A
	MOV A, $03D0+x
	MOV $02F0+x, A
	MOV A, $03E0+x
	MOV $0381+x, A
	MOV A, $03E1+x
	MOV $0280+x, A
	MOV A, $1A
	SETC
	SBC A, $03C1
	MOV $1A, A
	MOV A, $0007
	SETC
	SBC A, $03C1
	MOV $0007, A
	MOV $44, X
	MOV A, $0211+x
	CALL CODE_08B1
	MOV A, $03C1
	AND A, $03C3
	BEQ CODE_2211
	AND A, $4A
	BNE CODE_2211
	MOV A, $4A
	CLRC
	ADC A, $03C1
	MOV $4A, A
	MOV Y, #$4D
	CALL CODE_05FA
	MOV A, $03F3
	SETC
	SBC A, $03C1
	MOV $03F3, A
CODE_2211:
	MOV X, $03C0
	RET

;---------------------------------------------------------------------------

CODE_2215:
	CALL CODE_21A8
	JMP CODE_2164

CODE_221B:
	CALL CODE_3EA6
	MOV $03C0, X
	MOV A, $0391+x
	MOV Y, A
	MOV A, $0390+x
	MOVW $2C, YA
	MOV A, $03B0+x
	DEC A
	MOV $03B0+x, A
	BEQ CODE_2236
	JMP CODE_22A3

CODE_2236:
	INCW $2C
CODE_2238:
	MOV A, $03C0
	XCN A
	LSR A
	MOV $03C2, A
	MOV X, #$00
	MOV A, ($2C+x)
	BEQ CODE_2215
	BMI CODE_227E
	MOV Y, $03C0
	MOV $03B1+y, A
	INCW $2C
	MOV A, ($2C+x)
	MOV $10, A
	BMI CODE_227E
	MOV Y, $03C2
	CALL CODE_05FA
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
	BPL CODE_2271
	MOV X, A
	MOV A, $10
	MOV Y, $03C2
	INC Y
	CALL CODE_05FA
	MOV A, X
	BRA CODE_227E

CODE_2271:
	MOV Y, $03C2
	INC Y
	CALL CODE_05FA
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
CODE_227E:
	CMP A, #$E0
	BNE CODE_2285
	JMP CODE_3E20

CODE_2285:
	CMP A, #$F9
	BEQ CODE_22D0
	CMP A, #$F1
	BEQ CODE_22E5
	MOV X, $03C0
	MOV Y, A
	CALL CODE_0505
	MOV A, $03C1
	CALL CODE_3E79
CODE_229A:
	MOV X, $03C0
	MOV A, $03B1+x
	MOV $03B0+x, A
CODE_22A3:
	CLR7 $13
	MOV X, $03C0
	MOV A, $A0+x
	BEQ CODE_22B1
	CALL CODE_3E5F
	BRA CODE_22C0

CODE_22B1:
	MOV A, #$02
	CMP A, $03B0+x
	BNE CODE_22C0
	MOV A, $03C1
	MOV Y, #$5C
	CALL CODE_05FA
CODE_22C0:
	MOV X, $03C0
	MOV A, $2D
	MOV $0391+x, A
	MOV A, $2C
	MOV $0390+x, A
	JMP CODE_2164

CODE_22D0:
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
	MOV X, $03C0
	MOV $44, X
	MOV Y, A
	CALL CODE_0505
	MOV A, $03C1
	CALL CODE_3E79
CODE_22E5:
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
	MOV X, $03C0
	MOV $A1+x, A
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
	MOV X, $03C0
	MOV $A0+x, A
	PUSH A
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
	POP Y
	MOV X, $03C0
	MOV $44, X
	CALL CODE_0B1D
	JMP CODE_229A
%SPCDataBlockEnd(0EB0)

%SPCDataBlockStart(3E20)
CODE_3E20:
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
	MOV Y, #$06
	MUL YA
	MOV $D2, #$97
	MOV $D3, #$1D
	ADDW YA, $D2
	MOVW $D2, YA
	MOV Y, #$00
	MOV A, $03C2
	OR A, #$04
	MOV X, A
	MOV $12, #$04
CODE_3E3E:
	MOV A, ($D2)+y
	PUSH Y
	PUSH X
	POP Y
	CALL CODE_05FA
	PUSH Y
	POP X
	POP Y
	INC X
	INC Y
	DBNZ $12, CODE_3E3E
	MOV A, ($D2)+y
	MOV X, $03C0
	MOV $0221+x, A
	INC Y
	MOV A, ($D2)+y
	MOV $0220+x, A
	JMP CODE_2236

;---------------------------------------------------------------------------

CODE_3E5F:
	SET7 $13
	MOV A, #$60
	MOV Y, #$03
	DEC $A0+x
	CALL CODE_0C46
	MOV A, $0361+x
	MOV Y, A
	MOV A, $0360+x
	MOVW $10, YA
	MOV $47, #$00
	JMP CODE_056F

;---------------------------------------------------------------------------

CODE_3E79:
	PUSH A
	MOV Y, #$5C
	MOV A, #$00
	CALL CODE_05FA
	POP A
	MOV Y, #$4C
	JMP CODE_05FA

;---------------------------------------------------------------------------

CODE_3E87:
	MOV A, $03F1
	BNE CODE_3EA5
	MOV A, $59
	MOV $03F1, A
	MOV A, #$88
	MOV $59, A
	RET

;---------------------------------------------------------------------------

CODE_3E96:
	MOV A, $03F1
	BEQ CODE_3EA5
	MOV A, $03F1
	MOV $59, A
	MOV A, #$00
	MOV $03F1, A
CODE_3EA5:
	RET

;---------------------------------------------------------------------------

CODE_3EA6:
	MOV A, $03C1
	AND A, $4A
	BEQ CODE_3EBA
	MOV A, $4A
	SETC
	SBC A, $03C1
	MOV $4A, A
	MOV Y, #$4D
	CALL CODE_05FA
CODE_3EBA:
	RET
%SPCDataBlockEnd(3E20)

%SPCDataBlockStart(D000)
DATA_D000:
	incbin "SPC700/TitleScreenMusic.bin"
%SPCDataBlockEnd(D000)

%SPCDataBlockStart(FF90)
DATA_FF90:
	db $00,$D0,$96,$D8,$02,$D0
%SPCDataBlockEnd(FF90)

%SPCDataBlockStart(3C00)
DATA_3C00:
	dw DATA_4000	:	dw DATA_4000+$0024
	dw DATA_7E79	:	dw DATA_7E79+$001B
	dw DATA_99C1	:	dw DATA_99C1+$09AB
	dw DATA_A36C	:	dw DATA_A36C+$0171
	dw DATA_A501	:	dw DATA_A501+$041D
	dw DATA_A966	:	dw DATA_A966+$001B
	dw DATA_A99C	:	dw DATA_A99C+$0120
	dw DATA_AB16	:	dw DATA_AB16+$0B91
	dw DATA_B6A7	:	dw DATA_B6A7+$0345
	dw DATA_B9EC	:	dw DATA_B9EC+$041D
	dw DATA_BF5F	:	dw DATA_BF5F+$03D5

	%FREE_BYTES($3C2C, 4, $FF)
%SPCDataBlockEnd(3C00)

%SPCDataBlockStart(4000)
DATA_4000:
	incbin "Samples/TitleScreen/00.brr"

DATA_7E79:
	incbin "Samples/TitleScreen/01.brr"

DATA_99C1:
	incbin "Samples/TitleScreen/02.brr"

DATA_A36C:
	incbin "Samples/TitleScreen/03.brr"

DATA_A501:
	incbin "Samples/TitleScreen/04.brr"

DATA_A966:
	incbin "Samples/TitleScreen/05.brr"

DATA_A99C:
	incbin "Samples/TitleScreen/06.brr"

DATA_AB16:
	incbin "Samples/TitleScreen/07.brr"

DATA_B6A7:
	incbin "Samples/TitleScreen/08.brr"

DATA_B9EC:
	incbin "Samples/TitleScreen/09.brr"

DATA_BF5F:
	incbin "Samples/TitleScreen/0A.brr"
%SPCDataBlockEnd(4000)

%EndSPCUploadAndJumpToEngine($0400)
