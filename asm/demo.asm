assume cs:code,ds:data,ss:stack

data segment
		dw 1023H,24f6H,2434H,0A3H,9832H,873H,23BCH,67CH
data ends

stack segment stack
		dw 0,0,0,0,0,0,0,0
		dw 0,0,0,0,0,0,0,0
stack ends



code segment
	
start:		mov ax,stack  ;将栈地址给ss
		mov ss,ax
		mov sp,20H

		mov ax,data	;将数据地址给ds
		mov ds,ax

		mov ax,4C00H
		int 21H


code ends


end start







































