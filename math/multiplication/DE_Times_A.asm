DE_Times_A:
;DE*A ==> AHL
    ld hl,0
    ld b,h
    add a,a \ jr nc,$+5 \ ld h,d \ ld l,e
    add hl,hl \ rla \ jr nc,$+4 \ add hl,de \ adc a,b
    add hl,hl \ rla \ jr nc,$+4 \ add hl,de \ adc a,b
    add hl,hl \ rla \ jr nc,$+4 \ add hl,de \ adc a,b
    add hl,hl \ rla \ jr nc,$+4 \ add hl,de \ adc a,b
    add hl,hl \ rla \ jr nc,$+4 \ add hl,de \ adc a,b
    add hl,hl \ rla \ jr nc,$+4 \ add hl,de \ adc a,b
    add hl,hl \ rla \ ret nc \ add hl,de \ adc a,b \ ret
