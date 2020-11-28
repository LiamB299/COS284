    segment .data
hello: db "18015001 is my student number.",0x0a
    segment .text
    global _start
_start:
    mov eax,1
    mov edi,1
    mov edx, 30 ; The number of characters
    lea rsi,[hello]
    syscall
    mov eax,60
    xor edi, edi
    syscall
