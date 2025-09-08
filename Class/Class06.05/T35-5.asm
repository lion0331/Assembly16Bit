;设程序MBRANCH每次只接收一个单键命令'A'至'H'，然后根据命令进行相应的处理，
;如果接受到的不是规定的命令字母，则不处理。
;分析：编写一个入口地址表又称为散转表。如果各处理程序均在同一代码段，
;则入口地址只需要用偏移表示，入口地址表宽带为‘字’。
;程序名：t35-5.asm
;算法：地址表

;===================================================================
assume cs:code,ds:data
data segment
comtab	dw COMA,COMB,COMC,COMD
  	dw COME,COMF,COMG,COMH
data ends
code segment
start:	mov ah,1
	int 21h		;接收键盘命令在AL中
	and al,11011111b	;小写转大写
	cmp al,'A'
	jb ok
	cmp al,'H'
	ja ok
	sub al,'A'		;把命令字母转换成序号（从0开始）
	xor ah,ah		;清零
	add ax,ax		;ax*2，转换成comtab地址，宽度为dw
	mov bx,ax		;bx基址寄存器
	jmp comtab[bx]		;跳转对应的处理分支程序
ok:	mov ax,4c00h
	int 21h


COMA:	;....
	JMP OK
COMB:	...
	JMP OK
......
COMH:	......
	JMP OK




code ends
	end start
