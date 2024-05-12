extends Area2D

var entro = false

func _on_body_entered(body: PhysicsBody2D):
	var entro = true


func _on_body_exited(body):
	var entro = false


func _process(delta):
	if entro == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://Laboratorio/laboratorio.tscn")
