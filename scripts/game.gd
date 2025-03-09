extends Node2D

func _on_free_zone_area_entered(area: Area2D) -> void:
	print("memory free")
	if area.is_in_group("enemies"):
		area.queue_free()
