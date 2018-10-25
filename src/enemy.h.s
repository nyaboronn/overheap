
;.include "obstacle.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enemy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEnemy _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _sprite, _upd, _tile, _direct, _alpha, _health

    DefineEntity _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _sprite, _upd, _tile
    .db  _direct        ;; Sentido, 0 => left 1 => right
    .db  _alpha          ;; 
    .db _health
                        
.endm


.macro DefineEnemyShoot _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _sprite, _upd, _tile, _direct,_alpha, _health _k_max_num_obs, _m_num_obs, _m_next_obs, _m_alive_obs, _m_murieron_obs, _suf

    DefineEnemy _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _sprite, _upd, _tile, _direct, _alpha, _health

    .db _k_max_num_obs   ;; Maximo de objetos
    .db _m_num_obs       ;; Número de obs creados
    .dw .+4              ;; Posicion actual en el array
    .db _m_alive_obs     ;; Numero de Obs Usados
    .db _m_murieron_obs  ;; Numero de Obs que colisionan

    DefineNObstacles _name'_suf, _k_max_num_obs

.endm

e_size = 14

e_direct            = 0 + e_size
e_alpha             = 1 + e_size
e_health            = 2 + e_size
enm_k_max_num_obs  = 3 + e_size
enm_m_num_obs      = 4 + e_size
enm_m_next_obs     = 5 + e_size
enm_m_alive_obs    = 7 + e_size 
enm_m_murieron_obs = 8 + e_size 
enm_shot_array     = 9 + e_size




.globl enm_move0
.globl enm_clear
.globl enm_update
.globl enm_draw
.globl enm_doForAll
;.globl enm_data
;;;;;;;;;;;;;;; Temporal
.globl enm_move1
.globl eshoot
.globl eshoot2
.globl eshoot3
.globl eshoot4