extends Control

var acerto = false
		

func _on_button_pressed():
	acerto = false
	Global.transtion_scene = true
	change_scene("laboratorio")
	

func _on_button_2_pressed():
	acerto = true
	Global.transtion_scene = true
	change_scene("laboratorio")


func _on_button_3_pressed():
	acerto = false
	Global.transtion_scene = true
	change_scene("laboratorio")


func _on_button_4_pressed():
	acerto = false
	Global.transtion_scene = true
	change_scene("laboratorio")

func change_scene(lugar):
	if Global.transtion_scene == true:
		if Global.current_scene == "puzzle":
			if lugar == "laboratorio":
				Global.finish_changescenes(lugar)
				Global.acerto = acerto
				get_tree().change_scene_to_file("res://Laboratorio/laboratorio.tscn")
			
