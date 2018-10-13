;###########################################################################
;#### FICHERO:obstacle.s
;###########################################################################
.include "cpctelera.h.s"
.include "main.h.s"
.include "obstacle.h.s"
.include "entity.h.s"



DefineObstacle obstacle1,0,0,0x06,0x08,0x20

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_draw_obs:
call ren_drawEntity
  ret


 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BORRA UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF',AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_clear_obs:
  ld  a, de_col(ix)
  ex af, af'
 
   ld  de_col(ix), #0
 
   call ent_draw_obs
   ex af, af'
  ld de_col(ix), a
 
  ret



  ;;=====================================================================
  ;;   CHECKS COLLISIONS BETWEEN OBSTACLE AND OBJ
  ;;    Input: Iy and IX swaped
  ;;         IY: Points to the Hero 
  ;;         IX: Points to the Obtacle
  ;;        Delete Registers: IX, IY, A, C, B
  ;;=====================================================================

  obstacle_checkCollision::
    ;;  X axis
    ;;
    ;;  if (obs_x + obx_w <= herde_x) no_collision , ponemos mejor o igual, porque si no se estarían rozando pero daría fallo como si hubiese colision
    ;;  En el caso de que esté en la izq
    ;;  obs_x + obx_w - herde_x <= 0
 

        ld  a,de_x(iy)       ;;  obs_x
        ld	c, a            ;;  obs_x -> c
        ld  a, de_w(iy)      ;;  obs_w
        add c               ;;  obs_x + obs_w
        sub	de_x(ix)            ;;Entiendo que herde_x tiene que estar cargado en iy   Resto lo que hay en el acumulador con lo que hay en iy, también modifica los flags
        jr z, no_collision      ;;Menor o igual if (<= 0)
        jp m, no_collision      ;;Es válido poner doble salto, ya que no modifican los flags entonces sigue siendo válido
        

        ;;Other possibility
       ;; Y axis
        ld  a,de_y(iy)       ;;  obs_y
        ld	c, a            ;;  obs_y -> c
        ld  a, de_h(iy)      ;;  obs_h
        add c               ;;  obs_y + obs_h
        sub	de_y(ix)            ;;Entiendo que herde_y tiene que estar cargado en iy   Resto lo que hay en el acumulador con lo que hay en iy, también modifica los flags
        jr z, no_collision      ;;Menor o igual if (<= 0)
        jp m, no_collision      ;;Es válido poner doble salto, ya que no modifican los flags entonces sigue siendo válido

        

        ;;  If is on the right
        ;;  if(herde_x + hero_w <= obs_x)
        ;;  if(herde_x + hero_w - obs_x <= 0 )
              ;;ld iy, #hero_data   ;;NUEVO Tengo que volver a cargarle el valor de hero_data porque si no en A se queda una posición desfasada
        ld  a,de_x(ix) ;;Meto el valor de iy en a ;Meto en A herde_x
        ld  c,de_w(ix)
        add c
        ;;inc iy      ;;Tengo que incrementar en 4 iy para poder coger hero_w que es el tercer valor
        ;;inc iy
        ;;inc iy
        ;;inc iy
        ;;add (iy)    ;;Sumo a herde_x que lo tengo en A el valor de hero_w
        ld	c, a    ;;Paso el valor de la suma a C
        ld  a, de_x(iy)  ;;Paso a A el valor de obs_x
        ld  b, a    ;;Paso el valor de obs_x que tengo en a B
        ld  a, c    ;;Paso el valor de herde_x + hero_w de C a A para restar
        sub b       ;;Resto el valor de (herde_x + hero_w) - obs_x
        jr z, no_collision  ;; if(<=0)
        jp m, no_collision

        ;ld iy, #hero_data ;;Vuelvo a cargar hero_data , porque los inc de antes me han cambiado la dir que apuntaba iy

       ld  a,de_y(ix) ;;Meto el valor de iy en a ;Meto en A herde_x
       ld  c,de_h(ix)
       add c
       ;;inc iy      ;;Tengo que incrementar en 4 iy para poder coger hero_w que es el tercer valor
       ;;inc iy
       ;;inc iy
       ;;inc iy
       ;;inc iy
       ;;add (iy)    ;;Sumo a herde_x que lo tengo en A el valor de hero_w
       ld	c, a    ;;Paso el valor de la suma a C
       ld  a, de_y(iy)  ;;Paso a A el valor de obs_y
       ld  b, a    ;;Paso el valor de obs_x que tengo en a B
       ld  a, c    ;;Paso el valor de herde_x + hero_w de C a A para restar
       sub b       ;;Resto el valor de (herde_x + hero_w) - obs_x
       jr z, no_collision  ;; if(<=0)
       jp m, no_collision
;        ;;Collision
        ld	a, #0x01 ;;#1
       

        ret

        ;;No collision
        no_collision:
            ld	a, #0x00
        ret	

        
  ret	