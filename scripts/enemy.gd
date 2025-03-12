extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var detection_area = $DetectionArea
@onready var hit_allow_timer = $HitAllow

var moving = true
var hit_allow = true

var speed = 130
var health = 3

# Modify this function to accomodate bullets
# Note: use boolean/group checkers depending on player/bullet
func enemy_hit(player: CharacterBody2D, is_player_func: bool):
	if hit_allow:
		health -= 1
		hit_allow = false
		hit_allow_timer.start()
	
		if health == 0:
			moving = false
			hit_allow = false
			
			detection_area.queue_free()
			
			if not is_player_func:
				player.player_hit(self, true)
			
			animated_sprite.play("death")
			await animated_sprite.animation_finished
			self.queue_free()
			return
		
		if not is_player_func:
			player.player_hit(self, true)
		
		var tween = get_tree().create_tween()
		tween.tween_property(animated_sprite, "modulate", Color(255, 0, 0, 0.5), 0.2)
		tween.tween_property(animated_sprite, "modulate", Color(255, 255, 255, 0.5), 0.1)
		tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1, 1), 0.1)

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	if moving:
		translate(Vector2.DOWN * speed * delta)

# Modify this function to accomodate bullets
# Note: use boolean/group checkers depending on player/bullet
func _on_detection_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	
	if parent.name == "Player":
		if parent.hit_allow:
			parent.hit_allow = false
			enemy_hit(parent, false)
	elif area.is_in_group("playerbullet"):
		enemy_hit(null, true)

func _on_hit_allow_timeout() -> void:
	hit_allow = true
