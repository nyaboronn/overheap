.include "hero.h.s"
.include "cpcFunctions.h.s"             ;; CPCtelera constant definitions
.include "obstacles.h.s"

.area _DATA
.area _CODE

;;==========================================================================
;; Main program entry
;;==========================================================================
_main::
    ;; Disable firmware to prevent it from interfering with string drawing
    call cpct_disableFirmware_asm

    ld    c, #0
    call cpct_setVideoMode_asm

    call hero_erase                     ;; Erases the hero
    call obstacle_erase                 ;; Erases the obstacle  

    call hero_update                    ;; Updates the hero
    call obstacle_update                ;; Updates the obstacle
    
    ;;;;;;;;; borrar :OOOOOOOO ;;;;;;;
    ;; de momento pintamos el valor de la llamada a obstacle
    call hero_getPtrHL
    call obstacle_checkCollision
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ld (0xC000), a

    call hero_draw                      ;; Draw the hero
    call obstacle_draw                  ;; Draw the obstacle

    call cpct_waitVSYNC_asm             ;; Wait for raster

    jr    _main