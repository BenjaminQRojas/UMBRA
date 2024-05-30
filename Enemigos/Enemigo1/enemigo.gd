extends CharacterBody2D


const speed = 3000.0
var player = null
var player_chase = false


func _physics_process(_delta):
	if player_chase:
		position += (player.position - position)/speed
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	player = body
	player_chase = true


func _on_area_2d_body_exited(_body):
	player = null
	player_chase = false

'''
func linterna():
	si linterna esta en enemigo
		desaparece
'''
