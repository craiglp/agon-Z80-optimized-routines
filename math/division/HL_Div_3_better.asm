HL_Div_3:
;HL/3 --> DE
;209cc to 219cc
  xor a
  ld b,a
  ld d,h
  ld e,l
  add hl,hl \ rla
  add hl,hl \ rla
  add hl,de \ adc a,b
  add hl,hl \ rla
  add hl,hl \ rla
  add hl,de \ adc a,b
  add hl,hl \ rla
  add hl,hl \ rla
  add hl,de \ adc a,b
;AHL+(AHL+(DE>>1))/256
  srl d \ rr e
;AHL+(AHL+DE)/256
;AH.L+A.HL+.DE
  ld b,h
  ld c,l
;AB.C+A.HL+.DE
  add hl,de
;AB.C+A.HL+carry
  ld d,a
;DB.C+A.H+carry
  adc a,b
  ld e,a
  jr nc,$+3
  inc d
;DE.C+0.H+carry
  ld a,h
  add a,c
  ex de,hl
  ret nc
  inc hl
  ret
