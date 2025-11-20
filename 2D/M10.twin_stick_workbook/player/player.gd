extends CharacterBody2D

@export var max_speed = 2000.0

var turning_factor := 20.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_velocity: Vector2 = direction * max_speed
	var steering_factor: Vector2 = desired_velocity - velocity
	
	velocity += steering_factor * turning_factor * delta

	move_and_slide()
