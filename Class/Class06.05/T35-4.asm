;��3��дһ��ʵ�ְ�һλ16����������Ӧ��ASCII��ת��Ϊ16�������ĳ������û�ж�Ӧ������ת��Ϊ-1
;��������t35-4.asm
;��֧�ṹ
;���ܣ�ASCII��ת��Ϊ16������
;����������AL=ASCII�룬XΪת�����16����������Ϊ7�������
;AL<'0'ΪX=-1
;��0��<=AL<='9',X=AL-'0'
;'9'<=AL<='A',X=-1
;'A'<AL<'F'�� X=AL-('A'-10 )= AL - 37H
;'F'<AL<'a',x=-1
;'a'<=AL<='f' x=AL-('a'-10) = AL - 57H
;AL>'f',x=-1
;-------------------------------------------------------------
assume cs:code,ds:data
data segment
x	db ?
ASCII	db 'a'
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	;
	mov al,ASCII
	mov ah,al
	sub ah,30h
	cmp al,'0'
	jb lab1
	cmp al,'9'
	jbe lab2
	;
	mov ah,al
	sub ah,37h
	cmp al,'A'
	jb lab1
	;
	cmp al,'F'
	jbe lab2
	;
	mov ah,al
	sub ah,57h
	cmp al,'a'
	jb lab1
	;
	cmp al,'f'
	jbe lab2
		
lab1:
	mov x,-1
	jmp over
	
lab2:
	mov x,ah	

over:	;
	
	mov ax,4c00h
	int 21h

code ends
	end start