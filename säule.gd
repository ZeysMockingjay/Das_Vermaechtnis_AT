extends Node2D


# Called when the node enters the scene tree for the first time.
var state = "including_clue"
var player_in_area = false
var clue = preload("res://clue_collectable.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == "excluding_clue":
		$AnimatedSprite2D.play("Clue_empty")
	if state == "including_clue":
		$AnimatedSprite2D.play("Clue_full")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "excluding_clue"
				$AnimatedSprite2D.play("Clue_empty")
				drop_clue()
				
				


func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true

func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
		
func drop_clue():
	var clue_instance = clue.instantiate()
	clue_instance.global_position = $Marker2D.global_position
	get_parent().add_child(clue_instance)
	
	await get_tree().create_timer(3).timeout
	
