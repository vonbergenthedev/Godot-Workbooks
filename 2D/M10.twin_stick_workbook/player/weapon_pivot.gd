extends Node2D


func _process(_delta: float) -> void:
	var direction_to_pivot := global_position.direction_to(get_global_mouse_position())
	
	rotation = direction_to_pivot.angle()
