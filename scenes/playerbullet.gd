extends Node2D

@export var speed = 500
@export var explosion_scale : Vector2 = Vector2(3,3)
@onready var animation = $AnimatedSprite2D 
var spawn_location
var has_hit = false

func _ready() -> void:
	animation.play("default")
	add_to_group("playerbullet")
	spawn_location = get_node("../Player").global_position
	spawn_location.y -= 50
	global_translate(spawn_location)

func _physics_process(delta: float) -> void:
	if not has_hit:
		translate(Vector2.UP * speed * delta)

func _on_area_entered(area: Area2D) -> void:
	has_hit = true
	self.scale = Vector2(3,3)
	animation.play("explosion")
	await animation.animation_finished
	self.queue_free()
