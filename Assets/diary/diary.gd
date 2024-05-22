extends Resource

class_name Dia

signal update

@export var slots: Array[DiaSlot]

func insert(clue: DiaItem): #VIELLEICHT item STATT clue
	var itemslots = slots.filter(func(slot):return slot.clue == clue)  #VIELLEICHT item STATT clue 
	if !itemslots.is_empty():
		itemslots[0].amout += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.clue == null)
		if !emptyslots.is_empty():
			emptyslots[0].clue = clue
			emptyslots[0].amount = 1
	update.emit()
