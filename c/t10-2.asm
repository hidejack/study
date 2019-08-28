assume cs:code,ds:data,ss:stack

data 	segment
	dd	3000004 ;共占用32字节
data	ends

stack 	segment stack
	db	 128 dup (0)
stack ends



;解決除法溢出問題！
;公式 ： X/N = int(H/N)*65536 + [rem(H/N) * 65536 + L]/N
;參數 ： ax = dword 型數據的 低16位 L
;	 dx = dword 型數據的 高16位 H
;	 cx = 除數 N
;返回：
;	dx = 結果的高16位
;	ax = 結果的低16位
;	cx = 餘數
code	segment
	
	start:		mov ax,stack
			mov ss,ax
			mov sp,128

			mov ax,data
			mov ds,ax
			mov si,0

			mov ax,ds:[si+0]	;被除數的L
			mov dx,ds:[si+2]	;被除數的H

			mov cx,12		;除數 N

			call divdw

			mov ax,4C00H
			int 21H

;=========================================

	divdw:		push bx
			push ax
		
			mov ax,dx
			mov dx,0
			div cx		;商=ax  餘數 = dx
					;先計算  int(H/N)*65536
			mov bx,ax
			pop ax		;L 此時 dx = rem(H/N) * 65536 L = ax

			div cx		;  [rem(H/N) * 65536 + L]/N
			
			mov cx,dx	;將餘數給cx

			mov dx,bx	;獲取高16位	
		
			pop bx

			ret

;==========================================

code	ends


end	start





