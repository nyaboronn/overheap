.globl AtoBCextendendsign


;; Macro for multiplying 16-bits by 8 bits, doing
;;   HL += DE * A
;; Important: Carry MUST be 0 at the start
;;   best:   11 us
;;   worst: 111 us
;;
.macro mult_de_a
   ;; Displaced digits multiply
 mul:
   rra               ;; [1]   Move next right bit to the Carry
   jr   nc, skip_add ;; [2/3] If No Carry, this bit does not multiply, so we dont add another DE
   add  hl, de       ;; [3]   If Carry, this bit does multiply, so we add DE to the total 

 skip_add:           ;; For the next iteration, we will add 2*DE if next bit from A is on
   sla   e           ;; [2] | DE = 2*DE 
   rl    d           ;; [2] |
   or    a           ;; [1] Check A while resetting Carry (8-bit digit being displaced for multiplication)
   jr   nz, mul      ;; [2/3] If A != 0, multiplication hasn't finished yet, continue
.endm   

.macro add__hl_a
   add   l         ;; [1] | L += A (add up Least Significant Bytes)
   ld    l, a      ;; [1] |
   adc   h         ;; [1] A' = H + L' + Carry (L' = L + A)
   sub   l         ;; [1] A' = H + Carry  (As we subtract L')
   ld    h, a      ;; [1] | H = A' = H + Carry, finally making HL = HL + A
.endm
