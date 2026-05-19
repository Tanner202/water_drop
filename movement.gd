class_name Player extends CharacterBody2D

const FALLING_ACCEL := 500
const MAX_VERTICAL_SPEED := 1500
const MAX_HORIZONTAL_SPEED := 600.0
const ACCEL := 4000.0
const DECEL := 4200.0

# Makes direction changes feel slightly soft
const TURN_MULTIPLIER := 0.7

# Visual tilt
const MAX_ROTATION := 0.2
const ROTATION_SPEED := 8.0

var target_x: float
var prev_target_x: float = 0
var direction: = 0
var touching := false
var level_started = false
var coins_collected = 0

signal coin_collected(amount)

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
	if !level_started: return
	
	var input_dir := Input.get_axis("left", "right")
	var target_speed := input_dir * MAX_HORIZONTAL_SPEED

	# -------------------------
	# Horizontal movement
	# -------------------------
	if input_dir != 0:

		# Slightly softer when changing directions
		var accel := ACCEL

		if sign(input_dir) != sign(velocity.x) and velocity.x != 0:
			accel *= TURN_MULTIPLIER

		velocity.x = move_toward(
			velocity.x,
			target_speed,
			accel * delta
		)

	else:
		# Fast stop = responsive dodging
		velocity.x = move_toward(
			velocity.x,
			0,
			DECEL * delta
		)
	
	velocity.y = move_toward(
		velocity.y,
		MAX_VERTICAL_SPEED,
		FALLING_ACCEL * delta
	)

	# -------------------------
	# Visual rotation
	# -------------------------
	var target_rotation := (velocity.x / MAX_HORIZONTAL_SPEED) * MAX_ROTATION

	rotation = lerp(
		rotation,
		target_rotation,
		ROTATION_SPEED * delta
	)

	var collision = move_and_collide(velocity * delta)
	if collision:
		LevelManager.end()
		await get_tree().create_timer(2).timeout
		LevelManager.restart_level()

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Win")
	LevelManager.end()

func collect_coin():
	coins_collected += 1
	coin_collected.emit(coins_collected)

func on_level_started():
	level_started = true
