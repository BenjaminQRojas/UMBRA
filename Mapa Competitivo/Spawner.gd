extends Area2D

@onready var enemigo1 = load("res://Enemigos/Enemigo1/Scenes/enemigo.tscn")
@onready var enemigo2 = load("res://Enemigos/Enemigo2/Scenes/Enemigo2.tscn")
@onready var enemigo3 = load("res://Enemigos/Enemigo3/Scenes/Enemigo3.tscn")
@onready var main_script = get_tree().get_root().get_node("Mapa competitivo")
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
	var score = main_script.scorePlayer
	print_debug(score)
	$cooldown.start()
	bool_spawn = false
	# Obtener la referencia al nodo del jugador
	var jugador_node = $"../TileMap/OnlineCharcter"
	if jugador_node == null:
		print("Error: No se encontró el nodo del jugador.")
		return
	
	var enemigo_instance = enemigo1.instantiate()
	enemigo_instance.position = jugador_node.position + Vector2(200,0).rotated(randf_range(0,2*PI))
	print_debug(enemigo_instance.name)
	add_child(enemigo_instance)


func _on_cooldown_timeout():
	bool_spawn = true
