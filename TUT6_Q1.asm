%include "io.inc"
section .data
x:dd 2.0
y:dd 2.0
r:dd 3.45
theta:dd 0.785398185
temp:dd 0.0
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    pushad
push theta
push r
push dword[y]
push dword[x]
call RectPolar
add esp,16
popad
;
pushad
push y
push x
push dword[theta]
push dword[r]
call PolarToRec
add esp,16
popad
;
    ret
    
    RectPolar:
    ; finding r
    fld dword[esp+4] ;x
    fst dword[temp];
    fmul dword[esp+4]
    fst dword[temp];
    ; x^2
    fld dword[esp+8]
    fst dword[temp];
    fmul dword[esp+8]
    fst dword[temp];
    fadd 
    fst dword[temp];
    fsqrt
    fst dword[temp];
    mov eax, [esp+12]
    fstp dword[eax]
    ; finding theta
    mov eax,[esp+16]
    fld dword[esp+8] ;y
    fld dword[esp+4] ;x
    fpatan 
    fstp dword[eax]
    ret
    
    
    
    PolarToRec:
    fld dword[esp+8]
    fcos ; cos theta
    fmul dword[esp+4] ; r* cos theta
    mov eax,[esp+12]
    fstp dword[eax]
    fld dword[esp+8]
    fsin ; sin theta
    fmul dword[esp+4] ; r* sin theta
    mov eax,[esp+16]
    fstp dword[eax]
    ret