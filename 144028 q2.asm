%include "io.inc"
extern _fopen
extern _fclose
extern _fprintf
section .data
a:dq 0.1
b:dq 0.2
c:dq 0.0
name:dd 'C:\Users\khalid_fat7\Desktop\Lab4Example.txt' 
mode: dd 'w',0
format: dd '%e + % e= %e',0
fmt: dd 'fopen failed \n',0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
finit

fld qword[a]
fld qword[b]
fadd
fstp qword[c]
    ;
    
 push mode
push name
call _fopen 
add esp,8
;
cmp eax,0 
jne fprintf

push fmt
call _printf
add esp,4
ret

fprintf:
push eax 
sub esp,8
fld qword[c]
fstp qword[esp]
sub esp,8
fld qword[b]
fstp qword[esp]
sub esp,8
fld qword[a]
fst qword[esp]
push format
push eax
call _fprintf
add esp,32
pop eax
;

push eax
call _fclose
add esp,4

    ret