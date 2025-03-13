extends Area2D

@export var speed = 400
@export var explosion_scale : Vector2 = Vector2(3,3)
@onready var animation = $AnimatedSprite2D
var has_hit = false

func _ready() -> void:
	animation.play("default")
	add_to_group("enemybullet")

func _physics_process(delta: float) -> void:
	if not has_hit:
		translate(Vector2.DOWN * speed * delta)
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if area.hit_allow:
			area.player_hit(self, true)  
			has_hit = true  
			self.scale = explosion_scale
			animation.play("explosion")
			await animation.animation_finished
			self.queue_free()
