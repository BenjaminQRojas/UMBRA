extends Node

signal dialogue_finished

var dialogue_queue = []
var current_dialogue = null
var dialogue_index = 0

func show_dialogue_balloon(dialogue_resource, start_node):
	current_dialogue = dialogue_resource.new()
	current_dialogue.start(start_node)
	dialogue_index = 0
	dialogue_queue = current_dialogue.get_lines()
	show_next_line()

func show_next_line():
	if dialogue_index < dialogue_queue.size():
		var line = dialogue_queue[dialogue_index]
		dialogue_index += 1
		# Aquí deberías mostrar la línea en la pantalla, en un "dialogue balloon" o cuadro de diálogo.
		print(line)  # Esto es solo para propósitos de demostración.
	else:
		emit_signal("dialogue_finished")
		dialogue_index = 0
		dialogue_queue.clear()

func on_player_choice_made(choice):
	current_dialogue.make_choice(choice)
	dialogue_queue = current_dialogue.get_lines()
	show_next_line()
