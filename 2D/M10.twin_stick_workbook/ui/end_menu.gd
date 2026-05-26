extends Control

var _start_time := Time.get_ticks_msec()


@onready var _time_display: Label = %TimeDisplay
@onready var _restart_button: Button = %RestartButton
@onready var _quit_button: Button = %QuitButton


@export var confettis_amount := 5
@export var confettis_pop_time_delay := 0.5


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
	
	end_pop()


func end_pop() -> void:
	var viewport_size := get_viewport_rect().size

	for _i in confettis_amount:
		await get_tree().create_timer(confettis_pop_time_delay).timeout
		
		var confetti: GPUParticles2D = preload("res://teleporter/confettis.tscn").instantiate()
		add_child(confetti)
		
		confetti.global_position = Vector2(randf_range(0.0, viewport_size.x), viewport_size.y)
		
		confetti.process_mode = 3
		confetti.emitting = true
