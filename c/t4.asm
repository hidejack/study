assume cs:code



code segment
	
		mov ax,123
		mov cx,236

setNumber : 	add ax,ax
		loop setNumber

		mov ax,4C00H
		int 21H


code ends


end







































