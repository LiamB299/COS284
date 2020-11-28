segment .data
	input_text	db	"Please input a 5 digit number: "
	output_text	db	"This is the number you are looking for: "
	;len_1 equ $ - input_text
	;len_2 equ $ - output_text

segment .bss
	rec resb 6

segment .text
	global _start
_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, input_text
	mov rdx, 31 ; doesn't like variables passed in for size
	syscall
	
	mov rax, 0
	mov rdi, 0
	mov rsi, rec
	mov rdx, 6
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, output_text
	mov rdx, 40
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, rec
	mov rdx, 5
	syscall
	
	mov rax, 60
	mov rdi, 0
	syscall
