extends Area2D

var entro = false


func _on_body_entered(body: PhysicsBody2D):
	entro = true

func _on_body_exited(body):
	entro = false
	
func _process(delta):
	if entro == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://Cueva/cueva.tscn")
