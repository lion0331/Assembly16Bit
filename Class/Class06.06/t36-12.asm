;程序名：t36-12.asm				
;例8：设字符串1在数据段1中，字符串2在数据段2中，写一个程序判别字符串2是否是字符串1的				
;子字符串，如果是，则把数据段2中的flag单元置1，否置0				
;程序名：3621asm				
;功能				
;-------------------------------------------------------				
assume cs:code,ds:data1,es:data2				
data1 segment				
str1	db 'THIS IS A STRING!',0	;数据段1中的字符串		
data1 ends				
data2 segment				
str2	db 'STRING',0			
flag	db ?			
data2 ends				

 code segment
start:	mov ax,data1
	mov ds,ax
	mov ax,data2
	mov es,ax
	
	;计算str2的长度
	mov di,offset str2	
	xor cx,cx	;计数器
	dec di
while1:
	inc di		
	mov al,es:[di]
	cmp al,0
	jz next
	inc cx
	jmp while1	
next:
	mov dx,cx	;保存str2的长度
	mov si,offset str1	
fori:	
	mov cx,dx
	mov di,offset str2
forj:	
	mov al,es:[di]
	cmp al,[si]
	jz next1
	inc si
	cmp byte ptr [si],0
	jz notf
	jmp fori
next1:
	inc di
	inc si
	loop forj
	mov flag,1
	jmp over
notf:
	mov flag,0
over:	
	mov ax,4c00h
	int 21h
	
code ends
	end start