extends Node2D

@onready var anim : AnimationPlayer = $AnimationPlayerNode/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	if anim:
		anim.play("Bike")

func play_anim(animation_name: String):
	if anim:
		anim.play(animation_name)

func stop_anim():
	if anim:
		anim.stop()
