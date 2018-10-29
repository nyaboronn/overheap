
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UN ENEMIGO A  PARTIR DE UNA ENTIDAD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEnemy _name, _x, _y, _w, _h, _sprite, _upd, _tile, _direct, _alpha, _health

    DefineEntity _name, _x, _y,  _w, _h, _sprite, _upd, _tile
    .db  _direct    ;; 0 => left 1 => right
    .db  _alpha     ;; 0 => no necesita transparencia, 1 => usa transparencia
    .db _health     ;; Vida del enemigo
                        
.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UN ENEMIGO CON UN ARRAY DE BALAS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEnemyShoot _name, _x, _y, _w, _h, _sprite, _upd, _tile, _direct,_alpha, _health, _k_max_num_obs, _m_num_obs, _m_next_obs, _m_alive_obs, _m_murieron_obs, _suf

    DefineEnemy _name, _x, _y, _w, _h, _sprite, _upd, _tile, _direct, _alpha, _health

    .db _k_max_num_obs   ;; Maximo de balas a usar 
    .db _m_num_obs       ;; Número de obs creados
    .dw .+4              ;; Puntero al array de balas
    .db _m_alive_obs     ;; Numero de Obs en Pantalla
    .db _m_murieron_obs  ;; Numero de Obs que han colisionado
    
    ;; Array de Obstaculo, que representan las balas
    DefineNObstacles _name'_suf, _k_max_num_obs     

.endm

e_size = 14              ;; Size En Bytes de un Enemigo
e_direct            = 0 + e_size
e_alpha             = 1 + e_size
e_health            = 2 + e_size
k_max_num_obs  = 3 + e_size
m_num_obs      = 4 + e_size
m_next_obs     = 5 + e_size
m_alive_obs    = 7 + e_size 
m_murieron_obs = 8 + e_size 
shot_array     = 9 + e_size




;.globl eshoot
;.globl eshoot2
;.globl eshoot3
.globl eshoot4

.globl enm_clear
.globl enm_update
.globl enm_draw
.globl doForCurrentEnemy

.globl enemy_improve

.globl enm_move0
.globl enm_move1

.globl enm_doForAll

.globl enemy_default

.globl siguiente_mapa

