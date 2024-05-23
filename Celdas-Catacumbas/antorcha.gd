extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(_delta):
	animation_player.play("antorcha")
