extends CharacterBody2D

const SPEED = 30.0
var player = null
var player_chase = false

# Obtén una referencia al AnimatedSprite2D
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(_delta):
	if player_chase:
		var direction = (player.position - position).normalized()
		position += direction * SPEED * _delta

		# Cambia la animación según la dirección
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				animated_sprite.play("right_walk")
			else:
				animated_sprite.play("left_walk")
		else:
			if direction.y > 0:
				animated_sprite.play("front_walk")
			else:
				animated_sprite.play("back_walk")

	move_and_slide()

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true

func _on_area_2d_body_exited(_body):
	player = null
	player_chase = false

