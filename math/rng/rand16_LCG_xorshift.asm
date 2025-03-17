;You may use this routine, just be sure to credit John Metcalf for the
;xorshift16 part of this routine!

; This routine is a fast Pseudo Random Number Generator
;for the Z80. It combines a 16-bit LCG and 16-bit xorshift.
;The xorshift routine was written by John Metcalf
;and posted here:
;   http://www.retroprogramming.com/2017/07/xorshift-pseudorandom-numbers-in-z80.html


;#define smc	;uncomment if you are using SMC

rand16:
;174cc (or 186cc if not using SMC)
;34 bytes
;cycle length: 4,294,901,760 (almost 4.3 billion)

; For the first seed, we use an LCG, 1+5*seed1 ==> seed1
#ifdef smc
seed1=$+1
  	ld hl,9999
#else
    ld hl,(seed1)
#endif
    ld b,h
    ld c,l
    add hl,hl
    add hl,hl
    inc l
    add hl,bc
    ld (seed1),hl

; For the second seed, we apply an xorshift
;    seed2^(seed2<<7) ==> seed2
;    seed2^(seed2>>9) ==> seed2
;    seed2^(seed2<<8) ==> seed2
; This code was originally made by John Metcalf and posted here:
;     http://www.retroprogramming.com/2017/07/xorshift-pseudorandom-numbers-in-z80.html
; (My modifications are only in naming and compiler directives.)

#ifdef smc
seed2=$+1
	ld hl,9999
#else
    ld hl,(seed2)
#endif
    ld a,h
    rra
    ld a,l
    rra
    xor h
    ld h,a
    ld a,l
    rra
    ld a,h
    rra
    xor l
    ld l,a
    xor h
    ld h,a
    ld (seed2),hl
    add hl,bc
    ret
