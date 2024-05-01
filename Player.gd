extends CharacterBody2D

const GRAVITY : int = 500

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta  # Apply gravity

	# Reset horizontal velocity before checking input
	velocity.x = 0

	# Handle horizontal movement input
	if Input.is_action_pressed("playermoveright"):
		velocity.x = 100  # Set horizontal speed for moving right
	elif Input.is_action_pressed("playermoveleft"):
		velocity.x = -100  # Set horizontal speed for moving left

	# Move and slide, no arguments needed
	move_and_slide()

	# Check if the player is on the floor and update animations based on actual movement
	if is_on_floor():
		if velocity.x == 0 or (velocity.x != 0 and is_on_wall()):
			$AnimatedSprite2D.play("idle")  # Play idle animation if there's no effective horizontal movement or if stuck on a wall
		else:
			$AnimatedSprite2D.play("run")  # Play running animation if moving horizontally
