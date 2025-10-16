extends Sprite2D

var normal_speed := 600.0
var max_speed := normal_speed
var boost_speed := 1500.0
var velocity := Vector2(0, 0)
var steering_factor := 15.0

func _process(delta: float) -> void:
	# Get player direction from input
	# See Project -> Project Settings... -> Input Map
	# Another option would be .get_vector() but it is normalized by default.
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	# Normalize the direction if the length of the returned vector from player input if needed
	if direction.length() > 1.0:
		direction = direction.normalized()
	
	if Input.is_action_just_pressed("boost"):
		max_speed = boost_speed
		get_node("Timer").start()

	
	# Update player position and rotate sprite to match
	var desired_velocity := max_speed * direction
	var steering_vector := desired_velocity - velocity
	var steering_amount := steering_factor * delta
	
	if steering_amount > 1.0:
		steering_amount = 1.0
	
	velocity += steering_vector * steering_amount
	position +=  velocity * delta
	
	if direction.length() > 0.0:
		rotation = velocity.angle()


func _on_timer_timeout() -> void:
	max_speed = normal_speed
