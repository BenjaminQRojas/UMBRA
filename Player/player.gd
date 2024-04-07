extends CharacterBody2D

var speed := 120

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
func _physics_process(delta):
	var direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direccion * speed
	
	if direccion:
		anim.play("walk")
	else:
		anim.play("idle")
	
	#if direccion:
		#sprite.flip_h = true
	
	move_and_slide()
