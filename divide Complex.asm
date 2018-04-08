%include "io.inc"

section .data
a dq 2.0,1.0
align 128
b dq 4.0,2.0
align 128
c dq 0.0,0.0
align 128
d dq 0.0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    push a 
    push b 
    push c 
    call divide
    add esp,12
    ret
    
    divide:
    mov eax,[esp+12]
    mov ebx,[esp+8]
    mov edx,[esp+4]
    
    
    movupd xmm0,[ebx]
    movupd xmm1,[ebx]
    mulpd xmm0,xmm1
    haddpd xmm0,xmm0
    movupd [d], xmm0
    
    
    
    movupd xmm0,[eax]
    movupd xmm1,[ebx]
    mulpd xmm0,xmm1
    haddpd xmm0,xmm0
    divpd xmm0,[d]
    movsd [edx],xmm0
    
    movupd xmm0,[eax]
    movupd xmm1,[ebx]
    shufpd xmm0,xmm0,1
    mulpd xmm0,xmm1
    hsubpd xmm0,xmm0
    divpd xmm0,[d]
    movsd [edx+8],xmm0
    
   
    ret 