extends Area2D

var speed = 130
var health = 1

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	translate(Vector2.DOWN * speed * delta)

func _on_detection_area_entered(area: Area2D) -> void:
	if health == 0:
		print("enemy dieded")
	else:
		health -= 1
