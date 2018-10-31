                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module hearth
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _g_hearth
                             12 ;--------------------------------------------------------
                             13 ; special function registers
                             14 ;--------------------------------------------------------
                             15 ;--------------------------------------------------------
                             16 ; ram data
                             17 ;--------------------------------------------------------
                             18 	.area _DATA
                             19 ;--------------------------------------------------------
                             20 ; ram data
                             21 ;--------------------------------------------------------
                             22 	.area _INITIALIZED
                             23 ;--------------------------------------------------------
                             24 ; absolute external ram data
                             25 ;--------------------------------------------------------
                             26 	.area _DABS (ABS)
                             27 ;--------------------------------------------------------
                             28 ; global & static initialisations
                             29 ;--------------------------------------------------------
                             30 	.area _HOME
                             31 	.area _GSINIT
                             32 	.area _GSFINAL
                             33 	.area _GSINIT
                             34 ;--------------------------------------------------------
                             35 ; Home
                             36 ;--------------------------------------------------------
                             37 	.area _HOME
                             38 	.area _HOME
                             39 ;--------------------------------------------------------
                             40 ; code
                             41 ;--------------------------------------------------------
                             42 	.area _CODE
                             43 	.area _CODE
   2CEC                      44 _g_hearth:
   2CEC FF                   45 	.db #0xff	; 255
   2CED FF                   46 	.db #0xff	; 255
   2CEE FF                   47 	.db #0xff	; 255
   2CEF FF                   48 	.db #0xff	; 255
   2CF0 FF                   49 	.db #0xff	; 255
   2CF1 FF                   50 	.db #0xff	; 255
   2CF2 FF                   51 	.db #0xff	; 255
   2CF3 FF                   52 	.db #0xff	; 255
   2CF4 FF                   53 	.db #0xff	; 255
   2CF5 FC                   54 	.db #0xfc	; 252
   2CF6 FC                   55 	.db #0xfc	; 252
   2CF7 FF                   56 	.db #0xff	; 255
   2CF8 FE                   57 	.db #0xfe	; 254
   2CF9 FC                   58 	.db #0xfc	; 252
   2CFA FD                   59 	.db #0xfd	; 253
   2CFB FF                   60 	.db #0xff	; 255
   2CFC FE                   61 	.db #0xfe	; 254
   2CFD FC                   62 	.db #0xfc	; 252
   2CFE FC                   63 	.db #0xfc	; 252
   2CFF FD                   64 	.db #0xfd	; 253
   2D00 FC                   65 	.db #0xfc	; 252
   2D01 A8                   66 	.db #0xa8	; 168
   2D02 54                   67 	.db #0x54	; 84	'T'
   2D03 FF                   68 	.db #0xff	; 255
   2D04 FE                   69 	.db #0xfe	; 254
   2D05 FC                   70 	.db #0xfc	; 252
   2D06 FC                   71 	.db #0xfc	; 252
   2D07 FC                   72 	.db #0xfc	; 252
   2D08 FC                   73 	.db #0xfc	; 252
   2D09 A8                   74 	.db #0xa8	; 168
   2D0A 54                   75 	.db #0x54	; 84	'T'
   2D0B FF                   76 	.db #0xff	; 255
   2D0C FE                   77 	.db #0xfe	; 254
   2D0D FC                   78 	.db #0xfc	; 252
   2D0E FC                   79 	.db #0xfc	; 252
   2D0F FC                   80 	.db #0xfc	; 252
   2D10 FC                   81 	.db #0xfc	; 252
   2D11 A8                   82 	.db #0xa8	; 168
   2D12 54                   83 	.db #0x54	; 84	'T'
   2D13 FF                   84 	.db #0xff	; 255
   2D14 FF                   85 	.db #0xff	; 255
   2D15 FC                   86 	.db #0xfc	; 252
   2D16 FC                   87 	.db #0xfc	; 252
   2D17 FC                   88 	.db #0xfc	; 252
   2D18 FC                   89 	.db #0xfc	; 252
   2D19 FC                   90 	.db #0xfc	; 252
   2D1A FD                   91 	.db #0xfd	; 253
   2D1B FF                   92 	.db #0xff	; 255
   2D1C FF                   93 	.db #0xff	; 255
   2D1D FE                   94 	.db #0xfe	; 254
   2D1E FC                   95 	.db #0xfc	; 252
   2D1F FC                   96 	.db #0xfc	; 252
   2D20 FC                   97 	.db #0xfc	; 252
   2D21 FC                   98 	.db #0xfc	; 252
   2D22 FF                   99 	.db #0xff	; 255
   2D23 FF                  100 	.db #0xff	; 255
   2D24 FF                  101 	.db #0xff	; 255
   2D25 FF                  102 	.db #0xff	; 255
   2D26 FC                  103 	.db #0xfc	; 252
   2D27 FC                  104 	.db #0xfc	; 252
   2D28 FC                  105 	.db #0xfc	; 252
   2D29 FD                  106 	.db #0xfd	; 253
   2D2A FF                  107 	.db #0xff	; 255
   2D2B FF                  108 	.db #0xff	; 255
   2D2C FF                  109 	.db #0xff	; 255
   2D2D FF                  110 	.db #0xff	; 255
   2D2E FE                  111 	.db #0xfe	; 254
   2D2F FC                  112 	.db #0xfc	; 252
   2D30 FC                  113 	.db #0xfc	; 252
   2D31 FF                  114 	.db #0xff	; 255
   2D32 FF                  115 	.db #0xff	; 255
   2D33 FF                  116 	.db #0xff	; 255
   2D34 FF                  117 	.db #0xff	; 255
   2D35 FF                  118 	.db #0xff	; 255
   2D36 FF                  119 	.db #0xff	; 255
   2D37 FC                  120 	.db #0xfc	; 252
   2D38 FD                  121 	.db #0xfd	; 253
   2D39 FF                  122 	.db #0xff	; 255
   2D3A FF                  123 	.db #0xff	; 255
   2D3B FF                  124 	.db #0xff	; 255
   2D3C FF                  125 	.db #0xff	; 255
   2D3D FF                  126 	.db #0xff	; 255
   2D3E FF                  127 	.db #0xff	; 255
   2D3F FE                  128 	.db #0xfe	; 254
   2D40 FF                  129 	.db #0xff	; 255
   2D41 FF                  130 	.db #0xff	; 255
   2D42 FF                  131 	.db #0xff	; 255
   2D43 FF                  132 	.db #0xff	; 255
   2D44 FF                  133 	.db #0xff	; 255
   2D45 FF                  134 	.db #0xff	; 255
   2D46 FF                  135 	.db #0xff	; 255
   2D47 FF                  136 	.db #0xff	; 255
   2D48 FF                  137 	.db #0xff	; 255
   2D49 FF                  138 	.db #0xff	; 255
   2D4A FF                  139 	.db #0xff	; 255
   2D4B FF                  140 	.db #0xff	; 255
                            141 	.area _INITIALIZER
                            142 	.area _CABS (ABS)
