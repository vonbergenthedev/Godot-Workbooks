class_name Player extends CharacterBody2D

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

### Alternate using Ground Friction ###
#@export var speed := 460.0
#@export var ground_friction_factor := 10.0

#func _physics_process(delta: float) -> void:
	#var move_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var desired_velocity := speed * move_direction
	#var steering := desired_velocity - velocity
	#velocity += steering * ground_friction_factor * delta
	#move_and_slide()
