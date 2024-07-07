BITS 16
ORG 0x7C00



start:
        ; Clear the screen
        mov ah, 0x00      ; AH = 0x00 (Video Services)
        mov al, 0x03      ; AL = 0x03 (Clear screen)
        int 0x10          ; BIOS interrupt for video services
        mov bx, message
repeat:
        mov al, [bx]
        test al, al
        je hang
        push bx
        mov ah, 0x0e
        mov bx, 0x0004
        int 0x10
        pop bx
        inc bx
        jmp repeat

hang:
        jmp $

message: db "Mortar Bootloader VERSION 0.0.1", 0

times 510 - ($ - $$) db 0
dw 0xAA55
