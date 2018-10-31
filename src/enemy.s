

.include "sprite.h.s"
.include "enemy.h.s"
.include "entity.h.s"
.include "obstacle.h.s"
.include "menu.h.s"



.globl coche



ListaEnemigos: ;    
    DefineEnemyShoot eshoot, 30, 37,   0x04, 0x04, _sprite_vampiro,    FSMTote, -1,  1,  3
    DefineEnemyShoot eshoot2, 15, 37,   0x04, 0x04, _sprite_Skeleton,   enm_move0, -1,  -1,  3
    DefineEnemyShoot car, 100,   37,   0x08, 0x06, coche,   enm_move1,               -1, 0,  3

    DefineEnemyShoot eshoot5, 3, 3,  0x04, 0x04, _sprite_Skeleton,   enm_move1, 1,  1,  3   
    DefineEnemyShoot eshoot6, 21, 3,  0x04, 0x04, _sprite_Skeleton,   enm_move1, -1,  1,  3     ;;Duoataque

    DefineEnemyShoot eshoot4, 105, 4,   0x08, 0x06,  coche,     enm_move1, -1, 0,  3 
    
    DefineEnemyShoot eshoot3, 70, 37,   0x04, 0x04, _sprite_Skeleton,   enm_iddle, -1,  1,  3



CurrentEnemy: .dw ListaEnemigos
CurrentEnemyIt: .db 0x00 ;; Iterator

;;;;;;;;;;;;;;;;
;; Constantes
;;;;;;;;;;;;;;;;
k_lim_der       = #30       ;; Limite Derecho del movimiento
k_lim_izq       = #15        ;; Limite Izquierdo del movimiento
k_lim_detectar  = #15       ;; Distancia maxima a la que detecta al hero
k_total_enm     = #2           ;; Total de enemigos en memoria
k_enm_size      = #24 + k_max_balas*15 ; 5*obs + 14+9

;; Numero de enemigos vivos en el MapX
enm_map_alive: .db #k_total_enm ;;Enemigos que vamos a tener en el mapa por ronda, y va decrementando

enemies: .db #k_total_enm   ;;Enemigos que vamos a tener por ronda, que se incrementa cada ronda

life: .db 0x03      ;;Vidas de los enemigos que se van ingrementando



;; enm Jump Table (puede volar)
;enm_jumptable: ;; -17 
;     .db #-4, #-3, #-3, #-2
;     .db #-1, #-1, #5, #2
;     .db #3, #2, #1, #1
;     .db #0x80

enm_jumptable: ;; -17 
    .db #-3, #-2, #-1, #-1
    .db #-1, #1, #1, #1
    .db #2, #3
    .db #0x80



;Unsigned
;If A == N, then Z flag is set.
;If A != N, then Z flag is reset.
;If A < N, then C flag is set.
;If A >= N, then C flag is reset.


