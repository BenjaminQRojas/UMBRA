extends CanvasLayer


func _input(event):
	if event.is_action_pressed("Inventario"):
		$Inventario.visible = !$Inventario.visible
		$Inventario.initialize_inventory()
		
func _ready():
	pass
