extends CharacterBody2D

@export var max_speed := 400.0
@export var acceleration := 1200.0
@export var deceleration := 1080.0

@onready var _runner_visual_purple: RunnerVisual = %RunnerVisualPurple
@onready var _dust: GPUParticles2D = %Dust
@onready var _hit_box: Area2D = $HitBox

func _ready() -> void:
	make_idle()
	
	_hit_box.body_entered.connect(func(body: Node) -> void:
		if body is Runner:
			get_tree().reload_current_scene.call_deferred()
	)

func _physics_process(delta: float) -> void:
	var direction_to_target := global_position.direction_to(get_global_player_position())
	var distance_to_target := global_position.distance_to(get_global_player_position())
	var speed := max_speed if distance_to_target > 100 else max_speed * distance_to_target / 100
	var desired_velocity := direction_to_target * speed
	
	velocity = velocity.move_toward(desired_velocity, acceleration * delta)

	move_and_slide()
	
	if velocity.length() > 50.0:
		_runner_visual_purple.angle = rotate_toward(_runner_visual_purple.angle, direction_to_target.orthogonal().angle(), 8.0 * delta)
		var current_speed_percent := velocity.length() / max_speed
		_runner_visual_purple.animation_name = (RunnerVisual.Animations.WALK if current_speed_percent < 0.8 else RunnerVisual.Animations.RUN)
		_dust.emitting = true
	else:
		make_idle()
		
	if distance_to_target < 50.0:
		make_idle()

func get_global_player_position() -> Vector2:
	return get_tree().root.get_node("Game/Runner").global_position

func make_idle() -> void:
	_runner_visual_purple.animation_name = RunnerVisual.Animations.IDLE
	_dust.emitting = false
