extends Panel


@onready var clue_visual: Sprite2D = $clue_display

func update(item: DiaItem):
	if !item: 
		clue_visual.visible = false
	else:
		clue_visual.visible = true
		clue_visual.texture = item.texture
