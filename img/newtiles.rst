                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module newtiles
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _g_newtiles_255
                             12 	.globl _g_newtiles_254
                             13 	.globl _g_newtiles_253
                             14 	.globl _g_newtiles_252
                             15 	.globl _g_newtiles_251
                             16 	.globl _g_newtiles_250
                             17 	.globl _g_newtiles_249
                             18 	.globl _g_newtiles_248
                             19 	.globl _g_newtiles_247
                             20 	.globl _g_newtiles_246
                             21 	.globl _g_newtiles_245
                             22 	.globl _g_newtiles_244
                             23 	.globl _g_newtiles_243
                             24 	.globl _g_newtiles_242
                             25 	.globl _g_newtiles_241
                             26 	.globl _g_newtiles_240
                             27 	.globl _g_newtiles_239
                             28 	.globl _g_newtiles_238
                             29 	.globl _g_newtiles_237
                             30 	.globl _g_newtiles_236
                             31 	.globl _g_newtiles_235
                             32 	.globl _g_newtiles_234
                             33 	.globl _g_newtiles_233
                             34 	.globl _g_newtiles_232
                             35 	.globl _g_newtiles_231
                             36 	.globl _g_newtiles_230
                             37 	.globl _g_newtiles_229
                             38 	.globl _g_newtiles_228
                             39 	.globl _g_newtiles_227
                             40 	.globl _g_newtiles_226
                             41 	.globl _g_newtiles_225
                             42 	.globl _g_newtiles_224
                             43 	.globl _g_newtiles_223
                             44 	.globl _g_newtiles_222
                             45 	.globl _g_newtiles_221
                             46 	.globl _g_newtiles_220
                             47 	.globl _g_newtiles_219
                             48 	.globl _g_newtiles_218
                             49 	.globl _g_newtiles_217
                             50 	.globl _g_newtiles_216
                             51 	.globl _g_newtiles_215
                             52 	.globl _g_newtiles_214
                             53 	.globl _g_newtiles_213
                             54 	.globl _g_newtiles_212
                             55 	.globl _g_newtiles_211
                             56 	.globl _g_newtiles_210
                             57 	.globl _g_newtiles_209
                             58 	.globl _g_newtiles_208
                             59 	.globl _g_newtiles_207
                             60 	.globl _g_newtiles_206
                             61 	.globl _g_newtiles_205
                             62 	.globl _g_newtiles_204
                             63 	.globl _g_newtiles_203
                             64 	.globl _g_newtiles_202
                             65 	.globl _g_newtiles_201
                             66 	.globl _g_newtiles_200
                             67 	.globl _g_newtiles_199
                             68 	.globl _g_newtiles_198
                             69 	.globl _g_newtiles_197
                             70 	.globl _g_newtiles_196
                             71 	.globl _g_newtiles_195
                             72 	.globl _g_newtiles_194
                             73 	.globl _g_newtiles_193
                             74 	.globl _g_newtiles_192
                             75 	.globl _g_newtiles_191
                             76 	.globl _g_newtiles_190
                             77 	.globl _g_newtiles_189
                             78 	.globl _g_newtiles_188
                             79 	.globl _g_newtiles_187
                             80 	.globl _g_newtiles_186
                             81 	.globl _g_newtiles_185
                             82 	.globl _g_newtiles_184
                             83 	.globl _g_newtiles_183
                             84 	.globl _g_newtiles_182
                             85 	.globl _g_newtiles_181
                             86 	.globl _g_newtiles_180
                             87 	.globl _g_newtiles_179
                             88 	.globl _g_newtiles_178
                             89 	.globl _g_newtiles_177
                             90 	.globl _g_newtiles_176
                             91 	.globl _g_newtiles_175
                             92 	.globl _g_newtiles_174
                             93 	.globl _g_newtiles_173
                             94 	.globl _g_newtiles_172
                             95 	.globl _g_newtiles_171
                             96 	.globl _g_newtiles_170
                             97 	.globl _g_newtiles_169
                             98 	.globl _g_newtiles_168
                             99 	.globl _g_newtiles_167
                            100 	.globl _g_newtiles_166
                            101 	.globl _g_newtiles_165
                            102 	.globl _g_newtiles_164
                            103 	.globl _g_newtiles_163
                            104 	.globl _g_newtiles_162
                            105 	.globl _g_newtiles_161
                            106 	.globl _g_newtiles_160
                            107 	.globl _g_newtiles_159
                            108 	.globl _g_newtiles_158
                            109 	.globl _g_newtiles_157
                            110 	.globl _g_newtiles_156
                            111 	.globl _g_newtiles_155
                            112 	.globl _g_newtiles_154
                            113 	.globl _g_newtiles_153
                            114 	.globl _g_newtiles_152
                            115 	.globl _g_newtiles_151
                            116 	.globl _g_newtiles_150
                            117 	.globl _g_newtiles_149
                            118 	.globl _g_newtiles_148
                            119 	.globl _g_newtiles_147
                            120 	.globl _g_newtiles_146
                            121 	.globl _g_newtiles_145
                            122 	.globl _g_newtiles_144
                            123 	.globl _g_newtiles_143
                            124 	.globl _g_newtiles_142
                            125 	.globl _g_newtiles_141
                            126 	.globl _g_newtiles_140
                            127 	.globl _g_newtiles_139
                            128 	.globl _g_newtiles_138
                            129 	.globl _g_newtiles_137
                            130 	.globl _g_newtiles_136
                            131 	.globl _g_newtiles_135
                            132 	.globl _g_newtiles_134
                            133 	.globl _g_newtiles_133
                            134 	.globl _g_newtiles_132
                            135 	.globl _g_newtiles_131
                            136 	.globl _g_newtiles_130
                            137 	.globl _g_newtiles_129
                            138 	.globl _g_newtiles_128
                            139 	.globl _g_newtiles_127
                            140 	.globl _g_newtiles_126
                            141 	.globl _g_newtiles_125
                            142 	.globl _g_newtiles_124
                            143 	.globl _g_newtiles_123
                            144 	.globl _g_newtiles_122
                            145 	.globl _g_newtiles_121
                            146 	.globl _g_newtiles_120
                            147 	.globl _g_newtiles_119
                            148 	.globl _g_newtiles_118
                            149 	.globl _g_newtiles_117
                            150 	.globl _g_newtiles_116
                            151 	.globl _g_newtiles_115
                            152 	.globl _g_newtiles_114
                            153 	.globl _g_newtiles_113
                            154 	.globl _g_newtiles_112
                            155 	.globl _g_newtiles_111
                            156 	.globl _g_newtiles_110
                            157 	.globl _g_newtiles_109
                            158 	.globl _g_newtiles_108
                            159 	.globl _g_newtiles_107
                            160 	.globl _g_newtiles_106
                            161 	.globl _g_newtiles_105
                            162 	.globl _g_newtiles_104
                            163 	.globl _g_newtiles_103
                            164 	.globl _g_newtiles_102
                            165 	.globl _g_newtiles_101
                            166 	.globl _g_newtiles_100
                            167 	.globl _g_newtiles_099
                            168 	.globl _g_newtiles_098
                            169 	.globl _g_newtiles_097
                            170 	.globl _g_newtiles_096
                            171 	.globl _g_newtiles_095
                            172 	.globl _g_newtiles_094
                            173 	.globl _g_newtiles_093
                            174 	.globl _g_newtiles_092
                            175 	.globl _g_newtiles_091
                            176 	.globl _g_newtiles_090
                            177 	.globl _g_newtiles_089
                            178 	.globl _g_newtiles_088
                            179 	.globl _g_newtiles_087
                            180 	.globl _g_newtiles_086
                            181 	.globl _g_newtiles_085
                            182 	.globl _g_newtiles_084
                            183 	.globl _g_newtiles_083
                            184 	.globl _g_newtiles_082
                            185 	.globl _g_newtiles_081
                            186 	.globl _g_newtiles_080
                            187 	.globl _g_newtiles_079
                            188 	.globl _g_newtiles_078
                            189 	.globl _g_newtiles_077
                            190 	.globl _g_newtiles_076
                            191 	.globl _g_newtiles_075
                            192 	.globl _g_newtiles_074
                            193 	.globl _g_newtiles_073
                            194 	.globl _g_newtiles_072
                            195 	.globl _g_newtiles_071
                            196 	.globl _g_newtiles_070
                            197 	.globl _g_newtiles_069
                            198 	.globl _g_newtiles_068
                            199 	.globl _g_newtiles_067
                            200 	.globl _g_newtiles_066
                            201 	.globl _g_newtiles_065
                            202 	.globl _g_newtiles_064
                            203 	.globl _g_newtiles_063
                            204 	.globl _g_newtiles_062
                            205 	.globl _g_newtiles_061
                            206 	.globl _g_newtiles_060
                            207 	.globl _g_newtiles_059
                            208 	.globl _g_newtiles_058
                            209 	.globl _g_newtiles_057
                            210 	.globl _g_newtiles_056
                            211 	.globl _g_newtiles_055
                            212 	.globl _g_newtiles_054
                            213 	.globl _g_newtiles_053
                            214 	.globl _g_newtiles_052
                            215 	.globl _g_newtiles_051
                            216 	.globl _g_newtiles_050
                            217 	.globl _g_newtiles_049
                            218 	.globl _g_newtiles_048
                            219 	.globl _g_newtiles_047
                            220 	.globl _g_newtiles_046
                            221 	.globl _g_newtiles_045
                            222 	.globl _g_newtiles_044
                            223 	.globl _g_newtiles_043
                            224 	.globl _g_newtiles_042
                            225 	.globl _g_newtiles_041
                            226 	.globl _g_newtiles_040
                            227 	.globl _g_newtiles_039
                            228 	.globl _g_newtiles_038
                            229 	.globl _g_newtiles_037
                            230 	.globl _g_newtiles_036
                            231 	.globl _g_newtiles_035
                            232 	.globl _g_newtiles_034
                            233 	.globl _g_newtiles_033
                            234 	.globl _g_newtiles_032
                            235 	.globl _g_newtiles_031
                            236 	.globl _g_newtiles_030
                            237 	.globl _g_newtiles_029
                            238 	.globl _g_newtiles_028
                            239 	.globl _g_newtiles_027
                            240 	.globl _g_newtiles_026
                            241 	.globl _g_newtiles_025
                            242 	.globl _g_newtiles_024
                            243 	.globl _g_newtiles_023
                            244 	.globl _g_newtiles_022
                            245 	.globl _g_newtiles_021
                            246 	.globl _g_newtiles_020
                            247 	.globl _g_newtiles_019
                            248 	.globl _g_newtiles_018
                            249 	.globl _g_newtiles_017
                            250 	.globl _g_newtiles_016
                            251 	.globl _g_newtiles_015
                            252 	.globl _g_newtiles_014
                            253 	.globl _g_newtiles_013
                            254 	.globl _g_newtiles_012
                            255 	.globl _g_newtiles_011
                            256 	.globl _g_newtiles_010
                            257 	.globl _g_newtiles_009
                            258 	.globl _g_newtiles_008
                            259 	.globl _g_newtiles_007
                            260 	.globl _g_newtiles_006
                            261 	.globl _g_newtiles_005
                            262 	.globl _g_newtiles_004
                            263 	.globl _g_newtiles_003
                            264 	.globl _g_newtiles_002
                            265 	.globl _g_newtiles_001
                            266 	.globl _g_newtiles_000
                            267 ;--------------------------------------------------------
                            268 ; special function registers
                            269 ;--------------------------------------------------------
                            270 ;--------------------------------------------------------
                            271 ; ram data
                            272 ;--------------------------------------------------------
                            273 	.area _DATA
                            274 ;--------------------------------------------------------
                            275 ; ram data
                            276 ;--------------------------------------------------------
                            277 	.area _INITIALIZED
                            278 ;--------------------------------------------------------
                            279 ; absolute external ram data
                            280 ;--------------------------------------------------------
                            281 	.area _DABS (ABS)
                            282 ;--------------------------------------------------------
                            283 ; global & static initialisations
                            284 ;--------------------------------------------------------
                            285 	.area _HOME
                            286 	.area _GSINIT
                            287 	.area _GSFINAL
                            288 	.area _GSINIT
                            289 ;--------------------------------------------------------
                            290 ; Home
                            291 ;--------------------------------------------------------
                            292 	.area _HOME
                            293 	.area _HOME
                            294 ;--------------------------------------------------------
                            295 ; code
                            296 ;--------------------------------------------------------
                            297 	.area _CODE
                            298 	.area _CODE
   0C10                     299 _g_newtiles_000:
   0C10 FF                  300 	.db #0xff	; 255
   0C11 FF                  301 	.db #0xff	; 255
   0C12 FF                  302 	.db #0xff	; 255
   0C13 FF                  303 	.db #0xff	; 255
   0C14 FF                  304 	.db #0xff	; 255
   0C15 FF                  305 	.db #0xff	; 255
   0C16 FF                  306 	.db #0xff	; 255
   0C17 FF                  307 	.db #0xff	; 255
   0C18                     308 _g_newtiles_001:
   0C18 00                  309 	.db #0x00	; 0
   0C19 00                  310 	.db #0x00	; 0
   0C1A 00                  311 	.db #0x00	; 0
   0C1B 00                  312 	.db #0x00	; 0
   0C1C 00                  313 	.db #0x00	; 0
   0C1D 00                  314 	.db #0x00	; 0
   0C1E 00                  315 	.db #0x00	; 0
   0C1F 00                  316 	.db #0x00	; 0
   0C20                     317 _g_newtiles_002:
   0C20 5E                  318 	.db #0x5e	; 94
   0C21 AD                  319 	.db #0xad	; 173
   0C22 0F                  320 	.db #0x0f	; 15
   0C23 5E                  321 	.db #0x5e	; 94
   0C24 AD                  322 	.db #0xad	; 173
   0C25 5E                  323 	.db #0x5e	; 94
   0C26 AD                  324 	.db #0xad	; 173
   0C27 0F                  325 	.db #0x0f	; 15
   0C28                     326 _g_newtiles_003:
   0C28 00                  327 	.db #0x00	; 0
   0C29 00                  328 	.db #0x00	; 0
   0C2A 00                  329 	.db #0x00	; 0
   0C2B 00                  330 	.db #0x00	; 0
   0C2C 00                  331 	.db #0x00	; 0
   0C2D 00                  332 	.db #0x00	; 0
   0C2E 00                  333 	.db #0x00	; 0
   0C2F 00                  334 	.db #0x00	; 0
   0C30                     335 _g_newtiles_004:
   0C30 00                  336 	.db #0x00	; 0
   0C31 00                  337 	.db #0x00	; 0
   0C32 00                  338 	.db #0x00	; 0
   0C33 00                  339 	.db #0x00	; 0
   0C34 00                  340 	.db #0x00	; 0
   0C35 00                  341 	.db #0x00	; 0
   0C36 00                  342 	.db #0x00	; 0
   0C37 00                  343 	.db #0x00	; 0
   0C38                     344 _g_newtiles_005:
   0C38 00                  345 	.db #0x00	; 0
   0C39 00                  346 	.db #0x00	; 0
   0C3A 00                  347 	.db #0x00	; 0
   0C3B 00                  348 	.db #0x00	; 0
   0C3C 00                  349 	.db #0x00	; 0
   0C3D 00                  350 	.db #0x00	; 0
   0C3E 00                  351 	.db #0x00	; 0
   0C3F 00                  352 	.db #0x00	; 0
   0C40                     353 _g_newtiles_006:
   0C40 00                  354 	.db #0x00	; 0
   0C41 00                  355 	.db #0x00	; 0
   0C42 00                  356 	.db #0x00	; 0
   0C43 00                  357 	.db #0x00	; 0
   0C44 00                  358 	.db #0x00	; 0
   0C45 00                  359 	.db #0x00	; 0
   0C46 00                  360 	.db #0x00	; 0
   0C47 00                  361 	.db #0x00	; 0
   0C48                     362 _g_newtiles_007:
   0C48 FF                  363 	.db #0xff	; 255
   0C49 CC                  364 	.db #0xcc	; 204
   0C4A EE                  365 	.db #0xee	; 238
   0C4B CC                  366 	.db #0xcc	; 204
   0C4C EE                  367 	.db #0xee	; 238
   0C4D CC                  368 	.db #0xcc	; 204
   0C4E EE                  369 	.db #0xee	; 238
   0C4F CC                  370 	.db #0xcc	; 204
   0C50                     371 _g_newtiles_008:
   0C50 CC                  372 	.db #0xcc	; 204
   0C51 CC                  373 	.db #0xcc	; 204
   0C52 CC                  374 	.db #0xcc	; 204
   0C53 CC                  375 	.db #0xcc	; 204
   0C54 CC                  376 	.db #0xcc	; 204
   0C55 CC                  377 	.db #0xcc	; 204
   0C56 CC                  378 	.db #0xcc	; 204
   0C57 CC                  379 	.db #0xcc	; 204
   0C58                     380 _g_newtiles_009:
   0C58 CC                  381 	.db #0xcc	; 204
   0C59 FF                  382 	.db #0xff	; 255
   0C5A CC                  383 	.db #0xcc	; 204
   0C5B DD                  384 	.db #0xdd	; 221
   0C5C CC                  385 	.db #0xcc	; 204
   0C5D DD                  386 	.db #0xdd	; 221
   0C5E CC                  387 	.db #0xcc	; 204
   0C5F DD                  388 	.db #0xdd	; 221
   0C60                     389 _g_newtiles_010:
   0C60 FF                  390 	.db #0xff	; 255
   0C61 F3                  391 	.db #0xf3	; 243
   0C62 EE                  392 	.db #0xee	; 238
   0C63 F3                  393 	.db #0xf3	; 243
   0C64 EE                  394 	.db #0xee	; 238
   0C65 F3                  395 	.db #0xf3	; 243
   0C66 EE                  396 	.db #0xee	; 238
   0C67 F3                  397 	.db #0xf3	; 243
   0C68                     398 _g_newtiles_011:
   0C68 F3                  399 	.db #0xf3	; 243
   0C69 F3                  400 	.db #0xf3	; 243
   0C6A F3                  401 	.db #0xf3	; 243
   0C6B F3                  402 	.db #0xf3	; 243
   0C6C F3                  403 	.db #0xf3	; 243
   0C6D F3                  404 	.db #0xf3	; 243
   0C6E F3                  405 	.db #0xf3	; 243
   0C6F F3                  406 	.db #0xf3	; 243
   0C70                     407 _g_newtiles_012:
   0C70 F3                  408 	.db #0xf3	; 243
   0C71 FF                  409 	.db #0xff	; 255
   0C72 F3                  410 	.db #0xf3	; 243
   0C73 DD                  411 	.db #0xdd	; 221
   0C74 F3                  412 	.db #0xf3	; 243
   0C75 DD                  413 	.db #0xdd	; 221
   0C76 F3                  414 	.db #0xf3	; 243
   0C77 DD                  415 	.db #0xdd	; 221
   0C78                     416 _g_newtiles_013:
   0C78 00                  417 	.db #0x00	; 0
   0C79 00                  418 	.db #0x00	; 0
   0C7A 00                  419 	.db #0x00	; 0
   0C7B 00                  420 	.db #0x00	; 0
   0C7C 00                  421 	.db #0x00	; 0
   0C7D 00                  422 	.db #0x00	; 0
   0C7E 00                  423 	.db #0x00	; 0
   0C7F 00                  424 	.db #0x00	; 0
   0C80                     425 _g_newtiles_014:
   0C80 00                  426 	.db #0x00	; 0
   0C81 00                  427 	.db #0x00	; 0
   0C82 00                  428 	.db #0x00	; 0
   0C83 00                  429 	.db #0x00	; 0
   0C84 00                  430 	.db #0x00	; 0
   0C85 00                  431 	.db #0x00	; 0
   0C86 00                  432 	.db #0x00	; 0
   0C87 00                  433 	.db #0x00	; 0
   0C88                     434 _g_newtiles_015:
   0C88 00                  435 	.db #0x00	; 0
   0C89 00                  436 	.db #0x00	; 0
   0C8A 00                  437 	.db #0x00	; 0
   0C8B 00                  438 	.db #0x00	; 0
   0C8C 00                  439 	.db #0x00	; 0
   0C8D 00                  440 	.db #0x00	; 0
   0C8E 00                  441 	.db #0x00	; 0
   0C8F 00                  442 	.db #0x00	; 0
   0C90                     443 _g_newtiles_016:
   0C90 00                  444 	.db #0x00	; 0
   0C91 00                  445 	.db #0x00	; 0
   0C92 00                  446 	.db #0x00	; 0
   0C93 00                  447 	.db #0x00	; 0
   0C94 00                  448 	.db #0x00	; 0
   0C95 00                  449 	.db #0x00	; 0
   0C96 00                  450 	.db #0x00	; 0
   0C97 00                  451 	.db #0x00	; 0
   0C98                     452 _g_newtiles_017:
   0C98 00                  453 	.db #0x00	; 0
   0C99 00                  454 	.db #0x00	; 0
   0C9A 00                  455 	.db #0x00	; 0
   0C9B 00                  456 	.db #0x00	; 0
   0C9C 00                  457 	.db #0x00	; 0
   0C9D 00                  458 	.db #0x00	; 0
   0C9E 00                  459 	.db #0x00	; 0
   0C9F 00                  460 	.db #0x00	; 0
   0CA0                     461 _g_newtiles_018:
   0CA0 5E                  462 	.db #0x5e	; 94
   0CA1 AD                  463 	.db #0xad	; 173
   0CA2 5E                  464 	.db #0x5e	; 94
   0CA3 5E                  465 	.db #0x5e	; 94
   0CA4 0F                  466 	.db #0x0f	; 15
   0CA5 5E                  467 	.db #0x5e	; 94
   0CA6 FC                  468 	.db #0xfc	; 252
   0CA7 5E                  469 	.db #0x5e	; 94
   0CA8                     470 _g_newtiles_019:
   0CA8 00                  471 	.db #0x00	; 0
   0CA9 00                  472 	.db #0x00	; 0
   0CAA 00                  473 	.db #0x00	; 0
   0CAB 00                  474 	.db #0x00	; 0
   0CAC 00                  475 	.db #0x00	; 0
   0CAD 00                  476 	.db #0x00	; 0
   0CAE 00                  477 	.db #0x00	; 0
   0CAF 00                  478 	.db #0x00	; 0
   0CB0                     479 _g_newtiles_020:
   0CB0 00                  480 	.db #0x00	; 0
   0CB1 00                  481 	.db #0x00	; 0
   0CB2 00                  482 	.db #0x00	; 0
   0CB3 00                  483 	.db #0x00	; 0
   0CB4 00                  484 	.db #0x00	; 0
   0CB5 00                  485 	.db #0x00	; 0
   0CB6 00                  486 	.db #0x00	; 0
   0CB7 00                  487 	.db #0x00	; 0
   0CB8                     488 _g_newtiles_021:
   0CB8 00                  489 	.db #0x00	; 0
   0CB9 00                  490 	.db #0x00	; 0
   0CBA 00                  491 	.db #0x00	; 0
   0CBB 00                  492 	.db #0x00	; 0
   0CBC 00                  493 	.db #0x00	; 0
   0CBD 00                  494 	.db #0x00	; 0
   0CBE 00                  495 	.db #0x00	; 0
   0CBF 00                  496 	.db #0x00	; 0
   0CC0                     497 _g_newtiles_022:
   0CC0 00                  498 	.db #0x00	; 0
   0CC1 00                  499 	.db #0x00	; 0
   0CC2 00                  500 	.db #0x00	; 0
   0CC3 00                  501 	.db #0x00	; 0
   0CC4 00                  502 	.db #0x00	; 0
   0CC5 00                  503 	.db #0x00	; 0
   0CC6 00                  504 	.db #0x00	; 0
   0CC7 00                  505 	.db #0x00	; 0
   0CC8                     506 _g_newtiles_023:
   0CC8 EE                  507 	.db #0xee	; 238
   0CC9 CC                  508 	.db #0xcc	; 204
   0CCA EE                  509 	.db #0xee	; 238
   0CCB EE                  510 	.db #0xee	; 238
   0CCC FF                  511 	.db #0xff	; 255
   0CCD DD                  512 	.db #0xdd	; 221
   0CCE FF                  513 	.db #0xff	; 255
   0CCF FF                  514 	.db #0xff	; 255
   0CD0                     515 _g_newtiles_024:
   0CD0 CC                  516 	.db #0xcc	; 204
   0CD1 CC                  517 	.db #0xcc	; 204
   0CD2 EE                  518 	.db #0xee	; 238
   0CD3 DD                  519 	.db #0xdd	; 221
   0CD4 CC                  520 	.db #0xcc	; 204
   0CD5 EE                  521 	.db #0xee	; 238
   0CD6 FF                  522 	.db #0xff	; 255
   0CD7 FF                  523 	.db #0xff	; 255
   0CD8                     524 _g_newtiles_025:
   0CD8 CC                  525 	.db #0xcc	; 204
   0CD9 DD                  526 	.db #0xdd	; 221
   0CDA CC                  527 	.db #0xcc	; 204
   0CDB EE                  528 	.db #0xee	; 238
   0CDC DD                  529 	.db #0xdd	; 221
   0CDD DD                  530 	.db #0xdd	; 221
   0CDE FF                  531 	.db #0xff	; 255
   0CDF FF                  532 	.db #0xff	; 255
   0CE0                     533 _g_newtiles_026:
   0CE0 EE                  534 	.db #0xee	; 238
   0CE1 F3                  535 	.db #0xf3	; 243
   0CE2 EE                  536 	.db #0xee	; 238
   0CE3 F3                  537 	.db #0xf3	; 243
   0CE4 FF                  538 	.db #0xff	; 255
   0CE5 F7                  539 	.db #0xf7	; 247
   0CE6 FF                  540 	.db #0xff	; 255
   0CE7 FF                  541 	.db #0xff	; 255
   0CE8                     542 _g_newtiles_027:
   0CE8 F7                  543 	.db #0xf7	; 247
   0CE9 FB                  544 	.db #0xfb	; 251
   0CEA FF                  545 	.db #0xff	; 255
   0CEB FF                  546 	.db #0xff	; 255
   0CEC FF                  547 	.db #0xff	; 255
   0CED FF                  548 	.db #0xff	; 255
   0CEE FF                  549 	.db #0xff	; 255
   0CEF FF                  550 	.db #0xff	; 255
   0CF0                     551 _g_newtiles_028:
   0CF0 F3                  552 	.db #0xf3	; 243
   0CF1 DD                  553 	.db #0xdd	; 221
   0CF2 F3                  554 	.db #0xf3	; 243
   0CF3 EE                  555 	.db #0xee	; 238
   0CF4 FB                  556 	.db #0xfb	; 251
   0CF5 DD                  557 	.db #0xdd	; 221
   0CF6 FF                  558 	.db #0xff	; 255
   0CF7 FF                  559 	.db #0xff	; 255
   0CF8                     560 _g_newtiles_029:
   0CF8 00                  561 	.db #0x00	; 0
   0CF9 00                  562 	.db #0x00	; 0
   0CFA 00                  563 	.db #0x00	; 0
   0CFB 00                  564 	.db #0x00	; 0
   0CFC 00                  565 	.db #0x00	; 0
   0CFD 00                  566 	.db #0x00	; 0
   0CFE 00                  567 	.db #0x00	; 0
   0CFF 00                  568 	.db #0x00	; 0
   0D00                     569 _g_newtiles_030:
   0D00 00                  570 	.db #0x00	; 0
   0D01 00                  571 	.db #0x00	; 0
   0D02 00                  572 	.db #0x00	; 0
   0D03 00                  573 	.db #0x00	; 0
   0D04 00                  574 	.db #0x00	; 0
   0D05 00                  575 	.db #0x00	; 0
   0D06 00                  576 	.db #0x00	; 0
   0D07 00                  577 	.db #0x00	; 0
   0D08                     578 _g_newtiles_031:
   0D08 00                  579 	.db #0x00	; 0
   0D09 00                  580 	.db #0x00	; 0
   0D0A 00                  581 	.db #0x00	; 0
   0D0B 00                  582 	.db #0x00	; 0
   0D0C 00                  583 	.db #0x00	; 0
   0D0D 00                  584 	.db #0x00	; 0
   0D0E 00                  585 	.db #0x00	; 0
   0D0F 00                  586 	.db #0x00	; 0
   0D10                     587 _g_newtiles_032:
   0D10 00                  588 	.db #0x00	; 0
   0D11 00                  589 	.db #0x00	; 0
   0D12 00                  590 	.db #0x00	; 0
   0D13 00                  591 	.db #0x00	; 0
   0D14 00                  592 	.db #0x00	; 0
   0D15 00                  593 	.db #0x00	; 0
   0D16 00                  594 	.db #0x00	; 0
   0D17 00                  595 	.db #0x00	; 0
   0D18                     596 _g_newtiles_033:
   0D18 00                  597 	.db #0x00	; 0
   0D19 00                  598 	.db #0x00	; 0
   0D1A 00                  599 	.db #0x00	; 0
   0D1B 00                  600 	.db #0x00	; 0
   0D1C 00                  601 	.db #0x00	; 0
   0D1D 00                  602 	.db #0x00	; 0
   0D1E 00                  603 	.db #0x00	; 0
   0D1F 00                  604 	.db #0x00	; 0
   0D20                     605 _g_newtiles_034:
   0D20 00                  606 	.db #0x00	; 0
   0D21 00                  607 	.db #0x00	; 0
   0D22 00                  608 	.db #0x00	; 0
   0D23 00                  609 	.db #0x00	; 0
   0D24 00                  610 	.db #0x00	; 0
   0D25 00                  611 	.db #0x00	; 0
   0D26 00                  612 	.db #0x00	; 0
   0D27 00                  613 	.db #0x00	; 0
   0D28                     614 _g_newtiles_035:
   0D28 00                  615 	.db #0x00	; 0
   0D29 00                  616 	.db #0x00	; 0
   0D2A 00                  617 	.db #0x00	; 0
   0D2B 00                  618 	.db #0x00	; 0
   0D2C 00                  619 	.db #0x00	; 0
   0D2D 00                  620 	.db #0x00	; 0
   0D2E 00                  621 	.db #0x00	; 0
   0D2F 00                  622 	.db #0x00	; 0
   0D30                     623 _g_newtiles_036:
   0D30 00                  624 	.db #0x00	; 0
   0D31 00                  625 	.db #0x00	; 0
   0D32 00                  626 	.db #0x00	; 0
   0D33 00                  627 	.db #0x00	; 0
   0D34 00                  628 	.db #0x00	; 0
   0D35 00                  629 	.db #0x00	; 0
   0D36 00                  630 	.db #0x00	; 0
   0D37 00                  631 	.db #0x00	; 0
   0D38                     632 _g_newtiles_037:
   0D38 00                  633 	.db #0x00	; 0
   0D39 00                  634 	.db #0x00	; 0
   0D3A 00                  635 	.db #0x00	; 0
   0D3B 00                  636 	.db #0x00	; 0
   0D3C 00                  637 	.db #0x00	; 0
   0D3D 00                  638 	.db #0x00	; 0
   0D3E 00                  639 	.db #0x00	; 0
   0D3F 00                  640 	.db #0x00	; 0
   0D40                     641 _g_newtiles_038:
   0D40 00                  642 	.db #0x00	; 0
   0D41 00                  643 	.db #0x00	; 0
   0D42 00                  644 	.db #0x00	; 0
   0D43 00                  645 	.db #0x00	; 0
   0D44 00                  646 	.db #0x00	; 0
   0D45 00                  647 	.db #0x00	; 0
   0D46 00                  648 	.db #0x00	; 0
   0D47 00                  649 	.db #0x00	; 0
   0D48                     650 _g_newtiles_039:
   0D48 00                  651 	.db #0x00	; 0
   0D49 00                  652 	.db #0x00	; 0
   0D4A 00                  653 	.db #0x00	; 0
   0D4B 00                  654 	.db #0x00	; 0
   0D4C 00                  655 	.db #0x00	; 0
   0D4D 00                  656 	.db #0x00	; 0
   0D4E 00                  657 	.db #0x00	; 0
   0D4F 00                  658 	.db #0x00	; 0
   0D50                     659 _g_newtiles_040:
   0D50 00                  660 	.db #0x00	; 0
   0D51 00                  661 	.db #0x00	; 0
   0D52 00                  662 	.db #0x00	; 0
   0D53 00                  663 	.db #0x00	; 0
   0D54 00                  664 	.db #0x00	; 0
   0D55 00                  665 	.db #0x00	; 0
   0D56 00                  666 	.db #0x00	; 0
   0D57 00                  667 	.db #0x00	; 0
   0D58                     668 _g_newtiles_041:
   0D58 00                  669 	.db #0x00	; 0
   0D59 00                  670 	.db #0x00	; 0
   0D5A 00                  671 	.db #0x00	; 0
   0D5B 00                  672 	.db #0x00	; 0
   0D5C 00                  673 	.db #0x00	; 0
   0D5D 00                  674 	.db #0x00	; 0
   0D5E 00                  675 	.db #0x00	; 0
   0D5F 00                  676 	.db #0x00	; 0
   0D60                     677 _g_newtiles_042:
   0D60 00                  678 	.db #0x00	; 0
   0D61 00                  679 	.db #0x00	; 0
   0D62 00                  680 	.db #0x00	; 0
   0D63 00                  681 	.db #0x00	; 0
   0D64 00                  682 	.db #0x00	; 0
   0D65 00                  683 	.db #0x00	; 0
   0D66 00                  684 	.db #0x00	; 0
   0D67 00                  685 	.db #0x00	; 0
   0D68                     686 _g_newtiles_043:
   0D68 00                  687 	.db #0x00	; 0
   0D69 00                  688 	.db #0x00	; 0
   0D6A 00                  689 	.db #0x00	; 0
   0D6B 00                  690 	.db #0x00	; 0
   0D6C 00                  691 	.db #0x00	; 0
   0D6D 00                  692 	.db #0x00	; 0
   0D6E 00                  693 	.db #0x00	; 0
   0D6F 00                  694 	.db #0x00	; 0
   0D70                     695 _g_newtiles_044:
   0D70 00                  696 	.db #0x00	; 0
   0D71 00                  697 	.db #0x00	; 0
   0D72 00                  698 	.db #0x00	; 0
   0D73 00                  699 	.db #0x00	; 0
   0D74 00                  700 	.db #0x00	; 0
   0D75 00                  701 	.db #0x00	; 0
   0D76 00                  702 	.db #0x00	; 0
   0D77 00                  703 	.db #0x00	; 0
   0D78                     704 _g_newtiles_045:
   0D78 00                  705 	.db #0x00	; 0
   0D79 00                  706 	.db #0x00	; 0
   0D7A 00                  707 	.db #0x00	; 0
   0D7B 00                  708 	.db #0x00	; 0
   0D7C 00                  709 	.db #0x00	; 0
   0D7D 00                  710 	.db #0x00	; 0
   0D7E 00                  711 	.db #0x00	; 0
   0D7F 00                  712 	.db #0x00	; 0
   0D80                     713 _g_newtiles_046:
   0D80 00                  714 	.db #0x00	; 0
   0D81 00                  715 	.db #0x00	; 0
   0D82 00                  716 	.db #0x00	; 0
   0D83 00                  717 	.db #0x00	; 0
   0D84 00                  718 	.db #0x00	; 0
   0D85 00                  719 	.db #0x00	; 0
   0D86 00                  720 	.db #0x00	; 0
   0D87 00                  721 	.db #0x00	; 0
   0D88                     722 _g_newtiles_047:
   0D88 00                  723 	.db #0x00	; 0
   0D89 00                  724 	.db #0x00	; 0
   0D8A 00                  725 	.db #0x00	; 0
   0D8B 00                  726 	.db #0x00	; 0
   0D8C 00                  727 	.db #0x00	; 0
   0D8D 00                  728 	.db #0x00	; 0
   0D8E 00                  729 	.db #0x00	; 0
   0D8F 00                  730 	.db #0x00	; 0
   0D90                     731 _g_newtiles_048:
   0D90 00                  732 	.db #0x00	; 0
   0D91 00                  733 	.db #0x00	; 0
   0D92 00                  734 	.db #0x00	; 0
   0D93 00                  735 	.db #0x00	; 0
   0D94 00                  736 	.db #0x00	; 0
   0D95 00                  737 	.db #0x00	; 0
   0D96 00                  738 	.db #0x00	; 0
   0D97 00                  739 	.db #0x00	; 0
   0D98                     740 _g_newtiles_049:
   0D98 00                  741 	.db #0x00	; 0
   0D99 00                  742 	.db #0x00	; 0
   0D9A 00                  743 	.db #0x00	; 0
   0D9B 00                  744 	.db #0x00	; 0
   0D9C 00                  745 	.db #0x00	; 0
   0D9D 00                  746 	.db #0x00	; 0
   0D9E 00                  747 	.db #0x00	; 0
   0D9F 00                  748 	.db #0x00	; 0
   0DA0                     749 _g_newtiles_050:
   0DA0 00                  750 	.db #0x00	; 0
   0DA1 00                  751 	.db #0x00	; 0
   0DA2 00                  752 	.db #0x00	; 0
   0DA3 00                  753 	.db #0x00	; 0
   0DA4 00                  754 	.db #0x00	; 0
   0DA5 00                  755 	.db #0x00	; 0
   0DA6 00                  756 	.db #0x00	; 0
   0DA7 00                  757 	.db #0x00	; 0
   0DA8                     758 _g_newtiles_051:
   0DA8 00                  759 	.db #0x00	; 0
   0DA9 00                  760 	.db #0x00	; 0
   0DAA 00                  761 	.db #0x00	; 0
   0DAB 00                  762 	.db #0x00	; 0
   0DAC 00                  763 	.db #0x00	; 0
   0DAD 00                  764 	.db #0x00	; 0
   0DAE 00                  765 	.db #0x00	; 0
   0DAF 00                  766 	.db #0x00	; 0
   0DB0                     767 _g_newtiles_052:
   0DB0 00                  768 	.db #0x00	; 0
   0DB1 00                  769 	.db #0x00	; 0
   0DB2 00                  770 	.db #0x00	; 0
   0DB3 00                  771 	.db #0x00	; 0
   0DB4 00                  772 	.db #0x00	; 0
   0DB5 00                  773 	.db #0x00	; 0
   0DB6 00                  774 	.db #0x00	; 0
   0DB7 00                  775 	.db #0x00	; 0
   0DB8                     776 _g_newtiles_053:
   0DB8 00                  777 	.db #0x00	; 0
   0DB9 00                  778 	.db #0x00	; 0
   0DBA 00                  779 	.db #0x00	; 0
   0DBB 00                  780 	.db #0x00	; 0
   0DBC 00                  781 	.db #0x00	; 0
   0DBD 00                  782 	.db #0x00	; 0
   0DBE 00                  783 	.db #0x00	; 0
   0DBF 00                  784 	.db #0x00	; 0
   0DC0                     785 _g_newtiles_054:
   0DC0 00                  786 	.db #0x00	; 0
   0DC1 00                  787 	.db #0x00	; 0
   0DC2 00                  788 	.db #0x00	; 0
   0DC3 00                  789 	.db #0x00	; 0
   0DC4 00                  790 	.db #0x00	; 0
   0DC5 00                  791 	.db #0x00	; 0
   0DC6 00                  792 	.db #0x00	; 0
   0DC7 00                  793 	.db #0x00	; 0
   0DC8                     794 _g_newtiles_055:
   0DC8 00                  795 	.db #0x00	; 0
   0DC9 00                  796 	.db #0x00	; 0
   0DCA 00                  797 	.db #0x00	; 0
   0DCB 00                  798 	.db #0x00	; 0
   0DCC 00                  799 	.db #0x00	; 0
   0DCD 00                  800 	.db #0x00	; 0
   0DCE 00                  801 	.db #0x00	; 0
   0DCF 00                  802 	.db #0x00	; 0
   0DD0                     803 _g_newtiles_056:
   0DD0 00                  804 	.db #0x00	; 0
   0DD1 00                  805 	.db #0x00	; 0
   0DD2 00                  806 	.db #0x00	; 0
   0DD3 00                  807 	.db #0x00	; 0
   0DD4 00                  808 	.db #0x00	; 0
   0DD5 00                  809 	.db #0x00	; 0
   0DD6 00                  810 	.db #0x00	; 0
   0DD7 00                  811 	.db #0x00	; 0
   0DD8                     812 _g_newtiles_057:
   0DD8 00                  813 	.db #0x00	; 0
   0DD9 00                  814 	.db #0x00	; 0
   0DDA 00                  815 	.db #0x00	; 0
   0DDB 00                  816 	.db #0x00	; 0
   0DDC 00                  817 	.db #0x00	; 0
   0DDD 00                  818 	.db #0x00	; 0
   0DDE 00                  819 	.db #0x00	; 0
   0DDF 00                  820 	.db #0x00	; 0
   0DE0                     821 _g_newtiles_058:
   0DE0 00                  822 	.db #0x00	; 0
   0DE1 00                  823 	.db #0x00	; 0
   0DE2 00                  824 	.db #0x00	; 0
   0DE3 00                  825 	.db #0x00	; 0
   0DE4 00                  826 	.db #0x00	; 0
   0DE5 00                  827 	.db #0x00	; 0
   0DE6 00                  828 	.db #0x00	; 0
   0DE7 00                  829 	.db #0x00	; 0
   0DE8                     830 _g_newtiles_059:
   0DE8 00                  831 	.db #0x00	; 0
   0DE9 00                  832 	.db #0x00	; 0
   0DEA 00                  833 	.db #0x00	; 0
   0DEB 00                  834 	.db #0x00	; 0
   0DEC 00                  835 	.db #0x00	; 0
   0DED 00                  836 	.db #0x00	; 0
   0DEE 00                  837 	.db #0x00	; 0
   0DEF 00                  838 	.db #0x00	; 0
   0DF0                     839 _g_newtiles_060:
   0DF0 00                  840 	.db #0x00	; 0
   0DF1 00                  841 	.db #0x00	; 0
   0DF2 00                  842 	.db #0x00	; 0
   0DF3 00                  843 	.db #0x00	; 0
   0DF4 00                  844 	.db #0x00	; 0
   0DF5 00                  845 	.db #0x00	; 0
   0DF6 00                  846 	.db #0x00	; 0
   0DF7 00                  847 	.db #0x00	; 0
   0DF8                     848 _g_newtiles_061:
   0DF8 00                  849 	.db #0x00	; 0
   0DF9 00                  850 	.db #0x00	; 0
   0DFA 00                  851 	.db #0x00	; 0
   0DFB 00                  852 	.db #0x00	; 0
   0DFC 00                  853 	.db #0x00	; 0
   0DFD 00                  854 	.db #0x00	; 0
   0DFE 00                  855 	.db #0x00	; 0
   0DFF 00                  856 	.db #0x00	; 0
   0E00                     857 _g_newtiles_062:
   0E00 00                  858 	.db #0x00	; 0
   0E01 00                  859 	.db #0x00	; 0
   0E02 00                  860 	.db #0x00	; 0
   0E03 00                  861 	.db #0x00	; 0
   0E04 00                  862 	.db #0x00	; 0
   0E05 00                  863 	.db #0x00	; 0
   0E06 00                  864 	.db #0x00	; 0
   0E07 00                  865 	.db #0x00	; 0
   0E08                     866 _g_newtiles_063:
   0E08 00                  867 	.db #0x00	; 0
   0E09 00                  868 	.db #0x00	; 0
   0E0A 00                  869 	.db #0x00	; 0
   0E0B 00                  870 	.db #0x00	; 0
   0E0C 00                  871 	.db #0x00	; 0
   0E0D 00                  872 	.db #0x00	; 0
   0E0E 00                  873 	.db #0x00	; 0
   0E0F 00                  874 	.db #0x00	; 0
   0E10                     875 _g_newtiles_064:
   0E10 C0                  876 	.db #0xc0	; 192
   0E11 C0                  877 	.db #0xc0	; 192
   0E12 C0                  878 	.db #0xc0	; 192
   0E13 C0                  879 	.db #0xc0	; 192
   0E14 C0                  880 	.db #0xc0	; 192
   0E15 FF                  881 	.db #0xff	; 255
   0E16 C0                  882 	.db #0xc0	; 192
   0E17 FF                  883 	.db #0xff	; 255
   0E18                     884 _g_newtiles_065:
   0E18 00                  885 	.db #0x00	; 0
   0E19 00                  886 	.db #0x00	; 0
   0E1A 00                  887 	.db #0x00	; 0
   0E1B 00                  888 	.db #0x00	; 0
   0E1C 00                  889 	.db #0x00	; 0
   0E1D 00                  890 	.db #0x00	; 0
   0E1E 00                  891 	.db #0x00	; 0
   0E1F 00                  892 	.db #0x00	; 0
   0E20                     893 _g_newtiles_066:
   0E20 00                  894 	.db #0x00	; 0
   0E21 00                  895 	.db #0x00	; 0
   0E22 00                  896 	.db #0x00	; 0
   0E23 00                  897 	.db #0x00	; 0
   0E24 00                  898 	.db #0x00	; 0
   0E25 00                  899 	.db #0x00	; 0
   0E26 00                  900 	.db #0x00	; 0
   0E27 00                  901 	.db #0x00	; 0
   0E28                     902 _g_newtiles_067:
   0E28 00                  903 	.db #0x00	; 0
   0E29 00                  904 	.db #0x00	; 0
   0E2A 00                  905 	.db #0x00	; 0
   0E2B 00                  906 	.db #0x00	; 0
   0E2C 00                  907 	.db #0x00	; 0
   0E2D 00                  908 	.db #0x00	; 0
   0E2E 00                  909 	.db #0x00	; 0
   0E2F 00                  910 	.db #0x00	; 0
   0E30                     911 _g_newtiles_068:
   0E30 00                  912 	.db #0x00	; 0
   0E31 00                  913 	.db #0x00	; 0
   0E32 00                  914 	.db #0x00	; 0
   0E33 00                  915 	.db #0x00	; 0
   0E34 00                  916 	.db #0x00	; 0
   0E35 00                  917 	.db #0x00	; 0
   0E36 00                  918 	.db #0x00	; 0
   0E37 00                  919 	.db #0x00	; 0
   0E38                     920 _g_newtiles_069:
   0E38 00                  921 	.db #0x00	; 0
   0E39 00                  922 	.db #0x00	; 0
   0E3A 00                  923 	.db #0x00	; 0
   0E3B 00                  924 	.db #0x00	; 0
   0E3C 00                  925 	.db #0x00	; 0
   0E3D 00                  926 	.db #0x00	; 0
   0E3E 00                  927 	.db #0x00	; 0
   0E3F 00                  928 	.db #0x00	; 0
   0E40                     929 _g_newtiles_070:
   0E40 00                  930 	.db #0x00	; 0
   0E41 00                  931 	.db #0x00	; 0
   0E42 00                  932 	.db #0x00	; 0
   0E43 00                  933 	.db #0x00	; 0
   0E44 00                  934 	.db #0x00	; 0
   0E45 00                  935 	.db #0x00	; 0
   0E46 00                  936 	.db #0x00	; 0
   0E47 00                  937 	.db #0x00	; 0
   0E48                     938 _g_newtiles_071:
   0E48 FF                  939 	.db #0xff	; 255
   0E49 CC                  940 	.db #0xcc	; 204
   0E4A EE                  941 	.db #0xee	; 238
   0E4B CC                  942 	.db #0xcc	; 204
   0E4C EE                  943 	.db #0xee	; 238
   0E4D CC                  944 	.db #0xcc	; 204
   0E4E FF                  945 	.db #0xff	; 255
   0E4F FF                  946 	.db #0xff	; 255
   0E50                     947 _g_newtiles_072:
   0E50 CC                  948 	.db #0xcc	; 204
   0E51 CC                  949 	.db #0xcc	; 204
   0E52 CC                  950 	.db #0xcc	; 204
   0E53 CC                  951 	.db #0xcc	; 204
   0E54 CC                  952 	.db #0xcc	; 204
   0E55 CC                  953 	.db #0xcc	; 204
   0E56 FF                  954 	.db #0xff	; 255
   0E57 FF                  955 	.db #0xff	; 255
   0E58                     956 _g_newtiles_073:
   0E58 CC                  957 	.db #0xcc	; 204
   0E59 CC                  958 	.db #0xcc	; 204
   0E5A CC                  959 	.db #0xcc	; 204
   0E5B CC                  960 	.db #0xcc	; 204
   0E5C CC                  961 	.db #0xcc	; 204
   0E5D CC                  962 	.db #0xcc	; 204
   0E5E FF                  963 	.db #0xff	; 255
   0E5F FF                  964 	.db #0xff	; 255
   0E60                     965 _g_newtiles_074:
   0E60 CC                  966 	.db #0xcc	; 204
   0E61 FF                  967 	.db #0xff	; 255
   0E62 CC                  968 	.db #0xcc	; 204
   0E63 DD                  969 	.db #0xdd	; 221
   0E64 CC                  970 	.db #0xcc	; 204
   0E65 DD                  971 	.db #0xdd	; 221
   0E66 FF                  972 	.db #0xff	; 255
   0E67 FF                  973 	.db #0xff	; 255
   0E68                     974 _g_newtiles_075:
   0E68 00                  975 	.db #0x00	; 0
   0E69 00                  976 	.db #0x00	; 0
   0E6A 00                  977 	.db #0x00	; 0
   0E6B 00                  978 	.db #0x00	; 0
   0E6C 00                  979 	.db #0x00	; 0
   0E6D 00                  980 	.db #0x00	; 0
   0E6E 00                  981 	.db #0x00	; 0
   0E6F 00                  982 	.db #0x00	; 0
   0E70                     983 _g_newtiles_076:
   0E70 00                  984 	.db #0x00	; 0
   0E71 00                  985 	.db #0x00	; 0
   0E72 00                  986 	.db #0x00	; 0
   0E73 00                  987 	.db #0x00	; 0
   0E74 00                  988 	.db #0x00	; 0
   0E75 00                  989 	.db #0x00	; 0
   0E76 00                  990 	.db #0x00	; 0
   0E77 00                  991 	.db #0x00	; 0
   0E78                     992 _g_newtiles_077:
   0E78 00                  993 	.db #0x00	; 0
   0E79 00                  994 	.db #0x00	; 0
   0E7A 00                  995 	.db #0x00	; 0
   0E7B 00                  996 	.db #0x00	; 0
   0E7C 00                  997 	.db #0x00	; 0
   0E7D 00                  998 	.db #0x00	; 0
   0E7E 00                  999 	.db #0x00	; 0
   0E7F 00                 1000 	.db #0x00	; 0
   0E80                    1001 _g_newtiles_078:
   0E80 00                 1002 	.db #0x00	; 0
   0E81 00                 1003 	.db #0x00	; 0
   0E82 00                 1004 	.db #0x00	; 0
   0E83 00                 1005 	.db #0x00	; 0
   0E84 00                 1006 	.db #0x00	; 0
   0E85 00                 1007 	.db #0x00	; 0
   0E86 00                 1008 	.db #0x00	; 0
   0E87 00                 1009 	.db #0x00	; 0
   0E88                    1010 _g_newtiles_079:
   0E88 00                 1011 	.db #0x00	; 0
   0E89 00                 1012 	.db #0x00	; 0
   0E8A 00                 1013 	.db #0x00	; 0
   0E8B 00                 1014 	.db #0x00	; 0
   0E8C 00                 1015 	.db #0x00	; 0
   0E8D 00                 1016 	.db #0x00	; 0
   0E8E 00                 1017 	.db #0x00	; 0
   0E8F 00                 1018 	.db #0x00	; 0
   0E90                    1019 _g_newtiles_080:
   0E90 C0                 1020 	.db #0xc0	; 192
   0E91 FF                 1021 	.db #0xff	; 255
   0E92 C0                 1022 	.db #0xc0	; 192
   0E93 FF                 1023 	.db #0xff	; 255
   0E94 C0                 1024 	.db #0xc0	; 192
   0E95 FF                 1025 	.db #0xff	; 255
   0E96 C0                 1026 	.db #0xc0	; 192
   0E97 FF                 1027 	.db #0xff	; 255
   0E98                    1028 _g_newtiles_081:
   0E98 00                 1029 	.db #0x00	; 0
   0E99 00                 1030 	.db #0x00	; 0
   0E9A 00                 1031 	.db #0x00	; 0
   0E9B 00                 1032 	.db #0x00	; 0
   0E9C 00                 1033 	.db #0x00	; 0
   0E9D 00                 1034 	.db #0x00	; 0
   0E9E 00                 1035 	.db #0x00	; 0
   0E9F 00                 1036 	.db #0x00	; 0
   0EA0                    1037 _g_newtiles_082:
   0EA0 00                 1038 	.db #0x00	; 0
   0EA1 00                 1039 	.db #0x00	; 0
   0EA2 00                 1040 	.db #0x00	; 0
   0EA3 00                 1041 	.db #0x00	; 0
   0EA4 00                 1042 	.db #0x00	; 0
   0EA5 00                 1043 	.db #0x00	; 0
   0EA6 00                 1044 	.db #0x00	; 0
   0EA7 00                 1045 	.db #0x00	; 0
   0EA8                    1046 _g_newtiles_083:
   0EA8 00                 1047 	.db #0x00	; 0
   0EA9 00                 1048 	.db #0x00	; 0
   0EAA 00                 1049 	.db #0x00	; 0
   0EAB 00                 1050 	.db #0x00	; 0
   0EAC 00                 1051 	.db #0x00	; 0
   0EAD 00                 1052 	.db #0x00	; 0
   0EAE 00                 1053 	.db #0x00	; 0
   0EAF 00                 1054 	.db #0x00	; 0
   0EB0                    1055 _g_newtiles_084:
   0EB0 00                 1056 	.db #0x00	; 0
   0EB1 00                 1057 	.db #0x00	; 0
   0EB2 00                 1058 	.db #0x00	; 0
   0EB3 00                 1059 	.db #0x00	; 0
   0EB4 00                 1060 	.db #0x00	; 0
   0EB5 00                 1061 	.db #0x00	; 0
   0EB6 00                 1062 	.db #0x00	; 0
   0EB7 00                 1063 	.db #0x00	; 0
   0EB8                    1064 _g_newtiles_085:
   0EB8 00                 1065 	.db #0x00	; 0
   0EB9 00                 1066 	.db #0x00	; 0
   0EBA 00                 1067 	.db #0x00	; 0
   0EBB 00                 1068 	.db #0x00	; 0
   0EBC 00                 1069 	.db #0x00	; 0
   0EBD 00                 1070 	.db #0x00	; 0
   0EBE 00                 1071 	.db #0x00	; 0
   0EBF 00                 1072 	.db #0x00	; 0
   0EC0                    1073 _g_newtiles_086:
   0EC0 00                 1074 	.db #0x00	; 0
   0EC1 00                 1075 	.db #0x00	; 0
   0EC2 00                 1076 	.db #0x00	; 0
   0EC3 00                 1077 	.db #0x00	; 0
   0EC4 00                 1078 	.db #0x00	; 0
   0EC5 00                 1079 	.db #0x00	; 0
   0EC6 00                 1080 	.db #0x00	; 0
   0EC7 00                 1081 	.db #0x00	; 0
   0EC8                    1082 _g_newtiles_087:
   0EC8 EE                 1083 	.db #0xee	; 238
   0EC9 CC                 1084 	.db #0xcc	; 204
   0ECA EE                 1085 	.db #0xee	; 238
   0ECB CC                 1086 	.db #0xcc	; 204
   0ECC EE                 1087 	.db #0xee	; 238
   0ECD CC                 1088 	.db #0xcc	; 204
   0ECE EE                 1089 	.db #0xee	; 238
   0ECF CC                 1090 	.db #0xcc	; 204
   0ED0                    1091 _g_newtiles_088:
   0ED0 CC                 1092 	.db #0xcc	; 204
   0ED1 FF                 1093 	.db #0xff	; 255
   0ED2 DD                 1094 	.db #0xdd	; 221
   0ED3 DD                 1095 	.db #0xdd	; 221
   0ED4 CC                 1096 	.db #0xcc	; 204
   0ED5 FF                 1097 	.db #0xff	; 255
   0ED6 DD                 1098 	.db #0xdd	; 221
   0ED7 DD                 1099 	.db #0xdd	; 221
   0ED8                    1100 _g_newtiles_089:
   0ED8 00                 1101 	.db #0x00	; 0
   0ED9 00                 1102 	.db #0x00	; 0
   0EDA 00                 1103 	.db #0x00	; 0
   0EDB 00                 1104 	.db #0x00	; 0
   0EDC 00                 1105 	.db #0x00	; 0
   0EDD 00                 1106 	.db #0x00	; 0
   0EDE 00                 1107 	.db #0x00	; 0
   0EDF 00                 1108 	.db #0x00	; 0
   0EE0                    1109 _g_newtiles_090:
   0EE0 00                 1110 	.db #0x00	; 0
   0EE1 00                 1111 	.db #0x00	; 0
   0EE2 00                 1112 	.db #0x00	; 0
   0EE3 00                 1113 	.db #0x00	; 0
   0EE4 00                 1114 	.db #0x00	; 0
   0EE5 00                 1115 	.db #0x00	; 0
   0EE6 00                 1116 	.db #0x00	; 0
   0EE7 00                 1117 	.db #0x00	; 0
   0EE8                    1118 _g_newtiles_091:
   0EE8 00                 1119 	.db #0x00	; 0
   0EE9 00                 1120 	.db #0x00	; 0
   0EEA 00                 1121 	.db #0x00	; 0
   0EEB 00                 1122 	.db #0x00	; 0
   0EEC 00                 1123 	.db #0x00	; 0
   0EED 00                 1124 	.db #0x00	; 0
   0EEE 00                 1125 	.db #0x00	; 0
   0EEF 00                 1126 	.db #0x00	; 0
   0EF0                    1127 _g_newtiles_092:
   0EF0 00                 1128 	.db #0x00	; 0
   0EF1 00                 1129 	.db #0x00	; 0
   0EF2 00                 1130 	.db #0x00	; 0
   0EF3 00                 1131 	.db #0x00	; 0
   0EF4 00                 1132 	.db #0x00	; 0
   0EF5 00                 1133 	.db #0x00	; 0
   0EF6 00                 1134 	.db #0x00	; 0
   0EF7 00                 1135 	.db #0x00	; 0
   0EF8                    1136 _g_newtiles_093:
   0EF8 00                 1137 	.db #0x00	; 0
   0EF9 00                 1138 	.db #0x00	; 0
   0EFA 00                 1139 	.db #0x00	; 0
   0EFB 00                 1140 	.db #0x00	; 0
   0EFC 00                 1141 	.db #0x00	; 0
   0EFD 00                 1142 	.db #0x00	; 0
   0EFE 00                 1143 	.db #0x00	; 0
   0EFF 00                 1144 	.db #0x00	; 0
   0F00                    1145 _g_newtiles_094:
   0F00 00                 1146 	.db #0x00	; 0
   0F01 00                 1147 	.db #0x00	; 0
   0F02 00                 1148 	.db #0x00	; 0
   0F03 00                 1149 	.db #0x00	; 0
   0F04 00                 1150 	.db #0x00	; 0
   0F05 00                 1151 	.db #0x00	; 0
   0F06 00                 1152 	.db #0x00	; 0
   0F07 00                 1153 	.db #0x00	; 0
   0F08                    1154 _g_newtiles_095:
   0F08 00                 1155 	.db #0x00	; 0
   0F09 00                 1156 	.db #0x00	; 0
   0F0A 00                 1157 	.db #0x00	; 0
   0F0B 00                 1158 	.db #0x00	; 0
   0F0C 00                 1159 	.db #0x00	; 0
   0F0D 00                 1160 	.db #0x00	; 0
   0F0E 00                 1161 	.db #0x00	; 0
   0F0F 00                 1162 	.db #0x00	; 0
   0F10                    1163 _g_newtiles_096:
   0F10 00                 1164 	.db #0x00	; 0
   0F11 00                 1165 	.db #0x00	; 0
   0F12 00                 1166 	.db #0x00	; 0
   0F13 00                 1167 	.db #0x00	; 0
   0F14 00                 1168 	.db #0x00	; 0
   0F15 00                 1169 	.db #0x00	; 0
   0F16 00                 1170 	.db #0x00	; 0
   0F17 00                 1171 	.db #0x00	; 0
   0F18                    1172 _g_newtiles_097:
   0F18 CC                 1173 	.db #0xcc	; 204
   0F19 CC                 1174 	.db #0xcc	; 204
   0F1A CC                 1175 	.db #0xcc	; 204
   0F1B CC                 1176 	.db #0xcc	; 204
   0F1C CC                 1177 	.db #0xcc	; 204
   0F1D CC                 1178 	.db #0xcc	; 204
   0F1E CC                 1179 	.db #0xcc	; 204
   0F1F CD                 1180 	.db #0xcd	; 205
   0F20                    1181 _g_newtiles_098:
   0F20 CF                 1182 	.db #0xcf	; 207
   0F21 CF                 1183 	.db #0xcf	; 207
   0F22 CF                 1184 	.db #0xcf	; 207
   0F23 CF                 1185 	.db #0xcf	; 207
   0F24 CF                 1186 	.db #0xcf	; 207
   0F25 CF                 1187 	.db #0xcf	; 207
   0F26 45                 1188 	.db #0x45	; 69	'E'
   0F27 CF                 1189 	.db #0xcf	; 207
   0F28                    1190 _g_newtiles_099:
   0F28 00                 1191 	.db #0x00	; 0
   0F29 00                 1192 	.db #0x00	; 0
   0F2A 00                 1193 	.db #0x00	; 0
   0F2B 00                 1194 	.db #0x00	; 0
   0F2C 00                 1195 	.db #0x00	; 0
   0F2D 00                 1196 	.db #0x00	; 0
   0F2E 00                 1197 	.db #0x00	; 0
   0F2F 00                 1198 	.db #0x00	; 0
   0F30                    1199 _g_newtiles_100:
   0F30 00                 1200 	.db #0x00	; 0
   0F31 00                 1201 	.db #0x00	; 0
   0F32 00                 1202 	.db #0x00	; 0
   0F33 00                 1203 	.db #0x00	; 0
   0F34 00                 1204 	.db #0x00	; 0
   0F35 00                 1205 	.db #0x00	; 0
   0F36 00                 1206 	.db #0x00	; 0
   0F37 00                 1207 	.db #0x00	; 0
   0F38                    1208 _g_newtiles_101:
   0F38 00                 1209 	.db #0x00	; 0
   0F39 00                 1210 	.db #0x00	; 0
   0F3A 00                 1211 	.db #0x00	; 0
   0F3B 00                 1212 	.db #0x00	; 0
   0F3C 00                 1213 	.db #0x00	; 0
   0F3D 00                 1214 	.db #0x00	; 0
   0F3E 00                 1215 	.db #0x00	; 0
   0F3F 00                 1216 	.db #0x00	; 0
   0F40                    1217 _g_newtiles_102:
   0F40 00                 1218 	.db #0x00	; 0
   0F41 00                 1219 	.db #0x00	; 0
   0F42 00                 1220 	.db #0x00	; 0
   0F43 00                 1221 	.db #0x00	; 0
   0F44 00                 1222 	.db #0x00	; 0
   0F45 00                 1223 	.db #0x00	; 0
   0F46 00                 1224 	.db #0x00	; 0
   0F47 00                 1225 	.db #0x00	; 0
   0F48                    1226 _g_newtiles_103:
   0F48 00                 1227 	.db #0x00	; 0
   0F49 00                 1228 	.db #0x00	; 0
   0F4A 00                 1229 	.db #0x00	; 0
   0F4B 00                 1230 	.db #0x00	; 0
   0F4C 00                 1231 	.db #0x00	; 0
   0F4D 00                 1232 	.db #0x00	; 0
   0F4E 00                 1233 	.db #0x00	; 0
   0F4F 00                 1234 	.db #0x00	; 0
   0F50                    1235 _g_newtiles_104:
   0F50 00                 1236 	.db #0x00	; 0
   0F51 00                 1237 	.db #0x00	; 0
   0F52 00                 1238 	.db #0x00	; 0
   0F53 00                 1239 	.db #0x00	; 0
   0F54 00                 1240 	.db #0x00	; 0
   0F55 00                 1241 	.db #0x00	; 0
   0F56 00                 1242 	.db #0x00	; 0
   0F57 00                 1243 	.db #0x00	; 0
   0F58                    1244 _g_newtiles_105:
   0F58 00                 1245 	.db #0x00	; 0
   0F59 00                 1246 	.db #0x00	; 0
   0F5A 00                 1247 	.db #0x00	; 0
   0F5B 00                 1248 	.db #0x00	; 0
   0F5C 00                 1249 	.db #0x00	; 0
   0F5D 00                 1250 	.db #0x00	; 0
   0F5E 00                 1251 	.db #0x00	; 0
   0F5F 00                 1252 	.db #0x00	; 0
   0F60                    1253 _g_newtiles_106:
   0F60 00                 1254 	.db #0x00	; 0
   0F61 00                 1255 	.db #0x00	; 0
   0F62 00                 1256 	.db #0x00	; 0
   0F63 00                 1257 	.db #0x00	; 0
   0F64 00                 1258 	.db #0x00	; 0
   0F65 00                 1259 	.db #0x00	; 0
   0F66 00                 1260 	.db #0x00	; 0
   0F67 00                 1261 	.db #0x00	; 0
   0F68                    1262 _g_newtiles_107:
   0F68 00                 1263 	.db #0x00	; 0
   0F69 00                 1264 	.db #0x00	; 0
   0F6A 00                 1265 	.db #0x00	; 0
   0F6B 00                 1266 	.db #0x00	; 0
   0F6C 00                 1267 	.db #0x00	; 0
   0F6D 00                 1268 	.db #0x00	; 0
   0F6E 00                 1269 	.db #0x00	; 0
   0F6F 00                 1270 	.db #0x00	; 0
   0F70                    1271 _g_newtiles_108:
   0F70 00                 1272 	.db #0x00	; 0
   0F71 00                 1273 	.db #0x00	; 0
   0F72 00                 1274 	.db #0x00	; 0
   0F73 00                 1275 	.db #0x00	; 0
   0F74 00                 1276 	.db #0x00	; 0
   0F75 00                 1277 	.db #0x00	; 0
   0F76 00                 1278 	.db #0x00	; 0
   0F77 00                 1279 	.db #0x00	; 0
   0F78                    1280 _g_newtiles_109:
   0F78 00                 1281 	.db #0x00	; 0
   0F79 00                 1282 	.db #0x00	; 0
   0F7A 00                 1283 	.db #0x00	; 0
   0F7B 00                 1284 	.db #0x00	; 0
   0F7C 00                 1285 	.db #0x00	; 0
   0F7D 00                 1286 	.db #0x00	; 0
   0F7E 00                 1287 	.db #0x00	; 0
   0F7F 00                 1288 	.db #0x00	; 0
   0F80                    1289 _g_newtiles_110:
   0F80 00                 1290 	.db #0x00	; 0
   0F81 00                 1291 	.db #0x00	; 0
   0F82 00                 1292 	.db #0x00	; 0
   0F83 00                 1293 	.db #0x00	; 0
   0F84 00                 1294 	.db #0x00	; 0
   0F85 00                 1295 	.db #0x00	; 0
   0F86 00                 1296 	.db #0x00	; 0
   0F87 00                 1297 	.db #0x00	; 0
   0F88                    1298 _g_newtiles_111:
   0F88 00                 1299 	.db #0x00	; 0
   0F89 00                 1300 	.db #0x00	; 0
   0F8A 00                 1301 	.db #0x00	; 0
   0F8B 00                 1302 	.db #0x00	; 0
   0F8C 00                 1303 	.db #0x00	; 0
   0F8D 00                 1304 	.db #0x00	; 0
   0F8E 00                 1305 	.db #0x00	; 0
   0F8F 00                 1306 	.db #0x00	; 0
   0F90                    1307 _g_newtiles_112:
   0F90 00                 1308 	.db #0x00	; 0
   0F91 00                 1309 	.db #0x00	; 0
   0F92 00                 1310 	.db #0x00	; 0
   0F93 00                 1311 	.db #0x00	; 0
   0F94 00                 1312 	.db #0x00	; 0
   0F95 00                 1313 	.db #0x00	; 0
   0F96 00                 1314 	.db #0x00	; 0
   0F97 00                 1315 	.db #0x00	; 0
   0F98                    1316 _g_newtiles_113:
   0F98 CC                 1317 	.db #0xcc	; 204
   0F99 CD                 1318 	.db #0xcd	; 205
   0F9A DD                 1319 	.db #0xdd	; 221
   0F9B CD                 1320 	.db #0xcd	; 205
   0F9C EE                 1321 	.db #0xee	; 238
   0F9D CD                 1322 	.db #0xcd	; 205
   0F9E FF                 1323 	.db #0xff	; 255
   0F9F EF                 1324 	.db #0xef	; 239
   0FA0                    1325 _g_newtiles_114:
   0FA0 CF                 1326 	.db #0xcf	; 207
   0FA1 CF                 1327 	.db #0xcf	; 207
   0FA2 CF                 1328 	.db #0xcf	; 207
   0FA3 CF                 1329 	.db #0xcf	; 207
   0FA4 CF                 1330 	.db #0xcf	; 207
   0FA5 CF                 1331 	.db #0xcf	; 207
   0FA6 CF                 1332 	.db #0xcf	; 207
   0FA7 CF                 1333 	.db #0xcf	; 207
   0FA8                    1334 _g_newtiles_115:
   0FA8 00                 1335 	.db #0x00	; 0
   0FA9 CF                 1336 	.db #0xcf	; 207
   0FAA 8A                 1337 	.db #0x8a	; 138
   0FAB 45                 1338 	.db #0x45	; 69	'E'
   0FAC CF                 1339 	.db #0xcf	; 207
   0FAD 00                 1340 	.db #0x00	; 0
   0FAE CF                 1341 	.db #0xcf	; 207
   0FAF 8A                 1342 	.db #0x8a	; 138
   0FB0                    1343 _g_newtiles_116:
   0FB0 00                 1344 	.db #0x00	; 0
   0FB1 00                 1345 	.db #0x00	; 0
   0FB2 00                 1346 	.db #0x00	; 0
   0FB3 00                 1347 	.db #0x00	; 0
   0FB4 00                 1348 	.db #0x00	; 0
   0FB5 00                 1349 	.db #0x00	; 0
   0FB6 00                 1350 	.db #0x00	; 0
   0FB7 00                 1351 	.db #0x00	; 0
   0FB8                    1352 _g_newtiles_117:
   0FB8 CC                 1353 	.db #0xcc	; 204
   0FB9 CC                 1354 	.db #0xcc	; 204
   0FBA DD                 1355 	.db #0xdd	; 221
   0FBB DD                 1356 	.db #0xdd	; 221
   0FBC EE                 1357 	.db #0xee	; 238
   0FBD EF                 1358 	.db #0xef	; 239
   0FBE FF                 1359 	.db #0xff	; 255
   0FBF EF                 1360 	.db #0xef	; 239
   0FC0                    1361 _g_newtiles_118:
   0FC0 CD                 1362 	.db #0xcd	; 205
   0FC1 CE                 1363 	.db #0xce	; 206
   0FC2 CF                 1364 	.db #0xcf	; 207
   0FC3 CF                 1365 	.db #0xcf	; 207
   0FC4 CF                 1366 	.db #0xcf	; 207
   0FC5 CF                 1367 	.db #0xcf	; 207
   0FC6 CF                 1368 	.db #0xcf	; 207
   0FC7 CF                 1369 	.db #0xcf	; 207
   0FC8                    1370 _g_newtiles_119:
   0FC8 CC                 1371 	.db #0xcc	; 204
   0FC9 CC                 1372 	.db #0xcc	; 204
   0FCA CC                 1373 	.db #0xcc	; 204
   0FCB EE                 1374 	.db #0xee	; 238
   0FCC DF                 1375 	.db #0xdf	; 223
   0FCD DD                 1376 	.db #0xdd	; 221
   0FCE DF                 1377 	.db #0xdf	; 223
   0FCF FF                 1378 	.db #0xff	; 255
   0FD0                    1379 _g_newtiles_120:
   0FD0 00                 1380 	.db #0x00	; 0
   0FD1 00                 1381 	.db #0x00	; 0
   0FD2 00                 1382 	.db #0x00	; 0
   0FD3 00                 1383 	.db #0x00	; 0
   0FD4 00                 1384 	.db #0x00	; 0
   0FD5 00                 1385 	.db #0x00	; 0
   0FD6 00                 1386 	.db #0x00	; 0
   0FD7 00                 1387 	.db #0x00	; 0
   0FD8                    1388 _g_newtiles_121:
   0FD8 00                 1389 	.db #0x00	; 0
   0FD9 00                 1390 	.db #0x00	; 0
   0FDA 00                 1391 	.db #0x00	; 0
   0FDB 00                 1392 	.db #0x00	; 0
   0FDC 00                 1393 	.db #0x00	; 0
   0FDD 00                 1394 	.db #0x00	; 0
   0FDE 00                 1395 	.db #0x00	; 0
   0FDF 00                 1396 	.db #0x00	; 0
   0FE0                    1397 _g_newtiles_122:
   0FE0 00                 1398 	.db #0x00	; 0
   0FE1 00                 1399 	.db #0x00	; 0
   0FE2 00                 1400 	.db #0x00	; 0
   0FE3 00                 1401 	.db #0x00	; 0
   0FE4 00                 1402 	.db #0x00	; 0
   0FE5 00                 1403 	.db #0x00	; 0
   0FE6 00                 1404 	.db #0x00	; 0
   0FE7 00                 1405 	.db #0x00	; 0
   0FE8                    1406 _g_newtiles_123:
   0FE8 00                 1407 	.db #0x00	; 0
   0FE9 00                 1408 	.db #0x00	; 0
   0FEA 00                 1409 	.db #0x00	; 0
   0FEB 00                 1410 	.db #0x00	; 0
   0FEC 00                 1411 	.db #0x00	; 0
   0FED 00                 1412 	.db #0x00	; 0
   0FEE 00                 1413 	.db #0x00	; 0
   0FEF 00                 1414 	.db #0x00	; 0
   0FF0                    1415 _g_newtiles_124:
   0FF0 00                 1416 	.db #0x00	; 0
   0FF1 00                 1417 	.db #0x00	; 0
   0FF2 00                 1418 	.db #0x00	; 0
   0FF3 00                 1419 	.db #0x00	; 0
   0FF4 00                 1420 	.db #0x00	; 0
   0FF5 00                 1421 	.db #0x00	; 0
   0FF6 00                 1422 	.db #0x00	; 0
   0FF7 00                 1423 	.db #0x00	; 0
   0FF8                    1424 _g_newtiles_125:
   0FF8 00                 1425 	.db #0x00	; 0
   0FF9 00                 1426 	.db #0x00	; 0
   0FFA 00                 1427 	.db #0x00	; 0
   0FFB 00                 1428 	.db #0x00	; 0
   0FFC 00                 1429 	.db #0x00	; 0
   0FFD 00                 1430 	.db #0x00	; 0
   0FFE 00                 1431 	.db #0x00	; 0
   0FFF 00                 1432 	.db #0x00	; 0
   1000                    1433 _g_newtiles_126:
   1000 00                 1434 	.db #0x00	; 0
   1001 00                 1435 	.db #0x00	; 0
   1002 00                 1436 	.db #0x00	; 0
   1003 00                 1437 	.db #0x00	; 0
   1004 00                 1438 	.db #0x00	; 0
   1005 00                 1439 	.db #0x00	; 0
   1006 00                 1440 	.db #0x00	; 0
   1007 00                 1441 	.db #0x00	; 0
   1008                    1442 _g_newtiles_127:
   1008 00                 1443 	.db #0x00	; 0
   1009 00                 1444 	.db #0x00	; 0
   100A 00                 1445 	.db #0x00	; 0
   100B 00                 1446 	.db #0x00	; 0
   100C 00                 1447 	.db #0x00	; 0
   100D 00                 1448 	.db #0x00	; 0
   100E 00                 1449 	.db #0x00	; 0
   100F 00                 1450 	.db #0x00	; 0
   1010                    1451 _g_newtiles_128:
   1010 00                 1452 	.db #0x00	; 0
   1011 00                 1453 	.db #0x00	; 0
   1012 00                 1454 	.db #0x00	; 0
   1013 00                 1455 	.db #0x00	; 0
   1014 00                 1456 	.db #0x00	; 0
   1015 00                 1457 	.db #0x00	; 0
   1016 00                 1458 	.db #0x00	; 0
   1017 00                 1459 	.db #0x00	; 0
   1018                    1460 _g_newtiles_129:
   1018 00                 1461 	.db #0x00	; 0
   1019 00                 1462 	.db #0x00	; 0
   101A 00                 1463 	.db #0x00	; 0
   101B 00                 1464 	.db #0x00	; 0
   101C 00                 1465 	.db #0x00	; 0
   101D 00                 1466 	.db #0x00	; 0
   101E 00                 1467 	.db #0x00	; 0
   101F 00                 1468 	.db #0x00	; 0
   1020                    1469 _g_newtiles_130:
   1020 CC                 1470 	.db #0xcc	; 204
   1021 C0                 1471 	.db #0xc0	; 192
   1022 CC                 1472 	.db #0xcc	; 204
   1023 C0                 1473 	.db #0xc0	; 192
   1024 CC                 1474 	.db #0xcc	; 204
   1025 C0                 1475 	.db #0xc0	; 192
   1026 CC                 1476 	.db #0xcc	; 204
   1027 C0                 1477 	.db #0xc0	; 192
   1028                    1478 _g_newtiles_131:
   1028 CC                 1479 	.db #0xcc	; 204
   1029 C0                 1480 	.db #0xc0	; 192
   102A DD                 1481 	.db #0xdd	; 221
   102B C0                 1482 	.db #0xc0	; 192
   102C DD                 1483 	.db #0xdd	; 221
   102D C0                 1484 	.db #0xc0	; 192
   102E CC                 1485 	.db #0xcc	; 204
   102F C0                 1486 	.db #0xc0	; 192
   1030                    1487 _g_newtiles_132:
   1030 88                 1488 	.db #0x88	; 136
   1031 00                 1489 	.db #0x00	; 0
   1032 AA                 1490 	.db #0xaa	; 170
   1033 00                 1491 	.db #0x00	; 0
   1034 AA                 1492 	.db #0xaa	; 170
   1035 00                 1493 	.db #0x00	; 0
   1036 88                 1494 	.db #0x88	; 136
   1037 00                 1495 	.db #0x00	; 0
   1038                    1496 _g_newtiles_133:
   1038 CC                 1497 	.db #0xcc	; 204
   1039 CD                 1498 	.db #0xcd	; 205
   103A CC                 1499 	.db #0xcc	; 204
   103B CF                 1500 	.db #0xcf	; 207
   103C CD                 1501 	.db #0xcd	; 205
   103D CF                 1502 	.db #0xcf	; 207
   103E CF                 1503 	.db #0xcf	; 207
   103F CD                 1504 	.db #0xcd	; 205
   1040                    1505 _g_newtiles_134:
   1040 CF                 1506 	.db #0xcf	; 207
   1041 CF                 1507 	.db #0xcf	; 207
   1042 CF                 1508 	.db #0xcf	; 207
   1043 CF                 1509 	.db #0xcf	; 207
   1044 CF                 1510 	.db #0xcf	; 207
   1045 CF                 1511 	.db #0xcf	; 207
   1046 CF                 1512 	.db #0xcf	; 207
   1047 CF                 1513 	.db #0xcf	; 207
   1048                    1514 _g_newtiles_135:
   1048 CE                 1515 	.db #0xce	; 206
   1049 CC                 1516 	.db #0xcc	; 204
   104A CF                 1517 	.db #0xcf	; 207
   104B CC                 1518 	.db #0xcc	; 204
   104C CF                 1519 	.db #0xcf	; 207
   104D CE                 1520 	.db #0xce	; 206
   104E CE                 1521 	.db #0xce	; 206
   104F CF                 1522 	.db #0xcf	; 207
   1050                    1523 _g_newtiles_136:
   1050 00                 1524 	.db #0x00	; 0
   1051 00                 1525 	.db #0x00	; 0
   1052 00                 1526 	.db #0x00	; 0
   1053 00                 1527 	.db #0x00	; 0
   1054 00                 1528 	.db #0x00	; 0
   1055 00                 1529 	.db #0x00	; 0
   1056 00                 1530 	.db #0x00	; 0
   1057 00                 1531 	.db #0x00	; 0
   1058                    1532 _g_newtiles_137:
   1058 00                 1533 	.db #0x00	; 0
   1059 00                 1534 	.db #0x00	; 0
   105A 00                 1535 	.db #0x00	; 0
   105B 00                 1536 	.db #0x00	; 0
   105C 00                 1537 	.db #0x00	; 0
   105D 00                 1538 	.db #0x00	; 0
   105E 00                 1539 	.db #0x00	; 0
   105F 00                 1540 	.db #0x00	; 0
   1060                    1541 _g_newtiles_138:
   1060 00                 1542 	.db #0x00	; 0
   1061 00                 1543 	.db #0x00	; 0
   1062 00                 1544 	.db #0x00	; 0
   1063 00                 1545 	.db #0x00	; 0
   1064 00                 1546 	.db #0x00	; 0
   1065 00                 1547 	.db #0x00	; 0
   1066 00                 1548 	.db #0x00	; 0
   1067 00                 1549 	.db #0x00	; 0
   1068                    1550 _g_newtiles_139:
   1068 00                 1551 	.db #0x00	; 0
   1069 00                 1552 	.db #0x00	; 0
   106A 00                 1553 	.db #0x00	; 0
   106B 00                 1554 	.db #0x00	; 0
   106C 00                 1555 	.db #0x00	; 0
   106D 00                 1556 	.db #0x00	; 0
   106E 00                 1557 	.db #0x00	; 0
   106F 00                 1558 	.db #0x00	; 0
   1070                    1559 _g_newtiles_140:
   1070 00                 1560 	.db #0x00	; 0
   1071 00                 1561 	.db #0x00	; 0
   1072 00                 1562 	.db #0x00	; 0
   1073 00                 1563 	.db #0x00	; 0
   1074 00                 1564 	.db #0x00	; 0
   1075 00                 1565 	.db #0x00	; 0
   1076 00                 1566 	.db #0x00	; 0
   1077 00                 1567 	.db #0x00	; 0
   1078                    1568 _g_newtiles_141:
   1078 00                 1569 	.db #0x00	; 0
   1079 00                 1570 	.db #0x00	; 0
   107A 00                 1571 	.db #0x00	; 0
   107B 00                 1572 	.db #0x00	; 0
   107C 00                 1573 	.db #0x00	; 0
   107D 00                 1574 	.db #0x00	; 0
   107E 00                 1575 	.db #0x00	; 0
   107F 00                 1576 	.db #0x00	; 0
   1080                    1577 _g_newtiles_142:
   1080 00                 1578 	.db #0x00	; 0
   1081 00                 1579 	.db #0x00	; 0
   1082 00                 1580 	.db #0x00	; 0
   1083 00                 1581 	.db #0x00	; 0
   1084 00                 1582 	.db #0x00	; 0
   1085 00                 1583 	.db #0x00	; 0
   1086 00                 1584 	.db #0x00	; 0
   1087 00                 1585 	.db #0x00	; 0
   1088                    1586 _g_newtiles_143:
   1088 00                 1587 	.db #0x00	; 0
   1089 00                 1588 	.db #0x00	; 0
   108A 00                 1589 	.db #0x00	; 0
   108B 00                 1590 	.db #0x00	; 0
   108C 00                 1591 	.db #0x00	; 0
   108D 00                 1592 	.db #0x00	; 0
   108E 00                 1593 	.db #0x00	; 0
   108F 00                 1594 	.db #0x00	; 0
   1090                    1595 _g_newtiles_144:
   1090 00                 1596 	.db #0x00	; 0
   1091 00                 1597 	.db #0x00	; 0
   1092 00                 1598 	.db #0x00	; 0
   1093 00                 1599 	.db #0x00	; 0
   1094 00                 1600 	.db #0x00	; 0
   1095 00                 1601 	.db #0x00	; 0
   1096 00                 1602 	.db #0x00	; 0
   1097 00                 1603 	.db #0x00	; 0
   1098                    1604 _g_newtiles_145:
   1098 00                 1605 	.db #0x00	; 0
   1099 00                 1606 	.db #0x00	; 0
   109A 00                 1607 	.db #0x00	; 0
   109B 00                 1608 	.db #0x00	; 0
   109C 00                 1609 	.db #0x00	; 0
   109D 00                 1610 	.db #0x00	; 0
   109E 00                 1611 	.db #0x00	; 0
   109F 00                 1612 	.db #0x00	; 0
   10A0                    1613 _g_newtiles_146:
   10A0 CC                 1614 	.db #0xcc	; 204
   10A1 C0                 1615 	.db #0xc0	; 192
   10A2 DD                 1616 	.db #0xdd	; 221
   10A3 C0                 1617 	.db #0xc0	; 192
   10A4 EE                 1618 	.db #0xee	; 238
   10A5 C0                 1619 	.db #0xc0	; 192
   10A6 FF                 1620 	.db #0xff	; 255
   10A7 C0                 1621 	.db #0xc0	; 192
   10A8                    1622 _g_newtiles_147:
   10A8 00                 1623 	.db #0x00	; 0
   10A9 00                 1624 	.db #0x00	; 0
   10AA 00                 1625 	.db #0x00	; 0
   10AB 00                 1626 	.db #0x00	; 0
   10AC 00                 1627 	.db #0x00	; 0
   10AD 00                 1628 	.db #0x00	; 0
   10AE 00                 1629 	.db #0x00	; 0
   10AF 00                 1630 	.db #0x00	; 0
   10B0                    1631 _g_newtiles_148:
   10B0 00                 1632 	.db #0x00	; 0
   10B1 00                 1633 	.db #0x00	; 0
   10B2 00                 1634 	.db #0x00	; 0
   10B3 00                 1635 	.db #0x00	; 0
   10B4 00                 1636 	.db #0x00	; 0
   10B5 00                 1637 	.db #0x00	; 0
   10B6 00                 1638 	.db #0x00	; 0
   10B7 00                 1639 	.db #0x00	; 0
   10B8                    1640 _g_newtiles_149:
   10B8 CF                 1641 	.db #0xcf	; 207
   10B9 CD                 1642 	.db #0xcd	; 205
   10BA CF                 1643 	.db #0xcf	; 207
   10BB CD                 1644 	.db #0xcd	; 205
   10BC EE                 1645 	.db #0xee	; 238
   10BD EF                 1646 	.db #0xef	; 239
   10BE FF                 1647 	.db #0xff	; 255
   10BF FF                 1648 	.db #0xff	; 255
   10C0                    1649 _g_newtiles_150:
   10C0 CF                 1650 	.db #0xcf	; 207
   10C1 CF                 1651 	.db #0xcf	; 207
   10C2 CF                 1652 	.db #0xcf	; 207
   10C3 CF                 1653 	.db #0xcf	; 207
   10C4 CF                 1654 	.db #0xcf	; 207
   10C5 CF                 1655 	.db #0xcf	; 207
   10C6 CF                 1656 	.db #0xcf	; 207
   10C7 CF                 1657 	.db #0xcf	; 207
   10C8                    1658 _g_newtiles_151:
   10C8 CE                 1659 	.db #0xce	; 206
   10C9 CF                 1660 	.db #0xcf	; 207
   10CA CE                 1661 	.db #0xce	; 206
   10CB CF                 1662 	.db #0xcf	; 207
   10CC DF                 1663 	.db #0xdf	; 223
   10CD DD                 1664 	.db #0xdd	; 221
   10CE FF                 1665 	.db #0xff	; 255
   10CF FF                 1666 	.db #0xff	; 255
   10D0                    1667 _g_newtiles_152:
   10D0 00                 1668 	.db #0x00	; 0
   10D1 00                 1669 	.db #0x00	; 0
   10D2 00                 1670 	.db #0x00	; 0
   10D3 00                 1671 	.db #0x00	; 0
   10D4 00                 1672 	.db #0x00	; 0
   10D5 00                 1673 	.db #0x00	; 0
   10D6 00                 1674 	.db #0x00	; 0
   10D7 00                 1675 	.db #0x00	; 0
   10D8                    1676 _g_newtiles_153:
   10D8 00                 1677 	.db #0x00	; 0
   10D9 00                 1678 	.db #0x00	; 0
   10DA 00                 1679 	.db #0x00	; 0
   10DB 00                 1680 	.db #0x00	; 0
   10DC 00                 1681 	.db #0x00	; 0
   10DD 00                 1682 	.db #0x00	; 0
   10DE 00                 1683 	.db #0x00	; 0
   10DF 00                 1684 	.db #0x00	; 0
   10E0                    1685 _g_newtiles_154:
   10E0 00                 1686 	.db #0x00	; 0
   10E1 00                 1687 	.db #0x00	; 0
   10E2 00                 1688 	.db #0x00	; 0
   10E3 00                 1689 	.db #0x00	; 0
   10E4 00                 1690 	.db #0x00	; 0
   10E5 00                 1691 	.db #0x00	; 0
   10E6 00                 1692 	.db #0x00	; 0
   10E7 00                 1693 	.db #0x00	; 0
   10E8                    1694 _g_newtiles_155:
   10E8 00                 1695 	.db #0x00	; 0
   10E9 00                 1696 	.db #0x00	; 0
   10EA 00                 1697 	.db #0x00	; 0
   10EB 00                 1698 	.db #0x00	; 0
   10EC 00                 1699 	.db #0x00	; 0
   10ED 00                 1700 	.db #0x00	; 0
   10EE 00                 1701 	.db #0x00	; 0
   10EF 00                 1702 	.db #0x00	; 0
   10F0                    1703 _g_newtiles_156:
   10F0 00                 1704 	.db #0x00	; 0
   10F1 00                 1705 	.db #0x00	; 0
   10F2 00                 1706 	.db #0x00	; 0
   10F3 00                 1707 	.db #0x00	; 0
   10F4 00                 1708 	.db #0x00	; 0
   10F5 00                 1709 	.db #0x00	; 0
   10F6 00                 1710 	.db #0x00	; 0
   10F7 00                 1711 	.db #0x00	; 0
   10F8                    1712 _g_newtiles_157:
   10F8 00                 1713 	.db #0x00	; 0
   10F9 00                 1714 	.db #0x00	; 0
   10FA 00                 1715 	.db #0x00	; 0
   10FB 00                 1716 	.db #0x00	; 0
   10FC 00                 1717 	.db #0x00	; 0
   10FD 00                 1718 	.db #0x00	; 0
   10FE 00                 1719 	.db #0x00	; 0
   10FF 00                 1720 	.db #0x00	; 0
   1100                    1721 _g_newtiles_158:
   1100 00                 1722 	.db #0x00	; 0
   1101 00                 1723 	.db #0x00	; 0
   1102 00                 1724 	.db #0x00	; 0
   1103 00                 1725 	.db #0x00	; 0
   1104 00                 1726 	.db #0x00	; 0
   1105 00                 1727 	.db #0x00	; 0
   1106 00                 1728 	.db #0x00	; 0
   1107 00                 1729 	.db #0x00	; 0
   1108                    1730 _g_newtiles_159:
   1108 00                 1731 	.db #0x00	; 0
   1109 00                 1732 	.db #0x00	; 0
   110A 00                 1733 	.db #0x00	; 0
   110B 00                 1734 	.db #0x00	; 0
   110C 00                 1735 	.db #0x00	; 0
   110D 00                 1736 	.db #0x00	; 0
   110E 00                 1737 	.db #0x00	; 0
   110F 00                 1738 	.db #0x00	; 0
   1110                    1739 _g_newtiles_160:
   1110 00                 1740 	.db #0x00	; 0
   1111 00                 1741 	.db #0x00	; 0
   1112 00                 1742 	.db #0x00	; 0
   1113 00                 1743 	.db #0x00	; 0
   1114 00                 1744 	.db #0x00	; 0
   1115 00                 1745 	.db #0x00	; 0
   1116 00                 1746 	.db #0x00	; 0
   1117 00                 1747 	.db #0x00	; 0
   1118                    1748 _g_newtiles_161:
   1118 00                 1749 	.db #0x00	; 0
   1119 00                 1750 	.db #0x00	; 0
   111A 00                 1751 	.db #0x00	; 0
   111B 00                 1752 	.db #0x00	; 0
   111C 00                 1753 	.db #0x00	; 0
   111D 00                 1754 	.db #0x00	; 0
   111E 00                 1755 	.db #0x00	; 0
   111F 00                 1756 	.db #0x00	; 0
   1120                    1757 _g_newtiles_162:
   1120 00                 1758 	.db #0x00	; 0
   1121 00                 1759 	.db #0x00	; 0
   1122 00                 1760 	.db #0x00	; 0
   1123 00                 1761 	.db #0x00	; 0
   1124 00                 1762 	.db #0x00	; 0
   1125 00                 1763 	.db #0x00	; 0
   1126 00                 1764 	.db #0x00	; 0
   1127 00                 1765 	.db #0x00	; 0
   1128                    1766 _g_newtiles_163:
   1128 00                 1767 	.db #0x00	; 0
   1129 00                 1768 	.db #0x00	; 0
   112A 00                 1769 	.db #0x00	; 0
   112B 00                 1770 	.db #0x00	; 0
   112C 00                 1771 	.db #0x00	; 0
   112D 00                 1772 	.db #0x00	; 0
   112E 00                 1773 	.db #0x00	; 0
   112F 00                 1774 	.db #0x00	; 0
   1130                    1775 _g_newtiles_164:
   1130 00                 1776 	.db #0x00	; 0
   1131 00                 1777 	.db #0x00	; 0
   1132 00                 1778 	.db #0x00	; 0
   1133 00                 1779 	.db #0x00	; 0
   1134 00                 1780 	.db #0x00	; 0
   1135 00                 1781 	.db #0x00	; 0
   1136 00                 1782 	.db #0x00	; 0
   1137 00                 1783 	.db #0x00	; 0
   1138                    1784 _g_newtiles_165:
   1138 00                 1785 	.db #0x00	; 0
   1139 00                 1786 	.db #0x00	; 0
   113A 00                 1787 	.db #0x00	; 0
   113B 00                 1788 	.db #0x00	; 0
   113C 00                 1789 	.db #0x00	; 0
   113D 00                 1790 	.db #0x00	; 0
   113E 00                 1791 	.db #0x00	; 0
   113F 00                 1792 	.db #0x00	; 0
   1140                    1793 _g_newtiles_166:
   1140 CD                 1794 	.db #0xcd	; 205
   1141 CE                 1795 	.db #0xce	; 206
   1142 C8                 1796 	.db #0xc8	; 200
   1143 C4                 1797 	.db #0xc4	; 196
   1144 C8                 1798 	.db #0xc8	; 200
   1145 C4                 1799 	.db #0xc4	; 196
   1146 C8                 1800 	.db #0xc8	; 200
   1147 C4                 1801 	.db #0xc4	; 196
   1148                    1802 _g_newtiles_167:
   1148 00                 1803 	.db #0x00	; 0
   1149 00                 1804 	.db #0x00	; 0
   114A 00                 1805 	.db #0x00	; 0
   114B 00                 1806 	.db #0x00	; 0
   114C 00                 1807 	.db #0x00	; 0
   114D 00                 1808 	.db #0x00	; 0
   114E 00                 1809 	.db #0x00	; 0
   114F 00                 1810 	.db #0x00	; 0
   1150                    1811 _g_newtiles_168:
   1150 00                 1812 	.db #0x00	; 0
   1151 00                 1813 	.db #0x00	; 0
   1152 00                 1814 	.db #0x00	; 0
   1153 00                 1815 	.db #0x00	; 0
   1154 00                 1816 	.db #0x00	; 0
   1155 00                 1817 	.db #0x00	; 0
   1156 00                 1818 	.db #0x00	; 0
   1157 00                 1819 	.db #0x00	; 0
   1158                    1820 _g_newtiles_169:
   1158 00                 1821 	.db #0x00	; 0
   1159 00                 1822 	.db #0x00	; 0
   115A 00                 1823 	.db #0x00	; 0
   115B 00                 1824 	.db #0x00	; 0
   115C 00                 1825 	.db #0x00	; 0
   115D 00                 1826 	.db #0x00	; 0
   115E 00                 1827 	.db #0x00	; 0
   115F 00                 1828 	.db #0x00	; 0
   1160                    1829 _g_newtiles_170:
   1160 00                 1830 	.db #0x00	; 0
   1161 00                 1831 	.db #0x00	; 0
   1162 00                 1832 	.db #0x00	; 0
   1163 00                 1833 	.db #0x00	; 0
   1164 00                 1834 	.db #0x00	; 0
   1165 00                 1835 	.db #0x00	; 0
   1166 00                 1836 	.db #0x00	; 0
   1167 00                 1837 	.db #0x00	; 0
   1168                    1838 _g_newtiles_171:
   1168 00                 1839 	.db #0x00	; 0
   1169 00                 1840 	.db #0x00	; 0
   116A 00                 1841 	.db #0x00	; 0
   116B 00                 1842 	.db #0x00	; 0
   116C 00                 1843 	.db #0x00	; 0
   116D 00                 1844 	.db #0x00	; 0
   116E 00                 1845 	.db #0x00	; 0
   116F 00                 1846 	.db #0x00	; 0
   1170                    1847 _g_newtiles_172:
   1170 00                 1848 	.db #0x00	; 0
   1171 00                 1849 	.db #0x00	; 0
   1172 00                 1850 	.db #0x00	; 0
   1173 00                 1851 	.db #0x00	; 0
   1174 00                 1852 	.db #0x00	; 0
   1175 00                 1853 	.db #0x00	; 0
   1176 00                 1854 	.db #0x00	; 0
   1177 00                 1855 	.db #0x00	; 0
   1178                    1856 _g_newtiles_173:
   1178 00                 1857 	.db #0x00	; 0
   1179 00                 1858 	.db #0x00	; 0
   117A 00                 1859 	.db #0x00	; 0
   117B 00                 1860 	.db #0x00	; 0
   117C 00                 1861 	.db #0x00	; 0
   117D 00                 1862 	.db #0x00	; 0
   117E 00                 1863 	.db #0x00	; 0
   117F 00                 1864 	.db #0x00	; 0
   1180                    1865 _g_newtiles_174:
   1180 00                 1866 	.db #0x00	; 0
   1181 00                 1867 	.db #0x00	; 0
   1182 00                 1868 	.db #0x00	; 0
   1183 00                 1869 	.db #0x00	; 0
   1184 00                 1870 	.db #0x00	; 0
   1185 00                 1871 	.db #0x00	; 0
   1186 00                 1872 	.db #0x00	; 0
   1187 00                 1873 	.db #0x00	; 0
   1188                    1874 _g_newtiles_175:
   1188 00                 1875 	.db #0x00	; 0
   1189 00                 1876 	.db #0x00	; 0
   118A 00                 1877 	.db #0x00	; 0
   118B 00                 1878 	.db #0x00	; 0
   118C 00                 1879 	.db #0x00	; 0
   118D 00                 1880 	.db #0x00	; 0
   118E 00                 1881 	.db #0x00	; 0
   118F 00                 1882 	.db #0x00	; 0
   1190                    1883 _g_newtiles_176:
   1190 00                 1884 	.db #0x00	; 0
   1191 00                 1885 	.db #0x00	; 0
   1192 00                 1886 	.db #0x00	; 0
   1193 00                 1887 	.db #0x00	; 0
   1194 00                 1888 	.db #0x00	; 0
   1195 00                 1889 	.db #0x00	; 0
   1196 00                 1890 	.db #0x00	; 0
   1197 00                 1891 	.db #0x00	; 0
   1198                    1892 _g_newtiles_177:
   1198 00                 1893 	.db #0x00	; 0
   1199 00                 1894 	.db #0x00	; 0
   119A 00                 1895 	.db #0x00	; 0
   119B 00                 1896 	.db #0x00	; 0
   119C 00                 1897 	.db #0x00	; 0
   119D 00                 1898 	.db #0x00	; 0
   119E 00                 1899 	.db #0x00	; 0
   119F 00                 1900 	.db #0x00	; 0
   11A0                    1901 _g_newtiles_178:
   11A0 00                 1902 	.db #0x00	; 0
   11A1 00                 1903 	.db #0x00	; 0
   11A2 00                 1904 	.db #0x00	; 0
   11A3 00                 1905 	.db #0x00	; 0
   11A4 00                 1906 	.db #0x00	; 0
   11A5 00                 1907 	.db #0x00	; 0
   11A6 00                 1908 	.db #0x00	; 0
   11A7 00                 1909 	.db #0x00	; 0
   11A8                    1910 _g_newtiles_179:
   11A8 00                 1911 	.db #0x00	; 0
   11A9 00                 1912 	.db #0x00	; 0
   11AA 00                 1913 	.db #0x00	; 0
   11AB 00                 1914 	.db #0x00	; 0
   11AC 00                 1915 	.db #0x00	; 0
   11AD 00                 1916 	.db #0x00	; 0
   11AE 00                 1917 	.db #0x00	; 0
   11AF 00                 1918 	.db #0x00	; 0
   11B0                    1919 _g_newtiles_180:
   11B0 00                 1920 	.db #0x00	; 0
   11B1 00                 1921 	.db #0x00	; 0
   11B2 00                 1922 	.db #0x00	; 0
   11B3 00                 1923 	.db #0x00	; 0
   11B4 00                 1924 	.db #0x00	; 0
   11B5 00                 1925 	.db #0x00	; 0
   11B6 00                 1926 	.db #0x00	; 0
   11B7 00                 1927 	.db #0x00	; 0
   11B8                    1928 _g_newtiles_181:
   11B8 C8                 1929 	.db #0xc8	; 200
   11B9 C4                 1930 	.db #0xc4	; 196
   11BA C8                 1931 	.db #0xc8	; 200
   11BB C4                 1932 	.db #0xc4	; 196
   11BC C8                 1933 	.db #0xc8	; 200
   11BD C4                 1934 	.db #0xc4	; 196
   11BE C8                 1935 	.db #0xc8	; 200
   11BF C4                 1936 	.db #0xc4	; 196
   11C0                    1937 _g_newtiles_182:
   11C0 C8                 1938 	.db #0xc8	; 200
   11C1 C4                 1939 	.db #0xc4	; 196
   11C2 EA                 1940 	.db #0xea	; 234
   11C3 C4                 1941 	.db #0xc4	; 196
   11C4 C8                 1942 	.db #0xc8	; 200
   11C5 C4                 1943 	.db #0xc4	; 196
   11C6 EA                 1944 	.db #0xea	; 234
   11C7 D5                 1945 	.db #0xd5	; 213
   11C8                    1946 _g_newtiles_183:
   11C8 00                 1947 	.db #0x00	; 0
   11C9 00                 1948 	.db #0x00	; 0
   11CA 00                 1949 	.db #0x00	; 0
   11CB 00                 1950 	.db #0x00	; 0
   11CC 00                 1951 	.db #0x00	; 0
   11CD 00                 1952 	.db #0x00	; 0
   11CE 00                 1953 	.db #0x00	; 0
   11CF 00                 1954 	.db #0x00	; 0
   11D0                    1955 _g_newtiles_184:
   11D0 00                 1956 	.db #0x00	; 0
   11D1 00                 1957 	.db #0x00	; 0
   11D2 00                 1958 	.db #0x00	; 0
   11D3 00                 1959 	.db #0x00	; 0
   11D4 00                 1960 	.db #0x00	; 0
   11D5 00                 1961 	.db #0x00	; 0
   11D6 00                 1962 	.db #0x00	; 0
   11D7 00                 1963 	.db #0x00	; 0
   11D8                    1964 _g_newtiles_185:
   11D8 00                 1965 	.db #0x00	; 0
   11D9 00                 1966 	.db #0x00	; 0
   11DA 00                 1967 	.db #0x00	; 0
   11DB 00                 1968 	.db #0x00	; 0
   11DC 00                 1969 	.db #0x00	; 0
   11DD 00                 1970 	.db #0x00	; 0
   11DE 00                 1971 	.db #0x00	; 0
   11DF 00                 1972 	.db #0x00	; 0
   11E0                    1973 _g_newtiles_186:
   11E0 00                 1974 	.db #0x00	; 0
   11E1 00                 1975 	.db #0x00	; 0
   11E2 00                 1976 	.db #0x00	; 0
   11E3 00                 1977 	.db #0x00	; 0
   11E4 00                 1978 	.db #0x00	; 0
   11E5 00                 1979 	.db #0x00	; 0
   11E6 00                 1980 	.db #0x00	; 0
   11E7 00                 1981 	.db #0x00	; 0
   11E8                    1982 _g_newtiles_187:
   11E8 00                 1983 	.db #0x00	; 0
   11E9 00                 1984 	.db #0x00	; 0
   11EA 00                 1985 	.db #0x00	; 0
   11EB 00                 1986 	.db #0x00	; 0
   11EC 00                 1987 	.db #0x00	; 0
   11ED 00                 1988 	.db #0x00	; 0
   11EE 00                 1989 	.db #0x00	; 0
   11EF 00                 1990 	.db #0x00	; 0
   11F0                    1991 _g_newtiles_188:
   11F0 00                 1992 	.db #0x00	; 0
   11F1 00                 1993 	.db #0x00	; 0
   11F2 00                 1994 	.db #0x00	; 0
   11F3 00                 1995 	.db #0x00	; 0
   11F4 00                 1996 	.db #0x00	; 0
   11F5 00                 1997 	.db #0x00	; 0
   11F6 00                 1998 	.db #0x00	; 0
   11F7 00                 1999 	.db #0x00	; 0
   11F8                    2000 _g_newtiles_189:
   11F8 00                 2001 	.db #0x00	; 0
   11F9 00                 2002 	.db #0x00	; 0
   11FA 00                 2003 	.db #0x00	; 0
   11FB 00                 2004 	.db #0x00	; 0
   11FC 00                 2005 	.db #0x00	; 0
   11FD 00                 2006 	.db #0x00	; 0
   11FE 00                 2007 	.db #0x00	; 0
   11FF 00                 2008 	.db #0x00	; 0
   1200                    2009 _g_newtiles_190:
   1200 00                 2010 	.db #0x00	; 0
   1201 00                 2011 	.db #0x00	; 0
   1202 00                 2012 	.db #0x00	; 0
   1203 00                 2013 	.db #0x00	; 0
   1204 00                 2014 	.db #0x00	; 0
   1205 00                 2015 	.db #0x00	; 0
   1206 00                 2016 	.db #0x00	; 0
   1207 00                 2017 	.db #0x00	; 0
   1208                    2018 _g_newtiles_191:
   1208 00                 2019 	.db #0x00	; 0
   1209 00                 2020 	.db #0x00	; 0
   120A 00                 2021 	.db #0x00	; 0
   120B 00                 2022 	.db #0x00	; 0
   120C 00                 2023 	.db #0x00	; 0
   120D 00                 2024 	.db #0x00	; 0
   120E 00                 2025 	.db #0x00	; 0
   120F 00                 2026 	.db #0x00	; 0
   1210                    2027 _g_newtiles_192:
   1210 00                 2028 	.db #0x00	; 0
   1211 00                 2029 	.db #0x00	; 0
   1212 00                 2030 	.db #0x00	; 0
   1213 00                 2031 	.db #0x00	; 0
   1214 00                 2032 	.db #0x00	; 0
   1215 00                 2033 	.db #0x00	; 0
   1216 00                 2034 	.db #0x00	; 0
   1217 00                 2035 	.db #0x00	; 0
   1218                    2036 _g_newtiles_193:
   1218 00                 2037 	.db #0x00	; 0
   1219 00                 2038 	.db #0x00	; 0
   121A 00                 2039 	.db #0x00	; 0
   121B 00                 2040 	.db #0x00	; 0
   121C 00                 2041 	.db #0x00	; 0
   121D 00                 2042 	.db #0x00	; 0
   121E 00                 2043 	.db #0x00	; 0
   121F 00                 2044 	.db #0x00	; 0
   1220                    2045 _g_newtiles_194:
   1220 00                 2046 	.db #0x00	; 0
   1221 00                 2047 	.db #0x00	; 0
   1222 00                 2048 	.db #0x00	; 0
   1223 00                 2049 	.db #0x00	; 0
   1224 00                 2050 	.db #0x00	; 0
   1225 00                 2051 	.db #0x00	; 0
   1226 00                 2052 	.db #0x00	; 0
   1227 00                 2053 	.db #0x00	; 0
   1228                    2054 _g_newtiles_195:
   1228 00                 2055 	.db #0x00	; 0
   1229 00                 2056 	.db #0x00	; 0
   122A 00                 2057 	.db #0x00	; 0
   122B 00                 2058 	.db #0x00	; 0
   122C 00                 2059 	.db #0x00	; 0
   122D 00                 2060 	.db #0x00	; 0
   122E 00                 2061 	.db #0x00	; 0
   122F 00                 2062 	.db #0x00	; 0
   1230                    2063 _g_newtiles_196:
   1230 00                 2064 	.db #0x00	; 0
   1231 00                 2065 	.db #0x00	; 0
   1232 00                 2066 	.db #0x00	; 0
   1233 00                 2067 	.db #0x00	; 0
   1234 00                 2068 	.db #0x00	; 0
   1235 00                 2069 	.db #0x00	; 0
   1236 00                 2070 	.db #0x00	; 0
   1237 00                 2071 	.db #0x00	; 0
   1238                    2072 _g_newtiles_197:
   1238 00                 2073 	.db #0x00	; 0
   1239 00                 2074 	.db #0x00	; 0
   123A 00                 2075 	.db #0x00	; 0
   123B 00                 2076 	.db #0x00	; 0
   123C 00                 2077 	.db #0x00	; 0
   123D 00                 2078 	.db #0x00	; 0
   123E 00                 2079 	.db #0x00	; 0
   123F 00                 2080 	.db #0x00	; 0
   1240                    2081 _g_newtiles_198:
   1240 CD                 2082 	.db #0xcd	; 205
   1241 CE                 2083 	.db #0xce	; 206
   1242 EA                 2084 	.db #0xea	; 234
   1243 C4                 2085 	.db #0xc4	; 196
   1244 C8                 2086 	.db #0xc8	; 200
   1245 C4                 2087 	.db #0xc4	; 196
   1246 EF                 2088 	.db #0xef	; 239
   1247 DF                 2089 	.db #0xdf	; 223
   1248                    2090 _g_newtiles_199:
   1248 00                 2091 	.db #0x00	; 0
   1249 00                 2092 	.db #0x00	; 0
   124A 00                 2093 	.db #0x00	; 0
   124B 00                 2094 	.db #0x00	; 0
   124C 00                 2095 	.db #0x00	; 0
   124D 00                 2096 	.db #0x00	; 0
   124E 00                 2097 	.db #0x00	; 0
   124F 00                 2098 	.db #0x00	; 0
   1250                    2099 _g_newtiles_200:
   1250 00                 2100 	.db #0x00	; 0
   1251 00                 2101 	.db #0x00	; 0
   1252 00                 2102 	.db #0x00	; 0
   1253 00                 2103 	.db #0x00	; 0
   1254 00                 2104 	.db #0x00	; 0
   1255 00                 2105 	.db #0x00	; 0
   1256 00                 2106 	.db #0x00	; 0
   1257 00                 2107 	.db #0x00	; 0
   1258                    2108 _g_newtiles_201:
   1258 00                 2109 	.db #0x00	; 0
   1259 00                 2110 	.db #0x00	; 0
   125A 00                 2111 	.db #0x00	; 0
   125B 00                 2112 	.db #0x00	; 0
   125C 00                 2113 	.db #0x00	; 0
   125D 00                 2114 	.db #0x00	; 0
   125E 00                 2115 	.db #0x00	; 0
   125F 00                 2116 	.db #0x00	; 0
   1260                    2117 _g_newtiles_202:
   1260 00                 2118 	.db #0x00	; 0
   1261 00                 2119 	.db #0x00	; 0
   1262 00                 2120 	.db #0x00	; 0
   1263 00                 2121 	.db #0x00	; 0
   1264 00                 2122 	.db #0x00	; 0
   1265 00                 2123 	.db #0x00	; 0
   1266 00                 2124 	.db #0x00	; 0
   1267 00                 2125 	.db #0x00	; 0
   1268                    2126 _g_newtiles_203:
   1268 00                 2127 	.db #0x00	; 0
   1269 00                 2128 	.db #0x00	; 0
   126A 00                 2129 	.db #0x00	; 0
   126B 00                 2130 	.db #0x00	; 0
   126C 00                 2131 	.db #0x00	; 0
   126D 00                 2132 	.db #0x00	; 0
   126E 00                 2133 	.db #0x00	; 0
   126F 00                 2134 	.db #0x00	; 0
   1270                    2135 _g_newtiles_204:
   1270 00                 2136 	.db #0x00	; 0
   1271 00                 2137 	.db #0x00	; 0
   1272 00                 2138 	.db #0x00	; 0
   1273 00                 2139 	.db #0x00	; 0
   1274 00                 2140 	.db #0x00	; 0
   1275 00                 2141 	.db #0x00	; 0
   1276 00                 2142 	.db #0x00	; 0
   1277 00                 2143 	.db #0x00	; 0
   1278                    2144 _g_newtiles_205:
   1278 00                 2145 	.db #0x00	; 0
   1279 00                 2146 	.db #0x00	; 0
   127A 00                 2147 	.db #0x00	; 0
   127B 00                 2148 	.db #0x00	; 0
   127C 00                 2149 	.db #0x00	; 0
   127D 00                 2150 	.db #0x00	; 0
   127E 00                 2151 	.db #0x00	; 0
   127F 00                 2152 	.db #0x00	; 0
   1280                    2153 _g_newtiles_206:
   1280 00                 2154 	.db #0x00	; 0
   1281 00                 2155 	.db #0x00	; 0
   1282 00                 2156 	.db #0x00	; 0
   1283 00                 2157 	.db #0x00	; 0
   1284 00                 2158 	.db #0x00	; 0
   1285 00                 2159 	.db #0x00	; 0
   1286 00                 2160 	.db #0x00	; 0
   1287 00                 2161 	.db #0x00	; 0
   1288                    2162 _g_newtiles_207:
   1288 00                 2163 	.db #0x00	; 0
   1289 00                 2164 	.db #0x00	; 0
   128A 00                 2165 	.db #0x00	; 0
   128B 00                 2166 	.db #0x00	; 0
   128C 00                 2167 	.db #0x00	; 0
   128D 00                 2168 	.db #0x00	; 0
   128E 00                 2169 	.db #0x00	; 0
   128F 00                 2170 	.db #0x00	; 0
   1290                    2171 _g_newtiles_208:
   1290 00                 2172 	.db #0x00	; 0
   1291 00                 2173 	.db #0x00	; 0
   1292 00                 2174 	.db #0x00	; 0
   1293 00                 2175 	.db #0x00	; 0
   1294 00                 2176 	.db #0x00	; 0
   1295 00                 2177 	.db #0x00	; 0
   1296 00                 2178 	.db #0x00	; 0
   1297 00                 2179 	.db #0x00	; 0
   1298                    2180 _g_newtiles_209:
   1298 00                 2181 	.db #0x00	; 0
   1299 00                 2182 	.db #0x00	; 0
   129A 00                 2183 	.db #0x00	; 0
   129B 00                 2184 	.db #0x00	; 0
   129C 00                 2185 	.db #0x00	; 0
   129D 00                 2186 	.db #0x00	; 0
   129E 00                 2187 	.db #0x00	; 0
   129F 00                 2188 	.db #0x00	; 0
   12A0                    2189 _g_newtiles_210:
   12A0 00                 2190 	.db #0x00	; 0
   12A1 00                 2191 	.db #0x00	; 0
   12A2 00                 2192 	.db #0x00	; 0
   12A3 00                 2193 	.db #0x00	; 0
   12A4 00                 2194 	.db #0x00	; 0
   12A5 00                 2195 	.db #0x00	; 0
   12A6 00                 2196 	.db #0x00	; 0
   12A7 00                 2197 	.db #0x00	; 0
   12A8                    2198 _g_newtiles_211:
   12A8 00                 2199 	.db #0x00	; 0
   12A9 00                 2200 	.db #0x00	; 0
   12AA 00                 2201 	.db #0x00	; 0
   12AB 00                 2202 	.db #0x00	; 0
   12AC 00                 2203 	.db #0x00	; 0
   12AD 00                 2204 	.db #0x00	; 0
   12AE 00                 2205 	.db #0x00	; 0
   12AF 00                 2206 	.db #0x00	; 0
   12B0                    2207 _g_newtiles_212:
   12B0 00                 2208 	.db #0x00	; 0
   12B1 00                 2209 	.db #0x00	; 0
   12B2 00                 2210 	.db #0x00	; 0
   12B3 00                 2211 	.db #0x00	; 0
   12B4 00                 2212 	.db #0x00	; 0
   12B5 00                 2213 	.db #0x00	; 0
   12B6 00                 2214 	.db #0x00	; 0
   12B7 00                 2215 	.db #0x00	; 0
   12B8                    2216 _g_newtiles_213:
   12B8 00                 2217 	.db #0x00	; 0
   12B9 00                 2218 	.db #0x00	; 0
   12BA 00                 2219 	.db #0x00	; 0
   12BB 00                 2220 	.db #0x00	; 0
   12BC 00                 2221 	.db #0x00	; 0
   12BD 00                 2222 	.db #0x00	; 0
   12BE 00                 2223 	.db #0x00	; 0
   12BF 00                 2224 	.db #0x00	; 0
   12C0                    2225 _g_newtiles_214:
   12C0 00                 2226 	.db #0x00	; 0
   12C1 00                 2227 	.db #0x00	; 0
   12C2 00                 2228 	.db #0x00	; 0
   12C3 00                 2229 	.db #0x00	; 0
   12C4 00                 2230 	.db #0x00	; 0
   12C5 00                 2231 	.db #0x00	; 0
   12C6 00                 2232 	.db #0x00	; 0
   12C7 00                 2233 	.db #0x00	; 0
   12C8                    2234 _g_newtiles_215:
   12C8 00                 2235 	.db #0x00	; 0
   12C9 00                 2236 	.db #0x00	; 0
   12CA 00                 2237 	.db #0x00	; 0
   12CB 00                 2238 	.db #0x00	; 0
   12CC 00                 2239 	.db #0x00	; 0
   12CD 00                 2240 	.db #0x00	; 0
   12CE 00                 2241 	.db #0x00	; 0
   12CF 00                 2242 	.db #0x00	; 0
   12D0                    2243 _g_newtiles_216:
   12D0 00                 2244 	.db #0x00	; 0
   12D1 00                 2245 	.db #0x00	; 0
   12D2 00                 2246 	.db #0x00	; 0
   12D3 00                 2247 	.db #0x00	; 0
   12D4 00                 2248 	.db #0x00	; 0
   12D5 00                 2249 	.db #0x00	; 0
   12D6 00                 2250 	.db #0x00	; 0
   12D7 00                 2251 	.db #0x00	; 0
   12D8                    2252 _g_newtiles_217:
   12D8 00                 2253 	.db #0x00	; 0
   12D9 00                 2254 	.db #0x00	; 0
   12DA 00                 2255 	.db #0x00	; 0
   12DB 00                 2256 	.db #0x00	; 0
   12DC 00                 2257 	.db #0x00	; 0
   12DD 00                 2258 	.db #0x00	; 0
   12DE 00                 2259 	.db #0x00	; 0
   12DF 00                 2260 	.db #0x00	; 0
   12E0                    2261 _g_newtiles_218:
   12E0 00                 2262 	.db #0x00	; 0
   12E1 00                 2263 	.db #0x00	; 0
   12E2 00                 2264 	.db #0x00	; 0
   12E3 00                 2265 	.db #0x00	; 0
   12E4 00                 2266 	.db #0x00	; 0
   12E5 00                 2267 	.db #0x00	; 0
   12E6 00                 2268 	.db #0x00	; 0
   12E7 00                 2269 	.db #0x00	; 0
   12E8                    2270 _g_newtiles_219:
   12E8 00                 2271 	.db #0x00	; 0
   12E9 00                 2272 	.db #0x00	; 0
   12EA 00                 2273 	.db #0x00	; 0
   12EB 00                 2274 	.db #0x00	; 0
   12EC 00                 2275 	.db #0x00	; 0
   12ED 00                 2276 	.db #0x00	; 0
   12EE 00                 2277 	.db #0x00	; 0
   12EF 00                 2278 	.db #0x00	; 0
   12F0                    2279 _g_newtiles_220:
   12F0 00                 2280 	.db #0x00	; 0
   12F1 00                 2281 	.db #0x00	; 0
   12F2 00                 2282 	.db #0x00	; 0
   12F3 00                 2283 	.db #0x00	; 0
   12F4 00                 2284 	.db #0x00	; 0
   12F5 00                 2285 	.db #0x00	; 0
   12F6 00                 2286 	.db #0x00	; 0
   12F7 00                 2287 	.db #0x00	; 0
   12F8                    2288 _g_newtiles_221:
   12F8 00                 2289 	.db #0x00	; 0
   12F9 00                 2290 	.db #0x00	; 0
   12FA 00                 2291 	.db #0x00	; 0
   12FB 00                 2292 	.db #0x00	; 0
   12FC 00                 2293 	.db #0x00	; 0
   12FD 00                 2294 	.db #0x00	; 0
   12FE 00                 2295 	.db #0x00	; 0
   12FF 00                 2296 	.db #0x00	; 0
   1300                    2297 _g_newtiles_222:
   1300 00                 2298 	.db #0x00	; 0
   1301 00                 2299 	.db #0x00	; 0
   1302 00                 2300 	.db #0x00	; 0
   1303 00                 2301 	.db #0x00	; 0
   1304 00                 2302 	.db #0x00	; 0
   1305 00                 2303 	.db #0x00	; 0
   1306 00                 2304 	.db #0x00	; 0
   1307 00                 2305 	.db #0x00	; 0
   1308                    2306 _g_newtiles_223:
   1308 00                 2307 	.db #0x00	; 0
   1309 00                 2308 	.db #0x00	; 0
   130A 00                 2309 	.db #0x00	; 0
   130B 00                 2310 	.db #0x00	; 0
   130C 00                 2311 	.db #0x00	; 0
   130D 00                 2312 	.db #0x00	; 0
   130E 00                 2313 	.db #0x00	; 0
   130F 00                 2314 	.db #0x00	; 0
   1310                    2315 _g_newtiles_224:
   1310 00                 2316 	.db #0x00	; 0
   1311 00                 2317 	.db #0x00	; 0
   1312 00                 2318 	.db #0x00	; 0
   1313 00                 2319 	.db #0x00	; 0
   1314 00                 2320 	.db #0x00	; 0
   1315 00                 2321 	.db #0x00	; 0
   1316 00                 2322 	.db #0x00	; 0
   1317 00                 2323 	.db #0x00	; 0
   1318                    2324 _g_newtiles_225:
   1318 00                 2325 	.db #0x00	; 0
   1319 00                 2326 	.db #0x00	; 0
   131A 00                 2327 	.db #0x00	; 0
   131B 00                 2328 	.db #0x00	; 0
   131C 00                 2329 	.db #0x00	; 0
   131D 00                 2330 	.db #0x00	; 0
   131E 00                 2331 	.db #0x00	; 0
   131F 00                 2332 	.db #0x00	; 0
   1320                    2333 _g_newtiles_226:
   1320 00                 2334 	.db #0x00	; 0
   1321 00                 2335 	.db #0x00	; 0
   1322 00                 2336 	.db #0x00	; 0
   1323 00                 2337 	.db #0x00	; 0
   1324 00                 2338 	.db #0x00	; 0
   1325 00                 2339 	.db #0x00	; 0
   1326 00                 2340 	.db #0x00	; 0
   1327 00                 2341 	.db #0x00	; 0
   1328                    2342 _g_newtiles_227:
   1328 00                 2343 	.db #0x00	; 0
   1329 00                 2344 	.db #0x00	; 0
   132A 00                 2345 	.db #0x00	; 0
   132B 00                 2346 	.db #0x00	; 0
   132C 00                 2347 	.db #0x00	; 0
   132D 00                 2348 	.db #0x00	; 0
   132E 00                 2349 	.db #0x00	; 0
   132F 00                 2350 	.db #0x00	; 0
   1330                    2351 _g_newtiles_228:
   1330 00                 2352 	.db #0x00	; 0
   1331 00                 2353 	.db #0x00	; 0
   1332 00                 2354 	.db #0x00	; 0
   1333 00                 2355 	.db #0x00	; 0
   1334 00                 2356 	.db #0x00	; 0
   1335 00                 2357 	.db #0x00	; 0
   1336 00                 2358 	.db #0x00	; 0
   1337 00                 2359 	.db #0x00	; 0
   1338                    2360 _g_newtiles_229:
   1338 00                 2361 	.db #0x00	; 0
   1339 00                 2362 	.db #0x00	; 0
   133A 00                 2363 	.db #0x00	; 0
   133B 00                 2364 	.db #0x00	; 0
   133C 00                 2365 	.db #0x00	; 0
   133D 00                 2366 	.db #0x00	; 0
   133E 00                 2367 	.db #0x00	; 0
   133F 00                 2368 	.db #0x00	; 0
   1340                    2369 _g_newtiles_230:
   1340 00                 2370 	.db #0x00	; 0
   1341 00                 2371 	.db #0x00	; 0
   1342 00                 2372 	.db #0x00	; 0
   1343 00                 2373 	.db #0x00	; 0
   1344 00                 2374 	.db #0x00	; 0
   1345 00                 2375 	.db #0x00	; 0
   1346 00                 2376 	.db #0x00	; 0
   1347 00                 2377 	.db #0x00	; 0
   1348                    2378 _g_newtiles_231:
   1348 00                 2379 	.db #0x00	; 0
   1349 00                 2380 	.db #0x00	; 0
   134A 00                 2381 	.db #0x00	; 0
   134B 00                 2382 	.db #0x00	; 0
   134C 00                 2383 	.db #0x00	; 0
   134D 00                 2384 	.db #0x00	; 0
   134E 00                 2385 	.db #0x00	; 0
   134F 00                 2386 	.db #0x00	; 0
   1350                    2387 _g_newtiles_232:
   1350 00                 2388 	.db #0x00	; 0
   1351 00                 2389 	.db #0x00	; 0
   1352 00                 2390 	.db #0x00	; 0
   1353 00                 2391 	.db #0x00	; 0
   1354 00                 2392 	.db #0x00	; 0
   1355 00                 2393 	.db #0x00	; 0
   1356 00                 2394 	.db #0x00	; 0
   1357 00                 2395 	.db #0x00	; 0
   1358                    2396 _g_newtiles_233:
   1358 00                 2397 	.db #0x00	; 0
   1359 00                 2398 	.db #0x00	; 0
   135A 00                 2399 	.db #0x00	; 0
   135B 00                 2400 	.db #0x00	; 0
   135C 00                 2401 	.db #0x00	; 0
   135D 00                 2402 	.db #0x00	; 0
   135E 00                 2403 	.db #0x00	; 0
   135F 00                 2404 	.db #0x00	; 0
   1360                    2405 _g_newtiles_234:
   1360 00                 2406 	.db #0x00	; 0
   1361 00                 2407 	.db #0x00	; 0
   1362 00                 2408 	.db #0x00	; 0
   1363 00                 2409 	.db #0x00	; 0
   1364 00                 2410 	.db #0x00	; 0
   1365 00                 2411 	.db #0x00	; 0
   1366 00                 2412 	.db #0x00	; 0
   1367 00                 2413 	.db #0x00	; 0
   1368                    2414 _g_newtiles_235:
   1368 00                 2415 	.db #0x00	; 0
   1369 00                 2416 	.db #0x00	; 0
   136A 00                 2417 	.db #0x00	; 0
   136B 00                 2418 	.db #0x00	; 0
   136C 00                 2419 	.db #0x00	; 0
   136D 00                 2420 	.db #0x00	; 0
   136E 00                 2421 	.db #0x00	; 0
   136F 00                 2422 	.db #0x00	; 0
   1370                    2423 _g_newtiles_236:
   1370 00                 2424 	.db #0x00	; 0
   1371 00                 2425 	.db #0x00	; 0
   1372 00                 2426 	.db #0x00	; 0
   1373 00                 2427 	.db #0x00	; 0
   1374 00                 2428 	.db #0x00	; 0
   1375 00                 2429 	.db #0x00	; 0
   1376 00                 2430 	.db #0x00	; 0
   1377 00                 2431 	.db #0x00	; 0
   1378                    2432 _g_newtiles_237:
   1378 FF                 2433 	.db #0xff	; 255
   1379 8A                 2434 	.db #0x8a	; 138
   137A AA                 2435 	.db #0xaa	; 170
   137B CF                 2436 	.db #0xcf	; 207
   137C EF                 2437 	.db #0xef	; 239
   137D CF                 2438 	.db #0xcf	; 207
   137E EF                 2439 	.db #0xef	; 239
   137F CF                 2440 	.db #0xcf	; 207
   1380                    2441 _g_newtiles_238:
   1380 8A                 2442 	.db #0x8a	; 138
   1381 45                 2443 	.db #0x45	; 69	'E'
   1382 45                 2444 	.db #0x45	; 69	'E'
   1383 8A                 2445 	.db #0x8a	; 138
   1384 CF                 2446 	.db #0xcf	; 207
   1385 CF                 2447 	.db #0xcf	; 207
   1386 CF                 2448 	.db #0xcf	; 207
   1387 CF                 2449 	.db #0xcf	; 207
   1388                    2450 _g_newtiles_239:
   1388 00                 2451 	.db #0x00	; 0
   1389 FF                 2452 	.db #0xff	; 255
   138A CF                 2453 	.db #0xcf	; 207
   138B 55                 2454 	.db #0x55	; 85	'U'
   138C CF                 2455 	.db #0xcf	; 207
   138D DF                 2456 	.db #0xdf	; 223
   138E CF                 2457 	.db #0xcf	; 207
   138F DF                 2458 	.db #0xdf	; 223
   1390                    2459 _g_newtiles_240:
   1390 00                 2460 	.db #0x00	; 0
   1391 00                 2461 	.db #0x00	; 0
   1392 00                 2462 	.db #0x00	; 0
   1393 00                 2463 	.db #0x00	; 0
   1394 00                 2464 	.db #0x00	; 0
   1395 00                 2465 	.db #0x00	; 0
   1396 00                 2466 	.db #0x00	; 0
   1397 00                 2467 	.db #0x00	; 0
   1398                    2468 _g_newtiles_241:
   1398 00                 2469 	.db #0x00	; 0
   1399 00                 2470 	.db #0x00	; 0
   139A 00                 2471 	.db #0x00	; 0
   139B 00                 2472 	.db #0x00	; 0
   139C 00                 2473 	.db #0x00	; 0
   139D 00                 2474 	.db #0x00	; 0
   139E 00                 2475 	.db #0x00	; 0
   139F 00                 2476 	.db #0x00	; 0
   13A0                    2477 _g_newtiles_242:
   13A0 00                 2478 	.db #0x00	; 0
   13A1 00                 2479 	.db #0x00	; 0
   13A2 00                 2480 	.db #0x00	; 0
   13A3 00                 2481 	.db #0x00	; 0
   13A4 00                 2482 	.db #0x00	; 0
   13A5 00                 2483 	.db #0x00	; 0
   13A6 00                 2484 	.db #0x00	; 0
   13A7 00                 2485 	.db #0x00	; 0
   13A8                    2486 _g_newtiles_243:
   13A8 00                 2487 	.db #0x00	; 0
   13A9 00                 2488 	.db #0x00	; 0
   13AA 00                 2489 	.db #0x00	; 0
   13AB 00                 2490 	.db #0x00	; 0
   13AC 00                 2491 	.db #0x00	; 0
   13AD 00                 2492 	.db #0x00	; 0
   13AE 00                 2493 	.db #0x00	; 0
   13AF 00                 2494 	.db #0x00	; 0
   13B0                    2495 _g_newtiles_244:
   13B0 00                 2496 	.db #0x00	; 0
   13B1 00                 2497 	.db #0x00	; 0
   13B2 00                 2498 	.db #0x00	; 0
   13B3 00                 2499 	.db #0x00	; 0
   13B4 00                 2500 	.db #0x00	; 0
   13B5 00                 2501 	.db #0x00	; 0
   13B6 00                 2502 	.db #0x00	; 0
   13B7 00                 2503 	.db #0x00	; 0
   13B8                    2504 _g_newtiles_245:
   13B8 00                 2505 	.db #0x00	; 0
   13B9 00                 2506 	.db #0x00	; 0
   13BA 00                 2507 	.db #0x00	; 0
   13BB 00                 2508 	.db #0x00	; 0
   13BC 00                 2509 	.db #0x00	; 0
   13BD 00                 2510 	.db #0x00	; 0
   13BE 00                 2511 	.db #0x00	; 0
   13BF 00                 2512 	.db #0x00	; 0
   13C0                    2513 _g_newtiles_246:
   13C0 00                 2514 	.db #0x00	; 0
   13C1 00                 2515 	.db #0x00	; 0
   13C2 00                 2516 	.db #0x00	; 0
   13C3 00                 2517 	.db #0x00	; 0
   13C4 00                 2518 	.db #0x00	; 0
   13C5 00                 2519 	.db #0x00	; 0
   13C6 00                 2520 	.db #0x00	; 0
   13C7 00                 2521 	.db #0x00	; 0
   13C8                    2522 _g_newtiles_247:
   13C8 00                 2523 	.db #0x00	; 0
   13C9 00                 2524 	.db #0x00	; 0
   13CA 00                 2525 	.db #0x00	; 0
   13CB 00                 2526 	.db #0x00	; 0
   13CC 00                 2527 	.db #0x00	; 0
   13CD 00                 2528 	.db #0x00	; 0
   13CE 00                 2529 	.db #0x00	; 0
   13CF 00                 2530 	.db #0x00	; 0
   13D0                    2531 _g_newtiles_248:
   13D0 00                 2532 	.db #0x00	; 0
   13D1 00                 2533 	.db #0x00	; 0
   13D2 00                 2534 	.db #0x00	; 0
   13D3 00                 2535 	.db #0x00	; 0
   13D4 00                 2536 	.db #0x00	; 0
   13D5 00                 2537 	.db #0x00	; 0
   13D6 00                 2538 	.db #0x00	; 0
   13D7 00                 2539 	.db #0x00	; 0
   13D8                    2540 _g_newtiles_249:
   13D8 00                 2541 	.db #0x00	; 0
   13D9 00                 2542 	.db #0x00	; 0
   13DA 00                 2543 	.db #0x00	; 0
   13DB 00                 2544 	.db #0x00	; 0
   13DC 00                 2545 	.db #0x00	; 0
   13DD 00                 2546 	.db #0x00	; 0
   13DE 00                 2547 	.db #0x00	; 0
   13DF 00                 2548 	.db #0x00	; 0
   13E0                    2549 _g_newtiles_250:
   13E0 00                 2550 	.db #0x00	; 0
   13E1 00                 2551 	.db #0x00	; 0
   13E2 00                 2552 	.db #0x00	; 0
   13E3 00                 2553 	.db #0x00	; 0
   13E4 00                 2554 	.db #0x00	; 0
   13E5 00                 2555 	.db #0x00	; 0
   13E6 00                 2556 	.db #0x00	; 0
   13E7 00                 2557 	.db #0x00	; 0
   13E8                    2558 _g_newtiles_251:
   13E8 00                 2559 	.db #0x00	; 0
   13E9 00                 2560 	.db #0x00	; 0
   13EA 00                 2561 	.db #0x00	; 0
   13EB 00                 2562 	.db #0x00	; 0
   13EC 00                 2563 	.db #0x00	; 0
   13ED 00                 2564 	.db #0x00	; 0
   13EE 00                 2565 	.db #0x00	; 0
   13EF 00                 2566 	.db #0x00	; 0
   13F0                    2567 _g_newtiles_252:
   13F0 00                 2568 	.db #0x00	; 0
   13F1 00                 2569 	.db #0x00	; 0
   13F2 00                 2570 	.db #0x00	; 0
   13F3 00                 2571 	.db #0x00	; 0
   13F4 00                 2572 	.db #0x00	; 0
   13F5 00                 2573 	.db #0x00	; 0
   13F6 00                 2574 	.db #0x00	; 0
   13F7 00                 2575 	.db #0x00	; 0
   13F8                    2576 _g_newtiles_253:
   13F8 EF                 2577 	.db #0xef	; 239
   13F9 CF                 2578 	.db #0xcf	; 207
   13FA EF                 2579 	.db #0xef	; 239
   13FB EF                 2580 	.db #0xef	; 239
   13FC FF                 2581 	.db #0xff	; 255
   13FD DF                 2582 	.db #0xdf	; 223
   13FE FF                 2583 	.db #0xff	; 255
   13FF FF                 2584 	.db #0xff	; 255
   1400                    2585 _g_newtiles_254:
   1400 CF                 2586 	.db #0xcf	; 207
   1401 CF                 2587 	.db #0xcf	; 207
   1402 EF                 2588 	.db #0xef	; 239
   1403 DF                 2589 	.db #0xdf	; 223
   1404 CF                 2590 	.db #0xcf	; 207
   1405 EF                 2591 	.db #0xef	; 239
   1406 FF                 2592 	.db #0xff	; 255
   1407 FF                 2593 	.db #0xff	; 255
   1408                    2594 _g_newtiles_255:
   1408 CF                 2595 	.db #0xcf	; 207
   1409 DF                 2596 	.db #0xdf	; 223
   140A CF                 2597 	.db #0xcf	; 207
   140B EF                 2598 	.db #0xef	; 239
   140C DF                 2599 	.db #0xdf	; 223
   140D DF                 2600 	.db #0xdf	; 223
   140E FF                 2601 	.db #0xff	; 255
   140F FF                 2602 	.db #0xff	; 255
                           2603 	.area _INITIALIZER
                           2604 	.area _CABS (ABS)
