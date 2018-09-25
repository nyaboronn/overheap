.area _DATA
.area _CODE


;;======================================================
;;======================================================
;; PRIVATE DATA
;;======================================================
;;======================================================

;;
;; Obstacle data
;;
obstacle_x:     .db #80-1
obstacle_y:     .db #82
obstacle_w:     .db #1
obstacle_h:     .db #4

;; CPCtelera Symbols
.globl cpct_getScreenPtr_asm
.globl cpct_drawSolidBox_asm
.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm
.include "cpctelera.h.s"

;;======================================================
;;======================================================
;; PUBLIC FUNCTIONS
;;======================================================
;;======================================================

;;=========================================
;; Update Obstacle Status
;; DESTROYS: AF, BC, HL
;;=========================================
obstacle_update::

    ;; Move Obstacle to the left 
    ld a, (obstacle_x)                      ;; A = obstacleX value
    
    ; dec a. Activa los flags 
    ; no es necesario hacer un cp
    dec a                                   ;; obstacle_x --
    jr nz, not_restart_x                    ;; if obstacleX == 0 restart x
    
        ;; Restart obstacleX when it is 0
        ld a, #80-1                         ;; A = start location

    not_restart_x:
    ld (obstacle_x), a                      ;; Update obstacleX value

    ret

;;=========================================
;; Checks Collision between obstacle and other obstacle
;; Input:
;;      => HL: Points to the other entity
;; Return XXXXXXXXXXX
;; DESTROYS: HL
;;=========================================
obstacle_checkCollision::
    ;;
    ;; If (obs_x + obs_w <= hero_x) => r_no_collision
    ;; CENCIA
    ;; obs_x + obs_w - hero_x <= 0
    ;; Comprobar si está a la izquierda 
    ld a, (obstacle_x)              ;; A = obstacle_x
    ld c, a                         ;; C = obstacle_x
    ld a, (obstacle_w)              ;; A = obstacle_y
    add c                           ;; A += C 
    sub (hl)                        ;; A -= hero_x
    jr z, no_collision              ;; if (<= 0)
    jp m, no_collision              ;; then  no_colision

    ;;
    ;; if (herox + herow <= obsx) => l_no_collision
    ;; herox + herow - obsx
    ;;
    ld a, (hl)                      ;; A = hero_x
    inc hl                          ;; hl++ (heroy)
    inc hl                          ;; hl++ (herow)
    add (hl)                        ;; A +=  hero_w
    ld c, a                         ;; C = A
    ld a, (obstacle_x)              ;; A = obstacle_x
    ld b, a                         ;; :O
    ld a, c                         ;; :D
    sub a, b                        ;; A = herox + herow - obsx
    jr z, no_collision              ;; If (<=0) no collision
    jp m, no_collision              ;;  theb no_collision    

    ;; Collision
    ld a, #0xFF
    ret

    no_collision:
        ld a, #00
    ret

;;=========================================
;; Draws the Obstacle
;; DESTROYS:
;;=========================================
obstacle_draw::
    
    ld a, #0x0F                 ;; Patter color
    call drawObstacle           ;; Draw the obstacle

    ret
    
;;=========================================
;; Erases the Obstacle
;; DESTROYS:
;;=========================================
obstacle_erase::
    
    ld a, #0x00                 ;; Pattern color
    call drawObstacle           ;; Erase the obstacle

    ret


;;======================================================
;;======================================================
;; PRIVATE FUNCTIONS
;;======================================================
;;======================================================

;;===========================================================
;; Draw the Object
;; INPUTS:
;;      A => Colour Pattern
;; DESTROYS: AF, BC, DE, HL
;;===========================================================
drawObstacle:
    push af                             ;; Save A in the stack

    ;; Calculate Screen Position
    ld de, #0xC000                      ;; Video memory start position
    ld a, (obstacle_x)                  ;; |
    ld c, a                             ;; \X Coordinate
    ld a, (obstacle_y)                  ;; |
    ld b, a                             ;; \Y Coordinate
    call  cpct_getScreenPtr_asm

    ;; Draw A Box
    ex de, hl                           ;; Location
    pop af                              ;; A = User selected color
    ld bc, #0x0401                      ;; 4x4 pixels WithdxHeight
    call cpct_drawSolidBox_asm          ;; Draw a solid box

    ret

;;===========================================================
;; Check User Input
;; DESTROYS: AF, BC, DE, HL
;;===========================================================
checkUserInput:
    ;; Scan the whole keyboard
    call cpct_scanKeyboard_asm

    ;; Check fpr Key 'L' being pressed
    ld hl, #Key_L                   ;; HL = Key_I keycode
    call cpct_isKeyPressed_asm      ;; Check if Key_I is pressed
    cp #0                           ;; Check A == 0
    jr z, L_not_pressed             ;; Jump if A == 0

        ;; key_D is pressed
        ;;call moveHeroRight          ;; move hero right 

    L_not_pressed:

    ret