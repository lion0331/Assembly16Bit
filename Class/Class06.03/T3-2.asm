; 程序名: T3-2.asm
; 功能: 显示信息 "HELLO"（单段版）
assume cs:code   ; 仅需声明代码段

code segment
;---------- 数据定义 ----------
mess db 'HELLO',0dh,0ah,'$'  ; 字符串数据直接定义在代码段内
;------------------------------

start:
    ; 设置数据段寄存器 DS = CS（因为数据在代码段中）
    mov ax, cs
    mov ds, ax

    ; 显示字符串
    mov dx, offset mess
    mov ah, 9
    int 21h

    ; 退出程序
    mov ax, 4c00h
    int 21h

code ends
end start