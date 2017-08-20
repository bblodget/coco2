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

prog        .word   sum
            .word   return

docol                       ; The interpreter!
            pshu    y       Push nxt inst on stack
            leax    2,x     Add 2 to x to skip codeword
            tfr     x,y     Y addr start of forth word
            NEXT

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


    defcode "return",6,0,return
            rts

    defword "word_abc",8,0,word_abc
            .word   sub_a
            .word   sub_b
            .word   sub_c
            .word   EXIT

    defword "sum",3,0,sum
            .word   LIT,$1234
            .word   LIT,$2345
            .word   ADD
            .word   DROP
            .word   EXIT

    ; EXIT from Forth word
    defcode "EXIT",4,0,EXIT
            pulu    y       restore y (nxt inst) from stack
            NEXT

    ; TODO (brandon) : Need to save s reg at start
    ; probably should add protection not to drop to far.
    ; Drop top of the stack
    defcode "DROP",4,0,DROP
            leas    2,s     Add 2 to s reg
            NEXT

    ; SWAP top two elemnts on stack
    defcode "SWAP",4,0,SWAP
            tfr     y,d     tmp save y in d
            puls    x       top element in x
            puls    y       2nd element in y
            pshs    x       push x
            pshs    y       push y
            tfr     d,y     restore y
            NEXT

    ; DUPlicates the top value of the statck
    defcode "DUP",4,0,DUP
            ldx     ,s      copy top of stack into x
            pshs    x       push x, to make copy
            NEXT

    ; Next value is a literal 
    ; y points to the next command, but in this case it points to the next
    ; literal 16 bit integer. 
    defcode "LIT",3,0,LIT
            ldx     ,y++    copy y into x, then inc y
            pshs    x       push x
            NEXT

    ; ADD top two items on stack
    defcode "+",1,0,ADD
            puls    d       pop top of stack into d
            addd    ,s      add new top of stack to d
            std     ,s      write d to top of stack
            NEXT

end

