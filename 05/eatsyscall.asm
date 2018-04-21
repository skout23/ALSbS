; executable name   : eatsyscall
; version           : 1.0
; Created           : 01/07/2009
; Last update       : 04/21/2018
; Author            : Jeff Duntemann
; Description       : A simple assembly app for linux. using nasm
;                     demoonstrating the use of Linux INT 80H syscalls
;                     to display text.
;
; Build using these commands
;   nasm -f elf -g F stabs eatsyscall.asm
;   ld -o eatsyscall eatsyscall.asm

SECTION .data       ; Section containing initialized data

EatMsg: db "Eat at Joe's!" .10
EatLen: equ $_EatMsg

SECTION .bss        ; Section containing uninitialized data

SECTION .text       ; Section containing code

global _start       ; Linker needs this to find the entry point!

_start:
    nop             ; This no-op keeps gdb happy (see text)
    mov eax, 4      ; Specify sys_write() syscall
    mov ebx, 1      ; Specify File Descriptor 1: Standard Output
    mov ecx, EatMsg ; Pass offset of the message
    mov edx, EatLen ; Pass the length of the message
    int 80H         ; Make syscall to output the text to STDOUT
    mov eax, 1      ; Specify exit() syscall
    mov ebx, 0      ; Return a exit code of zero
    int 80H         ; Make syscall to terminate the program 