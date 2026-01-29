class_name Mob extends CharacterBody2D

@onready var _player_detection_area: Area2D = $PlayerDetectionArea2D

## Maximum movement speed for mob.
@export var max_speed := 250.0
## Rate of acceleration for mob movement.
@export var acceleration := 1000.0
## Rate of deceleration for mob movement.
@export var deceleration := 800.0
## Mob default health and setter declaration
@export var health := 0: set = set_health

var _max_health := 3
var _player: Player = null


func _ready() -> void:
	health = _max_health
	
	_player_detection_area.body_entered.connect(func (body:Node) -> void:
		if body is Player:
			_player = body
	)
	
	_player_detection_area.body_exited.connect(func (body:Node) -> void:
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

## Setter function for health; removes mob node at 0 health
func set_health(new_health: int) -> void:
	health = clampi(new_health, 0, _max_health)
	
	if health == 0:
		die()

## Function to remove mob from scene
func die() -> void:
	queue_free()