FSMTote:

     ;; Por defecto
    ld a, e_health(ix);
    ld bc, (#life)
    cp c   ;; Evento, vida 2
    jr nz, #noreset2
        ld hl, #enm_move1 ;; Cambiamos a estado JumpAndMove
        ld  (fsm1Method), hl         ;; (meotodo) = HL
        jr fsm1Method-1

    noreset2:


    ld a, e_health(ix);
    cp #2   ;; Evento, vida 2
    jr nz, #nosalta2
        ld hl, #enm_move1 
        ld  (fsm1Method), hl         ;; (meotodo) = HL
        jr fsm1Method-1

    nosalta2:


    ld a, e_health(ix);
    cp #3  ;; Evento, vida 3
    jr nz, #nodispara2
        call piro_bat
        ld hl, #jumpAndMove ;; Cambiamos a estado JumpAndMove 
        ld  (fsm1Method), hl         ;; (meotodo) = HL
        jr fsm1Method-1


    nodispara2:

    ;;ld a, e_health(ix);
    ;;cp #3  ;; Evento, vida 3
    ;;jr z, #nodispara3
    ;;    call bat_piro
    ;;    ld hl, #enm_move1 ;; Cambiamos a estado JumpAndMove 
    ;;    ld  (fsm1Method), hl         ;; (meotodo) = HL
    ;;    jr fsm1Method-1
;;
;;
    ;;nodispara3:

    ;; ELSE Apply Function
    fsm1Method  = . + 1           ;; | . + 1 es el call
    call    enm_iddle   

    ;; Poder mover al enemigo
    call enm_move
ret


bat_piro:

    ld hl, #_sprite_vampiro
    ld de_sprite+1(ix),h
    ld de_sprite(ix),l


ret

piro_bat:

    ld hl, #_sprite_murcielago
    ld de_sprite+1(ix),h
    ld de_sprite(ix),l

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;     Maquina de estados finitos 
;;; El metodo de update se ocupa de ejecutar el metodo/estado en el que se encuentra
;;; Ademas comprobara si existe un evento de entrada para cambiar el estado
;;; Es necesario cambiar la etiqueta fsm1Method
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FSM1::
    ;; Por defecto
    ld a, e_health(ix);
    ld bc, (#life)
    cp c   ;; Evento, vida 2
    jr nz, #noreset
        ld hl, #enm_iddle ;; Cambiamos a estado JumpAndMove
        ld  (fsm1Method), hl         ;; (meotodo) = HL
        jr fsm1Method-1

    noreset:


    ld a, e_health(ix);
    cp #2   ;; Evento, vida 2
    jr nz, #nosalta
        ld hl, #jumpAndMove ;; Cambiamos a estado JumpAndMove
        ld  (fsm1Method), hl         ;; (meotodo) = HL
        jr fsm1Method-1

    nosalta:


    ld a, e_health(ix);
    cp #3  ;; Evento, vida 3
    jr nz, #nodispara
        ld hl, #enm_move1 ;; Cambiamos a estado JumpAndMove 
        ld  (fsm1Method), hl         ;; (meotodo) = HL
        jr fsm1Method-1


    nodispara:



    ;; ELSE Apply Function
    fsm1Method  = . + 1           ;; | . + 1 es el call
    call    enm_iddle   

    ;; Poder mover al enemigo
    call enm_move


ret




jumpAndMove:
    ld  a,  e_jump(ix)  ;; A = hero_jumpstate
    cp  #-1             ;; A == -1? 
    jr  nz , skip             ;; A != 0. Jump is no activate, lest do

    ;; Jump is inactive, active it
    
        ld  e_jump(ix), #0
          ;;Cambiar por sentido
    ld  e_vx(ix), #2

skip:
  


    call enm_jumpControl



ret	




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CONTROLA EL SALTO DE LA ENTIDAD
;; REGISTROS DESTRUIDOS: A, BC, HL
;; ENTRADAS:
;;          IX => Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_jumpControl:

    ;; Check if we are jumping right now
    ld  a,  e_jump(ix)      ;; A = hero_jumpstate status
    cp  #-2                 ;; A == -2?
    ret z                   ;; A == 0. Cant activate. Entity is falling
    cp  #-1                 ;; A == -1? (-1 is not jumping)
    ret z                   ;; If  A == -1, not jumping

    ;; Move Hero
    ld  hl, #enm_jumptable ;; HL = Primer Valor de JumpTable
    ld  c,  a               ;; | C = Índice a acceder
    ld  b,  #0              ;; | 
    add hl, bc              ;; \ HL += BC

    ;; Check End of jumping && Store in A jump value
    ld  a,  (hl)            ;; A = jump movement
    cp  #0x80               ;; Jump value == 0
    jr  z,  end_of_jump     ;; if 0x80, end of jump

    ;; Do jump movement (HL = Posición de memoria con el dato de jumpTable)
    ld  b,  a               ;; B = valor del salto
    ld  a,  e_vy(ix)        ;; A = Coordenada X de la entidad
    add b                   ;; B += A (Sumar al valor del salto la X)
    ld  e_vy(ix), a         ;; e_x = Calculo de la nueva X 

    ;;call hero_move

    ;; Increment hero_jumpstate Index
    ld  a,  e_jump(ix)      ;; A = hero_jumpstate
    inc a                   ;; | 
    ld  e_jump(ix), a       ;; \ hero_jumpstate++
    ret

    ;; Put -1 in the jump index when jump ends
    end_of_jump:
        ld  a, #-1           ;; |
        ld  e_jump(ix), a    ;; \ hero_jumpstate = -1
ret




;Ejecutar hl para CurrentEnemy
;Comprobar si emos llegado al final de los ListaEnemigos
;    si- > Resetar puntero a ListaEnemigos
;    no-> Sumar offset
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Resetea las vidas que se van a incrementar de los
;; enemigos
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
reiniciar_life:
    ld a, #0x03
    ld (life), a
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Resetea el valor de enm_map_alive deafult
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
reiniciar_enm_map_alive:
    ld a, #k_total_enm
    ld (enm_map_alive), a
ret


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



    ld  iy, #CurrentEnemy

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
    ld hl, (#enemies)
    dec l
    cp l
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




enm_move:

  ld    a,  de_x(ix)      ;;  A = de_x
  ld    de_oldx(ix), a    ;;  oldx = A
  add   e_vx(ix)          ;;  A += e_vx
  ld    de_x(ix), a       ;;  de_x = A


  ld    a,  de_y(ix)      ;;  A = de_x
  ld    de_oldy(ix), a    ;;  oldx = A
  add   e_vy(ix)          ;;  A += e_vx
  ld    de_y(ix), a       ;;  de_x = A

      ld e_vx(ix), #0
    ld  e_vy(ix), #0
ret 


;;;;;;;;;;;;;;;;;;;
;;Enemigo no hace nada
;;
;;;;;;;;;;;;;;;;;;;;
enm_jump:
call enm_jumpControl
call enm_move
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

   ; ld	hl, #enm_map_alive
   ; ld (hl), #2;;enemies
    call reset_posi
    
    ld  hl, #ListaEnemigos
    ld (#CurrentEnemy),hl




    ld hl, #CurrentEnemyIt
    ld (hl), #0x00

    call reiniciar_enm_map_alive

    ld hl, #reset_enemy
    call enm_doForAllForDead

    
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Resetea las posiciones
;; Entrada IX -> Enemy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
reset_posi:

    ld  hl, #eshoot
    ld (hl), #30
    inc hl
    ld (hl), #37

    ld ix, #eshoot
    ld hl, #_sprite_vampiro
    ld de_sprite+1(ix),h
    ld de_sprite(ix),l

    ld  hl, #eshoot2
    ld (hl), #60
    inc hl
    ld (hl), #37

    ld  hl, #car
    ld (hl), #100
    inc hl
    ld (hl), #37

    ld  hl, #eshoot5
    ld (hl), #3
    inc hl
    ld (hl), #3

    ld  hl, #eshoot6
    ld (hl), #21
    inc hl
    ld (hl), #3

    ld  hl, #eshoot4
    ld (hl), #105
    inc hl
    ld (hl), #4

    ld  hl, #eshoot3
    ld (hl), #70
    inc hl
    ld (hl), #37

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
    call reset_posi
   
    ld e_health(ix), #3

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Incrementa el núemro de enemigos en el mapa
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
increase_enemies:

    ld a, (enemies)
    inc a
    ld (enemies), a
    ld (enm_map_alive), a

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Se encarga de incrementar enemigos, vida y aplicar la vida a los enemigos
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_improve::

    call increase_enemies
    ;;call reiniciar_enm_map_alive
    call increase_life
    call reset_posi

    ld hl, #aplica_life
    call enm_doForAllForDead

    
ret


;;;;;;;;;;;;;;;;;;;;
;;Incrementa la vida del enemigo
;;;;;;;;;;;;;;;;;;;;
increase_life:

    ld a, (life)
    add a, #2
    ld (life), a

ret
;;;;;;;;;;;;;;;;;;;;
;;Aplica la vida incrementada a los enemigos
;;;;;;;;;;;;;;;;;;;;
aplica_life:
    ld a, (life)
    ld e_health(ix),a

   

   ;; ld de_x(ix), #60
   ;; ld de_y(ix), #37
   ;; ld de_oldx(ix), #60
   ;; ld de_oldy(ix), #37

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
;;          IX => puntero a la entidad enemiga
;;          IY => puntero al hero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_move0:
    ;; Comprobar colisión
    call obs_checkCollision
    cp a, #1
    jr nz, seguir_movimiento

        ;; Invertir Sentido Enemy
        ld a, e_direct(ix)
        cp a, #-1
        jr z, emp_hero_der
        jr emp_hero_izq

    seguir_movimiento:

    ;; Posicion
    ld a, de_x(ix)              ;; \ A = e_x(IX)
    cp a, #k_lim_der            ;; A == lim_der value ???
    jr z, cambiar_izq           ;; IF A==max left right limit. THEN  move left

        ;; Comprueba si está en el límite izquierdo
        cp a, #k_lim_izq        ;; A == lim_izq value ???
        jr z, cambiar_der       ;; IF A==lim_izq THEN move right
        jp aplicar_sentido      ;; Aplicar el nuevo sentido a la X del enemigo

    
    ;; Primero empujar al hero y cambiar la dirección
    emp_hero_izq:
    ld a, #5
    ld e_vx(iy), a
    call enm_move

    cambiar_izq:
    ld e_direct(ix), #-1
    jp aplicar_sentido          ;; Aplicar el nuevo sentido a la X del enemigo

    emp_hero_der:
    ld a, #-5
    ld e_vx(iy), a
    call enm_move

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
    
    ;; Comprobar si Hero Colisiona con Enmy
    call obs_checkCollision     ;; CheckCollision bettewm hero and enemy
    cp a, #0                    ;;
    jr z, seguir_update         ;; IF a = 0 THEN no collision

        ;; ELSE: decrementar la vida al hero
        ld a, e_health(iy)
        cp #1
        jr z, terminarPartida

            ;; ELSE: vida > 0, decrementarla
           dec a
           ld e_health(iy), a
            jr seguir_update
terminarPartida:

               call end_game

ret
    seguir_update:

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
      
            ;;Fuerzo la limpieza del enm
             call ren_DestroyEntity
            
            ;;Fuerzo la limpieza de las balas
            ld	hl, #ren_DestroyEntity
            call	obs_doForAll



            
             
            ;; Comprobar si quedan enemigos vivos
            ;; En caso contrario carga la siguiente pantalla
             call siguiente_mapa

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



  ;;  call FSM1
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



    ld  a,  (enemies) ; Contador 

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

    ld  a,  (enemies) ; Contador 

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


