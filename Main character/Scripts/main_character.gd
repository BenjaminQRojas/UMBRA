extends CharacterBody2D

@export var speed: int = 35
@onready var animations = $AnimationPlayer

func handleInput():
	var moveDirection = Input.get_vector("ui_left","ui_right", "ui_up", "ui_down")
	velocity = moveDirection*speed

func updateAnimation():
	if velocity.length() == 0:
		animations.stop()
	else:
		var direction = ""
		
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"
		elif velocity.y > 0: direction = "down"
		
		animations.play("Walk_" + direction)

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	