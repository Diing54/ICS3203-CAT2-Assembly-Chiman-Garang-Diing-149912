section .data
    prompt db "Enter 5 integers separated by spaces: ", 0
    result_msg db "Reversed array is: ", 0
    newline db 10, 0

section .bss
    arr resd 5         ; Reserve space for 5 integers (4 bytes each = 20 bytes)

section .text
    global _start

_start:
    ; Print the prompt
    mov rax, 1             ; syscall: write
    mov rdi, 1             ; stdout
    mov rsi, prompt        ; Address of the prompt
    mov rdx, 30            ; Length of the prompt
    syscall

    ; Read user input (5 integers, each 4 bytes)
    mov rax, 0             ; syscall: read
    mov rdi, 0             ; stdin
    mov rsi, arr           ; Address to store input
    mov rdx, 20            ; Read 20 bytes (5 integers, 4 bytes each)
    syscall

    ; Now, the array contains the 5 integers, and we will reverse the array in place.
    ; Initialize loop variables
    mov rbx, 0             ; rbx = start index of array
    mov rcx, 4             ; rcx = number of elements - 1 (index for the last element)
    
reverse_loop:
    ; Swap arr[rbx] with arr[rcx]
    mov rdx, [arr + rbx*4] ; Load arr[rbx] into rdx
    mov r8, [arr + rcx*4]  ; Load arr[rcx] into r8
    mov [arr + rbx*4], r8  ; Store r8 at arr[rbx]
    mov [arr + rcx*4], rdx ; Store rdx at arr[rcx]

    ; Increment rbx and decrement rcx
    inc rbx
    dec rcx

    ; Continue looping until rbx >= rcx
    cmp rbx, rcx
    jl reverse_loop         ; Jump to reverse_loop if rbx < rcx

    ; Print the result message
    mov rax, 1             ; syscall: write
    mov rdi, 1             ; stdout
    mov rsi, result_msg    ; Address of result message
    mov rdx, 18            ; Length of result message
    syscall

    ; Print the reversed array
    mov rbx, 0             ; Start index again for printing
print_loop:
    ; Get the integer from the array
    mov rax, [arr + rbx*4] ; Load arr[rbx] into rax
    ; Convert integer to string and print it
    ; Integer-to-ASCII conversion function (simplified):
    mov rcx, 10            ; Set divisor for decimal conversion
    xor rdx, rdx           ; Clear rdx (remainder storage)
    
convert_loop:
    div rcx                ; Divide rax by 10 (result in rax, remainder in rdx)
    add dl, '0'            ; Convert remainder to ASCII ('0' = 48)
    push rdx               ; Push the digit onto the stack

    ; Check if we have finished the conversion
    test rax, rax
    jnz convert_loop       ; Continue looping if there's more to convert

    ; Print the digits (in reverse order)
print_digits:
    pop rdx                ; Pop a digit from the stack
    mov rdi, 1             ; stdout
    mov rsi, rdx           ; The digit to print
    mov rdx, 1             ; Print one byte (the digit)
    syscall

    ; Print space separator
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    inc rbx                ; Increment the index
    cmp rbx, 5             ; Check if we have printed all 5 elements
    jl print_loop          ; Loop if we haven't finished

    ; Exit program
    mov rax, 60            ; syscall: exit
    xor rdi, rdi           ; Exit code 0
    syscall
