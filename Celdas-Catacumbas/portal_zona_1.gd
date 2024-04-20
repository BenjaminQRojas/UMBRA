extends Area2D

func _on_body_entered(body):
	if body.name == "Main character":
		get_tree().change_scene_to_file("res://Laboratorio/laboratorio.tscn")
	pass # Replace with function body.
