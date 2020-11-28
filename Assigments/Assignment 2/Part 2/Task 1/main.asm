segment .data
	input_text_1 db "Please enter the first number: "
	input_text_2 db "Please enter the second number: "

segment .bss
	in_1 resb 2
	in_2 resb 2
	quot resb 1
	rem resb 1
	junk resb 1

segment .text
	global _start

_start:
	mov rax, 0
	mov rdx, 0

	mov rax, 1
	mov rdi, 1
	mov rsi, input_text_1
	mov rdx, 31
	syscall
	
	mov rax, 0
	mov rdi, 0
	mov rsi, in_1
	mov rdx, 2
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, input_text_2
	mov rdx, 32
	syscall
	
	mov rax, 0
	mov rdi, 0
	mov rsi, in_2
	mov rdx, 2
	syscall

	mov r9b, [in_1]
	mov r10b, [in_2]
	add r9b, r10b
	sub r9b, 96 
	mov al, r9b
	mov r8, 10
	mov rdx, 0
	div r8

	mov r9b, al
	add r9b, 48
	mov [quot], r9b

	mov r10b, dl
	add r10b, 48
	mov [rem], r10b

	mov rax, 1
	mov rdi, 1
	mov rsi, quot
	mov rdx, 1
	syscall

	mov rax, 1
	mov rdi, 1
	mov rsi, rem
	mov rdx, 1
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
