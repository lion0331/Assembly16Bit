; Ŀ�꣺�����ظ��ĴμĴ���AL�е�ÿһλ���õ�32λ�Ľ�����DX:AX�Ĵ�����
.model small
.stack 100h

.data
hexChars db '0123456789ABCDEF'  ; ʮ�������ַ���

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ��AL��ÿһλ�ظ��ĴΣ��������DX:AX
    xor ax, ax         ; ���AX����16λ��
    xor dx, dx         ; ���DX����16λ��

    ; ʾ������ֵ�����޸Ĳ��ԣ�
    mov al, 0FFh       ; AL = 255 (������11111111)

    mov cx, 8          ; ѭ����������8λ��
    mov bl, al         ; ����AL��BL

process_bits:
    ; ��DX:AX����4λ��32λ���ƣ�
    shl ax, 1
    rcl dx, 1
    shl ax, 1
    rcl dx, 1
    shl ax, 1
    rcl dx, 1
    shl ax, 1
    rcl dx, 1
    
    ; ��ȡ��ǰ���λ
    shl bl, 1          ; ���λ����CF
    jnc skip_set        ; ���Ϊ0����������
    
    ; ���õ�ǰ���4λΪ1111
    or al, 0Fh         ; ����AL�ĵ�4λ (�ؼ��޸�)

skip_set:
    loop process_bits   ; ������һλ

    ; ��ʾDX:AX��ʮ������ֵ
    call print_hex

    ; �˳�����
    mov ax, 4C00h
    int 21h
main endp

print_hex proc
    push bx
    push cx
    push dx
    push si
    push ax           ; ����ԭʼ AX����16λ��

    mov bx, offset hexChars  ; ָ��ʮ�������ַ���

    ; === �����16λ��DX��===
    mov si, dx        ; SI = ��16λ

    ; ����1�����4λ��DX[15:12]��
    mov ax, si
    mov cl, 12
    shr ax, cl
    and al, 0Fh
    xlat              ; AL = [BX+AL]
    mov dl, al
    mov ah, 02h
    int 21h           ; ����ַ�

    ; ����2��DX[11:8]��
    mov ax, si
    mov cl, 8
    shr ax, cl
    and al, 0Fh
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; ����3��DX[7:4]��
    mov ax, si
    mov cl, 4
    shr ax, cl
    and al, 0Fh
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; ����4��DX[3:0]��
    mov ax, si
    and al, 0Fh       ; ������λ��ֱ��ȡ��4λ
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; === �����16λ��ԭʼAX��===
    pop si            ; ��ջ��ȡ��ԭʼ��16λ -> SI
    push si           ; ѹ��ջ�б���ƽ��

    ; ����5�����4λ��AX[15:12]��
    mov ax, si
    mov cl, 12
    shr ax, cl
    and al, 0Fh
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; ����6��AX[11:8]��
    mov ax, si
    mov cl, 8
    shr ax, cl
    and al, 0Fh
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; ����7��AX[7:4]��
    mov ax, si
    mov cl, 4
    shr ax, cl
    and al, 0Fh
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; ����8��AX[3:0]��
    mov ax, si
    and al, 0Fh       ; ������λ��ֱ��ȡ��4λ
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; �������
    mov dl, 0Dh
    mov ah, 02h
    int 21h
    mov dl, 0Ah
    mov ah, 02h
    int 21h

    ; �ָ��Ĵ���
    pop ax
    pop si
    pop dx
    pop cx
    pop bx
    ret
print_hex endp

end main