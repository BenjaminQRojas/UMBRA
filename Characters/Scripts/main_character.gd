extends CharacterBody2D

@export var speed = 120
@export var maxHealth = 3
@export var knockbackPower: int = 800
@export var regenerationDelay: float = 3.0

@onready var animations = $AnimationPlayer
@onready var tomar = $Tomar
@onready var efecto = $Effects
@onready var timerHurt = $hurtTimer
@onready var regenerationTimer = $regenerationTimer

@onready var currentHealth: int = maxHealth

var Door = false
var currentDirection = ""
var isTaking = false

func _ready():
	efecto.play("RESET")
	animations.play("RESET")
	tomar.connect("animation_finished", Callable(self, "_on_TakeAnimation_finished"))
	regenerationTimer.wait_time = regenerationDelay
	regenerationTimer.connect("timeout", Callable(self, "_on_regeneration_timer_timeout"))

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
		print_debug(currentHealth)
		if currentHealth == 0:
			get_tree().change_scene_to_file("res://Muerte menu/Muerte.tscn")
		else:
			knockback(area.get_parent().velocity)
			efecto.play("hurtBlink")
			timerHurt.start()
			await timerHurt.timeout
			efecto.play("RESET")
			regenerationTimer.start()  # Restart regeneration timer on hit

func _on_regeneration_timer_timeout():
	if currentHealth < maxHealth:
		currentHealth += 1
		print_debug("Health regenerated: ", currentHealth)
		if currentHealth < maxHealth:
			regenerationTimer.start()  # Restart the timer until health is full

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	print_debug(velocity)
	print_debug(position)
	move_and_slide()
	print_debug(position)
	print_debug(" ")

func _input(event):
	if event.is_action_pressed("Take"):
		if $PickupZone.items_in_range.size() > 0:
			var pickup_item = $PickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.items_in_range.erase(pickup_item)
		


func _on_area_deteccion_enemigo_body_entered(body):
	if $Pivote/PointLight2D.enabled == true:
		if body.name == "Enemigo":
			body.dead()
