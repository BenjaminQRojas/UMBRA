extends Node2D

@onready var hotbar = $HotbarSlots
@onready var slots = hotbar.get_children()

func _ready():
	for i in range(slots.size()):
		#slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))
		slots[i].slot_index = i
	initialize_inventory()
		
func initialize_inventory():
	for i in range(slots.size()):
		if PlayerInventory.hotbar.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])
