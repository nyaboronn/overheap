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

.globl _sprite_bala

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINIR UN OBSTACULO A PARTIR DE UNA ENTIDAD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineObstacle _name, _x, _y,  _w, _h, _sprite, _upd, _alive

        DefineEntity _name, _x, _y,  _w, _h, _sprite, _upd
        .db _alive

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINIR UN OBSTACULO POR DEFECTO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineObstacleDefault _name, _suf

    DefineObstacle _name'_suf, 10, 10, 1, 1, _sprite_bala, obs_move, 1

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINIR UN ARRAY DE OBSTACULOS POR DEFECTO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineNObstacles _name, _n

    _c = 0

    .rept _n
        DefineObstacleDefault _name, \_c
        _c = _c + 1
    .endm

.endm



e_de_size = 7
o_alive = 6 + e_de_size 



;;;; FUNCTIONS
.globl obs_draw
.globl obs_clear
.globl obs_update

.globl obs_move
.globl obs_copy
.globl obs_new
.globl obs_doForAll
.globl obs_doForAllBool


.globl obs_checkCollision
.globl obs_no_collision

