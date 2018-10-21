.include "hero.h.s"
.include "enemy.h.s"
.include "entity.h.s"
.include "obstacle.h.s"


.include "cpctelera.h.s"
.include "tileManager.h.s"
.include "main.h.s"
.include "utils.h.s"

.globl _sprite_Xemnas




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hero Jump Table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_jumptable:
    .db #-5, #-3, #-3, #-3
    .db #-3, #01, #01, #01
    .db #0, #0, #0, #0
    .db #0x80                   ;; #0x80 marca el último byte

;;hero_jumptable:
;;    .db #-6, #-4, #-4, #-3
;;    .db #-1, #02, #01, #02
;;    .db #01, #01, #01, #01
;;    .db #0x80                   ;; #0x80 marca el último byte

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hero Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DefineHero hero_data, 10, 30, 10, 30, 0x00, 0x00, 0x04, 0x04, _sprite_Xemnas, hero_moveKeyboard, 0x0000, -1, 10,1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Comprueba si es encesario un cambio de direccion y hace flip al sprite
;; Entradas: IX -> Puntero a hero 
;;    
;; Destroy:  AF, BC, DE, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_directAndFlip:
ld b, e_vx(ix)
ld a, #0
cp b
jr z, mismaDir ; Si la velocidad es cero ignoracmos el cambio 

ld a, hero_direct(ix)
cp b ;; si ambas son iguales, me mantengo en la misma direccion
jr z, mismaDir
ld  hero_direct(ix),b


ld h, de_sprite+1(ix)
ld l, de_sprite(ix)
;ld hl, #_G_sprite_EMR ;;(2B HL) sprite	Source Sprite Pointer (array with pixel and mask data)
                      ;;(2B DE) memory	Destination video memory pointer
ld  c, de_w(ix)   ;; Ancho ; ld c, #4              ;;(1B C ) width	Sprite Width in bytes (>0) (Beware, not in pixels!)
ld  a, de_w(ix)
add a,c 
ld c, a


ld  b, de_h(ix)   ;; alto ;; ld b, #16             ;;(1B B ) height	Sprite Height in bytes (>0)
ld  a, de_h(ix)
add a,b
add a,a 
ld b, a

call cpct_hflipSpriteMaskedM0_asm

mismaDir:

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Resta vidas al hero cuando detecta una colisión
;; ENTRADAS:
;;          IX -> Puntero a hero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_hit::

      ld	  ix, #hero_data
      ld	  iy, #enm_data

        ;;IX and IY pointers to entitys
    call obstacle_checkCollision
    ;;Una marca al
    ld	(0xC027), a ;;Draw coliision level
    ld	(0xC028), a ;;Draw coliision level
    ld	(0xC029), a ;;Draw coliision level

    ld	(0x8027), a ;;Draw coliision level
    ld	(0x8028), a ;;Draw coliision level
    ld	(0x8029), a ;;Draw coliision level

    cp #1
    jr nz, colisionNODetected

            ;; Si existe colision precedemos a restar la vida...
        ld a, hero_vida(ix)
        dec a
        ld hero_vida(ix), a
        cp #0
        jr nz,colisionNODetected ;; si la vida no es cero salimos del metodo
        
        ;TODO
        ;ld a,de_col(ix)
        ;add a
        ;ld de_col(ix),a
        
        
        jr . ;; Bucle infinto

    colisionNODetected:


    ;; Comprobar colisión con un enemigo -- Colision entre dos entidades 

    ;; Decrementar vida

    ;; Comprobar si es cero

        ;; Pantalla end game
        ;; Volver al menu principal

    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: TODOS
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_update:
    ;; Llamada a la función que controla el salto
    call    hero_jumpControl     
    ;; Llamada a la función que actualiza una entidad
    call ent_update
;    call hero_hit

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BORRA UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF',AF, BC, DE, HL
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_clear:
    ;; Llamda a la función que borra una entidad
    call ent_clear
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIBUJAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF, BC, DE, HL
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_draw:
    ;; LLamada a al función que dibuja una entidad
    call ent_draw
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVER UNA ENTIDAD CON TECLADO
;; REGISTROS DESTRUIDOS:
;; ENTRADA: IX -> Puntero a entidad
;;           IY -> Puntero a TileMAp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_moveKeyboard::


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


  call hero_wait4KeyboardInput

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



  call hero_directAndFlip
  call  hero_move
 

  ld e_vx(ix), #0
  ld  e_vy(ix), #0
 
  ret
 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve el estado segun una entidad
