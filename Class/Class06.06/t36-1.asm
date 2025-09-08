;例1求内存中从地址0040：0000H开始的1024个字的字检验和
;字检验和:按字节或字累计的和,通常用于传输数据的校验
;程序名:t36-1.asm
;循环结构
;存储器指针SI，和计数器CX
;-----------------------------------------
assume cs:code,ds:data

data segment
sum dw ?
data ends

code segment
start:
	mov ax,0040h
	mov ds,ax
	;
	mov si,0
	xor ax,ax	;16位累加器
	mov cx,1024
next:
	add ax,word ptr ds:[si]
	inc si
	inc si
	;add si,2
	loop next
	;
	mov bx,data
	mov ds,bx
	mov sum,ax

	;
	mov ax,4c00h
	int 21h

code ends
	end start

