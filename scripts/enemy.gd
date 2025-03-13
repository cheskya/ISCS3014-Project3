extends Area2D

@export var enemy_bullet_scene: PackedScene = preload("res://scenes/enemybullet.tscn")
@onready var animated_sprite = $AnimatedSprite2D
@onready var detection_area = $DetectionArea
@onready var hit_allow_timer = $HitAllow
@onready var shoot_allow_timer = $ShootAllow

var moving = true
var hit_allow = true

var speed = 130
var health = 3

func _ready() -> void:
	add_to_group("enemies")

	shoot_allow_timer.start()
	shoot_allow_timer.timeout.connect(shoot)

func _physics_process(delta: float) -> void:
	if moving:
		translate(Vector2.DOWN * speed * delta)

func shoot():
	if enemy_bullet_scene:
		var bullet = enemy_bullet_scene.instantiate()
		bullet.global_position = global_position 
		bullet.add_to_group("enemybullet") 
		get_parent().add_child(bullet)

func enemy_hit(player: CharacterBody2D, is_player_func: bool):
	if hit_allow:
		health -= 1
		hit_allow = false
		hit_allow_timer.start()
	
		if health == 0:
			moving = false
			hit_allow = false
			
			detection_area.queue_free()
			
			if not is_player_func and player:
				player.player_hit(self, true)
			
			animated_sprite.play("death")
			await animated_sprite.animation_finished
			self.queue_free()
			return
		
		if not is_player_func and player:
			player.player_hit(self, true)
		
		var tween = get_tree().create_tween()
		tween.tween_property(animated_sprite, "modulate", Color(255, 0, 0, 0.5), 0.2)
		tween.tween_property(animated_sprite, "modulate", Color(255, 255, 255, 0.5), 0.1)
		tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1, 1), 0.1)

func _on_detection_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	
	if parent.is_in_group("Player"):
		if parent.hit_allow:
			parent.hit_allow = false
			enemy_hit(parent, false)
	elif area.is_in_group("playerbullet"):
		enemy_hit(null, true)

func _on_hit_allow_timeout() -> void:
	hit_allow = true
