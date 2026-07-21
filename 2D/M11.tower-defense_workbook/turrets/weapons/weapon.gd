@icon("res://icons/icon_weapon.svg")
class_name Weapon extends Sprite2D

## Radius for mob detection
@export var weapon_radius := 300.0


var _area_2d := _create_area_2d()
@onready var _collision_shape_area := _create_weapon_radius()


func _ready() -> void:
	add_child(_area_2d)
	_area_2d.add_child(_collision_shape_area)
	

func _create_area_2d() -> Area2D:
	var area := Area2D.new()
	# area.monitoring = true :: Default Behaviour
	area.monitoring = true
	area.monitorable = false
	return area
	

func _create_weapon_radius() -> CollisionShape2D:
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = weapon_radius
	return collision_shape
