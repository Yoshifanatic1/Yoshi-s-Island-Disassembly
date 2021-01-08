
%SPCDataBlockStart(3C60)
	db $60,$B9,$9E,$C0,$B9,$C0,$37,$C1,$40,$C1,$7B,$CB,$BA,$CB,$AA,$CF
%SPCDataBlockEnd(3C60)

%SPCDataBlockStart(B960)
	incbin "Samples/Athletic/00.brr"
	incbin "Samples/Athletic/01.brr"
	incbin "Samples/Athletic/02.brr"
	incbin "Samples/Athletic/03.brr"
%SPCDataBlockEnd(B960)

%EndSPCUploadAndJumpToEngine($0400)
