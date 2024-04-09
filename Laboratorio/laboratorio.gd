extends Node

func _ready():
	Reset_Timer()
	pass

var segundos = 0
var minutos = 0
var dsegundos = 30
var dminutos = 1

func _on_Timer_timeout():
	if segundos == 0:
		if minutos > 0:
			minutos -= 1
			segundos = 60
	segundos -= 1
	
	%Label.text = String(minutos) + ":" + String(segundos)
	
func Reset_Timer():
	segundos = dsegundos
	minutos = dminutos
