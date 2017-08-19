; file: itc.asm
; Indirect Threading Code Example

NEXT MACRO NOEXPAND
            ldx     ,y++
            jmp     [,x]
            ENDM

start       org     $0fa0   Start at 4000 dec
            ldy     #prog   Next word to execute
            NEXT


sub_a       .word   code_sub_a
code_sub_a  lda     #65     load A into accum
            ldx     #$400   pos 0 on screen
            sta     ,x      place A at pos 0
            NEXT

sub_b       .word   code_sub_b
code_sub_b  lda     #66     load B into accum
            ldx     #$401   pos 1 on screen
            sta     ,x      place B at pos 1
            NEXT

sub_c       .word   code_sub_c 
code_sub_c  lda     #67     load C into accum
            ldx     #$402   pos 2 on screen
            sta     ,x      place C at pos 2
            NEXT

return      .word   code_return
code_return rts


prog        org     $1000
            .word   sub_a
            .word   sub_b
            .word   sub_c
            .word   return

end