;; REGISTROS DESTRUIDOS: HL, 
;; ENTRADA: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_wait4KeyboardInput:

    ;;Escaneamos la matriz del tecaldo
    call  cpct_scanKeyboard_asm

    ;; COMPROBAR SI SE HA PULSADO 'W'
    ld      hl,     #Key_W
    call    cpct_isKeyPressed_asm
    jr      z,      w_no_pulsada           ;; IF KEY_W IS pressed: lest JUMP
    call    hero_startJump                  ;; Call Jump Function
    ld      h,      #0

    w_no_pulsada:

    ;;Comprobamos si la tecla A, ha sido pulsada 
    ld  hl,     #Key_A
    call  cpct_isKeyPressed_asm
    jr    z,    a_no_pulsada       ;;A is pressed

        ld  e_vx(ix), #-1
        ld  h,  #-1
        ld  l,  #0
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
;; HACER EL SALTO. Si el estado es -2 no puede saltar
;; REGISTROS DESTRUIDOS: AF
;; ENTRADAS:
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_startJump:
    ld  a,  e_jump(ix)  ;; A = hero_jumpstate
    cp  #-2             ;; A == -2?
    ret z               ;; A == 0. Cant activate. Entity is falling
    cp  #-1             ;; A == -1? 
    ret nz              ;; A != 0. Jump is no activate, lest do

    ;; Jump is inactive, active it
    ld  a,  #0
    ld  e_jump(ix), a

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CONTROLA EL SALTO DE LA ENTIDAD
;; REGISTROS DESTRUIDOS: AF, BC, HL
;; ENTRADAS:
;;          IX => Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_jumpControl:

    ;; Check if we are jumping right now
    ld  a,  e_jump(ix)      ;; A = hero_jumpstate status
    cp  #-2                 ;; A == -2?
    ret z                   ;; A == 0. Cant activate. Entity is falling
    cp  #-1                 ;; A == -1? (-1 is not jumping)
    ret z                   ;; If  A == -1, not jumping

    ;; Move Hero
    ld  hl, #hero_jumptable ;; HL = Primer Valor de JumpTable
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
;;
    ;;

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVER UNA ENTIDAD
;; REGISTROS DESTRUIDOS: af, hl,de
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_move::
    ;;Sumamos velocidad X a posicion X
    ld      a, de_x(ix)
    ld       de_oldx(ix), a

    add     e_vx(ix)
    ld      de_x(ix), a

    ;;Recogemos la coordenados y la cuerdamos en la pila,(variable local)
    ld      h, e_tile_h(ix)
    ld      l, e_tile_l(ix)
    push hl

    call CalcualteOFFSET

    ;;Sumamos velocidad al tile,para cambiar
    ld      e_tile_h(ix) , h
    ld      e_tile_l(ix), l

    ;;check if entity is in a solid tile
    ;;Cambiar logica del if, porque no estabamos usando el bit mas significativo para representar la colision
    call    ent_is_solidTile ;; Devuelve en B true o false
    jr z, checkY

    ;; Check if entity has a collision with an obstacle
    ;ld    iy, #obstacle1
    ; Call to function
    ;call	obstacle_checkCollision
    ;If collide dont move (A == 0) exit function
    ;Else revet changes in e_x and e_y
    ;cp #0
    ;jr z, exit

    pop hl ;;para restaurar el puntero a la tile actual
    push hl

    ld      a, de_x(ix)
    sub     e_vx(ix)
    ld      de_x(ix), a

    ;;restauramos puntero
    ld      e_tile_h(ix) , h
    ld      e_tile_l(ix), l

    checkY:
        pop hl
        ;;; Sumamos velocidad Y a posicion Y, ademas añadimos una unidad a Y para simular una caida constante
        ld      a, de_y(ix)
        ld       de_oldy(ix), a
        add     e_vy(ix)
        inc a
        ld      de_y(ix), a
        ;; Recogemos la coordenados y la cuerdamos en la pila,(variable local)
        ld h, e_tile_h(ix)
        ld l, e_tile_l(ix)

        push hl




        call CalcualteOFFSET

        ;; Sumamos velocidad al tile,para cambiar
        ld  e_tile_h(ix) , h
        ld  e_tile_l(ix), l

        ;; check if entity is in a solid tile
        ;; Cambiar logica del if, porque no estabamos usando el bit mas significativo para representar la colision
        call    ent_is_solidTile ;; Devuelve en B true o false
        jr z,   exit








        ;; Check if entity has a collision with an obstacle
        ;ld    iy, #obstacle1
        ; Call to function
        ;call	obstacle_checkCollision
        ;If collide dont move (A == 0) exit function
        ;Else revet changes in e_x and e_y
        ;cp #0
        ;jr z, exit

    resetY:
        pop     hl ;; para restaurar el puntero a la tile actual
        push    hl

        ld       a, de_y(ix)
        sub     e_vy(ix)
        dec a
        ld      de_y(ix), a

        ;;restauramos puntero
        ld      e_tile_h(ix) , h
        ld      e_tile_l(ix), l

    exit:
        ;;pop ix
        pop hl
        ret