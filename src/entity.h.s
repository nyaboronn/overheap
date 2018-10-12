.include "renderer.h.s"


;###########################################################################
;#### FICHERO: entity.h.s
;###########################################################################
.macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _col, _upd, _jump, _tile
_name:
DefineDrawableEntity _name'_dw, _x, _y, _w, _h, _col
   .db   _vx, _vy     ;; VX, VY
   .dw   _upd         ;; Update
   .db  _jump         ;; Jump State,    -1 if not jumping (can jump)
                        ;;              -2 if is falling  (cant jump)
   .dw _tile

.endm

e_de = 0
e_de_size = 5
e_vx = 0 + e_de_size  
e_vy = 1 + e_de_size
e_up_l = 2 + e_de_size
e_up_h = 3 + e_de_size
e_jump = 4 + e_de_size
e_tile_l = 5 + e_de_size
e_tile_h = 6 + e_de_size


.macro DefineEntityDefault _name, _suf
   DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF, #-1,0x0000
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



 
.globl ent_move
.globl ent_draw
.globl ent_clear
.globl ent_update
.globl ent_copy
.globl ent_new
.globl hero_data
.globl enemy_data
.globl ent_doForAll
.globl ent_initialTile
.globl ent_getActualTile