;��4����X��һ��1��10֮���������дһ������Y=LG(X)ֵ�ĳ���
;��������t34-7.asm
;���ܣ���1��10�Ķ���ֵ����10Ϊ�׵Ķ�����0��1֮�䣬Ϊ�˱�ʾ����Ϳ��Ǿ��ȣ�����ֵ�Ŵ�10000����
;
;-----------------------------------------------------------
assume cs:code,ds:data
data segment
value	db 4	;����X��ֵ
answer	dw ?	;���X�Ķ���
tab	dw 0,3010,4771,6021,6990,7782,8451,9031,9542,10000	;������
data ends
code segment
start:

    mov ax, data
    mov ds, ax          ; �������ݶμĴ���
    
    ; �������
    mov bl, value
    and bl, 0fh         ; ȷ��ֵ��1-10��Χ��
    xor bh, bh
    dec bx              ; ������������0��ʼ��
    add bx, bx          ; ��������2��ÿ��Ԫ�����֣�
    mov ax, tab[bx]     ; ��ȡ����ֵ
    mov answer, ax      ; �洢���
    
    ; ��ʾanswer��ֵ
    mov ax, answer      ; ����Ҫ��ʾ��ֵ
    mov cx, 10          ; ����
    mov bx, 0           ; ���ּ�����
    
    ; �������������0
    test ax, ax
    jnz convert
    mov dl, '0'         ; �����0��ֱ����ʾ'0'
    mov ah, 02h
    int 21h
    jmp end_display
    
convert:
    ; �ֽ����֣������λ��ʼ��
    xor dx, dx
    div cx              ; DX:AX / CX �� ����AX��������DX
    push dx             ; ������������ǰ���֣�
    inc bx              ; �������ּ���
    test ax, ax         ; ������Ƿ�Ϊ0
    jnz convert
    
display:
    ; ��ʾ���֣������λ�����λ��
    pop dx              ; ȡ������
    add dl, '0'         ; ת��ΪASCII
    mov ah, 02h         ; DOS�ַ��������
    int 21h
    dec bx              ; �������ּ���
    jnz display         ; ����ֱ������������ʾ���
    
end_display:
    ; ������ֹ
    mov ax, 4c00h
    int 21h

code ends
	end start