

.include "cpctelera.h.s"
.include "entity.h.s"
.include "tileManager.h.s"
.include "main.h.s"

.include "menu.h.s"
.include "sprite.h.s"

.include "obstacle.h.s"
.include "enemy.h.s"
.include "hero.h.s"
 
.area _DATA

palette:
.db #0x54,#0x54,#0x44,#0x55,#0x57,#0x53,#0x5C,#0x4C,#0x4E,#0x47,#0x4A,#0x40,#0x56,#0x52,#0x46,#0x4B


.area _CODE
fps: .db #1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Inicializamos todas las funciones y configuraciones
;;  NO Parameters
;;  destroy: c, hl,de,be, a d 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
initialize_CPC:

  call cpct_disableFirmware_asm

  ld C, #0x00 ;; Modo de video
  call cpct_setVideoMode_asm

  ld hl, #_g_palette   ;; Paleta de colores
  ld de, #13          ;;numero de colores a cambiar
  call cpct_setPalette_asm

  ld l, #16       ;;Constante
  ld h, #HW_BLACK
  call cpct_setPALColour_asm   ;;Cambiar fondo negro

call scroll_default


  ld    ix, #hero_data
  ld    e_tile_l(ix),l
  ld    e_tile_h(ix),h
  call ent_getActualTile



ret


_main::
principio:
  ;;Cambiamos la pila de sitio:
  ld sp, #0x7FFA ;;STackPointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    MENU
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

    ld C, #0x00 ;; Modo de video
    call cpct_setVideoMode_asm  ;;Establece modo 0
    ;;jp 0xBF2A

    ;;Initialize music
    ld	de, #_song_ingame
    call cpct_akp_musicInit_asm

    call menu
    ;;call end_game
  infinito:
  	ld	a, (fps)
    halt
    halt
    halt
    halt
    halt
    
	  xor	#1
	  ld	(fps), a
	  jr	z, infinito
    call cpct_akp_musicPlay_asm
    call pulsada  ;;Comprueba los botones del menu
    
  jp infinito

  game:

  call initialize_CPC

  ;;; Crear una nueva entidad
  ;call ent_new
  ;ex	de, hl
  ;ld    hl,#hero_data
  ;call ent_copy
  
  loop:
    ld ix, #hero_data
    call hero_clear
    ld ix, #hero_data
    call hero_update
    ld ix, #hero_data
    call hero_draw


ld	hl, #enm_clear
call enm_doForAll

ld iy, #hero_data
ld	hl, #enm_update
call doForCurrentEnemy
;;call enm_doForAll


  ld	hl, #enm_draw
call enm_doForAll


;ld	ix, #eshoot
;call enm_clear
;
;ld iy, #hero_data
;ld	hl, #eshoot
;call enm_update
;

;  ld	hl, #eshoot
;call enm_draw

;;call  cpct_scanKeyboard_asm
;;    ld    hl, #Key_P
;;    call  cpct_isKeyPressed_asm
;;    jr    z, no_press_p
;;    
;;  	ld a, hero_vida(ix)
;;
;;  	cp #1
;;  	jr	z,no
;;  	dec a
;;no:
;;  	ld hero_vida(ix), a
;;
;;no_press_p:

  

call ren_drawHud  ;;HUD

    
    call ren_switchBuffers
    call cpct_waitVSYNC_asm


  jp loop

