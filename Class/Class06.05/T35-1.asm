;3.5.1��֧�������
;��������t35-1.asm
;���ܣ�ʵ��3���޷������ɴ�С����
;�㷨��3���޷����������Ƚϣ��Ƚ�3��
;����ṹ����֧�ṹ
;����һ��ʹ��3���Ĵ������бȽ�
;------------------------------------
assume cs:code,ds:data
data segment
buffer	db 87,234,123
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	;ȡ����
	mov si,offset buffer
	mov al,[si]
	mov bl,[si+1]
	mov cl,[si+2]
	;��һ�αȽ�
	cmp al,bl
	jae next1
	xchg al,bl

next1:	;�ڶ��αȽ�
	cmp al,cl
	jae next2
	xchg al,cl

next2:	;�����αȽ�
	cmp bl,cl
	jae next3
	xchg bl,cl
	
next3:	;������
	mov [si],al
	mov [si+1],bl	
	mov [si+2],cl
over:	;
	mov ax,4c00h
	int 21h

code ends
	end start