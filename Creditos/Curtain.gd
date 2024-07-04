extends Control

@onready var animacion = $animacion

func change_scene_to_file(scene):
	animacion.play("show")
	await animacion.animation_finished
	
	get_tree().change_scene_to_file(scene)
	
	animacion.play_backwards("show")
	await animacion.animation_finished
