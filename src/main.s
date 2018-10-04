.include "cpctelera.h.s"
.include "entity.h.s"
.include "tileManager.h.s"
.include "main.h.s"
.include "obstacle.h.s"

 
.area _DATA
.area _CODE
 

entity_contador = 0



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

;;Tenemos que inicilizar EasyTileMap

    ld hl, #_g_tileset      ;;Punteor al tilesetW
call cpct_etm_setTileset2x4_asm


;;Ahora pintamos el mapa entero 
    ld C, #0x00    ;; X
    ld B, #0x00  ;; Y
    ld E, #SCR_TILE_WIDTH  ;; W
    ld D, #MAP_HEIGHT  ;; H
    ld A, #MAP_WIDTH ;; map_width

    ld hl, #_g_tilemap
    push hl

    ld hl, #CPCT_VMEM_START
    push hl

call cpct_etm_drawTileBox2x4_asm

call ent_initialTile
ld    ix, #hero_data
ld    e_tile_l(ix),l
ld    e_tile_h(ix),h
call ent_getActualTile




ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Comprueba telcado
;;  NO Parameters
;;  destroy: hl - Return in HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


wait4KeyboardInput:
  call  cpct_scanKeyboard_asm
 
  ld    hl, #Key_A
  call  cpct_isKeyPressed_asm
  jr    z, a_no_pulsada
        ;;A is pressed
        ld h, #-1
        ld l, #0
        ret
a_no_pulsada:

  ld    hl, #Key_D
  call  cpct_isKeyPressed_asm
  jr    z, d_no_pulsada
        ;; D is pressed
        ld h, #+1
        ld l, #SCR_TILE_WIDTH-1
        ret
d_no_pulsada:

ld h,#0
ret





_main::
  ;; Disable firmware to prevent it from interfering with string drawing
  ;;call cpct_disableFirmware_asm
 
  ;;ld    c, #0
  ;;call cpct_setVideoMode_asm

    ld ix, #TScreenTilemap
  call initialize_CPC
  

  
 
loop:


 ld	  ix, #obstacle1
  call ent_draw_obs


ld    ix, #hero_data
  call ent_clear
  call ent_update
  call ent_draw




  

  ld	(0xC027), a ;;Draw coliision level
  ld	(0xC028), a ;;Draw coliision level
  ld	(0xC029), a ;;Draw coliision level




   


    call cpct_waitVSYNC_asm

    ;; Loop forever
    jr    loop



