
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Heroe
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineHero _name, _x, _y,_oldx, _oldy, _vx, _vy, _w, _h, _sprite, _upd, _tile, _jump, _vida,_direct

    DefineEntity _name, _x, _y,_oldx, _oldy, _vx, _vy, _w, _h, _sprite, _upd, _tile
    .db  _jump          ;; Jump State,    -1 if not jumping (can jump)
                        ;;                -2 if is falling  (cant jump)
    .db _vida
    .db  _direct        ;; Sentido, 0 => left
                        ;;          1 => right
.endm

;;;;;;;;;;;;;;;;;;;;;;
;;
;;;;;;;;;;;;;;;;;;;;;

e_jump  = 13+1
hero_vida = 13+2
hero_direct = 13+3
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

.globl hero_hit