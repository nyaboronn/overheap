.globl _sprite_bala

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINIR UN OBSTACULO A PARTIR DE UNA ENTIDAD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineObstacle _name, _x, _y,  _w, _h, _sprite, _upd, _tile, _alive

        DefineEntity _name, _x, _y,  _w, _h, _sprite, _upd, _tile
        .db _alive

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINIR UN OBSTACULO POR DEFECTO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineObstacleDefault _name, _suf

    DefineObstacle _name'_suf, 10, 10, 1, 1, _sprite_bala, obs_move, 0xFFFF, 1

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINIR UN ARRAY DE OBSTACULOS POR DEFECTO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineNObstacles _name, _n

    _c = 0

    .rept _n
        DefineObstacleDefault _name, \_c
        _c = _c + 1
    .endm

.endm



e_de_size = 7
o_alive = 6 + e_de_size 



;;;; FUNCTIONS
.globl obs_draw
.globl obs_clear
.globl obs_update

.globl obs_move
.globl obs_copy
.globl obs_new
.globl obs_doForAll
.globl obs_doForAllBool

.globl obs_checkCollision
.globl obs_no_collision

