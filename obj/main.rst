ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .area _DATA
                              2 .area _CODE
                              3 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              4 .include "hero.h.s"
                              1 ;;================================================
                              2 ;;================================================
                              3 ;; HERO PUBLIC FUNCTIONS
                              4 ;;================================================
                              5 ;;================================================
                              6 
                              7 .globl hero_erase
                              8 .globl hero_draw
                              9 .globl hero_update
                             10 .globl hero_getPtrHL
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              5 .include "cpcFunctions.h.s"
                              1 ;;================================================
                              2 ;;================================================
                              3 ;; CPCTELERA PUBLIC FUNCTIONS
                              4 ;;================================================
                              5 ;;================================================
                              6 
                              7 .globl cpct_waitVSYNC_asm
                              8 .globl cpct_disableFirmware_asm
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              6 .include "obstacles.h.s"
                              1 ;;================================================
                              2 ;;================================================
                              3 ;; OBSTACLES PUBLIC FUNCTIONS
                              4 ;;================================================
                              5 ;;================================================
                              6 
                              7 .globl obstacle_draw
                              8 .globl obstacle_update
                              9 .globl obstacle_erase
                             10 .globl obstacle_checkCollision
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]



                              7 
                              8 ;;==========================================================================
                              9 ;; Main program entry
                             10 ;;==========================================================================
   426A                      11 _main::
                             12     ;; Disable firmware to prevent it from interfering with string drawing
   426A CD B8 42      [17]   13     call cpct_disableFirmware_asm
                             14 
   426D CD 6E 40      [17]   15     call hero_erase                     ;; Erases the hero
   4270 CD 3D 41      [17]   16     call obstacle_erase                 ;; Erases the obstacle  
                             17 
   4273 CD 5D 40      [17]   18     call hero_update                    ;; Updates the hero
   4276 CD 07 41      [17]   19     call obstacle_update                ;; Updates the obstacle
                             20     
                             21     ;;;;;;;;; borrar :OOOOOOOO ;;;;;;;
                             22     ;; de momento pintamos el valor de la llamada a obstacle
   4279 CD 64 40      [17]   23     call hero_getPtrHL
   427C CD 13 41      [17]   24     call obstacle_checkCollision
                             25     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                             26 
   427F 32 00 C0      [13]   27     ld (0xC000), a
                             28 
   4282 CD 68 40      [17]   29     call hero_draw                      ;; Draw the hero
   4285 CD 37 41      [17]   30     call obstacle_draw                  ;; Draw the obstacle
                             31 
   4288 CD A3 42      [17]   32     call cpct_waitVSYNC_asm             ;; Wait for raster
                             33 
   428B 18 DD         [12]   34     jr    _main
