;例6：设缓冲区DATA中有一组单字节有符号数，以0为结束符，写一个程序实现如下功能：
;程序名：t36-9.asm
;功能：把前5个正数依次送入缓冲区pdata,把前5个负数依次送入缓冲区mdata.如不足5个数，补0
;第一步：预设2个缓冲区
;第二步：取数据
;第三步：判断是否为0
;第四步：判断是否为正数
;第五步：判断是否为负数
;第六步：判断是否满5个数
;第七步：结束
;------------------------------------------------
;常量
max_c=5
assume cs:code,ds:dasg
dasg segment
data db 3,-4,5,6,-7,8,-9,-10,-1,-32,-123,27,58,44,-12,0
pdata db max_c dup(?)	;存储正数
mdata db max_c  dup(?)	;存放负数
dasg ends
code segment 
start:
	mov ax,dasg
	mov ds,ax
	;
	mov si,offset pdata
	mov di,offset mdata
	mov cx,5
next1:
	mov byte ptr ds:[si],0
	mov byte ptr ds:[di],0
	inc si
	inc di
	loop next1
	;
	mov bx,offset data
	xor si,si
	xor di,di
next2:
	mov al,[bx]
	cmp al,0
	jz over
	;
	cmp al,0
	jg plus
	;负数处理
	cmp di,max_c
	jae cont
	mov mdata[di],al
	inc di
	jmp cont
	
plus:	;正数处理
	cmp si,max_c
	jae cont
	mov pdata[si],al
	inc si

cont:	;判断是否都存满
	mov ax,si
	add ax,di
	cmp ax,max_c+max_c
	jz over
	inc bx
	jmp next2

over:	mov ax,4c00h
	int 21h

code ends
	end start