; file: forth.asm
; Building up a forth
; Based on jonesforth

F_IMMED     SET     $80
F_HIDDEN    SET     $20
F_LENMASK   SET     $1f
link        SET     0

; params: 1=name, 2=namelen, 3=flags, 4=label
defword MACRO
name_\4     .word   link
link        SET     name_\4
            .byte   \3+\2
            .str    \1
\4          .word   docol
                            ;list of ptrs to follow
            ENDM

; params: 1=name, 2=namelen, 3=flags, 4=label
defcode MACRO
name_\4     .word   link
link        SET     name_\4
            .byte   \3+\2
            .str    \1
\4          .word   \4+2
            ENDM

NEXT MACRO NOEXPAND
            ldx     ,y++
            jmp     [,x]
            ENDM

rstack      org     $0f9e   Put return stack before code

start       org     $0fa0   Start at 4000 dec
            ldu     #rstack
            ldy     #prog   Next word to execute
            NEXT

prog        .word   word_abc
            .word   return


    defcode "sub_a",5,0,sub_a
            lda     #65     load A into accum
            ldx     #$400   pos 0 on screen
            sta     ,x      place A at pos 0
            NEXT

    defcode "sub_b",5,0,sub_b
            lda     #66     load B into accum
            ldx     #$401   pos 1 on screen
            sta     ,x      place B at pos 1
            NEXT

    defcode "sub_c",5,0,sub_c
            lda     #67     load C into accum
            ldx     #$402   pos 2 on screen
            sta     ,x      place C at pos 2
            NEXT

            defcode "exit",4,0,exit
            pulu    y       restore y (nxt inst) from stack
            NEXT

    defcode "return",6,0,return
            rts

    defword "word_abc",8,0,word_abc
            .word   sub_a
            .word   sub_b
            .word   sub_c
            .word   exit

docol                       ; The interpreter!
            pshu    y       Push nxt inst on stack
            leax    2,x     Add 2 to x to skip codeword
            tfr     x,y     Y addr start of forth word
            NEXT


end

