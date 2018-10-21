;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enemy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEnemy _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _col, _upd, _tile, _direct  

    DefineEntity _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _col, _upd, _tile
    .db  _direct        ;; Sentido, -1 => left
                        ;;          1  => right
                        
.endm

;;;;;;;;;;;;;
;;
;;;;;;;;;;;;
e_direct = 13

.globl enm_move
.globl enm_clear
.globl enm_update
.globl enm_draw
.globl enm_data
;;;;;;;;;;;;;;; Temporal
.globl enm_move1