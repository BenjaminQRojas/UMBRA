extends CharacterBody2D

# velocidad enemigo
const SPEED = 40.0
# referencia al personaje
var player = null
var player_chase = false

# referencia a los sprites
@onready var spriteI = $"sprite-idle"
@onready var spriteW = $"sprite-walks"
# referencia al AnimatedSprite2D
@onready var animated_sprite = $AnimationPlayer

func _physics_process(_delta):
	if player_chase:
		print_debug("persiguiendo a player")
		spriteI.visible = false
		spriteW.visible = true
		var direction = (player.position - position).normalized()
		position += direction * SPEED * _delta
		# cambia la animación según la dirección
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
		print_debug("modo idle")
		spriteW.visible = false
		spriteI.visible = true
		animated_sprite.play("idle")
	move_and_slide()

# funcion de deteccion de "cuerpo" (player) en el area
func _on_area_2d_body_entered(body):
	player = body
	player_chase = true

# funcion si sale el "cuerpo" del area de deteccion
func _on_area_2d_body_exited(_body):
	player = null
	player_chase = false

