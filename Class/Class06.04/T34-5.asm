;例3 16进制数字码转换为对应的七段代码的程序
;程序名：t34-5.asm
;功能：16进制数字码到七段代码的转换
;方法一：查表法
;顺序结构
;------------------------------------------------

assume cs:code,ds:data
data segment
tab		db 1000000b,1111001b,0100100b,0110000b  ; 0,1,2,3
		db 0011001b,0010010b,0000010b,1111000b  ; 4,5,6,7
		db 0000000b,0010000b,0001000b,0000011b  ; 8,9,A,B
		db 1000110b,0100001b,0000110b,0001110b  ; C,D,E,F
xcode	db 8	;待转换的16进制的数字码（0-F）
ycode	db ?	;存放对应的七段代码
data ends
code segment
start:
	mov ax,data
	mov ds,ax       ; 初始化数据段寄存器
	
	mov bl,xcode    ; 取待转换的16进制数
	and bl,0fh      ; 确保只取低4位（限制在0-15范围）
	xor bh,bh       ; 高8位清0，形成完整的16位偏移地址
	
	mov al,tab[bx]  ; 查表获取对应的七段码
	mov ycode,al    ; 保存转换结果
	
	mov ax,4c00h    ; 程序结束，返回DOS
	int 21h

code ends
	end start
