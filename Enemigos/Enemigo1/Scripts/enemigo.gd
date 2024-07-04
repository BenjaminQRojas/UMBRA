extends CharacterBody2D

# velocidad enemigo
const SPEED = 40.0
# referencia al personaje
var player = null
var player_chase = false

# referencia al AnimatedSprite2D
@onready var animated_sprite = $AnimationPlayer

signal enemigo_eliminado(enemigo)

func _ready():
	$hitBox.connect("body_entered", Callable(self, "_on_body_entered"))


func _physics_process(_delta):
	if player_chase:
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
				animated_sprite.play("walk_front")
			else:
				animated_sprite.play("walk_back")
				
	else:
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
	

# Función llamada cuando un cuerpo entra en el hitBox del enemigo
func _on_body_entered(body):
	if body.name == "area_luz":  # Asegúrate de que el nombre es correcto
		dead()

# Función para eliminar al enemigo
func dead():
	player = null
	player_chase = false
	animated_sprite.play("muerte")
	print_debug("muerto")
	#emit_signal("enemigo_eliminado", self)
	queue_free()
