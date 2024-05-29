extends Node2D


@export var EnemigoMultiplayer: PackedScene


func _ready():
	$TimerEnemigo.start()
	print("comenzo")


func _on_timer_enemigo_timeout():
	# Create a new instance of the Mob scene.
	var mob = EnemigoMultiplayer.instantiate()
	print("nace mob: "+mob.name)

	# Choose a random location on Path2D.
	var mob_spawn_location = $EnemigoPath/SpawnEnemigo
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)



