; 例1:假设X和Y都是16位无符号数,写一个求表达式16*X+Y值的程序
; 设X,Y为16位无符号数,计算16X+Y的值
; 算法3:乘法
; 程序结构:顺序结构
; 程序名:T34-1.asm
; ===================
assume cs:code, ds:data

data segment
X dw 1234h         ; 定义16位无符号数X
Y dw 5678h         ; 定义16位无符号数Y
Z db 12 dup('$')   ; 分配12字节缓冲区存储十进制字符串（以'$'结尾）
data ends

code segment
start:
    ; 初始化数据段寄存器
    mov ax, data
    mov ds, ax

    ; 计算16*X + Y
    mov ax, X        ; AX = X
    xor dx, dx       ; 清零DX（DX:AX组成32位寄存器）

	mov bx,16
	mul bx

    ; 加上Y的值
    add ax, Y        ; AX = 16*X + Y
    adc dx, 0        ; 处理进位（DX:AX = 最终32位结果）

    ; 将32位结果转换为十进制字符串
    push ax          ; 保存低16位
    push dx          ; 保存高16位
    push si          ; 保存源指针
    push bx          ; 保存余数寄存器
    push cx          ; 保存除数

    mov cx, 10       ; 设置除数CX=10（十进制转换）
    lea di, Z + 10   ; 指向字符串缓冲区末尾（从后往前填充）
    mov byte ptr [di + 1], '$' ; 设置字符串结束符

    ; 检查是否为零的特殊情况
    mov si, dx       ; 加载高16位到SI
    or si, ax        ; 合并高低16位
    jnz convert_loop ; 非零则进入转换循环
    ; 处理零值情况
    mov byte ptr [di], '0' ; 直接写入字符'0'
    dec di           ; 调整di以保持与非零情况一致
    jmp end_conversion

convert_loop:
    call div32       ; 调用32位除法子程序（DX:AX / CX）
    add bl, '0'      ; 将余数转换为ASCII字符
    mov [di], bl     ; 存储字符到缓冲区
    dec di           ; 移动指针到前一个位置(逆序存储)
    ; 检查商是否为零
    mov si, dx       ; 加载商的高16位
    or si, ax        ; 合并商的32位
    jnz convert_loop ; 非零则继续循环

end_conversion:
    ; 恢复寄存器
    pop cx
    pop bx
    pop si
    pop dx
    pop ax

    ; 显示结果（DOS功能调用）
    lea dx, [di+1]   ; 正确获取字符串起始地址
    mov ah, 9        ; 设置显示字符串功能号
    int 21h          ; 调用DOS中断

    ; 程序终止
    mov ax, 4c00h    ; 设置终止程序功能号
    int 21h          ; 调用DOS中断

; 32位除以10的子程序（DX:AX / CX，返回商在DX:AX，余数在BL）
div32 proc near
    push di
    push si

    mov si, dx       ; 保存原始高16位
    mov di, ax       ; 保存原始低16位

    xor dx, dx       ; 清零DX
    mov ax, si       ; AX = 高16位
    div cx           ; 第一次除法：DX:AX / CX → 商1在AX，余数在DX
    mov si, ax       ; 保存商1到SI

    mov ax, di       ; AX = 原始低16位
    ; 此时 DX:AX = (第一次余数 << 16) + 原始低16位
    div cx           ; 第二次除法：DX:AX / CX → 商2在AX，余数在DX

    mov bl, dl       ; 余数保存到BL（DX < CX，所以DL足矣）
    mov dx, si       ; 商的高16位保存到DX
    ; AX已包含商的低16位，无需操作

    pop si
    pop di
    ret
div32 endp

code ends
end start