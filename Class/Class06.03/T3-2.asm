; ������: T3-2.asm
; ����: ��ʾ��Ϣ "HELLO"�����ΰ棩
assume cs:code   ; �������������

code segment
;---------- ���ݶ��� ----------
mess db 'HELLO',0dh,0ah,'$'  ; �ַ�������ֱ�Ӷ����ڴ������
;------------------------------

start:
    ; �������ݶμĴ��� DS = CS����Ϊ�����ڴ�����У�
    mov ax, cs
    mov ds, ax

    ; ��ʾ�ַ���
    mov dx, offset mess
    mov ah, 9
    int 21h

    ; �˳�����
    mov ax, 4c00h
    int 21h

code ends
end start