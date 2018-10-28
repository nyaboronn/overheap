.include "cpctelera.h.s"
.include "sprite.h.s"
.include "main.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Pintamos el Sprite por pantalla
;;  Registros Destruidos: HL, DE, C, B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pintar_sprite:	;84,47
 
 ld  c, #42     ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
 ld	 b, #47;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles

 call cpct_drawSprite_asm


ret

fondo_negro:
    ld hl, #0xC000
    ld (hl), #3		;;Poner negro con la palete final
    ld de, #0xC000 + 1
    ld bc, #0x4000 - 1
    ldir

    ld hl, #0x8000
    ld (hl), #3		;;Poner negro con la palete final
    ld de, #0x8000 + 1
    ld bc, #0x4000 - 1
    ldir


ret