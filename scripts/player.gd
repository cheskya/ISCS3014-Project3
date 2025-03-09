extends CharacterBody2D

@export var speed = 250

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var move = Input.get_vector("left", "right", "up", "down")
	
	if move[0] == 0:
		animated_sprite.play("idle")
	elif move[0] > 0:
		animated_sprite.play("move_right")
	elif move[0] < 0:
		animated_sprite.play("move_left")
	
	if move:
		velocity = move * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
