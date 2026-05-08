extends Control


@onready var _time_display: Label = %TimeDisplay
@onready var _restart_button: Button = %RestartButton
@onready var _quit_button: Button = %QuitButton


var _start_time := Time.get_ticks_msec()


func _ready() -> void:
	visible = false
	_restart_button.pressed.connect(func () -> void:
		get_tree().paused = false
		get_tree().reload_current_scene()
	)
	_quit_button.pressed.connect(get_tree().quit)



func open() -> void:
	visible = true
	get_tree().paused = true

	var end_time := Time.get_ticks_msec()
	var total_time_msec := end_time - _start_time
	var total_time_s := snappedf(total_time_msec / 1000.0, 0.1)
	_time_display.text = "Time: " + str(total_time_s) + "s"
