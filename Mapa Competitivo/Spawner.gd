extends Area2D

@onready var Escena_enemigo = load("res://Enemigos/Enemigo1/Scenes/enemigo.tscn")
@export var spawn_radius: float = 200.0  # Radio alrededor del jugador donde aparecerán los enemigos
var bool_spawn = true

var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(bool_spawn):
		spawn()

func spawn():
	$cooldown.start()
	bool_spawn = false
	# Obtener la referencia al nodo del jugador
	var jugador_node = $"../OnlineCharcter"
	
	if jugador_node == null:
		print("Error: No se encontró el nodo del jugador.")
		return
	
	var enemigo_instance = Escena_enemigo.instantiate()
	var angle = randf() * 2.0 * PI
	var distance = randf() * spawn_radius
	var offset = Vector2(cos(angle), sin(angle)) * distance
	enemigo_instance.position = jugador_node.position + offset
	print_debug(enemigo_instance.name)
	add_child(enemigo_instance)


func _on_cooldown_timeout():
	bool_spawn = true
