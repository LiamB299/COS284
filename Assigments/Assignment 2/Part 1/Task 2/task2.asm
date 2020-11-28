segment .data
	input_text db "Please input an integer: "
	output_text_p db "Result: positive", 10
	output_text_n db "Result: negative", 10
	;len_1 equ $ - input_text
	;len_2 equ $ - output_text_p

segment .bss
	input resb 1

segment .text
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, input_text
	mov rdx, 25
	syscall

	mov rax, 0
	mov rdi, 0
	mov rsi, input
	mov rdx, 1
	syscall
	
	mov rsi, output_text_p
	mov rax, output_text_n
	;mov rbx, 53
	sub byte[input], 53 ;specify the size
	cmovl rsi, rax 
	
	mov rax, 1
	mov rdi, 1
	mov rdx, 17
	syscall
	mov rax, 60
	mov rdi, 0
	syscall
