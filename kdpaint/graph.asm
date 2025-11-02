;public
set_graphical_mode:
	mov ax,0013h
	int 10h
ret

;public
set_text_mode:
	mov ax, 3
	int 10h         
ret

;private
clrscr:
	mov ax, 0a000h
	mov es, ax
	mov di, 0
	mov cx, 57600
	
	;private
	black_fill:	
		mov byte ptr es:[di], 3
		inc di
	loop black_fill
ret

;public
init_colors:
	mov ax, 13h
	int 10h

	mov ax, 01ffh            ;01 kolor R=ff
	mov bx, 0202h            ;G=2   B=2
	call set_rgb_color

	mov ax, 0202h            ;02 kolor
	mov bx, 02ffh           
	call set_rgb_color

	mov ax, 0300h            ;3 black
	mov bx, 0
	call set_rgb_color

	mov ax, 04ffh
	mov bx, 0ffffh           ;4 white
	call set_rgb_color

	mov ax, 05ffh
	mov bx, 0ffh           ;5 magenta
	call set_rgb_color

	mov ax, 0600h
	mov bx, 0ff00h           ;6 light green
	call set_rgb_color

	mov ax, 07ffh
	mov bx, 0ff00h           ;7 yellow
	call set_rgb_color

	mov ax, 0800h
	mov bx, 0ffffh           ;8 cyan
	call set_rgb_color

	mov ax, 09a0h            ;9 gray
	mov bx, 0a0a0h
	call set_rgb_color

	mov cx, 244
	mov ax, 0ffffh
	mov bx, 0ffffh
	
	;private
	set_gray_colors:
		dec ax
		dec bx
		call set_rgb_color
	loop set_gray_colors

ret

;private
set_rgb_color:
	xchg ah, al              ;after this al contains color index  ah= R value
	mov dx, 3c8h
	out dx, al               ;color index
	inc dx
	mov al, ah              ;R
	out dx, al
	mov al, bh              ;G
	out dx, al
	mov al, bl               ;B
	out dx, al
ret
