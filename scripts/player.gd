extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var player_detection = $PlayerDetection
@onready var hit_allow_timer = $HitAllow

var moving = true
var hit_allow = true

var speed = 280
var health = 3

var enemies = null

func player_hit(enemy: Area2D, is_enemy_func: bool):
	health -= 1
	
	if health == 0:
		moving = false
		animated_sprite.play("death")
		
		if not is_enemy_func:
			enemy.enemy_hit(self, true)
		
		await animated_sprite.animation_finished

		position.x = 305
		position.y = 764
		animated_sprite.play("straight")
		moving = true
		health = 3
		hit_allow_timer.start(1)
		return
	
	hit_allow_timer.start(1)
	
	if not is_enemy_func:
		enemy.enemy_hit(self, true)
	
	var tween = get_tree().create_tween()
	tween.tween_property(animated_sprite, "modulate", Color(255, 0, 0, 0.5), 0.4)
	tween.tween_property(animated_sprite, "modulate", Color(255, 255, 255, 0.5), 0.4)
	tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1, 1), 0.2)

func _physics_process(delta: float) -> void:
	enemies = get_tree().get_nodes_in_group("enemies")
	
	if moving:
		var viewport_size = get_viewport().size
		
		var camera_left = 35
		var camera_right = viewport_size.x - 35
		var camera_up = 65
		var camera_down = viewport_size.y - 15
		
		var player_pos = position
		player_pos.x = clamp(player_pos.x, camera_left, camera_right)
		player_pos.y = clamp(player_pos.y, camera_up, camera_down)
		
		position = player_pos
		
		var move = Input.get_vector("left", "right", "up", "down")
		
		if move[0] == 0:
			animated_sprite.play("straight")
		elif move[0] > 0:
			animated_sprite.play("move_right")
		elif move[0] < 0:
			animated_sprite.play("move_left")
		
		if move:
			velocity = move * speed
		else:
			velocity = Vector2.ZERO
		move_and_slide()

func _on_hit_allow_timeout() -> void:
	hit_allow = true
	for enemy in enemies:
		if player_detection.overlaps_area(enemy) and enemy.hit_allow:
			hit_allow = false
			player_hit(enemy, false)
