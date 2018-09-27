ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;###########################################################################
                              2 ;#### FICHERO: entity.h.s
                              3 ;###########################################################################
                              4 .macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _col, _upd, _jump
                              5 _name:
                              6    .db    _x, _y      ;; X, Y
                              7    .db   _vx, _vy     ;; VX, VY
                              8    .db    _w, _h      ;; W, H
                              9    .db   _col           ;; Color
                             10    .dw   _upd         ;; Update
                             11    .db  _jump         ;; Jump State, -1 if not jumping
                             12 .endm
                             13 
                             14 .macro DefineEntityDefault _name, _suf
                             15    DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF, #-1
                             16 .endm
                             17 
                             18 .macro DefineNEntities _name, _n
                             19   _c = 0
                             20   .rept _n
                             21      DefineEntityDefault _name, \_c
                             22      _c = _c + 1
                             23   .endm
                             24 .endm
                             25 
                             26 
                             27 ;;.macro ent_draw_default _pos, _y, _x, _de, _e_col, _e_h, _e_w
                             28   ;  ent_draw #0xC000, 0x00,0x00, 0xC000, 0xFF, 0x02, 0x08
                             29 ;;.endm
                             30 
                             31 
                             32 
                     0000    33 e_x = 0
                     0001    34 e_y = 1
                     0002    35 e_vx = 2
                     0003    36 e_vy = 3
                     0004    37 e_w = 4
                     0005    38 e_h = 5
                     0006    39 e_col = 6
                     0007    40 e_up_l = 7
                     0008    41 e_up_h = 8
                     0009    42 e_jump = 9
                             43  
                             44  
                             45 .globl ent_draw
                             46 .globl ent_clear
                             47 .globl ent_update
                             48 .globl ent_copy
                             49 .globl ent_new
                             50 .globl hero_data
                             51 .globl enemy_data
                             52 .globl ent_doForAll
