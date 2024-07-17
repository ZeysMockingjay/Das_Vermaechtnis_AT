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
	#der shit war für nen anderes portal system das kacke is
	#if NavigationManager.spawn_door_tag != null:
		#_on_level_spawn(NavigationManager.spawn_door_tag)
	#TransitionScreen.connect("on_transition_finished", Callable(self, "_on_transition_finished"))

#func _on_level_spawn(destination_tag: String) -> void:
	#var door_path: String = "Doors/Door_" + destination_tag
	#var door: Door = get_node(door_path) as Door
	#NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
	
	
func _physics_process(_delta: float) -> void:
	if entered and Input.is_action_just_pressed("e"):
		TransitionScreen.transition()
		await TransitionScreen.on_animation_finished
		get_tree().change_scene_to_file("res://Test_level_levelchangetest.tscn")

#func _on_transition_finished() -> void:
#	print("Transition finished, changing scene now.")
#	get_tree().change_scene("res://Test_level_levelchangetest.tscn")
	

