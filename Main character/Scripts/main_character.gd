extends CharacterBody2D

@export var speed = 100
@onready var animations = $AnimationPlayer

func handleInput():
	var moveDirection = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		moveDirection.x -= 1
	if Input.is_action_pressed("ui_right"):
		moveDirection.x += 1
	if Input.is_action_pressed("ui_up"):
		moveDirection.y -= 1
	if Input.is_action_pressed("ui_down"):
		moveDirection.y += 1
	velocity = moveDirection.normalized() * speed

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
	
