extends Node


func _ready():
	if Global.cas2_first_loading == true:
		$"Main character".position.x = Global.player_start_cas2_posx
		$"Main character".position.y = Global.player_start_cas2_posy
	else:
		$"Main character".position.x = Global.player_start_cas2_posx
		$"Main character".position.y = Global.player_start_cas2_posy



func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("castillo1")


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false


func change_scene(lugar):
	if Global.transtion_scene == true:
		if Global.current_scene == "castillo2":
			if lugar == "castillo1":
				Global.finish_changescenes(lugar)
				Global.cas2_first_loading = false
				get_tree().change_scene_to_file("res://1°Castillo/Castillo_1.tscn")
