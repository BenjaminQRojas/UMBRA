extends PointLight2D


func _ready():
	self.enabled = false
	
func _physics_process(delta):
	if Input.is_action_just_pressed("Flashlight"):
		if self.enabled == false:
			self.enabled = true
		else: 
			self.enabled = false
