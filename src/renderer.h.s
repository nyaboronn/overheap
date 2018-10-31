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


.macro DefineDrawableEntity _name, _x, _y, _w, _h, _sprite
    _name:
    .db    _x, _y       ;; X, Y
    .db    _x, _y ;; X, Y
    .db    _w, _h       ;; W, H
    .dw   _sprite       ;; Sprite
    _name'_size = . - _name
.endm

de_x = 0       
de_y = 1
de_oldx = 2    
de_oldy = 3
de_w = 4       
de_h = 5
de_sprite = 6

.globl ren_clearEntity

.globl ren_DestroyEntity
.globl ren_drawEntityAlpha
.globl ren_drawEntity
.globl ren_switchBuffers
.globl ren_initBuffers
.globl ren_drawHud
.globl ren_DWisInScreen

.globl m_front_tileMap
.globl m_back_tileMap

.globl next_stage
.globl final_stage
.globl rondas_stage