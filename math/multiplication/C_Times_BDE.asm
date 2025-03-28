C_times_BDE:
;C*BDE => CAHL
;C = 0     157
;C = 1     141
;141+
;C>=128    135+6{0,33+{0,1}}+{0,20+{0,8}}
;C>=64     115+5{0,33+{0,1}}+{0,20+{0,8}}
;C>=32     95+4{0,33+{0,1}}+{0,20+{0,8}}
;C>=16     75+3{0,33+{0,1}}+{0,20+{0,8}}
;C>=8      55+2{0,33+{0,1}}+{0,20+{0,8}}
;C>=4      35+{0,33+{0,1}}+{0,20+{0,8}}
;C>=2      15+{0,20+{0,8}}
;min: 141cc
;max: 508cc
;avg: 349.21279907227cc

  ld a,b
  ld h,d
  ld l,e
  sla c     jr c,mul8_24_1
  sla c     jr c,mul8_24_2
  sla c     jr c,mul8_24_3
  sla c     jr c,mul8_24_4
  sla c     jr c,mul8_24_5
  sla c     jr c,mul8_24_6
  sla c     jr c,mul8_24_7
  sla c     ret c
  ld a,c
  ld h,c
  ld l,c
  ret
mul8_24_1:
    add hl,hl     rla     rl c     jr nc,$+7     add hl,de     adc a,b     jr nc,$+3     inc c
mul8_24_2:
    add hl,hl     rla     rl c     jr nc,$+7     add hl,de     adc a,b     jr nc,$+3     inc c
mul8_24_3:
    add hl,hl     rla     rl c     jr nc,$+7     add hl,de     adc a,b     jr nc,$+3     inc c
mul8_24_4:
    add hl,hl     rla     rl c     jr nc,$+7     add hl,de     adc a,b     jr nc,$+3     inc c
mul8_24_5:
    add hl,hl     rla     rl c     jr nc,$+7     add hl,de     adc a,b     jr nc,$+3     inc c
mul8_24_6:
    add hl,hl     rla     rl c     jr nc,$+7     add hl,de     adc a,b     jr nc,$+3     inc c
mul8_24_7:
    add hl,hl     rla     rl c     ret nc     add hl,de     adc a,b     ret nc     inc c     ret
