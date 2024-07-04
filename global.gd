extends Node

var current_scene = "laboratorio"
var escena_anterior = ""
var transtion_scene = false

var player_exit_lab_posx = 790
var player_exit_lab_posy = 142
var player_ent_cat_posx = 1069
var player_ent_cat_posy = 221
var player_start_posx = 55
var player_start_posy = 67

var player_start_cat_posx = 6
var player_start_cat_posy = 94

var player_ent_cue_posx = 64
var player_ent_cue_posy = 18
var player_ent_cas_posx = 511
var player_ent_cas_posy = 42
var player_start_bosq_posx = 128
var player_start_bosq_posy = 331

var player_ent_cast_posx = 0
var player_ent_cast_posy = 0
var player_start_cue_posx = 129
var player_start_cue_posy = -52

var player_ent_cast2_posx = 330
var player_ent_cats2_poxy = 13
var player_start_cas_posx = -317
var player_start_cas_posy = 26

var player_start_cas2_posx = 302
var player_start_cas2_posy = 114


var player_ent_puzzle_posx = 792
var player_ent_puzzle_posy = 156
var acerto = false

var lab_first_loading = true
var bos_first_loading = true
var cat_first_loading = true
var cue_first_loading = true
var cas1_first_loading = true
var cas2_first_loading = true

var player_ent_puzzle_bos_posx = 474
var player_ent_puzzle_bos_posy = 60
var acerto_bos = false

var nota1_encontrada = false
var nota2_encontrada = false
var nota3_encontrada = false
var nota4_encontrada = false
var guia_encontrada = false
var navaja = false
var llave = false

var score_MP = 1
var termino_MP = false

func finish_changescenes(lugar):
	if transtion_scene == true:
		transtion_scene = false
		if current_scene == "laboratorio":
			if lugar == "bosque":
				current_scene = "bosque"
				escena_anterior = "laboratorio"
			elif lugar == "catacumbas":
				current_scene = "catacumbas"
				escena_anterior = "laboratorio"
			elif lugar == "puzzle":
				current_scene = "puzzle"
				escena_anterior == "laboratorio"
		elif current_scene == "bosque":
			if lugar == "laboratorio":
				current_scene = "laboratorio"
				escena_anterior = "bosque"
			elif lugar == "cueva":
				current_scene = "cueva"
				escena_anterior = "bosque"
			elif lugar == "castillo1":
				current_scene = "castillo1"
				escena_anterior = "bosque"
			elif lugar == "puzzle_bos":
				current_scene = "puzzle_bos"
				escena_anterior = "bosque"
		elif current_scene == "catacumbas":
			if lugar == "laboratorio":
				current_scene = "laboratorio"
				escena_anterior = "catacumbas"
		elif current_scene == "cueva":
			if lugar == "bosque":
				current_scene = "bosque"
				escena_anterior = "cueva"
			elif lugar == "entrada_Castillo":
				current_scene = "entrada_castillo"
				escena_anterior = "cueva"
		elif current_scene == "castillo1":
			if lugar == "bosque":
				current_scene = "bosque"
				escena_anterior = "castillo1"
			elif lugar == "castillo2":
				current_scene = "castillo2"
				escena_anterior = "castillo1"
		elif current_scene == "castillo2":
			if lugar == "castillo1":
				current_scene = "castillo1"
				escena_anterior = "castillo2"
		elif current_scene == "puzzle":
			if lugar == "laboratorio":
				current_scene = "laboratorio"
				escena_anterior = "puzzle"
		elif current_scene == "puzzle_bos":
			if lugar == "bosque":
				current_scene = "bosque"
				escena_anterior = "puzzle_bos"
