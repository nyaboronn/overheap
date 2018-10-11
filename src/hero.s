.include "hero.h.s"
.include "entity.h.s"

.include "cpctelera.h.s"
.include "tileManager.h.s"
.include "main.h.s"
.include "utils.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hero Jump Table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_jumptable:
    .db #-6, #-4, #-3, #-3
    .db #-3, #01, #01, #01
    .db #0, #0, #0, #0
    .db #0x80                   ;; #0x80 marca el último byte

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hero Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DefineHero hero_data, 20, 20, 0x00, 0x00, 0x02, 0x04, 0x77, hero_moveKeyboard, 0x0000, -1


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

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVER UNA ENTIDAD CON TECLADO
;; REGISTROS DESTRUIDOS:
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hero_moveKeyboard:
    call hero_wait4KeyboardInput

    ;;al comrpobar si hemos pulsado A o D
    ;;Si es A, comprobamos si estamos en la columna izquierda limite, 
    ;; Si hemo sllegado al borde, movemos al player y el mapa.
    ld  a, #0
    cp  h

    JP  z,  funcRet;carry flag
    ld  a, #1
    cp  h
    JP  z, morethanZero;carry flag

        ;;If A >= N, then C flag is reset.
        ld  a,  scroll(iy)
        add a,  #10
        ld  d,  e_x(ix)
        cp  d
        jr  c,  funcRet


        ld  a,  #0 ;; 0
        ld  d,  scroll(iy)
        cp  d
        jr  z,  funcRet
        jr  calltoFunc

    morethanZero:
        ;;If A < N, then C flag is set.|| CP REGister N
        ld  a,  scroll(iy)
        add a,  #30
        ld  d,  e_x(ix)
        cp  d
        jr  nc, funcRet

        ;; h == MAXSCROLL NEXT ITERATION
        ld  a,  #MAXSCROLL  ;; #MAXSCROLL
        ld  d,  scroll(iy)
        cp  d
        jr  z,  funcRet

    calltoFunc:
        call scrollScreenTilemap

    funcRet:
        ;;En caso contrario solo movemos el player
        ;; Realizamos lo mismo con la tecla D y el margen derecho
        
        ;;Ademas de la comprobacion se debe mirar si llegamos a los bordes

        call  ent_move
        ld e_vx(ix), #0
        
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

    call ent_move

    ld  e_vy(ix), #0

    ;; Poner una velocidad
    ;; llamar a move
    ;;quitar velocidad

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