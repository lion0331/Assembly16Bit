; ��������t34-4.asm
; ���ܣ���ѹ��BCD��ת��Ϊ��Ӧ��ʮ��������ASCII��
; �㷨��BCD����Ϊ��4λ�͵�4λ���ֱ��30h�õ�ASCII��
; ����ṹ��˳��ṹ
;-------------------------
assume cs:code, ds:data
data segment
    BCD     DB 86H        ; ѹ��BCD�루86H��ʾʮ����86��
    ASCII   DB 2 DUP(?), '$' ; �洢ת�����ASCII�룬��$��β
data ends

code segment
start:
    mov ax, data
    mov ds, ax           ; �������ݶμĴ���

    ; �����4λ����λ��
    mov al, BCD          ; ����BCD��
    and al, 0Fh          ; ȡ��4λ����λ��
    add al, 30h          ; ת��ΪASCII��
    mov ASCII+1, al      ; �洢��λASCII�뵽�ڶ����ֽ�

    ; �����4λ��ʮλ��
    mov al, BCD          ; ���¼���BCD��
    mov cl, 4
    shr al, cl           ; ����4λ������4λ������4λ
    add al, 30h          ; ת��ΪASCII��
    mov ASCII, al        ; �洢ʮλASCII�뵽��һ���ֽ�

    ; ��ʾ�����DOS���ܵ��ã�
    mov dx, offset ASCII ; DXָ��ASCII�ַ���
    mov ah, 9            ; ���ܺ�9����ʾ�ַ���
    int 21h

    ; ������ֹ
    mov ax, 4c00h        ; ���ܺ�4Ch���˳�����
    int 21h
code ends
end start