extends Area2D

var speed = 110

func _physics_process(delta: float) -> void:
	translate(Vector2.DOWN * speed * delta)
