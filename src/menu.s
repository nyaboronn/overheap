;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of OverHeap: An AmstradCpc Game for the contest cpcretrodev
;;  Copyright (C) 2018 jlga - jlq2 - ajah1 | @bastacpc 
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;-------------------------------------------------------------------------------

;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"
.include "menu.h.s"
.include "main.h.s"
.include "renderer.h.s"
.include "sprite.h.s"
.include "hero.h.s"
.include "tileManager.h.s"
.include "enemy.h.s"


fps2: .db #1
ronda: .db #0
max_ronda: .db #3


menuPal: .db  0x54, 0x5c, 0x44, 0x55, 0x57, 0x58, 0x5c, 0x4c, 0x4e, 0x47, 0x4a, 0x40, 0x56, 0x52, 0x46,  0x4b



;;;;;;;;;;;;;;;;;
;;Pinta Menu
;;;;;;;;;;;;;;;;
menu:

    ld  hl,  #menuPal
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


;;;;;;;;;;;;;;;;
;;LLeva el control de los botones del menu y su flujo de programa
;;;;;;;;;;;;;;;;
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

    ld  hl,  #menuPal
    ld  de,  #16      
    call cpct_setPalette_asm   
    call scroll_default
    call ren_initBuffers

    call inc_rondas
    call check_rondas
    
    call next_stage

    inf:
        call reinicio
    jp  inf

ret
;;;;;;;;;;;
;; X siguiente ronda
;;
;; Entro si me lo paso
;;;;;;;;;;
reinicio:

    call  cpct_scanKeyboard_asm
    ld    hl, #Key_X
    call  cpct_isKeyPressed_asm
    jr    z, no_press_X
    
   
    ;;Todo cambiar por los sigueitnes enemigos
    call scroll_default

    call enemy_improve
    ;;call enemy_default
    call hero_default_no_vida

;;Generamos los siguientes enemigos para la siguiente ronda-----------------------------------------------------------------------------------------------------------------


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
    call scroll_default

   ;; call reiniciar_life
   ;; call reinicio_rondas
   ;; call reinicio_enemies
;;
   ;; call enemy_default
   ;; call hero_default 
   call restart_all

    jp game
    ;;call llamada_menu
    ;;jp principio
full_no_press_Z:



ret
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Entro si me paso el juego
;;;;;;;;;;;;;;;;;;;;;;;;;;
end_reinicio::
    call  cpct_scanKeyboard_asm
    ld    hl, #Key_Z
    call  cpct_isKeyPressed_asm
    jr    z, end_no_press_Z
    ;;Saltamos y reiniciamos el vídeogame
    call scroll_default

    ;;call reiniciar_life
    ;;call reinicio_rondas
    ;;call reinicio_enemies
;;
    ;;call enemy_default
    ;;call hero_default
    call restart_all

    
    
    jp game
    ;;call llamada_menu
    ;;jp principio
end_no_press_Z:



ret


fin_rondas:
     ld  hl,  #menuPal
    ld  de,  #16      
    call cpct_setPalette_asm

    call scroll_default
    call ren_initBuffers
    call rondas_stage

    call restart_all


    inf4:
    call end_reinicio

    jp  inf4

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Carga final del mapa         
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
end_game:

    ld  hl,  #menuPal
    ld  de,  #16      
    call cpct_setPalette_asm 

    call scroll_default
    call ren_initBuffers
    call final_stage ;; Pintar por pantalla

    full_infw:
        call full_reinicio
    jp  full_infw

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Reinicia todas las variables necesarias para default
;;;;;;;;;;;;;;;;;;;;;;;;;;
restart_all:
call reset_RepeatRender
call reset_InputHL

    call reiniciar_life     ;;Reinicia la variable Life
    call reinicio_rondas    ;;Reinicia la variable ronda
    call reinicio_enemies   ;;Reinicia la variable enemies
    call reiniciar_enm_map_alive ;;Reinicia la variable enm_map_alive

    call enemy_default
    call hero_default
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Comprueba si se han ejecutado todas las rondas
;;  Registros Destruidos A, B
;;;;;;;;;;;;;;;;;;;;;;;;;;
check_rondas:

    ld a, (max_ronda)    ;;Cojo el máximo de rondas
    ld b, a              ;;Lo paso al registro b, para comprobar
    ld a, (ronda)

    cp b
    jr nz, no_fin
    call fin_rondas

    ;call llamada_menu

    no_fin:
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
;;  Reinicia la variable ronda
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
    call restart_all
    ;;call reinicio_rondas
    ;;call reinicio_enemies
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



