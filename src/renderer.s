.include "renderer.h.s"
.include "main.h.s"
.include "tileManager.h.s"





;; Posible problema de offset


.area _DATA

;; Define one Zero-terminated string to be used later on
string: .asciz "Menu";

.area _CODE


m_front_tileMap:: .dw #TScreenTilemapFront ;;
m_back_tileMap::  .dw #TScreenTilemapBack ;; 




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Intercambiamos los buffer
;; REGISTROS DESTRUIDOS: HL, BC, DE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_initBuffers:
  ld hl, #0x8000
  ld (hl), #0
  ld de, #0x8000 + 1
  ld bc, #0x4000 - 1
  ldir
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Comprueba si DrawableEntity esta dentro de la ventana
;; REGISTROS DESTRUIDOS: A
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
  call ren_DWisInScreen
  cp #0
  ret z

  ld hl, (#m_back_tileMap)
  push hl
  pop iy


  ;; Repintamos una columna, izquierda o derecha

  ;; A la X le restamos el scroll para solucionar el problema de borrado  el scroll hardware 
  ld a, de_x(ix)    ;; X
  ld c, scroll(iy)
  sub c
  ld c, a

  ld B, de_y(ix)  ;; Y


  ld E, de_w(ix)  ;; W
  ld D, de_h(ix)  ;; W


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
  call ren_DWisInScreen
  cp #0
  ret z

  ld hl, (#m_back_tileMap)
  push hl
  pop iy


  ;; Repintamos una columna, izquierda o derecha

  ;; A la X le restamos el scroll para solucionar el problema de borrado  el scroll hardware 
  ld a, de_oldx(ix)    ;; X
  ld c, scroll(iy)
  sub c
  ld c, a

  ld B, de_oldy(ix)  ;; Y


  ld E, de_w(ix)  ;; W
  ld D, de_h(ix)  ;; W


  ld A, #MAP_WIDTH ;; map_width

  
  ld h, pTilemap+1(iy)
  ld l, pTilemap(iy)
  push hl


  ld h, pVideo+1(iy)
  ld l, pVideo(iy)
  
  push hl

  call cpct_etm_drawTileBox2x4_asm

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pintamos el hud en la pantalla
;; DESTRUIDOS: A, BC, DE, HL, IY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_drawHud:

  ld hl, (#m_back_tileMap)
  push hl
  pop iy

  ;; pointer to screen
  ld d, pVideo+1(iy) ;; memory pointer
  ld e, pVideo(iy)

  ld c,#0  ;x
  ld b,#4*MAP_HEIGHT - 16  ;y
  call cpct_getScreenPtr_asm ;; return in hl

  ex de, hl ;;(2B DE) memory	Video memory pointer to the upper left box corner byte
  ld a,#0xFF ;;(1B A ) colour_pattern	1-byte colour pattern (in screen pixel format) to fill the box with
  ld c, #64  ;;(1B C ) width	Box width in bytes [1-64] (Beware!  not in pixels!)
  ld b, #16 ;;(1B B ) height	Box height in bytes (>0)

  call cpct_drawSolidBox_asm




  ;; Set up draw char colours before calling draw string
  ld    h, #0         ;; D = Background PEN (0)
  ld    l, #3         ;; E = Foreground PEN (3)

  call cpct_setDrawCharM0_asm   ;; Set draw char colours

  ;; Calculate a video-memory location for printing a string
  ld   de, #0xC000 ;; DE = Pointer to start of the screen
  ld    b, #24                  ;; B = y coordinate (24 = 0x18)
  ld    c, #16                  ;; C = x coordinate (16 = 0x10)

  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

  ;; Print the string in video memory
  ;; HL already points to video memory, as it is the return
  ;; value from cpct_getScreenPtr_asm
  ld   iy, #string    ;; IY = Pointer to the string 

  call cpct_drawStringM0_asm  ;; Draw the string



  ;; Calculate a video-memory location for printing a string
  ld   de, #0x8000 ;; DE = Pointer to start of the screen
  ld    b, #24                  ;; B = y coordinate (24 = 0x18)
  ld    c, #16                  ;; C = x coordinate (16 = 0x10)

  call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL

  ;; Print the string in video memory
  ;; HL already points to video memory, as it is the return
  ;; value from cpct_getScreenPtr_asm
  ld   iy, #string    ;; IY = Pointer to the string 

  call cpct_drawStringM0_asm  ;; Draw the string

ret