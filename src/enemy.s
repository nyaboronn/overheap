


.include "enemy.h.s"
.include "entity.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Movimiento Del Bicho Verde Estático
;; REGISTROS DESTRUIDOS: af, hl, de, b
;; ENTRADA: 
;;          IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Sentido por defecto = 0
;; 0 => Izquierda
;; 1 => Derecha
sentido: .db #1
;;
lim_der = #34   ;; Limite Derecho del movimiento
lim_izq = #4    ;; Limite Izquierda del movimiento

enm_move:
    ;; Posicion
    ld a, (sentido)     ;; | A = Sentido value
    ld b, a             ;; | B = A 
    ld a, e_x(ix)       ;; \ A = e_x(IX)
                    

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
    ld a, e_x(ix)                   ;; A = e_x(IX)
    jr z, mover_izq                 ;; IF A == 0 THEN move lef side

            ;; mover_der
            inc a                   ;; A++
            jp update_x             ;; Update the new A value

    mover_izq:
    dec a                           ;; A--
    
    update_x:
    ld e_x(ix), a                   ;; e_y = A
    ld hl, #sentido                 ;; HL = sentido dic memory
    ld (hl), b                      ;; (HL) = B
    call ent_move                   ;; Call func ent_move for applay new x value

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS: TODOS
;; ENTRADA: 
;;          IX -> Puntero a entidad
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