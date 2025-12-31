extends Area2D

var movement_speed := 1500

func _process(delta: float) -> void:
	global_position.y -= movement_speed * delta
