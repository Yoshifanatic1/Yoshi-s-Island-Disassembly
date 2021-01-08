
%SPCDataBlockStart(3C00)
	db $00,$40,$12,$40,$DE,$43,$47,$59,$47,$59,$D8,$64,$D8,$64,$49,$66
	db $6D,$66,$8D,$67,$E7,$67,$1F,$6C,$1F,$6C,$67,$6C,$82,$6C,$57,$70
	db $57,$70,$4D,$77,$01,$78,$1C,$78,$57,$79,$C9,$7C,$65,$83,$9D,$87
	db $9D,$87,$38,$8C,$38,$8C,$99,$91,$99,$91,$7A,$92,$95,$92,$E6,$9B
	db $E6,$9B,$01,$9C,$1C,$9C,$AF,$A2,$AF,$A2,$CA,$A2,$E5,$A2,$56,$A4
	db $83,$A4,$E4,$A9,$E4,$A9,$B9,$AD,$B9,$AD,$75,$B5,$75,$B5,$87,$B5
%SPCDataBlockEnd(3C00)

%SPCDataBlockStart(4000)
	incbin "Samples/Global/00.brr"
	incbin "Samples/Global/01.brr"
	incbin "Samples/Global/02.brr"
	incbin "Samples/Global/03.brr"
	incbin "Samples/Global/04.brr"
	incbin "Samples/Global/05.brr"
	incbin "Samples/Global/06.brr"
	incbin "Samples/Global/07.brr"
	incbin "Samples/Global/08.brr"
	incbin "Samples/Global/09.brr"
	incbin "Samples/Global/0A.brr"
	incbin "Samples/Global/0B.brr"
	incbin "Samples/Global/0C.brr"
	incbin "Samples/Global/0D.brr"
	incbin "Samples/Global/0E.brr"
	incbin "Samples/Global/0F.brr"
	incbin "Samples/Global/10.brr"
	incbin "Samples/Global/11.brr"
	incbin "Samples/Global/12.brr"
	incbin "Samples/Global/13.brr"
	incbin "Samples/Global/14.brr"
	incbin "Samples/Global/15.brr"
	incbin "Samples/Global/16.brr"
	incbin "Samples/Global/17.brr"
%SPCDataBlockEnd(4000)

%EndSPCUploadAndJumpToEngine($0400)
