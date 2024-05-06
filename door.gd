extends Area2D

class_name Door

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"

@onready var spawn = $Spawn

func _Sprite2D (body):
	if body is Player:
		print("test")  # This will print "test" when a Player1 enters the Area2D
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
#HIER MUSS DER FEHLER LIEGEN!
