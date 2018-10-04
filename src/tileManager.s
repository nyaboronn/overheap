.include "cpctelera.h.s"
.include "tileManager.h.s"
.include "utils.h.s"
.include "main.h.s"
 




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEVUELVE EL VALOR DE UN TILE, DADO UNA  COLUMNA Y FILA
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: A -> COLUMNA (X)
;;          F -> FILA    (Y)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getTileByte:
    ld iy, #TScreenTilemap ;; TODO, inecesario posible parametro



ret





 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Desplaza el tilemap, modifica los punteros y dibuja una columa a la derecha o izquierda 
;;
;;INPUT -> scroll= h
;;         column = l
;;
;;  scroll solo opero con un byte
;;  posible overflow
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
scrollScreenTilemap::


    ld ix, #TScreenTilemap ;; TODO, inecesario posible parametro
    push hl                ;; Usamos la pila para


    ;; Ahoramodificamos los valores de la structura
   ;;scr->pVideo   += 2*scroll; // Video memory starts now 2 bytes to the left or to the right
    ld a, h
    add a, h
    ld h, #0    ;; TODO, innecesario

    call AtoBCextendendsign ;; Como solo usamos un byte, y tenemos que operar en 2
                            ;; debemos de extender el signo
    push bc
    pop hl


    ld d, pVideo+1(ix)
    ld e, pVideo(ix)

    ex de,hl
    add hl,de
    

    ld pVideo+1(ix), h
    ld pVideo(ix), l

        pop hl
        push hl

;;   scr->pTilemap += scroll;
    ld a, h
    ld h, #0    ;;TODO, innecesario

    call AtoBCextendendsign ;; Extendemos signo
    push bc
    pop hl

    ld d, pTilemap+1(ix)
    ld e, pTilemap(ix)

    ex de,hl
    add hl,de
    

    ld pTilemap+1(ix), h
    ld pTilemap(ix), l

        pop hl
        push hl


    ;;scr->scroll   += scroll;
    ld a, h
    ld h, #0    ;;innecesario

    call AtoBCextendendsign ;; Extendemmos signo
    push bc
    pop hl


    ld e, scroll(ix)

    ex de,hl
    add hl,de
    
    ld scroll(ix), l



    ;; Esperamos al raster
    call cpct_waitVSYNC_asm

    ;; La clave del hardware scrolling es moficiar el puntero a memoria
    ld l, scroll(ix)
    call cpct_setVideoMemoryOffset_asm


    pop hl
    push hl


    ;; Repintamos una columna, izquierda o derecha
    ld C, L    ;; X
    ld B, #0x00  ;; Y
    ld E, #1  ;; W
    ld D, #MAP_HEIGHT  ;; H
    ld A, #MAP_WIDTH ;; map_width

    ld h, pTilemap+1(ix)
    ld l, pTilemap(ix)
    push hl

    ld h, pVideo+1(ix)
    ld l, pVideo(ix)
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
    ld d, pVideo+1(ix) ;; memory pointer
    ld e, pVideo(ix)

    ld c,#0  ;x
    ld b,#4*MAP_HEIGHT  ;y
    call cpct_getScreenPtr_asm ;; return in hl

    ex de, hl
    ld a,#0
    ld c, #2
    ld b, #8

    call cpct_drawSolidBox_asm


    deleteFragment:

    ld d, pVideo+1(ix) ;; memory pointer
    ld e, pVideo(ix)

    dec de
    dec de
    ld a,#0
    ld c, #2
    ld b, #8

    call cpct_drawSolidBox_asm

ret


