section .text

; ================================
; = isEqual (string a, string b) =
; ================================
; Usage: To check if a and b are equal to each other
; Input: String in eax, string in ebx
; Registers: eax, ebx, ecx, edx
; Output: Sets ZF to 1 if they are equal or sets ZF to 0 if they are not
isEqual:
    mov cl, byte[eax] ; Move the byte in eax into cl
    mov dl, byte[ebx] ; Move the byte in ebx into dl
    cmp cl, 0 ; Check if the value in eax is 0 (meaning that we have hit the end of the string)
    je ebxEq ; If eax is 0, check the value of ebx
    cmp cl, dl ; Compare the values at eax and ebx
    jne retNotEq ; If eax and ebx are not equal, then there is no way that the two strings can be equal
    inc eax ; Increment eax
    inc ebx ; Increment ebx
    jmp isEqual ; Continue the loop
ebxEq: ; If cl is 0 and dl is 0, then that means that the strings are equal. If they are not equal, then the strings are not equal
    cmp dl, 0 ; Check if the value in ebx is 0 (meaning that we have hit the end of the string)
    je retEq ; Return equal
retNotEq:
    mov eax, 1 ; Move 1 into eax
    mov ebx, 0 ; Move 0 into ebx
    cmp eax, ebx ; Compare 1 with 0 to set ZF to 0
    ret ; Return
retEq:
    mov eax, 1 ; Move 1 into eax
    mov ebx, 1 ; Move 1 into ebx
    cmp eax, ebx ; Compare 1 with 1 to set ZF to 1
    ret ; Return




; =============================================================
; = isEqualIgnoreCase(string a, string b, buffer c, buffer d) =
; =============================================================
; Usage: To check if a and b are equal to each other and ignore whether they are capitalized or not
; Input: String in eax, string in ebx
; Registers: eax, ebx, ecx, edx
; Output: Sets ZF to 1 if they are equal or sets ZF to 0 if they are not, capitalized forms of a and b are in buffer c and d respectively
isEqualIgnoreCase:
    ; Copy string a into buffer c
    push ebx ; Save the value in ebx
    push ecx ; Save the value in ecx
    mov ebx, ecx ; Move ecx into ebx
    call strCopy ; Copy string a into buffer c

    ; Copy string b into buffer d
    pop ecx ; Move buffer c into ecx
    mov ebx, eax ; Move string a into ebx
    pop eax ; Pop string b into eax
    push ebx ; Push string a onto the stack
    mov ebx, edx ; Move buffer d into ebx
    push ecx ; Save the value of buffer c onto the stack
    call strCopy ; Copy string 
    
    ; Move the buffers into eax and ebx
    mov ebx, edx ; Move buffer b into ebx
    mov edx, eax ; Move string b into edx
    pop eax ; Pop buffer c into eax
    pop ecx ; Pop string a into ecx
    
    ; Covert the strings into uppercase
    call upperCase ; Convert string originally in eax into uppercase
    push eax ; Save eax for now
    mov eax, ebx ; Move ebx into eax
    call upperCase ; Convert string originally in ebx (which is now eax) into uppercase
    mov ebx, eax ; Move eax into ebx
    pop eax ; Restore eax

    ; Check if the strings are equal
    call isEqual ; Call isEqual

    ; Move around some stuff so that the output's order isn't different from the input's order
    push eax ; Push buffer c onto the stack
    mov eax, ecx ; Move string a into eax
    pop ecx ; Pop buffer c into ecx
    push ebx ; Push buffer d onto the stack
    mov ebx, edx ; Move string b into ebx
    pop edx ; Pop buffer d into edx
    ret ; Return





; ================================
; = strCopy (string a, buffer b) =
; ================================
; Usage: Copies string a into buffer b
; Input: String in eax, buffer in ebx
; Registers: eax, ebx, ecx
; Output: String in eax and string in buffer in ebx
strCopy:
    push eax ; Push eax so that we retain its value
    push ebx ; Push ebx so that we retain its value
continueCopy:
    cmp byte[eax], 0 ; Check if the byte at eax is 0 (meaning that it's an end of string delimiter)
    je stopCopy ; If we are at the end of the string, stop copying
    mov cl, byte[eax] ; Move the byte in eax into cl
    mov byte[ebx], cl ; Move byte in eax into the byte in ebx
    inc eax ; Increment eax
    inc ebx ; Increment ebx
    jmp continueCopy ; Continue the loop until we hit an end of string delimiter
stopCopy:
    inc ebx ; Increment ebx
    mov byte[ebx], 0 ; Move zero into the byte at ebx (0 is an end-of-string delimiter)
    pop ebx ; Restore the previous value of ebx
    pop eax ; Restore the previous value of eax
    ret ; Return





; ========================
; = upperCase (string s) =
; ========================
; Usage: To convert all strings into upper case characters
; Input: String in eax
; Registers: eax
; Output: String in eax
upperCase:
    ; If a character's value is between 97 and 122, then it is lowercase
    ; Converting it to uppercase is as easy as subtracting 32 from a lowercase character
    push eax ; Push eax so that we can restore its original value later
convertUpperCase:
    ; Checks
    cmp byte[eax], 97 ; Compare eax with 97
    jl nextUpperCase ; Do not execute this code if eax is less than 97
    cmp byte[eax], 122 ; Compare eax with 122
    jg nextUpperCase ; Do not execute this code if eax is less than 122
    ; If all of the checks have been ran, then that means that this is a lowercase character
    sub byte[eax], 32 ; Subtract 32 from eax to convert the lowercase character into an uppercase character
nextUpperCase: ; Continue the loop
    inc eax ; Increment eax so that it points to the next character
    cmp byte[eax], 0 ; Check if the byte at eax is 0 (meaning that its an end-of-string delimiter)
    jne convertUpperCase ; Continue the loop if the letter is not 0
    pop eax ; Restore the first value of eax
    ret ; Return





; ========================
; = lowerCase (string s) =
; ========================
; Usage: To convert all strings into lower case characters
; Input: String in eax
; Registers: eax
; Output: String in eax
lowerCase:
    ; If a character's value is between 65 and 90, then it is uppercase
    ; Converting it to lowercase is as easy as adding 32 from an uppercase character
    push eax ; Push eax so that we can restore its original value later
convertLowerCase:
    ; Checks
    cmp byte[eax], 65 ; Compare eax with 65
    jl nextLowerCase ; Do not execute this code if eax is less than 65
    cmp byte[eax], 90 ; Compare eax with 90
    jg nextLowerCase ; Do not execute this code if eax is less than 90
    ; If all of the checks have been ran, then that means that this is a lowercase character
    add byte[eax], 32 ; Add 32 from eax to convert the lowercase character into an uppercase character
nextLowerCase: ; Continue the loop
    inc eax ; Increment eax so that it points to the next character
    cmp byte[eax], 0 ; Check if the byte at eax is 0 (meaning that its an end-of-string delimiter)
    jne convertLowerCase ; Continue the loop if the letter is not 0
    pop eax ; Restore the first value of eax
    ret ; Return
