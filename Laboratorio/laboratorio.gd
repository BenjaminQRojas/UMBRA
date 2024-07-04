extends Node

var sonido = preload("res://Laboratorio/Y2meta.app-z3r0-8bit-Nightmare-_-8bit-Horror-NO-COPYRIGHT-MUSIC-_128-kbps_.ogg")

@onready var MenuNotas = $CanvasLayer2/Control/ColorRect
@onready var nota1 = $CanvasLayer2/Control/ColorRect/Nota_1
@onready var nota2 = $CanvasLayer2/Control/ColorRect/Nota_2


func _ready():
	changeSound(sonido)
	if Global.lab_first_loading == true:
		$Main_character.position.x = Global.player_start_posx
		$Main_character.position.y = Global.player_start_posy
	else:
		if Global.escena_anterior == "bosque":
			$Main_character.position.x = Global.player_exit_lab_posx
			$Main_character.position.y = Global.player_exit_lab_posy
		elif Global.escena_anterior == "catacumbas":
			$Main_character.position.x = Global.player_ent_cat_posx
			$Main_character.position.y = Global.player_ent_cat_posy
		elif Global.escena_anterior == "puzzle":
			$Main_character.position.x = Global.player_ent_puzzle_posx
			$Main_character.position.y = Global.player_ent_puzzle_posy


func _on_area_2d_body_entered(body):
	if Global.acerto == true:
		if body.has_method("player"):
			Global.transtion_scene = true
			change_scene("bosque")


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false
		


func _process(delta):
	pass

func change_scene(lugar):
	if Global.transtion_scene == true:
		if Global.current_scene == "laboratorio":
			if lugar == "catacumbas":
				Global.finish_changescenes(lugar)
				Global.lab_first_loading = false
				print(Global.lab_first_loading)
				get_tree().change_scene_to_file("res://Celdas-Catacumbas/catacumbas.tscn")
			elif lugar == "bosque":
				Global.finish_changescenes(lugar)
				Global.lab_first_loading = false
				get_tree().change_scene_to_file("res://Bosque/bosque.tscn")
			elif lugar == "puzzle":
				if Global.acerto == false:
					Global.finish_changescenes(lugar)
					Global.lab_first_loading = false
					print(Global.lab_first_loading)
					get_tree().change_scene_to_file("res://Laboratorio/Puzzle/Enimga_lab.tscn")
			


func _on_area_2d_2_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("catacumbas")
	

func _on_area_2d_2_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false


func _on_button_pressed(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("puzzle")


func _on_puzzle_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("puzzle")


func _on_puzzle_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false

func changeSound(sound):
	AudioPrincipal.stream = sound
	AudioPrincipal.play()
	
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
