extends CollisionShape2D

signal interaction_started
signal interaction_ended

@onready var canvas_layer = $"CanvasLayerBook"


var player_in_range = false

func _ready():
	print("Script is running")
	if not initialize_nodes():
		print("Failed to initialize all nodes. Check your scene structure.")
		return

	var parent_area = get_parent()
	if parent_area and parent_area is Area2D:
		parent_area.body_entered.connect(_on_body_entered)
		parent_area.body_exited.connect(_on_body_exited)
		print("Connected to parent Area2D")
	else:
		print("Parent is not an Area2D. Check your scene structure.")

func initialize_nodes() -> bool:
	if not canvas_layer:
		print("CanvasLayer not found")
		return false
	
	
	print("All nodes initialized successfully")
	return true

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		print("Player entered range")
		interaction_started.emit()

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		print("Player exited range")
		interaction_ended.emit()
		canvas_layer.visible = false
		

func _process(delta):
	if player_in_range:
		if Input.is_action_just_pressed("e"): 
			canvas_layer.visible = (!canvas_layer.visible)

