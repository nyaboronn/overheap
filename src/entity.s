;###########################################################################
;#### FICHERO: entity.s
;###########################################################################
.include "cpctelera.h.s"
.include "entity.h.s"
.include "obstacle.h.s"
.include "tileManager.h.s"
.include "main.h.s"
.include "utils.h.s"


DefineNEntities entity_vector, 9
DefineEntity hero_data, 20, 20, 0x00, 0x00, 0x02, 0x04, 0x77, ent_moveKeyboard, -1,0x0000
DefineEntity enemy_data, 0x20, 0x01, 0xFF, 0x00, 0x02, 0x08, 0xFF, ent_move, -1,0x0000
 
 ;;
 ;;Cosas para poder crear entidades
 ;;
 k_max_num_ent = 9
 k_entity_size = 9
 m_num_ent: .db 00
 m_next_entity: .dw entity_vector0




;;
;; Jump Table
;;
hero_jumptable:
    .db #-6, #-4, #-3, #-3
    .db #-3, #01, #01, #01
    .db #0, #0, #0, #0
    .db #0x80                   ;; #0x80 marca el último byte




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve 0 si la tile donde esta la entidad en solida
;;  Distinto de cero en caso contrario
;;  
;; REGISTROS DESTRUIDOS: 
;;  Entrada: IX -> Entity
;; Return in A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_is_solidTile:
  call ent_getActualTile

  bit #7, a
  ld a,#0
  ret z
  ld a,#-2
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve ptr a tile donde estas inicial
;; REGISTROS DESTRUIDOS: DE, HL
;; Return in HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_initialTile:
ld hl, #_g_tilemap
ld de, #0x1338
add hl,de
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve ptr a tile donde estas inicial
;; REGISTROS DESTRUIDOS:  HL, A
;; ENTRADA: IX -> Puntero a entidad
;; Return in A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_getActualTile:

ld h, e_tile_h(ix)
ld l, e_tile_l(ix)
ld A, (hl)

ret
    


 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; REGISTRA UNA NUEVA ENTIDAD
 ;; REGISTROS DESTRUIDOS
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ent_new:
    ld  a, (m_num_ent)
    inc    a
    ld (m_num_ent), a
    
    ld hl, (m_next_entity)  ;; 0x10FF  +  9 = 0x1008
    ld  bc, #k_entity_size
    add  hl, bc
    ld (m_next_entity), hl
    ld  bc, #-k_entity_size         ;; O podemos usar sbc(restar con acarreo)       or  a       Quitamos el acarreo en el caso de que se genere a or a = a Acarreo 0
    add  hl, bc                     ;;Se cambia por las 2                           sbc hl, bc
    
    
    ;;add l
    ;;ld	l, a
    ;;ld	a, h
    ;;adc #0 suma con acarreo
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; COPIA LOS VALORES DE UNA ENTIDAD SOBRE OTRA
;;; REGISTROS DESTRUIDOS:
;;; ENTRADA: 
;;;        HL -> ENTIDAD ORIGEN
;;;        DE -> EMTODAD DESTINO
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_copy:
    ld bc, #k_entity_size
    ldir

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; ENTRADA HL -> PUNTERO AL MÉTODO A EJECUTAR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ent_doForAll:
    ld  a, (m_num_ent)
    ld  ix, #entity_vector0
    ld  (metodo), hl
 buc:
        push af
        metodo = . + 1      ;; . es la dir.mem en la que estoy si le sumo 1 es el call
        call ent_draw
        pop af
        ld bc, #k_entity_size
        add ix, bc
        

        dec a
        jr nz, buc

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_draw:
    call ren_drawEntity
  ret

 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BORRA UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF',AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_clear:
call ren_clearEntity
 
  ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: TODOS
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Cambios: jump_state = temporal_collision
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_update:
    call jumpControl      ;; Llamada a la función que controla el salto

    ;; Puntero a la función que actualiza la entidad
    ld     h, e_up_h(ix)
    ld     l, e_up_l(ix)
    jp    (hl)

    ret
    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve el estado segun una entidad
;; REGISTROS DESTRUIDOS: HL, 
;; ENTRADA: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
wait4KeyboardInput:

;;Escaneamos la matriz del tecaldo
  call  cpct_scanKeyboard_asm



;; COMPROBAR SI SE HA PULSADO 'W'
  ld    hl, #Key_W
  call  cpct_isKeyPressed_asm
  jr    z, w_no_pulsada         ;; IF KEY_W IS pressed: lest JUMP
    call startJump               ;; Call Jump Function
    ld h,#0

w_no_pulsada:

 ;;Comprobamos si la tecla A, ha sido pulsada 
  ld    hl, #Key_A
  call  cpct_isKeyPressed_asm
  jr    z, a_no_pulsada       ;;A is pressed
     ld e_vx(ix), #-1
      ld h, #-1
      ld l, #0
      ret
