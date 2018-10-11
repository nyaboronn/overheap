
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Heroe
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineHero _name, _x, _y, _vx, _vy, _w, _h, _col, _upd, _tile, _jump  

    DefineEntity _name, _x, _y, _vx, _vy, _w, _h, _col, _upd, _tile
    .db  _jump          ;; Jump State,    -1 if not jumping (can jump)
                        ;;                -2 if is falling  (cant jump)

.endm

;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;
e_jump  = 11

;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;;
.globl hero_jumptable
.globl hero_data

.globl hero_moveKeyboard
.globl hero_wait4KeyboardInput
.globl hero_jumpControl
.globl hero_startJump

.globl hero_update
.globl hero_clear
.globl hero_draw
.globl hero_move