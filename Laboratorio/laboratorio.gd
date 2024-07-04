extends Node

var sonido = preload("res://Laboratorio/Y2meta.app-z3r0-8bit-Nightmare-_-8bit-Horror-NO-COPYRIGHT-MUSIC-_128-kbps_.ogg")


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
