segment .data
    input_text_1 db "Input:"
    ten db 10
    neg_1 db 0
    neg_2 db 0

segment .bss
    Input resb 1
    m resd 1
    n resd 1
    alpha resd 1
    beta resd 1

segment .text
	global _start

_start:

    xor r9, r9
    xor r10, r10

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
    mov r11, 10
    mov rax, r9
    mul r11 ; mul of a byte changes the mul to only act on the byte
    mov r9, rax
    sub byte[Input], 48
    movzx rax, byte[Input]
    add r9, rax ; adding to a byte fucks the size sigh
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

    ; endline
    cmp byte[Input], 10
    je neg1

    ; null terminator
    cmp byte[Input], 0
    je neg1

    ; some other junk
    cmp byte[Input], 47
    jle neg1

    ; some other junk
    cmp byte[Input], 58
    jge neg1


store_bit_2:
    mov r11, 10
    mov rax, r10
    mul r11 ; mul of a byte changes the mul to only act on the byte
    mov r10, rax
    movzx rax, byte[Input]
    sub rax, 48
    add r10, rax ; adding to a byte fucks the size sigh
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

    mov dword[alpha], r9d
    mov dword[beta], r10d
    mov dword[n], 0
    mov dword[m], 0 

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


algor:
    xor r12, r12
    mov r12d, dword[beta]
    and r12d, 1
    mov dword[n], r12d

;====================================================== 
if:
    cmp dword[n], 1
    jnz elif
    cmp dword[m], 0
    jnz elif

    xor r13, r13
    mov r13d, dword[alpha] 
    xor r14, r14
    neg r13

    jmp reverse
    
elif:
    cmp dword[n], 0
    jnz operations
    cmp dword[m], 1
    jnz operations

    xor r13, r13
    mov r13d, dword[alpha]
    ;jmp reverse

;============================================================
reverse:

    cmp r13, 0
    jz operations

    xor r14, r14
    mov eax, r13d
    mov r13d, eax
    xor r15, r15

while:

    inc r15 ; increase counter
    shl r14, 1 ; reversed string

    mov rax, r13 ; original num
    and rax, 1 ; single out lowest bit
    cmp rax, 1 ; if one jump
    jnz after
    xor r14, 1 ; set bit 

after:
    ;mov rax, r13
    shr r13, 1 ; remove lowest bit

    ;xor rax, r13
    cmp r13, 0 ; if string not empty (fix)
    jnz while
    cmp r15, 32 ; fill with zeros (shift)
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
    shl dword[alpha], 1

    xor rax,  rax
    mov eax, dword[n]
    mov dword[m], eax

    xor r14, r14
    mov r14d, dword[beta]
    sar r14, 1

    cmp dword[beta], r14d
    jz exit

    sar dword[beta], 1
    jmp algor

exit:
	mov rax, 60
	mov rdi, 0
	syscall
