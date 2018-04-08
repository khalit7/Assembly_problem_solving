section .data

n dd 5
x dd 1.57
b: dd 0
sin: dd 0.0
section .text
global _main
_main:
    mov ebp, esp; for correct debugging
    
    mov ecx,1
    mov edi,1
   LK: 
    push ecx
    push dword[x]
    call pow
    add esp,4
    
    ;push ecx
    call fact
    ;add esp,4
    mov [b],ecx
    pop ecx
    movss xmm1,[b]
    cvtdq2ps xmm0,xmm1
    divss xmm0,xmm1
    movss xmm1,[sin]
    test edi,0x01
    jnz O
    subss xmm1,xmm0
    jmp V
    O:addss xmm1,xmm0
    V:movss [sin],xmm1
 
    add ecx,2
    inc edi
    cmp ecx,13
    jg exit
    jmp LK
    exit:
        ret
    
    pow:
    mov ecx,[esp+8]
    dec ecx
    movss xmm0,[esp+4]
    movss xmm1,[esp+4]
    P:
    cmp ecx,0
    jle ex
    mulss xmm0,xmm1
    dec ecx
    jmp P
    ex:
    ret
    fact:
    mov eax,[esp+4]
    mov ecx,eax
    dec ecx
    K:
    
    cmp ecx,0
    jle e
    mul ecx
    dec ecx
    jmp K
    e:
    ret