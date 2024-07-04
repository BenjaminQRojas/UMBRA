extends CharacterBody2D

class_name OnlineCharacter

signal healthChanged
signal scoreUp
@export var score = 0

@export var speed = 80
@onready var animations = $Movimiento
@onready var effects = $Efectos
@onready var hurtTimer = $hurtTimer

@export var maxHealth = 5
@onready var currentHealth : int = maxHealth

@export var knockbackPower:int = 500

@onready var flashlight_area = $Pivote/area_luz

func _ready():
	effects.play("RESET")
	flashlight_area.connect("body_entered", Callable(self, "_on_area_luz_body_entered"))

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
			
		animations.play("walk_" + direction)

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

func _physics_process(delta):
	handleInput()
	move_and_slide()
	handleCollision()
	updateAnimation()
	look_at_mouse()

func look_at_mouse():
	var mouse_pos = get_global_mouse_position()
	get_node("Pivote").look_at(mouse_pos)
	
func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		currentHealth -= 1
		if currentHealth < 0:
			Global.vida_MP = false
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		knockback(area.get_parent().velocity)
		effects.play("hurtBlink")
		hurtTimer.start()
		await hurtTimer.timeout
		effects.play("RESET")

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	print_debug(velocity)
	print_debug(position)
	move_and_slide()
	print_debug(position)
	print_debug(" ")

func _on_area_luz_body_entered(body: Node):
	print_debug(body.name)
	if $Pivote/PointLight2D.enabled == true and is_enemy(body):
		emit_signal("scoreUp")
		body.dead()

func is_enemy(node: Node) -> bool:
	return node.is_class("CharacterBody2D")
