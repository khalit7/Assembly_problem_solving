%include "io.inc"
section .data
array: dd 'BK','RD','OE','Yw','BN'
table: dd "BK", 0, "BN", 1,'RD',2 , 'OE',3,'YW',4,'GN',5,'BE',6,'VT',7,'GY',8,'WE',9 ; 10
tabel2: dd 'BN',1.0,'RD',2.0,'GO',5.0,'SI',10.0,'NO',20.0,'VT',0.1,'BE',0.25,'GN',0.5 ; 8
tabel1L:dd 10
tabel2:dd 8
section .text
global CMAIN
CMAIN:
push array
call func
add esp,4
    ret
    
    func:
    mov esi,[esp+4] ; array
    mov eax, [tabel1L]
    mov ebx,[tabel2]
    mov
    