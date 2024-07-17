extends Area2D

var entered = false

func _on_Area2D_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		entered = true

func _on_Area2D_body_exited(body: Node) -> void:
	if body is CharacterBody2D:
		entered = false

func _ready() -> void:
	
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	connect("body_exited", Callable(self, "_on_Area2D_body_exited"))

	
func _physics_process(_delta: float) -> void:
	if entered and Input.is_action_just_pressed("e"):
		TransitionScreen.transition()
		await TransitionScreen.on_animation_finished
		get_tree().change_scene_to_file("res://Bibliothek.tscn")

#func _on_transition_finished() -> void:
#	print("Transition finished, changing scene now.")
#	get_tree().change_scene("res://Test_level_levelchangetest.tscn")
	


