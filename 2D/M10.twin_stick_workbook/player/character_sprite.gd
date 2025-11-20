extends Sprite2D

const GODOT_BOTTOM := preload("res://player/godot_bottom.png")
const GODOT_BOTTOM_RIGHT := preload("res://player/godot_bottom_right.png")
const GODOT_RIGHT := preload("res://player/godot_right.png")
const GODOT_UP := preload("res://player/godot_up.png")
const GODOT_UP_RIGHT := preload("res://player/godot_up_right.png")
const VECTOR_UP_RIGHT = Vector2.UP + Vector2.RIGHT
const VECTOR_DOWN_RIGHT = Vector2.DOWN + Vector2.RIGHT
const VECTOR_UP_LEFT = Vector2.UP + Vector2.LEFT
const VECTOR_DOWN_LEFT = Vector2.DOWN + Vector2.LEFT

func _ready() -> void:
	texture =  GODOT_BOTTOM

func _process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var discrete_sign_direction := direction.sign()

	match discrete_sign_direction:
		Vector2.DOWN:
			texture = GODOT_BOTTOM

		Vector2.UP:
			texture = GODOT_UP

		Vector2.RIGHT, Vector2.LEFT:
			texture = GODOT_RIGHT

		VECTOR_UP_RIGHT, VECTOR_UP_LEFT:
			texture = GODOT_UP_RIGHT

		VECTOR_DOWN_RIGHT, VECTOR_DOWN_LEFT:
			texture = GODOT_BOTTOM_RIGHT

	if discrete_sign_direction.length() > 0:
		flip_h = discrete_sign_direction.x < 0.0
