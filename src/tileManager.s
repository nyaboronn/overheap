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


.include "cpctelera.h.s"
.include "tileManager.h.s"
.include "utils.h.s"
.include "main.h.s"

.include "renderer.h.s"

;;Structure 

TScreenTilemapFront: .dw #0x8000
                .dw #_g_tilemap
                .db 0x00

TScreenTilemapBack: .dw #0xC000
                .dw #_g_tilemap
                .db 0x00


RepeatRender: .db #0
;;INPUT -> scroll= h
;;         column = l

InputHL: .dw #0x0000      




reset_InputHL:
    ld bc, #0x0000
    ld (InputHL),bc
ret

reset_RepeatRender:
    ld a , #0
    ld (RepeatRender), a
ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    ;;LLAMAR SIEMPRE *ANTES* DE LA LLAMADA A HERO_DEFAULT
;; Devuelve al Scroll a valores default
;; 
;; Registros destruidos: IX
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
scroll_default:
    ld ix, #TScreenTilemapFront
    ld pVideo(ix), #0x8000
    ld pTilemap(ix), #_g_tilemap
    ld scroll(ix), #0x00

    ld ix, #TScreenTilemapBack
    ld pVideo(ix), #0xC000
    ld pTilemap(ix), #_g_tilemap
    ld scroll(ix), #0x00






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
call ren_switchBuffers

  
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEVUELVE EL VALOR DE UN TILE, DADO UNA  COLUMNA Y FILA
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: A -> COLUMNA (X)
;;          F -> FILA    (Y)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getTileByte:
    ld iy, #TScreenTilemapBack ;; TODO, inecesario posible parametro

ret




 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Desplaza el tilemap, modifica los punteros y dibuja una columa a la derecha o izquierda 
;;
;;INPUT -> scroll= h
;;         column = l
;;            BC = M_back_front_tileMAp
;;  scroll solo opero con un byte
;;  posible overflow
;;    ld bc, (#m_back_tileMap)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
scrollScreenTilemap::





    push hl                ;; Usamos la pila para guardar los dos parametros


    ;; Ahoramodificamos los valores de la structura
   ;;scr->pVideo   += 2*scroll; // Video memory starts now 2 bytes to the left or to the right
    ld a, h
    add a, h
    ld h, #0    ;; TODO, innecesario

    call AtoBCextendendsign ;; Como solo usamos un byte, y tenemos que operar en 2
                            ;; debemos de extender el signo
    push bc
    pop hl


    ld d, pVideo+1(iy)
    ld e, pVideo(iy)

    ex de,hl
    add hl,de
    

    ld pVideo+1(iy), h
    ld pVideo(iy), l

    pop hl
    push hl ;;Recuperamos los dos paremetos

;;   scr->pTilemap += scroll;
    ld a, h
    ld h, #0    ;;TODO, innecesario

    call AtoBCextendendsign ;; Extendemos signo
    push bc
    pop hl

    ld d, pTilemap+1(iy)
    ld e, pTilemap(iy)

    ex de,hl
    add hl,de
    

    ld pTilemap+1(iy), h
    ld pTilemap(iy), l

        pop hl
        push hl  ;;Recuperamos los dos paremtos


    ;;scr->scroll   += scroll;
    ld a, h
    ld h, #0    ;;innecesario

    call AtoBCextendendsign ;; Extendemmos signo
    push bc
    pop hl


    ld e, scroll(iy)

    ex de,hl
    add hl,de
    
    ld scroll(iy), l



    ;; Esperamos al raster

    ;; La clave del hardware scrolling es moficiar el puntero a memoria
  ;;ld l, scroll(iy)
  ;;call cpct_setVideoMemoryOffset_asm


    pop hl
    push hl ;; Recuperamos dos parametros, la L


    ;; Repintamos una columna, izquierda o derecha
    ld C, L    ;; X
    ld B, #0x00  ;; Y
    ld E, #1  ;; W
    ld D, #MAP_HEIGHT  ;; H
    ld A, #MAP_WIDTH ;; map_width

    ld h, pTilemap+1(iy)
    ld l, pTilemap(iy)
    push hl

    ld h, pVideo+1(iy)
    ld l, pVideo(iy)
    push hl

    call cpct_etm_drawTileBox2x4_asm






    pop hl


    ;; Debemos de borrar una serie de pixeles que que aparecen
    ;; al realizar escroll

    ;; TODO: Relizar un salto para pintar una u otra dependiendo del movieminto
    ;;

    ld a, #0
    cp h


  ;; pointer to screen
    ld d, pVideo+1(iy) ;; memory pointer
    ld e, pVideo(iy)

    ld c,#0  ;x
    ld b,#4*MAP_HEIGHT  ;y
    call cpct_getScreenPtr_asm ;; return in hl

    ex de, hl ;;(2B DE) memory	Video memory pointer to the upper left box corner byte
    ld a,#0 ;;(1B A ) colour_pattern	1-byte colour pattern (in screen pixel format) to fill the box with
    ld c, #2  ;;(1B C ) width	Box width in bytes [1-64] (Beware!  not in pixels!)
    ld b, #8 ;;(1B B ) height	Box height in bytes (>0)

    call cpct_drawSolidBox_asm


    deleteFragment:

    ld d, pVideo+1(iy) ;; memory pointer
    ld e, pVideo(iy)

    dec de 
    dec de
    ld a,#0
    ld c, #2
    ld b, #8

    call cpct_drawSolidBox_asm

ret


