extends CharacterBody2D

@export var horizontal_accel := 300.0
@export var drag_force := 300.0
@export var max_horizontal_speed := 600.0
@export var dead_zone := 8.0

var target_x: float
var touching := false

func _ready():
	target_x = global_position.x

func _input(event):
	if event is InputEventScreenTouch:
		touching = event.pressed
		if touching:
			target_x = get_global_mouse_position().x

	if event is InputEventScreenDrag:
		target_x = event.position.x

func _physics_process(delta):

	if touching:
		var dx = target_x - global_position.x
		var accel = dx * horizontal_accel * delta
		velocity.x += accel
		if abs(dx) < dead_zone:
			velocity.x = 0
	else:
		velocity.x = move_toward(velocity.x, 0.0, drag_force * delta)

	# Clamp speed
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)

	move_and_slide()
