

.macro DefineDrawableEntity _name, _x, _y, _oldx, _oldy, _w, _h, _sprite
    _name:
    .db    _x, _y       ;; X, Y
    .db    _oldx, _oldy ;; X, Y
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