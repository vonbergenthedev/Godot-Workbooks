class_name Player extends CharacterBody2D

var max_speed := 700.0
var acceleration := max_speed * 4
var deceleration := max_speed * 4
var health := 5: set = set_health


@onready var weapon: Node2D = $WeaponPivot/WeaponAnchor/Weapon
@onready var _player_collision_shape_2d: CollisionShape2D = %PlayerCollisionShape2D
@onready var _health_bar: ProgressBar = $HealthBar
@onready var _weapon_pivot: Node2D = $WeaponPivot
@onready var _weapon: Node2D = $WeaponPivot/WeaponAnchor/Weapon
@onready var player_damage: AudioStreamPlayer = $PlayerDamage
@onready var player_death: AudioStreamPlayer = $PlayerDeath


@export_range(0, 10) var max_health := 10


func _ready() -> void:
	set_physics_process(true)
	set_health(5)
	_health_bar.max_value = max_health
	_health_bar.value = health


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var has_direction_input := direction.length() > 0
	
	if has_direction_input:
		var desired_velocity := direction * max_speed
		
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		
	move_and_slide()


func set_health(new_health: int) -> void: 
	if new_health < health and new_health > 0:
		player_damage.play()
	health = clampi(new_health, 0, max_health)
	_health_bar.value = health
	if health == 0:
		die()


func die() -> void:
	set_physics_process(false)
	_player_collision_shape_2d.set_deferred("disabled", true)
	_weapon_pivot.set_process(false)
	_weapon.set_process(false)
	# set_deferred("visible", false)
	player_death.play()
	await get_tree().create_timer(player_death.stream.get_length() + 0.2).timeout
	get_tree().reload_current_scene()
