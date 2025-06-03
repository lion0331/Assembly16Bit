;例3写一个16进制数字码转换为对应的七段代码的程序
;程序名：t34-5.asm
;功能：16进制数字码到七段代码的转换
;方法一：查表法
;顺序结构
;------------------------------------------------

assume cs:code,ds:data
data segment
tab		db 1000000b,1111001b,0100100b,0110000b
		db 0011001b,0010010b,0000010b,1111000b
		db 0000000b,0010000b,0001000b,0000011b
		db 1000110b,0100001b,0001110b,0001110b
xcode	db 8	;待转换的16进制的数字码
ycode	db ?	;存放对应的七段代码
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	;
	mov bl,xcode
	and bl,0fh
	xor bh,bh
	;
	mov al,tab[bx]
	mov ycode,al
	;
	mov ax,4c00h
	int 21h

code ends
	end start