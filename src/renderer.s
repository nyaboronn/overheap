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


.include "renderer.h.s"
.include "main.h.s"
.include "tileManager.h.s"
.include "hero.h.s"
.include "sprite.h.s"





;; Posible problema de offset


.area _DATA

;; Define one Zero-terminated string to be used later on

.area _CODE


m_front_tileMap:: .dw #TScreenTilemapFront ;;
m_back_tileMap::  .dw #TScreenTilemapBack ;; 




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Intercambiamos los buffer
;; REGISTROS DESTRUIDOS: HL, BC, DE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_initBuffers:
  ld hl, #0x8000
  ld (hl), #0x00
  ld de, #0x8000 + 1
  ld bc, #0x4000 - 1
  ldir

  ld hl, #0xC000
  ld (hl), #0x00
  ld de, #0xC000 + 1
  ld bc, #0x4000 - 1
  ldir


ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Comprueba si DrawableEntity esta dentro de la ventana
;; REGISTROS DESTRUIDOS: A,b
;; Parametro Entrada IX : DrawableEntity
;; Return: A      A= 0 si no esta dentro de la ventana
;;                A= 1 Si si esta dentro de la ventana
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_DWisInScreen:
  ld iy, (#m_back_tileMap)

  ;; 0 < Offset + WinSize - X(ix) +MAP_WIDTH  < winSize +MAP_WIDTH
  ld a, scroll(iy)
  ld b, #SCR_TILE_WIDTH
  add a, b
  ld b, de_x(ix)
  sub a, b
  ld b,#MAP_WIDTH
  add a, b
  cp #SCR_TILE_WIDTH + #MAP_WIDTH 

  jr c, pertenece
  ld a, #0
  ret

  pertenece:

  cp  #MAP_WIDTH + 4 -1
  jr nc, pertenece2
  ld a, #0
  ret


  pertenece2:
  ld a,#1
ret	



ren_DWisInScreenDelete:
  ld iy, (#m_back_tileMap)

  ;; 0 < Offset + WinSize - X(ix) +MAP_WIDTH  < winSize +MAP_WIDTH
  ld a, scroll(iy)
  ld b, #SCR_TILE_WIDTH
  add a, b
  ld b, de_oldx(ix)
  sub a, b
  ld b,#MAP_WIDTH
  add a, b
  cp #SCR_TILE_WIDTH + #MAP_WIDTH + 1

  jr c, pertenecee
  ld a, #0
  ret

  pertenecee:

  cp  #MAP_WIDTH + 4 -1
  jr nc, pertenece22
  ld a, #0
  ret


  pertenece22:
  ld a,#1
ret	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Intercambiamos los buffer
;; REGISTROS DESTRUIDOS: A,B, IY,HL
;; Parametro Entrada IY : TILEMAPScreen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_switchBuffers:
    

    ld hl, (#m_back_tileMap)
    push hl
    ld hl, (#m_front_tileMap)
    ld (#m_back_tileMap),hl
    pop hl
    ld  (#m_front_tileMap),hl


    push hl
    pop iy
    ld b, pVideo+1(iy)

    srl b
    srl b
    ld l,b
    call  cpct_setVideoMemoryPage_asm

  ld l, scroll(iy)
  call cpct_setVideoMemoryOffset_asm


ret




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: A, BC, DE, HL, IY
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_drawEntity:

  call ren_DWisInScreen
  cp #0
  ret z

  ;;  ld de, #0xC000       ;;Comienzo memoria de video
  ld hl, (#m_back_tileMap)
  push hl
  pop iy
  ld d, pVideo+1(iy)
  ld e, #0 ;pVideo(iy)



  ;; Convert de X tile in X in bytes
  ld C, de_x(ix)    ;; X
  ld A, de_x(ix)    ;; X
  add a,c
  ld c, a
  ;; Convert de y tile in y in bytes
  ld b, de_y(ix)    ;; y
  ld A, de_y(ix)    ;; y
  add a,b
  add a,a
  ld b, a

  ;; ld     b, de_y(ix)         ;; B = Entity Y
  call cpct_getScreenPtr_asm ;; RETURN IN HL

  ex    de, hl   ;; DE = Puntero a memoria


  ld h, de_sprite+1(ix)
  ld l, de_sprite(ix)
  ;;(2B HL) sprite	Source Sprite Pointer (array with pixel and mask data)
                    ;;(2B DE) memory	Destination video memory pointer
  ld  c, de_w(ix)   ;; Ancho ; ld c, #4              ;;(1B C ) width	Sprite Width in bytes (>0) (Beware, not in pixels!)
  ld  a, de_w(ix)
  add a,c 
  ld c, a


  ld  b, de_h(ix)   ;; alto ;; ld b, #16             ;;(1B B ) height	Sprite Height in bytes (>0)
  ld  a, de_h(ix)
  add a,b
  add a,a 
  ld b, a

  call cpct_drawSprite_asm

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: A, BC, DE, HL, IY
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_drawEntityAlpha:

  call ren_DWisInScreen
  cp #0
  ret z


  ;;  ld de, #0xC000       ;;Comienzo memoria de video
  ld hl, (#m_back_tileMap)
  push hl
  pop iy
  ld d, pVideo+1(iy)
  ld e, #0 ;pVideo(iy)



  ;; Convert de X tile in X in bytes
  ld C, de_x(ix)    ;; X
  ld A, de_x(ix)    ;; X
  add a,c
  ld c, a
  ;; Convert de y tile in y in bytes
  ld b, de_y(ix)    ;; y
  ld A, de_y(ix)    ;; y
  add a,b
  add a,a
  ld b, a

  ;; ld     b, de_y(ix)         ;; B = Entity Y
  call cpct_getScreenPtr_asm ;; RETURN IN HL

  ex    de, hl   ;; DE = Puntero a memoria

  ; ld  b, de_h(ix)   ;; alto
  ; ld A, de_h(ix)    ;; y
  ; add a,b
  ; add a,a
  ; ld b, a
  ;
  ; ld  c, de_w(ix)   ;; Ancho
  ; ld A, de_w(ix)    ;; X
  ; add a,c
  ; ld c, a
  ;  ld  a, de_col(ix)   ;; Color
  ; 
  ; call cpct_drawSolidBox_asm


  ; pvmem = cpct_getScreenPtr(CPCT_VMEM_START, x, y);      
  ; cpct_drawSpriteMasked(G_sprite_EMR, pvmem, SPR_W, SPR_H);


  ld h, de_sprite+1(ix)
  ld l, de_sprite(ix)
  ;;(2B HL) sprite	Source Sprite Pointer (array with pixel and mask data)
                  ;;(2B DE) memory	Destination video memory pointer
  ld  c, de_w(ix)   ;; Ancho ; ld c, #4              ;;(1B C ) width	Sprite Width in bytes (>0) (Beware, not in pixels!)
  ld  a, de_w(ix)
  add a,c 
  ld c, a


  ld  b, de_h(ix)   ;; alto ;; ld b, #16             ;;(1B B ) height	Sprite Height in bytes (>0)
  ld  a, de_h(ix)
  add a,b
  add a,a 
  ld b, a

  call cpct_drawSpriteMasked_asm

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Destruir entidad, la diferencia con limpiar es que ay que llamar cuando 
;; El objeto a sido destruido por una colision o algo asi
;; REGISTROS DESTRUIDOS: A, BC, DE, HL, IY
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_DestroyEntity:

  ;; TODO, no borro la bala que se queda al final

  ld hl, (#m_front_tileMap)
  push hl
  pop iy



  ;; A la X le restamos el scroll para solucionar el problema de borrado  el scroll hardware 
  ld a, de_x(ix)    ;; X
  ld c, scroll(iy)
  sub c
  ld c, a


  ld B, de_y(ix)  ;; Y


  ld E, de_w(ix)  ;; W
  ld D, de_h(ix)  ;; h


  ld A, #MAP_WIDTH ;; map_width

  
  ld h, pTilemap+1(iy)
  ld l, pTilemap(iy)
  push hl


  ld h, pVideo+1(iy)
  ld l, pVideo(iy)
  
  push hl

  call cpct_etm_drawTileBox2x4_asm



ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_clearEntity:

  ;; TODO, no borro la bala que se queda al final
  call ren_DWisInScreenDelete
  cp #0
  jr nz, nodestroy

;
ret
  nodestroy:

  

  ld hl, (#m_back_tileMap)
  push hl
  pop iy


  ;; Repintamos una columna, izquierda o derecha

  ;; A la X le restamos el scroll para solucionar el problema de borrado  el scroll hardware 
  ld a, de_oldx(ix)    ;; X
  dec a
  ld c, scroll(iy)
  sub c
  ld c, a
  

  ld B, de_oldy(ix)  ;; Y


  ld E, de_w(ix)  ;; W
  inc e
  ld D, de_h(ix)  ;; h


  ld A, #MAP_WIDTH ;; map_width

  
  ld h, pTilemap+1(iy)
  ld l, pTilemap(iy)
  push hl


  ld h, pVideo+1(iy)
  ld l, pVideo(iy)
  
  push hl

  call cpct_etm_drawTileBox2x4_asm

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Pintamos el hud en la pantalla
;;;
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
corazon: .db #0

ren_drawHud:
	  ld  a, hero_vida(ix)

pintar_vidas:
	push af		;;Guardo las vidas que tenía visitadas

    ld hl, (#m_back_tileMap)
    push hl
    pop iy

  ;; pointer to screen
    ld d, pVideo+1(iy) ;; memory pointer
    ld e, pVideo(iy)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Pintar el Corazón de la vida          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
    ld a, (corazon)
    ld c, a ;x
    ld b,#4*MAP_HEIGHT - 12  ;y
    call cpct_getScreenPtr_asm ;; return in hl
    
    ex de, hl ;;(2B DE) memory	Video memory pointer to the upper left box corner byte
	ld  hl, #_g_hearth;;Imagen que voy a pintar
    ld  c, #8    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
	ld  b, #12   ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
	call cpct_drawSprite_asm

    
	ld	a, (corazon)
	add a, #8
  	ld (corazon), a
	pop af		;;Devuelvo las vidas visitadas
	
	dec a		;;Vida pintada, decremento
    cp #0
    jp	nz, pintar_vidas

	ld a, #0    ;;Resetamos el valor de la variable, para la siguiente ejecución
	ld (corazon), a

 call ren_clearHeart
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Carga sieguiente mapa        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next_stage:
;;1
    ld hl, (#m_back_tileMap)
    push hl
    pop iy

    ;; pointer to screen
    ld d, pVideo+1(iy) ;; memory pointer
    ld e, pVideo(iy)

	ld c, #23 ;x    
	ld b, #5 ;y
    call cpct_getScreenPtr_asm ;; return in hl

	ex de, hl ;;(2B DE) memory	Video memory pointer to the upper left box corner byte
	ld  hl, #_round_sp;; Cojo la segunda parte
    ld  c, #32    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
    ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
    call cpct_drawSprite_asm
;;;;2
;;	 ld hl, (#m_back_tileMap)
;;    push hl
;;    pop iy
;;
;;    ;; pointer to screen
;;    ld d, pVideo+1(iy) ;; memory pointer
;;    ld e, pVideo(iy)
;;
;;	ld c, #3 ;x    
;;	ld b, #100;y
;;    call cpct_getScreenPtr_asm ;; return in hl
;;
;;	ex de, hl ;;(2B DE) memory	Video memory pointer to the upper left box corner byte
;;	ld  hl, #_Restart_sp;; Cojo la segunda parte
;;    ld  c, #29    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
;;    ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
;;    call cpct_drawSprite_asm
;;3
ld hl, (#m_back_tileMap)
    push hl
    pop iy

    ;; pointer to screen
    ld d, pVideo+1(iy) ;; memory pointer
    ld e, pVideo(iy)

	ld c, #29 ;x    
	ld b, #100;y
    call cpct_getScreenPtr_asm ;; return in hl

	ex de, hl ;;(2B DE) memory	Video memory pointer to the upper left box corner byte
	ld  hl, #_Next_sp;; Cojo la segunda parte
    ld  c, #18    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
    ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
    call cpct_drawSprite_asm

;;Cambio el buffer	
	call ren_switchBuffers
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Carga pantalla final      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
final_stage:


;;1
    ld hl, (#m_back_tileMap)
    push hl
    pop iy

    ;; pointer to screen
    ld d, pVideo+1(iy) ;; memory pointer
    ld e, pVideo(iy)

	ld c, #25 ;x    
	ld b, #5 ;y
    call cpct_getScreenPtr_asm ;; return in hl

	ex de, hl ;;(2B DE) memory	Video memory pointer to the upper left box corner byte
	ld  hl, #_youLost_sp;; Cojo la segunda parte
    ld  c, #27    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
    ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
    call cpct_drawSprite_asm
;2
	 ld hl, (#m_back_tileMap)
    push hl
    pop iy

    ;; pointer to screen
    ld d, pVideo+1(iy) ;; memory pointer
    ld e, pVideo(iy)

	ld c, #25 ;x    
	ld b, #100;y
    call cpct_getScreenPtr_asm ;; return in hl

	ex de, hl ;;(2B DE) memory	Video memory pointer to the upper left box corner byte
	ld  hl, #_Restart_sp;; Cojo la segunda parte
    ld  c, #29    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
    ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
    call cpct_drawSprite_asm

	;;Cambio el buffer	;;Posible cambio en un futuro
	call ren_switchBuffers

ret
 
rondas_stage:
;;1
    ld hl, (#m_back_tileMap)
    push hl
    pop iy

    ;; pointer to screen
    ld d, pVideo+1(iy) ;; memory pointer
    ld e, pVideo(iy)

	ld c, #25 ;x    
	ld b, #5 ;y
    call cpct_getScreenPtr_asm ;; return in hl

	ex de, hl ;;(2B DE) memory	Video memory pointer to the upper left box corner byte
	ld  hl, #_win_sp;; Cojo la segunda parte
    ld  c, #23    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
    ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
    call cpct_drawSprite_asm
    ;;Cambio el buffer	;;Posible cambio en un futuro

    ld hl, (#m_back_tileMap)
    push hl
    pop iy

    ;; pointer to screen
    ld d, pVideo+1(iy) ;; memory pointer
    ld e, pVideo(iy)

	ld c, #25 ;x    
	ld b, #100;y
    call cpct_getScreenPtr_asm ;; return in hl

	ex de, hl ;;(2B DE) memory	Video memory pointer to the upper left box corner byte
	ld  hl, #_Restart_sp;; Cojo la segunda parte
    ld  c, #29    ;Bytes width se tiene que meter en bytes, en modo 0 1 byte = 2 píxeles y entre [1-63]
    ld  b, #8 ;;#160    ;Pixels height puede ser el valor que sea dentro de la pantalla > 0 y es el mismo en bytes que en píxeles
    call cpct_drawSprite_asm

	call ren_switchBuffers

ret



  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Borramos el ultimo corazon
;;;
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


ren_clearHeart:
	ld  a, hero_vida(ix)


;;bucle sumando la X

;;cuando la X este listo salimos del bucle, y se borra

pintar_vidasc:

  cp #0
  jp	z, clearHeart

	push af		;;Guardo las vidas que tenía visitadas


    
	ld	a, (corazon)
	add a, #4
	ld (corazon), a
	pop af		;;Devuelvo las vidas visitadas
  
  dec a

  jr pintar_vidasc


  clearHeart:

   ld hl, (#m_back_tileMap)
    push hl
    pop iy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Pintar el Corazón de la vida          ;;Hacer con el bucle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; push de   ;;El valor del puntero se va a la pila

    ld a, (corazon)

    ld c, a

  ld b,#43   ;y

  ld E, #4  ;; W
  ld D, #3  ;; h 

  ld A, #MAP_WIDTH ;; map_width

  ld h, pTilemap+1(iy)
  ld l, pTilemap(iy)
  push hl


  ld h, pVideo+1(iy)
  ld l, pVideo(iy)
  
  push hl

  call cpct_etm_drawTileBox2x4_asm


   ld hl, (#m_front_tileMap)
    push hl
    pop iy

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Pintar el Corazón de la vida          ;;Hacer con el bucle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; push de   ;;El valor del puntero se va a la pila

    ld a, (corazon)

    ld c, a

  ld b,#43   ;y

  ld E, #4  ;; W
  ld D, #3  ;; h 

  ld A, #MAP_WIDTH ;; map_width

  ld h, pTilemap+1(iy)
  ld l, pTilemap(iy)
  push hl


  ld h, pVideo+1(iy)
  ld l, pVideo(iy)
  
  push hl

  call cpct_etm_drawTileBox2x4_asm

	ld a, #0    ;;Resetamos el valor de la variable, para la siguiente ejecución
	ld (corazon), a


  ret


