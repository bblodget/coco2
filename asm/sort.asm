; From http://os9projects.com/CD_Archive/TUTORIAL/COCO/COCOASSEMBLY/CoCoAssemblyLang_Color.pdf
; Figure 1-1.
; Bubble Sort

bubsrt  clr     passno      set passno ro 0
bub010  ldx     #$400       point to screen
        ldy     #0          set change flag to 0
bub020  lda     ,x+         get first entry
        cmpa    ,x          test next
        bls     bub030      go if a<=b
        ldb     ,x          get second entry
        stb     -1,x        swap b to a
        sta     ,x          swap a to b
        ldy     #1          set "change"
bub030  cmpx    #$400+511   test for screen end
        bne     bub020      go if not one pass
        inc     passno      increment passno
        cmpy    #0          test change flag
        bne     bub010      go if change occurred
;loop    jmp     loop        loop here
        rts
passno  fcb     0           passno
        end

