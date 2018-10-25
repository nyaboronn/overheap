

.include "enemy.h.s"
.include "entity.h.s"
.include "obstacle.h.s"


.globl _sprite_Skeleton
;;;;;;;;;;;;;;;;;;;
;; Enemy Data
;;;;;;;;;;;;;;;;;;;;

;;;
;; _type = 0 => simple enm (enm_move0)
;; _type = 1 => shoot enm  (enm_move1)
;; _type = 2 => ....

ListaEnemigos: 
;              _name,    x,  y,_oldx, _oldy _vx, _vy, _w, _h, _sprite, _upd, _tile, _direct,_alpha, _health _k_max_num_obs, _m_num_obs, _m_next_obs, _m_alive_obs, _m_murieron_obs, _suf

DefineEnemyShoot eshoot, 10, 37, 10, 37, 1, 0, 0x04, 0x04, _sprite_Skeleton,    enm_move1, 0x1020, -1, 1,3, 5, 0, .+4 , 5, 0, 34
DefineEnemyShoot eshoot2, 60, 37, 60, 37, 1, 0, 0x04, 0x04, _sprite_Skeleton,   enm_move1, 0x1020, 1,  1,3, 5, 0, .+4 , 5, 0, 34
DefineEnemyShoot eshoot3, 10, 37, 10, 37, 1, 0, 0x04, 0x04, _sprite_Skeleton,   enm_move1, 0x1020, -1, 1,3, 5, 0, .+4 , 5, 0, 34
DefineEnemyShoot eshoot4, 0, 37, 0, 37, 1, 0, 0x04, 0x04, _sprite_Skeleton,     enm_move1, 0x1020, 1,  1,3, 5, 0, .+4 , 5, 0, 34
;DefineEnemy enm_data, 20, 40, 20, 41, 0x00, 0x00, 0x02, 0x04, _sprite_Skeleton, enm_move1, 0x0000, 0


;;;;;;;;;;;;;;;;
;; Constantes
;;;;;;;;;;;;;;;;
k_lim_der = #34         ;; Limite Derecho del movimiento
k_lim_izq = #4          ;; Limite Izquierda del movimiento
k_lim_detectar = #15    ;; Distancia maxima a la que detecta al hero
k_total_enm = #2
k_enm_size = #23 + 5*15 ; 5*obs + 14+9



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HORIZONTAL
;; Detecta al hero a una distancia N Por el lado que
;; marca el Byte de la direccion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS:
;; ENTRADAS:
;;              IX => puntero al enemigo
;;              IY => puntero al hero
;; SALIDAS: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_move1:

    ;;; Cuando Hero y Enm estén en la misma 'Y' comprobar distancia ;;;;
    ;; h_y == e_y ?? => CALCULAR si lo detecta
    ld  a, de_y(iy)  ;; A = hero_x
    ld  h, de_y(ix)  ;; H = enm_x
    cp  a, h        ;; A - H
    jr  z, misma_y  ;; IF h_y == e_y THE    N detectar al hero   
        ;; ELSE h_y != e_y. No detectarlo
        ret  
    misma_y:

    ;;;; En que dirección hay que comprobar???
    ld a, e_direct(ix)          ;; A = enemy_direction
    cp a, #-1                    
    jr z, busca_en_la_izquierda ;; IF enm_dict == 0 THEN detect left
        
        ;; ELSE buscar en la derecha
        jp busca_en_la_derecha


    busca_en_la_izquierda:
    call buscar_izquierda   ;; H = buscar_izquierda
    jp aplicar

    busca_en_la_derecha:
    call buscar_derecha     ;; H = busca_derecha


    aplicar:
    ld a, h                 ;; A = H
    cp #0
    jr z, no_aplica         ;; IF A == 0 THEN ret

        call obs_new
        cp #0
        jr z, no_aplica

    no_aplica:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Busca al hero por la izquierda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS: HL, AF, BC
;; ENTRADAS:
;;              IX => puntero al enemigo
;;              IY => puntero al hero
;; SALIDAS: 
;;              H  => 0 no lo detecta, 
;;                    1 en caso contrario
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
buscar_izquierda:

    ;; Por defecto no lo detecta
    ld h, #0

    ;; A = (enm_x - hero_x)
    ld  a, de_x(ix)  ;; A =  enm_x
    sub a, de_x(iy)  ;; A -= hero_x

    ;; IF (e_x - h_x) <= 5 THEN detected
    cp  a, #k_lim_detectar
    jr  nc,  no_detectado

        ;; Detectado
        inc h

    ;; ELSE no hay nada que hacer
    no_detectado:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Busca al hero por la derecha
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS: HL, AF, BC
;; ENTRADAS:
;;              IX => puntero al enemigo
;;              IY => puntero al hero
;; SALIDAS: 
;;              H  => 0 no lo detecta, 
;;                    1 en caso contrario
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
buscar_derecha:
    ;; Por defecto no lo detecta
    ld h, #0

    ;; A = (hero_x - enm_x)
    ld  a, de_x(iy)  ;; A =  hero_x
    sub a, de_x(ix)  ;; A -= enm_x

    ;; IF (h_x - e_x) <= 5 THEN detected
    cp  a, #k_lim_detectar
    jr  nc,  no_detecta

        ;; Detectado
        inc h

    ;; ELSE no hay nada que hacer
    no_detecta:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HORIZONTAL
