assume cs:code,ds:data,ss:stack

data	segment
		db	'1975','1976','1977','1978'
		db	'1979','1980','1981','1982'
		db	'1983','1984','1985','1986'
		db	'1987','1988','1989','1990'
		db	'1991','1992','1993','1994'
		db	'1995'
		;define year string,21
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

str	segment
		db 	16 dup (0)
str	ends


stack 	segment stack
		db	128 dup (0)
stack ends


code	segment

	start:		mov ax,stack 	;define stack register
			mov ss,ax
			mov sp,128

			call init_reg

			call clear_screen
	
			mov cx,21
			mov dh,2
			mov dl,2
			mov si,0
			mov di,0

	showRow:	call show_row
			inc dh
			inc si
			loop showRow

		

		
	
			mov ax,4C00H
			int 21H
;===============================顯示一行=====================================================

	show_row:	push di
			push ax
			push cx
			push ds
			push es
			push si
			push dx

			push si		;这里放入的是12345			

			call get_row
			push di

			call get_col

		
			mov cx,4
			mov ax,4
			mul si
			mov si,ax

	showYear:	mov al,ds:[si]
			mov es:[di],al
			inc si
			add di,2
			loop showYear

			pop di
			add di,40
			push di

			add si,20*4  ;因为si已经递增了4个字节，这里则加20*4即可	

			call dtoc	;将内存中的32位数解析为10进制字符串，存入内存：str

			push ds
			push si

			mov cx,16
			mov ax,str
			mov ds,ax
			mov si,0
			mov ah,0
			
	showSummary:	mov al,ds:[si]
			inc si
			push cx
			mov cx,ax
			jcxz interruptLoop
			pop cx
			mov es:[di],al
			inc di
	interruptLoop:	loop showSummary

			pop si
			pop ds

			call clear_str_seg

			
			


			pop di
			add di,40

			pop si
			add si,si
			add si,21*4*2 ;这里开始的位置为人数开始的位置
		
			push di

	showEmployee:	

			pop di
			add di,40

	showAverage:
			
			pop dx
			pop si
			pop es
			pop ds
			pop cx
			pop ax
			pop di
			ret




;============================清空存放str 内存區================================================
	;无返回值，不修改寄存器
	clear_str_seg:	push ax
			push ds
			push si
			push cx


			mov ax,str
			mov ds,ax
			mov si,0

			mov cx,8
			mov ax,0
		
	clearStrSeg:	mov ds:[si],ax
			add si,2
			loop clearStrSeg
			
			
			pop cx
			pop si
			pop ds
			pop ax
			ret

;==========================解決除法溢出==========================================
;	公式 ： X/N = int(H/N)*65536 + [rem(H/N) * 65536 + L]/N
;	参数：默认 ax，dx ，为被除数  cx 为除数
;	返回：cx 余数 dx 结果高16位 ax 结果低16位
;	注意：这里 ax，cx，dx 寄存器全部都改变了

	divdw:		push bx

			push ax		;先将ax（L） 存起来

			mov ax,dx	
			mov dx,0
			div cx		;这里得到：H/N 此时dx = rem(H/N) * 65536
			
			mov bx,ax	;bx = ax =  int(H/N) 
			pop ax		;ax = L
			
			div cx

			mov cx,dx	;cx 余数
			mov dx,bx	;dx = int(H/N) *65536  ax = [rem(H/N) * 65536 + L]/N 低八位
			
			pop bx
			ret

			


;==========================將二進制數字轉十進制字符串==========================================
;	參數：ds,si 设置好要读的地址
;	返回：解析后的十进制字符串 存入 ：str 内存区
	dtoc:		push ax
			push es
			push di
			push dx
			push ds
			push cx
			push si

			mov ax,str
			mov es,ax
			mov di,0FH

			mov ax,ds:[si]		;设置除数被除数
			mov dx,ds:[si+2]

	parse_str:	mov cx,10
			call divdw

			add cx,30H
			mov es:[di],cx
			dec di

			mov cx,ax
			jcxz isDXZero
			jmp parse_str
			
	isDXZero:	mov cx,dx
			jcxz dtocRet
			jmp parse_str
			
	dtocRet:	pop si
			pop cx
			pop ds
			pop dx
			pop di
			pop es
			pop ax
			ret
;==========================獲取顯示的行 存入 dh===========================================
;	有返回值 ： di 为修改后的值
	get_row:	push ax
			mov al,160
			mul dh
			add di,ax
			pop ax
			ret
;==========================獲取顯示的列 存入 dl==========================================
;	有返回值 ： di 为修改后的值
	get_col:	push ax
			mov al,2
			mul dl
			add di,ax
			pop ax
			ret

;==========================初始化寄存器===========================================
	init_reg:	mov ax,0B800H
			mov es,ax

			mov ax,data  
			mov ds,ax
			
			ret
;==========================清屏================================================
	clear_screen:	push es
			push bx
			push dx
			push cx
			
			mov bx,0B800H
			mov es,bx
			
			mov bx,0
			mov dx,0700H
			mov cx,2000
			
	clearScreen:	mov es:[bx],dx
			add bx,2
			loop clearScreen

			pop cx
			pop dx
			pop bx
			pop es
			ret
;===========================================================================
code	ends


end	start


