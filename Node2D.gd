extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayerNode/AnimationPlayer #HIER VERVOLLSTÄNDIGE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Bike")

func play_anim(Cutscene1_Intro_Anim) -> void:
	anim.play(Cutscene1_Intro_Anim)

func stop_anim() -> void:
	anim.stop()

#NOTIZEN: 
# Animation Name entweder Cutscene1_Intro_Anim oder Bike
#
#
#
#
#
