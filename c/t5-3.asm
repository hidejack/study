assume cs:code

a segment 
	db 1,2,3,4,5,6,7,8
a ends

b segment
	db 1,2,3,4,5,6,7,8
b ends

c segment 
	db 0,0,0,0,0,0,0,0
c ends


code segment

	start:  mov ax,c    ;数据要存放的位置
		mov es,ax
	
		mov bx,0    ;bx 从0 开始
		mov cx,8    ;循环8次



setNumber : 	mov ax,a    ;从a 数据段中取出地址
		mov ds,ax

		mov dx,0        ;将取出的字节（8位） 给dl
		mov dl,ds:[bx]

		mov ax,b     ;从b数据段中取出地址
		mov ds,ax    

		add dl,ds:[bx]   ;a + b 中数据 放入dl
 		mov ex:[bx],dl   ;dl数据存入ex:[bx]
		inc bx           ; bx 自增

		loop setNumber

		mov ax,4C00H
		int 21H


code ends


end







































