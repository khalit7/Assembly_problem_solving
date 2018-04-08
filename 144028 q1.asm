%include "io.inc"
extern _printf
section .data
Epslon:dq 0.001 
step: dq 0.1
X:dq 0.0 
xtimes3:dq 3.0
addtwo:dq 2.0 

xplusEpslon: dq 0 
format:dd "for x= %0.2f  == dy/dx=%0.2f ",10,0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
finit
xor ecx,ecx
next_:
push X
push fa     
call derive
add esp,8
; printig begins
pushad 
sub esp,8
fstp qword[esp] 
sub esp,8
fld qword[X]
fstp qword[esp]
push format
call _printf
add esp,20
popad 
; printing ends
fld qword[X]
fadd qword[step]
fstp qword[X]
cmp ecx,20
je finish
inc ecx
jmp next_
finish:
    ret
    
    derive:  
    push ebp
    mov ebp,esp
    mov ebx,[ebp+12];        
    
    push ebx 
    mov eax,[ebp+8]
    call eax
    add esp,4
    
    fld qword[ebx] 
    fadd qword[Epslon]
    fstp qword[xplusEpslon] 
    mov edx,xplusEpslon 
    push edx
    call eax
    add esp,4
    fsub
    fchs 
    fdiv qword[Epslon]
    mov esp,ebp
    pop ebp
    ret
    fa: 
    
    push ebp
    mov ebp,esp
    mov edi,[ebp+8]
    fld qword[edi]
    fld qword[edi]
    fmul
    fld qword[edi]
    fmul qword[xtimes3]
    fsubp 
    fadd qword[addtwo]
    
    mov esp,ebp
    pop ebp
    ret