extends Node

var item_data: Dictionary

func _ready():
	item_data = LoadData("res://Inventario/Data/ItemData.json")
	
func LoadData(file_path: String):
	var file_data = FileAccess.get_file_as_string(file_path)
	var json_data = JSON.parse_string(file_data)
	
	return json_data
