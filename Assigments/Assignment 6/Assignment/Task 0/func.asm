segment .text
    global apply

apply:
    push rbp
    mov rbp, rsp

    mov rdx, rdi
    mov rdi, rsi
    call rdx

    leave
    ret