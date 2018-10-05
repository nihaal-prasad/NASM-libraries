section .txt

; =============================
; = int2str (int i, buffer b) =
; =============================
; Usage: To convert an integer into a string
; Input: Int in eax, buffer in ebx
; Registers: eax, ebx, ecx, edx, esp
; Output: String inside the buffer that was inputted
int2str:
    mov edi, ebx ; Move the buffer into edi
    mov ecx, 0 ; Move 0 into ecx (this will be used for counting the length of the string)
    mov ebx, 10 ; Move 10 into ebx (this will be used for division later on)

pushInt:
    inc ecx ; Increment ecx
    xor edx, edx ; Clear edx (I don't know why this is necessary, but the code won't work without it)
    idiv ebx ; Divide eax by 10 (this is done so that we can get a single digit in edx; ints will be printed digit-by-digit)
    add edx, 30h ; Edx contains the remainder of the division (which should be a single digit)
                 ; Adding 48 will convert a single digit into a string (since the ascii values for numbers are 48+value)
    push edx ; Push the ascii value onto the stack.
    cmp eax, 0 ; Check if the number is zero (meaning that there are no more digits left to print)
    jne pushInt ; Repeat if it is not zero

popInt:
    ; Convert the integer to a string
    dec ecx ; Decrement ecx (ecx is a counter for how many digits are left to be printed out)
    pop eax ; Pop the value into eax
    stosb ; Move the contents of eax into the address at edi (which is the buffer)
    cmp ecx, 0 ; Check if ecx is 0. Ecx is the counter for our function
    jne popInt ; If ecx is not 0, then we still have more integers to move into edi
    
    ; End loop
    mov eax, 0 ; Move an end-of-string delimiter into eax
    stosb ; Add a line feed character into the buffer
    ret ; Return





; ======================
; = str2int (string s) =
; ======================
; Usage: To convert a string into an integer
; Input: String in eax
; Registers: eax, ebx, ecx, edx, edi
; Output: Int in eax
str2int:
    mov ecx, 0 ; Move 0 into ecx (this will be used for counting the length of the string)

pushStr:
    inc ecx ; Increment ecx
    xor ebx, ebx ; Zero out the ebx register
    mov bl, byte[eax] ; Move the byte in eax into bl
    sub bl, 30h ; Subtracting 48 will convert a single digit into an int (since the integer values for numbers are 48-value)
    push ebx ; Push the int value onto the stack.
    inc eax ; Increment eax
    cmp byte[eax], 0 ; Check if the number is zero (meaning that there are no more digits left to print)
    jne pushStr ; Repeat if it is not zero
    mov edx, ecx ; Move the counter into edx 
    mov ecx, 0 ; Move 0 into ecx so that we can start to count again
    mov edi, 0 ; Move 0 into edi (which is what we'll use to store the number)

popStr:
    inc ecx ; Increment the counter

    ; Convert the integer to a string
    pop eax ; Pop the value into eax
    push ecx ; Push ecx so that we don't lose it while using the loop command
    call mul10 ; Multiply eax by 10^ecx
    pop ecx ; Restore the previous value of ecx
    add edi, eax ; Add edi with eax
    cmp ecx, edx ; Check if ecx is edx. Ecx is the counter for our function and edx is the max
    jne popStr ; If ecx is not edx, then we still have more integers to move into edi
    mov eax, edi ; Move the result into eax
    ret ; Return

mul10: ; This will be used for multiplication
    mov ebx, 10 ; Move 10 into ebx
loop:
    dec ecx ; Decrement the counter
    cmp ecx, 0 ; Check if the counter is 0 yet
    je stop ; Stop the loop
    push edx ; Store the value of edx (so that we can restore its value after the mul command uses it to store the remainder)
    mul ebx ; Multiply eax by 10
    pop edx ; Restore the value of edx
    jmp loop ; Continue the loop
stop:
    ret ; Return
