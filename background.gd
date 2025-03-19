extends Node2D

# TODO - Any way to better determine this?
var width: int = 3200

func _process(_delta: float):
	if position.x < -width / 2:
			position.x += width / 2
