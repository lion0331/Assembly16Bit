; 功能：将32位有符号数转换为十进制字符串并显示
; 输入：DX:AX = 32位有符号数
; 输出：在屏幕上显示十进制结果
; 说明：处理负数补码转换，支持32位范围(-2147483648 到 2147483647)
.model small
.stack 100h

.data
    number_low  dw 0000h   ; 数字的低16位
    number_high dw 8000h   ; 数字的高16位 (示例值：-2147483648)
    Z           db 12 dup('$') ; 输出缓冲区(11位数字+终止符)
    sign_flag   db 0        ; 符号标志：0=正数, 1=负数

.code
main proc
    mov ax, @data         ; 初始化数据段
    mov ds, ax
    
    ; 加载32位数到DX:AX
    mov ax, number_low
    mov dx, number_high

    ; ==== 符号处理 ====
    mov sign_flag, 0       ; 初始化符号标志
    test dx, 8000h         ; 检测最高位(符号位)
    jz  convert_to_dec     ; 正数直接跳转转换
    
    ; ==== 负数处理 ====
    mov sign_flag, 1       ; 设置负数标志
    not ax                 ; 低16位取反
    not dx                 ; 高16位取反
    add ax, 1              ; 低16位加1
    adc dx, 0              ; 高16位带进位加

convert_to_dec:
    ; ==== 准备转换环境 ====
    push ax                ; 保存原始值
    push dx
    push bx
    push cx
    push si
    push di
    
    mov cx, 10             ; 设置除数为10
    lea di, Z + 11         ; DI指向缓冲区末尾(第12字节)
    mov byte ptr [di], '$' ; 设置字符串终止符
    dec di                 ; DI指向最后一位数字位置(Z+10)

convert_loop:
    call div32             ; 调用32位除法：DX:AX / 10
    add bl, '0'            ; 余数(BL)转ASCII字符
    dec di                 ; 前移缓冲区指针
    mov [di], bl           ; 存储数字字符(逆序)
    
    ; 检查商(DX:AX)是否为0
    mov bx, dx
    or  bx, ax             ; 合并高低位判断
    jnz convert_loop       ; 非零则继续除

display:
    ; ==== 符号处理 ====
    cmp sign_flag, 1       ; 检查是否为负数
    jne positive           ; 正数跳过符号添加
    dec di                 ; 前移指针留出符号位
    mov byte ptr [di], '-' ; 添加负号

positive:
    ; ==== 显示结果 ====
    mov dx, di             ; DX=字符串起始地址
    mov ah, 09h            ; DOS显示字符串功能
    int 21h

    ; ==== 恢复寄存器 ====
    pop di
    pop si
    pop cx
    pop bx
    pop dx
    pop ax

    ; ==== 退出程序 ====
    mov ax, 4c00h          ; DOS退出程序功能
    int 21h

; ==============================================
; 32位除法子程序
; 功能：DX:AX / CX → 商(DX:AX), 余数(BL)
; 算法：分两次除法处理32位值
; 注意：不保存BX寄存器，由调用者管理
; ==============================================
div32 proc near
    push si
    push di
    
    ; 保存原始值
    mov si, dx        ; SI = 原始高16位
    mov di, ax        ; DI = 原始低16位
    
    ; ==== 第一步：处理高16位 ====
    xor dx, dx        ; 清零DX(扩展为32位除法)
    mov ax, si        ; AX = 高16位
    div cx            ; DX:AX / CX → AX(商高位), DX(余数)
    mov si, ax        ; SI = 商的高位
    
    ; ==== 第二步：处理低16位 ====
    mov ax, di        ; AX = 低16位
    ; DX已是高16位除法的余数(作为本次除法的高16位)
    div cx            ; DX:AX / CX → AX(商低位), DX(余数)
    
    ; ==== 组合结果 ====
    mov bl, dl        ; BL = 余数(0-9)
    mov dx, si        ; DX = 商的高位
    
    pop di
    pop si
    ret
div32 endp

main endp
end main