class_name Mob extends CharacterBody2D

var _player: Player = null

@export var max_speed := 300.0
@export var max_health := 3
@export var health := max_health: set = set_health
@export var damage := 1

@onready var _detection_area: Area2D = $PlayerDetectionArea2D
@onready var _hitbox: Area2D = $Hitbox
@onready var _damage_timer: Timer = $DamageTimer
@onready var _mob_healthbar: ProgressBar = $MobHealthbar


var acceleration := max_speed * 3
var deceleration := max_speed * 10


func _ready() -> void:
	_mob_healthbar.value = health
	_mob_healthbar.visible = false
	
	_detection_area.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player = body
	)
	
	_detection_area.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_player = null
	)
	
	_hitbox.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player = body
			_player.health -= damage
			_damage_timer.start()
	)

	_hitbox.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_damage_timer.stop()
	)

	_damage_timer.timeout.connect(func () -> void:
		_player.health -= damage
		_damage_timer.start()
	)
	


func set_health(new_health: int) -> void:
	health = new_health
	
	if _mob_healthbar != null:
		
		if health < max_health:
			_mob_healthbar.set_deferred("visible", true)
		
		_mob_healthbar.value = health
	
	if health <= 0:
		die()


func die() -> void:
	queue_free()


func _physics_process(delta: float) -> void:
	if _player != null:
		var direction := global_position.direction_to(_player.position)
		var distance := global_position.distance_to(_player.position)
		var speed := max_speed if distance > 100 else max_speed * distance / 100
		var desired_velocity := direction * speed
		
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		
	move_and_slide()
