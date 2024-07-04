extends Control

var acerto = false
		

func _on_button_pressed():
	acerto = false
	Global.transtion_scene = true
	change_scene("bosque")
	

func _on_button_2_pressed():
	acerto = false
	Global.transtion_scene = true
	change_scene("bosque")


func _on_button_3_pressed():
	acerto = true
	Global.transtion_scene = true
	change_scene("bosque")


func _on_button_4_pressed():
	acerto = false
	Global.transtion_scene = true
	change_scene("bosque")

func change_scene(lugar):
	print(Global.current_scene)
	if Global.transtion_scene == true:
		if Global.current_scene == "puzzle_bos":
			if lugar == "bosque":
				Global.finish_changescenes(lugar)
				Global.acerto_bos = acerto
				get_tree().change_scene_to_file("res://Bosque/bosque.tscn")
			
