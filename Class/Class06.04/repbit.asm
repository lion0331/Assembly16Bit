; Ŀ�꣺�� AL �е�ÿһλ�ظ�һ�Σ�������� DX
.model small
.stack 100h

.data
hexChars db '0123456789ABCDEF'  ; ʮ�������ַ���

.code
main proc
    mov ax, @data
    mov ds, ax

    ; ʾ������ֵ�����޸Ĳ��ԣ�
    mov al, 0FFh       ; AL = 255 (������11111111)

    ; �ظ�AL��ÿһλ�õ�16λ�������DX
    xor dx, dx         ; ��ʼ��DXΪ0
    mov cx, 8          ; ����8λ
    
ProcessBits:
    ; ����DXΪ�µ���λ�ڳ��ռ�
    shl dx, 1
    shl dx, 1          ; �൱������2λ
    
    ; ��ȡAL�ĵ�ǰ���λ
    shl al, 1          ; ����AL�����λ����CF
    sbb bl, bl         ; ���CF=1����BL=FFh�����CF=0����BL=0
    and bl, 3          ; BL=00 �� 03
    neg bl             ; BL=00 �� FDh
    sbb bl, 0FDh       ; BL=00 �� 03? ����Ϊ00��03
    
    ; ���õķ�����ʹ��CFֱ�ӹ�����λ
    rcr bl, 1          ; ��CF����BL�����λ
    rcr bl, 1          ; �ٴ����룬�γ���λ
    and bl, 3          ; ȷ��ֻ�е���λ
    
    ; ���µ���λ����DX�����2λ
    or  dl, bl
    
    loop ProcessBits   ; ��������8λ

    ; ��ʾDX��ʮ������ֵ
    call print_hex

    ; �˳�����
    mov ax, 4C00h
    int 21h
main endp

; ��ʾDX�Ĵ���ʮ������ֵ���ӳ���
print_hex proc
    push cx
    push bx
    push ax
    push dx
    
    mov bx, offset hexChars
    
    ; ����ԭʼֵ
    push dx
    
    ; �������4λ������12λ��
    mov cl, 12         ; ������λλ��Ϊ12
    pop dx             ; ��ȡԭʼֵ
    push dx            ; ���±���
    shr dx, cl         ; ����12λ
    mov al, dl         ; ʹ����λ���ֵ
    and al, 0Fh        ; ȡ��4λ
    xlat               ; AL = [BX + AL]
    mov dl, al
    mov ah, 02h
    int 21h
    
    ; ����θ�4λ������8λ��
    mov cl, 8          ; ������λλ��Ϊ8
    pop dx             ; ��ȡԭʼֵ
    push dx            ; ���±���
    shr dx, cl         ; ����8λ
    mov al, dl         ; ʹ����λ���ֵ
    and al, 0Fh        ; ȡ��4λ
    xlat               ; AL = [BX + AL]
    mov dl, al
    mov ah, 02h
    int 21h
    
    ; ����ε�4λ������4λ��
    mov cl, 4          ; ������λλ��Ϊ4
    pop dx             ; ��ȡԭʼֵ
    push dx            ; ���±���
    shr dx, cl         ; ����4λ
    mov al, dl         ; ʹ����λ���ֵ
    and al, 0Fh        ; ȡ��4λ
    xlat               ; AL = [BX + AL]
    mov dl, al
    mov ah, 02h
    int 21h
    
    ; �������4λ������λ��
    pop dx             ; ��ȡԭʼֵ
    mov al, dl         ; ʹ��ԭʼֵ�ĵ��ֽ�
    and al, 0Fh        ; ȡ��4λ
    xlat               ; AL = [BX + AL]
    mov dl, al
    mov ah, 02h
    int 21h
    
    ; ��ӻ���
    mov dl, 0Dh
    mov ah, 02h
    int 21h
    mov dl, 0Ah
    mov ah, 02h
    int 21h

    pop dx
    pop ax
    pop bx
    pop cx
    ret
print_hex endp

end main