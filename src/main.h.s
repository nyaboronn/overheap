;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of OverHeap: An AmstradCpc Game for the contest cpcretrodev
;;  Copyright (C) 2018 jlga - jlq2 - ajah1 | @bastacpc 
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;-------------------------------------------------------------------------------

.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm
.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm
.globl cpct_drawSprite_asm
.globl cpct_setPALColour_asm
.globl cpct_etm_setTileset2x4_asm
.globl cpct_etm_drawTileBox2x4_asm
.globl cpct_scanKeyboard_f_asm
.globl cpct_setVideoMemoryOffset_asm
.globl cpct_setPalette_asm
.globl cpct_disableFirmware_asm
.globl cpct_setVideoMode_asm
.globl cpct_waitVSYNC_asm
.globl cpct_getBit_asm
.globl cpct_setVideoMemoryPage_asm

.globl cpct_setDrawCharM0_asm
.globl cpct_drawStringM0_asm

.globl cpct_setDrawCharM1_asm
.globl cpct_drawStringM1_asm

.globl cpct_drawSpriteMasked_asm
.globl cpct_hflipSpriteMaskedM0_asm

.globl cpct_akp_musicInit_asm
.globl cpct_akp_musicPlay_asm
.globl _song_ingame
.globl principio