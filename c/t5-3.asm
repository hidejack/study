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

	start:  mov ax,c    ;����Ҫ��ŵ�λ��
		mov es,ax
	
		mov bx,0    ;bx ��0 ��ʼ
		mov cx,8    ;ѭ��8��



setNumber : 	mov ax,a    ;��a ���ݶ���ȡ����ַ
		mov ds,ax

		mov dx,0        ;��ȡ�����ֽڣ�8λ�� ��dl
		mov dl,ds:[bx]

		mov ax,b     ;��b���ݶ���ȡ����ַ
		mov ds,ax    

		add dl,ds:[bx]   ;a + b ������ ����dl
 		mov ex:[bx],dl   ;dl���ݴ���ex:[bx]
		inc bx           ; bx ����

		loop setNumber

		mov ax,4C00H
		int 21H


code ends


end







































