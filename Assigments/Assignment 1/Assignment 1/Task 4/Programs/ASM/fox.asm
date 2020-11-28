	segment .data
hello: db "The quick brown fox jumps over the lazy dog.",0x0a
	segment .text
	global _start
_start:
	mov eax,1
	mov edi,1
	mov edx, 44 ; The number of characters
	lea rsi,[hello]
	syscall
	mov eax,60
	xor edi, edi
	syscall
