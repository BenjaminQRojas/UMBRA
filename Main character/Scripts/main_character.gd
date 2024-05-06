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

func _input(event):
	if event.is_action_pressed("ui_accept"):
		animations.play()

func updateAnimation():
	if velocity.length() == 0:
		animations.stop()
	else:
		var direction = ""
		
		if velocity.x < 0:
			if velocity.y < 0:
				direction = "up_left"
			elif velocity.y > 0:
				direction = "down_left"
			else:
				direction = "left"
		elif velocity.x > 0:
			if velocity.y < 0:
				direction = "up_right"
			elif velocity.y > 0:
				direction = "down_right"
			else:
				direction = "right"
		else:
			if velocity.y < 0:
				direction = "up"
			elif velocity.y > 0:
				direction = "down"
		
		animations.play("Walk_" + direction)
		
func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	look_at_mouse()
	

func look_at_mouse():
	var mouse_pos = get_global_mouse_position()
	get_node("Pivote").look_at(mouse_pos)
	
