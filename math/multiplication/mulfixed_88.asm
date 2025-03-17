mulfixed_88:
;Multiplies H.L by D.E, stores the result in H.L
; First, find out if the output is positive or negative
  ld a,h
  xor d
  push af   ;sign bit is the result sign bit

; Now make sure the inputs are positive
  xor d     ;A now has the value of H, since I XORed it with D twice (cancelling)
  jp p,+_   ;if Positive, don't negate
  xor a
  sub l
  ld l,a
  sbc a,a
  sub h
  ld h,a
_:
  bit 7,d
  jr z,+_
  xor a
  sub e
  ld e,a
  sbc a,a
  sub d
  ld d,a
_:

; Now we need to put HL in BC to use mul16
  ld b,h
  ld c,l
  call mul16

;Need to round, so get the top bit of L
  sla l

;Get the middle two bytes, EH, and put them in HL
  ld l,h
  ld h,e

  ld a,d
  ld de,0
  adc hl,de

;check for overflow!
;We should check for overflow. If A>0, we will set HL to 0x7FFF
  adc a,e
  jr c,$+4
  jr z,+_
  ld hl,$7FFF
_:

; Now we need to restore the sign
  pop af
  ret p    ;don't need to do anything, result is already positive
  xor a
  sub l
  ld l,a
  sbc a,a
  sub h
  ld h,a
  ret
