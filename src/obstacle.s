;###########################################################################
;#### FICHERO:obstacle.s
;###########################################################################
.include "cpctelera.h.s"
.include "main.h.s"
.include "obstacle.h.s"




DefineObstacle obstacle1,10,10,0x02,0x02,0x20

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_draw_obs:
ld de, #0xC000       ;;Comienzo memoria de video

    ;; Convert de X tile in X in bytes
    ld C, e_x(ix)    ;; X
    ld A, e_x(ix)    ;; X
    add a,c
    ld c, a
;; Convert de y tile in y in bytes
    ld b, e_y(ix)    ;; y
    ld A, e_y(ix)    ;; y
    add a,b
    add a,a
    ld b, a

 ;; ld     b, e_y(ix)         ;; B = Entity Y
  call cpct_getScreenPtr_asm
 
  ex    de, hl   ;; DE = Puntero a memoria

  ld  b, e_h(ix)   ;; alto
  ld A, e_h(ix)    ;; y
  add a,b
  add a,a
  ld b, a

  ld  c, e_w(ix)   ;; Ancho
  ld A, e_w(ix)    ;; X
  add a,c
  ld c, a
   ld  a, e_col(ix)   ;; Color
  
  call cpct_drawSolidBox_asm
 
  ret


 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BORRA UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF',AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_clear_obs:
  ld  a, e_col(ix)
  ex af, af'
 
   ld  e_col(ix), #0
 
   call ent_draw_obs
   ex af, af'
  ld e_col(ix), a
 
  ret



  ;;=====================================================================
  ;;   CHECKS COLLISIONS BETWEEN OBSTACLE AND OBJ
  ;;    Input:
  ;;         IY: Points to the Hero
  ;;         IX: Points to the Obtacle
  ;;        Delete Registers: IX, IY, A, C, B
  ;;=====================================================================

  obstacle_checkCollision::
    ;;  X axis
    ;;
    ;;  if (obs_x + obx_w <= hero_x) no_collision , ponemos mejor o igual, porque si no se estarían rozando pero daría fallo como si hubiese colision
    ;;  En el caso de que esté en la izq
    ;;  obs_x + obx_w - hero_x <= 0
 

        ld  a,e_x(ix)       ;;  obs_x
        ld	c, a            ;;  obs_x -> c
        ld  a, e_w(ix)      ;;  obs_w
        add c               ;;  obs_x + obs_w
        sub	e_x(iy)            ;;Entiendo que hero_x tiene que estar cargado en iy   Resto lo que hay en el acumulador con lo que hay en iy, también modifica los flags
        jr z, no_collision      ;;Menor o igual if (<= 0)
        jp m, no_collision      ;;Es válido poner doble salto, ya que no modifican los flags entonces sigue siendo válido
        

        ;;Other possibility
       ;; Y axis
        ld  a,e_y(ix)       ;;  obs_y
        ld	c, a            ;;  obs_y -> c
        ld  a, e_h(ix)      ;;  obs_h
        add c               ;;  obs_y + obs_h
        sub	e_y(iy)            ;;Entiendo que hero_y tiene que estar cargado en iy   Resto lo que hay en el acumulador con lo que hay en iy, también modifica los flags
        jr z, no_collision      ;;Menor o igual if (<= 0)
        jp m, no_collision      ;;Es válido poner doble salto, ya que no modifican los flags entonces sigue siendo válido

        

        ;;  If is on the right
        ;;  if(hero_x + hero_w <= obs_x)
        ;;  if(hero_x + hero_w - obs_x <= 0 )
              ;;ld iy, #hero_data   ;;NUEVO Tengo que volver a cargarle el valor de hero_data porque si no en A se queda una posición desfasada
        ld  a,e_x(iy) ;;Meto el valor de iy en a ;Meto en A hero_x
        inc iy      ;;Tengo que incrementar en 4 iy para poder coger hero_w que es el tercer valor
        inc iy
        inc iy
        inc iy
        add (iy)    ;;Sumo a hero_x que lo tengo en A el valor de hero_w
        ld	c, a    ;;Paso el valor de la suma a C
        ld  a, e_x(ix)  ;;Paso a A el valor de obs_x
        ld  b, a    ;;Paso el valor de obs_x que tengo en a B
        ld  a, c    ;;Paso el valor de hero_x + hero_w de C a A para restar
        sub b       ;;Resto el valor de (hero_x + hero_w) - obs_x
        jr z, no_collision  ;; if(<=0)
        jp m, no_collision

        ld iy, #hero_data ;;Vuelvo a cargar hero_data , porque los inc de antes me han cambiado la dir que apuntaba iy

       ld  a,e_y(iy) ;;Meto el valor de iy en a ;Meto en A hero_x
       inc iy      ;;Tengo que incrementar en 4 iy para poder coger hero_w que es el tercer valor
       inc iy
       inc iy
       inc iy
       inc iy
       add (iy)    ;;Sumo a hero_x que lo tengo en A el valor de hero_w
       ld	c, a    ;;Paso el valor de la suma a C
       ld  a, e_y(ix)  ;;Paso a A el valor de obs_y
       ld  b, a    ;;Paso el valor de obs_x que tengo en a B
       ld  a, c    ;;Paso el valor de hero_x + hero_w de C a A para restar
       sub b       ;;Resto el valor de (hero_x + hero_w) - obs_x
       jr z, no_collision  ;; if(<=0)
       jp m, no_collision
;        ;;Collision
        ld	a, #0x20 ;;#1
        ret

        ;;No collision
        no_collision:
            ld	a, #0x1A
        ret	

        
  ret	