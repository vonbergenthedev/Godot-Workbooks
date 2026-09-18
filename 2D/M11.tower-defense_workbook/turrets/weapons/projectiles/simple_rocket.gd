@icon("res://icons/icon_rocket.svg")
class_name SimpleRocket extends Area2D


@export var rocket_speed := 550.0
@export var max_distance := 800.0
@export var damage := 20


var _rocket_travel_distance := 0.0


func _init() -> void:
	monitorable = false


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	position += transform.x * rocket_speed * delta
	_rocket_travel_distance += rocket_speed * delta

	
	if max_distance < _rocket_travel_distance:
		_explode()


func _on_area_entered(other_area: Area2D) -> void:
	if other_area is DefaultMob:
		other_area.take_damage(damage)
		_explode()


func _explode() -> void:
	queue_free()
