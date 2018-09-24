ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;###########################################################################
                              2 ;#### FICHERO: main.h.s
                              3 ;###########################################################################
                              4 ;;
                              5 ;; Declare all function entry points as global symbols for the compiler.
                              6 ;; (The linker will know what to do with them)
                              7 ;; WARNING: Every global symbol declared will be linked, so DO NOT declare
                              8 ;; symbols for functions you do not use.
                              9 ;;
                             10 .globl cpct_disableFirmware_asm
                             11 .globl cpct_drawSolidBox_asm
                             12 .globl cpct_getScreenPtr_asm
                             13 .globl cpct_waitVSYNC_asm
                             14 .globl cpct_setVideoMode_asm
                             15 .globl cpct_scanKeyboard_asm
                             16 .globl cpct_isKeyPressed_asm
