extends Panel


@onready var clue_visual: Sprite2D = $clue_display

func update(slot: DiaSlot):
	if !slot.clue: 
		clue_visual.visible = false
	else:
		clue_visual.visible = true
		clue_visual.texture = slot.clue.texture
