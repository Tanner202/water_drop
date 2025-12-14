extends Node2D

@export var obstacle_prefab: PackedScene

func _on_timer_timeout() -> void:
	var obstacle = obstacle_prefab.instantiate()
	get_tree().root.get_node("Level").add_child(obstacle)
	obstacle.global_position.y = global_position.y
	obstacle.global_position.x = global_position.x + randf_range(-200, 200)
