
%SPCDataBlockStart(3C60)
	dw DATA_B960	:	dw DATA_B960+$0693
	dw DATA_BFF3	:	dw DATA_BFF3+$02FD
	dw DATA_C2F0	:	dw DATA_C2F0+$0585
	dw DATA_C875	:	dw DATA_C875+$02EB
%SPCDataBlockEnd(3C60)

%SPCDataBlockStart(B960)
DATA_B960:
	incbin "Samples/BonusCastleBossGrassland/00.brr"

DATA_BFF3:
	incbin "Samples/BonusCastleBossGrassland/01.brr"

DATA_C2F0:
	incbin "Samples/BonusCastleBossGrassland/02.brr"

DATA_C875:
	incbin "Samples/BonusCastleBossGrassland/03.brr"
%SPCDataBlockEnd(B960)

%EndSPCUploadAndJumpToEngine($0400)
