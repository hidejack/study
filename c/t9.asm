assume cs:code,ds:data,ss:stack

data 	segment
	db	'welcome to masm!' ;共占用16字节
	db	00000010B ;绿色
	db	00100100B ;绿底红色
	db	01110001B ;白底蓝色
data	ends

stack 	segment stack
	db	 128 dup (0)
stack ends



;实验要求，在屏幕中间分别显示：绿色，绿底红色，白底蓝色的字符串	'welcome to masm!'
;计算屏幕中央位置
;0B40H - 0BDFH   0B87H
;0BE0H - 0C7FH  0C2EH,0C2CH,0C2AH,0C28H,0C26H
;0C80H - 0D1FH  0CC5H
code	segment

	start:	mov ax,data ;设置数据来源
		mov ds,ax
	

		mov ax,stack ;设置栈
		mov ss,ax
		mov sp,128

		mov ax,0B800H ;设置数据的去处
		mov es,ax
		mov di,0B86H
		

		mov cx,3
		mov bx,0

	Row:	push cx
		mov si,0

		mov cx,16
		
	Column:	mov dx,0
		mov dl,ds:[0+si]
		mov dh,ds:[bx+16]
		mov es:[di],dx
		add di,2
		inc si
		loop Column
	
		pop cx
		inc bx		
		add di,0A0H - 20H
		loop Row


		mov ax,4C00H
		int 21H

code	ends


end	start



