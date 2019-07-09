extends "res://Heater.gd"

func _process(delta):
	._process(delta)
	if is_on:
		$"Sprite/Sprite".frame = 1
	else:
		$"Sprite/Sprite".frame = 0