

.include "hero.h.s"
.include "enemy.h.s"
.include "entity.h.s"
.include "obstacle.h.s"


.include "cpctelera.h.s"
.include "main.h.s"
.include "tileManager.h.s"
.include "utils.h.s"
.globl end_game


;; SPRITE usado por el Hero
.globl _sprite_Xemnas

;; Hero Jump Table
hero_jumptable:
    .db #-6, #-4, #-3, #-2
    .db #-1, #-1, #5, #3
    .db #2, #2, #1, #1
    .db #0x80                   ;; #0x80 marca el último byte

;; Hero Jump Table (puede volar)
;hero_jumptable:
;    .db #-5, #-3, #-3, #-3
;    .db #-3, #01, #01, #01
;    .db #0, #0, #0, #0
;    .db #0x80                   ;; #0x80 marca el último byte

time:     .db 0
firerate = #8

;; Hero Data
DefineHeroShot hero_data, 5, 32, 5, 32, 0, 0, 0x04, 0x04, _sprite_Xemnas, hero_moveKeyboard, 0x1020, -1, 3, 1, 5, 0, .+4 , 5, 0, 32
;_name, _x, _y,_oldx, _oldy, _vx, _vy, _w, _h, _sprite, _upd, _tile, _jump, _vida,_direct, _k_max_num_obs, _m_num_obs, _m_next_obs, _m_alive_obs, _m_murieron_obs, _suf

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve al Hero a valores default
;; 
;; Registros destruidos: IX
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_default:
    ld	ix, #hero_data  ;;Cargamos el valor de hero en ix
    ld de_x(ix), #5    ;x
    ld de_y(ix), #30   ;y
    ld de_oldx(ix), #5    ;old x
    ld de_oldy(ix), #30   ;old y
    ld hero_jump(ix), #1 ;;jump
    ld hero_vida(ix), #3 ;;Vida
    ;;ld hero_direct(ix), #-1 ;;Direct

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devuelve al Hero a valores default menos al vida
;; 
;; Registros destruidos: IX
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_default_no_vida:
    ld	ix, #hero_data  ;;Cargamos el valor de hero en ix
    ld de_x(ix), #5    ;x
    ld de_y(ix), #30   ;y
    ld de_oldx(ix), #5    ;old x
    ld de_oldy(ix), #30   ;old y
    ld hero_jump(ix), #1 ;;jump
    ld hero_direct(ix), #-1 ;;Direct

ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Comprueba si nos hemos quedado sin vidas
;;;; Registros destruidos: A
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;no_lifes:
;;    ld a, hero_vida(ix)
;;    cp #0
;;    jr nz, alive
;;    call end_game
;;    ;;jr .
;;alive:
;;ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Comprueba direccion y hace flip al sprite
;; Entradas: IX -> Puntero a hero 
;;    
;; Destroy:  AF, BC, DE, HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_directAndFlip:
    ld  b, e_vx(ix)
    ld  a, #0
    cp  b
    jr z, mismaDir ; Si la velocidad es cero ignoracmos el cambio 

    ld  a, hero_direct(ix)
    cp  b ;; si ambas son iguales, me mantengo en la misma direccion
    jr z, mismaDir
    ld  hero_direct(ix),b


    ld  h, de_sprite+1(ix)
    ld  l, de_sprite(ix)
    ;;(2B HL) sprite	Source Sprite Pointer (array with pixel and mask data)
    ;;(2B DE) memory	Destination video memory pointer
    ld  c, de_w(ix)   ;; Ancho ; ld c, #4              ;;(1B C ) width	Sprite Width in bytes (>0) (Beware, not in pixels!)
    ld  a, de_w(ix)
    add a,c 
    ld  c, a


    ld  b, de_h(ix)   ;; alto ;; ld b, #16             ;;(1B B ) height	Sprite Height in bytes (>0)
    ld  a, de_h(ix)
    add a,b
    add a,a 
    ld  b, a

    call cpct_hflipSpriteMaskedM0_asm

    mismaDir:

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXPLOTA: AF, BC, DE, HL
;; ENTRADA:
;;          IX -> Puntero a entidad, enemy
;;          IY -> Puntero a hero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_check_hit:
    ;Salvamos ix e iy 
    push ix     ;; IX -> Puntero a hero
    push iy     ;; IY -> Puntero a entidad, enemy

    ;; HL -> PUNTERO AL MÉTODO A EJECUTAR
    ld   hl, #obs_checkCollision
    call obs_doForAllBool
    ;;rescatamos
    pop iy
    pop ix

    cp #1
    jr nz, #noGolpeado
    ;;Cambiar estado?

    ld  a, e_health(IY)
    dec a
    ld  e_health(IY),a
    cp  #0
    jr  nz, noDamage
    ;;Cambiar de estado?
    ;; Animacion de muerte
    ;;jr .
    call end_game

    noDamage:
    noGolpeado:

ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: TODOS
;; ENTRADA: 
;;          IX -> Puntero a entidad hero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_update:
    ;; Update Shoot Timer
    ld a, (time)
    inc a
    ld (time), a ;; TIMER += 1


    push ix

    ld hl, #hero_check_hit
    call enm_doForAll


    pop ix

    call hero_jumpControl

    push ix
    ;Acutalizas las balas del enemigo
    ld	hl, #obs_update
    call	obs_doForAll
    ;Actualizar el enemigo
    pop ix
    ld  h, e_up_h(ix)
    ld  l, e_up_l(ix)
    jp  (hl) ;; llamada al estado
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BORRA UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF',AF, BC, DE, HL
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_clear:
    ;; Borras las balas del enemigo IX
    ld	hl, #obs_clear
    call	obs_doForAll
    ;; Borras enemigos
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
    call ren_drawEntityAlpha

    ;; Llamada a la función para dibujar las balas
    ld	hl, #obs_draw
    call	obs_doForAll
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVER UNA ENTIDAD CON TECLADO
;; REGISTROS DESTRUIDOS:
;; ENTRADA: IX -> Puntero a entidad
;;           IY -> Puntero a TileMAp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_moveKeyboard:

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


        ld a, #1 ;; 0
        ld d, scroll(iy)
        cp d
        jr z, funcRet
        

        ld a, #0 ;; 0
        ld d, scroll(iy)
        cp d
        jr z, funcRet
        jr calltoFunc


    morethanZero:

    ;;If A < N, then C flag is set.|| CP REGister N
    ld a, scroll(iy)
    add a, #24
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
;; REGISTROS DESTRUIDOS: HL
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

    ;;Comprobamos si la tecla P ha sido pulsada
    ld    hl, #Key_P
    call  cpct_isKeyPressed_asm
    jr    z, p_no_pulsada      ;;P is pressed

        ;; Comprobar Timer del Disparo
        ld a, (time)
        cp a, #firerate
        jr c, esperar_al_timer

            ;; ELSE
            ld a, #0            ;; El Timer ha llegado al máximo
            ld (time), a        ;; Reset Timer
            call obs_new        ;; Shoot

        esperar_al_timer:
        ld h,#0

    p_no_pulsada:

    ld h,#0
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HACER EL SALTO. Si el estado es -2 no puede saltar
;; REGISTROS DESTRUIDOS: A
;; ENTRADAS:
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_startJump:
    ld  a,  hero_jump(ix)  ;; A = hero_jumpstate
    cp  #-2             ;; A == -2?
    ret z               ;; A == 0. Cant activate. Entity is falling
    cp  #-1             ;; A == -1? 
    ret nz              ;; A != 0. Jump is no activate, lest do

    ;; Jump is inactive, active it
    ld  a,  #0
    ld  hero_jump(ix), a

ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CONTROLA EL SALTO DE LA ENTIDAD
;; REGISTROS DESTRUIDOS: A, BC, HL
;; ENTRADAS:
;;          IX => Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_jumpControl:

    ;; Check if we are jumping right now
    ld  a,  hero_jump(ix)      ;; A = hero_jumpstate status
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

    ;; Increment hero_jumpstate Index
    ld  a,  hero_jump(ix)      ;; A = hero_jumpstate
    inc a                   ;; | 
    ld  hero_jump(ix), a       ;; \ hero_jumpstate++
    ret

    ;; Put -1 in the jump index when jump ends
    end_of_jump:
        ld  a, #-1           ;; |
        ld  hero_jump(ix), a    ;; \ hero_jumpstate = -1
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVER UNA ENTIDAD
;; REGISTROS DESTRUIDOS: A, HL
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_move:
    ;;Sumamos velocidad X a posicion X
    ld      a, de_x(ix)
    ld       de_oldx(ix), a

    add     e_vx(ix)
    ld      de_x(ix), a

    ;;Recogemos la coordenados y la guerdamos en la pila,(variable local)
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