
%SPCDataBlockStart(3C60)
	db $60,$B9,$F3,$BF,$F3,$BF,$F0,$C2,$F0,$C2,$75,$C8,$75,$C8,$60,$CB
%SPCDataBlockEnd(3C60)

%SPCDataBlockStart(B960)
	incbin "Samples/BonusCastleBossGrassland/00.brr"
	incbin "Samples/BonusCastleBossGrassland/01.brr"
	incbin "Samples/BonusCastleBossGrassland/02.brr"
	incbin "Samples/BonusCastleBossGrassland/03.brr"
%SPCDataBlockEnd(B960)

%EndSPCUploadAndJumpToEngine($0400)
