#include "vampiro.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Tile sprite_vampiro: 16x16 pixels, 8x16x2 bytes.
// Mask data is interlaced (MASK BYTE, DATA BYTE).
const u8 sprite_vampiro[2 * 8 * 16] = {
	0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0x00, 0xff, 0x00, 0xff, 0x55, 0xaa, 0xff, 0x00, 0xff, 0x00,
	0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0x00, 0xef, 0x00, 0xcf, 0x55, 0x8a, 0xff, 0x00, 0xff, 0x00,
	0xff, 0x00, 0xff, 0x00, 0x00, 0xff, 0x00, 0xff, 0x00, 0xdf, 0x00, 0xdf, 0xff, 0x00, 0xff, 0x00,
	0xff, 0x00, 0xaa, 0x55, 0x00, 0xf0, 0x00, 0xef, 0x00, 0xcf, 0x00, 0xda, 0x55, 0xaa, 0xff, 0x00,
	0xff, 0x00, 0x00, 0xfa, 0x00, 0xf0, 0x00, 0xcf, 0xaa, 0x45, 0x00, 0xda, 0x00, 0xf5, 0xff, 0x00,
	0xff, 0x00, 0x00, 0xfa, 0x00, 0xf0, 0x00, 0xe5, 0x00, 0xcf, 0x00, 0xf0, 0x00, 0xf5, 0xff, 0x00,
	0xff, 0x00, 0xaa, 0x55, 0x00, 0xff, 0x00, 0xff, 0x00, 0xf0, 0x00, 0xf5, 0x55, 0xaa, 0xff, 0x00,
	0xff, 0x00, 0xff, 0x00, 0x00, 0xfa, 0x00, 0xf0, 0x00, 0xf0, 0x00, 0xf5, 0xff, 0x00, 0xff, 0x00,
	0xff, 0x00, 0xff, 0x00, 0x00, 0xfa, 0x00, 0xf0, 0x00, 0xf0, 0x00, 0xf5, 0xff, 0x00, 0xff, 0x00,
	0xff, 0x00, 0xff, 0x00, 0x00, 0xfa, 0x00, 0xf0, 0x00, 0xf0, 0x00, 0xfa, 0x55, 0xaa, 0xff, 0x00,
	0xff, 0x00, 0xaa, 0x55, 0x00, 0xf0, 0x00, 0xf0, 0x00, 0xf0, 0x00, 0xfa, 0x00, 0xf5, 0xff, 0x00,
	0xff, 0x00, 0xaa, 0x55, 0x00, 0xf0, 0x00, 0xf0, 0x00, 0xf8, 0x00, 0xfa, 0x55, 0xaa, 0xff, 0x00,
	0xff, 0x00, 0xff, 0x00, 0x00, 0xfa, 0x00, 0xf4, 0x00, 0xf0, 0x00, 0xf0, 0x55, 0xaa, 0xff, 0x00,
	0xff, 0x00, 0xff, 0x00, 0xaa, 0x55, 0x00, 0xf8, 0x00, 0xf0, 0x00, 0xfd, 0xff, 0x00, 0xff, 0x00,
	0xff, 0x00, 0xff, 0x00, 0xaa, 0x55, 0x00, 0xf8, 0x00, 0xfc, 0x00, 0xfc, 0x55, 0xaa, 0xff, 0x00,
	0xff, 0x00, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x55, 0xaa
};

