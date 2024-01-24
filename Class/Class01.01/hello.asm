;程序名 显示一个字符串
;hello.asm
;===================
assume cs:code,ds:data

data segment
message db 'hello welcome to masm16 see Saga',0dh,0ah,24h
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	
	mov dx,offset message
	mov ah,9
	int 21h
	
	mov ax,4c00h
	int 21h
code ends
end start