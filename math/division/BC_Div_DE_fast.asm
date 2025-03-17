BC_Div_DE:
;BC/DE ==> BC, remainder in HL
;NOTE: BC/0 returns 0 as the quotient.
;min: 773cc
;max: 933cc
;avg: 853cc
;82 bytes
  xor a
  ld h,a
  ld l,a
  sub e
  ld e,a
  sbc a,a
  sub d
  ld d,a

  ld a,b
  ld b,c
  call BC_Div_DE_sub
  ld a,b
  ld b,c

BC_Div_DE_sub:
;min: 354cc
;max: 434cc
;avg: 394cc
  rla \ adc hl,hl \ add hl,de \ jr c,$+4 \ sbc hl,de
  rla \ adc hl,hl \ add hl,de \ jr c,$+4 \ sbc hl,de
  rla \ adc hl,hl \ add hl,de \ jr c,$+4 \ sbc hl,de
  rla \ adc hl,hl \ add hl,de \ jr c,$+4 \ sbc hl,de
  rla \ adc hl,hl \ add hl,de \ jr c,$+4 \ sbc hl,de
  rla \ adc hl,hl \ add hl,de \ jr c,$+4 \ sbc hl,de
  rla \ adc hl,hl \ add hl,de \ jr c,$+4 \ sbc hl,de
  rla \ adc hl,hl \ add hl,de \ jr c,$+4 \ sbc hl,de
  rla
  ld c,a
  ret
