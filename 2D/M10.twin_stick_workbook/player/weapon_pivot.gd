extends Node2D


func _process(_delta: float) -> void:
	rotation =  global_position.direction_to(
		get_global_mouse_position()).angle()
