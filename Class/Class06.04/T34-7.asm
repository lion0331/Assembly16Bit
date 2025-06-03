;例4：设X是一个1～10之间的整数，写一个求函数Y=LG(X)值的程序
;程序名：t34-7.asm
;功能：求1～10的对数值，以10为底的对数在0～1之间，为了表示方便和考虑精度，对数值放大10000倍。
;
;-----------------------------------------------------------
assume cs:code,ds:data
data segment
value	db 4	;假设X的值
answer	dw ?	;存放X的对数
tab	dw 0,3010,4771,6021,6990,7782,8451,9031,9542,10000	;对数表
data ends
code segment
start:

    mov ax, data
    mov ds, ax          ; 设置数据段寄存器
    
    ; 计算对数
    mov bl, value
    and bl, 0fh         ; 确保值在1-10范围内
    xor bh, bh
    dec bx              ; 调整索引（从0开始）
    add bx, bx          ; 索引乘以2（每个元素是字）
    mov ax, tab[bx]     ; 获取对数值
    mov answer, ax      ; 存储结果
    
    ; 显示answer的值
    mov ax, answer      ; 加载要显示的值
    mov cx, 10          ; 除数
    mov bx, 0           ; 数字计数器
    
    ; 处理特殊情况：0
    test ax, ax
    jnz convert
    mov dl, '0'         ; 如果是0，直接显示'0'
    mov ah, 02h
    int 21h
    jmp end_display
    
convert:
    ; 分解数字（从最高位开始）
    xor dx, dx
    div cx              ; DX:AX / CX → 商在AX，余数在DX
    push dx             ; 保存余数（当前数字）
    inc bx              ; 增加数字计数
    test ax, ax         ; 检查商是否为0
    jnz convert
    
display:
    ; 显示数字（从最高位到最低位）
    pop dx              ; 取出数字
    add dl, '0'         ; 转换为ASCII
    mov ah, 02h         ; DOS字符输出功能
    int 21h
    dec bx              ; 减少数字计数
    jnz display         ; 继续直到所有数字显示完毕
    
end_display:
    ; 程序终止
    mov ax, 4c00h
    int 21h

code ends
	end start