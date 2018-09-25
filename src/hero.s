.area _DATA
.area _CODE

;;================================================
;;================================================
;; PRIVATE DATA
;;================================================
;;================================================

;;
;; Hero Data
;;
hero_x:     .db #39
hero_y:     .db #80
hero_w:     .db #2
hero_h:     .db #8
hero_jump:  .db #-1             ;; (-1 is not jumping)

;;
;; Jump Table
;;
jumptable:
    .db #-12, #-8, #-4, #-4
    .db #-4, #00, #00, #04
    .db #04, #04, #08, #012
    .db #0x80                   ;; El último byte se marca con el #0x80
                                ;; De esta forma no hace falta un contador

;; CPCtelera Symbols
.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm
.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm
.include "cpctelera.h.s"

;;================================================
;;================================================
;; PUBLIC FUNCTIONS
;;================================================
;;================================================

;;===========================================================
;; Updates the Hero
;; DESTROYS:
;;===========================================================
hero_update::
    call jumpControl                ;; Do jump
    call checkUserInput             ;; Check if User presses Keys

    ret

;;===========================================================
;; Gets a pointer to hero data in HL
;; DESTROYS: HL
;; RETURNS:
;;    HL: Pointer to Hero Data
;;===========================================================
hero_getPtrHL::
    ld hl, #hero_x                  ;; HL pointer to the hero data
    ret

;;===========================================================
;; Draws the Hero
;; DESTROYS:
;;===========================================================
hero_draw::
    ld a, #0xFF                     ;; Red Hero
    call drawHero                   ;; Draw Our Hero

    ret
;;===========================================================
;; Erases the Hero
;; DESTROYS:
;;===========================================================
hero_erase::
    ld a, #0x00                     ;; Red Hero
    call drawHero                   ;; Draw Our Hero

    ret

;;================================================
;;================================================
;; PRIVATE FUNCTIONS
;;================================================
;;================================================

;;===========================================================
;; Controls Jump Movements
;; DESTROYS: A
;;===========================================================
jumpControl:
    ;; Check if we are jumping right now
    ld a, (hero_jump)           ;; A = hero_jump status
    cp #-1                      ;; A == -1? (-1 is not jumping)
    ret z                       ;; If  A == -1, not jumping

    ;; Move Hero (forma de recorrer arrays)
    ld hl, #jumptable           ;; Direccion base del array JumpTable
    ld c, a                     ;; | Sumarle la posición del índice para acceder
    ld b, #0                    ;; | BC =  A (offset)
    add hl, bc                  ;; \ HL += BC

    ;; Check End of jumping
    ld a, (hl)                  ;; A = jump movement
    cp #0x80                    ;; Jump value == 0
    jr z, end_of_jump           ;; if 0x80, end of jump

    ;; Do jump movement (ya tenemos la posicion, falta aplicar el valor de esa dirc)
    ld b, a                  ;; B = Jump Movement
    ld a, (hero_y)              ;; A = hero_y
    add b                       ;; A += b (add jump movement)
    ld (hero_y), a             ;; Update hero_y value

    ;; Increment Hero_jump Index
    ld a, (hero_jump)           ;; A = hero_jump
    inc a                       ;; | 
    ld (hero_jump), a           ;; \ hero_jump++

    ret
    ;; Put -1 in the jump index when jump ends
    end_of_jump:
    ld a, #-1                   ;; |
    ld (hero_jump), a           ;; \ hero_jump = -1

    ret

;;===========================================================
;; move hero right
;; DESTROYS: AF
;;===========================================================
moveHeroRight:
    ld a, (hero_x)              ;; A = hero_x
    cp #80-2                    ;; Check against screen right limit
    jr z, do_not_move_r         ;; hero_x == limit. do not jump

        ;; Move right
        inc a                   ;; A++
        ld (hero_x), a          ; hero_x = A

    do_not_move_r:
    ret

;;===========================================================
;; move hero left
;; DESTROYS: AF
;;===========================================================
moveHeroLeft:
    ld a, (hero_x)                ;; A = hero_x
    cp #0                         ;; Check against screen right limit
    jr z, do_not_move_l           ;; hero_x == limit. do not move left

        ;; Move right
        dec a                     ;; A--
        ld (hero_x), a            ;; update hero_x = A

    do_not_move_l:
    ret

;;===========================================================
;; move hero jump
;; DESTROYS: AF
;;===========================================================
startJump:
    ld a, (hero_jump)             ;; A = hero_jump
    cp #-1                        ;; A == -1? 
    ret nz                        ;; A != 0. Jump is no activate, lest do

    ;; Jump is inactive, active it
    ld a, #0
    ld (hero_jump), a
    
    ret

;;===========================================================
;; Check User Input
;; DESTROYS: AF, BC, DE, HL
;;===========================================================
checkUserInput:
    ;; Scan the whole keyboard
    call cpct_scanKeyboard_asm

    ;; Check fpr Key 'D' being pressed
    ld hl, #Key_D                   ;; HL = Key_D keycode
    call cpct_isKeyPressed_asm      ;; Check if Key_D is pressed
    cp #0                           ;; Check A == 0
    jr z, d_not_pressed             ;; Jump if A == 0

        ;; key_D is pressed
        call moveHeroRight          ;; move hero right 

    d_not_pressed:

    ;; Check fpr Key 'A' being pressed
    ld hl, #Key_A                   ;; HL = Key_A keycode
    call cpct_isKeyPressed_asm      ;; Check if Key_A is pressed
    cp #0                           ;; Check A == 0
    jr z, a_not_pressed             ;; Jump if A == 0

        ;; Key_A is pressed
        call moveHeroLeft           ;; move hero right 

    a_not_pressed:

    ;; Check fpr Key 'A' being pressed
    ld hl, #Key_W                   ;; HL = Key_A keycode
    call cpct_isKeyPressed_asm      ;; Check if Key_A is pressed
    cp #0                           ;; Check A == 0
    jr z, w_not_pressed             ;; Jump if A == 0

        ;; Key_A is pressed
        call startJump              ;; move hero right 

    w_not_pressed:

ret
;;===========================================================
;; Draw the Hero
;; INPUTS:
;;      A => Colour Pattern
;; DESTROYS: AF, BC, DE, HL
;;===========================================================
drawHero:
    push af                         ;; Save A in the stack

    ;; Calculate Screen Position
    ld de, #0xC000                  ;; Video memory start position
    ld a, (hero_x)                  ;; |
    ld c, a                         ;; \X Coordinate
    ld a, (hero_y)                  ;; |
    ld b, a                         ;; \Y Coordinate
    call  cpct_getScreenPtr_asm

    ;; Draw A Box
    ex de, hl                       ;; Location
    pop af                          ;; A = User selected color
    ld bc, #0x0802                  ;; 8x8 pixels WithdxHeight
    call cpct_drawSolidBox_asm      ;; Draw a solid box

    ret