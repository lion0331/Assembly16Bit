;��3дһ��16����������ת��Ϊ��Ӧ���߶δ���ĳ���
;��������t34-5.asm
;���ܣ�16���������뵽�߶δ����ת��
;����һ�����
;˳��ṹ
;------------------------------------------------

assume cs:code,ds:data
data segment
tab		db 1000000b,1111001b,0100100b,0110000b
		db 0011001b,0010010b,0000010b,1111000b
		db 0000000b,0010000b,0001000b,0000011b
		db 1000110b,0100001b,0001110b,0001110b
xcode	db 8	;��ת����16���Ƶ�������
ycode	db ?	;��Ŷ�Ӧ���߶δ���
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	;
	mov bl,xcode
	and bl,0fh
	xor bh,bh
	;
	mov al,tab[bx]
	mov ycode,al
	;
	mov ax,4c00h
	int 21h

code ends
	end start