


.include "enemy.h.s"
.include "entity.h.s"
.include "obstacle.h.s"
.include "menu.h.s"

;; SPRITE que usan los enemigos
.globl _sprite_Skeleton
.globl coche


ListaEnemigos: ;                                                                       
    ;DefineEnemyShoot eshoot, 10, 37,   0x04, 0x04, _sprite_Skeleton,    enm_move1, 1,  1,  10
    DefineEnemyShoot eshoot2, 70, 37,   0x04, 0x04, _sprite_Skeleton,   enm_move1, -1,  1,  3
    ;DefineEnemyShoot eshoot3, 10, 37,  0x04, 0x04, _sprite_Skeleton,   enm_move1, -1,  1,  10
    DefineEnemyShoot eshoot4, 6, 37,   0x04, 0x04,  _sprite_Skeleton,     enm_move0, 1, 1,  3
    DefineEnemyShoot car, 105,   37,   0x08, 0x06, coche,   enm_move1,               -1, 0,  10



CurrentEnemy: .dw ListaEnemigos
CurrentEnemyIt: .db 0x00 ;; Iterator

;;;;;;;;;;;;;;;;
;; Constantes
;;;;;;;;;;;;;;;;
k_lim_der       = #34       ;; Limite Derecho del movimiento
k_lim_izq       = #4        ;; Limite Izquierdo del movimiento
k_lim_detectar  = #15       ;; Distancia maxima a la que detecta al hero
k_total_enm     = #3           ;; Total de enemigos en memoria
k_enm_size      = #23 + k_max_balas*15 ; 5*obs + 14+9

;; Numero de enemigos vivos en el MapX
enm_map_alive: .db #k_total_enm

life: .db 0x05




