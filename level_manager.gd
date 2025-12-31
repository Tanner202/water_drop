extends Node

signal start_level
var started_level := false

func _input(event: InputEvent) -> void:
	if event.is_pressed() and !started_level:
		start_level.emit()
		started_level = true
