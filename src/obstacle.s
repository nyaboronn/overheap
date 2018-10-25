.include "obstacle.h.s"
.include "entity.h.s"
.include "enemy.h.s"
.include "utils.h.s"

;;;;;;;;;;;;;;;;;;;;;
;; Shoots Data
;;;;;;;;;;;;;;;;;;;;;
k_obs_size = #15

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RESETEA LA MEMORIA DE LAS BALAS PARA SU NUEVO USO
;; ANTES DE HACERLO COMPRUEBA SI TODAS ESTAN DESTRUIDAS
;; EXPLOTAN: A, BC,
;; ENTRADAS: 
;;          IX => Puntero a la entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_reset_array::

  ;; Comprobar si TODAS las balas han colisionado
  ld  a, m_murieron_obs(ix)     ;; A = m_murieron_obs(ix) value
  ld  h, a                    ;; H = A
  ld	a,  k_max_num_obs(ix)      ;; A = k_max_num_obs value
  cp  a,  h                   ;; A == H??
  jr  z,  actualizar_array    ;; IF A == H reset array

    ;; ELSE devolver #0, esperar a que todas colisionen
    ld  a, #0
    ret

  actualizar_array:
    ;; Copiar Obstacle1 en la posicion en cada posición del array
        ;; DE = pointer to shot_array

    push ix
    pop hl
    ld de, #shot_array
    add hl, de
  
    ;lets save IY register in the stacks
    push iy

    push HL
    pop iy

    ;ld	hl, #obstacle1        ;; HL = pointer to obstalce1
    ld  a, #0                 ;; A = 0

    proceder_al_bucle:
      ;; Esto esta mal porque el punteor es a enemy, y tenemos que usar la bala
      ld o_alive(iy), #1 ;;
      

      ld  d, #0     ;; de = #k_obs_size value
      ld  e, #k_obs_size
      add iy, de              ;; 

      inc a                   ;; A++
      cp k_max_num_obs(ix)      ;; A == k_max_num_obs
      jr nz, proceder_al_bucle;; IF A != k_max_num_obs iterar bucle


    ;; Reiniciar Los Valores de Las Constantes y Contadores
   ; ld  a, #0                 ;; A = 0
    ld m_num_obs(ix), #0         ;; Número de obs creados


    ; ix + shot_array  = Array de balas
    push ix
    pop hl
    ld de, #shot_array
    add hl, de

    ld  m_next_obs+1(ix), h   ;; IX = Shot_array0
    ld  m_next_obs(ix), l   ;; IX = Shot_array0

    ld a, k_max_num_obs(ix)
    ld m_alive_obs(ix), a     ;; Numero de Obs Usados
    ld m_murieron_obs(ix), #0    ;; Numero de Obs que colisionan

    ;; Resetear puntero al array

    ;;And now restore iy
    pop iy 
    ld a, #1                  ;; A = 1
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REGISTRA UNA NUEVA ENTIDAD. SI HA LLEGADO
;; AL TOPE DE OBS, NO REGISTRA OTRO
;; REGISTROS DESTRUIDOS: A, HL, BC
;; SALIDA: A => 0/1 si puede registrar el Obs
;; ENTRADAS: 
;;          IX => Puntero a la entidad, enemigo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_new:
  ;; Ha llegado al maximo de obejtos ???
  ld h, m_next_obs+1(ix)
  ld l, m_next_obs(ix)
