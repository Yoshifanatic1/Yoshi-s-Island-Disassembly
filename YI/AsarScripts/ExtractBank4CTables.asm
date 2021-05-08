; This will dump the data for an asar patch that will be applied to the USA YI ROM. Said patch will dump the hundreds of tables in bank 4C pointed to from $4C0204 when applied to the ROM.
; The reason I'm generating a patch and not the tables directly is because of asar limitations. I don't think it's possible for asar to resolve commands through a define while in a print statement.
; Also, it may take a second before asar starts displaying anything on the command line. In addition, you'll need to replace the ' with " in the output patch, otherwise asar won't assemble the patch.
; Lastly, the last block extracts more data that it should.

sfxrom

!Offset = $4C0204
!EndOffset = $4C060C

macro HandleVariableDefine(ID)
	!Output<ID> #= !Input3
	if !Input3 < 16
		!LZ<ID> += "0"
	else
		!LZ<ID> += ""
	endif
endmacro

macro ClearDefines()
	!Output0 = ""
	!Output1 = ""
	!Output2 = ""
	!Output3 = ""
	!Output4 = ""
	!Output5 = ""
	!Output6 = ""
	!Output7 = ""
	!Output8 = ""
	!Output9 = ""
	!Output10 = ""
	!Output11 = ""
	!Output12 = ""
	!Output13 = ""
	!Output14 = ""
	!Output15 = ""
	!LZ0 = ""
	!LZ1 = ""
	!LZ2 = ""
	!LZ3 = ""
	!LZ4 = ""
	!LZ5 = ""
	!LZ6 = ""
	!LZ7 = ""
	!LZ8 = ""
	!LZ9 = ""
	!LZ10 = ""
	!LZ11 = ""
	!LZ12 = ""
	!LZ13 = ""
	!LZ14 = ""
	!LZ15 = ""
endmacro

macro HandleLineOfData(ID)
	if <ID> == 0
		!PrintData += "	db $!LZ<ID>',hex(!Output<ID>)"
	else
		!PrintData += ",',$!LZ<ID>',hex(!Output<ID>)"
	endif
endmacro

macro PrintVariableData(Data)
	print "print '<Data>"
endmacro

!SkipBytes = 0
!LoopCounter = 0
print "sfxrom"

while !Offset+!LoopCounter < !EndOffset
	!Input1 = read2(!Offset+!LoopCounter)+(!Offset&$FF0000)+$060C
	!Input2 = read2(!Offset+!LoopCounter+$02+!SkipBytes)+(!Offset&$FF0000)+$060C
	%ClearDefines()
	!ByteCount = 0
	!RowByteCount = 0
	!PrintData = ""
	if !Input2 > !Input1
		print "print 'DATA_',hex(!Input1),':'"
		while !Input2-(!ByteCount+!Input1) != $00
			!Input3 = read1(!Input1+!ByteCount)
			%HandleVariableDefine(!RowByteCount)
			%HandleLineOfData(!RowByteCount)
			!ByteCount #= !ByteCount+1
			!RowByteCount #= !RowByteCount+1
			if !RowByteCount == 16
				%PrintVariableData("!PrintData")
				%ClearDefines()
				!PrintData = ""
				!RowByteCount #= $00
			endif
		endif
		if !RowByteCount != 0
			%PrintVariableData("!PrintData")
		endif
		!LoopCounter #= !LoopCounter+2+!SkipBytes
		!SkipBytes #= 0
		print "print ''"
	else
		!SkipBytes #= !SkipBytes+2
	endif
endif
