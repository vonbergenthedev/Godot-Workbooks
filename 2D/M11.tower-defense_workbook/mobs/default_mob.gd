@icon("res://icons/icon_mob.svg")
class_name DefaultMob extends Area2D


@export var mob_health := 100: set = set_health
@export var speed := 100.0

@onready var _health_bar: ProgressBar = %HealthBar
@onready var _bar_pivot: Node2D = %BarPivot


func _ready() -> void:
	_health_bar.max_value = mob_health
	set_health(mob_health)


func _physics_process(_delta: float) -> void:
	_bar_pivot.global_rotation = 0.0


func set_health(new_health: int) -> void:
	mob_health = maxi(0, new_health)
	
	if _health_bar != null:
		_health_bar.value = mob_health
	
	if mob_health == 0:
		_die()


func take_damage(damage_amount: int) -> void:
	mob_health -= damage_amount
	var damage_indicator: DamageIndicator = preload("res://mobs/damage_indicator.tscn").instantiate()
	get_tree().current_scene.add_child(damage_indicator)
	damage_indicator.global_position = global_position
	damage_indicator.display_amount(damage_amount)
	


func _die() -> void:
	queue_free()
