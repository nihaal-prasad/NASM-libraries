import sys
import os

if(len(sys.argv) == 1):
    exit(0);

f_in = sys.argv[1]
f_o = f_in[0:f_in.rfind(".asm")] + ".o"
f_out = f_o[0:len(f_in) - 4]

print("Assembling...")
os.system("nasm -f elf " + f_in)
print("Linking...")
os.system("ld -m elf_i386 -s -o " + f_out + " " + f_o)
