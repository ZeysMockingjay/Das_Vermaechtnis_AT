extends Control

@onready var dia: Dia = preload("res://Assets/diary/playerdia.tres")
@onready var slots: Array = $TextureRect/GridContainer.get_children()


var is_open = false

func _ready():
	dia.update.connect(update_slots())
	update_slots()
	close()
	
func update_slots():
		for i in range(min(dia.slots.size(), slots.size())):
			slots[i].update(dia.slots[i])

func _process(delta):
	if Input.is_action_just_pressed("Space"):
		if is_open:
			close()
		else:
			open()
	
func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
