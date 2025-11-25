extends Node2D

var _is_joypad := false
var aim_direction: Vector2 = Vector2.ZERO


func _process(_delta: float) -> void:
	if _is_joypad:
		aim_direction = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
		
		if aim_direction.length() > 0.0:
			rotation = aim_direction.angle()
			
	else:
		aim_direction = global_position.direction_to(get_global_mouse_position())
		rotation = aim_direction.angle()
		
	z_index = 3
	if aim_direction.y < 0.0:
		z_index = 1


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion:
		_is_joypad = true
	if event is InputEventKey:
		_is_joypad = false
