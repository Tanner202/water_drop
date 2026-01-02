extends Camera2D

var movement_speed = 1000

func _process(delta: float) -> void:
	if LevelManager.get_state() == LevelManager.State.LIVE:
		global_position.y += movement_speed * delta
