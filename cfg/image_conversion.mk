##-----------------------------LICENSE NOTICE------------------------------------
##  This file is part of CPCtelera: An Amstrad CPC Game Engine 
##  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU Lesser General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU Lesser General Public License for more details.
##
##  You should have received a copy of the GNU Lesser General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##------------------------------------------------------------------------------
############################################################################
##                        CPCTELERA ENGINE                                ##
##                 Automatic image conversion file                        ##
##------------------------------------------------------------------------##
## This file is intended for users to automate image conversion from JPG, ##
## PNG, GIF, etc. into C-arrays.                                          ##
############################################################################

##
## NEW MACROS
##

## 16 colours palette
#PALETTE=0 1 2 3 6 9 11 12 13 15 16 18 20 24 25 26

## Default values
#$(eval $(call IMG2SP, SET_MODE        , 0                  ))  { 0, 1, 2 }
#$(eval $(call IMG2SP, SET_MASK        , none               ))  { interlaced, none }
#$(eval $(call IMG2SP, SET_FOLDER      , src/               ))
#$(eval $(call IMG2SP, SET_EXTRAPAR    ,                    ))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))	{ sprites, zgtiles, screen }
#$(eval $(call IMG2SP, SET_OUTPUT      , c                  ))  { bin, c }
#$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)         ))
#$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette ))


#$(eval $(call IMG2SP, CONVERT         , img/Xemnas.png , 16, 16, array, palette, tileset))

##
## OLD MACROS (For compatibility)
##

## Example firmware palette definition as variable in cpct_img2tileset format

## Firmware palette definition in cpct_img2tileset format
PALETTE=0 3 1 2 11 20 3 6  15 16 24 13 9  18 10 26


$(eval $(call IMG2SP, SET_FOLDER, src/Sprites))
$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)         ))
$(eval $(call IMG2SP, CONVERT, img/menu/overHeap.png,84,47, overHeap_sp, overHeap_pal))
$(eval $(call IMG2SP, CONVERT, img/menu/play.png,38,8, play_sp, play_pal))
$(eval $(call IMG2SP, CONVERT, img/menu/jlga10.png,40,8, jlga10_sp, jlga10_pal))
$(eval $(call IMG2SP, CONVERT, img/menu/jlq2.png,26,8, jlq2_sp, jlq2_pal))
$(eval $(call IMG2SP, CONVERT, img/menu/ajah1.png,34,8, ajah1_sp, ajah1_pal))
$(eval $(call IMG2SP, CONVERT, img/menu/hearth.png,16,12, hearth_sp, hearth_pal))
$(eval $(call IMG2SP, CONVERT, img/menu/Restart.png,59,8, Restart_sp, Restart_pal))
$(eval $(call IMG2SP, CONVERT, img/menu/youLost.png,54,8, youLost_sp, youLost_pal))


## Convert img/tiles.png into src/tiles.c and src/tiles.h
##   This is a mode 0 tileset, containing 16 4x4 pixel tiles, that are used
## to create a scrolling tilemap. The image will be converted into 16 C-arrays 
## called g_tiles{0-15} (g is prefix for _tiles) without interlaced mask. 
## Palette will also be converted to hardware values and outputed as a C-array
## named g_palette.
PALETTE2={  0 3 1 2 11 20 3 6  15 16 24 13 9  18 10 26 }

$(eval $(call IMG2SPRITES,img/newtiles.png,0,g,4,4,$(PALETTE2),tileset,src/assets,hwpalette))
$(eval $(call IMG2SPRITES,img/Xemnas.png,0,sprite,16,16,$(PALETTE2),mask,src/assets))
$(eval $(call IMG2SPRITES,img/Skeleton.png,0,sprite,16,16,$(PALETTE2),mask,src/assets))
$(eval $(call IMG2SPRITES,img/bala.png,0,sprite,4,4,$(PALETTE2),mask,src/assets))

