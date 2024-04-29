extends Sprite2D




func _ready():
	# Make sure to capture input events
	Input.set_use_accumulated_input(true)

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			self.visible = !self.visible


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
