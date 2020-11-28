segment .data
	input_text_1 db "Please input a number: "
	p db 19, 17, 13, 11, 7, 5, 3, 2

segment .bss
	num1 resb 3
	ans resb 2

segment .text
	global _start

_start:

	mov rax, 1
	mov rdi, 1
	mov rsi, input_text_1
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

	mov r9, -1
	xor r10, r10

find_p:
	add r9, 1
	mov r10b, [p+r9]
	cmp r10, r8
	jg find_p

    xor rax, rax
    mov al, [p+r9]
	mov r9, 10
	div r9
	mov [ans], al
	add byte[ans], 48
	mov [ans+1], dl
	add byte[ans+1], 48

	mov rax, 1
	mov rdi, 1
	mov rsi, ans
	mov rdx, 2
	syscall

	mov rax, 60
	mov rdi, 0
	syscall