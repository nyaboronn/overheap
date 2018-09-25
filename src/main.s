.include "cpctelera.h.s"
.include "entity.h.s"
.include "main.h.s"

 
.area _DATA
.area _CODE
 

entity_contador = 0

_main::
  ;; Disable firmware to prevent it from interfering with string drawing
  call cpct_disableFirmware_asm
 
  ld    c, #0
  call cpct_setVideoMode_asm

  call ent_new
  ex	de, hl
  ld    hl,#hero_data
  call ent_copy
 
loop:
  ld    ix, #hero_data

  ld  hl, #ent_clear
  call ent_doForAll

  ld  hl, #ent_update
  call ent_doForAll

  ld hl, #ent_draw
  call ent_doForAll

  call cpct_waitVSYNC_asm
 
  ;; Loop forever
  jr    loop