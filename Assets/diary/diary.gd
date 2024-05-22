extends Resource

class_name Dia

signal update

@export var slots: Array[DiaSlot]

func insert(item: DiaItem): #VIELLEICHT item STATT clue
	var itemslots = slots.filter(func(slot):return slot.item == item)  #VIELLEICHT item STATT clue 
	if !itemslots.is_empty():
		itemslots[0].amout += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null) #VIELLEICHT item STATT clue 
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()
