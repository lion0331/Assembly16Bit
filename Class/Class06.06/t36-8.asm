;例5：写一个程序判定从地址0040：0000H开始的2048个内存字节单元中是否有字符'A'.如有则把
;第一个（按地址由小到大为序）含此指定字符的存储单元的地址偏移送到0000：03FEH单元，如果
;没有则把特征值0FFFFH送上述指定单元。
;程序名：t36-8.asm
;功能：由计数和条件双重控制的循环
;-----------------------------------------------------
;常量定义
segaddr=40h	;开始地址段值
offaddr=0	;开始地址偏移
count=2048	;长度计数
keychar='A'	;指定字符
segresu=0	;结果保存单元段值
offresu=3feh ;结果保存单元偏移

assume cs:code 

code segment
start:
	mov ax,segaddr
	mov ds,ax
	mov si,offaddr
	;
	mov cx,count
next:
	mov al,[si]
	cmp al,'A'
	jz lab
	inc si
	loop next
	mov si,0ffffh
	
lab:
	mov bx,segresu
	mov ds,bx
	;
	mov di,offresu
	mov [di],si

over:
	mov ax,4c00h
	int 21h

code ends
	end start