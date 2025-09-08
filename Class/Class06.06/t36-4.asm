;例2：不使用乘法指令实现乘法运算
;程序名：t36-4.asm
;功能：循环加法实现乘法运算
;-----------------------------------
;方法二算法：移位运算
assume cs:code,ds:data
data segment
xxx db 234	;被乘数
yyy db 125	;乘数
zzz dw ?	;存放积
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	;
	xor dx,dx ;累加器
	mov al,xxx
	xor ah,ah
	mov bl,yyy
	;
	mov cx,8
next:
	shr bl,1
	jnc lab1
	add dx,ax
lab1:
	shl ax,1
	loop next
	;
	mov zzz,dx
	;
	mov ax,4c00h
	int 21h
	

code ends
	end start