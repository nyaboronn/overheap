MAXSCROLL = 80;;80
SCR_TILE_WIDTH = 40
MAP_WIDTH = 120;;120
MAP_HEIGHT = 46


pVideo = 0
pTilemap = 2
scroll = 4



RepeatRender: .db #0
;;INPUT -> scroll= h
;;         column = l

InputHL: .dw #0x000      




.globl _g_tilemap
.globl _g_palette
.globl _g_tileset

.globl scrollScreenTilemap

.globl TScreenTilemapFront
.globl TScreenTilemapBack