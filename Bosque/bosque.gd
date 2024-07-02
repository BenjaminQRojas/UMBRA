extends Node

func _ready():
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
			



func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("cueva")

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false


func _on_area_2d_2_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("castillo1")


func _on_area_2d_2_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false
