;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enemy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEnemy _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _col, _upd, _tile, _direct  

    DefineEntity _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _col, _upd, _tile
    .db  _direct        ;; Sentido, 0 => left
                        ;;          1 => right
                        
.endm

;macro DefineEnemyShot _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _col, _upd, _tile, _direct, 
;                        _suf,
;                        _k_max_num_obs,
;                        _k_obs_size,
;                        _m_num_obs,
;                        _m_alive_obs 
;
;    DefineEnemy _name, _x, _y,_oldx, _oldy _vx, _vy, _w, _h, _col, _upd, _tile, _direct
;    
;    .db _k_max_num_obs   ;; Maximo de objetos
;    .db _k_obs_size      ;; Obstacle size (in Bytes)
;    .db _m_num_obs       ;; Número de obs creados
;    .dw _m_next_obs      ;; Posicion actual en el array
;    .db _m_alive_obs     ;; Numero de Obs Usados
;    .db _m_murieron_obs  ;; Numero de Obs que colisionan
;
;    DefineNObstacles _name'_suf, _k_max_num_obs
;
;endm

e_size = 13
e_direct           = 0 + e_size
enm_k_max_num_obs  = 1 + e_size
enm_k_obs_size     = 2 + e_size
enm_m_num_obs      = 3 + e_size
enm_m_next_obs     = 4 + e_size
enm_m_alive_obs    = 5 + e_size
enm_m_murieron_obs = 6 + e_size


.globl enm_move
.globl enm_clear
.globl enm_update
.globl enm_draw
.globl enm_data
;;;;;;;;;;;;;;; Temporal
.globl enm_move1