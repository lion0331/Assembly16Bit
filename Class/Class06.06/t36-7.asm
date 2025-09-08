;例4：把一个字符串的所有大写字母改成小写字母的程序。字符串以0结尾。
;程序名：t36-7.asm
;功能：字符串大写字母转换
;分析：第5位置1转换小写字母，
;非字母不需要转换，大写字母
;-------------------------------------------------------
;方法二，先执行再判断
assume cs:code,ds:data
data segment
string	db 'HOW are yoU !',0,24h
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	;
	mov si,offset string
	;
next:
	mov al,[si]
	inc si
	cmp al,'A'
	jb lab1
	cmp al,'Z'
	ja lab1
	add al,20h
	mov [si-1],al
lab1:
	cmp al,0
	jz ok
	jmp next
ok:
	mov dx,offset string
	mov ah,9
	int 21h	
	;
	mov ax,4c00h
	int 21h

code ends
	end start