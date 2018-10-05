%include 'print.asm'
%include 'math.asm'
%include 'read.asm'
%include 'str.asm'
%include 'convert.asm'

section .data
    d db 'Hell ', 0

section .txt
global _start
_start:
    mov eax, d
repeat:
    call print
    mov eax, ecx
    jmp repeat
    mov eax, 1
    mov ebx, 0
    int 0x80
