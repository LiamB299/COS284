segment .data

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

    struc square
base resb shape_size
x resd 1
y resd 1
w resd 1
align 8
    endstruc

    struc rectangle
super resb square_size
h resd 1
align 8
    endstruc

rectangle_vtable resb shape_vtable_size

segment .text
    global rectangle_init
    extern malloc

rectangle_init:
    push rbp
    mov rbp, rsp

    push rdi
    push rsi 
    push rdx
    push rcx
    push r8
    push 0
    
    mov rdi, rectangle_size
    call malloc
    
    pop rdx

    pop rdx
    mov dword[rax+h], edx ; h

    pop rdx
    mov dword[rax+super+w], edx ; w

    pop rdx
    mov dword[rax+super+y], edx ; y

    pop rdx
    mov dword[rax+super+x], edx ; x

    pop rdx
    mov dword[rax+super+base+color], edx ; color

    mov dword[rax+super+base+num_children], 0 ; num children = 0 
    
    mov qword[rax+super+base+children], 0 ; children = null

    mov qword[rax+super+base+vtable], rectangle_vtable ; vtable

    leave
    ret