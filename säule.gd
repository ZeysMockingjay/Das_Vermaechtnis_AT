extends Node2D


# Called when the node enters the scene tree for the first time.
var state = "including_clue"
var player_in_area = false


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
				
				


func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true

func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
