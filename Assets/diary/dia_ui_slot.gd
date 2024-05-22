extends Panel


@onready var clue_visual: Sprite2D = $clue_display
@onready var amount_text: Label = $Label

func update(slot: DiaSlot):
	if !slot.item: 
		clue_visual.visible = false
		amount_text.visible = false
	else:
		clue_visual.visible = true
		clue_visual.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true
		amount_text.text = str(slot.amount)
