extends Node

signal dialog_finished

func show_dialogue_balloon(dialogue, start):
	emit_signal("dialogue_finished")
