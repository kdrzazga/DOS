;public
hide_mouse:
	mov ax, 2
	int 33h
ret

;public
show_mouse:
	mov ax, 1
	int 33h
ret

;public
set_mouse_movement_bounds:
	mov ax, 8
	mov cx, 180
	mov dx, 1
	int 33h
ret

;public
set_mouse_movement_speed:
	mov ax, 0fh
	mov cx, 75                       ;horizontal speed
	mov dx, 50                       ;vertical speed
	int 33h
ret

;public
on_left_mouse_click:
	push bx
	mov ax, dx
	mov bx, 320
	mul bx
	shr cx, 1
	add ax, cx
	mov di, ax
	sub di, 321
	mov bl, current_color
	mov es:[di], bl
	pop bx
jmp main_loop

;public
on_right_mouse_click:
	call show_menu
jmp execute_menu_option	
