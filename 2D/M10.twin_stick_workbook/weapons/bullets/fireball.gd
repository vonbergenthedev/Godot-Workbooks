class_name Fireball
extends Area2D

@export var speed := 1000.0
@export var damage := 1


var max_range := 800.0
var _current_range := 0.0


func _ready() -> void:
	body_entered.connect(func (body: Node) -> void:
		if body is Mob:
			body.health -= damage
			_destroy()
	)


func _destroy() -> void:
	queue_free()


func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
	_current_range += speed * delta
	
	if _current_range > max_range:
		_destroy()
