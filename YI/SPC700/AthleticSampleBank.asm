
%SPCDataBlockStart(3C60)
	dw DATA_B960	:	dw DATA_B960+$073E
	dw DATA_C0B9	:	dw DATA_C0B9+$007E
	dw DATA_C140	:	dw DATA_C140+$0A3B
	dw DATA_CBBA	:	dw DATA_CBBA+$03F0
%SPCDataBlockEnd(3C60)

%SPCDataBlockStart(B960)
DATA_B960:
	incbin "Samples/Athletic/00.brr"

DATA_C0B9:
	incbin "Samples/Athletic/01.brr"

DATA_C140:
	incbin "Samples/Athletic/02.brr"

DATA_CBBA:
	incbin "Samples/Athletic/03.brr"
%SPCDataBlockEnd(B960)

%EndSPCUploadAndJumpToEngine($0400)
