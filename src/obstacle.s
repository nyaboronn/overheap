.include "obstacle.h.s"
.include "entity.h.s"

;;;;;;;;;;;;;;;;;;;;;
;; Shoots Data
;;;;;;;;;;;;;;;;;;;;;
k_max_num_obs = 20                 ;; Maximo de objetos
k_obs_size    = 14                ;; Obstacle size (in Bytes)
m_num_obs :   .db 0               ;; Número de obs creados
m_next_obs:   .dw shot_array0     ;; Posicion actual en el array
m_alive_obs:  .db 0               ;; Numero de Obs Usados
m_murieron_obs: .db 0             ;; Numero de Obs que colisionan

aux_pointer: .dw shot_array0

;_name,   _x, _y,_oldx, _oldy, _vx, _vy, _w, _h, _col, _upd, _tile
DefineObstacle obstacle1, 5, 30, 5, 30, 1, 0, 1, 1, 0x45, obs_move, 0x0000, 1
shot_array:
  DefineNObstacles shot_array, #k_max_num_obs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RESETEA LA MEMORIA DE LAS BALAS PARA SU NUEVO USO
;; ANTES DE HACERLO COMPRUEBA SI TODAS ESTAN DESTRUIDAS
;; EXPLOTAN: A, BC,
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_reset_array:

  ;; Comprobar si TODAS las balas han colisionado
  ld  a, (m_murieron_obs)     ;; A = (m_murieron_obs) value
  ld  h, a                    ;; H = A
  ld	a,  #k_max_num_obs      ;; A = #k_max_num_obs value
  cp  a,  h                   ;; A == H??
  jr  z,  actualizar_array    ;; IF A == H reset array

    ;; ELSE devolver #0, esperar a que todas colisionen
    ld  a, #0
    ret

  actualizar_array:
    ;; Copiar Obstacle1 en la posicion en cada posición del array
    ld  de, #shot_array       ;; DE = pointer to shot_array
    ld	hl, #obstacle1        ;; HL = pointer to obstalce1
    ld  a, #0                 ;; A = 0

    proceder_al_bucle:
      call obs_copy
      
      ld  hl, #k_obs_size     ;; HL = #k_obs_size value
      add hl, de              ;; HL = DE  
      ld	hl, #obstacle1      ;; HL = #obstacle1 value
      ex  de, hl              ;; DE <=> HL

      inc a                   ;; A++
      cp #k_max_num_obs       ;; A == k_max_num_obs
      jr nz, proceder_al_bucle;; IF A != k_max_num_obs iterar bucle

    ;; Reiniciar Los Valores de Las Constantes y Contadores
    ld  a, #0                 ;; A = 0
    ld (m_num_obs), a         ;; Número de obs creados

    ld hl, #shot_array        ;; HL = #shot_array pointer
    ld (m_next_obs), hl       ;; Posicion actual en el array

    ld (m_alive_obs),  a      ;; Numero de Obs Usados
    ld (m_murieron_obs), a    ;; Numero de Obs que colisionan
    
    ld a, #1                  ;; A = 1
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REGISTRA UNA NUEVA ENTIDAD. SI HA LLEGADO
;; AL TOPE DE OBS, NO REGISTRA OTRO
;; REGISTROS DESTRUIDOS: A, HL, BC
;; SALIDA: A => 0/1 si puede registrar el Obs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_new:
  ;; Ha llegado al maximo de obejtos ???
  ld  a,  (m_num_obs)     ;; A = (m_num_obs) Value
  cp  #k_max_num_obs      ;; A - #k_max_num_obs Value
  jr  nz,  nuevo_obs      ;; IF A != k_max_num_obs THEN RET

    ;; ELSE A == k_max_num_obs
    call obs_reset_array
    ret

  nuevo_obs:
  ;; Incrementar los obs usados
  ld	b, a                ;; B = A
  ld  a,  #m_alive_obs    ;; A = #m_alive_obs Value
  inc a                   ;; A++
  ld  (m_alive_obs), a    ;; (m_alive_obs) value = A
  ld  a, b                ;; A = B

  ;; Incrementar el numero de obs
  inc     a
  ld      (m_num_obs), a

  ;; Hacer mas cosas :D
  ld      hl,     (m_next_obs)
  ld      bc,     #k_obs_size
  add     hl,     bc
  ld      (m_next_obs), hl
  ld      bc,     #-k_obs_size
  add     hl,     bc
  
  ld a, #1
    
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJECUTA EL METODO PASADO EN HL SOLO PARA LOS OBS VIVOS
;; EXPLOTA: AF, BC, DE, HL
;; ENTRADA:
;;          HL -> PUNTERO AL MÉTODO A EJECUTAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_doForAll:
  ld  a,  (m_num_obs) ;; A = m_num_obs
  cp  #0              ;; A - 0
  ret z               ;; IF A == 0 THEN ret
  
  ;; ELSE Apply Function
  ld  ix, #shot_array   ;; IX = Shot_array0
  ld  (metodo), hl      ;; (meotodo) = HL

  buc:
    ;; IF vivo == 0 THEN no aplicar la función.
    push af                       ;; PUSH AF
    ld  a, o_alive(ix)            ;; A = obs_alive
    cp  #0          
    jr  z,  inc_contadores        ;; IF A == 0 THEN jump inc_contadores

      ;; ELSE Apply Function
      metodo  = . + 1             ;; | . + 1 es el call
      call    ent_draw            ;; \ CALL metodo

    inc_contadores:
    pop	af                      ;; | POP AF
    ld  bc, #k_obs_size         ;; | BC = #k_entity_size
    add ix, bc                  ;; | IX += BC, Update pointer value
    dec a                       ;; | A--
    jr  nz, buc                 ;; \ IF A == 0 THEN stop Apply Function

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR UNa obstaculo
;; REGISTROS DESTRUIDOS: TODOS
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_update:
  ;; Comprobar la colision
  ld  a, #35                  ;; A = #35
  ld  b, de_x(ix)             ;; B = de_x(ix) value
  cp	a, b                    ;; A == B ??
  jr	nc, no_la_ha_palmado    ;; IF A != B THEN NO Colisiona 

    ;; ELSE: Borrarlo e incrementar m_murieron_obs
    call obs_clear            ;; call to obs_clear function
    ld  o_alive(ix), #0       ;; o_alive(ix) = 0
    ;; Incrementar contador de muertos
    ld  a, (m_murieron_obs)   ;; A = (m_murieron_obs) value
    inc a                     ;; A++
    ld  (m_murieron_obs), a   ;; (m_murieron_obs)value = A
    ret

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
;;        HL -> ENTIDAD ORIGEN
;;        DE -> EMTODAD DESTINO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_copy:
    ld bc, #k_obs_size
    ldir
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVIEMIENTO DE UN OBSTACULO
;; REGISTROS DESTRUIDOS:    A
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_move:
  ld    a,  de_x(ix)      ;;  A = de_x
  ld    de_oldx(ix), a    ;;  oldx = A
  add   e_vx(ix)          ;;  A += e_vx
  ld    de_x(ix), a       ;;  de_x = A
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