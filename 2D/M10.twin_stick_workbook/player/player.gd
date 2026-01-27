class_name Player extends CharacterBody2D

## Maximum movement speed for player.
@export var max_speed := 600.0
## Rate of acceleration for player movement.
@export var acceleration := 3000.0
## Rate of deceleration for player movement.
@export var deceleration := 3000.0


func _physics_process(delta: float) -> void:
	# Detect player input or lack of input
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var has_input_direction := direction.length() > 0.0
	
	# If player presses input keys/sticks,
	# accelerate player movement toward max speed.
	if has_input_direction:
		var desired_velocity := direction * max_speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	# If player releases input keys/sticks,
	# decelerate player movement toward zero.
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	move_and_slide()
