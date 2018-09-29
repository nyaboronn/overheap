;###########################################################################
;#### FICHERO: main.s
;###########################################################################
;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of CPCtelera: An Amstrad CPC Game Engine
;;  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
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
.include "entity.h.s"
.include "tileManager.h.s"
.include "main.h.s"

 
;;
;; Start of _DATA area
;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
;;  right after _CODE area contents.
;;
.area _DATA
.area _CODE
 
;;
;; MAIN function. This is the entry point of the application.
;;    _main:: global symbol is required for correctly compiling and linking
;;
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
  ;; Disable firmware to prevent it from interfering with string drawing
  ;;call cpct_disableFirmware_asm
 
  ;;ld    c, #0
  ;;call cpct_setVideoMode_asm


  call initialize_CPC
  
  call ent_new
  ex	de, hl
  ld    hl,#enemy_data
  call ent_copy

  
 
loop:


  ld    ix, #hero_data
  call ent_clear
  call ent_update
  call ent_draw
 
 ;; ld    ix, #enemy_data
 ;; call ent_clear
 ;; call ent_update
 ;; call ent_draw

 ;; ld  hl, #ent_clear
 ;; call ent_doForAll

 ;; ld  hl, #ent_update
  ;;call ent_doForAll

  ;;ld hl, #ent_draw
  ;;call ent_doForAll


  call  cpct_scanKeyboard_asm
 
;;  ld    hl, #Key_A
;; call  cpct_isKeyPressed_asm
;;  jr    z, a_no_pulsada

;;   call ent_new
;;    ex	de, hl
;;    ld    hl,#enemy_data
;;    call ent_copy

;;a_no_pulsada:


  call cpct_waitVSYNC_asm
 
  ;; Loop forever
  jr    loop