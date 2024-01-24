;³ÌĞòÃû
;$.asm
;===================
assume cs:code,ds:data

data segment
array dw 1,2,$+4,3,4,$+4
data ends

code segment
start:
	mov ax,data
	mov ds,ax

	
	mov ax,4c00h
	int 21h
code ends
end start