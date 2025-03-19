extends Node2D

var speed: int = 700
# TODO - Any way to better determine this?
var width: int = 3200

func _process(delta: float):
	position.x -= delta * speed
	
	if position.x < -width / 2:
			position.x += width / 2
