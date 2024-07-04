extends Node

var sonido = preload("res://Celdas-Catacumbas/Y2meta.app-The-search-_128-kbps_.ogg")

@onready var MenuNotas = $CanvasLayer2/Control/ColorRect
@onready var nota1 = $CanvasLayer2/Control/ColorRect/Nota_1
@onready var nota2 = $CanvasLayer2/Control/ColorRect/Nota_2

func _ready():
	changeSound(sonido)
	if Global.bos_first_loading == true:
		$"Main character".position.x = Global.player_start_cat_posx
		$"Main character".position.y = Global.player_start_cat_posy
	else:
		$"Main character".position.x = Global.player_start_cat_posx
		$"Main character".position.y = Global.player_start_cat_posy
		


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.transtion_scene = true
		change_scene("laboratorio")

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		Global.transtion_scene = false

func _process(delta):
	pass

func change_scene(lugar):
	if Global.transtion_scene == true:
		if Global.current_scene == "catacumbas":
			if lugar == "laboratorio":
				Global.finish_changescenes(lugar)
				Global.cat_first_loading = false
				get_tree().change_scene_to_file("res://Laboratorio/laboratorio.tscn")
			

func changeSound(sound):
	AudioPrincipal.stream = sound
	AudioPrincipal.play()


func _input(event):
	if event.is_action_pressed("Nota1"):
		if Global.nota1_encontrada == true:
			toggle_visibility("CanvasLayer2/Control/ColorRect/Nota_1")
		else:
			toggle_visibility("CanvasLayer2/Control/ColorRect/No_encontrada")
	elif event.is_action_pressed("Nota2"):
		if Global.nota2_encontrada == true:
			toggle_visibility("CanvasLayer2/Control/ColorRect/Nota_2")
		else:
			toggle_visibility("CanvasLayer2/Control/ColorRect/No_encontrada")
	elif event.is_action_pressed("Nota3"):
		if Global.nota3_encontrada == true:
			toggle_visibility("CanvasLayer2/Control/ColorRect/Nota_3")
		else:
			toggle_visibility("CanvasLayer2/Control/ColorRect/No_encontrada")
	elif event.is_action_pressed("Nota4"):
		if Global.nota4_encontrada == true:
			toggle_visibility("CanvasLayer2/Control/ColorRect/Nota_4")
		else:
			toggle_visibility("CanvasLayer2/Control/ColorRect/No_encontrada")
	elif event.is_action_pressed("GuiaCaracteres"):
		if Global.guia_encontrada == true:
			toggle_visibility("CanvasLayer2/Control/ColorRect/Guia_caracteres")
		else:
			toggle_visibility("CanvasLayer2/Control/ColorRect/No_encontrada")


func toggle_visibility(nota_name):
	var nota = get_node(nota_name)
	if nota == null:
		print("Node not found: " + nota_name)
		return
	
	if MenuNotas.visible:
		MenuNotas.hide()
		nota.hide()
	else:
		MenuNotas.show()
		nota.show()
