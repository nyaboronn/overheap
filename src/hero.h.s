
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

.macro DefineHeroShot _name, _x, _y,_oldx, _oldy, _vx, _vy, _w, _h, _sprite, _upd, _tile, _jump, _vida,_direct, _k_max_num_obs, _m_num_obs, _m_next_obs, _m_alive_obs, _m_murieron_obs, _suf

    DefineHero _name, _x, _y,_oldx, _oldy, _vx, _vy, _w, _h, _sprite, _upd, _tile, _jump, _vida, _direct

    .db _k_max_num_obs   ;; Maximo de objetos
    .db _m_num_obs       ;; Número de obs creados
    .dw .+4              ;; Posicion actual en el array
    .db _m_alive_obs     ;; Numero de Obs Usados
    .db _m_murieron_obs  ;; Numero de Obs que colisionan

    DefineNObstacles _name'_suf, _k_max_num_obs

.endm

e_size = 14
hero_jump   = 0 + e_size
hero_vida   = 1 + e_size
hero_direct = 2 + e_size

k_max_num_obs  = 3 + e_size
m_num_obs      = 4 + e_size
m_next_obs     = 5 + e_size
m_alive_obs    = 7 + e_size 
m_murieron_obs = 8 + e_size 
shot_array     = 9 + e_size


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