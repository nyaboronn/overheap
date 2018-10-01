MAXSCROLL = 80
SCR_TILE_WIDTH = 40
MAP_WIDTH = 120
MAP_HEIGHT = 46
CPCT_VMEM_START = 0xC000

pVideo = 0
pTilemap = 2
scroll = 4

;;Structure 

TScreenTilemap: .dw #CPCT_VMEM_START
                .dw #_g_tilemap
                .db 0x00


.globl _g_tilemap
.globl _g_palette
.globl _g_tileset

.globl scrollScreenTilemap


