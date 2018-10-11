.include "cpctelera.h.s"
.include "entity.h.s"
.include "tileManager.h.s"
.include "main.h.s"

.include "obstacle.h.s"
.include "enemy.h.s"
.include "hero.h.s"
 
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

    ld h, pTilemap+1(iy)
    ld l, pTilemap(iy)
    push hl

    ld h, pVideo+1(iy)
    ld l, pVideo(iy)
    push hl


call cpct_etm_drawTileBox2x4_asm

call ent_initialTile
ld    ix, #hero_data
ld    e_tile_l(ix),l
ld    e_tile_h(ix),h
call ent_getActualTile

call ent_initialTile
ld    ix, #enemy_data
ld    e_tile_l(ix),l
ld    e_tile_h(ix),h
call ent_getActualTile

ret






_main::
  ;; Disable firmware to prevent it from interfering with string drawing
  ;;call cpct_disableFirmware_asm
 
  ;;ld    c, #0
  ;;call cpct_setVideoMode_asm

  ld iy, #TScreenTilemap
  call initialize_CPC
  push iy


  
    ;;; Crear una nueva entidad
    call ent_new
    ex	de, hl
    ld    hl,#hero_data
    call ent_copy
 
    ; Crear una nueva entidad
    call ent_new
    ex	de, hl
    ld    hl, #enemy_data
    call ent_copy
 
loop:


  ld	  ix, #obstacle1
  call ent_draw_obs


  ld    ix, #enemy_data
  call enm_clear
  call enm_update
  call enm_draw

  ld    ix, #hero_data
  call hero_clear
  call hero_update
  call hero_draw

;;Una marca al
  ld	(0xC027), a ;;Draw coliision level
  ld	(0xC028), a ;;Draw coliision level
  ld	(0xC029), a ;;Draw coliision level


    call cpct_waitVSYNC_asm


  push iy




    jp loop



