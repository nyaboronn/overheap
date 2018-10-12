;###########################################################################
;#### FICHERO:obstacle.h.s
;###########################################################################


.macro DefineObstacle _name, _x, _y, _w, _h, _col
_name:
DefineDrawableEntity _name'_dw, _x, _y, _w, _h, _col
.endm

.globl ent_draw_obs
.globl ent_clear_obs
.globl obstacle1
.globl obstacle_checkCollision
.globl hero_data