assume cs:code,ds:data,ss:stack

data 	segment
	dd	3000004 ;��ռ��32�ֽ�
data	ends

stack 	segment stack
	db	 128 dup (0)
stack ends



;��Q����������}��
;��ʽ �� X/N = int(H/N)*65536 + [rem(H/N) * 65536 + L]/N
;���� �� ax = dword �͔����� ��16λ L
;	 dx = dword �͔����� ��16λ H
;	 cx = ���� N
;���أ�
;	dx = �Y���ĸ�16λ
;	ax = �Y���ĵ�16λ
;	cx = �N��
code	segment
	
	start:		mov ax,stack
			mov ss,ax
			mov sp,128

			mov ax,data
			mov ds,ax
			mov si,0

			mov ax,ds:[si+0]	;��������L
			mov dx,ds:[si+2]	;��������H

			mov cx,12		;���� N

			call divdw

			mov ax,4C00H
			int 21H

;=========================================

	divdw:		push bx
			push ax
		
			mov ax,dx
			mov dx,0
			div cx		;��=ax  �N�� = dx
					;��Ӌ��  int(H/N)*65536
			mov bx,ax
			pop ax		;L �˕r dx = rem(H/N) * 65536 L = ax

			div cx		;  [rem(H/N) * 65536 + L]/N
			
			mov cx,dx	;���N���ocx

			mov dx,bx	;�@ȡ��16λ	
		
			pop bx

			ret

;==========================================

code	ends


end	start





