
;.include "obstacle.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enemy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEnemy _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _sprite, _upd, _tile, _direct  

    DefineEntity _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _sprite, _upd, _tile
    .db  _direct        ;; Sentido, 0 => left
                        ;;          1 => right
                        
.endm


.macro DefineEnemyShoot _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _sprite, _upd, _tile, _direct, _k_max_num_obs, _k_obs_size, _m_num_obs, _m_next_obs, _m_alive_obs, _m_murieron_obs, _suf

    DefineEnemy _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _sprite, _upd, _tile, _direct  

    .db _k_max_num_obs   ;; Maximo de objetos
    .db _k_obs_size      ;; Obstacle size (in Bytes)
    .db _m_num_obs       ;; Número de obs creados
    .dw _m_next_obs      ;; Posicion actual en el array
    .db _m_alive_obs     ;; Numero de Obs Usados
    .db _m_murieron_obs  ;; Numero de Obs que colisionan

    DefineNObstacles _name'_suf, _k_max_num_obs

.endm

e_size = 14
e_direct           = 0 + e_size
enm_k_max_num_obs  = 1 + e_size
enm_k_obs_size     = 2 + e_size ;; posible constante
enm_m_num_obs      = 3 + e_size
enm_m_next_obs     = 4 + e_size
enm_m_alive_obs    = 6 + e_size 
enm_m_murieron_obs = 7 + e_size 
enm_shot_array     = 8 + e_size




.globl enm_move
.globl enm_clear
.globl enm_update
.globl enm_draw
;.globl enm_data
;;;;;;;;;;;;;;; Temporal
.globl enm_move1
.globl eshoot
.globl eshoot2
.globl eshoot3
.globl eshoot4