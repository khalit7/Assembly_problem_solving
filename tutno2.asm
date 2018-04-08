%include "io.inc"
extern _printf
extern _fopen
extern _fprintf
extern _fclose
section .data
path: dd "C:\Users\mushtaha\Desktop\tut2.txt",0
w: dd "w",0
a: dq 0.1
b: dq 0.2
c: dq 0.0
msg: dd "fopen failed",0
format: dd "%e + %e = %e",0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    finit   
    push w
    push path
    call _fopen
    add esp,8
    cmp eax,0
    jne print
    push msg
    call _printf
    add esp,4
    ret
print:
    pushad
    fld QWORD [a]
    fadd QWORD [b]
    fst QWORD[c]
    sub esp,8
    fstp QWORD [esp]
    fld QWORD [b]
    sub esp,8
    fstp QWORD [esp]
    fld QWORD [a]
    sub esp,8
    fstp QWORD [esp]
    push msg
    push eax
    call _fprintf
    add esp,32
    popad
    push eax
    call _fclose
    add esp,4
    ret