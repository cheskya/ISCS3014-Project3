extends Area2D

var speed = 40

func _physics_process(delta: float) -> void:
	translate(Vector2.DOWN * speed * delta)
