.include "cpctelera.h.s"
.include "entity.h.s"
.include "tileManager.h.s"
.include "main.h.s"

.include "obstacle.h.s"
.include "enemy.h.s"
.include "hero.h.s"
 
.area _DATA



.area _CODE

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


call ren_initBuffers


  ld bc, (#m_back_tileMap)
  push bc
  pop iy



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


  call ren_switchBuffers

  ;; LOAD in IY the new tileMAP
  ld bc, (#m_back_tileMap)
  push bc
  pop iy


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

ld    ix, #eshoot
ld    e_tile_l(ix),l
ld    e_tile_h(ix),h
call ent_getActualTile

ret


_main::
  ;;Cambiamos la pila de sitio:
  ld sp, #0x7FFA ;;STackPointer

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
  call enm_doForAll

    ld	hl, #enm_draw
  call enm_doForAll



    
    call ren_switchBuffers
    call cpct_waitVSYNC_asm


  jp loop



