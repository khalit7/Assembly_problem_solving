extern _printf
section .data
mat: dq 1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,0.0,0.0,0.0,0.0,0.0
N: dd 3
M: dd 3
Print_mat1: db 'MAT = ',10,0
Print_mat:db '%0.2f         %0.2f         %0.2f ',10,0
section .text
global _main
_main:
    mov ebp, esp; for correct debugging
push dword[N]
push dword[M]
push mat
call print
add esp,12
    ret
    
    print:
    ;;;;;;;;;;;;;
    push Print_mat1
    call _printf
    add esp,4
    ;;;;;;;;;;;;;
    mov edi,[esp+8] ; m
    mov esi,[esp+12] ;n
    mov ebx,[esp+4] ; mat

    mov ecx,-1 ; i
    mov edx,esi ;j
    mov eax,edx ; eax=n
    push edx
    mov edx,8
    mul edx ; eax=n*8
    pop edx
    add eax,4
    L1:
    inc ecx
    mov edx,esi
    cmp ecx,edi
    je finished_printing
    ;
    pushad
    L2:
    dec edx
    ;mat(i,j):
    ;
    push eax
    mov eax,ecx ; eax=i
    push edx
    mul esi ;i*n
    pop edx
    add eax,edx ;i*n+j
    push edx
    mov edx,8 
    mul edx ;(i*n+j)*8
    fld qword[ebx+eax]; mat(i,j)
    pop edx
    pop eax
    ;

    sub esp,8
    fstp qword[esp]
    cmp edx,0
    jg L2
    ;;;;;;;;;;;;;;;;
    push Print_mat
    call _printf
    add esp,28
    popad
    jmp L1
    finished_printing:
    ret