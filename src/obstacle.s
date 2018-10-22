.include "obstacle.h.s"
.include "entity.h.s"
.include "enemy.h.s"

;;;;;;;;;;;;;;;;;;;;;
;; Shoots Data
;;;;;;;;;;;;;;;;;;;;;

;_name,   _x, _y,_oldx, _oldy, _vx, _vy, _w, _h, _col, _upd, _tile
DefineObstacle obstacle1, 5, 30, 5, 30, 1, 0, 1, 1, 0x45, obs_move, 0x0000, 1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RESETEA LA MEMORIA DE LAS BALAS PARA SU NUEVO USO
;; ANTES DE HACERLO COMPRUEBA SI TODAS ESTAN DESTRUIDAS
;; EXPLOTAN: A, BC,
;; ENTRADAS: 
;;          IX => Puntero a la entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_reset_array:

  ;; Comprobar si TODAS las balas han colisionado
  ld  a, enm_m_murieron_obs(ix)     ;; A = enm_m_murieron_obs(ix) value
  ld  h, a                    ;; H = A
  ld	a,  enm_k_max_num_obs(ix)      ;; A = k_max_num_obs value
  cp  a,  h                   ;; A == H??
  jr  z,  actualizar_array    ;; IF A == H reset array

    ;; ELSE devolver #0, esperar a que todas colisionen
    ld  a, #0
    ret

  actualizar_array:
    ;; Copiar Obstacle1 en la posicion en cada posición del array
    ld  d, enm_shot_array+1(ix) 
    ld  e, enm_shot_array(ix)       ;; DE = pointer to shot_array
    ld	hl, #obstacle1        ;; HL = pointer to obstalce1
    ld  a, #0                 ;; A = 0

    proceder_al_bucle:
      call obs_copy
      
      ld  h, #0     ;; HL = #k_obs_size value
      ld  l, enm_k_obs_size(ix)
      add hl, de              ;; HL = DE  
      ld	hl, #obstacle1      ;; HL = #obstacle1 value
      ex  de, hl              ;; DE <=> HL

      inc a                   ;; A++
      cp enm_k_max_num_obs(ix)      ;; A == k_max_num_obs
      jr nz, proceder_al_bucle;; IF A != k_max_num_obs iterar bucle

    ;; Reiniciar Los Valores de Las Constantes y Contadores
    ld  a, #0                 ;; A = 0
    ld enm_m_num_obs(ix), a         ;; Número de obs creados

    ld  h, enm_shot_array+1(ix) 
    ld  l, enm_shot_array(ix)       ;; DE = pointer to shot_array
    ld  enm_m_next_obs+1(ix), h   ;; IX = Shot_array0
    ld  enm_m_next_obs(ix), l   ;; IX = Shot_array0

    ld enm_m_alive_obs(ix),  a      ;; Numero de Obs Usados
    ld enm_m_murieron_obs(ix), a    ;; Numero de Obs que colisionan
    
    ld a, #1                  ;; A = 1
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REGISTRA UNA NUEVA ENTIDAD. SI HA LLEGADO
;; AL TOPE DE OBS, NO REGISTRA OTRO
;; REGISTROS DESTRUIDOS: A, HL, BC
;; SALIDA: A => 0/1 si puede registrar el Obs
;; ENTRADAS: 
;;          IX => Puntero a la entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_new:
  ;; Ha llegado al maximo de obejtos ???
  ld h, enm_m_next_obs+1(ix)
  ld l, enm_m_next_obs(ix)
;push hl 
;pop iy


  ld  a,  enm_m_num_obs(ix)     ;; A = enm_m_num_obs(ix) Value
  cp  enm_k_max_num_obs(ix);#k_max_num_obs      ;; A - k_max_num_obs Value
  jr  nz,  nuevo_obs      ;; IF A != k_max_num_obs THEN RET

    ;; ELSE A == k_max_num_obs
    call obs_reset_array
    ret

  nuevo_obs:
  ;; Poner
  ;push af
  ;ld a, de_x(ix)
  ;ld de_x(iy), a
;
  ;ld a, de_y(ix)
  ;ld de_y(iy), a
;
  ;pop af

  ;; Incrementar los obs usados
  ld	b, a                ;; B = A
  ld  a,  enm_m_alive_obs(ix)    ;; A = enm_m_alive_obs(ix) Value
  inc a                   ;; A++
  ld  enm_m_alive_obs(ix), a    ;; enm_m_alive_obs(ix) value = A
  ld  a, b                ;; A = B

  ;; Incrementar el numero de obs
  inc     a
  ld      enm_m_num_obs(ix), a



  ;; Hacer mas cosas :D
  ;ld      hl,     (m_next_obs)
  ld  h, enm_m_next_obs+1(ix)   ;; IX = Shot_array0
  ld  l, enm_m_next_obs(ix)   ;; IX = Shot_array0
  ld c, enm_k_obs_size(ix)
  ld b, #0
  add     hl,     bc
  ;ld      (m_next_obs), hl
  ld  enm_m_next_obs+1(ix), h   ;; IX = Shot_array0
  ld  enm_m_next_obs(ix), l   ;; IX = Shot_array0
  ld c, enm_k_obs_size(ix)
  ld b, #-1
  add     hl,     bc
  
  ld a, #1
    
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EJECUTA EL METODO PASADO EN HL SOLO PARA LOS OBS VIVOS
;; EXPLOTA: AF, BC, DE, HL
;; ENTRADA:
;;          HL -> PUNTERO AL MÉTODO A EJECUTAR
;;          IX => Puntero a la entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_doForAll:
  ld  a,  enm_m_num_obs(ix) ;; A = m_num_obs
  cp  #0              ;; A - 0
  ret z               ;; IF A == 0 THEN ret
  

  ;; ELSE Apply Function
  push hl
  ld  h, enm_shot_array+1(ix)   ;; IX = Shot_array0
  ld  l, enm_shot_array(ix)   ;; IX = Shot_array0
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

    
      ;; ELSE Apply Function
      metodo  = . + 1             ;; | . + 1 es el call
      call    ent_draw            ;; \ CALL metodo

    inc_contadores:
    pop	af                      ;; | POP AF
    ld c, enm_k_obs_size(ix)
    ld b, #0
    add iy, bc                  ;; | IX += BC, Update pointer value
    dec a                       ;; | A--
    jr  nz, buc                 ;; \ IF A == 0 THEN stop Apply Function

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR UNa obstaculo
;; REGISTROS DESTRUIDOS: TODOS
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;          IX => Puntero a la entidad
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
    ld  a, enm_m_murieron_obs(ix)   ;; A = enm_m_murieron_obs(ix) value
    inc a                     ;; A++
    ld  enm_m_murieron_obs(ix), a   ;; enm_m_murieron_obs(ix)value = A
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
;;        HL -> ENTIDAD ORIGEN, plantilla
;;        DE -> EMTODAD DESTINO
;;        IX => Puntero a la entidad, posiciom del array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_copy:
    ld c, enm_k_obs_size(ix)
    ld b, #0
    ld d, enm_m_next_obs+1(ix)
    ld e, enm_m_next_obs(ix)
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