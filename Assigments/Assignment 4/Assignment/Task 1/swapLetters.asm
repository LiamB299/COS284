    section .text
    global swapLetters

swapLetters:
;========frame==============
	push rbp
	mov rbp, rsp

    xor r15, r15
    xor r14, r14

    mov r15b, [rdi+rsi]
    mov r14b, [rdi+rdx]

    mov [rdi+rsi], r14b
    mov [rdi+rdx], r15b

    mov rax, rdi
    leave
    ret