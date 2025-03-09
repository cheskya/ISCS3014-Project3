extends Area2D

var speed = 130

func _physics_process(delta: float) -> void:
	translate(Vector2.DOWN * speed * delta)
