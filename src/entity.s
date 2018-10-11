.include "cpctelera.h.s"
.include "tileManager.h.s"
.include "main.h.s"
.include "utils.h.s"

.include "obstacle.h.s"
.include "entity.h.s"
.include "enemy.h.s"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;CONSTANTES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
k_max_num_ent   = 9
k_entity_size   = 9
m_num_ent:      .db 00
m_next_entity:  .dw entity_vector0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Entidades
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DefineNEntities entity_vector, 9
DefineEntity    enemy_data, 10, 20, 0x00, 0x00, 0x02, 0x04, 0xFF, enm_move, 0x0000



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve 0 si la tile donde esta la entidad en solida
;; Distinto de cero en caso contrario
;; REGISTROS DESTRUIDOS: 
;; ENTRADA: 
;;          IX -> Entity
;; SALIDA: 
;;          A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_is_solidTile:
    call    ent_getActualTile

    bit     #7, a
    ld      a,  #0
    ret z
    ld      a,  #-2
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REGISTROS DESTRUIDOS: DE, HL
;; SALIDA:
;;          HL -> ptr a tile donde estas inicial
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_initialTile:
    ld      hl, #_g_tilemap
    ld      de, #0x1338
    add     hl, de
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve el tile en el que se encuentra la entidad
;; REGISTROS DESTRUIDOS:  HL, A
;; ENTRADA: 
;;          IX -> Puntero a entidad
;; SALIDA: 
;;          A -> ptr a tile donde estas inicial
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_getActualTile:
    ld  h,  e_tile_h(ix)
    ld  l,  e_tile_l(ix)
    ld  A,  (hl)
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REGISTRA UNA NUEVA ENTIDAD
;; REGISTROS DESTRUIDOS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_new:
    ld      a,  (m_num_ent)
    inc     a
    ld      (m_num_ent), a

    ld      hl,     (m_next_entity)     ;; 0x10FF  +  9 = 0x1008
    ld      bc,     #k_entity_size
    add     hl,     bc
    ld      (m_next_entity), hl
    ld      bc,     #-k_entity_size     ;; O podemos usar sbc(restar con acarreo)       or  a       Quitamos el acarreo en el caso de que se genere a or a = a Acarreo 0
    add     hl,     bc                  ;;Se cambia por las 2   sbc hl, bc
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; COPIA LOS VALORES DE UNA ENTIDAD SOBRE OTRA
;;; REGISTROS DESTRUIDOS:
;;; ENTRADA: 
;;;        HL -> ENTIDAD ORIGEN
;;;        DE -> EMTODAD DESTINO
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_copy:
    ld bc, #k_entity_size
    ldir
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; ENTRADA 
;;          HL -> PUNTERO AL MÉTODO A EJECUTAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_doForAll:
    ld  a,  (m_num_ent)
    ld  ix, #entity_vector0
    ld  (metodo), hl
 buc:
        push    af
        metodo  = . + 1     ;; . es la dir.mem en la que estoy si le sumo 1 es el call
        call    ent_draw
        pop     af
        ld      bc, #k_entity_size
        add     ix, bc
        ;;
        dec a
        jr nz, buc

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_draw:
    ld  de, #0xC000       ;;Comienzo memoria de video

    ;; Convert de X tile in X in bytes
    ld  C,  e_x(ix)    ;; X
    ld  A,  e_x(ix)    ;; X
    add a,  c
    ld  c,  a
    ;; Convert de y tile in y in bytes
    ld  b,  e_y(ix)    ;; y
    ld  A,  e_y(ix)    ;; y
    add a,  b
    add a,  a
    ld  b,  a

    ;; ld     b, e_y(ix)         ;; B = Entity Y
    call  cpct_getScreenPtr_asm

    ex    de, hl   ;; DE = Puntero a memoria

    ld    b,  e_h(ix)   ;; alto
    ld    A,  e_h(ix)    ;; y
    add   a,  b
    add   a,  a
    ld    b,  a

    ld    c,  e_w(ix)   ;; Ancho
    ld    A,  e_w(ix)    ;; X
    add   a,  c
    ld    c,  a
    ld    a, e_col(ix)   ;; Color

    call cpct_drawSolidBox_asm
 
  ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BORRA UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF',AF, BC, DE, HL
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_clear:
    ;; Repintamos una columna, izquierda o derecha
    ld  C,  e_x(ix)    ;; X
    ld  B,  e_y(ix)  ;; Y
    ld  E,  e_w(ix)  ;; 
    ld  D,  e_h(ix)  ;; H
    ld  A,  #MAP_WIDTH ;; map_width

    ld  iy, #TScreenTilemap
    
    ld  h,  pTilemap+1(iy)
    ld  l,  pTilemap(iy)
    push hl

    ld  h,  pVideo+1(iy)
    ld  l,  pVideo(iy)
    push hl

    call    cpct_etm_drawTileBox2x4_asm
 
    ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: TODOS
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_update:
    ;; Puntero a la función que actualiza la entidad
    ld  h, e_up_h(ix)
    ld  l, e_up_l(ix)
    jp  (hl)

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVER UNA ENTIDAD
;; REGISTROS DESTRUIDOS: af, hl,de
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_move:
    ;;Sumamos velocidad X a posicion X
    ld      a, e_x(ix)
    add     e_vx(ix)
    ld      e_x(ix), a

    ;;Recogemos la coordenados y la cuerdamos en la pila,(variable local)
    ld      h, e_tile_h(ix)
    ld      l, e_tile_l(ix)
    push hl

    call CalcualteOFFSET

    ;;Sumamos velocidad al tile,para cambiar
    ld      e_tile_h(ix) , h
    ld      e_tile_l(ix), l

    ;;check if entity is in a solid tile
    ;;Cambiar logica del if, porque no estabamos usando el bit mas significativo para representar la colision
    call    ent_is_solidTile ;; Devuelve en B true o false
    jr z, checkY

    ;; Check if entity has a collision with an obstacle
    ;ld    iy, #obstacle1
    ; Call to function
    ;call	obstacle_checkCollision
    ;If collide dont move (A == 0) exit function
    ;Else revet changes in e_x and e_y
    ;cp #0
    ;jr z, exit

    pop hl ;;para restaurar el puntero a la tile actual
    push hl

    ld      a, e_x(ix)
    sub     e_vx(ix)
    ld      e_x(ix), a

    ;;restauramos puntero
    ld      e_tile_h(ix) , h
    ld      e_tile_l(ix), l

    checkY:
        pop hl
        ;;; Sumamos velocidad Y a posicion Y, ademas añadimos una unidad a Y para simular una caida constante
        ;ld      a, e_y(ix)
        ;add     e_vy(ix)
        ;inc a
        ;ld      e_y(ix), a
        ;; Recogemos la coordenados y la cuerdamos en la pila,(variable local)
        ld h, e_tile_h(ix)
        ld l, e_tile_l(ix)

        push hl

        call CalcualteOFFSET

        ;; Sumamos velocidad al tile,para cambiar
        ld  e_tile_h(ix) , h
        ld  e_tile_l(ix), l

        ;; check if entity is in a solid tile
        ;; Cambiar logica del if, porque no estabamos usando el bit mas significativo para representar la colision
        call    ent_is_solidTile ;; Devuelve en B true o false
        jr z,   exit

        ;; Check if entity has a collision with an obstacle
        ;ld    iy, #obstacle1
        ; Call to function
        ;call	obstacle_checkCollision
        ;If collide dont move (A == 0) exit function
        ;Else revet changes in e_x and e_y
        ;cp #0
        ;jr z, exit

    resetY:
        pop     hl ;; para restaurar el puntero a la tile actual
        push    hl

        ld       a, e_y(ix)
        sub     e_vy(ix)
        dec a
        ld      e_y(ix), a

        ;;restauramos puntero
        ld      e_tile_h(ix) , h
        ld      e_tile_l(ix), l

    exit:
        ;;pop ix
        pop hl
        ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Calculate the offset of the first tile of the box inside the tilemap and add it
;; to the main tilemap pointer (ptilemap)
;; Offset = y * map_width + x
;; HL = ptilemap + Offset
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CalcualteOFFSET: 
    ld  hl, #_g_tilemap             ;; [3] HL=ptilemap 
    ld  a,  e_x(ix)                 ;; [1]   | HL = ptilemap + x

    add__hl_a                       ;; [5]   |  
    ld  de, #120                    ;; [3] DE = map_width
    ld  a,  e_y(ix)                 ;; [1] A = y 
    cp  a                           ;; [1] Reset Carry Flag (Required for multiplying)
    
    mult_de_a                       ;; [11-83] HL += DE * A (HL = y * map_width + x) ;; A * C + 
                                    ;; HL now points to the next tile to draw from the tilemap!
    ret