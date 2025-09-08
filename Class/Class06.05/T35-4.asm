;例3：写一个实现把一位16进制数所对应的ASCII码转换为16进制数的程序，如果没有对应数，则转换为-1
;程序名：t35-4.asm
;分支结构
;功能：ASCII码转换为16进制数
;分析：假设AL=ASCII码，X为转换后的16进制数，分为7种情况，
;AL<'0'为X=-1
;‘0’<=AL<='9',X=AL-'0'
;'9'<=AL<='A',X=-1
;'A'<AL<'F'， X=AL-('A'-10 )= AL - 37H
;'F'<AL<'a',x=-1
;'a'<=AL<='f' x=AL-('a'-10) = AL - 57H
;AL>'f',x=-1
;-------------------------------------------------------------
assume cs:code,ds:data
data segment
x	db ?
ASCII	db 'a'
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	;
	mov al,ASCII
	mov ah,al
	sub ah,30h
	cmp al,'0'
	jb lab1
	cmp al,'9'
	jbe lab2
	;
	mov ah,al
	sub ah,37h
	cmp al,'A'
	jb lab1
	;
	cmp al,'F'
	jbe lab2
	;
	mov ah,al
	sub ah,57h
	cmp al,'a'
	jb lab1
	;
	cmp al,'f'
	jbe lab2
		
lab1:
	mov x,-1
	jmp over
	
lab2:
	mov x,ah	

over:	;
	
	mov ax,4c00h
	int 21h

code ends
	end start