extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

var speed = 130
var health = 1

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	translate(Vector2.DOWN * speed * delta)

func _on_detection_area_entered(area: Area2D) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(animated_sprite, "modulate", Color(255, 0, 0, 0.5), 0.2)
	tween.tween_property(animated_sprite, "modulate", Color(255, 255, 255, 0.5), 0.2)
	tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1, 1), 0.1)
	
	if health == 0:
		print("enemy dieded")
	else:
		health -= 1
