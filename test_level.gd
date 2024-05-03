extends Node2D


var entered = false

func _on_Area2D_body_entered(body: CharacterBody2D) -> void:
	entered = true

func _on_Area2D_body_exited(body: CharacterBody2D) -> void:
	entered = false

func _ready():
	
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	connect("body_exited", Callable(self, "_on_Area2D_body_exited"))
	
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	
	# Correctly connect signals using Callable
	

func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
	
	 


func _physics_process(_delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("ui_accept"):
			TransitionScreen.transition()
			#await TransitionScreen.on_transition_finished()
			get_tree().change_scene_to_file("res://Test_level_levelchangetest.tscn")
