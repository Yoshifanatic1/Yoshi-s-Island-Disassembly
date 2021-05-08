
%SPCDataBlockStart(3C60)
	dw DATA_B960	:	dw DATA_B960+$0345
	dw DATA_BCA5	:	dw DATA_BCA5+$0240
	dw DATA_BEE5	:	dw DATA_BEE5+$041D
	dw DATA_BEE5	:	dw DATA_BEE5+$041D
%SPCDataBlockEnd(3C60)

%SPCDataBlockStart(B960)
DATA_B960:
	incbin "Samples/CaveFortBoss/00.brr"

DATA_BCA5:
	incbin "Samples/CaveFortBoss/01.brr"

DATA_BEE5:
	incbin "Samples/CaveFortBoss/02.brr"
%SPCDataBlockEnd(B960)

%EndSPCUploadAndJumpToEngine($0400)
