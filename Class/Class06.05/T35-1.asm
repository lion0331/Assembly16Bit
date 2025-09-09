;3.5.1分支程序举例
;程序名：t35-1.asm
;功能：实现3个无符号数由大到小排序
;算法：3个无符号数两两比较，比较3次
;程序结构：分支结构
;方法一：使用3个寄存器进行比较
;------------------------------------
assume cs:code,ds:data
data segment
buffer	db 87,234,123
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	;取数据
	mov si,offset buffer
	mov al,[si]
	mov bl,[si+1]
	mov cl,[si+2]
	;第一次比较
	cmp al,bl
	jae next1
	xchg al,bl

next1:	;第二次比较
	cmp al,cl
	jae next2
	xchg al,cl

next2:	;第三次比较
	cmp bl,cl
	jae next3
	xchg bl,cl
	
next3:	;保存结果
	mov [si],al
	mov [si+1],bl	
	mov [si+2],cl
over:	;
	mov ax,4c00h
	int 21h

code ends
	end start