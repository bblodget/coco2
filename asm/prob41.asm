; Problem 4-1
; From 6809 assembly language programming
; by Lance A. Leventhal
;
; Move the contents of memory locatoin 0040
; to memory location 0042 and the contents
; of memory location 0041 to memory 
; location 0043
;
; sample problem
; (0f40) = 3E
; (0f41) = B7
; result
; (0f42) = 3E
; (0f43) = B7

start   org     $0f00
        ldd     params
        std     result
        rts

params  org     $0f40
        fcb     $3e,$b7
result  org     $0f42
        fcb     $00,$00

