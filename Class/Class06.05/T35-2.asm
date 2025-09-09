;3.5.1分支程序举例
;程序名：t35-2.asm
;功能：实现3个无符号数由大到小排序
;算法：3个无符号数两两比较，比较3次
;程序结构：分支结构
;方法二：只使用1个寄存器进行比较
;------------------------------------
assume cs:code,ds:data
data segment
buffer	db 87,234,123	;需要排序的3个无符号数
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	
	mov si,offset buffer
	mov al,[si]		;al暂存第一个数
	
	;第一次比较：比较第一个数和第二个数，确保第一个数不小于第二个数
	cmp al,[si+1]
	jae next1		;若al >= [si+1]，无需交换，跳至next1
	xchg al,[si+1]	;否则交换al和第二个数
	mov [si],al		;将较大的数存回第一个位置
next1:	
	;第二次比较：比较当前第一个数和第三个数，确保第一个数是最大的
	cmp al,[si+2]
	jae next2		;若al >= [si+2]，无需交换，跳至next2
	xchg al,[si+2]	;否则交换al和第三个数
	mov [si],al		;将最大的数存回第一个位置
next2:	
	;第三次比较：比较第二个数和第三个数，确保第二个数不小于第三个数
	mov al,[si+1]	;al暂存第二个数
	cmp al,[si+2]
	jae over		;若al >= [si+2]，无需交换，排序完成
	xchg al,[si+2]	;否则交换第二个数和第三个数
	mov [si+1],al	;将较大的数存回第二个位置

over:	
	mov ax,4c00h	;程序结束，返回DOS
	int 21h

code ends
	end start
