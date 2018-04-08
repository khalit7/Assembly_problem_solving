section .data
M:dd 2.0,0.5,8.0,1.0,0.0,1.0,2.0,-1.0,1.0
V: dd 2.0,0.5,8.0,1.0,0.0,1.0
L: dd 0.0,0.0,0.0,0.0,0.0,0.0
N: dd 0.0,0.0,0.0
section .text
global _main
_main:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    
    push M
    push V 
    call mulpy
    add esp,8
    ret
    
    mulpy:
    mov eax,[esp+8];
    mov ebx,[esp+4];
    mov ecx,0
    a:
    imul edx,ecx,12;4*n/
    movups xmm0,[eax+edx]
    movups xmm1,[ebx]
    dpps xmm0,xmm1,01110001b;
    movss [N+4*ecx],xmm0
    inc ecx 
    cmp ecx,3
    jge exit
    jmp a
    exit:
    ret