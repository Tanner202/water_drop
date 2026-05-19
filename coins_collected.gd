extends Label

@export var player: Player

func _ready() -> void:
	player.coin_collected.connect(on_coin_collected)

func on_coin_collected(amount):
	text = str(amount)
