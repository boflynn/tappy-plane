extends Node

@export var obstacle: PackedScene

var background_movement_speed: int = 700
var health_decrease_speed: int = 3
var health: float = 100
var score: float = 0
var spawned_obstacle_position_x: int = 1700

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

func _on_spawner_timer_timeout() -> void:
	var top: bool = randi() % 2 == 0
	var obstacle_instance : Area2D = obstacle.instantiate()
	obstacle_instance.position.x = spawned_obstacle_position_x

	if top:
		obstacle_instance.position.y = 200
	else:
		obstacle_instance.position.y = 800
		obstacle_instance.scale.y *= -1

	add_child(obstacle_instance)
