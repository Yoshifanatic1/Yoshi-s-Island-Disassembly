
%SPCDataBlockStart(3C60)
	db $60,$B9,$A5,$BC,$A5,$BC,$E5,$BE,$E5,$BE,$02,$C3,$E5,$BE,$02,$C3
%SPCDataBlockEnd(3C60)

%SPCDataBlockStart(B960)
	incbin "Samples/CaveFortBoss/00.brr"
	incbin "Samples/CaveFortBoss/01.brr"
	incbin "Samples/CaveFortBoss/02.brr"
%SPCDataBlockEnd(B960)

%EndSPCUploadAndJumpToEngine($0400)
