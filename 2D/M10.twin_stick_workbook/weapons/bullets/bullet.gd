class_name Bullet extends Area2D

## Sets the bullet initial rotation.
@export_range(0.0, 360.0, 1.0, "radians_as_degrees") var bullet_rotation : float

## Sets the bullet initial speed.
@export var speed := 750

var max_range := 1000.0
var _traveled_distance = 0.0

func _ready() -> void:
	rotate(bullet_rotation)

func _physics_process(delta: float) -> void:
	var distance := speed * delta
	var motion := Vector2.RIGHT.rotated(rotation) * distance

	position += motion

	_traveled_distance += distance
	if _traveled_distance > max_range:
		_destroy()

func _destroy():
	queue_free()
