section .data
    cls db 27, "[2J", 27, "[H", 0       ; Escape characters to clear the screen
                                        ; and move the pointer to the top right
    headline db "          Vital Message      ", 10, 10 ; Headline
    headline_length equ $-headline
    difficulty db "   How difficult (4-10)? $ ", 0      ; Ask about difficulty
    difficulty_buffer db 2
    difficulty_length equ $-difficulty


section .bss
    input_difficulty resb 4


section .text
    global _start


%macro clear_screen_and_move 0
    mov rax, 1                      ; sys_write
    mov rdi, 1                  ; file descriptor (stdout)
    lea rsi, [cls]    ; pointer to the escape sequence
    mov rdx, 8          ; length of the sequence
    syscall
%endmacro

%macro print_msg 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro exit 0
    mov rax, 60
    mov rdi, 0
    syscall
%endmacro

_dif_input:
    mov rax, 0
    mov rdi, 0
    mov rsi, input_difficulty
    mov rdx, 4
    syscall
    ret

_start:
    clear_screen_and_move
    print_msg headline, headline_length
    print_msg difficulty, difficulty_length
    call _dif_input
    mov rax, 1
    mov rdi, 1
    mov rsi, input_difficulty
    mov rdx, 4
    syscall
    exit
