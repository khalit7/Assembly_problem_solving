section .data
UE:     DQ 0.0
LE:     DQ 0.0
U:      DQ 0.0
L:      DQ 5.0
 
ROOT2:  DQ 1000.0
E:      DQ 0.001


section .bss
ROOT1    RESQ 1


TEM     RESQ 1
M       RESQ 1
FX1     RESQ 1
FX2     RESQ 1
    

section .text
global _main
_main:
    mov ebp, esp; for correct debugging
PUSHAD
PUSH    FX1
PUSH    U
CALL    FUN
ADD     ESP,8
POPAD


PUSH    M
PUSH    ROOT1
MOV     EDI,U
PUSH    EDI
MOV     EDI,L
PUSH    EDI
PUSH    FUN
CALL    NEUTON 
ADD     ESP,20

    ;write your code here
    xor eax, eax
    ret
    
FUN:
ENTER 0,0
    ;MOV     EDI,[EBP+8]#
    MOV     EDI,[EBP+8]
    FLD     QWORD[EDI]
    FLD     QWORD[EDI]
    FMULP
    FLD1
    FSUBP
    MOV     EDI,[EBP+12]
    FSTP    QWORD[EDI]
LEAVE
RET

NEUTON:FINIT
ENTER 0,0
        
           

    MOV     EDI,[EBP+12]
    FLD     QWORD[EDI]
    MOV     EDI,[EBP+16]
    FLD     QWORD[EDI]
    FADDP
    FLD1
    FLD1
    FADDP
    FDIVP
    MOV     EDI,[EBP+24]
    FST     QWORD[EDI]
    FSTP    QWORD[TEM]
    
    FLD     QWORD[ROOT2]
    MOV     EDI,[EBP+24]
    FLD     QWORD[EDI]
    FSUBP
    MOV     EDI,[EBP+24]
    FLD     QWORD[EDI]
    FDIVP
    FABS
    FLD     QWORD[E]
    FCOMI
    JB CONTINUE
    JA EQUAL
    CONTINUE:
    
    
    
    
    
    
    PUSHAD
    PUSH    FX1
    MOV     EDI,[EBP+24]
    PUSH    EDI
    CALL    FUN
    ADD     ESP,8
    POPAD
    
    PUSHAD
    PUSH    FX2
    MOV     EDI,[EBP+16]
    PUSH    EDI
    CALL    FUN
    ADD     ESP,8
    POPAD
    
    FLD     QWORD[FX1]
    FLD     QWORD[FX2]
    FMULP
    FLDZ
    FCOMI
    JA GREAT
    JB LESS
    JE EQUAL
       
    GREAT:
    FLD QWORD[EBP+24]
    FSTP QWORD[ROOT2]
    
MOV     EDI,[EBP+24]
PUSH    EDI
MOV     EDI,[EBP+20]
PUSH    EDI
PUSH    TEM
MOV     EDI,[EBP+12]
PUSH    EDI
MOV     EDI,[EBP+8]
PUSH    EDI
CALL    NEUTON 
ADD     ESP,20
    JMP END1
    LESS:
    FLD QWORD[EBP+24]
    FSTP QWORD[ROOT2]
MOV     EDI,[EBP+24]
PUSH    EDI
MOV     EDI,[EBP+20]
PUSH    EDI
MOV     EDI,[EBP+16]
PUSH    EDI
PUSH    TEM
MOV     EDI,[EBP+8]
PUSH    EDI
CALL    NEUTON 
ADD     ESP,20
    JMP END2
    EQUAL:
    MOV  EDI,[EBP+20]
    FSTP QWORD[EDI]
    JMP END3
    
    END1:
    END2:
    END3:
LEAVE
RET