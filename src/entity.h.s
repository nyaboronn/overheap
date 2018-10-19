.include "renderer.h.s"


;###########################################################################
;#### FICHERO: entity.h.s
;###########################################################################
.macro DefineEntity _name, _x, _y,_oldx, _oldy, _vx, _vy, _w, _h, _col, _upd, _tile
_name:
DefineDrawableEntity _name'_dw, _x, _y,_oldx, _oldy, _w, _h, _col
   .db   _vx, _vy     ;; VX, VY
   .dw   _upd         ;; Update
   .dw _tile

.endm

e_de = 0
e_de_size = 8
e_vx = 0 + e_de_size  
e_vy = 1 + e_de_size
e_up_l = 2 + e_de_size
e_up_h = 3 + e_de_size
e_tile_l = 4 + e_de_size
e_tile_h = 5 + e_de_size


.macro DefineEntityDefault _name, _suf

    DefineEntity _name'_suf, 0xAA, 0, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF, 0x0000

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Array de entidades
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineNEntities _name, _n

    _c = 0

    .rept _n
        DefineEntityDefault _name, \_c
        _c = _c + 1
    .endm

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GLOBAL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ent_move
.globl ent_draw
.globl ent_clear
.globl ent_update
.globl ent_copy
.globl ent_new
.globl ent_doForAll
.globl ent_initialTile
.globl ent_getActualTile
;; m.......
.globl CalcualteOFFSET
.globl ent_is_solidTile
