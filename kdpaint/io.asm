;public
io_load_drawing:
	call io_open_file
	call io_read_from_file
ret

;private
io_error:
	mov dx, seg io_error_message
	mov ds, dx
	lea dx, io_error_message
	mov ah, 9
	int 21h
jmp exit_menu

;public
io_save_drawing:

	call hide_mouse

	mov ax, 0a000h
	mov es, ax
	mov dx, seg PICBUFFER
	mov ds, dx
	lea dx, PICBUFFER        
	mov di, 0
	mov cx, 57600
	
	;private
	copy_memory:
		mov bl, es:[di]
		mov ds:[di], bl
		inc di
		loop copy_memory

	call io_create_file
	call io_write_to_file
ret

;private
io_create_file:
	mov ah, 3ch
	mov dx, seg file_name
	mov ds, dx
	lea dx, file_name
	mov cx, 0
	int 21h
	jc io_error
ret

;private
io_write_to_file:
	xchg bx, ax               ;bx = handle to file
	mov ah, 40h
	mov dx, seg PICBUFFER
	mov ds, dx
	lea dx, PICBUFFER
	mov cx, 57600
	int 21h
	call show_mouse
	jc io_error
ret

;private
io_open_file:
	mov ah, 3dh
	mov dx, seg file_name
	mov ds, dx
	lea dx, file_name
	mov al, 0
	int 21h
	jc io_error
ret

;private
io_read_from_file:
	mov bx, ax
	mov ah, 3fh
	mov cx, 57600
	mov dx, 0a000h
	mov ds, dx
	mov dx, 0
	int 21h
	jc io_error
ret

file_name db "grafika.nfg", 0
io_error_message db "IO error$"
