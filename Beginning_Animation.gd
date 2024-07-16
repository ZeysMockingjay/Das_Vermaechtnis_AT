extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_animation_finished(anim_name: String):
	if anim_name == "Cutscene1_Intro_Anim":
		get_tree().change_scene_to_file("res://test_level.tscn")
