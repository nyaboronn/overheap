;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Definir un Obstaculo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineObstacle _name, _x, _y,_oldx, _oldy, _vx, _vy, _w, _h, _col, _upd, _tile, _alive

        DefineEntity _name, _x, _y,_oldx, _oldy, _vx, _vy, _w, _h, _col, _upd, _tile
        .db _alive

.endm

.macro DefineObstacleDefault _name, _suf

    DefineObstacle _name'_suf, 0, 0, 0, 0, 0, 0, 0, 0, 0xFFFF, 0xFFFF, 0xFFFF, 0

.endm

e_de_size = 7
o_alive = 6 + e_de_size 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Array de Obstculos
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineNObstacles _name, _n

    _c = 0

    .rept _n
        DefineObstacleDefault _name, \_c
        _c = _c + 1
    .endm

.endm

;;;; FUNCTIONS ;;
.globl obs_draw
.globl obs_clear
.globl obs_update

.globl obs_move
.globl obs_copy
.globl obs_new
.globl obs_doForAll

.globl obs_checkCollision
.globl obs_no_collision

.globl obstacle1
;.globl obstacle2
;.globl obstacle3
;.globl obstacle4
;.globl obstacle5
;.globl obstacle6