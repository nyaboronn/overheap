.include "map.h.s"
.include "renderer.h.s"
.include "tileManager.h.s"
.include "main.h.s"
.include "cpctelera.h.s"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CARGA UN MAPA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS:
;; ENTRADAS:
;;          IX => puntero al mapa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cargar_mapa:
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
ret

init_mapa:
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

ret