extends Node

var speed: int = 700
# TODO - Any way to better determine this?
var width: int = 3200

func _process(delta: float):
	for lefty in get_tree().get_nodes_in_group("lefties"):
		lefty.position.x -= delta * speed
	
