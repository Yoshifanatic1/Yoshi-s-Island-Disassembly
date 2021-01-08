
%SPCDataBlockStart(3C60)
	db $60,$B9,$E8,$BB,$03,$BC,$F3,$BF,$03,$BC,$F3,$BF,$29,$C0,$16,$C7
%SPCDataBlockEnd(3C60)

%SPCDataBlockStart(B960)
	incbin "Samples/IntroMapCastleFort/00.brr"
	incbin "Samples/IntroMapCastleFort/01.brr"
	incbin "Samples/IntroMapCastleFort/02.brr"
%SPCDataBlockEnd(B960)

%EndSPCUploadAndJumpToEngine($0400)
