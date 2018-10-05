section .txt

; ========================
; = power (int a, int b) =
; ========================
; Usage: To raise int a to the power of int b
; Input: Base integer in eax, exponent int in ebx
; Registers: eax, ebx, ecx
; Output: Int a^b in eax
power:
    cmp ebx, 0 ; Check if ebx is zero
    je ret0Pow ; Return 1 if ebx is zero
    cmp ebx, 1 ; Check if ebx is one (meaning that there is no change)
    je retPow
    mov ecx, eax ; Move eax into ecx (so that we retain the original value of the base as we continuously multiply it)
loopPow:
    dec ebx ; Decrement ebx
    mul ecx ; Multiply eax by ecx
    cmp ebx, 1 ; Check if ebx is one (meaning that we have no more numbers to multiply)
    jne loopPow ; Continue the loop if we still have more numbers to multiply
retPow:
    ret ; Return if we're done
ret0Pow: ; Return eax^0 power
    mov eax, 1 ; Anything to the zeroth value is always 1 no matter what
    ret ; Return





; ================
; = rand (int a) =
; ================
; Usage: To create a random integer between 0 and a
; Input: Maximum integer in eax
; Registers: eax, ebx, edx
; Output: Random number between 0 and a in eax
rand:
    mov ebx, eax ; Move the maximum integer into ebx (because the next line of code will use eax)
    rdtsc ; Returns the Time Stamp Counter in EDX:EAX
    xor edx, edx ; Clear edx so that we can use it to put the remainder in there
    div ebx ; Divide eax with the maximum integer so that we can get the remainder
    mov eax, edx ; The remainder, which is a random number less than ebx, will be moved into eax right before returning
    ret ; Return
