section .data
    prompt db "Enter a number (0-9): ", 0      ; Message to prompt the user
    positive_msg db "POSITIVE", 0             ; Message for positive numbers
    negative_msg db "NEGATIVE", 0             ; Message for negative numbers
    zero_msg db "ZERO", 0                     ; Message for zero

section .bss
    num resb 2                                ; Buffer to store user input

section .text
    global _start

_start:
    ; Display prompt message
    mov rax, 1                               ; syscall for write
    mov rdi, 1                               ; file descriptor (stdout)
    mov rsi, prompt                          ; pointer to prompt message
    mov rdx, 23                              ; length of the message
    syscall

    ; Read user input
    mov rax, 0                               ; syscall for read
    mov rdi, 0                               ; file descriptor (stdin)
    mov rsi, num                             ; buffer to store user input
    mov rdx, 2                               ; length of input buffer
    syscall

    ; Convert input to integer
    movzx rax, byte [num]                    ; Load the first byte of input
    sub rax, '0'                             ; Convert ASCII to integer

    ; Branching logic: Check if number is ZERO
    cmp rax, 0
    je is_zero                               ; Conditional jump for ZERO. je is used to determine if the input number is ZERO. It directs the flow to the is_zero label.

    ; Check if number is NEGATIVE
    cmp rax, 0
    jl is_negative                           ; Conditional jump for NEGATIVE. jl is  used to check if the input number is NEGATIVE and direct flow to the is_negative label.

    ; Default case: POSITIVE
    jmp is_positive                          ; Unconditional jump for POSITIVE. jmp is used after checking conditions to redirect the flow without further evaluation.

is_positive:
    ; Handle positive case
    mov rsi, positive_msg                    ; Load "POSITIVE" message
    jmp print_message                        ; Unconditional jump to print

is_negative:
    ; Handle negative case
    mov rsi, negative_msg                    ; Load "NEGATIVE" message
    jmp print_message                        ; Unconditional jump to print

is_zero:
    ; Handle zero case
    mov rsi, zero_msg                        ; Load "ZERO" message

print_message:
    ; Print the message
    mov rax, 1                               ; syscall for write
    mov rdi, 1                               ; file descriptor (stdout)
    mov rdx, 8                               ; length of message
    syscall

    ; Exit the program
    mov rax, 60                              ; syscall for exit
    xor rdi, rdi                             ; exit code 0
    syscall

    ;Conditional jumps make the logic efficient by branching based on specific conditions.
    ;Unconditional jumps ensure seamless flow for non-conditional tasks like printing messages or exiting.
    ;The je and jl instructions ensure that each classification is accurate based on input.
    ;The jmp instructions streamline transitions between tasks and prevent accidental execution of unrelated code.