;push hl 
;pop iy


  ld  a,  m_num_obs(ix)     ;; A = m_num_obs(ix) Value
  cp  k_max_num_obs(ix);#k_max_num_obs      ;; A - k_max_num_obs Value
  jr  nz,  nuevo_obs      ;; IF A != k_max_num_obs THEN RET

    ;; ELSE A == k_max_num_obs
    call obs_reset_array
    ret ;; Borrar para asi no recargar

  nuevo_obs:

  ;; Incrementar los obs usados
  ld	b, a                ;; B = A
  ld  a,  m_alive_obs(ix)    ;; A = m_alive_obs(ix) Value
  inc a                   ;; A++
  ld  m_alive_obs(ix), a    ;; m_alive_obs(ix) value = A
  ld  a, b                ;; A = B

  ;; Incrementar el numero de obs
  inc     a
  ld      m_num_obs(ix), a
 ; ld      m_alive_obs(ix), a


  ;; Hacer mas cosas :D
  ;ld      hl,     (m_next_obs)
  ld  h, m_next_obs+1(ix)   ;; IX = Shot_array0
  ld  l, m_next_obs(ix)   ;; IX = Shot_array0

  push HL
  pop iy

  ld a, de_x(ix)
  ld de_x(iy), a
 ld de_oldx(iy), a
 
  ld a, de_y(ix)
  ld de_y(iy), a
  ld de_oldy(iy), a

  push hl
  call CalcualteOFFSET

    ;;cargamos la tile donde estams
    ld      e_tile_h(iy) , h
    ld      e_tile_l(iy), l
  pop hl

  ld a, e_direct(ix)
  ld e_vx(iy), a
  
  ld c, #k_obs_size
  ld b, #0
  add     hl,     bc
  ;ld      (m_next_obs), hl
  ld  m_next_obs+1(ix), h   ;; IX = Shot_array0
  ld  m_next_obs(ix), l   ;; IX = Shot_array0
  ld c, #k_obs_size
  ld b, #-1
  add     hl,     bc
  
  ld a, #1
    
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJECUTA EL METODO PASADO EN HL SOLO PARA LOS OBS VIVOS
;; EXPLOTA: AF, BC, DE, HL
;; ENTRADA:
;;          HL -> PUNTERO AL MÉTODO A EJECUTAR
;;          IX => Puntero a la entidad dueña de las balas/ enemy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_doForAll::
  ld  a,  m_num_obs(ix) ;; A = m_num_obs
  cp  #0              ;; A - 0
  ret z               ;; IF A == 0 THEN ret
  

  ;; ELSE Apply Function
  push hl
  ;ld  h, shot_array+1(ix)   ;; IX = Shot_array0
  ;ld  l, shot_array(ix)   ;; IX = Shot_array0
  
  push ix
  pop hl
  
  ld de, #shot_array
  add hl, de
  
  push hl
  pop iy
  pop hl

  ld  (metodo), hl      ;; (meotodo) = HL

  buc:
    ;; IF vivo == 0 THEN no aplicar la función.
    push af                       ;; PUSH AF
    ld  a, o_alive(iy)            ;; A = obs_alive
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
    ld c, #k_obs_size
    ld b, #0
    add iy, bc                  ;; | Iy += BC, Update pointer value
    dec a                       ;; | A--
    jr  nz, buc                 ;; \ IF A == 0 THEN stop Apply Function

    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve 0 si la tile donde esta la entidad en solida
;; Distinto de -1 en caso contrario
;; REGISTROS DESTRUIDOS: 
;; ENTRADA: 
;;          IX -> Entity
;; SALIDA: 
;;          A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_is_solidTile:

    ld  h,  e_tile_h(ix)
    ld  l,  e_tile_l(ix)
    inc hl ;; En vez de incrementar habria que hacerlo con el ancho - 1

    ld  A,  (hl)
    bit     #7, a
    ld      a,  #0  ;;Esto es necesario=
    ret nz

    call    ent_getActualTile

    bit     #7, a
    ld      a,  #0  ;;
    ret z

ret	



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR UNa obstaculo
;; REGISTROS DESTRUIDOS: TODOS
;; ENTRADA: 
;;   
;;          IX => Al obstaculo -> Una bala
;;          IY => Enemigo 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_update::


    ;;check if entity is in a solid tile
    ;;Cambiar logica del if, porque no estabamos usando el bit mas significativo para representar la colision
    call    obs_is_solidTile ;; Devuelve en B true o false
    jr z, no_la_ha_palmado


  ;; Comprobar la colision
 ; ld  a, #35                  ;; A = #35
 ; ld  b, de_x(ix)             ;; B = de_x(ix) value
 ; cp	a, b                    ;; A == B ??
 ; jr	nc, no_la_ha_palmado    ;; IF A != B THEN NO Colisiona 

    ;; ELSE: Borrarlo e incrementar m_murieron_obs
    ;call obs_clear            ;; call to obs_clear function
    ld  o_alive(ix), #0       ;; o_alive(ix) = 0
    ;; Incrementar contador de muertos
    ld  a, m_murieron_obs(iy)   ;; A = m_murieron_obs(ix) value
    inc a                     ;; A++
    ld  m_murieron_obs(iy), a   ;; m_murieron_obs(ix)value = A
    ret
