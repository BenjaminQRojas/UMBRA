extends Area2D


func _on_body_entered(body):
	if body.name == "Main character" and Input.is_action_just_pressed("Entrar a zona"):
		get_tree().change_scene_to_file("res://Celdas-Catacumbas/catacumbas.tscn")
	pass # Replace with function body.
