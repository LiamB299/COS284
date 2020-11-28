    section .text
    global swapWords

swapWords:
;========frame==============
	push rbp
	mov rbp, rsp

    xor eax, eax
    xor r14, r14
    xor r15, r15

    cmp rcx,0
    je end

    inc rcx
    mov r15, rdx

;========indices============
    mov rax, rcx
    mul rsi
    mov rsi, rax

    mov rax, rcx
    mul r15
    mov rdx, rax


;========loop===============
lp

    cmp rcx, 1
    je end

    call swapLetters
    mov rdi, rax

    dec rcx
    inc rsi
    inc rdx

    jmp lp

;========end================
end:
    leave
    ret

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