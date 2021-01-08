
%SPCDataBlockStart(3C50)
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$83,$A4,$3F,$AC,$3F,$AC,$D2,$B2
	db $3F,$AC,$D2,$B2,$D2,$B2,$FD,$C0,$FD,$C0,$47,$C5,$FD,$C0,$47,$C5
%SPCDataBlockEnd(3C50)

%SPCDataBlockStart(A480)
	db $FF,$FF,$FF
	incbin "Samples/Bowser/00.brr"
	incbin "Samples/Bowser/01.brr"
	incbin "Samples/Bowser/02.brr"
	incbin "Samples/Bowser/03.brr"
%SPCDataBlockEnd(A480)

%EndSPCUploadAndJumpToEngine($0400)
