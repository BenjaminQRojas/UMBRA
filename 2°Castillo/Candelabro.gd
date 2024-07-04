extends Sprite2D

@onready var candelabro : AnimationPlayer = $AnimacionCandelabro

func _process(_delta):
	candelabro.play("candelabro")
