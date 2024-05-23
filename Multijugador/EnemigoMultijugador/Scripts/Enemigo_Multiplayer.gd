extends CharacterBody2D

@export var player1: PackedScene

const speed = 30.0
var player = null
var player_chase = false


func _physics_process(_delta):
	if player_chase:
		position += (player.position - position)/speed
	
	move_and_slide()

func dead():
	
	$AnimatedSprite2D.play("muerte")
	await($AnimatedSprite2D.animation_finished)
	queue_free()

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true


func _on_area_2d_body_exited(_body):
	player = null
	player_chase = false


