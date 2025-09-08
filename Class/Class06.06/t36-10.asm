;例7设buffer缓冲区中有10个单字节无符号数整数，写一个程序将它们由小到大排序
;二重循环，简单选择法
;si为外层循环控制变量i，di为内层循环控制变量j，因为i从1开始循环9次
;所以buffer地址减一，[bx+si]取第一个数
;程序名t36-10.asm
;算法：简单选择法
;----------------------------------------------------
assume cs:code,ds:data
data segment
buffer	db 23,12,45,32,127,3,9,58,81,72		;假设10个数据
n	equ 10					;定义符号n为常数10
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	;
	mov bx,offset buffer -1
	mov si,1
fori:	
	mov di,si
	inc di
forj:	;
	mov al,[bx+si]
	cmp al,[bx+di]
	jbe nextj
	xchg al,[bx+di]
	mov [bx+si],al	;保存
	
	
nextj:	;不需要交换
	inc di
	cmp di,n
	jbe forj
	;
nexti:
	inc si
	cmp si,n-1
	jbe fori

over:	mov ax,4c00h
	int 21h

code ends
	end start
