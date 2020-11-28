section .data
align 16
    vals: dd 255.0, 256.0, 2.0, 4.0

section .bss
    hold resd 4

section .text
    global color_distance

; xmm0 is r-bar
; xmm1 is r1 - r2
; xmm2 is g1 - g2
; xmm3 is b1 - b2

color_distance:
;=======frame==========
    push rbp
    mov rbp, rsp

;=====extract rgb======
; and square it
    xor eax, eax
    xor edx, edx
    xor ecx, ecx

    mov dl, dil
    mov cl, sil
    sub rdx, rcx
    mov dword[hold], edx
    mov eax, dword[hold]
    cvtsi2ss xmm1, dword[hold]
    mulss xmm1, xmm1
    movss [hold], xmm1

    shr rdi, 8
    shr rsi, 8
    xor edx, edx
    mov dl, dil
    xor ecx, ecx
    mov cl, sil
    sub rdx, rcx
    mov dword[hold+4], edx
    cvtsi2ss xmm1, dword[hold+4]
    mulss xmm1, xmm1
    movss [hold+4], xmm1

    shr rdi, 8
    shr rsi, 8
    ;===r-bar==========
    cvtsi2ss xmm0, rdi
    cvtsi2ss xmm1, rsi
    addss xmm0, xmm1
    divss xmm0, [vals+8]
    ;===r-extract======
    sub rdi, rsi
    mov dword[hold+8], edi
    cvtsi2ss xmm1, dword[hold+8]
    mulss xmm1, xmm1
    movss [hold+8], xmm1

    movss xmm1, [hold]
    movss xmm2, [hold+8]
    movss [hold], xmm2
    movss [hold+8], xmm1

;========multiply====
    movss xmm1, xmm0
    divss xmm1, [vals+4]
    addss xmm1, [vals+8]
    movss xmm2, [hold]
    mulss xmm1, xmm2
    movss [hold], xmm1

    movss xmm1, [hold+4]
    mulss xmm1, [vals+12]
    movss [hold+4], xmm1

    movss xmm1, [vals]
    subss xmm1, xmm0
    divss xmm1, [vals+4]
    addss xmm1, [vals+8]
    mulss xmm1, [hold+8]
    movss [hold+8], xmm1

    movss xmm0, [hold]
    addss xmm0, [hold+4]
    addss xmm0, [hold+8]

    sqrtss xmm0, xmm0

;======================
    leave
    ret