a_no_pulsada:
 

 ;;Comprobamos si la tecla D ha sido pulsada
  ld    hl, #Key_D
  call  cpct_isKeyPressed_asm
  jr    z, d_no_pulsada      ;;D is pressed
    ld e_vx(ix), #1
    ld h, #+1
    ld l, #SCR_TILE_WIDTH-1
    ret
d_no_pulsada:


ld h,#0
ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVER UNA ENTIDAD CON TECLADO
;; REGISTROS DESTRUIDOS:
;; ENTRADA: IX -> Puntero a entidad
;;           IY -> Puntero a TileMAp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_moveKeyboard::

 
    ld hl, (#m_back_tileMap)
    push hl
    pop iy
;;Si en la iteracion anterior hemos renderizado algunas columnas, debemos renderizarlas otra vez
;;en el otro buffer
  ld bc, #RepeatRender
  ld a, (bc)
  push af
      ;;INPUT -> scroll= h
      ;;         column = l

      ld hl,(InputHL)



    ld a,#0
    ld (bc), a
  pop af
  cp #0

  JP NZ, #calltoFuncOtherBuffer


  call wait4KeyboardInput

  ;;al comrpobar si hemos pulsado A o D
  ;;Si es A, comprobamos si estamos en la columna izquierda limite, 
    ;; Si hemo sllegado al borde, movemos al player y el mapa.

    ld a, #0
    cp h
    JP z, funcRet ;;


    ld a, #1
    cp h
    JP z, morethanZero;carry flag

    ;;If A >= N, then C flag is reset.
        ld a, scroll(iy)
        add a, #10
        ld d,de_x(ix)
        cp d
        jr c, funcRet


        ld a, #0 ;; 0
        ld d, scroll(iy)
        cp d
        jr z, funcRet
        jr calltoFunc

    morethanZero:

        ;;If A < N, then C flag is set.|| CP REGister N
        ld a, scroll(iy)
        add a, #30
        ld d,de_x(ix)
        cp d
        jr nc, funcRet

        ;; h == MAXSCROLL NEXT ITERATION
        ld a, #MAXSCROLL  ;; #MAXSCROLL
        ld d, scroll(iy)
        cp d
        jr z, funcRet

    calltoFunc:
    ld a,#1
    ld bc, #RepeatRender
    ld (bc), a

    ld (InputHL), hl


    calltoFuncOtherBuffer:



    call scrollScreenTilemap

    funcRet:


  call  ent_move
 

  ld e_vx(ix), #0
 
  ret
 




  ;; Calculate the offset of the first tile of the box inside the tilemap and add it
  ;; to the main tilemap pointer (ptilemap)
  ;;    Offset = y * map_width + x
  ;;    HL = ptilemap + Offset
  ;;
  
 CalcualteOFFSET: 
  ld  hl, #_g_tilemap         ;; [3] HL=ptilemap 
  ld    a, de_x(ix)      ;; [1]   | HL = ptilemap + x
  add__hl_a       ;; [5]   |  

  ld   de, #MAP_WIDTH;; #120  ;; [3] DE = map_width
  ld    a, de_y(ix)      ;; [1] A = y 
  cp    a         ;; [1] Reset Carry Flag (Required for multiplying)
  mult_de_a       ;; [11-83] HL += DE * A (HL = y * map_width + x) ;; A * C + 
  ;; HL now points to the next tile to draw from the tilemap!

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVER UNA ENTIDAD
;; REGISTROS DESTRUIDOS: af, hl,de
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_move:
  ;;Sumamos velocidad X a posicion X
  ld    a, de_x(ix)
  add   e_vx(ix)
  ld    de_x(ix), a


  ;;Recogemos la coordenados y la cuerdamos en la pila,(variable local)
  ld h, e_tile_h(ix)
  ld l, e_tile_l(ix)
  push hl


 call CalcualteOFFSET

   ;;Sumamos velocidad al tile,para cambiar
  ld  e_tile_h(ix) , h
  ld  e_tile_l(ix), l





  ;;check if entity is in a solid tile
  ;;Cambiar logica del if, porque no estabamos usando el bit mas significativo para representar la colision
  call ent_is_solidTile ;; Devuelve en B true o false
  jr z, checkY


  ;; Check if entity has a collision with an obstacle



  ;;ld    iy, #obstacle1

  ;; Call to function
  ;;call	obstacle_checkCollision

  ;;If collide dont move (A == 0) exit function
  ;;Else revet changes in de_x and de_y
  ;;cp #0
  ;;jr z, exit




  pop hl ;;para restaurar el puntero a la tile actual
  push hl

  ld    a, de_x(ix)
  sub   e_vx(ix)
  ld    de_x(ix), a


    ;;restauramos puntero
  ld  e_tile_h(ix) , h
  ld  e_tile_l(ix), l



checkY:

pop hl
  ;;Sumamos velocidad Y a posicion Y, ademas añadimos una unidad a Y para simular una caida constante
  ld    a, de_y(ix)
  add   e_vy(ix)
  inc a
  ld    de_y(ix), a


  ;;Recogemos la coordenados y la cuerdamos en la pila,(variable local)
  ld h, e_tile_h(ix)
  ld l, e_tile_l(ix)

  push hl


 call CalcualteOFFSET

   ;;Sumamos velocidad al tile,para cambiar
  ld  e_tile_h(ix) , h
  ld  e_tile_l(ix), l





  ;;check if entity is in a solid tile
  ;;Cambiar logica del if, porque no estabamos usando el bit mas significativo para representar la colision
  call ent_is_solidTile ;; Devuelve en B true o false
  jr z, exit


  ;; Check if entity has a collision with an obstacle



  ;;ld    iy, #obstacle1

  ;; Call to function
  ;;call	obstacle_checkCollision

  ;;If collide dont move (A == 0) exit function
  ;;Else revet changes in de_x and de_y
  ;;cp #0
  ;;jr z, exit



resetY:
  pop hl ;; para restaurar el puntero a la tile actual
  push hl

  ld    a, de_y(ix)
  sub   e_vy(ix)
  dec a
  ld    de_y(ix), a

    ;;restauramos puntero
  ld  e_tile_h(ix) , h
  ld  e_tile_l(ix), l

exit:

  ;;pop ix
  pop hl
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUXILIAR: como no tengo la colisión la uso con
;; un valor fijo. Devuelve el estado del salto.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS: AF   
;;  SALIDAS:
;;      A =>  IF -2 SI no colisiona (is falling cant jump)
;;            ELSE -1               (can jump)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
temporal_collision:
    ;; A = -2. Esta cayendo.
    ;; A = -1. Colisiona con algo, puede saltar
    ld a, #-2
    
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HACER EL SALTO
;; REGISTROS DESTRUIDOS: AF
;; ENTRADAS:
;;    IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Cambios: Si el estado es -2 no puede saltar
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  startJump:
    ld a, e_jump(ix)              ;; A = hero_jumpstate
    cp #-2                        ;; A == -2?
    ret z                         ;; A == 0. Cant activate. Entity is falling
    cp #-1                        ;; A == -1? 
    ret nz                        ;; A != 0. Jump is no activate, lest do

    ;; Jump is inactive, active it
    ld a, #0
    ld e_jump(ix), a
    
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CONTROLA EL SALTO DE LA ENTIDAD
;; REGISTROS DESTRUIDOS: AF, BC, HL
;; ENTRADAS:
;;          IX => Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CAMBIOS: cuando el -2 no hace nada
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
jumpControl:

  ;; Check if we are jumping right now
  ld    a, e_jump(ix)           ;; A = hero_jumpstate status
    cp #-2                        ;; A == -2?
    ret z                         ;; A == 0. Cant activate. Entity is falling
  cp    #-1                      ;; A == -1? (-1 is not jumping)
  ret z                       ;; If  A == -1, not jumping

  ;; Move Hero
  ld    hl, #hero_jumptable           ;; HL = Primer Valor de JumpTable
  ld    c, a                     ;; | C = Índice a acceder
  ld    b, #0                    ;; | 
  add   hl, bc                  ;; \ HL += BC

  ;; Check End of jumping && Store in A jump value
  ld    a, (hl)                  ;; A = jump movement
  cp    #0x80                    ;; Jump value == 0
  jr    z, end_of_jump           ;; if 0x80, end of jump

  ;; Do jump movement (HL = Posición de memoria con el dato de jumpTable)
  ld    b, a                     ;; B = valor del salto
  ld    a, e_vy(ix)               ;; A = Coordenada X de la entidad
  add   b                       ;; B += A (Sumar al valor del salto la X)
  ld    e_vy(ix), a               ;; de_x = Calculo de la nueva X 

  call ent_move

  ld e_vy(ix), #0


  ;; Poner una velocidad
  ;; llamar a move
  ;;quitar velocidad

  ;; Increment hero_jumpstate Index
  ld    a, e_jump(ix)           ;; A = hero_jumpstate
  inc   a                       ;; | 
  ld    e_jump(ix), a           ;; \ hero_jumpstate++
  ret

  ;; Put -1 in the jump index when jump ends
  end_of_jump:
  ld    a, #-1                   ;; |
  ld    e_jump(ix), a           ;; \ hero_jumpstate = -1

  ret


