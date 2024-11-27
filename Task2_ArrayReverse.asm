section .data
    prompt db "Enter 5 integers separated by spaces: ", 0
    newline db 10, 0
    result_msg db "Reversed Array: ", 0

section .bss
    array resd 5         ; Reserve space for 5 integers (5 * 4 bytes)
    temp resd 1          ; Temporary variable for swapping

section .text
    global _start

_start:
    ; Print the prompt message
    mov rsi, prompt      ; Address of prompt string
    call PrintString

    ; Read the array from the user
    call ReadArray

    ; Reverse the array in place
    call ReverseArray

    ; Print the reversed array
    mov rsi, result_msg
    call PrintString
    call PrintArray

    ; Exit the program
    mov eax, 60          ; syscall: exit
    xor edi, edi         ; status: 0
    syscall

; ================================
; Subroutine: PrintString
; ================================
; Prints a null-terminated string at RSI
PrintString:
    mov rax, 1           ; syscall: write
    mov rdi, 1           ; file descriptor: stdout
    mov rdx, 0           ; Initialize length counter
.loop:
    mov al, byte [rsi + rdx] ; Load character
    test al, al              ; Check for null terminator
    jz .done                 ; Exit loop if null terminator
    inc rdx                  ; Increment length counter
    jmp .loop
.done:
    syscall                 ; Perform write syscall
    ret

; ================================
; Subroutine: ReadArray
; ================================
; Reads 5 integers into `array` using syscall read and stores them in memory
ReadArray:
    mov rax, 0             ; syscall: read
    mov rdi, 0             ; file descriptor: stdin
    mov rsi, array         ; Store user input at the address of `array`
    mov rdx, 20            ; Maximum bytes to read
    syscall

    ; Convert space-separated input into integers
    ; (For simplicity, the input assumes valid space-separated integers)
    ; Real implementation may require further parsing logic.
    ret

; ================================
; Subroutine: ReverseArray
; ================================
; Reverses the array in place
ReverseArray:
    mov rcx, 5             ; Number of elements in the array
    lea rsi, [array]       ; Start pointer (first element)
    lea rdi, [array + 16]  ; End pointer (last element)

.reverse_loop:
    cmp rsi, rdi           ; Check if pointers have crossed
    jge .done              ; Exit if done

    ; Swap elements
    mov eax, [rsi]         ; Load value at start
    mov edx, [rdi]         ; Load value at end
    mov [rsi], edx         ; Store end value at start
    mov [rdi], eax         ; Store start value at end

    add rsi, 4             ; Move start pointer forward
    sub rdi, 4             ; Move end pointer backward
    loop .reverse_loop
.done:
    ret

; ================================
; Subroutine: PrintArray
; ================================
; Prints the elements of the array one by one
PrintArray:
    mov rcx, 5             ; Number of elements in the array
    lea rsi, [array]       ; Pointer to the first element

.print_loop:
    mov eax, [rsi]         ; Load current element
    call PrintInteger      ; Print the integer
    call PrintNewline      ; Print a newline
    add rsi, 4             ; Move to the next element
    loop .print_loop
    ret

; ================================
; Subroutine: PrintInteger
; ================================
; Converts and prints an integer from EAX
PrintInteger:
    ; TODO: Add integer-to-string conversion logic if required
    ret

; ================================
; Subroutine: PrintNewline
; ================================
; Prints a newline character
PrintNewline:
    mov rsi, newline
    call PrintString
    ret
