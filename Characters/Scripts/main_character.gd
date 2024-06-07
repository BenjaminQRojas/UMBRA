extends CharacterBody2D

@export var speed = 120
@export var maxHealth = 3
@export var knockbackPower: int = 500

@onready var animations = $AnimationPlayer
@onready var tomar =  $Tomar

@onready var currentHealth: int = maxHealth

var Door = false
var currentDirection = ""
var isTaking = false

func _ready():
	animations.play("RESET")
	tomar.connect("animation_finished", Callable(self, "_on_TakeAnimation_finished"))

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
	if isTaking:
		return
	var direction = ""
	if velocity.length() == 0:
		animations.stop()

	else:
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
		currentDirection = direction

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
	
		
func _physics_process(delta):
	if not isTaking:
		handleInput()
		move_and_slide()
		handleCollision()
	updateAnimation()
	look_at_mouse()
	open_Door()
	if Input.is_action_just_pressed("ui_accept"):
		playTakeAnimation()

func open_Door():
	if Door == true:
		set_physics_process(false)
		Door = false

func look_at_mouse():
	var mouse_pos = get_global_mouse_position()
	get_node("Pivote").look_at(mouse_pos)
	
func playTakeAnimation():
	if currentDirection != "" and not isTaking:
		isTaking = true
		tomar.play("Take_" + currentDirection)
		animations.stop()

func _on_TakeAnimation_finished(anim_name):
	if anim_name.begins_with("Take_"):
		isTaking = false
		updateAnimation()  

func player():
	pass


func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
		print_debug(currentHealth)
		knockback(area.get_parent().velocity)

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	print_debug(velocity)
	print_debug(position)
	move_and_slide()
	print_debug(position)
	print_debug(" ")
