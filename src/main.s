.include "cpctelera.h.s"
.include "entity.h.s"
.include "tileManager.h.s"
.include "main.h.s"

 
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

    ret

_main::
    ;; Cosas de la CPC
    call initialize_CPC
  
    ;; Crear una nueva entidad
    call ent_new
    ex	de, hl
    ld    hl,#hero_data
    call ent_copy
 
loop:
    ;;; New Entity
    ld    ix, #hero_data
    ;; Clear entity
    ld  hl, #ent_clear
    call ent_doForAll
    ;; Update entity
    ld  hl, #ent_update
    call ent_doForAll
    ;; Draw Entity
    ld hl, #ent_draw
    call ent_doForAll


    call cpct_waitVSYNC_asm
 
    jr    loop