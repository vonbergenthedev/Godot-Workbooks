extends Control


signal health_depleted


@onready var _heart_h_box_container: HBoxContainer = %HBoxContainer
@onready var _max_health := _heart_h_box_container.get_child_count()
@onready var _game_over_screen: ColorRect = %GameOverScreen
@onready var _restart_button: Button = %RestartButton
@onready var _quit_button: Button = %QuitButton


var player_health: set = _set_heart_level


func _ready() -> void:
	_set_heart_level(_max_health)
	
	_restart_button.pressed.connect(func() -> void: 
		get_tree().reload_current_scene.call_deferred()
		_set_heart_level(_max_health)
		_game_over_screen.visible = false
		get_tree().paused = false
	)
	
	_quit_button.pressed.connect(func() -> void: 
		get_tree().quit.call_deferred()
	)
	
	## Show the UI health heart drain.
	#var tween := create_tween()
	#tween.tween_property(self, "_player_health", 0, 5)


func _set_heart_level(current_heart_level: int) -> void:
	player_health = clampi(current_heart_level, 0, _max_health)
	
	for child in _heart_h_box_container.get_children():
		child.visible = player_health > child.get_index()
	
	if player_health == 0:
		health_depleted.emit()
		get_tree().paused = true
		_game_over_screen.visible = true
