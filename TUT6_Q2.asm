%include "io.inc"

section .data
x: dd 1.0,2.0,3.0
y:dd 3.0,4.0,5.0
count: dd 3
m: dd 0.0
b: dd 0.0
sum_x: dd 0.0
sum_y: dd 0.0
sum_xy: dd 0.0
sum_xx: dd 0.0
x_sum_x: dd 0.0
temp: dd 0.0
section .text
global CMAIN
CMAIN:  
    mov ebp, esp; for correct debugging
    push dword [count]
    push x
    push y
    call fun_
    add esp, 12
    ret
    
    fun_:
    ;;;;;;;;;;;;;
    mov esi, [esp+8]
    mov edi, [esp+4]
    mov ecx, [esp+12]
    dec ecx
    finit
    fld dword [esi]
    lsum_x:
    add esi, 4
    fadd dword [esi]
    loop lsum_x
    fstp dword [sum_x]
    ;
    mov esi, [esp+8]
    mov edi, [esp+4]
    mov ecx, [esp+12]
    dec ecx
    fld dword[edi]
    lsum_y:
    add edi,4
    fadd dword[edi]
    loop lsum_y
    fstp dword[sum_y]
    ;
    mov esi, [esp+8]
    mov edi, [esp+4]
    mov ecx, [esp+12]
    dec ecx
    fld dword[esi]
    fmul dword [edi]
    lsum_xy:
    add esi, 4
    add edi,4
    fld dword [esi]
    fmul dword [edi]
    fadd
    loop lsum_xy
    fstp dword [sum_xy]
    ;
    mov esi, [esp+8]
    mov edi, [esp+4]
    mov ecx, [esp+12]
    dec ecx
    fld dword[esi]
    fmul dword [esi]
    lsum_xx:
    add esi, 4
    fld dword [esi]
    fmul dword [esi]
    fadd
    loop lsum_xx
    fstp dword [sum_xx]
    ;
    lx_sum_x:
    fld dword[sum_x]
    fmul dword[sum_x]
    fstp dword[x_sum_x]
    ;;;;;;;;;;;;;;;;;;
    mov esi, [esp+8]
    mov edi, [esp+4]
    mov ecx, [esp+12]
    ;;;;;;;;;;;;;;;;;;;
    ;calculating m
    fld dword[sum_xy]
    fst dword [temp]
    fimul dword[esp+12]
    fst dword [temp]
    fld dword[sum_x]
    fmul dword[sum_y]
    fsubp
    fst dword [temp]
    fld dword[sum_xx]
    fimul dword[esp+12]
    fsub dword[x_sum_x]
    fst dword [temp]
    fdivp st1, st0
    fstp dword[m]
    ; calculating b
    fld dword[sum_xx]
    fmul dword[sum_y]
    fld dword[sum_x]
    fmul dword[sum_xy]
    fsub
    fld dword[sum_xx]
    fimul dword [esp+12]
    fsub dword[x_sum_x]
    fdiv 
    fstp dword[b]
    ret