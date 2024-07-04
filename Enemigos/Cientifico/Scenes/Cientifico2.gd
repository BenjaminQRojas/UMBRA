extends CharacterBody2D

func _physics_process(delta):
	$AnimationPlayer.play("idle_down")

func dead():
	pass

func enemy():
	pass
