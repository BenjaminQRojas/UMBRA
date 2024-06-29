extends Area2D

@onready var Escena_enemigo = load("res://Enemigos/Enemigo1/Scenes/enemigo.tscn")
var bool_spawn = true

var random = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn()

func spawn():
	if bool_spawn:
		$cooldown.start()
		bool_spawn = false
		var enemigo_instance = Escena_enemigo.instantiate()
		enemigo_instance.position = Vector2(random.randi_range(-1050,1730), random.randi_range(450,-450))
		add_child(enemigo_instance)
		


func _on_cooldown_timeout():
	bool_spawn = true
