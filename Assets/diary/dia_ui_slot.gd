extends Panel


@onready var clue_visual: Sprite2D = $clue_display
@onready var amount_text: Label = $Label

func update(slot: DiaSlot):
	if !slot.clue: 
		clue_visual.visible = false
		amount_text.visible = false
	else:
		clue_visual.visible = true
		clue_visual.texture = slot.clue.texture
		amount_text.visible = true
		amount_text.text = str(slot.amount)
