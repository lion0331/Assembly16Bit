;例1:假设X和Y都是16位无符号数,写一个求表达式16*X+Y值的程序
;设X,Y为16位无符号数,计算16X+Y的值
;算法1:加法
;程序结构:顺序结构
;程序名:T34-1.asm
;===================
assume cs:code,ds:data

data segment
X dw 1234h
Y dw 5678h
Z db 12 dup('$') ; 分配12个字节的空间用于存储字符串，以'$'结尾
data ends

code segment
start:
	mov ax,data
	mov ds,ax

	mov ax,X
	xor dx,dx;结果保存到DX:AX
	;加法运算16*X
	add ax,ax
	adc dx,0
	add ax,ax
	adc dx,0
	add ax,ax
	adc dx,0
	add ax,ax
	adc dx,0
	;16*X+Y
	add ax,Y
	adc dx,0

	;调用函数将DX:AX转换为字符串，并存储于Z
	call to_str
	;显示结果
	mov dx,offset Z
	mov ah,9
	int 21h
	
	mov ax,4c00h
	int 21h

	;将DX:AX中的32位无符号整数转换为字符串
to_str proc
	push cx
	push bx
	push si

	mov si, offset Z + 11 ; 指向Z倒数第二个位置
	mov cx, 0 ; 计数器，记录有效字符数量
	mov bx, 10
convert_loop:
	xor dx, dx ; 清零DX以进行除法操作
	div bx ; AX / BX -> 商在AX, 余数在DX
	add dl, '0' ; 将余数转为ASCII字符
	mov [si], dl ; 存储ASCII字符到Z
	dec si
	inc cx
	or ax, ax ; 检查商是否为0
	jnz convert_loop ; 如果不为0，继续循环

	; 处理DX中的高位部分
high_part_loop:
	test dx, dx ; 检查DX是否为0
	jz end_convert
	xor ax, ax ; 清零AX
	mov ax, dx ; 将DX移到AX以便进行除法操作
	xor dx, dx ; 清零DX以进行除法操作
	div bx ; AX / BX -> 商在AX, 余数在DX
	add dl, '0' ; 将余数转为ASCII字符
	mov [si], dl ; 存储ASCII字符到Z
	dec si
	inc cx
	jmp high_part_loop ; 继续处理DX中的高位部分

end_convert:
	; 移动SI指针到字符串开头
	add si, cx
	; 将SI指向的第一个字符之前的空闲位置填充为'$'
	cld
	mov al, '$'
	repne scasb
	mov byte ptr [di-1], '$'

	pop si
	pop bx
	pop cx
	ret
to_str endp

code ends
	end start