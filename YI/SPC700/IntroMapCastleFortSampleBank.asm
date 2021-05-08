
%SPCDataBlockStart(3C60)
	dw DATA_B960	:	dw DATA_B960+$0288
	dw DATA_BC03	:	dw DATA_BC03+$03F0
	dw DATA_BC03	:	dw DATA_BC03+$03F0
	dw DATA_C029	:	dw DATA_C029+$06ED
%SPCDataBlockEnd(3C60)

%SPCDataBlockStart(B960)
DATA_B960:
	incbin "Samples/IntroMapCastleFort/00.brr"

DATA_BC03:
	incbin "Samples/IntroMapCastleFort/01.brr"

DATA_C029:
	incbin "Samples/IntroMapCastleFort/02.brr"
%SPCDataBlockEnd(B960)

%EndSPCUploadAndJumpToEngine($0400)
