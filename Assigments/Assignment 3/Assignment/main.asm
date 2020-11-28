segment .data
    input_text_1 db "Input:"
    ten db 10

segment .bss
    Input resb 16
    check resb 1

segment .text
	global _start

_start:

    xor r12, r12
    xor r14, r14
    xor r15, r15

    ; read in line
    mov rax, 0
	mov rdi, 0
	mov rsi, Input
	mov rdx, 16
	syscall

    mov r11, 10

    mov al, byte[Input+r12]
    inc r12
    mov byte[check], al
;=================================================

check_neg:
    mov rdx, 1
    mov al, [check]
    cmp al, 45
    cmovz r14, rdx

    ; if negative sign jump
    mov al, r14b
    cmp rax, 0
    je continue_1

next_dig_1:
    mov al, byte[Input+r12]
    inc r12
    mov byte[check], al

continue_1:
    ; if space end of first number
    cmp byte[check], 32
    je num2

store_bit_1:
    mov rax, r9
    mul r11
    mov r9, rax
    sub byte[check], 48
    xor rax, rax
    mov al, byte[check] 
    add r9, rax
    jmp next_dig_1

;=============================================================
num2:
    mov al, byte[Input+r12]
    inc r12
    mov byte[check], al

check_neg_2:
    mov rdx, 1
    mov al, [check]
    cmp al, 45
    cmovz r15, rdx
    
    ; if negative sign jump
    cmp r15b, 0
    je continue_2

next_dig_2:
    mov al, byte[Input+r12]
    inc r12
    mov byte[check], al    

continue_2:
    ; endline
    cmp byte[check], 10
    je neg1

    ; null terminator
    cmp byte[check], 0
    je neg1

    ; some other junk
    cmp byte[check], 47
    jle neg1

    ; some other junk
    cmp byte[check], 58
    jge neg1


store_bit_2:
    mov rax, r10
    mul r11
    mov r10, rax
    sub byte[check], 48
    xor rax, rax
    mov al, byte[check] 
    add r10, rax
    jmp next_dig_2

; both bits and signs received
neg1:
    mov al, r14b
    cmp al, 1
    jnz neg2
    neg r9 

neg2:
    mov al, r15b
    cmp al, 1
    jnz end_neg
    neg r10

    ;mov eax, r9d
    ;mov r9, rax
    ;mov eax, r10d
    ;mov r10, rax

end_neg

;===========================================================

; r8 check space
; r9 multiplicand (alpha)
; r10 multiplier (beta)
; r11 "m"
; r12 "n" 
; r13 "-alpha / alpha" to print / n in reverse
; r14 compare / printer / rev
; r15 counter

xor r8, r8
xor r11, r11
xor r12, r12
xor r13, r13
xor r14, r14
xor r15, r15
xor rax, rax

algor:
    mov r12, r10
    mov rax, 1
    and r12, rax

;====================================================== 
if:
    cmp r12, 1
    jnz elif
    cmp r11, 0
    jnz elif

    ; -alpha
    mov r13, r9
    neg r13

    xor r14, r14
    jmp reverse
    
elif:
    cmp r12, 0
    jnz operations
    cmp r11, 1
    jnz operations

    ; normal alpha
    mov r13, r9
    jmp reverse

;===============================Print========================
reverse:

    cmp r13d, 0
    jz operations

    xor r14, r14
    mov eax, r13d
    mov r13d, eax
    xor r15, r15

while:
    inc r15
    shl r14, 1

    mov rax, r13
    and rax, 1
    cmp rax, 1
    jnz after
    xor r14, 1

after:
    shr r13, 1

    cmp r13, 0
    jnz while
    cmp r15, 32
    jnz while    

    xor r15, r15

first_space:
    cmp r8, 0
    jz print

    ; space
    mov byte[Input], 32
    mov rax, 1
	mov rdi, 1
	mov rsi, Input
	mov rdx, 1
	syscall


print: 
    inc r8
    inc r15
    shr r14, 1
    setc al

    ; print bit string
    mov byte[Input], al
    add byte[Input], 48
    mov rax, 1
	mov rdi, 1
	mov rsi, Input
	mov rdx, 1
	syscall

    cmp r15, 32
    jnz print

;=============================end-print===============================

operations:
    shl r9, 1 ; alpha *=2
    mov r11, r12 ; m = n
    
    mov r14, r10 ; if beta >> 1 = beta
    sar r14, 1
    cmp r10, r14
    jz exit

    sar r10, 1 ; else:
    jmp algor


;===================================end===============================
exit:
	mov rax, 60
	mov rdi, 0
	syscall
