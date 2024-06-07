extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(_delta: float) -> void:
		await Cutscene1_Intro_Anim.on_animation_finished
		get_tree().change_scene_to_file("res://test_level.tscn")
