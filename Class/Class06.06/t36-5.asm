;例3：把16位二进制数转换为5位十进制数，为了简单，设二进制数为无符号数
;采用8421BCD码表示十进制数
;程序名：t36-5.asm
;算法：5位十进制，16位二进制数依次除以10000，1000，100，10，1；商为十进制数高-低位，余数接着做除法运算
;-----------------------------------------
assume cs:code,ds:data
data segment
ej	dw 23456	;16位二进制数
buffer	db 5 dup(0),0dh,0ah,24h	;存放十进制数
jm	dw 10000,1000,100,10,1	;5个除数
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	;
	mov si,offset buffer
	mov di,offset jm
	;
	mov ax,ej
	xor dx,dx

	;
	mov cx,5
next:
	mov bx,	[di]

	div bx
	add al,30h
	mov [si],al

	;
	mov ax,dx	;dx是余数
	xor dx,dx
	inc di
	inc di	
	inc si	
	loop next
	;
	mov dx,offset buffer
	mov ah,9
	int 21h
	
	;
	mov ax,4c00h
	int 21h

code ends
	end start