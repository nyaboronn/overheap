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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UNA ENTIDAD A PARTIR DE DrawableEntity
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEntity _name, _x, _y, _w, _h, _col, _upd

    _name:
        DefineDrawableEntity _name'_dw, _x, _y, _w, _h, _col
        .db   0, 0      ;; VX, VY
        .dw   _upd          ;; Update
        .dw  0x0000           ;; Tile

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UN ENTIDAD CON VALORES POR DEFECTO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEntityDefault _name, _suf

    DefineEntity _name'_suf, 0xAA, 0,  0, 0, 0, 0xFFFF

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ARRAY DE ENTIDADES POR DEFECTO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineNEntities _name, _n

    _c = 0

    .rept _n
        DefineEntityDefault _name, \_c
        _c = _c + 1
    .endm

.endm


e_de_size   = 8
e_vx        = 0 + e_de_size  
e_vy        = 1 + e_de_size
e_up_l      = 2 + e_de_size
e_up_h      = 3 + e_de_size
e_tile_l    = 4 + e_de_size
e_tile_h    = 5 + e_de_size


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GLOBAL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ent_draw
.globl ent_clear
.globl ent_update

.globl ent_copy
.globl ent_new
.globl ent_doForAll

.globl ent_initialTile
.globl ent_getActualTile

.globl CalcualteOFFSET
.globl ent_is_solidTile
