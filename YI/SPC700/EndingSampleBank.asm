
%SPCDataBlockStart(3C00)
	dw DATA_4000	:	dw DATA_4000+$0171
	dw DATA_419E	:	dw DATA_419E+$06ED
	dw DATA_4F39	:	dw DATA_4F39+$0E34
	dw DATA_5DAC	:	dw DATA_5DAC+$00C6
	dw DATA_5E7B	:	dw DATA_5E7B+$06AE
	dw DATA_6649	:	dw DATA_6649+$041D
	dw DATA_6AAE	:	dw DATA_6AAE+$0288
	dw DATA_6D51	:	dw DATA_6D51+$0BA3
	dw DATA_78F4	:	dw DATA_78F4+$0372
	dw DATA_8302	:	dw DATA_8302+$00E1
	dw DATA_83FE	:	dw DATA_83FE+$1923
	dw DATA_9DA8	:	dw DATA_9DA8+$1EF0
%SPCDataBlockEnd(3C00)

%SPCDataBlockStart(4000)
DATA_4000:
	incbin "Samples/Ending/00.brr"

DATA_419E:
	incbin "Samples/Ending/01.brr"

DATA_4F39:
	incbin "Samples/Ending/02.brr"

DATA_5DAC:
	incbin "Samples/Ending/03.brr"

DATA_5E7B:
	incbin "Samples/Ending/04.brr"

DATA_6649:
	incbin "Samples/Ending/05.brr"

DATA_6AAE:
	incbin "Samples/Ending/06.brr"

DATA_6D51:
	incbin "Samples/Ending/07.brr"

DATA_78F4:
	incbin "Samples/Ending/08.brr"

DATA_8302:
	incbin "Samples/Ending/09.brr"

DATA_83FE:
	incbin "Samples/Ending/0A.brr"

DATA_9DA8:
	incbin "Samples/Ending/0B.brr"
%SPCDataBlockEnd(4000)

%EndSPCUploadAndJumpToEngine($0400)
