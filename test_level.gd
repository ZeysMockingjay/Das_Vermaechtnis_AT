extends Node2D

var entered = false

func _on_Area2D_body_entered(body: CharacterBody2D) -> void:
	entered = true

func _on_Area2D_body_exited(body: CharacterBody2D) -> void:
	entered = false

func _ready():
	# Load the scene containing the AnimationPlayer
	var cutscene_scene = load("res://Beginning_Animation.tscn")
	if cutscene_scene:
		var cutscene_instance = cutscene_scene.instantiate()
		add_child(cutscene_instance)
		
		# Get the AnimationPlayer node from the instantiated scene
		var animation_player = cutscene_instance.get_node("AnimationPlayer")
		
		# Debug: print the node to verify it exists
		print(animation_player)
		if animation_player:
			# Play the animation
			animation_player.play("Cutscene1_Intro_Anim")
			# Connect the animation_finished signal to a function
			animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))
			# Initially disable gameplay elements
			set_physics_process(false)
		else:
			print("AnimationPlayer node not found!")
	else:
		print("Failed to load cutscene scene!")

	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	connect("body_exited", Callable(self, "_on_Area2D_body_exited"))

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "Cutscene1_Intro_Anim":
		# Enable gameplay elements after the animation finishes
		set_physics_process(true)

func _physics_process(_delta: float) -> void:
	if entered:
		if Input.is_action_just_pressed("ui_accept"):
			TransitionScreen.transition()
			# await TransitionScreen.on_transition_finished()
			get_tree().change_scene_to_file("res://Test_level_levelchangetest.tscn")
