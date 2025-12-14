extends Node2D

var touching_screen: bool
var starting_x_pos := 0.0
var starting_char_x_pos := 0.0
var current_delta := 0.0

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			touching_screen = true
			starting_x_pos = event.position.x
			starting_char_x_pos = global_position.x
		else:
			touching_screen = false
			current_delta = 0
	elif event is InputEventScreenDrag and touching_screen:
		current_delta = event.position.x - starting_x_pos
		position.x = starting_char_x_pos + current_delta
