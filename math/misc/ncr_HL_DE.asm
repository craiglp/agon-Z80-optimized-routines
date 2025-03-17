;Written by Zeda

; Requires
;    mul16          ;BC*DE ==> DEHL
;    DEHL_Div_BC    ;DEHL/BC ==> DEHL

ncr_HL_DE:
;"n choose r", defined as n!/(r!(n-r)!)
;Computes "HL choose DE"
;Inputs: HL,DE
;Outputs:
;   HL is the result
;       "HL choose DE"
;   carry flag reset means overflow
;Destroys:
;   A,BC,DE,IX
;Notes:
;   Overflow is returned as 0
;   Overflow happens if HL choose DE exceeds 65535
;   This algorithm is constructed in such a way that intermediate
;   operations won't erroneously trigger overflow.
;66 bytes
  ld bc,1
  or a
  sbc hl,de
  jr c,ncr_oob
  jr z,ncr_exit
  sbc hl,de
  add hl,de
  jr c,$+3
  ex de,hl
  ld a,h
  or l
  push hl
  pop ix
ncr_exit:
  ld h,b
  ld l,c
  scf
  ret z
ncr_loop:
  push bc \ push de
  push hl \ push bc
  ld b,h
  ld c,l
  call mul16          ;BC*DE ==> DEHL
  pop bc
  call DEHL_Div_BC    ;result in DEHL
  ld a,d
  or e
  pop bc
  pop de
  jr nz,ncr_overflow
  add hl,bc
  jr c,ncr_overflow
  pop bc
  inc bc
  ld a,b
  cp ixh
  jr c,ncr_loop
  ld a,ixl
  cp c
  jr nc,ncr_loop
  ret
ncr_overflow:
  pop bc
  xor a
  ld b,a
ncr_oob:
  ld h,b
  ld l,b
  ret
