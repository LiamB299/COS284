    segment .data
        fmt db "%s", 0xa

    section .text
    global sort
    extern printf

; rdi - string array
; rsi - no of words
; rdx - length of word
; r15 - word to compare (subject)
; r14 - count words compared
; r13 - reasserts rdx after mul
; r12 - index for second word
; r11 - index for first word

sort:
;========frame==============
	push rbp
	mov rbp, rsp
    sub rsp, 64 
;===========================
init
    mov r13, rdx
    xor eax, eax
    xor r15, r15
    mov r15, -1

outer
;============debug print=============
    ;mov [rsp], rdi
    ;mov [rsp+8], rsi
    ;mov [rsp+16], rdx
    ;mov [rsp+24], rcx
    ;xor rax, rax

    ;mov rsi, rdi
    ;mov rdi, fmt
    ;call printf

    ;mov rdi, [rsp]
    ;mov rsi, [rsp+8]
    ;mov rdx, [rsp+16]
    ;mov rcx, [rsp+24]

;====================================

    inc r15

    cmp r15, rsi
    je end

    xor r14, r14
    mov r14, r15

;========calcIndexForSubject==========
    xor eax, eax
    mov rax, rdx
    inc rax
    mul r15
    mov r11, rax
    mov rdx, r13

inner
    inc r14
    cmp r14, rsi
    je outer

;=========calcIndexForCompare==========
    xor eax, eax
    mov rax, rdx
    inc rax
    mul r14
    mov r12, rax
    mov rdx, r13

;=========Compare======================

    xor eax, eax
    mov al, byte[rdi+r11]
    cmp al, byte[rdi+r12]
    jle done



;=========swap=========================
swap:
    mov [rsp], rsi
    mov [rsp+8], rdx
    mov [rsp+16], r14
    mov [rsp+24], r15

    mov rcx, rdx
    mov rdx, r15
    mov rsi, r14

    call swapWords
    mov rdi, rax

    mov rsi, [rsp]
    mov rdx, [rsp+8]
    mov r14, [rsp+16]
    mov r15, [rsp+24]

done:
    jmp inner
;========end===========================
end:
    mov rax, rdi
    leave
    ret


;======================================
;======================================
;======================================

swapWords:
;========frame==============
	push rbp
	mov rbp, rsp

    xor eax, eax
    xor r14, r14
    xor r15, r15

    cmp rcx,0
    je endsl

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
    je endsl

    call swapLetters
    mov rdi, rax

    dec rcx
    inc rsi
    inc rdx

    jmp lp

;========end================
endsl:
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