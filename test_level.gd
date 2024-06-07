extends Node2D

var entered = false

func _on_Area2D_body_entered(body: Node) -> void:
	entered = true

func _on_Area2D_body_exited(body: Node) -> void:
	entered = false

func _ready():
	var cutscene_scene = load("res://Beginning_Animation.tscn")
	if cutscene_scene:
		var cutscene_instance = cutscene_scene.instantiate()
		add_child(cutscene_instance)
		
		var animation_player = cutscene_instance.get_node("AnimationPlayer")
		if animation_player:
			animation_player.play("Cutscene1_Intro_Anim")
			animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))
			set_physics_process(false)

	var area2d_node = $Area2D
	if area2d_node:
		area2d_node.connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
		area2d_node.connect("body_exited", Callable(self, "_on_Area2D_body_exited"))

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "Cutscene1_Intro_Anim":
		set_physics_process(true)
		var cutscene_instance = get_node("Beginning_Animation")
		if cutscene_instance:
			cutscene_instance.queue_free()

func _physics_process(_delta: float) -> void:
	if entered and Input.is_action_just_pressed("ui_accept"):
		TransitionScreen.transition()
		get_tree().change_scene_to_file("res://Test_level_levelchangetest.tscn")
