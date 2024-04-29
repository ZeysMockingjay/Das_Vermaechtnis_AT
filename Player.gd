extends CharacterBody2D

const GRAVITY : int = 500 #OG 200

func _physics_process(delta):
	velocity.y += GRAVITY * delta  # Continuously apply gravity to simulate falling or staying on the ground

	# Reset horizontal velocity before checking input
	velocity.x = 0

	# Handle horizontal movement input
	if Input.is_action_pressed("playermoveright"):
		velocity.x = 100  # Set horizontal speed for moving right
	elif Input.is_action_pressed("playermoveleft"):
		velocity.x = -100  # Set horizontal speed for moving left

	# Update animation based on current velocity state
	if is_on_floor():
		if velocity.x != 0:
			$AnimatedSprite2D.play("run")  # Play running animation if moving horizontally
		else:
			$AnimatedSprite2D.play("idle")  # Play idle animation if not moving horizontally

	# Execute the movement
	move_and_slide()
