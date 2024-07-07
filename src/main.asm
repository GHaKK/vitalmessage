;   Executable name                 : main
;   Version                         : 1.0
;   Created date                    : 2024-07-07
;   Last Update                     : 2024-07-07
;   Author                          : Tommy Larsen
;   License                         : MIT
;   GitHub-Link                     : https://github.com/GHaKK/vitalmessage.git
;   Description                     : Game of chance where you select a number
;                                     and a random number is generated
;   
;
;   Makefile created for making, tree looks like this
;       ./src (All source-code)
;       ./build (Where binaries gets built)
;       ./obj (Here the .o files ends up before it gets linked)
;

section .data                                               ; Section containing initialized data
    cls db 27, "[2J", 27, "[H", 0                           ; Escape characters to clear the screen
                                                            
    headline db "          Vital Message      ", 10, 10
    headline_length equ $-headline                          
    difficulty db "   How difficult (4-10)? $ ", 0
    difficulty_length equ $-difficulty


section .bss                                                ; Section containing uninitialized data
    input_difficulty resb 4


section .text                                               ; Here the code starts
    global _start

%macro print_msg 2
    mov rax, 1                          ; Set syscall "Write"
    mov rdi, 1                          ; Set write to STDOUT
    mov rsi, %1                         ; Message to print
    mov rdx, %2                         ; Length of message (bytes)
    syscall                             ; Call Kernel
%endmacro

%macro exit 0                           ; Exit Program
    mov rax, 60                         ; Set sysExit
    mov rdi, 0                          ; Set ExitCode = 0
    syscall                             ; Call kernel
%endmacro

clear_screen_and_move:
    mov rax, 1                          ; sys_write
    mov rdi, 1                          ; file descriptor (stdout)
    lea rsi, [cls]                      ; pointer to the escape sequence
    mov rdx, 8                          ; length of the sequence
    syscall
    ret

_dif_input:
    mov rax, 0
    mov rdi, 0
    mov rsi, input_difficulty
    mov rdx, 4
    syscall
    ret

_start:
    call clear_screen_and_move
    print_msg headline, headline_length
    print_msg difficulty, difficulty_length
    call _dif_input
    mov rax, 1
    mov rdi, 1
    mov rsi, input_difficulty
    mov rdx, 4
    syscall
    exit
