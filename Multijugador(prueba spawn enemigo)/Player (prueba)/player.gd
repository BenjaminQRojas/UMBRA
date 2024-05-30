extends CharacterBody2D

#Parametros para la velocidad del jugador
var speed := 100
var direccionx := 2
var direcciony := 2

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D

var enemy = "EnemigoMultiplayer"
func _physics_process(_delta):
	direccionx = Input.get_axis("ui_left", "ui_right")
	velocity.x = direccionx * speed
	
	direcciony = Input.get_axis("ui_up", "ui_down")
	velocity.y = direcciony * speed
	
	if direccionx != 0 or direcciony != 0:
		anim.play("walk")
	else:
		anim.play("idle")
	
	sprite.flip_h = direccionx < 0 if direccionx != 0 else sprite.flip_h
	#sprite.flip_v = direcciony < 0 if direcciony != 0 else sprite.flip_v
	
	move_and_slide()
	look_at_mouse()

func look_at_mouse():
	var mouse_pos = get_global_mouse_position()
	get_node("Pivote").look_at(mouse_pos)
	
	
	


func _on_area_luz_body_entered(body):
	if(body.name == enemy): #cambiar en caso de cambio de nombre de la escena enemigo
		print("mato")
		body.dead()
