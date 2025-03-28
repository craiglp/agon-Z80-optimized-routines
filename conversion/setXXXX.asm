setXXXXOP2:
    ld de,OP2
    jp setXXXX
setXXXXOP1:
    ld de,OP1
setXXXX:
;Convert HL to a TI float
;Inputs:
;   HL is 16-bit integer to convert;
;   DE points to the output.
;Notes:
;   This overwrites the 9 bytes at DE.
;min: 300cc       (-134cc if 'fast' is defined)
;max: 1564cc      (-134cc if 'fast' is defined)
;avg: 1460.7059cc (-134cc if 'fast' is defined)   1460+46259.875/65536
;clearop: (inline,loop) 7+9(7+6+13)-5        =236cc
;clearop: (inline,unrolled) 7+9(7+6+13)-5    =102cc
    xor a
#ifdef fast
    ld (de),a   ;first, I am zeroing out the 9 bytes
    inc de
    push de
    ld a,80h
    ld (de),a
    xor a
    inc de
    ld (de),a
    inc de
    ld (de),a
    inc de
    ld (de),a
    inc de
    ld (de),a
    inc de
    ld (de),a
    inc de
    ld (de),a
    inc de
    ld (de),a
    pop de
#else
    push de
    ld b,9
    ld (de),a   ;first, I am zeroing out the 9 bytes
    inc de
    djnz $-2
    pop de
    inc de
    ld a,80h
    ld (de),a
#endif
    ld a,h
    or l
    ret z       ;if HL is zero, exit now
    push de
    call HLtoBCD
    ld b,85h
    ld c,a
    ;DEC is the BCD number to convert
    ld a,d
    or a
    jr nz,+_
    ld d,e      ; here, a=0
    ld e,c
    ld c,a
    dec b
    dec b
    or d
    jr nz,+_
    ld d,e
    ld e,c
    ld c,a
    dec b
    dec b
_:
;now D is non-zero
    pop hl
    ld (hl),b
    inc hl
    ld (hl),d
    inc hl
    ld (hl),e
    inc hl
    ld (hl),c
    ld a,d
    and $F0
    ret nz
    ;now we need to shift up by 4 bytes
    rld
    dec hl
    rld
    dec hl
    rld
    dec hl
    dec (hl)
    ret
HLtoBCD:
;Input:
;   HL is the input
;Output:
;   DEA
    ld a,h
    call AL_Div_100
    ld b,a
    ld a,h
    call AL_Div_C
    ld e,a
    ld d,l  ;already in BCD format
    ld l,e
    call LtoBCD
    ld e,a
    ld l,b
LtoBCD:
    ld h,0
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    ld a,h	daa 	rl l
    adc a,a	daa	rl l
    adc a,a	daa	rl l
    adc a,a	daa	rl l
    adc a,a	daa
    ret
