extends TabBar

func _ready():
	var screen_type = Persistence.config.get_value("Video", "fullscreen")
	if screen_type == DisplayServer.WINDOW_MODE_FULLSCREEN:
		%FullScreen.button_pressed = true
		
	var borderless_type = Persistence.config.get_value("Video", "borderless")
	if borderless_type == true:
		%Borderless.button_pressed = true
		
	var vsync_index = Persistence.config.get_value("Video", "vsync")
	%Vsync.selected = vsync_index


func _on_full_screen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)

	Persistence.save_data()

func _on_borderless_toggled(toggled_on):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	Persistence.config.set_value("Video", "borderless", toggled_on)
	Persistence.save_data()


func _on_vsync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	Persistence.config.set_value("Video", "vsync", index)
	Persistence.save_data()



func _on_window_size_item_selected(index):
	if index == 0:
		get_viewport().size = Vector2(1920, 1080)
	elif index == 1:
		get_viewport().size = Vector2(1280, 720)
	elif index == 2:
		get_viewport().size = Vector2(854, 480)
	elif index == 3:
		get_viewport().size = DisplayServer.screen_get_size()
