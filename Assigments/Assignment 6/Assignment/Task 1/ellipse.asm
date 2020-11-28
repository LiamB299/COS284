    section .data

    struc canvas
data resq 1
width resd 1
height resd 1
    endstruc

    struc shape_vtable
svt_add resq 1
svt_draw resq 1
    endstruc

    struc shape
vtable resq 1
children resq 1
num_children resd 1
color resd 1
    endstruc

    struc ellipse
base resb shape_size
x resd 1
y resd 1
w resd 1
h resd 1
    endstruc  

ellipse_vtable resb shape_vtable_size
; align 8  

    section .text
    global ellipse_init
    extern malloc

ellipse_init:
    push rbp
    mov rbp, rsp

    push rdi
    push rsi
    push rdx
    push rcx
    push r8
    push 0

    mov rdi, ellipse_size
    call malloc

    pop rdx

    pop rdx
    mov dword[rax+h], edx

    pop rdx
    mov dword[rax+w], edx

    pop rdx
    mov dword[rax+y], edx

    pop rdx
    mov dword[rax+x], edx

    pop rdx
    mov dword[rax+base+color], edx

    mov dword[rax+base+num_children], 0

    mov qword[rax+base+children], 0

    mov qword[rax+base+vtable], ellipse_vtable

    leave
    ret