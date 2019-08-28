assume cs:code,ds:data,ss:stack

data	segment
		db	'1975','1976','1977','1978'
		db	'1979','1980','1981','1982'
		db	'1983','1984','1985','1986'
		db	'1987','1988','1989','1990'
		db	'1991','1992','1993','1994'
		db	'1995'
		;define year string,21
		;db 常用来定义字符串！！！
		;a string cost 4 byte . total cost  ： 21*4 = 84 byte
		
		dd	16,22,382,1356
		dd	2390,8000,16000,24486
		dd	50065,97479,140417,197514
		dd	345980,590827,803530,1183000
		dd	1843000,2759000,3753000,4649000
		dd	5937000
		;dword type data . a dword cost 4 byte. this total cost : 21*4 = 84 byte

		dw	3,7,9,13,28,38,130,220
		dw	476,778,1001,1442,2258,2793,4037,5635
		dw	8226,11542,14430,15257,17800
		;number of employee. a number cost 2 byte. total cost : 21 * 2 = 42 byte 
		; 2 byte per, total cost ：21 * 2 = 42 byte
data	ends

table	segment
		;	    total cost 16 byte 
		db 21 dup ('year summ ne ?? ')
table	ends

stack 	segment stack
		db	128 dup (0)
stack ends


code	segment

	start:	mov ax,stack 	;define stack register
		mov ss,ax
		mov sp,128

		mov ax,data  	;define src data register
		mov ds,ax
	
		mov ax,table  	;define dst data register
		mov es,ax

		mov si,0   	; ds:[si]
		mov di,21*4  	; ds:[di]
		mov bx,21*4*2 	; ds:[bx]
		mov bp,0   	; es:[bp]
		mov cx,21
		
s:		push ds:[si][0]
		pop es:[bp][0]
		push ds:[si][2]
		pop es:[bp][2]

		mov ax,ds:[di][0]
		mov dx,ds:[di][2]
		mov es:[bp][5],ax
		mov es:[bp][7],dx

		push [bx]
		pop es:[bp][0AH]
		
		div word ptr [bx]
		
		mov es:[bp][0DH],ax

		add si,4
		add di,4
		add bx,2
		add bp,10H
		loop s
		
		mov ax,4C00H
		int 21H

code	ends


end	start

