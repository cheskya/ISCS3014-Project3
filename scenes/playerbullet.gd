extends Node2D

@export var speed = 500
var spawn_location

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("playerbullet")
	spawn_location = get_node("../Player").global_position
	spawn_location.y -= 50
	global_translate(spawn_location)
	pass

func _physics_process(delta: float) -> void:
	translate(Vector2.UP * speed * delta)
