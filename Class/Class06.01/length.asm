;程序名:length.asm
;显示dup值
assume cs:code,ds:data

data segment
message	db 1,10 dup('A'),0dh,0ah,24h
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	
	mov dx,offset message
	mov ah,9
	int 21h
	
	mov ax,length message
	mov bx,size message
	mov cx,type message
	mov dx,seg message

	mov ax,4c00h
	int 21h
code ends
end start