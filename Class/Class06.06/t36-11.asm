;例8：设字符串1在数据段1中，字符串2在数据段2中，写一个程序判别字符串2是否是字符串1的
;子字符串，如果是，则把数据段2中的flag单元置1，否置0
;程序名：t36-11.asm
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
start:
	mov ax,data1
	mov ds,ax
	mov ax,data2
	mov es,ax
	;
	mov di,offset str2
	mov bx,di
	xor cx,cx
	dec di
	;测str2长度
while1:	inc di
	inc cx
	cmp byte ptr es:[di],0
	jnz while1
	dec cx
	mov dx,cx
	;取str1首地址
	mov si,offset str1
	mov bp,si
fori:	mov cx,dx
	mov di,bx
forj:	mov al,es:[di]
	cmp [si],al
	jnz nexti
	inc si
	inc di
	loop forj
	mov flag,1
	jmp over
nexti:	cmp  byte ptr [si],0
	jz flag0
	inc bp
	mov si,bp
	jmp fori
flag0:	mov flag,0	
over:	mov ax,4c00h
	int 21h

 code ends
	end start
