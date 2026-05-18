extends Camera2D

@export var target: Node2D

func _process(delta: float) -> void:
	if LevelManager.get_state() == LevelManager.State.LIVE:
		global_position.y = target.global_position.y
