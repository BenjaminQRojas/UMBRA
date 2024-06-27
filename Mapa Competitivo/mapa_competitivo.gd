extends Node

var url = "https://ucn-game-server.martux.cl/scores"

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $TileMap/OnlineCharcter
@onready var http_request = $HTTPRequest

func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	
	$HTTPRequest.request_completed.connect(_on_request_completed)
	


func juego_iniciado():
	var headers = ["Content-Type: application/json"]
	http_request.request(url, headers, HTTPClient.METHOD_GET)

func juego_terminado(nickname, ptj):
	var headers = ["Content-Type: application/json"]
	var body = {"playername": nickname, "score": ptj}
	#var json_body = to_json(body)
	http_request.request(url, headers, HTTPClient.METHOD_POST, body)
	
func send_request():
	var headers = ["Content-Type: application/json"]
	http_request.request(url, headers, HTTPClient.METHOD_GET)
	
func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json["Godot 4.2.2"])
