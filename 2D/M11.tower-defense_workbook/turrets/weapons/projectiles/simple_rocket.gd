@icon("res://icons/icon_rocket.svg")
class_name SimpleRocket extends Area2D


@export var rocket_speed := 300.0
@export var rocket_max_distance := 600.0


var _distance_travelled := 0.0


func _ready() -> void:
	monitorable = false


func _physics_process(delta: float) -> void:
	var speed := rocket_speed * delta
	position += transform.x * speed
	_distance_travelled += speed
	
	if _distance_travelled > rocket_max_distance:
		_explode()


func _explode() -> void:
	queue_free()
