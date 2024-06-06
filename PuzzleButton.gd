extends Button

var textt

func _ready():
	set_process_unhandled_key_input(false)
	display_text()
	
func display_text():
	text = InputMap.action_get_events(textt)[0].as_text()
	
func remap_action_to(event):
	InputMap.action_erase_events(textt)
	InputMap.action_add_event(textt, event)

	text = event.as_text()

func _on_pressed():
	set_process_unhandled_key_input(true)
	text = "Decifra el enigma"

func _unhandled_key_input(event):
	remap_action_to(event)
	set_process_unhandled_key_input(false)
	release_focus()
