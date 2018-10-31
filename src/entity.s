
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


.include "tileManager.h.s"
.include "utils.h.s"
.include "entity.h.s"

;; constantes
k_max_num_ent   = 9
k_entity_size   = 9
m_num_ent:      .db 00
m_next_entity:  .dw entity_vector0

;; Array de Entidades
DefineNEntities entity_vector, 9


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve 0 si la tile donde esta la entidad en solida
;; Distinto de -1 en caso contrario
;; REGISTROS DESTRUIDOS: A, HL, DE
;; ENTRADA: 
;;          IX -> Entity
;; SALIDA: 
;;          A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_is_solidTile:

    ld  h,  e_tile_h(ix)
    ld  l,  e_tile_l(ix)
    inc hl ;; En vez de incrementar habria que hacerlo con el ancho - 1

    ld  A,  (hl)
    bit #7, a
    ld  a,  #0  ;;Esto es necesario=
    ret nz



    ld  a,  de_x(ix)
    add #3
    ld  de_x(ix),   a
    ld  a,  de_y(ix)
    add #3
    ld  de_y(ix),   a

    call CalcualteOFFSET

    ld  a,  de_y(ix)
    sub #3
    ld  de_y(ix),   a
    ld  a,  de_x(ix)
    sub #3
    ld  de_x(ix),   a

    ld  A,  (hl)
    bit #7, a
    ld  a,  #0  ;;Esto es necesario=
    ret nz


    ld  a,  de_y(ix)
    ;;inc a
    add #2
    ld  de_y(ix),   a
    call CalcualteOFFSET

    ld  a,  de_y(ix)
    ;;dec a
    sub #2
    ld  de_y(ix),   a

    ld  A,  (hl)
    bit #7, a
    ld  a,  #0  ;;Esto es necesario=
    ret nz


    ld a,   de_y(ix)
    ;;inc a
    add #3
    ld  de_y(ix),   a
    call CalcualteOFFSET

    ld  a,  de_y(ix)
    ;;dec a
    sub #3
    ld de_y(ix),    a

    ld  A,  (hl)
    bit #7, a
    ld  a,  #0  ;;Esto es necesario=
    ret nz
    
    call    ent_getActualTile

    bit     #7, a
    ld      a,  #0  ;;
    ret z

    ld      a,  #-1
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COPIA LOS VALORES DE UNA ENTIDAD SOBRE OTRA
;; REGISTROS DESTRUIDOS:
;; ENTRADA: 
;;        HL -> ENTIDAD ORIGEN
;;        DE -> EMTODAD DESTINO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_copy:
    ld bc, #k_entity_size
    
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
    call ren_drawEntity
ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BORRA UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF',AF, BC, DE, HL
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_clear:
    call ren_clearEntity
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Calculate the offset of the first tile of the box inside the tilemap and add it
;; to the main tilemap pointer (ptilemap)
;; Offset = y * map_width + x
;; HL = ptilemap + Offset
;; DESTRUIDOS: A, HL, DE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
CalcualteOFFSET: 
    ld  hl, #_g_tilemap             ;; [3] HL=ptilemap 
    ld  a,  de_x(ix)                 ;; [1]   | HL = ptilemap + x

    add__hl_a                       ;; [5]   |  
    ld  de, #120                    ;; [3] DE = map_width
    ld  a,  de_y(ix)                 ;; [1] A = y 
    cp  a                           ;; [1] Reset Carry Flag (Required for multiplying)
    
    mult_de_a                       ;; [11-83] HL += DE * A (HL = y * map_width + x) ;; A * C + 
                                    ;; HL now points to the next tile to draw from the tilemap!
ret
