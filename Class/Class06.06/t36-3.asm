;例2：不使用乘法指令实现乘法运算
;程序名：t36-3.asm
;功能：循环加法实现乘法运算
;循环结构
;方法二算法：8位加法运算
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
	;累加器为ax
	mov al,0
	xor ah,ah	;cf=0
	;乘数
	mov bl,xxx
	;计数器
	mov cl,yyy
	xor ch,ch
	;
next:
	add al,bl
	adc ah,0
	loop next
	;
	mov zzz,ax
	;
	mov ax,4c00h
	int 21h

code ends
	end start
