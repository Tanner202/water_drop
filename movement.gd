extends CharacterBody2D

@export var horizontal_accel := 2000.0
@export var drag_force := 1000.0
@export var max_horizontal_speed := 800.0
@export var dead_zone := 8.0

var target_x: float
var prev_target_x: float = 0
var touching := false

func _ready():
	target_x = global_position.x
	LevelManager.start_level.connect(on_level_started)

func _input(event):
	if event is InputEventScreenTouch:
		touching = event.pressed
		if touching:
			target_x = get_global_mouse_position().x

	if event is InputEventScreenDrag:
		prev_target_x = target_x
		target_x = event.position.x

func _physics_process(delta):
	if touching:
		var accel = sign(target_x - prev_target_x) * horizontal_accel * delta
		velocity.x += accel
	else:
		velocity.x = move_toward(velocity.x, 0.0, drag_force * delta)

	# Clamp speed
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)

	var collision = move_and_collide(velocity * delta)
	if collision:
		LevelManager.end()
		await get_tree().create_timer(2).timeout
		LevelManager.restart_level()

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Win")
	LevelManager.end()

func on_level_started():
	velocity.y = 1000
