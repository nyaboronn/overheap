ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;###########################################################################
                              2 ;#### FICHERO: entity.h.s
                              3 ;###########################################################################
                              4 .macro DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _col, _upd
                              5 _name:
                              6    .db    _x, _y     ;; X, Y
                              7    .db   _vx, _vy     ;; VX, VY
                              8    .db    _w, _h     ;; W, H
                              9    .db   _col           ;; Color
                             10    .dw   _upd        ;; Update
                             11 .endm
                             12 .macro DefineEntityDefault _name, _suf
                             13    DefineEntity _name'_suf, 0xAA, 0, 0, 0, 0, 0, 0, 0xFFFF
                             14 .endm
                             15 
                             16 .macro DefineNEntities _name, _n
                             17   _c = 0
                             18   .rept _n
                             19      DefineEntityDefault _name, \_c
                             20      _c = _c + 1
                             21   .endm
                             22 .endm
                             23 
                             24 
                             25 ;;.macro ent_draw_default _pos, _y, _x, _de, _e_col, _e_h, _e_w
                             26   ;  ent_draw #0xC000, 0x00,0x00, 0xC000, 0xFF, 0x02, 0x08
                             27 ;;.endm
                             28 
                             29 
                             30 
                     0000    31 e_x = 0
                     0001    32 e_y = 1
                     0002    33 e_vx = 2
                     0003    34 e_vy = 3
                     0004    35 e_w = 4
                     0005    36 e_h = 5
                     0006    37 e_col = 6
                     0007    38 e_up_l = 7
                     0008    39 e_up_h = 8
                             40  
                             41  
                             42 .globl ent_draw
                             43 .globl ent_clear
                             44 .globl ent_update
                             45 .globl ent_copy
                             46 .globl ent_new
                             47 .globl hero_data
                             48 .globl enemy_data
                             49 .globl ent_doForAll
