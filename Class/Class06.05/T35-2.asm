;3.5.1��֧�������
;��������t35-2.asm
;���ܣ�ʵ��3���޷������ɴ�С����
;�㷨��3���޷����������Ƚϣ��Ƚ�3��
;����ṹ����֧�ṹ
;��������ֻʹ��1���Ĵ������бȽ�
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
	;��һ�αȽ�
	cmp al,[si+1]
	jbe next1
	xchg al,bl
	mov [si],al
next1:	;�ڶ��αȽ�
	cmp al,[si+2]
	jbe next2	
	xchg al,[si+2]
	mov [si],al
next2:	;�����αȽ�
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