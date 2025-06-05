; 目标：依次重复四次寄存器AL中的每一位，得到32位的结果存放DX:AX寄存器中
.model small
.stack 100h

.data
hexChars db '0123456789ABCDEF'  ; 十六进制字符表

.code
main proc
    mov ax, @data
    mov ds, ax

    ; 将AL的每一位重复四次，结果存入DX:AX
    xor ax, ax         ; 清空AX（低16位）
    xor dx, dx         ; 清空DX（高16位）

    ; 示例输入值（可修改测试）
    mov al, 0FFh       ; AL = 255 (二进制11111111)

    mov cx, 8          ; 循环计数器（8位）
    mov bl, al         ; 保存AL到BL

process_bits:
    ; 将DX:AX左移4位（32位左移）
    shl ax, 1
    rcl dx, 1
    shl ax, 1
    rcl dx, 1
    shl ax, 1
    rcl dx, 1
    shl ax, 1
    rcl dx, 1
    
    ; 获取当前最高位
    shl bl, 1          ; 最高位移入CF
    jnc skip_set        ; 如果为0则跳过设置
    
    ; 设置当前最低4位为1111
    or al, 0Fh         ; 设置AL的低4位 (关键修复)

skip_set:
    loop process_bits   ; 处理下一位

    ; 显示DX:AX的十六进制值
    call print_hex

    ; 退出程序
    mov ax, 4C00h
    int 21h
main endp

print_hex proc
    push bx
    push cx
    push dx
    push si
    push ax           ; 保存原始 AX（低16位）

    mov bx, offset hexChars  ; 指向十六进制字符表

    ; === 处理高16位（DX）===
    mov si, dx        ; SI = 高16位

    ; 数字1（最高4位：DX[15:12]）
    mov ax, si
    mov cl, 12
    shr ax, cl
    and al, 0Fh
    xlat              ; AL = [BX+AL]
    mov dl, al
    mov ah, 02h
    int 21h           ; 输出字符

    ; 数字2（DX[11:8]）
    mov ax, si
    mov cl, 8
    shr ax, cl
    and al, 0Fh
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; 数字3（DX[7:4]）
    mov ax, si
    mov cl, 4
    shr ax, cl
    and al, 0Fh
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; 数字4（DX[3:0]）
    mov ax, si
    and al, 0Fh       ; 无需移位，直接取低4位
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; === 处理低16位（原始AX）===
    pop si            ; 从栈中取出原始低16位 -> SI
    push si           ; 压回栈中保持平衡

    ; 数字5（最高4位：AX[15:12]）
    mov ax, si
    mov cl, 12
    shr ax, cl
    and al, 0Fh
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; 数字6（AX[11:8]）
    mov ax, si
    mov cl, 8
    shr ax, cl
    and al, 0Fh
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; 数字7（AX[7:4]）
    mov ax, si
    mov cl, 4
    shr ax, cl
    and al, 0Fh
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; 数字8（AX[3:0]）
    mov ax, si
    and al, 0Fh       ; 无需移位，直接取低4位
    xlat
    mov dl, al
    mov ah, 02h
    int 21h

    ; 输出换行
    mov dl, 0Dh
    mov ah, 02h
    int 21h
    mov dl, 0Ah
    mov ah, 02h
    int 21h

    ; 恢复寄存器
    pop ax
    pop si
    pop dx
    pop cx
    pop bx
    ret
print_hex endp

end main