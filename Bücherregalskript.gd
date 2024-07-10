extends CollisionShape2D

var entered = false
var bib_regalview_scene = preload("res://Bib_Regalview.tscn")

func _ready() -> void:
	var parent_area = get_parent()
	if parent_area is Area2D:
		parent_area.connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
		parent_area.connect("body_exited", Callable(self, "_on_Area2D_body_exited"))
	else:
		push_error("Parent node is not an Area2D. This script should be attached to a CollisionShape2D that is a child of an Area2D.")

func _on_Area2D_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		entered = true
		print("Player entered the area")

func _on_Area2D_body_exited(body: Node) -> void:
	if body is CharacterBody2D:
		entered = false
		print("Player exited the area")

func _unhandled_input(event: InputEvent) -> void:
	if entered and event.is_action_pressed("e"):
		print("E key pressed while in area")
		open_bib_regalview()

func open_bib_regalview() -> void:
	print("Attempting to open Bib_Regalview")
	var bib_regalview_instance = bib_regalview_scene.instantiate()
	get_tree().root.add_child(bib_regalview_instance)
	print("Bib_Regalview opened")
