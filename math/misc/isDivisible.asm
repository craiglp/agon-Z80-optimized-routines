isDivisible:
;Inputs: DE,HL
;Outputs: c flag set if HL is not divisible by DE, else c flag is reset.
;         HL is 0 if true.
;See below for a note on the motivation and development of this algorithm.
    ld a,d \ or e \ ccf \ ret z         ;remove this if DE is always guaranteed non-zero
;step 1
    ld a,e \ or l \ rra \ jr c,step2    ;\
    srl d \ rr e \ rr h \ rr l          ; |
    ld a,e \ or l \ rra \ jr nc,$-11    ; |Remove these if DE is always guaranteed odd at input.
step2:                                  ; |
    ld a,e \ rra \ ccf \ ret c          ;/
;steps 3, 4, and 5
    ld a,l
    or a
loop:
    sbc hl,de \ ret c \ ret z
    rr h \ rra \ bit 0,a \ jr z,$-5
    ld l,a
    jp loop
;Motivation and Development
;  I often find myself in a situation where I need to find the factors of a number, but I have no technology around to aid me. This means I need to use... mental arithmetic!
;  I've been doing this for 15 years, so I have refined my mental process quite a bit.
;  It is still a trial division algorithm, but with a very obfuscated "division" technique.
;  We don't need to do 1131/7 to see if it is divisible by 7, we just need to see if 7 divides 1131 and this is what my algorithm does.
;  Interestingly, testing divisibility at the algorithmic level is a little faster than division. Not by much, but it is also non-negligible.
;The Algorithm
;  The core algorith is designed around checking that (A mod B == 0) is true or false.
;  We also make the assumption that B is odd and by extension, non-zero.
;  The case where B is non-zero and even will be discussed later.
;
;  Since B is odd, 2 does not divide B. This means that if A is even:
;      (A mod B == 0) if and only if  (A/2 mod B)==0.
;  We also know by the definition of divisibility that
;      (A mod B) == (A+c*B mod B)
;  where c is any integer. Combining all this, we have an algorithm:
;
;  1]  Remove all factors of 2 from A
;  2]  With A now odd, do A=A-B
;      If the result is zero, that means (A mod B == 0)
;      If the result underflow (becomes "negative", or on the Z80, sets the carry flag), it means that A was somewhere on [1,B-1], so it is not divisible by B.
;  3] Continue back at 1.
;
;  Now suppose B is allowd to be non-zero and even. Then B is of the form d*2^k where d is odd.
;  This just means there are some factors of 2 that can be removed from B until it is odd.
;  The only way A is divisible by B, is if it has the same number or more of factors of 2 as B.
;  If we factor out common factors of 2 and find B is still even, then A is not divisible by B.
;  Otherwise we have an odd number and only need to check the new (A mod d)
;  for which we can use the "odd algorithm" above.
;  So putting it all together:
;
;  1] If B==0, return FALSE.
;  2] Remove common factors of 2 from A and B.
;  3] If B is even, return FALSE.
;  4] Remove all factors of 2 from A.
;  5] Subtract B from A (A=A-B).
;      If the result is zero, return TRUE.
;      If the result is "negative" (setting the carry flag on many processors), return FALSE.
;  6] Repeat at 4]
;
;  The overhead steps are 1] to 3].
;  The iterated steps are 4] and 5].
;  Because 5 always produces an even number, when it then performs step 4, it always divides by at least one factor of 2.
;  This means the algorithm takes at most 1+ceil(log2(A))-floor(log2(B) iterations.
;  For example, if A is a 37-bit number and B is a 13-bit number,this takes at most 38-13 = 25 iterations.
;  However, in practice it is usually slightly less.
;Example Time:
;  Say I wanted to test if 1337 is divisible by 17.
;  Since 17 is odd, we can proceed.
;  1337 is odd, so no factors of 2 to remove.
;  1337-17 == 1320.
;  1320/2 == 660
;  660/2 == 330
;  330/2 == 165
;  165-17 == 148
;  148/2 == 74
;  74/2 == 37
;  37-17 == 20
;  20/2 == 10
;  10/2 == 5
;  5-17 = -12
;
;  So 1337 is not divisible by 17.
;Now test divisibility by 7:
;1337 => 1330
;=>665
;=>658
;=>329
;=>322
;=>161
;=>154
;=>77
;=>70
;=>35
;=>28
;=>14
;=>7
;=>0
;
;  So 1337 is divisible by 7.
