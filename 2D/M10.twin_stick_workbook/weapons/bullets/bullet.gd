class_name Bullet extends Area2D

## Current speed of bullet
@export var speed := 600.0
## Maximum distance bullet travels before being destroyed
var max_range := 600.0
## Curent distance bullet has travelled
var _current_distance_travelled := 0.0


func _physics_process(delta: float) -> void:
	# Move bullet in direction of sprite rotation each frame
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	# Add to distance travelled by bullet each frame
	_current_distance_travelled += speed * delta
	# If bullet has travelled farther than max range remove it from game by
	# calling destroy function
	if _current_distance_travelled > max_range:
		_destroy()
	
## Function to destroy bullet for bullet type expansion
func _destroy() -> void:
	queue_free()
