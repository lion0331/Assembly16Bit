;��1:����X��Y����16λ�޷�����,дһ������ʽ16*X+Yֵ�ĳ���
;��X,YΪ16λ�޷�����,����16X+Y��ֵ
;�㷨1:�ӷ�
;����ṹ:˳��ṹ
;������:T34-1.asm
;===================
assume cs:code,ds:data

data segment
X dw 1234h
Y dw 5678h
Z db 12 dup('$') ; ����12���ֽڵĿռ����ڴ洢�ַ�������'$'��β
data ends

code segment
start:
	mov ax,data
	mov ds,ax

	mov ax,X
	xor dx,dx;������浽DX:AX
	;�ӷ�����16*X
	add ax,ax
	adc dx,0
	add ax,ax
	adc dx,0
	add ax,ax
	adc dx,0
	add ax,ax
	adc dx,0
	;16*X+Y
	add ax,Y
	adc dx,0

	;���ú�����DX:AXת��Ϊ�ַ��������洢��Z
	call to_str
	;��ʾ���
	mov dx,offset Z
	mov ah,9
	int 21h
	
	mov ax,4c00h
	int 21h

	;��DX:AX�е�32λ�޷�������ת��Ϊ�ַ���
to_str proc
	push cx
	push bx
	push si

	mov si, offset Z + 11 ; ָ��Z�����ڶ���λ��
	mov cx, 0 ; ����������¼��Ч�ַ�����
	mov bx, 10
convert_loop:
	xor dx, dx ; ����DX�Խ��г�������
	div bx ; AX / BX -> ����AX, ������DX
	add dl, '0' ; ������תΪASCII�ַ�
	mov [si], dl ; �洢ASCII�ַ���Z
	dec si
	inc cx
	or ax, ax ; ������Ƿ�Ϊ0
	jnz convert_loop ; �����Ϊ0������ѭ��

	; ����DX�еĸ�λ����
high_part_loop:
	test dx, dx ; ���DX�Ƿ�Ϊ0
	jz end_convert
	xor ax, ax ; ����AX
	mov ax, dx ; ��DX�Ƶ�AX�Ա���г�������
	xor dx, dx ; ����DX�Խ��г�������
	div bx ; AX / BX -> ����AX, ������DX
	add dl, '0' ; ������תΪASCII�ַ�
	mov [si], dl ; �洢ASCII�ַ���Z
	dec si
	inc cx
	jmp high_part_loop ; ��������DX�еĸ�λ����

end_convert:
	; �ƶ�SIָ�뵽�ַ�����ͷ
	add si, cx
	; ��SIָ��ĵ�һ���ַ�֮ǰ�Ŀ���λ�����Ϊ'$'
	cld
	mov al, '$'
	repne scasb
	mov byte ptr [di-1], '$'

	pop si
	pop bx
	pop cx
	ret
to_str endp

code ends
	end start