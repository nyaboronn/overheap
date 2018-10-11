;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _col, _upd, _tile

    _name:
        .db _x,     _y      ;; X,   Y
        .db _vx,    _vy     ;; VX,  VY
        .db _w,     _h      ;; W,   H
        .db _col            ;; Color
        .dw _upd            ;; Update
        .dw _tile

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Entidad por defecto
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEntityDefault _name, _suf

    DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF, 0x0000

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
;; Basta
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
e_x     = 0
e_y     = 1
e_vx    = 2
e_vy    = 3
e_w     = 4
e_h     = 5
e_col   = 6
e_up_l  = 7
e_up_h  = 8
e_tile_l = 9
e_tile_h = 10

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
