ASSUME cs:CODE
CODE SEGMENT

current_color db 1
PICBUFFER db 57600 dup(?)

;public
main:
	call set_graphical_mode
	call init_colors                      					 
	call set_mouse_movement_bounds
	call set_mouse_movement_speed
	call show_mouse		

	;public
	main_loop:
		mov dx, 0a000h
		mov es, dx
		mov ax, 3
		int 33h
		
		test bx, 1
		jnz on_left_mouse_click
		
		test bx, 2
		jnz on_right_mouse_click
		
	jmp main_loop

	include mouse.asm
	include menu.asm
	include graph.asm
	include io.asm

	;public
	exit:
		call set_text_mode
	mov ax, 4c01h
	int 21h

	CODE ENDS

END main
