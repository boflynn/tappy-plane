extends Node

@export var obstacle: PackedScene
@export var coin: PackedScene

var background_movement_speed: int = 700
var health_decrease_speed: int = 3
var health: float = 100
var score: float = 0
var spawned_obstacle_position_x: int = 1700
var coin_position_ys: Array = [280, 480, 680]

func _process(delta: float):
	for lefty in get_tree().get_nodes_in_group("lefties"):
		lefty.position.x -= delta * background_movement_speed

	if health > 0:
		health -= delta * health_decrease_speed
		$UI/HealthBar.value = health
	else:
		game_over()

	score += delta
	var formatted_score: String = str(score)
	var decimal_index: int = formatted_score.find(".")
	formatted_score = formatted_score.left(decimal_index + 3)
	$UI/HealthBar/ScoreLabel.text = formatted_score

func _on_spawner_timer_timeout() -> void:
	var top: bool = randi() % 2 == 0
	var obstacle_instance : Area2D = obstacle.instantiate()

	obstacle_instance.position.x = spawned_obstacle_position_x
	obstacle_instance.body_entered.connect(_on_obstacle_collided)

	if top:
		obstacle_instance.position.y = 200
	else:
		obstacle_instance.position.y = 800
		obstacle_instance.scale.y *= -1

	add_child(obstacle_instance)

func _on_coin_timer_timeout() -> void:
	var ypos: int = randi() % 3

	var coin_instance : Area2D = coin.instantiate()

	coin_instance.position.x = spawned_obstacle_position_x
	coin_instance.position.y = coin_position_ys[ypos]
	coin_instance.body_entered.connect(_on_coin_collided.bind(coin_instance))

	add_child(coin_instance)

func _on_coin_collided(body: Node2D, coin_instance: Area2D) -> void:
	if(!body.is_in_group("player")):
		pass
	
	health += 4
	health = clamp(health, 0, 100)
	# Is this a memory leak?
	coin_instance.get_node("AnimationPlayer").play("CoinCollected")

func _on_obstacle_collided(body: Node2D) -> void:
	if(body.is_in_group("player")):
		game_over()

func game_over() -> void:
	$GameOver.show()
	get_tree().paused = true
