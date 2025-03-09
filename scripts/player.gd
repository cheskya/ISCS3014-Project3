extends CharacterBody2D

@export var speed = 280

@onready var animated_sprite = $AnimatedSprite2D

var health = 3

func _physics_process(delta: float) -> void:
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
	if health == 0:
		print("player dieded")
	else:
		health -= 1
