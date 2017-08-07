; This is a speed test
; It fills the screen 
; with "A" then "B" etc
; to "Z" then stops

start   lda     #64        start at "A"-1
inclet  inca               next letter
        ldx     #$400      point to screen
nxtpos  sta     ,x+        put letter on screen
        cmpx    #$400+511  test for screen end
        bne     nxtpos     loop until last pos
        cmpa    #90        test with Z
        bne     inclet     get the next letter
;loop    jmp     loop        loop here
        rts
        end

