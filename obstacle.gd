extends Area2D

var is_level_started := false
var movement_speed := 1500

func _ready() -> void:
	LevelManager.start_level.connect(on_level_started)

func _process(delta: float) -> void:
	if is_level_started:
		global_position.y -= movement_speed * delta

func on_level_started():
	is_level_started = true
