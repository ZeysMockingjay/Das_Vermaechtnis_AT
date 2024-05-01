extends Node2D

# Game variables
const PLAYER_START_POS : Vector2 = Vector2(100, 106)
#TESTconst CAM_START_POS : Vector2 = Vector2(136, 77)

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

# Initialize a new game, setting initial positions and properties
func new_game():
	$Player.position = PLAYER_START_POS
	$Player.velocity = Vector2.ZERO  # Ensure the player's velocity is reset
	#TEST$Camera2D.global_position = CAM_START_POS  # Optionally set an initial camera position
	$Boden.position = Vector2(500, 191)  # Positioning the ground if needed

# No longer modifying the player's or camera's position in _process

#Testyo Walter White yo yo nochmal yo

#Testyo Walter White yo
#huh
# (For scrolling ground in the train level?)
# if $Camera2D.position.x - $Boden.position.x > get_window().size.x * 1.5:
#    $Boden.position.x += get_window().size.x  # Reset ground position
