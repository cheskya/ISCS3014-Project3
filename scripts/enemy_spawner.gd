extends Node2D

var enemies = [
	preload("res://scenes/enemy.tscn")
]

@onready var spawn_timer = $EnemySpawnTimer

var spawn_interval = 2.5

func _ready():
	randomize()
	spawn_timer.start(spawn_interval)

func _on_enemy_spawn_timer_timeout() -> void:
	var chosen_enemy = enemies[randi() % enemies.size()]
	var enemy = chosen_enemy.instantiate()
	
	var spawn_two = randi() % 2
	var enemy_two = null
	if spawn_two == 1:
		enemy_two = chosen_enemy.instantiate()
	
	var view_rect = get_viewport_rect()
	var x_pos = randf_range(view_rect.position.x+25, view_rect.end.x-25)
	
	enemy.position = Vector2(x_pos, position.y)
	get_tree().current_scene.add_child(enemy)
	
	if enemy_two and (x_pos <= view_rect.end.x/2-25 or x_pos >= view_rect.end.x/2+25):
		var flip_x_pos = view_rect.end.x-x_pos
		enemy_two.position = Vector2(flip_x_pos, position.y)
		get_tree().current_scene.add_child(enemy_two)

	spawn_timer.start(spawn_interval)
