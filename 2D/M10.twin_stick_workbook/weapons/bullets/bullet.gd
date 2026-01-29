class_name Bullet extends Area2D

## Current speed of bullet
@export var speed := 600.0
## Maximum distance bullet travels before being destroyed
@export var max_range := 600.0

## Curent distance bullet has travelled
var _current_distance_travelled := 0.0

## Default damage done by bullet
var damage := 1


func _ready() -> void:
	body_entered.connect(func (body:Node) -> void:
		if body is Mob:
			var current_health = body.health
			body.health = current_health - damage
			_destroy()
		)
	
func _physics_process(delta: float) -> void:
	# Move bullet in direction of sprite rotation each frame
	var direction := global_transform.x.normalized()
	position += direction * speed * delta
	# Add to distance travelled by bullet each frame
	_current_distance_travelled += speed * delta
	# If bullet has travelled farther than max range remove it from game by
	# calling destroy function
	if _current_distance_travelled > max_range:
		_destroy()
	
## Function to destroy bullet for bullet type expansion
func _destroy() -> void:
	queue_free()