;
  no_la_ha_palmado:
    call ent_update

  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_draw:
  call ren_drawEntity
  ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BORRA UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF',AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_clear:
  call ren_clearEntity
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COPIA LOS VALORES DE UNA ENTIDAD SOBRE OTRA
;; REGISTROS DESTRUIDOS:
;; ENTRADA: 
;;        HL -> ENTIDAD ORIGEN, plantilla
;;        DE -> EMTODAD DESTINO
;;        IX => Puntero a la entidad, posiciom del array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_copy:
    ld c, #k_obs_size
    ld b, #0
    ld d, m_next_obs+1(ix)
    ld e, m_next_obs(ix)
    ldir
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVIEMIENTO DE UN OBSTACULO
;; REGISTROS DESTRUIDOS:    A,BC
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_move:

  ld   a, e_vx(ix)          ;;  A = e_vx

  call AtoBCextendendsign

  ld    a,  de_x(ix)      ;;  A = de_x
  ld    de_oldx(ix), a    ;;  oldx = A
  add   e_vx(ix)          ;;  A += e_vx
  ld    de_x(ix), a       ;;  de_x = A

  ld    h , e_tile_h(ix) 
  ld    l,  e_tile_l(ix)

  add hl, bc

  ;;cargamos la tile donde estams
  ld      e_tile_h(ix) , h
  ld      e_tile_l(ix), l

  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   CHECKS COLLISIONS BETWEEN OBSTACLE AND OBJ
;;    Input: Iy and IX swaped
;;         IY: Points to the Hero 
;;         IX: Points to the Obtacle
;;        Delete Registers: IX, IY, A, C, B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_checkCollision::
  ;;  X axis - Left Side
  ;;  IF (obs_x + obx_w <= herde_x) THEN no_collision
  ;;  obs_x + obx_w - herde_x <= 0
  ld    a,  de_x(iy)      ;;  A = obs_x
  ld	  c,  a             ;;  C = A
  ld    a,  de_w(iy)      ;;  A = obs_w
  add   c                 ;;  A += C
  sub	  de_x(ix)          ;;  A - con lo que hay en iy
  jr z, obs_no_collision      ;;  IF (<= 0)
  jp m, obs_no_collision      ;; 

  ;;  Y axis
  ld    a,  de_y(iy)      ;;  A = obs_y
  ld	  c,  a             ;;  C = A
  ld    a,  de_h(iy)      ;;  A = obs_h
  add   c                 ;;  A += C
  sub	  de_y(ix)          ;;  A -= de_y
  jr z, obs_no_collision      ;;  IF (<= 0)
  jp m, obs_no_collision      ;;

  ;;  X axis - Right Side
  ;;  IF (herde_x + hero_w <= obs_x)
  ;;  herde_x + hero_w - obs_x <= 0
  ld    a,  de_x(ix)      ;;  A = de_x
  ld    c,  de_w(ix)      ;;  C = de_w
  add   c                 ;;  A += C
  ld	  c,  a             ;;  C += A
  ld    a,  de_x(iy)      ;;  A = de_x
  ld    b,  a             ;;  B = A
  ld    a,  c             ;;  A = C
  sub   b                 ;;  A -= B
  jr z, obs_no_collision      ;;  IF (<=0)
  jp m, obs_no_collision

  ;;  Y axis
  ld    a,  de_y(ix)      ;;  A = hero_x
  ld    c,  de_h(ix)      ;;  C = de_h
  add   c                 ;;  A += C
  ld	  c,  a             ;;  C = A
  ld    a,  de_y(iy)      ;;  A = obs_y
  ld    b,  a             ;;  obs_x = B
  ld    a,  c             ;;  A = C
  sub   b                 ;;  A = (herde_x + hero_w) - obs_x
  jr z, obs_no_collision      ;;  IF (<=0)
  jp m, obs_no_collision

  ld	a, #0x01 ;;#1
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   CHECKS COLLISIONS BETWEEN OBSTACLE AND OBJ
;;    Input: Iy and IX swaped
;;         IY: Points to the Hero 
;;         IX: Points to the Obtacle
;;        Delete Registers: IX, IY, A, C, B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_no_collision:
  ld	a, #0x00
  ret
