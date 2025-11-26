extends CharacterBody2D


var _player: Player = null

@export var max_speed := 500.0
@export var acceleration := 1000.0

@onready var _area: Area2D = $SightLineArea2D


func _ready() -> void:
	_area.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player = body
	)
	_area.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_player = null
	)


func _physics_process(delta: float) -> void:
	if _player:
		var direction := global_position.direction_to(get_global_player_position())
		var distance := global_position.distance_to(get_global_player_position())
		var speed := max_speed if distance > 120.0 else max_speed * distance / 120.0
		var desired_velocity := direction * speed
		
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
		
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()
	
	
func get_global_player_position() -> Vector2:
	return get_tree().root.get_node("Game/Player").global_position


	## Testing for Sight Line using mouse.
	#_area.mouse_entered.connect(func () -> void:
		#print("Sightline Entered")
	#)
	#
	#_area.mouse_exited.connect(func () -> void:
		#print("Sightline Exited")
	#)
