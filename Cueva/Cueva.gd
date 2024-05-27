extends Node

func _ready():
	if Global.cue_first_loading == true:
		$"Main character".position.x = Global.player_start_cue_posx
		$"Main character".position.y = Global.player_start_cue_posy
	else:
		if Global.escena_anterior == "bosque":
			$"Main character".position.x = Global.player_start_cue_posx
			$"Main character".position.y = Global.player_start_cue_posy
		elif Global.escena_anterior == "entrada_castillo":
			$"Main character".position.x = Global.player_ent_cast_posx
			$"Main character".position.y = Global.player_ent_cast_posy

func _on_area_2d_body_entered(body):
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
		if Global.current_scene == "cueva":
			if lugar == "bosque":
				Global.finish_changescenes(lugar)
				Global.cue_first_loading = false
				get_tree().change_scene_to_file("res://Bosque/bosque.tscn")
			elif lugar == "entrada_castillo":
				Global.finish_changescenes(lugar)
				Global.cue_first_loading = false
				#get_tree().change_scene_to_file()
