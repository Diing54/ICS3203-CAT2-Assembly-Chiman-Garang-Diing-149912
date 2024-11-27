section .data
    prompt db "Enter a number: ", 0
    result_msg db "Factorial: ", 0
    newline db 10, 0

section .bss
    num resb 4
    factorial resq 1
    result_str resb 20     ; Buffer to store the result as a string

section .text
    global _start

_start:
    ; Prompt user for input
    mov rax, 1             ; syscall: write
    mov rdi, 1             ; file descriptor: stdout
    mov rsi, prompt        ; address of message
    mov rdx, 15            ; message length
    syscall

    ; Read user input
    mov rax, 0             ; syscall: read
    mov rdi, 0             ; file descriptor: stdin
    mov rsi, num           ; address to store input
    mov rdx, 4             ; max input size
    syscall

    ; Convert input from ASCII to integer
    movzx rax, byte [num]  ; Load input as zero-extended integer
    sub rax, '0'

    ; Call factorial subroutine
    push rax               ; Save input number on the stack
    call factorial_subroutine
    add rsp, 8             ; Clean up the stack

    ; Store result in memory
    mov [factorial], rax

    ; Convert factorial to string
    mov rax, [factorial]
    mov rdi, result_str    ; Buffer for the result string
    call int_to_string     ; Convert integer to string

    ; Display result message
    mov rax, 1             ; syscall: write
    mov rdi, 1             ; file descriptor: stdout
    mov rsi, result_msg    ; address of message
    mov rdx, 10            ; message length
    syscall

    ; Display factorial result
    mov rax, 1             ; syscall: write
    mov rdi, 1             ; file descriptor: stdout
    mov rsi, result_str    ; address of result string
    mov rdx, 20            ; result buffer length
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Exit program
    mov rax, 60            ; syscall: exit
    xor rdi, rdi           ; exit code 0
    syscall

factorial_subroutine:
    ; Registers used: rax (input/output), rbx (loop counter)
    ; Save registers
    push rbx

    mov rbx, rax           ; Copy input number to rbx
    dec rbx                ; Set loop counter to n-1
    cmp rbx, 1             ; Check if n <= 1
    jle .done              ; If so, return 1

.loop:
    imul rax, rbx          ; Multiply rax by rbx
    dec rbx                ; Decrement loop counter
    cmp rbx, 1             ; Check if counter reached 1
    jg .loop

.done:
    pop rbx                ; Restore register
    ret

int_to_string:
    ; Converts the integer in rax to a string in the buffer at rdi
    ; Registers used: rax (input), rbx, rcx (loop counters), rsi (temp buffer)
    mov rcx, 0             ; Digit count

.convert_loop:
    xor rdx, rdx           ; Clear rdx
    mov rbx, 10            ; Divisor
    div rbx                ; rax = rax / 10, remainder in rdx
    add rdx, '0'           ; Convert remainder to ASCII
    mov [rdi + rcx], dl    ; Store ASCII character
    inc rcx                ; Increment digit count
    test rax, rax          ; Check if quotient is 0
    jnz .convert_loop

    ; Reverse the string
    mov rsi, rdi           ; Start of string
    add rdi, rcx           ; End of string (null-terminator position)
    dec rdi                ; Adjust to last character
.reverse_loop:
    cmp rsi, rdi           ; Compare pointers
    jge .done_reverse      ; If start >= end, done
    mov al, [rsi]          ; Swap characters
    mov bl, [rdi]
    mov [rsi], bl
    mov [rdi], al
    inc rsi                ; Move forward
    dec rdi                ; Move backward
    jmp .reverse_loop
.done_reverse:
    ret