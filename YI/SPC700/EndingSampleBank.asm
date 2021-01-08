
%SPCDataBlockStart(3C00)
	db $00,$40,$71,$41,$9E,$41,$8B,$48,$39,$4F,$6D,$5D,$AC,$5D,$72,$5E
	db $7B,$5E,$29,$65,$49,$66,$66,$6A,$AE,$6A,$36,$6D,$51,$6D,$F4,$78
	db $F4,$78,$66,$7C,$02,$83,$E3,$83,$FE,$83,$21,$9D,$A8,$9D,$98,$BC
%SPCDataBlockEnd(3C00)

%SPCDataBlockStart(4000)
	incbin "Samples/Ending/00.brr"
	incbin "Samples/Ending/01.brr"
	incbin "Samples/Ending/02.brr"
	incbin "Samples/Ending/03.brr"
	incbin "Samples/Ending/04.brr"
	incbin "Samples/Ending/05.brr"
	incbin "Samples/Ending/06.brr"
	incbin "Samples/Ending/07.brr"
	incbin "Samples/Ending/08.brr"
	incbin "Samples/Ending/09.brr"
	incbin "Samples/Ending/0A.brr"
	incbin "Samples/Ending/0B.brr"
%SPCDataBlockEnd(4000)

%EndSPCUploadAndJumpToEngine($0400)