;Ejecutar hl para CurrentEnemy
;Comprobar si emos llegado al final de los ListaEnemigos
;    si- > Resetar puntero a ListaEnemigos
;    no-> Sumar offset
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ejecuta la un metodo para el enemigo actual
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS: H, A
;; ENTRADAS:
;;   
;; SALIDAS: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
doForCurrentEnemy:



    ld  iy, (#CurrentEnemy)

    ld  (metodoActual), hl         ;; (meotodo) = HL


    ;; IF vivo == 0 THEN no aplicar la función.
    ld      a, e_health(iy)  ;; A = obs_alive
    cp  #0          
    jr  z,  nextEnemy   ;; IF A == 0 THEN jump inc_contadores

    ;Salvar
    push    ix
    push    iy 

    ;; metemos EXchange
    push    iy 
    push    ix 
    pop     iy
    pop     ix

    ;; ELSE Apply Function
    metodoActual  = . + 1           ;; | . + 1 es el call
    call    ent_draw          ;; \ CALL metodo

    pop     iy
    pop     ix

    nextEnemy:

    ld a, (#CurrentEnemyIt)
    cp #k_total_enm-1
    jr z, resetCurrent


    ld  iy, (#CurrentEnemy)
	
    
    ld      c,  #k_enm_size   ;; | C = k_enm_size
    ld      b,  #0            ;; | B = 0
    add     iy, bc            ;; | Iy += BC, Update pointer value
    ld (#CurrentEnemy),iy
    
    
    ld a, (#CurrentEnemyIt)
    inc a
    ld (#CurrentEnemyIt),a


ret
    resetCurrent:

    ld  hl, #ListaEnemigos
    ld (#CurrentEnemy),hl


    ld a, #0x00
    ld (#CurrentEnemyIt),a



ret	


;;;;;;;;;;;;;;;;;;;
;;Enemigo no hace nada
;;
;;;;;;;;;;;;;;;;;;;;

enm_iddle:
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve a la vida a los esqueletos
;; LLAMAR SIEMPRE ANTES DE HERO_DEFAULT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_default::

    ld	hl, #enm_map_alive
    ld (hl), #k_total_enm

    ld hl, #reset_enemy
    call enm_doForAllForDead

    
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Resetea los bits del enemy
;; Entrada IX -> Enemy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
reset_enemy::
    ;;ld de_x(ix), #60
    ;;ld de_y(ix), #37
    ;;ld de_oldx(ix), #60
    ;;ld de_oldy(ix), #37
   
    ld e_health(ix), #5

ret

enemy_improve::

    ld	hl, #enm_map_alive
    ld (hl), #k_total_enm

    ld hl, #increase_life
    call enm_doForAllForDead

    
ret

increase_life:

    ld a, (life)
    add a, a
    ld (life), a
    ld e_health(ix),a

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Detecta al hero a una distancia k_lim_detectar 
;; indicado el por el Byte _direct
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS: H, A
;; ENTRADAS:
;;              IX => puntero al enemigo
;;              IY => puntero al hero
;; SALIDAS: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_move1:

    ;;; Cuando Hero y Enm estén en la misma 'Y' comprobar distancia ;;;;
    ;; h_y == e_y ?? => CALCULAR si lo detecta
    ld  a, de_y(iy)             ;; A = hero_x
    ld  h, de_y(ix)             ;; H = enm_x
    cp  a, h                    ;; A - H
    jr  z, misma_y              ;; IF h_y == e_y THE    N detectar al hero   
        ;; ELSE h_y != e_y. No detectarlo
        ret  
    misma_y:

    ;; Comprobar en que dirección buscar el Hero
    ld a, e_direct(ix)          ;; A = enemy_direction
    cp a, #-1                    
    jr z, busca_en_la_izquierda ;; IF enm_dict == 0 THEN detect left
        
        ;; ELSE buscar en la derecha
        jp busca_en_la_derecha


    busca_en_la_izquierda:
    call buscar_izquierda       ;; H = buscar_izquierda
    jp aplicar

    busca_en_la_derecha:
    call buscar_derecha         ;; H = busca_derecha


    aplicar:
    ld a, h                     ;; A = H
    cp #0
    jr z, no_aplica             ;; IF A == 0 THEN ret

        call obs_new
        cp #0
        jr z, no_aplica

    no_aplica:
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Busca al hero por la izquierda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS: H, A
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
;; DESTRUIDOS: H, A
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
;; Mover desde k_lim_der hastas k_lim_izq, en el eje X
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS: A, HL, BC
;; INPUT:
;;          IX => puntero a la entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_move0:
    ;; Posicion
    ld a, de_x(ix)              ;; \ A = e_x(IX)

    ;; Actualizar El Valor del Sentido
    cp a, #k_lim_der            ;; A == lim_der value ???
    jr z, cambiar_izq           ;; IF A==max left right limit. THEN  move left

        ;; Comprueba si está en el límite izquierdo
        cp a, #k_lim_izq        ;; A == lim_izq value ???
        jr z, cambiar_der       ;; IF A==lim_izq THEN move right
        jp aplicar_sentido      ;; Aplicar el nuevo sentido a la X del enemigo

    cambiar_izq:
    ld e_direct(ix), #-1
    jp aplicar_sentido          ;; Aplicar el nuevo sentido a la X del enemigo

    cambiar_der:
    ld e_direct(ix), #1

    ;; Aplica El Sentido Obtenido
    aplicar_sentido:
    ld a, e_direct(ix)          ;; A = B
    cp a, #-1                   ;; A == #-1 ??
    jr z, mover_izq             ;; IF A == -1 THEN move lef side

        ;; ELSE: mover_der
        ld e_vx(ix), #1
        jp update_x             ;; Update the new A value

    mover_izq:
    ld e_vx(ix), #-1

    update_x:
    call obs_move               ;; Call func ent_move for applay new x value

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CARGA EL SIGUIENTE MAPA / GAME OVER cuando el número
;; de enemigos vivos en el mapa llega a 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REGISTROS DESTRUIDOS: A
;; ENTRADA: 
;;          IX -> Puntero a entidad, enemy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
siguiente_mapa:
    ;; Cuando Un Enemigo Llega a Heal = 0, 
    ;; Decrementar enm_map_alive. Si este valor
    ;; llega a 0, no quedan enemigos por matar y acaba el mapa
    ;; Comprobar si el enemigo sigue con vida
    ld  a,  e_health(ix)  ;; A = e_health
    cp  #0
    jr  nz, seguir_el_mapa   ;; IF A == 0 THEN jump inc_contadores

        ;; ELSE decrementar enm_map_alive
        ld  a, (enm_map_alive)
        dec a
        ld  (enm_map_alive), a

        ;; Quedan enemigos vivos???
        cp a, #0
        jr nz, seguir_el_mapa

            ;; ELSE CARGAR SIGUIENTE MAPA
            ;;jr .
            call next_game

    seguir_el_mapa:

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR ENEMIGO QUE PUEDE DISPARAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: 
;;          IX -> Puntero a entidad, enemy
;;          IY -> Puntero a hero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_update:

    ;Salvamos ix e iy 
    push ix
    push iy 

    ;; EXCHANGE IY IX
    push iy 
    push ix 
    pop iy                              ;; IY -> Puntero a entidad, enemy
    pop ix                              ;; IX -> Puntero a hero
    
    ;; Comprobar las colisiones con las balas
    ld      hl,  #obs_checkCollision
    call    obs_doForAllBool            ;; RETURN A = 0 Ò A = 1

    ;; Restaurar los punteros de ix, iy
    pop iy                              ;; IY -> Puntero a entidad, enemy
    pop ix                              ;; IX -> Puntero a hero

    cp #1
    jr nz, #noGolpeado                  ;; IF A != 0 THEN colisión no detectada

        ;; ELSE: decrementar la vida al enemigo
        ld  a, e_health(IX)
        dec a
        ld  e_health(IX),a
        
        cp #0
        jr nz, noDamage

            ;; ELSE 
                ;;Cambiar de estado?
                ;; Animacion de muerte
              ;  call ren_clearEntity
             call ren_DestroyEntity
            

             

    noDamage:
    noGolpeado:

    ;; Guardar IX, IY
    push ix
    push iy

    ;Acutalizas las balas del enemigo
    ld	hl, #obs_update
    call	obs_doForAll
    
    ;; Recuperar IX, IY destruidos por el call
    pop iy
    pop ix


    ;; Comprobar si quedan enemigos vivos
    ;; En caso contrario carga la siguiente pantalla
    call siguiente_mapa

    ;Actualizar el enemigo
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
;; DIBUJAR ENEMIGO CON TRANSPARENCIA
;; ENTRADA: IX -> Puntero a entidad
;; DESTRUIDOS:  A, BC, DE, HL, IY
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
;; DESTRUIDOS: A, BC, DE, HL, IY, IX
;; ENTRADA: HL -> PUNTERO AL MÉTODO A EJECUTAR
;;          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_doForAll:

  ;;  ld  a,  #k_total_enm ; Contador 
    ld a, (#enm_map_alive)


    ld  iy, #ListaEnemigos

    ld  (metodo), hl         ;; (meotodo) = HL

    buc:
    ;; IF vivo == 0 THEN no aplicar la función.
    push    af               ;; PUSH AF
    ld      a, e_health(iy)  ;; A = obs_alive
    cp  #0          
    jr  z,  inc_contadores   ;; IF A == 0 THEN jump inc_contadores

    ;Salvar
    push    ix
    push    iy 

    ;; metemos EXchange
    push    iy 
    push    ix 
    pop     iy
    pop     ix

    ;; ELSE Apply Function
    metodo  = . + 1           ;; | . + 1 es el call
    call    ent_draw          ;; \ CALL metodo

    pop     iy
    pop     ix

    inc_contadores:
    pop	    af                ;; | POP AF
    ld      c,  #k_enm_size   ;; | C = k_enm_size
    ld      b,  #0            ;; | B = 0
    add     iy, bc            ;; | Iy += BC, Update pointer value
    dec     a                 ;; | A--
    jr  nz, buc               ;; \ IF A == 0 THEN stop Apply Function

ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJECUTA EL METODO PASADO EN HL SOLO PARA LOS OBS VIVOS
;; DESTRUIDOS: A, BC, DE, HL, IY, IX
;; ENTRADA: HL -> PUNTERO AL MÉTODO A EJECUTAR
;;          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_doForAllForDead:

    ld  a,  #k_total_enm ; Contador 

    ld  iy, #ListaEnemigos

    ld  (metodoDead), hl         ;; (meotodo) = HL

    bucle:
    ;; IF vivo == 0 THEN no aplicar la función.
    push    af               ;; PUSH AF


    ;Salvar
    push    ix
    push    iy 

    ;; metemos EXchange
    push    iy 
    push    ix 
    pop     iy
    pop     ix

    ;; ELSE Apply Function
    metodoDead  = . + 1           ;; | . + 1 es el call
    call    ent_draw          ;; \ CALL metodo

    pop     iy
    pop     ix

   
    pop	    af                ;; | POP AF
    ld      c,  #k_enm_size   ;; | C = k_enm_size
    ld      b,  #0            ;; | B = 0
    add     iy, bc            ;; | Iy += BC, Update pointer value
    dec     a                 ;; | A--
    jr  nz, bucle               ;; \ IF A == 0 THEN stop Apply Function

ret


