;程序名:T3-1.asm
;显示信息"HELLO"
assume cs:code,ds:data,ss:sseg
sseg segment
	dw 256 dup(?)
sseg ends
data segment
mess	db 'HELLO',0dh,0ah,24h
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	
	mov dx,offset mess
	mov ah,9
	int 21h

	mov ax,4c00h
	int 21h
code ends
end start