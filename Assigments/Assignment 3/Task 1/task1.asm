segment .data
	in1	db	"Enter the first number: "
	in2	db	"Enter the second number: "

segment .bss
	num1 resb 3
	num2 resb 3
	ans resb 2

segment .text
	global _start
_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, in1
	mov rdx, 24
	syscall
	
	mov rax, 0
	mov rdi, 0
	mov rsi, num1
	mov rdx, 3
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, in2
	mov rdx, 25
	syscall
	
	mov rax, 0
	mov rdi, 0
	mov rsi, num2
	mov rdx, 3
	syscall

	mov r8, 0
	mov r9, 0

	mov al, [num1]
	sub al, 48
	mov r8, 10
	mul r8
	mov r8b, al
	add r8b, byte[num1+1]
	sub r8b, 48

	mov al, [num2]
	sub al, 48
	mov r9, 10
	mul r9
	mov r9b, al
	add r9b, byte[num2+1]
	sub r9b, 48

	xor rax, rax
	xor rdx, rdx
	mov al, r8b
	
divide:
	div r9
	mov rax, r9
	mov r9, rdx
	xor rdx, rdx ; RDX needs ro be zeroed out to prevent weird behaviour
	cmp r9, 0
	jnz divide

	;mov rax, r9
	mov r9, 10
	;mov rax, r8
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
