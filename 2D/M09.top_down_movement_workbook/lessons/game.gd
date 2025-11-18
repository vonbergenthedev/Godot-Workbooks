extends Node2D

@onready var _finish_line: FinishLine = %FinishLine
@onready var _runner: Runner = %Runner
@onready var _bouncer: CharacterBody2D = %Bouncer
@onready var _count_down: CountDown = %CountDown
@onready var _bouncer_timer: Timer = $BouncerTimer

var current_bouncer_max_speed: float = 0.0
var countdown_finished := false

func _ready() -> void:
	_runner.set_physics_process(false)
	_bouncer.set_physics_process(false)
	_count_down.start_counting()
	
	_count_down.counting_finished.connect(
		func () -> void:
			_runner.set_physics_process(true)
			_bouncer_timer.start()
			_bouncer_timer.timeout.connect(func() -> void: 
				_bouncer.set_physics_process(true)
				countdown_finished = true
			)
	)
	
	_finish_line.body_entered.connect(
		func (body: Node) -> void:
			if body is not Runner:
				return
			var runner := body as Runner

			runner.set_physics_process(false)
			var destination_position := (
				_finish_line.global_position
				+ Vector2(0, 64)
			)
			_bouncer.set_physics_process(false)
			_bouncer.make_idle()

			runner.walk_to(destination_position)
			runner.walked_to.connect(
				_finish_line.pop_confettis
			)
	)

	_finish_line.confettis_finished.connect(
		get_tree().reload_current_scene.call_deferred
	)

func _physics_process(delta: float) -> void:
	if countdown_finished and current_bouncer_max_speed < 400.0:
		current_bouncer_max_speed = move_toward(current_bouncer_max_speed, 400.0, 4.0)
		_bouncer.max_speed = current_bouncer_max_speed
