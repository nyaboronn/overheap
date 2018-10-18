

.include "cpctelera.h.s"
.include "main.h.s"
.include "obstacle.h.s"
.include "entity.h.s"

;;;;;;;;;;;;;;;;;;;;;
;; Shoots Data
;;;;;;;;;;;;;;;;;;;;;
k_max_num_obs = 3               ;; Maximo de objetos
k_obs_size    = 11              ;; Obstacle size (in Bytes)
m_num_obs :   .db 0            ;; Número de obs creados
m_next_obs:   .dw shot_array0   ;; Posicion actual en el array

;_name,   _x, _y,_oldx, _oldy, _vx, _vy, _w, _h, _col, _upd, _tile
DefineNObstacles shot_array, #k_max_num_obs
DefineObstacle obstacle1, 5, 30, 5, 30, 1, 0, 1, 1, 0xF0F0, obs_move, 0x0000
DefineObstacle obstacle2, 5, 20, 5, 20, 1, 0, 1, 1, 0x0F0F, obs_move, 0x0000



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; EXPLOTA: TODOS
;; ENTRADA:
;;          HL -> PUNTERO AL MÉTODO A EJECUTAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_doForAll:
  ld    a,  (m_num_obs) ;; A = m_num_obs
  cp    #0              ;; A - 0
  ret   z               ;; IF A == 0 THEN ret
  
  ;; ELSE Apply Function
  ld  ix, #shot_array0  ;; IX = Shot_array0
  ld  (metodo), hl      ;; (meotodo) = HL
 buc:
      ;; IF vivo == 0 THEN jump inc_contadores

      ;; ELSE Apply Function
      push    af                  ;; | PUSH AF
      metodo  = . + 1             ;; | . es la dir.mem en la que estoy si le sumo 1 es el call
      call    ent_draw            ;; | CALL metodo
      pop     af                  ;; \ POP AF
      
      ld      bc, #k_obs_size     ;; | BC = #k_entity_size

      ;inc_contadores:
      add     ix, bc              ;; | IX += BC, Update pointer value
      dec a                       ;; | A--
      jr nz, buc                  ;; \ IF A == 0 THEN stop Apply Function

    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REGISTRA UNA NUEVA ENTIDAD
;; REGISTROS DESTRUIDOS: A, HL, BC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_new:
    ld      a,  (m_num_obs)
    inc     a
    ld      (m_num_obs), a

    ld      hl,     (m_next_obs)     ;; 0x10FF  +  9 = 0x1008
    ld      bc,     #k_obs_size
    add     hl,     bc
    ld      (m_next_obs), hl
    ld      bc,     #-k_obs_size     ;; O podemos usar sbc(restar con acarreo)       or  a       Quitamos el acarreo en el caso de que se genere a or a = a Acarreo 0
    add     hl,     bc                  ;;Se cambia por las 2   sbc hl, bc
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR UNa obstaculo
;; REGISTROS DESTRUIDOS: TODOS
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obs_update:
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
  sub	  de_x(ix)          ;;  Entiendo que herde_x tiene que estar cargado en iy   Resto lo que hay en el acumulador con lo que hay en iy, también modifica los flags
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