;; Ida y Vuelta Sin Parar de un punto A a otro B
;; DESTRUIDOS: todos
;; INPUT:
;;          IX => puntero a la entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_move0:
    ;; Posicion
    ld a, de_x(ix)       ;; \ A = e_x(IX)

    ;; Actualizar El Valor del Sentido
    cp a, #k_lim_der                  ;; A == lim_der value ???
    jr z, cambiar_izq               ;; IF A==max left right limit. THEN  move left

        ;; Comprueba si está en el límite izquierdo
        cp a, #k_lim_izq              ;; A == lim_izq value ???
        jr z, cambiar_der           ;; IF A==lim_izq THEN move right
        jp aplicar_sentido          ;; Aplicar el nuevo sentido a la X del enemigo

    cambiar_izq:
    ld e_direct(ix), #-1
    jp aplicar_sentido              ;; Aplicar el nuevo sentido a la X del enemigo

    cambiar_der:
    ld e_direct(ix), #1

    ;; Aplica El Sentido Obtenido
    aplicar_sentido:
    ld a, e_direct(ix)              ;; A = B
    cp a, #-1                        ;; A == #-1 ??
    jr z, mover_izq                 ;; IF A == -1 THEN move lef side

        ;; mover_der
        ld e_vx(ix), #1
        jp update_x             ;; Update the new A value

    mover_izq:
    ld e_vx(ix), #-1

    update_x:
    call ent_move                   ;; Call func ent_move for applay new x value

    ret






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR ENEMIGO QUE PUEDE DISPARAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REGISTROS DESTRUIDOS: TODOS
;; ENTRADA: 
;;          IX -> Puntero a entidad, enemy
;;          IY -> Puntero a hero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_update:
    ;Comprobar si han golpeado a enemy
    call obs_checkCollision
    cp #0
    jr z,noDamage
    ;;enemigo dañado
    
    ld a,#0
    dec e_health(ix)
    cp e_health(ix)
    jr nz, noDamage
        ;;Cambiar de estado?
      ;jr .
    noDamage:

    push ix
    push iy
    ;Acutalizas las balas del enemigo
    ld	hl, #obs_update
    call	obs_doForAll
    ;Actualizar el enemigo
    pop iy
    pop ix
    ld  h, e_up_h(ix)
    ld  l, e_up_l(ix)
    jp  (hl) ;; llamada al estado
    ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BORRAR ENEMIGO QUE PUEDE DISPARAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_clear:
    ;; Borras las balas del enemigo IX
    ld	hl, #obs_clear
    call	obs_doForAll
    ;; Borras enemigos
    call ent_clear 
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR ENEMIGO QUE PUEDE DISPARAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR ENEMIGO CON T
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_draw:
    ;; Comprobar si necesita tranparencia
    ld	a,  #0
    cp  e_alpha(ix)
    jr  nz,  dibujar_con_transparencia
    
        ;; ELSE No necesita Transparencia
        call    ren_drawEntity
        jp	    tiene_balas

    dibujar_con_transparencia:
    call ren_drawEntityAlpha

    tiene_balas:
    ld	hl, #obs_draw
    call	obs_doForAll
    ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJECUTA EL METODO PASADO EN HL SOLO PARA LOS OBS VIVOS
;; EXPLOTA: AF, BC, DE, HL
;; ENTRADA:
;;          HL -> PUNTERO AL MÉTODO A EJECUTAR
;;          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_doForAll::


    ld a,#k_total_enm ; Contador 
    
  ld iy, #ListaEnemigos

  ld  (metodo), hl      ;; (meotodo) = HL

  buc:
    ;; IF vivo == 0 THEN no aplicar la función.
    push af                       ;; PUSH AF
    ld  a, e_health(iy)            ;; A = obs_alive
    cp  #0          
    jr  z,  inc_contadores        ;; IF A == 0 THEN jump inc_contadores

  ;Salvar
        push ix
        push iy 

;; metemos EXchange
      push iy 
      push ix 
      pop iy
      pop ix

      ;; ELSE Apply Function
      metodo  = . + 1             ;; | . + 1 es el call
      call    ent_draw            ;; \ CALL metodo

      pop iy
      pop ix

    inc_contadores:
    pop	af                      ;; | POP AF
    ld c, #k_enm_size
    ld b, #0
    add iy, bc                  ;; | Iy += BC, Update pointer value
    dec a                       ;; | A--
    jr  nz, buc                 ;; \ IF A == 0 THEN stop Apply Function

    ret