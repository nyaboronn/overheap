#include "overHeap.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Palette uses hardware values.
const u8 overHeap_pal[16] = { 0x4b, 0x5c, 0x44, 0x55, 0x57, 0x58, 0x5c, 0x4c, 0x4e, 0x47, 0x4a, 0x40, 0x56, 0x52, 0x46, 0x54 };

// Tile overHeap_sp: 84x47 pixels, 42x47 bytes.
const u8 overHeap_sp[42 * 47] = {
	0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff,
	0x00, 0x00, 0x00, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff,
	0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff,
	0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff,
	0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff,
	0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xdd, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff,
	0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff,
	0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xee, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xdd, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff,
	0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xee, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xdd, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff,
	0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff,
	0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x00, 0xff, 0xaa, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xaa, 0x00, 0x00,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x55, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xcc, 0xcc,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xff, 0xff, 0xaa, 0x00, 0x00, 0x55, 0xff, 0xff, 0x00, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00, 0xff, 0xff, 0xaa, 0x00, 0x00,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff,
	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xee, 0xcc, 0xdd, 0xff, 0xff, 0xff, 0xff, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xcc, 0xdd, 0xee, 0xcc, 0xcc, 0xdd, 0xff, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xff, 0xff
};

