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

struc ellipse
base resb shape_size
x resd 1
y resd 1
w resd 1
h resd 1
    endstruc  

    struc circle
super resb ellipse_size
    endstruc

circle_vtable resb shape_vtable_size

    segment .text
    global circle_init
    extern malloc

circle_init:
    push rbp
    mov rbp, rsp

    push rdi
    push rsi
    push rdx
    push rcx

    mov rdi, circle_size
    call malloc

    pop rdx
    mov dword[rax+super+w], edx
    mov dword[rax+super+h], edx

    pop rdx
    mov dword[rax+super+y], edx

    pop rdx
    mov dword[rax+super+x], edx 

    pop rdx
    mov dword[rax+super+base+color], edx

    mov qword[rax+super+base+children], 0

    mov dword[rax+super+base+num_children], 0

    mov qword[rax+super+base+vtable], circle_vtable

    leave
    ret