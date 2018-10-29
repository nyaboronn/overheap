;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"
.include "menu.h.s"
.include "main.h.s"
.include "renderer.h.s"
.include "sprite.h.s"
.include "hero.h.s"
.include "tileManager.h.s"
.include "enemy.h.s"

.globl _overHeap_pal
.globl _youLost_pal

fps2: .db #1
ronda: .db #0

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


;;Muestra por pantalla Z para reiniciar y X para siguiente
next_game:

    ld  hl,  #_youLost_pal
    ld  de,  #16      
    call cpct_setPalette_asm   
    call scroll_default
    call ren_initBuffers
    call next_stage

    inf:
        call reinicio
    jp  inf

ret
;;;;;;;;;;;
;;Reincia el juego dandolo a la Z y a la X siguiente ronda
;;
;; Entro si me lo paso
;;;;;;;;;;
reinicio:



    call  cpct_scanKeyboard_asm
    ld    hl, #Key_Z
    call  cpct_isKeyPressed_asm
    jr    z, no_press_Z
    ;;Saltamos y reiniciamos el vídeogame
    ;;ld a, #2
    ;;ld (enemies), a
    call scroll_default
    
    
    call enemy_default
    call hero_default

    call reinicio_rondas
    call reinicio_enemies

    ;;jp principio
    jp game
    ;;call llamada_menu
no_press_Z:

    call  cpct_scanKeyboard_asm
    ld    hl, #Key_X
    call  cpct_isKeyPressed_asm
    jr    z, no_press_X
    
   
    ;;Todo cambiar por los sigueitnes enemigos
    call scroll_default

    ;; call improve_enemies
   ;; call enemy_default
    call enemy_improve
    call hero_default_no_vida

    call inc_rondas

;;Generamos los siguientes enemigos para la siguiente ronda-----------------------------------------------------------------------------------------------------------------
    
    cp #3
    jr nz, no_fin
    call fin_rondas
    no_fin:

    jp game
no_press_X:

ret	
;;;;;;;;;;;;;;;;;;;;;
;;Reincia el juego dandolo a la Z
;;Entro si me matan
;;;;;;;;;;;;;;;;;;;;;
full_reinicio:
    call  cpct_scanKeyboard_asm
    ld    hl, #Key_Z
    call  cpct_isKeyPressed_asm
    jr    z, full_no_press_Z
    ;;Saltamos y reiniciamos el vídeogame
    ;ld a, #2
    ;ld (enemies), a
   ; call enemy_default
    call scroll_default
    
    
    call reinicio_rondas
    call reinicio_enemies

    call enemy_default
    call hero_default

    jp game
    ;;call llamada_menu
    ;;jp principio
full_no_press_Z:



ret

end_reinicio:
    call  cpct_scanKeyboard_asm
    ld    hl, #Key_Z
    call  cpct_isKeyPressed_asm
    jr    z, end_no_press_Z
    ;;Saltamos y reiniciamos el vídeogame
    ;;ld a, #2
    ;;ld (enemies), a
   ; call enemy_default
    call scroll_default
    call enemy_default
    call hero_default

    call reinicio_rondas
    call reinicio_enemies
    
    ;;jp game
    call llamada_menu
    ;;jp principio
end_no_press_Z:



ret


fin_rondas:
     ld  hl,  #_youLost_pal
    ld  de,  #16      
    call cpct_setPalette_asm

    call scroll_default
    call ren_initBuffers
    call rondas_stage


    inf4:
       
    
    call end_reinicio

    jp  inf4

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Carga final del mapa         
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
end_game:

    ld  hl,  #_youLost_pal
    ld  de,  #16      
    call cpct_setPalette_asm 

    call scroll_default
    call ren_initBuffers
    call final_stage ;; Pintar por pantalla

    full_inf:
        call full_reinicio
    jp  full_inf

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Incrementa en 1 la ronda
;;;;;;;;;;;;;;;;;;;;;;;;;;
inc_rondas:
     ld a, (ronda)
     inc a
     ld (ronda), a
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Reinicia la variable rondas
;;;;;;;;;;;;;;;;;;;;;;;;;;
reinicio_rondas:
    ld a, #0
    ld (ronda), a
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Reinicia la variable enemies para el siguiente mapa al de la ronda default
;;;;;;;;;;;;;;;;;;;;;;;;;;
reinicio_enemies:
    ld a, #k_total_enm
    ld (enemies), a
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Se encarga de limpar el buffer y de llamar al menu y controlar las opciones del menu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
llamada_menu:
    call ren_initBuffers
    call menu
    call ren_switchBuffers
    
    call reinicio_rondas
    call reinicio_enemies
inf3:	

    ld	a, (fps2)
    halt
    halt
    halt
    halt
    halt
    
    xor	#1
	ld	(fps2), a
	jr	z, inf3

    call cpct_akp_musicPlay_asm
    call pulsada

jp inf3

ret



