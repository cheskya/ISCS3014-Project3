extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var moving = true
var speed = 280
var health = 3

func _physics_process(delta: float) -> void:
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

func _on_detection_area_entered(area: Area2D) -> void:
	health -= 1
	
	if health == 0:
		moving = false
		animated_sprite.play("death")
		await animated_sprite.animation_finished

		position.x = 305
		position.y = 764
		animated_sprite.play("straight")
		moving = true
		health = 3
		return
		
	var tween = get_tree().create_tween()
	tween.tween_property(animated_sprite, "modulate", Color(255, 0, 0, 0.5), 0.2)
	tween.tween_property(animated_sprite, "modulate", Color(255, 255, 255, 0.5), 0.2)
	tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1, 1), 0.1)
