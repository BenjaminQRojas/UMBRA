extends Node


func _ready():
	if Global.cas1_first_loading == true:
		$"Main character".position.x = Global.player_start_cas_posx
		$"Main character".position.y = Global.player_start_cas_posy
	else:
		if Global.escena_anterior == "bosque":
			$"Main character".position.x = Global.player_start_cas_posx
			$"Main character".position.y = Global.player_start_cas_posy
		elif Global.escena_anterior == "castillo2":
				$"Main character".position.x = Global.player_ent_cast2_posx
				$"Main character".position.y = Global.player_ent_cats2_poxy
				


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("castillo2")



func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false


func change_scene(lugar):
	if Global.transtion_scene == true:
		if Global.current_scene == "castillo1":
			if lugar == "castillo2":
				Global.finish_changescenes(lugar)
				Global.cas1_first_loading = false
				get_tree().change_scene_to_file("res://2°Castillo/Castillo_2.tscn")
			elif lugar == "bosque":
				Global.finish_changescenes(lugar)
				Global.cas1_first_loading = false
				get_tree().change_scene_to_file("res://Bosque/bosque.tscn")




func _on_area_2d_2_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("bosque")


func _on_area_2d_2_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false
