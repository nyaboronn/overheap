
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UN ENEMIGO A  PARTIR DE UNA ENTIDAD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEnemy _name, _x, _y, _w, _h, _sprite, _upd, _direct, _alpha, _health

    DefineEntity _name, _x, _y,  _w, _h, _sprite, _upd
    .db  _direct    ;; 0 => left 1 => right
    .db  _alpha     ;; 0 => no necesita transparencia, 1 => usa transparencia
    .db _health     ;; Vida del enemigo
    .db  -1      ;; _jump             
.endm


k_max_balas = 5


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UN ENEMIGO CON UN ARRAY DE BALAS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineEnemyShoot _name, _x, _y, _w, _h, _sprite, _upd, _direct,_alpha, _health

    DefineEnemy _name, _x, _y, _w, _h, _sprite, _upd, _direct, _alpha, _health

    .db k_max_balas   ;; Maximo de balas a usar 
    .db 0       ;; Número de obs creados
    .dw .+4              ;; Puntero al array de balas
    .db k_max_balas     ;; Numero de Obs en Pantalla
    .db 0  ;; Numero de Obs que han colisionado
    
    ;; Array de Obstaculo, que representan las balas
    DefineNObstacles _name'_suf, k_max_balas     

.endm

e_size = 14              ;; Size En Bytes de un Enemigo
e_direct            = 0 + e_size
e_alpha             = 1 + e_size
e_health            = 2 + e_size
e_jump              = 3 + e_size    

k_max_num_obs  = 4 + e_size
m_num_obs      = 5 + e_size
m_next_obs     = 6 + e_size
m_alive_obs    = 8 + e_size 
m_murieron_obs = 9 + e_size 
shot_array     = 10 + e_size




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

.globl enm_map_alive
.globl enemies
.globl k_total_enm
.globl reiniciar_life
.globl reiniciar_enm_map_alive


