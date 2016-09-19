section	.code
global	hex_decoder
hex_decoder:
	push		ebp				; remember addr of a calling function
	mov		ebp, esp			; load new addr

	%idefine 	str[ebp+8]	
	%idefine 	new_str[ebp+12]

	mov		esi, str  			; now esi points to input string
	mov 		edi, new_str 			; now edi points to output string
	
.read_byte:
	mov		dl, BYTE[esi]
	test		dl, dl
	jz		.end_pr
	cmp		dl, '0'
	jz		.zero_detected
	mov		BYTE[edi], dl
	inc		edi
	inc		esi
	jmp		.read_byte 
	
.zero_detected:
	mov		dl, BYTE[esi+1]
	cmp		dl, 'x'
	je		.hex_detected
	cmp		dl, '0'
	jl		.bad_number
	cmp		dl, '7'
	jg		.bad_number
	
.octal_detected:
	cmp		dl, '1'
	jg		.bad_number
	mov		dl, BYTE[esi+2]
	cmp		dl, '0'
	jge		.nextt_
	jmp		.bad_number
.nextt_:
	cmp		dl, '7'
	jle		.postt_
	jmp		.bad_number
.postt_:
	mov		dl, BYTE[esi+3]
	cmp		dl, '0'
	jge		.next_
	jmp		.bad_number
.next_:
	cmp		dl, '7'
	jle		.post_
	jmp		.bad_number
.post_:
	mov		dl, BYTE[esi+4]
	cmp		dl, '0'
	jge		.next_c
	jmp		.octal_confirmed
.next_c:
	cmp		dl, '7'
	jle		.bad_number
	
.octal_confirmed:
	;xor		ecx, ecx
	;xor		eax, eax
	mov		al, BYTE[esi+1]
	sub		al, 48
	shl		al, 6
	mov		cl, al
	mov		al, BYTE[esi+2]
	sub		al, 48
	shl		al, 3
	add		cl, al
	mov		al, BYTE[esi+3]
	sub		al, 48
	add		cl, al
	jmp		.number_stored
	
	mov		BYTE[edi], al
	inc		edi
	
.hex_detected:
	mov		dl, BYTE[esi+2]
	cmp		dl, '3'
	jl		.bad_number
	cmp		dl, '7'
	jg		.bad_number
	
	mov		dl, BYTE[esi+4]
	cmp		dl, '0'
	jge		.next_cond
	jmp		.hex_confirmed
.next_cond:
	cmp		dl, '9'
	jle		.bad_number
	cmp		dl, 'F'
	jle		.next_cond_2
	jmp		.hex_confirmed
.next_cond_2:
	cmp		dl, 'A'
	jge		.bad_number
	
.hex_confirmed:	
	mov		al, BYTE[esi+2]
	add		al, -48
.count_hex:
	shl		al, 4
	mov		cl, al
	mov		al, BYTE[esi+3]
	cmp		al, 64
	jg		.hex
	add		al, -48
.count:
	add		cl, al
	jmp		.number_stored
.hex:
	add		al, -55
	jmp		.count
	
.bad_number:
	mov		dl, BYTE[esi]
	mov		BYTE[edi], dl
	inc 		edi
	inc		esi
	jmp 		.read_byte
	
.number_stored:	
	cmp		cl, 48
	jl		.bad_number

	cmp		cl, 58
	jge		.next_condition
	jmp		.post
.next_condition:
	cmp		cl, 64
	jle		.bad_number
	cmp		cl, 96
	jle		.next_condition_2
	jmp		.post
.next_condition_2:
	cmp		cl, 91
	jge		.bad_number

.post:
	cmp		cl, 122
	jg		.bad_number
	
	mov		BYTE[edi], 39			;load " ' " in dest file 
	inc		edi
	mov		BYTE[edi], cl
	inc		edi
	mov		BYTE[edi], 39
	inc		edi
	add		esi, 4
	jmp		.read_byte

.end_pr:
	mov 		esp, ebp
	pop 		ebp
	ret
