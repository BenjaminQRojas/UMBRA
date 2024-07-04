extends Area2D

@onready var Escena_enemigo = load("res://Enemigos/Enemigo1/Scenes/enemigo.tscn")
@onready var Escena_enemigo2 = load("res://Enemigos/Enemigo2/Scenes/Enemigo2.tscn")
@onready var Escena_enemigo3 = load("res://Enemigos/Enemigo3/Scenes/Enemigo3.tscn")
@onready var jugador_node = $"../TileMap/OnlineCharcter"
var bool_spawn = true

var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random.randomize()
	jugador_node.connect("scoreChanged", Callable(self, "_on_player_score_changed"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(bool_spawn):
		spawn()

func spawn():
	#score jugador
	var score_jugador = jugador_node.score
	#timer
	$cooldown.start()
	bool_spawn = false
<<<<<<< Updated upstream
	# Obtener la referencia al nodo del jugador
	var jugador_node = $"../OnlineCharcter"
	
=======
	#control de errores jugador
>>>>>>> Stashed changes
	if jugador_node == null:
		print("Error: No se encontró el nodo del jugador.")
		return
	#instancia de enemigo
	if score_jugador < 20:
		print_debug(score_jugador)
		var enemigo_instance = Escena_enemigo.instantiate()
		enemigo_instance.position = jugador_node.position + Vector2(200,0).rotated(randf_range(0,2*PI))
		add_child(enemigo_instance)
	else: 
		if score_jugador >= 20 and score_jugador < 50:
			for x in range(3):
				var enemigo_instance = Escena_enemigo2.instantiate()
				enemigo_instance.position = jugador_node.position + Vector2(200,0).rotated(randf_range(0,2*PI))
				add_child(enemigo_instance)
		else:
			if score_jugador >= 50:
				for x in range(6):
					var enemigo_instance = Escena_enemigo3.instantiate()
					enemigo_instance.position = jugador_node.position + Vector2(200,0).rotated(randf_range(0,2*PI))
					add_child(enemigo_instance)

func enemigo_random():
	
	pass

func _on_cooldown_timeout():
	bool_spawn = true
