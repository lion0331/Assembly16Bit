;3.5.1��֧�������
;��������t35-2.asm
;���ܣ�ʵ��3���޷������ɴ�С����
;�㷨��3���޷����������Ƚϣ��Ƚ�3��
;����ṹ����֧�ṹ
;��������ֻʹ��1���Ĵ������бȽ�
;------------------------------------
assume cs:code,ds:data
data segment
buffer	db 87,234,123	;��Ҫ�����3���޷�����
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	
	mov si,offset buffer
	mov al,[si]		;al�ݴ��һ����
	
	;��һ�αȽϣ��Ƚϵ�һ�����͵ڶ�������ȷ����һ������С�ڵڶ�����
	cmp al,[si+1]
	jae next1		;��al >= [si+1]�����轻��������next1
	xchg al,[si+1]	;���򽻻�al�͵ڶ�����
	mov [si],al		;���ϴ������ص�һ��λ��
next1:	
	;�ڶ��αȽϣ��Ƚϵ�ǰ��һ�����͵���������ȷ����һ����������
	cmp al,[si+2]
	jae next2		;��al >= [si+2]�����轻��������next2
	xchg al,[si+2]	;���򽻻�al�͵�������
	mov [si],al		;����������ص�һ��λ��
next2:	
	;�����αȽϣ��Ƚϵڶ������͵���������ȷ���ڶ�������С�ڵ�������
	mov al,[si+1]	;al�ݴ�ڶ�����
	cmp al,[si+2]
	jae over		;��al >= [si+2]�����轻�����������
	xchg al,[si+2]	;���򽻻��ڶ������͵�������
	mov [si+1],al	;���ϴ������صڶ���λ��

over:	
	mov ax,4c00h	;�������������DOS
	int 21h

code ends
	end start
