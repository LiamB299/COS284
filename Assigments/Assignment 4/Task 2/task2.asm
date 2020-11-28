    section .text
    global rotateString

rotateString:
;========frame==============   
    push rbp
	mov rbp, rsp
;========reserve============
    xor r15, r15
    mov r14, rdx
    mov r13, rdx
    mov r15, rdx
res:
    cmp r14, 0
    jle res_end

    sub rsp, 16
    dec r14

    jmp res

;========store==============
res_end:
    mov r14, rdx
    xor eax, eax
store:
    cmp rdx, 0
    je shift

    mov r15b, [rdi+rax]
    mov [rsp+rdx*8], r15b
    dec rdx
    inc rax

    jmp store
;========shift=============
shift:
    xor edx, edx 
shift_2:
    cmp rax, rsi
    jge append

    mov r15b, [rdi+rax]
    mov [rdi+rdx], r15b
    inc rax
    inc rdx

    jmp shift_2

;========append=============
append:
    cmp r14, 0
    je end

    mov r15b, [rsp+r14*8]
    mov [rdi+rdx], r15b
    dec r14
    inc rdx

    jmp append
    
;========end================
end
    mov rax, rdi
    leave
    ret