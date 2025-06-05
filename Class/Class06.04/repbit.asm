; 目标：将 AL 中的每一位重复一次，结果存入 DX
.model small
.stack 100h

.data
hexChars db '0123456789ABCDEF'  ; 十六进制字符表

.code
main proc
    mov ax, @data
    mov ds, ax

    ; 示例输入值（可修改测试）
    mov al, 0FFh       ; AL = 255 (二进制11111111)

    ; 重复AL的每一位得到16位结果存入DX
    xor dx, dx         ; 初始化DX为0
    mov cx, 8          ; 处理8位
    
ProcessBits:
    ; 左移DX为新的两位腾出空间
    shl dx, 1
    shl dx, 1          ; 相当于左移2位
    
    ; 获取AL的当前最高位
    shl al, 1          ; 左移AL，最高位移入CF
    sbb bl, bl         ; 如果CF=1，则BL=FFh；如果CF=0，则BL=0
    and bl, 3          ; BL=00 或 03
    neg bl             ; BL=00 或 FDh
    sbb bl, 0FDh       ; BL=00 或 03? 修正为00或03
    
    ; 更好的方法：使用CF直接构建两位
    rcr bl, 1          ; 将CF移入BL的最高位
    rcr bl, 1          ; 再次移入，形成两位
    and bl, 3          ; 确保只有低两位
    
    ; 将新的两位放入DX的最低2位
    or  dl, bl
    
    loop ProcessBits   ; 处理所有8位

    ; 显示DX的十六进制值
    call print_hex

    ; 退出程序
    mov ax, 4C00h
    int 21h
main endp

; 显示DX寄存器十六进制值的子程序
print_hex proc
    push cx
    push bx
    push ax
    push dx
    
    mov bx, offset hexChars
    
    ; 保存原始值
    push dx
    
    ; 处理最高4位（右移12位）
    mov cl, 12         ; 设置移位位数为12
    pop dx             ; 获取原始值
    push dx            ; 重新保存
    shr dx, cl         ; 右移12位
    mov al, dl         ; 使用移位后的值
    and al, 0Fh        ; 取低4位
    xlat               ; AL = [BX + AL]
    mov dl, al
    mov ah, 02h
    int 21h
    
    ; 处理次高4位（右移8位）
    mov cl, 8          ; 设置移位位数为8
    pop dx             ; 获取原始值
    push dx            ; 重新保存
    shr dx, cl         ; 右移8位
    mov al, dl         ; 使用移位后的值
    and al, 0Fh        ; 取低4位
    xlat               ; AL = [BX + AL]
    mov dl, al
    mov ah, 02h
    int 21h
    
    ; 处理次低4位（右移4位）
    mov cl, 4          ; 设置移位位数为4
    pop dx             ; 获取原始值
    push dx            ; 重新保存
    shr dx, cl         ; 右移4位
    mov al, dl         ; 使用移位后的值
    and al, 0Fh        ; 取低4位
    xlat               ; AL = [BX + AL]
    mov dl, al
    mov ah, 02h
    int 21h
    
    ; 处理最低4位（不移位）
    pop dx             ; 获取原始值
    mov al, dl         ; 使用原始值的低字节
    and al, 0Fh        ; 取低4位
    xlat               ; AL = [BX + AL]
    mov dl, al
    mov ah, 02h
    int 21h
    
    ; 添加换行
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