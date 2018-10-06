#!/bin/bash
nasm -f elf $1
name=$(echo "$1" | cut -f 1 -d '.')
object="$name.o"
ld -m elf_i386 -s -o $name $object
