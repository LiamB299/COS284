segment .data
	input_text_1 db "Enter the first number: "
	input_text_2 db "Enter the second number: "

segment .bss
	in_1 resb 8
	in_2 resb 8
	;ans resb 1
	
segment .text
	global _start

_start:

	mov rax, 1
	mov rdi, 1
	mov rsi, input_text_1
	mov rdx, 24
	syscall
	
	mov rax, 0
	mov rdi, 0
	mov rsi, in_1
	mov rdx, 2 ; read two bytes being the number and enter, but only the number is written as 
			; in_ is 1 byte
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, input_text_2
	mov rdx, 25
	syscall
	
	mov rax, 0
	mov rdi, 0
	mov rsi, in_2
	mov rdx, 2
	syscall
	
	mov r8l, [in_1]
	add [in_2], r8l
	sub byte[in_2], 48
	
	mov rax, 1
	mov rdi, 1
	mov rsi, in_2
	mov rdx, 1
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
