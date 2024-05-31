extends Area2D

var resuelto = false


func _ready():
	pass
	
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Laboratorio/Puzzle/puzzle.tscn")
	#if Puzzle1.resuelto == true:
		#resuelto = true
		#get_tree().change_scene_to_file("res://Laboratorio/laboratorio.tscn")
