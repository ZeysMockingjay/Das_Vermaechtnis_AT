extends CharacterBody2D

class_name Player

const GRAVITY : int = 500

@export var dia: Dia
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta  # Apply gravity

	# Reset horizontal velocity before checking input
	velocity.x = 0
#----------------SPIELER LAUF GESCHWIDNIGKEIT---------------
	# Handle horizontal movement input
	if Input.is_action_pressed("playermoveright"):
		velocity.x = 45  # Set horizontal speed for moving right
		animated_sprite.flip_h = false
	elif Input.is_action_pressed("playermoveleft"):
		velocity.x = -45  # Set horizontal speed for moving left
		animated_sprite.flip_h = true

	# Quit game if the 'closegame' action is pressed
	if Input.is_action_pressed("closegame"):
		get_tree().quit()

	# Move and slide, no arguments needed
	move_and_slide()

	# Check if the player is on the floor and update animations based on actual movement
	if is_on_floor():
		if velocity.x == 0 or (velocity.x != 0 and is_on_wall()):
			animated_sprite.play("idle")  # Play idle animation if there's no effective horizontal movement or if stuck on a wall
		else:
			animated_sprite.play("run")  # Play running animation if moving horizontally
			
func collect(clue):
	dia.insert(clue)
