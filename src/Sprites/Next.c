#include "Next.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Palette uses hardware values.
const u8 Next_pal[16] = { 0x54, 0x44, 0x55, 0x5c, 0x4c, 0x56, 0x57, 0x5e, 0x40, 0x4e, 0x47, 0x52, 0x53, 0x4a, 0x43, 0x4b };

// Tile Next_sp: 36x8 pixels, 18x8 bytes.
const u8 Next_sp[18 * 8] = {
	0xff, 0x00, 0xff, 0x55, 0xff, 0xff, 0xaa, 0xff, 0x00, 0xff, 0x55, 0xff, 0xff, 0xaa, 0x00, 0xff, 0x00, 0xff,
	0xff, 0x00, 0xff, 0x55, 0xff, 0xff, 0xaa, 0x55, 0x00, 0xaa, 0x55, 0xff, 0xff, 0xaa, 0x00, 0x55, 0x00, 0xaa,
	0xff, 0xaa, 0xff, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xaa,
	0xff, 0xff, 0xff, 0x55, 0xff, 0xaa, 0x00, 0x00, 0xff, 0x00, 0x00, 0x55, 0xaa, 0x55, 0xaa, 0x00, 0xff, 0x00,
	0x0c, 0x0c, 0x0c, 0x04, 0x0c, 0x08, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x04, 0x08, 0x00, 0x00, 0x00, 0x0c, 0x00,
	0x0c, 0x04, 0x0c, 0x04, 0x08, 0x00, 0x00, 0x04, 0x0c, 0x08, 0x00, 0x04, 0x08, 0x40, 0x80, 0x04, 0x0c, 0x08,
	0x0c, 0x00, 0x0c, 0x04, 0x0c, 0x0c, 0x08, 0x04, 0x00, 0x08, 0x00, 0x04, 0x08, 0x00, 0x00, 0x04, 0x00, 0x08,
	0x0c, 0x00, 0x0c, 0x04, 0x0c, 0x0c, 0x08, 0x0c, 0x00, 0x0c, 0x00, 0x04, 0x08, 0x00, 0x00, 0x0c, 0x00, 0x0c
};

