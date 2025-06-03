; 程序名：t34-4.asm
; 功能：将压缩BCD码转换为对应的十进制数字ASCII码
; 算法：BCD码拆分为高4位和低4位，分别加30h得到ASCII码
; 程序结构：顺序结构
;-------------------------
assume cs:code, ds:data
data segment
    BCD     DB 86H        ; 压缩BCD码（86H表示十进制86）
    ASCII   DB 2 DUP(?), '$' ; 存储转换后的ASCII码，以$结尾
data ends

code segment
start:
    mov ax, data
    mov ds, ax           ; 设置数据段寄存器

    ; 处理低4位（个位）
    mov al, BCD          ; 加载BCD码
    and al, 0Fh          ; 取低4位（个位）
    add al, 30h          ; 转换为ASCII码
    mov ASCII+1, al      ; 存储个位ASCII码到第二个字节

    ; 处理高4位（十位）
    mov al, BCD          ; 重新加载BCD码
    mov cl, 4
    shr al, cl           ; 右移4位，将高4位移至低4位
    add al, 30h          ; 转换为ASCII码
    mov ASCII, al        ; 存储十位ASCII码到第一个字节

    ; 显示结果（DOS功能调用）
    mov dx, offset ASCII ; DX指向ASCII字符串
    mov ah, 9            ; 功能号9：显示字符串
    int 21h

    ; 程序终止
    mov ax, 4c00h        ; 功能号4Ch：退出程序
    int 21h
code ends
end start