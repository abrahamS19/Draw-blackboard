TITLE Assignment #4 (assignment4.asm)

; PROGRAM NAME: Programming assignment #4
; AUTHOR: Ibrokhimkhuja Shokhujaev
; DATE: 4/30/19
; DESCRIPTION: this program allows a user to draw on the board

include Irvine32.inc
include macros.inc
	
topBorder macro dh, dl	; macro for top and bottom borders of the board

.CODE

	call goToXY

	repeat 100
		add dl, 1
		mov eax, yellow + (green*16) 
		call setTextColor
		mov eax, '_'
		call writeChar
	endm

ENDM

sideBorder macro dh, dl		; macro for left and right borders of the board

.CODE

	call goToXY

	repeat 22
		add dh, 1
		call GoToXY
		mov eax, '|'
		call writeChar
	endm

ENDM

displayShape macro
	
	mov eax, black + (white*16)
	call setTextColor
	mov edx, offset shape
	call writeString

ENDM

.DATA

	msg1 db "  ____            _      ___         ____     ___      _     ____    ____    ", 0dh, 0ah, 0
	msg2 db " |    \  |       / \    /   \ |   / |    \   /   \    / \   |    \  |    \   ", 0dh, 0ah, 0
	msg3 db " |     | |      /   \  |      |  /  |     | |     |  /   \  |     | |     \  ", 0dh, 0ah, 0
	msg4 db " |____/  |     |_____| |      |_/   |____/  |     | |_____| |____/  |      | ", 0dh, 0ah, 0
	msg5 db " |    \  |     |     | |      | \   |    \  |     | |     | |  \    |      | ", 0dh, 0ah, 0
	msg6 db " |     | |     |     | |      |  \  |     | |     | |     | |   \   |     /  ", 0dh, 0ah, 0
	msg7 db " |____/  |___| |     |  \___/ |   \ |____/   \___/  |     | |    \_ |____/   ", 0dh, 0ah, 0
	msg8 db "                                                                             ", 0dh, 0ah, 0

	row db ?
	col db ?

	shape db '*', 0

.CODE

main proc

	call clrscr

	mov dh, 10
	mov dl, 5
	topBorder dh, dl	; creating top border
	call crlf

	mov dh, 32
	mov dl, 5
	topBorder dh, dl	; creating bottom border
	call crlf

	mov dh, 10
	mov dl, 5
	sideBorder dh, dl	; creating left border
	call crlf

	mov dh, 10
	mov dl, 104
	sideBorder dh, dl	; creating right border
	call crlf

	mov dh, 1
	mov dl, 16
	call writeWord	; calling a procedure that prints the word "BLACKBOARD"
	call crlf

	call instructions

	mov dh, 11
	mov dl, 6
	call goToXY
	mov row, dh
	mov col, dl
	call drawObject ; calling a procedure that draws inside the board

	call crlf


	EXIT
main endp

writeWord proc	; procedure to print the word "BLACKBOARD"
	
	call goToXY

	push eax
	mov eax, white + (red * 16)	; foreground/ background
	call setTextColor
	pop eax

	call goToXY

	push edx	; save the position
	mov edx, offset msg1
	call writeString
	pop edx
	inc dh

	call goToXY

	push edx	; save the position
	mov edx, offset msg2
	call writeString
	pop edx
	inc dh

	call goToXY

	push edx	; save the position
	mov edx, offset msg3
	call writeString
	pop edx
	inc dh

	call goToXY

	push edx	; save the position
	mov edx, offset msg4
	call writeString
	pop edx
	inc dh

	call goToXY

	push edx	; save the position
	mov edx, offset msg5
	call writeString
	pop edx
	inc dh

	call goToXY

	push edx	; save the position
	mov edx, offset msg6
	call writeString
	pop edx
	inc dh

	call goToXY

	push edx	; save the position
	mov edx, offset msg7
	call writeString
	pop edx
	inc dh

	call goToXY

	mov edx, offset msg8
	call writeString
	call crlf


	ret

writeWord endp

drawObject proc		; procedure to move the cursor and draw objects
	
	move:	call readChar
			cmp al, 'w'
			JE moveUp
			cmp al, 's'
			JE moveDown
			cmp al, 'a'
			JE moveLeft
			cmp al, 'd'
			JE moveRight
			cmp al, 'l'	; actually draws an object
			JE draw
			jmp stop

			moveUp:	mov dh, row
					sub dh, 1
					mov dl, col
					call goToXY
					mov row, dh	; save dx
					mov col, dl
					jmp move

			moveDown:	mov dh, row
						add dh, 1
						mov dl, col
						call goToXY
						mov row, dh	; save dx
						mov col, dl
						jmp move

			moveRight:	mov dh, row
						mov dl, col
						add dl, 1
						call goToXY
						mov row, dh	; save dx
						mov col, dl
						jmp move

			moveLeft:	mov dh, row
						mov dl, col
						sub dl, 1
						call goToXY
						mov row, dh	; save dx
						mov col, dl
						jmp move

			draw:	.if(dh < 11 || dh > 31 || dl > 103 || dl < 6)	; if the cursor is outside of the board, drawing is not allowed
						jmp move
					.endIf
					displayShape
					jmp move
			
			stop:		
					 

	ret

drawObject endp

instructions proc	; procedure to print out instructions
	
	mov eax, yellow + (blue * 16) 
	call setTextColor

	mov dh, 34
	mov dl, 45
	call goToXY
	mwrite "INSTRUCTIONS:"
	
	mov dh, 35
	mov dl, 42
	call goToXY
	mWrite "Press w to move up"

	mov dh, 36
	mov dl, 42
	call goToXY
	mWrite "Press a to move left"

	mov dh, 37
	mov dl, 42
	call goToXY
	mWrite "Press s to move down"

	mov dh, 38
	mov dl, 42
	call goToXY
	mWrite "Press d to move right"

	mov dh, 39
	mov dl, 42
	call goToXY
	mWrite "Press l to draw"
	
	ret

instructions endp
end main



