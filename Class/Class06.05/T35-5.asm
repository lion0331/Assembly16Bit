;�����MBRANCHÿ��ֻ����һ����������'A'��'H'��Ȼ��������������Ӧ�Ĵ���
;������ܵ��Ĳ��ǹ涨��������ĸ���򲻴���
;��������дһ����ڵ�ַ���ֳ�Ϊɢת�����������������ͬһ����Σ�
;����ڵ�ַֻ��Ҫ��ƫ�Ʊ�ʾ����ڵ�ַ����Ϊ���֡���
;��������t35-5.asm
;�㷨����ַ��

;===================================================================
assume cs:code,ds:data
data segment
comtab	dw COMA,COMB,COMC,COMD
  	dw COME,COMF,COMG,COMH
data ends
code segment
start:	mov ah,1
	int 21h		;���ռ���������AL��
	and al,11011111b	;Сдת��д
	cmp al,'A'
	jb ok
	cmp al,'H'
	ja ok
	sub al,'A'		;��������ĸת������ţ���0��ʼ��
	xor ah,ah		;����
	add ax,ax		;ax*2��ת����comtab��ַ�����Ϊdw
	mov bx,ax		;bx��ַ�Ĵ���
	jmp comtab[bx]		;��ת��Ӧ�Ĵ����֧����
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
