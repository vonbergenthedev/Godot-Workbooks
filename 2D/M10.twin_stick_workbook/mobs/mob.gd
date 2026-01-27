class_name Mob extends CharacterBody2D

@onready var _area: Area2D = $PlayerDetectionArea2D

## Maximum movement speed for mob.
@export var max_speed := 250.0
## Rate of acceleration for mob movement.
@export var acceleration := 1000.0
## Rate of deceleration for mob movement.
@export var deceleration := 800.0

var _player: Player = null


func _ready() -> void:
	_area.body_entered.connect(func (body:Node) -> void:
		if body is Player:
			_player = body
	)
	
	_area.body_exited.connect(func (body:Node) -> void:
		if body is Player:
			_player = null
	)

func _physics_process(delta: float) -> void:
	# If player node is not found, decelerate to stopping.
	if _player == null:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	# If player node is found, accelerate in straight line to player.
	else:
		var direction = global_position.direction_to(_player.global_position)
		var distance = global_position.distance_to(_player.global_position)
		var speed: float = max_speed if distance > 120.0 else max_speed * distance / 120.0
		var desired_velocity: Vector2 = direction * speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	
	move_and_slide()
