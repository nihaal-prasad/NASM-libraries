section .txt

; ==============================
; = read (address a, length l) =
; ==============================
; Usage: To read from STDIN
; Input: Variable to send output to in eax, length in ebx
; Registers: eax, ebx, ecx, edx
; Output: Value read from STDIN is outputted into variable that was in eax
read:
    mov edx, ebx ; The length should be in ebx. Move the length into edx
    mov ecx, eax ; The address should be in eax. Move the address into ecx
    mov ebx, 2 ; 2 represents STDIN
    mov eax, 3 ; 3 represents SYS_READ
    int 0x80 ; System interrupt
    ret ; Return





; ========================================
; = readF (buffer b, string s, length l) =
; ========================================
; Usage: To read from file a and store the output in buffer b
; Input: Buffer in eax, file name in ebx, and length in ecx
; Registers: eax, ebx, ecx, edx
; Output: Value read from file is outputted into buffer that was in eax
readF:
    ; The first step is to open the file
    push eax ; Push the input buffer onto the stack (so that we don't lose it during this step)
    push ecx ; Push the length onto the stack (so that we don't lost it during this step)
    mov eax, 5 ; 5 will call SYS_OPEN
    mov ecx, 0 ; 0 stands for read-only access
    mov edx, 0777 ; Read, write, and execute permissions
    int 0x80 ; System interrupt

    ; The second step is to read the opened file
    pop edx ; Move the length into edx
    pop ecx ; Move the input buffer into ecx
    mov ebx, eax ; File descriptor should be in eax; move it into ebx
    mov eax, 3 ; 3 stands for SYS_READ
    int 0x80 ; System interrupt

    ret ; Return
