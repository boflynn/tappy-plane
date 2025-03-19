extends Node

var background_movement_speed: int = 700
var health_decrease_speed: int = 3
var health: float = 100
var score: float = 0

func _process(delta: float):
	for lefty in get_tree().get_nodes_in_group("lefties"):
		lefty.position.x -= delta * background_movement_speed

	if health > health_decrease_speed:
		health -= delta * health_decrease_speed
		$UI/HealthBar.value = health

	score += delta
	var formatted_score: String = str(score)
	var decimal_index: int = formatted_score.find(".")
	formatted_score = formatted_score.left(decimal_index + 3)
	$UI/HealthBar/ScoreLabel.text = formatted_score
