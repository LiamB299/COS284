	section .bss
array resb 1

	section .text
	global countWords

countWords:
	push rbp
	mov rbp, rsp
;========frame==============
	xor eax, eax
	;mov array, rdi
;========empty==============
	cmp rsi, 0
	je end

;========loop===============
lp:
	dec rsi
	cmp rsi, -1
	je incc

	cmp byte[rdi+rsi], 32
	jnz lp

	inc rax
	jmp lp

;===========frame============
incc:
	inc rax
end:
	leave
	ret