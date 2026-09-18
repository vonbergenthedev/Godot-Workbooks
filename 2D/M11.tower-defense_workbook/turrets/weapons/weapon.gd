@icon("res://icons/icon_weapon.svg")
class_name Weapon extends Sprite2D


@export var weapon_mob_detection_default_range := 400.0
@export var attack_rate := 1.0

var _area2d: Area2D = _create_new_area2d()

@onready var _collisionshape2d = _create_new_collisionshape2d()
@onready var _timer := _create_timer()


func _ready() -> void:
	# Adding Nodes for weapon area and a shape for detection to scene
	add_child(_area2d)
	_area2d.add_child(_collisionshape2d)
	
	# Adding Timer node to control the fire rate of the weapon
	add_child(_timer)
	_timer.start()
	_timer.timeout.connect(_attack)
	
	# Set so all weapons draw on top of their respective projectiles
	z_index = 10
	

func _create_new_area2d() -> Area2D:
	var area := Area2D.new()
	
	area.monitorable = false
	#area.monitoring = true
	
	return area


func _create_new_collisionshape2d() -> CollisionShape2D:
	var collision_shape := CollisionShape2D.new()
	
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = weapon_mob_detection_default_range
	
	return collision_shape


func _create_timer() -> Timer:
	var timer := Timer.new()
	
	timer.wait_time = 1.0 / attack_rate
	
	return timer


func _attack() -> void:
	pass
