section .txt

; ==================
; = len (String s) =
; ==================
; Usage: To find the length of a string
; Input: String in eax
; Registers: eax, ebx
; Output: String in eax, length in ebx
len:
    mov ebx, eax ; String should be in both eax and ebx
                 ; This loop will continuouly increment ebx by one, and check if byte[ebx] is 0
                 ; If byte[ebx] is 0, then that is an end of string character, and the loop will end
                 ; The length is found by subtracting ebx (end of string) by eax (beginning of string)

nextchar:
    cmp byte[ebx], 0 ; Check if ebx is 0
    jz endLen ; Jump to the end if it is
    inc ebx ; Increment ebx by one
    jmp nextchar ; Continue the loop

endLen:
    sub ebx, eax ; Subtract ebx by eax
    ret ; Return





; ====================
; = print (string s) =
; ====================
; Usage: To print out a string
; Input: String in eax
; Registers: eax, ebx, ecx, edx
; Output: Void
print:
    call len ; Get the length
    mov edx, ebx ; Move length from ebx into edx
    mov ecx, eax ; Move string from 
    mov ebx, 1 ; Move std_out into ebx (1 represents std_out)
    mov eax, 4 ; 4 represents sys_write
    int 0x80 ; System interrupt
    ret ; Return





; =============================
; = printF (string s, file f) =
; =============================
; Usage: To print out a string in a file
; Input: String in eax, file name in ebx
; Registers: eax, ebx, ecx, edx
; Output: Void
printF:
    push eax ; Push the string in eax so that we don't lose it during this step

    ; Open the file
    mov edx, 0777 ; Read, write, and execute for all
    mov ecx, 1 ; Open with write access
    mov eax, 5 ; 5 represents SYS_OPEN
    int 0x80 ; System interrupt

    ; Find the length of the string
    mov ebx, eax ; Move the file descriptor in eax into ebx (because we're going to pop something into eax)
    pop eax ; Retrieve the string that we pushed earlier
    push ebx ; Push the value that is inside ebx (you couldn't push it earlier because we had to pop that last value into eax)
    call len ; Find the length
    
    ; Write to the file
    mov edx, ebx ; Move the length of the string into edx
    mov ecx, eax ; Move the message into ecx
    pop ebx ; Pop the file descriptor that we pushed earlier
    mov eax, 4 ; 4 represents SYS_WRITE
    int 0x80 ; System interrupt

    ret ; Return





; ==============================
; = printCF (string s, file f) =
; ==============================
; Usage: To create a file and then print a string to it
; Input: String in eax, file in ebx
; Registers: eax, ebx, ecx, edx
; Output: File descriptor in eax
printCF:
    push eax ; Save the string to be printed out in the stack

    ; Create the file
    mov eax, 8 ; 8 represents SYS_CREAT
    mov ecx, 0777 ; Read, write, and execute by all
    int 0x80 ; System interrupt

    ; Find the length of the string
    mov ebx, eax ; Move the file descriptor in eax into ebx (because we're going to pop something into eax)
    pop eax ; Retrieve the string that we pushed earlier
    push ebx ; Push the value that is inside ebx (you couldn't push it earlier because we had to pop that last value into eax)
    call len ; Find the length
    
    ; Write to the file
    mov edx, ebx ; Move the length of the string into edx
    mov ecx, eax ; Move the message into ecx
    pop ebx ; Pop the file descriptor that we pushed earlier
    mov eax, 4 ; 4 represents SYS_WRITE
    int 0x80 ; System interrupt

    ret ; Return





; ======================
; = printLF (string s) =
; ======================
; Usage: To print out a string and a LF character
; Input: String in eax
; Registers: eax, ebx, ecx, edx, esp
; Output: Void
printLF:
    call print ; Print out the string first
    mov eax, 0Ah ; Move LF character into eax
    push eax ; Since we can't directly print the LF character, we'll just push it,
    mov eax, esp ; And then we'll use the stack pointer to print it out
    call print ; Print out the stack pointer
    pop eax ; Get rid of the LF character on the stack
    ret ; Return
