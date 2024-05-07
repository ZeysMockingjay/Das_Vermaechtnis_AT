#SKRIPT VON WELT 1 NODE

extends Node2D


var entered = false

func _on_Area2D_body_entered(body: CharacterBody2D) -> void:
	entered = true

func _on_Area2D_body_exited(body: CharacterBody2D) -> void:
	entered = false

func _ready():
	
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	connect("body_exited", Callable(self, "_on_Area2D_body_exited"))
	

func _physics_process(_delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("ui_accept"):
			TransitionScreen.transition()
			#await TransitionScreen.on_transition_finished()
			get_tree().change_scene_to_file("res://Test_level_levelchangetest.tscn")
