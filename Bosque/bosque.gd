extends Node
var a = 0

var sonido = preload("res://Bosque/Y2meta.app-Run-As-Fast-As-You-Can-_128-kbps_.ogg")

@onready var MenuNotas = $CanvasLayer2/Control/ColorRect
@onready var nota1 = $CanvasLayer2/Control/ColorRect/Nota_1
@onready var nota2 = $CanvasLayer2/Control/ColorRect/Nota_2

func _ready():
	changeSound(sonido)
	if Global.bos_first_loading == true:
		$"Main character".position.x = Global.player_start_bosq_posx
		$"Main character".position.y = Global.player_start_bosq_posy
	else:
		if Global.escena_anterior == "laboratorio":
			$"Main character".position.x = Global.player_start_bosq_posx
			$"Main character".position.y = Global.player_start_bosq_posy
		elif Global.escena_anterior == "cueva":
			$"Main character".position.x = Global.player_ent_cue_posx
			$"Main character".position.y = Global.player_ent_cue_posy
		elif Global.escena_anterior == "castillo1":
			$"Main character".position.x = Global.player_ent_cas_posx
			$"Main character".position.y = Global.player_ent_cas_posy
		elif Global.escena_anterior == "puzzle_bos":
			$"Main character".position.x = Global.player_ent_puzzle_bos_posx
			$"Main character".position.y = Global.player_ent_puzzle_bos_posy

func _on_area_2d_3_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("laboratorio")

func _on_area_2d_3_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false

func _process(delta):
	pass

func change_scene(lugar):
	if Global.transtion_scene == true:
		if Global.current_scene == "bosque":
			if lugar == "laboratorio":
				Global.finish_changescenes(lugar)
				Global.bos_first_loading = false
				get_tree().change_scene_to_file("res://Laboratorio/laboratorio.tscn")
			elif lugar == "cueva":
				Global.finish_changescenes(lugar)
				Global.bos_first_loading = false
				get_tree().change_scene_to_file("res://Cueva/Cueva.tscn")
			elif lugar == "castillo1":
				Global.finish_changescenes(lugar)
				Global.bos_first_loading = false
				get_tree().change_scene_to_file("res://1°Castillo/Castillo_1.tscn")
			elif lugar == "puzzle_bos":
				if Global.acerto_bos == false:
					Global.finish_changescenes(lugar)
					Global.bos_first_loading = false
					get_tree().change_scene_to_file("res://Bosque/Puzzle/Puzzle_bos.tscn")
			



func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("cueva")

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false


func _on_area_2d_2_body_entered(body):
	if Global.acerto_bos == true:
		if body.has_method("player"):
			Global.transtion_scene = true
			change_scene("castillo1")


func _on_area_2d_2_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false
		
func changeSound(sound):
	AudioPrincipal.stream = sound
	AudioPrincipal.play()


func _on_puzzle_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("puzzle_bos")


func _on_puzzle_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false


func _input(event):
	if event.is_action_pressed("Nota1"):
		if Global.nota1_encontrada == true:
			toggle_visibility("CanvasLayer2/Control/ColorRect/Nota_1")
		else:
			toggle_visibility("CanvasLayer2/Control/ColorRect/No_encontrada")
	elif event.is_action_pressed("Nota2"):
		if Global.nota2_encontrada == true:
			toggle_visibility("CanvasLayer2/Control/ColorRect/Nota_2")
		else:
			toggle_visibility("CanvasLayer2/Control/ColorRect/No_encontrada")
	elif event.is_action_pressed("Nota3"):
		if Global.nota3_encontrada == true:
			toggle_visibility("CanvasLayer2/Control/ColorRect/Nota_3")
		else:
			toggle_visibility("CanvasLayer2/Control/ColorRect/No_encontrada")
	elif event.is_action_pressed("Nota4"):
		if Global.nota4_encontrada == true:
			toggle_visibility("CanvasLayer2/Control/ColorRect/Nota_4")
		else:
			toggle_visibility("CanvasLayer2/Control/ColorRect/No_encontrada")
	elif event.is_action_pressed("GuiaCaracteres"):
		if Global.guia_encontrada == true:
			toggle_visibility("CanvasLayer2/Control/ColorRect/Guia_caracteres")
		else:
			toggle_visibility("CanvasLayer2/Control/ColorRect/No_encontrada")


func toggle_visibility(nota_name):
	var nota = get_node(nota_name)
	if nota == null:
		print("Node not found: " + nota_name)
		return
	
	if MenuNotas.visible:
		MenuNotas.hide()
		nota.hide()
	else:
		MenuNotas.show()
		nota.show()
