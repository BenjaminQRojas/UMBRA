extends Node2D

var sonidoMenu = preload("res://Menu/untitled.ogg")

func _ready():
	changeSound(sonidoMenu)
	
	
func changeSound(sound):
	AudioPrincipal.stream = sound
	AudioPrincipal.play()
