.include "utils.h.s"

;a to bc (extend sign)
;inputs:  a  - 8-bit signed number
;outputs: bc - same 16-bit signed number
AtoBCextendendsign:
	ld c,a
	rlca		; or rla
	sbc a,a
	ld b,a
	ret

;;http://z80-heaven.wikidot.com/math#toc12
absA:
     or a
     ret p
     neg         ;or you can use      cpl \ inc a
     ret