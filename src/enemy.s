.include "enemy.h.s"
.include "entity.h.s"

;;;;;;;;;;;;;;;;;;;
;; Enemy Data
;;;;;;;;;;;;;;;;;;;;
DefineEnemy enm_data, 20, 41, 20, 41, 0x00, 0x00, 0x02, 0x04, 0xFF, enm_move1, 0x0000, 0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DIAGONAL
;; A la vez que avanza, sube y baja una distancia N
;; en forma de diagonal.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS:
;; ENTRADAS:
;;              IX => puntero al enemigo
;;                 => N es el ancho que baja/sube
;; SALIDAS: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_move2:

    ;bucle:

        ;; bajar diagonal (x++y++)

        ;; parar cuando y = N

        ;; subir diagonal (x++y--)

        ;; Parar cuando y = Y

    ;jump bucle


    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HORIZONTAL
;; Detecta al hero a una distancia N Por el lado que
;; marca el Byte de la direccion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS:
;; ENTRADAS:
;;              IX => puntero al enemigo
;;              IY => puntero al hero
;; SALIDAS: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_move1:
    ;;;; Cuando Hero y Enm estén en la misma 'Y' comprobar distancia ;;;;
    ;;; h_y == e_y ?? => CALCULAR si lo detecta
    ld  a, de_y(iy)  ;; A = hero_x
    ld  h, de_y(ix)  ;; H = enm_x
    cp  a, h        ;; A - H
    jr  z, misma_y  ;; IF h_y == e_y THEN detectar al hero

        ;; ELSE h_y != e_y. No detectarlo
        ret

    misma_y:

    ;;;; En que dirección hay que comprobar???
    ld a, e_direct(ix)          ;; A = enemy_direction
    cp a, #0                    
    jr z, busca_en_la_izquierda ;; IF enm_dict == 0 THEN detect left
        
        ;; ELSE buscar en la derecha
        jp busca_en_la_derecha


    busca_en_la_izquierda:
        call buscar_izquierda   ;; H = buscar_izquierda
        jp aplicar

    busca_en_la_derecha:
        call buscar_derecha     ;; H = busca_derecha


    aplicar:
        ld a, h                 ;; A = H
        cp #0
        jr z, no_aplica         ;; IF A == 0 THEN ret

            ;; TEMPORAL => FALTA DISPARAR AL DETECTAR EL HERO
            ;; ELSE Encontrado hero
            ld a, e_direct(ix)  ;; A = enemy_direction
            ld a, de_col(ix)     ;; TEMPORAL A = color enemigo
            inc a               ;; A++
            ld de_col(ix), a     ; enemy_color = A

        no_aplica:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Busca al hero por la izquierda
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS: HL, AF, BC
;; ENTRADAS:
;;              IX => puntero al enemigo
;;              IY => puntero al hero
;; SALIDAS: 
;;              H  => 0 no lo detecta, 
;;                    1 en caso contrario
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
buscar_izquierda:

    ;; Por defecto no lo detecta
    ld h, #0

    ;; A = (enm_x - hero_x)
    ld  a, de_x(ix)  ;; A =  enm_x
    sub a, de_x(iy)  ;; A -= hero_x

    ;; IF (e_x - h_x) <= 5 THEN detected
    cp  a, #15
    jr  nc,  no_detectado

        ;; Detectado
        inc h

    ;; ELSE no hay nada que hacer
    no_detectado:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Busca al hero por la derecha
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DESTRUIDOS: HL, AF, BC
;; ENTRADAS:
;;              IX => puntero al enemigo
;;              IY => puntero al hero
;; SALIDAS: 
;;              H  => 0 no lo detecta, 
;;                    1 en caso contrario
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
buscar_derecha:
    ;; Por defecto no lo detecta
    ld h, #0

    ;; A = (hero_x - enm_x)
    ld  a, de_x(iy)  ;; A =  hero_x
    sub a, de_x(ix)  ;; A -= enm_x

    ;; IF (h_x - e_x) <= 5 THEN detected
    cp  a, #15
    jr  nc,  no_detecta

        ;; Detectado
        inc h

    ;; ELSE no hay nada que hacer
    no_detecta:
    ret


;; Sentido por defecto = 0
;; 0 => Izquierda
;; 1 => Derecha
sentido: .db #1
;;
lim_der = #34   ;; Limite Derecho del movimiento
lim_izq = #4    ;; Limite Izquierda del movimiento

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HORIZONTAL
;; Ida y Vuelta Sin Parar de un punto A a otro B
;; DESTRUIDOS: todos
;; INPUT:
;;          IX => puntero a la entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_move:
    ;; Posicion
    ld a, (sentido)     ;; | A = Sentido value
    ld b, a             ;; | B = A 
    ld a, de_x(ix)       ;; \ A = e_x(IX)
                    

    ;; Actualizar El Valor del Sentido
    cp a, #lim_der                  ;; A == lim_der value ???
    jr z, cambiar_izq               ;; IF A==max left right limit. THEN  move left

        ;; Comprueba si está en el límite izquierdo
        cp a, #lim_izq              ;; A == lim_izq value ???
        jr z, cambiar_der           ;; IF A==lim_izq THEN move right
        jp aplicar_sentido          ;; Aplicar el nuevo sentido a la X del enemigo

    cambiar_izq:
    ld b, #0                        ;; B = #0
    jp aplicar_sentido              ;; Aplicar el nuevo sentido a la X del enemigo

    cambiar_der:
    ld b, #1                        ;; B = #1


    ;; Aplica El Sentido Obtenido
    aplicar_sentido:
    ld a, b                         ;; A = B
    cp a, #0                        ;; A == #0 ??
    ld a, de_x(ix)                   ;; A = e_x(IX)
    jr z, mover_izq                 ;; IF A == 0 THEN move lef side

            ;; mover_der
            inc a                   ;; A++
            jp update_x             ;; Update the new A value

    mover_izq:
    dec a                           ;; A--

    update_x:
    ld de_x(ix), a                   ;; e_y = A
    ld hl, #sentido                 ;; HL = sentido dic memory
    ld (hl), b                      ;; (HL) = B
    
    call ent_move                   ;; Call func ent_move for applay new x value

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: TODOS
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;          IY -> Puntero a hero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_update:
    ;; Puntero a la función que actualiza la entidad
    ld  h, e_up_h(ix)
    ld  l, e_up_l(ix)
    jp  (hl)

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_clear:
    call ent_clear

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enm_draw:
    call ent_draw

    ret