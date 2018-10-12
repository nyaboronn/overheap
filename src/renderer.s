.include "renderer.h.s"
.include "main.h.s"
.include "tileManager.h.s"


;; Posible problema de offset




m_front_tileMap:: .dw #TScreenTilemapFront ;;
m_back_tileMap::  .dw #TScreenTilemapBack ;; 




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Intercambiamos los buffer
;; REGISTROS DESTRUIDOS: A,B
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_initBuffers:
    ld hl, #0x8000
    ld (hl), #0
    ld de, #0x8000 + 1
    ld bc, #0x4000 - 1
    ldir
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
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_drawEntity:
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
  call cpct_getScreenPtr_asm
 
  ex    de, hl   ;; DE = Puntero a memoria

  ld  b, de_h(ix)   ;; alto
  ld A, de_h(ix)    ;; y
  add a,b
  add a,a
  ld b, a

  ld  c, de_w(ix)   ;; Ancho
  ld A, de_w(ix)    ;; X
  add a,c
  ld c, a
   ld  a, de_col(ix)   ;; Color
  
  call cpct_drawSolidBox_asm
 
  ret




  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ren_clearEntity:
 
    ld hl, (#m_back_tileMap)
    push hl
    pop iy


    ;; Repintamos una columna, izquierda o derecha

    ;; A la X le restamos el scroll para solucionar el problema de borrado  el scroll hardware 
    ld a, de_x(ix)    ;; X
    ld c, scroll(iy)
    sub c
    ld c, a
    dec c  ;; Restamos uno para borrar el posible anterior dibujo

    ld B, de_y(ix)  ;; Y
    dec b
    dec b
     dec b
    ;; Duplicamos el ancho para borrar
    ld A, de_w(ix)  ;; W
    add A
    ld E, A

    ;;Duplicamos el alto para borrar
    ld A, de_h(ix)  ;; W
    add A
    ld D, A

    
    ld A, #MAP_WIDTH ;; map_width

    
    ld h, pTilemap+1(iy)
    ld l, pTilemap(iy)
    push hl


    ld h, pVideo+1(iy)
    ld l, pVideo(iy)
    
    push hl

    call cpct_etm_drawTileBox2x4_asm

  ret