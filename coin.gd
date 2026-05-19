extends Node2D

signal coin_collected

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	var player: Player = body
	player.collect_coin()
	queue_free()
