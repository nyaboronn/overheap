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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UN HERO A PARTIR DE UNA ENTIDAD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineHero _name, _x, _y,  _w, _h, _sprite, _upd, _jump, _vida,_direct



.endm


k_max_hero_balas = 2



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UN HERO QUE PUEDE DISPARAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineHeroShot _name, _x, _y,  _w, _h, _sprite, _upd, _jump, _vida,_direct

    DefineEntity _name, _x, _y,  _w, _h, _sprite, _upd
    .db  _direct        ;; Donde apunta    0 => left
    .db  _jump          ;; Jump State,    -1 if not jumping (can jump)
                        ;;                -2 if is falling  (cant jump)
    .db _vida           ;; Numero de Vidas
    .db 0               ;; aux

    .db k_max_hero_balas   ;; Maximo de objetos
    .db 0       ;; Número de obs creados
    .dw .+4              ;; Posicion actual en el array
    .db k_max_hero_balas     ;; Numero de Obs Usados
    .db 0  ;; Numero de Obs que colisionan

    DefineNObstacles _name'_suf, k_max_hero_balas

.endm

e_size = 14
hero_direct = 0 + e_size
hero_jump   = 1 + e_size
hero_vida   = 2 + e_size
hero_aux    = 3 + e_size

k_max_num_obs  = 4 + e_size
m_num_obs      = 5 + e_size
m_next_obs     = 6 + e_size
m_alive_obs    = 8 + e_size 
m_murieron_obs = 9 + e_size 
shot_array     = 10 + e_size



.globl hero_jumptable

.globl hero_data

.globl hero_moveKeyboard
.globl hero_wait4KeyboardInput
.globl hero_jumpControl
.globl hero_startJump

.globl hero_update
.globl hero_clear
.globl hero_draw
.globl hero_move

.globl hero_check_hit

.globl hero_default
.globl hero_default_no_vida