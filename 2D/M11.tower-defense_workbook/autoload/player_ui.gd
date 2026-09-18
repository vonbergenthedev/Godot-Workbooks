class_name PlayerUI extends Control


@onready var _heart_h_box_container: HBoxContainer = %HBoxContainer
@onready var _max_health := _heart_h_box_container.get_child_count()

var _player_health: set = _set_heart_level


func _ready() -> void:
	_set_heart_level(_max_health)
	
	## Show the UI health heart drain.
	#var tween := create_tween()
	#tween.tween_property(self, "_player_health", 0, 5)


func _set_heart_level(current_heart_level: int) -> void:
	_player_health = clampi(current_heart_level, 0, _max_health)
	
	for child in _heart_h_box_container.get_children():
		child.visible = _player_health > child.get_index()
