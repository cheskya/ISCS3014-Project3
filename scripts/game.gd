extends Node2D

func _on_enemy_free_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies") or area.is_in_group("enemybullet"):
		area.queue_free()

func _on_player_bullet_free_zone_area_entered(area: Area2D) -> void:
	area.queue_free()
