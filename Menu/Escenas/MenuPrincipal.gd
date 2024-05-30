extends Node2D

var sonidoMenu = preload("res://Menu/Sonidos/sonido_Menu.ogg")

func _ready():
	changeSound(sonidoMenu)
	
	
func changeSound(sound):
	AudioPrincipal.stream = sound
	AudioPrincipal.play()
