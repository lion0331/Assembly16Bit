;程序名:jmp.asm
;转移指令
;JMP 无条件转移
assume cs:code

code segment
start:
    mov ax,0
    mov bx,0
    jmp short s
    add ax,1
S:
    inc ax

	mov ax,4c00h
	int 21h
code ends
end start
