

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UN HERO A PARTIR DE UNA ENTIDAD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineHero _name, _x, _y,  _w, _h, _sprite, _upd, _jump, _vida,_direct



.endm


k_max_hero_balas = 5



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MACRO PARA DEFINIR UN HERO QUE PUEDE DISPARAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DefineHeroShot _name, _x, _y,  _w, _h, _sprite, _upd, _jump, _vida,_direct

    DefineEntity _name, _x, _y,  _w, _h, _sprite, _upd
    .db  _direct        ;; Donde apunta    0 => left
    .db  _jump          ;; Jump State,    -1 if not jumping (can jump)
                        ;;                -2 if is falling  (cant jump)
    .db _vida           ;; Numero de Vidas
    .db 0               ;; aux

    .db k_max_hero_balas   ;; Maximo de objetos
    .db 0       ;; Número de obs creados
    .dw .+4              ;; Posicion actual en el array
    .db k_max_hero_balas     ;; Numero de Obs Usados
    .db 0  ;; Numero de Obs que colisionan

    DefineNObstacles _name'_suf, k_max_hero_balas

.endm

e_size = 14
hero_direct = 0 + e_size
hero_jump   = 1 + e_size
hero_vida   = 2 + e_size
hero_aux    = 3 + e_size

k_max_num_obs  = 4 + e_size
m_num_obs      = 5 + e_size
m_next_obs     = 6 + e_size
m_alive_obs    = 8 + e_size 
m_murieron_obs = 9 + e_size 
shot_array     = 10 + e_size



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