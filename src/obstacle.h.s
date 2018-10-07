o_x = 0
o_y = 1
o_w = 2
o_h = 3
o_col = 4

.macro DefineObstacle _name, _x, _y, _w, _h, _col
    _name:
        .db    _x, _y     ;; X, Y
        .db    _w, _h     ;; W, H
        .db    _col       ;; Color
.endm

.globl ent_draw_obs
.globl ent_clear_obs
.globl obstacle1
.globl obstacle_checkCollision
.globl hero_data