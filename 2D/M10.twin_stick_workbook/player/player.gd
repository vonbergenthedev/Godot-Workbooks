extends CharacterBody2D

@export var max_speed := 2000.0
@export var acceleration := 6000.0
@export var deceleration := 5000.0

var turning_factor := 20.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var has_input := direction.length() > 0.0
	
	if has_input:
		var desired_velocity := direction * max_speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	move_and_slide()
