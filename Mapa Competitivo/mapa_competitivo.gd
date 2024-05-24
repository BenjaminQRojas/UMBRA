extends Node

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $TileMap/OnlineCharcter

func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)

