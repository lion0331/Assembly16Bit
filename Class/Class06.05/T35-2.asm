;3.5.1分支程序举例
;程序名：t35-2.asm
;功能：实现3个无符号数由大到小排序
;算法：3个无符号数两两比较，比较3次
;程序结构：分支结构
;方法二：只使用1个寄存器进行比较
;------------------------------------
assume cs:code,ds:data
data segment
buffer	db 87,234,123
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	;
	mov si,offset buffer
	mov al,[si]
	;第一次比较
	cmp al,[si+1]
	jbe next1
	xchg al,bl
	mov [si],al
next1:	;第二次比较
	cmp al,[si+2]
	jbe next2	
	xchg al,[si+2]
	mov [si],al
next2:	;第三次比较
	mov al,[si+1]
	cmp al,[si+2]
	jbe over
	xchg al,[si+2]
	mov [si+1],al

over:	;
	mov ax,4c00h
	int 21h

code ends
	end start