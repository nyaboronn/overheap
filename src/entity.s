;###########################################################################
;#### FICHERO: entity.s
;###########################################################################
.include "cpctelera.h.s"
.include "entity.h.s"
.include "main.h.s"
 

DefineNEntities entity_vector, 9
DefineEntity hero_data, 0x14, 0x21, 0x00, 0x00, 0x02, 0x08, 0x0F, ent_moveKeyboard
DefineEntity enemy_data, 0x20, 0x01, 0xFF, 0x00, 0x02, 0x08, 0xFF, ent_move

;;
;; Jump Table
;;
hero_jumptable:
    .db #-12, #-8, #-4, #-4
    .db #-4, #00, #00, #04
    .db #04, #04, #08, #012
    .db #0x80                   ;; El último byte se marca con el #0x80
;;
;; Hero Jump Status (IF Not Jumping, hero_jumpstate = -1)
;;
hero_jumpstate:  .db #-1             ;; (-1 is not jumping)



 ;;
 ;;Cosas para poder crear entidades
 ;;

 k_max_num_ent = 9
 k_entity_size = 9
 m_num_ent: .db 00
 m_next_entity: .dw entity_vector0

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
  ld    de, #0xC000       ;;Comienzo memoria de video
  ld     c, e_x(ix)         ;; C = Entity Y
  ld     b, e_y(ix)         ;; B = Entity X
  call cpct_getScreenPtr_asm
 
  ex    de, hl   ;; DE = Puntero a memoria
  ld  a, e_col(ix)   ;; Color
  ld  b, e_h(ix)   ;; alto
  ld  c, e_w(ix)   ;; Ancho
 
  call cpct_drawSolidBox_asm
 
  ret

 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BORRA UNA ENTIDAD
;; REGISTROS DESTRUIDOS: AF',AF, BC, DE, HL
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_clear:
  ld  a, e_col(ix)
  ex af, af'
 
   ld  e_col(ix), #0
 
   call ent_draw
   ex af, af'
  ld e_col(ix), a
 
  ret
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ACTUALIZAR UNA ENTIDAD
;; REGISTROS DESTRUIDOS:
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_update:
  ;; Controla el estado del salto
  call jumpControl
  ld     h, e_up_h(ix)
  ld     l, e_up_l(ix)
  jp    (hl)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVER UNA ENTIDAD CON TECLADO
;; REGISTROS DESTRUIDOS:
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_moveKeyboard:
  call  cpct_scanKeyboard_asm
 
  ld    hl, #Key_A
  call  cpct_isKeyPressed_asm
  jr    z, a_no_pulsada
     ld e_vx(ix), #-1
a_no_pulsada:
 
  ld    hl, #Key_D
  call  cpct_isKeyPressed_asm
  jr    z, d_no_pulsada
     ld e_vx(ix), #1
d_no_pulsada:

;; COMPROBAR SI SE HA PULSADO 'W'
  ld    hl, #Key_W
  call  cpct_isKeyPressed_asm
  jr    z, w_no_pulsada         ;; IF KEY_W IS pressed: lest JUMP
  call startJump               ;; Call Jump Function
w_no_pulsada:
 
  call  ent_move
 
  ld e_vx(ix), #0
 
  ret
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MOVER UNA ENTIDAD
;; REGISTROS DESTRUIDOS:
;; ENTRADA: IX -> Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ent_move:
  ld    a, e_x(ix)
  add   e_vx(ix)
  ld    e_x(ix), a
 
  ld    a, e_y(ix)
  add   e_vy(ix)
  ld    e_y(ix), a
 
  ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HACER EL SALTO
;; REGISTROS DESTRUIDOS:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  startJump:
    ld a, (hero_jumpstate)             ;; A = hero_jumpstate
    cp #-1                        ;; A == -1? 
    ret nz                        ;; A != 0. Jump is no activate, lest do

    ;; Jump is inactive, active it
    ld a, #0
    ld (hero_jumpstate), a
    
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CONTROLA EL SALTO
;; REGISTROS DESTRUIDOS: AF, BC, HL
;; ENTRADAS:
;;          IX => Puntero a entidad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
jumpControl:

  ;; Check if we are jumping right now
  ld    a, (hero_jumpstate)           ;; A = hero_jumpstate status
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
  ld    a, e_y(ix)               ;; A = Coordenada X de la entidad
  add   b                       ;; B += A (Sumar al valor del salto la X)
  ld    e_y(ix), a               ;; e_x = Calculo de la nueva X 

  ;; Increment hero_jumpstate Index
  ld    a, (hero_jumpstate)           ;; A = hero_jumpstate
  inc   a                       ;; | 
  ld    (hero_jumpstate), a           ;; \ hero_jumpstate++
  ret

  ;; Put -1 in the jump index when jump ends
  end_of_jump:
  ld    a, #-1                   ;; |
  ld    (hero_jumpstate), a           ;; \ hero_jumpstate = -1

  ret


