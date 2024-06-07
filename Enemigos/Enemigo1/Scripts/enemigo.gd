extends CharacterBody2D

const SPEED = 30.0
var player = null
var player_chase = false

# referencia a los sprites
@onready var spriteI = $"sprite-idle"
@onready var spriteW = $"sprite-walks"
# Obtén una referencia al AnimatedSprite2D
@onready var animated_sprite = $AnimationPlayer

func _physics_process(_delta):
	if player_chase:
		spriteI.visible = false
		spriteW.visible = true
		var direction = (player.position - position).normalized()
		position += direction * SPEED * _delta
		# Cambia la animación según la dirección
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				animated_sprite.play("walk_right")
			else:
				animated_sprite.play("walk_left")
		else:
			if direction.y > 0:
				animated_sprite.play("walk_up")
			else:
				animated_sprite.play("walk_down")
				
	else:
		spriteW.visible = false
		spriteI.visible = true
		animated_sprite.play("idle")
	move_and_slide()

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true

func _on_area_2d_body_exited(_body):
	player = null
	player_chase = false

