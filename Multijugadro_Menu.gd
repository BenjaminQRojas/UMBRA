extends Control

var url = "https://ucn-game-server.martux.cl/scores"
var api_key: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzVjMzliZS1iNGJlLTRhNDgtYTIwMy03NzhkNDZkNzc1NjEiLCJrZXkiOiJDY1RzRVpWVXlEU2VMZnU4MmFaWHNMTXQzIiwiaWF0IjoxNzE5NDYxNTMzLCJleHAiOjE3NTA5OTc1MzN9.tLk9cTCOg0ENw00sMCW6qNJ9e0Tfvzt__IxLqWSAJtg"

@onready var http_request = $HTTPRequest
@onready var playerName_node = $VBoxContainer/LineEdit
@onready var timer = $Timer
@onready var timer2 = $Timer2


var termino =  Global.termino_MP
var playerName = ""

func _input(event):
	if event.is_action_pressed("guardar_datos"):
		http_request.request_completed.connect(Callable(self, "_on_request_completed"))
		visible = true
		juego_iniciado()
		playerName_node.max_length = 10
		timer2.wait_time = 1.0
		timer2.one_shot = true
		timer2.start()


func _on_button_pressed():
	playerName = playerName_node.get_text()
	var score = Global.score_MP
	juego_terminado(playerName, score)
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.start()
	
	
	
func juego_iniciado():
	var headers = [
		"Authorization: Bearer " + api_key
	]
	var error = http_request.request(url, headers, HTTPClient.METHOD_GET)
	if error != OK:
		print("Error al enviar la solicitud HTTP GET: %s" % str(error))
	else: 
		print("Solicitud HTTP GET enviada con éxito")

func juego_terminado(nickname, ptj):
	
	
	var headers = ["Content-type: application/json", "Authorization: Bearer " + api_key]
	
	var json_body = {
		"playerName": nickname,
		"score": int(ptj)
	}
	
	var body = JSON.stringify(json_body)
	
	var send_data = http_request.request(url, headers, HTTPClient.METHOD_POST, body)
	
	if send_data != OK:
		print("Hay un error al enviar la solicitud HTTP POST: %s" % str(send_data))
	else:
		print("Solicitud HTTP POST enviada con éxito")

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	if json.has("data"):
		print(json["data"])
		actualizar_lista_scores(json["data"])
	else:
		print("El JSON devuelto no contiene la clave 'data'")
		actualizar_lista_scores("No hay puntajes guardados.")

func actualizar_lista_scores(data):
	var list = ""
	
	if typeof(data) == TYPE_ARRAY and data.size() >= 1:
		for i in range(data.size()):
			var player = data[i]
			list += "%s, %d\n" % [player["playerName"], player["score"]]
	elif typeof(data) == TYPE_DICTIONARY:
		juego_iniciado()
		pass
		#list += "%s, %d\n" % [data["playerName"], data["score"]]
	elif typeof(data) == TYPE_ARRAY and data.size() == 0:
		list = "No hay puntajes."
	else:
		list = "No hay puntajes."
	$VBoxContainer2/Label2.text = list


func _on_timer_timeout():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu/Escenas/Test.tscn")


func _on_timer_2_timeout():
	get_tree().paused = true
