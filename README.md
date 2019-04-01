# NASM-libraries
Hello everyone. These are libraries that I have made while I was learning NASM assembly so that I could get some work done quicker.

## Usage
Using the library is quite simple. I have tried to document as much as possible about this library, so I have the whole library structure printed below. In order to use this library, all you have to do is type "%include 'filename'" at the top of your .asm file, and then type "call [function name]" in your .txt section whenever you want to call a function in your code :)

I also realize that there is one random bash script in this project. That file is only used for assembling your code, and nothing more than that. You can easily run that script using "./assemble.sh [enter_your_asm_file_here]" and it will automatically run the commands necessary to assemble your code on a i_386 machine.

## Library structure

Here I will paste the entire library structure of all of my assembly code. This will contain the name of each function, how the function is supposed to be used, how the function takes in input parameters (and in what form), what registers the function will use (and therefore probably erase data from), and how the function will output its values.

assemble.sh:

    - assemble(string file_name)
        - Usage: Assembles and links NASM code
        - Input: Command line arguments (ex. "./assemble.sh [file_name]")
        - Registers: idk
        - Output: An object file and an executable file.

convert.asm:

    - str2int(string s):
        - Usage: To convert a string into an integer
        - Input: String in eax
        - Registers: eax, ebx, ecx, edx, edi
        - Output: Int in eax
    - int2str(int i, buffer b):
        - Usage: To convert an integer into a string
        - Input: Int in eax, buffer in ebx
        - Registers: eax, ebx, ecx, edx, esp
        - Output: String inside the buffer that was inputted

math.asm

    - power(int a, int b):
        - Usage: To raise int a to the power of int b
        - Input: Base integer in eax, exponent int in ebx
        - Registers: eax, ebx, ecx
        - Output: Int a^b in eax
    - rand(int a):
        - Usage: To create a random integer between 0 and a
        - Input: Maximum integer in eax
        - Registers: eax, ebx, edx
        - Output: Random number between 0 and a in eax

print.asm:

    - len(string s):
        - Usage: To find the length of a string
        - Input: String in eax
        - Registers: eax, ebx
        - Output: String in eax, length in ebx
    - print(string s):
        - Usage: To print out a string
        - Input: String in eax
        - Registers: eax, ebx, ecx, edx
        - Output: Void
    - printF(string s, file f):
        - Usage: To print out a string in a file
        - Input: String in eax, file in ebx
        - Registers: eax, ebx, ecx, edx
        - Output: Void
    - printCF(string s, file f):
        - Usage: To create a file and then print a string to it
        - Input: String in eax, file in ebx
        - Registers: eax, ebx, ecx, edx
        - Output: File descriptor in eax
    - printLF(string s): Will print out a string and a LF character
        - Usage: To print out a string and a LF character
        - Input: String in eax
        - Registers: eax, ebx, ecx, edx, esp
        - Output: Void

read.asm:

    - read(variable a, length l):
        - Usage: To read from STDIN
        - Input: Variable to send output to in eax, length in ebx
        - Registers: eax, ebx, ecx, edx
        - Output: Value read from STDIN is outputted into variable that was in eax
    - readF(buffer b, file f, length l):
        - Usage: To read from file a and store the output in buffer b
        - Input: Buffer in eax, file name in ebx, and length in ecx
        - Registers: eax, ebx, ecx, edx
        - Output: Value read from file is outputted into buffer that was in eax

str.asm:

    - isEqual(string a, string b):
        - Usage: To check if a and b are equal to each other
        - Input: String in eax, string in ebx
        - Registers: eax, ebx, ecx, edx
        - Output: Sets ZF to 1 if they are equal or sets ZF to 0 if they are not
    - isEqualIgnoreCase(string a, string b, buffer c, buffer d):
        - Usage: To check if a and b are equal to each other and ignore whether they are capitalized or not
        - Input: String in eax, string in ebx, buffer in ecx, buffer in edx
        - Registers: eax, ebx, ecx, edx
        - Output: Sets ZF to 1 if they are equal or sets ZF to 0 if they are not, capitalized forms of a and b are in buffer c and d respectively
    - strCopy(string a, buffer b):
        - Usage: Copies string a into buffer b
        - Input: String in eax, buffer in ebx
        - Registers: eax, ebx, ecx
        - Output: String in eax and string in buffer in ebx
    - upperCase(string s):
        - Usage: To convert all strings into upper case characters
        - Input: String in eax
        - Registers: eax
        - Output: String in eax
    - lowerCase(string s):
        - Usage: To convert all strings into lower case characters
        - Input: String in eax
        - Registers: eax
        - Output: String in eax
