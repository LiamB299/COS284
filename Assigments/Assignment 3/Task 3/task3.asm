segment .data
    out1 db "Please input a number: "

segment .bss
    num1 resb 2
    dig resb 1

segment .text
	global _start

_start:

    mov rax, 1
	mov rdi, 1
	mov rsi, out1
	mov rdx, 23
	syscall

    mov rax, 0
	mov rdi, 0
	mov rsi, num1
	mov rdx, 3
	syscall

    mov al, [num1]
	sub al, 48
	mov r8, 10
	mul r8
	mov r8b, al
	add r8b, byte[num1+1]
	sub r8b, 48 ;r8 has the number

    mov rcx, r8
    xor rax, rax
    mov rax, 1
    shl rax, cl
    sub rax, 1

    mov r10, 10
    mov r15, rax
    xor r12, r12

; reverse number to print
reverse: 
    xor rdx, rdx
    div r10
    mov r11, rax
    mov r13, rdx

    ; multiply old position by 10
    mov rax, r12
    mul r10
    mov r12, rax

    ; add new digit
    add r12, r13


    mov rax, r11
    cmp rax, 0
    jnz reverse

    mov r15, r12

; r15 has original
; r12 will be modified
print:
    xor rdx, rdx
    mov rax, r12
    div r10
    mov [dig], dl
    add byte[dig], 48
    mov r12, rax

    mov rax, 1
	mov rdi, 1
	mov rsi, dig
	mov rdx, 1
	syscall

    cmp r12, 0
    jnz print

    mov rax, 60
	mov rdi, 0
	syscall