assume cs:code,ds:data,ss:stack

data 	segment
	db	'welcome to masm!' ;��ռ��16�ֽ�
	db	00000010B ;��ɫ
	db	00100100B ;�̵׺�ɫ
	db	01110001B ;�׵���ɫ
data	ends

stack 	segment stack
	db	 128 dup (0)
stack ends



;ʵ��Ҫ������Ļ�м�ֱ���ʾ����ɫ���̵׺�ɫ���׵���ɫ���ַ���	'welcome to masm!'
;������Ļ����λ��
;0B40H - 0BDFH   0B87H
;0BE0H - 0C7FH  0C2EH,0C2CH,0C2AH,0C28H,0C26H
;0C80H - 0D1FH  0CC5H
code	segment

	start:	mov ax,data ;����������Դ
		mov ds,ax
	

		mov ax,stack ;����ջ
		mov ss,ax
		mov sp,128

		mov ax,0B800H ;�������ݵ�ȥ��
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



