assume cs:code,ds:data,ss:stack

data segment
		db	'12are u ok!'
		dd	1  ;32byte
		dw	1  ;16byte
		db	1  ;8byte
		db	100  dup(2) ;定义100个字符2 长度为db 8 位
data ends

stack segment stack
		dw	0,0,0,0
		dw	0,0,0,0
		dw	0,0,0,0
		dw	0,0,0,0
stack ends




code segment

	start:	mov ax,stack
		mov ss,ax
		mov sp,32

		mov ax,data
		mov ds,ax

		mov al,'a'
		mov ah,'b'


code ends


end







































