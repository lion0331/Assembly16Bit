;例2：不使用乘法指令实现乘法运算
;程序名：t36-2.asm
;功能：循环加法实现乘法运算
;循环结构
;方法一算法：16位加法运算
;-----------------------------------

assume cs:code,ds:data
data segment
xxx db 255	;被乘数
yyy db 255	;乘数
zzz dw ?	;存放积
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	;
	xor ax,ax
	xor dx,dx
	;
	mov bl,xxx
	xor bh,bh
	;
	mov cl,yyy
	xor ch,ch
	;
next:
	add ax,bx
	adc dx,0
	loop next
	;
	mov zzz,ax
	;
	mov ax,4c00h
	int 21h	

code ends
	end start
