

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UN HERO A PARTIR DE UNA ENTIDAD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineHero _name, _x, _y,  _w, _h, _sprite, _upd, _tile, _jump, _vida,_direct

    DefineEntity _name, _x, _y,  _w, _h, _sprite, _upd, _tile
    .db  _direct        ;; Donde apunta    0 => left
    .db  _jump          ;; Jump State,    -1 if not jumping (can jump)
                        ;;                -2 if is falling  (cant jump)
    .db _vida           ;; Numero de Vidas

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UN HERO QUE PUEDE DISPARAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineHeroShot _name, _x, _y,  _w, _h, _sprite, _upd, _tile, _jump, _vida,_direct, _k_max_num_obs, _m_num_obs, _m_next_obs, _m_alive_obs, _m_murieron_obs, _suf

    DefineHero _name, _x, _y, _w, _h, _sprite, _upd, _tile, _jump, _vida, _direct

    .db _k_max_num_obs   ;; Maximo de objetos
    .db _m_num_obs       ;; Número de obs creados
    .dw .+4              ;; Posicion actual en el array
    .db _m_alive_obs     ;; Numero de Obs Usados
    .db _m_murieron_obs  ;; Numero de Obs que colisionan

    DefineNObstacles _name'_suf, _k_max_num_obs

.endm

e_size = 14
hero_direct = 0 + e_size
hero_jump   = 1 + e_size
hero_vida   = 2 + e_size

k_max_num_obs  = 3 + e_size
m_num_obs      = 4 + e_size
m_next_obs     = 5 + e_size
m_alive_obs    = 7 + e_size 
m_murieron_obs = 8 + e_size 
shot_array     = 9 + e_size



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

.globl hero_check_hit

.globl hero_default
.globl hero_default_no_vida