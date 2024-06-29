extends CharacterBody2D

const acceleration = 460
const max_speed = 225
var item_velocity = Vector2.ZERO
var item_name

var player = null
var being_picked_up = false

func _ready():
	item_name = "Slime Potion"

func _physics_process(delta):
	if being_picked_up:
		var direction = global_position.direction_to(player.global_position)
		item_velocity = item_velocity.move_toward(direction * max_speed, acceleration * delta)
		
		# Calcula la distancia al jugador
		var distance = global_position.distance_to(player.global_position)
		if distance < 4:
			PlayerInventory.add_item(item_name, 1)
			queue_free()
	
	#item_velocity = move_and_collide(item_velocity * delta)
	# Mueve el objeto solo si está siendo recogido
	if being_picked_up:
		move_and_collide(item_velocity * delta)

func pick_up_item(body):
	player = body
	being_picked_up = true
