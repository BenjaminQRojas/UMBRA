extends PointLight2D


func _ready():
	self.enabled = true
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_text_backspace"):
		if self.enabled == false:
			self.enabled = true
		else: 
			self.enabled = false