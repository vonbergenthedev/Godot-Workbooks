extends Node2D

func _process(_delta: float) -> void:
	var aim_direction := global_position.direction_to(get_global_mouse_position())
	
	if aim_direction.length() > 0.1:
		rotation = aim_direction.angle()
