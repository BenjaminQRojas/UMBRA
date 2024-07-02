extends Node

var url = "https://ucn-game-server.martux.cl/scores"
var api_key: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzVjMzliZS1iNGJlLTRhNDgtYTIwMy03NzhkNDZkNzc1NjEiLCJrZXkiOiJDY1RzRVpWVXlEU2VMZnU4MmFaWHNMTXQzIiwiaWF0IjoxNzE5NDYxNTMzLCJleHAiOjE3NTA5OTc1MzN9.tLk9cTCOg0ENw00sMCW6qNJ9e0Tfvzt__IxLqWSAJtg"
var score = 3

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $TileMap/OnlineCharcter
@onready var http_request = $HTTPRequest
@onready var playerName_input = $UI/Control/VBoxContainer/LineEdit
@onready var timer = $Timer
var scorePlayer := 0

func _ready():
	player.connect("scoreUp",subirScore)
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	
	http_request.request_completed.connect(Callable(self, "_on_request_completed"))
	
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.start()

func subirScore():
	scorePlayer+=1
	$Score/Label.text = str(scorePlayer)
	pass

func menu_terminado():
	Global.score_MP = score
	$UI/ColorRect.show()
	$UI/VBoxContainer.show()
	
func _input(event):
	if event.is_action_pressed("guardar_datos"):
		$UI/ColorRect.hide()
		$UI/VBoxContainer.hide()
	

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

func eliminar_datos():
	var headers = [
		"Authorization: Bearer " + api_key
	]
	var eliminados = http_request.request(url, headers, HTTPClient.METHOD_DELETE)
	if eliminados != OK:
		print("Error al enviar la solicitud HTTP DELETE: %s" % str(eliminados))
	else:
		print("Solicitud HTTP DELETE enviada con éxito")	

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
	$VBoxContainer/Label2.text = list



func _on_timer_timeout():
	menu_terminado()
