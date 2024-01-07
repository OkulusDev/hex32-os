bits 16
org 0x7c00

jmp main

Message db "HEX32-OS", 0x0
AnyKey db "Press any key to shutdown . . . ", 0x0

print:
	lodsb
	or al, al
	jz complete
	mov ah, 0x0e
	int 0x10
	jmp print
complete:
	call printnl

printnl:
	mov al, 0
	stosb
	mov ah, 0x0E
	mov al, 0x0D
	int 0x10
	mov al, 0x0A
	int 0x10
		ret

shutdown:
    mov ax, 0x1000
    mov ax, ss
    mov sp, 0xf000
    mov ax, 0x5307
    mov bx, 0x0001
    mov cx, 0x0003
    int 0x15
	ret
	
boot:
    mov si, Message
    call print
	mov si, AnyKey
	call print
	call is_key_pressed
	
	call shutdown

is_key_pressed:
	mov ah, 0
	int 0x16
	ret

main:
    mov bp, 0x8000
	cli
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov ss,ax
	sti

	call boot

	times 510 - ($-$$) db 0
	dw 0xAA55
