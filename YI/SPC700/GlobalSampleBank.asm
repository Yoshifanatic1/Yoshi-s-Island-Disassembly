
%SPCDataBlockStart(3C00)
	dw DATA_4000	:	dw DATA_4000+$0012
	dw DATA_43DE	:	dw DATA_43DE+$1569
	dw DATA_5947	:	dw DATA_5947+$0B91
	dw DATA_64D8	:	dw DATA_64D8+$0171
	dw DATA_666D	:	dw DATA_666D+$0120
	dw DATA_67E7	:	dw DATA_67E7+$0438
	dw DATA_6C1F	:	dw DATA_6C1F+$0048
	dw DATA_6C82	:	dw DATA_6C82+$03D5
	dw DATA_7057	:	dw DATA_7057+$06F6
	dw DATA_7801	:	dw DATA_7801+$001B
	dw DATA_7957	:	dw DATA_7957+$0372
	dw DATA_8365	:	dw DATA_8365+$0438
	dw DATA_879D	:	dw DATA_879D+$049B
	dw DATA_8C38	:	dw DATA_8C38+$0561
	dw DATA_9199	:	dw DATA_9199+$00E1
	dw DATA_9295	:	dw DATA_9295+$0951
	dw DATA_9BE6	:	dw DATA_9BE6+$001B
	dw DATA_9C1C	:	dw DATA_9C1C+$0693
	dw DATA_A2AF	:	dw DATA_A2AF+$001B
	dw DATA_A2E5	:	dw DATA_A2E5+$0171
	dw DATA_A483	:	dw DATA_A483+$0561
	dw DATA_A9E4	:	dw DATA_A9E4+$03D5
	dw DATA_ADB9	:	dw DATA_ADB9+$07BC
	dw DATA_B575	:	dw DATA_B575+$0012
%SPCDataBlockEnd(3C00)

%SPCDataBlockStart(4000)
DATA_4000:
	incbin "Samples/Global/00.brr"

DATA_43DE:
	incbin "Samples/Global/01.brr"

DATA_5947:
	incbin "Samples/Global/02.brr"

DATA_64D8:
	incbin "Samples/Global/03.brr"

DATA_666D:
	incbin "Samples/Global/04.brr"

DATA_67E7:
	incbin "Samples/Global/05.brr"

DATA_6C1F:
	incbin "Samples/Global/06.brr"

DATA_6C82:
	incbin "Samples/Global/07.brr"

DATA_7057:
	incbin "Samples/Global/08.brr"

DATA_7801:
	incbin "Samples/Global/09.brr"

DATA_7957:
	incbin "Samples/Global/0A.brr"

DATA_8365:
	incbin "Samples/Global/0B.brr"

DATA_879D:
	incbin "Samples/Global/0C.brr"

DATA_8C38:
	incbin "Samples/Global/0D.brr"

DATA_9199:
	incbin "Samples/Global/0E.brr"

DATA_9295:
	incbin "Samples/Global/0F.brr"

DATA_9BE6:
	incbin "Samples/Global/10.brr"

DATA_9C1C:
	incbin "Samples/Global/11.brr"

DATA_A2AF:
	incbin "Samples/Global/12.brr"

DATA_A2E5:
	incbin "Samples/Global/13.brr"

DATA_A483:
	incbin "Samples/Global/14.brr"

DATA_A9E4:
	incbin "Samples/Global/15.brr"

DATA_ADB9:
	incbin "Samples/Global/16.brr"

DATA_B575:
	incbin "Samples/Global/17.brr"
%SPCDataBlockEnd(4000)

%EndSPCUploadAndJumpToEngine($0400)
