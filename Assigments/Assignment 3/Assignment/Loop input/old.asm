segment .data
    input_text_1 db "Input:"
    ten db 10
    neg_1 db 0
    neg_2 db 0

segment .bss
    Input resb 1

segment .text
	global _start

_start:

	;mov rax, 1
	;mov rdi, 1
	;mov rsi, input_text_1
	;mov rdx, 6
	;syscall

; check first sign
    mov rax, 0
	mov rdi, 0
	mov rsi, Input
	mov rdx, 1
	syscall

check_neg:
    mov al, [Input]
    mov r15, 0
    cmp al, 45
    cmovz r15, rdx
    mov byte[neg_1], r15b

    ; if negative sign jump
    mov al, [neg_1]
    cmp rax, 1
    je read_bit

    ; if not negative sign write to first number
    mov r9b, [Input]
    sub r9b, 48 

read_bit:
    mov rax, 0
	mov rdi, 0
	mov rsi, Input
	mov rdx, 1
	syscall

    ; if space end of first number
    cmp byte[Input], 32
    je num2

store_bit_1:
    mov rax, r9
    mul byte[ten]
    mov r9, rax
    sub byte[Input], 48
    add r9b, byte[Input]
    jmp read_bit

;=============================================================
num2:
    mov rax, 0
	mov rdi, 0
	mov rsi, Input
	mov rdx, 1
	syscall

check_neg_2:
    mov al, [Input]
    mov r15, 0
    cmp al, 45
    cmovz r15, rdx
    mov byte[neg_2], r15b
    
    ; if negative sign jump
    cmp byte[neg_2], 1
    je read_bit_2

    ; if not negative sign write to first number
    mov r10b, [Input]
    sub r10b, 48 

read_bit_2:
    mov rax, 0
	mov rdi, 0
	mov rsi, Input
	mov rdx, 1
	syscall

    ; if endline end of first number
    cmp byte[Input], 10
    je neg1

store_bit_2:
    mov rax, r10
    mul byte[ten]
    mov r10, rax
    sub byte[Input], 48
    add r10b, byte[Input]
    jmp read_bit_2

; both bits and signs received
neg1
    cmp byte[neg_1], 1
    jnz neg2
    neg r9 

neg2:
    cmp byte[neg_2], 1
    jnz end_neg
    neg r10

    ;mov eax, r9d
    ;mov r9, rax
    ;mov eax, r10d
    ;mov r10, rax

end_neg

;===========================================================

; r8 check space
; r9 multiplicand
; r10 multiplier
; r11 "m"
; r12 "n" 
; r13 "-alpha / alpha" to print / n in reverse
; r14 compare / printer / rev
; r15 counter

xor r8, r8
xor r11, r11
xor r12, r12
xor r13, r13

algor:
    mov r12, r10
    and r12, 1

;====================================================== 
if:
    cmp r12, 1
    jnz elif
    cmp r11, 0
    jnz elif

    mov r13, r9
    xor r14, r14
    neg r13

    jmp reverse
    
elif:
    cmp r12, 0
    jnz operations
    cmp r11, 1
    jnz operations

    mov r13, r9
    jmp reverse

;============================================================
reverse:

    cmp r13, 0
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

;=================================================================

operations:
    shl r9, 1
    mov r11, r12
    xor r14, r14
    mov r14, r10
    sar r14, 1

    cmp r10d, r14d
    jz exit

    sar r10, 1
    jmp algor

exit:
	mov rax, 60
	mov rdi, 0
	syscall
