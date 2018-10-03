.macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _col, _upd, _jump
_name:
   .db    _x, _y      ;; X, Y
   .db   _vx, _vy     ;; VX, VY
   .db    _w, _h      ;; W, H
   .db   _col           ;; Color
   .dw   _upd         ;; Update
   .db  _jump         ;; Jump State,    -1 if not jumping (can jump)
                        ;;              -2 if is falling  (cant jump)
.endm

.macro DefineEntityDefault _name, _suf
   DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF, #-1
.endm

.macro DefineNEntities _name, _n
  _c = 0
  .rept _n
     DefineEntityDefault _name, \_c
     _c = _c + 1
  .endm
.endm


;;.macro ent_draw_default _pos, _y, _x, _de, _e_col, _e_h, _e_w
  ;  ent_draw #0xC000, 0x00,0x00, 0xC000, 0xFF, 0x02, 0x08
;;.endm



e_x = 0
e_y = 1
e_vx = 2
e_vy = 3
e_w = 4
e_h = 5
e_col = 6
e_up_l = 7
e_up_h = 8
e_jump = 9
 
 
.globl ent_draw
.globl ent_clear
.globl ent_update
.globl ent_copy
.globl ent_new
.globl hero_data
.globl enemy_data
.globl ent_doForAll