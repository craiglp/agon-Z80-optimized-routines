cpstr:
;Compare two strings at HL and DE
;returns z if they are equal
;returns c if DE points to the smaller string
;returns nc if DE is the bigger (or equal) string.
  ld a,(de)
  cp (hl)
  inc de
  inc hl
  ret nz
  or a
  jr nz,cpstr
  ret
