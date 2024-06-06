extends Control

var acerto = false


func _on_button_pressed():
	acerto = true
	visible = not get_tree().paused
	get_tree().paused = not get_tree().paused

func _on_button_2_pressed():
	pass # Replace with function body.


func _on_button_3_pressed():
	pass # Replace with function body.


func _on_button_4_pressed():
	pass # Replace with function body.
