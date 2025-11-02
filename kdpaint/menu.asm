;public
show_menu:
	call set_menu_coordinates	
	call display_menu_content
ret

;private
set_menu_coordinates:
	mov ah, 2
	mov dh, 23      ;row
	mov dl, 0       ;column
	mov bh, 0
	int 10h
ret

;private
display_menu_content:
	mov ah, 9
	mov al, 4
	mov dx, seg menu_content
	mov ds, dx
	lea dx, menu_content
	int 21h
ret

;public
hide_menu:
	mov cx, 6400
	mov al, 3       ; BLK
	mov dx, 0a000h
	mov es, dx
	mov di, 57600
	cld
	rep stosb
ret

;public
execute_menu_option:	
	mov ah, 8
	int 21h
	cmp al, 27		;ESC
	jne key_1
	jmp exit
	
	key_1:
		cmp al, '1'                      
		jne key_2
		mov current_color,1
	key_2:
		cmp al, '2'
		jne key_3
		mov current_color,2
	key_3:
		cmp al, '3'
		jne key_4
		mov current_color,3
	key_4:
		cmp al, '4'
		jne key_5
		mov current_color,4
	key_5:
		cmp al, '5'
		jne key_6
		mov current_color,5
	key_6:
		cmp al, '6'
		jne key_7
		mov current_color,6
	key_7:
		cmp al, '7'
		jne key_8
		mov current_color,7
	key_8:
		cmp al, '8'
		jne key_9
		mov current_color,8
	key_9:
		cmp al, '9'
		jne key_s
		mov current_color,9
	key_s:
		cmp al, 's'
		jne key_l
		call io_save_drawing
	key_l:
		cmp al, 'l'
		jne key_c
		call io_load_drawing
	key_c:
		cmp al, 'c'
		jne exit_menu
		call clrscr

	;public
	exit_menu:
		call hide_menu
jmp main_loop
	
menu_content db "1red 2blu 3blk 4wht 5pur 6grn 7yel 8cyan"
			 db "9gray s-save l-load c-clear ESC-exit$"
