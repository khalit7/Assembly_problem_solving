%include "io.inc"
extern _printf 
extern _fopen , _fclose , _fprintf
section .data
a: dq 0.1
b: dq 0.2
c: dq 0.0
st: db 'file open' , 10
mode: db 'w' ,0
f: db 0
format: db '%e +%e = %e ' , 0
FileName: db 'C:\Users\khalid\Desktop\a.txt' , 0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    xor eax , eax 
finit    
push mode
push FileName

call _fopen 
add esp , 8

cmp eax , 0 
je fail 
fld qword[a] 
fld qword[b] 
faddp 
push eax 
fstp qword[c] 

push dword[c]
push dword[b]
push dword[a]
push format
push eax
call _fprintf
add esp , 20

call _fclose
add esp , 4
    ret
    fail:
    push st
    call printf 
    add esp , 4
    
    ret