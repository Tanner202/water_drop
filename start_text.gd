extends Label

var direction = -1

func _ready() -> void:
	LevelManager.start_level.connect(on_start_level)

func _process(delta: float) -> void:
	modulate.a += direction * delta
	
	if modulate.a <= 0:
		direction = 1
	elif modulate.a >= 1:
		direction = -1

func on_start_level():
	visible = false
