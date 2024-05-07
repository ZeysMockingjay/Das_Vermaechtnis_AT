extends Area2D

var entered = false

func _on_Area2D_body_entered(body: CharacterBody2D) -> void:
	entered = true

func _on_Area2D_body_exited(body: CharacterBody2D) -> void:
	entered = false

func _ready():
	

	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	connect("body_exited", Callable(self, "_on_Area2D_body_exited"))


#PORTAL skript für einfachen level change.
func _physics_process(_delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://test_level.tscn")
