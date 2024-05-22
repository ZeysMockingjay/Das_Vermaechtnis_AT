extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	entferntvonort()

func entferntvonort():
	await get_tree().create_timer(1.5).timeout
	print("+1 clue")
	queue_free()
