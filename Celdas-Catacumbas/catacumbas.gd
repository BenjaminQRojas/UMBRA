extends Node

func _ready():
	if Global.bos_first_loading == true:
		$"Main character".position.x = Global.player_start_cat_posx
		$"Main character".position.y = Global.player_start_cat_posy
	else:
		$"Main character".position.x = Global.player_start_cat_posx
		$"Main character".position.y = Global.player_start_cat_posy
		


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("laboratorio")

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false

func _process(delta):
	pass

func change_scene(lugar):
	if Global.transtion_scene == true:
		if Global.current_scene == "catacumbas":
			if lugar == "laboratorio":
				Global.finish_changescenes(lugar)
				Global.cat_first_loading = false
				get_tree().change_scene_to_file("res://Laboratorio/laboratorio.tscn")
			
