;��2��дһ��ʵ�ְ�һλʮ��������ת��Ϊ��Ӧ��ASCII��ĳ���
;��������t35-3.asm
;���ܣ�ʮ��������ת��ΪASCII��
;�㷨��0��9 +30H��A~F +37H
;��֧�ṹ
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