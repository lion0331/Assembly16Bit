; ��1:����X��Y����16λ�޷�����,дһ������ʽ16*X+Yֵ�ĳ���
; ��X,YΪ16λ�޷�����,����16X+Y��ֵ
; �㷨3:�˷�
; ����ṹ:˳��ṹ
; ������:T34-1.asm
; ===================
assume cs:code, ds:data

data segment
X dw 1234h         ; ����16λ�޷�����X
Y dw 5678h         ; ����16λ�޷�����Y
Z db 12 dup('$')   ; ����12�ֽڻ������洢ʮ�����ַ�������'$'��β��
data ends

code segment
start:
    ; ��ʼ�����ݶμĴ���
    mov ax, data
    mov ds, ax

    ; ����16*X + Y
    mov ax, X        ; AX = X
    xor dx, dx       ; ����DX��DX:AX���32λ�Ĵ�����

	mov bx,16
	mul bx

    ; ����Y��ֵ
    add ax, Y        ; AX = 16*X + Y
    adc dx, 0        ; �����λ��DX:AX = ����32λ�����

    ; ��32λ���ת��Ϊʮ�����ַ���
    push ax          ; �����16λ
    push dx          ; �����16λ
    push si          ; ����Դָ��
    push bx          ; ���������Ĵ���
    push cx          ; �������

    mov cx, 10       ; ���ó���CX=10��ʮ����ת����
    lea di, Z + 10   ; ָ���ַ���������ĩβ���Ӻ���ǰ��䣩
    mov byte ptr [di + 1], '$' ; �����ַ���������

    ; ����Ƿ�Ϊ����������
    mov si, dx       ; ���ظ�16λ��SI
    or si, ax        ; �ϲ��ߵ�16λ
    jnz convert_loop ; ���������ת��ѭ��
    ; ������ֵ���
    mov byte ptr [di], '0' ; ֱ��д���ַ�'0'
    dec di           ; ����di�Ա�����������һ��
    jmp end_conversion

convert_loop:
    call div32       ; ����32λ�����ӳ���DX:AX / CX��
    add bl, '0'      ; ������ת��ΪASCII�ַ�
    mov [di], bl     ; �洢�ַ���������
    dec di           ; �ƶ�ָ�뵽ǰһ��λ��(����洢)
    ; ������Ƿ�Ϊ��
    mov si, dx       ; �����̵ĸ�16λ
    or si, ax        ; �ϲ��̵�32λ
    jnz convert_loop ; ���������ѭ��

end_conversion:
    ; �ָ��Ĵ���
    pop cx
    pop bx
    pop si
    pop dx
    pop ax

    ; ��ʾ�����DOS���ܵ��ã�
    lea dx, [di+1]   ; ��ȷ��ȡ�ַ�����ʼ��ַ
    mov ah, 9        ; ������ʾ�ַ������ܺ�
    int 21h          ; ����DOS�ж�

    ; ������ֹ
    mov ax, 4c00h    ; ������ֹ�����ܺ�
    int 21h          ; ����DOS�ж�

; 32λ����10���ӳ���DX:AX / CX����������DX:AX��������BL��
div32 proc near
    push di
    push si

    mov si, dx       ; ����ԭʼ��16λ
    mov di, ax       ; ����ԭʼ��16λ

    xor dx, dx       ; ����DX
    mov ax, si       ; AX = ��16λ
    div cx           ; ��һ�γ�����DX:AX / CX �� ��1��AX��������DX
    mov si, ax       ; ������1��SI

    mov ax, di       ; AX = ԭʼ��16λ
    ; ��ʱ DX:AX = (��һ������ << 16) + ԭʼ��16λ
    div cx           ; �ڶ��γ�����DX:AX / CX �� ��2��AX��������DX

    mov bl, dl       ; �������浽BL��DX < CX������DL���ӣ�
    mov dx, si       ; �̵ĸ�16λ���浽DX
    ; AX�Ѱ����̵ĵ�16λ���������

    pop si
    pop di
    ret
div32 endp

code ends
end start