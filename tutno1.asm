%include "io.inc"
extern _printf
section .data
x: dq 0.0
eps: dq 0.001
b: dq -3.0
c: dq 2.0
f1: dq 0.0
f2: dq 0.0
xpe: dq 0.0
ans: dq 0.0
stp: dq 0.1
format: db "dy/dx = %0.2f",10,0
   
section .text
global CMAIN
CMAIN:
finit
    mov ebp, esp; for correct debugging
    xor ecx,ecx
next:
    cmp ecx,21
    jge done
    push x
    push funval
    call Derive
    add esp ,8
    ;
    pushad
    sub esp,8
    fstp QWORD [esp]
    push format
    call _printf
    add esp,12
    popad
    ;
    inc ecx
    fld QWORD [x]
    fadd QWORD [stp]
    fstp QWORD [x]
    jmp next
    done:
    
    ret
funval:
push ebp
    mov ebp,esp
    mov esi,[ebp+8]
    fld qword[esi]
    fmul qword[esi]
    fld qword[esi]
    fmul qword[b]
    fadd 
    fadd qword[c] 
    
    mov esp,ebp
    pop ebp
    ret

Derive:
    push ebp
    mov ebp,esp
    mov eax,[ebp+8]
    mov ebx,[ebp+12]
    mov edx,xpe
    fld QWORD[ebx]
    fadd QWORD [eps]
    fstp QWORD [xpe]
    push ebx
    call eax
    add esp,4
    fstp QWORD[f1]
    mov ebx,xpe
    push ebx
    call eax 
    add esp,4
    fst QWORD[f2]
    fld QWORD[f1]
    fsub
    fdiv QWORD[eps]
    fst QWORD[ans] 
    mov esp,ebp
    pop ebp
    ret