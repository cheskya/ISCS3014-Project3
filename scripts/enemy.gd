extends Area2D

var speed = 130

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	translate(Vector2.DOWN * speed * delta)
