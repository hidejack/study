assume cs:code,ds:data,ss:stack

data 	segment
		;0123456789ABCDE
	dw	123,12666,1,8,3,38,0,0
	db	32 dup (0)
data	ends

stack 	segment stack
	db	 128 dup (0)
stack ends



code	segment
	
	start:		mov bx,stack
			mov ss,bx
			mov sp,128

			call init_reg	;初始化寄存器

			call dtoc	;處理數據為10進制，存入内存區域


			mov dh,8
			call get_row
			add di,ax

			mov dl,3
			call get_col
			add di,ax

			mov cl,2
			mov dl,cl

			call show_str

			

		


			mov ax,4C00H
			int 21H

;===========================================================
	get_row:	mov al,160
			mul dh
			ret
;===========================================================
	get_col:	mov al,2
			mul dl
			ret

;=====================================================
	show_str:	push cx
			push dx
			push si
			push di
			push ds
			push es

			mov cx,0
			mov si,30H
			
	showStr:	mov cl,ds:[si]
			mov es:[di],cl
			mov es:[di+1],dl
			add di,2
			dec si
			
			push si
			sub si,10H
			mov cx,si
			pop si

			jcxz showStrRet
			jmp showStr
			
			
	showStrRet:	pop es
			pop ds
			pop di
			pop si
			pop dx
			pop cx
			ret 	


;=====================================================
	
	dtoc:		push bx
			push dx
			push ax
			push cx
			push si
			push di
			push ds
		
			mov bx,10
			mov di,16
			mov si,-2
	
	read_number:	mov ds:[di],bh
			inc di
			add si,2
			mov ax,ds:[si]
			mov cx,ax
			jcxz dtocRet

	dtocFun:	mov dx,0
			div bx
			
			mov cx,ax			

			add dl,30H
			mov ds:[di],dl
			inc di
			
			jcxz read_number
			
			jmp dtocFun
			

	dtocRet:	pop ds
			pop di
			pop si
			pop cx
			pop ax
			pop dx
			pop bx
			ret

;=======================================================
	
	init_reg:	mov bx,data
			mov ds,bx
			mov si,0

			mov bx,0B800H
			mov es,bx
			mov di,0

			ret
;========================================================


code	ends


end	start







