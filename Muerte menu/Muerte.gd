extends Control


@onready var estasMuerto = $Center/estasMuerto
@onready var timer = $Timer

func _ready():
	# Verifica si el nodo 'estasMuerto' es un RichTextLabel
	if estasMuerto and estasMuerto is RichTextLabel:
		estasMuerto.bbcode_text = "[center][wave]ESTAS MUERTO[/wave][/center]"
	else:
		print("Node 'estasMuerto' not found or not a RichTextLabel")
	
	# Inicia el temporizador
	if timer:
		timer.start()
	else:
		print("Node 'Timer' not found")

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Menu/Escenas/MenuPrincipal.tscn")
