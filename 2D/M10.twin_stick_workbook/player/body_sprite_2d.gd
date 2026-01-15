extends Sprite2D

#Preload player sprites to display direction of movement.
const GODOT_BOTTOM = preload("uid://bw03btxpkxde4")
const GODOT_BOTTOM_RIGHT = preload("uid://cm33qabjyo48g")
const GODOT_RIGHT = preload("uid://dscj1kv8s4bxa")
const GODOT_UP = preload("uid://b2q8n8kfhhbi7")
const GODOT_UP_RIGHT = preload("uid://deiak2vt25cwr")
#Create vector directions for those that are not existing constants.
const UP_LEFT := Vector2.UP + Vector2.LEFT
const UP_RIGHT := Vector2.UP + Vector2.RIGHT
const DOWN_LEFT := Vector2.DOWN + Vector2.LEFT
const DOWN_RIGHT  := Vector2.DOWN + Vector2.RIGHT


func _process(_delta: float) -> void:
	#Detect player input
	var direction_discrete := Input.get_vector("move_left", "move_right", "move_up", "move_down").sign()
	
	#Change sprite texture to match the input direction;
	match direction_discrete:
		Vector2.LEFT, Vector2.RIGHT:
			texture = GODOT_RIGHT
		UP_LEFT, UP_RIGHT:
			texture = GODOT_UP_RIGHT
		DOWN_LEFT, DOWN_RIGHT:
			texture = GODOT_BOTTOM_RIGHT
		Vector2.UP:
			texture = GODOT_UP
		Vector2.DOWN:
			texture = GODOT_BOTTOM
			
	#Invert sprite for leftward movement
	if direction_discrete.length() > 0:
		flip_h = direction_discrete.x < 0.0
