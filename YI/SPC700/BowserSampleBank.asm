
%SPCDataBlockStart(3C50)
	dw $FFFF	:	dw $FFFF
	dw $FFFF	:	dw $FFFF
	dw DATA_A483	:	dw DATA_A483+$07BC
	dw DATA_AC3F	:	dw DATA_AC3F+$0693
	dw DATA_AC3F	:	dw DATA_AC3F+$0693
	dw DATA_B2D2	:	dw DATA_B2D2+$0E2B
	dw DATA_C0FD	:	dw DATA_C0FD+$044A
	dw DATA_C0FD	:	dw DATA_C0FD+$044A
%SPCDataBlockEnd(3C50)

%SPCDataBlockStart(A480)
	%FREE_BYTES($A480, 3, $FF)

DATA_A483:
	incbin "Samples/Bowser/00.brr"

DATA_AC3F:
	incbin "Samples/Bowser/01.brr"

DATA_B2D2:
	incbin "Samples/Bowser/02.brr"

DATA_C0FD:
	incbin "Samples/Bowser/03.brr"
%SPCDataBlockEnd(A480)

%EndSPCUploadAndJumpToEngine($0400)
