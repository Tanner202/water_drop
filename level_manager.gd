extends Node

enum State {
	WAITING,
	LIVE,
	ENDING
}

signal start_level
var state: = State.WAITING

func _ready() -> void:
	state = State.WAITING

func _input(event: InputEvent) -> void:
	if event.is_pressed() and state == State.WAITING:
		start_level.emit()
		state = State.LIVE

func end():
	state = State.ENDING

func restart_level():
	state = State.WAITING
	get_tree().reload_current_scene()

func get_state():
	return state
