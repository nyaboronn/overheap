;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"
.include "menu.h.s"
.include "main.h.s"
.include "renderer.h.s"
.include "sprite.h.s"
.include "hero.h.s"
.include "tileManager.h.s"

.globl _overHeap_pal
.globl _youLost_pal

menu:

    ld  hl,  #_overHeap_pal
    ld  de,  #16      
    call cpct_setPalette_asm   
    
    ;;call fondo_negro

            ;D80F
    ld  de, #0xE0B4 ;;1 bloque pos de memoria
    ld  hl, #_overHeap_sp ;;Parte del sprite que quiero pintar
    call pintar_sprite
            ;;DCC0
    ld  de, #0xC430 ;;2 bloque pos de memoria
    ld  hl, #_play_sp;; Cojo la segunda parte
    ld  c, #19    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
    ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
    call cpct_drawSprite_asm

    ld  de, #0xC5A6 ;;2 bloque pos de memoria
    ld  hl, #_jlga10_sp;; Cojo la segunda parte
    ld  c, #20    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
    ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
    call cpct_drawSprite_asm

    ld  de, #0xC5C3 ;;2 bloque pos de memoria
    ld  hl, #_jlq2_sp;; Cojo la segunda parte
    ld  c, #13    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
    ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
    call cpct_drawSprite_asm

    ld  de, #0xC5D8 ;;2 bloque pos de memoria
    ld  hl, #_ajah1_sp;; Cojo la segunda parte
    ld  c, #17    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
    ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
    call cpct_drawSprite_asm
ret	



pulsada:
    call  cpct_scanKeyboard_asm
    ld    hl, #Key_1
    call  cpct_isKeyPressed_asm
    jr    z, no_press_1
    call cpct_akp_stop_asm
    jp game

no_press_1:


ret

end_game:

    ld  hl,  #_youLost_pal
    ld  de,  #16      
    call cpct_setPalette_asm   
    
        ;;call fondo_negro

        ;;ld  de, #0xE0BA ;;1 bloque pos de memoria
        ;;ld  hl, #_youLost_sp;; Cojo la segunda parte
        ;;ld  c, #27    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
        ;;ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
        ;;call cpct_drawSprite_asm

        ;;ld  de, #0xC428 ;;1 bloque pos de memoria
        ;;ld  hl, #_Restart_sp;; Cojo la segunda parte
        ;;ld  c, #29    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
        ;;ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
        ;;call cpct_drawSprite_asm
        call final_stage
    inf:
        call reinicio
    jp  inf

ret

reinicio:
    call  cpct_scanKeyboard_asm
    ld    hl, #Key_Z
    call  cpct_isKeyPressed_asm
    jr    z, no_press_Z
    ;;Saltamos y reiniciamos el vídeogame
    
    call scroll_default
    call hero_default
    ;;jp principio
    jp game
no_press_Z:
ret	