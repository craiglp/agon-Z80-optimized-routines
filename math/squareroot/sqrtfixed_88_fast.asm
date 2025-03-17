;Written by Zeda

sqrtfixed_88:
;Input: A.E ==> D.E
;Output: DE is the sqrt, AHL is the remainder
;Speed: 690+6{0,13}+{0,3+{0,18}}+{0,38}+sqrtA
;min: 855cc
;max: 1003cc
;avg: 924.5cc
;152 bytes

  call sqrtA
  ld l,a
  ld a,e
  ld h,0
  ld e,d
  ld d,h

  sla e
  rl d

  sll e \ rl d
  add a,a \ adc hl,hl
  add a,a \ adc hl,hl
  sbc hl,de
  jr nc,+_
  add hl,de
  dec e
  .db $FE     ;start of `cp *`
_:
  inc e

  sll e \ rl d
  add a,a \ adc hl,hl
  add a,a \ adc hl,hl
  sbc hl,de
  jr nc,+_
  add hl,de
  dec e
  .db $FE     ;start of `cp *`
_:
  inc e

  sll e \ rl d
  add a,a \ adc hl,hl
  add a,a \ adc hl,hl
  sbc hl,de
  jr nc,+_
  add hl,de
  dec e
  .db $FE     ;start of `cp *`
_:
  inc e

  sll e \ rl d
  add a,a \ adc hl,hl
  add a,a \ adc hl,hl
  sbc hl,de
  jr nc,+_
  add hl,de
  dec e
  .db $FE     ;start of `cp *`
_:
  inc e

;Now we have four more iterations
;The first two are no problem
  sll e \ rl d
  add hl,hl
  add hl,hl
  sbc hl,de
  jr nc,+_
  add hl,de
  dec e
  .db $FE     ;start of `cp *`
_:
  inc e

  sll e \ rl d
  add hl,hl
  add hl,hl
  sbc hl,de
  jr nc,+_
  add hl,de
  dec e
  .db $FE     ;start of `cp *`
_:
  inc e

sqrtfixed_88_iter11:
;On the next iteration, HL might temporarily overflow by 1 bit
  sll e \ rl d      ;sla e \ rl d \ inc e
  add hl,hl
  add hl,hl
  jr c,sqrtfixed_88_iter11_br0
;
  sbc hl,de
  jr nc,+_
  add hl,de
  dec e
  jr sqrtfixed_88_iter12
sqrtfixed_88_iter11_br0:
  or a
  sbc hl,de
_:
  inc e

;On the next iteration, HL is allowed to overflow, DE could overflow with our current routine, but it needs to be shifted right at the end, anyways
sqrtfixed_88_iter12:
  ld b,a      ;A is 0, so B is 0
  add hl,hl
  add hl,hl
  rla
;AHL - (DE+DE+1)
  sbc hl,de \ sbc a,b
  inc e
  or a
  sbc hl,de \ sbc a,b
  ret p
  add hl,de
  adc a,b
  dec e
  add hl,de
  adc a,b
  ret
