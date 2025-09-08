;例2：写一个实现把一位十六进制数转换为对应的ASCII码的程序
;程序名：t35-3.asm
;功能：十六进制数转换为ASCII码
;算法：0～9 +30H；A~F +37H
;分支结构
;-----------------------------------------------------------
assume cs:code,ds:data
data segment
x	db 0fh
ASCII	db ?
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	;
	mov al,x
	add al,30h
	cmp al,39h
	jbe over
	add al,7h

over:
	mov ASCII,AL
	mov ax,4c00h
	int 21h

code ends
	end start