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


MAXSCROLL = 80;;80
SCR_TILE_WIDTH = 40
MAP_WIDTH = 120;;120
MAP_HEIGHT = 46


pVideo = 0
pTilemap = 2
scroll = 4



.globl RepeatRender
.globl InputHL

.globl reset_RepeatRender
.globl reset_InputHL

.globl _g_tilemap
.globl _g_palette
.globl _g_tileset

.globl scrollScreenTilemap
.globl reDrawLeft
;.globl reDrawRight

.globl TScreenTilemapFront
.globl TScreenTilemapBack
.globl scroll_default