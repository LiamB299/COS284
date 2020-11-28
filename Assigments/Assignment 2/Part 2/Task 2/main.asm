section .data
    out1 db "Please enter the first number: "
    out2 db "Please enter the second number: "
    r db "r"

section .bss
    in1 resb 3
    in2 resb 3
    junk resb 1
    quot resb 2
    rem resb 2

section .text

    global _start
_start:

    mov rax, 1
	mov rdi, 1
	mov rsi, out1
	mov rdx, 31
	syscall

    mov rax, 0
	mov rdi, 0
	mov rsi, in1
	mov rdx, 3
	syscall

    mov rax, 1
	mov rdi, 1
	mov rsi, out2
	mov rdx, 32
	syscall

    mov rax, 0
	mov rdi, 0
	mov rsi, in2
	mov rdx, 3
	syscall

    mov rdx, 0
    mov al, [in2]
    sub al, 48
    mov r9b, 10
    mul r9b
    mov r9b, al
    add r9b, [in2+1]
    sub r9b, 48

    mov rdx, 0
    mov al, [in1]
    sub al, 48
    mov r8b, 10
    mul r8b
    mov r8b, al
    add r8b, [in1+1]
    sub r8b, 48

    mov rdx, 0
    mov rax, r8
    div r9

    ;quotient
    mov r9b, al

    ;remainder
    mov r10b, dl

    ; convert quotient to double digits
    mov rax,0 
    mov al, r9b
    mov r9, 10
    mov rdx, 0 
    div r9
    mov [quot], al
    add byte[quot], 48
    mov [quot+1], dl
    add byte[quot+1], 48

    ; convert remainder to double digits
    mov rax, 0
    mov al, r10b
    mov r9, 10
    mov rdx, 0 
    div r9
    mov [rem], al
    add byte[rem], 48
    mov [rem+1], dl
    add byte[rem+1], 48

;==============================works========================

    mov rax, 1
	mov rdi, 1
	mov rsi, quot
	mov rdx, 2
	syscall

    mov rax, 1
	mov rdi, 1
	mov rsi, r
	mov rdx, 1
	syscall

    mov rax, 1
	mov rdi, 1
	mov rsi, rem
	mov rdx, 2
	syscall

    mov rax, 60
	mov rdi, 0
	syscall