; ���ܣ���32λ�з�����ת��Ϊʮ�����ַ�������ʾ
; ���룺DX:AX = 32λ�з�����
; ���������Ļ����ʾʮ���ƽ��
; ˵��������������ת����֧��32λ��Χ(-2147483648 �� 2147483647)
.model small
.stack 100h

.data
    number_low  dw 0000h   ; ���ֵĵ�16λ
    number_high dw 8000h   ; ���ֵĸ�16λ (ʾ��ֵ��-2147483648)
    Z           db 12 dup('$') ; ���������(11λ����+��ֹ��)
    sign_flag   db 0        ; ���ű�־��0=����, 1=����

.code
main proc
    mov ax, @data         ; ��ʼ�����ݶ�
    mov ds, ax
    
    ; ����32λ����DX:AX
    mov ax, number_low
    mov dx, number_high

    ; ==== ���Ŵ��� ====
    mov sign_flag, 0       ; ��ʼ�����ű�־
    test dx, 8000h         ; ������λ(����λ)
    jz  convert_to_dec     ; ����ֱ����תת��
    
    ; ==== �������� ====
    mov sign_flag, 1       ; ���ø�����־
    not ax                 ; ��16λȡ��
    not dx                 ; ��16λȡ��
    add ax, 1              ; ��16λ��1
    adc dx, 0              ; ��16λ����λ��

convert_to_dec:
    ; ==== ׼��ת������ ====
    push ax                ; ����ԭʼֵ
    push dx
    push bx
    push cx
    push si
    push di
    
    mov cx, 10             ; ���ó���Ϊ10
    lea di, Z + 11         ; DIָ�򻺳���ĩβ(��12�ֽ�)
    mov byte ptr [di], '$' ; �����ַ�����ֹ��
    dec di                 ; DIָ�����һλ����λ��(Z+10)

convert_loop:
    call div32             ; ����32λ������DX:AX / 10
    add bl, '0'            ; ����(BL)תASCII�ַ�
    dec di                 ; ǰ�ƻ�����ָ��
    mov [di], bl           ; �洢�����ַ�(����)
    
    ; �����(DX:AX)�Ƿ�Ϊ0
    mov bx, dx
    or  bx, ax             ; �ϲ��ߵ�λ�ж�
    jnz convert_loop       ; �����������

display:
    ; ==== ���Ŵ��� ====
    cmp sign_flag, 1       ; ����Ƿ�Ϊ����
    jne positive           ; ���������������
    dec di                 ; ǰ��ָ����������λ
    mov byte ptr [di], '-' ; ��Ӹ���

positive:
    ; ==== ��ʾ��� ====
    mov dx, di             ; DX=�ַ�����ʼ��ַ
    mov ah, 09h            ; DOS��ʾ�ַ�������
    int 21h

    ; ==== �ָ��Ĵ��� ====
    pop di
    pop si
    pop cx
    pop bx
    pop dx
    pop ax

    ; ==== �˳����� ====
    mov ax, 4c00h          ; DOS�˳�������
    int 21h

; ==============================================
; 32λ�����ӳ���
; ���ܣ�DX:AX / CX �� ��(DX:AX), ����(BL)
; �㷨�������γ�������32λֵ
; ע�⣺������BX�Ĵ������ɵ����߹���
; ==============================================
div32 proc near
    push si
    push di
    
    ; ����ԭʼֵ
    mov si, dx        ; SI = ԭʼ��16λ
    mov di, ax        ; DI = ԭʼ��16λ
    
    ; ==== ��һ���������16λ ====
    xor dx, dx        ; ����DX(��չΪ32λ����)
    mov ax, si        ; AX = ��16λ
    div cx            ; DX:AX / CX �� AX(�̸�λ), DX(����)
    mov si, ax        ; SI = �̵ĸ�λ
    
    ; ==== �ڶ����������16λ ====
    mov ax, di        ; AX = ��16λ
    ; DX���Ǹ�16λ����������(��Ϊ���γ����ĸ�16λ)
    div cx            ; DX:AX / CX �� AX(�̵�λ), DX(����)
    
    ; ==== ��Ͻ�� ====
    mov bl, dl        ; BL = ����(0-9)
    mov dx, si        ; DX = �̵ĸ�λ
    
    pop di
    pop si
    ret
div32 endp

main endp
end main